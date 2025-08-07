Return-Path: <linux-kselftest+bounces-38429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA4B1D0EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 04:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091F2563D1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1113219F135;
	Thu,  7 Aug 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H4ySGy9Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344DF1FC3;
	Thu,  7 Aug 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534116; cv=none; b=D4DYByuw3G/pqSWVsGwotzCCKWlJKbVCLkwaRUglHhIWVIzDp9Sg51cv9ZA4ZuBRVLHq+aGSjkJ78eJGCO5jhtsrQwzATu41cyYQYStZOW9XCGvJACfr0rXdfzbWDdTgtqpSnLidSOdCCDQb/0BYMkZJkYR1dKkPm31H6kXoIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534116; c=relaxed/simple;
	bh=DJRiM51sUHVMdFnuSUCnDqCrApr9XSP5DhHLcbWaI9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spW8UvGAXrODaO8Q/HpFZp+WPOoX5RUqwCW2x0kswuhFGR6le1PoclTShRj1XO/KKIgnRaEybqYOLFbUH/FvOKd2poSaTjLYgqLfU1gD0EkBWouvmXwKFJWXFU7ZZzSgqGlwHh1oIzBGhCmH3bPhSBraFXZk5YaZ52YUW2eO20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H4ySGy9Y; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YG
	aHjg5DHhwax12wVFIRns88y7vxnsJQvKsXA6yBaOE=; b=H4ySGy9YTbmx3Yt2s/
	V5a2kPZOWjj9Cjj7SoGBCWIgcPQ4QQe5wuaIk9TKGpkL+C80uHS3mi9gbFVOOTiX
	+v6jEMXwjPrH1V16H7viQofc9L3o/FbpP4VlKNoaK98HSCrWE5S2IOom1CaL2Oyx
	/1NX9Wxim8k9+EOsspJryRQyc=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD331O2EJRoF+MEAQ--.33482S3;
	Thu, 07 Aug 2025 10:34:32 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 1/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu,  7 Aug 2025 02:34:27 +0000
Message-ID: <20250807023430.4566-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807023430.4566-1-phoenix500526@163.com>
References: <20250807023430.4566-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331O2EJRoF+MEAQ--.33482S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr48XryDGFg_yoW7KF4fpa
	y09wnayr1rJ3yS9Fn3Wa10v343Crs7Gr4rZr4xJa45ZFWxWr4UJryfKF1ayrn8GrZFyF43
	ZF4FgrWfCa43Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzXdUUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFBaiiGiUCQLbqQAAst

On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
to fail with -ENOENT (unrecognized register).

This patch fixes this by implementing the necessary changes:
- add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
- add adaptive support to `__bpf_usdt_arg_type` and
  `__bpf_usdt_arg_spec` to represent SIB addressing parameters.

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/lib/bpf/usdt.bpf.h | 33 +++++++++++++++++++++++++++++-
 tools/lib/bpf/usdt.c     | 43 ++++++++++++++++++++++++++++++++++------
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..246513088c3a 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_SIB,
 };
 
 struct __bpf_usdt_arg_spec {
@@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
 	enum __bpf_usdt_arg_type arg_type;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
+	/* offset of index register in pt_regs, only used in SIB mode */
+	short idx_reg_off;
+	/* scale factor for index register, only used in SIB mode */
+	short scale;
 	/* whether arg should be interpreted as signed value */
 	bool arg_signed;
 	/* number of bits that need to be cleared and, optionally,
@@ -149,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	unsigned long val, idx;
 	int err, spec_id;
 
 	*res = 0;
@@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 			return err;
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		val >>= arg_spec->arg_bitshift;
+#endif
+		break;
+	case BPF_USDT_ARG_SIB:
+		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
+		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Register
+		 * is identified like with BPF_USDT_ARG_SIB case, the offset
+		 * is in arg_spec->val_off, the scale factor is in arg_spec->scale.
+		 * Firstly, we fetch the base register contents and the index
+		 * register contents from pt_regs. Secondly, we multiply the
+		 * index register contents by the scale factor, then add the
+		 * base address and the offset to get the final address. Finally,
+		 * we do another user-space probe read to fetch argument value
+		 * itself.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val),
+				(void *)val + idx * arg_spec->scale + arg_spec->val_off);
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 4e4a52742b01..1f8b9e1c9819 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -200,6 +200,7 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };
 
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
@@ -207,6 +208,8 @@ struct usdt_arg_spec {
 	__u64 val_off;
 	enum usdt_arg_type arg_type;
 	short reg_off;
+	short idx_reg_off;
+	short scale;
 	bool arg_signed;
 	char arg_bitshift;
 };
@@ -1283,11 +1286,39 @@ static int calc_pt_regs_off(const char *reg_name)
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
-	char reg_name[16];
-	int len, reg_off;
-	long off;
+	char reg_name[16] = {0}, idx_reg_name[16] = {0};
+	int len, reg_off, idx_reg_off, scale = 1;
+	long off = 0;
+
+	if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n",
+				arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5 ||
+		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^,] , %d ) %n",
+				arg_sz, reg_name, idx_reg_name, &scale, &len) == 4 ||
+		sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, idx_reg_name, &len) == 4 ||
+		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^)] ) %n",
+				arg_sz, reg_name, idx_reg_name, &len) == 3
+		) {
+		/* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)
+		 * 1@(%rbp,%rax,8)
+		 * 1@-96(%rbp,%rax)
+		 * 1@(%rbp,%rax)
+		 */
+		arg->arg_type = USDT_ARG_SIB;
+		arg->val_off = off;
+		arg->scale = scale;
+
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
+		idx_reg_off = calc_pt_regs_off(idx_reg_name);
+		if (idx_reg_off < 0)
+			return idx_reg_off;
+		arg->idx_reg_off = idx_reg_off;
+	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1298,7 +1329,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", arg_sz, reg_name, &len) == 2) {
 		/* Memory dereference case without offset, e.g., 8@(%rsp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
-		arg->val_off = 0;
+		arg->val_off = off;
 		reg_off = calc_pt_regs_off(reg_name);
 		if (reg_off < 0)
 			return reg_off;
@@ -1306,7 +1337,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
-		arg->val_off = 0;
+		arg->val_off = off;
 
 		reg_off = calc_pt_regs_off(reg_name);
 		if (reg_off < 0)
-- 
2.43.0


