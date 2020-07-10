Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CA21AE5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 07:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJFLl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 01:11:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgGJFLk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 01:11:40 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A51nP2107497;
        Fri, 10 Jul 2020 01:11:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpqqpfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 01:10:59 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06A52F7F108851;
        Fri, 10 Jul 2020 01:10:59 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpqqpeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 01:10:59 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06A55FfG018835;
        Fri, 10 Jul 2020 05:10:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 326bch84q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 05:10:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06A5Ari353018686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 05:10:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB9B52057;
        Fri, 10 Jul 2020 05:10:53 +0000 (GMT)
Received: from JAVRIS.in.ibm.com.com (unknown [9.199.48.201])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C4E205205A;
        Fri, 10 Jul 2020 05:10:51 +0000 (GMT)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/livepatch: adopt to newer sysctl error format
Date:   Fri, 10 Jul 2020 10:40:43 +0530
Message-Id: <20200710051043.899291-1-kamalesh@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_01:2020-07-09,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100029
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With procfs v3.3.16, the sysctl command doesn't prints the set key and
value on error.  This change breaks livepatch selftest test-ftrace.sh,
that tests the interaction of sysctl ftrace_enabled:

 # selftests: livepatch: test-ftrace.sh
 # TEST: livepatch interaction with ftrace_enabled sysctl ... not ok
 #
 # --- expected
 # +++ result
 # @@ -16,7 +16,7 @@ livepatch: 'test_klp_livepatch': initial
 #  livepatch: 'test_klp_livepatch': starting patching transition
 #  livepatch: 'test_klp_livepatch': completing patching transition
 #  livepatch: 'test_klp_livepatch': patching complete
 # -livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
    resource busy kernel.ftrace_enabled = 0
 # +livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
    resource busy
 #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
 #  livepatch: 'test_klp_livepatch': initializing unpatching transition
 #  livepatch: 'test_klp_livepatch': starting unpatching transition
 #
 # ERROR: livepatch kselftest(s) failed

on setting sysctl kernel.ftrace_enabled={0,1} value successfully, the
set key and value is displayed.

This patch fixes it by limiting the output from both the cases to eight
words, that includes the error message or set key and value on failure
and success. The upper bound of eight words is enough to display the
only tracked error message. Also, adjust the check_result string in
test-ftrace.sh to match the expected output.

With the patch, the test-ftrace.sh passes on v3.3.15, v3.3.16 versions
of sysctl:
 ...
 # selftests: livepatch: test-ftrace.sh
 # TEST: livepatch interaction with ftrace_enabled sysctl ... ok
 ok 5 selftests: livepatch: test-ftrace.sh

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
Based on livepatching/for-5.9/selftests-cleanup, to be merged
through livepatching.git

 tools/testing/selftests/livepatch/functions.sh   | 3 ++-
 tools/testing/selftests/livepatch/test-ftrace.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 36648ca367c2..e3c0490d5a45 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -75,7 +75,8 @@ function set_dynamic_debug() {
 }
 
 function set_ftrace_enabled() {
-	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
+	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ' | \
+		 cut -d" " -f1-8)
 	echo "livepatch: $result" > /dev/kmsg
 }
 
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index 9160c9ec3b6f..552e165512f4 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -51,7 +51,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
+livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition

base-commit: 3fd9bd8b7e41a1908bf8bc0cd06606f2b787cd39
-- 
2.26.2

