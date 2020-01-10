Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF32D136C45
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2020 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgAJLuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jan 2020 06:50:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59924 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgAJLuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jan 2020 06:50:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ABmBed144146;
        Fri, 10 Jan 2020 11:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=JJW3trWejl6ezxgJ10nAdxvNTgv9rAAla3xEGRMdP/E=;
 b=b+v985lPgbUpnmfYLSAPubgGWtiRnldTf21hB3pSq9Qbeu9oQnG1ZYcEbanBpuwa1qK8
 XCvzQ9JFHAHC33/FF0YupPXg5/yNA1mdAUL/9b37kJ3CD9Pnp967WAza78LPOyd7xxYc
 nWZv9qrnuKJ0BkYnsxUZxqQjHtkgcqTAwUq75KMX84OU+lryMLegyaqRYd63GdUT27Sx
 UP0x6QUNwWrq6fC1DCj5nkqpJFqBeReAR7ryeJwAZqLkwSrPES9bgGdV9WdyWGD+aQOG
 1lXA2DvG0mlTexMwz+hSjWK1VoWwKtUl1d692rFOSBpD174U1iUaUZy7um6b1ZXrdTle ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbr9hue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 11:49:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ABmuCB051763;
        Fri, 10 Jan 2020 11:49:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xeh90k0kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 11:49:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00ABnk8O019563;
        Fri, 10 Jan 2020 11:49:48 GMT
Received: from dhcp-10-175-222-124.vpn.oracle.com (/10.175.222.124)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 03:49:46 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, jmorris@namei.org, serge@hallyn.com,
        knut.omang@oracle.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, sfr@canb.auug.org.au,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH kunit] kunit: building kunit as a module breaks allmodconfig
Date:   Fri, 10 Jan 2020 11:49:25 +0000
Message-Id: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100101
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit tests that do not support module build should depend
on KUNIT=y rather than just KUNIT in Kconfig, otherwise
they will trigger compilation errors for "make allmodconfig"
builds.

Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/Kconfig      | 2 +-
 security/apparmor/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index c3b3b5c..5f0bc74 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -150,7 +150,7 @@ config DEBUG_TEST_DRIVER_REMOVE
 
 config PM_QOS_KUNIT_TEST
 	bool "KUnit Test for PM QoS features"
-	depends on KUNIT
+	depends on KUNIT=y
 
 config HMEM_REPORTING
 	bool
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index d547930..0fe3368 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -71,7 +71,7 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 
 config SECURITY_APPARMOR_KUNIT_TEST
 	bool "Build KUnit tests for policy_unpack.c"
-	depends on KUNIT && SECURITY_APPARMOR
+	depends on KUNIT=y && SECURITY_APPARMOR
 	help
 	  This builds the AppArmor KUnit tests.
 
-- 
1.8.3.1

