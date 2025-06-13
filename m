Return-Path: <linux-kselftest+bounces-34872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D0AD84AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0EB3A606D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89F226B74A;
	Fri, 13 Jun 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cAFx4niw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524202F2C48;
	Fri, 13 Jun 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800262; cv=none; b=tYw9Bgvb1ohUnXE+934SlG4FpMITrmqlW/QkTR1TN/InxLdtRNeuOiYDygTPE6XDqEJa1Uifq9RlXuk1SMQw1v6fOdVtcn8paiTdMtmQQzWs2naQ/bnYYz4Fpi2EsYx5dd0sLXmbrp/YZogqaFumo6jE6/HEsGbasdd6O2BtsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800262; c=relaxed/simple;
	bh=r99sJfu4ewPRyz0zJbWXJMYkpw47S2rIyZaupP+jn1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asnr47XufE5fM8TKd2uS9Q22SnFePE6xGBSbevUIqLe4fp0vfNcbj68wTFcECBqwsgG7OOgzYYpy1yk8THmF000Mq1b6jGeuyrnIqEfUu3pcKIFV1ExjtSiqOQFaWGCm9fshQScR1/dF5bAPKh4uSOleAK/74+XlUI8Nx2lN5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cAFx4niw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCC6B44506;
	Fri, 13 Jun 2025 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749800250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWrXudQ87v1aByOGhl67T4UU7KUM5mT6FEm5oZqhcLg=;
	b=cAFx4niwDDsyQFKGdmMcGf11CvIpcE6i60PNTLVL6XAEHr8QsvAnUtPgghd0BMq2R+ppDC
	FFai5U507SCN+pyoN6wuDoWlTMOjSSoP4TnpNxYiC+w0QbX1ZUzPQlhl134JonesXJvjFx
	OWDw6aSbLFZe7FDXXsBj2S+b7DQHMXAKYwDHAWLiIwLUr5ryMSKFEAsH//6LX4WvBNf7+B
	RTSk1TpiSwF389Xnh71A9SzYutIAanBG+/eJ2O3NS8i6MD2qG3qY8IPYR+kJcbwUdA/tQF
	SzpnBSDBVvIxVqUtGLlQS7VmjGVpj6a1tNP17AMJbhSHMVv02WVX06WVxtBTDQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 13 Jun 2025 09:37:10 +0200
Subject: [PATCH bpf 1/7] bpf/x86: use define for max regs count used for
 arguments
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250613-deny_trampoline_structs_on_stack-v1-1-5be9211768c3@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehkedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohepshhvvghnsheslhhinhhugidrihgsmhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

x86 allows using up to 6 registers to pass arguments between function
calls. This value is hardcoded in multiple places, use a define for this
value.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/net/bpf_jit_comp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc1817f97d2cd1c55d1575803f6958..9689834de1bb1a90fdc28156e0e2a56ac0ff2076 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -61,6 +61,8 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 #define EMIT_ENDBR_POISON()
 #endif
 
+#define MAX_REGS_FOR_ARGS	6
+
 static bool is_imm8(int value)
 {
 	return value <= 127 && value >= -128;
@@ -2710,10 +2712,10 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 
 	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
 		arg_regs = (m->arg_size[i] + 7) / 8;
-		if (nr_used_regs + arg_regs <= 6)
+		if (nr_used_regs + arg_regs <= MAX_REGS_FOR_ARGS)
 			nr_used_regs += arg_regs;
 
-		if (nr_used_regs >= 6)
+		if (nr_used_regs >= MAX_REGS_FOR_ARGS)
 			break;
 	}
 
@@ -2751,7 +2753,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 		 * the arg1-5,arg7 will be passed by regs, and arg6 will
 		 * by stack.
 		 */
-		if (nr_regs + arg_regs > 6) {
+		if (nr_regs + arg_regs > MAX_REGS_FOR_ARGS) {
 			/* copy function arguments from origin stack frame
 			 * into current stack frame.
 			 *
@@ -2811,7 +2813,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 	 */
 	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
 		arg_regs = (m->arg_size[i] + 7) / 8;
-		if (nr_regs + arg_regs <= 6) {
+		if (nr_regs + arg_regs <= MAX_REGS_FOR_ARGS) {
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW,
 					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
@@ -2824,7 +2826,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 			stack_size -= 8 * arg_regs;
 		}
 
-		if (nr_regs >= 6)
+		if (nr_regs >= MAX_REGS_FOR_ARGS)
 			break;
 	}
 }
@@ -3149,7 +3151,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off = stack_size;
 
-	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
+	if (nr_regs > MAX_REGS_FOR_ARGS && (flags & BPF_TRAMP_F_CALL_ORIG)) {
 		/* the space that used to pass arguments on-stack */
 		stack_size += (nr_regs - get_nr_used_regs(m)) * 8;
 		/* make sure the stack pointer is 16-byte aligned if we

-- 
2.49.0


