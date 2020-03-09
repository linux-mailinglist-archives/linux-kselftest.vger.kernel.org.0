Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6138517DE63
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 12:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgCILNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 07:13:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55140 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCILNa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so5347752wmc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Mar 2020 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfIbQ9egZOgHYEi4ZCtd5fcolR6Q2j1G5CwpXRfW+tU=;
        b=KEx0ardFKYz7mGkN7NWnfSDkRafDapDG2sLJYkCv+JC2SBmTcFSiYizOTPYGLtPwGg
         bKeyCtwHIy/Z7AkMcCWM04z37PJvzgsnFbsqJ/0sbqLj3L0uzjmytRUSdSQqpfcLzzXg
         HsIKE38qf+XFkSf2BiB2MbBviHa0n40VfdxG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfIbQ9egZOgHYEi4ZCtd5fcolR6Q2j1G5CwpXRfW+tU=;
        b=SvPxdIhniiZgCtLYVNlD/QVhuJZVF7EH6S9q9afry3gu43+wYsRG9y35welEjAvBzN
         GMEsxMRAp//EgG0J+CbC2+XtWldU0QFdYh14QXYpYE9CF5wg6mXZruIAxOhVbZ7Ef06L
         zDPfkDmYH5TrRrZsg5OBRLsVxSd2U4Pi4XO3oBSVOrSr6nCvXh8mSfWUmPSkEToGYE0T
         0tpPQEBlOreU4ftyjAxFZhm01tJowfKTtGG2sxOdA84GY1694ciXXiFVuCxHKesIJZcz
         sot670u99CGMLiR/NADH66Rq42sVBmEuq03iEptA0rHc9tLDEulQv63Svpt+zqgQBrAS
         gF0g==
X-Gm-Message-State: ANhLgQ06RDzfHGbZWIotZWIdQitEfYGAARzvDhp+9VaDCwLQCpNlExrD
        VVyp7bHgq86vEuCY0todfBZuGFsYatf2IQ==
X-Google-Smtp-Source: ADFU+vuRfiz5krPEg4BZ5r6jV4YZnMKnig5RI9m5gj5KCO1aBqQF6rqXdPIJcLzJwmHHi1znJBAZHw==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr6140449wme.125.1583752406466;
        Mon, 09 Mar 2020 04:13:26 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:25 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 10/12] selftests: bpf: add tests for UDP sockets in sockmap
Date:   Mon,  9 Mar 2020 11:12:41 +0000
Message-Id: <20200309111243.6982-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expand the TCP sockmap test suite to also check UDP sockets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 157 ++++++++++++++----
 1 file changed, 127 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ba41dd26d6b..52aa468bdccd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -108,6 +108,22 @@
 		__ret;                                                         \
 	})
 
