Return-Path: <linux-kselftest+bounces-21840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8E9C4C8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 03:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9336A1F22B8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF961CEEB3;
	Tue, 12 Nov 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="M1ZCf3M2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n79C6nqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A319CC3D;
	Tue, 12 Nov 2024 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378300; cv=none; b=LKwXf3dg93EbM6uCQTskvgRGK+bcJxh5rpEnx0J95R/4SWRVsLfygjHG6dlKot/vWIEYqmqP7PMPQTwBjeyvA+oaUzLVcnLPDNzuqS27JP1te2BmIVgzQJop92knQqChO+Vvu5wR/MwykBl4aDUL4ItoWk9rvdlnmucDtTITAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378300; c=relaxed/simple;
	bh=3JXPofZrAihuRz2Dftz3FiL8QsEIZyfNEEldzOgT8Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnAfIs3aFqkHXSAqA/ExjL0oN4JGehYgRw8QZ0+ZrD7gY8vwvfP+D6vUkGbiVYeZYV87xrmgXlvqMc7/FWZVa4cxlx/JNv3kSg1YkmujQ6TuRJK5lfwm0a9GHMMjaL/9O4WTKmFzTlrHbHOVZT0Ex4ZKGDrd2hFbocvr8zfkOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=M1ZCf3M2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n79C6nqM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EAB521380274;
	Mon, 11 Nov 2024 21:24:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 11 Nov 2024 21:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731378296; x=1731464696; bh=3bTl2kc6DYFcUgHxTINVK
	8rXRMZ1klif4KCyFjRR7Lw=; b=M1ZCf3M2JrkZjpuKVtx+t/wq1dSJPOwRFFzxJ
	kYfRx1922HsFGVT39iQ89UtmMB0hbG1QoV9PMvppwv19CvlgnAyBsA7M7dlKFaCg
	snZqyIcK/zigF19eAx9StTjuTVnBzSnSQp+Oq/6vBqlJXuwBxT5ZV3SbCpXTw/zN
	p4cBxB115yeWQGsaKLx9ZFTkJ5uEScriqf1eC4XyicZ5bqCbCyAwZ33vIEt+tIUg
	upsYdIVK0EW/KFjop+S8KPVA3107UE8PjHKO3m/GgjtC2kqqqNCwucmSU7jVPtpP
	rdmHTByyG2UGNXDVZN5NhmucYUnFROWimqOrrOGN+8UA9wdqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731378296; x=1731464696; bh=3bTl2kc6DYFcUgHxTINVK8rXRMZ1klif4KC
	yFjRR7Lw=; b=n79C6nqMkvn5B7G6lVKyZFO1z7LKsTTkY261S4DeDyv4QVIs3TU
	koKnAmBCuXOFM+teKyjcPsu2AMl6Yloo8F1xdMUpifY1cC0UFjskvKKWuI4bFOrK
	/7UQSPhnwiQyI0Ae/pckvIVjp/hKBY3C8U90HLPPQ604R5Q7/nlanqxouj1aWqHA
	yL3BkMPytRus4PwXB9N93UuYiKNZ1DtLwGosctHeOAy3pSS8zjagbU9R3L/hQ2Kx
	6g3vwCE2GnMhUNvkBDkrjrwv7+cL64JRku/VEu6/q/ni4NZIdExgWgTK9g1Nvm2/
	sRNNiHW0okxHZ/lSaZIzFy9XKmglDwRfFTw==
X-ME-Sender: <xms:eLwyZ_PZDpyYY5-kJkqP1Wt8FI6GxgIUolrallCNP9DPFdV-V_JrLw>
    <xme:eLwyZ586Hbg1PjeSu0W3aU9X4njDmp2a8jDgno3WfG3BVzOAU1udfkKiIWpfknv5v
    TZPEHxK8Nw6x6zUvA>
X-ME-Received: <xmr:eLwyZ-QnEYtCf1Av6apA5gS8-F3cSlmsN7lCTIFVqaI5jfha0hbW5Al5G9QDwViR1K8_ISee6JUL6jifdyeHOqi32M5olSEDTAD8IpLwLd4kwZg6jN6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvge
    fgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghlvghshhdqrghnrghkkhhurhdrphhurhgrhihilhessghrohgruggtohhmrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhitghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgt
    phhtthhopehprghvrghnrdgthhgvsggsihessghrohgruggtohhmrdgtohhmpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtih
    hnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhes
    mhgvthgrrdgtohhm
X-ME-Proxy: <xmx:eLwyZztAOGOyx7TFiCA4M2nAGjuStbmdHfe7hl5sCyBJpUnfXTra3w>
    <xmx:eLwyZ3cfUGX5nz7hH_2k2EBP9-x5GaDFhYS1KbfSLMyVx7hx1vQJ6A>
    <xmx:eLwyZ_3r_NPuR_ncCivd3d3uenxbYvntDhNd3zqezRh39w1nm8FVPw>
    <xmx:eLwyZz9aj-Qid04qPILfLJ7Ja7a3qgB8_p6chO_yxyM8MkfqgntW9g>
    <xmx:eLwyZ77lmfn0VCprXtCfRwhJ4Iqg6J8x9w0aNgcSmzFM2Sx6C-SAOf3z>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 21:24:55 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev
Cc: kernel-team@meta.com
Subject: [PATCH net v2 0/2] bnxt: Fix failure to report RSS context in ntuple rule
Date: Mon, 11 Nov 2024 19:23:29 -0700
Message-ID: <cover.1731377399.git.dxu@dxuuu.xyz>
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

Daniel Xu (2):
  bnxt_en: ethtool: Supply ntuple rss context action
  selftests: drv-net: rss_ctx: Add test for ntuple rule

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  8 ++++++--
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.46.0


