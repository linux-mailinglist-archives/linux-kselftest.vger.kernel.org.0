Return-Path: <linux-kselftest+bounces-24566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F1A12240
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D37188BFAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FA23F27D;
	Wed, 15 Jan 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="bMtaM99w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vwKAEsDy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B31EEA2A;
	Wed, 15 Jan 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939660; cv=none; b=bGqSfn0Nt58dgrr4n8BC2quMRVJcGi3fCTd1uQi1VuJ9Q+a0iCOxkmU5atF6tqSnHfYnBPh3i03JE260t01Gnu45nbV1zJQvMuS77ZW2cmT2dzBKEiusaQV5+2M00MW8rQawQt4KM5TSI3/bRNjIvcYVS0PKIJ73mHlAePDJ6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939660; c=relaxed/simple;
	bh=Bd0I0lIMKMC4KxEOjUIKWSGVerkNEic9IL2ALFZ+R48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzybQIif7ZBlQ6e+TUZNdRDWhQSG5uJtb4iEIbDfX83hosZO5HV79cZpzQAOqWLS74DCiYlC/35Lfc54xPVi8x3eEpmBoqtLNysPIo3sdeQrrAWlaKpD/XzGvUzUB7+xZr6HUTzesItzUwo3/ismIE3xWddsv0XN+4wa8TE8Y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=bMtaM99w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vwKAEsDy; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id EB8BD200F84;
	Wed, 15 Jan 2025 06:14:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 15 Jan 2025 06:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736939656; x=1736946856; bh=WfiGYnphGq
	vudtD6RXFjAbGTohKPfJnsfNrRsHzlEL4=; b=bMtaM99wg2t0sGsWBBr9DRK+d4
	6ElpWK4uVOU6I3S3fC5DrwS6XS5Bop4pBipUtYzdgo4tTPDBqilV9gQjblb7pgKW
	ZThERb5+upl9p5jRj57trl5UY5G6X2fdNebgjKdTBbk3bj83Kam9brdokLXr8JZ8
	sm/eCiITI9F33g6DwKwtci7MDQ3jW5GpP8Vq0mtdZYzxCQqwass2ShGCvnRPmesg
	XbYrGe0uVK1I6L/cI3kppZskPKPTdMOvWypAUCdu3h7I+FB5NF/w884oue9CZ61/
	7q8cgJu5xGBsC4KeuTZaxkZCi6zyvvQ20ysPThLy0CZU5UqFks8YOFrG2z0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736939656; x=
	1736946856; bh=WfiGYnphGqvudtD6RXFjAbGTohKPfJnsfNrRsHzlEL4=; b=v
	wKAEsDy3E1Ykbo7zHQnkulDZ0dw9Uq6wZLJvdF2P1jPNEiKelP0sTZHWecUpSK4E
	bZStqGKG+BWi+Jjfx5jbblUqXArW/EGqqg14euV5qQYyzba7tFTFLGOSeQb/hO2w
	BhJ/RVMEp3kiuEfKLJNM3uARulwsZNbAZ7MMiV+QizNSIKk76aOoNQ5bxToWdwJe
	5o41MBSDvENrjJidvtEzU66HcKY8fRr5if0H+hCPb+OwmayemsQU48Q5BuaJM2wR
	ju6vialqhZEfzvRe44PPV3Y3senx75wSOtZz2WJsQh2SJV8sZWdQfOAjzh4hBWXP
	mi+rHqlywRwL0ECEM7ydg==
X-ME-Sender: <xms:h5iHZ-TzRbIO_gAYgOY3VjI37faIMleEBMRyQg1mH2UYXw-ZC9c3gA>
    <xme:h5iHZzzMDZdpqhi8-3UCyQuNzYuPkbMOijBVB3w_ZwZu29Ln9Xfp8fCtSOYoFkUKF
    H4bf0YYuIMehl57Zcs>
X-ME-Received: <xmr:h5iHZ701Dv2nER0iSRwOguAnlOIELdt3JTr-saL7J-ngotIr8JoimO5satG9xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfh
    rhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeuiefgudffleffgeeiffeffeefieelveejgfeh
    hfejffeutedvffeiudevtdelgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhestgho
    vghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlughvsehsthhrrggtvgdrihhopdhrtghpthhtoh
    eptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepsghjohhrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgvseifiehriidrnhgvthdprhgtphhtthhopegvsghivgguvghrmhes
    gihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepiihhohhuqhhurghnsehishgtrghsrd
    grtgdrtghnpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h5iHZ6AbdDiaMlJd_NyE9h9pPGqoL_kyecAzvQerQGY8KB27T5dJWw>
    <xmx:h5iHZ3hHBc73k9glAiSDdcm7NroFQbFOENCPeXjCT3KAFD6rdM9vWA>
    <xmx:h5iHZ2ra--n3r_7B1hIiNVqhpm8du3UvDp9sGXuXtEWx9g1VAGLBFQ>
    <xmx:h5iHZ6jMzJ4kt3dFosbgxo_BlqEZmh2UvEOCMFVypzI6wsJkyZR-MQ>
    <xmx:iJiHZ2S6O8oxGyN1Xc2vmjzK2g89oGa8otkdEQJzfWP--6K5l_UKeFWV>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 06:14:14 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Wed, 15 Jan 2025 19:13:27 +0800
Subject: [PATCH v6 1/3] riscv/ptrace: add new regset to access original a0
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-riscv-new-regset-v6-1-59bfddd33525@coelacanthus.name>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
In-Reply-To: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
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
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9PYZ5VutbCad5Tn5ndOR38uJYV7Dv+6vnvq+FfPTO
 Y/NcE6L4e4oZWEQ42KQFVNkySth+cl56Wz33o7tXTBzWJlAhjBwcQrAROaGMTI8d991KlKo4aFX
 I19XSsrdpJofD4xDWCJfvDU3FFGb/7qL4X8Ux5rc0wu8ddemZqSnL2Bb/XjS3wA172m/l4Umzts
 xwZIDAL8wRz0=
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


