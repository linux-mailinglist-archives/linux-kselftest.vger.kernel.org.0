Return-Path: <linux-kselftest+bounces-20403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B509AB210
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AB61F25393
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD71A705C;
	Tue, 22 Oct 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqWA4B02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF91A3049
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610962; cv=none; b=mF7LAisKsxrIRGXtu4g1nT72jN+t5Z/hRgqbW0PZ5U8jBqP/QFCk1paoJdsp1jTsagjgADYRrmsGbj9SaDIxEkQ0KSMQO5lN1Plx1gSCYioVoJ7T0PSSSjLrw5pe85PG57dZlfF+cEhuSxNsSj/97bg/qb3qdjOeTbHUrkYEfG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610962; c=relaxed/simple;
	bh=PIBElrUWYvv2PwD1OtHxNlMP6ZaEK/i5ZNf+lnSa2TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aEJrE4XWewKlp4vxSfkA0yYxkDzz+IVayWFwiGdKT+584lDmfYhDEvPP+JTnaoQyOKa5h5z55jivBoyX5a4xsGsZC0xoq3yuiaoBNjbP+w4/8OoyRodRsv0/IPtiUfiQrI5kC1glniCA5JyAW9NuB6iqHeliU8XvwrzGNu0i5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqWA4B02; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6507e2f0615so4867335a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610960; x=1730215760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAWSt/btbjFtiBghyaLDlopKWtLgN/X+E84XHJl7PxM=;
        b=TqWA4B02z+15Hu0D5WDFe/SMKvt+noeXCXI+LNN+Yk/k3h5OOd2nS/3Gx1I4S7fPFc
         Pztj7SRMtupaO+KLk6eYAXokhF9txVJpEHfi3wZCSgFAHjGvpMGe8ojviLj9M7nfErvi
         Cy6P/0aQF41IuJkUzwQR4PmmE0znAHVqnkbjGs0z5yy571VPudC/61m4jeERgQk749f/
         LlepBSHUW/HkWpauzL0wzBUOZcM6MawBfNEfAuS+JYzvgAOGDoar/EjRCO+Y9SAUlOVf
         QpD6l+p8GBdYhsApjAV1X5eMmmyRnsmpZG54SiQ63GUwy4Q5E2GjK8mGnPAEooa4ZVvx
         8ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610960; x=1730215760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAWSt/btbjFtiBghyaLDlopKWtLgN/X+E84XHJl7PxM=;
        b=N0btX0TGYdfcBrcldfuSXcDzM/ZaY5XaPoD0OOJQLf/nmocjB25sJicTlF/iyPUGyi
         yB7fsAE9JAeBQDN4CG8VmowHFKKQ9fA6Fs30nLRTLaNK9lHGr6CvSEflR2o6xbCA+FBT
         GL0vtLf98dy9WA2luOdtvUDVgnfsZ3r6NKvcdftRCXts5t84ZJjeNnR6FBEE+/Jgzhud
         e+OtAQlGFouL+7+n8UQkDOH5sxNNVNIVkuVej6nKyjxUnsmWggeoGeJtW63fGTD4SVNn
         fgA2nI5XSDLQ8XHuFOW4YWGuGEVffNeDvgGg28fTcRHqRtoK/ZV8lIKvD9G0wG31oRMS
         mcgg==
X-Forwarded-Encrypted: i=1; AJvYcCUQck1rvKJnIxc26TNmKUvjQBDrZopDmeMkpXXw1cOutzNCPpzf/FVRLCVqrLrASt97D4PbxH8p+307InQElYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDHN2yOdke1aoycs4i0+RVWDRD/OP6OEjycBSfh348BueUTFJ
	R6M2+MxFwIF2j2rJLr0VexAZR1RWUxQYxV+RO6C2eRqrKSW/TX77bD+SDySSONXJBEF4cmT6FQ=
	=
X-Google-Smtp-Source: AGHT+IG+8WtYAIvE5hMOTDDIDnESEKs9cooxGmHJzmkpUQR6rSf3ErATiOoioVL9hjQPnMGv1+BjKVw55A==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:3741:0:b0:7ea:7e29:be5 with SMTP id
 41be03b00d2f7-7eacc86642bmr17501a12.6.1729610959685; Tue, 22 Oct 2024
 08:29:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:02 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-3-jrife@google.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Migrate LOAD_REJECT test cases
 to prog_tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move LOAD_REJECT test cases from test_sock.c to an equivalent set of
verifier tests in progs/verifier_sock.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 60 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sock.c       | 52 ----------------
 2 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..d3e70e38e442 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -977,4 +977,64 @@ l1_%=:	r0 = *(u8*)(r7 + 0);				\
 	: __clobber_all);
 }
 
+SEC("cgroup/post_bind4")
+__description("sk->src_ip6[0] [load 1st byte]")
+__failure __msg("invalid bpf_context access off=28 size=2")
+__naked void post_bind4_read_src_ip6(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_ip6_0]);	\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_ip6_0, offsetof(struct bpf_sock, src_ip6[0]))
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind4")
+__description("sk->mark [load mark]")
+__failure __msg("invalid bpf_context access off=16 size=2")
+__naked void post_bind4_read_mark(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_mark]);		\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_mark, offsetof(struct bpf_sock, mark))
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind6")
+__description("sk->src_ip4 [load src_ip4]")
+__failure __msg("invalid bpf_context access off=24 size=2")
+__naked void post_bind6_read_src_ip4(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_ip4]);		\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_ip4, offsetof(struct bpf_sock, src_ip4))
+	: __clobber_all);
+}
+
+SEC("cgroup/sock_create")
+__description("sk->src_port [word load]")
+__failure __msg("invalid bpf_context access off=44 size=2")
+__naked void sock_create_read_src_port(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_port]);	\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_port, offsetof(struct bpf_sock, src_port))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 9ed908163d98..26dff88abbaa 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -47,58 +47,6 @@ struct sock_test {
 };
 
 static struct sock_test tests[] = {
-	{
-		.descr = "bind4 load with invalid access: src_ip6",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip6[0])),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "bind4 load with invalid access: mark",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, mark)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "bind6 load with invalid access: src_ip4",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "sock_create load with invalid access: src_port",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.result = LOAD_REJECT,
-	},
 	{
 		.descr = "sock_create load w/o expected_attach_type (compat mode)",
 		.insns = {
-- 
2.47.0.105.g07ac214952-goog


