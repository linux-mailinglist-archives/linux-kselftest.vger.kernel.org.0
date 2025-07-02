Return-Path: <linux-kselftest+bounces-36252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18275AF0935
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F9188CB95
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180C1E5B70;
	Wed,  2 Jul 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qPAeaqfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538A1D63F2;
	Wed,  2 Jul 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426915; cv=fail; b=BbJDvHHJplOS703jh90OfdIECEMylLo/q0VWGp0RX60zNiiuxxjeBT1BVjNi6ABUQI8tlB9SRHzVhzI4fDHmIIFU1mmeeIJ4Yfy4WWN3yNHkScPe4zz/27rNuppuao/+LGddXS+uYA1slp/im31D6KoCbPuutpQJE7EfTSw2igo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426915; c=relaxed/simple;
	bh=gflzag+UdY7Ms/lg2+Eqcq8iOz6RRP41XIS5tmqQuWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6S0wbHhdmW+k79vZ6mqFC3fErmABGopwAH0nLtYgqsYehmWINivqhVnys1NetoNYJvr31JpNkLJoPgNTVTDphTJ51Qu2/v5DeO/KSp3zGdGQJm61edEzKSDWbfEbMWC+2izLuNqxDz6NOoENDgBVoNNMHxqcxL0us6uCRkByk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qPAeaqfG; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQP07sDfCRwegvKAL5pTz3/JXeEMyZKfbxK/+0v6sAC1yEQtgntRbqerjIp2kFr5asCTiyFvuNz0c2ZBHVjzWPPBmqwbniLtKjXh6mDxK7p3/i7ZukGf7RPWuwJYHJb77a7prZMxeGpheWa8g0PgR0uyf41IPoaoTtl2jawH3MFO9BHo770qnwBErA9wGFE3h3nTfQJHALmd9RWFHsPhiqojg8wFqGUdB36XwIF4qhFCQpNLkdwmBVBtng+fUQR7lP13q7SMJFuLjazUvuD5CG/lkOKnfP1aRbBlwAFfE96KuLX5Rq8ekDGU9bFMLvWw/5Y/IykvYezC/gXBPlCNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOVS3bvDEYBcbkksbpFmgLtvQorz5XRGrtm4tC8Ads0=;
 b=Wj6IY/cqTiHlwcICwY9pxs9+4aOxu8eBKu9BXwe7BaeqRnIZsNZxHVseyFyXF/OLcQkJQsF5RX6H4srJy0NICTyt1WYnVGiciIjmBbxkbJ0fpBpT4ZNEXLb/1YChEx3EDu3DjV+o+kVuwTRSEGRKY6gdZMHzVvExbt1a+lMHxtTW0YhFfrTEedQcFNoSAiIb1D/fL1UjZT8twjiS41sZKcnxU/JIy8yn+3KNPOz37mAlryTczTn491NwV8yKMZviPQP3/m5dZrsXvQS9X+IG2Pa1UdzdmEaPUjVTdXZQfwziVMoUcAL/kKCrYwGXtrbONa+AhlvOirbmoJFS/423Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=albisser.org
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOVS3bvDEYBcbkksbpFmgLtvQorz5XRGrtm4tC8Ads0=;
 b=qPAeaqfGf7sNWkVZCVHRnKvZTmjMtijNOSIndcUMvfLQungwpwPBhvzrjvwifOiHjYZXj7n/IT6TyRmI70/KOar63gTK0lBEzjkqTtVIY9irLcguN/K7JpdJI3lItfL/92bU54AaoHZwNL0lljsk9/RK9/Wh7X3BDBAlDhFK663kbgaL4oeG2buiXXYwGuJ3i7tsW3QC0aXPKiG951ygnsqdlz4coRVdnla7aIW27kB4yge3p5S39fSyF2eK5wm7SjfSMCLUAhNaP+5tS/pQ6akwssmIz8ZrwQYt3kmdUIc6zXeNLlKgrtgAHOdvb3vvOgqnrGZUkC5ry/6G3/uM7g==
