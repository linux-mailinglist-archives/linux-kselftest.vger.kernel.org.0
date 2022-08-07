Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF858BE09
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiHGWeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiHGWdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B28192B0;
        Sun,  7 Aug 2022 15:22:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277J3xeV016982;
        Sun, 7 Aug 2022 22:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Z166aQrGxFvGfqgfYk2k/eb+MdkHWLkpuHni0wWAVkg=;
 b=dV6O4vwHXYs/0K/rdPAzy0CNmkMd7nw2H8K8NRQ8fS7thX2ZO7pBAM3qUpeG04nybWRr
 dCtL7pd1DHtWPsx6KkDudg9Q+6wdN1DJsWdsrbVhv9nuTgbqWeJ/sp86rFcsYbsLcBm5
 wn89PDp7nq1HLleoQ5YYPrjlKD2ag8FVpzCAtJ2gW3cn0O2z7mi6yLS4KRBQJleJCSRn
 DRvOc78i0hUW0mN1DA3EUSehaZwBStOyZEy34UP/6K5pkG4wDX8ZPFli5eOZUbr72uOr
 WIWm+7cRZDqlEa7OyQkPPDlgs98cOFoML9+6P26IVwsEzXUGci/vQSn6al05H68Fg5oX eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew122ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277D0o49035674;
        Sun, 7 Aug 2022 22:21:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser15gwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX3Xxw8JMoC30pER+VnLH+n3CUb8zE1v3IgoeH2AGaHeUYCIxWj/6kcNUznuJPo98GDBDW56qAvvSr1QXijQI2zgS0OzPq38XG2HRZpK2mCgKuOHg64cUYRS8t7qC0lBtsZB0E1MRXGNgIZuXOfeDBI8GX5ourYhqB3+VOEf7EwPBxLo3L7B3HUnm/xUVPAHA97H5I6j/Sro0nfuag86A0eDJwsaiCgAXCCeRY+laYs09JmoVxEj8NoAmWDtPIqYlTM4fDsXVUcDKpUw2qnUq+O5dWkrxb9Xr4LQgS2R23PMzA9SkcNzN5tqzjmdx0TE94LVGfcKeth1oj3eEOJhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z166aQrGxFvGfqgfYk2k/eb+MdkHWLkpuHni0wWAVkg=;
 b=KkgJJ1XWeDyqYFT3/6u87TuCQM9HIYuKO7JXmpc1D/4NHSzjIwPf9x3ClNfTmIFR852N86SWtxcjkYRiUXmgdpeOrMlZVYYGZ8r5bQ3lGemLL96VrCsDR/2H4YbrFNesmXEZ91OtL16QtFmYhAAjDVgJRCOADdMq5B2RMmY1QRxLSlP+VuXewb87geJbgj2YOth6p+ZJlMjMKNjFHTUfzisAa40GHW7QI5XMS/xVya8Wt45ft0lg6bF1H04DsAUvhS/IK2FP5EFbUl1g3RzWntzd67NYsGblKrDw9bY5sQDKaI7VBfRUPQg8vCBrvqto5jNR37Y3ch/ll+xWPmYXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z166aQrGxFvGfqgfYk2k/eb+MdkHWLkpuHni0wWAVkg=;
 b=PJm23vCXsCiT2x0yljtPm1mGuKMJDKjYSEWpPui530mux1DwTJ4t1UlY0myye/8HCMqjClvMat6Q1lBJexs13hIA0dyVNpRSKIlCrBet+OmIU6CFGAyUDmhEtrJLIe4YdcWv19IOOOXto723hCizpz9WmNC7b5STPfyT2xpD/D0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR1001MB2381.namprd10.prod.outlook.com (2603:10b6:301:30::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Sun, 7 Aug
 2022 22:21:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5504.020; Sun, 7 Aug 2022
 22:21:46 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC tracing 2/4] tracing: support > 8 byte array filter predicates
