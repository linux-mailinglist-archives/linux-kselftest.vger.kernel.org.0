Return-Path: <linux-kselftest+bounces-23747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEA9FCA64
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6401B1882DDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013D1D47B4;
	Thu, 26 Dec 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="gnWd/vQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXmUFQrd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392E1D4600;
	Thu, 26 Dec 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735210396; cv=none; b=itp92NOZHcBj4RqqjhiR5yE6t794vVRSZuYS6VHb8xSDKBWgcTA84Iwt7IggkqlKiDs4ovXB7AATJBMsKenUFLxLonoUJJCEHNASUQNfRU59jF9ceNVhJH3VMLwmkYtt/UHXONMD9y3Hh6e4oksj2hFxvOKfwQNUj8BRmoovUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735210396; c=relaxed/simple;
	bh=lALw3onDiG+zgqJyeWG6Zp6El5Gyio2enpVzc7TjYt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sq4xW88YwpY/GKd0lNbp+6rcYuf6DC9YPtWNUcACOujRL8Mw1NzpgF5CDLI+TnfFXhytDs/Z8ljG8ISq8tnnrH6/54i9KT6VQzARAL1R4o1L5Grly6HI1g4NvhrJxLGl+Pds4LYzL5YggLy5PBaj8GCpBRTybGppYfVXUwn97Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=gnWd/vQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXmUFQrd; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id CD701200296;
	Thu, 26 Dec 2024 05:53:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 05:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1735210393; x=1735217593; bh=FbA905A+DGwHO7AIhjFuIaLqMYE7N927
	tXxffJKVFG4=; b=gnWd/vQ8rRvnIAuFGp8lRkIjAel40pmjADoS8xdxueKq/J0s
	00x5mfvF5ThQK4oOzrGosLMWm1r8eFmb7zuh/RJ/IPEI145bi9jIpFPPDD6jR54x
	bcUfSVjnO6HJTaa3NywihUz8lJNX/DFXU0BF2/F/3BDirlyUBNyhxqi/DozkpnUd
	+nOxBGpbWhYk2tlAOdHBaBm+RPdUfaJYYR3+xiq1ydSSohkm/tOZBtWHP3b3kZXR
	NkuHWKOs5wf6+dU6EiewDyBbr31ZtdWR4KPGT86Elr9IL1bxG+Ewrud+uWy2PWcJ
	tQB2eS95swnBqbnIFARqr7gcM9pjkiD3GzLvPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735210393; x=1735217593; bh=FbA905A+DGwHO7AIhjFuIaLqMYE7
	N927tXxffJKVFG4=; b=TXmUFQrdoJLqmlLheSWTym7ds4nd3O0raXl4sfAMtuyt
	kEZZp5hZAjsCM8a9Y1EJz1TGqUsMXaJvNnIRnAaVZ2IQlOm2uvQyYbLZoOhGIGaw
	EfpKrOM7uIpQwB99WIMESZLA3WEAdxvabn8M2rz5bniIByU4RfMTLEalKWHL1taw
	9e/5Vot+sdGC9ZBqN4cA1CPxEtxuDwCLh2+nbb39gJCb2/4Ao8GvWOL8gcYYTISj
	WN9n4kghkdavEZ4MB00Rd/XSG5KPpl1F9vVYyP1XEk2YmRe/3AfWa3CUEQyfHg+K
	yKmC7xipZYzVdNOoLV9nA8M0jTLZCwgsJLLQHG3VMg==
X-ME-Sender: <xms:mDVtZ2PPnXGcre1EahQC6EuzcWN0d1idx2pAN_8o3nqjAEixIqYJYw>
    <xme:mDVtZ09bvnkwfan71xFhhPKWVm0zvX4KYDm7K6jBVOEl8Unzd4ceFbL4_22NhvQOj
    UEpqFnNUcb-jqfntaE>
X-ME-Received: <xmr:mDVtZ9QySoIomFZbmM8ZLO4xrA73haNYv4GQreQWWCqZWclIC8yKgS-B8mdQbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepudevleffvdekkeekvdeguefguddtkeetuedu
    hfelfffhhfffiefhteejhfelheeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfhgvlhhigihonhhmrghrshesrghrtghhlhhinhhugidrohhrghdprhgtphhtth
    hopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegr
    ohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepuhifuhestghovg
    hlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehguhhorhgvnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhgvseifiehriidrnhgvthdprhgtphhtthhopegsjhhorh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihig
    rdguvg
X-ME-Proxy: <xmx:mDVtZ2uIlRs0x0gH5LBawkfroE_OUokzGAz_puOq6WRSBxj4Y3qWew>
    <xmx:mDVtZ-f7IuCf_msVFQN30ITM0z2xWU4V05w_8oTWMX44s3Kazq_nCQ>
    <xmx:mDVtZ61nEemF1NMLkgcQ40hJ2KHNXouwKhECeH_CwrPZtznYNyNVQA>
    <xmx:mDVtZy8kqOsC35dNk9K5_QGK2qL_2hufIn-3Nq3P3CF-blwCKqprnA>
    <xmx:mTVtZ_sOhxHWpSP9JyOyrh7mWHMIcPTZ7Nl1sdxxn_tqMXoNOptoloLX>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:53:11 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Subject: [PATCH v4 0/2] riscv/ptrace: add new regset to access original a0
 register
Date: Thu, 26 Dec 2024 18:52:50 +0800
Message-Id: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAII1bWcC/33OwW7CMAyA4VdBOc9T4jSh5bT3QDskjqGRWIqSL
 gyhvjuBE4eO42/Jn30ThXPkInabm8hcY4lTatF9bASNLh0ZYmgtUGKnUCrIsVCFxBfIfCw8QzA
 4+MGgCzKItnbOfIh/T3L/3XqMZZ7y9Xmhqsf0DVYVKKBek+mdJ9r6L5r45Milefwtn8n9sHigF
 V8hvQIhSAh6G1xPkryz/0H6BUK7AukGHYwfbGdNj3b1o2VZ7ojAf+pKAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=lALw3onDiG+zgqJyeWG6Zp6El5Gyio2enpVzc7TjYt8=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9FzTCZ+3L7FgWeTauu/RfqbJjAmLZt663/hH0y7bu
 0PHX2T1L9GOUhYGMS4GWTFFlrwSlp+cl8527+3Y3gUzh5UJZAgDF6cATIRjKSPD7G9paY2nBViE
 dppvfay8vEhfIpvn2rnHLj1dUw7JH60IZvhn8+fqEc7vezc4RFetbLSqOlvzyfR1xySWVVKWNZz
 iDkW8AHgXR5c=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v4:
- Fix a copy paste error in selftest. (Forget to commit...)
- Link to v3: https://lore.kernel.org/r/20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name

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


