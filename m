Return-Path: <linux-kselftest+bounces-10030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C758C2A34
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EED1C2222D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790813ADA;
	Fri, 10 May 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpOGaqxO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694144C73
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367776; cv=none; b=ejZyMGKd7fOmoW9EGBfMQX1VHkBAUXEwc6lkxt8YoliqO3Dj5wbCZs/5ManNPCoo0sZ1YcWFkbE/38V4oL95T1fxjsYcbYlezIj3zT3MSp5uoGBrGWnsxS4c2DWw3NxBc27PRgSj+0H2hGWs9m7YiAS49inEoP8Yh9yQ9y694dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367776; c=relaxed/simple;
	bh=umwDCHMxWe2VleAcb0MR/ATgCNVJNqxCKDau+vAM1iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpwSGCSfC3nYg+ewMQzS1dnmc0viMbb/ahtJ+6QljGU9PNEZmH9uIhTa8TSxtOBJw//2HECLVkFEZhT2QmFazap0ATArI9LKpyA5Pg1oVTxOmFVN91foO/EbWWQM4kER4xBnYgTWlThEq1SSLm7Gd7zxKt4mPGScQEcQdVB39Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpOGaqxO; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7e18170ca14so232223339f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367773; x=1715972573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSfeVpMvwODzNEwypI4cGwPjJUiYaJQzLUjzCAkNHo=;
        b=VpOGaqxOuvQsDkYbkyan+39RDHzhwUwEVAorm2H+70oVpuWeVWPZkFflDMqRiVA2HM
         ruQ2jj6TTL3uRgunRTvf5qx/hp+wUxlejijs22YGtUBEG+1xbiwefW22Ru4Pt+M4/lWP
         ocDoX2Mk220sTST+M1LkH8Y8vuWlr7nCr4I4kAU71GyQdvMf2uZnNubagCOfiQ/wQSgz
         D9flU75+5dorggjmGFLf4cclNFI/bBjIOkKDkxNPAQ9hp3od4NRDlRCJLDxNGTNXz52b
         +k6c1nGEEM1FouF5ibziMHBg+ugjJTn1MhfqKk1cG7QW6uQObbgXP8ztIqcCOvy/xKWZ
         QeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367773; x=1715972573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSfeVpMvwODzNEwypI4cGwPjJUiYaJQzLUjzCAkNHo=;
        b=poSiZkyUj9LTqC7Bw5hCT3ltdnt5wY+UsaPLNAtLYLE9BabwOuQ5g6b/3IQ0fKDaLS
         0UPiVrIeKRjdq2maLZ53tXEbuv70X12xPg95AeTrMH5LOry1yCuANgU1rCiJfTgomKKY
         4wMn8Q9PTPwqMEJNV+E5NmmF+ATyQrryTdPDqFdPOz5cynWjSzBkgqDFGE7XVy/GVSCq
         eqlQ0BTyC/lrMqDphr2NMQXKPs/eVf2WT5LowjbG8tuk6cWLE4Hbnitj0m2tolFrw99X
         zttvxP8rwpB12kpfSpjlPQIMpMgNWH9bX1FGDnzsLszO4uyL3k5UaeGXQAKo21/9oEpO
         dnHA==
X-Forwarded-Encrypted: i=1; AJvYcCWoECgUNiG+3wsxUKdsoh38ym1N8+wCG8uUcQ6MNk3tEqltzu3Iv3D2CXxxBh3jL2mmW0eUwCXOrnZlhAOtWPnM3d26k4OIMcU/ODoArG+X
X-Gm-Message-State: AOJu0Yyko6RUj4XUgg32nns2ouuPfv05eYUXVPCmql0VddUx+6dkBGFB
	s/g9ypQOcUWnr805Ar35L90w0CwFyTFdOlGkQhKtXYqv6jXUrk3N60UxiUNpqfGqvfO5MbHS0A=
	=
X-Google-Smtp-Source: AGHT+IFOCD3TK76hgg1j2I7tXKXE7izW2vzfDFqxJjwb3/5fLciGU/CDmRC/k8ISZGXSusfSzdRRFO4Jkg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:8625:b0:488:d668:d201 with SMTP id
 8926c6da1cb9f-4895856f59emr201108173.1.1715367773669; Fri, 10 May 2024
 12:02:53 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:20 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-4-jrife@google.com>
Subject: [PATCH v1 bpf-next 03/17] selftests/bpf: Handle LOAD_REJECT test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to move test cases from bpf/test_sock_addr.c that expect
LOAD_REJECT, this patch adds expected_attach_type and extends load_fn to
accept an expected attach type and a flag indicating whether or not
rejection is expected.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 103 +++++++++++++++++-
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 039c3e38e1bc2..3033641fd7567 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -52,7 +52,9 @@ enum sock_addr_test_type {
 	SOCK_ADDR_TEST_GETPEERNAME,
 };
 
-typedef void *(*load_fn)(int cgroup_fd);
+typedef void *(*load_fn)(int cgroup_fd,
+			 enum bpf_attach_type attach_type,
+			 bool expect_reject);
 typedef void (*destroy_fn)(void *skel);
 
 static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
