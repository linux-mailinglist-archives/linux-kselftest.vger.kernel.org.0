Return-Path: <linux-kselftest+bounces-22436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263619D5A35
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55F1B21248
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CD16F0EB;
	Fri, 22 Nov 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RZIUJwwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0613AA38;
	Fri, 22 Nov 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261703; cv=none; b=Tt6td4uXUTBsXUPDQ+w5SC+67MtK6Fc66jLHRyxTBzINYOcx2CGtlYmRzJgXL/eKrDLYgcrQAxP+VH5DwQ0AFGUIwE/+jkKlRUWD0FXVlOkLB9A+zUwJ+rNk3WQ8wolJbmWQyAL6Ha2mdlttSjUc+lqF5jAgTzSbJof1pHmEwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261703; c=relaxed/simple;
	bh=GNvW0YNmAwDyg6aOosIg2OjrgC1S+/+EW+BsuithU08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWVOLHs9k7zHJonWQfoetX68zT47898VY+YcXMNYq39K0lpIEbiYwrH6Ni5LShiaN0u2WIYnrVfuyT9WhK5HlO6Bk6bz3aDHTxD2eIzZoLfdyOdNyXHXR19L/SVMHVXkm/kaQrJGSMdJ/HR2zSbboabhFckLUrruj7Cgve1eKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RZIUJwwC; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732261702; x=1763797702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GNvW0YNmAwDyg6aOosIg2OjrgC1S+/+EW+BsuithU08=;
  b=RZIUJwwC1G7rGsex/LlS3/E6YUM2h/BH06qt/LlH3otwKPrGA2mfiJVa
   SOtn32eyqYg1FZyhmopjrdGu0tuaN03/llu7NEx7I0NhRzgW/M6JSe+oD
   l5/tHt/xXtUQwsAsb/FUHQLcr+M3jLt/UaincflyJNtG+lQ+i3zgW5rP7
   TezR5q/e1MhFY6uD2SoCL+3LlLaP6C6BGXuVzmuPjiZJxvXxQ2/uRMp/N
   1wKpUzRXqhk7DvjAY2GI90T018BTSQYpJZjuqbQDqDm01Bzv8mjDw/dSQ
   CYsdsEAqM0F47s66StHo5KHheucGWKnPw9iZF79H+65/ISv4FHcyHqmvI
   g==;
X-CSE-ConnectionGUID: sHM8VtxNQn2B70fxKr59ag==
X-CSE-MsgGUID: mNFZu963QtSdaiBSWS706w==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="169300573"
X-IronPort-AV: E=Sophos;i="6.12,175,1728918000"; 
   d="scan'208";a="169300573"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:47:11 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 37038DBB89;
	Fri, 22 Nov 2024 16:47:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BDF4CC19B7;
	Fri, 22 Nov 2024 16:47:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E4D42007C3F3;
	Fri, 22 Nov 2024 16:47:08 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A281B1A000B;
	Fri, 22 Nov 2024 15:47:07 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH for-next v3] selftests/cpufreq: gitignore output files and clean them in make clean
Date: Fri, 22 Nov 2024 15:47:57 +0800
Message-ID: <20241122074757.1583002-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28812.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28812.003
X-TMASE-Result: 10--5.641300-10.000000
X-TMASE-MatchedRID: hT/3bzzoPieAIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOOPh
	s17991vRV89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8f4qCLIu0mtIL5/tqn0MloN7Pt
	3qk+AS2v5jQz76et+v8rbguuTTSDuTBhdFGvbKae3D7EeeyZCM2vaomg0i4KNYUdWP7oX6sjDVt
	TLy5Lm8KGvCFqoKSwTgDLqnrRlXrYbaLjLw/bFed0H8LFZNFG7bkV4e2xSge5uexHsacBljYpNX
	Eit+Y8dMDBCDp51RoVxS4ZpqPMtYDZFEgw6u+Np
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After `make run_tests`, the git status complains:
Untracked files:
    (use "git add <file>..." to include in what will be committed)
        cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
        cpufreq/cpufreq_selftest.dmesg_full.txt
        cpufreq/cpufreq_selftest.txt

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-pm@vger.kernel.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
  add Copyright descirption
V2:
  split as a separate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/cpufreq/.gitignore | 2 ++
 tools/testing/selftests/cpufreq/Makefile   | 1 +
 2 files changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/.gitignore

diff --git a/tools/testing/selftests/cpufreq/.gitignore b/tools/testing/selftests/cpufreq/.gitignore
new file mode 100644
index 000000000000..67604e91e068
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
 
-- 
2.44.0


