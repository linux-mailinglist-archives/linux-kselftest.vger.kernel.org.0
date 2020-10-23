Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D96296B80
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460901AbgJWIwl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 04:52:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32416 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460899AbgJWIwk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 04:52:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N8Vur5133576;
        Fri, 23 Oct 2020 04:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=PE7YuQTS+QuVbjfnC7LUKKiGrNQ4ubzehaHLOeqNMMk=;
 b=DbsP8ndMAxlKKqAQLgNXtAFZZZGPS+7itzv3zOQ2wfjg5Qvb4+oO0jAYNS2AE73Huz7k
 CJ5h3tl1O9bMo52fHnDvQ5pldQumd6+TsnVWkDJy7+C5taeU5Ixc7nHuW323/20QiGuP
 o5yJ/45DzK3hfOr1m3Ipp8mwq19v0IU5MVn7xnw58d490+C3S2ZfA2C98ERfksl6rETj
 y12VZoBSFsvY9nz2fDs5CKkXHGsPHav5eZYS/tZvDGxm9xUBTQbiiUIdjSt7MpvWtSiE
 WJVa/gs8Py/5Ud3fpG1O/nXUy8u0uqCpWViXQ77bAUKZOjeI/9qLIlpSQrMypO8sU0t/ uA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34bh70qt6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 04:52:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N8oreK030096;
        Fri, 23 Oct 2020 08:52:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 347r88b9j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 08:52:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N8q5jr22544828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 08:52:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99E894204D;
        Fri, 23 Oct 2020 08:52:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A2E42047;
        Fri, 23 Oct 2020 08:52:05 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.85.144])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Oct 2020 08:52:05 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Date:   Fri, 23 Oct 2020 10:52:03 +0200
Message-Id: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_03:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230055
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The _do_fork() is not completely removed from selftests
in favor of the kernel_clone().

Fixes: eea11285dab3 ("tracing: switch to kernel_clone()")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index acb17ce..0ddb948 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -39,7 +39,7 @@ do_test() {
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
-    echo *do_fork >> set_ftrace_filter
+    echo kernel_clone >> set_ftrace_filter
 
     echo $PID > set_ftrace_notrace_pid
     echo function > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 9f0a968..71319b3 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -39,7 +39,7 @@ do_test() {
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
-    echo *do_fork >> set_ftrace_filter
+    echo kernel_clone >> set_ftrace_filter
 
     echo $PID > set_ftrace_pid
     echo function > current_tracer
-- 
1.8.3.1

