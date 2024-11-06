Return-Path: <linux-kselftest+bounces-21515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06F9BE22F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277481C23149
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09671DA63D;
	Wed,  6 Nov 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KcYzHBOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EB1D88CA;
	Wed,  6 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884671; cv=none; b=cNjuYV9lIsT3YXh2O8V1x35vhbeWFs3Vs4Yfx0Rii2Bs15Q/leeOTtVgfdDrd0z7Q+rLYJeH7mZH7oL8ir7DQF8YiPK8Dy+ymeq/4/Lb9Wz9Vw84YPm4rNA/2eyk8a2RPTmz/k0A2WndSdUuhiShz8RZk5o06bwhU9dxTx05bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884671; c=relaxed/simple;
	bh=GLb7HcmZQX1gdpiPdgniwXZvg7q5HYGuj2rJTZsZB1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/Zy9DyDxVnyTXMgfKylAWOEa4x43stl5ElLmIq9W53SQFfis8Qo/YVqqRJkMIa31XAnZqGPc8iUsmaatg8HDyHaNQtwNb/5H02DIjbqiHuLP+08DDZ5QSJYRGiGEIsuqbZBhxntlZese+t/Ll8GR+bauVT8bTAabyThW1+R9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KcYzHBOz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HD7B035681;
	Wed, 6 Nov 2024 03:17:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730884633;
	bh=iLrRXXFqcwItg0lw31N6XVp0ETawlclPWtIL3rnRHeo=;
	h=From:To:CC:Subject:Date;
	b=KcYzHBOzUEy/w4upgPzx/Y9kvkZgH+xmTlyNeAxaFzhQWQKVOHex6fmTAfCZPlPfL
	 TJHMWSpMtyCxZW6xyLYZ0bIFCM8qDJmEmp0+rfctHjuTutbZMKzH4ecJmsezU6d/ju
	 4+Ck0t5e32x98gspJ4Xg2RMmnHv0cmedvirsi6EI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A69HDIb116843
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 03:17:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 03:17:13 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 03:17:13 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HDus081192;
	Wed, 6 Nov 2024 03:17:13 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A69HBXA020759;
	Wed, 6 Nov 2024 03:17:12 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <jiri@resnulli.us>,
        <w-kwok2@ti.com>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 0/4] Introduce VLAN support in HSR
Date: Wed, 6 Nov 2024 14:47:06 +0530
Message-ID: <20241106091710.3308519-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds VLAN support to HSR framework.
This series also adds VLAN support to HSR mode of ICSSG Ethernet driver.

Changes from v2 to v3:
*) Modified hsr_ndo_vlan_rx_add_vid() to handle arbitrary HSR_PT_SLAVE_A,
HSR_PT_SLAVE_B order and skip INTERLINK port in patch 2/4 as suggested by
Paolo Abeni <pabeni@redhat.com>
*) Removed handling of HSR_PT_MASTER in hsr_ndo_vlan_rx_kill_vid() as MASTER
and INTERLINK port will be ignored anyway in the default switch case as
suggested by Paolo Abeni <pabeni@redhat.com>
*) Modified the selftest in patch 4/4 to use vlan by default. The test will
check the exposed feature `vlan-challenged` and if vlan is not supported, skip
the vlan test as suggested by Paolo Abeni <pabeni@redhat.com>. Test logs can be
found at [1]

Changes from v1 to v2:
*) Added patch 4/4 to add test script related to VLAN in HSR as asked by
Lukasz Majewski <lukma@denx.de>

[1] https://gist.githubusercontent.com/danish-ti/d309f92c640134ccc4f2c0c442de5be1/raw/9cfb5f8bd12b374ae591f4bd9ba3e91ae509ed4f/hsr_vlan_logs
v1 https://lore.kernel.org/all/20241004074715.791191-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20241024103056.3201071-1-danishanwar@ti.com/

MD Danish Anwar (1):
  selftests: hsr: Add test for VLAN

Murali Karicheri (1):
  net: hsr: Add VLAN CTAG filter support

Ravi Gunasekaran (1):
  net: ti: icssg-prueth: Add VLAN support for HSR mode

WingMan Kwok (1):
  net: hsr: Add VLAN support

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 ++++++++-
 net/hsr/hsr_device.c                         | 85 +++++++++++++++--
 net/hsr/hsr_forward.c                        | 19 +++-
 tools/testing/selftests/net/hsr/config       |  1 +
 tools/testing/selftests/net/hsr/hsr_ping.sh  | 98 ++++++++++++++++++++
 5 files changed, 236 insertions(+), 12 deletions(-)


base-commit: a84e8c05f58305dfa808bc5465c5175c29d7c9b6
-- 
2.34.1


