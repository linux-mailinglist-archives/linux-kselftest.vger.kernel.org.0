Return-Path: <linux-kselftest+bounces-20535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF729AE296
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF611C20322
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A91CACCF;
	Thu, 24 Oct 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iegj9JI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DA1C879E;
	Thu, 24 Oct 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765896; cv=none; b=HqnmXSlmzTpFNAhYSlXV7cLiq/y34b6cerM5Nqc5fllBTWjZjMxCq0SqcVsNu+2d4hJuyuZyQF99NKly3ORFL7vqd4Z2UAMWjsLJ+7VvjRMcMyOLG9o8aqJ90AhTHPQPRSyhBjmcverSw7gVNPSPd8cwZ6hyWe0pkKp595+ZeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765896; c=relaxed/simple;
	bh=1Pl3seaKsVqvUTf35IOyS4yaL/7Irx/Z/G25+DDIeC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qst0UWhX+UpkIxe6VHm+uk8WVtcjK7v8VJflys5ahJdWDOQ2Y1UYEFhFPV/jLeO9NfyPIFe9Mukc36zVjt358sb3sHMSl2h48Vz1gAzZpButMDawyzi6JUxNw2QkO7QEzws94D0OilMNVeL5VX4lijdp3HSdyqH0T6YtVx2k5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iegj9JI8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OAUweq053976;
	Thu, 24 Oct 2024 05:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729765858;
	bh=XpNsdjNUKmyHDq4lKpIhAEJl7hPe0UBSX8YCXzbXgEI=;
	h=From:To:CC:Subject:Date;
	b=Iegj9JI8GV7cVUgkk8VK6oEFNEWjg9qLG1uSjo6cKhbOE8QwkX3hLRyd3GCP4Mtb9
	 emv7tp6kVTVy+dYbOIUtHIOr4tZAFf8lK9XnJhF4kj9N4dKSgZBEPlrAb6OrHojIBA
	 h6lwEWVO5IVhHfW1Ok18OOO7JEUmKVFn115qcL7s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49OAUw47002389
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 05:30:58 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 05:30:57 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 05:30:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OAUv5N082154;
	Thu, 24 Oct 2024 05:30:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49OAUuPf024586;
	Thu, 24 Oct 2024 05:30:57 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>,
        <jiri@resnulli.us>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>
Subject: [PATCH net-next v2 0/4] Introduce VLAN support in HSR
Date: Thu, 24 Oct 2024 16:00:52 +0530
Message-ID: <20241024103056.3201071-1-danishanwar@ti.com>
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

Changes from v1 to v2:
*) Added patch 4/4 to add test script related to VLAN in HSR as asked by
Lukasz Majewski <lukma@denx.de>

v1 https://lore.kernel.org/all/20241004074715.791191-1-danishanwar@ti.com/

MD Danish Anwar (1):
  selftests: hsr: Add test for VLAN

Murali Karicheri (1):
  net: hsr: Add VLAN CTAG filter support

Ravi Gunasekaran (1):
  net: ti: icssg-prueth: Add VLAN support for HSR mode

WingMan Kwok (1):
  net: hsr: Add VLAN support

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 +++++++++++-
 net/hsr/hsr_device.c                         | 76 ++++++++++++++++++--
 net/hsr/hsr_forward.c                        | 19 +++--
 tools/testing/selftests/net/hsr/config       |  1 +
 tools/testing/selftests/net/hsr/hsr_ping.sh  | 63 +++++++++++++++-
 5 files changed, 191 insertions(+), 13 deletions(-)


base-commit: 1bf70e6c3a5346966c25e0a1ff492945b25d3f80
-- 
2.34.1


