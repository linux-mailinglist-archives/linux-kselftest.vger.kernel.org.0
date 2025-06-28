Return-Path: <linux-kselftest+bounces-36047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8EAEC753
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019624A159A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BA1F0E32;
	Sat, 28 Jun 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="VwLEdX2R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C139175D53;
	Sat, 28 Jun 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751116206; cv=none; b=nohxleIHbXgCLm+4f4Kq25yAcs1VEvcEyxKH3EYsew9RgbfNmrRMnlqBDYBYrMNLoCzIAZavvnL0J5Saoz4Zis6KRfbTh2evCeeqntug+XLMmGiRA9p2fVbNzDAoJ8m4t+MRDdggbTB0XEr5Ka4PkHpFgd43DPaPgTSFucwR/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751116206; c=relaxed/simple;
	bh=JYSr+4axxHIotvpxTe4hIWmAX2B/c5uvK0LSS2w+C3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTt65byYDaeqadEl3rmWETPJmYBW6jUa2uNY+tmcfnKEJmgqT7O31KiHl/ossWWkJMJMP6abOxMnKOp2h0logCvVUjZdEyJTMc/ggwKX5tre9rMZ5BqCi8QeSFQh59pgzJywbib8bhy80Q792VyBig6q6PL8zcOtVpmvtQgKqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=VwLEdX2R; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751116202; bh=rcqvB24Pyxx9S4coBRICiUhH7Jgty3vrOBOTtW7/DS4=;
	h=From:To:Subject:Date:In-Reply-To:References:From:To:CC:Subject;
	b=VwLEdX2RYmHpKIZfqb5fk8JnTN/V/iD71nMk90kWsbt6ZrXAEupufFX9i1EQj21Fg
	 BnaNokjGMvfqNLXeaXl+r/FB4EXRBHiHf4r+M1W/54P1iOniyCTonBLhkcyPSlDc08
	 ka+kDr2X36Oxt217foM+XyVXHI6Qi+EdYpQrIgjzWft8NNZC0tO89YElqO2Ts4h41k
	 8dIDveTZNgo7yF+4Cr+i13J2jexaawmyh1kAMQVH7IAonUj8j0BTT0It0yCq/Jco1j
	 nHHT1dGzZBOJWxmzx89pjC8/xE7eaUEYGRuHlWE/mBG+DDPUSFsRsMZZu8UxEVkfhp
	 c/hffYF+4gBqQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bTt7Z6CXqz8vkf;
	Sat, 28 Jun 2025 15:10:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3601:f400:3a2b:2f7e:18b0:5ef9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19DeMpgeYeJNqK3FfOHNd/M6h7yXUoShWA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bTt7W1G9Gz8t53;
	Sat, 28 Jun 2025 15:09:59 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Peilin Ye <yepeilin@google.com>,
	Jiayuan Chen <mrpre@163.com>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add Spectre v4 tests
Date: Sat, 28 Jun 2025 14:59:27 +0200
Message-ID: <20250628125927.763088-4-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250628125927.763088-1-luis.gerhorst@fau.de>
References: <20250628125927.763088-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following tests:

1. A test with an (unimportant) ldimm64 (16 byte insn) and a
   Spectre-v4--induced nospec that clarifies and serves as a basic
   Spectre v4 test.

2. Make sure a Spectre v4 nospec_result does not prevent a Spectre v1
   nospec from being added before the dangerous instruction (tests that
   [1] is fixed).

3. Combine the two, which is the combination that triggers the warning
   in [2]. This is because the unanalyzed stack write has nospec_result
   set, but the ldimm64 (which was just analyzed) had incremented
   insn_idx by 2. That violates the assertion that nospec_result is only
   used after insns that increment insn_idx by 1 (i.e., stack writes).

[1] https://lore.kernel.org/bpf/4266fd5de04092aa4971cbef14f1b4b96961f432.camel@gmail.com/
[2] https://lore.kernel.org/bpf/685b3c1b.050a0220.2303ee.0010.GAE@google.com/

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../selftests/bpf/progs/verifier_unpriv.c     | 149 ++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a678463e972c..be7d9bfa8390 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -235,4 +235,8 @@
 #define SPEC_V1
 #endif
 