Received: from DB8PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:10:110::40)
 by AS8PR07MB9397.eurprd07.prod.outlook.com (2603:10a6:20b:637::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 03:28:26 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::34) by DB8PR04CA0030.outlook.office365.com
 (2603:10a6:10:110::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 03:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 03:28:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 90C8B200B6;
	Wed,  2 Jul 2025 06:28:24 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
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
Cc: Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Bob Briscoe <research@bobbriscoe.net>
Subject: [PATCH v21 net-next 3/6] sched: Add enqueue/dequeue of dualpi2 qdisc
Date: Wed,  2 Jul 2025 05:28:14 +0200
Message-Id: <20250702032817.13274-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|AS8PR07MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca28143-fb48-423f-cf3f-08ddb91881ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1RtamNrajlucjljRGVpbFRTek5ia2x0Mk4xWTlxZDJGUGhwdVYrTTA4Q0lQ?=
 =?utf-8?B?WnVBU00zL0grblpUdUtGTGhTSG1RZk9yRGhhbTJrVk5mYUhCdzVRZjBBR05K?=
 =?utf-8?B?NVYrOG85eGZhOTlSZzhKRng1NHk3RHVyZjFKRDhPcnI2K1VVV0Z1NUNkOUs4?=
 =?utf-8?B?c3pld1phQXlSK3Z6bzFwUWpaQzI1UkFwdXNFRUpGNHl4YVZRd3NyUDI5Mkpw?=
 =?utf-8?B?dytCc2xuM3RDTjBtWCt2aS94YWtwUXBhYVRhTkNKUGJjdzV1Qmt4Wmk0WHlW?=
 =?utf-8?B?SlFiSlB1STFybzduTjFMVXUwWFZidU9UZXhlUms4cnpCN0FEcXJqZGthWWU3?=
 =?utf-8?B?YU9HdjFHYzY2U2ZNMzdORExZbEM3c0s4TExRU1ZZR3NoakROL1RLOGgyejVB?=
 =?utf-8?B?Q0lqQkNGWldXeHh0YlNXRnNkSXFzMGowM2Y5bDlCWFc0bklpQjlzZHpVWDdQ?=
 =?utf-8?B?OUlJTWRRR3dkS0tudzN2L1cwMFgzcDA0RzNvWHlBRllBbzRFN1lsUnFESFY2?=
 =?utf-8?B?b2NPQy9nczZMQkVXT1c5eEYzaG1WVEJRaW0yajR3em12ZlRXSzArWHpYMGZ1?=
 =?utf-8?B?a3hKR0xVOHRaVlhaVTE1bTZHakYrTGtIZkYyNWJLMlRiVXlLYTVGZVRjSFZK?=
 =?utf-8?B?S3M3MkZjbzBlNVpyZWVYa2traWtFZGRIZE5kcjZEU2FXU09UT0piNjZFT3dE?=
 =?utf-8?B?L05aQ1BNZUtWaHVqQnJWK0w2NVhrOWpPOEI1OHNuQ25kdHJySzFnamlJTldn?=
 =?utf-8?B?cVFEK3J6ZmpLQWRTV3RKS1RMVlBDaFRWZTQ2dExJVjRZRnpiT2JlUkJoZmVq?=
 =?utf-8?B?eElqZC9lTXVPRklYTVZBWmQ0djIva1N6LytSeTlIZnJrdDFEVFlGK1hrRVNj?=
 =?utf-8?B?V085VFVXN1dVUGdrMnVENkZNVUIyN0JhRjZRcUwzREcwTHBBTDE3VHBJbDFG?=
 =?utf-8?B?bWE1cHE0QlVNZFpVT1MwVmdLOWFsTXV1emRqM0xVdnFIUnpzUkpTZ1hiSzhZ?=
 =?utf-8?B?d0d2b2c0TEtCQmkvOXJ0ZEF0UkhqeDIxbU5IZjhVd1RNa0RHb29OWEthMy8v?=
 =?utf-8?B?Q1d3enJpdUFrTVVsRGtKRHF2ZUN0c2x3U2MrY1BMdmIwOE9TZEFFWXhnUDZB?=
 =?utf-8?B?bnJQNnAvQUQvZWdXR05wc1ByMjF5dktXWkprdmZhbVhzZ3ZTR2NEUm5RaHFD?=
 =?utf-8?B?ZHpsSmdadGVVRG5TVFV4RXRuSndtbExZcFBPaDh2VjZhYXg0RUFESisxWGVG?=
 =?utf-8?B?RjN3OStmK3Z2aUtjL0F3d3ZtdXNPaG84MVBucGVSdk1YTmdBazR5UGJJRTZY?=
 =?utf-8?B?WDcyNnBLUlpQV1Ird2lhRkFUNnZqK3J1MWE1ZWtVclVJNVo1SVA0d1NVdzRT?=
 =?utf-8?B?bW5pTXlNaHJIVFhQNGZoWXJWbXJScE83aE1TWjVTR1pBMFZOYkxBOFRMWllH?=
 =?utf-8?B?c0RTVGhMdUZkUm1zSmU1cFdDMlc2NWdTTENWTzhpMHhCYm95bTZFMDYwUDdy?=
 =?utf-8?B?bHRVY2FORWFtOHUxYzY5QndoQU1FVmJ5WkZDaTM5b3JaemhISDkyWDhYNHRj?=
 =?utf-8?B?UmVWU001QnpaKzhEelhyakRKVWhDeEcyNGU3RmgxZ3E2UENreTdWUFE4MUtl?=
 =?utf-8?B?TVJzTHJkenFwRnBMVjlkZkhPVDc0dmFwTW0wRDlXWG84UzRKaDRxNkRlcUpw?=
 =?utf-8?B?RlZjUjdOMEdTc3k2YkZpRnI1QmhDNnUxMHdBUGFQR01hU2JQTVAxblprWlNM?=
 =?utf-8?B?OUtmdG5NQTV4Mk1ERTBKSkhTSzRRU3dPRE9sNU1kcEZYcE5IejQwbkdaTWpW?=
 =?utf-8?B?K2ltT2x0aEdyTkhoaTRZNloyWEVvUWtGbFUyTzhubGpiRWtTaGZmeC9nTjlN?=
 =?utf-8?B?Ylg0MTZoTGxJQlFlS1N0U0I2OS9xVGY0ZC9aOGU2Z0JJZXFOSkFBWTkzbURS?=
 =?utf-8?B?RXVweUxEdEtqSHdQOGhGT1dITndvMURkUDZSMG94bEJRRUprd3haQXlCbW5n?=
 =?utf-8?B?ZERldjZ1Zk9PRlZCZkpyU3J6anRlaE90emNDQWJyS0NZVnNEbHZiNWZCc0RK?=
 =?utf-8?B?ZFZyeVEzaUIxOU5sQkNoT0Q0TTZwbVRBbGhlUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:26.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca28143-fb48-423f-cf3f-08ddb91881ad
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9397

From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

DualPI2 provides L4S-type low latency & loss to traffic that uses a
scalable congestion controller (e.g. TCP-Prague, DCTCP) without
degrading the performance of 'classic' traffic (e.g. Reno,
Cubic etc.). It is to be the reference implementation of IETF RFC9332
DualQ Coupled AQM (https://datatracker.ietf.org/doc/html/rfc9332).

Note that creating two independent queues cannot meet the goal of
DualPI2 mentioned in RFC9332: "...to preserve fairness between
ECN-capable and non-ECN-capable traffic." Further, it could even
lead to starvation of Classic traffic, which is also inconsistent
with the requirements in RFC9332: "...although priority MUST be
bounded in order not to starve Classic traffic." DualPI2 is
designed to maintain approximate per-flow fairness on L-queue and
C-queue by forming a single qdisc using the coupling factor and
scheduler between two queues.

The qdisc provides two queues called low latency and classic. It
classifies packets based on the ECN field in the IP headers. By
default it directs non-ECN and ECT(0) into the classic queue and
ECT(1) and CE into the low latency queue, as per the IETF spec.

Each queue runs its own AQM:
* The classic AQM is called PI2, which is similar to the PIE AQM but
  more responsive and simpler. Classic traffic requires a decent
  target queue (default 15ms for Internet deployment) to fully
  utilize the link and to avoid high drop rates.
* The low latency AQM is, by default, a very shallow ECN marking
  threshold (1ms) similar to that used for DCTCP.

The DualQ isolates the low queuing delay of the Low Latency queue
from the larger delay of the 'Classic' queue. However, from a
bandwidth perspective, flows in either queue will share out the link
capacity as if there was just a single queue. This bandwidth pooling
effect is achieved by coupling together the drop and ECN-marking
probabilities of the two AQMs.

The PI2 AQM has two main parameters in addition to its target delay.
The integral gain factor alpha is used to slowly correct any persistent
standing queue error from the target delay, while the proportional gain
factor beta is used to quickly compensate for queue changes (growth or
shrinkage). Either alpha and beta are given as a parameter, or they can
be calculated by tc from alternative typical and maximum RTT parameters.

Internally, the output of a linear Proportional Integral (PI)
controller is used for both queues. This output is squared to
calculate the drop or ECN-marking probability of the classic queue.
This counterbalances the square-root rate equation of Reno/Cubic,
which is the trick that balances flow rates across the queues. For
the ECN-marking probability of the low latency queue, the output of
the base AQM is multiplied by a coupling factor. This determines the
balance between the flow rates in each queue. The default setting
makes the flow rates roughly equal, which should be generally
applicable.

If DUALPI2 AQM has detected overload (due to excessive non-responsive
traffic in either queue), it will switch to signaling congestion
solely using drop, irrespective of the ECN field. Alternatively, it
can be configured to limit the drop probability and let the queue
grow and eventually overflow (like tail-drop).

GSO splitting in DUALPI2 is configurable from userspace while the
default behavior is to split gso. When running DUALPI2 at unshaped
10gigE with 4 download streams test, splitting gso apart results in
halving the latency with no loss in throughput:

Summary of tcp_4down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP   :       0.53      0.30 ms         350
 TCP download avg :    2326.86       N/A Mbits/s    350
 TCP download sum :    9307.42       N/A Mbits/s    350
 TCP download::1  :    2672.99   2568.73 Mbits/s    350
 TCP download::2  :    2586.96   2570.51 Mbits/s    350
 TCP download::3  :    1786.26   1798.82 Mbits/s    350
 TCP download::4  :    2261.21   2309.49 Mbits/s    350

Summart of tcp_4down run 'split_gso':
                         avg          median      # data pts
 Ping (ms) ICMP   :       0.22      0.23 ms         350
 TCP download avg :    2335.02       N/A Mbits/s    350
 TCP download sum :    9340.09       N/A Mbits/s    350
 TCP download::1  :    2335.30   2334.22 Mbits/s    350
 TCP download::2  :    2334.72   2334.20 Mbits/s    350
 TCP download::3  :    2335.28   2334.58 Mbits/s    350
 TCP download::4  :    2334.79   2334.39 Mbits/s    350

A similar result is observed when running DUALPI2 at unshaped 1gigE
with 1 download stream test:

Summary of tcp_1down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         1.13      1.25 ms         350
 TCP download   :       941.41    941.46 Mbits/s    350

Summart of tcp_1down run 'split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         0.51      0.55 ms         350
 TCP download   :       941.41    941.45 Mbits/s    350

Additional details can be found in the draft:
  https://datatracker.ietf.org/doc/html/rfc9332

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Olga Albisser <olga@albisser.org>
Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Acked-by: Dave Taht <dave.taht@gmail.com>

---
v17:
- Add helper function skb_apply_step()
- Change the drop reason into SKB_DROP_REASON_QDISC_CONGESTED for drop_early
- Modify the condition to remove the original skb when enqueuing with GSO segments
- Add brackets and spaces for readability
---
 include/net/dropreason-core.h |   6 +
 net/sched/Kconfig             |  12 +
 net/sched/Makefile            |   1 +
 net/sched/sch_dualpi2.c       | 472 +++++++++++++++++++++++++++++++++-
 4 files changed, 487 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index b9e78290269e..7e17e360ded1 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -124,6 +124,7 @@
 	FN(CAN_RX_INVALID_FRAME)	\
 	FN(CANFD_RX_INVALID_FRAME)	\
 	FN(CANXL_RX_INVALID_FRAME)	\
+	FN(DUALPI2_STEP_DROP)		\
 	FNe(MAX)
 
 /**
@@ -591,6 +592,11 @@ enum skb_drop_reason {
 	 * non conform CAN-XL frame (or device is unable to receive CAN frames)
 	 */
 	SKB_DROP_REASON_CANXL_RX_INVALID_FRAME,
+	/**
+	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
+	 * threshold of DualPI2 qdisc.
+	 */
+	SKB_DROP_REASON_DUALPI2_STEP_DROP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index ad914d2b2e22..6ddff028b81a 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -415,6 +415,18 @@ config NET_SCH_BPF
 
 	  If unsure, say N.
 
+config NET_SCH_DUALPI2
+	tristate "Dual Queue PI Square (DUALPI2) scheduler"
+	help
+	  Say Y here if you want to use the Dual Queue Proportional Integral
+	  Controller Improved with a Square scheduling algorithm.
+	  For more information, please see https://tools.ietf.org/html/rfc9332
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sch_dualpi2.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 904d784902d1..5078ea84e6ad 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
 obj-$(CONFIG_NET_SCH_BPF)	+= bpf_qdisc.o
+obj-$(CONFIG_NET_SCH_DUALPI2)	+= sch_dualpi2.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index e54a427dcc67..cfa30d1b6582 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -113,8 +113,44 @@ struct dualpi2_sched_data {
 	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
 	u32	memory_used;	/* Memory used of both queues */
 	u32	max_memory_used;/* Maximum used memory */
+
+	/* Deferred drop statistics */
+	u32	deferred_drops_cnt;	/* Packets dropped */
+	u32	deferred_drops_len;	/* Bytes dropped */
+};
+
+struct dualpi2_skb_cb {
+	u64 ts;			/* Timestamp at enqueue */
+	u8 apply_step:1,	/* Can we apply the step threshold */
+	   classified:2,	/* Packet classification results */
+	   ect:2;		/* Packet ECT codepoint */
+};
+
+enum dualpi2_classification_results {
+	DUALPI2_C_CLASSIC	= 0,	/* C-queue */
+	DUALPI2_C_L4S		= 1,	/* L-queue (scale mark/classic drop) */
+	DUALPI2_C_LLLL		= 2,	/* L-queue (no drops/marks) */
+	__DUALPI2_C_MAX			/* Keep last*/
 };
 
+static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
+{
+	qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
+	return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
+}
+
+static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
+{
+	return reference - dualpi2_skb_cb(skb)->ts;
+}
+
+static u64 head_enqueue_time(struct Qdisc *q)
+{
+	struct sk_buff *skb = qdisc_peek_head(q);
+
+	return skb ? dualpi2_skb_cb(skb)->ts : 0;
+}
+
 static u32 dualpi2_scale_alpha_beta(u32 param)
 {
 	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
@@ -136,6 +172,30 @@ static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
 	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
 }
 
+static bool skb_is_l4s(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified == DUALPI2_C_L4S;
+}
+
+static bool skb_in_l_queue(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified != DUALPI2_C_CLASSIC;
+}
+
+static bool skb_apply_step(struct sk_buff *skb, struct dualpi2_sched_data *q)
+{
+	return skb_is_l4s(skb) && qdisc_qlen(q->l_queue) >= q->min_qlen_step;
+}
+
+static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
+{
+	if (INET_ECN_set_ce(skb)) {
+		q->ecn_mark++;
+		return true;
+	}
+	return false;
+}
+
 static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 {
 	q->c_protection_credit = q->c_protection_init;
@@ -155,6 +215,408 @@ static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 	dualpi2_reset_c_protection(q);
 }
 
+static bool dualpi2_roll(u32 prob)
+{
+	return get_random_u32() <= prob;
+}
+
+/* Packets in the C-queue are subject to a marking probability pC, which is the
+ * square of the internal PI probability (i.e., have an overall lower mark/drop
+ * probability). If the qdisc is overloaded, ignore ECT values and only drop.
+ *
+ * Note that this marking scheme is also applied to L4S packets during overload.
+ * Return true if packet dropping is required in C queue
+ */
+static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
+				    struct sk_buff *skb, u32 prob,
+				    bool overload)
+{
+	if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
+		if (overload || dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Packets in the L-queue are subject to a marking probability pL given by the
+ * internal PI probability scaled by the coupling factor.
+ *
+ * On overload (i.e., @local_l_prob is >= 100%):
+ * - if the qdisc is configured to trade losses to preserve latency (i.e.,
+ *   @q->drop_overload), apply classic drops first before marking.
+ * - otherwise, preserve the "no loss" property of ECN at the cost of queueing
+ *   delay, eventually resulting in taildrop behavior once sch->limit is
+ *   reached.
+ * Return true if packet dropping is required in L queue
+ */
+static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
+				     struct sk_buff *skb,
+				     u64 local_l_prob, u32 prob,
+				     bool overload)
+{
+	if (overload) {
+		/* Apply classic drop */
+		if (!q->drop_overload ||
+		    !(dualpi2_roll(prob) && dualpi2_roll(prob)))
+			goto mark;
+		return true;
+	}
+
+	/* We can safely cut the upper 32b as overload==false */
+	if (dualpi2_roll(local_l_prob)) {
+		/* Non-ECT packets could have classified as L4S by filters. */
+		if (dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+mark:
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Decide whether a given packet must be dropped (or marked if ECT), according
+ * to the PI2 probability.
+ *
+ * Never mark/drop if we have a standing queue of less than 2 MTUs.
+ */
+static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
+		      struct sk_buff *skb)
+{
+	u64 local_l_prob;
+	bool overload;
+	u32 prob;
+
+	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+		return false;
+
+	prob = READ_ONCE(q->pi2_prob);
+	local_l_prob = (u64)prob * q->coupling_factor;
+	overload = local_l_prob > MAX_PROB;
+
+	switch (dualpi2_skb_cb(skb)->classified) {
+	case DUALPI2_C_CLASSIC:
+		return dualpi2_classic_marking(q, skb, prob, overload);
+	case DUALPI2_C_L4S:
+		return dualpi2_scalable_marking(q, skb, local_l_prob, prob,
+						overload);
+	default: /* DUALPI2_C_LLLL */
+		return false;
+	}
+}
+
+static void dualpi2_read_ect(struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	int wlen = skb_network_offset(skb);
+
+	switch (skb_protocol(skb, true)) {
+	case htons(ETH_P_IP):
+		wlen += sizeof(struct iphdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK;
+		break;
+	case htons(ETH_P_IPV6):
+		wlen += sizeof(struct ipv6hdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK;
+		break;
+	default:
+		goto not_ecn;
+	}
+	return;
+
+not_ecn:
+	/* Non pullable/writable packets can only be dropped hence are
+	 * classified as not ECT.
+	 */
+	cb->ect = INET_ECN_NOT_ECT;
+}
+
+static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
+				struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	struct tcf_result res;
+	struct tcf_proto *fl;
+	int result;
+
+	dualpi2_read_ect(skb);
+	if (cb->ect & q->ecn_mask) {
+		cb->classified = DUALPI2_C_L4S;
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (TC_H_MAJ(skb->priority) == q->sch->handle &&
+	    TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
+		cb->classified = TC_H_MIN(skb->priority);
+		return NET_XMIT_SUCCESS;
+	}
+
+	fl = rcu_dereference_bh(q->tcf_filters);
+	if (!fl) {
+		cb->classified = DUALPI2_C_CLASSIC;
+		return NET_XMIT_SUCCESS;
+	}
+
+	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result >= 0) {
+#ifdef CONFIG_NET_CLS_ACT
+		switch (result) {
+		case TC_ACT_STOLEN:
+		case TC_ACT_QUEUED:
+		case TC_ACT_TRAP:
+			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		case TC_ACT_SHOT:
+			return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+		}
+#endif
+		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
+			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	}
+	return NET_XMIT_SUCCESS;
+}
+
+static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
+			       struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct dualpi2_skb_cb *cb;
+
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
+		qdisc_qstats_overlimit(sch);
+		if (skb_in_l_queue(skb))
+			qdisc_qstats_overlimit(q->l_queue);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 SKB_DROP_REASON_QDISC_OVERLIMIT);
+	}
+
+	if (q->drop_early && must_drop(sch, q, skb)) {
+		qdisc_drop_reason(skb, sch, to_free,
+				  SKB_DROP_REASON_QDISC_CONGESTED);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	}
+
+	cb = dualpi2_skb_cb(skb);
+	cb->ts = ktime_get_ns();
+	q->memory_used += skb->truesize;
+	if (q->memory_used > q->max_memory_used)
+		q->max_memory_used = q->memory_used;
+
+	if (qdisc_qlen(sch) > q->maxq)
+		q->maxq = qdisc_qlen(sch);
+
+	if (skb_in_l_queue(skb)) {
+		/* Apply step thresh if skb is L4S && L-queue len >= min_qlen */
+		dualpi2_skb_cb(skb)->apply_step = skb_apply_step(skb, q);
+
+		/* Keep the overall qdisc stats consistent */
+		++sch->q.qlen;
+		qdisc_qstats_backlog_inc(sch, skb);
+		++q->packets_in_l;
+		if (!q->l_head_ts)
+			q->l_head_ts = cb->ts;
+		return qdisc_enqueue_tail(skb, q->l_queue);
+	}
+	++q->packets_in_c;
+	if (!q->c_head_ts)
+		q->c_head_ts = cb->ts;
+	return qdisc_enqueue_tail(skb, sch);
+}
+
+/* By default, dualpi2 will split GSO skbs into independent skbs and enqueue
+ * each of those individually. This yields the following benefits, at the
+ * expense of CPU usage:
+ * - Finer-grained AQM actions as the sub-packets of a burst no longer share the
+ *   same fate (e.g., the random mark/drop probability is applied individually)
+ * - Improved precision of the starvation protection/WRR scheduler at dequeue,
+ *   as the size of the dequeued packets will be smaller.
+ */
+static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+				 struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	err = dualpi2_skb_classify(q, skb);
+	if (err != NET_XMIT_SUCCESS) {
+		if (err & __NET_XMIT_BYPASS)
+			qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return err;
+	}
+
+	if (q->split_gso && skb_is_gso(skb)) {
+		netdev_features_t features;
+		struct sk_buff *nskb, *next;
+		int cnt, byte_len, orig_len;
+		int err;
+
+		features = netif_skb_features(skb);
+		nskb = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(nskb))
+			return qdisc_drop(skb, sch, to_free);
+
+		cnt = 1;
+		byte_len = 0;
+		orig_len = qdisc_pkt_len(skb);
+		skb_list_walk_safe(nskb, nskb, next) {
+			skb_mark_not_on_list(nskb);
+
+			/* Iterate through GSO fragments of an skb:
+			 * (1) Set pkt_len from the single GSO fragments
+			 * (2) Copy classified and ect values of an skb
+			 * (3) Enqueue fragment & set ts in dualpi2_enqueue_skb
+			 */
+			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			dualpi2_skb_cb(nskb)->classified =
+				dualpi2_skb_cb(skb)->classified;
+			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
+			err = dualpi2_enqueue_skb(nskb, sch, to_free);
+
+			if (err == NET_XMIT_SUCCESS) {
+				/* Compute the backlog adjustment that needs
+				 * to be propagated in the qdisc tree to reflect
+				 * all new skbs successfully enqueued.
+				 */
+				++cnt;
+				byte_len += nskb->len;
+			}
+		}
+		if (cnt > 1) {
+			/* The caller will add the original skb stats to its
+			 * backlog, compensate this if any nskb is enqueued.
+			 */
+			--cnt;
+			byte_len -= orig_len;
+		}
+		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
+		consume_skb(skb);
+		return err;
+	}
+	return dualpi2_enqueue_skb(skb, sch, to_free);
+}
+
+/* Select the queue from which the next packet can be dequeued, ensuring that
+ * neither queue can starve the other with a WRR scheduler.
+ *
+ * The sign of the WRR credit determines the next queue, while the size of
+ * the dequeued packet determines the magnitude of the WRR credit change. If
+ * either queue is empty, the WRR credit is kept unchanged.
+ *
+ * As the dequeued packet can be dropped later, the caller has to perform the
+ * qdisc_bstats_update() calls.
+ */
+static struct sk_buff *dequeue_packet(struct Qdisc *sch,
+				      struct dualpi2_sched_data *q,
+				      int *credit_change,
+				      u64 now)
+{
+	struct sk_buff *skb = NULL;
+	int c_len;
+
+	*credit_change = 0;
+	c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+	if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection_credit <= 0)) {
+		skb = __qdisc_dequeue_head(&q->l_queue->q);
+		WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
+		if (c_len)
+			*credit_change = q->c_protection_wc;
+		qdisc_qstats_backlog_dec(q->l_queue, skb);
+
+		/* Keep the global queue size consistent */
+		--sch->q.qlen;
+		q->memory_used -= skb->truesize;
+	} else if (c_len) {
+		skb = __qdisc_dequeue_head(&sch->q);
+		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+		if (qdisc_qlen(q->l_queue))
+			*credit_change = ~((s32)q->c_protection_wl) + 1;
+		q->memory_used -= skb->truesize;
+	} else {
+		dualpi2_reset_c_protection(q);
+		return NULL;
+	}
+	*credit_change *= qdisc_pkt_len(skb);
+	qdisc_qstats_backlog_dec(sch, skb);
+	return skb;
+}
+
+static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
+		       u64 now)
+{
+	u64 qdelay = 0;
+
+	if (q->step_in_packets)
+		qdelay = qdisc_qlen(q->l_queue);
+	else
+		qdelay = dualpi2_sojourn_time(skb, now);
+
+	if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step_thresh) {
+		if (!dualpi2_skb_cb(skb)->ect) {
+			/* Drop this non-ECT packet */
+			return 1;
+		}
+
+		if (dualpi2_mark(q, skb))
+			++q->step_marks;
+	}
+	qdisc_bstats_update(q->l_queue, skb);
+	return 0;
+}
+
+static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
+			   struct Qdisc *sch, enum skb_drop_reason reason)
+{
+	++q->deferred_drops_cnt;
+	q->deferred_drops_len += qdisc_pkt_len(skb);
+	kfree_skb_reason(skb, reason);
+	qdisc_qstats_drop(sch);
+}
+
+static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	int credit_change;
+	u64 now;
+
+	now = ktime_get_ns();
+
+	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
+		if (!q->drop_early && must_drop(sch, q, skb)) {
+			drop_and_retry(q, skb, sch,
+				       SKB_DROP_REASON_QDISC_CONGESTED);
+			continue;
+		}
+
+		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
+			qdisc_qstats_drop(q->l_queue);
+			drop_and_retry(q, skb, sch,
+				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
+			continue;
+		}
+
+		q->c_protection_credit += credit_change;
+		qdisc_bstats_update(sch, skb);
+		break;
+	}
+
+	if (q->deferred_drops_cnt) {
+		qdisc_tree_reduce_backlog(sch, q->deferred_drops_cnt,
+					  q->deferred_drops_len);
+		q->deferred_drops_cnt = 0;
+		q->deferred_drops_len = 0;
+	}
+	return skb;
+}
+
 static s64 __scale_delta(u64 diff)
 {
 	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
@@ -167,8 +629,8 @@ static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c,
 	u64 now, qc, ql;
 
 	now = ktime_get_ns();
-	qc = q->c_head_ts;
-	ql = q->l_head_ts;
+	qc = READ_ONCE(q->c_head_ts);
+	ql = READ_ONCE(q->l_head_ts);
 
 	*qdelay_c = qc ? now - qc : 0;
 	*qdelay_l = ql ? now - ql : 0;
@@ -254,7 +716,7 @@ static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
-	q->pi2_prob = calculate_probability(sch);
+	WRITE_ONCE(q->pi2_prob, calculate_probability(sch));
 	hrtimer_set_expires(&q->pi2_timer, next_pi2_timeout(q));
 
 	spin_unlock(root_lock);
@@ -555,7 +1017,7 @@ static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	struct tc_dualpi2_xstats st = {
-		.prob			= q->pi2_prob,
+		.prob			= READ_ONCE(q->pi2_prob),
 		.packets_in_c		= q->packets_in_c,
 		.packets_in_l		= q->packets_in_l,
 		.maxq			= q->maxq,
@@ -673,6 +1135,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.id		= "dualpi2",
 	.cl_ops		= &dualpi2_class_ops,
 	.priv_size	= sizeof(struct dualpi2_sched_data),
+	.enqueue	= dualpi2_qdisc_enqueue,
+	.dequeue	= dualpi2_qdisc_dequeue,
 	.peek		= qdisc_peek_dequeued,
 	.init		= dualpi2_init,
 	.destroy	= dualpi2_destroy,
-- 
2.34.1


