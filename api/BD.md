erDiagram
    users {
        bigint id PK
        varchar username UK
        varchar email UK
        varchar password "BCrypt hash"
        varchar role "ROLE_ADMIN | ROLE_INQUISITOR | ROLE_SCRIBE"
        boolean enabled "Для UserDetails.isEnabled()"
        boolean account_non_locked "Для UserDetails.isAccountNonLocked()"
        timestamp created_at
    }

    refresh_tokens {
        bigint id PK
        bigint user_id FK
        varchar token UK "JWT Refresh Token или его хэш"
        timestamp expires_at
        boolean revoked
        varchar device_info "User-Agent / IP для управления сессиями"
        timestamp created_at
    }

    inquisitors {
        bigint id PK
        bigint user_id FK "UK, nullable"
        varchar full_name
        varchar rank
        varchar title
    }

    sins {
        bigint id PK
        varchar heresy_type
        varchar severity_level
        text description
    }

    heretics {
        bigint id PK
        varchar first_name
        varchar last_name
        varchar alias
        varchar origin_place
        varchar status
        date registration_date
    }

    interrogation_rooms {
        bigint id PK
        varchar room_number
        int dungeon_level
        int capacity
        varchar status
    }

    inventory_items {
        bigint id PK
        varchar item_name
        varchar category
        varchar condition
        int quantity
    }

    heretic_sins {
        bigint id PK
        bigint heretic_id FK
        bigint sin_id FK
        date date_confessed
        varchar reported_by
    }

    interrogations {
        bigint id PK
        bigint heretic_id FK
        bigint inquisitor_id FK
        bigint room_id FK
        int session_number
        timestamp start_time
        timestamp end_time
        boolean confession_obtained
        varchar verdict
    }

    room_inventory {
        bigint id PK
        bigint room_id FK
        bigint item_id FK
        int quantity_assigned
        date last_inspected
    }

    interrogation_records {
        bigint id PK
        bigint interrogation_id FK
        bigint scribe_user_id FK
        text transcript
    }

    users ||--o{ refresh_tokens : has_sessions
    users ||--o| inquisitors : linked_to
    users ||--o{ interrogation_records : writes

    sins ||--o{ heretic_sins : referenced_in
    heretics ||--o{ heretic_sins : accused_of
    heretics ||--o{ interrogations : subjected_to
    inquisitors ||--o{ interrogations : presides_over
    interrogation_rooms ||--o{ interrogations : hosts
    interrogation_rooms ||--o{ room_inventory : houses
    inventory_items ||--o{ room_inventory : stocked_as
    interrogations ||--o{ interrogation_records : yields