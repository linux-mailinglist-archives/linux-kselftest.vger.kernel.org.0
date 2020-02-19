Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAA164083
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSJgg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 04:36:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJgf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 04:36:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9Xft5072800;
        Wed, 19 Feb 2020 09:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=uJNUKa7+i4uMJlknFqHIMwrQla43Db9REwAVDDYod6o=;
 b=pvzzGA1t4QPaFT9ZhLui1iqmgUuOBuiOssZUHfIBqS1eNcFsmzGl1Cic/x0BB55Pfj3H
 YyfdJaiwkhT+boi+KYbyPHl9uDLmDmBgDXDQ+C4kXoGD4eCRcrGdnMusYlXEtt9x3GZq
 OUWfMSLwAlsa35GUd79ii78r3gODxA2PLzy2Gcr3cB/6JXZU2J3+7iYHETkJb61MZdgC
 g/51DnVBkqarNTPH//kvQ8sBCjvsfqq0YTqxsoOnhHFC/J2408e9X1/06EgrDa5ngc1R
 jwkMqATSpw/JaJVIFlcma0Dlse5aWyRTwnrexRnCwFO77oREbF2snAoYJpl0aHRpfSby 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udk9qfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:36:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9X1gS034527;
        Wed, 19 Feb 2020 09:36:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8uda4stm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:36:00 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01J9Zx9T016679;
        Wed, 19 Feb 2020 09:35:59 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 01:34:02 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 2/2] ftrace/selftest: make unresolved cases cause failure if --fail-unresolved set
Date:   Wed, 19 Feb 2020 09:33:30 +0000
Message-Id: <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=3 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=3
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190070
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, ftracetest will return 1 (failure) if any unresolved cases
are encountered.  The unresolved status results from modules and
programs not being available, and as such does not indicate any
issues with ftrace itself.  As such, change the behaviour of
ftracetest in line with unsupported cases; if unsupported cases
happen, ftracetest still returns 0 unless --fail-unsupported.  Here
--fail-unresolved is added and the default is to return 0 if
unresolved results occur.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 144308a..19e9236 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -17,6 +17,7 @@ echo "		-v|--verbose Increase verbosity of test messages"
 echo "		-vv        Alias of -v -v (Show all results in stdout)"
 echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
 echo "		--fail-unsupported Treat UNSUPPORTED as a failure"
+echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
@@ -112,6 +113,10 @@ parse_opts() { # opts
       UNSUPPORTED_RESULT=1
       shift 1
     ;;
+    --fail-unresolved)
+      UNRESOLVED_RESULT=1
+      shift 1
+    ;;
     --logdir|-l)
       LOG_DIR=$2
       shift 2
@@ -176,6 +181,7 @@ KEEP_LOG=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
+UNRESOLVED_RESULT=0
 STOP_FAILURE=0
 # Parse command-line options
 parse_opts $*
@@ -280,7 +286,7 @@ eval_result() { # sigval
     $UNRESOLVED)
       prlog "	[${color_blue}UNRESOLVED${color_reset}]"
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
-      return 1 # this is a kind of bug.. something happened.
+      return $UNRESOLVED_RESULT # depends on use case
     ;;
     $UNTESTED)
       prlog "	[${color_blue}UNTESTED${color_reset}]"
-- 
1.8.3.1

