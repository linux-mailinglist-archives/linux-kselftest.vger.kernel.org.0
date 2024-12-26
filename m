Return-Path: <linux-kselftest+bounces-23748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6C9FCA67
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAD163066
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387D1D5165;
	Thu, 26 Dec 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="rD9gXZzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zo3dw23y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D11D5147;
	Thu, 26 Dec 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735210400; cv=none; b=SdbPLCK6u9t5aXhh1NVlnp7Zeh941Sp70MGy1rn4TRuoBDzO50znjFVVUc1a8n53R4FlmI0jJkuFnQYbcHgghm98z3z5nRfEwPhsu40NOjjFaolfvv+o4eeKBOSbneMAozU2meCprIv8U22gySwKbPXzqHnqFk/oiPXw6W20xjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735210400; c=relaxed/simple;
	bh=ltD8Q1yJuFcwflR+5zmJHqfB8aeFKvQGlw/4hXFU+gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sqSbNmpVDCtomETojG4eug0xBbor7NUpYL9W7/vDPMWs5hqUVdiQeLD/te1GDCeel9ily7eweJAopZjZU/pYz9SF4GmfJkqTiIxP2ucgitgYTfAVprnFOR1cPsSFsHVyALvlKf2I9YwcYNJ9BRrVjGpAb7OZFGL6TbRxxjrtu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=rD9gXZzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zo3dw23y; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id DCC1E200298;
	Thu, 26 Dec 2024 05:53:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 05:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735210397; x=1735217597; bh=ePabROfKQd
	3trOxWB+908jisGE3fNauyk5nCt4vyino=; b=rD9gXZzzeY/BFFLeDTK+M8eWDC
	sxyaDkib164PwEXBBPfk+NtQyvRx4odo2EuajbKzWJXW3MmrJZSeStflC/oFLoMp
	PH3smBzWjE7zfMCFB6A2TY8JB3rrSFw4UeoBOKj01wFHaAsnrWtKB1Nk5rT/Naf3
	YfKzsxMDMTJCpnUkIIvyjaPyDL4zqhLJm2Ed3IPrkjZD58wF5dUQsqP25GHHgsMK
	HOmvA8wB+mOlIcyLmuwbBKB+cx4Nla3NHOBAhCsPfJX2IE+44E1RT60Lk/WZjSYB
	S7KwzVDBGORRfcjEp/Xz2B3SXnQdYSjqQn5SFrnh6SLoOD+wCvUlmi0qo/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735210397; x=
	1735217597; bh=ePabROfKQd3trOxWB+908jisGE3fNauyk5nCt4vyino=; b=Z
	o3dw23ye754fPrOuH5/urcUT506FtweUOPMa3qv+1Rq+mIHv5NFasjks9rrlPn0Y
	Q6KmTlFFJ8M0GFgXKx6F6BEVYsx78KVooEnWWfv7GcQQGFMRSljMrSMP96ulLS6m
	8qwpikvxZfF7HB856qmOiU2fTA9uruaNYC8YjhoTB2m4zmdiMfATj0EFTQbAQy1F
	uMKeZOoAVWN7hTztqkPPA8nHfAOTNI6VvAVPyyGPESx46B32d96++v3mubNX0S6z
	uVBKRjopgOuSil2TEXyBHxElogWq5Inu1Vau/IEjm9MDZpGM+KanOhMJ/DD5eh9h
	pOcwD34s19V5u+NwC9u6A==
X-ME-Sender: <xms:nTVtZ1O9-VcLnSwEg-cgn7uFh1xPR04UMwB3Zg3aePKUo1oRAltVuw>
    <xme:nTVtZ39K6J8O3o2x-PU09lDNVTn762165c4vM9uImJG4kbVIFv-s4Vm4EOMyhgJmW
    BcVXrs0Ai75OesvXH4>
X-ME-Received: <xmr:nTVtZ0QqSo_PgBHgfs1Kus6GvjssdHHi292Kn-djxiwtYTOOmFaiuHGWpE2Hwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueeigfduffelffegiefffeeffeeileev
    jefghefhjeffueetvdffieduvedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihu
    segtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepfhgvlhhigihonhhmrghrshesrghrtghhlhhinhhugidrohhrghdprhgtph
    htthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthho
    pegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepuhifuhestg
    hovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehguhhorhgvnheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgvseifiehriidrnhgvthdprhgtphhtthhopegsjh
    horhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhn
    ihigrdguvg
X-ME-Proxy: <xmx:nTVtZxuDINhKgKQzsVR6rkGQPESV-S7M0oS9BgdaUuPk8kMQGRL7LQ>
    <xmx:nTVtZ9fYyb41Mr0RrcupBbkBqOJ9axhVU73cp1HusPsBMikNgodLeg>
    <xmx:nTVtZ90Z3W083lMd7hH_XUolRs0-_hCuft8RT4ql5423Llco-clo8A>
    <xmx:nTVtZ58iulxe4MvGGjktasp5icxNiPrBNPC_5F9DXZNNxLlkvdr4fA>
    <xmx:nTVtZ2t-hxDshqrCVbgSrUGpGGR1IDkDpBXqM9mqTgR_z0OPU7lg54IT>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:53:16 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Thu, 26 Dec 2024 18:52:51 +0800
Subject: [PATCH v4 1/2] riscv/ptrace: add new regset to access original a0
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241226-riscv-new-regset-v4-1-4496a29d0436@coelacanthus.name>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
In-Reply-To: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
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
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9FzTSayCcadjtL1TfZwFL4VaWoskah41DHl4IebMZ
 7FL5VfXM3aUsjCIcTHIiimy5JWw/OS8dLZ7b8f2Lpg5rEwgQxi4OAVgIg0pDP99Fx6OOnhNRGqf
 2n/7hM8WTOH/rmf/4M5+eEHWKeOfVcAvhv8+R+w5D20PWXlNYpeEz8QVso8sr2+7ZvHljK3kl+5
 +7idsAH7FSLQ=
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


