Return-Path: <linux-kselftest+bounces-24565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E033A1223D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1FF1689E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3671E9912;
	Wed, 15 Jan 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="N+/sHNII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0fAlafw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157D207DE0;
	Wed, 15 Jan 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939655; cv=none; b=savqYV1uWWwJxE0vbOPHguqeYDr8WJAPjCjIiKgBt5I3hJtukyNJl6nTVO/QGujy3HEd6FWUnZjhHyfG4hyd10AwAPnVaZw5UDBVvAX8b8JG3W6uoNaw6T4F38DQjkI8LXPZcO+roh6VN5APh5qHBVskvM26ALwm4cRFG/EhvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939655; c=relaxed/simple;
	bh=FtOeBaQupavKu+tI2Y/VxaBtsP4LjSP/8QVEtgdjb88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kVmiK+vj0ukg6wzT/cTGT9OtrdSqOmaqfP1hUPwtE685EF2/lXm7xeDktHqUf+sbrj6kF9g82odt5La/URafaSxb7QtSrYhSPl7TwqBKyUXJE/rYYZlTJkWE4X3D3Rbue4M0YyEcrZg+EmWIFvCJLPN34c/kSGSLYpTgkIGAkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=N+/sHNII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0fAlafw; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id EA50D200D70;
	Wed, 15 Jan 2025 06:14:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jan 2025 06:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1736939651; x=1736946851; bh=w3CMkxf3HW7o25usDv8iCcrO7cdY52Vx
	1FFiviBkZRQ=; b=N+/sHNIIrS8nSIf+52FMx0My/H3AAFSPC0m6ppYXOskGMFdl
	6YKsikchZ3GKPtyQB33bPmhYNbRyxCRIc4ua2rw03licQLWZfabMleeig+eqIkSZ
	3FT7aoTyN5+s+064ofTjdPWzBopBzKnM6pkVMRnCpfoNm8m/3SxZNEomC0DIq0Ks
	eO+S1QiJKMV8P3VNDXG+P8leyRTtheQ1kD8zxx5zt+ClJ6uyIbpKL9jSMWX+SxF2
	2xr99ymYbekIE8ADhNF1f2ljyP3yzPDjbU+zQbHblueMdajKz3p1sj9wzBiY4BNl
	wGNYTynOHO3SaGgkbQ+CkCM+tPChObme0AIOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736939651; x=1736946851; bh=w3CMkxf3HW7o25usDv8iCcrO7cdY
	52Vx1FFiviBkZRQ=; b=F0fAlafwK51/557AY5k9uOSZP6Yo6R/Hqt26AeqSCXkL
	OKGgqNguN54483ncg2ZAVf/6j0HkZ9uBp9wQchlWhkNNz1CVahd/p51V8UrWmrQy
	vEkOgq8Wp7B8WeC9BxVcdDEmN80bA5f2Gyi9IsODc+FhO51tA04mMcDOSOphKVrw
	82hqi5XnQfN1rWc+XclRW4vKArtjmPfcTqaIKj49aGp1zC6YgEKgfHr7e/KAGeuG
	BbzxSo71GQDj2eKUNWXktthr2FzEASjZcyO+w+VUndKCPwtHkeHuhN1n48U6+uYs
	HtjiDcU0VHNBtJYgjY/9o0aEIgnhvAw5wcGE6Eku6w==
X-ME-Sender: <xms:gpiHZ0hHtJQg8aQkvJNIxQYqdmQYeMgjHU2LKjAPGuQOYJQ1W8Jbaw>
    <xme:gpiHZ9AlI7egkzFJTGVH0S3BEnfL5pRovieE0wLiEOoK2q1wzf307XWH3T5NWAiTi
    HHWpm6Xc9y9JsQjykY>
