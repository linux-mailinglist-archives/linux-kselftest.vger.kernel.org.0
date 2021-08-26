Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF33F8012
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhHZBzS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:55:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41401 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235172AbhHZBzR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:55:17 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGrLBWKOohjjSYMBcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfUzSL3/qynOpoVj6faaslYssR0b9exofZPwJE80lqQFhrX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKgQeQfxEWndQ96U4PScdD4aXLfDpHZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,352,1620662400"; 
   d="scan'208";a="113479371"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Aug 2021 09:54:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id CCA704D0D4BA;
        Thu, 26 Aug 2021 09:54:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 26 Aug 2021 09:54:21 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 26 Aug 2021 09:54:18 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <philip.li@intel.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
Date:   Thu, 26 Aug 2021 09:58:45 +0800
Message-ID: <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CCA704D0D4BA.A1AD8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SYNC was removed since aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
LKP/0Day will check if all configs listing under selftests are able to be enabled properly.

For the missing configs, it will report something like:
LKP WARN miss config CONFIG_SYNC= of sync/config

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
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



