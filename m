Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04456FDAF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 11:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKOKRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 05:17:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40658 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKOKRB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFAEDUw039024;
        Fri, 15 Nov 2019 10:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=CF76dqOjLnDtVQlj2rFziNpDdLSq1Rr16rBQHbvLv6Y=;
 b=oz2J5i6SWla6EFKSOlRg/p9BdA+ThBZTvWPdbMKB1MZi4F8LGeQ8zoEorL+9r4JuRVau
 LGefioAdpod/CqI0I1YmeD3soK98CM/pCqtZZeUObqXDSKMgrUipqZ8v8nsi3a52Ur9L
 XBsibtJOjIGoeT5XxRQCsb1UQkRpljWQR6g1ha+HFOtY6V3gPtDYWFT5DcpNyOdK2/lo
 vHZ+Da1AXrlqKfFrFcdrJfATcuBv9J5ePQ9djRKYDMXU82laEltokpss7ZsRI9DKVQI7
 FjH0PvkT2ThMXaJZceEOBr31hITRSGWu63akOpV+85r+2/ILoj6sIzVS/7pxSIccgF9R 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w9gxpjd2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFADLCv120961;
        Fri, 15 Nov 2019 10:16:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w9h17s1v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFAGPlf016278;
        Fri, 15 Nov 2019 10:16:25 GMT
Received: from dhcp-10-175-208-51.vpn.oracle.com (/10.175.208.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 02:16:24 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 linux-kselftest-test 0/6] kunit: support building core/tests as modules
Date:   Fri, 15 Nov 2019 10:16:06 +0000
Message-Id: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150096
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

 Documentation/dev-tools/kunit/faq.rst   |   3 +-
 Documentation/dev-tools/kunit/index.rst |   3 +
 Documentation/dev-tools/kunit/usage.rst |  16 ++
 fs/ext4/Kconfig                         |   2 +-
 fs/ext4/Makefile                        |   5 +
 fs/ext4/inode-test.c                    |   4 +-
 include/kunit/assert.h                  |   3 +-
 include/kunit/string-stream.h           |  51 -----
 include/kunit/test.h                    |  35 +++-
 include/kunit/try-catch.h               |  10 -
 kernel/sysctl-test.c                    |   4 +-
 lib/Kconfig.debug                       |   4 +-
 lib/kunit/Kconfig                       |   6 +-
 lib/kunit/Makefile                      |  14 +-
 lib/kunit/assert.c                      |  10 +
 lib/kunit/example-test.c                |  88 ---------
 lib/kunit/kunit-example-test.c          |  90 +++++++++
 lib/kunit/kunit-test.c                  | 334 ++++++++++++++++++++++++++++++++
 lib/kunit/string-stream-test.c          |   5 +-
 lib/kunit/string-stream.c               |   3 +-
 lib/kunit/string-stream.h               |  51 +++++
 lib/kunit/test-test.c                   | 331 -------------------------------
 lib/kunit/test.c                        |  25 ++-
 lib/kunit/try-catch-impl.h              |  28 +++
 lib/kunit/try-catch.c                   |  37 +---
 lib/list-test.c                         |   4 +-
 26 files changed, 628 insertions(+), 538 deletions(-)
 delete mode 100644 include/kunit/string-stream.h
 delete mode 100644 lib/kunit/example-test.c
 create mode 100644 lib/kunit/kunit-example-test.c
 create mode 100644 lib/kunit/kunit-test.c
 create mode 100644 lib/kunit/string-stream.h
 delete mode 100644 lib/kunit/test-test.c
 create mode 100644 lib/kunit/try-catch-impl.h

-- 
1.8.3.1

