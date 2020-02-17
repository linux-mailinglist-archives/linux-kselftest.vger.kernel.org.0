Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF42B1614B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2020 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBQO2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Feb 2020 09:28:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgBQO2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Feb 2020 09:28:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HEMldC045577;
        Mon, 17 Feb 2020 14:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=F33e2h/VKg524zfDno3YmF4kFLz8ceA2/AbSPfczn2w=;
 b=dJwFzaELeFN4Iqx4jKy0xAUOUXyK4Qg/4OcKstysntyZ9ZoAORL2nzgz4XRXftvI82/D
 S9RxOheeEnDWNkz01bdJ/X8CSFF2pGAHl6TJ6i8BrkEfrDLRSj1gsW4NcsbRmJDGI7bL
 3ZZQzTYKbsAko9Nxcm0JFlmY2cIInv9HwYnVCwjbjuS+yk4KpqckKoTOWCVhaoZgU/NP
 sfWsriNOHKZ1D/Jyg01KUxKPTxKeHlLH9jxjOfPcvu/gisGP0aaANNohd0ACfJYxstwO
 nV5j3fCLGKpfkHuJJLjjTbN3U/S/bobOqI14q0DAygJxsh/51+k1/l4xduRUt5NaA7S+ pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y7aq5kq0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HERjbB055355;
        Mon, 17 Feb 2020 14:28:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y6t4g6j41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:28:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01HESZ8X011075;
        Mon, 17 Feb 2020 14:28:35 GMT
Received: from dhcp-10-175-161-198.vpn.oracle.com (/10.175.161.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 06:28:35 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 kunit-next 3/3] kunit: update documentation to describe debugfs representation
Date:   Mon, 17 Feb 2020 14:27:40 +0000
Message-Id: <1581949660-20113-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com>
References: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=3 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170119
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Documentation should describe debugfs layout and semantics.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1..816fff4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -590,3 +590,16 @@ able to run one test case per invocation.
 
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
+intermixed with other events in dmesg output.
-- 
1.8.3.1

