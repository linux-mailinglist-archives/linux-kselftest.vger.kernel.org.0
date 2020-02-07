Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E55155C49
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGQ7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 11:59:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGQ7s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 11:59:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Gx1En184318;
        Fri, 7 Feb 2020 16:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=K5QddFRmTuQMYU2lyff0WWiJ+/nfjpOG6cnU9AcycxQ=;
 b=fi8w0XEge6J0uKUTNxDXZB++gqWCJDCN2w6X2Yxe56p4ilPcepZK64OeqQF5GfcCppVB
 C91iX9xDD5vluCmNZ9V3Nzvpexjf/ppXLYsRDxjgOEtF6Z+NdQ08Tc8potkjNBJiGl71
 pMLW8yVc62bZQXOYGIPtqBXiiEdLRSzg1XcvJAt8EytlQ7h5RrTh4npvoHylw7GGeqcD
 iPW5VSJXFSM21cBWoBSJCaH+k80ZqtzGq+DFhxeaW0OhFbSk+AzcY4bq9VaWFib6toDB
 6JlwQ4OKXV/6II1qA/muyZ2cqdLuqsgKpj9dlKkV0zTWL8mrLPw8aT/M9esD5nkqCfo1 nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xykbph6c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:59:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017GxVLb030169;
        Fri, 7 Feb 2020 16:59:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y0mnnyvkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:59:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017GwcF4004601;
        Fri, 7 Feb 2020 16:58:39 GMT
Received: from dhcp-10-175-205-224.vpn.oracle.com (/10.175.205.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 08:58:38 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, davidgow@google.com, frowand.list@gmail.com
Subject: [PATCH v3 kunit-next 2/2] kunit: update documentation to describe debugfs representation
Date:   Fri,  7 Feb 2020 16:58:14 +0000
Message-Id: <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/dev-tools/kunit/usage.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1..b2b958a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -590,3 +590,15 @@ able to run one test case per invocation.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
    dependent KUnit test.
+
+KUnit debugfs representation
+============================
+When kunit test suites are initialized, they create an associated directory
+in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+
+- results: "cat results" displays results of last test run
+
+The debugfs representation is primarily of use when kunit test suites are
+run in a native environment, either as modules or builtin.  Having a way
+to display results like this is valuable as otherwise results can be
+intermixed with other events in dmesg output.
-- 
1.8.3.1

