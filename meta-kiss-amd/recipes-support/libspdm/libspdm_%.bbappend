# Fix a parse error caused by an unrecognized microblazeel architecture
# libspdm_3.8.2.bb: unsupported architecture 'microblazeel'
COMPATIBLE_MACHINE:microblazeel = "^$"
