Return-Path: <linux-kselftest+bounces-30705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31329A8819F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AD116A287
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826D2989AE;
	Mon, 14 Apr 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AhlzGdj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8A433CB;
	Mon, 14 Apr 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636765; cv=fail; b=N/l12Zh8I0x30WAQxeh1zIYVPE/BpfUiRKIsGBoQH4cJIeKHPR8gWDFjVAQ3q/tX/993ojpKidt1THesTr8bEMKXCr5huMS6qNpZSiKMbtlwOpHAj55gayzNM2nOPFeUu1KijKobEwJSDaVQ+cfLqCXmdZlJeq4x8Vh8/MUlRAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636765; c=relaxed/simple;
	bh=v6KLmkb0fJuSsb1mZ1MtadT1wRUtT4KuA5gFBw20vBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=of4KU59zCI7nYmH2TzSDMpEjX+Ek1U6532neRebXz4ErXv+A8v22DsDBqKjwumV6Nvs5ZDanQa2N4uRx5qqDENSqY03Jt0SXhLKskpHZrGUHOXPJqN4GUlNBRlhQDjauuS8G9FuQecrhOmrF9JFf6b+00Phcy84HRG1mPeaYJLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AhlzGdj/; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcnf4HoO+QNllOtsNWAftvOYR/AJzRmbgEEiz6Tw5NWOO9DIPwIZ3aN1aw/Gm+lhf5zHFpao+UCQcw5kR1j2TuSw0JuupKDx5Y1ttL1hNw+J82HpntWkEI0F9P+4ozUpHBLUBXtO6ywJePWyl647CzPiMIWzLl6lqEPrXxIAcMrXf6QgIbiT6TEyX45EJfE/2BVrHfcGGiblka46Ne8snHriwx/6/JMb4aJBUkTT2BI2VfQl0chKgpkypIAcT6MLjTF1w+TbIVVG1PCcn21RnV1F0maNbiycXSve0YeakwAa2idHRB8bEQ62Uay7A8jFzD+SivyHivNrQ2oLimXacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AfhlY69CXja+OE9RT7710H5Zy6K1QH4QhqttMWHId8=;
 b=brex3FYSFJjPQoMJNSmmqgTmFXXJF7e9UGDfmTiII4v35BeEu7weG0SO5nS0a9MLGpuDCqT4c2DR2W/g6VzRqz9RvBt7aTvaxvFqhavFYC+2G2rY3xb+Pr859hDJpSCzo+LZDV6+ij6K0yZQZlTE9vq7wdi0RbHiAjAadilKoT2QYMUTjLZ/YyUR1wIO1qvTwz1XcEMALMkAXK5/7hqmDI7StVkH8oO+31O5Mqy2Imcp7wJHVcqrF201bDu8THspKccvMW/Dx5BLViaQLKv7kQHjD/De/YPalLEp5VXnmNYlApQ/NDwrpPHYI7v1zbP0CGi1OliCMtjWeW3XzdeiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=henrist.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AfhlY69CXja+OE9RT7710H5Zy6K1QH4QhqttMWHId8=;
 b=AhlzGdj/l9rF1IZp0YbWqrC/o1wxjMpS4jH3eTR2o/kbSMGq46fmOLGHUDe6BwGhlU1k5qevoepXI3RSpi70j614/Jg+WyV6RnfVC+6kMy/m5qk8HDTw1Z+KwytFBIXt9kuBKbW+NeCN8h6t8XIrzViVvSvG/aDGCmiR0JKnaTeJqH1VB5mihKvWVNzzb+y9RMIPl/a5xXcib2ZN1YukBZ6CBrILJ4ZMAJigffTazDQcj4N1RZxI0kAPjmS8ZC2+JLAox5xRX0WZx6MQUk1YZmu4uLAlF+ww1snjnctT3QqhQROkXiZ6pjhFzLv8Gu4RrOS0VlPC9O4aBeb3/r6kcg==
