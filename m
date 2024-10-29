Return-Path: <linux-kselftest+bounces-20892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA729B40EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 04:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113BA2838D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4691FF5F0;
	Tue, 29 Oct 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HI/GrWlr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22E200CA4;
	Tue, 29 Oct 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171638; cv=none; b=FkydgT1v+DK703pXbPgS6Gpua/dCvVE0j0oQxQ/nIzVNHb7mQnpFr5CcUZVNRoRynrREARw2EZTyZcMXGMFroDdZYCZV3A1Jl/EpgqANJR5o7Okv35Ju8hTlDt063ybW1UN7ULNztUbUbK/ooX0e7G5MDP5FeUXRc8tUvrCWkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171638; c=relaxed/simple;
	bh=awpN9ZV9QAewO1+Une17fqRPfocj076T306xTYqnGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEqRGYrY5LrM7s7Aa/3Jy72DARWQs3CQYVWpzd/eoCJ0IpOJ0SHUrSd+1oTbcpzUof3UYrMXmjIlsz1R/QetxTD7CQsLqGa4DpfLtaW1NQAWAfPv56UXDLn2zbsODYBamAQFymJvaBfizwpKlBGbwdLKVTlRa6xQQTpoKAV/fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HI/GrWlr; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1730171636; x=1761707636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=awpN9ZV9QAewO1+Une17fqRPfocj076T306xTYqnGyo=;
  b=HI/GrWlrMggdi9crIIcKWfznqGXJD59+mDn5/+uHhn0BECrlLUUGuo3B
   nvkQm2Ak9Ubvs5knCogAOxGK62bCHoYFNANFaM4qWdUdjSZgYSQxCZDGv
   txBjPvMcFchjkXSeeX53KxsdQ3ctygczOlmosdDuGOwwhTC2BJJgvaYg9
   3acOT2D+7y1pQqIu0IPT/wSfaotJE8hA6ClWQFgyqNh/65V1R+cRvZYlb
   /pe048xUjSmwfPLQgE2rC5zwgGIngjcxhqJfumRuEipIJwiPUQN4jIbPD
   BgRf09A33dYePyk6SwcXCF3EU6zC/tVKImileKUQ5ZY8+aNFmFmftQDI0
   w==;
X-CSE-ConnectionGUID: PQekpmrxSwOCY3FKBbgvsw==
X-CSE-MsgGUID: kA/cG6MARru3ZUcWVwsZug==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="178536189"
X-IronPort-AV: E=Sophos;i="6.11,240,1725289200"; 
   d="scan'208";a="178536189"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:12:43 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5EF03C68E1;
	Tue, 29 Oct 2024 12:12:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F232CFB68;
	Tue, 29 Oct 2024 12:12:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2245F6BE5B;
	Tue, 29 Oct 2024 12:12:40 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 69D261A000B;
	Tue, 29 Oct 2024 11:12:39 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] selftests/watchdog-test: Fix system accidentally reset after watchdog-test
Date: Tue, 29 Oct 2024 11:13:24 +0800
Message-ID: <20241029031324.482800-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28760.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28760.004
X-TMASE-Result: 10--1.201400-10.000000
X-TMASE-MatchedRID: R1u6Jncx2x3ySUS2aTJPt6qHmm/V4M/PgbNN0R684zOMJxigKCCiS5Pt
	b9/hXhKLQYv578GocN2kulA7P59GulZ4zYLYihwUhqdH8K9g7xdMkOX0UoduucC5DTEMxpeQsqh
	SzMv5Wab/5j56PnN5eoAy6p60ZV62yA7duzCw6dLdB/CxWTRRu+rAZ8KTspSzzIxwTX5XbPrh3f
	DELC/NH/TBE6iYwCJ6mBu1N2mMu/rdZyiuw899e527JgrsY427YmGiX+0Co1/+khSV9pCKGpPIt
	N3u2pQfIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When running watchdog-test with 'make run_tests', the watchdog-test will
be terminated by a timeout signal(SIGTERM) due to the test timemout.

And then, a system reboot would happen due to watchdog not stop. see
the dmesg as below:
```
[ 1367.185172] watchdog: watchdog0: watchdog did not stop!
```

Fix it by registering more signals(including SIGTERM) in watchdog-test,
where its signal handler will stop the watchdog.

After that
 # timeout 1 ./watchdog-test
 Watchdog Ticking Away!
 .
 Stopping watchdog ticks...

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index bc71cbca0dde..a1f506ba5578 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -334,7 +334,13 @@ int main(int argc, char *argv[])
 
 	printf("Watchdog Ticking Away!\n");
 
+	/*
+	 * Register the signals
+	 */
 	signal(SIGINT, term);
+	signal(SIGTERM, term);
+	signal(SIGKILL, term);
+	signal(SIGQUIT, term);
 
 	while (1) {
 		keep_alive();
-- 
2.44.0


