Return-Path: <linux-kselftest+bounces-22076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04199CD556
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 03:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FE8B22F00
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC813D52E;
	Fri, 15 Nov 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DNmXZJCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7F10F2;
	Fri, 15 Nov 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637437; cv=none; b=XqLk45RNlwbPd7D9Lbhic4onmhrlb0L+pNo31R0XfosyadQDb8es+oT6VbvLUYT6leOaT+1eo6pGzdtyjM6Ab2ilCAgFplXaWLIququEhG3qjxWhnEENd7AHkNB5EPuoRmyN3WT9HGJ1CQUk4lbJxPa343Ou/GCn4pQSxGaWKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637437; c=relaxed/simple;
	bh=6v8yAyykXcLDyigDOO8TiKdwsErNtmjzZuT0f8z9eKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+kxd0CUUTYIGCrw4izOdiQgwElJ1hc8No6uE4uu5+tsUk3IPJk87ueVDG3HWNiQEbfILzQS9ssxGt/pVnolYlsWjlLhRq6h4I6rkGeVG1Ca6RHBlpgXz2t/nv4Fm2DlKQrBa5DDSjOSd7v+GYzSpCHJhUS/9WXfclU1u6kq1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DNmXZJCA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731637435; x=1763173435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6v8yAyykXcLDyigDOO8TiKdwsErNtmjzZuT0f8z9eKs=;
  b=DNmXZJCAnPMmLrXlHZZYTXGE8NLO5/i2TKi22P04gOZ7mJEkU6sa7DBn
   tDR02nEWNCBkCF/vPAGM4zqpKh5ufjAm5tWD4NVs2fuBk0I8HFQAw+hKD
   jnYlAdIC/7pgLObpDcI+ntoBvzkZ5cEvja46APSxrFAUSi15it8F8Zkk8
   Kq27coc/UJIZCszQa6nmtEhO/ZXoyihHor9dbbS9yFIV6Dt51mmx7p3w/
   Swd1qdEvxdndWXIg8PZicRzCy/hzXr0mDAbNYANnLoLSVRHhPT5FpBdt9
   j5/lqjqALDfToSE0BzTXUjMoRr9UzEcHle6XcUWJwyqRDcuzCJTF+YPIn
   w==;
X-CSE-ConnectionGUID: 44dLkhyPQcCnPJiBO6oYOQ==
X-CSE-MsgGUID: xT4XYc7wTdGwk/vZ3GM7Pw==
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="34348659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 19:23:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 19:23:07 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 19:23:02 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: [PATCH net-next v4 0/3] selftests: Add selftest for link layer and performance testing
Date: Fri, 15 Nov 2024 00:55:17 +0530
Message-ID: <20241114192545.1742514-1-mohan.prasad@microchip.com>
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
Changes in v4:
- Type hints are added for arguments and return types.
- Test values can be modified through command line.
- Minor code improvements.
- GenerateTraffic class extended for throughput test.
- Protocol testcases separated.

Changes in v3:
Link to v3: https://patchwork.kernel.org/project/netdevbpf/cover/20241016215014.401476-1-mohan.prasad@microchip.com/
- LinkConfig class is included in the hw library. This contains
  generic APIs for doing link layer operations.
- Auto-negotiation checks involve changing the auto-neg state
  both in local and partner NIC.
- Link layer test and performance test are separated to 
  different selftest files.
- Resetting of NIC driver done after test completion.

Changes in v2:
Link to v2: https://patchwork.kernel.org/project/netdevbpf/cover/20240917023525.2571082-1-mohan.prasad@microchip.com/
- Changed the hardcoded implementation of speed, duplex states,
  throughput to generic values, in order to support all type
  of NIC drivers.
- Test executes based on the supported link modes between local
  NIC driver and partner.
- Instead of lan743x directory, selftest file is now relocated 
  to /selftests/drivers/net/hw.
Link to v1: https://patchwork.kernel.org/project/netdevbpf/cover/20240903221549.1215842-1-mohan.prasad@microchip.com/
---
Mohan Prasad J (3):
  selftests: nic_link_layer: Add link layer selftest for NIC driver
  selftests: nic_link_layer: Add selftest case for speed and duplex
    states
  selftests: nic_performance: Add selftest for performance of NIC driver

 .../testing/selftests/drivers/net/hw/Makefile |   6 +-
 .../drivers/net/hw/lib/py/__init__.py         |   1 +
 .../drivers/net/hw/lib/py/linkconfig.py       | 222 ++++++++++++++++++
 .../drivers/net/hw/nic_link_layer.py          | 113 +++++++++
 .../drivers/net/hw/nic_performance.py         | 137 +++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  20 +-
 6 files changed, 496 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py

-- 
2.43.0


