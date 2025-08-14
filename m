Return-Path: <linux-kselftest+bounces-38938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF417B25C1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BAB1C86993
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F70258CED;
	Thu, 14 Aug 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CxwKuzwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C324467F;
	Thu, 14 Aug 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153938; cv=none; b=qOj99pTC4Oa4niKHvPmgfJh6IftIvKy3C1vYXGNbI6S9sG5nFa6rQPGMmxqpx0xDFGIkksWJm1PBjM3fZYqN648hNAGhYDhC/AO0vYeipauJTST67U3RWKju17/C45nwg1/qJG8RB0io2yeA74T5YoDSTXFZI5kRaT4PdNw8Z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153938; c=relaxed/simple;
	bh=GqGmvapcqj9zCgiVIWLXB/BD3psZXJmQZX3DZ9pVLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1hyV8LA3vQJSNl7ljSEcPAKCkrTm/gGJsctWgkNT+rLjIhHscIwAg+cdtzpocfb2AnevOMncWex4dnNC448MVjzo+RIZNmFP0j2I4zMgHeicvnUIeCZOH0OFyAYDyST0HVJN24AKZf+jlLkxpkN40HtDJ4HlNDDtwsYMlPG2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CxwKuzwX; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vA
	JZWIBZ/GMlJcKm2t6cSG7u1EC34nHt8lN2Xu8aVjE=; b=CxwKuzwXyECzP8vlX4
	6f5i2omQytvl4q0uX/zVneqKH9Ih/+M/ncGJ+/E5TeNMhiMyU6Z5i6ecVeJquZpw
	2d+Azb8uHzj6lh12lyMvhmj5YMdFzxC42thNjmwuz/IuiS4oimyzPOznEEXVHo7m
	q7EsFMS3MlkINzo7La0ojtAXM=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHVEjxhZ1oTQ2nBQ--.36242S3;
	Thu, 14 Aug 2025 14:45:08 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 1/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 14 Aug 2025 06:45:03 +0000
Message-ID: <20250814064504.103401-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814064504.103401-1-phoenix500526@163.com>
References: <20250814064504.103401-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHVEjxhZ1oTQ2nBQ--.36242S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr48Zr1fJFb_yoW3WFy3pa
	109r9ayry8Jr4SvF4fX3WFya43CFs7Gr4rAr1kta4YvFWxWr4UXrySkF1Ykrn8Ka47tF43
	XF4YqrWxCa47Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7PEfUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgBapiGidhbQFfQAAsL

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
 tools/lib/bpf/usdt.bpf.h | 55 ++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/usdt.c     | 61 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..f6bb7d6e4f9a 100644
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
 
@@ -202,6 +225,34 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
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
+		err = bpf_probe_read_user(&val, sizeof(val),
+								 (void *)val + idx * scale + arg_spec->val_off);
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


