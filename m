Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81911266A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSQSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 11:18:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51372 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSQSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEJ8D119693;
        Thu, 19 Dec 2019 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=U9cMW9SZLbBtmgqabstWfkfHdgUKUAYyt+h4V5ncAvQ=;
 b=EnMlWN7XJ8d4XAnJgNhonGydb1id4LSO8iIVmr74nEOBXKdL4cPB7rAvwyEpgx3ynG+W
 T0qNfvCqIMeRUCDa4ATdAHhKaAsEB7wFs2VIHNjW6C0t+pd8sEblwwt00/yxaPNig5PK
 VW6sXzwwZXKiXSDZlpQxZXemvQhx/qxjgYGQHKooLjpDIipWB9+lSae+o3ou/Lz891RQ
 xOw/k4x94SMZKiEL4GDZQeY37SeHay+YKKvJ9Ors/YcIFjOgfLAh+v5HIQYqES2fjGv7
 SrnarZn3ldjSF8T+8wB3AMFg2wCm8yJ5oybCL+JWjxZ9ih6MRd0trgStWC68l3Y7ymji rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x0ag10v6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGESba136853;
        Thu, 19 Dec 2019 16:18:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wyut5jj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:18:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJGI8O9019545;
        Thu, 19 Dec 2019 16:18:09 GMT
Received: from dhcp-10-175-212-35.vpn.oracle.com (/10.175.212.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 08:18:08 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-ext4@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 linux-kselftest-test 0/6] kunit: support building core/tests as modules
Date:   Thu, 19 Dec 2019 16:17:33 +0000
Message-Id: <1576772259-31382-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
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
with existing consumers in patch 3.

Changes since v6:
 - reintroduce kunit_test_suite() definition to handle users in other trees
   not yet converted to using kunit_test_suites() (kbuild error when
   applying patches to ext4/dev tree)
 - modify drivers/base/power/qos-test.c to use kunit_test_suites()
   to register suite.  We do not convert it to support module build now as
   the suite uses a few unexported function; see patch 3 for details.
   
Changes since v5:
 - fixed fs/ext4/Makefile to remove unneeded conditional compilation
   (Iurii, patch 3)
 - added Reviewed-by, Acked-by to patches 3, 4, 5 and 6

Changes since v4:
 - fixed signoff chain to use Co-developed-by: prior to Knut's signoff
   (Stephen, all patches)
 - added Reviewed-by, Tested-by for patches 1, 2, 4 and 6
 - updated comment describing try-catch-impl.h (Stephen, patch 2)
 - fixed MODULE_LICENSEs to be GPL v2 (Stephen, patches 3, 5)
 - added __init to kunit_init() (Stephen, patch 5)

Changes since v3:
 - removed symbol lookup patch for separate submission later
 - removed use of sysctl_hung_task_timeout_seconds (patch 4, as discussed
   with Brendan and Stephen)
 - disabled build of string-stream-test when CONFIG_KUNIT_TEST=m; this
   is to avoid having to deal with symbol lookup issues
 - changed string-stream-impl.h back to string-stream.h (Brendan)
 - added module build support to new list, ext4 tests

Changes since v2:
 - moved string-stream.h header to lib/kunit/string-stream-impl.h (Brendan)
   (patch 1)
 - split out non-exported interfaces in try-catch-impl.h (Brendan)
   (patch 2)
 - added kunit_find_symbol() and KUNIT_INIT_SYMBOL to lookup non-exported
   symbols (patches 3, 4)
 - removed #ifdef MODULE around module licenses (Randy, Brendan, Andy)
   (patch 4)
 - replaced kunit_test_suite() with kunit_test_suites() rather than
   supporting both (Brendan) (patch 4)
 - lookup sysctl_hung_task_timeout_secs as kunit may be built as a module
   and the symbol may not be available (patch 5)

Alan Maguire (6):
  kunit: move string-stream.h to lib/kunit
  kunit: hide unexported try-catch interface in try-catch-impl.h
  kunit: allow kunit tests to be loaded as a module
  kunit: remove timeout dependence on sysctl_hung_task_timeout_seconds
  kunit: allow kunit to be loaded as a module
  kunit: update documentation to describe module-based build

 Documentation/dev-tools/kunit/faq.rst              |  3 +-
 Documentation/dev-tools/kunit/index.rst            |  3 ++
 Documentation/dev-tools/kunit/usage.rst            | 16 ++++++++++
 drivers/base/power/qos-test.c                      |  2 +-
 fs/ext4/Kconfig                                    |  2 +-
 fs/ext4/Makefile                                   |  3 +-
 fs/ext4/inode-test.c                               |  4 ++-
 include/kunit/assert.h                             |  3 +-
 include/kunit/test.h                               | 37 ++++++++++++++++------
 include/kunit/try-catch.h                          | 10 ------
 kernel/sysctl-test.c                               |  4 ++-
 lib/Kconfig.debug                                  |  4 +--
 lib/kunit/Kconfig                                  |  6 ++--
 lib/kunit/Makefile                                 | 14 +++++---
 lib/kunit/assert.c                                 | 10 ++++++
 lib/kunit/{example-test.c => kunit-example-test.c} |  4 ++-
 lib/kunit/{test-test.c => kunit-test.c}            |  7 ++--
 lib/kunit/string-stream-test.c                     |  5 +--
 lib/kunit/string-stream.c                          |  3 +-
 {include => lib}/kunit/string-stream.h             |  0
 lib/kunit/test.c                                   | 25 ++++++++++++++-
 lib/kunit/try-catch-impl.h                         | 27 ++++++++++++++++
 lib/kunit/try-catch.c                              | 37 +++++-----------------
 lib/list-test.c                                    |  4 ++-
 24 files changed, 160 insertions(+), 73 deletions(-)
 rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
 rename lib/kunit/{test-test.c => kunit-test.c} (98%)
 rename {include => lib}/kunit/string-stream.h (100%)
 create mode 100644 lib/kunit/try-catch-impl.h

-- 
1.8.3.1

