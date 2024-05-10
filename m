Return-Path: <linux-kselftest+bounces-10035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A58C2A3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2911C223A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208D45C10;
	Fri, 10 May 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJPk/9Fo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82B3D968
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367784; cv=none; b=DUsYnzBbc5hNIaq0SZYK2jPEjQfPAAZVUhMnkLfX008U2f5tgJxlk8vUELbrRGwvA9gp0juFBHkfmv3aWwFmVuAiX518Sz3ZLqHgKWvjeTSGy4/viDPgduJ3aeiqXv2yi7EraSA4WEh3KOqY8IJtc0dqiBVKZoYKwD+izLAIQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367784; c=relaxed/simple;
	bh=egpM+SS0LirfD5WSVqAIq0kMKcw13G77ryxMRFCOIQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ktwETSLKm/zyBxHc3LdPTamRiIJkqFpudIbt5q5eOqKZOOdaylUCgvYqqkP9c0p7Efyo4Y5bstT6CV7bstndGqPCDOBc/gyTWkGYwYhr+mKGlm24JWx3sHwLta550WnXRb+6CY8G36xtaY/3ubyidcSDPLg/6S06zeeTs5tP1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJPk/9Fo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso29821807b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367782; x=1715972582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHfwMebtZT2WFxMtw8SrwWjcPDYGaUi97DICNoF8ucc=;
        b=fJPk/9Fo64etC0qTGOsS8EeZ+c2cXyZQG7//r086GLFFYfBjN90eJrYVld4MdJgkLO
         QkkTDFkPfkb6Ng9Lfa2vbdoWsEaaSmMlP8lwk7XqNlyg7Jd99Gper65/OBNVCh7WFj7I
         P0nhvH8qWOa05vooCUyV3YS9wExGaknDsRKCrOEtMbUkGoYht9eEGkUd5htJWRO2Xioe
         N38mCaR1E6F2tYwG66vIWJ/atNDVdP8sFa48uyfgnAH6IPnj7Zx+LhdfpI84lJuSBu8+
         TDl0qyHCryOT6UZs1+MReftmPjDec1l0Z+0xKPD0S5QWdvhNRJYRHJ12BAs3zWmOaPh9
         Bi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367782; x=1715972582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHfwMebtZT2WFxMtw8SrwWjcPDYGaUi97DICNoF8ucc=;
        b=clyW3fRoCOEybHPNhN2pnH4/z32w7sHON/1jyDIYNuSjElEqMzCX6DGZomFM6hxeB+
         ySC60eRVyzUj5FFvr1rxKY40Lb4qGKZ0JzC7rOtEbXkqCna/a7MyLxjSLUhXBa/g9srB
         XWUMX5lN+zU272FpVVI1d0514zlFM70ZGKj87OxbAa2+1huphnVnbVOhdGxSD5ZBAM2P
         p7O+Zh4hulvd0Zd+Uw6FlI2YiWEj9BlbwvoX+zPdAzI+dnXt3QcgDPqVNrq13J21b/hC
         L/CeoKed63e5t4Yu0350X7Cick6fzTVvfdAf+FhkjghVn7+9bno0rQrRGNShJ5GZI5Wl
         zxgg==
X-Forwarded-Encrypted: i=1; AJvYcCW+P8gx/ZNdGdkIb/tqmYWndjqyVaY+AAAyNKnb99iz6e45ydSxcSxSh70BHzJxW7urZVP/NzeM5HFVcC4+alan5WI5T1MaA/Hn+u4JgN0m
X-Gm-Message-State: AOJu0YwEplM6i5e/x9u19jp1LcTsn8989Z15rIPuQOIdVbY+bhDvB0OI
	q354vb2ACd+vUz7hqx/7/PAjsC5hNWrFgJfwWfOiC6DRtPBpaQjs9326HvwSJGWiG3HdRET7qg=
	=
