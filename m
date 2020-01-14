Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5D13AEA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANQKi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 11:10:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANQKi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 11:10:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EG8DBH069867;
        Tue, 14 Jan 2020 16:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=DXGEyr5ta0XlqUrJRWrExFRIxM3FCYNIxMhvm8kVLdE=;
 b=ZI3C7yuVyQIPUg9GH91miMNTre/ToCR/HIiHa97eUXdjlFjn/9nZU30Sb1RwVufHnRyv
 0HwOKjY0uFb7isZPVyzuCOXXlMoMmOiDVKnNfUTey6jXtv1B2Hr8tytKkpWhZZLjvm25
 oFdoDNbaOlKXKkK15Kzm9skxBszekYmb+9U4dMAnwRI/JRY7+j7Y+jWGsWWUesJ9MIoc
 w2FPPEIuZNwiHq+aIauj3Yu4OmyPUwkJ3/di+G6ZwjIaIgdqeO76Q2AkS8oCcBpCl0kz
 f3f5uYAG1k58SZTz45Ja+Qgf59QUsP4k9Qo7G0hI4PDpQHWEgBlTOLBGB0svdoCVbVin Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74s6yb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:10:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EG9QRW168893;
        Tue, 14 Jan 2020 16:10:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xh8esas4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:10:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00EG9umn004555;
        Tue, 14 Jan 2020 16:09:56 GMT
Received: from dhcp-10-175-171-251.vpn.oracle.com (/10.175.171.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 08:09:55 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, dmitry.torokhov@gmail.com
Cc:     sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
Date:   Tue, 14 Jan 2020 16:09:43 +0000
Message-Id: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140137
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

currently the property entry kunit tests are built if CONFIG_KUNIT=y.
This will cause warnings when merged with the kunit tree that now
supports tristate CONFIG_KUNIT.  While the tests appear to compile
as a module, we get a warning about missing module license.

It's better to have a per-test suite CONFIG variable so that
we can do selective building of kunit-based suites, and can
also avoid merge issues like this.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: c032ace71c29 ("software node: add basic tests for property entries")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 drivers/base/test/Kconfig  | 3 +++
 drivers/base/test/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 86e85da..d29ae95 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
 	  The module name will be test_async_driver_probe.ko
 
 	  If unsure say N.
+config KUNIT_DRIVER_PE_TEST
+	bool "KUnit Tests for property entry API"
+	depends on KUNIT
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 2214310..3ca5636 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
-obj-$(CONFIG_KUNIT) += property-entry-test.o
+obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
-- 
1.8.3.1

