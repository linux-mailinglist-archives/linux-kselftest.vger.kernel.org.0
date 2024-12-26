Return-Path: <linux-kselftest+bounces-23744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576159FCA51
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDFB162E84
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B75977F10;
	Thu, 26 Dec 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="O3ZDpFGM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcG0k9fx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B72186E2E;
	Thu, 26 Dec 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209937; cv=none; b=Ua/ddgUInTKpYTBBEmrBscWkWyUmH0ZLiyLZl7HBXZ5b8sFWhDw8rPU1aSztkmcVAB/qGTlh6LyRVi45SZey8LpyyC4UanGcRtdZoSai4WLV6lqeDuvK9Y61FHNFIgeUYxtrp254lInnmo/yf1xzcjJSVgejfCdTfwI7Ri+RnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209937; c=relaxed/simple;
	bh=FzHhv0FirWGjeDhpD5E/shY97Ohq8zvrZ4aJo4GEwtE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fqxRNpXUA4Ub2EHKf5qWbYF9FzhGnuF5PeN6LwwbY8U9OHQdTXW+3RhVYgZ5pHCS59yTP5tqPPcGv2ns4tF4sgNbtDBVL6CBrfPCkdk/0kXAvsfnhk1DIKYKNIg85O7+LyoDgXFzvDmBO5Rxz8dYLNL/X7LA4YobMD24Wbm8FPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=O3ZDpFGM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcG0k9fx; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 39C04200594;
	Thu, 26 Dec 2024 05:45:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 05:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1735209933; x=1735217133; bh=10TP4Whk8LjQRQqlRFAekDUwjJ0f832U
	9TFD0lFXHEk=; b=O3ZDpFGMvnYG+CSrVLq4+/SJxqWpAP5iREqF5C41CM5b82WO
	4AVlLosR+gGO2SeTLfQwJ7TJ7+4o/ZTCZysA1n6D9cNZfIT95sqfXLRIS/LqrfKY
	gS8a8NgIFPSRCauKIjNJRZlJSPNhkPgHr21aVEqS35Mew1HoB2gcWzVhXJvC/IZu
	XlwL7r7VvKLGlXn3wEFj2Q90cHs5n78WpRX4laOJyx5u40F8DB+GrfGy9LqB31fA
	my8O8Ml0iZ+OF2NSpcAlPyMNmDWwDSiVTAwQqseCACyBxye4BEldfWu35Ph1UPlq
	8cwaxxoyo14LYxeY6oiJ+F4R+iPWyFGW+0pNNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735209933; x=1735217133; bh=10TP4Whk8LjQRQqlRFAekDUwjJ0f
	832U9TFD0lFXHEk=; b=jcG0k9fxFoOWd+xvWeMDPKCguE/EnwNNzOpXDSHmTjfF
	AcKcqyNAkvZ6R4tXG9xrXCjKIPhcJSb28LaQq3trlD1IUsVcqFzPA1veSOV9qUhR
	wN5Gv1jxDJOfNTL973kceBLXBCniNhGbsurKhf4tSPQmpw564oZVgkg3xCSGVi2i
	ltlmzovUq1I6kSPt5XTPZ8RrEmpT4VfOxZbBfYtBk+3Xd7w+d4bSm+TQDo4rG+SX
	O28swrpkb8L+YUtq3gjot5vOHcVlDTjm0GO4GQUHLUexR63uPDBROuHzXMQmmDK1
	zUt7TkUQnqzeU+WXfQrAl5SBmId0B4+1pYHCIoBp+A==
X-ME-Sender: <xms:yTNtZ3mjF_OvGNjEuCG_k8O1nJ76PtOq8v5KJ9FTqF7DU-A-2uDXdw>
    <xme:yTNtZ61scadkc0R32ghI5iZe3a-XbXElc4I2xkoKErKsSrrKyx3QB50Zf6wAJHBYn
    Sih7dZKtpLZSGtOhwM>
X-ME-Received: <xmr:yTNtZ9oLy18uHGJK58QZWzIqVr5FjVuuEacOUt-vV8iGiK9lPRrkoBgIUktJQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepudevleffvdekkeekvdeguefguddtkeetuedu
    hfelfffhhfffiefhteejhfelheeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepfhgvlhhigihonhhmrghrshesrghrtghhlhhinhhu
    gidrohhrghdprhgtphhtthhopegrsgholhhoghhnrgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehl
    ihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvg
    gvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgr
    mhhitghrohdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yTNtZ_lT9XOzaiOY1-H0XLPrbDfrRTrUkXJxnxWVNF2Hr8tQ6-qS5g>
    <xmx:yTNtZ107tlxFjw0ryw8NfIN8_ichUfXCHLUidLCEl-nJu8Oyekl1cA>
    <xmx:yTNtZ-twjxPNurk_Hqt0V1oCBezgEh6V--PrEHCXDetleDi_fB33KA>
    <xmx:yTNtZ5XHx4iNDCk1fBbZMmx3DQBpRmCdCSbaNiNbQfsxeItya2w3_Q>
    <xmx:zTNtZwHj9mbG-s3d5Jpqgs_p9tYPHEzNssxR2pn2MDe9o-dnpNedBcjk>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:45:28 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Subject: [PATCH v3 0/2] riscv/ptrace: add new regset to access original a0
 register
Date: Thu, 26 Dec 2024 18:45:08 +0800
Message-Id: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQzbWcC/33NTQ6CMBCG4auQrh3THxF05T2Mi+l0hCZaTItVQ
 7i7wMoFcfl+yTwziMTRcxLHYhCRs0++C1OYTSGoxdAweDe10FLvlJYKok+UIfALIjeJe3ClPth
 DqdFJJ6azR+Srfy/k+TJ161Pfxc/yIat5/YNlBQqoNlTWaIkqe6KOb0gY+vaZtgHvLGY061/Ir
 EAaJDhTOaxJksX9GjSO4xdRkmtPAQEAAA==
X-Change-ID: 20241201-riscv-new-regset-d529b952ad0d
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=FzHhv0FirWGjeDhpD5E/shY97Ohq8zvrZ4aJo4GEwtE=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9Fzj3awLwkR2y52fI7JCOC9gWnv59Y0Wjl26P1oap
 s3wFXt0sbmjlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAE6l2Y2TYu1viN1fptIB6
 kTPPd768eFQzcYN6i9Gad+f/3O1Y+fFnJsP/uAU20S8UWyKWLFuos/T5KetdjyN+mGQmmG07/oX
 rBqM0MwDH70wJ
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v3:
- Use return 0 directly for readability.
- Fix test for modify a0.
- Add Fixes: tag
- Remove useless Cc: stable.
- Selftest will check both a0 and orig_a0, but depends on the
  correctness of PTRACE_GET_SYSCALL_INFO.
- Link to v2: https://lore.kernel.org/r/20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name

Changes in v2:
- Fix integer width.
- Add selftest.
- Link to v1: https://lore.kernel.org/r/20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name

---
Celeste Liu (2):
      riscv/ptrace: add new regset to access original a0 register
      riscv: selftests: Add a ptrace test to verify syscall parameter modification

 arch/riscv/kernel/ptrace.c                   |  32 ++++++
 include/uapi/linux/elf.h                     |   1 +
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   5 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 151 +++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 1 deletion(-)
---
base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
change-id: 20241201-riscv-new-regset-d529b952ad0d

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


