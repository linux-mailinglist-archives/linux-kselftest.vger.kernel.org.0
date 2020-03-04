Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78756178F4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCDLHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 06:07:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDLHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 06:07:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B46U4167217;
        Wed, 4 Mar 2020 11:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=qk/3ZmWRWb3QGJUEL1xyFS4r4TRjTGBtpUL+aarZ+aA=;
 b=WRGB97hWT27+P//0oAj6vftOyYbWyV9ZmF/Le5DtQ/ZPnWOBNvTJRx5X0BsiTJQ16dky
 2EE7Anwq4J7reb9CsEA0xMAOAspvMa6AUFkGZizgK9ET/UTP/znVaLoV/X+cJ/DIBIxd
 Qp2M00BEfhq/7noi9/q6m1c4VWuqBBSo/SLV/O+DAN8CUjz9Bo6cdGbylsyFYhiVX5XY
 oDdSfbf+7KGDkElKxKrj9lT2qG+xffgMOM8e+Yr9WWUz0I42gNEtrBAhrlnZmIq/tm6F
 kuufLTx7Z4lGkGqTSj776wBZSSCJoCZgSaQXvh7ckElcgMBgIq4COKt3aMRSAnxFlbXh jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwqwm7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024B3Sh7027604;
        Wed, 4 Mar 2020 11:07:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yg1h0nbpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 11:07:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024B7h8m005718;
        Wed, 4 Mar 2020 11:07:43 GMT
Received: from dhcp-10-175-165-222.vpn.oracle.com (/10.175.165.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 03:07:43 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 kunit-next 0/4] kunit: add debugfs representation to show results
Date:   Wed,  4 Mar 2020 11:07:12 +0000
Message-Id: <1583320036-442-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=995 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=3
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040086
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kunit tests are run on native (i.e. non-UML) environments, the results
of test execution are often intermixed with dmesg output.  This patch
series attempts to solve this by providing a debugfs representation
of the results of the last test run, available as

/sys/kernel/debug/kunit/<testsuite>/results

Changes since v5:

- replaced undefined behaviour use of snprintf(buf, ..., buf) in kunit_log()
  with a function to append string to existing log (Frank, patch 1)
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
 include/kunit/test.h                    |  59 +++++++++++--
 lib/kunit/Kconfig                       |   8 ++
 lib/kunit/Makefile                      |   4 +
 lib/kunit/assert.c                      |  79 ++++++++---------
 lib/kunit/debugfs.c                     | 116 +++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  30 +++++++
 lib/kunit/kunit-test.c                  |  45 +++++++++-
 lib/kunit/test.c                        | 147 +++++++++++++++++++++++++-------
 9 files changed, 421 insertions(+), 81 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

