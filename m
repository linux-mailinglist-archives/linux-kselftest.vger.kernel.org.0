Return-Path: <linux-kselftest+bounces-1981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2502C813FE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8FB1C221E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B7EBC;
	Fri, 15 Dec 2023 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Sy0H7mUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E319E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso2342675e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607843; x=1703212643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8KUwkZxtEdVR6sc/YT8e30czG+JjN7FEsJA3b6MvTw=;
        b=Sy0H7mUy96wUtRjthCijb77qhdZX9r+eloGzjMOao6jRAnwhkLC914MpMAfFdAin8o
         SYg8Owku2qeHCBdRarOSL4SwEJdQfnLzXT54RmXfW+rgcfTjvT2s00xPn6RmqfGNoW4T
         y82QxBSrV+aJzKk77gcrgMRcqpGvWEJQkmAwAO5gD118HMDqldfoCAA6IcxTtboIfT4w
         tPz0DXyHkQHpSJZotLGclTy63sqhG791QTJBUIM8XGQN8DGzWiJ+WLhdsjSxZL9qqOji
         Lw6e55TBSu3YpLmhbio6vHz7eErIztJTuxZoK8M7JbDk6FO83vzJVzMaD6zxgYrkArZE
         ZMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607843; x=1703212643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8KUwkZxtEdVR6sc/YT8e30czG+JjN7FEsJA3b6MvTw=;
        b=KIJITDE8FFJEZtv7lq82KkHAy3lJjKFtkucfA0pSjPa7ZkSjatXg7wyrwhOW/gCPWF
         yda9iU767k8cou4itnVWd2uGneeCvt+Q8OrTmxB0oqYr/9IZakc4MGwR5Xv0LNIT6RCo
         AZNyvvbpTZobzf9WpUgtc3ATyL4Lk7v2I7zrQdIl0KrehlnA4qB8eap70g3efeUcdkk/
         KIgwHzbKGQ5zQ0Lpift+UplbafY/wQ1hHDDNOqe3gZMIGCjaeFlegECgJRcCvbcHhOD4
         GUqFQbRb5ZjVK1PwXfhEXDOU6b0IH/1EU3UJFHSDXSPgO0Dcv0i3wPEVeebxkUxOm6Fg
         /X0A==
X-Gm-Message-State: AOJu0Yx5lc3SHZoztXS9P/rHphdtdALwU+rkqWVHSCKKDqYEunKh4WoP
	KbhWTN39BraI007y2VzOsExOUQ==
X-Google-Smtp-Source: AGHT+IG5xmAOVCSwyCOBbFNzRMjXe7vY6REQ1Ia0l0e4mysbJLIUQI7axsRxOD3CJrK6P/j+Mg1O2A==
X-Received: by 2002:a05:600c:1913:b0:40b:5e21:c5b2 with SMTP id j19-20020a05600c191300b0040b5e21c5b2mr3747230wmq.128.1702607842733;
        Thu, 14 Dec 2023 18:37:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:21 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 01/12] selftests/net: Add TCP-AO library
Date: Fri, 15 Dec 2023 02:36:15 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-1-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=81513; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=oxdMyAkztR2J4idxWILnl8hY3MEV7VECh35tYsYP1Kw=; b=YUjI6XnE39fRZ0CFaJrYUvmw41zdtfrZJ9E+WX1S6tBXaSIsVBXWcEOm42Jg1cMylVEWjCd3U mcd/yf84s3XB79sMLs7rV+k2KTvoKPTM1cZwrELmIE6KLyUTg46vQdK
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Provide functions to create selftests dedicated to TCP-AO.
They can run in parallel, as they use temporary net namespaces.
They can be very specific to the feature being tested.
This will allow to create a lot of TCP-AO tests, without complicating
one binary with many --options and to create scenarios, that are
hard to put in bash script that uses one binary.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/net/tcp_ao/.gitignore    |   2 +
 tools/testing/selftests/net/tcp_ao/Makefile      |  45 ++
 tools/testing/selftests/net/tcp_ao/connect.c     |  90 ++++
 tools/testing/selftests/net/tcp_ao/lib/aolib.h   | 605 +++++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c | 148 ++++++
 tools/testing/selftests/net/tcp_ao/lib/netlink.c | 415 ++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/proc.c    | 273 ++++++++++
 tools/testing/selftests/net/tcp_ao/lib/repair.c  | 254 ++++++++++
 tools/testing/selftests/net/tcp_ao/lib/setup.c   | 342 +++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/sock.c    | 592 ++++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/utils.c   |  30 ++
 12 files changed, 2797 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..f0c854d6511c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -58,6 +58,7 @@ TARGETS += net/forwarding
 TARGETS += net/hsr
 TARGETS += net/mptcp
 TARGETS += net/openvswitch
+TARGETS += net/tcp_ao
 TARGETS += netfilter
 TARGETS += nsfs
 TARGETS += perf_events
