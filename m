Return-Path: <linux-kselftest+bounces-18942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC398E78F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D501F26224
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF52A41;
	Thu,  3 Oct 2024 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="B+upX3kx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKQM0kTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051CECF;
	Thu,  3 Oct 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914320; cv=none; b=sBnF3PqDUNsD84ShdlwhRQF/U1pKW50wUk5zUknEqFyHH1t56ClU8NHK/aGFT2LJ2ddkErkuHvIq6AK4q/ZtDdsQtVBlbYS4Wuu4GXVobFhK3h0NegcM0R56LW5sOwKv1ZimHi8DdraDptjMqlzjgYXMsPNcn3DG4N/eok+/r7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914320; c=relaxed/simple;
	bh=s34ChWNTUZf+PNp0Jm27smljl+qGcakLZCkUTByDHrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D72doq2N4CsQnZK/FmmhCWkN//LYVaDNHRIShQFhauxH0toEMMxxzR1vsp9VOHwXtCe/HNMtuQgnF484l7VFSnSd96FoOlOavuvGYaB8HHCHCkwcDPaNYtUPug1KlYf57WB1rDNNPvSwZz5G0i3zu+QqwUOUJc+xpL6acSfhEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=B+upX3kx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKQM0kTG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F16D513804BD;
	Wed,  2 Oct 2024 20:11:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Oct 2024 20:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1727914313; x=1728000713; bh=iIAd8H6B2VnYrY4EUsFVV
	SZCYYU1X4R5ATQvY2f6A2c=; b=B+upX3kx7DiwyXC2Ksvn/nbNsZf/9hJnqiEjw
	DtvB2jbciAjCv8iT5UNqh62gpJP0O0M8JlWv6iGXKVMRgiPXGYJGg6XHThM68yaN
	9fUlUS4HAE7b27x1IXL47JugyBdA7i1NdalQrsk+xe/aoGcYq6zySF1e32TFmpHC
	M2nBAZsnbHF0i9q9jCnShAnJ6CPmgSka8CuvDcr7wnCNFQSBeFioyd+8piVsUc53
	9JUEYNmjDcVSZlLtgqMjRtLHi1YbstNdL04MqHhwVDKD38m6w91rjNsE/wWUSANL
	MPbJhanvw53jcxsGoJTISoD9/VfrenNC0p8EhVZG4z/ApTraQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727914313; x=1728000713; bh=iIAd8H6B2VnYrY4EUsFVVSZCYYU1
	X4R5ATQvY2f6A2c=; b=SKQM0kTGLUPGSazwM7jcwH1qn9k5E8xaAUdUR9ERIkmP
	uYCZHQNP7SzWxJtFHk32+yrfgYeAceo6BM91fXxuIaiItznv8Sw8UYKlRUHemr1b
	tBWhdF+Vi/VC0nqIUBcrXneCpoQBujn5teSv4JVc+TTU16Gx/3RU+mn9U39MaYMF
	7KF3HVbwMarXaqmg14QECsYBLBendYdeQUGrTgUIlh9q6+JARn9gr7kISf9pbmPG
	dtERsJgQru3RoHpC9gp/Sg/2WDMP2/bWa4mIkzGWkHiE5tez5Abhj18eFXMHEN1X
	xbeRaQp9yMzLeOLzgEnsJpa56ms22XMwXrzG496xCQ==
X-ME-Sender: <xms:SeH9Zu76QwTx6U33E0DMt2RKUtcqw2gdSnvUlMg05NIsQa0A1mOg9g>
    <xme:SeH9Zn7HweO2TfWLsWeEAyPae50XRyJz5N9GZ0Eq1TCINOpCEnOw2E6h8puvKy0oN
    TTQj6xIWbYEdBcXSA>
X-ME-Received: <xmr:SeH9Ztd8RTbTu_Uvu0bcTrGQT7unCtPY3DgcWTfgTRjCy0zR32F8dSNsfgnBN6QvwOvC0l3Isii1DX2wKJgwIUuy-UXGWDPsaHLpfLLEfp2uzGlG3sPD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:SeH9ZrK91lZVB1Wmh51xsc1hIwrQ5BLGkbSBudWhXbmxcEuopA0NZg>
    <xmx:SeH9ZiJ1OGBBn2FidF9CkEm9E7jd4h-KDbteex0mimslK7BaOQz0Qw>
    <xmx:SeH9ZswHhamEAhcgn9UhooxIw-kzT9UGfZWazkJ2C3YCCbnB4sA1Zw>
    <xmx:SeH9ZmIrUz3oBl3s6aB111o-gzQ5q2OOUeKuZI8IefuUeoUWJIECww>
    <xmx:SeH9ZjotRO-ZXM19bSe9v8Ccz9ksnADJZfczkwT_VtA2Uq7w-BA3sAad>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 20:11:52 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/2] Support eliding map lookup nullness
Date: Wed,  2 Oct 2024 18:11:38 -0600
Message-ID: <cover.1727914243.git.dxu@dxuuu.xyz>
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

Daniel Xu (2):
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         |  73 ++++++-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../bpf/progs/verifier_array_access.c         | 183 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 6 files changed, 265 insertions(+), 11 deletions(-)

-- 
2.46.0


