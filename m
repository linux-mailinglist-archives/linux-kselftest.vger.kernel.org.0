Return-Path: <linux-kselftest+bounces-22727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEB9E17A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20E0165A96
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915A1DFDB7;
	Tue,  3 Dec 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="Y8XnSfaG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPXR3S4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F981DFD83;
	Tue,  3 Dec 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218267; cv=none; b=DJtutMBbfN5rh/JAW0jtvREVPeeoYYSz69jYU4H8YzN4YDMogtlZNkQBrIa0c7BpdCFkjzgD3vpZ+QPTQkhPsoHq3Y22iTcRZq0RH6/3RWcHm6EGxsEgJaeAMIvnJa6syh4Pbo83Mll5KjbrLdIGrv96611PCtgNYTWDJD2s++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218267; c=relaxed/simple;
	bh=iHUx8lM5PnkP98ImrmiiCww6XfAXRjB9rUvZRyb0f/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMUT7ZbV+e8Q94n19/WmvEwndZvvqaYkJG0wzL8cboexPWyBXIsq8Zm4FZPrpBXiQr8Pas+2dAGz2QpNaQ0OpGAUoOc6yMcfFuUtwMfHxNv20UKRiGNCH9vdCUFmtlUZPOriFrYI8Fyxwi1QfLABp6DabqYZMHcejO3ZZlbSFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=Y8XnSfaG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPXR3S4L; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id BD0E31D40992;
	Tue,  3 Dec 2024 04:31:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Dec 2024 04:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1733218262; x=1733221862; bh=DqUcVM7Nni
	c2BeS/tLup4JAADHIhGLFVw8qHcQEoBuU=; b=Y8XnSfaGjsUsAWkTI7hUPImXiT
	h0To34fkyIbcSQK/grJ5TkMG748jH+wj/mlUgysHW68SMX3Keag/noeY3mS2Ab9h
	WViz8KUxHufTFOfOO0SDFxyCNaBYcHW9Xdlu1vE/HUfZ05bPtAJgEYVRzvWM2nyz
	7fsAg7VpNkJWMKeuHjSdzxnJE2KaIw0/+4wKP11NpkJRjYLjEX1vCFz1je2cPQUO
	KikvnvUGgWMMBC2AAmUAFoZKeeJBQoFBvKggWE4eUt9WEzwo4/2y1gim7zGj3Jc1
	xZoZjjz4p65uaLyf1cfphQMbWmZFZK1xEqOOJp/rRdx5NSGpJkey6l5QK7XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733218262; x=
	1733221862; bh=DqUcVM7Nnic2BeS/tLup4JAADHIhGLFVw8qHcQEoBuU=; b=r
	PXR3S4LPKfytdcYLwG2mfTMBlGUmQ9PXBwYglzM+i0mbAALbNJdrZPuI5JqceO0V
	6ao9Gf2edkEK0iG0w3EX/bZIIS218zuV4AbuX2eJjjiQmV/ac3R3sTd3tSznDfiO
	ZR+js39Oh1GCgRqpTjRODgcg8/hAF7rR8Q9X1cc1OKfHhBcJHIOOKAasb5k/bPKX
	EQ/knHVDdHj5f7DO1+C0m4bhFjAPn92hflNlv1GD5DeBV1+b6ApLHqMF1GTyghGS
	JyCtiyam6tvpfe4pzHdyTRyVK6p9Mw1Qi8W8/4/ioy0PWSnwScrTe7JeE+UCw55Q
	bmJ1EbuJ0gAM59g9Go1Bg==
X-ME-Sender: <xms:1c9OZ7-iK2uALWnFrYSy9zCnRk1kQld-2yAWD-QS4-RYgY9CaT-X7g>
    <xme:1c9OZ3sB1seOxOHz5HN3mru8Vy2tAUODoftw1IJtOn1Z0Y3X4RSKHP0yjHLtBow6f
    uldcxhEUoGEZMHRpLI>
X-ME-Received: <xmr:1c9OZ5B7N1pr4Q8_tqqcX8ritU6iBfSllrTPc43P_V_cFFzNKnTPaKPtRXA3AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeeiheeufeejtdeiffejgfellefgudfhhedv
    vdejhfdvtdeigfegtedufeehteetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdrnhgr
    mhgvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdif
    rghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepghhuohhrvghnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgu
    vhesshhtrhgrtggvrdhioh
X-ME-Proxy: <xmx:1c9OZ3doRlCOFhfuU-clwHxW88lQwYdb6DA4QfMzq4NWYomr44MHZQ>
    <xmx:1c9OZwMpzSuPae2eLSB9qQVk0TMia_jcjWZJQzsGTn1gnSX_gmtYlQ>
    <xmx:1c9OZ5nE3eJGOrYDfqz0xI-OLsrY2ec3hmammrPtHV8nSgyFJI0P4w>
    <xmx:1c9OZ6u8tzRG3YoDUesVEDqs4El3HeN1KfCzCzrrwxvwNhkNtqoICg>
    <xmx:1s9OZ7dl0xdSelYGlb3enmjq5kvw9-jKj39KCmDbg5kLqg82Hdpd_K8l>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:31:00 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 03 Dec 2024 17:30:04 +0800
Subject: [PATCH v2 1/2] riscv/ptrace: add new regset to access original a0
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-riscv-new-regset-v2-1-d37da8c0cba6@coelacanthus.name>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
In-Reply-To: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
To: Oleg Nesterov <oleg@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, 
 Andrea Bolognani <abologna@redhat.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
 Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, 
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3101; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=iHUx8lM5PnkP98ImrmiiCww6XfAXRjB9rUvZRyb0f/s=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGdL/zxx+VZ1W++qB1xHHrzGuKjCUyRVsbOk4XJ6j3t
 P8637ea93lHKQuDGBeDrJgiS14Jy0/OS2e793Zs74KZw8oEMoSBi1MAJpIlxvBXIir8ozx/i+Hu
 n96HPuu7y38t+lPppzX/Sd3a/dZl165MZvhflsT2YfmBIot11vqGDz/vTrwuKxEnvE7p/x3Gimm
 Lku35ARL3TDc=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 arch/riscv/kernel/ptrace.c | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a583683b922fe2c017ea61f3bc848db..18ce07ffb27bb1180667769eed800f6fdf96c083 100644
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
+	return ret;
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
2.47.0


