Return-Path: <linux-kselftest+bounces-26546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21EA33FFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719281885AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500723F42C;
	Thu, 13 Feb 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ngD5Y4hE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95F23F41B;
	Thu, 13 Feb 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452393; cv=none; b=LmHWiUXhSf9Dte2AL28ZBj+s5EutLXeWuyjIIZc8l3gpZrK82JVKR0TRqOa29ghBrpczWEvtHrQ623UDP6GsJV+O64qS1SouvvBkk4tfHJEgeA0BxLeOnuD6iXWx8PaM2zQLhdycXuU6PGQ5WszIk6hGhxmqRthFWwSuBrgi0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452393; c=relaxed/simple;
	bh=nyEsKhTApCPZoLTMnv/lFkEGMWySgB+lFwwLSPV8Ou4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjla7QdJPtAv6A0lZDcmzGSLdOJzAxiD8C4qlezMNNC1+QfWL06PkaMgaOm1BMbJYJAD8rbN6fNVs1RJAg32d8N2QZufseO49jTLaRjIp+wYkwReTxjV0OOlYIv0GoDi26c/ZaBTrK8ww14oZWFOpBepp/QOkntlSWDLzmqNL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ngD5Y4hE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=cJ3UT
	jsSJyPJ9WcOaBSeMblhCf9uN6xSOO70sEY2XLY=; b=ngD5Y4hEUtWrxs+qfEw2I
	5bITXlRPMaovONtizEBhsikIO2IgA8YvgLn3sXKFnmPQEoEHgt+EIyPhY4fVeLPp
	m1KX3Q13WvY4E7WIstWx5AYDE23nS2eK0a6yAKzQtpvY0Kxxlaew9NBKiP+PlcIt
	FHMl7f5Xy44IcLxSwQuOeM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3N8qv761nJPMJMA--.27324S4;
	Thu, 13 Feb 2025 21:12:21 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Allow the program to select specific modes for testing
Date: Thu, 13 Feb 2025 21:12:13 +0800
Message-ID: <20250213131214.164982-3-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213131214.164982-1-mrpre@163.com>
References: <20250213131214.164982-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8qv761nJPMJMA--.27324S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWrWF4rWF4fZF48AFy3XFb_yoW5KFyDpa
	y8G34Ykr4xJFnaqa4xGa1jgFW3Kr4kWFW8JF12gFZYyw4UG34kXF1xKayagFn8Gr4fWrnx
	Z3ZY9w4fur97AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziyrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxfyp2et6WvV-QAAs5

In some cases, the verification logic under the interpreter and JIT
differs, such as may_goto, and the test program behaves differently under
different runtime modes, requiring separate verification logic for each
result.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  2 ++
 tools/testing/selftests/bpf/test_loader.c    | 27 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f45f4352feeb..dd23822cfb5a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -135,6 +135,8 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
+#define __use_jit()		__attribute__((btf_decl_tag("comment:run_mode=jit")))
+#define __use_interp()		__attribute__((btf_decl_tag("comment:run_mode=interpreter")))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 53b06647cf57..2c23178d9a7a 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -37,6 +37,7 @@
 #define TEST_TAG_JITED_PFX "comment:test_jited="
 #define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
 #define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
+#define TEST_TAG_RUN_MODE_PFX "comment:run_mode="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -55,6 +56,11 @@ enum mode {
 	UNPRIV = 2
 };
 
+enum run_mode {
+	JIT = 1 << 0,
+	INTERP = 1 << 1
+};
+
 struct expect_msg {
 	const char *substr; /* substring match */
 	regex_t regex;
@@ -87,6 +93,7 @@ struct test_spec {
 	int prog_flags;
 	int mode_mask;
 	int arch_mask;
+	int run_mode;
 	bool auxiliary;
 	bool valid;
 };
@@ -406,6 +413,7 @@ static int parse_test_spec(struct test_loader *tester,
 	bool collect_jit = false;
 	int func_id, i, err = 0;
 	u32 arch_mask = 0;
+	u32 run_mode = 0;
 	struct btf *btf;
 	enum arch arch;
 
@@ -580,10 +588,22 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_RUN_MODE_PFX)) {
+			val = s + sizeof(TEST_TAG_RUN_MODE_PFX) - 1;
+			if (strcmp(val, "jit") == 0) {
+				run_mode = JIT;
+			} else if (strcmp(val, "interpreter") == 0) {
+				run_mode = INTERP;
+			} else {
+				PRINT_FAIL("bad run mode spec: '%s'", val);
+				err = -EINVAL;
+				goto cleanup;
+			}
 		}
 	}
 
 	spec->arch_mask = arch_mask ?: -1;
+	spec->run_mode = run_mode ?: (JIT | INTERP);
 
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
@@ -930,6 +950,7 @@ void run_subtest(struct test_loader *tester,
 	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
 	struct bpf_program *tprog = NULL, *tprog_iter;
 	struct bpf_link *link, *links[32] = {};
+	bool jit_enabled = is_jit_enabled();
 	struct test_spec *spec_iter;
 	struct cap_state caps = {};
 	struct bpf_object *tobj;
@@ -946,6 +967,12 @@ void run_subtest(struct test_loader *tester,
 		return;
 	}
 
+	if ((jit_enabled && spec->run_mode & INTERP) ||
+	    (!jit_enabled && spec->run_mode & JIT)) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
-- 
2.47.1


