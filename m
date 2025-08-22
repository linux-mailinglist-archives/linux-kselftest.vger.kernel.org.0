Return-Path: <linux-kselftest+bounces-39675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED5CB318E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB2B624B54
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8762FE568;
	Fri, 22 Aug 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="JZqFtwFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4IbgBUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08B305063;
	Fri, 22 Aug 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867624; cv=none; b=FDx04pEeaTU0mnRwWW8cVHPzQJSvDy675vjMBkbv+qlbzapFoSaNDHjMGFc4JKci+BHLPlkSJZKoorOcP1V8PFVLV3PcWNrG1uOlj76OKSBxTzcOxK9xcRWw51elvG+109cQS7oeZ2aseOWUQ0CHgkViGuRnVqUj57z3OvGVhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867624; c=relaxed/simple;
	bh=qRJYX+qgXxucznu8xEatkm9BZ8X3ZncpudgZi5+dKJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUYBuPBkuFVy041QxhS97dSkNiyJuP5ZMfuKtrkHQZs9HCW0r+nOXw0S1NFnN3ubU2kK4EdMLIH7CCbjiSxmq3HqCkvZkOfFqiFizqqNfzWdTzoDCMW2FEjDyDhhz49DY/Ci2gVZuWwjphlw4Ucn0wMKgZGH0fuAKyhGU6z/eoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=JZqFtwFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4IbgBUX; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 6023213802FC;
	Fri, 22 Aug 2025 09:00:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 09:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1755867621; x=1755871221; bh=qKeCcFKdYjA3Xk9aXQ7oUksybvXxRA62
	NvDzzlHXPLY=; b=JZqFtwFgsD5Mh/3vABYOC6Qf1mLhhTaNRRWT+7dBe480tE5K
	Q+xx9I0F2+umL2YW4DM9a1YjJm6mrciJ7dcBVpIcgsxUwkxGJYpcdSG6g7R4PmWg
	tJmGqWNwtcj9gtnVA2gau55dzIv0wNNHEHLOHl0Xqgpr6UT14POh/dqpAwfJ4Xi+
	CBukD2WPGLVlGSBBpa3QSWcr3UyHh3D0DbKE12174wYW8GTuxFh9Fwi4IY9uRoQB
	/FxaCuSAV6nn387vS/ysKWK4tICH/8FoKznt15SZWeqV2iqMJdObHsXlQJ9V+BKM
	mgNFrQ43u0nvgkhzShqHxYMHfrtP30H6rJj19Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755867621; x=1755871221; bh=qKeCcFKdYjA3Xk9aXQ7oUksybvXx
	RA62NvDzzlHXPLY=; b=B4IbgBUX640AgNAQ9xP1PlwVZoTxhcYpna3GJngbPAmM
	yZINx2yNIfwD2+Z0No5qmuV0jeRbYISTLffziUlRwPga77bJlOI0+Cm7sWnjA6ZC
	Ksd1YE+91MAU5vhZ+qTLnlGWenOUzsEaUQMP5rDOW4+z8IrXO15fU4yTKABheuYH
	IbNM35A/wK6Yk/aq/Y+VYYR15BcbqAYQvg8CStAR+kOZC5tiiv+gdRI44B9denjc
	tREHhaI+KReWfxf7zQDVtFduu+fkJ7DQ5ozlicYAW/ZdOkJ/eR2Dy1rBwWtS6e85
	K9e2CDxvpgD951CR7auvGkm9Znhgsp4Re6fRsI3oDQ==
X-ME-Sender: <xms:5GmoaACeG0-4ZbWBmtbSshqgVfQ1FwAQL0OcMk1ZChAb75RWEWw0Yg>
    <xme:5GmoaAeO73xidfFzv0lxUOEQD8rgoZKWmuQeMRDQ87cghtb8W90kIO2cP7lTtM0HB
    mMexE9vdHHJSPglTOU>
X-ME-Received: <xmr:5GmoaF4Ef2NWS0DjSqGVIesKJrxGy9Kk-Ld34ORrzDhqx7_eKkSsHzCJSh8QWS_NnmhGk5sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepffgvsggrnhhilhcuvehhohifughhuhhrhicuoehkvghrnhgvlhgu
    vghvseguvggsrghnihhltghhohifughhuhhrhidrtghomheqnecuggftrfgrthhtvghrnh
    epuddtfefgffffiefgtddugeefvdeuteefhfeltdeuieejvdeludetveettdetheefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvg
    hluggvvhesuggvsggrnhhilhgthhhofiguhhhurhihrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehskhhhrghnsehlihhnuhigfh
    houhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhm
    vghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugi
    dqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkvghrnhgvlhguvghvseguvggsrghnihhltghhohifughhuhhrhidrtghomh
X-ME-Proxy: <xmx:5GmoaLWqbE7a-KLrfgjIy2PbUEpgR5ucQB4x8EfhBmBX1RzPmCfO9g>
    <xmx:5GmoaM68bD4hYkm0Iqq5Jhi2FXIlz_p0FiS_mK3zlBdX6RWO6dQ1cA>
    <xmx:5GmoaOpGS14WBuiTjAx19tj2Smjn_E82oKWAxv4ETH48bHn8jQv2HQ>
    <xmx:5GmoaHmMq6LMwYHvC5OmrwkwAgNYWRXYW9doRTLLn_7_4CyHSFnJaA>
    <xmx:5WmoaDFZMKHs6odYW-qnYFxgK5naUbkKJLIoR8WhKpIXFfFE9u8a8mC->
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 09:00:18 -0400 (EDT)
From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH v2] kselftests: ntb: fix spelling mistakes in ntb_test.sh
Date: Fri, 22 Aug 2025 18:28:14 +0530
Message-ID: <20250822130010.3669-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changed a typo in the help text in ntb_test.sh: "maxmium" → "maximum".

Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
Changes in v2:
 - Added commit message (suggested by Greg KH)

tools/testing/selftests/ntb/ntb_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 020137b61..41ad97e34 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -39,7 +39,7 @@ function show_help()
 	echo "  -d              run dma tests for ntb_perf"
 	echo "  -p ORDER        total data order for ntb_perf"
 	echo "                  (default: $PERF_RUN_ORDER)"
-	echo "  -w MAX_MW_SIZE  maxmium memory window size for ntb_perf"
+	echo "  -w MAX_MW_SIZE  maximum memory window size for ntb_perf"
 	echo
 }
 
-- 
2.49.1


