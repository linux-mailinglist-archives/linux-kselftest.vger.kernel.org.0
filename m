Return-Path: <linux-kselftest+bounces-19912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D49A19D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EBE1C238E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF5143895;
	Thu, 17 Oct 2024 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GR9kuGSy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78692F36;
	Thu, 17 Oct 2024 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140475; cv=none; b=Ze5430eBGpRNMi+1xP0IXUFT7tc9Z70GwXqMwvKAzHCyC/kpC9p9wh1vkvuHqIV4C5LdwA1Vk1xiRlXvjO3/2itElAVHxMCq8JLN7cpqBkD11kYd4jVUb6JVm/SLqcApqOTBS+7injFYahU00hUaHQYe5PwDT939uNC9jNvQo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140475; c=relaxed/simple;
	bh=ylY5RHcLWYaOChDCNw9tXnZ61wrsawcZDkmiLCL+4As=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kSj/X64bR+BhtxS6Blcr8AP3fl7fumWU3rN2I7P70tL32Nv0QGRcGgl92Jssu55BVEIBwLQ55lljcD+9+kY7Op1OTJ/MBK6YvfhFIzkoIQDlzhrfXFo6/vkKjGxzvAtxHwBi7Hz1DOJCbefJRXVunFjFVvwXFHqkYrjCSfJ9yLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GR9kuGSy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729140471; x=1760676471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ylY5RHcLWYaOChDCNw9tXnZ61wrsawcZDkmiLCL+4As=;
  b=GR9kuGSyDKEg0oLCRwXtLAohjA+/c/xCY1z1ai+8Z2pdEb4Lk9+3Qynw
   A493uuWaA9TlV3qERmAh/xNCsSIjxwtyQxYnczz0bsb+yvkoEyL/p68O0
   NSssVgq0o5SOQGZynrsoRP9OmQHvc9rq4LpazTrmxuz6gKvt3PDJYBNln
   NFVA5j+IkFqztmsL6zYRnAEQDWssiFpVurgtKBNGfmiFqPBsHSFbl4ORP
   IxWas089SjHQ1DDBS53vCXhoG/Ytc8vAq53p+YPNdF2TcHBpmrKfllU5K
   3CYufqvF+9kvygB0Yk1GdIsPWLZaEYEQDdRfBxIXRs8T1Pd4QqtpuI1jp
   Q==;
X-CSE-ConnectionGUID: 8pbTCNeqT7aHxiJ1HBLGWw==
X-CSE-MsgGUID: Ij3jxNSVSjuJbYqvROB5Cg==
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="200553964"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 21:47:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 21:47:19 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 16 Oct 2024 21:47:14 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v3 0/3] selftests: Add selftest for link layer and performance testing
Date: Thu, 17 Oct 2024 03:20:04 +0530
Message-ID: <20241016215014.401476-1-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The series of patches are for doing basic tests
of NIC driver. Test comprises checks for auto-negotiation,
speed, duplex state and throughput between local NIC and
partner. Tools such as ethtool, iperf3 are used.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
Changes in v3:
- LinkConfig class is included in the hw library. This contains
  generic APIs for doing link layer operations.
- Auto-negotiation checks involve changing the auto-neg state
  both in local and partner NIC.
- Link layer test and performance test are separated to 
  different selftest files.
- Resetting of NIC driver done after test completion.

Changes in v2:
- Changed the hardcoded implementation of speed, duplex states,
  throughput to generic values, in order to support all type
  of NIC drivers.
- Test executes based on the supported link modes between local
  NIC driver and partner.
- Instead of lan743x directory, selftest file is now relocated 
  to /selftests/drivers/net/hw.
---
Mohan Prasad J (3):
  selftests: nic_link_layer: Add link layer selftest for NIC driver
  selftests: nic_link_layer: Add selftest case for speed and duplex
    states
  selftests: nic_performance: Add selftest for performance of NIC driver

 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../drivers/net/hw/lib/py/__init__.py         |   1 +
 .../drivers/net/hw/lib/py/linkconfig.py       | 220 ++++++++++++++++++
 .../drivers/net/hw/nic_link_layer.py          | 105 +++++++++
 .../drivers/net/hw/nic_performance.py         | 121 ++++++++++
 5 files changed, 449 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py

-- 
2.43.0


