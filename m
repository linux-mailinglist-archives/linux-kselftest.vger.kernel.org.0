Return-Path: <linux-kselftest+bounces-44379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF477C1E3A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF609407874
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE212D1913;
	Thu, 30 Oct 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2xh+JsWu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DF2D2388;
	Thu, 30 Oct 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795677; cv=none; b=suDGYuv/61D335zL3vbjY7x6rJl5+35oL0baWJJC3LrFSNWwaHA06Sm+1iPOTC1vw6rgvNuXAiZRyObg/4sCYpxsdyj+l3mIFbgiLA6vN3HyqN74gzz9tDOLKow+u7Wb/+SwXkn6gAqeyN94ARXCC0Fl/iiikp17oQiGnJnM+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795677; c=relaxed/simple;
	bh=/cVS4yT64QIgyXL3FQrBtgEyG7Mn5XWI2t06y36mDF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOfnqdh4vRzUhY5BklDfx2jJv9cdhlQnCBNPn+ue+H5KvKLfb2LVjxST6OuMsm1DUBOJIZl0cA1aRxsqEb9oIpLW8Q43zYsuM6rUJaboWDHKm/onKyJCuXyjYXQ9s3ZK2mNDNUgKHeLBqcrERmoOad21OOqDlYZBkmMR57dHAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2xh+JsWu; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WnqNB/gf7wv9JnLF8CMDUlVB8RyF7+ahjh8o+b9yDPI=;
	b=2xh+JsWumT3y3tETW0QfGL5IhgHNYU+7Ab8103JPu9/rH3GwepRGh7o15Qc4F5TQCQWXpPZMs
	LixUGO56TerpVjse865fVnfhTqXupGQb+UXuraIjsQAhbI8VZOyL6FK1H5Vc644q6xaQR+Miu7r
	GnPUjdomzq+bjkPOHX7hDa4=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cxqdM17mkzRhRs;
	Thu, 30 Oct 2025 11:40:39 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id BF46E18007F;
	Thu, 30 Oct 2025 11:41:08 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:41:07 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<acardace@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net v2] selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh
Date: Thu, 30 Oct 2025 12:03:40 +0800
Message-ID: <20251030040340.3258110-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The script "ethtool-common.sh" is not installed in INSTALL_PATH, and
triggers some errors when I try to run the test
'drivers/net/netdevsim/ethtool-coalesce.sh':

  TAP version 13
  1..1
  # timeout set to 600
  # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
  # ./ethtool-coalesce.sh: line 4: ethtool-common.sh: No such file or directory
  # ./ethtool-coalesce.sh: line 25: make_netdev: command not found
  # ethtool: bad command line argument(s)
  # ./ethtool-coalesce.sh: line 124: check: command not found
  # ./ethtool-coalesce.sh: line 126: [: -eq: unary operator expected
  # FAILED /0 checks
  not ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh # exit=1

Install this file to avoid this error. After this patch:

  TAP version 13
  1..1
  # timeout set to 600
  # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
  # PASSED all 22 checks
  ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh

Fixes: fbb8531e58bd ("selftests: extract common functions in ethtool-common.sh")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 tools/testing/selftests/drivers/net/netdevsim/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index daf51113c827..df10c7243511 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -20,4 +20,8 @@ TEST_PROGS := \
 	udp_tunnel_nic.sh \
 # end of TEST_PROGS
 
+TEST_FILES := \
+	ethtool-common.sh
+# end of TEST_FILES
+
 include ../../../lib.mk
-- 
2.34.1


