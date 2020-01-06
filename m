Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3D131B61
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2020 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgAFW3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jan 2020 17:29:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58854 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFW3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jan 2020 17:29:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJDHS051697;
        Mon, 6 Jan 2020 22:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=U9cMW9SZLbBtmgqabstWfkfHdgUKUAYyt+h4V5ncAvQ=;
 b=a5yOabC1OjGsCQHU0M1Ei2XDW7eFH5WoVpsBDSE0D0ZYz728luo518She+P86nOrz4II
 8rWYUGL80l16p+cURHDmuzDf9G8Lj7nY5JU11ECoFlhfMYvSxj+5zNsiZBs6Ua1D7QMP
 Zs4gxuSFXKQQ3SmRR+OfchNtLIz/mQhxcOGjQ7jhILDWLWGTpeu+CWgwoXe85MEtA2U9
 OLpU2zisL34rIO2HfRnQJs/vC/WhBQOWIkwLTLaQqxQIopN0VnT11J5VpX2fRVePmyeX
 BYyX930yf2THD7T7ylWqi3zUOvcmBNvqJb3rTFwgHXo0+lplJqvMSmjRW2NYkHwornGY Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4tt4xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:28:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJNbQ182897;
        Mon, 6 Jan 2020 22:28:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xb467jcne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:28:53 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 006MSlBn028806;
        Mon, 6 Jan 2020 22:28:47 GMT
Received: from dhcp-10-175-162-40.vpn.oracle.com (/10.175.162.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 14:28:46 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RESEND PATCH v7 linux-kselftest-test 0/6] kunit: support building core/tests as modules
Date:   Mon,  6 Jan 2020 22:28:17 +0000
Message-Id: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060185
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

