Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B56F1BA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbjD1PfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbjD1PfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE881FFB;
        Fri, 28 Apr 2023 08:35:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3pBG013966;
        Fri, 28 Apr 2023 15:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=YVCRBRkfFPkGR8hzIXJZIFGAb7lsTnmbW9p0HfFiVb4=;
 b=j/30y37wb+GSCqfEURAF8YuuxUyRjOt7dmgFfcFiqwGuv3O3H9pVp1S4fl16OR/gPfMa
 ix30NithNwsbW6WoknxKgHbUjJXBJfjZOR9VU/hFRFofSuS6SABeDC6RS5T3IUT0FvDe
 IS6LlIvToeOVney14FKeNEl1zke4na8KiIFJN6kJd9sCT4tKgGaeOg3gNEWjRTCL5HX9
 rBA+nzVNSBNig6Q3DLm5j1xZvYs2XxMVc2rT/hSkUME+z+Wf5NkGCXeCYyxiM9g8+fPw
 oyVZR0U+NNvx8uILA1+dAX77rjGNX2WcdcVfkvsQC3dE2TEw+gh1C2wGZEL+AyMDhv6d Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460def5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE6V1p028202;
        Fri, 28 Apr 2023 15:34:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUC028134;
        Fri, 28 Apr 2023 15:34:54 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-2;
        Fri, 28 Apr 2023 15:34:54 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 1/6] tracing: support > 8 byte array filter predicates
Date:   Fri, 28 Apr 2023 16:34:44 +0100
Message-Id: <1682696089-27937-2-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: L4u-s7ivLQPx9SW7S1MLZl8zQFLl1SVw
X-Proofpoint-ORIG-GUID: L4u-s7ivLQPx9SW7S1MLZl8zQFLl1SVw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For > 8 byte values, allow simple binary '==', '!='
predicates where the user passes in a hex ASCII
representation of the desired value.  The representation
must match the field size exactly, and a simple memory
comparison between predicate and actual value is carried out.
For example:

 cd /sys/kernel/debug/tracing/events/tcp/tcp_receive_reset
 echo "saddr_v6 == 0x00000000000000000000000000000001" > filter

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 54 +++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1dad64267878..64f1dfb72cb5 100644
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
+				kfree((u8 *)(uintptr_t)(prog_stack[i].pred->val));
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
+	u8 *cmp = (u8 *)(uintptr_t)(pred->val);
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
@@ -1370,6 +1384,7 @@ static int parse_pred(const char *str, void *data,
 	unsigned long size;
 	unsigned long ip;
 	char num_buf[24];	/* Big enough to hold an address */
+	u8 *pred_val;
 	char *field_name;
 	char *name;
 	bool function = false;
@@ -1631,6 +1646,43 @@ static int parse_pred(const char *str, void *data,
 		/* go past the last quote */
 		i++;
 
+	} else if (str[i] == '0' && tolower(str[i + 1]) == 'x' &&
+		   field->size > 8) {
+		/* For sizes > 8 bytes, we store hex bytes for comparison;
+		 * only '==' and '!=' are supported.
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

