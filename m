Return-Path: <linux-kselftest+bounces-23642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938679F8ADD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73273188CF0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970D7080E;
	Fri, 20 Dec 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZsyIS1yK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kobBfZPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4F2594AE;
	Fri, 20 Dec 2024 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667804; cv=none; b=mPEm0yO8RjleGeT5KimCrhCxykFNpS7AiNEraoEynYPqt6aIhu+znoNewgRfF7z7zDGuR+e9O8Bc/XQsQCSaMJXcm7+2HBzxGUUCcZvORMPKDmSmAtJ0krKKvkQLi0okrLX+xFs7YTHk3xBOa799kxzd15NbfSdPKa7TwzfVcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667804; c=relaxed/simple;
	bh=D/KnxLcrVlCKuamtHtJG12ZYTmPO3BxQ8NJMWmmflwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K/smM4/zBeMFS66mbFCO3/ttNRDGfNyTR1i21xDUCsV6SgIrUV/bnVswi4OkIM9DENBkps6nVQeOUNGKUWC5PkY4IexiaGnNA/Rj2U2SDPk17nblysWorJpSOa7xzGKmKlOSMczDvKAbjoD542H8ek8byfENsFFsYYzYwifX5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZsyIS1yK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kobBfZPC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 115892540133;
	Thu, 19 Dec 2024 23:10:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 19 Dec 2024 23:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734667800; x=1734754200; bh=dqN5M2g0+vArcVpTZYpsP
	eSncbzTLUpbEyEHOj5WZHg=; b=ZsyIS1yKdF8P3FiHUooCj9PGO3VG3/Ht+4faG
	OjFfKctmqiz8kWC6VP/dDxerdzMOsIl4EazhwkJVrknoxDQy+j37yKQWNVIZ9/VT
	hLOYu88+d/4BsQNfIO1HWkxd+9Up+LTQY+Nq54JqK1/tO6+/CN7MdjafCAN41jK6
	M77Jj62vT7g4Yv26eKuhOYhPw9wht1XSZ0eqUqTuk8E4oopsBZxUI4VPZg5LSgq1
	pqbRnJ72g5wyXhHLmlkdOFMt9YOSSaiDqUB5TxQ/OH3TmBn5o8kaPuoYAlRDSMWv
	RWoMQlaoSPgYoXD5zED/5KDZxQqRC9miN+JCBO5iv+tYqkknQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734667800; x=1734754200; bh=dqN5M2g0+vArcVpTZYpsPeSncbzTLUpbEyE
	HOj5WZHg=; b=kobBfZPCRPyrbpEn3oKWsCeh5k6OcKhJlovnvrYxny8OD6/9VH0
	B3LKxzegOxREqfpsrI5QB/VMmRDcUp0uaSGHAGhQL+jlXUPHdoID+YRR4L03OhVs
	DTEYPhu34wAY4srWSsQXTkldjmbAbgWIPxPIYNU2SAPXJg0M0AsXncRWhVNzgBcR
	8aseBatdhJ0/pdnoO+WLYiWHwmbkj3/Bpurug0R51OdxKVskcPrhSWQYzEjRfV4y
	C/5O9EN4q1JOJMDo227rHBz6xUIXTcclOx19ln/lYeyrsbJj8I37/j4R8owqX8PH
	VDPS+ifRT/19rlLfRHzSbcg8SGGufRW6fEw==
X-ME-Sender: <xms:GO5kZ4DqPI1nlES-Fd6W9ciz9h2fu4p2sBADbhCqQ5CI8vw6eeCpHA>
    <xme:GO5kZ6j0lFO4-bVKus43n0GfjmeDELBgjt09vM9v6GbQdS4A5Q7d6BBBfadCX-Ibv
    kwehnJwLVQ_swTvJA>
