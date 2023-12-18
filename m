Return-Path: <linux-kselftest+bounces-2144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F013816FA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286981C23E80
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54D42381;
	Mon, 18 Dec 2023 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwO2kJvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FA42361;
	Mon, 18 Dec 2023 12:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A22C433CA;
	Mon, 18 Dec 2023 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904120;
	bh=0LK+UP7B8OJnJnFaqcZIp7zG2AKQAhCqfdIXh5rmE9U=;
	h=From:To:Cc:Subject:Date:From;
	b=WwO2kJvIRfS1Ka6xvh7MFJcLx2oQ/yBDFs12G3fNrUf74gP/o18QQDIbH6rEH41yA
	 KFeHLrnBdECtSp/3+99mxTcJDgO2Kskx4pLOEgVn16KFVV4/iiutTke9aP3891AgdK
	 fz4omzAPlLbg+ctzjO39RM8r+4kAIzkqqd2SorX/qHTeUQbAyokfBcQxqnloQRqBkr
	 /7ckaGQaItffmurkTBKJcc3wRLctu1W+Dy90LEWQVVXtMZylzrLln9hFwFacRsHFeL
	 yPbwxVuJDX29JqLzxuGb1vRayRkJd66t/itFdhwzFDNJ2etFE73cF3tgEqLJshawG8
	 fsgqkItmIHN7g==
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
Subject: [PATCH net-next v10 00/10] net: ethernet: am65-cpsw: Add mqprio, frame preemption & coalescing
Date: Mon, 18 Dec 2023 14:55:03 +0200
Message-Id: <20231218125513.52337-1-rogerq@kernel.org>
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

In v10 following changes were made
- Fix fallback to aggregate stats check
- Added Reviewed-by tags

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


base-commit: 610a689d2a57af3e21993cb6d8c3e5f839a8c89e
-- 
2.34.1


