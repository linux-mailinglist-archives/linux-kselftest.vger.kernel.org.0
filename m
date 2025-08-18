Return-Path: <linux-kselftest+bounces-39200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDAB29B22
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E5C171194
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E428727A;
	Mon, 18 Aug 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FcnszTaw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735E286D7D;
	Mon, 18 Aug 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503230; cv=none; b=DmWcuteDcf97inGPqTwitHJoX054PWX1Yz7CdaOlxdT3lTTG9AfTticBdUBtwiOIUiPq/ciQN34ySERQyPZybQxySbr6FfC428SDClZ/+1EAvnOdw6efsdbwWzmT6pPURSdsc99x7O385DmePBtGUEdmXrQlsqdQzqfxOQfu7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503230; c=relaxed/simple;
	bh=rPbxrG6DiKDjudUDxS0OBzpk+OOY8JHG8K9CbaYtaqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC8HULMLDgLNlAMOaTaKuRRJREu1WbMDLgdqU4G5YOEc0nt8o/YXE6VjWn19fY8pTeAvE1a+ikhbbao6PBVW4J88J2K0Hg/k8H71d80Q1JReLWuRk/9D7Msr/3X2lcIu6wXX56T79O3Ujx8TnomqrRjWB8sOaof4UKnExPKlqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FcnszTaw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dY
	vma5Rn63lla7bKiqS7gekg8+4QdkOsCcO+uwGtMUQ=; b=FcnszTaw53YA7sMwQk
	wJRh/7I5vth+E2pNSCXg56iiVvi48+JihuxdZfJS2Gk2iZDH8mihNXUg492DmHYz
	y/lCRNRF8ItaD6Hs1RwwcQthW1QhI9mzYAWuWUeEyi+AQHN41Z+DF47eUt574ly2
	2iD/Mklh1tCFtyTAW7fYozkG8=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBH_+VZ2qJoyxi9Cg--.52195S3;
	Mon, 18 Aug 2025 15:46:36 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 1/3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Mon, 18 Aug 2025 07:46:30 +0000
Message-ID: <20250818074632.433008-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818074632.433008-1-phoenix500526@163.com>
References: <20250818074632.433008-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_+VZ2qJoyxi9Cg--.52195S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr48Xw47urg_yoW3WFy7pa
	109r9ayry8Jr4SvF4fX3WFya43CFs7Gr4rAr1kta4YvFWxWr4UXrySkF1Ykrn8Ka47tF43
	XF4YqrWxCFy7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgB2tiGii15JBvwAAsJ

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
 tools/lib/bpf/usdt.bpf.h | 54 +++++++++++++++++++++++++++++++++--
 tools/lib/bpf/usdt.c     | 61 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..1e6de0afe65d 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -34,13 +34,31 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_SIB,
 };
 
+/*
+ * To preserve overall layout and avoid growing this struct while adding SIB
+ * extras, we keep 4 bytes worth of space after val_off:
+ *
+ *  - arg_type is stored as a single byte (values from enum below)
+ *  - idx_packed is a 16-bit field packing idx_reg_off (high 12 bits)
+ *    and scale shift (low 4 bits, i.e., scale = 1 << shift)
+ *  - reserved is one spare byte for future use
+ *
+ * This keeps the offset of reg_off identical to the historical layout
+ * (val_off:8 + 4 bytes here), ensuring backwards/forwards compatibility for
+ * non-SIB modes that only rely on val_off/arg_type/reg_off/... offsets.
+ */
 struct __bpf_usdt_arg_spec {
 	/* u64 scalar interpreted depending on arg_type, see below */
 	__u64 val_off;
 	/* arg location case, see bpf_usdt_arg() for details */
-	enum __bpf_usdt_arg_type arg_type;
+	__u8 arg_type;
+	/* packed: [15:4] idx_reg_off, [3:0] scale_shift */
+	__u16 idx_packed;
+	/* reserved for future use, keeps reg_off offset stable */
+	__u8 reserved;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
 	/* whether arg should be interpreted as signed value */
@@ -52,6 +70,10 @@ struct __bpf_usdt_arg_spec {
 	char arg_bitshift;
 };
 
+/* Helpers to (un)pack SIB extras from idx_packed without relying on bitfields. */
+#define USDT_IDX_OFF(packed)         ((packed) >> 4)
+#define USDT_IDX_SCALE_SHIFT(packed) ((packed) & 0x000f)
+
 /* should match USDT_MAX_ARG_CNT in usdt.c exactly */
 #define BPF_USDT_MAX_ARG_CNT 12
 struct __bpf_usdt_spec {
@@ -149,8 +171,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	unsigned long val, idx;
 	int err, spec_id;
+	int idx_off = 0, scale = 0;
 
 	*res = 0;
 
@@ -202,6 +225,33 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
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
+		idx_off = USDT_IDX_OFF(arg_spec->idx_packed);
+		scale = 1UL << USDT_IDX_SCALE_SHIFT(arg_spec->idx_packed);
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + idx_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + idx * scale + arg_spec->val_off);
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 3373b9d45ac4..0a6499f654fc 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -200,12 +200,15 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };
 
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
 struct usdt_arg_spec {
 	__u64 val_off;
-	enum usdt_arg_type arg_type;
+	__u8 arg_type;     /* enum value stored as u8 */
+	__u16 idx_packed;  /* [15:4]=idx_reg_off, [3:0]=scale_shift */
+	__u8 reserved;     /* keep reg_off offset stable */
 	short reg_off;
 	bool arg_signed;
 	char arg_bitshift;
@@ -214,6 +217,10 @@ struct usdt_arg_spec {
 /* should match BPF_USDT_MAX_ARG_CNT in usdt.bpf.h */
 #define USDT_MAX_ARG_CNT 12
 
+/* Helpers to (un)pack SIB extras from idx_packed without relying on bitfields. */
+#define BPF_USDT_IDX_PACK(idx_off, scale_shift) \
+	((__u16)(((__u16)((idx_off) & 0x0fff)) << 4) | (__u16)((scale_shift) & 0x000f))
+
 /* should match struct __bpf_usdt_spec from usdt.bpf.h */
 struct usdt_spec {
 	struct usdt_arg_spec args[USDT_MAX_ARG_CNT];
@@ -1283,11 +1290,54 @@ static int calc_pt_regs_off(const char *reg_name)
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
-	char reg_name[16];
-	int len, reg_off;
-	long off;
+	char reg_name[16] = {0}, idx_reg_name[16] = {0};
+	int len, reg_off, idx_reg_off, scale = 1;
+	long off = 0;
+	__u16 scale_shift;
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
+		/* pack idx_reg_off and scale shift (scale in {1,2,4,8}) */
+		if (scale == 1)
+			scale_shift = 0;
+		else if (scale == 2)
+			scale_shift = 1;
+		else if (scale == 4)
+			scale_shift = 2;
+		else if (scale == 8)
+			scale_shift = 3;
+		else {
+			pr_warn("usdt: invalid SIB scale %d, expected 1,2,4,8; defaulting to 1\n", scale);
+			return -EINVAL;
+		}
+		arg->idx_packed = BPF_USDT_IDX_PACK(idx_reg_off, scale_shift);
+	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1306,6 +1356,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
+		/* register read has no memory offset */
 		arg->val_off = 0;
 
 		reg_off = calc_pt_regs_off(reg_name);
-- 
2.43.0


