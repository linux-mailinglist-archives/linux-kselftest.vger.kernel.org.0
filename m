Return-Path: <linux-kselftest+bounces-9088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE58B64D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86739B20DBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE64194C61;
	Mon, 29 Apr 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9ItVGn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5191836F9
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427147; cv=none; b=sr2Rar/96rHd4lpHqDUcB9/cz9FXWg9wygn78/d0clfh9SvTWSG7gWj4PVa8Cchx4/jG3eg60RqRim6vOktX4LdxdpLgo8ewgZgs2dTYP/2/T49dJFAFQhksx1lpL0SGotA8HsEY1f08nVAcbNdGw5POIjFmpokSZVbblCD00B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427147; c=relaxed/simple;
	bh=NqpBD//J6M3z9RZHdyWOHyC0ckGPi+WDWe09y+L55/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFTrWU1XK6r0gJ4OCI8GJjIs2MAOU2qjcb0Hjdfv1Nu7Y5OYw/cfQ1oigLfesxHiHX2y5tMsbagyZ2r9s2C9BeNMQj/LalAnl+kIJUvJOkF47806gL0DdqcsFtSklw0GZJopw48MnkMVSbHcrTGFz21fHxB0fWu+9Lb4lMgoJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9ItVGn6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so104344637b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427145; x=1715031945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7gTk9IPVFIWP3bNZ688SstLyKeUxnKEv25aOhTiAoo=;
        b=t9ItVGn60BAJuexXAHins+IbDCejlkAnaMDSqQl7htpo36v5FH6aDK0c/PsJGoh7+L
         Tmdje8/kmRYh57pnLnqOdmt1ZrB0mELwoiOvtHce8mwtIIIZA4xOb/IBCuTYRvJfn5YU
         e9W29DVIQnff8pIKT6MMD8ROsw9+Fe/CrUMSUBfvSF7y+qmOMOVd2Mm/9XGsH3PVe7CU
         cirdHvJvecz3DLjmKquLgVYWHLeT4doAUkUwit47Zb3u2UtumRZPzdlCylEYdqsG19sm
         x8izkPVtQ87n/WIiVyuhwjLPiNLRT3BQ29/IMeR+NNz8Ju/1YNOckFATpsSs31/XqkMH
         tAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427145; x=1715031945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7gTk9IPVFIWP3bNZ688SstLyKeUxnKEv25aOhTiAoo=;
        b=Qyx8kPp7evNlFxFtX0jf8MwPUJsoDM0x78tkHredcD4VnLvkyPz9gfqZGUbUzF8NvJ
         quIs9v+U9FJKiUHNzGHVy7Uv0gl5COAlkbQ1Ttru17Lss4UFfl5WQzdLZYRAQRGiNH4R
         XVLnDXduhHGmxlIhHrylqsxekkwrdAk0cXq0hfD7bKv30mkLollqsnDmOwq8qAx3mP7o
         wEgZj5TrSNmuGGboWuZdXbROjwnv5XqWL5F++IhKyy+QjOwGQAcejYXm4HPxWXqK7A7M
         NSYZRtsDpXIBUXBLwZ2UsvhneMDfaTh0KjwD+duhVLUBfkvHKtSekEDVfTNTai92lHn8
         qB+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZXIqVGBk+kuU+TMHLoQw3PTCsUGBYgckbamsN54O56noiWf6hTe2FjiBRNnK1OguQ+dCiBbtuigyYe0KnfEaykZty4XO2KiJckBymJRdU
X-Gm-Message-State: AOJu0YyvIkst0hUVm+QXBJ9SnlSzs5KIa49VBjoMIVVnet8aS6dFw0Kq
	w2iyh+G61H7JMmlGr2zG6DrVXMM4XB0Yq8QlgfnUyTBrZYNpw2yYz9AASn3KpBGJccxG3cyJcQ=
	=
