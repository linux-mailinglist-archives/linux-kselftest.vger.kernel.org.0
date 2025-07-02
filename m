Return-Path: <linux-kselftest+bounces-36246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A0AF0929
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA544E07ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED51B423D;
	Wed,  2 Jul 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DUMAeCW6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FC4C62;
	Wed,  2 Jul 2025 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426811; cv=fail; b=ALGc5Z9WiHvbKjC7PJrxWvtyKLLrdix//xA7Qd6AAMjjm5k8IFuVhDg9KYVoPh1kw6n/mC9xKfgT4Ss2J/2GmjeLd4Z22m5GOX5m7Bf3XOwSr91wzTlLHjNDg5GQnELkdHsI2+4TABn6iJRAe9G+LpgN3y/r/0SQsmhac1mkox0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426811; c=relaxed/simple;
	bh=tv9dFg5zA2HsIVgY7HFWVbMi+VLySshtFEFbOf7v47Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mKsQ3jdT8bDTq9OaWMuSZecqA3Bpg6CFwpSMb0QV5Ho5kTDRjNzjngaW0L2cgGVBA1G53EkC96uvLCNgvj85NjFDg3E0KYLRL41bGPoWO1G19bvKm98MZihy9nsP/LL8TOi5Ynj+GHsh1YjCsLxTDHj0LAb+ESIyIBrASi+N3W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DUMAeCW6; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylYYq28ifd0gVjXC27qpPvV+5HPPIuf9rfz2J/FngBsXwXlJ+xGeOWOXdfYXB6ENnUP1ewk3hQZ1TafgmjBxZv5PhQnQrbZpbz2ptmnegaBwKvExzRNkUsDGhhPjlN/FwoGDi0lQUmORsO/8taY59L+RDoXeHJkVyHEtgOoUGEpJ9r03gYGJcQkx3A4+1NuJdPEms+KzNf6ksnQpgchm/qQQ/4hzqSnAN5oFE+WtetYNJ7Tp7bcHsaYqLDujReR7chScryogEBpuw63HdEpgPzz20PlSG9+qkjXVJQtmHCoxRA4KC1DyoSrKVe3BA3npAu9e+B4owMhnqSrj+ds8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2ZDI4Jlrd3CYkA8SPXpB+jokOxsZTovvOU0i3Rxcu4=;
 b=Zp+exmzYv+O43bfc2TC/U3zxgR7Eh3Gt8Em+aginZNp6jYzGV+97u9dgvCqY2ll1LN31Q3XfsTAI2hzH94Xd1I/HZTPYDqiOO1lOhLFc5tFKrPGCCEc07jga69wkRpSwh23APfmcReBLRcChaDN9XWSCG4M2JJEAiPLv6ipIQMLI3970I31AGWsg6HWGjX7azNdRcpm/1WRG9D8XiLpRmmF3JJs/3zvenAkbhen8Qbe8L28BktBW/Swic8eKzBJvWYFhx6BupTraNvbBfpTSFsqNgSfkQpAg7FzrzECSy2tNpfz+KraAc4WctXnRwf9Xp/0uDL2iGRW1xYq+GEkjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ZDI4Jlrd3CYkA8SPXpB+jokOxsZTovvOU0i3Rxcu4=;
 b=DUMAeCW6vwHUOxlGXBuA3BCF8S56OyVsJc1GAhLKuWvp4QyQXPTfAfhcc8ZICJYJhR2s0OwOnDEys3VQ87orxgy36DErEzUq8uYlyFndzHDvTSXKEIqN6zBWXd14GhU9a8zSa2QVpGyobqMdsbwdNgk64yN8R1ZhCqVjT0YlZtiSmmDedogPrEHvySnas2n+aJCgFOM/rgycnb+RoMaUlD3OJpRy5bVzKnbCNHZnZRUbOflIBMDLkXpwuSD2Jr5yKn23DoMdCdzm295vmql4JwkeH8+1AW5Q6tMmiL1mm95rAS9Rii2Vkb/BeX7MmqToTY7Tf7NcNVMxOdb1SGXflA==
