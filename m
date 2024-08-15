Return-Path: <linux-kselftest+bounces-15458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CD953CAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEB01F2599C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F061547DC;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/L23Hwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA5153BF6;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757570; cv=none; b=STeg23e8SDUCpSKTAzjbRYFYIFAsmt8Um5hSpPadKPIUWfHv95YiguTPIDdL6JK03phru3VqTIjUeDfNXcpVNbRmvTFLGxXzjWT/fudz3eJAuWKQjiGj3MdDP2GD5o4psBkBbGos5iA+tVVueg+oDkI2/LwYvMrlXaqIy8ViqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757570; c=relaxed/simple;
	bh=CtA36natmjdStKn1+0ICkz1KTX5q2PvTYeLEocDTwho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vcuvxqwzzx8BWvNXMgPIjY8dsUqLpgy6WeKxPOj5LWJvHgQpenLbshvWovl9ogMhblw/UevSGgmEY0SW8rVksviEgEgRpPzN7FdeqTORh2FTLkXdJO0QHtBW77HAKgD5/R/tgKd4q5oBdhBhDv7lowzJ5XYwqRlESqZCng6yM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/L23Hwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1966C4AF11;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757570;
	bh=CtA36natmjdStKn1+0ICkz1KTX5q2PvTYeLEocDTwho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H/L23Hwx+ZchKrEJ6G3ZrJYU3T4Jx0JIDzSXxPdy6r7cABmpuIPaGwmiba3+utQPs
	 bIGKsvx+CwfSIEXwqLDiBrqrM5l13OiIjwW2dJEtceRJN+lasFu9mMD6eXyjr+FJso
	 1DqqAbDHaS5jHv7Va/WaMZ8aODKxL4NG+OdPvkLQkbPoNEILPsy+xR3p5rKPf+EAJr
	 g52AED0uLh/eM98oRNRh7xypq3fzbRi0OwOskzjfxDDg97tB7+fROjq59GizgAv/qQ
	 Q+7s9cCYgXtK5qH8L5+JMSrDdkClUjPYcbbViizuJI24V1VAxVFcz8WJHbiBgDA1/e
	 CI8HYPNmx8X5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE1C531DF;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:33 +0100
Subject: [PATCH net-next v3 8/8] selftests/net: Add trace events matching
 to tcp_ao
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-8-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=54111;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=1rRY9PldtPyuxVxndxQjdg5erfB9hKONypKJwrVRBZA=;
 b=RCIhLafx+VZqlbhWZdmVQozSucJi5OVGaU0vtxYoPMciANeq48766ZM0wphY8XhY2inCtmmQQ
 ofeTaRtL2PuBvTKUYXMDApvr3PrbyvoxJ43m40pLAj/Yp8j58jxVUq/
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Setup trace points, add a new ftrace instance in order to not interfere
with the rest of the system, filtering by net namespace cookies.
Raise a new background thread that parses trace_pipe, matches them with
the list of expected events.