diff --git a/tools/testing/selftests/net/tcp_ao/.gitignore b/tools/testing/selftests/net/tcp_ao/.gitignore
new file mode 100644
index 000000000000..e8bb81b715b7
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/.gitignore
@@ -0,0 +1,2 @@
+*_ipv4
+*_ipv6
diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
new file mode 100644
index 000000000000..62425b9fb73c
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_BOTH_AF := connect
+
+TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
+TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
+
+TEST_GEN_PROGS := $(TEST_IPV4_PROGS) $(TEST_IPV6_PROGS)
+
+top_srcdir	  := ../../../../..
+KSFT_KHDR_INSTALL := 1
+include ../../lib.mk
+
+HOSTAR ?= ar
+
+# Drop it on port to linux/master with commit 8ce72dc32578
+.DEFAULT_GOAL := all
+
+LIBDIR	:= $(OUTPUT)/lib
+LIB	:= $(LIBDIR)/libaotst.a
+LDLIBS	+= $(LIB) -pthread
+LIBDEPS	:= lib/aolib.h Makefile
+
+CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	+= -I ../../../../../usr/include/ -iquote $(LIBDIR)
+CFLAGS	+= -I ../../../../include/
+
+# Library
+LIBSRC	:= kconfig.c netlink.c proc.c repair.c setup.c sock.c utils.c
+LIBOBJ	:= $(LIBSRC:%.c=$(LIBDIR)/%.o)
+EXTRA_CLEAN += $(LIBOBJ) $(LIB)
+
+$(LIB): $(LIBOBJ)
+	$(HOSTAR) rcs $@ $^
+
+$(LIBDIR)/%.o: ./lib/%.c $(LIBDEPS)
+	$(CC) $< $(CFLAGS) $(CPPFLAGS) -o $@ -c
+
+$(TEST_GEN_PROGS): $(LIB)
+
+$(OUTPUT)/%_ipv4: %.c
+	$(LINK.c) $^ $(LDLIBS) -o $@
+
+$(OUTPUT)/%_ipv6: %.c
+	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@
+
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
new file mode 100644
index 000000000000..81653b47f303
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "aolib.h"
+
+static void *server_fn(void *arg)
+{
+	int sk, lsk;
+	ssize_t bytes;
+
+	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
+
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	synchronize_threads();
+
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	synchronize_threads();
+
+	bytes = test_server_run(sk, 0, 0);
+
+	test_fail("server served: %zd", bytes);
+	return NULL;
+}
+
+static void *client_fn(void *arg)
+{
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	uint64_t before_aogood, after_aogood;
+	const size_t nr_packets = 20;
+	struct netstat *ns_before, *ns_after;
+	struct tcp_ao_counters ao1, ao2;
+
+	if (sk < 0)
+		test_error("socket()");
+
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads();
+	if (test_connect_socket(sk, this_ip_dest, test_server_port) <= 0)
+		test_error("failed to connect()");
+	synchronize_threads();
+
+	ns_before = netstat_read();
+	before_aogood = netstat_get(ns_before, "TCPAOGood", NULL);
+	if (test_get_tcp_ao_counters(sk, &ao1))
+		test_error("test_get_tcp_ao_counters()");
+
+	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+		test_fail("verify failed");
+		return NULL;
+	}
+
+	ns_after = netstat_read();
+	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+	netstat_print_diff(ns_before, ns_after);
+	netstat_free(ns_before);
+	netstat_free(ns_after);
+
+	if (nr_packets > (after_aogood - before_aogood)) {
+		test_fail("TCPAOGood counter mismatch: %zu > (%zu - %zu)",
+				nr_packets, after_aogood, before_aogood);
+		return NULL;
+	}
+	if (test_tcp_ao_counters_cmp("connect", &ao1, &ao2, TEST_CNT_GOOD))
+		return NULL;
+
+	test_ok("connect TCPAOGood %" PRIu64 "/%" PRIu64 "/%" PRIu64 " => %" PRIu64 "/%" PRIu64 "/%" PRIu64 ", sent %" PRIu64,
+			before_aogood, ao1.ao_info_pkt_good,
+			ao1.key_cnts[0].pkt_good,
+			after_aogood, ao2.ao_info_pkt_good,
+			ao2.key_cnts[0].pkt_good,
+			nr_packets);
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(1, server_fn, client_fn);
+	return 0;
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
new file mode 100644
index 000000000000..fbc7f6111815
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -0,0 +1,605 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TCP-AO selftest library. Provides helpers to unshare network
+ * namespaces, create veth, assign ip addresses, set routes,
+ * manipulate socket options, read network counter and etc.
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+#ifndef _AOLIB_H_
+#define _AOLIB_H_
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <linux/snmp.h>
+#include <linux/tcp.h>
+#include <netinet/in.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../../../../../include/linux/stringify.h"
+#include "../../../../../include/linux/bits.h"
+
+#ifndef SOL_TCP
+/* can't include <netinet/tcp.h> as including <linux/tcp.h> */
+# define SOL_TCP		6	/* TCP level */
+#endif
+
+/* Working around ksft, see the comment in lib/setup.c */
+extern void __test_msg(const char *buf);
+extern void __test_ok(const char *buf);
+extern void __test_fail(const char *buf);
+extern void __test_xfail(const char *buf);
+extern void __test_error(const char *buf);
+extern void __test_skip(const char *buf);
+
+__attribute__((__format__(__printf__, 2, 3)))
+static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
+{
+#define TEST_MSG_BUFFER_SIZE 4096
+	char buf[TEST_MSG_BUFFER_SIZE];
+	va_list arg;
+
+	va_start(arg, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, arg);
+	va_end(arg);
+	fn(buf);
+}
+
+#define test_print(fmt, ...)						\
+	__test_print(__test_msg, "%ld[%s:%u] " fmt "\n",		\
+		     syscall(SYS_gettid),				\
+		     __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define test_ok(fmt, ...)						\
+	__test_print(__test_ok, fmt "\n", ##__VA_ARGS__)
+#define test_skip(fmt, ...)						\
+	__test_print(__test_skip, fmt "\n", ##__VA_ARGS__)
+#define test_xfail(fmt, ...)						\
+	__test_print(__test_xfail, fmt "\n", ##__VA_ARGS__)
+
+#define test_fail(fmt, ...)						\
+do {									\
+	if (errno)							\
+		__test_print(__test_fail, fmt ": %m\n", ##__VA_ARGS__);	\
+	else								\
+		__test_print(__test_fail, fmt "\n", ##__VA_ARGS__);	\
+	test_failed();							\
+} while (0)
+
+#define KSFT_FAIL  1
+#define test_error(fmt, ...)						\
+do {									\
+	if (errno)							\
+		__test_print(__test_error, "%ld[%s:%u] " fmt ": %m\n",	\
+			     syscall(SYS_gettid), __FILE__, __LINE__,	\
+			     ##__VA_ARGS__);				\
+	else								\
+		__test_print(__test_error, "%ld[%s:%u] " fmt "\n",	\
+			     syscall(SYS_gettid), __FILE__, __LINE__,	\
+			     ##__VA_ARGS__);				\
+	exit(KSFT_FAIL);						\
+} while (0)
+
+enum test_fault {
+	FAULT_TIMEOUT = 1,
+	FAULT_KEYREJECT,
+	FAULT_PREINSTALL_AO,
+	FAULT_PREINSTALL_MD5,
+	FAULT_POSTINSTALL,
+	FAULT_BUSY,
+	FAULT_CURRNEXT,
+	FAULT_FIXME,
+};
+typedef enum test_fault fault_t;
+
+enum test_needs_kconfig {
+	KCONFIG_NET_NS = 0,		/* required */
+	KCONFIG_VETH,			/* required */
+	KCONFIG_TCP_AO,			/* required */
+	KCONFIG_TCP_MD5,		/* optional, for TCP-MD5 features */
+	KCONFIG_NET_VRF,		/* optional, for L3/VRF testing */
+	__KCONFIG_LAST__
+};
+extern bool kernel_config_has(enum test_needs_kconfig k);
+extern const char *tests_skip_reason[__KCONFIG_LAST__];
+static inline bool should_skip_test(const char *tst_name,
+				    enum test_needs_kconfig k)
+{
+	if (kernel_config_has(k))
+		return false;
+	test_skip("%s: %s", tst_name, tests_skip_reason[k]);
+	return true;
+}
+
+union tcp_addr {
+	struct in_addr a4;
+	struct in6_addr a6;
+};
+
+typedef void *(*thread_fn)(void *);
+extern void test_failed(void);
+extern void __test_init(unsigned int ntests, int family, unsigned int prefix,
+			union tcp_addr addr1, union tcp_addr addr2,
+			thread_fn peer1, thread_fn peer2);
+
+static inline void test_init2(unsigned int ntests,
+			      thread_fn peer1, thread_fn peer2,
+			      int family, unsigned int prefix,
+			      const char *addr1, const char *addr2)
+{
+	union tcp_addr taddr1, taddr2;
+
+	if (inet_pton(family, addr1, &taddr1) != 1)
+		test_error("Can't convert ip address %s", addr1);
+	if (inet_pton(family, addr2, &taddr2) != 1)
+		test_error("Can't convert ip address %s", addr2);
+
+	__test_init(ntests, family, prefix, taddr1, taddr2, peer1, peer2);
+}
+extern void test_add_destructor(void (*d)(void));
+
+/* To adjust optmem socket limit, approximately estimate a number,
+ * that is bigger than sizeof(struct tcp_ao_key).
+ */
+#define KERNEL_TCP_AO_KEY_SZ_ROUND_UP	300
+
+extern void test_set_optmem(size_t value);
+extern size_t test_get_optmem(void);
+
+extern const struct sockaddr_in6 addr_any6;
+extern const struct sockaddr_in addr_any4;
+
+#ifdef IPV6_TEST
+# define __TEST_CLIENT_IP(n)	("2001:db8:" __stringify(n) "::1")
+# define TEST_CLIENT_IP	__TEST_CLIENT_IP(1)
+# define TEST_WRONG_IP	"2001:db8:253::1"
+# define TEST_SERVER_IP	"2001:db8:254::1"
+# define TEST_NETWORK	"2001::"
+# define TEST_PREFIX	128
+# define TEST_FAMILY	AF_INET6
+# define SOCKADDR_ANY	addr_any6
+# define sockaddr_af	struct sockaddr_in6
+#else
+# define __TEST_CLIENT_IP(n)	("10.0." __stringify(n) ".1")
+# define TEST_CLIENT_IP	__TEST_CLIENT_IP(1)
+# define TEST_WRONG_IP	"10.0.253.1"
+# define TEST_SERVER_IP	"10.0.254.1"
+# define TEST_NETWORK	"10.0.0.0"
+# define TEST_PREFIX	32
+# define TEST_FAMILY	AF_INET
+# define SOCKADDR_ANY	addr_any4
+# define sockaddr_af	struct sockaddr_in
+#endif
+
+static inline union tcp_addr gen_tcp_addr(union tcp_addr net, size_t n)
+{
+	union tcp_addr ret = net;
+
+#ifdef IPV6_TEST
+	ret.a6.s6_addr32[3] = htonl(n & (BIT(32) - 1));
+	ret.a6.s6_addr32[2] = htonl((n >> 32) & (BIT(32) - 1));
+#else
+	ret.a4.s_addr = htonl(ntohl(net.a4.s_addr) + n);
+#endif
+
+	return ret;
+}
+
+static inline void tcp_addr_to_sockaddr_in(void *dest,
+					   const union tcp_addr *src,
+					   unsigned int port)
+{
+	sockaddr_af *out = dest;
+
+	memset(out, 0, sizeof(*out));
+#ifdef IPV6_TEST
+	out->sin6_family = AF_INET6;
+	out->sin6_port   = port;
+	out->sin6_addr   = src->a6;
+#else
+	out->sin_family  = AF_INET;
+	out->sin_port    = port;
+	out->sin_addr    = src->a4;
+#endif
+}
+
+static inline void test_init(unsigned int ntests,
+			     thread_fn peer1, thread_fn peer2)
+{
+	test_init2(ntests, peer1, peer2, TEST_FAMILY, TEST_PREFIX,
+			TEST_SERVER_IP, TEST_CLIENT_IP);
+}
+extern void synchronize_threads(void);
+extern void switch_ns(int fd);
+
+extern __thread union tcp_addr this_ip_addr;
+extern __thread union tcp_addr this_ip_dest;
+extern int test_family;
+
+extern void randomize_buffer(void *buf, size_t buflen);
+extern int open_netns(void);
+extern int unshare_open_netns(void);
+extern const char veth_name[];
+extern int add_veth(const char *name, int nsfda, int nsfdb);
+extern int add_vrf(const char *name, uint32_t tabid, int ifindex, int nsfd);
+extern int ip_addr_add(const char *intf, int family,
+		       union tcp_addr addr, uint8_t prefix);
+extern int ip_route_add(const char *intf, int family,
+			union tcp_addr src, union tcp_addr dst);
+extern int ip_route_add_vrf(const char *intf, int family,
+			    union tcp_addr src, union tcp_addr dst,
+			    uint8_t vrf);
+extern int link_set_up(const char *intf);
+
+extern const unsigned int test_server_port;
+extern int test_wait_fd(int sk, time_t sec, bool write);
+extern int __test_connect_socket(int sk, const char *device,
+				 void *addr, size_t addr_sz, time_t timeout);
+extern int __test_listen_socket(int backlog, void *addr, size_t addr_sz);
+
+static inline int test_listen_socket(const union tcp_addr taddr,
+				     unsigned int port, int backlog)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &taddr, htons(port));
+	return __test_listen_socket(backlog, (void *)&addr, sizeof(addr));
+}
+
+/*
+ * In order for selftests to work under CONFIG_CRYPTO_FIPS=y,
+ * the password should be loger than 14 bytes, see hmac_setkey()
+ */
+#define TEST_TCP_AO_MINKEYLEN	14
+#define DEFAULT_TEST_PASSWORD	"In this hour, I do not believe that any darkness will endure."
+
+#ifndef DEFAULT_TEST_ALGO
+#define DEFAULT_TEST_ALGO	"cmac(aes128)"
+#endif
+
+#ifdef IPV6_TEST
+#define DEFAULT_TEST_PREFIX	128
+#else
+#define DEFAULT_TEST_PREFIX	32
+#endif
+
+/*
+ * Timeout on syscalls where failure is not expected.
+ * You may want to rise it if the test machine is very busy.
+ */
+#ifndef TEST_TIMEOUT_SEC
+#define TEST_TIMEOUT_SEC	5
+#endif
+
+/*
+ * Timeout on connect() where a failure is expected.
+ * If set to 0 - kernel will try to retransmit SYN number of times, set in
+ * /proc/sys/net/ipv4/tcp_syn_retries
+ * By default set to 1 to make tests pass faster on non-busy machine.
+ */
+#ifndef TEST_RETRANSMIT_SEC
+#define TEST_RETRANSMIT_SEC	1
+#endif
+
+static inline int _test_connect_socket(int sk, const union tcp_addr taddr,
+				       unsigned int port, time_t timeout)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &taddr, htons(port));
+	return __test_connect_socket(sk, veth_name,
+				     (void *)&addr, sizeof(addr), timeout);
+}
+
+static inline int test_connect_socket(int sk, const union tcp_addr taddr,
+				      unsigned int port)
+{
+	return _test_connect_socket(sk, taddr, port, TEST_TIMEOUT_SEC);
+}
+
+extern int __test_set_md5(int sk, void *addr, size_t addr_sz,
+			  uint8_t prefix, int vrf, const char *password);
+static inline int test_set_md5(int sk, const union tcp_addr in_addr,
+			       uint8_t prefix, int vrf, const char *password)
+{
+	sockaddr_af addr;
+
+	if (prefix > DEFAULT_TEST_PREFIX)
+		prefix = DEFAULT_TEST_PREFIX;
+
+	tcp_addr_to_sockaddr_in(&addr, &in_addr, 0);
+	return __test_set_md5(sk, (void *)&addr, sizeof(addr),
+			prefix, vrf, password);
+}
+
+extern int test_prepare_key_sockaddr(struct tcp_ao_add *ao, const char *alg,
+		void *addr, size_t addr_sz, bool set_current, bool set_rnext,
+		uint8_t prefix, uint8_t vrf,
+		uint8_t sndid, uint8_t rcvid, uint8_t maclen,
+		uint8_t keyflags, uint8_t keylen, const char *key);
+
+static inline int test_prepare_key(struct tcp_ao_add *ao,
+		const char *alg, union tcp_addr taddr,
+		bool set_current, bool set_rnext,
+		uint8_t prefix, uint8_t vrf,
+		uint8_t sndid, uint8_t rcvid, uint8_t maclen,
+		uint8_t keyflags, uint8_t keylen, const char *key)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &taddr, 0);
+	return test_prepare_key_sockaddr(ao, alg, (void *)&addr, sizeof(addr),
+			set_current, set_rnext, prefix, vrf, sndid, rcvid,
+			maclen, keyflags, keylen, key);
+}
+
+static inline int test_prepare_def_key(struct tcp_ao_add *ao,
+		const char *key, uint8_t keyflags,
+		union tcp_addr in_addr, uint8_t prefix, uint8_t vrf,
+		uint8_t sndid, uint8_t rcvid)
+{
+	if (prefix > DEFAULT_TEST_PREFIX)
+		prefix = DEFAULT_TEST_PREFIX;
+
+	return test_prepare_key(ao, DEFAULT_TEST_ALGO, in_addr, false, false,
+				prefix, vrf, sndid, rcvid, 0, keyflags,
+				strlen(key), key);
+}
+
+extern int test_get_one_ao(int sk, struct tcp_ao_getsockopt *out,
+			   void *addr, size_t addr_sz,
+			   uint8_t prefix, uint8_t sndid, uint8_t rcvid);
+extern int test_get_ao_info(int sk, struct tcp_ao_info_opt *out);
+extern int test_set_ao_info(int sk, struct tcp_ao_info_opt *in);
+extern int test_cmp_getsockopt_setsockopt(const struct tcp_ao_add *a,
+					  const struct tcp_ao_getsockopt *b);
+extern int test_cmp_getsockopt_setsockopt_ao(const struct tcp_ao_info_opt *a,
+					     const struct tcp_ao_info_opt *b);
+
+static inline int test_verify_socket_key(int sk, struct tcp_ao_add *key)
+{
+	struct tcp_ao_getsockopt key2 = {};
+	int err;
+
+	err = test_get_one_ao(sk, &key2, &key->addr, sizeof(key->addr),
+			      key->prefix, key->sndid, key->rcvid);
+	if (err)
+		return err;
+
+	return test_cmp_getsockopt_setsockopt(key, &key2);
+}
+
+static inline int test_add_key_vrf(int sk,
+				   const char *key, uint8_t keyflags,
+				   union tcp_addr in_addr, uint8_t prefix,
+				   uint8_t vrf, uint8_t sndid, uint8_t rcvid)
+{
+	struct tcp_ao_add tmp = {};
+	int err;
+
+	err = test_prepare_def_key(&tmp, key, keyflags, in_addr, prefix,
+				   vrf, sndid, rcvid);
+	if (err)
+		return err;
+
+	err = setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp));
+	if (err < 0)
+		return -errno;
+
+	return test_verify_socket_key(sk, &tmp);
+}
+
+static inline int test_add_key(int sk, const char *key,
+			      union tcp_addr in_addr, uint8_t prefix,
+			      uint8_t sndid, uint8_t rcvid)
+{
+	return test_add_key_vrf(sk, key, 0, in_addr, prefix, 0, sndid, rcvid);
+}
+
+static inline int test_verify_socket_ao(int sk, struct tcp_ao_info_opt *ao)
+{
+	struct tcp_ao_info_opt ao2 = {};
+	int err;
+
+	err = test_get_ao_info(sk, &ao2);
+	if (err)
+		return err;
+
+	return test_cmp_getsockopt_setsockopt_ao(ao, &ao2);
+}
+
+static inline int test_set_ao_flags(int sk, bool ao_required, bool accept_icmps)
+{
+	struct tcp_ao_info_opt ao = {};
+	int err;
+
+	err = test_get_ao_info(sk, &ao);
+	/* Maybe ao_info wasn't allocated yet */
+	if (err && err != -ENOENT)
+		return err;
+
+	ao.ao_required = !!ao_required;
+	ao.accept_icmps = !!accept_icmps;
+	err = test_set_ao_info(sk, &ao);
+	if (err)
+		return err;
+
+	return test_verify_socket_ao(sk, &ao);
+}
+
+extern ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec);
+extern ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
+				const size_t msg_len, time_t timeout_sec);
+extern int test_client_verify(int sk, const size_t msg_len, const size_t nr,
+			      time_t timeout_sec);
+
+struct tcp_ao_key_counters {
+	uint8_t sndid;
+	uint8_t rcvid;
+	uint64_t pkt_good;
+	uint64_t pkt_bad;
+};
+
+struct tcp_ao_counters {
+	/* per-netns */
+	uint64_t netns_ao_good;
+	uint64_t netns_ao_bad;
+	uint64_t netns_ao_key_not_found;
+	uint64_t netns_ao_required;
+	uint64_t netns_ao_dropped_icmp;
+	/* per-socket */
+	uint64_t ao_info_pkt_good;
+	uint64_t ao_info_pkt_bad;
+	uint64_t ao_info_pkt_key_not_found;
+	uint64_t ao_info_pkt_ao_required;
+	uint64_t ao_info_pkt_dropped_icmp;
+	/* per-key */
+	size_t nr_keys;
+	struct tcp_ao_key_counters *key_cnts;
+};
+extern int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out);
+
+#define TEST_CNT_KEY_GOOD		BIT(0)
+#define TEST_CNT_KEY_BAD		BIT(1)
+#define TEST_CNT_SOCK_GOOD		BIT(2)
+#define TEST_CNT_SOCK_BAD		BIT(3)
+#define TEST_CNT_SOCK_KEY_NOT_FOUND	BIT(4)
+#define TEST_CNT_SOCK_AO_REQUIRED	BIT(5)
+#define TEST_CNT_SOCK_DROPPED_ICMP	BIT(6)
+#define TEST_CNT_NS_GOOD		BIT(7)
+#define TEST_CNT_NS_BAD			BIT(8)
+#define TEST_CNT_NS_KEY_NOT_FOUND	BIT(9)
+#define TEST_CNT_NS_AO_REQUIRED		BIT(10)
+#define TEST_CNT_NS_DROPPED_ICMP	BIT(11)
+typedef uint16_t test_cnt;
+
+#define TEST_CNT_AO_GOOD		(TEST_CNT_SOCK_GOOD | TEST_CNT_NS_GOOD)
+#define TEST_CNT_AO_BAD			(TEST_CNT_SOCK_BAD | TEST_CNT_NS_BAD)
+#define TEST_CNT_AO_KEY_NOT_FOUND	(TEST_CNT_SOCK_KEY_NOT_FOUND | \
+					 TEST_CNT_NS_KEY_NOT_FOUND)
+#define TEST_CNT_AO_REQUIRED		(TEST_CNT_SOCK_AO_REQUIRED | \
+					 TEST_CNT_NS_AO_REQUIRED)
+#define TEST_CNT_AO_DROPPED_ICMP	(TEST_CNT_SOCK_DROPPED_ICMP | \
+					 TEST_CNT_NS_DROPPED_ICMP)
+#define TEST_CNT_GOOD			(TEST_CNT_KEY_GOOD | TEST_CNT_AO_GOOD)
+#define TEST_CNT_BAD			(TEST_CNT_KEY_BAD | TEST_CNT_AO_BAD)
+
+extern int __test_tcp_ao_counters_cmp(const char *tst_name,
+		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
+		test_cnt expected);
+extern int test_tcp_ao_key_counters_cmp(const char *tst_name,
+		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
+		test_cnt expected, int sndid, int rcvid);
+extern void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts);
+/*
+ * Frees buffers allocated in test_get_tcp_ao_counters().
+ * The function doesn't expect new keys or keys removed between calls
+ * to test_get_tcp_ao_counters(). Check key counters manually if they
+ * may change.
+ */
+static inline int test_tcp_ao_counters_cmp(const char *tst_name,
+					   struct tcp_ao_counters *before,
+					   struct tcp_ao_counters *after,
+					   test_cnt expected)
+{
+	int ret;
+
+	ret = __test_tcp_ao_counters_cmp(tst_name, before, after, expected);
+	if (ret)
+		goto out;
+	ret = test_tcp_ao_key_counters_cmp(tst_name, before, after,
+					   expected, -1, -1);
+out:
+	test_tcp_ao_counters_free(before);
+	test_tcp_ao_counters_free(after);
+	return ret;
+}
+
+struct netstat;
+extern struct netstat *netstat_read(void);
+extern void netstat_free(struct netstat *ns);
+extern void netstat_print_diff(struct netstat *nsa, struct netstat *nsb);
+extern uint64_t netstat_get(struct netstat *ns,
+			    const char *name, bool *not_found);
+
+static inline uint64_t netstat_get_one(const char *name, bool *not_found)
+{
+	struct netstat *ns = netstat_read();
+	uint64_t ret;
+
+	ret = netstat_get(ns, name, not_found);
+
+	netstat_free(ns);
+	return ret;
+}
+
+struct tcp_sock_queue {
+	uint32_t seq;
+	void *buf;
+};
+
+struct tcp_sock_state {
+	struct tcp_info info;
+	struct tcp_repair_window trw;
+	struct tcp_sock_queue out;
+	int outq_len;		/* output queue size (not sent + not acked) */
+	int outq_nsd_len;	/* output queue size (not sent only) */
+	struct tcp_sock_queue in;
+	int inq_len;
+	int mss;
+	int timestamp;
+};
+
+extern void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
+				   void *addr, size_t addr_size);
+static inline void test_sock_checkpoint(int sk, struct tcp_sock_state *state,
+					sockaddr_af *saddr)
+{
+	__test_sock_checkpoint(sk, state, saddr, sizeof(*saddr));
+}
+extern void test_ao_checkpoint(int sk, struct tcp_ao_repair *state);
+extern void __test_sock_restore(int sk, const char *device,
+				struct tcp_sock_state *state,
+				void *saddr, void *daddr, size_t addr_size);
+static inline void test_sock_restore(int sk, struct tcp_sock_state *state,
+				     sockaddr_af *saddr,
+				     const union tcp_addr daddr,
+				     unsigned int dport)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
+	__test_sock_restore(sk, veth_name, state, saddr, &addr, sizeof(addr));
+}
+extern void test_ao_restore(int sk, struct tcp_ao_repair *state);
+extern void test_sock_state_free(struct tcp_sock_state *state);
+extern void test_enable_repair(int sk);
+extern void test_disable_repair(int sk);
+extern void test_kill_sk(int sk);
+static inline int test_add_repaired_key(int sk,
+					const char *key, uint8_t keyflags,
+					union tcp_addr in_addr, uint8_t prefix,
+					uint8_t sndid, uint8_t rcvid)
+{
+	struct tcp_ao_add tmp = {};
+	int err;
+
+	err = test_prepare_def_key(&tmp, key, keyflags, in_addr, prefix,
+				   0, sndid, rcvid);
+	if (err)
+		return err;
+
+	tmp.set_current = 1;
+	tmp.set_rnext = 1;
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0)
+		return -errno;
+
+	return test_verify_socket_key(sk, &tmp);
+}
+
+#endif /* _AOLIB_H_ */
diff --git a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
new file mode 100644
index 000000000000..f279ffc3843b
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Check what features does the kernel support (where the selftest is running).
+ * Somewhat inspired by CRIU kerndat/kdat kernel features detector.
+ */
+#include <pthread.h>
+#include "aolib.h"
+
+struct kconfig_t {
+	int _errno;		/* the returned error if not supported */
+	int (*check_kconfig)(int *error);
+};
+
+static int has_net_ns(int *err)
+{
+	if (access("/proc/self/ns/net", F_OK) < 0) {
+		*err = errno;
+		if (errno == ENOENT)
+			return 0;
+		test_print("Unable to access /proc/self/ns/net: %m");
+		return -errno;
+	}
+	return *err = errno = 0;
+}
+
+static int has_veth(int *err)
+{
+	int orig_netns, ns_a, ns_b;
+
+	orig_netns = open_netns();
+	ns_a = unshare_open_netns();
+	ns_b = unshare_open_netns();
+
+	*err = add_veth("check_veth", ns_a, ns_b);
+
+	switch_ns(orig_netns);
+	close(orig_netns);
+	close(ns_a);
+	close(ns_b);
+	return 0;
+}
+
+static int has_tcp_ao(int *err)
+{
+	struct sockaddr_in addr = {
+		.sin_family = test_family,
+	};
+	struct tcp_ao_add tmp = {};
+	const char *password = DEFAULT_TEST_PASSWORD;
+	int sk, ret = 0;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0) {
+		test_print("socket(): %m");
+		return -errno;
+	}
+
+	tmp.sndid = 100;
+	tmp.rcvid = 100;
+	tmp.keylen = strlen(password);
+	memcpy(tmp.key, password, strlen(password));
+	strcpy(tmp.alg_name, "hmac(sha1)");
+	memcpy(&tmp.addr, &addr, sizeof(addr));
+	*err = 0;
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0) {
+		*err = errno;
+		if (errno != ENOPROTOOPT)
+			ret = -errno;
+	}
+	close(sk);
+	return ret;
+}
+
+static int has_tcp_md5(int *err)
+{
+	union tcp_addr addr_any = {};
+	int sk, ret = 0;
+
+	sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0) {
+		test_print("socket(): %m");
+		return -errno;
+	}
+
+	/*
+	 * Under CONFIG_CRYPTO_FIPS=y it fails with ENOMEM, rather with
+	 * anything more descriptive. Oh well.
+	 */
+	*err = 0;
+	if (test_set_md5(sk, addr_any, 0, -1, DEFAULT_TEST_PASSWORD)) {
+		*err = errno;
+		if (errno != ENOPROTOOPT && errno == ENOMEM) {
+			test_print("setsockopt(TCP_MD5SIG_EXT): %m");
+			ret = -errno;
+		}
+	}
+	close(sk);
+	return ret;
+}
+
+static int has_vrfs(int *err)
+{
+	int orig_netns, ns_test, ret = 0;
+
+	orig_netns = open_netns();
+	ns_test = unshare_open_netns();
+
+	*err = add_vrf("ksft-check", 55, 101, ns_test);
+	if (*err && *err != -EOPNOTSUPP) {
+		test_print("Failed to add a VRF: %d", *err);
+		ret = *err;
+	}
+
+	switch_ns(orig_netns);
+	close(orig_netns);
+	close(ns_test);
+	return ret;
+}
+
+static pthread_mutex_t kconfig_lock = PTHREAD_MUTEX_INITIALIZER;
+static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
+	{ -1, has_net_ns },
+	{ -1, has_veth },
+	{ -1, has_tcp_ao },
+	{ -1, has_tcp_md5 },
+	{ -1, has_vrfs },
+};
+
+const char *tests_skip_reason[__KCONFIG_LAST__] = {
+	"Tests require network namespaces support (CONFIG_NET_NS)",
+	"Tests require veth support (CONFIG_VETH)",
+	"Tests require TCP-AO support (CONFIG_TCP_AO)",
+	"setsockopt(TCP_MD5SIG_EXT) is not supported (CONFIG_TCP_MD5)",
+	"VRFs are not supported (CONFIG_NET_VRF)",
+};
+
+bool kernel_config_has(enum test_needs_kconfig k)
+{
+	bool ret;
+
+	pthread_mutex_lock(&kconfig_lock);
+	if (kconfig[k]._errno == -1) {
+		if (kconfig[k].check_kconfig(&kconfig[k]._errno))
+			test_error("Failed to initialize kconfig %u", k);
+	}
+	ret = kconfig[k]._errno == 0;
+	pthread_mutex_unlock(&kconfig_lock);
+	return ret;
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/netlink.c b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
new file mode 100644
index 000000000000..b731f2c84083
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Original from tools/testing/selftests/net/ipsec.c */
+#include <linux/netlink.h>
+#include <linux/random.h>
+#include <linux/rtnetlink.h>
+#include <linux/veth.h>
+#include <net/if.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/socket.h>
+
+#include "aolib.h"
+
+#define MAX_PAYLOAD		2048
+
+static int netlink_sock(int *sock, uint32_t *seq_nr, int proto)
+{
+	if (*sock > 0) {
+		seq_nr++;
+		return 0;
+	}
+
+	*sock = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, proto);
+	if (*sock < 0) {
+		test_print("socket(AF_NETLINK)");
+		return -1;
+	}
+
+	randomize_buffer(seq_nr, sizeof(*seq_nr));
+
+	return 0;
+}
+
+static int netlink_check_answer(int sock, bool quite)
+{
+	struct nlmsgerror {
+		struct nlmsghdr hdr;
+		int error;
+		struct nlmsghdr orig_msg;
+	} answer;
+
+	if (recv(sock, &answer, sizeof(answer), 0) < 0) {
+		test_print("recv()");
+		return -1;
+	} else if (answer.hdr.nlmsg_type != NLMSG_ERROR) {
+		test_print("expected NLMSG_ERROR, got %d",
+			   (int)answer.hdr.nlmsg_type);
+		return -1;
+	} else if (answer.error) {
+		if (!quite) {
+			test_print("NLMSG_ERROR: %d: %s",
+				answer.error, strerror(-answer.error));
+		}
+		return answer.error;
+	}
+
+	return 0;
+}
+
+static inline struct rtattr *rtattr_hdr(struct nlmsghdr *nh)
+{
+	return (struct rtattr *)((char *)(nh) + RTA_ALIGN((nh)->nlmsg_len));
+}
+
+static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
+		unsigned short rta_type, const void *payload, size_t size)
+{
+	/* NLMSG_ALIGNTO == RTA_ALIGNTO, nlmsg_len already aligned */
+	struct rtattr *attr = rtattr_hdr(nh);
+	size_t nl_size = RTA_ALIGN(nh->nlmsg_len) + RTA_LENGTH(size);
+
+	if (req_sz < nl_size) {
+		test_print("req buf is too small: %zu < %zu", req_sz, nl_size);
+		return -1;
+	}
+	nh->nlmsg_len = nl_size;
+
+	attr->rta_len = RTA_LENGTH(size);
+	attr->rta_type = rta_type;
+	memcpy(RTA_DATA(attr), payload, size);
+
+	return 0;
+}
+
+static struct rtattr *_rtattr_begin(struct nlmsghdr *nh, size_t req_sz,
+		unsigned short rta_type, const void *payload, size_t size)
+{
+	struct rtattr *ret = rtattr_hdr(nh);
+
+	if (rtattr_pack(nh, req_sz, rta_type, payload, size))
+		return 0;
+
+	return ret;
+}
+
+static inline struct rtattr *rtattr_begin(struct nlmsghdr *nh, size_t req_sz,
+		unsigned short rta_type)
+{
+	return _rtattr_begin(nh, req_sz, rta_type, 0, 0);
+}
+
+static inline void rtattr_end(struct nlmsghdr *nh, struct rtattr *attr)
+{
+	char *nlmsg_end = (char *)nh + nh->nlmsg_len;
+
+	attr->rta_len = nlmsg_end - (char *)attr;
+}
+
+static int veth_pack_peerb(struct nlmsghdr *nh, size_t req_sz,
+		const char *peer, int ns)
+{
+	struct ifinfomsg pi;
+	struct rtattr *peer_attr;
+
+	memset(&pi, 0, sizeof(pi));
+	pi.ifi_family	= AF_UNSPEC;
+	pi.ifi_change	= 0xFFFFFFFF;
+
+	peer_attr = _rtattr_begin(nh, req_sz, VETH_INFO_PEER, &pi, sizeof(pi));
+	if (!peer_attr)
+		return -1;
+
+	if (rtattr_pack(nh, req_sz, IFLA_IFNAME, peer, strlen(peer)))
+		return -1;
+
+	if (rtattr_pack(nh, req_sz, IFLA_NET_NS_FD, &ns, sizeof(ns)))
+		return -1;
+
+	rtattr_end(nh, peer_attr);
+
+	return 0;
+}
+
+static int __add_veth(int sock, uint32_t seq, const char *name,
+		      int ns_a, int ns_b)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_EXCL | NLM_F_CREATE;
+	struct {
+		struct nlmsghdr		nh;
+		struct ifinfomsg	info;
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+	static const char veth_type[] = "veth";
+	struct rtattr *link_info, *info_data;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.info));
+	req.nh.nlmsg_type	= RTM_NEWLINK;
+	req.nh.nlmsg_flags	= flags;
+	req.nh.nlmsg_seq	= seq;
+	req.info.ifi_family	= AF_UNSPEC;
+	req.info.ifi_change	= 0xFFFFFFFF;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_IFNAME, name, strlen(name)))
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_NET_NS_FD, &ns_a, sizeof(ns_a)))
+		return -1;
+
+	link_info = rtattr_begin(&req.nh, sizeof(req), IFLA_LINKINFO);
+	if (!link_info)
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_INFO_KIND, veth_type, sizeof(veth_type)))
+		return -1;
+
+	info_data = rtattr_begin(&req.nh, sizeof(req), IFLA_INFO_DATA);
+	if (!info_data)
+		return -1;
+
+	if (veth_pack_peerb(&req.nh, sizeof(req), name, ns_b))
+		return -1;
+
+	rtattr_end(&req.nh, info_data);
+	rtattr_end(&req.nh, link_info);
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		test_print("send()");
+		return -1;
+	}
+	return netlink_check_answer(sock, false);
+}
+
+int add_veth(const char *name, int nsfda, int nsfdb)
+{
+	int route_sock = -1, ret;
+	uint32_t route_seq;
+
+	if (netlink_sock(&route_sock, &route_seq, NETLINK_ROUTE))
+		test_error("Failed to open netlink route socket\n");
+
+	ret = __add_veth(route_sock, route_seq++, name, nsfda, nsfdb);
+	close(route_sock);
+	return ret;
+}
+
+static int __ip_addr_add(int sock, uint32_t seq, const char *intf,
+			 int family, union tcp_addr addr, uint8_t prefix)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_EXCL | NLM_F_CREATE;
+	struct {
+		struct nlmsghdr		nh;
+		struct ifaddrmsg	info;
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+	size_t addr_len = (family == AF_INET) ? sizeof(struct in_addr) :
+						sizeof(struct in6_addr);
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.info));
+	req.nh.nlmsg_type	= RTM_NEWADDR;
+	req.nh.nlmsg_flags	= flags;
+	req.nh.nlmsg_seq	= seq;
+	req.info.ifa_family	= family;
+	req.info.ifa_prefixlen	= prefix;
+	req.info.ifa_index	= if_nametoindex(intf);
+	req.info.ifa_flags	= IFA_F_NODAD;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFA_LOCAL, &addr, addr_len))
+		return -1;
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		test_print("send()");
+		return -1;
+	}
+	return netlink_check_answer(sock, true);
+}
+
+int ip_addr_add(const char *intf, int family,
+		union tcp_addr addr, uint8_t prefix)
+{
+	int route_sock = -1, ret;
+	uint32_t route_seq;
+
+	if (netlink_sock(&route_sock, &route_seq, NETLINK_ROUTE))
+		test_error("Failed to open netlink route socket\n");
+
+	ret = __ip_addr_add(route_sock, route_seq++, intf,
+			    family, addr, prefix);
+
+	close(route_sock);
+	return ret;
+}
+
+static int __ip_route_add(int sock, uint32_t seq, const char *intf, int family,
+			  union tcp_addr src, union tcp_addr dst, uint8_t vrf)
+{
+	struct {
+		struct nlmsghdr	nh;
+		struct rtmsg	rt;
+		char		attrbuf[MAX_PAYLOAD];
+	} req;
+	unsigned int index = if_nametoindex(intf);
+	size_t addr_len = (family == AF_INET) ? sizeof(struct in_addr) :
+						sizeof(struct in6_addr);
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.rt));
+	req.nh.nlmsg_type	= RTM_NEWROUTE;
+	req.nh.nlmsg_flags	= NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE;
+	req.nh.nlmsg_seq	= seq;
+	req.rt.rtm_family	= family;
+	req.rt.rtm_dst_len	= (family == AF_INET) ? 32 : 128;
+	req.rt.rtm_table	= RT_TABLE_MAIN;
+	req.rt.rtm_protocol	= RTPROT_BOOT;
+	req.rt.rtm_scope	= RT_SCOPE_UNIVERSE;
+	req.rt.rtm_type		= RTN_UNICAST;
+
+	if (rtattr_pack(&req.nh, sizeof(req), RTA_DST, &dst, addr_len))
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), RTA_PREFSRC, &src, addr_len))
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), RTA_OIF, &index, sizeof(index)))
+		return -1;
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		test_print("send()");
+		return -1;
+	}
+
+	return netlink_check_answer(sock, true);
+}
+
+int ip_route_add_vrf(const char *intf, int family,
+		 union tcp_addr src, union tcp_addr dst, uint8_t vrf)
+{
+	int route_sock = -1, ret;
+	uint32_t route_seq;
+
+	if (netlink_sock(&route_sock, &route_seq, NETLINK_ROUTE))
+		test_error("Failed to open netlink route socket\n");
+
+	ret = __ip_route_add(route_sock, route_seq++, intf,
+			     family, src, dst, vrf);
+	if (ret == -EEXIST) /* ignoring */
+		ret = 0;
+
+	close(route_sock);
+	return ret;
+}
+
+int ip_route_add(const char *intf, int family,
+		 union tcp_addr src, union tcp_addr dst)
+{
+	return ip_route_add_vrf(intf, family, src, dst, RT_TABLE_MAIN);
+}
+
+static int __link_set_up(int sock, uint32_t seq, const char *intf)
+{
+	struct {
+		struct nlmsghdr		nh;
+		struct ifinfomsg	info;
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.info));
+	req.nh.nlmsg_type	= RTM_NEWLINK;
+	req.nh.nlmsg_flags	= NLM_F_REQUEST | NLM_F_ACK;
+	req.nh.nlmsg_seq	= seq;
+	req.info.ifi_family	= AF_UNSPEC;
+	req.info.ifi_change	= 0xFFFFFFFF;
+	req.info.ifi_index	= if_nametoindex(intf);
+	req.info.ifi_flags	= IFF_UP;
+	req.info.ifi_change	= IFF_UP;
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		test_print("send()");
+		return -1;
+	}
+	return netlink_check_answer(sock, false);
+}
+
+int link_set_up(const char *intf)
+{
+	int route_sock = -1, ret;
+	uint32_t route_seq;
+
+	if (netlink_sock(&route_sock, &route_seq, NETLINK_ROUTE))
+		test_error("Failed to open netlink route socket\n");
+
+	ret = __link_set_up(route_sock, route_seq++, intf);
+
+	close(route_sock);
+	return ret;
+}
+
+static int __add_vrf(int sock, uint32_t seq, const char *name,
+		     uint32_t tabid, int ifindex, int nsfd)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_EXCL | NLM_F_CREATE;
+	struct {
+		struct nlmsghdr		nh;
+		struct ifinfomsg	info;
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+	static const char vrf_type[] = "vrf";
+	struct rtattr *link_info, *info_data;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.info));
+	req.nh.nlmsg_type	= RTM_NEWLINK;
+	req.nh.nlmsg_flags	= flags;
+	req.nh.nlmsg_seq	= seq;
+	req.info.ifi_family	= AF_UNSPEC;
+	req.info.ifi_change	= 0xFFFFFFFF;
+	req.info.ifi_index	= ifindex;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_IFNAME, name, strlen(name)))
+		return -1;
+
+	if (nsfd >= 0)
+		if (rtattr_pack(&req.nh, sizeof(req), IFLA_NET_NS_FD,
+				&nsfd, sizeof(nsfd)))
+			return -1;
+
+	link_info = rtattr_begin(&req.nh, sizeof(req), IFLA_LINKINFO);
+	if (!link_info)
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_INFO_KIND, vrf_type, sizeof(vrf_type)))
+		return -1;
+
+	info_data = rtattr_begin(&req.nh, sizeof(req), IFLA_INFO_DATA);
+	if (!info_data)
+		return -1;
+
+	if (rtattr_pack(&req.nh, sizeof(req), IFLA_VRF_TABLE,
+			&tabid, sizeof(tabid)))
+		return -1;
+
+	rtattr_end(&req.nh, info_data);
+	rtattr_end(&req.nh, link_info);
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		test_print("send()");
+		return -1;
+	}
+	return netlink_check_answer(sock, true);
+}
+
+int add_vrf(const char *name, uint32_t tabid, int ifindex, int nsfd)
+{
+	int route_sock = -1, ret;
+	uint32_t route_seq;
+
+	if (netlink_sock(&route_sock, &route_seq, NETLINK_ROUTE))
+		test_error("Failed to open netlink route socket\n");
+
+	ret = __add_vrf(route_sock, route_seq++, name, tabid, ifindex, nsfd);
+	close(route_sock);
+	return ret;
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
new file mode 100644
index 000000000000..2322f4d4676d
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdio.h>
+#include "../../../../../include/linux/compiler.h"
+#include "../../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+struct netstat_counter {
+	uint64_t val;
+	char *name;
+};
+
+struct netstat {
+	char *header_name;
+	struct netstat *next;
+	size_t counters_nr;
+	struct netstat_counter *counters;
+};
+
+static struct netstat *lookup_type(struct netstat *ns,
+		const char *type, size_t len)
+{
+	while (ns != NULL) {
+		size_t cmp = max(len, strlen(ns->header_name));
+
+		if (!strncmp(ns->header_name, type, cmp))
+			return ns;
+		ns = ns->next;
+	}
+	return NULL;
+}
+
+static struct netstat *lookup_get(struct netstat *ns,
+				  const char *type, const size_t len)
+{
+	struct netstat *ret;
+
+	ret = lookup_type(ns, type, len);
+	if (ret != NULL)
+		return ret;
+
+	ret = malloc(sizeof(struct netstat));
+	if (!ret)
+		test_error("malloc()");
+
+	ret->header_name = strndup(type, len);
+	if (ret->header_name == NULL)
+		test_error("strndup()");
+	ret->next = ns;
+	ret->counters_nr = 0;
+	ret->counters = NULL;
+
+	return ret;
+}
+
+static struct netstat *lookup_get_column(struct netstat *ns, const char *line)
+{
+	char *column;
+
+	column = strchr(line, ':');
+	if (!column)
+		test_error("can't parse netstat file");
+
+	return lookup_get(ns, line, column - line);
+}
+
+static void netstat_read_type(FILE *fnetstat, struct netstat **dest, char *line)
+{
+	struct netstat *type = lookup_get_column(*dest, line);
+	const char *pos = line;
+	size_t i, nr_elems = 0;
+	char tmp;
+
+	while ((pos = strchr(pos, ' '))) {
+		nr_elems++;
+		pos++;
+	}
+
+	*dest = type;
+	type->counters = reallocarray(type->counters,
+				type->counters_nr + nr_elems,
+				sizeof(struct netstat_counter));
+	if (!type->counters)
+		test_error("reallocarray()");
+
+	pos = strchr(line, ' ') + 1;
+
+	if (fscanf(fnetstat, type->header_name) == EOF)
+		test_error("fscanf(%s)", type->header_name);
+	if (fread(&tmp, 1, 1, fnetstat) != 1 || tmp != ':')
+		test_error("Unexpected netstat format (%c)", tmp);
+
+	for (i = type->counters_nr; i < type->counters_nr + nr_elems; i++) {
+		struct netstat_counter *nc = &type->counters[i];
+		const char *new_pos = strchr(pos, ' ');
+		const char *fmt = " %" PRIu64;
+
+		if (new_pos == NULL)
+			new_pos = strchr(pos, '\n');
+
+		nc->name = strndup(pos, new_pos - pos);
+		if (nc->name == NULL)
+			test_error("strndup()");
+
+		if (unlikely(!strcmp(nc->name, "MaxConn")))
+			fmt = " %" PRId64; /* MaxConn is signed, RFC 2012 */
+		if (fscanf(fnetstat, fmt, &nc->val) != 1)
+			test_error("fscanf(%s)", nc->name);
+		pos = new_pos + 1;
+	}
+	type->counters_nr += nr_elems;
+
+	if (fread(&tmp, 1, 1, fnetstat) != 1 || tmp != '\n')
+		test_error("Unexpected netstat format");
+}
+
+static const char *snmp6_name = "Snmp6";
+static void snmp6_read(FILE *fnetstat, struct netstat **dest)
+{
+	struct netstat *type = lookup_get(*dest, snmp6_name, strlen(snmp6_name));
+	char *counter_name;
+	size_t i;
+
+	for (i = type->counters_nr;; i++) {
+		struct netstat_counter *nc;
+		uint64_t counter;
+
+		if (fscanf(fnetstat, "%ms", &counter_name) == EOF)
+			break;
+		if (fscanf(fnetstat, "%" PRIu64, &counter) == EOF)
+			test_error("Unexpected snmp6 format");
+		type->counters = reallocarray(type->counters, i + 1,
+					sizeof(struct netstat_counter));
+		if (!type->counters)
+			test_error("reallocarray()");
+		nc = &type->counters[i];
+		nc->name = counter_name;
+		nc->val = counter;
+	}
+	type->counters_nr = i;
+	*dest = type;
+}
+
+struct netstat *netstat_read(void)
+{
+	struct netstat *ret = 0;
+	size_t line_sz = 0;
+	char *line = NULL;
+	FILE *fnetstat;
+
+	/*
+	 * Opening thread-self instead of /proc/net/... as the latter
+	 * points to /proc/self/net/ which instantiates thread-leader's
+	 * net-ns, see:
+	 * commit 155134fef2b6 ("Revert "proc: Point /proc/{mounts,net} at..")
+	 */
+	errno = 0;
+	fnetstat = fopen("/proc/thread-self/net/netstat", "r");
+	if (fnetstat == NULL)
+		test_error("failed to open /proc/net/netstat");
+
+	while (getline(&line, &line_sz, fnetstat) != -1)
+		netstat_read_type(fnetstat, &ret, line);
+	fclose(fnetstat);
+
+	errno = 0;
+	fnetstat = fopen("/proc/thread-self/net/snmp", "r");
+	if (fnetstat == NULL)
+		test_error("failed to open /proc/net/snmp");
+
+	while (getline(&line, &line_sz, fnetstat) != -1)
+		netstat_read_type(fnetstat, &ret, line);
+	fclose(fnetstat);
+
+	errno = 0;
+	fnetstat = fopen("/proc/thread-self/net/snmp6", "r");
+	if (fnetstat == NULL)
+		test_error("failed to open /proc/net/snmp6");
+
+	snmp6_read(fnetstat, &ret);
+	fclose(fnetstat);
+
+	free(line);
+	return ret;
+}
+
+void netstat_free(struct netstat *ns)
+{
+	while (ns != NULL) {
+		struct netstat *prev = ns;
+		size_t i;
+
+		free(ns->header_name);
+		for (i = 0; i < ns->counters_nr; i++)
+			free(ns->counters[i].name);
+		free(ns->counters);
+		ns = ns->next;
+		free(prev);
+	}
+}
+
+static inline void
+__netstat_print_diff(uint64_t a, struct netstat *nsb, size_t i)
+{
+	if (unlikely(!strcmp(nsb->header_name, "MaxConn"))) {
+		test_print("%8s %25s: %" PRId64 " => %" PRId64,
+				nsb->header_name, nsb->counters[i].name,
+				a, nsb->counters[i].val);
+		return;
+	}
+
+	test_print("%8s %25s: %" PRIu64 " => %" PRIu64, nsb->header_name,
+			nsb->counters[i].name, a, nsb->counters[i].val);
+}
+
+void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
+{
+	size_t i, j;
+
+	while (nsb != NULL) {
+		if (unlikely(strcmp(nsb->header_name, nsa->header_name))) {
+			for (i = 0; i < nsb->counters_nr; i++)
+				__netstat_print_diff(0, nsb, i);
+			nsb = nsb->next;
+			continue;
+		}
+
+		if (nsb->counters_nr < nsa->counters_nr)
+			test_error("Unexpected: some counters dissapeared!");
+
+		for (j = 0, i = 0; i < nsb->counters_nr; i++) {
+			if (strcmp(nsb->counters[i].name, nsa->counters[j].name)) {
+				__netstat_print_diff(0, nsb, i);
+				continue;
+			}
+
+			if (nsa->counters[j].val == nsb->counters[i].val) {
+				j++;
+				continue;
+			}
+
+			__netstat_print_diff(nsa->counters[j].val, nsb, i);
+			j++;
+		}
+		if (j != nsa->counters_nr)
+			test_error("Unexpected: some counters dissapeared!");
+
+		nsb = nsb->next;
+		nsa = nsa->next;
+	}
+}
+
+uint64_t netstat_get(struct netstat *ns, const char *name, bool *not_found)
+{
+	if (not_found)
+		*not_found = false;
+
+	while (ns != NULL) {
+		size_t i;
+
+		for (i = 0; i < ns->counters_nr; i++) {
+			if (!strcmp(name, ns->counters[i].name))
+				return ns->counters[i].val;
+		}
+
+		ns = ns->next;
+	}
+
+	if (not_found)
+		*not_found = true;
+	return 0;
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/repair.c b/tools/testing/selftests/net/tcp_ao/lib/repair.c
new file mode 100644
index 000000000000..9893b3ba69f5
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/repair.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/* This is over-simplified TCP_REPAIR for TCP_ESTABLISHED sockets
+ * It tests that TCP-AO enabled connection can be restored.
+ * For the proper socket repair see:
+ * https://github.com/checkpoint-restore/criu/blob/criu-dev/soccr/soccr.h
+ */
+#include <fcntl.h>
+#include <linux/sockios.h>
+#include <sys/ioctl.h>
+#include "aolib.h"
+
+#ifndef TCPOPT_MAXSEG
+# define TCPOPT_MAXSEG		2
+#endif
+#ifndef TCPOPT_WINDOW
+# define TCPOPT_WINDOW		3
+#endif
+#ifndef TCPOPT_SACK_PERMITTED
+# define TCPOPT_SACK_PERMITTED	4
+#endif
+#ifndef TCPOPT_TIMESTAMP
+# define TCPOPT_TIMESTAMP	8
+#endif
+
+enum {
+	TCP_ESTABLISHED = 1,
+	TCP_SYN_SENT,
+	TCP_SYN_RECV,
+	TCP_FIN_WAIT1,
+	TCP_FIN_WAIT2,
+	TCP_TIME_WAIT,
+	TCP_CLOSE,
+	TCP_CLOSE_WAIT,
+	TCP_LAST_ACK,
+	TCP_LISTEN,
+	TCP_CLOSING,	/* Now a valid state */
+	TCP_NEW_SYN_RECV,
+
+	TCP_MAX_STATES	/* Leave at the end! */
+};
+
+static void test_sock_checkpoint_queue(int sk, int queue, int qlen,
+				       struct tcp_sock_queue *q)
+{
+	socklen_t len;
+	int ret;
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_QUEUE, &queue, sizeof(queue)))
+		test_error("setsockopt(TCP_REPAIR_QUEUE)");
+
+	len = sizeof(q->seq);
+	ret = getsockopt(sk, SOL_TCP, TCP_QUEUE_SEQ, &q->seq, &len);
+	if (ret || len != sizeof(q->seq))
+		test_error("getsockopt(TCP_QUEUE_SEQ): %d", (int)len);
+
+	if (!qlen) {
+		q->buf = NULL;
+		return;
+	}
+
+	q->buf = malloc(qlen);
+	if (q->buf == NULL)
+		test_error("malloc()");
+	ret = recv(sk, q->buf, qlen, MSG_PEEK | MSG_DONTWAIT);
+	if (ret != qlen)
+		test_error("recv(%d): %d", qlen, ret);
+}
+
+void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
+			    void *addr, size_t addr_size)
+{
+	socklen_t len = sizeof(state->info);
+	int ret;
+
+	memset(state, 0, sizeof(*state));
+
+	ret = getsockopt(sk, SOL_TCP, TCP_INFO, &state->info, &len);
+	if (ret || len != sizeof(state->info))
+		test_error("getsockopt(TCP_INFO): %d", (int)len);
+
+	len = addr_size;
+	if (getsockname(sk, addr, &len) || len != addr_size)
+		test_error("getsockname(): %d", (int)len);
+
+	len = sizeof(state->trw);
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, &len);
+	if (ret || len != sizeof(state->trw))
+		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
+
+	if (ioctl(sk, SIOCOUTQ, &state->outq_len))
+		test_error("ioctl(SIOCOUTQ)");
+
+	if (ioctl(sk, SIOCOUTQNSD, &state->outq_nsd_len))
+		test_error("ioctl(SIOCOUTQNSD)");
+	test_sock_checkpoint_queue(sk, TCP_SEND_QUEUE, state->outq_len, &state->out);
+
+	if (ioctl(sk, SIOCINQ, &state->inq_len))
+		test_error("ioctl(SIOCINQ)");
+	test_sock_checkpoint_queue(sk, TCP_RECV_QUEUE, state->inq_len, &state->in);
+
+	if (state->info.tcpi_state == TCP_CLOSE)
+		state->outq_len = state->outq_nsd_len = 0;
+
+	len = sizeof(state->mss);
+	ret = getsockopt(sk, SOL_TCP, TCP_MAXSEG, &state->mss, &len);
+	if (ret || len != sizeof(state->mss))
+		test_error("getsockopt(TCP_MAXSEG): %d", (int)len);
+
+	len = sizeof(state->timestamp);
+	ret = getsockopt(sk, SOL_TCP, TCP_TIMESTAMP, &state->timestamp, &len);
+	if (ret || len != sizeof(state->timestamp))
+		test_error("getsockopt(TCP_TIMESTAMP): %d", (int)len);
+}
+
+void test_ao_checkpoint(int sk, struct tcp_ao_repair *state)
+{
+	socklen_t len = sizeof(*state);
+	int ret;
+
+	memset(state, 0, sizeof(*state));
+
+	ret = getsockopt(sk, SOL_TCP, TCP_AO_REPAIR, state, &len);
+	if (ret || len != sizeof(*state))
+		test_error("getsockopt(TCP_AO_REPAIR): %d", (int)len);
+}
+
+static void test_sock_restore_seq(int sk, int queue, uint32_t seq)
+{
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_QUEUE, &queue, sizeof(queue)))
+		test_error("setsockopt(TCP_REPAIR_QUEUE)");
+
+	if (setsockopt(sk, SOL_TCP, TCP_QUEUE_SEQ, &seq, sizeof(seq)))
+		test_error("setsockopt(TCP_QUEUE_SEQ)");
+}
+
+static void test_sock_restore_queue(int sk, int queue, void *buf, int len)
+{
+	int chunk = len;
+	size_t off = 0;
+
+	if (len == 0)
+		return;
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_QUEUE, &queue, sizeof(queue)))
+		test_error("setsockopt(TCP_REPAIR_QUEUE)");
+
+	do {
+		int ret;
+
+		ret = send(sk, buf + off, chunk, 0);
+		if (ret <= 0) {
+			if (chunk > 1024) {
+				chunk >>= 1;
+				continue;
+			}
+			test_error("send()");
+		}
+		off += ret;
+		len -= ret;
+	} while (len > 0);
+}
+
+void __test_sock_restore(int sk, const char *device,
+			 struct tcp_sock_state *state,
+			 void *saddr, void *daddr, size_t addr_size)
+{
+	struct tcp_repair_opt opts[4];
+	unsigned int opt_nr = 0;
+	long flags;
+
+	if (bind(sk, saddr, addr_size))
+		test_error("bind()");
+
+	flags = fcntl(sk, F_GETFL);
+	if ((flags < 0) || (fcntl(sk, F_SETFL, flags | O_NONBLOCK) < 0))
+		test_error("fcntl()");
+
+	test_sock_restore_seq(sk, TCP_RECV_QUEUE, state->in.seq - state->inq_len);
+	test_sock_restore_seq(sk, TCP_SEND_QUEUE, state->out.seq - state->outq_len);
+
+	if (device != NULL && setsockopt(sk, SOL_SOCKET, SO_BINDTODEVICE,
+					 device, strlen(device) + 1))
+		test_error("setsockopt(SO_BINDTODEVICE, %s)", device);
+
+	if (connect(sk, daddr, addr_size))
+		test_error("connect()");
+
+	if (state->info.tcpi_options & TCPI_OPT_SACK) {
+		opts[opt_nr].opt_code = TCPOPT_SACK_PERMITTED;
+		opts[opt_nr].opt_val = 0;
+		opt_nr++;
+	}
+	if (state->info.tcpi_options & TCPI_OPT_WSCALE) {
+		opts[opt_nr].opt_code = TCPOPT_WINDOW;
+		opts[opt_nr].opt_val = state->info.tcpi_snd_wscale +
+				(state->info.tcpi_rcv_wscale << 16);
+		opt_nr++;
+	}
+	if (state->info.tcpi_options & TCPI_OPT_TIMESTAMPS) {
+		opts[opt_nr].opt_code = TCPOPT_TIMESTAMP;
+		opts[opt_nr].opt_val = 0;
+		opt_nr++;
+	}
+	opts[opt_nr].opt_code = TCPOPT_MAXSEG;
+	opts[opt_nr].opt_val = state->mss;
+	opt_nr++;
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_OPTIONS, opts, opt_nr * sizeof(opts[0])))
+		test_error("setsockopt(TCP_REPAIR_OPTIONS)");
+
+	if (state->info.tcpi_options & TCPI_OPT_TIMESTAMPS) {
+		if (setsockopt(sk, SOL_TCP, TCP_TIMESTAMP,
+			       &state->timestamp, opt_nr * sizeof(opts[0])))
+			test_error("setsockopt(TCP_TIMESTAMP)");
+	}
+	test_sock_restore_queue(sk, TCP_RECV_QUEUE, state->in.buf, state->inq_len);
+	test_sock_restore_queue(sk, TCP_SEND_QUEUE, state->out.buf, state->outq_len);
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, sizeof(state->trw)))
+		test_error("setsockopt(TCP_REPAIR_WINDOW)");
+}
+
+void test_ao_restore(int sk, struct tcp_ao_repair *state)
+{
+	if (setsockopt(sk, SOL_TCP, TCP_AO_REPAIR, state, sizeof(*state)))
+		test_error("setsockopt(TCP_AO_REPAIR)");
+}
+
+void test_sock_state_free(struct tcp_sock_state *state)
+{
+	free(state->out.buf);
+	free(state->in.buf);
+}
+
+void test_enable_repair(int sk)
+{
+	int val = TCP_REPAIR_ON;
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR, &val, sizeof(val)))
+		test_error("setsockopt(TCP_REPAIR)");
+}
+
+void test_disable_repair(int sk)
+{
+	int val = TCP_REPAIR_OFF_NO_WP;
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR, &val, sizeof(val)))
+		test_error("setsockopt(TCP_REPAIR)");
+}
+
+void test_kill_sk(int sk)
+{
+	test_enable_repair(sk);
+	close(sk);
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
new file mode 100644
index 000000000000..374b27c26ebd
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include "aolib.h"
+
+/*
+ * Can't be included in the header: it defines static variables which
+ * will be unique to every object. Let's include it only once here.
+ */
+#include "../../../kselftest.h"
+
+/* Prevent overriding of one thread's output by another */
+static pthread_mutex_t ksft_print_lock = PTHREAD_MUTEX_INITIALIZER;
+
+void __test_msg(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_print_msg(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+void __test_ok(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_test_result_pass(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+void __test_fail(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_test_result_fail(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+void __test_xfail(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_test_result_xfail(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+void __test_error(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_test_result_error(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+void __test_skip(const char *buf)
+{
+	pthread_mutex_lock(&ksft_print_lock);
+	ksft_test_result_skip(buf);
+	pthread_mutex_unlock(&ksft_print_lock);
+}
+
+static volatile int failed;
+static volatile int skipped;
+
+void test_failed(void)
+{
+	failed = 1;
+}
+
+static void test_exit(void)
+{
+	if (failed) {
+		ksft_exit_fail();
+	} else if (skipped) {
+		/* ksft_exit_skip() is different from ksft_exit_*() */
+		ksft_print_cnts();
+		exit(KSFT_SKIP);
+	} else {
+		ksft_exit_pass();
+	}
+}
+
+struct dlist_t {
+	void (*destruct)(void);
+	struct dlist_t *next;
+};
+static struct dlist_t *destructors_list;
+
+void test_add_destructor(void (*d)(void))
+{
+	struct dlist_t *p;
+
+	p = malloc(sizeof(struct dlist_t));
+	if (p == NULL)
+		test_error("malloc() failed");
+
+	p->next = destructors_list;
+	p->destruct = d;
+	destructors_list = p;
+}
+
+static void test_destructor(void) __attribute__((destructor));
+static void test_destructor(void)
+{
+	while (destructors_list) {
+		struct dlist_t *p = destructors_list->next;
+
+		destructors_list->destruct();
+		free(destructors_list);
+		destructors_list = p;
+	}
+	test_exit();
+}
+
+static void sig_int(int signo)
+{
+	test_error("Caught SIGINT - exiting");
+}
+
+int open_netns(void)
+{
+	const char *netns_path = "/proc/self/ns/net";
+	int fd;
+
+	fd = open(netns_path, O_RDONLY);
+	if (fd < 0)
+		test_error("open(%s)", netns_path);
+	return fd;
+}
+
+int unshare_open_netns(void)
+{
+	if (unshare(CLONE_NEWNET) != 0)
+		test_error("unshare()");
+
+	return open_netns();
+}
+
+void switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWNET))
+		test_error("setns()");
+}
+
+int switch_save_ns(int new_ns)
+{
+	int ret = open_netns();
+
+	switch_ns(new_ns);
+	return ret;
+}
+
+static int nsfd_outside	= -1;
+static int nsfd_parent	= -1;
+static int nsfd_child	= -1;
+const char veth_name[]	= "ktst-veth";
+
+static void init_namespaces(void)
+{
+	nsfd_outside = open_netns();
+	nsfd_parent = unshare_open_netns();
+	nsfd_child = unshare_open_netns();
+}
+
+static void link_init(const char *veth, int family, uint8_t prefix,
+		      union tcp_addr addr, union tcp_addr dest)
+{
+	if (link_set_up(veth))
+		test_error("Failed to set link up");
+	if (ip_addr_add(veth, family, addr, prefix))
+		test_error("Failed to add ip address");
+	if (ip_route_add(veth, family, addr, dest))
+		test_error("Failed to add route");
+}
+
+static unsigned int nr_threads = 1;
+
+static pthread_mutex_t sync_lock = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t sync_cond = PTHREAD_COND_INITIALIZER;
+static volatile unsigned int stage_threads[2];
+static volatile unsigned int stage_nr;
+
+/* synchronize all threads in the same stage */
+void synchronize_threads(void)
+{
+	unsigned int q = stage_nr;
+
+	pthread_mutex_lock(&sync_lock);
+	stage_threads[q]++;
+	if (stage_threads[q] == nr_threads) {
+		stage_nr ^= 1;
+		stage_threads[stage_nr] = 0;
+		pthread_cond_signal(&sync_cond);
+	}
+	while (stage_threads[q] < nr_threads)
+		pthread_cond_wait(&sync_cond, &sync_lock);
+	pthread_mutex_unlock(&sync_lock);
+}
+
+__thread union tcp_addr this_ip_addr;
+__thread union tcp_addr this_ip_dest;
+int test_family;
+
+struct new_pthread_arg {
+	thread_fn	func;
+	union tcp_addr	my_ip;
+	union tcp_addr	dest_ip;
+};
+static void *new_pthread_entry(void *arg)
+{
+	struct new_pthread_arg *p = arg;
+
+	this_ip_addr = p->my_ip;
+	this_ip_dest = p->dest_ip;
+	p->func(NULL); /* shouldn't return */
+	exit(KSFT_FAIL);
+}
+
+static void __test_skip_all(const char *msg)
+{
+	ksft_set_plan(1);
+	ksft_print_header();
+	skipped = 1;
+	test_skip("%s", msg);
+	exit(KSFT_SKIP);
+}
+
+void __test_init(unsigned int ntests, int family, unsigned int prefix,
+		 union tcp_addr addr1, union tcp_addr addr2,
+		 thread_fn peer1, thread_fn peer2)
+{
+	struct sigaction sa = {
+		.sa_handler = sig_int,
+		.sa_flags = SA_RESTART,
+	};
+	time_t seed = time(NULL);
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGINT, &sa, NULL))
+		test_error("Can't set SIGINT handler");
+
+	test_family = family;
+	if (!kernel_config_has(KCONFIG_NET_NS))
+		__test_skip_all(tests_skip_reason[KCONFIG_NET_NS]);
+	if (!kernel_config_has(KCONFIG_VETH))
+		__test_skip_all(tests_skip_reason[KCONFIG_VETH]);
+	if (!kernel_config_has(KCONFIG_TCP_AO))
+		__test_skip_all(tests_skip_reason[KCONFIG_TCP_AO]);
+
+	ksft_set_plan(ntests);
+	test_print("rand seed %u", (unsigned int)seed);
+	srand(seed);
+
+
+	ksft_print_header();
+	init_namespaces();
+
+	if (add_veth(veth_name, nsfd_parent, nsfd_child))
+		test_error("Failed to add veth");
+
+	switch_ns(nsfd_child);
+	link_init(veth_name, family, prefix, addr2, addr1);
+	if (peer2) {
+		struct new_pthread_arg targ;
+		pthread_t t;
+
+		targ.my_ip = addr2;
+		targ.dest_ip = addr1;
+		targ.func = peer2;
+		nr_threads++;
+		if (pthread_create(&t, NULL, new_pthread_entry, &targ))
+			test_error("Failed to create pthread");
+	}
+	switch_ns(nsfd_parent);
+	link_init(veth_name, family, prefix, addr1, addr2);
+
+	this_ip_addr = addr1;
+	this_ip_dest = addr2;
+	peer1(NULL);
+	if (failed)
+		exit(KSFT_FAIL);
+	else
+		exit(KSFT_PASS);
+}
+
+/* /proc/sys/net/core/optmem_max artifically limits the amount of memory
+ * that can be allocated with sock_kmalloc() on each socket in the system.
+ * It is not virtualized, so it has to written outside test namespaces.
+ * To be nice a test will revert optmem back to the old value.
+ * Keeping it simple without any file lock, which means the tests that
+ * need to set/increase optmem value shouldn't run in parallel.
+ * Also, not re-entrant.
+ */
+static const char *optmem_file = "/proc/sys/net/core/optmem_max";
+static size_t saved_optmem;
+
+size_t test_get_optmem(void)
+{
+	FILE *foptmem;
+	int old_ns;
+	size_t ret;
+
+	old_ns = switch_save_ns(nsfd_outside);
+	foptmem = fopen(optmem_file, "r");
+	if (!foptmem)
+		test_error("failed to open %s", optmem_file);
+
+	if (fscanf(foptmem, "%zu", &ret) != 1)
+		test_error("can't read from %s", optmem_file);
+	fclose(foptmem);
+	switch_ns(old_ns);
+	return ret;
+}
+
+static void __test_set_optmem(size_t new, size_t *old)
+{
+	FILE *foptmem;
+	int old_ns;
+
+	if (old != NULL)
+		*old = test_get_optmem();
+
+	old_ns = switch_save_ns(nsfd_outside);
+	foptmem = fopen(optmem_file, "w");
+	if (!foptmem)
+		test_error("failed to open %s", optmem_file);
+
+	if (fprintf(foptmem, "%zu", new) <= 0)
+		test_error("can't write %zu to %s", new, optmem_file);
+	fclose(foptmem);
+	switch_ns(old_ns);
+}
+
+static void test_revert_optmem(void)
+{
+	if (saved_optmem == 0)
+		return;
+
+	__test_set_optmem(saved_optmem, NULL);
+}
+
+void test_set_optmem(size_t value)
+{
+	if (saved_optmem == 0) {
+		__test_set_optmem(value, &saved_optmem);
+		test_add_destructor(test_revert_optmem);
+	} else {
+		__test_set_optmem(value, NULL);
+	}
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
new file mode 100644
index 000000000000..7f3c31b7d997
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <alloca.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <string.h>
+#include "../../../../../include/linux/kernel.h"
+#include "../../../../../include/linux/stringify.h"
+#include "aolib.h"
+
+const unsigned int test_server_port = 7010;
+int __test_listen_socket(int backlog, void *addr, size_t addr_sz)
+{
+	int err, sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	long flags;
+
+	if (sk < 0)
+		test_error("socket()");
+
+	err = setsockopt(sk, SOL_SOCKET, SO_BINDTODEVICE, veth_name,
+			 strlen(veth_name) + 1);
+	if (err < 0)
+		test_error("setsockopt(SO_BINDTODEVICE)");
+
+	if (bind(sk, (struct sockaddr *)addr, addr_sz) < 0)
+		test_error("bind()");
+
+	flags = fcntl(sk, F_GETFL);
+	if ((flags < 0) || (fcntl(sk, F_SETFL, flags | O_NONBLOCK) < 0))
+		test_error("fcntl()");
+
+	if (listen(sk, backlog))
+		test_error("listen()");
+
+	return sk;
+}
+
+int test_wait_fd(int sk, time_t sec, bool write)
+{
+	struct timeval tv = { .tv_sec = sec };
+	struct timeval *ptv = NULL;
+	fd_set fds, efds;
+	int ret;
+	socklen_t slen = sizeof(ret);
+
+	FD_ZERO(&fds);
+	FD_SET(sk, &fds);
+	FD_ZERO(&efds);
+	FD_SET(sk, &efds);
+
+	if (sec)
+		ptv = &tv;
+
+	errno = 0;
+	if (write)
+		ret = select(sk + 1, NULL, &fds, &efds, ptv);
+	else
+		ret = select(sk + 1, &fds, NULL, &efds, ptv);
+	if (ret < 0)
+		return -errno;
+	if (ret == 0) {
+		errno = ETIMEDOUT;
+		return -ETIMEDOUT;
+	}
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &ret, &slen) || ret)
+		return -ret;
+	return 0;
+}
+
+int __test_connect_socket(int sk, const char *device,
+			  void *addr, size_t addr_sz, time_t timeout)
+{
+	long flags;
+	int err;
+
+	if (device != NULL) {
+		err = setsockopt(sk, SOL_SOCKET, SO_BINDTODEVICE, device,
+				 strlen(device) + 1);
+		if (err < 0)
+			test_error("setsockopt(SO_BINDTODEVICE, %s)", device);
+	}
+
+	if (!timeout) {
+		err = connect(sk, addr, addr_sz);
+		if (err) {
+			err = -errno;
+			goto out;
+		}
+		return 0;
+	}
+
+	flags = fcntl(sk, F_GETFL);
+	if ((flags < 0) || (fcntl(sk, F_SETFL, flags | O_NONBLOCK) < 0))
+		test_error("fcntl()");
+
+	if (connect(sk, addr, addr_sz) < 0) {
+		if (errno != EINPROGRESS) {
+			err = -errno;
+			goto out;
+		}
+		if (timeout < 0)
+			return sk;
+		err = test_wait_fd(sk, timeout, 1);
+		if (err)
+			goto out;
+	}
+	return sk;
+
+out:
+	close(sk);
+	return err;
+}
+
+int __test_set_md5(int sk, void *addr, size_t addr_sz, uint8_t prefix,
+		   int vrf, const char *password)
+{
+	size_t pwd_len = strlen(password);
+	struct tcp_md5sig md5sig = {};
+
+	md5sig.tcpm_keylen = pwd_len;
+	memcpy(md5sig.tcpm_key, password, pwd_len);
+	md5sig.tcpm_flags = TCP_MD5SIG_FLAG_PREFIX;
+	md5sig.tcpm_prefixlen = prefix;
+	if (vrf >= 0) {
+		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_IFINDEX;
+		md5sig.tcpm_ifindex = (uint8_t)vrf;
+	}
+	memcpy(&md5sig.tcpm_addr, addr, addr_sz);
+
+	errno = 0;
+	return setsockopt(sk, IPPROTO_TCP, TCP_MD5SIG_EXT,
+			&md5sig, sizeof(md5sig));
+}
+
+
+int test_prepare_key_sockaddr(struct tcp_ao_add *ao, const char *alg,
+		void *addr, size_t addr_sz, bool set_current, bool set_rnext,
+		uint8_t prefix, uint8_t vrf, uint8_t sndid, uint8_t rcvid,
+		uint8_t maclen, uint8_t keyflags,
+		uint8_t keylen, const char *key)
+{
+	memset(ao, 0, sizeof(struct tcp_ao_add));
+
+	ao->set_current	= !!set_current;
+	ao->set_rnext	= !!set_rnext;
+	ao->prefix	= prefix;
+	ao->sndid	= sndid;
+	ao->rcvid	= rcvid;
+	ao->maclen	= maclen;
+	ao->keyflags	= keyflags;
+	ao->keylen	= keylen;
+	ao->ifindex	= vrf;
+
+	memcpy(&ao->addr, addr, addr_sz);
+
+	if (strlen(alg) > 64)
+		return -ENOBUFS;
+	strncpy(ao->alg_name, alg, 64);
+
+	memcpy(ao->key, key,
+	       (keylen > TCP_AO_MAXKEYLEN) ? TCP_AO_MAXKEYLEN : keylen);
+	return 0;
+}
+
+static int test_get_ao_keys_nr(int sk)
+{
+	struct tcp_ao_getsockopt tmp = {};
+	socklen_t tmp_sz = sizeof(tmp);
+	int ret;
+
+	tmp.nkeys  = 1;
+	tmp.get_all = 1;
+
+	ret = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &tmp, &tmp_sz);
+	if (ret)
+		return -errno;
+	return (int)tmp.nkeys;
+}
+
+int test_get_one_ao(int sk, struct tcp_ao_getsockopt *out,
+		void *addr, size_t addr_sz, uint8_t prefix,
+		uint8_t sndid, uint8_t rcvid)
+{
+	struct tcp_ao_getsockopt tmp = {};
+	socklen_t tmp_sz = sizeof(tmp);
+	int ret;
+
+	memcpy(&tmp.addr, addr, addr_sz);
+	tmp.prefix = prefix;
+	tmp.sndid  = sndid;
+	tmp.rcvid  = rcvid;
+	tmp.nkeys  = 1;
+
+	ret = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &tmp, &tmp_sz);
+	if (ret)
+		return ret;
+	if (tmp.nkeys != 1)
+		return -E2BIG;
+	*out = tmp;
+	return 0;
+}
+
+int test_get_ao_info(int sk, struct tcp_ao_info_opt *out)
+{
+	socklen_t sz = sizeof(*out);
+
+	out->reserved = 0;
+	out->reserved2 = 0;
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, out, &sz))
+		return -errno;
+	if (sz != sizeof(*out))
+		return -EMSGSIZE;
+	return 0;
+}
+
+int test_set_ao_info(int sk, struct tcp_ao_info_opt *in)
+{
+	socklen_t sz = sizeof(*in);
+
+	in->reserved = 0;
+	in->reserved2 = 0;
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, in, sz))
+		return -errno;
+	return 0;
+}
+
+int test_cmp_getsockopt_setsockopt(const struct tcp_ao_add *a,
+				   const struct tcp_ao_getsockopt *b)
+{
+	bool is_kdf_aes_128_cmac = false;
+	bool is_cmac_aes = false;
+
+	if (!strcmp("cmac(aes128)", a->alg_name)) {
+		is_kdf_aes_128_cmac = (a->keylen != 16);
+		is_cmac_aes = true;
+	}
+
+#define __cmp_ao(member)						\
+do {									\
+	if (b->member != a->member) {					\
+		test_fail("getsockopt(): " __stringify(member) " %u != %u",	\
+				b->member, a->member);			\
+		return -1;						\
+	}								\
+} while(0)
+	__cmp_ao(sndid);
+	__cmp_ao(rcvid);
+	__cmp_ao(prefix);
+	__cmp_ao(keyflags);
+	__cmp_ao(ifindex);
+	if (a->maclen) {
+		__cmp_ao(maclen);
+	} else if (b->maclen != 12) {
+		test_fail("getsockopt(): expected default maclen 12, but it's %u",
+				b->maclen);
+		return -1;
+	}
+	if (!is_kdf_aes_128_cmac) {
+		__cmp_ao(keylen);
+	} else if (b->keylen != 16) {
+		test_fail("getsockopt(): expected keylen 16 for cmac(aes128), but it's %u",
+				b->keylen);
+		return -1;
+	}
+#undef __cmp_ao
+	if (!is_kdf_aes_128_cmac && memcmp(b->key, a->key, a->keylen)) {
+		test_fail("getsockopt(): returned key is different `%s' != `%s'",
+				b->key, a->key);
+		return -1;
+	}
+	if (memcmp(&b->addr, &a->addr, sizeof(b->addr))) {
+		test_fail("getsockopt(): returned address is different");
+		return -1;
+	}
+	if (!is_cmac_aes && strcmp(b->alg_name, a->alg_name)) {
+		test_fail("getsockopt(): returned algorithm %s is different than %s", b->alg_name, a->alg_name);
+		return -1;
+	}
+	if (is_cmac_aes && strcmp(b->alg_name, "cmac(aes)")) {
+		test_fail("getsockopt(): returned algorithm %s is different than cmac(aes)", b->alg_name);
+		return -1;
+	}
+	/* For a established key rotation test don't add a key with
+	 * set_current = 1, as it's likely to change by peer's request;
+	 * rather use setsockopt(TCP_AO_INFO)
+	 */
+	if (a->set_current != b->is_current) {
+		test_fail("getsockopt(): returned key is not Current_key");
+		return -1;
+	}
+	if (a->set_rnext != b->is_rnext) {
+		test_fail("getsockopt(): returned key is not RNext_key");
+		return -1;
+	}
+
+	return 0;
+}
+
+int test_cmp_getsockopt_setsockopt_ao(const struct tcp_ao_info_opt *a,
+				      const struct tcp_ao_info_opt *b)
+{
+	/* No check for ::current_key, as it may change by the peer */
+	if (a->ao_required != b->ao_required) {
+		test_fail("getsockopt(): returned ao doesn't have ao_required");
+		return -1;
+	}
+	if (a->accept_icmps != b->accept_icmps) {
+		test_fail("getsockopt(): returned ao doesn't accept ICMPs");
+		return -1;
+	}
+	if (a->set_rnext && a->rnext != b->rnext) {
+		test_fail("getsockopt(): RNext KeyID has changed");
+		return -1;
+	}
+#define __cmp_cnt(member)						\
+do {									\
+	if (b->member != a->member) {					\
+		test_fail("getsockopt(): " __stringify(member) " %llu != %llu",	\
+				b->member, a->member);			\
+		return -1;						\
+	}								\
+} while(0)
+	if (a->set_counters) {
+		__cmp_cnt(pkt_good);
+		__cmp_cnt(pkt_bad);
+		__cmp_cnt(pkt_key_not_found);
+		__cmp_cnt(pkt_ao_required);
+		__cmp_cnt(pkt_dropped_icmp);
+	}
+#undef __cmp_cnt
+	return 0;
+}
+
+int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
+{
+	struct tcp_ao_getsockopt *key_dump;
+	socklen_t key_dump_sz = sizeof(*key_dump);
+	struct tcp_ao_info_opt info = {};
+	bool c1, c2, c3, c4, c5;
+	struct netstat *ns;
+	int err, nr_keys;
+
+	memset(out, 0, sizeof(*out));
+
+	/* per-netns */
+	ns = netstat_read();
+	out->netns_ao_good = netstat_get(ns, "TCPAOGood", &c1);
+	out->netns_ao_bad = netstat_get(ns, "TCPAOBad", &c2);
+	out->netns_ao_key_not_found = netstat_get(ns, "TCPAOKeyNotFound", &c3);
+	out->netns_ao_required = netstat_get(ns, "TCPAORequired", &c4);
+	out->netns_ao_dropped_icmp = netstat_get(ns, "TCPAODroppedIcmps", &c5);
+	netstat_free(ns);
+	if (c1 || c2 || c3 || c4 || c5)
+		return -EOPNOTSUPP;
+
+	err = test_get_ao_info(sk, &info);
+	if (err)
+		return err;
+
+	/* per-socket */
+	out->ao_info_pkt_good		= info.pkt_good;
+	out->ao_info_pkt_bad		= info.pkt_bad;
+	out->ao_info_pkt_key_not_found	= info.pkt_key_not_found;
+	out->ao_info_pkt_ao_required	= info.pkt_ao_required;
+	out->ao_info_pkt_dropped_icmp	= info.pkt_dropped_icmp;
+
+	/* per-key */
+	nr_keys = test_get_ao_keys_nr(sk);
+	if (nr_keys < 0)
+		return nr_keys;
+	if (nr_keys == 0)
+		test_error("test_get_ao_keys_nr() == 0");
+	out->nr_keys = (size_t)nr_keys;
+	key_dump = calloc(nr_keys, key_dump_sz);
+	if (!key_dump)
+		return -errno;
+
+	key_dump[0].nkeys = nr_keys;
+	key_dump[0].get_all = 1;
+	key_dump[0].get_all = 1;
+	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
+			 key_dump, &key_dump_sz);
+	if (err) {
+		free(key_dump);
+		return -errno;
+	}
+
+	out->key_cnts = calloc(nr_keys, sizeof(out->key_cnts[0]));
+	if (!out->key_cnts) {
+		free(key_dump);
+		return -errno;
+	}
+
+	while (nr_keys--) {
+		out->key_cnts[nr_keys].sndid = key_dump[nr_keys].sndid;
+		out->key_cnts[nr_keys].rcvid = key_dump[nr_keys].rcvid;
+		out->key_cnts[nr_keys].pkt_good = key_dump[nr_keys].pkt_good;
+		out->key_cnts[nr_keys].pkt_bad = key_dump[nr_keys].pkt_bad;
+	}
+	free(key_dump);
+
+	return 0;
+}
+
+int __test_tcp_ao_counters_cmp(const char *tst_name,
+			       struct tcp_ao_counters *before,
+			       struct tcp_ao_counters *after,
+			       test_cnt expected)
+{
+#define __cmp_ao(cnt, expecting_inc)					\
+do {									\
+	if (before->cnt > after->cnt) {					\
+		test_fail("%s: Decreased counter " __stringify(cnt) " %" PRIu64 " > %" PRIu64, \
+			  tst_name ?: "", before->cnt, after->cnt);		\
+		return -1;						\
+	}								\
+	if ((before->cnt != after->cnt) != (expecting_inc)) {		\
+		test_fail("%s: Counter " __stringify(cnt) " was %sexpected to increase %" PRIu64 " => %" PRIu64, \
+			  tst_name ?: "", (expecting_inc) ? "" : "not ",	\
+			  before->cnt, after->cnt);			\
+		return -1;						\
+	}								\
+} while(0)
+
+	errno = 0;
+	/* per-netns */
+	__cmp_ao(netns_ao_good, !!(expected & TEST_CNT_NS_GOOD));
+	__cmp_ao(netns_ao_bad, !!(expected & TEST_CNT_NS_BAD));
+	__cmp_ao(netns_ao_key_not_found,
+		 !!(expected & TEST_CNT_NS_KEY_NOT_FOUND));
+	__cmp_ao(netns_ao_required, !!(expected & TEST_CNT_NS_AO_REQUIRED));
+	__cmp_ao(netns_ao_dropped_icmp,
+		 !!(expected & TEST_CNT_NS_DROPPED_ICMP));
+	/* per-socket */
+	__cmp_ao(ao_info_pkt_good, !!(expected & TEST_CNT_SOCK_GOOD));
+	__cmp_ao(ao_info_pkt_bad, !!(expected & TEST_CNT_SOCK_BAD));
+	__cmp_ao(ao_info_pkt_key_not_found,
+		 !!(expected & TEST_CNT_SOCK_KEY_NOT_FOUND));
+	__cmp_ao(ao_info_pkt_ao_required, !!(expected & TEST_CNT_SOCK_AO_REQUIRED));
+	__cmp_ao(ao_info_pkt_dropped_icmp,
+		 !!(expected & TEST_CNT_SOCK_DROPPED_ICMP));
+	return 0;
+#undef __cmp_ao
+}
+
+int test_tcp_ao_key_counters_cmp(const char *tst_name,
+				 struct tcp_ao_counters *before,
+				 struct tcp_ao_counters *after,
+				 test_cnt expected,
+				 int sndid, int rcvid)
+{
+	size_t i;
+#define __cmp_ao(i, cnt, expecting_inc)					\
+do {									\
+	if (before->key_cnts[i].cnt > after->key_cnts[i].cnt) {		\
+		test_fail("%s: Decreased counter " __stringify(cnt) " %" PRIu64 " > %" PRIu64 " for key %u:%u", \
+			  tst_name ?: "", before->key_cnts[i].cnt,	\
+			  after->key_cnts[i].cnt,			\
+			  before->key_cnts[i].sndid,			\
+			  before->key_cnts[i].rcvid);			\
+		return -1;						\
+	}								\
+	if ((before->key_cnts[i].cnt != after->key_cnts[i].cnt) != (expecting_inc)) {		\
+		test_fail("%s: Counter " __stringify(cnt) " was %sexpected to increase %" PRIu64 " => %" PRIu64 " for key %u:%u", \
+			  tst_name ?: "", (expecting_inc) ? "" : "not ",\
+			  before->key_cnts[i].cnt,			\
+			  after->key_cnts[i].cnt,			\
+			  before->key_cnts[i].sndid,			\
+			  before->key_cnts[i].rcvid);			\
+		return -1;						\
+	}								\
+} while(0)
+
+	if (before->nr_keys != after->nr_keys) {
+		test_fail("%s: Keys changed on the socket %zu != %zu",
+			  tst_name, before->nr_keys, after->nr_keys);
+		return -1;
+	}
+
+	/* per-key */
+	i = before->nr_keys;
+	while (i--) {
+		if (sndid >= 0 && before->key_cnts[i].sndid != sndid)
+			continue;
+		if (rcvid >= 0 && before->key_cnts[i].rcvid != rcvid)
+			continue;
+		__cmp_ao(i, pkt_good, !!(expected & TEST_CNT_KEY_GOOD));
+		__cmp_ao(i, pkt_bad, !!(expected & TEST_CNT_KEY_BAD));
+	}
+	return 0;
+#undef __cmp_ao
+}
+
+void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts)
+{
+	free(cnts->key_cnts);
+}
+
+#define TEST_BUF_SIZE 4096
+ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
+{
+	ssize_t total = 0;
+
+	do {
+		char buf[TEST_BUF_SIZE];
+		ssize_t bytes, sent;
+		int ret;
+
+		ret = test_wait_fd(sk, timeout_sec, 0);
+		if (ret)
+			return ret;
+
+		bytes = recv(sk, buf, sizeof(buf), 0);
+
+		if (bytes < 0)
+			test_error("recv(): %zd", bytes);
+		if (bytes == 0)
+			break;
+
+		ret = test_wait_fd(sk, timeout_sec, 1);
+		if (ret)
+			return ret;
+
+		sent = send(sk, buf, bytes, 0);
+		if (sent == 0)
+			break;
+		if (sent != bytes)
+			test_error("send()");
+		total += bytes;
+	} while (!quota || total < quota);
+
+	return total;
+}
+
+ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
+			 const size_t msg_len, time_t timeout_sec)
+{
+	char msg[msg_len];
+	int nodelay = 1;
+	size_t i;
+
+	if (setsockopt(sk, IPPROTO_TCP, TCP_NODELAY, &nodelay, sizeof(nodelay)))
+		test_error("setsockopt(TCP_NODELAY)");
+
+	for (i = 0; i < buf_sz; i += min(msg_len, buf_sz - i)) {
+		size_t sent, bytes = min(msg_len, buf_sz - i);
+		int ret;
+
+		ret = test_wait_fd(sk, timeout_sec, 1);
+		if (ret)
+			return ret;
+
+		sent = send(sk, buf + i, bytes, 0);
+		if (sent == 0)
+			break;
+		if (sent != bytes)
+			test_error("send()");
+
+		bytes = 0;
+		do {
+			ssize_t got;
+
+			ret = test_wait_fd(sk, timeout_sec, 0);
+			if (ret)
+				return ret;
+
+			got = recv(sk, msg + bytes, sizeof(msg) - bytes, 0);
+			if (got <= 0)
+				test_error("recv(): %zd", got);
+			bytes += got;
+		} while (bytes < sent);
+		if (bytes > sent)
+			test_error("recv(): %zd > %zd", bytes, sent);
+		if (memcmp(buf + i, msg, bytes) != 0) {
+			test_fail("received message differs");
+			return -1;
+		}
+	}
+	return i;
+}
+
+int test_client_verify(int sk, const size_t msg_len, const size_t nr,
+		       time_t timeout_sec)
+{
+	size_t buf_sz = msg_len * nr;
+	char *buf = alloca(buf_sz);
+
+	randomize_buffer(buf, buf_sz);
+	if (test_client_loop(sk, buf, buf_sz, msg_len, timeout_sec) != buf_sz)
+		return -1;
+	return 0;
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/utils.c b/tools/testing/selftests/net/tcp_ao/lib/utils.c
new file mode 100644
index 000000000000..372daca525f5
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/utils.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "aolib.h"
+#include <string.h>
+
+void randomize_buffer(void *buf, size_t buflen)
+{
+	int *p = (int *)buf;
+	size_t words = buflen / sizeof(int);
+	size_t leftover = buflen % sizeof(int);
+
+	if (!buflen)
+		return;
+
+	while (words--)
+		*p++ = rand();
+
+	if (leftover) {
+		int tmp = rand();
+
+		memcpy(buf + buflen - leftover, &tmp, leftover);
+	}
+}
+
+const struct sockaddr_in6 addr_any6 = {
+	.sin6_family	= AF_INET6,
+};
+
+const struct sockaddr_in addr_any4 = {
+	.sin_family	= AF_INET,
+};

-- 
2.43.0


