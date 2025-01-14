Return-Path: <linux-kselftest+bounces-24515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC80A111EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713E83A1106
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBF20967A;
	Tue, 14 Jan 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WPY8GV+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bt+VibFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B1FBCA6;
	Tue, 14 Jan 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886547; cv=none; b=VcF08YQIqnZQThTiaAj4K38RxqICR/W8hQokmcdphPFZsPC0OQJRPBeAxA6h1lxgkbOGDSD9u3+ABQCvAwdVreZoIuQOt+KtK8vOWqVneAaK6luBrIuhPbpjYY6gk8lxAWBaXe4EMrnmRfjp6lOp/ejp1zIshZI6a3WUhcNMyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886547; c=relaxed/simple;
	bh=w3GKJW4dxKObWJJ5sS1uX5ni/6l1HKrWIipHuxFBUi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ihnwm4cKwf+1F19VmT2oBoPlUzhZetBE3KBMecmwOl/4c4Ik4ry5ItDyd+fWUnVrrGmSTn0Xjia3NMNdDyyP3dhXiTlpAxCrYhstHsynZ7YevYr8J5+3jsN9Y3N5JLEh3YsuupnfsVslibiooOwX0auAHB+TrRBN5rJp8uRe/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=WPY8GV+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bt+VibFX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DD6F1140051;
	Tue, 14 Jan 2025 15:29:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 15:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1736886543; x=1736972943; bh=fAhBMPcT3KWreyXJ6/K8X
	IUq8LGhJ37NMiB9G2KJzTc=; b=WPY8GV+Ir8n+KSCD7nziudLbJs4+mwxHMwMzf
	CEjA1gHu/hzuVR4RGAPoQ2ANpmuCxfyoVeG4KQYjfNEWXXGggJ0hK43KUzRtpz/W
	7OSZ2Zh3dM0KtxOWaxqc9FVXKLvPkcdZ2KCoU9SKI74qME15NRZdEDkVlZnU2Bc7
	fKx9qWT5WOfw9xPCm5quHeK/001HtrjWoOxbTp4k91VzC8MND1VCahbOoBK288YW
	rOpGQtjFIwDVv/cWxIo/wLb2hK7n09zHZapqWwPvSwjel3xxHGJAXUhUH9G8j6h4
	PDJkK1vBnILztrlk2KhKOrrkSLIsyl9RjrskQ29gZBrlOQiUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736886543; x=1736972943; bh=fAhBMPcT3KWreyXJ6/K8XIUq8LGhJ37NMiB
	9G2KJzTc=; b=Bt+VibFXxZJoZndvJteRGgNVxV32vm9IXuKC8/PgiwKzuacxqZe
	KGTU07n1jgUDuP+0bvB4SRxwCNQql4+pKnTcLpU39kfzeyliT1maLhLG8qLDTfgo
	2I45gVFD9QvtO2LuC40ptuZFra580MEETWEKAqfDTeZvzRFndOZaBdMJHQr56l2A
	nGOZ4rYsPRMEeQR7sKIJPrZuO+ivnSo5r1y3ch175I3ynMDRM+sV+Kssqy8jV50m
	S7plpue1QFCNj8CJjG2V8KC1JCvNb/GmIVpP4aukUYS7aRZRLpzgFBEqhxTGKq9l
	sG/03UzmxlC34Dr0mrXomzuMgMAckSEC5Hw==
X-ME-Sender: <xms:D8mGZwI4F2scOwUVIC3b9u1WTSYuQZPXjee3_PNrWOGq-b5OPCZlhw>
    <xme:D8mGZwLBAhv7gy7KDOeEDrlFbpPPEKLj83V19dMErK7YbyG4iQnSskc-0HUmiYNyy
    0s7LqrauZqcGguDKA>
X-ME-Received: <xmr:D8mGZwtSzJpXkIlb5rZETM8TToFYuCFrEP1B0Y_slurgIwgaPrUbAqNvYS1iVRZeGeAfe_XExpqeIFmNS07Kg8cE66DXycH66UE_XDVys6gkTN_wry7x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepie
    ffgfelvdffiedtleejvdetfeefiedvfeehieevveejudeiiefgteeiveeiffffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshht
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
    dprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:D8mGZ9Y8vOt2HqBhMRV1Q9XuwFADpUwuU8LqPA5iVTZCsU7LVQrOYA>
    <xmx:D8mGZ3bvWWOGIF3vYgLQdejp7ILCRZkZEo21dVE0ZxGoxBRTBB_XdA>
    <xmx:D8mGZ5CVHbCY5NkOGN26Tf-rPDC6HDiuq3Labk3rgB_z0WMLLULotQ>
    <xmx:D8mGZ9afVcSgq-rwfdO0qmX41EvdOvdyeB1jW4qal8WYHeZDjsPW4w>
    <xmx:D8mGZxk_UkGXH7zQRt_s_Fh9HjeqCQmHx7fe7ro--4cN-7SZwQlPHY06>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:02 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v7 0/5] Support eliding map lookup nullness
Date: Tue, 14 Jan 2025 13:28:41 -0700
Message-ID: <cover.1736886479.git.dxu@dxuuu.xyz>
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

Changes in v7:
* Use more accurate frame number when marking precise
* Add test for non-stack key
* Test for marking stack slot precise

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

 kernel/bpf/verifier.c                         | 139 ++++++++++---
 net/core/filter.c                             |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/test_global_func10.c  |   2 +-
 .../selftests/bpf/progs/uninit_stack.c        |   5 +-
 .../bpf/progs/verifier_array_access.c         | 188 ++++++++++++++++++
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
 19 files changed, 331 insertions(+), 69 deletions(-)

-- 
2.47.1


