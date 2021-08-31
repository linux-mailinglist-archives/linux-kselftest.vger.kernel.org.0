Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E792F3FC583
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhHaKT3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 06:19:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31502 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235826AbhHaKT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 06:19:28 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Abb3EjK5ImftZNrmNQwPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,366,1620662400"; 
   d="scan'208";a="113766962"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2021 18:18:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id CDC844D0D9D8;
        Tue, 31 Aug 2021 18:18:27 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 Aug 2021 18:18:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 31 Aug 2021 18:18:27 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v3 2/2] selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST
Date:   Tue, 31 Aug 2021 18:23:16 +0800
Message-ID: <20210831102316.280512-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
References: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CDC844D0D9D8.AF1C2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DEBUG_PI_LIST was renamed to DEBUG_PLIST since
8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")

- It's not reasonable to keep the deprecated configs.
- configs under kselftests are recommended by corresponding tests.
So if some configs are missing, it will impact the testing results

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
v3: update commit logs # Shuah
---
 tools/testing/selftests/cpufreq/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
index 27ff72ebd0f5..75e900793e8a 100644
--- a/tools/testing/selftests/cpufreq/config
+++ b/tools/testing/selftests/cpufreq/config
@@ -6,7 +6,7 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_PI_LIST=y
+CONFIG_DEBUG_PLIST=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_LOCK_ALLOC=y
-- 
2.31.1



