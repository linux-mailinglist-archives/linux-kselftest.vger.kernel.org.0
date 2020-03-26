Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178FF19417D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 15:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZOap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 10:30:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49468 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZOap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 10:30:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QETBsR005507;
        Thu, 26 Mar 2020 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=4BLw30Hr96cQMep2R4AUjnjhT8BzoA3mA+LrI3ZVIQ4=;
 b=pN+jxk1GQHQYEkuHt3xhzRsNG5EeRlzoYsly95rFnyYoNLFk6eYK/fsMHjth+OL4vUzB
 YSCftFMrlTC0mk4F4LNNEDrH/KPb+NNu2VKeUtxBABF3b+73Wu2J/PSIBnSMqqtVR0i2
 iUJCf7Ch3jEqUhhYQXTEatCNgG1P9m3yCb3KS/3tZpvehJ88VbY8yutBYyoNcIXBzwb9
 rWrEAqW7Wa8b8kaQG32k0rOLQDZEyJRbkV2h4kZvRGV/N0/FCx+DfNJcia2k9LLCwM9Q
 Dg2sBxfgLCCUI3582qe+QdE83CP8Wg7NwzIwRsvod6fLEYuAN/Jq1BmM053DMZ9aLaJI Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavmg427-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:30:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QESWYi115612;
        Thu, 26 Mar 2020 14:28:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yxw4trgjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:28:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QESWZw011629;
        Thu, 26 Mar 2020 14:28:32 GMT
Received: from localhost.uk.oracle.com (/10.175.198.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 07:28:32 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: [PATCH v8 kunit-next 0/4] kunit: add debugfs representation to show results
Date:   Thu, 26 Mar 2020 14:25:06 +0000
Message-Id: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260112
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kunit tests are run on native (i.e. non-UML) environments, the results
of test execution are often intermixed with dmesg output.  This patch
series attempts to solve this by providing a debugfs representation
of the results of the last test run, available as

/sys/kernel/debug/kunit/<testsuite>/results

Changes since v7:

- renamed KUNIT_INDENT[2] to KUNIT_SUBTEST_INDENT, KUNIT_SUBSUBTEST_INDENT
  and added more description to their definitions to clarify why they
  are defined as they are (Shuah)
- defined KUNIT_SUBSUBTEST_INDENT directly as 8 spaces to avoid
  checkpatch error (Shuah)

Changes since v6:

- fixed regexp parsing in kunit_parser.py to ensure test results are read
  successfully with 4-space indentation (Brendan, patch 3)

Changes since v5:

- replaced undefined behaviour use of snprintf(buf, ..., buf) in
  kunit_log() with a function to append string to existing log
  (Frank, patch 1)
- added clarification on log size limitations to documentation
  (Frank, patch 4)

Changes since v4:

- added suite-level log expectations to kunit log test (Brendan, patch 2)
- added log expectations (of it being NULL) for case where
  CONFIG_KUNIT_DEBUGFS=n to kunit log test (patch 2)
- added patch 3 which replaces subtest tab indentation with 4 space
  indentation as per TAP 14 spec (Frank, patch 3)

Changes since v3:

- added CONFIG_KUNIT_DEBUGFS to support conditional compilation of debugfs
  representation, including string logging (Frank, patch 1)
- removed unneeded NULL check for test_case in
  kunit_suite_for_each_test_case() (Frank, patch 1)
- added kunit log test to verify logging multiple strings works
  (Frank, patch 2)
- rephrased description of results file (Frank, patch 3)

Changes since v2:

- updated kunit_status2str() to kunit_status_to_string() and made it
  static inline in include/kunit/test.h (Brendan)
- added log string to struct kunit_suite and kunit_case, with log
  pointer in struct kunit pointing at the case log.  This allows us
  to collect kunit_[err|info|warning]() messages at the same time
  as we printk() them.  This solves for the most part the sharing
  of log messages between test execution and debugfs since we
  just print the suite log (which contains the test suite preamble)
  and the individual test logs.  The only exception is the suite-level
  status, which we cannot store in the suite log as it would mean
  we'd print the suite and its status prior to the suite's results.
  (Brendan, patch 1)
- dropped debugfs-based kunit run patch for now so as not to cause
  problems with tests currently under development (Brendan)
- fixed doc issues with code block (Brendan, patch 3)

Changes since v1:
 - trimmed unneeded include files in lib/kunit/debugfs.c (Greg)
 - renamed global debugfs functions to be prefixed with kunit_ (Greg)
 - removed error checking for debugfs operations (Greg)

Alan Maguire (4):
  kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
  kunit: add log test
  kunit: subtests should be indented 4 spaces according to TAP
  kunit: update documentation to describe debugfs representation

 Documentation/dev-tools/kunit/usage.rst |  14 +++
 include/kunit/test.h                    |  63 ++++++++++++--
 lib/kunit/Kconfig                       |   8 ++
 lib/kunit/Makefile                      |   4 +
 lib/kunit/assert.c                      |  79 ++++++++---------
 lib/kunit/debugfs.c                     | 116 +++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  30 +++++++
 lib/kunit/kunit-test.c                  |  44 +++++++++-
 lib/kunit/test.c                        | 148 +++++++++++++++++++++++++-------
 tools/testing/kunit/kunit_parser.py     |  10 +--
 10 files changed, 430 insertions(+), 86 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

