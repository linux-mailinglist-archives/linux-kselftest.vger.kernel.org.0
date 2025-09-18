Return-Path: <linux-kselftest+bounces-39502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A716B2FBFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B74D1883624
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C520298C;
	Thu, 21 Aug 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TYVJT4gH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860519DF4A;
	Thu, 21 Aug 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785218; cv=none; b=TcPH/5WCTRApoFXy45wITafpVZaxau18fJ+iLT1C1jI7wvOCljDkwnAGeZfzXvuYBHjWTV2OM+NyiSA0ruduWIkwz8wqiJ2C2whuA1gIhKakvFJ2dG2PLr3R2sPEpsEe5KKNvyM0/T8Eigw2b92C9XK0Eu9sSmpsDC6g3ryJrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785218; c=relaxed/simple;
	bh=nUGU27fzDsTOg2J9A5OTomvtQbT3M0USfEGyJ3PwOoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciu3bbDvWOwYDzteEJak79+Y9QgzIpk0KpvauTVHsW28Of+/D6M56h6pOYzpuo/hGIF/oAw9S3FCx6+n1Je+1ngVnkRtUpfZB4w+eqlYohuanBcG/18wFs/P5Oz9ga+C0RtWMMsI0dGQjh0+DtuP1q3SQ8dnuVwddcmSE4ZJGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TYVJT4gH; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=li
	0tdgetfqc1FOFNnQpld+aQTCcO+7IXZb6ERmK+fVs=; b=TYVJT4gHE58tCmQ4pR
	LehLCs6XAZcnBSAsXext3k+qO7m4avhN8Px9z5We+JJx/XiuABYf7tGmB57xwFpW
	sLYHxAJPrwg16hw6ci92THcX4/wLwv7IUrlvwLcfafvsIIfzkulan/16vVCR8lfS
	gg33b1IzfU0LMouLix1lGmtGQ=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3RUngJ6doG2VUDA--.41400S3;
	Thu, 21 Aug 2025 22:06:27 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 1/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 21 Aug 2025 14:06:22 +0000
Message-ID: <20250821140623.971621-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821140623.971621-1-phoenix500526@163.com>
References: <20250821140623.971621-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3RUngJ6doG2VUDA--.41400S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr1xKFWfZrb_yoWxZF47pa
	y09rZYyr18tw4Svan3WF40va43Cws7Gr4rZrW8ta45ZFWxWr4UJrWSkr1Yyrn5Jay2yr43
	XF4YvrWfGF13Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgASwiGim-6KgjQAEsG

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
 tools/lib/bpf/usdt.bpf.h | 47 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/usdt.c     | 58 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..263168d57286 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -4,6 +4,7 @@
 #define __USDT_BPF_H__
 
 #include <linux/errno.h>
+#include <asm/byteorder.h>
 #include "bpf_helpers.h"
 #include "bpf_tracing.h"
 
@@ -34,13 +35,34 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_SIB,
 };
 
+/*
+ * This struct layout is designed specifically to be backwards/forward
+ * compatible between libbpf versions for ARG_CONST, ARG_REG, and
+ * ARG_REG_DEREF modes. ARG_SIB requires libbpf v1.7+.
+ */
 struct __bpf_usdt_arg_spec {
 	/* u64 scalar interpreted depending on arg_type, see below */
 	__u64 val_off;
 	/* arg location case, see bpf_usdt_arg() for details */
-	enum __bpf_usdt_arg_type arg_type;
+	enum __bpf_usdt_arg_type arg_type: 8;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	/* index register offset within struct pt_regs (high 12 bits) */
+	__u16	idx_reg_off: 12,
+	/* scale factor for index register (1, 2, 4, or 8) (low 4 bits) */
+		scale: 4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	/* scale factor for index register (1, 2, 4, or 8) (high 4 bits) */
+	__u16	scale: 4,
+	/* index register offset within struct pt_regs (low 12 bits) */
+		idx_reg_off: 12;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	/* reserved for future use, keeps reg_off offset stable */
+	__u8 reserved;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
 	/* whether arg should be interpreted as signed value */
@@ -149,7 +171,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	unsigned long val, idx;
 	int err, spec_id;
 
 	*res = 0;
@@ -202,6 +224,27 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 			return err;
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		val >>= arg_spec->arg_bitshift;
+#endif
+		break;
+	case BPF_USDT_ARG_SIB:
+		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
+		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). We first
+		 * fetch the base register contents and the index register
+		 * contents from pt_regs. Then we calculate the final address
+		 * as base + (index * scale) + offset, and do a user-space
+		 * probe read to fetch the argument value.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val), (void *)(val + (idx * arg_spec->scale) + arg_spec->val_off));
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 3373b9d45ac4..730a896a566b 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
+#include <asm/byteorder.h>
 
 /* s8 will be marked as poison while it's a reg of riscv */
 #if defined(__riscv)
@@ -200,12 +201,23 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };
 
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
 struct usdt_arg_spec {
 	__u64 val_off;
-	enum usdt_arg_type arg_type;
+	enum usdt_arg_type arg_type: 8;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u16	idx_reg_off: 12,
+		scale: 4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u16	scale: 4,
+		idx_reg_off: 12;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	__u8 reserved;     /* keep reg_off offset stable */
 	short reg_off;
 	bool arg_signed;
 	char arg_bitshift;
@@ -1283,11 +1295,46 @@ static int calc_pt_regs_off(const char *reg_name)
 
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
+			   arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5 ||
+		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^,] , %d ) %n",
+			   arg_sz, reg_name, idx_reg_name, &scale, &len) == 4 ||
+		sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^)] ) %n",
+			   arg_sz, &off, reg_name, idx_reg_name, &len) == 4 ||
+		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^)] ) %n",
+			   arg_sz, reg_name, idx_reg_name, &len) == 3
+		) {
+		/*
+		 * Scale Index Base case:
+		 * 1@-96(%rbp,%rax,8)
+		 * 1@(%rbp,%rax,8)
+		 * 1@-96(%rbp,%rax)
+		 * 1@(%rbp,%rax)
+		 */
+		arg->arg_type = USDT_ARG_SIB;
+		arg->val_off = off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+
+		idx_reg_off = calc_pt_regs_off(idx_reg_name);
+		if (idx_reg_off < 0)
+			return idx_reg_off;
+		/* validate scale factor and set fields directly */
+		if (scale != 1 && scale != 2 && scale != 4 && scale != 8) {
+			pr_warn("usdt: invalid SIB scale %d, expected 1,2,4,8; defaulting to 1\n", scale);
+			return -EINVAL;
+		}
+		arg->idx_reg_off = idx_reg_off;
+		arg->scale = scale;
+	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1306,6 +1353,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
+		/* register read has no memory offset */
 		arg->val_off = 0;
 
 		reg_off = calc_pt_regs_off(reg_name);
-- 
2.43.0


