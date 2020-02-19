Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59F164081
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSJg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 04:36:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 04:36:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9XHFa006568;
        Wed, 19 Feb 2020 09:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=9rfqPcoS6V4Kfp93WA9G++pHoTv0A+Yp1wS/x30l2eQ=;
 b=PHJLdRAOWRaUIlGZ//fcyFcx/mLwvAziwjs3AdXF+qFp78sFzYri34snttxw/PnEYkId
 j8exOnZbQX95HEm1GhXTvoSsX8M2IIoEq0B/Gv3eYF7GtrJn8ucs4HygiA8wHbBpEWv5
 mH/PpPPdrH+d6xF2oUXZeTDkdmLs9TZd49WJIZd85Njnd2PswF6WvnlFr/kPJwv2jZv3
 8caZCY9VGyLFa6AxXEa+eGdkR1nTbu4l40E6qi/inZRC+969bgY/oO342ecerAjDFsl6
 mCwcQDbPNknxCbG4101KHoRF105vPGsSjRPqDDgMtz/8C2OnFGihZwy6nQIuSmg1y5Bx Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8udd1r0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:35:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9WhrE176762;
        Wed, 19 Feb 2020 09:35:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y8ud2rtxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:35:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J9ZsWG004025;
        Wed, 19 Feb 2020 09:35:54 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 01:33:56 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 0/2] ftrace/selftest: clean up failure cases
Date:   Wed, 19 Feb 2020 09:33:28 +0000
Message-Id: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=646 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=3 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=706 malwarescore=0 mlxscore=0 suspectscore=3
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190070
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the ftrace selftests, 2 failures and 6 unresolved
cases were observed.  The failures can be avoided by setting
a sysctl prior to test execution (fixed in patch 1) and by
having unresolved cases not return 0 from ftracetest by default
since they indicate an absence of testing modules/programs
rather than ftrace issues (patch 2).

The latter are classified as "unresolved" tests, which operate
differently from "unsupported" tests.  For unsupported tests,
we note the unsupported count but do not consider the tests
as having failed, whereas with unresolved the test run is
considered to have failed so returns "not ok" when run via
kselftest ("make -C tools/testing/selftest/ftrace run_tests").

Patch 2 aligns the unresolved behaviour with the unsupported;
by default, unresolved outcomes do not trigger overall failure,
but they can if --fail-unresolved is specified.

Changes since v1:

- updated patch 1 to use /proc path instead of sysctl (Masami)
- updated patch 2 to modify unresolved handling in ftracetest
  rather than change individual unresolved -> unsupported (Masami)

Alan Maguire (2):
  ftrace/selftests: workaround cgroup RT scheduling issues
  ftrace/selftest: make unresolved cases cause failure if
    --fail-unresolved set

 tools/testing/selftests/ftrace/ftracetest | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
1.8.3.1