Received: from DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) by AS5PR07MB10059.eurprd07.prod.outlook.com
 (2603:10a6:20b:680::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 2 Jul
 2025 03:26:45 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::2f) by DUZPR01CA0067.outlook.office365.com
 (2603:10a6:10:3c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 03:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Wed, 2 Jul 2025 03:26:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id D52EC68003E;
	Wed,  2 Jul 2025 06:26:43 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v10 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Wed,  2 Jul 2025 05:26:40 +0200
Message-Id: <20250702032641.13258-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|AS5PR07MB10059:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f01abac-5ac2-459d-cd65-08ddb918459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhiFIB6vyTKj/c6yBi1OkBW9KdtqwUAM4v5hO9OL6J0Hzn2726YdYEzU+r3l?=
 =?us-ascii?Q?u7+y4mDui4RaEpfFVsAYAY1Uqaz2PhJuwfh1hXf8w9vkfm26LB6AwISx4xj8?=
 =?us-ascii?Q?S5Gdpomo1rj8M84scLikkgVeyZ9mK8NV/Y2cFaBM/rjqVmodh4CgDE/mUx08?=
 =?us-ascii?Q?pWLEXcLT1NChfsL5lsq4/TENDEijbx94XeL9FXm2qU5ItR2L7Oq7rfdCMdcE?=
 =?us-ascii?Q?hupzotc3v1lBpAbgUUnRt4wVpL8sEG4k5d7e3F7852iR/JZ1SXA//VAgCFMR?=
 =?us-ascii?Q?PO1R0Wl0CZg6l1To3tOiBYNOSjBgwqH8YA3w6DuTH6MZMZAK31ntfhIwffDW?=
 =?us-ascii?Q?ZanD1b7j/Hr0T72rzbpfUr5spOudHqGLUtHPhC386gmXAoMpH4ZaBxV9xotO?=
 =?us-ascii?Q?Xs2MhMrzshtLDa3FbSVvjb2x4yKqW/0juJqTOp3+DNMDMPhErEGxFpbtuwic?=
 =?us-ascii?Q?T/kj7BDyn64mHNnYRpO4v/MStqBCmg6BDwWEI4qRdRQvcn3K6QhvcCoqFC1W?=
 =?us-ascii?Q?xzEaD8lU8xkr24RrML2hRW4qdBIFMhZNkFwQCYuSlE0bjocBkWynbvxYcgUj?=
 =?us-ascii?Q?kGk36gEhmWgxm4yMoL5PhAG+xF7PXqfCQmw9I14iqd+GbYnRwJWpJSwoLo4Z?=
 =?us-ascii?Q?BJPkofCvtTFClApXTC8UpmoAN2+caLjXk5NGOlVAq8LU4QvL8WTmrGyKEAPp?=
 =?us-ascii?Q?eoS3vd5WCKt6+nLFcW3z71NLbgdkPJlb62ho/erFE2jwhnyRTIBU/0gIWkQ5?=
 =?us-ascii?Q?lpMjsrMqLpEgokX0ex+oqoHbse7okZMraHjgYcZsbhNHp4CJkzdfB+qa5OXm?=
 =?us-ascii?Q?n9YnkGMqwdODUJQcrqQuOQ86iYs6drQac51vowGmDCLynOHvGSI9iYQMsBsm?=
 =?us-ascii?Q?P3TlV8JvOX8JpfRPb9jkniW4OoLcvlz0iDBVKPa99hE91GZ/rcKQZ+OMZiQQ?=
 =?us-ascii?Q?CXYffvsGudyGYKeGvnuzZxsYwBPeFD4njuvmKBUoHHmgBv2zVR0SEVOaSJN+?=
 =?us-ascii?Q?marZqqAlLZgIenLQxupsiVetD3MWsgAkzaElqSQXG1zNsu3OqeRYdCSgMCT5?=
 =?us-ascii?Q?gQu0LOE7A5FXoy4uMRZcY1DgoIE+VFxZC+5tsIE/R/3/jCBN/QJRw0ypwyFo?=
 =?us-ascii?Q?iKPo+oq6DaFohtqQXCLUEIoCyepj/OXCnWvkclC0m4R2KzrA24ZApfXDSkYq?=
 =?us-ascii?Q?l8tEmIhnjPAqPLzCiT05AtBsRsXzhPqO2GxXXnTYvI6AtwpRp43t9W90+uiw?=
 =?us-ascii?Q?hPKwT9xIdNsiTruUBtRDBwLJJhnvjofqbOTC/sx4mPSNUnsBoDoIFjkKXrGG?=
 =?us-ascii?Q?+VFGLAmctZt5QRAI2mXqdV2xZ67ClGsfkJvrVzGI23nVC0qq3weT3Oo5u3pH?=
 =?us-ascii?Q?pRVfGuQI4Ndyla2JE8DZKBnAfO6//LfC7VzOjAsxJKB9039ngtrfHlatI4Qz?=
 =?us-ascii?Q?VhN47e8TSPJYJYaTsdkEOV5n3a9sNfFlPaCdHEMp0v3tQl1ItpmP76RvBYWy?=
 =?us-ascii?Q?tDy5RMKnffNwAYcNt//Fg8ip+1Lrm3TdDsap+DitavEahzgqgmBB/3Bydg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:26:45.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f01abac-5ac2-459d-cd65-08ddb918459d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10059

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v10.

  For more details of DualPI2, please refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

---
v10 (02-Jul-2025)
- Replace STEP_THRESH and STEP_PACKETS w/ STEP_THRESH_PKTS and STEP_THRESH_US of net-next patch (Jakub Kicinski <kuba@kernel.org>)

v9 (13-Jun-2025)
- Fix space issue and typos (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Change 'rtt_typical' to 'typical_rtt' in tc/q_dualpi2.c (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Add the num of enum used by DualPI2 in pkt_sched.h

v8 (09-May-2025)
- Update pkt_sched.h with the one in nex-next
- Correct a typo in the comment within pkt_sched.h (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update manual content in man/man8/tc-dualpi2.8 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update tc/q_dualpi2.c to fix missing blank lines and add missing case (ALOK TIWARI <alok.a.tiwari@oracle.com>)

v7 (05-May-2025)
- Align pkt_sched.h with the v14 version of net-next due to spec modification in tc.yaml
- Reorganize dualpi2_print_opt() to match the order in tc.yaml
- Remove credit-queue in PRINT_JSON

v6 (26-Apr-2025)
- Update JSON file output due to spec modification in tc.yaml of net-next

v5 (25-Mar-2025)
- Use matches() to replace current strcmp() (Stephen Hemminger <stephen@networkplumber.org>)
- Use general parse_percent() for handling scaled percentage values (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 stats (Stephen Hemminger <stephen@networkplumber.org>)

v4 (16-Mar-2025)
- Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step marking.

v3 (21-Feb-2025)
- Add memlimit to the dualpi2 attribute, and add memory_used, max_memory_used, and memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update the manual to align with the latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2 (23-Oct-2024)
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

---
Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  68 +++++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 528 +++++++++++++++++++++++++++++++++
 8 files changed, 888 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


