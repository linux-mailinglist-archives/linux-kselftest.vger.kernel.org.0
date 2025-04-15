Return-Path: <linux-kselftest+bounces-30867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87623A89E6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8918190296E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811D2951C5;
	Tue, 15 Apr 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="giDmx10z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA2291160;
	Tue, 15 Apr 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721052; cv=fail; b=DT6kTw12tD/E7N3yBDtqEfh1lzo84+/Vfs9xTRH2DeyBUXUmiGvaUjng+Hj1hxzaTBZ+ScbcV8dcYL9qejKQ3oMet03Ma2w2Xi7acpuzf0wzbun9WfFCfQe1xUCiWfEoQDAQEW9YPF6UROREcN4sfir2jZtLZ4M68O2kxJuHZak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721052; c=relaxed/simple;
	bh=J3gghKMCAQYb6X22VHtQEYa1bUEVPr6Qr/EONqACy7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcSct0g1dz6VHCDB1/G78pjlj2z0q5GkD8nCGgeUObLMdjDRWgEl2ptAA5sV+4GWbhaB3HlZNDEPho+KELmeA+ScU6nlgbUhqolwUGRTQjRqCT2UvQr2rq4VDRf3c+Hu8X1QmIMdGqsO/R3j+eSmpw0tJVSlbzETseEB7nUTvaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=giDmx10z; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLoVN4e72qHiJpLWK97giIZlk2hcyhID0GsmUtq9ZO/QtKyg5YSyMw5gyuVtDEXh6FpUDgBzOUv+TH0hFyt3ZWgCqdTgdvWZbVekBATzPR47ASlaOUjFFWpHUrl4ud1iUstL7/X57uqWub4nXm3nIKMHXcVj0EYYMu8iblUOl8xAYkeG0N3D2XKP2LlFYqBUWwMHSruVU0PC28IEuSr+pWo/UkAuLnwCO5gz1bdu5UkpFmNLWLT4WPGxpCdOV58IDxGKg7Vns4h8FZKazxA/h1ufkJUoeu8Z6MjpIPpemiXg+3SD67V0Aa7/MBSDKooSSeNPEIGY8/yK7bse4kBaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr0WVWpJ9qsK9Ltohw5GCNG/Q6S00o1y4G+EOv4qSBk=;
 b=dn9Oo0yNz41WkERBNOMspwRd3ieVhKE7IfKwTpGIBlV9wS8gvVW5pLP5k3W9Td4PNDBc/vT2eJ6oI4uSxyHH/klZ0mUVVK3UVqhyl1wD8pGDO8HGYLEjfWJb/Fv+DuQPTwm+CQoyFsxG828A0/JPcw7cW+vuG45cfFn0wiAOIY3jozsF/6DTXXBocry+4L/jNu7sZOQ1VM9qCE1yD2dm7XWQFTpDpbz34ZymE11Prn5HPmIYWXldEa+T7W7wV3RFQGWqWciXL+8TSU+/ljNVYPweIe7OoN5f0HAfm3VJ/o7EvX9mgIr0uM8fvr+izdD82SxLr8VepCVjIp8Lr+86zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr0WVWpJ9qsK9Ltohw5GCNG/Q6S00o1y4G+EOv4qSBk=;
 b=giDmx10zj6/qLul+Gtbb2+iCDoS6hGLoyG7qdd8jFQSdHRL75jt4qPh3bti8CgLkDz0w53y2aV5aUOFbW1gY20AEQFeyhKrFm+1c7tQ1ak9IhWX4Hs2mnNhUSrf9M5sf4GQC/4vDK0vL50Is5Wr0Zex06UoHB68QB1BVLRtSRhnZQKf9kCvRosd8R/x6zpTlxSEyRv9HYBSkmwSk54uY9azUlgc9jp5lriyo8yenaJU/6uoV6an0DS341UknjTVIDPGVlUXSyyMZvIHsS51+BnUul5CbDVw/lstZqsZeTFF6VORPncd9AcwNyNPOErMJsPNPasKr7AnPWSQIsVCwdQ==
