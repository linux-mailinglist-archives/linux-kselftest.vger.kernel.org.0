Return-Path: <linux-kselftest+bounces-23745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFF9FCA54
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0DE1630C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F61D4359;
	Thu, 26 Dec 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="WJCKp/yH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCDGpgif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FA1CF2B7;
	Thu, 26 Dec 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209939; cv=none; b=YI+YNFDPpfgvLiPndLcPFtcP85UydQPOOjTitNXJardG9goW0x9JKp30GydtPENW7WdkC1yIKSLsl5a93srD98J669I6OVMmSj1giBdRHPRP0qxGZDVB87x10zKhZ9J9yF94ZGxQB2AHHdo3JEZWmcMbfAjskY3t9t0toNfLhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209939; c=relaxed/simple;
	bh=ltD8Q1yJuFcwflR+5zmJHqfB8aeFKvQGlw/4hXFU+gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYOFGnpvRaGbvDRHbs6s1sXY7E0/iHNkjzuOADtDGqt9qcd8kK9cEm7kO9CRve6sc3HFzuibbK2X254XcSc3+VCscuw7EjlHKipcxxiG0h12mxJzKgAj9KLidOZrkeLeIO3AnOtEw8pk1asM88M3LSLDwAjtmI3q6UnJJ8/iJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=WJCKp/yH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCDGpgif; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id BCC252005BC;
	Thu, 26 Dec 2024 05:45:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 05:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735209936; x=1735217136; bh=ePabROfKQd
	3trOxWB+908jisGE3fNauyk5nCt4vyino=; b=WJCKp/yHbthI8T+qhG/lyB8sVl
	YkBdNRi92T7EjmfAbW05WfVUqDu6jMu/pV3O3UDDFi3bwVIIA5zyZO5UtSzIlteK
	OjuZ8aMVHFdrFILJ+CDVV3Q6uZzvcZOBDQfjedKCJwlS5ckYzekFayuJxhWPCIAF
	SjkG5pgUr63vrT0O18uKxwyeWkCVFU57zuA49U3lZ4FBrOdE9O11FoEUjTcCISmK
	lNnxGP7k4CrA/l+5PlRQdktO30wi2umtCXxTp9NQAZa4bR8PIXO9a4L4pgao7Q2q
	NOvn9Z5T+S5p5QFxpuXUmKX8Bk+nCrK0/R5c1Rd463frn54ZqIb3i5AcFN9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735209936; x=
	1735217136; bh=ePabROfKQd3trOxWB+908jisGE3fNauyk5nCt4vyino=; b=e
	CDGpgifKLN6SqZU5GgHiZkzD9f3gSYBbWmMcaEC1BB+hlYeLabPw3gNh52pejqb/
	8WbiSTOTHWdFIdTFXZhW1QegDkIbCpMocpWKco/JtlFIDfM1ypfn+v3h3j7+40yB
	+ox5zGQJGuP+1B2I3NtCfXxRiMpUrXg6q/nsP5RkvQxyxqe/be9ZBE0wFxnZeMJt
	zi5vSene5LV0etexLECP0WxSuNVIVrr02y5FcVPgKGUZvTlFaGJ8vyC0tlv3lb5b
	ZpZmLpAN3fQgW7eKhzDGqI5rUe3X0X1m1scff8dL7jy8PjT1KcIZ0J0qbqlwGQdi
	TFjzDhawAn5/zFoLqm4HA==
X-ME-Sender: <xms:0DNtZ7yjDB8DznbBtoFTjW6Bb4GuhQqy9VQyZt1C4mvgh1X-crXmag>
    <xme:0DNtZzS7wtRmhBMT4oQMjyUMdasKo6TAbNq0rESD9KQUi67E3rO-I11yL1R8ApglZ
    LGsBF5Vpb8sOXZnIzo>
X-ME-Received: <xmr:0DNtZ1XFai5VaJaHRFKcPNZcQUpE9bXwjY8Etwqm3uq0OyW4PRe3WAMnxqXh2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueeigfduffelffegiefffeeffeeileev
    jefghefhjeffueetvdffieduvedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihu
    segtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvlhhigihonhhmrghrshesrghrtghhlhhi
    nhhugidrohhrghdprhgtphhtthhopegrsgholhhoghhnrgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthho
    pehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghjohhnvghssehvvghnthgr
    nhgrmhhitghrohdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0DNtZ1jP_5WESZQUMYYJ1rx4VOQFa0Fy03qrhuNw0MLfuabP1iDI-g>
    <xmx:0DNtZ9AcmGNCUMGv49fzMBTTIrUMqjhPQXTGa79CEiSVal7AImxb2Q>
    <xmx:0DNtZ-LATYIf9GVQcyDXPCNFrbhKSmIyFjo1c7x70Br1b3ghJpwyqA>
    <xmx:0DNtZ8C9W5Ws8XwxaQsPQwx7f6e2rI03qPHq2qc1-Fkx4Dk5u5jd7w>
    <xmx:0DNtZ_z1z8S4wgpTaFULsyYbiqmC9FXAL0vH_TgvGiyHscXxZkbROiQz>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:45:35 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Thu, 26 Dec 2024 18:45:09 +0800
Subject: [PATCH v3 1/2] riscv/ptrace: add new regset to access original a0
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241226-riscv-new-regset-v3-1-f5b96465826b@coelacanthus.name>
References: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
In-Reply-To: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
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
 h=from:subject:message-id; bh=ltD8Q1yJuFcwflR+5zmJHqfB8aeFKvQGlw/4hXFU+gg=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9FzjfcFzW5JSdpl75XUxC/ltnaLIqDsn6mp9ALeE/
 /UNjTpGnztKWRjEuBhkxRRZ8kpYfnJeOtu9t2N7F8wcViaQIQxcnAIwkbY4hr+CYlO/Xjrb7vv1
 +Z2EKf+Uc45vtstX3O5heYTPZ/69PkYfhv+pU2QfOJ+VmqvmXlw/Sez2geWKDfKuot+ldE1LVY8
 xbeEGAGoyRRQ=
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
2.47.1


