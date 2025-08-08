Return-Path: <linux-kselftest+bounces-38535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3F4B1E04A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A17518988D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFC76410;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAuW4YPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D72AD04;
	Fri,  8 Aug 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617807; cv=none; b=E03BJqyrMmDtyaNx1d6q70jPWmX8MYKzjifD5uANensZdQjKmOl3c23wvjj2IxWebZGbndnAf4+YTpL85XxE/VKMQAO90Q5xvHGP0Xv5EMIlKZHEJEDfRWmD6eq/9AaCfYCulIrf98Srkn18IoL/AMJwZL/aNwaxGbfxpLIEdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617807; c=relaxed/simple;
	bh=Js/a8dnIsiZe6Omc3GFzjC72tz9bsDQXKGE1/CnK1iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHaLfKZ5FjJyaG2s2X2SpbE3giuP8/ntY0PBAiuNryq5X80S+o37CqvOxLiZWt3KtnbL+ik8L6VDTZS6K1FRHmyHodYdYjcm4wLUbZu5wYgnahTnmyzPeHyho7+vlyBHivHjuGNFBXq5q5e7GDDnXa9g/A4QVC+B5N5MxEch+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAuW4YPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227CFC4CEEB;
	Fri,  8 Aug 2025 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754617806;
	bh=Js/a8dnIsiZe6Omc3GFzjC72tz9bsDQXKGE1/CnK1iY=;
	h=From:To:Cc:Subject:Date:From;
	b=HAuW4YPSH+pH0Ciwfzmg/azAf5HSBJTHsjtatQjJcffK+QENJ3sf5NcnPRqPAkO94
	 a5TtHSjINIBNH0ytCjh3KsZigjrEeEai8eyDS2nkat9Zo5lmXa+5trbqK3rHK9CNLE
	 fR1DoJ9R2Nr7sg/c0CX2Gq8H9U/Uy2c1JCNJ7mFamIh3tTYhBLhrCB1Ar/pc6b7Ht5
	 S2gTxmIHKzfpBzwThkqcXWjr5C9rChW9/Z6BAygIEjepvWbJTsl0xA/gDF9gjvKMXm
	 Tpompf6mm7pXGka1cVW8wIe8RLsErYeh5TPtsQLx7eILcu4IKEZ7iGcvVhNZ8kkGAl
	 lgt+z7sEZ2y4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	joe@dama.to,
	sdf@fomichev.me,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/3] net: prevent deadlocks and mis-configuration with per-NAPI threaded config
Date: Thu,  7 Aug 2025 18:49:49 -0700
Message-ID: <20250808014952.724762-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running the test added with a recent fix on a driver with persistent
NAPI config leads to a deadlock. The deadlock is fixed by patch 3,
patch 2 is I think a more fundamental problem with the way we
implemented the config.

I hope the fix makes sense, my own thinking is definitely colored
by my preference (IOW how the per-queue config RFC was implemented).

Jakub Kicinski (3):
  selftests: drv-net: don't assume device has only 2 queues
  net: update NAPI threaded config even for disabled NAPIs
  net: prevent deadlocks when enabling NAPIs with mixed kthread config

 include/linux/netdevice.h                            |  3 ++-
 net/core/dev.h                                       |  8 ++++++++
 net/core/dev.c                                       | 12 +++++++++---
 tools/testing/selftests/drivers/net/napi_threaded.py | 10 ++++++----
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.50.1


