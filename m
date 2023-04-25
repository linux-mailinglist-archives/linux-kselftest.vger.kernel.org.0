Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9981E6EDEEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjDYJQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjDYJQu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 05:16:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AA2685;
        Tue, 25 Apr 2023 02:16:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0i0ZW005234;
        Tue, 25 Apr 2023 09:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=uEvv3LAyU/zfvFvoOcm942rAaxSYCfXplaAMUlb7W6o=;
 b=1VMGomFVkEsfbBS33eMP4Tk269b1nYwJ687E5J/zysOcG9XQzRAgMkRtDtZkEyfKywVi
 F0JY9WmLP5savx6SJ5bRNjDmuFASGEhf6WsNFrojt1lDsIegADlryCTiqSHs7lJZlrR+
 ieiRbV63zbCfO2xyZEUBpWYZFDdoRF1IGN8izTJmwrXAD1h+wtdg9xFSQ0A2amrbOs+7
 /XbJumwzi8VoghLwd5x64ZSMMX8zSfBz62B/mX0sdfMnXNjuBj0/OfNHx6UcjjRXTG98
 TzAKQ1vLuuZoYui/tx5uNQ502dqmSCg9kRwuqtn9Gj4cKLaV6HBdihJytH2zn8cF2/02 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476tvun9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P7roOg025226;
        Tue, 25 Apr 2023 09:16:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461cdwcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33P93LCR024482;
        Tue, 25 Apr 2023 09:16:43 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-181-126.vpn.oracle.com [10.175.181.126])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461cdwa1-2;
        Tue, 25 Apr 2023 09:16:43 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH tracing 1/3] tracing: support > 8 byte array filter predicates
Date:   Tue, 25 Apr 2023 10:16:35 +0100
Message-Id: <1682414197-13173-2-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: LZoWkMPiAxPu9ZSGPpVbSovH5u3HcKa6
X-Proofpoint-ORIG-GUID: LZoWkMPiAxPu9ZSGPpVbSovH5u3HcKa6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For > 8 byte values, allow simple binary '==', '!=' predicates
where the user passes in a hex ASCII representation of the
desired value.  This representation must match the field size
exactly, and a simple memory comparison between predicate and
actual values is carried out.  This will allow predicates with
for example IPv6 addresses to be supported, such as filtering
on ::1

 cd /sys/kernel/debug/tracing/events/tcp/tcp_receive_reset
 echo "saddr_v6 == 0x00000000000000000000000000000001" > filter

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 55 +++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1dad64267878..4f4f53b7302d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -67,6 +67,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
+	FILTER_PRED_FN_MEMCMP,
 };
 
 struct filter_pred {
@@ -622,8 +623,11 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	kfree(op_stack);
 	kfree(inverts);
 	if (prog_stack) {
-		for (i = 0; prog_stack[i].pred; i++)
+		for (i = 0; prog_stack[i].pred; i++) {
+			if (prog_stack[i].pred->fn_num == FILTER_PRED_FN_MEMCMP)
+				kfree((u8 *)prog_stack[i].pred->val);
 			kfree(prog_stack[i].pred);
+		}
 		kfree(prog_stack);
 	}
 	return ERR_PTR(ret);
@@ -890,6 +894,14 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
 	return pred->op == OP_EQ ? ret : !ret;
 }
 
+static int filter_pred_memcmp(struct filter_pred *pred, void *event)
+{
+	u8 *mem = (u8 *)(event + pred->offset);
+	u8 *cmp = (u8 *)(pred->val);
+
+	return (memcmp(mem, cmp, pred->field->size) == 0) ^ pred->not;
+}
+
 /*
  * regex_match_foo - Basic regex callbacks
  *
@@ -1353,6 +1365,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
 		return test_pred_visited_fn(pred, event);
+	case FILTER_PRED_FN_MEMCMP:
+		return filter_pred_memcmp(pred, event);
 	default:
 		return 0;
 	}
@@ -1631,6 +1645,45 @@ static int parse_pred(const char *str, void *data,
 		/* go past the last quote */
 		i++;
 
+	} else if (str[i] == '0' && tolower(str[i + 1]) == 'x' &&
+		   field->size > 8) {
+		u8 *pred_val;
+
+		/* For sizes > 8 bytes, we store a binary representation
+		 * for comparison; only '==' and '!=' are supported.
+		 * To keep things simple, the predicate value must specify
+		 * a value that matches the field size exactly, with leading
+		 * 0s if necessary.
+		 */
+		if (pred->op != OP_EQ && pred->op != OP_NE) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		/* skip required 0x */
+		s += 2;
+		i += 2;
+
+		while (isalnum(str[i]))
+			i++;
+
+		len = i - s;
+		if (len != (field->size * 2)) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + s);
+			goto err_free;
+		}
+
+		pred_val = kzalloc(field->size, GFP_KERNEL);
+		if (hex2bin(pred_val, str + s, field->size)) {
+			parse_error(pe, FILT_ERR_ILLEGAL_INTVAL, pos + s);
+			kfree(pred_val);
+			goto err_free;
+		}
+		pred->val = (u64)pred_val;
+		pred->fn_num = FILTER_PRED_FN_MEMCMP;
+		if (pred->op == OP_NE)
+			pred->not = 1;
+
 	} else if (isdigit(str[i]) || str[i] == '-') {
 
 		/* Make sure the field is not a string */
-- 
2.31.1