X-Google-Smtp-Source: AGHT+IHqKmkAftA+KODzpoWitl475T9IlhfJTudbilWYl3yZA5Aa2dvl5WroN3aXOP5Yzq9wuMMkFekF9A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:a18f:0:b0:61b:e6d8:1c01 with SMTP id
 y137-20020a81a18f000000b0061be6d81c01mr216389ywg.10.1714427145116; Mon, 29
 Apr 2024 14:45:45 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:22 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-6-jrife@google.com>
Subject: [PATCH v3 bpf-next 5/6] selftests/bpf: Make sock configurable for
 each test case
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

In order to reuse the same test code for both socket system calls (e.g.
connect(), bind(), etc.) and kernel socket functions (e.g.
kernel_connect(), kernel_bind(), etc.), this patch introduces the "ops"
field to sock_addr_test. This field allows each test cases to configure
the set of functions used in the test case to create, manipulate, and
tear down a socket.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 140 ++++++++++++------
 1 file changed, 98 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index f3ab154c869b6..f51ba97065f74 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -54,12 +54,64 @@ enum sock_addr_test_type {
 typedef void *(*load_fn)(int cgroup_fd);
 typedef void (*destroy_fn)(void *skel);
 
+struct sock_ops {
+	int (*connect_to_addr)(int type, const struct sockaddr_storage *addr,
+			       socklen_t addrlen,
+			       const struct network_helper_opts *opts);
+	int (*start_server)(int family, int type, const char *addr_str,
+			    __u16 port, int timeout_ms);
+	int (*socket)(int famil, int type, int protocol);
+	int (*bind)(int fd, struct sockaddr *addr, socklen_t addrlen);
+	int (*getsockname)(int fd, struct sockaddr *addr, socklen_t *addrlen);
+	int (*getpeername)(int fd, struct sockaddr *addr, socklen_t *addrlen);
+	int (*sendmsg)(int fd, struct sockaddr *addr, socklen_t addrlen,
+		       char *msg, int msglen);
+	int (*close)(int fd);
+};
+
+static int user_sendmsg(int fd, struct sockaddr *addr, socklen_t addrlen,
+			char *msg, int msglen)
+{
+	struct msghdr hdr;
+	struct iovec iov;
+
+	memset(&iov, 0, sizeof(iov));
+	iov.iov_base = msg;
+	iov.iov_len = msglen;
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.msg_name = (void *)addr;
+	hdr.msg_namelen = addrlen;
+	hdr.msg_iov = &iov;
+	hdr.msg_iovlen = 1;
+
+	return sendmsg(fd, &hdr, 0);
+}
+
+static int user_bind(int fd, struct sockaddr *addr, socklen_t addrlen)
+{
+	return bind(fd, (const struct sockaddr *)addr, addrlen);
+}
+
+struct sock_ops user_ops = {
+	.connect_to_addr = connect_to_addr,
+	.start_server = start_server,
+	.socket = socket,
+	.bind = user_bind,
+	.getsockname = getsockname,
+	.getpeername = getpeername,
+	.sendmsg = user_sendmsg,
+	.close = close,
+};
+
 struct sock_addr_test {
 	enum sock_addr_test_type type;
 	const char *name;
 	/* BPF prog properties */
 	load_fn loadfn;
 	destroy_fn destroyfn;
+	/* Socket operations */
+	struct sock_ops *ops;
 	/* Socket properties */
 	int socket_family;
 	int socket_type;
@@ -113,6 +165,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (stream)",
 		bind4_prog_load,
 		bind4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
 		SERV4_IP,
@@ -125,6 +178,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (dgram)",
 		bind4_prog_load,
 		bind4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -137,6 +191,7 @@ static struct sock_addr_test tests[] = {
 		"bind6: bind (stream)",
 		bind6_prog_load,
 		bind6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
 		SERV6_IP,
@@ -149,6 +204,7 @@ static struct sock_addr_test tests[] = {
 		"bind6: bind (dgram)",
 		bind6_prog_load,
 		bind6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -163,6 +219,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (stream)",
 		connect4_prog_load,
 		connect4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
 		SERV4_IP,
@@ -176,6 +233,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (dgram)",
 		connect4_prog_load,
 		connect4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -189,6 +247,7 @@ static struct sock_addr_test tests[] = {
 		"connect6: connect (stream)",
 		connect6_prog_load,
 		connect6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
 		SERV6_IP,
@@ -202,6 +261,7 @@ static struct sock_addr_test tests[] = {
 		"connect6: connect (dgram)",
 		connect6_prog_load,
 		connect6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -215,6 +275,7 @@ static struct sock_addr_test tests[] = {
 		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -230,6 +291,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sendmsg (dgram)",
 		sendmsg4_prog_load,
 		sendmsg4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -243,6 +305,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg6: sendmsg (dgram)",
 		sendmsg6_prog_load,
 		sendmsg6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -256,6 +319,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
 		SERVUN_ADDRESS,
@@ -271,6 +335,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg4: recvfrom (dgram)",
 		recvmsg4_prog_load,
 		recvmsg4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_REWRITE_IP,
@@ -284,6 +349,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg6: recvfrom (dgram)",
 		recvmsg6_prog_load,
 		recvmsg6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_REWRITE_IP,
@@ -297,6 +363,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
 		SERVUN_REWRITE_ADDRESS,
@@ -310,6 +377,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_REWRITE_ADDRESS,
@@ -325,6 +393,7 @@ static struct sock_addr_test tests[] = {
 		"getsockname_unix",
 		getsockname_unix_prog_load,
 		getsockname_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -340,6 +409,7 @@ static struct sock_addr_test tests[] = {
 		"getpeername_unix",
 		getpeername_unix_prog_load,
 		getpeername_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -400,26 +470,15 @@ static int cmp_sock_addr(info_fn fn, int sock1,
 	return cmp_addr(&addr1, len1, addr2, addr2_len, cmp_port);
 }
 
-static int cmp_local_addr(int sock1, const struct sockaddr_storage *addr2,
-			  socklen_t addr2_len, bool cmp_port)
-{
-	return cmp_sock_addr(getsockname, sock1, addr2, addr2_len, cmp_port);
-}
-
-static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2,
-			 socklen_t addr2_len, bool cmp_port)
-{
-	return cmp_sock_addr(getpeername, sock1, addr2, addr2_len, cmp_port);
-}
-
 static void test_bind(struct sock_addr_test *test)
 {
 	struct sockaddr_storage expected_addr;
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
 	int serv = -1, client = -1, err;
 
-	serv = start_server(test->socket_family, test->socket_type,
-			    test->requested_addr, test->requested_port, 0);
+	serv = test->ops->start_server(test->socket_family, test->socket_type,
+				       test->requested_addr,
+				       test->requested_port, 0);
 	if (!ASSERT_GE(serv, 0, "start_server"))
 		goto cleanup;
 
@@ -429,7 +488,8 @@ static void test_bind(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	err = cmp_local_addr(serv, &expected_addr, expected_addr_len, true);
+	err = cmp_sock_addr(test->ops->getsockname, serv, &expected_addr,
+			    expected_addr_len, true);
 	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
 		goto cleanup;
 
@@ -442,7 +502,7 @@ static void test_bind(struct sock_addr_test *test)
 	if (client != -1)
 		close(client);
 	if (serv != -1)
-		close(serv);
+		test->ops->close(serv);
 }
 
 static void test_connect(struct sock_addr_test *test)
@@ -463,7 +523,8 @@ static void test_connect(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(test->socket_type, &addr, addr_len, NULL);
+	client = test->ops->connect_to_addr(test->socket_type, &addr, addr_len,
+					    NULL);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -479,18 +540,21 @@ static void test_connect(struct sock_addr_test *test)
 			goto cleanup;
 	}
 
-	err = cmp_peer_addr(client, &expected_addr, expected_addr_len, true);
+	err = cmp_sock_addr(test->ops->getpeername, client, &expected_addr,
+			    expected_addr_len, true);
 	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
 		goto cleanup;
 
 	if (test->expected_src_addr) {
-		err = cmp_local_addr(client, &expected_src_addr, expected_src_addr_len, false);
+		err = cmp_sock_addr(test->ops->getsockname, client,
+				    &expected_src_addr, expected_src_addr_len,
+				    false);
 		if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
 			goto cleanup;
 	}
 cleanup:
 	if (client != -1)
-		close(client);
+		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
 }
@@ -500,8 +564,6 @@ static void test_xmsg(struct sock_addr_test *test)
 	struct sockaddr_storage addr, src_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
 		  src_addr_len = sizeof(struct sockaddr_storage);
-	struct msghdr hdr;
-	struct iovec iov;
 	char data = 'a';
 	int serv = -1, client = -1, err;
 
@@ -514,7 +576,7 @@ static void test_xmsg(struct sock_addr_test *test)
 	if (!ASSERT_GE(serv, 0, "start_server"))
 		goto cleanup;
 
-	client = socket(test->socket_family, test->socket_type, 0);
+	client = test->ops->socket(test->socket_family, test->socket_type, 0);
 	if (!ASSERT_GE(client, 0, "socket"))
 		goto cleanup;
 
@@ -524,7 +586,8 @@ static void test_xmsg(struct sock_addr_test *test)
 		if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 			goto cleanup;
 
-		err = bind(client, (const struct sockaddr *) &src_addr, src_addr_len);
+		err = test->ops->bind(client, (struct sockaddr *)&src_addr,
+				      src_addr_len);
 		if (!ASSERT_OK(err, "bind"))
 			goto cleanup;
 	}
@@ -535,17 +598,8 @@ static void test_xmsg(struct sock_addr_test *test)
 		goto cleanup;
 
 	if (test->socket_type == SOCK_DGRAM) {
-		memset(&iov, 0, sizeof(iov));
-		iov.iov_base = &data;
-		iov.iov_len = sizeof(data);
-
-		memset(&hdr, 0, sizeof(hdr));
-		hdr.msg_name = (void *)&addr;
-		hdr.msg_namelen = addr_len;
-		hdr.msg_iov = &iov;
-		hdr.msg_iovlen = 1;
-
-		err = sendmsg(client, &hdr, 0);
+		err = test->ops->sendmsg(client, (struct sockaddr *)&addr,
+					 addr_len, &data, sizeof(data));
 		if (!ASSERT_EQ(err, sizeof(data), "sendmsg"))
 			goto cleanup;
 	} else {
@@ -596,7 +650,7 @@ static void test_xmsg(struct sock_addr_test *test)
 
 cleanup:
 	if (client != -1)
-		close(client);
+		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
 }
@@ -607,7 +661,7 @@ static void test_getsockname(struct sock_addr_test *test)
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
 	int serv = -1, err;
 
-	serv = start_server(test->socket_family, test->socket_type,
+	serv = test->ops->start_server(test->socket_family, test->socket_type,
 			    test->requested_addr, test->requested_port, 0);
 	if (!ASSERT_GE(serv, 0, "start_server"))
 		goto cleanup;
@@ -618,13 +672,13 @@ static void test_getsockname(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	err = cmp_local_addr(serv, &expected_addr, expected_addr_len, true);
+	err = cmp_sock_addr(test->ops->getsockname, serv, &expected_addr, expected_addr_len, true);
 	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
 		goto cleanup;
 
 cleanup:
 	if (serv != -1)
-		close(serv);
+		test->ops->close(serv);
 }
 
 static void test_getpeername(struct sock_addr_test *test)
@@ -644,7 +698,8 @@ static void test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(test->socket_type, &addr, addr_len, NULL);
+	client = test->ops->connect_to_addr(test->socket_type, &addr, addr_len,
+					    NULL);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -653,13 +708,14 @@ static void test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	err = cmp_peer_addr(client, &expected_addr, expected_addr_len, true);
+	err = cmp_sock_addr(test->ops->getpeername, client, &expected_addr,
+			    expected_addr_len, true);
 	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
 		goto cleanup;
 
 cleanup:
 	if (client != -1)
-		close(client);
+		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
 }
-- 
2.44.0.769.g3c40516874-goog


