Return-Path: <linux-kselftest+bounces-24512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD9A111D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06578188AB28
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696A20AF83;
	Tue, 14 Jan 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="MKb6BPqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lh0s0tQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A991FCD03;
	Tue, 14 Jan 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886326; cv=none; b=dXIMkmFLo2F1DV+etnoOuy4d+Zg69PCXblDsH44XM4nB69HtGq+Xtqm6V1dGujuUVbbvVKY11/b1f7iTEuLOHE9/n5GBbbVdnkMUrxrlTkycgi1WGzR0IrDc+9fZFjqit+Jv3ESIHUFPamY8gxI178VD7sdGHLhiLmwlJq/hJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886326; c=relaxed/simple;
	bh=Cuptt6+X+DwvcSwxeLzs4iLG9ApcFbolf+DmWtr4qCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mS5bRhLdc61L1Y3jl0Ixvv/R46KIR6VsuYyp7IQZ29JTEg8ggPwnEt/xXyPwJYboFF60ivEhlTIHWULb24tYAzzvxMmRDX6vkuHSexd+HqPu0cXnBWRa4KmuE8jp+9vi8y968umDgQb0q0/m/+6ZHl7Cw2N9aKsRY8YbfiJUa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=MKb6BPqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lh0s0tQR; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id B80BD1D40BF1;
	Tue, 14 Jan 2025 15:25:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 15:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1736886321; x=1736893521; bh=V0+Wok2NSxIYdNRIMGImlXm9psq07jFt
	AJcTnTk5u9g=; b=MKb6BPqK3qISkV/G6g9PJY01hvYgTa8K9J6BiGuF6VWbKSHr
	+9uaEIP0ebrmw/hQvIGvFQPDii6lisJfuQUEOmkb6mu3cVydasm91SithUCLVG44
	GJGiChX6uGa/rCpe9HuIa+KsnU0BdzjV9BgVtd1D7NGFKnUqjyHXt/A6eINFsl1X
	H5IBTz3+02PQ0lfB3awLsLkEfeCu5F4wQZy3Cp+QC7wtvwmiuAOKSuKmtf/PrEAM
	keI0gfzCFx1tV/p7Ldij2H52LRlURsVAGAcOvXSs7rZvhZVg/iNMCj6bvSg2VHiX
	80xHF6+MC/b+k3VV03/Wkya3B5yNtBogdrlFgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736886321; x=1736893521; bh=V0+Wok2NSxIYdNRIMGImlXm9psq0
	7jFtAJcTnTk5u9g=; b=lh0s0tQRs+cbFEqubIRL/GiUxf03g7RQC+vAdWWO1CI1
	jLjzsUz4BYY+IGxBq8zpVJYIzW7fh9iQJ1T9N/ZEMoizv7f4G8hK+FHBYGH4Wwra
	HJIBzOOpaqTYsV+mnYTcjboV0UGepxnT2aLtz3twylGmzxbp6jPAgbxo/aF1zvfW
	HkP5QLoBxMGyMq6hSFvlDnnnHuXrIsvpYAiAtzWu4io+DUIXLFsjHdTBoywmon91
	Ol69q8N1Lc+zoo2H8McjWcSYb60/qaCHlIrrVZCIOUMitJDpjjdWE4kS22iyw3si
	Y2tuFOmqq+n1RY2pcJT5oXu96YGdj1iczPeQX/6AAg==
X-ME-Sender: <xms:L8iGZzAOUGif0VTJzIh9Qm6kV2biPdxzEhDf_5NMUVAVe3OzEMKxPw>
    <xme:L8iGZ5hGC1OHOWC6h9nxNb3-RobXlM2mBFc4_uxJ8aaPgFK-phzEUAekAMQSolv3H
    10bBpEXcbz_cmkCAYQ>
X-ME-Received: <xmr:L8iGZ-n2uVjBO_g2Hy7bpUxTJwGj_88x4e3G8ZDdNml0KsLOc0k-_i3zBWA9-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeduveelffdvkeekkedvgeeugfdutdekteeu
    udfhleffhffhffeihfetjefhleehueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
    dprhgtphhtthhopehfvghlihigohhnmhgrrhhssegrrhgthhhlihhnuhigrdhorhhgpdhr
    tghpthhtoheplhguvhesshhtrhgrtggvrdhiohdprhgtphhtthhopehtghhlgieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdr
    nhgrmhgvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhouhhquhgrnhesihhs
    tggrshdrrggtrdgtnh
X-ME-Proxy: <xmx:L8iGZ1zjssxftcZGhQfrRT4pBxaxHcPGMlDjeGTf58peRzNNTT4klw>
    <xmx:L8iGZ4Q6g30VOF7WY7hCGo4TcEfpQ99vk1_bnSb_pCYiroJJXg9rLw>
    <xmx:L8iGZ4YeCUJhdCwiTCHr_DPm2vJgUFB6WeK3xnuyRqX-JQGQwPiSoA>
    <xmx:L8iGZ5T0cxkhqoTVh_HNarRPypZO8L-nOiaiaLH0X-bz1MP5WE1seQ>
    <xmx:MciGZ5CBm_TzDd4JOqllhAco0uT8aUj3e78PFytDZHMgHNnR8Hpdms2c>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:25:18 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Subject: [PATCH v5 0/2] riscv/ptrace: add new regset to access original a0
 register
Date: Wed, 15 Jan 2025 04:24:57 +0800
Message-Id: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABnIhmcC/4XOzW4CIRQF4FcxrKWBy49DV76H6QIuV4ekMg2M2
 MbMuxdduRjb5bnJ/c65sUolUWXvmxsr1FJNU+7BbDcMR59PxFPsmYEALUFIXlLFxjNdeaFTpZl
 HAy44Az6KyPrbV6Fj+n6Qh4+ex1Tnqfw8Gpq8X//AmuSS46DQDD4g7sIeJ/r06PM8Xupb9mdid
 7TBM6RWIOCCR7WLfkCBwdtXkHqCwK5AqkNHE5zV1gxgXy7S/0G6Q1o768FFodXqomVZfgEMb5o
 FkwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=Cuptt6+X+DwvcSwxeLzs4iLG9ApcFbolf+DmWtr4qCE=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9LYTKkdWMKhyCd+WdrbelpqpvTBhaVvWN8mQFUvnP
 XVi9P2YGd5RysIgxsUgK6bIklfC8pPz0tnuvR3bu2DmsDKBDGHg4hSAicSKMzI0LJC4sb5IIXbB
 v6mdd3012oxU7j3b1Swlt89jw8Rnea/tGBk+n2JIk7rH6i8l1er33Clvkt/fhRY+6heDy41f2e/
 hqeEAAHpwROc=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v5:
- Fix wrong usage in selftests.
- Link to v4: https://lore.kernel.org/r/20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name

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
      riscv: selftests: Add a ptrace test to verify a0 and orig_a0 access

 arch/riscv/kernel/ptrace.c                   |  32 +++++
 include/uapi/linux/elf.h                     |   1 +
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   6 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 201 +++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 1 deletion(-)
---
base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
change-id: 20241201-riscv-new-regset-d529b952ad0d

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