Received: from AM8P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::8)
 by AM7PR07MB6421.eurprd07.prod.outlook.com (2603:10a6:20b:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:44:03 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::9b) by AM8P190CA0003.outlook.office365.com
 (2603:10a6:20b:219::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 12:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:44:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53FChgEh013987;
	Tue, 15 Apr 2025 12:44:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v11 net-next 4/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Tue, 15 Apr 2025 14:43:16 +0200
Message-Id: <20250415124317.11561-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AM7PR07MB6421:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 316a20e9-06bd-4c09-a0d6-08dd7c1b33a6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?R1vmYcF8lMomvRACZUAKNwZwBb8YQU4OgsJmOETDG9u3VreTgHhslVgo5M6j?=
 =?us-ascii?Q?nGW+KO77nHF0H/2t4XO22JvQsfWGA0qg8U8NJbpwIWYhIipOcipNBiAgtz5d?=
 =?us-ascii?Q?DhFFIiDQiXUBggfqYW1/aYKShhoAr08Xf7/3XDomd/j/LVFjsmZKedIQDnpW?=
 =?us-ascii?Q?LQ1NhnAQqWKKuVColdrBhyRYqs1tikFbrocbsoTlc2lzmDL90DEDdcWNwZjO?=
 =?us-ascii?Q?zteQC0+2P9sYJSYQoddJmrGr+IBUIL0yHz0Ri9l4/XPTG8odoKbGjy1XDm31?=
 =?us-ascii?Q?9Stnm9LSb1JcQEf/qz780ha+NpzZJVG+QQ0rwxICAd983m1qaRZ4Auc0EiTH?=
 =?us-ascii?Q?M74CfN1SpsAuMSfKi0yakKRqTqfbwMpx3V1sanE50HuyhSoRJgQN030sIgaQ?=
 =?us-ascii?Q?m3w3OnIMJu9b2WQzvUmkK8KQkd5LK4w7iJAAJvTIWbJpP7BwVlF+PsX7k1kX?=
 =?us-ascii?Q?ZIu2RoPOcvk7J+zoOWsLHEfnLZv9QcsXV9iBjUiltKVeK+qnP27qTt/MscPs?=
 =?us-ascii?Q?N0i1c7gWeUses/7WusiKtkJ65y89nSS2a7Tlo/YmZru1kR8MzeCrwtUzdbpz?=
 =?us-ascii?Q?J3kVtBN+vZz7YmqoXtKCZJN9rGkBG6/J7sCMFpDsYLt5dAO6CvTZouQ6rilG?=
 =?us-ascii?Q?HHLnOVTzKBDcbt+4HSZcMBNPacPvf8N+s/IMMxuqeGFYpSU2LYm6EEHC7HAk?=
 =?us-ascii?Q?y269O2VnotGQuwlo3jjyXdZiH7u39HSQW14E9PDSJ1oCRLekP28fO0NgjqP/?=
 =?us-ascii?Q?M7TVsKAHTfnvQDRQ0TtPhBfAvKY0rXpgBUKrgFEAhNAeGuhkGqdkf+bRQcT5?=
 =?us-ascii?Q?4D4D/9ow1ef78R/JW6/vXeOzUopyVlex8LQNLKA08tzwaQI4+TBp/5jLhEGZ?=
 =?us-ascii?Q?qCQqIPw6xza4wGe8BNOTW9haILbCncWNqJEZdD66Cd3JG9yb4pturptnaiVo?=
 =?us-ascii?Q?iYpBVGZ3S5ab3lufebcKemLRia1mTQr/qJnwFoYKq/LuEgZNHYGaKtZmWaEY?=
 =?us-ascii?Q?HfB7vMA0UbT1/LhZns6Fr5hCajxFhY43C0mTGBzB8bHSGHd9DawVQWHEd9Qf?=
 =?us-ascii?Q?X9NuG/bo6c3NTihcZuajh4eLSALX94Pu/hqxv/HZh+pVzJwjbSGovRAZLcrT?=
 =?us-ascii?Q?QF21RERz3lxgMIZGARSzv9PIl54/c6EPeVr/acPnBY0rO+I5Hvk59fKXu0vB?=
 =?us-ascii?Q?uoY40nF0+8RQYxWVP2g340qSpN5Pzf2Q+iTyXnWh2lLHsdlCTtNDjvmeKFAd?=
 =?us-ascii?Q?3tLqgvrbYWnB7+kqwJ7O6N2H5kViqm/ISokXHB/YtgoUIYSpnxJE6Kr3Wxdw?=
 =?us-ascii?Q?PdtW9b/BZr7+1woEwSH1CGZBZeM1mvz7ssT8+vHLpqf1WjV65HfVnzVjmRQM?=
 =?us-ascii?Q?kPUQJ6sm5zi6ZKErjaTnXYb1BNYBdMAzLN0fwUZgu/GXDQBCLXYQqi0WFzub?=
 =?us-ascii?Q?xmRr9vevz1dCY9fqdSM/dbTbpV16pO6MS3FN5ReFoau+OC2npRL8NAUGAI9C?=
 =?us-ascii?Q?4HKFN6PTqXKjJ76GdUKMg3m75+bOgflYWsH+Kr/f2gCSoMoijuBR9dp3BQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:44:02.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316a20e9-06bd-4c09-a0d6-08dd7c1b33a6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6421

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/uapi/linux/pkt_sched.h | 15 ++++++
 net/sched/sch_dualpi2.c        | 86 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index fd5bec118cdc..62fec34c1005 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1234,4 +1234,19 @@ enum {
 
 #define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
 
+struct tc_dualpi2_xstats {
+	__u32 prob;		/* current probability */
+	__u32 delay_c;		/* current delay in C queue */
+	__u32 delay_l;		/* current delay in L queue */
+	__s32 credit;		/* current c_protection credit */
+	__u32 packets_in_c;	/* number of packets enqueued in C queue */
+	__u32 packets_in_l;	/* number of packets enqueued in L queue */
+	__u32 maxq;		/* maximum queue size */
+	__u32 ecn_mark;		/* packets marked with ecn*/
+	__u32 step_marks;	/* ECN marks due to the step AQM */
+	__u32 memory_used;	/* Meory used of both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 3f91f6b1db2f..78027d6ce917 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -126,6 +126,14 @@ static u32 dualpi2_scale_alpha_beta(u32 param)
 	return tmp;
 }
 
+static u32 dualpi2_unscale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
+
+	do_div(tmp, MAX_PROB);
+	return tmp;
+}
+
 static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
 {
 	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
@@ -421,6 +429,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	return ns;
+}
+
+static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MEMORY_LIMIT,
+			READ_ONCE(q->memory_limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
+			convert_ns_to_usec(READ_ONCE(q->pi2.target))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
+			convert_ns_to_usec(READ_ONCE(q->pi2.tupdate))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.alpha))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_BETA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.beta))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
+			READ_ONCE(q->step.in_packets) ?
+			READ_ONCE(q->step.thresh) :
+			convert_ns_to_usec(READ_ONCE(q->step.thresh))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS,
+		       READ_ONCE(q->step.in_packets)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection.wc)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso)))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	nla_nest_cancel(skb, opts);
+	return -1;
+}
+
+static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct tc_dualpi2_xstats st = {
+		.prob			= READ_ONCE(q->pi2.prob),
+		.packets_in_c		= q->packets_in_c,
+		.packets_in_l		= q->packets_in_l,
+		.maxq			= q->maxq,
+		.ecn_mark		= q->ecn_mark,
+		.credit			= q->c_protection.credit,
+		.step_marks		= q->step_marks,
+		.memory_used		= q->memory_used,
+		.max_memory_used	= q->max_memory_used,
+		.memory_limit		= q->memory_limit,
+	};
+	u64 qc, ql;
+
+	get_queue_delays(q, &qc, &ql);
+	st.delay_l = convert_ns_to_usec(ql);
+	st.delay_c = convert_ns_to_usec(qc);
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
 /* Reset both L-queue and C-queue, internal packet counters, PI probability,
  * C-queue protection credit, and timestamps, while preserving current
  * configuration of DUALPI2.
@@ -525,6 +609,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


