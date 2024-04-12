Return-Path: <linux-kselftest+bounces-7826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66D8A3420
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B407F1F22A61
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF014D2B2;
	Fri, 12 Apr 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPK4u/in"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7114C5AA
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940775; cv=none; b=mNoOi/CaxogsFk+KWY4IZKgX8DcNIc9sHmsOwiCkf+n4i+JI26jbYnSQf0X4f4EJjo+qs39amoVXEMa4FdsmjKLXp53GReWudigOUzFerGTuOkELnsn6yrC+ERzLJ+O5B8NyPrAG6YattiEimvpKSCTPglDjQSsGpdPAe1Ye+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940775; c=relaxed/simple;
	bh=/sJKFkORHCJX+gzNjnKPLaET7Hd6YCkskv5/Ly82u6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3tsEGCOpDEAyF0XtWxawKRW9+wb4/G9SEqGu4Ur5hF8KgkEf7igj7W5VvCzHOCX7v+mviX0mS8XS5+/z0EdChePGOtNC9MD/wRl6eh9eK31f5RhC76uaq/73650MY9CsvqLSGyNUGIMWM0QaeAIbK+SPYbLWD2kzbgMna+ISac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPK4u/in; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so119314439f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940773; x=1713545573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKikK3rZsicHz3bGVtIEDWtlbmGZjh3TPmrcRxrh6GQ=;
        b=TPK4u/inhluwOp7cVbOpxzsvdvAM+IbLAFfPNlu7NZGc6yPiqwgrojUr/UfQbU7DBV
         flRcUsY0tKeKJVexHpUG/1qj2YuwQ3Rp85X8Ky0TEuKvt0biYusdOZK5mZvTLdjPqI/r
         pnrZ2pHpzm/88bIKlbWjmxzShLvChIu+F13kDW3nOjpsmspr7zNmAr/ENQTsoQmEm5qq
         Pr14CNn4jH5OvQklxS9XLDlmhb04AjVajE3bJOtpa5MfaqrJz4pi9xokGofYhTSjPVuZ
         txnA19b3dUl+jEjE2c7XdkXMGxq4ChGpc3gSXEKjz+uE4v/8D+jBAxVX1b8CPiY6fAWU
         3Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940773; x=1713545573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKikK3rZsicHz3bGVtIEDWtlbmGZjh3TPmrcRxrh6GQ=;
        b=F1QVq43Xcf8VAB1pHsDBW6+YLLIHlIicoISxsBif/3AAXFuvGTY99MhZrLbiDGLv2B
         tAYBRBvqD1Vb8S3LxjRiLakChHgdme7ZUiR0wa93FcuVoPjd+xKKcT1Lyxn7gvFRlO2y
         IjKn+tulWm8vT36YptrIpWvASq9/JVmgMWlidwNDDpS1kkGE/g64086wegfDRvo+Aie+
         0+883rQgnJqeXV2tQet8s3j1zLgz6xkmZW1iU6uSib1Caal5zxu990qLlJm5gI/65IvY
         s17LJUUR2Dr2fG4iuB4wi3Jiyc/q6mfckUJ2A3MRnFCP5/yGRNG/+UdcqMik24QLK5hG
         I1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwzm9K+P2vjYOAiZtmzMFvf9Ib1t4emSQPpuNpa3lGjvJGdNhqW/cy9V7Sl8wqpjlea7C9kjP8YNd2NcrKmn/7jeXnIDwqrryrOoLQ9ma
X-Gm-Message-State: AOJu0YxMwwnBFcwSS2HJ9zYGxLJGbLpbhB/8csv5TdyoJBgzvLqEVT08
	hKEDd5fx2pxxCZTvi3LyVlv7vFct/p/MHx6Bj5j9Mk4cmaIfXipfgk9Q7R4ydQycNkrWSz+MWQ=
	=
X-Google-Smtp-Source: AGHT+IF6+o6j5tFhCdweGYRFegjNiDtHNUj+22CveBg+llQdJzNFJrNFFrg2+BviLjnCc7ylQRzcOGVIdQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6602:340e:b0:7d0:ad03:af10 with SMTP id
 n14-20020a056602340e00b007d0ad03af10mr82634ioz.1.1712940773357; Fri, 12 Apr
 2024 09:52:53 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:26 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-6-jrife@google.com>
