Return-Path: <linux-kselftest+bounces-20077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6639A30FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340D7B228AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F91D5CFB;
	Thu, 17 Oct 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeXCPayv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C051D278C
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205451; cv=none; b=bM57bGQLyFgvlBB7aMhmSKAoDAMgKA9oPg9dgf5QV/Eah1ZyJoIMwBPkn51fLG4yKCk0Kxa2rkfJZp7dkIbPSscXKpr4XannU+ZIBNVE9k+NtK7XlGBGrH4a6Y529VytAuMNgHYkPukKBUslqe6brPZSF+J1l7MHCSN/vL0YXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205451; c=relaxed/simple;
	bh=92lER4RD1KfMgpHw/bqC0mIN5r7IWn865Oh4xhr5o1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJ68jHSro0HDhHTngGdeM0cc0Wx7qxSN/fwPCeXi79j+MeBbaxY2GENZPs+0Ke93AGFdhqpWmju5N4TmLf2QMqdCZLxn0NgIUiKAte7gaNnGJbC1Dl+yrEGpCzbnOHRTRGmUQJ1JKefsHBebrVKD5L4p3Y+Cs6zV5wCUyVwmO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeXCPayv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d4f9974c64so1164003a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205448; x=1729810248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HD233Lgat9+uaGYeJg/soPiG0pkTMlyycgkHDgRnl1g=;
        b=OeXCPayveei7XBwhKDyHD06/IlPMH4BYCK2zBt2uA8jSmJKtl7v7JLfmvejEmitRG8
         +eBXlMtVIKFvOKKd6kSk3IJGCMQuEYE5pjCrMKLqfztdzSvWbIcLr3bw8abtjCA8hybE
         0BZWsbM0RRwLHOV926gvgG/AmV55QahOz3Kpe6FntH2noKGKvMWLPNcKZENbGTHZ7ohM
         PMNDuIq9Jr1MC9ya7y3KgqjNACjsmbXZY/01rO5yt8zUiAyX29oSyXPrU5gJF5IwO66J
         QZeXBQvUeZxMoLcrGghdT7OtxrLalWXJS67F/k7wqgycv9ox6HdNtOSkvlTLb7AjOp7m
         Uqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205448; x=1729810248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD233Lgat9+uaGYeJg/soPiG0pkTMlyycgkHDgRnl1g=;
        b=kJ4gVpl73RJHhOEiWGu51RHjoYHZud/YIXqR5YBSYgxtvOcz3lgNEH/UZw6jxbPWqY
         DBEEBLuSBqUQfKSEFfRO3cVpYGxcc56azGt9SzhFY+5A+ygMF2HJsj5R3DvfVX5fPu1J
         bT8qLdI5e56up4c3CSCXYL5y9LHz/Z1hckuohS4W7d21jwTre9J97TCzoQ908W5rv9gH
         dYeVhML8ynaaLtSPPjeg71cp69fULwYp+paAJTN+LfMDvmUfFDGbZlqPY7aSsVEgC1DC
         DoNcLE9/AAF1IjiRIZxGH5TLw/CitpjCfdDkJeMePXRvdgzmanBKS5KuP9Z0z13akYz+
         7OaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWxbBXPp0/VeH+LbhyQcc1Dy1NyZQmtloMbMNxL6G5g51CwZEWqbzCwfCm3GbOM7tyj4oYjiyWe1sam4mZKLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjbV3MeAIboJAD+Ms1/e83qTD3JGzArBCKtWZytX/avWeZYRd
	JgCk0yo/iAwoPlZ1bpW9muQR5arerD/7XMgm+f2Aogi4ScYTpWKsh8BLLjjtOAtND39fTGv7Ow=
	=
