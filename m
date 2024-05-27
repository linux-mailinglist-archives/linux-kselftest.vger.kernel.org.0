Return-Path: <linux-kselftest+bounces-10727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B98D0687
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CCEB2B6B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DB61FC6;
	Mon, 27 May 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="INTejVd3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380A17E919;
	Mon, 27 May 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824419; cv=fail; b=HFyFzUYAjrpnFkyVDESeB6CEs3Ch5KN0I/9SwN2Wb2/IamTOZFL+XpaaWR6ysm+NNfsg4y6la0k9Al+RhcBXzEOm0WAmuEFddzvi1HVWYlXPLX5G8TRMjKOjBjEFGPjZHVmTIZDMcio28XwHBxXrvn511z3OfAlxc6MU3ySptFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824419; c=relaxed/simple;
	bh=m/wkENAXXx6u1PI5bg2VtZGzw68HESibN8Zkx23L8C4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WBJnrNEelrzuZUlevqB2+QMKm4i4fgPM0EXgcg9FxC7syX75U27s8bS8yLGNN/PMUXDqjNJK/YPMFEuagz17VNI7TwByUxKR4rZA2Zi7GS110KBwnaJ/3r723cV1yHNxY8nBTHvrNIdC1g89Ygb007MsiXsHbdPp9f1N6q9QIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=INTejVd3; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8IWmw8MRU/CGubOmQci9ELDwGfGoanxnsrugtidcni91FwWqlMHMdyGrPbsM6UcGqJfE7nBPoQap6N+3wQWp+PSwrALFTvQfUvftsDZmud1kEbJ5MtseoF7235kcwmVGDxDe30nYok/H14G85Aq0D4dQpgn6YLGt2Ot9ykVHK65MwCrL38e7pijyrvh7ErlSP5L39xBisA4dHOXTc2tGHaM9SdQshdHxJdd6D4vP+q06dkXriZmVGmbQWSoVaSlWWl7ZYoAyES4Vx68VTcHI3FujshjRH/3qUO3zz0Q3wuAcVwy/FIOTawl8nhzMVXO5/DZPQApKox60dubQGeXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT4tNKXB+u3mQBtVjwjrKpUly0ew9Nb94YgWxVvtcVM=;
 b=LAlgg3oarS4LUB9lS6Tzbybz4GwZe5pnAM0UoaMT/TKJKafPQ4RChiSWGoVdcxYOUY3ScbJOMAjA55ksEtD3hDSZsJWz04JRumqweDcCpdMDEHX8QLA7H6QCnqHtpf6En11eFEbErzvfDrYZ9oEHbbM0FgNBl7d9eEduK9VW/tYLms3c6sCqqKLq0nIOXI8MbeHZfmdcXSR4nug8b722IWpLcEdjyoJcYKEV464gWTzxsQtzeEvZSHfwsZkyGD91i1cbrE/lw4yu2ij4QubiSwIV3/wRsAH4EnPWqev/WzdIYqAV/YoebNvRMfITy1hZPaCCj8qIOviBCYDGz5ClSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT4tNKXB+u3mQBtVjwjrKpUly0ew9Nb94YgWxVvtcVM=;
 b=INTejVd32ar5kNd6+NiJdCa/Sq5r+IbrKqHXOsLoIT/Cm0HaoClodOjQ5zwHBErlbAEOCchWdJfY6hq1hifbrwFJPD1se5l4oDP5dtn8OiNyY29ebB770VSAsOtotmC1StAI8ybiQ/YS47zR05I+fHuchGroqnP0XA9u4cCP8bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 15:40:14 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:40:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()
