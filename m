Return-Path: <linux-kselftest+bounces-2190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1398185CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 11:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80149B2115D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2314AB6;
	Tue, 19 Dec 2023 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXAhJtyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC615AC4;
	Tue, 19 Dec 2023 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139BC433C7;
	Tue, 19 Dec 2023 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983492;
	bh=te54wGyBTwLcw+CJhlHXDGtuPjiHoUjTAUzMEfl5Bkw=;
	h=From:To:Cc:Subject:Date:From;
	b=NXAhJtyAW1FuK84ie1+ylXTlWanAyMy9Bggr2UWgNv5UNxWuOivnCcylDMXgU4xAe
	 pDm/7O2JDBZFe9SxaT47aF+D2PQA5VyLQUZl0kwRISj01VJGmIol1luLkaYk6d3dWj
	 p6igZMhVgFLnqUo9EFpl98lFSY24QiKweGX5sN6L5DLILwa7tvYv11nwV4RIStkKNi
	 hpwhd+bSmTVxWfNA8mxcV5quONwLL6WS8vaIQpmGAbNaz57wtuwVYz+f4EOE4l0L2b
	 RoMVFOV0+okwPxDVnJulrWQcy/3u0EXc3aDQZy87v/V/hXO8w1P4a6zbU1C6ZRcerX
	 W6WyaUZsFYGbw==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v11 00/10] net: ethernet: am65-cpsw: Add mqprio, frame preemption & coalescing
Date: Tue, 19 Dec 2023 12:57:55 +0200
Message-Id: <20231219105805.80617-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series adds mqprio qdisc offload in channel mode,
Frame Preemption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

In v11 following changes were made
- Fix patch "net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode"
by including units.h

Changelog information in each patch file.

cheers,
-roger

*** BLURB HERE ***

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (6):
  net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
  net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
  net: ethernet: am65-cpsw: cleanup TAPRIO handling
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: am65-cpsw: Move register definitions to header file
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

Vladimir Oltean (2):
  selftests: forwarding: ethtool_mm: support devices with higher
    rx-min-frag-size
  selftests: forwarding: ethtool_mm: fall back to aggregate if device
    does not report pMAC stats

 drivers/net/ethernet/ti/Kconfig               |  14 +-
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   | 246 ++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  64 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h      |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c       | 708 +++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-qos.h       | 186 +++++
 .../selftests/net/forwarding/ethtool_mm.sh    |  48 +-
 tools/testing/selftests/net/forwarding/lib.sh |   9 +
 9 files changed, 1100 insertions(+), 187 deletions(-)


base-commit: c49b292d031e385abf764ded32cd953c77e73f2d
-- 
2.34.1


