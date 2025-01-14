Return-Path: <linux-kselftest+bounces-24513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F8A111D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C298B7A29F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B320CCFD;
	Tue, 14 Jan 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="FmrjpT07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkS5xN+S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B720C488;
	Tue, 14 Jan 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886329; cv=none; b=fuCbsTgid7HtnOvQzwYVD3JNSp94noFl4lR4bJ8br5JNvmOPMt611Eg7ELLOirsbQpv2lzezU1U2onWJb7AWhv0+zN8zi7tBd70CvmaUjXY6kGewO+g/d26a+fRYFUl59shmlPup9KNQhwc4ZfhovLF0uFMGj+F5K5fPG8RB/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886329; c=relaxed/simple;
	bh=Bd0I0lIMKMC4KxEOjUIKWSGVerkNEic9IL2ALFZ+R48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ilf9cA7XHubBYiibjM6G2drcPGH/BCZlIGPTX7fnr6LYVyk+6swQRDRIcvsIstNLF1t0z63h7aAOfCIuk0okSMLs6cG9QfzbJ6jTNWvczVHKY9+3ljNUnn5G/pnsA26a+Y2RyFwgCUlFeCxw7gojwtbegK6QEAQSrnqfsDv1gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=FmrjpT07; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkS5xN+S; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 6CA841D40BEE;
	Tue, 14 Jan 2025 15:25:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jan 2025 15:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736886326; x=1736893526; bh=WfiGYnphGq
	vudtD6RXFjAbGTohKPfJnsfNrRsHzlEL4=; b=FmrjpT07YapVSFaY1sGnvFnz1X
	V3Wm4K9jF/8ZFsbjNyEHtlB+iE5FhcNl8xWf+/4OldWNfafM0TAwhl8aCBlTofh8
	UqTU7IIEtFUcVJedu8CbGfZ3RYegTh+OlhwwmbCv1bmiELDc1Zyyw0v/k3xAcPTg
	+cpw3JxrMj3tksGRxA86I2rOXftWQdLa+sao9gXpV0Uki+oqmlXv3j8xhLtYM4kQ
	yD20dABste7apThlgQ9Sa1qTW9r6YOkPuj4CBEkdlrxFXeAE+XNTIJsDjPBlogSh
	mLtlzIKSZN94apzID/Y1LN1G1aob8JOf3aMvbvqZN1DyuwhAZiy4+X5v9HEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736886326; x=
	1736893526; bh=WfiGYnphGqvudtD6RXFjAbGTohKPfJnsfNrRsHzlEL4=; b=D
	kS5xN+SrokCOeuGkeA0Rdl4Iche77/VAi327Qoasu9ZzmyB87bixfvKkTIMLX3vB
	nkNc/BinfuUlHmTOzlZZ7hU2L3r+KJ6lmyualOmSRHNVQXzJMqZeG+8PwDRKgS5B
	gXY9oklDQ4114W1eADDOTQp9U4hqLc6pTWRtdKALxkl7gYqE3Px3P1WbPI8hoyAm
	vhL0t/blkS+migWR31gbiU+VTYyCWoQ5aPseWYq3+gag/tE1yErRRAUUBxBUlEah
	DWXimM6yNxZ9eBda4zxRJ8AVZFN832dvhooTghHnOm3qvGXxysl3WpwyGUtJubxl
	lNn3yDn3jX0LoOJB+limg==
X-ME-Sender: <xms:NciGZ_LAYEY89IPy9tZNkEECacWIUsVz6LhZUbWymAxu9EzEvLTb1w>
    <xme:NciGZzKvmee4bRhjDWOXnbbyr6nfBbenRZf0QHN7JXM1YbRALlmbosNptsoajVPGn
    WBkvr3G42_OCElHQnc>
X-ME-Received: <xmr:NciGZ3vcToVEMPiNKXM0DImFLeWH-OfXFVcjOLRh24oD94bXxzIvdBmonIi5Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthh
    hushdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuiefgudffleffgeeiffeffeefieel
    veejgfehhfejffeutedvffeiudevtdelgeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhif
    uhestghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtg
    homhdprhgtphhtthhopehfvghlihigohhnmhgrrhhssegrrhgthhhlihhnuhigrdhorhhg
    pdhrtghpthhtoheplhguvhesshhtrhgrtggvrdhiohdprhgtphhtthhopehtghhlgieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhu
    shdrnhgrmhgvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhouhhquhgrnhes
    ihhstggrshdrrggtrdgtnh
X-ME-Proxy: <xmx:NciGZ4bO8cwhk4-uRV0eZfRV6hSiI_tEdmWZabv9LRTHHgYg6V6WOA>
    <xmx:NciGZ2YXTVYXTZ_yCzfIYqYalplE8HdGiIDiBJiwtNGNK4IiBfDmHg>
    <xmx:NciGZ8A2x4hjK9eakMRBxIjgRkjryQHr9Bqoz02iLvDu9upqIyM82Q>
    <xmx:NciGZ0ZhoKMWvlMfnTFAraZ7egopmUFY98diACn4Gi09PxqwjsJpCA>
    <xmx:NsiGZyKYvMmwzYyeJFReKdwFq0HtBTp0o00acWOEI0hWn_ki4C_s1Izn>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:25:24 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Wed, 15 Jan 2025 04:24:58 +0800
Subject: [PATCH v5 1/2] riscv/ptrace: add new regset to access original a0
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-riscv-new-regset-v5-1-d0e6ec031a23@coelacanthus.name>
References: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
In-Reply-To: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
To: Oleg Nesterov <oleg@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, 
 Andrea Bolognani <abologna@redhat.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>, stable@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3197; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=Bd0I0lIMKMC4KxEOjUIKWSGVerkNEic9IL2ALFZ+R48=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9LYTahxei2+ZK7gL31/p1LKEL+S0u9TWg2pWopNOn
 ch+9jLbmr2jlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAE1nRz8jQulbWYqJDmdS9
 yH0Xd0ZtaImSZtoiOvOPRm3rh46tD2JXMjJMt7t61ztq0xrZnQ+9mjfNvhsjKVJToZO/aUXVeeO
 /8z/yAADK3kiB
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 arch/riscv/kernel/ptrace.c | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a583683b922fe2c017ea61f3bc848db..ef9ab74c8575a5c440155973b1c625c06a867c97 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -31,6 +31,7 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_SUPM
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+	REGSET_ORIG_A0,
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -184,6 +185,29 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
+static int riscv_orig_a0_get(struct task_struct *target,
+			     const struct user_regset *regset,
+			     struct membuf to)
+{
+	return membuf_store(&to, task_pt_regs(target)->orig_a0);
+}
+
+static int riscv_orig_a0_set(struct task_struct *target,
+			     const struct user_regset *regset,
+			     unsigned int pos, unsigned int count,
+			     const void *kbuf, const void __user *ubuf)
+{
+	unsigned long orig_a0 = task_pt_regs(target)->orig_a0;
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
+	if (ret)
+		return ret;
+
+	task_pt_regs(target)->orig_a0 = orig_a0;
+	return 0;
+}
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -224,6 +248,14 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+	[REGSET_ORIG_A0] = {
+		.core_note_type = NT_RISCV_ORIG_A0,
+		.n = 1,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.regset_get = riscv_orig_a0_get,
+		.set = riscv_orig_a0_set,
+	},
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cecc0f9de90ee66bfffd2137f4275a8..390060229601631da2fb27030d9fa2142e676c14 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -452,6 +452,7 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_ORIG_A0	  0x903	/* RISC-V original a0 register */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */

-- 
2.48.0


