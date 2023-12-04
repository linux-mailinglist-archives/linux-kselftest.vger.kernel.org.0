Return-Path: <linux-kselftest+bounces-1087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B941804090
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E9BB20B16
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228939FD0;
	Mon,  4 Dec 2023 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iaWCqT43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTSs0rUb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046D109;
	Mon,  4 Dec 2023 12:57:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id D52F5580A24;
	Mon,  4 Dec 2023 15:57:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Dec 2023 15:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723423; x=
	1701730623; bh=/AYNOAxNgVK/QVMc0AlL/YbO7UaSJXnY0NdrYpUsy9Q=; b=i
	aWCqT43SnhJ5KTCoNaEy0tR9bDLEH3vIzv7YXNoSTng5i9R21EoQhYYRDL39YTyx
	14I32NFORjRllKNYrAK4XvlR3SJiTZTFF4sPF3ZxSd6sUWPILhIl070EKuY9GZDN
	D5GE67zTCF/9PMeJ2EYeN8B0YHa7nA82869B7hTQHI7lJtPdr6YAK0gy4tIgTggB
	hVfYJK7PDGT5lBWRB/Ag7+pypY+wPe3YqWUspkzlRI/AZJM+Bvdq7dTEGofPIbe6
	/PUbTYGVBWZvxeiS7gHv0xWz4PHjhc/GvXqOJYaqjxuAkxAahVkTQNCYp14dh6Ku
	HaFwt/UpJSrj+tPmRDqdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723423; x=
	1701730623; bh=/AYNOAxNgVK/QVMc0AlL/YbO7UaSJXnY0NdrYpUsy9Q=; b=z
	TSs0rUbTwxt2RjQKOSbpuhsKpMFA+3+x1XBr1ZxqJnJeRDQ5A30omOfDcDl/O0jr
	aMcmuVWHQNmr+KoKjOjhhqTT+boPx9eUi5gz39A4Axere3B5oR4BWIAsU/APi4Vt
	r2z777pJuknmjtLkCKXlWYFoN0vk7fEN1x4XU4GEhlkWUgL4eUMf9e66RzQ+fFya
	blNuxbaIRAPyfQnYJgFLm1SfKrbXpTP+14htQEXZzsTOgmnEC0aAG0Ogi9rbx9im
	epn+L/fpu+Fh+tdh4WNGDqFqjdsOhF4zqsPQqTQwTr9hYl6JH6DSGGBvwRA0+37Z
	M451XpXZZDP2h2QiugtlA==
X-ME-Sender: <xms:Hz1uZdhJahVnai90RN2bLIqqArTLL4vrn8S7kbCKfpzYqzKmpI1Rwg>
    <xme:Hz1uZSCdr0e92TQxOVKaLJxc6KBVcJ16tKj9bvVaYxhEyfgcUQXsIhYuOPY61lrKJ
    0kVw13jZvvloK9JYg>
X-ME-Received: <xmr:Hz1uZdH-0N3jbfoJr1xHtwWROwafuYhax68A_w05PiAAuhIXF7hyXXGPc2SmYijPZ3vXzd5gcUdNS1NDsCenUTLFBR3bbbpkMl5AhWBKsWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Hz1uZSSxe6KeipOMyA0OrzaU07fp7J6ccLDJTETgdS4h7b5CxK_FAQ>
    <xmx:Hz1uZayIRBFO2CtQNaDRWAY7APnX5Kh4XoC0sqLVjAxVshnardyrjA>
    <xmx:Hz1uZY5Vb5SZnrAqEOrP7I5sB1V2j_OZ6dhh_PfTDiqqfz0iqDJXSQ>
    <xmx:Hz1uZXwOA-EfworqvGj-CIwoFN0CGnRg3KB4qY6kfsWKiE5keon_ag>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:57:02 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 06/10] libbpf: selftests: Add verifier tests for CO-RE bitfield writes
Date: Mon,  4 Dec 2023 13:56:26 -0700
Message-ID: <d47d9105686551f0435091f45888bc64d1101bd4.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
non-trivial bit fiddling is going on, make sure various edge cases (such
as adjacent bitfields and bitfields at the edge of structs) are
exercised.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8d746642cbd7..ac49ec25211d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
+#include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
@@ -116,6 +117,7 @@ static void run_tests_aux(const char *skel_name,
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
+void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
new file mode 100644
index 000000000000..623f130a3198
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <stdint.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+
+struct core_reloc_bitfields {
+	/* unsigned bitfields */
+	uint8_t		ub1: 1;
+	uint8_t		ub2: 2;
+	uint32_t	ub7: 7;
+	/* signed bitfields */
+	int8_t		sb4: 4;
+	int32_t		sb20: 20;
+	/* non-bitfields */
+	uint32_t	u32;
+	int32_t		s32;
+} __attribute__((preserve_access_index));
+
+SEC("tc")
+__description("single CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success
+__retval(3)
+int single_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 3);
+	return BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+}
+
+SEC("tc")
+__description("multiple CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success
+__retval(0x3FD)
+int multiple_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint8_t ub2;
+	int8_t sb4;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, sb4, -1);
+
+	ub2 = BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+	sb4 = BPF_CORE_READ_BITFIELD(&bitfields, sb4);
+
+	return (((uint8_t)sb4) << 2) | ub2;
+}
+
+SEC("tc")
+__description("adjacent CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success
+__retval(7)
+int adjacent_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint8_t ub1, ub2;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub1, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 3);
+
+	ub1 = BPF_CORE_READ_BITFIELD(&bitfields, ub1);
+	ub2 = BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+
+	return (ub2 << 1) | ub1;
+}
+
+SEC("tc")
+__description("multibyte CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success
+__retval(0x21)
+int multibyte_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint32_t ub7;
+	uint8_t ub1;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub1, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub7, 16);
+
+	ub1 = BPF_CORE_READ_BITFIELD(&bitfields, ub1);
+	ub7 = BPF_CORE_READ_BITFIELD(&bitfields, ub7);
+
+	return (ub7 << 1) | ub1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.1