Received: from DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) by PAWPR07MB9926.eurprd07.prod.outlook.com
 (2603:10a6:102:38a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 13:19:11 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::40) by DUZPR01CA0043.outlook.office365.com
 (2603:10a6:10:468::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Mon,
 14 Apr 2025 13:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:19:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDJKYs027866;
	Mon, 14 Apr 2025 13:19:25 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
        Olga Albisser <olga@albisser.org>,
        Oliver Tilmans <olivier.tilmans@nokia.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Henrik Steen <henrist@henrist.net>
Subject: [PATCH v5 RESEND iproute2-next 1/1] tc: add dualpi2 scheduler module
Date: Mon, 14 Apr 2025 15:18:59 +0200
Message-Id: <20250414131859.97517-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131859.97517-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131859.97517-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|PAWPR07MB9926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b1e2ce79-1788-417e-5d39-08dd7b56f17f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?rmY7FJaYIJnvgOy+ss47Nz1xvEPxxctK+TXeo3e5XJtdeUSZ5vT7qFzBebv1?=
 =?us-ascii?Q?yJLeUfKS8lnTcSmc5ZzG5vJ6O4mPUmGPXx44JoTFODIhtmhOoKr+24w9q2u3?=
 =?us-ascii?Q?bIqlrsVbqS9s8PsIAzJ0SSG6znDF3/VN+P43ER8lg0hYT5U7/0KP3w6oSKpR?=
 =?us-ascii?Q?YjG+y/iZGoiydcidOcEZu+z1s1VvHB2YJtfiixmUznsT1vPZ4KOdOjga6jJA?=
 =?us-ascii?Q?E3A18jrOl3leOh++12GHzlqVHjS0ZICsDDgeztSwTdqch1OTx34Q5RBhGyw+?=
 =?us-ascii?Q?kBxGzINzsiwSQzcM1XJrT4H4WImZxg7EGlQgU82/ta0WdnEVFGh4vXEn6z04?=
 =?us-ascii?Q?9GCeXxeS7S3quGjFtRPWp+9uUDIw/FSGhslIwN5farZaeYn7bcj2Qq3VsxrH?=
 =?us-ascii?Q?DlguXvT/FkD+dCRdo3BNbjPZnK+bczg4rMOAG99lrKuHcLYh+VTS2lGqsHPB?=
 =?us-ascii?Q?FilOvk72NCBqN+GWzNJsLHyjCkyY5yQPuqeWav30zu7dNQvMpDbDFHWrMMT1?=
 =?us-ascii?Q?SUkZW0oXkdlMMeo1hlZW+Ntlmm+JNdB4mOcW/MABVvLAs3Z5rFZhvvMLW9db?=
 =?us-ascii?Q?phmPAHGsZ6qXkdnogfIV0k5H6RrWakR6uQrtG6AAJLQJUZ+HgDhPq1/B8SRE?=
 =?us-ascii?Q?Es+/GoJ6HFExEHPbcDL8WKop2AZTEZmcAgezW1yr5CvgYJsZf7CKIwi4tT4U?=
 =?us-ascii?Q?BO82C6kbrSQUvc8pjCYRuO6JnW68AoKCMsHbl23nn/y2qCYp33DLtfL2geb3?=
 =?us-ascii?Q?nA8q4zmRSZxE+HTOXm1PtpIt0zxCqiY+qQhGN9t667WXEAo10OGouus/PzF/?=
 =?us-ascii?Q?qbu4I8/J9ziDfRn1ZI9LCvZrpNq/dLAF9U3cDRk+DUTXqiMj56hUFqOA/2Rt?=
 =?us-ascii?Q?FivSAUhQUJCgWujTqNEyzpmGf2u+kHwOJc1ZrGPEvM94jJNxFlhdSKKvBOFT?=
 =?us-ascii?Q?3FuJptmSsgNasP2wOHqq28AqTkq0Rxt83enRh9FhKBmEHJT+4tRvMTyHY9o/?=
 =?us-ascii?Q?ojAlGZGnPEG/1HRRxu9iqlo9QYHpxT5gN52lIjNDL2+58ms8GX9LvmrLHx6M?=
 =?us-ascii?Q?IzoSxWSISCnd4VsQHUvQrtbdVCJq+umIvDqR2k9Jf8doodZrwAtkQS/vTrUf?=
 =?us-ascii?Q?c0KBsGhhZ3zhNOCqL22H9aCT1++JRo10YVF0VHGqi9hN8KdlHiUDPDl9xkkj?=
 =?us-ascii?Q?62mWVIHsit9mbIUFylHz8DSzn6It8rWSqA0wbce2m4yDdBvWk1uZM0CqhX0a?=
 =?us-ascii?Q?XUpcPp1Gl+LlBxwAkgt59sABfhj8Ul0YPwkp7apJIoYgB6EZ1WxpvFB7216p?=
 =?us-ascii?Q?VVX2Spg3/FIgCO+IaWlrJ2Psji5QPUQ7aXNtXK6ezXHGn76rTw+kpR/AcE3z?=
 =?us-ascii?Q?skzJxHVrkPGitDr48RUfzJ58KoidjB1KCzgKS51GJRibfAbCcQ5X1AmA5Byo?=
 =?us-ascii?Q?zqM2j5Lvm6w5EvzZe3WX+9cmZl5MDNkBXJ/yBDdYNeS5s6uIhezXyG6glKOZ?=
 =?us-ascii?Q?rCNw+kvUdnoBVTTOjbwieO+lqYlHgeEXttqmZTpAFXxM3oiJU5Ihwx0dNg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:19:10.4288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e2ce79-1788-417e-5d39-08dd7b56f17f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9926

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2
base-AQM. The PI2 AQM is in turn both an extension and a simplification
of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while
being able to control scalable congestion controls like TCP-Prague.
With PI2, both Reno/Cubic can be used in parallel with Prague,
maintaining window fairness. DUALQ provides latency separation between
low latency Prague flows and Reno/Cubic flows that need a bigger queue.

This patch adds support to tc to configure it through its netlink
interface.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Olga Albisser <olga@albisser.org>
Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
---
 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  39 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 519 +++++++++++++++++++++++++++++++++
 8 files changed, 850 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

diff --git a/bash-completion/tc b/bash-completion/tc
index 61f0039d..c18288a3 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -4,7 +4,7 @@
 
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf \
-            drr hfsc htb prio qfq '
+            drr hfsc htb prio qfq dualpi2'
 FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
@@ -366,6 +366,15 @@ _tc_qdisc_options()
             _tc_once_attr 'default r2q direct_qlen debug'
             return 0
             ;;
+        dualpi2)
+            _tc_once_attr 'limit memlimit coupling_factor step_thresh \
+                min_qlen_step classic_protection max_rtt typical_rtt \
+                target tupdate alpha beta'
+            _tc_one_of_list 'drop_on_overload overflow'
+            _tc_one_of_list 'drop_enqueue drop_dequeue'
+            _tc_one_of_list 'l4s_ect any_ect'
+            _tc_one_of_list 'split_gso no_split_gso'
+            ;;
         multiq|pfifo_fast|drr|qfq)
             return 0
             ;;
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 25a9a470..29b92f23 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1210,4 +1210,43 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
+	TCA_DUALPI2_MEMORY_LIMIT,	/* Memory limit in Bytes */
+	TCA_DUALPI2_TARGET,		/* us */
+	TCA_DUALPI2_TUPDATE,		/* us */
+	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */
+	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
+	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
+	TCA_DUALPI2_MIN_QLEN_STEP,	/* Minimum qlen to apply STEP_THRESH */
+	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
+	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
+	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
+	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
+	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
+	TCA_DUALPI2_SPLIT_GSO,		/* Split aggregated packets */
+	TCA_DUALPI2_PAD,
+	__TCA_DUALPI2_MAX
+};
+
+#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
+
+struct tc_dualpi2_xstats {
+	__u32 prob;			/* current probability */
+	__u32 delay_c;			/* current delay in C queue */
+	__u32 delay_l;			/* current delay in L queue */
+	__s32 credit;			/* current c_protection credit */
+	__u32 packets_in_c;		/* number of packets enqueued in C queue */
+	__u32 packets_in_l;		/* number of packets enqueued in L queue */
+	__u32 maxq;			/* maximum queue size */
+	__u32 ecn_mark;			/* packets marked with ecn*/
+	__u32 step_marks;		/* ECN marks due to the step AQM */
+	__u32 memory_used;		/* Meory used of both queues */
+	__u32 max_memory_used;		/* Maximum used memory */
+	__u32 memory_limit;		/* Memory limit of both queues */
+};
+
 #endif
