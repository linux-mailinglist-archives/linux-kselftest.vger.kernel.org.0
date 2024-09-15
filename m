Return-Path: <linux-kselftest+bounces-18001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4748979455
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 04:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AED1F2139D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3241C32;
	Sun, 15 Sep 2024 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZSxLVEQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bRrscKeM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E710E0;
	Sun, 15 Sep 2024 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366288; cv=none; b=Uhjc39RebHXYXWqerckl5KT1Q29OyJJzSBv2s7weeKrWqv+S7H4n/0v7saDsul4ieQgxUwixm7mvqnWWeva8G/+WyV6cwOhQ1riA3l6libmTdKsCuqJp7T/pGsokWBrKGsz99rrZmY6Iouy4C/puhszG8D6YN6psIi0pa63Ptvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366288; c=relaxed/simple;
	bh=ONOOvc7H8puUY7BFSVYSGAUeQBINEpTL1Lo1rB2QMQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW03nsvqwVt6HITftzpQCWdr4wafxjcCABNWTjYYRdEoZtsb04qQdv7Et33G3iqxFg/sZXxbGm2f+L66d7eZ7xG8d4tu94TTN9EhCNDqdqP+GlI+IwHz8boweuYEV3mXekh/LsDyVDFrBrUdG4vIIs9mGs7q18Bq5q+WV03nPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZSxLVEQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bRrscKeM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E69511401A0;
	Sat, 14 Sep 2024 22:11:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 14 Sep 2024 22:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1726366285; x=1726452685; bh=vH1L6GVdqbgklROtASIhg
	ZjcgZUvBW19IlqBQp/sQHU=; b=ZSxLVEQGSHhOehoordsoHKNBDc33Y24eWRAr/
	6mjvwWnOf2aC2OJH3l8jJH9QnXqhXb7+M99ooqXhk6LEN6NfNF2cl2IRIvkUfAIF
	rrLP9kw+V5kbBbZtz+DZCyNqcFW/LOKYs/e9wcYRIr5EgJg0QHKZzRxvCclComGw
	is7Mje0s91U+rYUr5xJOb2Qu2mrETym1l6TuJKeA8w/zpiEJWoP7wIsP+GJRP5DL
	g+QD2pHWrjdxbGNXmHs3YN7XzheABxnnlk/6oPr/NShXbyp7TyVsCr8QX6iAQ9iO
	5UUjjmlzQJdRPyjeGYwykeVB6wvoj/3CPRkXaz/hhvjeRYYeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726366285; x=1726452685; bh=vH1L6GVdqbgklROtASIhgZjcgZUv
	BW19IlqBQp/sQHU=; b=bRrscKeMASPGwemLb3oRhR3glwepBxgJjsgPpHQ1xl/z
	KicRhGodhMHYN4q/nfaU772ke6sHYaGAhc/SVm7q4O6eNte+lka/8aDczdgzDekK
	79DIKkZzNexIMZkyQJS/x9XsRFW3ic7ZKkYnXGwP8Y+Aucprc0BJCrrOAd7m93rg
	kPah3fmHC/iTnlXJUQHPB8Z3qXRp8VwXyc0nMC2xVU8Y3TaZ42KwkO5lUfqOU3qf
	x9M+EvOn7OVKbhW7U73eGa6I6RC4sOIf1AKnW1wfJS9SNy7bNECLcXcN4N+sVlOy
	jIAsFjbzRNjQqik0Yk9OgTQizLuMbCI97pY6YM8Mdw==
X-ME-Sender: <xms:TULmZt19tIVrlDovXt1bSMDPfHvw9kbhBMe8a88cJgj9aVupGdpTKQ>
    <xme:TULmZkFBoAxN6XvHnPiMLnDVdn0eKLyv4Z_Af6JbjKut24Bz_ePAtbx8tSPN9c3bl
    bqsF2YdaP-AWPFR9g>
X-ME-Received: <xmr:TULmZt6GKNgVAa1MEmgne28RyQ1GILDm1JxTZZzd3nIKdfMv0eab5xwjafjmURhhocCEcPnQBh-um1CXhC2Li9dtmOX6HmdM9o03OSRfaDXscXtR9RcN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekuddgheejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:TULmZq1M-I_0VwVuxg2RzdA7U-2bMQP1tbrKNPEC2VZvj8mBZNsaYw>
    <xmx:TULmZgHYW1O9gryDRPO6Rd6SIIYFW2TOqNd6gB8VIoNEmceBlRuMMQ>
    <xmx:TULmZr96_oGKgPoHjpVFoIlMSfYNAzBIQtmRFYIp0QEdwnHKuU4Ejg>
    <xmx:TULmZtluUzihLJoU1gpkv3xacZWYd6urXJflpdyKEzQcVuDW0j05lA>
    <xmx:TULmZl4UYe-DMFzHbTE8VCQ6t_44Q-XdaI-w_34_7i0gpWrMUxoTxH2d>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 22:11:23 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] Support eliding map lookup nullness
Date: Sat, 14 Sep 2024 20:11:10 -0600
Message-ID: <cover.1726366145.git.dxu@dxuuu.xyz>
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

Daniel Xu (2):
  bpf: verifier: Support eliding map lookup nullness
  bpf: selftests: verifier: Add nullness elision tests

 kernel/bpf/verifier.c                         |  56 +++++++
 .../bpf/progs/verifier_array_access.c         | 143 ++++++++++++++++++
 2 files changed, 199 insertions(+)

-- 
2.46.0


