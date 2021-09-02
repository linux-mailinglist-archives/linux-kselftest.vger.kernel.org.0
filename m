Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770953FEABE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 10:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbhIBImq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 04:42:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35308 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233362AbhIBImq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 04:42:46 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Avw/ria3LZLj8maIxy2eP8gqjBIAkLtp133Aq?=
 =?us-ascii?q?2lEZdPUMSL38qyiv9M516faGskd0ZJhAo6H5BEDuewK+yXcY2+Qs1NSZLXLbUQ?=
 =?us-ascii?q?mTXeNfBOLZqlWKcREWndQy6U4USchD4arLbGSS4/yX3ODyKadG/DDOytHPuQ7x?=
 =?us-ascii?q?9QYVcT1X?=
X-IronPort-AV: E=Sophos;i="5.84,371,1620662400"; 
   d="scan'208";a="113896117"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Sep 2021 16:41:46 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B52F4D0D9DC;
        Thu,  2 Sep 2021 16:41:45 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 16:41:40 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Sep 2021 16:41:39 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <bamv2005@gmail.com>, <shuah@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests/gpio: Fix gpio compiling error
Date:   Thu, 2 Sep 2021 16:46:35 +0800
Message-ID: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 8B52F4D0D9DC.AECA9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[root@iaas-rpma gpio]# make
gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selftests/gpio/gpio-mockup-cdev
gpio-mockup-cdev.c: In function ‘request_line_v2’:
gpio-mockup-cdev.c:24:30: error: storage size of ‘req’ isn’t known
   24 |  struct gpio_v2_line_request req;
      |                              ^~~
gpio-mockup-cdev.c:32:14: error: ‘GPIO_V2_LINE_FLAG_OUTPUT’ undeclared (first use in this function); did you mean ‘GPIOLINE_FLAG_IS_OUT’?
   32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
      |              ^~~~~~~~~~~~~~~~~~~~~~~~

Search headers from linux tree like others, such as sched

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/gpio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 39f2bbe8dd3d..42ea7d2aa844 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -3,5 +3,6 @@
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
+CFLAGS += -I../../../../usr/include
 
 include ../lib.mk
-- 
2.31.1