+#if defined(__TARGET_ARCH_x86)
+#define SPEC_V4
+#endif
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 4470541b5e71..28b4f7035ceb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -801,4 +801,153 @@ l2_%=:							\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: ldimm64 before Spectre v4 barrier")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V4
+__xlated_unpriv("r1 = 0x2020200005642020") /* should not matter */
+__xlated_unpriv("*(u64 *)(r10 -8) = r1")
+__xlated_unpriv("nospec")
+#endif
+__naked void unpriv_ldimm64_spectre_v4(void)
+{
+	asm volatile ("					\
+	r1 = 0x2020200005642020 ll;			\
+	*(u64 *)(r10 -8) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: Spectre v1 and v4 barrier")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+#ifdef SPEC_V4
+/* starts with r0 == r8 == r9 == 0 */
+__xlated_unpriv("if r8 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("if r9 == 0x0 goto pc+4")
+__xlated_unpriv("r2 = r0")
+/* Following nospec required to prevent following dangerous `*(u64 *)(NOT_FP -64)
+ * = r1` iff `if r9 == 0 goto pc+4` was mispredicted because of Spectre v1. The
+ * test therefore ensures the Spectre-v4--induced nospec does not prevent the
+ * Spectre-v1--induced speculative path from being fully analyzed.
+ */
+__xlated_unpriv("nospec") /* Spectre v1 */
+__xlated_unpriv("*(u64 *)(r2 -64) = r1") /* could be used to leak r2 */
+__xlated_unpriv("nospec") /* Spectre v4 */
+#endif
+#endif
+__naked void unpriv_spectre_v1_and_v4(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r8 = r0;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r9 = r0;					\
+	r0 = r10;					\
+	r1 = 0;						\
+	r2 = r10;					\
+	if r8 != 0 goto l0_%=;				\
+	if r9 != 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r8 != 0 goto l1_%=;				\
+	goto l2_%=;					\
+l1_%=:	if r9 == 0 goto l3_%=;				\
+	r2 = r0;					\
+l2_%=:	*(u64 *)(r2 -64) = r1;				\
+l3_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: Spectre v1 and v4 barrier (simple)")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+#ifdef SPEC_V4
+__xlated_unpriv("if r8 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("goto pc-1") /* if r9 == 0 goto l3_%= */
+__xlated_unpriv("goto pc-1") /* r2 = r0 */
+__xlated_unpriv("nospec")
+__xlated_unpriv("*(u64 *)(r2 -64) = r1")
+__xlated_unpriv("nospec")
+#endif
+#endif
+__naked void unpriv_spectre_v1_and_v4_simple(void)
+{
+	asm volatile ("					\
+	r8 = 0;						\
+	r9 = 0;						\
+	r0 = r10;					\
+	r1 = 0;						\
+	r2 = r10;					\
+	if r8 != 0 goto l0_%=;				\
+	if r9 != 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r8 != 0 goto l1_%=;				\
+	goto l2_%=;					\
+l1_%=:	if r9 == 0 goto l3_%=;				\
+	r2 = r0;					\
+l2_%=:	*(u64 *)(r2 -64) = r1;				\
+l3_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: ldimm64 before Spectre v1 and v4 barrier (simple)")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+#ifdef SPEC_V4
+__xlated_unpriv("if r8 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+4")
+__xlated_unpriv("goto pc-1") /* if r9 == 0 goto l3_%= */
+__xlated_unpriv("goto pc-1") /* r2 = r0 */
+__xlated_unpriv("goto pc-1") /* r1 = 0x2020200005642020 ll */
+__xlated_unpriv("goto pc-1") /* second part of ldimm64 */
+__xlated_unpriv("nospec")
+__xlated_unpriv("*(u64 *)(r2 -64) = r1")
+__xlated_unpriv("nospec")
+#endif
+#endif
+__naked void unpriv_ldimm64_spectre_v1_and_v4_simple(void)
+{
+	asm volatile ("					\
+	r8 = 0;						\
+	r9 = 0;						\
+	r0 = r10;					\
+	r1 = 0;						\
+	r2 = r10;					\
+	if r8 != 0 goto l0_%=;				\
+	if r9 != 0 goto l0_%=;				\
+	r0 = 0;						\
+l0_%=:	if r8 != 0 goto l1_%=;				\
+	goto l2_%=;					\
+l1_%=:	if r9 == 0 goto l3_%=;				\
+	r2 = r0;					\
+	r1 = 0x2020200005642020 ll;			\
+l2_%=:	*(u64 *)(r2 -64) = r1;				\
+l3_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


