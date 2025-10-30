Return-Path: <linux-kselftest+bounces-44374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D3C1E2BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53E1F4E402E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912432C93D;
	Thu, 30 Oct 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vbsfuC9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8681D90DD;
	Thu, 30 Oct 2025 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793183; cv=none; b=UktoQ5o0WPbdPfjsaTW7XvwhYSxosuML44oZHL6xW6RcCfo7JZH4ysqQ5Z7b8zZIetNw7Qay1q8yUUheMRfH8QBwDBvKBG7A4f5+pXJs5mYDlAn18iUgXzQfad+u5luBz3v4zVvwugUKJZBTVeVEdf8fx8rnVj9RGMzNPFvkMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793183; c=relaxed/simple;
	bh=Z4FwOYA/MldwEQbaY9hWHxKlarFAnNtyi81ff7lqBLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfMk7+QeM3QwuoycY1dcGvvdCi2OBxI7YZmXyeIGbjfOcZLmDQMBWOhtZ2eyh4rOhtzPq21UP54PDQnl1osaefnimhgjP9fgws6a3fWsnpHqb9nWq8R9Txyh6TVFSPvzJ3nCKD9aHxvXmYsGApHXrPD9l8/1nFnCiHKItRI2TWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vbsfuC9X; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yN4Cw98grPeKEFg5pNB+m6iIWvIp3cWZHIUyPfIenTE=;
	b=vbsfuC9XET+2HODu4FEzZ2m7E/fMvEt9RbeE13q5ubLuYFpkC1cnMHO90l4jR6gQUrXlBn8P7
	QrsqasZ/n27l9rXAoFxBsB/SaLRZcABI97ByDZ9gyptCft3ogCbcLoR/T83CALJ1/bmOwmJfFRR
	9MeIeSpgpWHZCV9be7EjZKo=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cxpjL3mjYzmV6g;
	Thu, 30 Oct 2025 10:59:02 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C66EA14013B;
	Thu, 30 Oct 2025 10:59:31 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:59:30 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <kuba@kernel.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<horms@kernel.org>, <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Date: Thu, 30 Oct 2025 11:22:03 +0800
Message-ID: <20251030032203.442961-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The test 'ethtool-features.sh' failed with the below output:

  TAP version 13
  1..1
  # timeout set to 600
  # selftests: drivers/net/netdevsim: ethtool-features.sh
  # Warning: file ethtool-features.sh is not executable
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # ethtool: bad command line argument(s)
  # For more information run ethtool -h
  # FAILED 10/10 checks
  not ok 1 selftests: drivers/net/netdevsim: ethtool-features.sh # exit=1

Similar to commit 18378b0e49d9 ("selftests/damon: Add executable
permission to test scripts"), the script 'ethtool-features.sh' has no
executable permission, which leads to the warning 'file
ethtool-features.sh is not executable'.

Old version ethtool (my ethtool version is 5.16) does not support command
'ethtool --json -k enp1s0', which leads to the output 'ethtool: bad
command line argument(s)'.

This patch adds executable permission to script 'ethtool-features.sh', and
check 'ethtool --json -k' support. After this patch:

  TAP version 13
  1..1
  # timeout set to 600
  # selftests: drivers/net/netdevsim: ethtool-features.sh
  # SKIP: No --json -k support in ethtool
  ok 1 selftests: drivers/net/netdevsim: ethtool-features.sh

Fixes: 0189270117c3 ("selftests: netdevsim: add a test checking ethtool features")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 .../selftests/drivers/net/netdevsim/ethtool-features.sh      | 5 +++++
 1 file changed, 5 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
old mode 100644
new mode 100755
index bc210dc6ad2d..f771dc6839ea
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
@@ -7,6 +7,11 @@ NSIM_NETDEV=$(make_netdev)
 
 set -o pipefail
 
+if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then
+	echo "SKIP: No --json -k support in ethtool"
+	exit $ksft_skip
+fi
+
 FEATS="
   tx-checksum-ip-generic
   tx-scatter-gather
-- 
2.34.1


