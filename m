Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F13F8018
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhHZBzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:55:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41401 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235172AbhHZBzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:55:21 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aq6j6h6+fvmy5LgFRAk5uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,352,1620662400"; 
   d="scan'208";a="113479374"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Aug 2021 09:54:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 28CA24D0D9D1;
        Thu, 26 Aug 2021 09:54:31 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 26 Aug 2021 09:54:20 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 26 Aug 2021 09:54:19 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 2/3] selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST
Date:   Thu, 26 Aug 2021 09:58:46 +0800
Message-ID: <20210826015847.7416-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 28CA24D0D9D1.AF687
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
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



