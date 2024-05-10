Return-Path: <linux-kselftest+bounces-10034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC98C2A3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98C81C213E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC747A62;
	Fri, 10 May 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FppcQ6bx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83445979
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367782; cv=none; b=ZFcNcBoUys5XWTtX1APy/usQXQ7vv/cY+xetwQTJn+KvrcJLq9mgK0SMDrzX60KnaBYrmW7Tj+k+upm89FWqWtkIygX0HYEuLyNwShNtOBntLNCToq/Su+/dvVXRXwOD9yI4yLNwvtK2dmiMpg8zqRMnD4nsXKA6ATNpNPYdjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367782; c=relaxed/simple;
	bh=ClRaP72pjb3E2W917zpJHnDF6WQ563poSNVHHcPXUAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLh3N8ZBzSFsiKUZmXbcUQ2HGWEuiMnmNvebkVTMX1DvQ+C6eKdaShzZbsZZYyrBL8L5NfLWzbCt4ClVyS/s6NW/Ha5asIUsuR7ZR9bF1uTL2s7xrf7QrZOiSnRC13z5T8LUEtxsnvumm7AR3n5sdlFLrowADXVdx4qW4ZPSrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FppcQ6bx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c296333so40543977b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367780; x=1715972580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtnreiZbliPZHYz3oERPbdrbZVQ8ZqM9pXNGCzUgu3M=;
        b=FppcQ6bx62POgJewrkp+8acbX8QwxU2qF3Uw5RKs2LzmyDIOkaTWbwTKGzvOwKrh4X
         VLLEjrieY/v/G1k8dyxBGXBkg8XbEbSGFjcdJdiMKRNyLQQsfaEI5LGxMKxcJe+/t5D6
         AvfPJFuA/FGZ0/GD7eyTjVpTLMbR5Wg00YA++G6nGd0/Etkk6MOFhJRxK1y5i83jwRXr
         xaPzNT5aaS7tnxQB8e7arG4oYsKuXvPN7W5VTOiWoBceSHgcW4hwf02k0YpVus0niI6h
         PVeeVuzXZtwg15wtYmbuaWryVuIFBpyIN3nGB2fPl4wHR4g7iOFmxfCd9gG9P161dLYi
         0x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367780; x=1715972580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtnreiZbliPZHYz3oERPbdrbZVQ8ZqM9pXNGCzUgu3M=;
        b=ia26hjjqeiEzLYxqdXGR69/7PoNMEfjhhKdugHlqfM9qGGmMbbRsfdQvr1S46N4l4g
         ZAsX/V/heOTrGJdA890p7RZ17bxc+IkxQPWMmyTYoHiCDpbQgHGf5r7G+WVYhqGCb8aY
         lT2N2/OiG2Mj56ueQ/0/QjFtYLS8KkQgIkljy1uQ3jAeVETNlljYWQBH1mT2UfVgLT8M
         gdFr/N5vM1wybrj82NylBy8dWc6ew6Sp76NAIB7vveD86IDIjKREB0BBoH90VFenua0r
         xWM3uETC9pOK6Am3yacktYDA+cYh+x9fD8JBynyd6BahAK1L3T/hwYDqSD7H7kHm8r/8
         Jebw==
X-Forwarded-Encrypted: i=1; AJvYcCUpI4M9V/dwn8+WCZRb1jGBCQDRfHGdShh+Ry6aC9Q8dKt8Int/rOiLQMiFwth/6Mn8sOW58z9/iXuW6tS4Na48pQ4tbPGpStSsTWDPxBRc
X-Gm-Message-State: AOJu0YxMn8vBrU4lRFCbfdOKrTy5ZECz/RklW/OBBRifKpX9ytc61W0/
	ee0LTjh5BKwLnS9XPLuOTnKNtkoOkw8Haj2mXBs50Um6AZdNjK6vSY011NLS91s1JNdnzpZhcQ=
	=
