Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD33C43F50B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhJ2Csp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 22:48:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36610 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231348AbhJ2Csp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 22:48:45 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AGYcfUat4ylTs3oZKa2wRdCQm3ufnVNpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3xmAYUWqHO/mDZjbxcop1O96180oCvp/dmIM2QQdoqyxgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUba?=
 =?us-ascii?q?eangqLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1JtI6wS?=
 =?us-ascii?q?AUoN6vklvkfUgVDDmd1OqguFLrveCHh7JLDnhKZG5fr67A0ZK0sBqUT+vx2Gn1?=
 =?us-ascii?q?P/PowIioEcxaOnaS3x9qTTup0rsUlMMTveogYvxlI1THYCfc+B5TCa6TM+dJcm?=
 =?us-ascii?q?jw3g6hmBvbDbsoxajd1ahnEJRpVNT8/DJM4gffthXTldTBcgEyaqLBx4GXJygF?=
 =?us-ascii?q?1lr/3P7L9ft2MWNUQnV2Vomza8n/lKg8VOcbZyjef9H+owOjVkkvGtCg6fFGj3?=
 =?us-ascii?q?qcyxgTNmSpIU1tLPWZXaMKR0iaWM++z4WRIksb2kZUPyQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AlNLi+6rTErvUOvz5V1s6yKEaV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsyMc6QxhIU3I9urhBEDtex/hHNtOkOws1NSZLW7bUQ?=
 =?us-ascii?q?mTXeJfBOLZqlWKcUDDH6xmpMNdmsNFaeEYY2IUsS+D2njbLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116568977"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 10:46:16 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B88604D0F910;
        Fri, 29 Oct 2021 10:46:12 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 10:46:07 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 10:46:07 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Christian Brauner <christian@brauner.io>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] ksefltest: pidfd: Fix wait_states: Test terminated by timeout
Date:   Fri, 29 Oct 2021 10:45:28 +0800
Message-ID: <20211029024528.8086-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
References: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B88604D0F910.AD04C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

0Day/LKP observed that the kselftest blocks foever since one of the
pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
the source, we found that it blocks at:
ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);

we can reproduce it by:
$ while true; do make run_tests -C pidfd; done

a delay to ensure that the parent can see child process WCONTINUED.

CC: Christian Brauner <christian@brauner.io>
CC: Shuah Khan <shuah@kernel.org>
CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/pidfd/pidfd_wait.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index be2943f072f6..5abd26da4caa 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -107,7 +107,9 @@ TEST(wait_states)
 
 	if (pid == 0) {
 		kill(getpid(), SIGSTOP);
+		usleep(1000);
 		kill(getpid(), SIGSTOP);
+		usleep(1000);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.33.0



