# Shipping-Management-System
A system that allows inventory management, ship management, and port management.

---A. Brief Description of the System---

The Cargo Tracker System (Lodestar Shipping Co.) is a Java desktop application that manages the day-to-day operations of a network of ports. It is built with Java Swing for the user interface and uses a MySQL database (lodestar_shipping) for storage. The system brings port registration, permit approval, partnerships between ports, vessel registration, cargo preparation, dispatching and delivery tracking into one program, so that every transaction is recorded in a single database and every user works from the same data.
The system has two kinds of users. The Administrator oversees the whole network: reviews and approves port operating permits and vessel registrations, adds, suspends and reactivates ports, monitors all cargo in the network, reviews historical archives, views the network policy limits, and can send messages to individual users or broadcast to all active ports. A Port user represents a registered port: manages the port's partnerships, creates inbound and outbound cargo, assigns vessels and dispatches cargo, logs arrivals, maintains the port's fleet registry, views its permit profile and archive, and exchanges messages with the administrator and other active ports.
The program follows a layered design. The Presentation layer contains the Swing screens and dialogs, and the UI package contains the shared styling and window-resizing helpers. The Service layer enforces the business rules and validations. The DAO (Data Access Object) layer runs the SQL statements through JDBC. The Model layer holds the entity classes, and the Util package provides the database connection, the user session and the code generator. The UI package and the Theme class provide shared look-and-feel helpers, and the windows can be resized.
Purpose of the system. The main purpose of the system is to give ports and the network administrator a single, organized platform for managing shipping operations. It aims to replace scattered records with a central database, to make sure that only permitted ports and approved vessels take part in the network, and to make each step of a shipment (prepared, dispatched, received, returned or cancelled) traceable from creation to archive.


---B. Scope and Limitations---

1. Scope
The system can perform the following functions:
•	Login with role-based access (Administrator or Port) and account status checks that block pending, suspended or terminated ports.
•	Self-registration of a port with its permit information and an uploaded permit photo (JPG or PNG, up to 5 MB), saved together with a pending permit application and a login account in one transaction.
•	Administrator review of permit applications and vessel registrations, with approval or rejection and remarks.
•	Port management by the administrator: add a port, search the registered ports, suspend a permit, and validate (reactivate) a suspended permit.
•	Partnership management: a port sends a partnership request, the receiving port reviews the contract and accepts or rejects it, and either port can terminate an active partnership.
•	Cargo operations: create inbound or outbound cargo with a list of products, update cargo status, delete or cancel prepared cargo, inspect the manifest, and filter or search the cargo list.
•	Dispatching: assign an active vessel and schedule to prepared cargo, update the route and estimated arrival of dispatched cargo, and log the arrival at the destination port.
•	Ship registry: a port requests registration of its vessels with a registration document, and the administrator approves or rejects the request.
•	Dashboards for the administrator and for each port, a network-wide dispatch queue, historical archives of received, returned and cancelled cargo, and export of the administrator dashboard summary to a CSV file.
•	Account settings (name, email and password) for each user, and a display of the Global Network System Policy (maximum queue per port, maximum items per cargo and network status); the stored limits are used as the default limits of newly registered ports.
•	Messaging: users read their inbox and sent messages, compose, reply to and delete messages, and the administrator can broadcast one message to all active ports; the dashboards show the unread count.
•	Automatic generation of formatted codes for ports, cargo, permits, partnerships and vessels.

3. Limitations
The following are outside the coverage of the current version of the system:
•	It is a desktop application for a single computer or local network; there is no web or mobile version.
•	It needs a running MySQL server. The connection settings (localhost, port 3306, user root) are written inside the source code and must be edited there to use a different server.
•	Passwords are saved and compared as plain text. A password hashing method (for example BCrypt) is not yet implemented.
•	It does not track vessels in real time. A route consists of the vessel, the departure date and the estimated arrival date only.
•	It does not handle billing, payments, customs documents or email and SMS notifications.
•	Adding a port from Port Management registers the port and its permit application but does not create a login account for it; ports that register themselves receive their account automatically.
•	The Global Network System Policy values are shown in read-only fields; they cannot be changed from the screen in this version.
•	Messages are plain text only (no attachments).
•	The project has no automated test cases.

---C. Benefits and Values---

The system improves the way ports and the network administrator handle shipping work, and it offers the following advantages to its users:
•	Efficiency. Registration, approvals, partnerships, cargo creation and dispatching are done in one program, which removes repeated encoding and manual coordination between ports.
•	Accuracy. The service layer checks the data before saving it. For example, it rejects cargo that is heavier than the vessel's capacity, blocks cargo to ports without an active partnership, and prevents duplicate emails and duplicate IMO numbers. Codes are generated automatically, so identifiers stay consistent and unique.
•	Control and accountability. Only ports with an approved permit can operate, only approved vessels can be dispatched, and each action is limited to the port that is allowed to perform it (for example, only the origin port dispatches and only the destination port receives). Limits on active shipments and products per cargo are enforced for every port.
•	Traceability. Each cargo, permit, partnership and vessel keeps a status and dates, and finished cargo is kept in searchable archives, which makes past transactions easy to find and review.
•	Accessibility and ease of use. The graphical interface uses a sidebar menu, tables with search and filters, dialogs, and clear error messages, so users can operate the system without technical knowledge.
•	Communication. Administrators and ports can send notices, replies and network-wide announcements inside the system, so coordination stays in one place and unread messages are visible on the dashboards.
•	Data security through role separation. Administrator and Port users see different screens, and a port can only see and change its own records.

