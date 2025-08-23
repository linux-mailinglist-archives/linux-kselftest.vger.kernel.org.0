Return-Path: <linux-kselftest+bounces-39779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C71B3271D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49A87BC2DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE221F1F;
	Sat, 23 Aug 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AFcirxRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F272623;
	Sat, 23 Aug 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931844; cv=none; b=bRL6NqMMfonzit7VX9ZFR/txXfovwCbzXv60tZaLuYHqvzvXjLT+1C5roLNkQ5sH1CVYNgVMrPg1qyWZS9CbueC7Sacn3/F1cJV0j/mCYIIqM6ZNlcra5OeoCski/BxyA3deGuuZT/xT+CViTOiQOv7biJESI3LQsbcBbkFNOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931844; c=relaxed/simple;
	bh=kJuiIR8rVDpwqGIPF1nQuAY6c7Z+h+ZunUtTbQE0708=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg9zYrbAgUbVHXIm1zjwXbq/UB7St60yGnxBB20KpluPGQLq+HF8AhxjBorQS68mFJEN1t77QNbO2frNnDTT6htfMR233+J77vHp60hZtPaGh9Y3R/1JbUEeSzrPlhP4EYUQIlhtkzBiHBd2bhSxtyj8jsIxW49Xh7BgxpR7iKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AFcirxRv; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hY
	0bVfXVCvwSkvV8zWlb3tUSiMgvkV/DiRGEg8n7LL0=; b=AFcirxRv0R09F0Vfue
	aULqevP0VSXHTaGvyLfG2kj5PoVmoi6tp9Hid02afbyst90ZUq8xsANafPRSio5z
	lEAfsR5uQ8p8MNySSfsO/Eram1EVPLeuI8y0TTAxBAfm9u4yvCQBCBsmz47KzxyM
	BO3NmAODG5HZRH+SeEXduYJsM=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAn8USdZKlohCriDQ--.20793S3;
	Sat, 23 Aug 2025 14:50:08 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v14 1/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Sat, 23 Aug 2025 06:50:03 +0000
Message-ID: <20250823065005.1187181-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823065005.1187181-1-phoenix500526@163.com>
References: <20250823065005.1187181-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn8USdZKlohCriDQ--.20793S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr48Xw47urg_yoWxXrWfpa
	y09rnayryrJw4Sva1fXF40y343CFs7Gr4rZrWkta45ZFWxWr4UJrySkF1Yyrn8JFW2yF43
	ZF4YvrWxG3W3ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAqyiGipWPbE8QABs-

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
 tools/lib/bpf/usdt.bpf.h | 44 +++++++++++++++++++++++++++++--
 tools/lib/bpf/usdt.c     | 57 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..aaa584a4f4f9 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -34,13 +34,32 @@ enum __bpf_usdt_arg_type {
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
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	/* arg location case, see bpf_usdt_arg() for details */
-	enum __bpf_usdt_arg_type arg_type;
+	enum __bpf_usdt_arg_type arg_type: 8;
+	/* index register offset within struct pt_regs */
+	__u16 idx_reg_off: 12,
+	/* scale factor for index register (1, 2, 4, or 8) */
+	__u16 scale: 4;
+	/* reserved for future use, keeps reg_off offset stable */
+	__u8 __reserved: 8;
+#else
+	__u8 __reserved: 8;
+	__u16 idx_reg_off: 12;
+	__u16 scale: 4;
+	enum __bpf_usdt_arg_type arg_type: 8;
+#endif
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
 	/* whether arg should be interpreted as signed value */
@@ -149,7 +168,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	unsigned long val, idx;
 	int err, spec_id;
 
 	*res = 0;
@@ -202,6 +221,27 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
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
index 3373b9d45ac4..d90e0b694134 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -200,12 +200,23 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };
 
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
 struct usdt_arg_spec {
 	__u64 val_off;
-	enum usdt_arg_type arg_type;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	enum usdt_arg_type arg_type: 8;
+	__u16	idx_reg_off: 12;
+	__u16	scale: 4;
+	__u8 __reserved: 8;     /* keep reg_off offset stable */
+#else
+	__u8 __reserved: 8;     /* keep reg_off offset stable */
+	__u16	idx_reg_off: 12;
+	__u16	scale: 4;
+	enum usdt_arg_type arg_type: 8;
+#endif
 	short reg_off;
 	bool arg_signed;
 	char arg_bitshift;
@@ -1283,11 +1294,46 @@ static int calc_pt_regs_off(const char *reg_name)
 
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
+			pr_warn("usdt: invalid SIB scale %d, expected 1, 2, 4, 8\n", scale);
+			return -EINVAL;
+		}
+		arg->idx_reg_off = idx_reg_off;
+		arg->scale = scale;
+	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
@@ -1306,6 +1352,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
 		/* Register read case, e.g., -4@%eax */
 		arg->arg_type = USDT_ARG_REG;
+		/* register read has no memory offset */
 		arg->val_off = 0;
 
 		reg_off = calc_pt_regs_off(reg_name);
-- 
2.43.0


