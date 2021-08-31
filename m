Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8D3FC585
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbhHaKTa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 06:19:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60361 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240882AbhHaKT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 06:19:28 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AySs1ua5N5ggSAu3fswPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,366,1620662400"; 
   d="scan'208";a="113766963"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2021 18:18:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 66E934D0D9D1;
        Tue, 31 Aug 2021 18:18:27 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 Aug 2021 18:18:27 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 Aug 2021 18:18:26 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 31 Aug 2021 18:18:25 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] selftests/sync: Remove the deprecated config SYNC
Date:   Tue, 31 Aug 2021 18:23:15 +0800
Message-ID: <20210831102316.280512-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
References: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 66E934D0D9D1.AC448
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SYNC was removed since
aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
LKP/0Day will check if all configs listing under selftests are able to
be enabled properly.

For the missing configs, it will report something like:
LKP WARN miss config CONFIG_SYNC= of sync/config

- it's not reasonable to keep the deprecated configs.
- configs under kselftests are recommended by corresponding tests.
So if some configs are missing, it will impact the testing results

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
V3: update commit logs # Shuah
---
 tools/testing/selftests/sync/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/sync/config b/tools/testing/selftests/sync/config
index 1ab7e8130db2..47ff5afc3727 100644
--- a/tools/testing/selftests/sync/config
+++ b/tools/testing/selftests/sync/config
@@ -1,4 +1,3 @@
 CONFIG_STAGING=y
 CONFIG_ANDROID=y
-CONFIG_SYNC=y
 CONFIG_SW_SYNC=y
-- 
2.31.1



