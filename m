Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA51849D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCMOrS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 10:47:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35164 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCMOrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 10:47:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEeaiT042643;
        Fri, 13 Mar 2020 14:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=FAXjI9acl3BvhqBVLHwTP8ZVKrXH638AdGx3om6kJNQ=;
 b=FhPdlmxIHJvQgls3DVfxUO0C7gZUS4ANPeDN4y7XcZzdaI2Cgt0/cRcXiKIMTn/AyhYi
 Q8iX7/lRGteQgfbGzldQ5ssv0YJZuxHhLqAmdyf645N9wCJlGEuRMiMK0LT62BBicEye
 Z2D5UZNmzW/wg+qZlYF+pKjoC1ICr21nniV59zigMaz9YvQ6iB2q34xiHeLY8DzY/dLF
 wTL7jkj2wd3PKQnOP/bC6BQxueA9hGnJSTQD4c8pqfNvAkSzPzXiQ7nrhaHBIGhyeF5x
 hO3DaWSxR1RNjkOMFvsceUpr7l8Tdslm6DKMNK2hgqFrScvQQ/65kOqhjZivv0zpcAgb jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yqtaev7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:47:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcCFW070599;
        Fri, 13 Mar 2020 14:45:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqtabb577-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:45:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DEj8s5015787;
        Fri, 13 Mar 2020 14:45:09 GMT
Received: from dhcp-10-175-173-225.vpn.oracle.com (/10.175.173.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 07:45:08 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 kunit-next 4/4] kunit: update documentation to describe debugfs representation
Date:   Fri, 13 Mar 2020 14:44:42 +0000
Message-Id: <1584110682-3837-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=3 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=3
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 607758a..473a236 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -591,3 +591,17 @@ able to run one test case per invocation.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
    dependent KUnit test.
+
+KUnit debugfs representation
+============================
+When kunit test suites are initialized, they create an associated directory
+in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+
+- results: "cat results" displays results of each test case and the results
+  of the entire suite for the last test run.
+
+The debugfs representation is primarily of use when kunit test suites are
+run in a native environment, either as modules or builtin.  Having a way
+to display results like this is valuable as otherwise results can be
+intermixed with other events in dmesg output.  The maximum size of each
+results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
-- 
1.8.3.1

