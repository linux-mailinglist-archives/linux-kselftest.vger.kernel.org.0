Return-Path: <linux-kselftest+bounces-39724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83278B3234E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC76179ACC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77992D5A10;
	Fri, 22 Aug 2025 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrG0Jir4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E441F418D;
	Fri, 22 Aug 2025 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892862; cv=none; b=QEFrmqCq1OPQvGch8/PRc84sPGZrgO/wenr4l35cwCc2MBn0uqie9aHGKVnFkD/OAauuwpHbjV5SIr/m4z6gjZHxYIbpRJXPjhzoYnqoBaDQBTU7gH1Xu7PMcUUP8o5c27lWUldylMWRCCahyvafNV6oP9td9Q2WTdwHQPJuxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892862; c=relaxed/simple;
	bh=N9fy2bLwK3IJp+QJFF+YnwaKxKb8B1Lgt6t0nqst3OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSFXtOstA/I5FohrcTF1T3hsjSIy4m+o9LL2X7yTQ7i0LEr+lRCHVA2yZn986SBEXXEwHITfSs/NP6L7QWBuHiLbdUwmiKOVDr+wAPxyxHMWjpj7Cdho1J14rqE7CTYMbNGuwixfn3Vr0ZZNugrQpP4uSG79+cqtTgmftfAQ/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrG0Jir4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA1C4CEED;
	Fri, 22 Aug 2025 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892862;
	bh=N9fy2bLwK3IJp+QJFF+YnwaKxKb8B1Lgt6t0nqst3OA=;
	h=From:To:Cc:Subject:Date:From;
	b=DrG0Jir4GMFBf2/TVbnCnU3tWr2jox3+X61ibVUM614dEvsAz1jmgwWreLzo1O/Zc
	 8+ul/dSzZrIxe6BzB7w50HZUDXBFky5vVjJW/Jj5gED4PWDvptRI1jW+vXKK7IPnwW
	 w+1jy8eijiEEUhpCQqZLAi2JTQVPdHrAdlVetUz5KEPy/VZjiFO5nNecUA1r8cIPgw
	 kyaDATeWyhMtG8mpv/1bmji78Gb4nyWo1nq5fdgFgy2sQVf3SNq3SiOs/VCGJoLK8h
	 vStiLcZCQqDhCvbCwqAzTiOGXza5yMeI08mqq96h4LUFUXnL5spx34UiJS+JM0jEjC
	 0NdA20siLUW6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: drv-net: ncdevmem: fix error paths
Date: Fri, 22 Aug 2025 13:00:48 -0700
Message-ID: <20250822200052.1675613-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ncdevmem clean up after itself. While at it make sure it sets
HDS threshold to 0 automatically.

Jakub Kicinski (4):
  selftests: drv-net: ncdevmem: remove use of error()
  selftests: drv-net: ncdevmem: save IDs of flow rules we added
  selftests: drv-net: ncdevmem: restore old channel config
  selftests: drv-net: ncdevmem: configure and restore HDS threshold

 .../selftests/drivers/net/hw/ncdevmem.c       | 773 +++++++++++++-----
 1 file changed, 566 insertions(+), 207 deletions(-)

-- 
2.50.1


