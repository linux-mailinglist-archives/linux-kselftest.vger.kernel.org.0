Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F026F1BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjD1PfI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346529AbjD1PfG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CC1FFB;
        Fri, 28 Apr 2023 08:35:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF4GLx004440;
        Fri, 28 Apr 2023 15:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=HW9CMy3il/IRcCDBr4P2DexsA8A9u2fl1mPaG/1i0tU=;
 b=iPfW1RU3Kc9GmHndTABqPsOsZi7Zc+OGfprw1RwNAu0gXuupPwuZUGMKiZwQPggYPilJ
 szsHd2h1zS9vxNtYiRuur/dpbiwMbk9Fzv3mQGpYRtV71QLjoHa2VmQ8WHFJMXLlfG/j
 MogbS+vpnyDDXGSerT+JX8h5o1w7vUCzA/bk3bmpOd0jzQKOKyDVwRzJvp20bP6dZC2n
 EYKkAn+CrvyqchZMWg19OUXl6CkPsmk55+wSRVoy7RjsWKZDJfzOxwcbjA7cRDcPLcM/
 NFpgvGqtXW6/iV7SvelTu2XGzD6ljU2RdXYUAemAYvr7e0/WTobNeVRbLIxuCt2xkRQL hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47faxjcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:35:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE1TQU028199;
        Fri, 28 Apr 2023 15:35:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUG028134;
        Fri, 28 Apr 2023 15:34:59 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-4;
        Fri, 28 Apr 2023 15:34:59 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 3/6] tracing: support IPv6 filter predicates
Date:   Fri, 28 Apr 2023 16:34:46 +0100
Message-Id: <1682696089-27937-4-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: XYPD5ShOdlBAgY4MyrfNSHTRnaCmXswa
X-Proofpoint-GUID: XYPD5ShOdlBAgY4MyrfNSHTRnaCmXswa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support '==' and '!=' predicates for IPv6 addresses;
for example

 cd /sys/kernel/debug/tracing/events/tcp/tcp_receive_reset
 echo "saddr_v6 == ::1" > filter

 or equivalently

 echo "saddr_v6 == 0:0:0:0:0:0:0:1" > filter

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 73 ++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d8e08d3c3594..e2521574f3c4 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1665,6 +1665,79 @@ static int parse_pred(const char *str, void *data,
 		if (pred->op == OP_NE)
 			pred->not = 1;
 
+	} else if (field->size == 16 &&
+		   (str[i] == ':' ||
+		    (isalnum(str[i]) && tolower(str[i + 1]) != 'x'))) {
+		u8 j, gap_size, gap = 0, gap_count = 0, index = 0;
+		u16 tmp_v6addr[8] = {};
+		u16 v6addr[8] = {};
+
+		/* For IPv6 addresses, only '==' or '!=' are supported. */
+		if (pred->op != OP_EQ && pred->op != OP_NE) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+		/* Store the u16s in the address string consecutively in
+		 * tmp_v6addr while tracking the presence of a "::" (if any)
+		 * in the IPv6 address string; we will use its location
+		 * to determine how many u16s it represents (the gap_size
+		 * below).  Only one "::" is allowed in an IPv6 address
+		 * string.
+		 */
+		while (isalnum(str[i]) || str[i] == ':') {
+			switch (str[i]) {
+			case ':':
+				i++;
+				/* mark "::" index by setting gap */
+				if (str[i] == ':') {
+					gap = index;
+					gap_count++;
+					i++;
+				}
+				if (gap_count > 1) {
+					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
+						    pos + s);
+					goto err_free;
+				}
+				break;
+			default:
+				if (sscanf(&str[i], "%hx", &tmp_v6addr[index]) != 1) {
+					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
+						    pos + s);
+					goto err_free;
+				}
+				index++;
+				while (isalnum(str[i]))
+					i++;
+				break;
+			}
+		}
+		/* The gap_size here represents the number of u16s the "::"
+		 * represents; for ::1 the gap size is 7, for feed::face
+		 * it is 6, etc.
+		 */
+		gap_size = 8 - index;
+		index = 0;
+		for (j = 0; j < 8; ) {
+			if (gap_size > 0 && j == gap) {
+				j += gap_size;
+			} else {
+#ifdef __BIG_ENDIAN
+				v6addr[j++] = tmp_v6addr[index];
+#else
+				v6addr[j++] = ((tmp_v6addr[index] & 0xff) << 8) +
+					      ((tmp_v6addr[index] & 0xff00) >> 8);
+#endif
+				index++;
+			}
+		}
+		pred_val = kzalloc(field->size, GFP_KERNEL);
+		memcpy(pred_val, v6addr, field->size);
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

