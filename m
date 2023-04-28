Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D376F1BB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbjD1PfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbjD1PfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA2210C;
        Fri, 28 Apr 2023 08:35:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3oxp020054;
        Fri, 28 Apr 2023 15:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=RSxC4dWNE/2O3qu1GoLDyqzY8ygixzh0e37oJcbfFXY=;
 b=iE5bg7XhGAAl+xGcwP7EklzRB8jLyYEGDDv1PWq2bjXYArMTddijJXlsRkXULWl8fvYZ
 OsYz69q1GOeeLUEBcE9VC3BC0AhwyQsIESr3fIysJHbn8jRkkdWgPLndqyLsp/qs5Dw1
 oGzovernceL5RcvS2iR1hzUy89KerdDBUqiLiQ0sX/s0EugMZ25cL/wclsk9lkS9D+om
 1MlpnOZ6BlmIM1rbxttfZiGBHPqBnh/mRbXokZolrGeC+vsZamXM9CbZs7ijIQaTsc7a
 ysO2bWwMIOG8nBGf39BjfW5fbVttC/mI0Mvqd6JiuvSX/cEV7Duit7hOVavAMj27RxHs UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u6ged-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE5vmh028177;
        Fri, 28 Apr 2023 15:35:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUM028134;
        Fri, 28 Apr 2023 15:35:07 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-7;
        Fri, 28 Apr 2023 15:35:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 6/6] tracing: document IPv4, IPv6, MAC address and > 8 byte numeric filtering support
Date:   Fri, 28 Apr 2023 16:34:49 +0100
Message-Id: <1682696089-27937-7-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
References: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280125
X-Proofpoint-GUID: jp-r6OidS0SqBkV1800aMVkzMX12rjV8
X-Proofpoint-ORIG-GUID: jp-r6OidS0SqBkV1800aMVkzMX12rjV8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Document that only == and != predicates are supported for
IPv4, IPv6 and MAC addresses.

For values > 8 bytes in size, only == and != filter predicates are
supported; document this also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/trace/events.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f5fcb8e1218f..6a75e4e256c9 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -182,10 +182,31 @@ The field-names available for use in filters can be found in the
 
 The relational-operators depend on the type of the field being tested:
 
+For IPv4, IPv6 and MAC addresses, the available operators are:
+
+==, !=
+
+For example
+
+"dst == 127.0.0.1"
+
+"src != ::1"
+
+"mac_addr == ab:cd:ef:12:34:56"
+
 The operators available for numeric fields are:
 
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

