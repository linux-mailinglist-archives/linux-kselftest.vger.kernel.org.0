Return-Path: <linux-kselftest+bounces-30623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C993A86739
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49456467632
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A8298CC3;
	Fri, 11 Apr 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="epNuqUzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9C28F945;
	Fri, 11 Apr 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403554; cv=none; b=qofVbXIQgdUTnG79xxJwZB0F0+ftpSBGK5ycUb+oxFjnn0ZABvmx64OewBTjEEFznyqBO2lNoRVytyaDJCnrN6cWSBNaba2giApWmFuUSo+5RwSGK2g9yy6Fi/Lvhn5qbOvXgB/rZ7HXEztUVeaYDtp1T4mVwS75vdfQKg2Atto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403554; c=relaxed/simple;
	bh=HloyfiKjkX/PA8jWhKINWnOcKdN5lYwdXphgi4gbqks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5Pl1UEG7h8p68lDL5c7Z6jZcDEj3WUdN/Kfd2za6ih3FqUs0S/iSGqjzWqjyFw69egnBV8YzZt6tm5YK/O1lW/WbiyAYcKpoCJsVyxZP9rOn2H+0RtER8YMq2YtKfEnW7mnZAkfa3P3ZGmOxUaYstf4UJo63svZQvtbhmzk/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=epNuqUzg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68733439F5;
	Fri, 11 Apr 2025 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744403543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1LEEOj+dRfAxqML0b7ZiCS95DdAAf0qejLXDfRihnk=;
	b=epNuqUzgNVnwVYaVaVvzgEHjHohpnkYYZdTN5Cs1TMjSCVY5TnZv/cwwLKcoByehiP9mQv
	Slcom2nwmqxj/wDz0krvJG7A5sbXZDaCvPfpP+mo3X5PPZ4XyevvfxmvhNgX2nUwI39M/t
	6PeRwfRO0fp9OGqWj3Q+NyRjB1s0414UbuV2X58QYWd3JpDDlSlxI+4OhbbOWQOuniFtfZ
	Z6dUQuBpF74Iv/gSZFntRnLUx2WOkzzFoT76wH1/jpnd71MJrdQs+qIuk22cocqtbFVQgj
	27e6YPQySVwhGPcTmXduwVhxOV++HOyrWkpA3NSgL2PhUrhiZa3Hz114eBazag==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 11 Apr 2025 22:32:12 +0200
Subject: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
In-Reply-To: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhorucdlvgeurffhucfhohhunhgurghtihhonhdmuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeljeektefffeevleegkeelhfethffgieegudevffejheelieeffeejtddujeegueenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

When dealing with large types (>8 bytes), ARM64 trampolines need to take
extra care about the arguments alignment to respect the calling
convention set by AAPCS64.

Add two tests ensuring that the BPF trampoline arranges arguments with
the relevant layout. The two new tests involve almost the same
arguments, except that the second one requires a more specific alignment
to be set by the trampoline when preparing arguments before calling the
the target function.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/tracing_struct.c      | 23 ++++++++
 tools/testing/selftests/bpf/progs/tracing_struct.c | 10 +++-
 .../selftests/bpf/progs/tracing_struct_many_args.c | 67 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 50 ++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index 19e68d4b353278bf8e2917e62f62c89d14d7fe80..ecb5d38539f8b2fc275f93713ce2a7aad908b929 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -108,6 +108,29 @@ static void test_struct_many_args(void)
 	ASSERT_EQ(skel->bss->t9_i, 27, "t9:i");
 	ASSERT_EQ(skel->bss->t9_ret, 258, "t9 ret");
 
