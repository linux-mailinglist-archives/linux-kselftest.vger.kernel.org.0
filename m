Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AE15472B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBFPKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 10:10:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBFPKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 10:10:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F87F9142665;
        Thu, 6 Feb 2020 15:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ARPonP1U7McuPo6Qy5eAIFbn137aCvnTTbf1VmVmhp0=;
 b=iqj8wJKodIMyaMhZ4RoBknQTCdn2KxRTDl3wNGcP+Gi2NSykO89ELRAwM9F1TqCrylWC
 kdEvrXDjckAZnFzjbcuGKtkF+uN9RZu2FeuKGVIUVP6YlMVUkRYg8YCx2O35UY9xjImP
 SV3x42bWPfpvn4wn6oAuwUicULbOGqNVS9eCZIQDsK4fFjzVSAyS5FtOJxprRRpUhJd3
 Fyt3rz6xFEPqC5fQjPKHi/r+0ttnE7vUETdhkLZYzMGev3AI1GmsqwoiMMswvTStLx4B
 SDwejtMmXiRhgydsRB8b3AvMel4y2xQOOkrzVHB7xIaXGwlSLu2NVj6jcm2LTOYrchrn 0A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ARPonP1U7McuPo6Qy5eAIFbn137aCvnTTbf1VmVmhp0=;
 b=WXVQpb1OLnwYAD1qisJmzC7CtQOjMDttQCNf5lb4VthK5pDecqKQZHJ1Q9sxmFu86XuA
 OwNwGZ33sZxdtU5MDnFg1B02p4opI7qBnHZItKodUyQGx2tFGRqTaiCuJjDZgbksFde3
 XyAh8C/Xp1U7Zk72oQStN0w9WcfD+sTv/4U67SWbZLnDVtKRyAZKZdcW/5TIjsq2SZjU
 UzSf+0oDZ0zUbprVrEBBLDlNvpIUBgFW2ZGLmn+Kbs4oOCn341tYYzd6HFB3mX2U8kvu
 MfrVkGUeE2OFGtJKrqw73GpbaTal+OM1Zp44GUjMGT6NZz3/bNRAQdu60udHT2puhrjB 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xykbpaaa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:09:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F9JEA135306;
        Thu, 6 Feb 2020 15:09:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y0mnjtej0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:09:56 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016F9tUX010096;
        Thu, 6 Feb 2020 15:09:55 GMT
Received: from dhcp-10-175-186-149.vpn.oracle.com (/10.175.186.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 07:09:55 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        colin.king@canonical.com
Subject: [PATCH 2/2] ftrace/selftest: absence of modules/programs should trigger unsupported errors
Date:   Thu,  6 Feb 2020 15:09:20 +0000
Message-Id: <1581001760-29831-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060116
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In a number of cases, the ftrace tests check for the presence of
ftrace testing-related modules (ftrace-direct, trace-printk) and
programs (checkbashisms), returning exit_unresolved if these
are not found.  The problem is, exit_unresolved causes execution
of ftracetest to return an error, when really our tests are
failing due to not having the requisite kernel configuration/tools
present, which is I think more of an unsupported error condition.
With these fixed, we see no unresolved test cases and ftracetest
returns success ("ok" when run via kselftest).

Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
Fixes: ff431b1390cb ("selftests/ftrace: Add a test to probe module functions")
Fixes: 4a075bd4e13f ("selftests/ftrace: Add checkbashisms meta-testcase")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index d75a869..3d6189e 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -5,7 +5,7 @@
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 echo "Let the module run a little"
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 801ecb6..3d0e3ca 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -5,7 +5,7 @@
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 if [ ! -f kprobe_events ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
index b02550b..dd8b10d 100644
--- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
@@ -5,7 +5,7 @@
 rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 echo "Waiting for irq work"
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
index 9330c87..fc22ac0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
 m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 : "Wildcard should be resolved after loading module"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index d861bd7..4e07c69 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -8,7 +8,7 @@ rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
 m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 MOD=trace_printk
diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
index 1b081e9..1b339bd 100644
--- a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
+++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
@@ -9,7 +9,7 @@ fi
 
 if ! which checkbashisms > /dev/null 2>&1 ; then
   echo "No checkbashisms found. skipped."
-  exit_unresolved
+  exit_unsupported
 fi
 
 checkbashisms $FTRACETEST_ROOT/ftracetest
-- 
1.8.3.1

