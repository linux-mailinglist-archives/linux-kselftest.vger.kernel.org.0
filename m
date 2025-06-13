Return-Path: <linux-kselftest+bounces-34875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CEAD84C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FCD7A5740
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9C2C158D;
	Fri, 13 Jun 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PbUsx0ia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401A279DB0;
	Fri, 13 Jun 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800268; cv=none; b=evXyOa6UsTzwylwHp1oa9IzrX6uIXpJs9dN4uCNLJ6nONYa2fZQXY7+COWpOXT5N2zAVqRydOXTqe1hrtCJ0Xbui5Z63lZ58SW/Rz/ZAVvo4pQUTQTAcWkODCNhQWXE7ddFcIEPlYfA05avkw/SwrRt2XhIxwa5HvKSHU+aLYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800268; c=relaxed/simple;
	bh=xUaD/nsPE2GIzcFHMYPMvnTmtq7voSyUCXhca+/WzNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UftfqWy7mpQlf1ENBeDEvLTl/LX3k5GnVTokaBmN/6NgWlwMmYi7HzhQXQH4O8Z+sabePiAEHsTwS3UAlevT7f9gepMlr9SaJvIjUu626Ufc3liiQWP9GkblEOL7NRAns3V4CwKPEYZX1xMcvbLSLCoCkmOVcRWy3fgrqADnZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PbUsx0ia; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5C3D4451B;
	Fri, 13 Jun 2025 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749800263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeLleyfYulrm7/2JkDlmDKQ+W0qM+PQ6c1Xd/a6HciU=;
	b=PbUsx0iacezWvrE6A20Xyl+42FRd0/58MVH7JIf9elFbkDG3eJJOpPGahhO/fOwo06e7Gb
	v1In1Q/JhMx10WL0FVaMQLv8yM7qi6hl4gjHJBEBAadUl1AlxaXU/7UanahRe8NY82lPHT
	RIaBdWnX4B0AsjT9RnzYiuAtLL1q9vrkkVxg0R0brkQ9Wd4kPpfHCimyNG1cFEFCLp+eo+
	aZJ1YSyI68DwRMuA/gSfC4kdCpB5pK58wK19PUAQ6eYzrFh0n+serqJ33z6xPgAI6tCkyK
	jpHHzO+7YONhWsDauoIHYDC0ETlCR6ocSRSRHBCtmX/Qt7CSafBTpS9Q9PAfjQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 13 Jun 2025 09:37:14 +0200
Subject: [PATCH bpf 5/7] bpf/powerpc64: use define for max regs count used
 for arguments
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250613-deny_trampoline_structs_on_stack-v1-5-5be9211768c3@bootlin.com>
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
In-Reply-To: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Menglong Dong <imagedong@tencent.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehkedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohepshhvvghnsheslhhinhhugidrihgsmhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

powerpc allows using up to 8 registers to pass arguments between function
calls. This value is hardcoded in multiple places, use a define for this
value.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c0684733e9d6ac79b4cf653bf1b9ad40eb3e1aca..d313920a42c2310c6b5deab6d82e13af49c8ecb1 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -22,6 +22,8 @@
 
 #include "bpf_jit.h"
 
+#define MAX_REGS_FOR_ARGS	8
+
 /* These offsets are from bpf prog end and stay the same across progs */
 static int bpf_jit_ool_stub, bpf_jit_long_branch_stub;
 
@@ -613,7 +615,7 @@ static void bpf_trampoline_save_args(u32 *image, struct codegen_context *ctx, in
 	param_save_area_offset += STACK_FRAME_MIN_SIZE; /* param save area is past frame header */
 
 	for (int i = 0; i < nr_regs; i++) {
-		if (i < 8) {
+		if (i < MAX_REGS_FOR_ARGS) {
 			EMIT(PPC_RAW_STL(_R3 + i, _R1, regs_off + i * SZL));
 		} else {
 			EMIT(PPC_RAW_LL(_R3, _R1, param_save_area_offset + i * SZL));
@@ -626,7 +628,7 @@ static void bpf_trampoline_save_args(u32 *image, struct codegen_context *ctx, in
 static void bpf_trampoline_restore_args_regs(u32 *image, struct codegen_context *ctx,
 					     int nr_regs, int regs_off)
 {
-	for (int i = 0; i < nr_regs && i < 8; i++)
+	for (int i = 0; i < nr_regs && i < MAX_REGS_FOR_ARGS; i++)
 		EMIT(PPC_RAW_LL(_R3 + i, _R1, regs_off + i * SZL));
 }
 
@@ -725,7 +727,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *
 	 * Reserve space for at least 8 registers for now. This can be optimized later.
 	 */
-	bpf_frame_size += (nr_regs > 8 ? nr_regs : 8) * SZL;
+	bpf_frame_size +=
+		(nr_regs > MAX_REGS_FOR_ARGS ? nr_regs : MAX_REGS_FOR_ARGS) *
+		SZL;
 
 	/* Room for struct bpf_tramp_run_ctx */
 	run_ctx_off = bpf_frame_size;

-- 
2.49.0


