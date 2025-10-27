Return-Path: <linux-kselftest+bounces-44078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB6C0BC62
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 05:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A6189B524
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 04:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD636238145;
	Mon, 27 Oct 2025 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vqx/o+1l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920D18AFD;
	Mon, 27 Oct 2025 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761538060; cv=none; b=io2rGhH7CRqcEpgdlHiAJL5ssZKA+H8iEHBgwJpqmXvtjP+V2C3yH9pXljssklBqsvbUAUF5U95dXY+w7jmoe89uy1/etxOIT2FSKeuvRDXioJnBN0czxn0aEUQ/Es0FPTW/F2layPqaPLg7mb+YjyzLQ93usmiPBDweiaKnvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761538060; c=relaxed/simple;
	bh=C592mbCQevtEPnS3JNbZTZV1xz2slqt/UhHNUknqmQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUE7Im9FnnfsXC7ZGU99I01dunu4Zx9vF4G09g/H7vrVAPvseHhBfklqdcAoJ9CnYDc6yT1yMGIjCYvAK2QydMNhozj1PvPEt8D1M3ji78/ANSckOldcmdNcHF1shAo2Li0eoscaW/p9556Hg4Op6NlFajp/Fngy/5k2tUmS8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vqx/o+1l; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WFKhqbdplhNXw7kSiCO7XFmkhdB23FzCb114U3VJ2xw=;
	b=Vqx/o+1l1i56f4oqksfKl/8KAwDsBBB8EYUoOsb2BWXaUg5+2AXGR5vvfPh6ykHb1DFCkPJuG
	4Jw6xkoEFk2eqpToEIJCcjJ167BIkkpK7KZWDIPrx0OQUus21zN2evC/xKvzh0hX7MerZd4mVLJ
	deyldtsTARnSqlZKb0CIdhs=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cw0M94Qcnz1K98C;
	Mon, 27 Oct 2025 12:07:01 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EC901A0188;
	Mon, 27 Oct 2025 12:07:28 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 12:07:27 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<acardace@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net] selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh
Date: Mon, 27 Oct 2025 12:30:07 +0800
Message-ID: <20251027043007.1315917-1-wangliang74@huawei.com>
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
 tools/testing/selftests/drivers/net/netdevsim/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index daf51113c827..653141a654a0 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -20,4 +20,6 @@ TEST_PROGS := \
 	udp_tunnel_nic.sh \
 # end of TEST_PROGS
 
+TEST_FILES := ethtool-common.sh
+
 include ../../../lib.mk
-- 
2.34.1