diff --git a/include/utils.h b/include/utils.h
index 9a81494d..91e6e31f 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -146,6 +146,8 @@ int read_prop(const char *dev, char *prop, long *value);
 int get_long(long *val, const char *arg, int base);
 int get_integer(int *val, const char *arg, int base);
 int get_unsigned(unsigned *val, const char *arg, int base);
+int get_float(float *val, const char *arg);
+int get_float_min_max(float *val, const char *arg, float min, float max);
 int get_time_rtt(unsigned *val, const char *arg, int *raw);
 #define get_byte get_u8
 #define get_ushort get_u16
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fcffa852..9f6084e6 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -67,20 +67,6 @@ static void usage(void)
 	print_usage(stderr);
 }
 
-static int get_float(float *val, const char *arg)
-{
-	float res;
-	char *ptr;
-
-	if (!arg || !*arg)
-		return -1;
-	res = strtof(arg, &ptr);
-	if (!ptr || ptr == arg || *ptr)
-		return -1;
-	*val = res;
-	return 0;
-}
-
 static void set_ctrlmode(char *name, char *arg,
 			 struct can_ctrlmode *cm, __u32 flags)
 {
diff --git a/lib/utils.c b/lib/utils.c
index 706e93c3..dd242d4d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -220,6 +220,36 @@ int get_unsigned(unsigned int *val, const char *arg, int base)
 	return 0;
 }
 
