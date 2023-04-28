Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67F6F1BAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbjD1PfM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbjD1PfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C22129;
        Fri, 28 Apr 2023 08:35:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3q0f013983;
        Fri, 28 Apr 2023 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=qbpAVpdqvJpRmYvk+bUcqyw6njxS1/sYaFkQUCMfQdk=;
 b=CLenxwekIbgNcwjL2VOX+x/KhP0mbXIQ4VKuxdudidCB8TZEt3ofxz7BwZq+7wF4zawF
 1xS1m/MdV7WmK/Y2Fp3hz8uUgDLubY8VbvTnrb7lXbQowKFXvHR5VdzFRIGF8j0Nbh7j
 qO+2gnjxGK7un8EUvoocpc2lsLZZGfdwLJ2MRQedc3iuuU0e7hnvIXYgN5EHuY/wr49g
 /8h6kQCQvnZF/6T1PrvA6Sd/XJiGnl8pfQrDBzbdkQibKJlAIX3hIp+DtQY2hqOVpbNV
 GqI4q6ESCGuo8kSVchCoijTg8T4h4x6vG/1vlF0zcM1vAF/73DlihA8VCtm4nucAz3Fe gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460def67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE3UFh028277;
        Fri, 28 Apr 2023 15:35:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUI028134;
        Fri, 28 Apr 2023 15:35:01 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-5;
        Fri, 28 Apr 2023 15:35:01 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 4/6] tracing: support MAC address filter predicates
Date:   Fri, 28 Apr 2023 16:34:47 +0100
Message-Id: <1682696089-27937-5-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 2AAV9NyNJTjvbRe2sWOnRfnviscfQDvz
X-Proofpoint-ORIG-GUID: 2AAV9NyNJTjvbRe2sWOnRfnviscfQDvz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support '==' and '!=' predicates for MAC address format;
for example

 cd /sys/kernel/debug/tracing/events/cfg80211/rdev_get_key
 echo "mac_addr == de:ad:be:ef:de:ad"

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e2521574f3c4..f38023f490b1 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1384,7 +1384,7 @@ static int parse_pred(const char *str, void *data,
 	unsigned long size;
 	unsigned long ip;
 	char num_buf[24];	/* Big enough to hold an address */
-	char scratch[4];	/* Big enough to hold an IPv4 address */
+	char scratch[6];	/* Big enough to hold a MAC address */
 	u8 *pred_val;
 	char *field_name;
 	char *name;
@@ -1738,6 +1738,24 @@ static int parse_pred(const char *str, void *data,
 		if (pred->op == OP_NE)
 			pred->not = 1;
 
+	} else if (field->size == 6 &&
+		   sscanf(&str[i], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			  &scratch[0], &scratch[1], &scratch[2], &scratch[3],
+			  &scratch[4], &scratch[5]) == 6) {
+		/* For MAC addresses, only '==' or '!=' are supported. */
+		if (pred->op != OP_EQ && pred->op != OP_NE) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+		while (isalnum(str[i]) || str[i] == ':')
+			i++;
+		pred_val = kzalloc(field->size, GFP_KERNEL);
+		memcpy(pred_val, scratch, field->size);
+		pred->val = (u64)pred_val;
+		pred->fn_num = FILTER_PRED_FN_MEMCMP;
+		if (pred->op == OP_NE)
+			pred->not = 1;
+
 	} else if (str[i] == '0' && tolower(str[i + 1]) == 'x' &&
 		   field->size > 8) {
 		/* For sizes > 8 bytes, we store hex bytes for comparison;
-- 
2.31.1