X-ME-Received: <xmr:GO5kZ7lze5whQXxhlClqSksoczKlAmDCi7Hjv__0AcF7grkl-dfs2Oj72NQvDy8VH7KMcdYzQUTKCL4LcrtmqzhqlLmXhI4y2YEaGAWpGC6SixyN3G1O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeiff
    fgledvffeitdeljedvteeffeeivdefheeiveevjeduieeigfetieevieffffenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomhdprhgt
    phhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    ugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:GO5kZ-zn9-vAeSqQi5FZVmfovfYrHOwrGEU_YiJ8rG0RpZDOt1gbOg>
    <xmx:GO5kZ9SLv-Sxw01Cdf9c2J1hBfxh4aUsBFYQxh5zgOrCJJyYln6aDQ>
    <xmx:GO5kZ5adhb1u30fQPYJlTyri7RU9O1JnlFRMH8hfCi9LNAUB7VKW6Q>
    <xmx:GO5kZ2RuXorQ39ALA7RDAZUS7lQjAUtcYLi5Z-w892Z6_iOn26F1Fw>
    <xmx:GO5kZ6_bxo2Ai94znXTCLY0H0NX0vmHabgukkWSWHAm37jrdXC88rscX>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:09:59 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v6 0/5] Support eliding map lookup nullness
Date: Thu, 19 Dec 2024 21:09:42 -0700
Message-ID: <cover.1734667691.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows progs to elide a null check on statically known map
lookup keys. In other words, if the verifier can statically prove that
the lookup will be in-bounds, allow the prog to drop the null check.

This is useful for two reasons:

1. Large numbers of nullness checks (especially when they cannot fail)
   unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
2. It forms a tighter contract between programmer and verifier.

For (1), bpftrace is starting to make heavier use of percpu scratch
maps. As a result, for user scripts with large number of unrolled loops,
we are starting to hit jump complexity verification errors.  These
percpu lookups cannot fail anyways, as we only use static key values.
Eliding nullness probably results in less work for verifier as well.

For (2), percpu scratch maps are often used as a larger stack, as the
currrent stack is limited to 512 bytes. In these situations, it is
desirable for the programmer to express: "this lookup should never fail,
and if it does, it means I messed up the code". By omitting the null
check, the programmer can "ask" the verifier to double check the logic.

=== Changelog ===

Changes in v6:
* Use is_spilled_scalar_reg() helper and remove unnecessary comment
* Add back deleted selftest with different helper to dirty dst buffer
* Check size of spill is exactly key_size and update selftests
* Read slot_type from correct offset into the spi
* Rewrite selftests in C where possible
* Mark constant map keys as precise

Changes in v5:
* Dropped all acks
* Use s64 instead of long for const_map_key
* Ensure stack slot contains spilled reg before accessing spilled_ptr
* Ensure spilled reg is a scalar before accessing tnum const value
* Fix verifier selftest for 32-bit write to write at 8 byte alignment
  to ensure spill is tracked
* Introduce more precise tracking of helper stack accesses
* Do constant map key extraction as part of helper argument processing
  and then remove duplicated stack checks
* Use ret_flag instead of regs[BPF_REG_0].type
* Handle STACK_ZERO
* Fix bug in bpf_load_hdr_opt() arg annotation

Changes in v4:
* Only allow for CAP_BPF
* Add test for stack growing upwards
* Improve comment about stack growing upwards

Changes in v3:
* Check if stack is (erroneously) growing upwards
* Mention in commit message why existing tests needed change

Changes in v2:
* Added a check for when R2 is not a ptr to stack
* Added a check for when stack is uninitialized (no stack slot yet)
* Updated existing tests to account for null elision
* Added test case for when R2 can be both const and non-const

Daniel Xu (5):
  bpf: verifier: Add missing newline on verbose() call
  bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
  bpf: verifier: Refactor helper access type tracking
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         | 139 +++++++++++----
 net/core/filter.c                             |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/test_global_func10.c  |   2 +-
 .../selftests/bpf/progs/uninit_stack.c        |   5 +-
 .../bpf/progs/verifier_array_access.c         | 168 ++++++++++++++++++
 .../bpf/progs/verifier_basic_stack.c          |   2 +-
 .../selftests/bpf/progs/verifier_const_or.c   |   4 +-
 .../progs/verifier_helper_access_var_len.c    |  12 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |   2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../selftests/bpf/progs/verifier_mtu.c        |   2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |   4 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |   8 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 19 files changed, 311 insertions(+), 69 deletions(-)

-- 
2.47.1


