Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B3DB586
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395232AbfJQSIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 14:08:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbfJQSIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 14:08:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI4Bsc143709;
        Thu, 17 Oct 2019 18:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=7mJKPixnndHdR4uQjuaPnAtpZhIWsL337zXt9AP/YOc=;
 b=DVLsr7bBmim8k8IWyTNXyN95/RvlnWCxplT5OJjCdSkGGHW5oXhwxJsCDkyfFfQ1NHte
 570/rIUOAC/0su13gxo+bCwOeEeqHi3p6bDitFVUbsPQjzeB2z+n/czn5zqPq8COw4dQ
 8UXxzeihxI2bKcoUQNa02v51qKT3xFh+X2nLg1GYQL4cLTqg/7fuw2WJxoVyjpxxXoow
 UU1DOooeLZo7p0JB1Yu8BgDHdR/xvAE+jxtPtwpHeQOOhvrhYlzKft28dwcMGML/R+K1
 bwXxREFLrEipNbJGe/6TEKIdR7XCiZlY7Mx9I7dPnrwm1XNvv/OxhgxokVrKdQpP4jvJ CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sr0505-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI464k016545;
        Thu, 17 Oct 2019 18:07:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vp70qcemj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:38 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HI7Xgi028994;
        Thu, 17 Oct 2019 18:07:34 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:07:33 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 linux-kselftest-test 0/6]  kunit: support building core/tests as modules
Date:   Thu, 17 Oct 2019 19:07:13 +0100
Message-Id: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current kunit execution model is to provide base kunit functionality
and tests built-in to the kernel.  The aim of this series is to allow
building kunit itself and tests as modules.  This in turn allows a
simple form of selective execution; load the module you wish to test.
In doing so, kunit itself (if also built as a module) will be loaded as
an implicit dependency.

Because this requires a core API modification - if a module delivers
multiple suites, they must be declared with the kunit_test_suites()
macro - we're proposing this patch set as a candidate to be applied to the
test tree before too many kunit consumers appear.  We attempt to deal
with existing consumers in patch 4.

Changes since v2:
 - moved string-stream.h header to lib/kunit/string-stream-impl.h (Brendan)
   (patch 1)
 - split out non-exported interfaces in try-catch-impl.h (Brendan)
   (patch 2)
 - added kunit_find_symbol() and KUNIT_INIT_*SYMBOL to lookup non-exported
   symbols. KUNIT_INIT_*SYMBOL() is defined so that a mismatch between
   local symbol definition and definition of symbol in target will trigger
   a compilation error when the object is compiled built-in (Brendan)
   (patches 3, 4)
 - removed #ifdef MODULE around module licenses (Randy, Brendan, Andy)
   (patch 4)
 - replaced kunit_test_suite() with kunit_test_suites() rather than
   supporting both (Brendan) (patch 4)
 - lookup sysctl_hung_task_timeout_secs as kunit may be built as a module
   and the symbol may not be available (patch 5)
 - fixed whitespace issues in doc (patch 6)

Alan Maguire (6):
  kunit: move string-stream.h to lib/kunit/string-stream-impl.h
  kunit: hide unexported try-catch interface in try-catch-impl.h
  kunit: add kunit_find_symbol() function for symbol lookup
  kunit: allow kunit tests to be loaded as a module
  kunit: allow kunit to be loaded as a module
  kunit: update documentation to describe module-based build

 Documentation/dev-tools/kunit/faq.rst   |   3 +-
 Documentation/dev-tools/kunit/index.rst |   3 +
 Documentation/dev-tools/kunit/usage.rst |  16 +++++
 include/kunit/assert.h                  |   3 +-
 include/kunit/string-stream.h           |  51 -------------
 include/kunit/test.h                    | 123 +++++++++++++++++++++++++++++---
 include/kunit/try-catch.h               |  10 ---
 kernel/sysctl-test.c                    |   4 +-
 lib/Kconfig.debug                       |   2 +-
 lib/kunit/Kconfig                       |   6 +-
 lib/kunit/Makefile                      |   4 +-
 lib/kunit/assert.c                      |   9 +++
 lib/kunit/example-test.c                |   4 +-
 lib/kunit/string-stream-impl.h          |  51 +++++++++++++
 lib/kunit/string-stream-test.c          |  46 ++++++++----
 lib/kunit/string-stream.c               |   3 +-
 lib/kunit/test-test.c                   |  50 ++++++++++---
 lib/kunit/test.c                        |  49 +++++++++++++
 lib/kunit/try-catch-impl.h              |  23 ++++++
 lib/kunit/try-catch.c                   |   6 ++
 20 files changed, 363 insertions(+), 103 deletions(-)
 delete mode 100644 include/kunit/string-stream.h
 create mode 100644 lib/kunit/string-stream-impl.h
 create mode 100644 lib/kunit/try-catch-impl.h

-- 
1.8.3.1

