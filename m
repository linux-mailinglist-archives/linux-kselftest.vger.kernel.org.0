Return-Path: <linux-kselftest+bounces-19695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97E99DB1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3701C20833
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EA149E16;
	Tue, 15 Oct 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YihReD8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69E82890;
	Tue, 15 Oct 2024 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954533; cv=none; b=d8cx76N6dQna3rEaE7Qxu8LzGNwM7Gu3Pg/A/kWq9rtax5Wt8E9/WPmO0O06pQwfpYpiac3bpvxaklkhpPVKPIRE8W9aXxiGZ9utoECSXlcHf9VOg6aD/rHeCOJggIHuYObmJKz/b1cSRcpjei6z0epTgnc7Y9AvaXvXxBHAi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954533; c=relaxed/simple;
	bh=FYawhF9gZT0clVcL2KVukGITmTJeMlLSK+4R7Jc9UJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enuH6HnpeSd7mTE56ZGcEnui2MMGukTOOJc9VIwV320tfYh+qr6VOow3lXj9MeTX4q4CAeOxI+SXKzwM1TpNwYX2z3yCgAeBVioV/p8yP1pyh8zINEiw/1KKESzNPm+aXJbGXXjsEeSaDdSlQr3QaEmMY2/dq2dkT2F6IggRfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YihReD8p; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728954530; x=1760490530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYawhF9gZT0clVcL2KVukGITmTJeMlLSK+4R7Jc9UJM=;
  b=YihReD8p+sP/Pa/DPtsS88qVflyzc7lNTxiBnR6XCrggjZOC/HQcQoih
   3xFiN+vzcQZpWzuPRy0LuifSh8R4QWE+76dV/8l7VCio6xq3XelOek2Lc
   Gcn883Dr1sVvPTAcP2vrQBRkIxsr6t3Mvv4Itf8hMezrqf8ZVaea8jkcQ
   tmEb+GYrFxgmv9Tx2tj9vU/Od8zIcdgID9rxFk8wNDv64MhWxeOpqtDBg
   qmzzZZ5oRndj4UzlhCC/LRhk5QP8XLaiMYb6o0SaTjmclcbmC8alvK+SD
   0rFoiovVH8LPu2vZXf5m1RM25/9gqWk4TY0tGHuiZqwtNG1yUDsyoip15
   w==;
X-CSE-ConnectionGUID: jvkhFroATiiFKCsILigaig==
X-CSE-MsgGUID: COJx4A2zSlemAkaV3uUCAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="175952434"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; 
   d="scan'208";a="175952434"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:07:37 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B9163C68E5;
	Tue, 15 Oct 2024 10:07:36 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id F2D7DC56D6;
	Tue, 15 Oct 2024 10:07:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90F5F6BD6D;
	Tue, 15 Oct 2024 10:07:35 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 210CA1A000B;
	Tue, 15 Oct 2024 09:07:35 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/3] selftests: ignore output files and clean them in Makefile
Date: Tue, 15 Oct 2024 09:08:17 +0800
Message-ID: <20241015010817.453539-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015010817.453539-1-lizhijian@fujitsu.com>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28732.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28732.003
X-TMASE-Result: 10--7.072700-10.000000
X-TMASE-MatchedRID: tlYlTTNZdz+AIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOBka
	AZoftHktcMrdJyab/PEN81EjEf6F2+BRuAss+FbmCtzGvPCy/m42ZWOmuJUS2bgbJOZ434BshFA
	nTzcsrmW1h3Ci3ttLreihEDlL1+arGAdnzrnkM48URSScn+QSXt0H8LFZNFG7bkV4e2xSge7pEy
	O57i/rZERHSQjgfIu/WoQbvMANSI1vZlbU822PH8WFcyN1Agmm
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After `make run_tests`, the git status complains:
Untracked files:
    (use "git add <file>..." to include in what will be committed)
        cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
        cpufreq/cpufreq_selftest.dmesg_full.txt
        cpufreq/cpufreq_selftest.txt
        zram/err.log

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/cpufreq/.gitignore | 1 +
 tools/testing/selftests/cpufreq/Makefile   | 1 +
 tools/testing/selftests/zram/.gitignore    | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/.gitignore
 create mode 100644 tools/testing/selftests/zram/.gitignore

diff --git a/tools/testing/selftests/cpufreq/.gitignore b/tools/testing/selftests/cpufreq/.gitignore
new file mode 100644
index 000000000000..f684d27f5d91
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/.gitignore
@@ -0,0 +1 @@
+cpufreq_selftest.*
diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
index c86ca8342222..9b2ccb10b0cf 100644
--- a/tools/testing/selftests/cpufreq/Makefile
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -3,6 +3,7 @@ all:
 
 TEST_PROGS := main.sh
 TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
+EXTRA_CLEAN := cpufreq_selftest.dmesg_cpufreq.txt cpufreq_selftest.dmesg_full.txt cpufreq_selftest.txt
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
new file mode 100644
index 000000000000..b4a2cb6fafa6
--- /dev/null
+++ b/tools/testing/selftests/zram/.gitignore
@@ -0,0 +1 @@
+err.log
-- 
2.44.0


