Return-Path: <linux-kselftest+bounces-20404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623C9AB211
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8A11F252F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7361A726F;
	Tue, 22 Oct 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/05Ab3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099A1A3056
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610962; cv=none; b=FJhM1Mz0iE8uGwZ1pHorbCZtDBEzU0uF3ida+/lwrleuJkVGj9ft7kz4UsbojZHxJa1rWzEYQ5WJSWGY/xLzz6EZyzIk4rVN9M9+aXlnKkfCVHL6XP7L7YIr0TyfF/tVYevvsLgcsOgDYFXlRusASAcGdgG/PIREQxXOo5wuEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610962; c=relaxed/simple;
	bh=GdvrfYPXKufBcCKtwhEWQaPblf67lc8LuA9PLBLMz9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGqzCZzAHrhnTdBr20fdbcQrp1TnSDroS8qjigJBhCZRWfrPttbYWbvM7jt74BLxto/CmWQdl5Lee0dVsuCrM9IgsqwjZOuQf9QdXKkne6b5ZIoYzWut0TZbwhTD5ey69yAkVxK23j8P8NBPiG4Cxps7aV5ezCmUfYLGQJcDm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/05Ab3h; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea61faf655so2492277a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610958; x=1730215758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDNpe86iWZxRpORrtGdS8nlKHDmPBRzXt90mx6BTn+g=;
        b=B/05Ab3h00UM8wn/E5C7d6XTuGopOLjZVpFTUfrQTWgir8+FjjkxsWgw9rB4Tk/nd5
         QC0+bkl0K2lY0zZtiRpnJLQ85RJqSYsuuFq1p1oUh98N2qWdxWz2Vwsqp3w6WbYf0i+E
         X+VIazA7GpizRvz67atRx+1gjdTKLTq5/TbOyJBKfHT4GJsSKD0KzkZX/0IbDN7Mkwbb
         qd8F0SIoaduHLc6Dl3rejYTFVovQHfU61+WEUS4NNaTCoMtEXKnlS1LVdXtm0BcTOfWk
         Zf96rmAC7Gkzi3TlioVV1f846/K7jTjTQIOXUQRdemMvR7AuY6gSaNpNS5SXV2cJcWcl
         MolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610958; x=1730215758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDNpe86iWZxRpORrtGdS8nlKHDmPBRzXt90mx6BTn+g=;
        b=k6ILV3KzPGbAB3e6GUPoJSvlfnFXpnD6ANvFtnpjofmcIbZkixOMUs00IYzkiONwbM
         BlBb+rU4XEVU6qYFnW0xVL/BX+SftJ7SX2mPJ3wQzYRn/ytDKImZnDRbnEAuFmSUDYNj
         2SFLSVaauZj15n+ifF6zv0LyvvyK0gtjiRZcNLgXhm9FKSiSSpQ3Bm/DRXhLFSLifPci
         RKODxQjqIx3OqmJVleA49KCWBo2I+TSASmSHDGNoRavMfT6lV3gyaPiuLA8DPNnvHEDQ
         7aL2BBAEuPbc+j8N8pHG5CKWVVi/oeYRUIwhpkyC6WxoPljhzDs803V20rBOHZoWHIx1
         fNlw==
X-Forwarded-Encrypted: i=1; AJvYcCX1qsVWKJ1qXWyZ3JRqLQuK512KhPxxuSK60RSUOzDUlEjGweWVxX/ivMJ9aHhznxP7Ndraj344pFY4xslri8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHTW4aqBiDtGvhRzv5x0cOHLk9faF4hORyERG55rhQ2Wxzai1
	nm5FZE1Z4GFngfPVdKsPTC8DGAM+NUwFdzDEhhYkFzUYk8S7G+fwadZJ3hga+wXppmzS4q7EuQ=
	=
X-Google-Smtp-Source: AGHT+IGw+hmIZrdZZBB2RZyokYLyhRz1qPN3Jnk67bBTgSTEkHChO/2Cgc5lj7kKcyR954/XcnNbDqVEjg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:6402:0:b0:7ea:6a4f:274a with SMTP id
 41be03b00d2f7-7eacc880b2fmr16507a12.7.1729610957550; Tue, 22 Oct 2024
 08:29:17 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:01 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-2-jrife@google.com>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Migrate *_POST_BIND test cases
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
 .../selftests/bpf/prog_tests/sock_post_bind.c | 428 ++++++++++++++++++
 tools/testing/selftests/bpf/test_sock.c       | 245 ----------
 2 files changed, 428 insertions(+), 245 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_post_bind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
new file mode 100644
index 000000000000..7edcd8caada0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+
+#define TEST_NS "sock_post_bind"
+
+static char bpf_log_buf[4096];
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
+	if (fd < 0)
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
+	struct netns_obj *ns = NULL;
+	int cgroup_fd = 0;
+	int i;
+
+	ns = netns_new(TEST_NS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/post_bind");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].descr))
+			continue;
+
+		ASSERT_OK(run_test(cgroup_fd, &tests[i]), tests[i].descr);
+	}
+
+cleanup:
+	if (ns)
+		netns_free(ns);
+	if (cgroup_fd)
+		close(cgroup_fd);
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
2.47.0.105.g07ac214952-goog