X-Google-Smtp-Source: AGHT+IG7fbQlnTrbXbgDBfbr6eGA00YeEBfy4lIhjdsALahrTgVDmpH+FiO197VLNr+GfHSnrbwoQxw+wQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:4884:0:b0:618:2ad1:a46f with SMTP id
 00721157ae682-620992ea406mr14233357b3.2.1715367781807; Fri, 10 May 2024
 12:03:01 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:25 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-9-jrife@google.com>
Subject: [PATCH v1 bpf-next 08/17] selftests/bpf: Migrate sendmsg6 v4 mapped
 address tests
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

Migrate test case from bpf/test_sock_addr.c ensuring that sendmsg
returns -ENOTSUPP when sending to an IPv4-mapped IPv6 address to
prog_tests/sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 17 +++++++++++++
 .../selftests/bpf/progs/sendmsg6_prog.c       | 25 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 20 ---------------
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 634f7a31b35db..f096203171b17 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -447,6 +447,7 @@ BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_v4mapped_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
@@ -832,6 +833,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SYSCALL_EPERM,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg IPv4-mapped IPv6 (dgram)",
+		sendmsg_v6_v4mapped_prog_load,
+		sendmsg_v6_v4mapped_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_ENOTSUPP,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index 0c1825cb994d6..7611d9e17dd16 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -20,6 +20,11 @@
 #define DST_REWRITE_IP6_2	0
 #define DST_REWRITE_IP6_3	1
 
+#define DST_REWRITE_IP6_V4_MAPPED_0	0
+#define DST_REWRITE_IP6_V4_MAPPED_1	0
+#define DST_REWRITE_IP6_V4_MAPPED_2	0x0000FFFF
+#define DST_REWRITE_IP6_V4_MAPPED_3	0xc0a80004 // 192.168.0.4
+
 #define DST_REWRITE_PORT6	6666
 
 SEC("cgroup/sendmsg6")
@@ -59,6 +64,26 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg6")
+int sendmsg_v6_v4mapped_prog(struct bpf_sock_addr *ctx)
+{
+	/* Rewrite source. */
+	ctx->msg_src_ip6[0] = bpf_htonl(SRC_REWRITE_IP6_0);
+	ctx->msg_src_ip6[1] = bpf_htonl(SRC_REWRITE_IP6_1);
+	ctx->msg_src_ip6[2] = bpf_htonl(SRC_REWRITE_IP6_2);
+	ctx->msg_src_ip6[3] = bpf_htonl(SRC_REWRITE_IP6_3);
+
+	/* Rewrite destination. */
+	ctx->user_ip6[0] = bpf_htonl(DST_REWRITE_IP6_V4_MAPPED_0);
+	ctx->user_ip6[1] = bpf_htonl(DST_REWRITE_IP6_V4_MAPPED_1);
+	ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_V4_MAPPED_2);
+	ctx->user_ip6[3] = bpf_htonl(DST_REWRITE_IP6_V4_MAPPED_3);
+
+	ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
+
+	return 1;
+}
+
 SEC("cgroup/sendmsg6")
 int sendmsg_v6_preserve_dst_prog(struct bpf_sock_addr *ctx)
 {
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 91d88358090eb..4ead113753f81 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -94,7 +94,6 @@ static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
-static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
@@ -299,20 +298,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: IPv4-mapped IPv6",
-		sendmsg6_rw_v4mapped_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SYSCALL_ENOTSUPP,
-	},
 	{
 		"sendmsg6: set dst IP = [::] (BSD'ism)",
 		sendmsg6_rw_wildcard_prog_load,
@@ -512,11 +497,6 @@ static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test)
 	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_REWRITE_IP);
 }
 
-static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test)
-{
-	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_V4MAPPED_IP);
-}
-
 static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test)
 {
 	return sendmsg6_rw_dst_asm_prog_load(test, WILDCARD6_IP);
-- 
2.45.0.118.g7fe29c98d7-goog


