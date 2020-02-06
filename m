Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65BB154766
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBFPMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 10:12:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgBFPMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 10:12:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016FBR27164704;
        Thu, 6 Feb 2020 15:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=VF7RaskOxU0ICZ79gQNL/Eu75aks0GZtpmw5lql+XJg=;
 b=amzS7/EUlZrHpzmfj17Wmz8LZ4A/44lO7mchUI4EM0hOlGYK8L1+KZXdzmt4uOO+GjrD
 s65TP17mIwS4eO9Wu0rmrR3JUIdvDi49Hcx9bOz5GO7SGGlFdvRZ5xjTXXtXJCDspRlu
 ykv3NQt4NR+WOhkA+fLho8wvhg8yNw4Aw5y9u4HAg3c6FLiBy4UIQrg8C6xtcT9gqWSg
 6JD2BqDMdZfYDgAMVnR+ZG7Zwet1Km+reZYIHLmRd5FySVQOeRYnU/dsYL07nVIyEPOg
 hzPjPpTXM2tGbJCW7+QIeYhoDfbh7QVGnUBxHEiLyXvMifuGzTMIi4eDdEK048D1fanG YQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=VF7RaskOxU0ICZ79gQNL/Eu75aks0GZtpmw5lql+XJg=;
 b=jF0XGycMDLNNFvTGpuqoBUVhYzcGRIRutu5Qw5Yib5zQwbt8o/kTFMrJPnSerMlJMtNU
 W72VNtsHWAvjS+MHnqlyeZ1HKX/aP+XWIfoe4kOP01XYudVdekAddtzs/JPxX3RgTHbb
 gAVR4nnFeA/kG5yUBGbl++kwQzDCG8FZa+GB7RhwVkLTzuJZag9aJMWNw+sSXDuIgYYC
 yirUPNsbM/LgKCgTe19X0YxRk0OdXDG9YAZ9YG3LwgneSZjlnKUykv50JAKnAIPNy9mK
 oH1DHp98ZtNqT8nUMkHY3Z3yhaLuT0IjnrXljqKhkBU2o2BlbbppT3wbYnKqnsYf6tSB Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xykbpa9s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:11:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F9Hk3135230;
        Thu, 6 Feb 2020 15:09:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y0mnjteet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:09:54 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016F9rmH026826;
        Thu, 6 Feb 2020 15:09:53 GMT
Received: from dhcp-10-175-186-149.vpn.oracle.com (/10.175.186.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 07:09:52 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        colin.king@canonical.com
Subject: [PATCH 1/2] ftrace/selftests: workaround cgroup RT scheduling issues
Date:   Thu,  6 Feb 2020 15:09:19 +0000
Message-Id: <1581001760-29831-2-git-send-email-alan.maguire@oracle.com>
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

wakeup_rt.tc and wakeup.tc tests in tracers/ subdirectory
fail due to the chrt command returning:

 chrt: failed to set pid 0's policy: Operation not permitted.

To work around this, temporarily disable grout RT scheduling
during ftracetest execution.  Restore original value on
test run completion.  With these changes in place, both
tests consistently pass.

Fixes: c575dea2c1a5 ("selftests/ftrace: Add wakeup_rt tracer testcase")
Fixes: c1edd060b413 ("selftests/ftrace: Add wakeup tracer testcase")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/ftrace/ftracetest | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 063ecb2..3207bbf 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -29,8 +29,26 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# cgroup RT scheduling prevents chrt commands from succeeding, which
+# induces failures in test wakeup tests.  Disable for the duration of
+# the tests.
+sched_rt_runtime=$(sysctl -n kernel.sched_rt_runtime_us)
+
+set_sysctl() {
+  sysctl -qw ${1}=${2} >/dev/null 2>&1
+}
+
+setup() {
+  set_sysctl kernel.sched_rt_runtime_us -1
+}
+
+cleanup() {
+  set_sysctl kernel.sched_rt_runtime_us $sched_rt_runtime
+}
+
 errexit() { # message
   echo "Error: $1" 1>&2
+  cleanup
   exit $err_ret
 }
 
@@ -39,6 +57,8 @@ if [ `id -u` -ne 0 ]; then
   errexit "this must be run by root user"
 fi
 
+setup
+
 # Utilities
 absdir() { # file_path
   (cd `dirname $1`; pwd)
@@ -235,6 +255,7 @@ TOTAL_RESULT=0
 
 INSTANCE=
 CASENO=0
+
 testcase() { # testfile
   CASENO=$((CASENO+1))
   desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
@@ -406,5 +427,7 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
 prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
 prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 
+cleanup
+
 # if no error, return 0
 exit $TOTAL_RESULT
-- 
1.8.3.1

