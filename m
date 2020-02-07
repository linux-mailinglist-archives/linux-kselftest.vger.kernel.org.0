Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B8155C4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 18:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBGQ7v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 11:59:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGQ7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 11:59:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Gwc4B183894;
        Fri, 7 Feb 2020 16:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=gXFa3xkSWPwm9CTChS6rf0bozbOyOYYw7I+3edYH8q0=;
 b=myoFVZTvIW/j1tHXiG8NGW3bYAJYZktqAKMPwjfio2Gt84XkousXEu0kk2uVG/JscRzp
 m6sI+u16m080axUX+n/UsyB7BufuAjyZ0BEQhcgII7uS2C+69aUsf+WScYt4MMNUUjE0
 MNNGVf2Nb0AGymTfwC7JM9CYL5OuLY+D7LyQbaAmPFwUmA4b1X7F5VIGqHmBu07h9k6+
 2tvcC743A+4Q8uiAkZ5HvhqXoTohlXqPhWjfk65p6oHLzQhSHo9h+ZjtVqic0YIXlNCD
 TrIsN6ryRFXsw5tLCdRW1w+P0vvIhkg/wkUQVrB3ZOJJK+/QjlE+Y7lq4QJsvyloAJj3 GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbph6d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:59:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017GxTdk041511;
        Fri, 7 Feb 2020 16:59:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y0mk2qn4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:59:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 017GwXX2013550;
        Fri, 7 Feb 2020 16:58:33 GMT
Received: from dhcp-10-175-205-224.vpn.oracle.com (/10.175.205.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 08:58:33 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, davidgow@google.com, frowand.list@gmail.com
Subject: [PATCH v3 kunit-next 0/2] kunit: add debugfs representation to show results/run tests
Date:   Fri,  7 Feb 2020 16:58:12 +0000
Message-Id: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kunit tests are run on native (i.e. non-UML) environments, the results
of test execution are often intermixed with dmesg output.  This patch
series attempts to solve this by providing a debugfs representation
of the results of the last test run, available as

/sys/kernel/debug/kunit/<testsuite>/results

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

Alan Maguire (2):
  kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display
  kunit: update documentation to describe debugfs representation

 Documentation/dev-tools/kunit/usage.rst |  12 +++
 include/kunit/test.h                    |  52 ++++++++++--
 lib/kunit/Makefile                      |   3 +-
 lib/kunit/debugfs.c                     | 105 ++++++++++++++++++++++++
 lib/kunit/debugfs.h                     |  16 ++++
 lib/kunit/kunit-test.c                  |   4 +-
 lib/kunit/test.c                        | 136 ++++++++++++++++++++++++--------
 7 files changed, 286 insertions(+), 42 deletions(-)
 create mode 100644 lib/kunit/debugfs.c
 create mode 100644 lib/kunit/debugfs.h

-- 
1.8.3.1

