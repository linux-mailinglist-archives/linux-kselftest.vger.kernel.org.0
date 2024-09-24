Return-Path: <linux-kselftest+bounces-18290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3609843CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED041F23403
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808919C561;
	Tue, 24 Sep 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZtXgLsXq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0NugjZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630319C54C;
	Tue, 24 Sep 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174426; cv=none; b=RlFMfDg61sWeobes5fdVsI0AXupyD4M5u1vaQU3LYWwTW7m1GE/kSGijjX2ILW70HHPwP7l+PO1ltJqeKCpsAxIxij1y+E71CSem66h7nq20DJc9eUlCSNCmzSvOdzyIe8N27x3Cfge7bfPMGYrDV/JvsbtmZAist2EWiIy7TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174426; c=relaxed/simple;
	bh=/O/J/izwD4c7+6+KkaZ8zeckwL7Y8vx5JOACYI7kk24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMVS3czZpit55UA4YihtycGcl8Pm9E/AEKGbPPIDvLpj25NI0YckLJVhlfFO3HomHArIE8j8Qc4IEYWpX5Yy8+zMSKc3DAGxt0VacBu+b37N+aGM5iyTe0T3ge1lD6LzCDteSYGH8WD70KrxwbwCXS4pi2Ykxu67Z21Z8QgbH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZtXgLsXq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0NugjZ6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 345A01380468;
	Tue, 24 Sep 2024 06:40:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Sep 2024 06:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1727174423; x=1727260823; bh=rCb3GWP7USijz6rPi+ltw
	nSjH/eSJGnWg3yGDTAWq64=; b=ZtXgLsXqC8COZDnzzYfdkjjM51LmgQQSqfSa4
	EH/f7nwGsKMnsHrP+UEcDLiuBX94vuyVzDXefSn8wCnw0MTnfo0coNtO23p8C3Jn
	csLXwo2bnEeRlTGKMLtU7RZxBFjvY6Pt2ykRAOexlVkMunX1fRd1mTt4eG7xQHKF
	I9PiVtMAV88fMkbA6Gx3XyVpusBqIxSbYR2lkNNryGqh4riCYWGRgmbiYI49l8Mg
	igXynpgtBIrs94FRZ1KVviZyljD/nRmOcsoGOFZbLDzBruWz1qOf9Q+oAsS9VIbY
	eKm1PAqTTV0MhEdCqZWyBRYXjilCaI72ctSsk0riSs9rc1lgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727174423; x=1727260823; bh=rCb3GWP7USijz6rPi+ltwnSjH/eS
	JGnWg3yGDTAWq64=; b=P0NugjZ6ua35IkKusoenmwSc2XK8UkM4S5YIhrUuWQ2A
	/2FQflYGf9MWE31jF2/1Qv5gEXiZiPUCZ8Lnik4tZOGLgzV14jQLPRIjWpc2BrnK
	pdR80WJKanOzWxcYEBwQR/gzm/Fqrs17MIfvj6YAnzKSW8Sqq1DC4md140HXxkEL
	Tws/tAMhTD4w4PgfkHU/HmhgNiXGJVSuk6GI8UKM+AO7w2uiahUk8heRY44SqL23
	NORrJ5SXgH+6SI9uUsvYuPJcuQLGN1/Rr20sXl0A33YdIY5N8gmebqV/4567yIhN
	oJhdOs3n4Xbi/Kf+W53VOdDUdivrwnWY4A/Tzuk3Aw==
X-ME-Sender: <xms:FpfyZpCdAd6Tz9253Vp0FrZVXLnQ7SVr3J9tIGNi2XSC8vgLkeGI5A>
    <xme:FpfyZniS9WLHjkr1kxkB0zeALBDIDRv4BD8L7cxGgQwOKmx5ZnTbPiQyIs8vA9h5r
    9kXfvvURqgts8si9w>
X-ME-Received: <xmr:FpfyZkmFJ9IrPhO526N9FgLelrocY1EaG2q-giUZSNNceODWlvsx20qi6dS_4Oo0MeX-dDmLz--R316hWGESOBI6W_wpIHOkHRA9-ulTToOQ6qjoDdTm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:FpfyZjzCwm6If8GZOGTKRY8HOOQyTwnG91DGXQkWxuiKf6ZsJX5UFA>
    <xmx:FpfyZuRfAndwahceP5Hp5kignsNmRs4xezhe3U8YRa5G6F8vdJglfw>
    <xmx:FpfyZmZIQG3K5kn1Wf54tQc5LkeNui6tciws8BgiE381EHtdqh-q1Q>
    <xmx:FpfyZvQIEOpX2Q4wXaYtym_iY6sLakx7D8CnQWFu6Qtu3ZUel9gmZw>
    <xmx:F5fyZtGGUXK0EmDP5hYtXZBQLcg9FOzAl0QhsQaxX2H3WgvmiFviu7Jx>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:40:21 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] Support eliding map lookup nullness
Date: Tue, 24 Sep 2024 04:40:07 -0600
Message-ID: <cover.1727174358.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
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

Changes in v3:
* Check if stack is (erroneously) growing upwards
* Mention in commit message why existing tests needed change

Changes in v2:
* Added a check for when R2 is not a ptr to stack
* Added a check for when stack is uninitialized (no stack slot yet)
* Updated existing tests to account for null elision
* Added test case for when R2 can be both const and non-const

Daniel Xu (2):
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         |  67 ++++++-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../bpf/progs/verifier_array_access.c         | 166 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 6 files changed, 242 insertions(+), 11 deletions(-)

-- 
2.46.0


