Return-Path: <linux-kselftest+bounces-17101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7296B058
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 07:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627241F25F0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 05:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266182866;
	Wed,  4 Sep 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vu1ayrFB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E8433A9;
	Wed,  4 Sep 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426882; cv=none; b=SGiE+d9TUUTbqodrojSjMgpPJQOJ8ninOZpOMC8+zXWADrY3R0NaUHe9G5gJqhBmzScBoqE6iaq2vr1N6ygNrYcdosLwZ4SW2J9v4gpYw6EfTTdBX1zdVszABME8Sdtf/8CrZ1DBez9eLjS/OeQMW74SttnY1iD7HN7AzGbVnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426882; c=relaxed/simple;
	bh=W+LForudlZI+mN96e/9989TPERzQNGZMV377nucLBbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mlZt7096J7rj9JCTLYi/NPpUDWHffPYotwnoOiHLikPi9vrrxwATmZ5PSv++bBKFy+99oXxPKsEfcSPHYrynBOv7oSRR9/f0Uc1a1psdGfRG73cypv+5+SPL8kKr+rUEOhIar5mswswKAGCAcHr6abbelbUOOJ7m7s5vqb8RriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vu1ayrFB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725426881; x=1756962881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+LForudlZI+mN96e/9989TPERzQNGZMV377nucLBbw=;
  b=Vu1ayrFBIq9B/shk2WtveRUn6jVE2H+saxRgibqlGO0iggpgTmoRcHsf
   zA12PzKHRNpQcrz9UCFlGliMmd2entZMpM8TfqliIKBoBGUlYNDawqthx
   NgXP3F+Toxn8kyFS9EUzo9qdwmggrdK1PRRkkpoTT2UXdomSSrfI10AhV
   Jtby2Qrarv56u6DFVQIedu0jV4CmnY68qvmSuwMbxpI7xYk4JJyZYmYzj
   L9Cw8jN3jStFoZaMGLhV0tfkSmqTL7t5XDE8a7SBPnXUzPFGWavYJTUKT
   kTYFPGVIFL14cJExgr+La27lkMrRg/JRkEQ1pP+MI8aqrhQvnVYIBvd+9
   Q==;
X-CSE-ConnectionGUID: rZTpTODjTH2NWy2Lwmh1ng==
X-CSE-MsgGUID: eY/IxOhUSuSbszjOt62d2w==
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="262232897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 22:14:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 22:14:09 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 22:14:05 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <shuah@kernel.org>, <bryan.whitehead@microchip.com>,
	<mohan.prasad@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: [PATCH net-next 0/3] lan743x: This series of patches are for lan743x driver testing
Date: Wed, 4 Sep 2024 03:45:46 +0530
Message-ID: <20240903221549.1215842-1-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches are for testing the lan743x network driver.
Testing comprises autonegotiation, speed, duplex and throughput checks.
Tools such as ethtool, iperf3 are used in the testing process.
Performance test is done for TCP streams at different speeds.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>

Mohan Prasad J (3):
  selftests: lan743x: Add testfile for lan743x network driver
  selftests: lan743x: Add testcase to check speed and duplex state of
    lan743x
  selftests: lan743x: Add testcase to check throughput of lan743x

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/Makefile              |   2 +-
 .../drivers/net/hw/microchip/lan743x/Makefile |   7 ++
 .../net/hw/microchip/lan743x/lan743x.py       | 117 ++++++++++++++++++
 .../hw/microchip/lan743x/lib/py/__init__.py   |  16 +++
 5 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/microchip/lan743x/lib/py/__init__.py

-- 
2.43.0


