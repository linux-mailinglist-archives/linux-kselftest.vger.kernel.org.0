Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F241A0898
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDGHr2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 03:47:28 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35054 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726635AbgDGHr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 03:47:28 -0400
X-IronPort-AV: E=Sophos;i="5.72,353,1580745600"; 
   d="scan'208";a="88605379"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Apr 2020 15:47:24 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id ABD92406AB15;
        Tue,  7 Apr 2020 15:37:02 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 7 Apr 2020 15:47:23 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 7 Apr 2020 15:47:25 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] selftests/ftrace: Check the first record for kprobe_args_type.tc
Date:   Tue, 7 Apr 2020 14:34:19 +0800
Message-ID: <20200407063419.292821-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ABD92406AB15.A8C4E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is possible to get multiple records from trace during test and then more
than 4 arguments are assigned to ARGS.  This situation results in the failure
of kprobe_args_type.tc.  For example:
-----------------------------------------------------------
grep testprobe trace
   ftracetest-5902  [001] d... 111195.682227: testprobe: (_do_fork+0x0/0x460) arg1=334823024 arg2=334823024 arg3=0x13f4fe70 arg4=7
     pmlogger-5949  [000] d... 111195.709898: testprobe: (_do_fork+0x0/0x460) arg1=345308784 arg2=345308784 arg3=0x1494fe70 arg4=7
 grep testprobe trace
 sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'
ARGS='334823024 334823024 0x13f4fe70 7
345308784 345308784 0x1494fe70 7'
-----------------------------------------------------------

We don't care which process calls do_fork so just check the first record to
fix the issue.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 1bcb67dcae26..81490ecaaa92 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -38,7 +38,7 @@ for width in 64 32 16 8; do
   echo 0 > events/kprobes/testprobe/enable
 
   : "Confirm the arguments is recorded in given types correctly"
-  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
   check_types $ARGS $width
 
   : "Clear event for next loop"
-- 
2.25.1