X-Google-Smtp-Source: AGHT+IEch2bGDCqvmLnKWiMJLrUhsRW3+2XiAMqHJd/L/3y0owGocVTDvbossqh4TAm6UrHWATlU7cCs1Q==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:d311:0:b0:7ea:6c42:d18b with SMTP id
 41be03b00d2f7-7eacc894c58mr126a12.8.1729205448258; Thu, 17 Oct 2024 15:50:48
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:19 +0000
In-Reply-To: <20241017225031.2448426-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-2-jrife@google.com>
Subject: [PATCH bpf-next v1 1/4] selftests/bpf: Migrate *_POST_BIND test cases
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

Move all BPF_CGROUP_INET6_POST_BIND and BPF_CGROUP_INET4_POST_BIND test
cases to a new prog_test, prog_tests/sock_post_bind.c, except for
LOAD_REJECT test cases.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_post_bind.c | 417 ++++++++++++++++++
 tools/testing/selftests/bpf/test_sock.c       | 245 ----------
 2 files changed, 417 insertions(+), 245 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_post_bind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
new file mode 100644
index 000000000000..c46537e3b9d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+
+static char bpf_log_buf[4096];
+static bool verbose;
+
+static struct sock_post_bind_test {
+	const char			*descr;
+	/* BPF prog properties */
+	const struct bpf_insn		insns[64];
+	enum bpf_attach_type		attach_type;
+	enum bpf_attach_type		expected_attach_type;
+	/* Socket properties */
+	int				domain;
+	int				type;
+	/* Endpoint to bind() to */
+	const char *ip;
+	unsigned short port;
+	unsigned short port_retry;
+
+	/* Expected test result */
+	enum {
+		ATTACH_REJECT,
+		BIND_REJECT,
+		SUCCESS,
+		RETRY_SUCCESS,
+		RETRY_REJECT
+	} result;
+} tests[] = {
+	{
+		.descr = "attach type mismatch bind4 vs bind6",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.result = ATTACH_REJECT,
+	},
+	{
+		.descr = "attach type mismatch bind6 vs bind4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.result = ATTACH_REJECT,
+	},
+	{
+		.descr = "attach type mismatch default vs bind4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = 0,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.result = ATTACH_REJECT,
+	},
+	{
+		.descr = "attach type mismatch bind6 vs sock_create",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.result = ATTACH_REJECT,
+	},
+	{
+		.descr = "bind4 reject all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.ip = "0.0.0.0",
+		.result = BIND_REJECT,
+	},
+	{
+		.descr = "bind6 reject all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.ip = "::",
+		.result = BIND_REJECT,
+	},
+	{
+		.descr = "bind6 deny specific IP & port",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* if (ip == expected && port == expected) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_ip6[3])),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+				    __bpf_constant_ntohl(0x00000001), 4),
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_port)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.ip = "::1",
+		.port = 8193,
+		.result = BIND_REJECT,
+	},
+	{
+		.descr = "bind4 allow specific IP & port",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* if (ip == expected && port == expected) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_ip4)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+				    __bpf_constant_ntohl(0x7F000001), 4),
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_port)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+
+			/* return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+
+			/* else return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.ip = "127.0.0.1",
+		.port = 4098,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "bind4 deny specific IP & port of TCP, and retry",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* if (ip == expected && port == expected) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_ip4)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+				    __bpf_constant_ntohl(0x7F000001), 4),
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_port)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.ip = "127.0.0.1",
+		.port = 4098,
+		.port_retry = 5000,
+		.result = RETRY_SUCCESS,
+	},
+	{
+		.descr = "bind4 deny specific IP & port of UDP, and retry",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* if (ip == expected && port == expected) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_ip4)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+				    __bpf_constant_ntohl(0x7F000001), 4),
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_port)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+		.ip = "127.0.0.1",
+		.port = 4098,
+		.port_retry = 5000,
+		.result = RETRY_SUCCESS,
+	},
+	{
+		.descr = "bind6 deny specific IP & port, and retry",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* if (ip == expected && port == expected) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_ip6[3])),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
+				    __bpf_constant_ntohl(0x00000001), 4),
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+				    offsetof(struct bpf_sock, src_port)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.ip = "::1",
+		.port = 8193,
+		.port_retry = 9000,
+		.result = RETRY_SUCCESS,
+	},
+	{
+		.descr = "bind4 allow all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.attach_type = BPF_CGROUP_INET4_POST_BIND,
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.ip = "0.0.0.0",
+		.result = SUCCESS,
+	},
+	{
+		.descr = "bind6 allow all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.attach_type = BPF_CGROUP_INET6_POST_BIND,
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.ip = "::",
+		.result = SUCCESS,
+	},
+};
+
+static int load_prog(const struct bpf_insn *insns,
+		     enum bpf_attach_type expected_attach_type)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .expected_attach_type = expected_attach_type,
+		    .log_level = 2,
+		    .log_buf = bpf_log_buf,
+		    .log_size = sizeof(bpf_log_buf),
+	);
+	int fd, insns_cnt = 0;
+
+	for (;
+	     insns[insns_cnt].code != (BPF_JMP | BPF_EXIT);
+	     insns_cnt++) {
+	}
+	insns_cnt++;
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns,
+			   insns_cnt, &opts);
+	if (verbose && fd < 0)
+		fprintf(stderr, "%s\n", bpf_log_buf);
+
+	return fd;
+}
+
+static int bind_sock(int domain, int type, const char *ip,
+		     unsigned short port, unsigned short port_retry)
+{
+	struct sockaddr_storage addr;
+	struct sockaddr_in6 *addr6;
+	struct sockaddr_in *addr4;
+	int sockfd = -1;
+	socklen_t len;
+	int res = SUCCESS;
+
+	sockfd = socket(domain, type, 0);
+	if (sockfd < 0)
+		goto err;
+
+	memset(&addr, 0, sizeof(addr));
+
+	if (domain == AF_INET) {
+		len = sizeof(struct sockaddr_in);
+		addr4 = (struct sockaddr_in *)&addr;
+		addr4->sin_family = domain;
+		addr4->sin_port = htons(port);
+		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1)
+			goto err;
+	} else if (domain == AF_INET6) {
+		len = sizeof(struct sockaddr_in6);
+		addr6 = (struct sockaddr_in6 *)&addr;
+		addr6->sin6_family = domain;
+		addr6->sin6_port = htons(port);
+		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1)
+			goto err;
+	} else {
+		goto err;
+	}
+
+	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
+		/* sys_bind() may fail for different reasons, errno has to be
+		 * checked to confirm that BPF program rejected it.
+		 */
+		if (errno != EPERM)
+			goto err;
+		if (port_retry)
+			goto retry;
+		res = BIND_REJECT;
+		goto out;
+	}
+
+	goto out;
+retry:
+	if (domain == AF_INET)
+		addr4->sin_port = htons(port_retry);
+	else
+		addr6->sin6_port = htons(port_retry);
+	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
+		if (errno != EPERM)
+			goto err;
+		res = RETRY_REJECT;
+	} else {
+		res = RETRY_SUCCESS;
+	}
+	goto out;
+err:
+	res = -1;
+out:
+	close(sockfd);
+	return res;
+}
+
+static int run_test(int cgroup_fd, struct sock_post_bind_test *test)
+{
+	int err, prog_fd, res, ret = 0;
+
+	prog_fd = load_prog(test->insns, test->expected_attach_type);
+	if (prog_fd < 0)
+		goto err;
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, test->attach_type, 0);
+	if (err < 0) {
+		if (test->result == ATTACH_REJECT)
+			goto out;
+		else
+			goto err;
+	}
+
+	res = bind_sock(test->domain, test->type, test->ip, test->port,
+			test->port_retry);
+	if (res > 0 && test->result == res)
+		goto out;
+err:
+	ret = -1;
+out:
+	/* Detaching w/o checking return code: best effort attempt. */
+	if (prog_fd != -1)
+		bpf_prog_detach(cgroup_fd, test->attach_type);
+	close(prog_fd);
+	return ret;
+}
+
+void test_sock_post_bind(void)
+{
+	int cgroup_fd, i;
+
+	cgroup_fd = test__join_cgroup("/post_bind");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].descr))
+			continue;
+
+		ASSERT_OK(run_test(cgroup_fd, &tests[i]), tests[i].descr);
+	}
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 810c3740b2cc..9ed908163d98 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -127,251 +127,6 @@ static struct sock_test tests[] = {
 		.port = 8097,
 		.result = SUCCESS,
 	},
