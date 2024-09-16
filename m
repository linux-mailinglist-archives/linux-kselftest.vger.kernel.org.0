Return-Path: <linux-kselftest+bounces-18011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF0979A1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 05:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5058A1F228B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDEF17BBE;
	Mon, 16 Sep 2024 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YcjW6nRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqFhDi+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD817C8D;
	Mon, 16 Sep 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458335; cv=none; b=UsYWj4lO1kVgfUAH8G0WUqy3iF2/nhqZ5pY4sFxasyaxlro7oo4fgOSltM4mO+8J3JmG7fUkNZnFYxpn/3LhNVZT51Oh1XFE6XRhHlSpEVFhIk5yqDNXmfYsljxQaay6IS/q0khicOWzvfr/j2ufPB0h8ZyiX4b7tkeGqUAPImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458335; c=relaxed/simple;
	bh=+DFATm44i28dku+78qvbyfJBvwDt+vgP2HoVzuiriYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXoZeAuhgn/Fgofe0ycbbDjZDk1mos7WICSAmus1+ghtak8mC0yPJfm3kweSviZWD6u1v5eyCFwqBk32nu/pAe/gwpy8QXYfTOHI1ZBdRJFkPhQ5j355T+zRSbUw8bVvo7kNfoBgZJ4gbexa4fuDey92eCdvOZr06hkju/lqDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YcjW6nRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqFhDi+B; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C72271140220;
	Sun, 15 Sep 2024 23:45:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 15 Sep 2024 23:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1726458332; x=1726544732; bh=CYUslildIcZmhzPunqphu
	aYk+sw/SS7ddUpsTZJAaQ8=; b=YcjW6nRBombij0kNrOACJqmBVtzugEVlW+pkw
	ba6sYQhJeXjnwis/UsTFs+VDzqX3LTvUGgJDaPXOjQTiEBystErj7vyjF/yCLR6M
	gesAGtTOCzi4rcM47u10riT1K5MmN6/zlyPmN/uR4J/IiFMxLEmaBE8gxSJCURRC
	xqvIBFiwQL8scXFcStj3bKP5cEQ073gJ+cyuRRXiNvOAGROKk6wRcahJqaZnPjai
	1qIGkO1/JwDI7gA6iYWMurD4R13p5gQDHA28ioQrHxrICH3YaEYsaXAvvQC4kCEy
	6AjvS62293V6BV4kAClPGmgze7wvFVDYuhGDpG2Uyl6YOnUIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726458332; x=1726544732; bh=CYUslildIcZmhzPunqphuaYk+sw/
	SS7ddUpsTZJAaQ8=; b=TqFhDi+BlrDc2sFJjB7PH56bRrcjmQiYWI2qBs6TdjDi
	/Z2+9tSYeUYP3EysESMMC4Vhl+agvZgU+VD3VEp7mjZbaa2Dezm93b/6eBrw/yAD
	RSVLW9t9ZekvpCEVIHbh0lr9YOtoFVXmb6pcpa0Elg3ZCNKeNyI5z49Z0Hg3aU//
	bsBVilPQ9zQNGcTVxfgLra4tD+nd59Cqbkrvq4GwBQGteNerB9nqgVynHhhcY9fQ
	wOn8gnk4alnsNCJ3l00ClVjn/nZf/c8hoDDF0+Bxs9GFs51fQY6MtrM0sEemUT8m
	cnY/tgMaUHOfh+aUM5mii8s8OMYpNumXq2cuA9hGnw==
X-ME-Sender: <xms:3KnnZo59B6vWtm0Fa4d3oW6CXxOGTxpdNctqzj5IiO4wcnx9-AaAow>
    <xme:3KnnZp4l3LdFTyYfDjeoznEVLxRigGt3ejX_R1dTuzLA8SXUCr_bbXax84nsqTdwZ
    V2ixtSC2rkLef6pVA>
X-ME-Received: <xmr:3KnnZndQkLu1W1uQJNBu0dhNnKDrie7xB5dXiqZXI64YcbZ9L-q0U3rENuYJyiaoyA9LueqgZZ0xv6OC1Z-udg5AYylG-zca5k3lOMSdsIvm6xDO0Lkv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:3KnnZtKYVCnfuqiOs2yQUFfU-LWhKxxjhXx4rl832BpVZQOnv6BM_g>
    <xmx:3KnnZsKBLdSO5zCIvR9YCmK65NFrGvFE_Y6i9eQn-wpd9SrtJSEyTQ>
    <xmx:3KnnZuwns5VAutlA-ndqtnyh02tm2RGMnGbPjiTyIoezNfSO9wAdpg>
    <xmx:3KnnZgKZU5sg-EjS4qU4K7z8yO23lp5srvmNeTWObZjCBeGgOLpmbw>
    <xmx:3KnnZk9ip0vHCn3X73Lf7oL1KPcRok68AbTlc59xNGTuSvr1mruvVD68>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Sep 2024 23:45:31 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Support eliding map lookup nullness
Date: Sun, 15 Sep 2024 21:45:18 -0600
Message-ID: <cover.1726458273.git.dxu@dxuuu.xyz>
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

Changes from v1:
* Added a check for when R2 is not a ptr to stack
* Added a check for when stack is uninitialized (no stack slot yet)
* Fix spinlock reg id bumping
* Updated existing tests to account for null elision
* Added test case for when R2 can be both const and non-const

Daniel Xu (2):
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         |  64 ++++++-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../bpf/progs/verifier_array_access.c         | 166 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 6 files changed, 239 insertions(+), 11 deletions(-)

-- 
2.46.0


