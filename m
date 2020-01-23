Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D560146BA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAWOrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 09:47:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgAWOro (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 09:47:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NERemS081753;
        Thu, 23 Jan 2020 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=VLBXQG3L+vQfzIALTTItUjwrNdTrwGxtWuccZS4MiYE=;
 b=LiNGUPo1GHT9f9L0wu5LjSFhHy6zHvo6EahYGk3S/r8cdn3gAAkmWglibqW841OpJzH+
 XEY2/CsHy6bbOQrw10B/mlffnQNZupsqJ8OlkXnYCn0ALtDug2GlbmRtfzCIdhV55Qmb
 OYxUyl5lLDYxnbyanpIW3nT7i2Vmlfh4plC4AlYiPpdFIX0QQvF6Kq9iuaS2SOasWLTw
 bx7DQ8zyo4jAtdD/Xe8xFGpI/eBo4FCbEnbC5UAavK/dG1vHNXaMDadJKTSVgkP030U0
 bjOBSRvLzg+jbxJFQ4ZmZ08F33Dhe66Dp+l7IG3epb4M09tioLHeoEHrHci538C6V6r8 gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xksyqjpsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NET6kd007769;
        Thu, 23 Jan 2020 14:47:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xpq7mw44b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NElWk2001377;
        Thu, 23 Jan 2020 14:47:32 GMT
Received: from dhcp-10-175-173-105.vpn.oracle.com (/10.175.173.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 06:47:31 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH kunit 0/3] kunit: add debugfs representation to show results/run tests
Date:   Thu, 23 Jan 2020 14:47:17 +0000
Message-Id: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=732
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230124
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kunit tests are run on native (i.e. non-UML) environments, the results
of test execution are often intermixed with dmesg output.  This patch
series attempts to solve this by providing a debugfs representation
of the results of the last test run, available as

/sys/kernel/debug/kunit/<testsuite>/results

In addition, we provide a way to re-run the tests and show results via

/sys/kernel/debug/kunit/<testsuite>/run

Alan Maguire (3):
  kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
  kunit: add "run" debugfs file to run suites, display results
  kunit: update documentation to describe debugfs representation

 Documentation/dev-tools/kunit/usage.rst |  20 +++++
 include/kunit/test.h                    |  21 +++--
 lib/kunit/Makefile                      |   3 +-
 lib/kunit/debugfs.c                     | 145 ++++++++++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  11 +++
 lib/kunit/test.c                        |  88 ++++++++++++++-----
 6 files changed, 260 insertions(+), 28 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