-	{
-		.descr = "attach type mismatch bind4 vs bind6",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.result = ATTACH_REJECT,
-	},
-	{
-		.descr = "attach type mismatch bind6 vs bind4",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = ATTACH_REJECT,
-	},
-	{
-		.descr = "attach type mismatch default vs bind4",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = 0,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = ATTACH_REJECT,
-	},
-	{
-		.descr = "attach type mismatch bind6 vs sock_create",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.result = ATTACH_REJECT,
-	},
-	{
-		.descr = "bind4 reject all",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "0.0.0.0",
-		.result = BIND_REJECT,
-	},
-	{
-		.descr = "bind6 reject all",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.domain = AF_INET6,
-		.type = SOCK_STREAM,
-		.ip = "::",
-		.result = BIND_REJECT,
-	},
-	{
-		.descr = "bind6 deny specific IP & port",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-			/* if (ip == expected && port == expected) */
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip6[3])),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
-				    __bpf_constant_ntohl(0x00000001), 4),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
-
-			/* return DENY; */
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
-
-			/* else return ALLOW; */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.domain = AF_INET6,
-		.type = SOCK_STREAM,
-		.ip = "::1",
-		.port = 8193,
-		.result = BIND_REJECT,
-	},
-	{
-		.descr = "bind4 allow specific IP & port",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-			/* if (ip == expected && port == expected) */
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
-				    __bpf_constant_ntohl(0x7F000001), 4),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
-
-			/* return ALLOW; */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_JMP_A(1),
-
-			/* else return DENY; */
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 4098,
-		.result = SUCCESS,
-	},
-	{
-		.descr = "bind4 deny specific IP & port of TCP, and retry",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-			/* if (ip == expected && port == expected) */
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
-				    __bpf_constant_ntohl(0x7F000001), 4),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
-
-			/* return DENY; */
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
-
-			/* else return ALLOW; */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 4098,
-		.port_retry = 5000,
-		.result = RETRY_SUCCESS,
-	},
-	{
-		.descr = "bind4 deny specific IP & port of UDP, and retry",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-			/* if (ip == expected && port == expected) */
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
-				    __bpf_constant_ntohl(0x7F000001), 4),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
-
-			/* return DENY; */
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
-
-			/* else return ALLOW; */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.domain = AF_INET,
-		.type = SOCK_DGRAM,
-		.ip = "127.0.0.1",
-		.port = 4098,
-		.port_retry = 5000,
-		.result = RETRY_SUCCESS,
-	},
-	{
-		.descr = "bind6 deny specific IP & port, and retry",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-			/* if (ip == expected && port == expected) */
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip6[3])),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
-				    __bpf_constant_ntohl(0x00000001), 4),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
-
-			/* return DENY; */
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_JMP_A(1),
-
-			/* else return ALLOW; */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.domain = AF_INET6,
-		.type = SOCK_STREAM,
-		.ip = "::1",
-		.port = 8193,
-		.port_retry = 9000,
-		.result = RETRY_SUCCESS,
-	},
-	{
-		.descr = "bind4 allow all",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "0.0.0.0",
-		.result = SUCCESS,
-	},
-	{
-		.descr = "bind6 allow all",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.domain = AF_INET6,
-		.type = SOCK_STREAM,
-		.ip = "::",
-		.result = SUCCESS,
-	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.47.0.rc1.288.g06298d1525-goog