Wiring up trace events to selftests provides another insight if there is
anything unexpected happining in the tcp-ao code (i.e. key rotation when
it's not expected).

Note: in real programs libtraceevent should be used instead of this
manual labor of setting ftrace up and parsing. I'm not using it here
as I don't want to have an .so library dependency that one would have to
bring into VM or DUT (Device Under Test). Please, don't copy it over
into any real world programs, that aren't tests.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |   3 +-
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |   2 +-
 tools/testing/selftests/net/tcp_ao/config          |   1 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |   2 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |   2 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 117 +++++
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  | 549 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 466 +++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |   8 +
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |   2 +-
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |  26 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  16 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |   2 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  15 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  10 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   2 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  28 +-
 19 files changed, 1269 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index bd88b90b902b..5b0205c70c39 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -31,7 +31,8 @@ CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
 # Library
-LIBSRC	:= kconfig.c netlink.c proc.c repair.c setup.c sock.c utils.c
+LIBSRC	:= ftrace.c ftrace-tcp.c kconfig.c netlink.c
+LIBSRC	+= proc.c repair.c setup.c sock.c utils.c
 LIBOBJ	:= $(LIBSRC:%.c=$(LIBDIR)/%.o)
 EXTRA_CLEAN += $(LIBOBJ) $(LIB)
 
diff --git a/tools/testing/selftests/net/tcp_ao/bench-lookups.c b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
index a1e6e007c291..6736484996a3 100644
--- a/tools/testing/selftests/net/tcp_ao/bench-lookups.c
+++ b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
@@ -355,6 +355,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(30, server_fn, client_fn);
+	test_init(31, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/config b/tools/testing/selftests/net/tcp_ao/config
index d3277a9de987..3605e38711cb 100644
--- a/tools/testing/selftests/net/tcp_ao/config
+++ b/tools/testing/selftests/net/tcp_ao/config
@@ -7,4 +7,5 @@ CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_VRF=y
 CONFIG_TCP_AO=y
 CONFIG_TCP_MD5SIG=y
+CONFIG_TRACEPOINTS=y
 CONFIG_VETH=m
diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 166ad4549ef2..d418162d335f 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -215,30 +215,44 @@ static void try_connect(const char *tst_name, unsigned int port,
 
 static void *client_fn(void *arg)
 {
-	union tcp_addr wrong_addr, network_addr;
+	union tcp_addr wrong_addr, network_addr, addr_any = {};
 	unsigned int port = test_server_port;
 
 	if (inet_pton(TEST_FAMILY, TEST_WRONG_IP, &wrong_addr) != 1)
 		test_error("Can't convert ip address %s", TEST_WRONG_IP);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Non-AO server + AO client", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, this_ip_addr, this_ip_dest,
+				-1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server + Non-AO client", port++, NULL,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Wrong password", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Wrong rcv id", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_sk_expect(TCP_AO_SYNACK_NO_KEY, this_ip_dest, addr_any,
+				 port, 0, 100, 100);
 	try_connect("Wrong snd id", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_WRONG_MACLEN, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Different maclen", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Server: Wrong addr", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
@@ -262,6 +276,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(21, server_fn, client_fn);
+	test_init(22, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index 9eecc4a1072e..f1d8d29e393f 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -85,6 +85,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(1, server_fn, client_fn);
+	test_init(2, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index d69bcba3c929..a1614f0d8c44 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -444,6 +444,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(3, server_fn, client_fn);
+	test_init(4, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index 24e62120b792..d4385b52c10b 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -965,7 +965,7 @@ static void end_client(const char *tst_name, int sk, unsigned int nr_keys,
 	synchronize_threads(); /* 5: counters */
 }
 
-static void try_unmatched_keys(int sk, int *rnext_index)
+static void try_unmatched_keys(int sk, int *rnext_index, unsigned int port)
 {
 	struct test_key *key;
 	unsigned int i = 0;
@@ -1013,6 +1013,9 @@ static void try_unmatched_keys(int sk, int *rnext_index)
 		test_error("all keys on server match the client");
 	if (test_set_key(sk, -1, key->server_keyid))
 		test_error("Can't change the current key");
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1,
+			      -1, key->server_keyid, -1);
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("verify failed");
 	*rnext_index = i;
@@ -1054,6 +1057,10 @@ static void check_current_back(const char *tst_name, unsigned int port,
 		return;
 	if (test_set_key(sk, collection.keys[rotate_to_index].client_keyid, -1))
 		test_error("Can't change the current key");
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1,
+			      collection.keys[rotate_to_index].client_keyid,
+			      collection.keys[current_index].client_keyid, -1);
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("verify failed");
 	/* There is a race here: between setting the current_key with
@@ -1085,6 +1092,11 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 	for (i = rnext_index + 1; rotations > 0; i++, rotations--) {
 		if (i >= collection.nr_keys)
 			i = 0;
+		trace_ao_event_expect(TCP_AO_RNEXT_REQUEST,
+				this_ip_addr, this_ip_dest,
+				-1, port, 0, -1, -1, -1, -1, -1,
+				i == 0 ? -1 : collection.keys[i - 1].server_keyid,
+				collection.keys[i].server_keyid, -1);
 		if (test_set_key(sk, -1, collection.keys[i].server_keyid))
 			test_error("Can't change the Rnext key");
 		if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
@@ -1124,7 +1136,7 @@ static void try_client_match(const char *tst_name, unsigned int port,
 				 rnext_index, msg_len, nr_packets);
 	if (sk < 0)
 		return;
-	try_unmatched_keys(sk, &rnext_index);
+	try_unmatched_keys(sk, &rnext_index, port);
 	end_client(tst_name, sk, nr_keys, current_index, rnext_index, NULL);
 }
 
@@ -1181,6 +1193,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(120, server_fn, client_fn);
+	test_init(121, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index 60a63419cabb..9ecacdaf5964 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -144,6 +144,7 @@ enum test_needs_kconfig {
 	KCONFIG_TCP_AO,			/* required */
 	KCONFIG_TCP_MD5,		/* optional, for TCP-MD5 features */
 	KCONFIG_NET_VRF,		/* optional, for L3/VRF testing */
+	KCONFIG_FTRACE,			/* optional, for tracepoints checks */
 	__KCONFIG_LAST__
 };
 extern bool kernel_config_has(enum test_needs_kconfig k);
@@ -183,6 +184,8 @@ static inline void test_init2(unsigned int ntests,
 	__test_init(ntests, family, prefix, taddr1, taddr2, peer1, peer2);
 }
 extern void test_add_destructor(void (*d)(void));
+extern void test_init_ftrace(int nsfd1, int nsfd2);
+extern int test_setup_tracing(void);
 
 /* To adjust optmem socket limit, approximately estimate a number,
  * that is bigger than sizeof(struct tcp_ao_key).
@@ -257,12 +260,17 @@ static inline void test_init(unsigned int ntests,
 }
 extern void synchronize_threads(void);
 extern void switch_ns(int fd);
+extern int switch_save_ns(int fd);
+extern void switch_close_ns(int fd);
 
 extern __thread union tcp_addr this_ip_addr;
 extern __thread union tcp_addr this_ip_dest;
 extern int test_family;
 
 extern void randomize_buffer(void *buf, size_t buflen);
+extern __printf(3, 4) int test_echo(const char *fname, bool append,
+				    const char *fmt, ...);
+
 extern int open_netns(void);
 extern int unshare_open_netns(void);
 extern const char veth_name[];
@@ -643,4 +651,113 @@ static inline int test_add_repaired_key(int sk,
 	return test_verify_socket_key(sk, &tmp);
 }
 
+#define DEFAULT_FTRACE_BUFFER_KB	10000
+#define DEFAULT_TRACER_LINES_ARR	200
+struct test_ftracer;
+extern uint64_t ns_cookie1, ns_cookie2;
+
+enum ftracer_op {
+	FTRACER_LINE_DISCARD = 0,
+	FTRACER_LINE_PRESERVE,
+	FTRACER_EXIT,
+};
+
+extern struct test_ftracer *create_ftracer(const char *name,
+		enum ftracer_op (*process_line)(const char *line),
+		void (*destructor)(struct test_ftracer *tracer),
+		size_t lines_buf_sz, size_t buffer_size_kb);
+extern int setup_trace_event(struct test_ftracer *tracer,
+			     const char *event, const char *filter);
+extern void destroy_ftracer(struct test_ftracer *tracer);
+extern const size_t tracer_get_savedlines_nr(struct test_ftracer *tracer);
+extern const char **tracer_get_savedlines(struct test_ftracer *tracer);
+
+enum trace_events {
+	/* TCP_HASH_EVENT */
+	TCP_HASH_BAD_HEADER = 0,
+	TCP_HASH_MD5_REQUIRED,
+	TCP_HASH_MD5_UNEXPECTED,
+	TCP_HASH_MD5_MISMATCH,
+	TCP_HASH_AO_REQUIRED,
+	/* TCP_AO_EVENT */
+	TCP_AO_HANDSHAKE_FAILURE,
+	TCP_AO_WRONG_MACLEN,
+	TCP_AO_MISMATCH,
+	TCP_AO_KEY_NOT_FOUND,
+	TCP_AO_RNEXT_REQUEST,
+	/* TCP_AO_EVENT_SK */
+	TCP_AO_SYNACK_NO_KEY,
+	/* TCP_AO_EVENT_SNE */
+	TCP_AO_SND_SNE_UPDATE,
+	TCP_AO_RCV_SNE_UPDATE,
+	__MAX_TRACE_EVENTS
+};
+extern int __trace_event_expect(enum trace_events type, int family,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack,
+				int keyid, int rnext, int maclen, int sne);
+
+static inline void trace_hash_event_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, L3index,
+				   fin, syn, rst, psh, ack,
+				   -1, -1, -1, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack,
+				int keyid, int rnext, int maclen)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, L3index,
+				   fin, syn, rst, psh, ack,
+				   keyid, rnext, maclen, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_sk_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port,
+				int keyid, int rnext)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, -1,
+				   -1, -1, -1, -1, -1,
+				   keyid, rnext, -1, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_sne_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int sne)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, -1,
+				   -1, -1, -1, -1, -1,
+				   -1, -1, -1, sne);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+extern int setup_aolib_ftracer(void);
+
 #endif /* _AOLIB_H_ */
diff --git a/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
new file mode 100644
index 000000000000..5a6c021a8877
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
@@ -0,0 +1,549 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <pthread.h>
+#include "aolib.h"
+
+static const char *trace_event_names[__MAX_TRACE_EVENTS] = {
+	/* TCP_HASH_EVENT */
+	"tcp_hash_bad_header",
+	"tcp_hash_md5_required",
+	"tcp_hash_md5_unexpected",
+	"tcp_hash_md5_mismatch",
+	"tcp_hash_ao_required",
+	/* TCP_AO_EVENT */
+	"tcp_ao_handshake_failure",
+	"tcp_ao_wrong_maclen",
+	"tcp_ao_mismatch",
+	"tcp_ao_key_not_found",
+	"tcp_ao_rnext_request",
+	/* TCP_AO_EVENT_SK */
+	"tcp_ao_synack_no_key",
+	/* TCP_AO_EVENT_SNE */
+	"tcp_ao_snd_sne_update",
+	"tcp_ao_rcv_sne_update"
+};
+
+struct expected_trace_point {
+	/* required */
+	enum trace_events type;
+	int family;
+	union tcp_addr src;
+	union tcp_addr dst;
+
+	/* optional */
+	int src_port;
+	int dst_port;
+	int L3index;
+
+	int fin;
+	int syn;
+	int rst;
+	int psh;
+	int ack;
+
+	int keyid;
+	int rnext;
+	int maclen;
+	int sne;
+
+	size_t matched;
+};
+
+static struct expected_trace_point *exp_tps;
+static size_t exp_tps_nr;
+static size_t exp_tps_size;
+static pthread_mutex_t exp_tps_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+int __trace_event_expect(enum trace_events type, int family,
+		union tcp_addr src, union tcp_addr dst,
+		int src_port, int dst_port, int L3index,
+		int fin, int syn, int rst, int psh, int ack,
+		int keyid, int rnext, int maclen, int sne)
+{
+	struct expected_trace_point new_tp = {
+		.type           = type,
+		.family         = family,
+		.src            = src,
+		.dst            = dst,
+		.src_port       = src_port,
+		.dst_port       = dst_port,
+		.L3index        = L3index,
+		.fin            = fin,
+		.syn            = syn,
+		.rst            = rst,
+		.psh            = psh,
+		.ack            = ack,
+		.keyid          = keyid,
+		.rnext          = rnext,
+		.maclen         = maclen,
+		.sne            = sne,
+		.matched        = 0,
+	};
+	int ret = 0;
+
+	if (!kernel_config_has(KCONFIG_FTRACE))
+		return 0;
+
+	pthread_mutex_lock(&exp_tps_mutex);
+	if (exp_tps_nr == exp_tps_size) {
+		struct expected_trace_point *tmp;
+
+		if (exp_tps_size == 0)
+			exp_tps_size = 10;
+		else
+			exp_tps_size = exp_tps_size * 1.6;
+
+		tmp = reallocarray(exp_tps, exp_tps_size, sizeof(exp_tps[0]));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		exp_tps = tmp;
+	}
+	exp_tps[exp_tps_nr] = new_tp;
+	exp_tps_nr++;
+out:
+	pthread_mutex_unlock(&exp_tps_mutex);
+	return ret;
+}
+
+static void free_expected_events(void)
+{
+	/* We're from the process destructor - not taking the mutex */
+	exp_tps_size = 0;
+	exp_tps = NULL;
+	free(exp_tps);
+}
+
+struct trace_point {
+	int family;
+	union tcp_addr src;
+	union tcp_addr dst;
+	unsigned int src_port;
+	unsigned int dst_port;
+	int L3index;
+	unsigned int fin:1,
+		     syn:1,
+		     rst:1,
+		     psh:1,
+		     ack:1;
+
+	unsigned int keyid;
+	unsigned int rnext;
+	unsigned int maclen;
+
+	unsigned int sne;
+};
+
+static bool lookup_expected_event(int event_type, struct trace_point *e)
+{
+	size_t i;
+
+	pthread_mutex_lock(&exp_tps_mutex);
+	for (i = 0; i < exp_tps_nr; i++) {
+		struct expected_trace_point *p = &exp_tps[i];
+		size_t sk_size;
+
+		if (p->type != event_type)
+			continue;
+		if (p->family != e->family)
+			continue;
+		if (p->family == AF_INET)
+			sk_size = sizeof(p->src.a4);
+		else
+			sk_size = sizeof(p->src.a6);
+		if (memcmp(&p->src, &e->src, sk_size))
+			continue;
+		if (memcmp(&p->dst, &e->dst, sk_size))
+			continue;
+		if (p->src_port >= 0 && p->src_port != e->src_port)
+			continue;
+		if (p->dst_port >= 0 && p->dst_port != e->dst_port)
+			continue;
+		if (p->L3index >= 0 && p->L3index != e->L3index)
+			continue;
+
+		if (p->fin >= 0 && p->fin != e->fin)
+			continue;
+		if (p->syn >= 0 && p->syn != e->syn)
+			continue;
+		if (p->rst >= 0 && p->rst != e->rst)
+			continue;
+		if (p->psh >= 0 && p->psh != e->psh)
+			continue;
+		if (p->ack >= 0 && p->ack != e->ack)
+			continue;
+
+		if (p->keyid >= 0 && p->keyid != e->keyid)
+			continue;
+		if (p->rnext >= 0 && p->rnext != e->rnext)
+			continue;
+		if (p->maclen >= 0 && p->maclen != e->maclen)
+			continue;
+		if (p->sne >= 0 && p->sne != e->sne)
+			continue;
+		p->matched++;
+		pthread_mutex_unlock(&exp_tps_mutex);
+		return true;
+	}
+	pthread_mutex_unlock(&exp_tps_mutex);
+	return false;
+}
+
+static int check_event_type(const char *line)
+{
+	size_t i;
+
+	/*
+	 * This should have been a set or hashmap, but it's a selftest,
+	 * so... KISS.
+	 */
+	for (i = 0; i < __MAX_TRACE_EVENTS; i++) {
+		if (!strncmp(trace_event_names[i], line, strlen(trace_event_names[i])))
+			return i;
+	}
+	return -1;
+}
+
+static bool event_has_flags(enum trace_events event)
+{
+	switch (event) {
+	case TCP_HASH_BAD_HEADER:
+	case TCP_HASH_MD5_REQUIRED:
+	case TCP_HASH_MD5_UNEXPECTED:
+	case TCP_HASH_MD5_MISMATCH:
+	case TCP_HASH_AO_REQUIRED:
+	case TCP_AO_HANDSHAKE_FAILURE:
+	case TCP_AO_WRONG_MACLEN:
+	case TCP_AO_MISMATCH:
+	case TCP_AO_KEY_NOT_FOUND:
+	case TCP_AO_RNEXT_REQUEST:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int tracer_ip_split(int family, char *src, char **addr, char **port)
+{
+	char *p;
+
+	if (family == AF_INET) {
+		/* fomat is <addr>:port, i.e.: 10.0.254.1:7015 */
+		*addr = src;
+		p = strchr(src, ':');
+		if (p == NULL) {
+			test_print("Couldn't parse trace event addr:port %s", src);
+			return -EINVAL;
+		}
+		*p++ = '\0';
+		*port = p;
+		return 0;
+	}
+	if (family != AF_INET6)
+		return -EAFNOSUPPORT;
+
+	/* format is [<addr>]:port, i.e.: [2001:db8:254::1]:7013 */
+	*addr = strchr(src, '[');
+	p = strchr(src, ']');
+
+	if (p == NULL || *addr == NULL) {
+		test_print("Couldn't parse trace event [addr]:port %s", src);
+		return -EINVAL;
+	}
+
+	*addr = *addr + 1;      /* '[' */
+	*p++ = '\0';            /* ']' */
+	if (*p != ':') {
+		test_print("Couldn't parse trace event :port %s", p);
+		return -EINVAL;
+	}
+	*p++ = '\0';            /* ':' */
+	*port = p;
+	return 0;
+}
+
+static int tracer_scan_address(int family, char *src,
+		union tcp_addr *dst, unsigned int *port)
+{
+	char *addr, *port_str;
+	int ret;
+
+	ret = tracer_ip_split(family, src, &addr, &port_str);
+	if (ret)
+		return ret;
+
+	if (inet_pton(family, addr, dst) != 1) {
+		test_print("Couldn't parse trace event addr %s", addr);
+		return -EINVAL;
+	}
+	errno = 0;
+	*port = (unsigned int)strtoul(port_str, NULL, 10);
+	if (errno != 0) {
+		test_print("Couldn't parse trace event port %s", port_str);
+		return -errno;
+	}
+	return 0;
+}
+
+static int tracer_scan_event(const char *line, enum trace_events event,
+		struct trace_point *out)
+{
+	char *src = NULL, *dst = NULL, *family = NULL;
+	char fin, syn, rst, psh, ack;
+	int nr_matched, ret = 0;
+	uint64_t netns_cookie;
+
+	switch (event) {
+	case TCP_HASH_BAD_HEADER:
+	case TCP_HASH_MD5_REQUIRED:
+	case TCP_HASH_MD5_UNEXPECTED:
+	case TCP_HASH_MD5_MISMATCH:
+	case TCP_HASH_AO_REQUIRED: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state%*s family=%ms src=%ms dest=%ms L3index=%d [%c%c%c%c%c]",
+				    &netns_cookie, &family,
+				    &src, &dst, &out->L3index,
+				    &fin, &syn, &rst, &psh, &ack);
+		if (nr_matched != 10)
+			test_print("Couldn't parse trace event, matched = %d/10",
+				   nr_matched);
+		break;
+	}
+	case TCP_AO_HANDSHAKE_FAILURE:
+	case TCP_AO_WRONG_MACLEN:
+	case TCP_AO_MISMATCH:
+	case TCP_AO_KEY_NOT_FOUND:
+	case TCP_AO_RNEXT_REQUEST: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state%*s family=%ms src=%ms dest=%ms L3index=%d [%c%c%c%c%c] keyid=%u rnext=%u maclen=%u",
+				    &netns_cookie, &family,
+				    &src, &dst, &out->L3index,
+				    &fin, &syn, &rst, &psh, &ack,
+				    &out->keyid, &out->rnext, &out->maclen);
+		if (nr_matched != 13)
+			test_print("Couldn't parse trace event, matched = %d/13",
+				   nr_matched);
+		break;
+	}
+	case TCP_AO_SYNACK_NO_KEY: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state%*s family=%ms src=%ms dest=%ms keyid=%u rnext=%u",
+				    &netns_cookie, &family,
+				    &src, &dst, &out->keyid, &out->rnext);
+		if (nr_matched != 6)
+			test_print("Couldn't parse trace event, matched = %d/6",
+					nr_matched);
+		break;
+	}
+	case TCP_AO_SND_SNE_UPDATE:
+	case TCP_AO_RCV_SNE_UPDATE: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state%*s family=%ms src=%ms dest=%ms sne=%u",
+				    &netns_cookie, &family,
+				    &src, &dst, &out->sne);
+		if (nr_matched != 5)
+			test_print("Couldn't parse trace event, matched = %d/5",
+					nr_matched);
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	if (family) {
+		if (!strcmp(family, "AF_INET")) {
+			out->family = AF_INET;
+		} else if (!strcmp(family, "AF_INET6")) {
+			out->family = AF_INET6;
+		} else {
+			test_print("Couldn't parse trace event family %s", family);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	if (event_has_flags(event)) {
+		out->fin = (fin == 'F');
+		out->syn = (syn == 'S');
+		out->rst = (rst == 'R');
+		out->psh = (psh == 'P');
+		out->ack = (ack == '.');
+
+		if ((fin != 'F' && fin != ' ') ||
+				(syn != 'S' && syn != ' ') ||
+				(rst != 'R' && rst != ' ') ||
+				(psh != 'P' && psh != ' ') ||
+				(ack != '.' && ack != ' ')) {
+			test_print("Couldn't parse trace event flags %c%c%c%c%c",
+					fin, syn, rst, psh, ack);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	if (src && tracer_scan_address(out->family, src, &out->src, &out->src_port)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (dst && tracer_scan_address(out->family, dst, &out->dst, &out->dst_port)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (netns_cookie != ns_cookie1 && netns_cookie != ns_cookie2) {
+		test_print("Net namespace filter for trace event didn't work: %" PRIu64 " != %" PRIu64 " OR %" PRIu64,
+				netns_cookie, ns_cookie1, ns_cookie2);
+		ret = -EINVAL;
+	}
+
+out_free:
+	free(src);
+	free(dst);
+	free(family);
+	return ret;
+}
+
+static enum ftracer_op aolib_tracer_process_event(const char *line)
+{
+	int event_type = check_event_type(line);
+	struct trace_point tmp = {};
+
+	if (event_type < 0)
+		return FTRACER_LINE_PRESERVE;
+
+	if (tracer_scan_event(line, event_type, &tmp))
+		return FTRACER_LINE_PRESERVE;
+
+	return lookup_expected_event(event_type, &tmp) ?
+		FTRACER_LINE_DISCARD : FTRACER_LINE_PRESERVE;
+}
+
+static void dump_trace_event(struct expected_trace_point *e)
+{
+	char src[INET6_ADDRSTRLEN], dst[INET6_ADDRSTRLEN];
+
+	if (!inet_ntop(e->family, &e->src, src, INET6_ADDRSTRLEN))
+		test_error("inet_ntop()");
+	if (!inet_ntop(e->family, &e->dst, dst, INET6_ADDRSTRLEN))
+		test_error("inet_ntop()");
+	test_print("trace event filter %s [%s:%d => %s:%d, L3index %d, flags: %s%s%s%s%s, keyid: %d, rnext: %d, maclen: %d, sne: %d] = %zu",
+		   trace_event_names[e->type],
+		   src, e->src_port, dst, e->dst_port, e->L3index,
+		   (e->fin > 0) ? "F" : (e->fin == 0) ? "!F" : "",
+		   (e->syn > 0) ? "S" : (e->syn == 0) ? "!S" : "",
+		   (e->rst > 0) ? "R" : (e->rst == 0) ? "!R" : "",
+		   (e->psh > 0) ? "P" : (e->psh == 0) ? "!P" : "",
+		   (e->ack > 0) ? "." : (e->ack == 0) ? "!." : "",
+		   e->keyid, e->rnext, e->maclen, e->sne, e->matched);
+}
+
+static void print_match_stats(bool unexpected_events)
+{
+	size_t matches_per_type[__MAX_TRACE_EVENTS] = {};
+	bool expected_but_none = false;
+	size_t i, total_matched = 0;
+	char *stat_line = NULL;
+
+	for (i = 0; i < exp_tps_nr; i++) {
+		struct expected_trace_point *e = &exp_tps[i];
+
+		total_matched += e->matched;
+		matches_per_type[e->type] += e->matched;
+		if (!e->matched)
+			expected_but_none = true;
+	}
+	for (i = 0; i < __MAX_TRACE_EVENTS; i++) {
+		if (!matches_per_type[i])
+			continue;
+		stat_line = test_sprintf("%s%s[%zu] ", stat_line ?: "",
+					 trace_event_names[i],
+					 matches_per_type[i]);
+		if (!stat_line)
+			test_error("test_sprintf()");
+	}
+
+	if (unexpected_events || expected_but_none) {
+		for (i = 0; i < exp_tps_nr; i++)
+			dump_trace_event(&exp_tps[i]);
+	}
+
+	if (unexpected_events)
+		return;
+
+	if (expected_but_none)
+		test_fail("Some trace events were expected, but didn't occur");
+	else if (total_matched)
+		test_ok("Trace events matched expectations: %zu %s",
+			total_matched, stat_line);
+	else
+		test_ok("No unexpected trace events during the test run");
+}
+
+#define dump_events(fmt, ...)                           \
+	__test_print(__test_msg, fmt, ##__VA_ARGS__)
+static void check_free_events(struct test_ftracer *tracer)
+{
+	const char **lines;
+	size_t nr;
+
+	if (!kernel_config_has(KCONFIG_FTRACE)) {
+		test_skip("kernel config doesn't have ftrace - no checks");
+		return;
+	}
+
+	nr = tracer_get_savedlines_nr(tracer);
+	lines = tracer_get_savedlines(tracer);
+	print_match_stats(!!nr);
+	if (!nr)
+		return;
+
+	errno = 0;
+	test_xfail("Trace events [%zu] were not expected:", nr);
+	while (nr)
+		dump_events("\t%s", lines[--nr]);
+}
+
+static int setup_tcp_trace_events(struct test_ftracer *tracer)
+{
+	char *filter;
+	size_t i;
+	int ret;
+
+	filter = test_sprintf("net_cookie == %zu || net_cookie == %zu",
+			      ns_cookie1, ns_cookie2);
+	if (!filter)
+		return -ENOMEM;
+
+	for (i = 0; i < __MAX_TRACE_EVENTS; i++) {
+		char *event_name = test_sprintf("tcp/%s", trace_event_names[i]);
+
+		if (!event_name) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = setup_trace_event(tracer, event_name, filter);
+		free(event_name);
+		if (ret)
+			break;
+	}
+
+	free(filter);
+	return ret;
+}
+
+void destroy_aolib_ftracer(struct test_ftracer *tracer)
+{
+	check_free_events(tracer);
+	free_expected_events();
+}
+
+int setup_aolib_ftracer(void)
+{
+	struct test_ftracer *f;
+
+	f = create_ftracer("aolib", aolib_tracer_process_event,
+			   destroy_aolib_ftracer,
+			   DEFAULT_FTRACE_BUFFER_KB, DEFAULT_TRACER_LINES_ARR);
+	if (!f)
+		return -1;
+
+	return setup_tcp_trace_events(f);
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/ftrace.c b/tools/testing/selftests/net/tcp_ao/lib/ftrace.c
new file mode 100644
index 000000000000..24853481f47d
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/ftrace.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include "../../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+static char ftrace_path[] = "ksft-ftrace-XXXXXX";
+static bool ftrace_mounted;
+uint64_t ns_cookie1, ns_cookie2;
+
+struct test_ftracer {
+	pthread_t tracer_thread;
+	int	error;
+	char	*instance_path;
+	FILE	*trace_pipe;
+
+	enum ftracer_op (*process_line)(const char *line);
+	void (*destructor)(struct test_ftracer *tracer);
+
+	char	**saved_lines;
+	size_t	saved_lines_size;
+	size_t	next_line_ind;
+
+	struct test_ftracer *next;
+};
+
+static struct test_ftracer *ftracers;
+static pthread_mutex_t ftracers_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static int mount_ftrace(void)
+{
+	if (!mkdtemp(ftrace_path))
+		test_error("Can't create temp dir");
+
+	if (mount("tracefs", ftrace_path, "tracefs", 0, "rw"))
+		return -errno;
+
+	ftrace_mounted = true;
+
+	return 0;
+}
+
+static void unmount_ftrace(void)
+{
+	if (ftrace_mounted && umount(ftrace_path))
+		test_print("Failed on cleanup: can't unmount tracefs: %m");
+
+	if (rmdir(ftrace_path))
+		test_error("Failed on cleanup: can't remove ftrace dir %s",
+			   ftrace_path);
+}
+
+struct opts_list_t {
+	char *opt_name;
+	struct opts_list_t *next;
+};
+
+static int disable_trace_options(const char *ftrace_path)
+{
+	struct opts_list_t *opts_list = NULL;
+	char *fopts, *line = NULL;
+	size_t buf_len = 0;
+	ssize_t line_len;
+	int ret = 0;
+	FILE *opts;
+
+	fopts = test_sprintf("%s/%s", ftrace_path, "trace_options");
+	if (!fopts)
+		return -ENOMEM;
+
+	opts = fopen(fopts, "r+");
+	if (opts == NULL) {
+		ret = -errno;
+		goto out_free;
+	}
+
+	while ((line_len = getline(&line, &buf_len, opts)) != -1) {
+		struct opts_list_t *tmp;
+
+		if (!strncmp(line, "no", 2))
+			continue;
+
+		tmp = malloc(sizeof(*tmp));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto out_free_opts_list;
+		}
+		tmp->next = opts_list;
+		tmp->opt_name = test_sprintf("no%s", line);
+		if (!tmp->opt_name) {
+			ret = -ENOMEM;
+			free(tmp);
+			goto out_free_opts_list;
+		}
+		opts_list = tmp;
+	}
+
+	while (opts_list) {
+		struct opts_list_t *tmp = opts_list;
+
+		fseek(opts, 0, SEEK_SET);
+		fwrite(tmp->opt_name, 1, strlen(tmp->opt_name), opts);
+
+		opts_list = opts_list->next;
+		free(tmp->opt_name);
+		free(tmp);
+	}
+
+out_free_opts_list:
+	while (opts_list) {
+		struct opts_list_t *tmp = opts_list;
+
+		opts_list = opts_list->next;
+		free(tmp->opt_name);
+		free(tmp);
+	}
+	free(line);
+	fclose(opts);
+out_free:
+	free(fopts);
+	return ret;
+}
+
+static int setup_buffer_size(const char *ftrace_path, size_t sz)
+{
+	char *fbuf_size = test_sprintf("%s/buffer_size_kb", ftrace_path);
+	int ret;
+
+	if (!fbuf_size)
+		return -1;
+
+	ret = test_echo(fbuf_size, 0, "%zu", sz);
+	free(fbuf_size);
+	return ret;
+}
+
+static int setup_ftrace_instance(struct test_ftracer *tracer, const char *name)
+{
+	char *tmp;
+
+	tmp = test_sprintf("%s/instances/ksft-%s-XXXXXX", ftrace_path, name);
+	if (!tmp)
+		return -ENOMEM;
+
+	tracer->instance_path = mkdtemp(tmp);
+	if (!tracer->instance_path) {
+		free(tmp);
+		return -errno;
+	}
+
+	return 0;
+}
+
+static void remove_ftrace_instance(struct test_ftracer *tracer)
+{
+	if (rmdir(tracer->instance_path))
+		test_print("Failed on cleanup: can't remove ftrace instance %s",
+			   tracer->instance_path);
+	free(tracer->instance_path);
+}
+
+static void tracer_cleanup(void *arg)
+{
+	struct test_ftracer *tracer = arg;
+
+	fclose(tracer->trace_pipe);
+}
+
+static void tracer_set_error(struct test_ftracer *tracer, int error)
+{
+	if (!tracer->error)
+		tracer->error = error;
+}
+
+const size_t tracer_get_savedlines_nr(struct test_ftracer *tracer)
+{
+	return tracer->next_line_ind;
+}
+
+const char **tracer_get_savedlines(struct test_ftracer *tracer)
+{
+	return (const char **)tracer->saved_lines;
+}
+
+static void *tracer_thread_func(void *arg)
+{
+	struct test_ftracer *tracer = arg;
+
+	pthread_cleanup_push(tracer_cleanup, arg);
+
+	while (tracer->next_line_ind < tracer->saved_lines_size) {
+		char **lp = &tracer->saved_lines[tracer->next_line_ind];
+		enum ftracer_op op;
+		size_t buf_len = 0;
+		ssize_t line_len;
+
+		line_len = getline(lp, &buf_len, tracer->trace_pipe);
+		if (line_len == -1)
+			break;
+
+		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
+		op = tracer->process_line(*lp);
+		pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+
+		if (op == FTRACER_LINE_DISCARD)
+			continue;
+		if (op == FTRACER_EXIT)
+			break;
+		if (op != FTRACER_LINE_PRESERVE)
+			test_error("unexpected tracer command %d", op);
+
+		tracer->next_line_ind++;
+		buf_len = 0;
+	}
+
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+static int setup_trace_thread(struct test_ftracer *tracer)
+{
+	int ret = 0;
+	char *path;
+
+	path = test_sprintf("%s/trace_pipe", tracer->instance_path);
+	if (!path)
+		return -ENOMEM;
+
+	tracer->trace_pipe = fopen(path, "r");
+	if (!tracer->trace_pipe) {
+		ret = -errno;
+		goto out_free;
+	}
+
+	if (pthread_create(&tracer->tracer_thread, NULL,
+			   tracer_thread_func, (void *)tracer)) {
+		ret = -errno;
+		fclose(tracer->trace_pipe);
+	}
+
+out_free:
+	free(path);
+	return ret;
+}
+
+static void stop_trace_thread(struct test_ftracer *tracer)
+{
+	void *res;
+
+	if (pthread_cancel(tracer->tracer_thread)) {
+		test_print("Can't stop tracer pthread: %m");
+		tracer_set_error(tracer, -errno);
+	}
+	if (pthread_join(tracer->tracer_thread, &res)) {
+		test_print("Can't join tracer pthread: %m");
+		tracer_set_error(tracer, -errno);
+	}
+	if (res != PTHREAD_CANCELED) {
+		test_print("Tracer thread wasn't canceled");
+		tracer_set_error(tracer, -errno);
+	}
+	if (tracer->error)
+		test_fail("tracer errored by %s", strerror(tracer->error));
+}
+
+int setup_trace_event(struct test_ftracer *tracer,
+		      const char *event, const char *filter)
+{
+	char *enable_path, *filter_path, *instance = tracer->instance_path;
+	int ret;
+
+	enable_path = test_sprintf("%s/events/%s/enable", instance, event);
+	if (!enable_path)
+		return -ENOMEM;
+
+	filter_path = test_sprintf("%s/events/%s/filter", instance, event);
+	if (!filter_path) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = test_echo(filter_path, 0, "%s", filter);
+	if (!ret)
+		ret = test_echo(enable_path, 0, "1");
+
+out_free:
+	free(filter_path);
+	free(enable_path);
+	return ret;
+}
+
+
+
+struct test_ftracer *create_ftracer(const char *name,
+				    enum ftracer_op (*process_line)(const char *line),
+				    void (*destructor)(struct test_ftracer *tracer),
+				    size_t lines_buf_sz, size_t buffer_size_kb)
+{
+	struct test_ftracer *tracer;
+
+	/* XXX: separate __create_ftracer() helper and do here
+	 * if (!kernel_config_has(KCONFIG_FTRACE))
+	 *	return NULL;
+	 */
+
+	tracer = malloc(sizeof(*tracer));
+	if (!tracer)
+		return NULL;
+
+	memset(tracer, 0, sizeof(*tracer));
+
+	if (setup_ftrace_instance(tracer, name))
+		goto err_free;
+
+	if (disable_trace_options(tracer->instance_path))
+		goto err_remove;
+
+	if (setup_buffer_size(tracer->instance_path, buffer_size_kb))
+		goto err_remove;
+
+	tracer->saved_lines = calloc(lines_buf_sz, sizeof(tracer->saved_lines[0]));
+	if (!tracer->saved_lines)
+		goto err_remove;
+	tracer->saved_lines_size = lines_buf_sz;
+
+	if (setup_trace_thread(tracer))
+		goto err_free_lines;
+
+	tracer->process_line	= process_line;
+	tracer->destructor	= destructor;
+
+	pthread_mutex_lock(&ftracers_lock);
+	tracer->next = ftracers;
+	ftracers = tracer;
+	pthread_mutex_unlock(&ftracers_lock);
+
+	return tracer;
+
+err_free_lines:
+	free(tracer->saved_lines);
+err_remove:
+	remove_ftrace_instance(tracer);
+err_free:
+	free(tracer);
+	return NULL;
+}
+
+static void __destroy_ftracer(struct test_ftracer *tracer)
+{
+	size_t i;
+
+	stop_trace_thread(tracer);
+	remove_ftrace_instance(tracer);
+	if (tracer->destructor)
+		tracer->destructor(tracer);
+	for (i = 0; i < tracer->saved_lines_size; i++)
+		free(tracer->saved_lines[i]);
+	free(tracer);
+}
+
+void destroy_ftracer(struct test_ftracer *tracer)
+{
+	pthread_mutex_lock(&ftracers_lock);
+	if (tracer == ftracers) {
+		ftracers = tracer->next;
+	} else {
+		struct test_ftracer *f = ftracers;
+
+		while (f->next != tracer) {
+			if (!f->next)
+				test_error("tracers list corruption or double free %p", tracer);
+			f = f->next;
+		}
+		f->next = tracer->next;
+	}
+	tracer->next = NULL;
+	pthread_mutex_unlock(&ftracers_lock);
+	__destroy_ftracer(tracer);
+}
+
+static void destroy_all_ftracers(void)
+{
+	struct test_ftracer *f;
+
+	pthread_mutex_lock(&ftracers_lock);
+	f = ftracers;
+	ftracers = NULL;
+	pthread_mutex_unlock(&ftracers_lock);
+
+	while (f) {
+		struct test_ftracer *n = f->next;
+
+		f->next = NULL;
+		__destroy_ftracer(f);
+		f = n;
+	}
+}
+
+static void test_unset_tracing(void)
+{
+	destroy_all_ftracers();
+	unmount_ftrace();
+}
+
+int test_setup_tracing(void)
+{
+	/*
+	 * Just a basic protection - this should be called only once from
+	 * lib/kconfig. Not thread safe, which is fine as it's early, before
+	 * threads are created.
+	 */
+	static int already_set;
+	int err;
+
+	/* Needs net-namespace cookies for filters */
+	if (ns_cookie1 == ns_cookie2)
+		return -1;
+
+	if (already_set)
+		return -1;
+	already_set = 1;
+
+	test_add_destructor(test_unset_tracing);
+
+	err = mount_ftrace();
+	if (err)
+		return err;
+
+	return setup_aolib_ftracer();
+}
+
+static int get_ns_cookie(int nsfd, uint64_t *out)
+{
+	int old_ns = switch_save_ns(nsfd);
+	socklen_t size = sizeof(*out);
+	int sk;
+
+	sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0) {
+		test_print("socket(): %m");
+		return -errno;
+	}
+
+	if (getsockopt(sk, SOL_SOCKET, SO_NETNS_COOKIE, out, &size)) {
+		test_print("getsockopt(SO_NETNS_COOKIE): %m");
+		close(sk);
+		return -errno;
+	}
+
+	close(sk);
+	switch_close_ns(old_ns);
+	return 0;
+}
+
+void test_init_ftrace(int nsfd1, int nsfd2)
+{
+	get_ns_cookie(nsfd1, &ns_cookie1);
+	get_ns_cookie(nsfd2, &ns_cookie2);
+	/* Populate kernel config state */
+	kernel_config_has(KCONFIG_FTRACE);
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
index 3bf4a7e4b3c9..9f1c175846f8 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
@@ -116,6 +116,12 @@ static int has_vrfs(int *err)
 	return ret;
 }
 
+static int has_ftrace(int *err)
+{
+	*err = test_setup_tracing();
+	return 0;
+}
+
 #define KCONFIG_UNKNOWN			1
 static pthread_mutex_t kconfig_lock = PTHREAD_MUTEX_INITIALIZER;
 static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
@@ -124,6 +130,7 @@ static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
 	{ KCONFIG_UNKNOWN, has_tcp_ao },
 	{ KCONFIG_UNKNOWN, has_tcp_md5 },
 	{ KCONFIG_UNKNOWN, has_vrfs },
+	{ KCONFIG_UNKNOWN, has_ftrace },
 };
 
 const char *tests_skip_reason[__KCONFIG_LAST__] = {
@@ -132,6 +139,7 @@ const char *tests_skip_reason[__KCONFIG_LAST__] = {
 	"Tests require TCP-AO support (CONFIG_TCP_AO)",
 	"setsockopt(TCP_MD5SIG_EXT) is not supported (CONFIG_TCP_MD5)",
 	"VRFs are not supported (CONFIG_NET_VRF)",
+	"Ftrace points are not supported (CONFIG_TRACEPOINTS)",
 };
 
 bool kernel_config_has(enum test_needs_kconfig k)
diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 86a4f6e20450..a27cc03c9fbd 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -250,9 +250,9 @@ void __test_init(unsigned int ntests, int family, unsigned int prefix,
 	test_print("rand seed %u", (unsigned int)seed);
 	srand(seed);
 
-
 	ksft_print_header();
 	init_namespaces();
+	test_init_ftrace(nsfd_parent, nsfd_child);
 
 	if (add_veth(veth_name, nsfd_parent, nsfd_child))
 		test_error("Failed to add veth");
diff --git a/tools/testing/selftests/net/tcp_ao/lib/utils.c b/tools/testing/selftests/net/tcp_ao/lib/utils.c
index 372daca525f5..bdf5522c9213 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/utils.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/utils.c
@@ -21,6 +21,32 @@ void randomize_buffer(void *buf, size_t buflen)
 	}
 }
 
+__printf(3, 4) int test_echo(const char *fname, bool append,
+			     const char *fmt, ...)
+{
+	size_t len, written;
+	va_list vargs;
+	char *msg;
+	FILE *f;
+
+	f = fopen(fname, append ? "a" : "w");
+	if (!f)
+		return -errno;
+
+	va_start(vargs, fmt);
+	msg = test_snprintf(fmt, vargs);
+	va_end(vargs);
+	if (!msg) {
+		fclose(f);
+		return -1;
+	}
+	len = strlen(msg);
+	written = fwrite(msg, 1, len, f);
+	fclose(f);
+	free(msg);
+	return written == len ? 0 : -1;
+}
+
 const struct sockaddr_in6 addr_any6 = {
 	.sin6_family	= AF_INET6,
 };
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index f6ea2190f43d..ecc6f1e3a414 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -208,22 +208,36 @@ static void *client_fn(void *arg)
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.snt_isn += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong send ISN", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.rcv_isn += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong receive ISN", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.snd_sne += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	/* not expecting server => client mismatches as only snd sne is broken */
 	test_sk_restore("TCP-AO with wrong send SEQ ext number", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_BAD | TEST_CNT_GOOD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.rcv_sne += 1;
+	/* not expecting client => server mismatches as only rcv sne is broken */
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong receive SEQ ext number", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_GOOD | TEST_CNT_BAD);
@@ -233,6 +247,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(20, server_fn, client_fn);
+	test_init(21, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index a2fe88d35ac0..6364facaa63e 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -455,6 +455,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(14, server_fn, client_fn);
+	test_init(15, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index e56931d38e06..3ecd2b58de6a 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -163,17 +163,26 @@ static void *client_fn(void *arg)
 	setup_lo_intf("lo");
 
 	tcp_self_connect("self-connect(same keyids)", port++, false, false);
+
+	/* expecting rnext to change based on the first segment RNext != Current */
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
 	tcp_self_connect("self-connect(different keyids)", port++, true, false);
 	tcp_self_connect("self-connect(restore)", port, false, true);
-	port += 2;
+	port += 2; /* restore test restores over different port */
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
+	/* intentionally on restore they are added to the socket in different order */
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port + 1, port + 1, 0, -1, -1, -1, -1, -1, 5, 7, -1);
 	tcp_self_connect("self-connect(restore, different keyids)", port, true, true);
-	port += 2;
+	port += 2; /* restore test restores over different port */
 
 	return NULL;
 }
 
 int main(int argc, char *argv[])
 {
-	test_init(4, client_fn, NULL);
+	test_init(5, client_fn, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index 885866cc193c..8901a6785dc8 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -116,6 +116,14 @@ static void *server_fn(void *arg)
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
 			     client_new_port, &ao1);
 
+	trace_ao_event_sne_expect(TCP_AO_SND_SNE_UPDATE, this_ip_addr,
+			this_ip_dest, test_server_port + 1, client_new_port, 1);
+	trace_ao_event_sne_expect(TCP_AO_SND_SNE_UPDATE, this_ip_dest,
+			this_ip_addr, client_new_port, test_server_port + 1, 1);
+	trace_ao_event_sne_expect(TCP_AO_RCV_SNE_UPDATE, this_ip_addr,
+			this_ip_dest, test_server_port + 1, client_new_port, 1);
+	trace_ao_event_sne_expect(TCP_AO_RCV_SNE_UPDATE, this_ip_dest,
+			this_ip_addr, client_new_port, test_server_port + 1, 1);
 	synchronize_threads(); /* 5: verify the connection during SEQ-number rollover */
 	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
 	if (bytes != quota) {
@@ -242,6 +250,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(7, server_fn, client_fn);
+	test_init(8, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 5eee826c37aa..084db4ecdff6 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -830,6 +830,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(120, client_fn, NULL);
+	test_init(121, client_fn, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 02346b58efbd..f779e5892bc1 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -674,24 +674,38 @@ static void *client_fn(void *arg)
 
 	try_connect("AO server (INADDR_ANY): AO client", port++, NULL, 0,
 		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (INADDR_ANY): unsigned client", port++, NULL, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
 	try_connect("AO server (AO_REQUIRED): AO client", port++, NULL, 0,
 		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &client2);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("MD5 server (INADDR_ANY): AO client", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 	try_connect("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("MD5 server (INADDR_ANY): no sign client", port++, NULL, 0,
 		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("no sign server: AO client", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("no sign server: MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 	try_connect("no sign server: no sign client", port++, NULL, 0,
@@ -699,25 +713,37 @@ static void *client_fn(void *arg)
 
 	try_connect("AO+MD5 server: AO client (matching)", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, 0, 1, &client2);
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("AO+MD5 server: AO client (misconfig, matching MD5)",
 		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
 		   FAULT_TIMEOUT, 1, &this_ip_addr);
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, client3, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("AO+MD5 server: AO client (misconfig, non-matching)",
 		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
 		   FAULT_TIMEOUT, 1, &client3);
 	try_connect("AO+MD5 server: MD5 client (matching)", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: MD5 client (misconfig, matching AO)",
 		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client2);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, client3,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: MD5 client (misconfig, non-matching)",
 		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client3);
 	try_connect("AO+MD5 server: no sign client (unmatched)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, 0, 1, &client3);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: no sign client (misconfig, matching AO)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client2);
+	trace_hash_event_expect(TCP_HASH_MD5_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: no sign client (misconfig, matching MD5)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &this_ip_addr);
@@ -739,6 +765,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(72, server_fn, client_fn);
+	test_init(73, server_fn, client_fn);
 	return 0;
 }

-- 
2.42.2



