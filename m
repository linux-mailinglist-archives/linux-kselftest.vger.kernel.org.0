Return-Path: <linux-kselftest+bounces-22586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E649DAF72
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 23:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934D4B22B0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D92040A4;
	Wed, 27 Nov 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dOL3r3YK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fh8i/SO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5E2036FF;
	Wed, 27 Nov 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748327; cv=none; b=i0HEvTQTm3P6H7jM/ctTghqUZdACQOpWVYWTGBbQSXAwXJWzf0YfoGr3He3Qea3xsvExfxcpNRbCZadHYi8PE5Rz1N0LS2+dZexQne3CAxbdp86hBpTx6k3YKgOzDnwbRSEN0n/TZosgdLKyGfXFHe6uyROK+RPjGuz9U7Ad8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748327; c=relaxed/simple;
	bh=20dquXz3Ns2oFcYe/4/knEE7/tNHsttrV8ADBrNB+dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDSjRBVbHUbCa4jYnIjLbKv+ewlPRSWsfSow1St1/5lpPuB8lp4s/JPGRsVg6EUycRKktta6eaARTJF+oUPzVtTdmNm9cs44M/C8aIAzpzQatGoAqyMFBFxcQHBh7Sizb2kpKN2vPEPYLt5MR/38ik7/0l7UdmQ3oG2WbLignyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dOL3r3YK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fh8i/SO3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AF2F1140195;
	Wed, 27 Nov 2024 17:58:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 27 Nov 2024 17:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1732748324; x=1732834724; bh=E0PuXWbtfTxnhshYPccxB
	vxOhYcUvTwCkpf0/ymYcuQ=; b=dOL3r3YKU5ziPCzqOp647Tva2A5By0jo9HuNg
	y2veFGxIPewuj3Z2Uy38ak9YrS+GjVCgROp+ZWa1aWBy1wQCibLOSBQWc3jeliRi
	f+7L4hfHZIZU/mbjVELCkvoYCSAEeouj/3k3awWUgh0d0b2yXxjC02QMDl8QhVGH
	6sYO16qMRWcL1lP8myH+dFHzxzByOxl3sxGQ20GTDhAbDPAgD3VUTwYouOezlZNu
	9BFhz28PNPOrtmUoKbg+pjBONXBRopOBj8ROGODFigCgElDfqgT0xdbdYmnjW8nF
	E44bT1I+/AylF6hZuM7nW+FtAzgTn7yy4cHbozwDw+8C36UEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732748324; x=1732834724; bh=E0PuXWbtfTxnhshYPccxBvxOhYcUvTwCkpf
	0/ymYcuQ=; b=Fh8i/SO3jzfw0wlidygTZLso8een1oHk2cEXtdypB2jLpsL5Kbl
	NioEsr72xyBE5H//l8J6R6zGd1jS42dgMev9zp//R/fvH3PEDphlL3ov6hjgUqod
	79r9XGv19Fs7Mix2aijd6x5G6K7FgSu8cLQGdclNZFgLFlq8sTZlQswvYHq/cRFd
	+JBlVLRfFXjvBkr8c2RZXQL4gQmZ62n+pFLyjvt4JKtynE/lpWjpkhIjxthK4q4H
	qULPOlCXnMado/+KTC8GoRd9HR8pIQRRSI9dGJrZ03HdeyzLg795NupkZvwgAGY4
	RsFkjPA0oI9kGZ1AYAkbMqXIGIsXWORdiIQ==
X-ME-Sender: <xms:I6RHZ-L8fOJ2AFH_LUUGy67v5-s-P2UO7OgTLBbwkTGEGkU58GtLgQ>
    <xme:I6RHZ2LUuB5El3nuIq_5CKeSthRnSRjNkqJLZSeDF3-W42QTZ4xPAksgt0i9gCrCT
    OEnuhXgtt9H3VhFyw>
X-ME-Received: <xmr:I6RHZ-vROuEGCXmk8e3ybzBg9-PRfZaL4ll1KvJQ5d1-hNCVRJ2cVhHTkAr9CtUIKB5hPciUs3ApIfocLozpJEPQRcno8f8RRgpnrMGGpy_4rdPSaymf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvge
    fgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggutghomhdrtghomhdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghl
    vghshhdqrghnrghkkhhurhdrphhurhgrhihilhessghrohgruggtohhmrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmihgthhgrvghlrdgthhgrnhessghrohgruggtohhmrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrth
    hinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvtghrvggvrdigihhlihhn
    giesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I6RHZzbvK1IS5cTGQ2ece08VH2RVNLE8-_CoVIKSsa_DFovltWzeWg>
    <xmx:I6RHZ1Yiqwuu41nXsoUSctTD5zAwQMtejifjKkanYbnP3XBwVxcpKw>
    <xmx:I6RHZ_B-5XQisZ-uxFjYt-_5v8bCPacl_w_s--0UpS26DPmgBjKbhQ>
    <xmx:I6RHZ7Y9oI0DNJlS98d_VBzYtdhcitPkvFJYog9hI02D1c88AeDpqw>
    <xmx:JKRHZyT2FqyxAkPUg9j8s5ANH2xeAxOfcuW2NLSg-wZ9lqaWN7OD7n4o>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 17:58:42 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	linux-kselftest@vger.kernel.org,
	michael.chan@broadcom.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	martin.lau@linux.dev,
	ecree.xilinx@gmail.com
Cc: kernel-team@meta.com
Subject: [PATCH net v3 0/2] bnxt: Fix failure to report RSS context in ntuple rule
Date: Wed, 27 Nov 2024 15:58:28 -0700
Message-ID: <cover.1732748253.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes a bug where bnxt driver was failing to report that
an ntuple rule is redirecting to an RSS context. First commit is the
fix, then second commit extends selftests to detect if other/new drivers
are compliant with ntuple/rss_ctx API.

=== Changelog ===

Changes from v2:
* Rebase to net instead of net-next
* Make regex work with ethtool output changes

Changes from v1:
* Add selftest in patch 2

Daniel Xu (2):
  bnxt_en: ethtool: Supply ntuple rss context action
  selftests: drv-net: rss_ctx: Add test for ntuple rule

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  8 ++++++--
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 12 +++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.46.0