@@ -343,6 +345,7 @@ struct sock_addr_test {
 	/* BPF prog properties */
 	load_fn loadfn;
 	destroy_fn destroyfn;
+	enum bpf_attach_type attach_type;
 	/* Socket operations */
 	struct sock_ops *ops;
 	/* Socket properties */
@@ -354,15 +357,34 @@ struct sock_addr_test {
 	const char *expected_addr;
 	unsigned short expected_port;
 	const char *expected_src_addr;
+	/* Expected test result */
+	enum {
+		LOAD_REJECT,
+		ATTACH_REJECT,
+		SYSCALL_EPERM,
+		SYSCALL_ENOTSUPP,
+		SUCCESS,
+	} expected_result;
 };
 
 #define BPF_SKEL_FUNCS(skel_name, prog_name) \
-static void *prog_name##_load(int cgroup_fd) \
+static void *prog_name##_load(int cgroup_fd, \
+			      enum bpf_attach_type attach_type, \
+			      bool expect_reject) \
 { \
-	struct skel_name *skel; \
-	skel = skel_name##__open_and_load(); \
+	struct skel_name *skel = skel_name##__open(); \
 	if (!ASSERT_OK_PTR(skel, "skel_open")) \
 		goto cleanup; \
+	if (!ASSERT_OK(bpf_program__set_expected_attach_type(skel->progs.prog_name, \
+							     attach_type), \
+		       "set_expected_attach_type")) \
+		goto cleanup; \
+	if (skel_name##__load(skel)) { \
+		ASSERT_TRUE(expect_reject, "unexpected rejection"); \
+		goto cleanup; \
+	} \
+	if (!ASSERT_FALSE(expect_reject, "expected rejection")) \
+		goto cleanup; \
 	skel->links.prog_name = bpf_program__attach_cgroup( \
 		skel->progs.prog_name, cgroup_fd); \
 	if (!ASSERT_OK_PTR(skel->links.prog_name, "prog_attach")) \
@@ -398,6 +420,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (stream)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -406,12 +429,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: bind (dgram)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -420,12 +445,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (stream)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -434,12 +461,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (dgram)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -448,6 +477,7 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 
 	/* bind - kernel calls */
@@ -456,6 +486,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: kernel_bind (stream)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -463,12 +494,15 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: kernel_bind (dgram)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -476,12 +510,15 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (stream)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -489,12 +526,15 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (dgram)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -502,6 +542,8 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 
 	/* connect - system calls */
@@ -510,6 +552,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (stream)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -518,12 +561,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: connect (dgram)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -532,12 +577,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (stream)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -546,12 +593,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (dgram)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -560,12 +609,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -574,6 +625,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* connect - kernel calls */
@@ -582,6 +634,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: kernel_connect (stream)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -590,12 +643,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: kernel_connect (dgram)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -604,12 +659,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (stream)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -618,12 +675,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (dgram)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -632,12 +691,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: kernel_connect (dgram)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -646,6 +707,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - system calls */
@@ -654,6 +716,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -662,12 +725,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -676,12 +741,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -690,6 +757,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - kernel calls (sock_sendmsg) */
@@ -698,6 +766,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sock_sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -706,12 +775,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sock_sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -720,12 +791,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -734,6 +807,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - kernel calls (kernel_sendmsg) */
@@ -742,6 +816,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: kernel_sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -750,12 +825,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: kernel_sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -764,12 +841,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -778,6 +857,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* recvmsg - system calls */
@@ -786,6 +866,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg4: recvfrom (dgram)",
 		recvmsg4_prog_load,
 		recvmsg4_prog_destroy,
+		BPF_CGROUP_UDP4_RECVMSG,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -794,12 +875,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SERV4_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg6: recvfrom (dgram)",
 		recvmsg6_prog_load,
 		recvmsg6_prog_destroy,
+		BPF_CGROUP_UDP6_RECVMSG,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -808,12 +891,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SERV6_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_RECVMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -822,12 +907,14 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		SERVUN_ADDRESS,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_RECVMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -836,6 +923,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		SERVUN_ADDRESS,
+		SUCCESS,
 	},
 
 	/* getsockname - system calls */
@@ -844,6 +932,7 @@ static struct sock_addr_test tests[] = {
 		"getsockname_unix",
 		getsockname_unix_prog_load,
 		getsockname_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETSOCKNAME,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -852,6 +941,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* getpeername - system calls */
@@ -860,6 +950,7 @@ static struct sock_addr_test tests[] = {
 		"getpeername_unix",
 		getpeername_unix_prog_load,
 		getpeername_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETPEERNAME,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -868,6 +959,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 };
 
@@ -1249,7 +1341,8 @@ void test_sock_addr(void)
 		if (!test__start_subtest(test->name))
 			continue;
 
-		skel = test->loadfn(cgroup_fd);
+		skel = test->loadfn(cgroup_fd, test->attach_type,
+				    test->expected_result == LOAD_REJECT);
 		if (!skel)
 			continue;
 
-- 
2.45.0.118.g7fe29c98d7-goog


