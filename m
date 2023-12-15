Return-Path: <linux-kselftest+bounces-2014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52A8148F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B118AB20A56
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15F2D7B3;
	Fri, 15 Dec 2023 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW6L/Br3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C82D7A2;
	Fri, 15 Dec 2023 13:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BB2C433C8;
	Fri, 15 Dec 2023 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646454;
	bh=2PCSLccgKFJP6w+u+FbaCCrI0+rCgc7fQ3xwz9BWPzE=;
	h=From:To:Cc:Subject:Date:From;
	b=HW6L/Br3QnpUmuYimQrakik2HY3V2zM5OnMMmqucetWBJ26coMrKQ/yxmIFRuG5qe
	 tq8MIBVmL6Ip/UPddbK4pCq6pKO1QsW26KTaUd8/V+/sSQ4ei2J0c2Z/5TuxPF3S9Z
	 4oBg4t8lBADRLnrTdeW2Vb7vSdMGWk/yQhefudKDNeNdFL+D4nsiSDaucAJZuB6VJ2
	 5SEdHotlAnILA4kDtD6EAurvdgxeS+8vul+JetFAhCDyfNa+RrFJg33Yn/bJ33szTr
	 WcTtEyNjT0urQaZCY4pMPSh345NjBIx9ANman3J/QuvZ5tCddhojCs23K/Gnf5zdZs
	 1M6ECLH3yGoEw==
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
Subject: [PATCH net-next v9 00/10] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date: Fri, 15 Dec 2023 15:20:38 +0200
Message-Id: <20231215132048.43727-1-rogerq@kernel.org>
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
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

In v9 following changes were made
- rebase to latest net-next/main
- merge patch "net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats" with
"net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support"
- drop "\n" from NL_SET_ERR_MSG_FMT_MOD() 

Changelog information in each patch file.

cheers,
-roger

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


base-commit: d6beb085e8ff3d9547df8a5a55f15ccc7552c5d0
-- 
2.34.1


