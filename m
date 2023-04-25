Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCFE6EDEF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDYJRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjDYJQz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 05:16:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54210FD;
        Tue, 25 Apr 2023 02:16:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0i1Uj026457;
        Tue, 25 Apr 2023 09:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=7kgs+lAKCEL9tceQOO9jB+IYOkJ+/3Rc21XPBYFqcac=;
 b=kDIFJZxTAl1eLj5XDF5CH5Cf/94+Z22rYn9mvhHTpvgKCWoq5ZLxQ+4FSTzDAbje6y5H
 dOg3BwoLsjfWE1XTsqtH0mSKazllWgSuM0QgGQ7HTU9cH4i4oO5dOk/yNpPvu5MiLgff
 SEHonAEm8IxivW+vsKesbBaudZ708xtIu3mqrN4o2lNR5Y2QFrAo08iZ0a/PomTpOfFi
 w3EdO6W1Nb9qS53HRazhXDBGldRtnYpL7ZaB3IteCjHVsMluVbYLUwbdC3k1MgT8ZG/3
 uNI15g6rr2RXLlBlczsf2Lnlc52B+W4t6yW27mTN9euG2OYbLROiz9pm3Jplkm8Xnf3y 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d4vfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P7erjw024956;
        Tue, 25 Apr 2023 09:16:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461cdwek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:49 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33P93LCV024482;
        Tue, 25 Apr 2023 09:16:48 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-181-126.vpn.oracle.com [10.175.181.126])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461cdwa1-4;
        Tue, 25 Apr 2023 09:16:48 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH tracing 3/3] tracing: document > 8 byte numeric filtering support
Date:   Tue, 25 Apr 2023 10:16:37 +0100
Message-Id: <1682414197-13173-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250082
X-Proofpoint-GUID: v3ForVluSwZNhxJ_gxxop4bq9qYZi5rU
X-Proofpoint-ORIG-GUID: v3ForVluSwZNhxJ_gxxop4bq9qYZi5rU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For values > 8 bytes in size, only == and != filter predicates are
supported; document this.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/trace/events.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f5fcb8e1218f..0142bf59dc4b 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -186,6 +186,15 @@ The operators available for numeric fields are:
 
 ==, !=, <, <=, >, >=, &
 
+For numeric fields larger than 8 bytes, only
+
+==, !=
+
+...are allowed, and values for comparison must match field size exactly.
+For example, to match the "::1" IPv6 address:
+
+"dst == 0x00000000000000000000000000000001"
+
 And for string fields they are:
 
 ==, !=, ~
-- 
2.31.1

