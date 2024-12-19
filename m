Return-Path: <linux-kselftest+bounces-23582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B99F77D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FABE16AF87
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75622146E;
	Thu, 19 Dec 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cCgGt0Y9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426EC1FA174;
	Thu, 19 Dec 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598724; cv=none; b=Kt/h/XFChyqTq7WDsq2Mp1PexL5EfeJwafz9w3SIXkRp8+160E8wnvRM3Jmjck7t6e3Db7BixEcQLeHxoXJm7uR6M2mb/4xgYnSloq461xjlWCpzUWjp8YKcfTNQHaRaiNnEDyGl+Ne7JBrmyFqHxTcsdOtQS/HBmKMLK5HK6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598724; c=relaxed/simple;
	bh=r235KXsKtpOWvva4ExNas8rWHaEiUsyLYktMeM+2PsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGNien4oMUsBHj8hvLiw32yH0tvhT0g1gYISKvleP3k9quKNRLE3bB9SEzxKDIv0C6DueXTH1QqOmuoxBXdf8AEaqDtGSd6rAZUo9g+8p2SGnUWhBE08t2AmtzSEMSUes9UftwT6GH4Q8A6ogi+t7P1aukPy72JueJmt5/pdmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cCgGt0Y9; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734598722; x=1766134722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r235KXsKtpOWvva4ExNas8rWHaEiUsyLYktMeM+2PsU=;
  b=cCgGt0Y9cnnZYsa7oZMZ7FZxJaVqrY+a+TszJcecnbjdS5dS/fjSx7kN
   rNVpVGkkmwN4bHhEgtIQnIB4SpeUZuy3XbvdA+mX0BmjyZadv5yuGhBro
   q7kbZIXrPH8pLdL6v6M9+X8l5s8G0gALLsI54jmkgy9qPo7l5bV5Ljq4T
   CA510fO2ggAuHyci3vMy1Blwc3VYy1JAcd4ZRiwSDnlRtDpSxp7tBZwI1
   kx23w95vWw9zLxsTiBjOpziBqA78HbhiZo9SGe4Qr81hUlzNgNokgmSq6
   9/Hs8EVJkj0I0uaUV2jNizKJ3XgnHs8c2zNZezQ8aFpgPdPVoYzJhc8Se
   Q==;
X-CSE-ConnectionGUID: sxuTwDafQaO7gyTIkDP+bw==
X-CSE-MsgGUID: VET7gJo6SL+toOcmexgxZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="171631681"
X-IronPort-AV: E=Sophos;i="6.12,247,1728918000"; 
   d="scan'208";a="171631681"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 17:57:31 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BCDDCD6EA5;
	Thu, 19 Dec 2024 17:57:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C9D5D9748;
	Thu, 19 Dec 2024 17:57:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 00D1A220E74;
	Thu, 19 Dec 2024 17:57:28 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E84831A006C;
	Thu, 19 Dec 2024 16:57:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 0/2] selftests: Fix run_tests and install for net TARGET
Date: Thu, 19 Dec 2024 16:58:01 +0800
Message-ID: <20241219085803.1145606-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28868.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28868.006
X-TMASE-Result: 10--3.178200-10.000000
X-TMASE-MatchedRID: cEobPIBZMxau2WUlRg7UeirLqyE6Ur/jgbNN0R684zMT4iDztnfIOWZY
	/RdXrUKNHWa2bSeZPhtgRWLzgh5fxjcpdZ3fQiLdFEUknJ/kEl51f3bbwLy/mMLQF1IYnOnS5MI
	x11wv+COyO81X3yak8+/YZNRftZZqWSU6E2ZmcuAJuRO60D4LfRjOxKAktS7dmV9yAfU8E4BbjB
	uldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This patch set intends to fix the errors in install and run_tests when
'O=' is specified. such as `make O=/path/to/build TARGETS=net kselftest-install`


Li Zhijian (2):
  selftests/Makefile: Create BUILD_TARGET directory for
    INSTALL_DEP_TARGETS
  selftests/Makefile: add INSTALL_DEP_TARGETS to run_tests

 tools/testing/selftests/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.44.0


