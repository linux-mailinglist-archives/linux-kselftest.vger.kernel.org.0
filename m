Return-Path: <linux-kselftest+bounces-22726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E529E199A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 11:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7513B3B0F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F11DF256;
	Tue,  3 Dec 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="RNJplb1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ep3/xxhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2691DEFEA;
	Tue,  3 Dec 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218262; cv=none; b=VvuVCeSpNMYMxGAdyVPhu985CF9KTCFzeJuyjgulVxMgNAlCV00O4cKM4dNkeJByC6azNdmcqi7et9JS9zOGz9O1p5U63pstlxTLzjqJEAVfgevdy55oOSgGyWO5wlz7y72W36hAWWWLnU5j6tg4wzSHkM7dAK9V1QgCK2BwLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218262; c=relaxed/simple;
	bh=v3UR4n3upO1L3GtOj7I7EX/ml6xx42eddSbkQxGVPzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jucJts6YI07jWrUOLLdnL24TkjZFYtQR3iI/mvX/QGfAMuzjmV7Znx8GRcsknWMII3gNs+9DeuoKSwtHLiRXkS6HFDUDIbOn2dEh125N7pJSDliJmYRRnfnHLCBelPXhXLJJVJZWPMOxZ1/3p0/Osco98wV6D8rB8J/WTkHMdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=RNJplb1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ep3/xxhN; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 18D5D1D40988;
	Tue,  3 Dec 2024 04:30:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 04:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1733218256; x=1733221856; bh=9Whz9OzImmI197gBlbvEhE00BE9mdgVf
	ySVnOACTR9Y=; b=RNJplb1yrN00f7zdFJdcu6N7y5hK1UMRnFRIDc4o6KCa4+De
	ORA2IlbnFsh7hdJRe3sFZRhKsdNYK0MNGJFsxumrcH3SE3XbqiVxannw8oZnL0c/
	WHviJmqp7NY82KIdRTJ3mqeqtmdXUmsbvQvQx9RjNeQa9oBPg4XHU/V7OiIPSg8H
	DAfdYqL+mxVovbI+6ey0r1YTWN68weWPbpCcJzQ2JGRw6s/PY2NdVOJb3fipkg9o
	7jRPs0GlHN6VvOjddBgoEsnf1pG58asUhLX0xZqQh2roThopvhFGA38Gy3eB+li0
	zgCsdlirWllX/N3UvsYnz9IynuGK5SmC3KeiJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733218256; x=1733221856; bh=9Whz9OzImmI197gBlbvEhE00BE9m
	dgVfySVnOACTR9Y=; b=ep3/xxhN56CEHoJQrzbZHejN1asBPwqo7/vdAJjsxVRv
	xFpCJBpkaYWoz69zOkIRVLQ210jLUh9Gsyo/lsPDaWgD7HrM7U36B+kYKv/+0qmP
	sinTW5YCqO8Z8kuohlWdYzob9fqazOKhlvbqoTuD9FLemzdvhUB6TCeVTmMTKC2j
	EYFViZFZ0D83aheL/4b7giDv6A/inHSGdbztRBPbO1Hwa0iY+zmkoBZzI6eTZ6Fi
	6gIGip7jV4/B0hjelDhAq+bV8wS0EVhlWiTcUgq9t0fym5vcqJfoN/cuKM/nR8O5
	37ujKRya7M/LsrIcr6AfQ3foVBjJEEShJMpNbJvf8A==
X-ME-Sender: <xms:zc9OZ90xpeteE_hY16-W3ByxLs9wco_EGSUkaSV8I3YIJKZim75P9w>
    <xme:zc9OZ0Hl1KV3lBxqwY9PqVUYfHdgyqn7kMYlaZFM40N3h46H9uyT7X0-4nwRv32SG
    2T2gz613wZL5dwDEiw>
X-ME-Received: <xmr:zc9OZ95a6o7_TcMJPg8mo5D4Yt1YJbO0Rx5XIudTYudBxBsOkZRXWa2u3RMOCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfh
    rhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeduveelffdvkeekkedvgeeugfdutdekteeuudfh
    leffhffhffeihfetjefhleehueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhestgho
    vghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgv
    pdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghl
    mhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepghhuohhrvghnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehlihhnuhigqdhksh
    gvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhguvhes
    shhtrhgrtggvrdhioh
X-ME-Proxy: <xmx:zc9OZ62Q9_RVpr9UReo8VK9HZLHaSnOWWl5lXLbg2bniUpu9OCwjog>
    <xmx:zc9OZwHMI1vHVnWtFO5ACJjizWuM9d_z5UxXdmF7ug0mcDoBc_dQBQ>
    <xmx:zc9OZ79eWWeaKPnQDQzr34y_Op-wE6uAvbAnWqc8S_vu3xpFqGa3qw>
    <xmx:zc9OZ9mC3rhFgNhp0oLV_JAUEcnGq0GwFNemt54juzHUulkN480rew>
    <xmx:0M9OZwUEnubuc9QGHm8_txPbk40pvTI1l3D5IixhIfiMpCosaBwOVzOU>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:30:52 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Subject: [PATCH v2 0/2] riscv/ptrace: add new regset to access original a0
 register
Date: Tue, 03 Dec 2024 17:30:03 +0800
Message-Id: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvPTmcC/32NQQ6CMBBFr0Jm7RhaJYIr72FYlOkIk2ghHawaw
 t2tHMDle8l/fwHlKKxwLhaInERlDBnsrgAaXOgZxWcGW9qjsaXBKEoJA78wcq88o69s0zWVdb7
 0kGdT5Ju8t+S1zTyIzmP8bA/J/OyfWDJokOoDVbXriE7dhUa+O3JhHp66D+7B0K7r+gVGqTKju
 AAAAA==
X-Change-ID: 20241201-riscv-new-regset-d529b952ad0d
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=v3UR4n3upO1L3GtOj7I7EX/ml6xx42eddSbkQxGVPzA=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGdL/zR1nEExOVj0Udc7NZ5BrYLlLjpzZj4c9vS5aL8
 CVtijVnm9tRysIgxsUgK6bIklfC8pPz0tnuvR3bu2DmsDKBDGHg4hSAiSSIMvz3nbjSK/59vqDt
 hI11mxh7W2f3MOr1rPQN5Hv9YYLhv9p6hv9OIfuPB6UvXO9h3JgQERqzOq7qhWqKfPzcnctKbxr
 0dbEDAJu6Rqg=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

The orig_a0 is missing in struct user_regs_struct of riscv, and there is
no way to add it without breaking UAPI. (See Link tag below)

Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
access original a0 register from userspace via ptrace API.

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
Changes in v2:
- Fix integer width.
- Add selftest.
- Link to v1: https://lore.kernel.org/r/20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name

---
Celeste Liu (1):
      riscv/ptrace: add new regset to access original a0 register

Charlie Jenkins (1):
      riscv: selftests: Add a ptrace test to verify syscall parameter modification

 arch/riscv/kernel/ptrace.c                   |  32 +++++++
 include/uapi/linux/elf.h                     |   1 +
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   5 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 1 deletion(-)
---
base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
change-id: 20241201-riscv-new-regset-d529b952ad0d

Best regards,
-- 
Celeste Liu <uwu@coelacanthus.name>


