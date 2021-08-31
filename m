Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074273FC580
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhHaKT1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 06:19:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31502 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231397AbhHaKT1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 06:19:27 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AwKkaN6j+VUa9BIisDpha77OwCXBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.84,366,1620662400"; 
   d="scan'208";a="113766958"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2021 18:18:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B4EBB4D0D9DB;
        Tue, 31 Aug 2021 18:18:25 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 Aug 2021 18:18:19 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 31 Aug 2021 18:18:19 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, "kernel test robot" <lkp@intel.com>
Subject: [PATCH v3 0/2] kselftests: clean configs
Date:   Tue, 31 Aug 2021 18:23:14 +0800
Message-ID: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B4EBB4D0D9DB.A01B3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

0Day will check if all configs listing under selftests are able
to be enabled properly.

For the missing configs, it will report something like:
LKP WARN miss config CONFIG_SYNC= of sync/config

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>

Li Zhijian (2):
  selftests/sync: Remove the deprecated config SYNC
  selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST

 tools/testing/selftests/cpufreq/config | 2 +-
 tools/testing/selftests/sync/config    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.31.1



