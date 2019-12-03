Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28E10FD68
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCMKp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 07:10:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47574 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCMKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 07:10:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3BsiGg148452;
        Tue, 3 Dec 2019 12:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=PAN8N/BNBLs9CxXc911l9Xu6pKmv8bJSEV2cpQz7Xw8=;
 b=qJ0o9Qc2pcXFFDbYVEBMf5tZmDJeh/P0NcTBhPWBlzLjo6EAX6dgcp1+Mh012weFyHdc
 xsZiuvFU2GoRWsQpaySCb90xVIqwUJ9jnJAssud46wbZHBvEycBXbVmwHX4I8vkMU1ag
 mWG3j88uRF+L9qAO0cc0Zt3I+61a8RqqFXXpfUI+I8qs2HNlXOKIk470V/aH4EO8PD7l
 bghc6RCKKAHzWdXla10aCegpFdFQFXovhn9bB2g4XbxKKzBslCVxuOw9iECmF4tVmUBb
 uBVTOQN1mG37SdpMTHZTOpaq9Ktm9CUXk8hAR9enGwgwJHpaZ9o1SfKzlOfDuQp9lvSM Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcq75tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 12:08:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3BsWV4195197;
        Tue, 3 Dec 2019 12:08:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wn8k2gxs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 12:08:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3C8C4l025088;
        Tue, 3 Dec 2019 12:08:12 GMT
Received: from dhcp-10-175-211-120.vpn.oracle.com (/10.175.211.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 04:08:12 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 linux-kselftest-test 0/6] kunit: support building core/tests as modules
Date:   Tue,  3 Dec 2019 12:07:42 +0000
Message-Id: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030096
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
 fs/ext4/Kconfig                                    |  2 +-
 fs/ext4/Makefile                                   |  5 +++
 fs/ext4/inode-test.c                               |  4 ++-
 include/kunit/assert.h                             |  3 +-
 include/kunit/test.h                               | 35 ++++++++++++++------
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
 23 files changed, 160 insertions(+), 71 deletions(-)
 rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
 rename lib/kunit/{test-test.c => kunit-test.c} (98%)
 rename {include => lib}/kunit/string-stream.h (100%)
 create mode 100644 lib/kunit/try-catch-impl.h

-- 
1.8.3.1