X-Google-Smtp-Source: AGHT+IFmkW5oyt+fCUDEit4rEVfnALEndXTfWYgpUvZc35j30WdfNRmFuQjUX6JxFqjQKxQFNvZekxDuag==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:68c3:0:b0:de5:dcb8:5c8a with SMTP id
 3f1490d57ef6-debcfbce27fmr1485306276.2.1715367780121; Fri, 10 May 2024
 12:03:00 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:24 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-8-jrife@google.com>
Subject: [PATCH v1 bpf-next 07/17] selftests/bpf: Migrate sendmsg deny test cases
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

This set of tests checks that sendmsg calls are rejected (return -EPERM)
when the sendmsg* hook returns 0. Replace those in bpf/test_sock_addr.c
with corresponding tests in prog_tests/sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 98 +++++++++++++++++++
 .../selftests/bpf/progs/sendmsg4_prog.c       |  6 ++
 .../selftests/bpf/progs/sendmsg6_prog.c       |  6 ++
 tools/testing/selftests/bpf/test_sock_addr.c  | 45 ---------
 4 files changed, 110 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 37e9ef5a5ae16..634f7a31b35db 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -443,7 +443,9 @@ BPF_SKEL_FUNCS(connect4_prog, connect_v4_prog);
 BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
+BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
@@ -766,6 +768,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: sendmsg deny (dgram)",
+		sendmsg_v4_deny_prog_load,
+		sendmsg_v4_deny_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
@@ -798,6 +816,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg deny (dgram)",
+		sendmsg_v6_deny_prog_load,
+		sendmsg_v6_deny_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
@@ -832,6 +866,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: sock_sendmsg deny (dgram)",
+		sendmsg_v4_deny_prog_load,
+		sendmsg_v4_deny_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sock_sendmsg (dgram)",
@@ -864,6 +914,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sock_sendmsg deny (dgram)",
+		sendmsg_v6_deny_prog_load,
+		sendmsg_v6_deny_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
@@ -898,6 +964,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: kernel_sendmsg deny (dgram)",
+		sendmsg_v4_deny_prog_load,
+		sendmsg_v4_deny_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: kernel_sendmsg (dgram)",
@@ -930,6 +1012,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: kernel_sendmsg deny (dgram)",
+		sendmsg_v6_deny_prog_load,
+		sendmsg_v6_deny_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
index 351e79aef2fae..edc159598a0ef 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
@@ -49,4 +49,10 @@ int sendmsg_v4_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg4")
+int sendmsg_v4_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index 03956a654ce58..0c1825cb994d6 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -65,4 +65,10 @@ int sendmsg_v6_preserve_dst_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg6")
+int sendmsg_v6_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index ab8ef02c9c556..91d88358090eb 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -92,7 +92,6 @@ static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
-static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
@@ -258,20 +257,6 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg4: deny call",
-		sendmsg_deny_prog_load,
-		BPF_CGROUP_UDP4_SENDMSG,
-		BPF_CGROUP_UDP4_SENDMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SRC4_REWRITE_IP,
-		SYSCALL_EPERM,
-	},
 	{
 		"sendmsg6: load prog with wrong expected attach type",
 		sendmsg6_rw_asm_prog_load,
@@ -342,20 +327,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: deny call",
-		sendmsg_deny_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SYSCALL_EPERM,
-	},
 };
 
 static int load_insns(const struct sock_addr_test *test,
@@ -431,22 +402,6 @@ static int connect6_prog_load(const struct sock_addr_test *test)
 	return load_path(test, CONNECT6_PROG_PATH);
 }
 
-static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
-				   int32_t rc)
-{
-	struct bpf_insn insns[] = {
-		/* return rc */
-		BPF_MOV64_IMM(BPF_REG_0, rc),
-		BPF_EXIT_INSN(),
-	};
-	return load_insns(test, insns, ARRAY_SIZE(insns));
-}
-
-static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
-{
-	return xmsg_ret_only_prog_load(test, /*rc*/ 0);
-}
-
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
 	struct sockaddr_in dst4_rw_addr;
-- 
2.45.0.118.g7fe29c98d7-goog


