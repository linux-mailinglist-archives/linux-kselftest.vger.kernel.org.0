Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CA6F1BA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbjD1PfI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346518AbjD1PfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554301FFB;
        Fri, 28 Apr 2023 08:35:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3uCY001561;
        Fri, 28 Apr 2023 15:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=nOmEmDJvf0ujmg1ooMtHBJ58/BwYXKCo6GrTn2bVPdY=;
 b=rJkCevQdNa/NMda9eDmvgP5oSBz4rZnb6AAL7OXz6pmRn9TZrngmQO9Qjv156K/q/7JI
 zUmG7J6hj/7AeolrvHnhzJdivqdb8Yuz2fHiaUFOUyvp12XqAmoFtA0XdoMR2wOlkvBl
 qoGsp5gttejcVavebwViRY58ic9pTl4YqcUCh6hv4H/cK8bcW9yKL7aNZECjVkIoJrKn
 weebUmiTNOMPsAz7uC1PFdIglB9lKR6Niqgjk/5aueRh8v3GEOQXSLZqQtNN1HV5skDl
 KjfUHeXRAd/lo2U1vntcFq/5/pbv/0jvb5RUdLqTDSfuwZKEVMrgOzUm+Llek0S7rpu2 Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md6rcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE4dKI028041;
        Fri, 28 Apr 2023 15:34:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:57 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUE028134;
        Fri, 28 Apr 2023 15:34:57 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-3;
        Fri, 28 Apr 2023 15:34:56 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 2/6] tracing: support IPv4 address filter predicate
Date:   Fri, 28 Apr 2023 16:34:45 +0100
Message-Id: <1682696089-27937-3-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: PFChNbtqyuwrdE_yijqNgJq5ob7yTXIL
X-Proofpoint-ORIG-GUID: PFChNbtqyuwrdE_yijqNgJq5ob7yTXIL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support '==' and '!=' predicates for IPv4 address format;
for example

 cd /sys/kernel/debug/tracing/events/tcp/tcp_receive_reset
 echo "saddr == 127.0.0.1" > filter

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 64f1dfb72cb5..d8e08d3c3594 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1384,6 +1384,7 @@ static int parse_pred(const char *str, void *data,
 	unsigned long size;
 	unsigned long ip;
 	char num_buf[24];	/* Big enough to hold an address */
+	char scratch[4];	/* Big enough to hold an IPv4 address */
 	u8 *pred_val;
 	char *field_name;
 	char *name;
@@ -1646,6 +1647,24 @@ static int parse_pred(const char *str, void *data,
 		/* go past the last quote */
 		i++;
 
+	} else if (field->size == 4 &&
+		   sscanf(&str[i], "%hhd.%hhd.%hhd.%hhd",
+			  /* assume address in network byte order */
+			  &scratch[0], &scratch[1], &scratch[2], &scratch[3]) == 4) {
+		/* For IPv4 addresses, only '==' or '!=' are supported. */
+		if (pred->op != OP_EQ && pred->op != OP_NE) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+		while (isdigit(str[i]) || str[i] == '.')
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