Date: Mon, 27 May 2024 18:39:54 +0300
Message-Id: <20240527153955.553333-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::45) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DB9PR04MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f85d8a-b7cf-47fa-703c-08dc7e634ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtl2jXZI1c80IN4ixF6XH/x6IcTSyYr9Lm73Wfh+JEOtpXOWYKVpMpQ4b1mo?=
 =?us-ascii?Q?pO6TOnGAFuq32YXFedSlZ1x3rhJ6xSCkSwJrKaOnKW0QEpkWfLR0sD1WsH1F?=
 =?us-ascii?Q?aDhi4ShoN5ieDh7d8orSw7BV5nt094hf+QKYcNbqjFJPMkYWxbSD0QHgUA9l?=
 =?us-ascii?Q?CBxvMqq/AsLW9tCIxCWhATaoAcub9OLAaE/as+o5Y0fmb72X2ove9Tv7w/+f?=
 =?us-ascii?Q?Se6gKmG6QwDRULHhHOQ2KLmXu9FQcOOv0QSc6LQustytN+znRcf2nMPteKED?=
 =?us-ascii?Q?y+QAeD3V9qGNfYoDF/8rorKNI3vHu/C/hUV1ejcLDF+4Wkva6qudhP5KCSOT?=
 =?us-ascii?Q?bJIbfNMq05RWZs876rMohu8sbpYjykCC5BGtU+0n7cd5WKYddLiPOWJ6zpCJ?=
 =?us-ascii?Q?G83XMiJo4Ks/047VvsJmXh6kGUGVsTg1YS5ormHcKLDDM6+pEMguxTuEmtnS?=
 =?us-ascii?Q?1kBFykRAkXeydYEWnQMbS2ap171Z2o2VfX3wnqK1Au60CiIx0QcYzrQ4xZw4?=
 =?us-ascii?Q?FjoA78IPLl7yumTq+Lh9ZyXlHtbwCJEuog665pbSS/SidXUu5JWKdSj9qpuO?=
 =?us-ascii?Q?1zEIU4KJKHwEfYt0gYCtllMrdsAnjyDO9DANh0hZ7gfySLvgEmyRExyT71Er?=
 =?us-ascii?Q?IwstEhF+Cd9c1UeekES71NLwCVuySz9+eQ5JOdPd6qq+mLA22IvlIDm3drsf?=
 =?us-ascii?Q?KlwSn9BkDMa+BzjJj0Mnxngip+m+sQuSxTdbC/NH2Imy6PdTuo4Oajx1r+BL?=
 =?us-ascii?Q?JBlWhy1fZ9IHIqKldWhHPPr/jNCUQLRZF3yrethYBvqBW2Fi4lg2fAUViyp+?=
 =?us-ascii?Q?SpnUr2vLg9610FWucpva7AF77YcrYl6xH84dEdd2dXWo3WU7Lbbgy3M4xd/h?=
 =?us-ascii?Q?S2Q2MiyX+3dXExmNsf8u1KnxV1Wv0Q/yysM46iQjLOB1HHbedkQ+RIorYL7N?=
 =?us-ascii?Q?UjnlpvTkU8ib1fQqheuxGeoEAqskWz3QnPnngMpGGorgMYvYAKRMaGXhGZFj?=
 =?us-ascii?Q?cPdVo5deOxwDP1QCpeOWUFHHgTkpTbYnEjuHVmZA5pZScf9XWIDzEldhk5M0?=
 =?us-ascii?Q?SqGNcxyPaK+sAcKfVwWk6NlyXwNWi3XtNVom1SyftACJmgUn/+SorG7KWnDU?=
 =?us-ascii?Q?ZqtND4gAI4IP3Cm8IPBke+fAWsnVgDdSrqLOdfkPk5dU3bKGfPQlrej9iYWi?=
 =?us-ascii?Q?roQ15OGRXPQapVWADHDafYrnaghm2OKvRMWC6UUVgPMyBjPQCnGz9LN1y1El?=
 =?us-ascii?Q?asIW1cCPxoEN0/Nc6OL3pvMqzk9f9dem3DNsKAU7qkc17oLmVDl7j3uU3cbg?=
 =?us-ascii?Q?YBosG2gkkuAzylSZw4twId8I3dp8nLedTSnwho3G0MiVvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QU3kiKSJjjAOY2hyf9ezEaXyYs0oHndBfnoZjZ5tGyTXa4EU5zAQmD1lo+uh?=
 =?us-ascii?Q?z7dlxculjJ7OEgmcefdDsY6yqhFboojqm5wWSBfioIv+UrbfaBGZY42Ggeh2?=
 =?us-ascii?Q?nLKbWHYLIVg6kBfBXDx2G6TCLn19m60HC+zhUfXhLP8DDfhMJSp2QW6qLJck?=
 =?us-ascii?Q?dpcuwKdQdicKyFQ4nyMs+KM4oh7TeqnA0FmZJOJRdt+fA8fwHZUs8w+y2U5u?=
 =?us-ascii?Q?b9rqGXQTJVmtzrUY4zSFGlTqGse8qXYhjgrw/MVmXnm0RLbQp3DDCaHXp5CE?=
 =?us-ascii?Q?Vq6OSM46b/oXluJlYMh0rDpSyh/sAULU+IoX53NgLQyvDud8G+qqTKrD7jaj?=
 =?us-ascii?Q?aQBuYUWpU17K8u3J681RqTavs+o2z6NkbRLnkbep8yN6bk6WjL4DZEXwdbiz?=
 =?us-ascii?Q?S4e7Kgdm24CEv+alSRHuadTBXqBmLxiif9M2rD45ZdXxcd01tj0MB9s4CxnF?=
 =?us-ascii?Q?2Tlm0tIh7uxJpZzp5YM4Jm/VdObzHBVcyyr5IxMgMr6roR5fu3WGk1oH/nAw?=
 =?us-ascii?Q?VJ1a9IoFwCm6DjTlob/SVGKCI+BcLxrshSC0T87KauByeXkwQDutb2iCCnX7?=
 =?us-ascii?Q?rPr9uzx6+79FGElMwQcb+gpaEtwRfzef1TtLAyCptS3rUMH04oR4XoTlCe/g?=
 =?us-ascii?Q?wf2uN4OcEnrknjP0MZ3LFjLUcIFzNThPjFkLydAJhGk2vXgJHcGq1GJbFu+l?=
 =?us-ascii?Q?HzBMEwaxugec0VzSoclLdLj6ZPyUrfTj9JB9I+Vyl6g46HIDkIgAZG3IWP0t?=
 =?us-ascii?Q?gszG/DIlIqAmS9k2pXODHq7Q8wQWZ9gs84ZzBVahVsvLiMB9bByFTxtbWNUK?=
 =?us-ascii?Q?YiR9aqRbBMnyKFJvhW9eUBJJQqPCaVFV0VmOTDHUXtOwkFJbm1kgOvLGNGSV?=
 =?us-ascii?Q?K+Sup06BIRwJet+npQUsns3lCb1jZkES/8UCcf5uijd4k0I33V39egOdbG63?=
 =?us-ascii?Q?ApsYCMnxSUHXFX9RmJbtxwnZzNBA6uH3MwfyC2FyNTf+VOlfrjW3JGP0pRRo?=
 =?us-ascii?Q?8dL+r3PiY8PfkZYUaIvXqZmKr8N0QYARCZMAniXUsmVWxnIAiQdLosnsHJU2?=
 =?us-ascii?Q?oNpjZWYhMUCnsI36BmY1SYZhYCRFInFvTCePH/gUnfyDnm7lkjer8i/aFJ72?=
 =?us-ascii?Q?9Ryos913W2122sWAoi7olri6lzmHDOO+IMb4v4v224pNfIa4wslH87ouMEPc?=
 =?us-ascii?Q?BwEAEHVe0NeOpjeXn0cxUSyzXwiVEKjQn7/LSnIOI7v4YDNoI7eulYB0UAuE?=
 =?us-ascii?Q?61zxS6SLPscbRTu0nPE4TzD6PcDw9IB90yckd5+bQsnZJY3WkhIdIkQeCsYx?=
 =?us-ascii?Q?DKs6sNKWFAjh6Usj9GBTJ8u5OneB0Ysdyl5xEuTtWUvPEXGH6WgKlviWi+pD?=
 =?us-ascii?Q?admxtgctVUIn9mutnStxn5hrS169bzLzfHYBN/zwsFs2Fh+U5mh2GhtEO2BB?=
 =?us-ascii?Q?fsx/YXPnMV0Nc9mhHKH+8iWhFhEVuLU4JhqU6yXYoSHFRcE4oaM20QTLgWmx?=
 =?us-ascii?Q?/WLyjM3qhg30Vci7OxYF2t96LVQsZs/YrdD6zj+LnXuTRI61ePIUpl7VrLGR?=
 =?us-ascii?Q?NZ2TnwsO1YY3O+uoASKWWV3TJUqHPLWI6AU4z5N0P4R2IIdONZY4qJHuXM/D?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f85d8a-b7cf-47fa-703c-08dc7e634ce6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 15:40:13.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABnEv5K4R2k55pAj0QxmsJAGpgPsPmZ1RMt77H3LdMB1XLE695UjAXYkFPClX5f6a5Bd+tqF1egQp3pZX6h6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961