+	ASSERT_EQ(skel->bss->t10_a_a, 27, "t10:a.a");
+	ASSERT_EQ(skel->bss->t10_a_b, 28, "t10:a.b");
+	ASSERT_EQ(skel->bss->t10_b_a, 29, "t10:b.a");
+	ASSERT_EQ(skel->bss->t10_b_b, 30, "t10:b.b");
+	ASSERT_EQ(skel->bss->t10_c_a, 31, "t10:c.a");
+	ASSERT_EQ(skel->bss->t10_c_b, 32, "t10:c.b");
+	ASSERT_EQ(skel->bss->t10_d_a, 33, "t10:d.a");
+	ASSERT_EQ(skel->bss->t10_d_b, 34, "t10:d.b");
+	ASSERT_EQ(skel->bss->t10_e, 35, "t10:e");
+	ASSERT_EQ(skel->bss->t10_f_a, 36, "t10:f.a");
+	ASSERT_EQ(skel->bss->t10_f_b, 37, "t10:f.b");
+
+	ASSERT_EQ(skel->bss->t10_ret, 352, "t10 ret");
+
+	ASSERT_EQ(skel->bss->t11_a, 38, "t11:a");
+	ASSERT_EQ(skel->bss->t11_b, 39, "t11:b");
+	ASSERT_EQ(skel->bss->t11_c, 40, "t11:c");
+	ASSERT_EQ(skel->bss->t11_d, 41, "t11:d");
+	ASSERT_EQ(skel->bss->t11_e, 42, "t11:e");
+	ASSERT_EQ(skel->bss->t11_f, 43, "t11:f");
+
+	ASSERT_EQ(skel->bss->t11_ret, 243, "t11 ret");
+
 destroy_skel:
 	tracing_struct_many_args__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index c435a3a8328ab1580c63967a7f0ab779aa7ca4d4..feabf618a2e011b0d08eeaa6cc09fba1922ecb3f 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -18,6 +18,15 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
+struct bpf_testmod_struct_arg_4 {
+	__u64 a;
+	__u64 b;
+};
+
+struct bpf_testmod_struct_arg_5 {
+	__int128 a;
+};
+
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -25,7 +34,6 @@ long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
 long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
 long t5_ret;
 int t6;
