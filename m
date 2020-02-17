Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9E1614A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2020 15:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBQO2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Feb 2020 09:28:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36420 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgBQO2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Feb 2020 09:28:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HES94V072667;
        Mon, 17 Feb 2020 14:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=kuawTAcgFU/2dUv+hY9dAQNI6l7YT8VZDM2bAJZP8Hc=;
 b=sP2fP7QinTVbnIpe0fa6WyKVjisPH1bAj5PXDRMN9MYZ9kSC1Dt17AHik7wzgsQNtHoC
 1AbVB9dGERoVtCgBFw4G1kAc/noSuHc0P29MAlkFwiJBXWfw5dIMFYXRU70fxhOv9bTF
 o0OF/vbee3y104ENTQzgvbtON7uktn+V+apNe1qFo3xhU4ZjvkkxSdUbrtVded5xhct6
 9rOFX8DML+a9Eu0SXyevDEw1Wav9rVVV3Dot4OOau44wFHFqDvtbg63QyQ1QgbtjF2zW
 TQFgk5ek+1oTPYBdKMX8Igg4qoNN1OfLF1Vj+65S7Xr071zEZQA6iPTQUtKiTE5ZK8TZ 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y699rgegj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HERY64022576;
        Mon, 17 Feb 2020 14:28:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y6tc088nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01HESPPa011020;
        Mon, 17 Feb 2020 14:28:25 GMT
Received: from dhcp-10-175-161-198.vpn.oracle.com (/10.175.161.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 06:28:25 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 kunit-next 0/3] kunit: add debugfs representation to show results
Date:   Mon, 17 Feb 2020 14:27:37 +0000
Message-Id: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=3
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=3
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170120
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kunit tests are run on native (i.e. non-UML) environments, the results
of test execution are often intermixed with dmesg output.  This patch
series attempts to solve this by providing a debugfs representation
of the results of the last test run, available as

/sys/kernel/debug/kunit/<testsuite>/results

Changes since v3:

- added CONFIG_KUNIT_DEBUGFS to support conditional compilation of debugfs
  representation, including string logging (Frank, patch 1)
- removed unneeded NULL check for test_case in kunit_suite_for_each_test_case()
  (Frank, patch 1)
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

Alan Maguire (3):
  kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
  kunit: add log test
  kunit: update documentation to describe debugfs representation

 Documentation/dev-tools/kunit/usage.rst |  13 ++++
 include/kunit/test.h                    |  54 +++++++++++---
 lib/kunit/Kconfig                       |   8 +++
 lib/kunit/Makefile                      |   4 ++
 lib/kunit/debugfs.c                     | 116 ++++++++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  30 ++++++++
 lib/kunit/kunit-test.c                  |  31 +++++++-
 lib/kunit/test.c                        | 122 ++++++++++++++++++++++++--------
 8 files changed, 336 insertions(+), 42 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