In commit b5b73b26b3ca ("taprio: Fix allowing too small intervals"), a
comparison of user input against length_to_duration(q, ETH_ZLEN) was
introduced, to avoid RCU stalls due to frequent hrtimers.

The implementation of length_to_duration() depends on q->picos_per_byte
being set for the link speed. The blamed commit in the Fixes: tag has
moved this too late, so the checks introduced above are ineffective.
The q->picos_per_byte is zero at parse_taprio_schedule() ->
parse_sched_list() -> parse_sched_entry() -> fill_sched_entry() time.

Move the taprio_set_picos_per_byte() call as one of the first things in
taprio_change(), before the bulk of the netlink attribute parsing is
done. That's because it is needed there.

Add a selftest to make sure the issue doesn't get reintroduced.

Fixes: 09dbdf28f9f9 ("net/sched: taprio: fix calculation of maximum gate durations")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/sch_taprio.c                        |  4 +++-
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 22 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab17e8a7260..118915055360 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1848,6 +1848,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	q->flags = taprio_flags;
 
+	/* Needed for length_to_duration() during netlink attribute parsing */
+	taprio_set_picos_per_byte(dev, q);
+
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
 		return err;
@@ -1907,7 +1910,6 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (err < 0)
 		goto free_sched;
 
-	taprio_set_picos_per_byte(dev, q);
 	taprio_update_queue_max_sdu(q, new_admin, stab);
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 12da0a939e3e..8f12f00a4f57 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -132,6 +132,28 @@
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
     },
+    {
+        "id": "6f62",
+        "name": "Add taprio Qdisc with too short interval",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 queues 1@0 1@1 sched-entry S 01 300 sched-entry S 02 1700 clockid CLOCK_TAI",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
     {
         "id": "3e1e",
         "name": "Add taprio Qdisc with an invalid cycle-time",
-- 
2.34.1


