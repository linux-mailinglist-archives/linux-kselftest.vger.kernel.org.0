Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FA147106
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWSrW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:47:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWSrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:47:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINm5q120066;
        Thu, 23 Jan 2020 18:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=bp//ElxO1uu3vRX0RsYhifJyIJ1pfMAfVT88mHaDq5c=;
 b=ok4i7XgIA36ly7WkIWaH4zrFPYgmuuUeheXysUUvnkqrxj594B+UeIqbBl9uBbaJMmoC
 hoGrjSeeEM1fHROg5y1c6B1zCZ6KxFMhqvRK0g+FzQbigrkLlwOVimC2nyzt8o51hhjQ
 czdtU5bLzHkbsfOq6L4K+sSdz7djKwiZ1Uncy4+jQrfWDgfsN/FtxRUgAmW6jOf/ry/q
 QWJGKQ92gXKXoK1JCfpNeqBJLax7rY/Mz60dvRC+Plrg7cTW8/kY5WQP39xX8CK/oyUt
 1MPAnYX41vzKGH4dxiatliKxSLi+qU/xt1FTpUl57gkPczx+eJpzPaOznEYcHnbGxngH Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnrm5gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NIOSAi027722;
        Thu, 23 Jan 2020 18:47:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xppq8gy3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NIlDwX017309;
        Thu, 23 Jan 2020 18:47:13 GMT
Received: from dhcp-10-175-166-237.vpn.oracle.com (/10.175.166.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 10:47:13 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 kunit-next 0/3] kunit: add debugfs representation to show results/run tests
Date:   Thu, 23 Jan 2020 18:46:58 +0000
Message-Id: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230141
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

Changes since v1:
 - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
 - renamed global debugfs functions to be prefixed with kunit_ (Greg)
 - removed error checking for debugfs operations (Greg)

Alan Maguire (3):
  kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
  kunit: add "run" debugfs file to run suites, display results
  kunit: update documentation to describe debugfs representation

 Documentation/dev-tools/kunit/usage.rst |  19 +++++
 include/kunit/test.h                    |  21 +++--
 lib/kunit/Makefile                      |   3 +-
 lib/kunit/debugfs.c                     | 137 ++++++++++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  16 ++++
 lib/kunit/test.c                        |  85 +++++++++++++++-----
 6 files changed, 254 insertions(+), 27 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

