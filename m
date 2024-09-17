Return-Path: <linux-kselftest+bounces-18069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605497ADF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691021C220A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA681586CB;
	Tue, 17 Sep 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uv38flpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D3150990;
	Tue, 17 Sep 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565599; cv=none; b=QS/YWj4WAgMeYaPMmq1oVU38/1L8WuG5Cy8D8otUUJeQxI/0RfH4+Hki3M6zUGfMYr+dwbEzlGDseKtgjgQ8ywJ3s0OYlPlwNLaY60E+bGZgHHzv4e2CJHMtyhXQjH91Qjz5YW6kcn6abkxHu2OmqSRnt/GvfBRCZaxZ+fKqBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565599; c=relaxed/simple;
	bh=keMMIiSmAfjl19Ahw9VGjGPC5u687GA4L44+iIF4G68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNYOOZZpRJcGYQ3ZteS2Dy6bviCJUPjk/E/7Ogzx2NBs6lIVLbLcfXb+AJV9eeCkfS+xB9t84O46xrOBKuO7Xz5RSkz9/NJgqWitvFEeRvzeEXVKmQo7FCC8f6oxwbrs4vJujdsapl+6FEzvyXl2vL8wQVN0ZbYUNX3qn3i/upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uv38flpe; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726565597; x=1758101597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=keMMIiSmAfjl19Ahw9VGjGPC5u687GA4L44+iIF4G68=;
  b=uv38flpeHgOpnJ1HUb3CzXN+q5RSQD6wWJTZMvH6ySn3yJ8ei2BcqNEv
   +Y+dPriKGRS8VIhb+QhzrYspej6hy5F0apbcvTBMK6RLhRkO4Z74UbgFl
   24Xj+93+G2Im5QXk4FvyHPSbCAfoSj+x5oBqTEoCM3UxwJIrrkekji2n5
   xoBYKAI1EXzngBf8IG4qo8KPK4iZmsD4po9K966hrvAowlhniCYxQICB5
   wBuV2+QUUxT33t9Na/H/vuEJx6sLkWykmDwE7iVxo/pnvssYec0KOWjFS
   WTARLfALkP9HY8Z/RjFrZ0gk39yLSZrcFbzew0COgibYT4RC6P77slBDY
   w==;
X-CSE-ConnectionGUID: 6j7NM/cARrCart7pGaXQPQ==
X-CSE-MsgGUID: SW36Ovf1QzuL+9ypztZ85w==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="31767002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 02:33:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 02:32:35 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 02:32:31 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<mohan.prasad@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>
Subject: [PATCH net-next v2 0/3] nic_basic_tests: Add selftest for doing basic tests of NIC driver
Date: Tue, 17 Sep 2024 08:04:06 +0530
Message-ID: <20240917023525.2571082-1-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The series of patches are for doing basic tests of NIC driver.
Test comprises checks for auto-negotiation, speed,
duplex state and throughput between local NIC and partner.
Tools such as ethtool, iperf3 are used.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
Changes in v2:
- Changed the hardcoded implementation of speed, duplex states,
  throughput to generic values, in order to support all type
  of NIC drivers.
- Test executes based on the supported link modes between local
  NIC driver and partner.
- Instead of lan743x directory, selftest file is now placed in
  /selftests/drivers/net/hw.
---
Mohan Prasad J (3):
  selftests: nic_basic_tests: Add selftest file for basic tests of NIC
  selftests: nic_basic_tests: Add selftest case for speed and duplex
    state checks
  selftests: nic_basic_tests: Add selftest case for throughput check

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/nic_basic_tests.py         | 230 ++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_basic_tests.py

-- 
2.43.0


