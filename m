Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29328154737
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBFPLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 10:11:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42150 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgBFPLB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 10:11:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F88fb142764;
        Thu, 6 Feb 2020 15:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=AQVBQBMgJcTfDEg0yhow3tN7Q1Pax4n2aKD0EtCvB5g=;
 b=RETquQFs1fKBNgdO+SC2SKpV6GWy5hV1i6FjD5q/B6GQBX8NMZgGSGwslbGnMjUAMH8h
 sz79oy25yNCDycr10XBDLE9qKIExG5CDzEbIuspzC+peq54XpVgoeFngdSfxyV0xlUbu
 014Tl2bkra1YN10IpCFl4049jCasEKgAUyka/EL9KnXexmn9t7HzAqxnJwcIiIBxqFTl
 BS6j1NV8LTywu8SyKTvjaTBG9tU7cV0JvF07f4gXqtSr5NAhe6Kvs9UzW0gVv0XiksMm
 WGECtcChxo4rDcnweBbffZtu5Ae3sSdy5qrwCAvrZQJiOceChSl/ubPzWT/zBfzFGran 4g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=AQVBQBMgJcTfDEg0yhow3tN7Q1Pax4n2aKD0EtCvB5g=;
 b=Ii3Gi2JbGgiAKKS/t752ah8Ri/uNKai0T0tPf1ragsVrp5cqzPPI3LxYQhCKpNg+qWjB
 3PedLb328GrnnSY4hg6fi1rj6d1UidrnOmUsmmqElyjpqN8DHQqrbs6c1R9Tqbr7JzsL
 Gdi8uMJxNrB1JHnJN1y7dpF9seVuSJxk8tPpvW2NebllgAmuk9PULMCn6/qSSis5D2Jw
 MiAo3vj+xX4SyfGNb90Ej01m1JGH0FLrZB91qMz06VGIaKfpEa1hCU0ri6BEOrNnurfo
 /xmzmi0jc/GBmLh/5ezGct7Bbec+XI1RG6vxuBi/1NpMfCcksGGw2VLvv2CDZbtuX2y/ WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xykbpaa96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:09:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F9IaR146695;
        Thu, 6 Feb 2020 15:09:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y0jfxuft2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 15:09:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016F9oZY026720;
        Thu, 6 Feb 2020 15:09:51 GMT
Received: from dhcp-10-175-186-149.vpn.oracle.com (/10.175.186.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 07:09:50 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        colin.king@canonical.com
Subject: [PATCH 0/2] ftrace/selftests: clean up failure cases
Date:   Thu,  6 Feb 2020 15:09:18 +0000
Message-Id: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=992 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060116
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the ftrace selftests, 2 failures and 6 unresolved
cases were observed.  The failures can be avoided by setting
a sysctl prior to test execution (fixed in patch 1) and the
unresolved cases result from absence of testing modules which
are built based on CONFIG options being set and program
availability (fixed in patch 2).

These seem more like "unsupported" than "unresolved" errors,
since for the ftrace tests "unresolved" cases cause the test
(and thus kselftest) to report failure.  With these changes
in place, the unresolved cases become unsupported and the
test failures disappear, resulting in the ftracetest program
exiting with "ok" status.

Alan Maguire (2):
  ftrace/selftests: workaround cgroup RT scheduling issues
  ftrace/selftest: absence of modules/programs should trigger
    unsupported errors

 tools/testing/selftests/ftrace/ftracetest          | 23 ++++++++++++++++++++++
 .../ftrace/test.d/direct/ftrace-direct.tc          |  2 +-
 .../ftrace/test.d/direct/kprobe-direct.tc          |  2 +-
 .../selftests/ftrace/test.d/event/trace_printk.tc  |  2 +-
 .../ftrace/test.d/ftrace/func_mod_trace.tc         |  2 +-
 .../ftrace/test.d/kprobe/kprobe_module.tc          |  2 +-
 .../selftests/ftrace/test.d/selftest/bashisms.tc   |  2 +-
 7 files changed, 29 insertions(+), 6 deletions(-)

-- 
1.8.3.1