+int get_float(float *val, const char *arg)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	*val = res;
+	return 0;
+}
+
+int get_float_min_max(float *val, const char *arg, float min, float max)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	if (res < min || res > max)
+		return -1;
+	*val = res;
+	return 0;
+}
+
 /*
  * get_time_rtt is "translated" from a similar routine "get_time" in
  * tc_util.c.  We don't use the exact same routine because tc passes
diff --git a/man/man8/tc-dualpi2.8 b/man/man8/tc-dualpi2.8
new file mode 100644
index 00000000..f303ee5d
--- /dev/null
+++ b/man/man8/tc-dualpi2.8
@@ -0,0 +1,249 @@
+.TH DUALPI2 8 "29 Oct 2024" "iproute2" "Linux"
+
+.SH NAME
+DUALPI2 \- Dual Queue Proportional Integral Controller AQM - Improved with a square
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.BR tc " " qdisc " ... " dualpi2
+.br
+.RB "[ " limit
+.IR PACKETS " ]"
+.br
+.RB "[ " memlimit
+.IR BYTES " ]"
+.br
+.RB "[ " coupling_factor
+.IR NUMBER " ]"
+.br
+.RB "[ " step_thresh
+.IR TIME | PACKETS " ]"
+.br
+.RB "[ " min_qlen_step
+.IR PACKETS " ]"
+.br
+.RB "[ " drop_on_overload " | " overflow " ]"
+.br
+.RB "[ " drop_enqueue " | " drop_dequeue " ]"
+.br
+.RB "[ " l4s_ect " | " any_ect " ]"
+.br
+.RB "[ " classic_protection
+.IR PERCENTAGE " ] "
+.br
+.RB "[ " max_rtt
+.IR TIME
+.RB " [ " typical_rtt
+.IR TIME " ]] "
+.br
+.RB "[ " target
+.IR TIME " ]"
+.br
+.RB "[ " tupdate
+.IR TIME " ]"
+.br
+.RB "[ " alpha
+.IR float " ]"
+.br
+.RB "[ " beta
+.IR float " ] "
+.br
+.RB "[ " split_gso " | " no_split_gso " ]"
+
+.SH DESCRIPTION
+DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2 base-AQM. The PI2 AQM (details can be found in the paper cited below) is in turn both an extension and a simplification of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while being able to control scalable congestion controls like TCP-Prague. With PI2, both Reno/Cubic can be used in parallel with Prague, maintaining window fairness. DUALQ provides latency separation between low latency Prague flows and Reno/Cubic flows that need a bigger queue. The main design goals are:
+.PD 0
+.IP \(bu 4
+L4S - Low Loss, Low Latency and Scalable congestion control support
+.IP \(bu 4
+DualQ option to separate the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling
+.IP \(bu 4
+Configurable overload strategies
+.IP \(bu 4
+Use of sojourn time to reliably estimate queue delay
+.IP \(bu 4
+Simple implementation
+.IP \(bu 4
+Guaranteed stability and fast responsiveness
+
+.PP
+The detailed PI2 parameters (alpha, beta, and tupdate) of DualPI2 are hard to get right and typically give bad results if just tried or guessed. These parameters need to be calculated to a coherent set with a typical objective in mind. DualPI2 has a set of default parameters that can be used for the general Internet, where the maximum RTT is around 100ms and the typical RTT is around 15ms. It is highly recommended to use
+.I "" max_rtt
+and
+.I "" typical_rtt
+(or target) helper parameters if your deployment is deviating from the above objectives (e.g., in a data center). These helpers are used to provide the theoretically optimal PI2 parameters (alpha, beta, and tupdate) for those objectives, and that can be used as a basis for further finetuning, experimentation, and testing if desired.
+
+.SH ALGORITHM
+DUALPI2 is designed to provide low loss and low latency to L4S traffic, without harming classic traffic. Every update interval, a new internal base probability is calculated based on queue delay. The base probability is updated with a delta based on the difference between the current queue delay and the
+.I "" target
+delay, and the queue growth compared with the queuing delay during the previous
+.I "" tupdate
+interval. The integral gain factor
+.RB "" alpha
+is used to correct slowly enough any persistent standing queue error to the user specified target delay, while the proportional gain factor
+.RB "" beta
+is used to quickly compensate for queue changes (growth or shrink).
+
+The updated base probability is used as input to decide to mark and drop packets. DUALPI2 scales the calculated probability for each of the two queues accordingly. For the L-queue, the probability is multiplied by a
+.RB "" coupling_factor
+, while for the C-queue, it is squared to compensate the squareroot rate equation of Reno/Cubic. The ECT identifier (
+.RB "" l4s_ect | any_ect
+) is used to classify traffic into respective queues.
+
+If DUALPI2 AQM has detected overload (when excessive non-responsive traffic is sent), it can signal congestion solely using
+.RB "" drop
+, irrespective of the ECN field, or alternatively limit the drop probability and let the queue grow and eventually
+.RB "" overflow
+(like tail-drop).
+
+Additional details can be found in the RFC cited below.
+
+.SH PARAMETERS
+.TP
+.BI limit " PACKETS"
+Limit the number of packets that can be enqueued. Incoming packets are dropped when this limit is reached. This limit is common for the L-queue and C-queue. Defaults to
+.I 10000
+packets. This is about 125ms delay on a 1Gbps link.
+.PD
+.TP
+.BI memlimit " BYTES"
+Limit the amount of memory that can be used. Incoming packets are dropped when this memlimit is reached. This memlimit is common for the L-queue and C-queue. Defaults to
+.I 10000 * interface MTU bytes.
+.PD
+.TP
+.BI coupling_factor " NUMBER"
+Set the coupling rate factor between Classic and L4S. Defaults to
+.I 2
+.PD
+.TP
+.BI l4s_ect | any_ect
+Configures the ECT classifier. Packets whose ECT codepoint matches this are sent to the L-queue, where they receive a scalable marking. Defaults to
+.I l4s_ect
+, i.e., the L4S identifier ECT(1). Setting this to
+.I any_ect
+causes all packets whose ECN field is not zero to be sent to the L-queue. This enables it to be backward compatible with, e.g., DCTCP. Note DCTCP should only be used for intra-DC traffic with very low RTTs and AQM delay targets bigger than those RTTs, separated from Internet traffic (also if Prague compliant CC), as it does not support all Prague requirements that make sure that a congestion control can work well with the range of RTTs on the Internet.
+.PD
+.TP
+.BI step_thresh " TIME | PACKETS"
+Set the step threshold for the L-queue. This will cause packets with a sojourn time exceeding the threshold to always be marked. This value can either be specified using time units (i.e., us, ms, s), or in packets (p, pkt, packet(s)). A value without units is assumed to be in time (us). If defining the step in packets, be sure to disable GRO on the ingress interfaces. Defaults to
+.I 1ms
+.PD
+.TP
+.BI min_qlen_step " PACKETS"
+Incoming pacekts enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. Defaults to
+.I 0
+packets. This means that every enqueued packets to the L-queue with a sojourn time exceed the step thresohld will be marked.
+.PD
+.TP
+.B drop_on_overload  |  overflow
+Control the overload strategy.
+.I drop_on_overload
+preserves the delay in the L-queue by dropping in both queues on overload.
+.I overflow
+sacrifices delay to avoid losses, eventually resulting in a taildrop behavior once the
+.I limit
+is reached. Defaults to
+.I drop_on_overload
+.PD
+.TP
+.B drop_enqueue | drop_dequeue
+Decide when packets are PI-based dropped or marked. The
+.I step_thresh
+based L4S marking is always at dequeue. Defaults to
+.I drop_dequeue
+.PD
+.TP
+.BI classic_protection " PERCENTAGE
+Protects the C-queue from unresponsive traffic in the L-queue. This bounds the maximal scheduling delay in the C-queue to be
+.I (100 - PERCENTAGE)
+times greater than the one in the L-queue. Defaults to
+.I 10
+.TP
+.BI typical_rtt " TIME"
+.PD 0
+.TP
+.PD
+.BI max_rtt " TIME"
+Specify the maximum round trip time (RTT) and/or the typical RTT of the traffic that will be controlled by DUALPI2. These values are specified using time units (i.e., us, ms, s). A value without units is assumed to be in us. If either
+.I max_rtt
+or
+.I typical_rtt
+is not specified, the missing value will be computed from the following relationship:
+.I max_rtt = typical_rtt * 6.
+If any of these parameters is given, it will be used to automatically compute suitable values for
+.I alpha, beta, target, and tupdate,
+according to the relationship from the appendix A.1 in the IETF RFC cited below, to achieve a stable control. Consequently, those derived values will override their eventual user-provided ones. The default range of operation for the qdisc uses
+.I max_rtt = 100ms
+and
+.I typical_rtt = 15ms
+, which is suited to controlling Internet traffic.
+.TP
+.BI target " TIME"
+Set the expected queue delay. Defaults to
+.I 15
+ms. A value without units is assumed to be in us.
+.TP
+.BI tupdate " TIME"
+Set the frequency at which the system drop probability is calculated. Defaults to
+.I 16
+ms. A value without units is assumed to be in us. This should be less than a third of the max RTT supported.
+.TP
+.BI alpha " float"
+.PD 0
+.TP
+.PD
+.BI beta " float"
+Set alpha and beta, the integral and proportional gain factors in Hz for the PI controller. These can be calculated based on control theory. Defaults are
+.I 0.16
+and
+.I 3.2
+Hz, which provide stable control for RTT's up to 100ms with tupdate of 16ms. Be aware, unlike with PIE, these are the real unscaled gain factors. If not provided, they will be automatically derived from
+.I typical_rtt and max_rtt
+, if one of them or both are provided.
+.PD
+.TP
+.B split_gso | no_split_gso
+Decide how to handle aggregated packets. Either treat the aggregate as a single packet (thus all share fate with respect to marks and drops) with
+.I no_split_gso
+, trading some tail latency for CPU usage, or treat each packet individually (i.e., split them) with
+.I split_gso
+to finely mark/drop and control queueing latencies. Defaults to
+.I split_gso
+
+.SH EXAMPLES
+Setting DUALPI2 for the Internet with default parameters:
+ # sudo tc qdisc add dev eth0 root dualpi2
+
+Setting DUALPI2 for datacenter with legacy DCTCP using ECT(0):
+ # sudo tc qdisc add dev eth0 root dualpi2 any_ect
+
+.SH FILTERS
+This qdisc can be used in conjunction with tc-filters. More precisely, it will honor filters "stealing packets", as well as accept other classification schemes.
+.BR
+.TP
+Packets whose priority/classid are set to
+.I 1
+will be enqueued in the L-queue, alongside L4S traffic, and thus subject to the increased marking probability (or drops if they are marked not-ECT).
+.BR
+.TP
+Packets whose priority/classid are set to
+.I 2
+will also be enqueued in the L-queue, but will never be dropped if they are not-ECT (unless the qdisc is full and thus resorts to taildrop).
+.BR
+.TP
+Finally, all the other classid/priority map to the C-queue.
+
+.SH SEE ALSO
+.BR tc (8),
+.BR tc-pie (8)
+
+.SH SOURCES
+.IP \(bu 4
+IETF RFC9332 : https://datatracker.ietf.org/doc/html/rfc9332
+.IP \(bu 4
+CoNEXT '16 Proceedings of the 12th International on Conference on emerging Networking EXperiments and Technologies : "PI2: A Linearized AQM for both Classic and Scalable TCP"
+
+.SH AUTHORS
+DUALPI2 was implemented by Koen De Schepper, Olga Albisser, Henrik Steen, Olivier Tilmans, and Chia-Yu Chang, also the authors of this man page. Please report bugs and corrections to the Linux networking development mailing list at <netdev@vger.kernel.org>.
diff --git a/tc/Makefile b/tc/Makefile
index b5e853d8..6264a772 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -9,6 +9,7 @@ SHARED_LIBS ?= y
 
 TCMODULES :=
 TCMODULES += q_fifo.o
+TCMODULES += q_dualpi2.o
 TCMODULES += q_sfq.o
 TCMODULES += q_red.o
 TCMODULES += q_prio.o
diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c
new file mode 100644
index 00000000..ea5abd9c
--- /dev/null
+++ b/tc/q_dualpi2.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Olga Albisser <olga@albisser.org>
+ * Author: Henrik Steen <henrist@henrist.net>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ *
+ * DualPI Improved with a Square (dualpi2):
+ * - Supports congestion controls that comply with the Prague requirements
+ *   in RFC9331 (e.g. TCP-Prague)
+ * - Supports coupled dual-queue with PI2 as defined in RFC9332
+ * - Supports ECN L4S-identifier (IP.ECN==0b*1)
+ *
+ * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
+ *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
+ *   Section 4, so they can only be used with DualPI2 in a datacenter
+ *   context.
+ *
+ * References:
+ * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
+ * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
+ *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <syslog.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
+#include <math.h>
+#include <errno.h>
+
+#include "utils.h"
+#include "tc_util.h"
+
+#define MAX_PROB ((uint32_t)(~0U))
+#define DEFAULT_ALPHA_BETA ((uint32_t)(~0U))
+#define ALPHA_BETA_MAX ((2 << 23) - 1) /* see net/sched/sch_dualpi2.c */
+#define ALPHA_BETA_SCALE (1 << 8)
+#define RTT_TYP_TO_MAX 6
+
+enum {
+	INET_ECN_NOT_ECT = 0,
+	INET_ECN_ECT_1 = 1,
+	INET_ECN_ECT_0 = 2,
+	INET_ECN_CE = 3,
+	INET_ECN_MASK = 3,
+};
+
+static const char *get_credit_queue(int credit)
+{
+	return credit > 0 ? "C-queue" : "L-queue";
+}
+
+static const char *get_ecn_type(uint8_t ect)
+{
+	switch (ect & INET_ECN_MASK) {
+	case INET_ECN_ECT_1: return "l4s_ect";
+	case INET_ECN_ECT_0:
+	case INET_ECN_MASK: return "any_ect";
+	default:
+		fprintf(stderr,
+			"Warning: Unexpected ecn type %u!\n", ect);
+		return "";
+	}
+}
+
+static void explain(void)
+{
+	fprintf(stderr, "Usage: ... dualpi2\n");
+	fprintf(stderr, "               [limit PACKETS]\n");
+	fprintf(stderr, "               [memlimit BYTES]\n");
+	fprintf(stderr, "               [coupling_factor NUMBER]\n");
+	fprintf(stderr, "               [step_thresh TIME|PACKETS]\n");
+	fprintf(stderr, "               [min_qlen_step PACKETS]\n");
+	fprintf(stderr, "               [drop_on_overload|overflow]\n");
+	fprintf(stderr, "               [drop_enqueue|drop_dequeue]\n");
+	fprintf(stderr, "               [classic_protection PERCENTAGE]\n");
+	fprintf(stderr, "               [max_rtt TIME [typical_rtt TIME]]\n");
+	fprintf(stderr, "               [target TIME] [tupdate TIME]\n");
+	fprintf(stderr, "               [alpha ALPHA] [beta BETA]\n");
+	fprintf(stderr, "               [split_gso|no_split_gso]\n");
+}
+
+static int get_packets(uint32_t *val, const char *arg)
+{
+	unsigned long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtoul(arg, &ptr, 10);
+	if (!ptr || ptr == arg ||
+	    !(matches(ptr, "pkts") == 0 || matches(ptr, "packets") == 0))
+		return -1;
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+	if (res > 0xFFFFFFFFUL)
+		return -1;
+	*val = res;
+	return 0;
+}
+
+static int parse_alpha_beta(const char *name, char *argv, uint32_t *field)
+{
+
+	float field_f;
+
+	if (get_float_min_max(&field_f, argv, 0.0, ALPHA_BETA_MAX)) {
+		fprintf(stderr, "Illegal \"%s\"\n", name);
+		return -1;
+	} else if (field_f < 1.0f / ALPHA_BETA_SCALE)
+		fprintf(stderr,
+			"Warning: \"%s\" is too small and will be rounded to zero.\n",
+			name);
+	*field = (uint32_t)(field_f * ALPHA_BETA_SCALE);
+	return 0;
+}
+
+static int try_get_percent(int *val, const char *arg)
+{
+	double per;
+
+	if (parse_percent(&per, arg))
+		return -1;
+
+	*val = rint(per * 100);
+	return 0;
+}
+
+static int dualpi2_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+			     struct nlmsghdr *n, const char *dev)
+{
+	uint32_t limit = 0;
+	uint32_t memory_limit = 0;
+	uint32_t target = 0;
+	uint32_t tupdate = 0;
+	uint32_t alpha = DEFAULT_ALPHA_BETA;
+	uint32_t beta = DEFAULT_ALPHA_BETA;
+	int32_t coupling_factor = -1;
+	uint8_t ecn_mask = INET_ECN_NOT_ECT;
+	bool step_packets = false;
+	uint32_t step_thresh = 0;
+	int32_t min_qlen_step =  -1;
+	int c_protection = -1;
+	int drop_early = -1;
+	int drop_overload = -1;
+	int split_gso = -1;
+	uint32_t rtt_max = 0;
+	uint32_t rtt_typ = 0;
+	struct rtattr *tail;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "limit") == 0) {
+			NEXT_ARG();
+			if (get_u32(&limit, *argv, 10)) {
+				fprintf(stderr, "Illegal \"limit\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "memlimit") == 0) {
+			NEXT_ARG();
+			if (get_u32(&memory_limit, *argv, 10)) {
+				fprintf(stderr, "Illegal \"memlimit\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "target") == 0) {
+			NEXT_ARG();
+			if (get_time(&target, *argv)) {
+				fprintf(stderr, "Illegal \"target\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "tupdate") == 0) {
+			NEXT_ARG();
+			if (get_time(&tupdate, *argv)) {
+				fprintf(stderr, "Illegal \"tupdate\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "alpha") == 0) {
+			NEXT_ARG();
+			if (parse_alpha_beta("alpha", *argv, &alpha))
+				return -1;
+		} else if (strcmp(*argv, "beta") == 0) {
+			NEXT_ARG();
+			if (parse_alpha_beta("beta", *argv, &beta))
+				return -1;
+		} else if (strcmp(*argv, "coupling_factor") == 0) {
+			NEXT_ARG();
+			if (get_s32(&coupling_factor, *argv, 0) ||
+			    coupling_factor > 0xFFUL || coupling_factor < 0) {
+				fprintf(stderr,
+					"Illegal \"coupling_factor\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "l4s_ect") == 0)
+			ecn_mask = INET_ECN_ECT_1;
+		else if (strcmp(*argv, "any_ect") == 0)
+			ecn_mask = INET_ECN_MASK;
+		else if (strcmp(*argv, "step_thresh") == 0) {
+			NEXT_ARG();
+			/* First assume that this is specified in time */
+			if (get_time(&step_thresh, *argv)) {
+				/* Then packets */
+				if (get_packets(&step_thresh, *argv)) {
+					fprintf(stderr,
+						"Illegal \"step_thresh\"\n");
+					return -1;
+				}
+				step_packets = true;
+			}
+		} else if (strcmp(*argv, "min_qlen_step") == 0) {
+			NEXT_ARG();
+			if (get_u32(&min_qlen_step, *argv, 10)) {
+				fprintf(stderr, "Illegal \"min_qlen_step\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "overflow") == 0) {
+			drop_overload = 0;
+		} else if (strcmp(*argv, "drop_on_overload") == 0) {
+			drop_overload = 1;
+		} else if (strcmp(*argv, "drop_enqueue") == 0) {
+			drop_early = 1;
+		} else if (strcmp(*argv, "drop_dequeue") == 0) {
+			drop_early = 0;
+		} else if (strcmp(*argv, "split_gso") == 0) {
+			split_gso = 1;
+		} else if (strcmp(*argv, "no_split_gso") == 0) {
+			split_gso = 0;
+		} else if (strcmp(*argv, "classic_protection") == 0) {
+			NEXT_ARG();
+			if (try_get_percent(&c_protection, *argv) ||
+			    c_protection > 100 ||
+			    c_protection < 0) {
+				fprintf(stderr,
+					"Illegal \"classic_protection\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "max_rtt") == 0) {
+			NEXT_ARG();
+			if (get_time(&rtt_max, *argv)) {
+				fprintf(stderr, "Illegal \"rtt_max\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "typical_rtt") == 0) {
+			NEXT_ARG();
+			if (get_time(&rtt_typ, *argv)) {
+				fprintf(stderr, "Illegal \"rtt_typ\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "help") == 0) {
+			explain();
+			return -1;
+		} else {
+			fprintf(stderr, "What is \"%s\"?\n", *argv);
+			explain();
+			return -1;
+		}
+		--argc;
+		++argv;
+	}
+
+	if (rtt_max || rtt_typ) {
+		double alpha_f, beta_f;
+
+		SPRINT_BUF(max_rtt_t);
+		SPRINT_BUF(typ_rtt_t);
+		SPRINT_BUF(tupdate_t);
+		SPRINT_BUF(target_t);
+
+		if (!rtt_typ)
+			rtt_typ = max(rtt_max / RTT_TYP_TO_MAX, 1U);
+		else if (!rtt_max)
+			rtt_max = rtt_typ * RTT_TYP_TO_MAX;
+		else if (rtt_typ > rtt_max) {
+			fprintf(stderr, "typical_rtt must be <= max_rtt!\n");
+			return -1;
+		}
+		if (alpha != DEFAULT_ALPHA_BETA || beta != DEFAULT_ALPHA_BETA ||
+		    tupdate || target)
+			fprintf(stderr,
+				"rtt_max is specified, ignore alpha/beta/tupdate/target\n");
+		target = rtt_typ;
+		tupdate = (double)rtt_typ < (double)rtt_max / 3.0f ?
+			rtt_typ : (double)rtt_max / 3.0f;
+		tupdate = max(tupdate, 1U);
+		alpha_f = (double)tupdate / rtt_max / rtt_max
+			* TIME_UNITS_PER_SEC * 0.1f;
+		beta_f = 0.3f / (double)rtt_max * TIME_UNITS_PER_SEC;
+		if (beta_f > ALPHA_BETA_MAX) {
+			fprintf(stderr,
+				"max_rtt=%s is too low and cause beta to overflow!\n",
+				sprint_time(rtt_max, max_rtt_t));
+			return -1;
+		}
+		if (alpha_f < 1.0f / ALPHA_BETA_SCALE ||
+		    beta_f < 1.0f / ALPHA_BETA_SCALE) {
+			fprintf(stderr,
+				"Large max_rtt=%s rounds down alpha=%f and/or beta=%f!\n",
+				sprint_time(rtt_max, max_rtt_t),
+				alpha_f, beta_f);
+			return -1;
+		}
+		fprintf(stderr,
+			"Auto-config [max_rtt: %s, typical_rtt: %s]: target=%s tupdate=%s alpha=%f beta=%f\n",
+			sprint_time(rtt_max, max_rtt_t),
+			sprint_time(rtt_typ, typ_rtt_t),
+			sprint_time(target, target_t),
+			sprint_time(tupdate, tupdate_t), alpha_f, beta_f);
+		alpha = alpha_f * ALPHA_BETA_SCALE;
+		beta = beta_f * ALPHA_BETA_SCALE;
+	}
+
+	tail = addattr_nest(n, 1024, TCA_OPTIONS | NLA_F_NESTED);
+	if (limit)
+		addattr32(n, 1024, TCA_DUALPI2_LIMIT, limit);
+	if (memory_limit)
+		addattr32(n, 1024, TCA_DUALPI2_MEMORY_LIMIT, memory_limit);
+	if (tupdate)
+		addattr32(n, 1024, TCA_DUALPI2_TUPDATE, tupdate);
+	if (target)
+		addattr32(n, 1024, TCA_DUALPI2_TARGET, target);
+	if (alpha != DEFAULT_ALPHA_BETA)
+		addattr32(n, 1024, TCA_DUALPI2_ALPHA, alpha);
+	if (beta != DEFAULT_ALPHA_BETA)
+		addattr32(n, 1024, TCA_DUALPI2_BETA, beta);
+	if (ecn_mask != INET_ECN_NOT_ECT)
+		addattr8(n, 1024, TCA_DUALPI2_ECN_MASK, ecn_mask);
+	if (drop_overload != -1)
+		addattr8(n, 1024, TCA_DUALPI2_DROP_OVERLOAD, drop_overload);
+	if (coupling_factor != -1)
+		addattr8(n, 1024, TCA_DUALPI2_COUPLING, coupling_factor);
+	if (split_gso != -1)
+		addattr8(n, 1024, TCA_DUALPI2_SPLIT_GSO, split_gso);
+	if (step_thresh) {
+		addattr32(n, 1024, TCA_DUALPI2_STEP_THRESH, step_thresh);
+		addattr8(n, 1024, TCA_DUALPI2_STEP_PACKETS, step_packets);
+	}
+	if (min_qlen_step != -1)
+		addattr32(n, 1024, TCA_DUALPI2_MIN_QLEN_STEP, min_qlen_step);
+	if (drop_early != -1)
+		addattr8(n, 1024, TCA_DUALPI2_DROP_EARLY, drop_early);
+	if (c_protection != -1)
+		addattr8(n, 1024, TCA_DUALPI2_C_PROTECTION, c_protection);
+	addattr_nest_end(n, tail);
+	return 0;
+}
+
+static float get_scaled_alpha_beta(struct rtattr *tb)
+{
+	if (tb == NULL)
+		return 0;
+
+	if (RTA_PAYLOAD(tb) < sizeof(__u32))
+		return -1;
+
+	return ((float)rta_getattr_u32(tb)) / ALPHA_BETA_SCALE;
+}
+
+static int dualpi2_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+{
+	struct rtattr *tb[TCA_DUALPI2_MAX + 1];
+	uint32_t tupdate;
+	uint32_t target;
+	uint8_t ecn_type;
+	uint8_t drop_overload;
+	uint32_t step_thresh;
+	uint8_t drop_early;
+	uint8_t split_gso;
+	bool step_packets = false;
+
+	SPRINT_BUF(b1);
+
+	if (opt == NULL)
+		return 0;
+
+	parse_rtattr_nested(tb, TCA_DUALPI2_MAX, opt);
+
+	if (tb[TCA_DUALPI2_LIMIT] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_LIMIT]) >= sizeof(__u32))
+		print_uint(PRINT_ANY, "limit", "limit %up ",
+			   rta_getattr_u32(tb[TCA_DUALPI2_LIMIT]));
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_MEMORY_LIMIT]) >= sizeof(__u32))
+		print_uint(PRINT_ANY, "memlimit", "memlimit %uB ",
+			   rta_getattr_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
+	if (tb[TCA_DUALPI2_TARGET] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_TARGET]) >= sizeof(__u32)) {
+		target = rta_getattr_u32(tb[TCA_DUALPI2_TARGET]);
+		print_uint(PRINT_JSON, "target", NULL, target);
+		print_string(PRINT_FP, NULL, "target %s ",
+			     sprint_time(target, b1));
+	}
+	if (tb[TCA_DUALPI2_TUPDATE] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_TUPDATE]) >= sizeof(__u32)) {
+		tupdate = rta_getattr_u32(tb[TCA_DUALPI2_TUPDATE]);
+		print_uint(PRINT_JSON, "tupdate", NULL, tupdate);
+		print_string(PRINT_FP, NULL, "tupdate %s ",
+			     sprint_time(tupdate, b1));
+	}
+	if (tb[TCA_DUALPI2_ALPHA] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_ALPHA]) >= sizeof(__u32))
+		print_float(PRINT_ANY, "alpha", "alpha %f ",
+			    get_scaled_alpha_beta(tb[TCA_DUALPI2_ALPHA]));
+	if (tb[TCA_DUALPI2_BETA] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_BETA]) >= sizeof(__u32))
+		print_float(PRINT_ANY, "beta", "beta %f ",
+			    get_scaled_alpha_beta(tb[TCA_DUALPI2_BETA]));
+	if (tb[TCA_DUALPI2_ECN_MASK] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_ECN_MASK]) >= sizeof(__u8)) {
+		ecn_type = rta_getattr_u8(tb[TCA_DUALPI2_ECN_MASK]);
+		print_uint(PRINT_JSON, "ecn_type", NULL, ecn_type);
+		print_string(PRINT_FP, NULL, "%s ",
+			     get_ecn_type(ecn_type));
+	}
+	if (tb[TCA_DUALPI2_COUPLING] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_COUPLING]) >= sizeof(__u8))
+		print_uint(PRINT_ANY, "coupling_factor", "coupling_factor %u ",
+			   rta_getattr_u8(tb[TCA_DUALPI2_COUPLING]));
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_OVERLOAD]) >= sizeof(__u8)) {
+		drop_overload = rta_getattr_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     drop_overload ? "drop_on_overload" : "overflow");
+		print_bool(PRINT_JSON, "drop_on_overload", NULL,
+			   !!drop_overload);
+	}
+	if (tb[TCA_DUALPI2_STEP_PACKETS] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_PACKETS]) >= sizeof(__u8) &&
+	    rta_getattr_u8(tb[TCA_DUALPI2_STEP_PACKETS]))
+		step_packets = true;
+	if (tb[TCA_DUALPI2_STEP_THRESH] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_THRESH]) >= sizeof(__u32)) {
+		step_thresh = rta_getattr_u32(tb[TCA_DUALPI2_STEP_THRESH]);
+		if (step_packets) {
+			print_uint(PRINT_ANY, "step_thresh",
+				   "step_thresh %up ", step_thresh);
+		} else {
+			print_uint(PRINT_JSON, "step_thresh", NULL,
+				   step_thresh);
+			print_string(PRINT_FP, NULL, "step_thresh %s ",
+				     sprint_time(step_thresh, b1));
+		}
+	}
+	if (tb[TCA_DUALPI2_MIN_QLEN_STEP] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_MIN_QLEN_STEP]) >= sizeof(__u32))
+		print_uint(PRINT_ANY, "min_qlen_step", "min_qlen_step %up ",
+			   rta_getattr_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
+	if (tb[TCA_DUALPI2_DROP_EARLY] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_EARLY]) >= sizeof(__u8)) {
+		drop_early = rta_getattr_u8(tb[TCA_DUALPI2_DROP_EARLY]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     drop_early ? "drop_enqueue" : "drop_dequeue");
+		print_bool(PRINT_JSON, "drop_early", NULL, !!drop_early);
+	}
+	if (tb[TCA_DUALPI2_SPLIT_GSO] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_SPLIT_GSO]) >= sizeof(__u8)) {
+		split_gso = rta_getattr_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
+		print_string(PRINT_FP, NULL, "%ssplit_gso ", split_gso ? "" : "no_");
+		print_bool(PRINT_JSON, "split_gso", NULL, !!split_gso);
+	}
+	if (tb[TCA_DUALPI2_C_PROTECTION] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_C_PROTECTION]) >= sizeof(__u8))
+		print_uint(PRINT_ANY, "classic_protection",
+			   "classic_protection %u%% ",
+			   rta_getattr_u8(tb[TCA_DUALPI2_C_PROTECTION]));
+
+	return 0;
+}
+
+static int dualpi2_print_xstats(struct qdisc_util *qu, FILE *f,
+			    struct rtattr *xstats)
+{
+	struct tc_dualpi2_xstats *st;
+
+	if (xstats == NULL)
+		return 0;
+
+	if (RTA_PAYLOAD(xstats) < sizeof(*st))
+		return -1;
+
+	st = RTA_DATA(xstats);
+	print_float(PRINT_ANY, "prob", "prob %f ", (double)st->prob / (double)MAX_PROB);
+	print_uint(PRINT_ANY, "delay_c", "delay_c %uus ", st->delay_c);
+	print_uint(PRINT_ANY, "delay_l", "delay_l %uus", st->delay_l);
+	print_nl();
+
+	print_uint(PRINT_ANY, "pkts_in_c", "pkts_in_c %u ", st->packets_in_c);
+	print_uint(PRINT_ANY, "pkts_in_l", "pkts_in_l %u ", st->packets_in_l);
+	print_uint(PRINT_ANY, "max_q", "max_q %u", st->maxq);
+	print_nl();
+
+	print_uint(PRINT_ANY, "ecn_mark", "ecn_mark %u ", st->ecn_mark);
+	print_uint(PRINT_ANY, "step_mark", "step_mark %u", st->step_marks);
+	print_nl();
+
+	print_int(PRINT_ANY, "credit", "credit %d ", st->credit);
+	print_string(PRINT_ANY, "credit queue", "(%s)", get_credit_queue(st->credit));
+	print_nl();
+
+	print_uint(PRINT_ANY, "memory_used", "memory_used %u ", st->memory_used);
+	print_uint(PRINT_ANY, "max_memory_used", "(max %u) ", st->max_memory_used);
+	print_uint(PRINT_ANY, "memory_limit", "of memory limit %u", st->memory_limit);
+	print_nl();
+
+	return 0;
+
+}
+
+struct qdisc_util dualpi2_qdisc_util = {
+	.id		= "dualpi2",
+	.parse_qopt	= dualpi2_parse_opt,
+	.print_qopt	= dualpi2_print_opt,
+	.print_xstats	= dualpi2_print_xstats,
+};
-- 
2.34.1