X-ME-Received: <xmr:gpiHZ8FREMEVJuUv52t2LmfN-xwNpqywsJrRcrCSItX3feeJ6ck8ra8HyR9E6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhho
    mhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmh
    gvqeenucggtffrrghtthgvrhhnpeduveelffdvkeekkedvgeeugfdutdekteeuudfhleff
    hffhffeihfetjefhleehueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhestghovghl
    rggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlughvsehsthhrrggtvgdrihhopdhrtghpthhtoheptg
    hhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepsghjohhrnheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgvseifiehriidrnhgvthdprhgtphhtthhopegvsghivgguvghrmhesgihm
    ihhsshhiohhnrdgtohhmpdhrtghpthhtohepiihhohhuqhhurghnsehishgtrghsrdgrtg
    drtghnpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:gpiHZ1ShNd6JfZKG8Jd5s4qaZDDhA-AxN3TJjXs89_tAX8xCENx-Bw>
    <xmx:gpiHZxzteplhxFo2wbg3RYdLGsPWfwIx1p2A8ltktD8-PJiECpJSlQ>
    <xmx:gpiHZz65FCkDqQkajR34lQ5GcShHc5wKHQVbntohdTzu-tANDSKEoA>
    <xmx:gpiHZ-wkBhjD4hFkj9ZPoA_-BB_Gsf5c_-ZiG-7nabjN4tYcVfvUVw>
    <xmx:g5iHZ2goMNH9U2YhRc5dcaHyInnrMNS8skdyJ676aXp8MkRmPg7AjT7O>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 06:14:09 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Subject: [PATCH v6 0/3] riscv/ptrace: add new regset to access original a0
 register
Date: Wed, 15 Jan 2025 19:13:26 +0800
Message-Id: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaYh2cC/4XPTU7DMBAF4KtUXmNkj38as+IeiIU9njaWwKnsY
 EBV7o5TCamLBJZvpPnmzZVVKokqezpcWaGWappyD/bhwHD0+Uw8xZ4ZCNAShOQlVWw80ycvdK4
 082jABWfARxFZX7sUOqWvG/ny2vOY6jyV79uFJtfpH1iTXHIcFJrBB8RjeMaJ3jz6PI8f9TH7d
 2Ir2uAeUhsQcMGjOkY/oMDg7R6k7iCwG5Dq0MkEZ7U1A9jdRvo/SHdIa2c9uCi02m1kfiEjpDQ
 bkFlfE2QJhZIe1Ba0LMsPOnmfftwBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=FtOeBaQupavKu+tI2Y/VxaBtsP4LjSP/8QVEtgdjb88=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9PYZxUdeN+tX5ojqBk9PyJa83qFn/Lx5steJU3ppZ
 h8/bPjx+nVHKQuDGBeDrJgiS14Jy0/OS2e793Zs74KZw8oEMoSBi1MAJnJvLSPD039fZ8xTXxRZ
 /HbyAl/BaZeXvp3usq5ffWFb0Y779x/KiDEyzF5xyyKdf0pxVnmJ5KrUxEP7FpXvaFNqrw8Q+Ln
 s6UcWfgAbTU2B
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v6:
- Fix obsolute comment.
- Copy include/linux/stddef.h to tools/include to use offsetofend in
  selftests.
- Link to v5: https://lore.kernel.org/r/20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name

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
Celeste Liu (3):
      riscv/ptrace: add new regset to access original a0 register
      tools: copy include/linux/stddef.h to tools/include
      riscv: selftests: Add a ptrace test to verify a0 and orig_a0 access

 arch/riscv/kernel/ptrace.c                   |  32 +++++
 include/uapi/linux/elf.h                     |   1 +
 tools/include/linux/stddef.h                 |  85 ++++++++++++
 tools/include/uapi/linux/stddef.h            |   6 +-
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   6 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 193 +++++++++++++++++++++++++++
 7 files changed, 319 insertions(+), 5 deletions(-)
---
base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
change-id: 20241201-riscv-new-regset-d529b952ad0d

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


