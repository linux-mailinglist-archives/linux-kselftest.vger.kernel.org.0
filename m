Return-Path: <linux-kselftest+bounces-20594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF99AF6F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BE21F21042
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75045009;
	Fri, 25 Oct 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QoQuaK6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF62744B;
	Fri, 25 Oct 2024 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820383; cv=none; b=dv7BNH1Ixa68qvHME5PCUzKGCds413DZvGirc3+cJfwVeeHdoNKohF3FosageTh2jdp8jEr55GS1rd8+Yb47tKqckmKafhe0MVQzucda6ucmxHTszSC0djwTRH9UmySEqQ0ngStHnw37ppMOLL6ctkZK46+UdBKtPPoWs18266M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820383; c=relaxed/simple;
	bh=5ogVt9gTGBQ4g15QEMXwFnukAEs0OCVQRkBosAlI6tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzVcKA8x4NDKHyJznqePsMWFUYgA2ejKcfBVqiUmvPnHNkoUl4OqBWEgEuYJrB7R+sMgBvTJEteISuLdYb4AMXqaXAwBvZVrBbLr/TmSfSAvMojOeFWyJPK7dVNzaAbMCPTml8e94d9N5tX26OTF2DeUB1Rwg2xK5PEcmsxFtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QoQuaK6w; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820382; x=1761356382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ogVt9gTGBQ4g15QEMXwFnukAEs0OCVQRkBosAlI6tg=;
  b=QoQuaK6wQU2Y8vtDpHm9fHtAEsZX7kjjK+XwNrDjAwLyXGJ9HsSvzbEt
   OtU//xokhj6aL17MsbrKgslTklad2tV3XBX33Dky5WKiztLwHO2h38Ku2
   F8iKE4ca4Rd1Br9SRuFizzaBmA/KtEym2AqDG2JfwtXJr3wQRJXKkz7Jq
   Y0yk7UbyYsRsMbh6HjVQnirO6utCwPH0a/o6H6taWE4k6idef0YsqCTyE
   H/8BEsV7z6eVXE95Ck1lNSooUnRglBf0LFGwBbj7h4GypxfUIORkGTgFe
   Jt5ToewtUdkX4puOWz6DsHo028Q++ddR/m4FHrX8w2sLir8bn2setX3oi
   A==;
X-CSE-ConnectionGUID: 4z1d/5vNSaKTlyXQZC+gZA==
X-CSE-MsgGUID: SG4zrXoISsO0/RiQCi6k8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="177927662"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="177927662"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:38 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 86BE9D9223;
	Fri, 25 Oct 2024 10:39:36 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C3CFAD7461;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D79620071A06;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id DB5D81A000B;
	Fri, 25 Oct 2024 09:39:34 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 6/7] selftests/zram: gitignore output file
Date: Fri, 25 Oct 2024 09:40:09 +0800
Message-ID: <20241025014010.6533-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--12.338400-10.000000
X-TMASE-MatchedRID: hT/3bzzoPieAIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOBka
	AZoftHktcMrdJyab/PE7316J37LffS8oE1Ngob6lrMZ+BqQt2NrJ5SXtoJPLyFcZNuxCoduSsaY
	IF6sQsQ6Rcw/1JlbBVPi01xSSk4wo4FG4Cyz4VuYK3Ma88LL+bjZlY6a4lRLZuBsk5njfgGxp4q
	Y9LyzTaKGvCFqoKSwTgDLqnrRlXrb9VAfQOqUygt0H8LFZNFG7bkV4e2xSge4lEORpkdkPIH+Me
	rwdBc1Md/FKCRqdlzIi8+PRGUrXNB/BXqwE9HSW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After `make run_tests`, the git status complains:
Untracked files:
    (use "git add <file>..." to include in what will be committed)
        zram/err.log

This file will be cleaned up when execute 'make clean'

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/zram/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/zram/.gitignore

diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
new file mode 100644
index 000000000000..b4a2cb6fafa6
--- /dev/null
+++ b/tools/testing/selftests/zram/.gitignore
@@ -0,0 +1 @@
+err.log
-- 
2.44.0


