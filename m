Return-Path: <linux-kselftest+bounces-26640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AECA35A0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B973A3B32
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3622D7AC;
	Fri, 14 Feb 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zn0zKRQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60440151983;
	Fri, 14 Feb 2025 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524756; cv=none; b=iB1YaG2HzIBF+imb3zgY0wEXU56tvLxYShbEsf4QwXQ8gwPV4haqVyoU2k1XXXwb53E41ZasSS4JGJMW/epUcAi5EV23u4wQiskUnB3nW+G9DvstHEnGahbvRoJdBLMVsumj24DzxwTdvK0Zo7Oz1SMuKlBif+dV/8sxRDBWIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524756; c=relaxed/simple;
	bh=1glHOL5Pzw+8f9Vi4dPnvjKUnZdK+7Gma6tpPN5wtZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq5l8P4FiUBd9F6FRRL/O2tg7c8/eKMLeONVZfZfxPXZYCzRDd99GQwhYST4Hj+u5jXeKz7U6+O32cUX+AKCXS3iN0OCJjWxi1srZvdX23kBnmwQ+qCFqpmuPVj30zlw1fp8y+tAutPcx5fA3BDDhZ6+Y3EaXgHrdLB6pyvimfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zn0zKRQO; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=r/Nie
	Ukngw1Ng7zjztWXdhTdNUKCYe7Tq1fFu04keqs=; b=Zn0zKRQOcnRnto2Gzonso
	q2kZzTc51LUcEUkD1KxJ383fLZa39Ux9lYhHyPZu44qbeIiFdf/xF4obOv+Q75Lx
	angFuFCokf/ma/Slj7ZxA222Dm3EZ0cOaz6lB/ghzniLKMm+x3p5eB1qwX56rRfz
	RzzRAm/UzSdLiC3CUPcqPA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3N0RjCq9nqR1PMA--.3071S4;
	Fri, 14 Feb 2025 17:18:32 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Introduce __load_if_JITed annotation for tests
Date: Fri, 14 Feb 2025 17:18:22 +0800
Message-ID: <20250214091823.46042-3-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214091823.46042-1-mrpre@163.com>
References: <20250214091823.46042-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N0RjCq9nqR1PMA--.3071S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF17ZF1xAFWDJr4kAr17trb_yoWrJr4rpF
	y8Ga4YkrWxJF13XFyxJa1UWFWfKr1kWrWfAF1jgrsYyws8Xas7XF4xK3yagFn8Xr4rWrn8
	AasY9w45urykAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziyrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxnzp2evAb7UygAAs-

In some cases, the verification logic under the interpreter and JIT
differs, such as may_goto, and the test program behaves differently under
different runtime modes, requiring separate verification logic for each
result.

Introduce __load_if_JITed and __load_if_no_JITed annotation for tests.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  2 ++
 tools/testing/selftests/bpf/test_loader.c    | 26 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f45f4352feeb..a40d5c0040ec 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -135,6 +135,8 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
+#define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
+#define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 53b06647cf57..4d23a9c463ee 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -37,6 +37,7 @@
 #define TEST_TAG_JITED_PFX "comment:test_jited="
 #define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
 #define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
+#define TEST_TAG_LOAD_MODE_PFX "comment:load_mode="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -55,6 +56,11 @@ enum mode {
 	UNPRIV = 2
 };
 
+enum load_mode {
+	JITED		= 1 << 0,
+	NO_JITED	= 1 << 1,
+};
+
 struct expect_msg {
 	const char *substr; /* substring match */
 	regex_t regex;
@@ -87,6 +93,7 @@ struct test_spec {
 	int prog_flags;
 	int mode_mask;
 	int arch_mask;
+	int load_mask;
 	bool auxiliary;
 	bool valid;
 };
@@ -406,6 +413,7 @@ static int parse_test_spec(struct test_loader *tester,
 	bool collect_jit = false;
 	int func_id, i, err = 0;
 	u32 arch_mask = 0;
+	u32 load_mask = 0;
 	struct btf *btf;
 	enum arch arch;
 
@@ -580,10 +588,22 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX)) {
+			val = s + sizeof(TEST_TAG_LOAD_MODE_PFX) - 1;
+			if (strcmp(val, "jited") == 0) {
+				load_mask = JITED;
+			} else if (strcmp(val, "no_jited") == 0) {
+				load_mask = NO_JITED;
+			} else {
+				PRINT_FAIL("bad load spec: '%s'", val);
+				err = -EINVAL;
+				goto cleanup;
+			}
 		}
 	}
 
 	spec->arch_mask = arch_mask ?: -1;
+	spec->load_mask = load_mask ?: (JITED | NO_JITED);
 
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
@@ -928,6 +948,7 @@ void run_subtest(struct test_loader *tester,
 		 bool unpriv)
 {
 	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
+	int current_runtime = is_jit_enabled() ? JITED : NO_JITED;
 	struct bpf_program *tprog = NULL, *tprog_iter;
 	struct bpf_link *link, *links[32] = {};
 	struct test_spec *spec_iter;
@@ -946,6 +967,11 @@ void run_subtest(struct test_loader *tester,
 		return;
 	}
 
+	if ((current_runtime & spec->load_mask) == 0) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
-- 
2.47.1