-
 SEC("fentry/bpf_testmod_test_struct_arg_1")
 int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, b, int, c)
 {
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
index 4742012ace06af949d7f15a21131aaef7ab006e4..6f086b3d32d5f89e426aa4b79daa24bdb42861db 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
@@ -18,6 +18,14 @@ struct bpf_testmod_struct_arg_5 {
 long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
 long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
 long t9_a, t9_b, t9_c, t9_d, t9_e, t9_f, t9_g, t9_h_a, t9_h_b, t9_h_c, t9_h_d, t9_i, t9_ret;
+__u64 t10_a_a, t10_a_b, t10_b_a, t10_b_b, t10_c_a, t10_c_b, t10_d_a, t10_d_b,
+	t10_f_a, t10_f_b;
+short t10_e;
+int t10_ret;
+__int128 t11_a, t11_b, t11_c, t11_d, t11_f;
+short t11_e;
+int t11_ret;
+
 
 SEC("fentry/bpf_testmod_test_struct_arg_7")
 int BPF_PROG2(test_struct_many_args_1, __u64, a, void *, b, short, c, int, d,
@@ -92,4 +100,63 @@ int BPF_PROG2(test_struct_many_args_6, __u64, a, void *, b, short, c, int, d, vo
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(test_struct_many_args_7, struct bpf_testmod_struct_arg_4, a,
+	      struct bpf_testmod_struct_arg_4, b,
+	      struct bpf_testmod_struct_arg_4, c,
+	      struct bpf_testmod_struct_arg_4, d, short, e,
+	      struct bpf_testmod_struct_arg_4, f)
+{
+	t10_a_a = a.a;
+	t10_a_b = a.b;
+	t10_b_a = b.a;
+	t10_b_b = b.b;
+	t10_c_a = c.a;
+	t10_c_b = c.b;
+	t10_d_a = d.a;
+	t10_d_b = d.b;
+	t10_e = e;
+	t10_f_a = f.a;
+	t10_f_b = f.b;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(test_struct_many_args_8, struct bpf_testmod_struct_arg_4, a,
+	      struct bpf_testmod_struct_arg_4, b,
+	      struct bpf_testmod_struct_arg_4, c,
+	      struct bpf_testmod_struct_arg_4, d, short, e,
+	      struct bpf_testmod_struct_arg_4, f, int, ret)
+{
+	t10_ret = ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_11")
+int BPF_PROG2(test_struct_many_args_9, struct bpf_testmod_struct_arg_5, a,
+	      struct bpf_testmod_struct_arg_5, b,
+	      struct bpf_testmod_struct_arg_5, c,
+	      struct bpf_testmod_struct_arg_5, d, int, e,
+	      struct bpf_testmod_struct_arg_5, f)
+{
+	t11_a = a.a;
+	t11_b = b.a;
+	t11_c = c.a;
+	t11_d = d.a;
+	t11_e = e;
+	t11_f = f.a;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_11")
+int BPF_PROG2(test_struct_many_args_10, struct bpf_testmod_struct_arg_5, a,
+	      struct bpf_testmod_struct_arg_5, b,
+	      struct bpf_testmod_struct_arg_5, c,
+	      struct bpf_testmod_struct_arg_5, d, int, e,
+	      struct bpf_testmod_struct_arg_5, f, int, ret)
+{
+	t11_ret = ret;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f38eaf0d35efa712ec288f06983c86b02c0d3e0e..96c80da725c978f2e48df8602dd63155971a7bf6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -62,6 +62,15 @@ struct bpf_testmod_struct_arg_5 {
 	long d;
 };
 
+struct bpf_testmod_struct_arg_6 {
+	u64 a;
+	u64 b;
+};
+
+struct bpf_testmod_struct_arg_7 {
+	__int128 a;
+};
+
 __bpf_hook_start();
 
 noinline int
@@ -128,6 +137,29 @@ bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int bpf_testmod_test_struct_arg_10(struct bpf_testmod_struct_arg_6 a,
+					    struct bpf_testmod_struct_arg_6 b,
+					    struct bpf_testmod_struct_arg_6 c,
+					    struct bpf_testmod_struct_arg_6 d,
+					    short e,
+					    struct bpf_testmod_struct_arg_6 f)
+{
+	bpf_testmod_test_struct_arg_result =
+		a.a + a.b + b.a + b.b + c.a + c.b + d.a + d.b + e + f.a + f.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int bpf_testmod_test_struct_arg_11(struct bpf_testmod_struct_arg_7 a,
+					    struct bpf_testmod_struct_arg_7 b,
+					    struct bpf_testmod_struct_arg_7 c,
+					    struct bpf_testmod_struct_arg_7 d,
+					    short e,
+					    struct bpf_testmod_struct_arg_7 f)
+{
+	bpf_testmod_test_struct_arg_result = a.a + b.a + c.a + d.a + e + f.a;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
@@ -394,6 +426,16 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
 	struct bpf_testmod_struct_arg_5 struct_arg5 = {23, 24, 25, 26};
+	struct bpf_testmod_struct_arg_6 struct_arg6_a = {27, 28};
+	struct bpf_testmod_struct_arg_6 struct_arg6_b = {29, 30};
+	struct bpf_testmod_struct_arg_6 struct_arg6_c = {31, 32};
+	struct bpf_testmod_struct_arg_6 struct_arg6_d = {33, 34};
+	struct bpf_testmod_struct_arg_6 struct_arg6_f = {36, 37};
+	struct bpf_testmod_struct_arg_7 struct_arg7_a = {38};
+	struct bpf_testmod_struct_arg_7 struct_arg7_b = {39};
+	struct bpf_testmod_struct_arg_7 struct_arg7_c = {40};
+	struct bpf_testmod_struct_arg_7 struct_arg7_d = {41};
+	struct bpf_testmod_struct_arg_7 struct_arg7_f = {43};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -411,6 +453,14 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	(void)bpf_testmod_test_struct_arg_9(16, (void *)17, 18, 19, (void *)20,
 					    21, 22, struct_arg5, 27);
 
+	(void)bpf_testmod_test_struct_arg_10(struct_arg6_a, struct_arg6_b,
+					     struct_arg6_c, struct_arg6_d, 35,
+					     struct_arg6_f);
+
+	(void)bpf_testmod_test_struct_arg_11(struct_arg7_a, struct_arg7_b,
+					     struct_arg7_c, struct_arg7_d, 42,
+					     struct_arg7_f);
+
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
 	(void)trace_bpf_testmod_test_raw_tp_null(NULL);

-- 
2.49.0