+#define xsend(fd, buf, len, flags)                                             \
+	({                                                                     \
+		ssize_t __ret = send((fd), (buf), (len), (flags));             \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("send");                                    \
+		__ret;                                                         \
+	})
+
+#define xrecv(fd, buf, len, flags)                                             \
+	({                                                                     \
+		ssize_t __ret = recv((fd), (buf), (len), (flags));             \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("recv");                                    \
+		__ret;                                                         \
+	})
+
 #define xsocket(family, sotype, flags)                                         \
 	({                                                                     \
 		int __ret = socket(family, sotype, flags);                     \
@@ -330,7 +346,7 @@ static void test_insert_bound(int family, int sotype, int mapfd)
 	xclose(s);
 }
 
-static void test_insert_listening(int family, int sotype, int mapfd)
+static void test_insert(int family, int sotype, int mapfd)
 {
 	u64 value;
 	u32 key;
@@ -467,7 +483,7 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
 	xclose(s);
 }
 
-static void test_update_listening(int family, int sotype, int mapfd)
+static void test_update_existing(int family, int sotype, int mapfd)
 {
 	int s1, s2;
 	u64 value;
@@ -1116,7 +1132,7 @@ static void test_reuseport_select_listening(int family, int sotype,
 {
 	struct sockaddr_storage addr;
 	unsigned int pass;
-	int s, c, p, err;
+	int s, c, err;
 	socklen_t len;
 	u64 value;
 	u32 key;
@@ -1145,19 +1161,33 @@ static void test_reuseport_select_listening(int family, int sotype,
 	if (err)
 		goto close_cli;
 
-	p = xaccept(s, NULL, NULL);
-	if (p < 0)
-		goto close_cli;
+	if (sotype == SOCK_STREAM) {
+		int p;
+
+		p = xaccept(s, NULL, NULL);
+		if (p < 0)
+			goto close_cli;
+		xclose(p);
+	} else {
+		char b = 'a';
+		ssize_t n;
+
+		n = xsend(c, &b, sizeof(b), 0);
+		if (n == -1)
+			goto close_cli;
+
+		n = xrecv(s, &b, sizeof(b), 0);
+		if (n == -1)
+			goto close_cli;
+	}
 
 	key = SK_PASS;
 	err = xbpf_map_lookup_elem(verd_map, &key, &pass);
 	if (err)
-		goto close_peer;
+		goto close_cli;
 	if (pass != 1)
 		FAIL("want pass count 1, have %d", pass);
 
-close_peer:
-	xclose(p);
 close_cli:
 	xclose(c);
 close_srv:
@@ -1201,9 +1231,24 @@ static void test_reuseport_select_connected(int family, int sotype,
 	if (err)
 		goto close_cli0;
 
-	p0 = xaccept(s, NULL, NULL);
-	if (err)
-		goto close_cli0;
+	if (sotype == SOCK_STREAM) {
+		p0 = xaccept(s, NULL, NULL);
+		if (p0 < 0)
+			goto close_cli0;
+	} else {
+		p0 = xsocket(family, sotype, 0);
+		if (p0 < 0)
+			goto close_cli0;
+
+		len = sizeof(addr);
+		err = xgetsockname(c0, sockaddr(&addr), &len);
+		if (err)
+			goto close_cli0;
+
+		err = xconnect(p0, sockaddr(&addr), len);
+		if (err)
+			goto close_cli0;
+	}
 
 	/* Update sock_map[0] to redirect to a connected socket */
 	key = 0;
@@ -1216,8 +1261,24 @@ static void test_reuseport_select_connected(int family, int sotype,
 	if (c1 < 0)
 		goto close_peer0;
 
+	len = sizeof(addr);
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		goto close_srv;
+
 	errno = 0;
 	err = connect(c1, sockaddr(&addr), len);
+	if (sotype == SOCK_DGRAM) {
+		char b = 'a';
+		ssize_t n;
+
+		n = xsend(c1, &b, sizeof(b), 0);
+		if (n == -1)
+			goto close_cli1;
+
+		n = recv(c1, &b, sizeof(b), 0);
+		err = n == -1;
+	}
 	if (!err || errno != ECONNREFUSED)
 		FAIL_ERRNO("connect: expected ECONNREFUSED");
 
@@ -1281,7 +1342,18 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 		goto close_srv2;
 
 	err = connect(c, sockaddr(&addr), len);
-	if (err && errno != ECONNREFUSED) {
+	if (sotype == SOCK_DGRAM) {
+		char b = 'a';
+		ssize_t n;
+
+		n = xsend(c, &b, sizeof(b), 0);
+		if (n == -1)
+			goto close_cli;
+
+		n = recv(c, &b, sizeof(b), 0);
+		err = n == -1;
+	}
+	if (!err || errno != ECONNREFUSED) {
 		FAIL_ERRNO("connect: expected ECONNREFUSED");
 		goto close_cli;
 	}
@@ -1302,9 +1374,9 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 	xclose(s1);
 }
 
-#define TEST(fn)                                                               \
+#define TEST(fn, ...)                                                          \
 	{                                                                      \
-		fn, #fn                                                        \
+		fn, #fn, __VA_ARGS__                                           \
 	}
 
 static void test_ops_cleanup(const struct bpf_map *map)
@@ -1353,18 +1425,31 @@ static const char *map_type_str(const struct bpf_map *map)
 	}
 }
 
+static const char *sotype_str(int sotype)
+{
+	switch (sotype) {
+	case SOCK_DGRAM:
+		return "UDP";
+	case SOCK_STREAM:
+		return "TCP";
+	default:
+		return "unknown";
+	}
+}
+
 static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		     int family, int sotype)
 {
 	const struct op_test {
 		void (*fn)(int family, int sotype, int mapfd);
 		const char *name;
+		int sotype;
 	} tests[] = {
 		/* insert */
 		TEST(test_insert_invalid),
 		TEST(test_insert_opened),
-		TEST(test_insert_bound),
-		TEST(test_insert_listening),
+		TEST(test_insert_bound, SOCK_STREAM),
+		TEST(test_insert),
 		/* delete */
 		TEST(test_delete_after_insert),
 		TEST(test_delete_after_close),
@@ -1373,28 +1458,32 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		TEST(test_lookup_after_delete),
 		TEST(test_lookup_32_bit_value),
 		/* update */
-		TEST(test_update_listening),
+		TEST(test_update_existing),
 		/* races with insert/delete */
-		TEST(test_destroy_orphan_child),
-		TEST(test_syn_recv_insert_delete),
-		TEST(test_race_insert_listen),
+		TEST(test_destroy_orphan_child, SOCK_STREAM),
+		TEST(test_syn_recv_insert_delete, SOCK_STREAM),
+		TEST(test_race_insert_listen, SOCK_STREAM),
 		/* child clone */
-		TEST(test_clone_after_delete),
-		TEST(test_accept_after_delete),
-		TEST(test_accept_before_delete),
+		TEST(test_clone_after_delete, SOCK_STREAM),
+		TEST(test_accept_after_delete, SOCK_STREAM),
+		TEST(test_accept_before_delete, SOCK_STREAM),
 	};
-	const char *family_name, *map_name;
+	const char *family_name, *map_name, *sotype_name;
 	const struct op_test *t;
 	char s[MAX_TEST_NAME];
 	int map_fd;
 
 	family_name = family_str(family);
 	map_name = map_type_str(map);
+	sotype_name = sotype_str(sotype);
 	map_fd = bpf_map__fd(map);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
-			 t->name);
+		snprintf(s, sizeof(s), "%s %s %s %s", map_name, family_name,
+			 sotype_name, t->name);
+
+		if (t->sotype != 0 && t->sotype != sotype)
+			continue;
 
 		if (!test__start_subtest(s))
 			continue;
@@ -1427,6 +1516,7 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
 			 t->name);
+
 		if (!test__start_subtest(s))
 			continue;
 
@@ -1441,26 +1531,31 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 		void (*fn)(int family, int sotype, int socket_map,
 			   int verdict_map, int reuseport_prog);
 		const char *name;
+		int sotype;
 	} tests[] = {
 		TEST(test_reuseport_select_listening),
 		TEST(test_reuseport_select_connected),
 		TEST(test_reuseport_mixed_groups),
 	};
 	int socket_map, verdict_map, reuseport_prog;
-	const char *family_name, *map_name;
+	const char *family_name, *map_name, *sotype_name;
 	const struct reuseport_test *t;
 	char s[MAX_TEST_NAME];
 
 	family_name = family_str(family);
 	map_name = map_type_str(map);
+	sotype_name = sotype_str(sotype);
 
 	socket_map = bpf_map__fd(map);
 	verdict_map = bpf_map__fd(skel->maps.verdict_map);
 	reuseport_prog = bpf_program__fd(skel->progs.prog_reuseport);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
-			 t->name);
+		snprintf(s, sizeof(s), "%s %s %s %s", map_name, family_name,
+			 sotype_name, t->name);
+
+		if (t->sotype != 0 && t->sotype != sotype)
+			continue;
 
 		if (!test__start_subtest(s))
 			continue;
@@ -1473,8 +1568,10 @@ static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
 	test_ops(skel, map, family, SOCK_STREAM);
+	test_ops(skel, map, family, SOCK_DGRAM);
 	test_redir(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_STREAM);
+	test_reuseport(skel, map, family, SOCK_DGRAM);
 }
 
 void test_sockmap_listen(void)
-- 
2.20.1

