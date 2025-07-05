Return-Path: <linux-kselftest+bounces-36643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C72AFA15B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 21:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA95C1898896
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4E1FF7C5;
	Sat,  5 Jul 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="GVV+PEpr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926D13D51E;
	Sat,  5 Jul 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751743074; cv=none; b=IGtuXqXHOp3efToQrWC/QW2/rQ1HMh/s9HEDjBwrd9kWB/6ZzK5phax22wMX8Emt1yjitF6EH9FyUSuxGwJX3y2R5oDBwUaxS9OHUDoboN8NgTjEvxsB97xeV7tNsCA4LNX0pdOVDElae/76EmJdPQDilaS7FzrqBeZG4+R8DTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751743074; c=relaxed/simple;
	bh=j5uG22crsJ/y1C4GRAvazUHPXZblpH8KK8NGEVxoY9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iefpIp0p7PcA7HMwsdAxsWxYpA+cgV4V4yC+K+KNalTbacL3ANknkz2I753CUAwaeHQ4zwOO0TEk/biuWR4iNhf1EIxWbCNfao4zCPidf5jDmUQw2o/JQmfMZN2A+PzGjCgzvVIlg2ey8a+ZesQGaJEs1VOCYOCIYHeqEaWBynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=GVV+PEpr; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751743070; bh=Evj+fG6s9N1k9Y/Qtzg3/jI7/hNykybGp/AZeC09P5M=;
	h=From:To:Subject:Date:In-Reply-To:References:From:To:CC:Subject;
	b=GVV+PEpraLfjiS10Z79BLtwcPednaN0ufSwq2zfQuHlT2Bx4AeUUKP59q9Y11Ri9T
	 InA2C0PF4BsOi4Tm+5qzU22GbHFSO5fGw2njK9dnqmnxIad2ZlPMqacHVds34atZHu
	 00bgB1ZmUPEyZGjDVk9g4OIuq6DWcyQEZWaJjAdJL1GEyY+KWc41QpTT5Tf2k+B/KA
	 PTHSkhAEP3LBt9dkaoYwKH4vsA7AuoVfej/IfJCmAz6KIPFmLn6isovi65ExxwZbXy
	 Rml98dZBh59IkfFwNVLZ1OIIcE51Bg+f2v5iEugTHzq+HH7soSSXe1R8cxhB+NqA8y
	 6/P4bL0mse5Rw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bZKyk4TLrzPk3F;
	Sat,  5 Jul 2025 21:17:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362a:3200:5d43:2d8a:dc0e:5715
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362a:3200:5d43:2d8a:dc0e:5715])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19Gnp/zcJw7nqVyYmTP7aRe88QKECjNvxQ=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bZKyg0tsFzPjyc;
	Sat,  5 Jul 2025 21:17:47 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Viktor Malik <vmalik@redhat.com>,
	Ihor Solodrai <isolodrai@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add Spectre v4 tests
Date: Sat,  5 Jul 2025 21:09:08 +0200
Message-ID: <20250705190908.1756862-3-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250705190908.1756862-1-luis.gerhorst@fau.de>
References: <20250705190908.1756862-1-luis.gerhorst@fau.de>
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
index 20dce508d8e0..530752ddde8e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -237,4 +237,8 @@
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


