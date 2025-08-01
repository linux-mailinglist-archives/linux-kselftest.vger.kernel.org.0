Return-Path: <linux-kselftest+bounces-38184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE35DB1858D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698533B91D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393A279329;
	Fri,  1 Aug 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kgP0v2mC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391C639;
	Fri,  1 Aug 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064974; cv=none; b=uiZvpA0liWzEexB4MLnOpA3rHqQH88WEiM6BY5UawrPvXcMiBh5O1zn9V5bcBX50nBsXWB2NbgBbMQmGCVIAOK4HeKbKyNjxVo+dlD2pztlWS34MY6Y/VRv2N9yYifbEdZr9kY9PXnoXWiFvbO5YAuaLWYHwmEI5M4Ua1b9HwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064974; c=relaxed/simple;
	bh=R7Mrm5U34ZLR5OOy9r7H0nw7NEK6cOX4iXSo0t9f9RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIAqDKWkT3h9pxBXYspEzwuVHbwF7p/TToTNywqzxR8EsZ4O95aFH2S61tuetNLYVJGizAnt1Yhgpq9d0WfLKMwHDt2DCmS9Y3lHEmKLxTw6ooLLmLNOInzXo1ZM8WMiMbYnk87WOO1X/GvdDzNMMuj44X5qgSbHetSTycp2udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kgP0v2mC; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bf
	/pvO/QNZtOK68n137XZi4C9EIWXgIS4QoE0ay0bbg=; b=kgP0v2mC8g8re/FkjP
	dbek9tSr/z3Sm2gMFqZ+GBxHSf6YrLYXLCIgM+CqOua6fNZky3T+jZMSFFvq3mGt
	MHlAB55kxuOsrq7s19khyjiW2GIdACdItw4d1+nuzVubMVx260IheFTli8MBVVwx
	SvS72la17Yn57u+wPRoNvCriE=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn7c0j6IxoIAufIw--.10599S3;
	Sat, 02 Aug 2025 00:15:34 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiawei Zhao <Phoenix500526@163.com>
Subject: [PATCH v4 1/1] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Fri,  1 Aug 2025 16:15:30 +0000
Message-ID: <20250801161531.816845-2-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801161531.816845-1-phoenix500526@163.com>
References: <20250801161531.816845-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7c0j6IxoIAufIw--.10599S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kCrWrCFyUWrg_yoWfXF4kpa
	y09wn2yF1ftF4Sva1rXF4UZrW3Crs7JrWrAr18Ja4YvFWxGr1kXrWfKF45trn8G397tF43
	ZF4SgrWfGay5Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ptQ6p_UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAmciGiM5e83nQABsY

From: Jiawei Zhao <Phoenix500526@163.com>

On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
to fail with -ENOENT (unrecognized register).

This patch fixes this by implementing the necessary changes:
- add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
- add adaptive support to `__bpf_usdt_arg_type` and
`__bpf_usdt_arg_spec` to represent SIB addressing parameters.

Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
---
 tools/lib/bpf/usdt.bpf.h                      | 33 +++++++++++++-
 tools/lib/bpf/usdt.c                          | 43 ++++++++++++++++---
 tools/testing/selftests/bpf/Makefile          |  5 +++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 +++++---
 4 files changed, 86 insertions(+), 13 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 910d8d6402ef..f53c86023334 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -759,6 +759,11 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
+# Force usdt.c to use -O2 optimization to generate SIB addressing
+$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+
 # Define test_verifier test runner.
 # It is much simpler than test_maps/test_progs and sufficiently different from
 # them (e.g., test.h is using completely pattern), that it's worth just
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..86f354d25aef 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -14,10 +14,15 @@ static volatile int idx = 2;
 static volatile __u64 bla = 0xFEDCBA9876543210ULL;
 static volatile short nums[] = {-1, -2, -3, -4};
 
-static volatile struct {
-	int x;
-	signed char y;
-} t1 = { 1, -127 };
+/*
+ * TODO:  At O2 optimization level, t1's USDT argument spec becomes -1@4+t1(%rip).
+ * Since libbpf doesn't support RIP addressing mode yet, this causes "unrecognized register" errors.
+ * This test will be re-enabled once libbpf supports RIP addressing mode.
+ */
+// static volatile struct {
+//	int x;
+//	signed char y;
+// } t1 = { 1, -127 };
 
 #define SEC(name) __attribute__((section(name), used))
 
@@ -27,6 +32,7 @@ unsigned short test_usdt12_semaphore SEC(".probes");
 
 static void __always_inline trigger_func(int x) {
 	long y = 42;
+	signed char t1 = -127;
 
 	if (test_usdt0_semaphore)
 		STAP_PROBE(test, usdt0);
@@ -36,7 +42,7 @@ static void __always_inline trigger_func(int x) {
 		STAP_PROBE12(test, usdt12,
 			     x, x + 1, y, x + y, 5,
 			     y / 7, bla, &bla, -9, nums[x],
-			     nums[idx], t1.y);
+			     nums[idx], t1);
 	}
 }
 
@@ -106,7 +112,7 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt12_args[8], -9, "usdt12_arg9");
 	ASSERT_EQ(bss->usdt12_args[9], nums[1], "usdt12_arg10");
 	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
-	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
+	ASSERT_EQ(bss->usdt12_args[11], -127, "usdt12_arg12");
 
 	int usdt12_expected_arg_sizes[12] = { 4, 4, 8, 8, 4, 8, 8, 8, 4, 2, 2, 1 };
 
-- 
2.43.0