Subject: [PATCH v2 bpf-next 5/6] selftests/bpf: Make sock configurable for
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
 .../selftests/bpf/prog_tests/sock_addr.c      | 137 ++++++++++++------
 1 file changed, 95 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 92879b971a098..78bcc147f09c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -53,12 +53,63 @@ enum sock_addr_test_type {
 typedef void *(*load_fn)(int cgroup_fd);
 typedef void (*destroy_fn)(void *skel);
 
+struct sock_ops {
+	int (*connect_to_addr)(const struct sockaddr_storage *addr,
+			       socklen_t addrlen, int type);
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
@@ -112,6 +163,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (stream)",
 		bind4_prog_load,
 		bind4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
 		SERV4_IP,
@@ -124,6 +176,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (dgram)",
 		bind4_prog_load,
 		bind4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -136,6 +189,7 @@ static struct sock_addr_test tests[] = {
 		"bind6: bind (stream)",
 		bind6_prog_load,
 		bind6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
 		SERV6_IP,
@@ -148,6 +202,7 @@ static struct sock_addr_test tests[] = {
 		"bind6: bind (dgram)",
 		bind6_prog_load,
 		bind6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -162,6 +217,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (stream)",
 		connect4_prog_load,
 		connect4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
 		SERV4_IP,
@@ -175,6 +231,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (dgram)",
 		connect4_prog_load,
 		connect4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -188,6 +245,7 @@ static struct sock_addr_test tests[] = {
 		"connect6: connect (stream)",
 		connect6_prog_load,
 		connect6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
 		SERV6_IP,
@@ -201,6 +259,7 @@ static struct sock_addr_test tests[] = {
 		"connect6: connect (dgram)",
 		connect6_prog_load,
 		connect6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -214,6 +273,7 @@ static struct sock_addr_test tests[] = {
 		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -229,6 +289,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sendmsg (dgram)",
 		sendmsg4_prog_load,
 		sendmsg4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_IP,
@@ -242,6 +303,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg6: sendmsg (dgram)",
 		sendmsg6_prog_load,
 		sendmsg6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_IP,
@@ -255,6 +317,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
 		SERVUN_ADDRESS,
@@ -270,6 +333,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg4: recvfrom (dgram)",
 		recvmsg4_prog_load,
 		recvmsg4_prog_destroy,
+		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
 		SERV4_REWRITE_IP,
@@ -283,6 +347,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg6: recvfrom (dgram)",
 		recvmsg6_prog_load,
 		recvmsg6_prog_destroy,
+		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
 		SERV6_REWRITE_IP,
@@ -296,6 +361,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
 		SERVUN_REWRITE_ADDRESS,
@@ -309,6 +375,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_REWRITE_ADDRESS,
@@ -324,6 +391,7 @@ static struct sock_addr_test tests[] = {
 		"getsockname_unix",
 		getsockname_unix_prog_load,
 		getsockname_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -339,6 +407,7 @@ static struct sock_addr_test tests[] = {
 		"getpeername_unix",
 		getpeername_unix_prog_load,
 		getpeername_unix_prog_destroy,
+		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
 		SERVUN_ADDRESS,
@@ -399,26 +468,15 @@ static int cmp_sock_addr(info_fn fn, int sock1,
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
 
@@ -428,7 +486,8 @@ static void test_bind(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	err = cmp_local_addr(serv, &expected_addr, expected_addr_len, true);
+	err = cmp_sock_addr(test->ops->getsockname, serv, &expected_addr,
+			    expected_addr_len, true);
 	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
 		goto cleanup;
 
@@ -441,7 +500,7 @@ static void test_bind(struct sock_addr_test *test)
 	if (client != -1)
 		close(client);
 	if (serv != -1)
-		close(serv);
+		test->ops->close(serv);
 }
 
 static void test_connect(struct sock_addr_test *test)
@@ -462,7 +521,7 @@ static void test_connect(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = test->ops->connect_to_addr(&addr, addr_len, test->socket_type);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -478,18 +537,21 @@ static void test_connect(struct sock_addr_test *test)
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
@@ -499,8 +561,6 @@ static void test_xmsg(struct sock_addr_test *test)
 	struct sockaddr_storage addr, src_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
 		  src_addr_len = sizeof(struct sockaddr_storage);
-	struct msghdr hdr;
-	struct iovec iov;
 	char data = 'a';
 	int serv = -1, client = -1, err;
 
@@ -513,7 +573,7 @@ static void test_xmsg(struct sock_addr_test *test)
 	if (!ASSERT_GE(serv, 0, "start_server"))
 		goto cleanup;
 
-	client = socket(test->socket_family, test->socket_type, 0);
+	client = test->ops->socket(test->socket_family, test->socket_type, 0);
 	if (!ASSERT_GE(client, 0, "socket"))
 		goto cleanup;
 
@@ -523,7 +583,8 @@ static void test_xmsg(struct sock_addr_test *test)
 		if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 			goto cleanup;
 
-		err = bind(client, (const struct sockaddr *) &src_addr, src_addr_len);
+		err = test->ops->bind(client, (struct sockaddr *) &src_addr,
+				      src_addr_len);
 		if (!ASSERT_OK(err, "bind"))
 			goto cleanup;
 	}
@@ -534,17 +595,8 @@ static void test_xmsg(struct sock_addr_test *test)
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
@@ -595,7 +647,7 @@ static void test_xmsg(struct sock_addr_test *test)
 
 cleanup:
 	if (client != -1)
-		close(client);
+		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
 }
@@ -606,7 +658,7 @@ static void test_getsockname(struct sock_addr_test *test)
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
 	int serv = -1, err;
 
-	serv = start_server(test->socket_family, test->socket_type,
+	serv = test->ops->start_server(test->socket_family, test->socket_type,
 			    test->requested_addr, test->requested_port, 0);
 	if (!ASSERT_GE(serv, 0, "start_server"))
 		goto cleanup;
@@ -617,13 +669,13 @@ static void test_getsockname(struct sock_addr_test *test)
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
@@ -643,7 +695,7 @@ static void test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = test->ops->connect_to_addr(&addr, addr_len, test->socket_type);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -652,13 +704,14 @@ static void test_getpeername(struct sock_addr_test *test)
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
2.44.0.478.gd926399ef9-goog