Date:   Sun,  7 Aug 2022 23:21:21 +0100
Message-Id: <1659910883-18223-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
References: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a8a8f5-227b-48d6-7a54-08da78c3370b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/WotO10XI0MD+mst9sO2Su6xEGOqJ1u5h7uTQnhjFnNPoBCtPgQnVTE56l9MWe/u3v4fwRXZlzH/DtKQ2oxfD42njOWg4rX/ZZfigdxuPPPfL9/Z7naTCoEAn/nIWx9IAIHI/xuIRxMTcpWv56jVRSrAXXxKijOy7st1026hL3jKS2UnMiLB+lfPgnJOzUFpTR56SzJh9CYZ/r4kdNrBMv7AJ+2NBVb3xoevzG6d5Nw81476GyyhjlCp7ptbU9Vv53sB4Yfm/RJV2PfxtAzdqg4k5Xy6VYww2l8eeWQSjByDw64CBX4JNpAcb7VvlaKFExzoj9ROL8318t2ruESKInwZnz0qpAiq4v5gWWqDhUkpT4+Kau1MAF4KE3gQttHG9pHMkRIl3nL25gHb8XwG09LPeZ1/Y5PF7JyEj2wo3VLFrPaeCd27tH13WqltlF9PH0TblzcHZWGMBUA2vMifSS89e+F8kEqYjyNrN65bylvOhcfenCucN7NZR1aAKkB7eHGwMydIWX+8fQieZE681NOL7dnOWAcUEHZCjjkELiGRp68MDv6g81+a3C3Rr/rhSIGCg5riXSKDsNxU89hvd3t+rHoWYHHbIUvwPy6wScxVpys7XqnC7eS71tTnR9+ccTWlR8GYp8qBf/oKilBG6QZoHd8Q7JbLgmXfccBxVMGLpzBm+PeWopLi0aJfSZ0GsnHaN9f3fl6QGbfTcyyejjKugfHZIF2VG4AIvLIjw3gHfCuHQdkBz1GmbsffZCeVfTv5sAGDIevlM3d2Nhp7VbIOzfWSZae2KgcSOBJOnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(186003)(52116002)(107886003)(478600001)(86362001)(6512007)(26005)(41300700001)(83380400001)(6506007)(2616005)(6666004)(2906002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(4326008)(8936002)(44832011)(5660300002)(316002)(6916009)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+LNFeVgwth7BYTHa2NFMDW0H2Kxb4UE+7QqnNifLyBH2El/uNKrkaEYwgY7?=
 =?us-ascii?Q?EiKx/2mY58j06XyU86Z6IChlzZvrDeqvpaHlzz4wFxR+ElORAT/VTQqfMpsF?=
 =?us-ascii?Q?2EcIr/Y/Mux3rTJk1KO4vwyYHgiVS+2XMZiiLLVO/1SNrassl1tJWS2Vvg8Q?=
 =?us-ascii?Q?3rY8uqF4Oqo+VTKkM8sFVweE0cMdxfP+Nkg/tWNnSUstfwtfWDrUzPw6l7FD?=
 =?us-ascii?Q?MLzA/8cJAkA4ZBgpFvz0ZSX5HRo8gVNNycAc02ZdasRjL0MzDn8fFzaG0+ei?=
 =?us-ascii?Q?aBvqftAP6UqiPMy4LVCcLrXOS2X7ZcxLBhkFxzabgQJJBHQxoRIlscPTIJWD?=
 =?us-ascii?Q?2QebLpVmLsVenakWKLj2YFWtkfa8nHGnzEpjyin8lujSyNOi96MLOIWMfeL4?=
 =?us-ascii?Q?1NfzMVE6JpjEpRc98l5CIpnOf2fS9jonTR+DAW9zuvdBWjv/uQrraXu1CAoi?=
 =?us-ascii?Q?1iOfcP622cxhXSUTp5nltHS8wQSdCNIza/Fbq47Zteh7GgpCBi3VmU0ay0yU?=
 =?us-ascii?Q?SXK+IHtFCht7xPYYgHElfhyAuXIRQtVdZIrgX8AJzHEAxDGz8r6QmbNj5ozY?=
 =?us-ascii?Q?cdk8TgrMDtff9ch9si5hRQx8Fm8CPnoxL1w4HYsGPsF7qRFGwbW0wYQhQ7nA?=
 =?us-ascii?Q?Y0OdjavCV89DrqHFCZPA5DQXF86lTene1RlWjEmgrkegKbNiH8VOOruxVWaa?=
 =?us-ascii?Q?6Wp3OC/ggg8n2y14m/85BMWF+1h1GvsrQTz4Nbf6KkDYSPHI44cB0sQuRycO?=
 =?us-ascii?Q?ANdHo/czSGJUOSTs2GNYsLj95uc1C/GoqZ/BRPfketvrxpIeklN6aF64w9ER?=
 =?us-ascii?Q?817w3eFglZu5RgvPqYXKFdNjcVPgOgSnbCyubEPBQVlJYRwXxbKfaFSBf0Tw?=
 =?us-ascii?Q?UXvwq/n4/pdRu42bGgpTCZZLe4UU04gVUmu7FQiTxHzr2WX7d/LoSgC8uvIL?=
 =?us-ascii?Q?8+xm4Dlz+qDTA73hrLVBv9aRFDMjt7TBThvSw4B7wX5KSD5GLwhF874Nbf+K?=
 =?us-ascii?Q?cyO28+XLOPXyzYMR8/dJkskiruLTguAD6/MwivLmMNJn2xfPF3tAnrxXKQHq?=
 =?us-ascii?Q?OZwULy0yF7ttyT1yf+jv61+aDj49HVnnRfNIGrnUykJBcqLfq6x0q/VWJ6pn?=
 =?us-ascii?Q?ygh1HStV95WGwEWfXbu3gJTenWvjPadWH3HL8HFIW5cE1BxfhGd902TDTJje?=
 =?us-ascii?Q?3j6GxKa3cRa4G48tcHFksIAUcIDuEPbcLUa0XrZ7gvJcIg6oET7BCglsU/ZQ?=
 =?us-ascii?Q?/jghfuHWJKYK7JwtGwiynGaOoLMZiaIzj2sNs7rFm6G8wQojaGLVQ+GihL5y?=
 =?us-ascii?Q?geFYTW48uflYM68eUIadsBhWaAKHgtyuM8wucsxgeNb+xV4XRlWExSiXlOsQ?=
 =?us-ascii?Q?wZ7DGtwrzdlYGsHg7emdSTz+21kJQB1hxYohsOjUSoS9ATqwfd4xqDRBUsoQ?=
 =?us-ascii?Q?j+J2JM1FCVrC2pDUxyf5xkW99mbRMT4/btnF1t5saCeRlKlI/3Am6dWLlnuu?=
 =?us-ascii?Q?IgumokN/8Qtx2y7dliUWUDqq76ZvXBs3cULE4oRxLzsTyNl3skb8BITZ9qA6?=
 =?us-ascii?Q?AZP+0pi704qDoqJD3xyMbnk8rsBk7Ta9JPHcWfBf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8a8f5-227b-48d6-7a54-08da78c3370b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 22:21:46.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtPnmc3762FC3I3G4Vz6CqLR52IQYSOEsZ9KDwrUFbfFMa8P8Wr21XiMnO+m61jkB/MXd1WVN63QHDRDUvPw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_15,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208070119
X-Proofpoint-ORIG-GUID: jm-nh2aDWMHdwcPpab0ipnfpKq3U6Efl
X-Proofpoint-GUID: jm-nh2aDWMHdwcPpab0ipnfpKq3U6Efl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 kernel/trace/trace_events_filter.c | 54 +++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 65e01c8d48d9..31c900b6a83c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -147,6 +147,8 @@ enum {
 	PROCESS_OR	= 4,
 };
 
+static int filter_pred_memcmp(struct filter_pred *pred, void *event);
+
 /*
  * Without going into a formal proof, this explains the method that is used in
  * parsing the logical expressions.
@@ -583,8 +585,11 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	kfree(op_stack);
 	kfree(inverts);
 	if (prog_stack) {
-		for (i = 0; prog_stack[i].pred; i++)
+		for (i = 0; prog_stack[i].pred; i++) {
+			if (prog_stack[i].pred->fn == filter_pred_memcmp)
+				kfree((u8 *)prog_stack[i].pred->val);
 			kfree(prog_stack[i].pred);
+		}
 		kfree(prog_stack);
 	}
 	return ERR_PTR(ret);
@@ -841,6 +846,14 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
 	return 0;
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
@@ -1443,6 +1456,45 @@ static int parse_pred(const char *str, void *data,
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
+		pred->fn = filter_pred_memcmp;
+		if (pred->op == OP_NE)
+			pred->not = 1;
+
 	} else if (isdigit(str[i]) || str[i] == '-') {
 
 		/* Make sure the field is not a string */
-- 
2.31.1

