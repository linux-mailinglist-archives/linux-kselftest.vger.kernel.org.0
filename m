Return-Path: <linux-kselftest+bounces-33143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8DAB92F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A7E1BC6AAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009B440C;
	Fri, 16 May 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="npwZAunu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD182;
	Fri, 16 May 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353742; cv=fail; b=s8UAhDKcgmuiwo16bW1vvShILIiOePJQJmmRRlAb0qoqJIkISiqk+VJxv2yJizkuIyGYQ2dfbry91UPlPautoqJX+rZ7jel42ZtuUT/p8HRmUGA/8QU569irVAN80uGYvPC2oH+CIgS0g7/61UfjnnBcT1/hSwTLr3UdxPDQD48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353742; c=relaxed/simple;
	bh=ghfxC7SDUz6ae8TlI0e/3k1v9UDeOC8V+8fwLc75byc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujK6mkOw+e3s+KZTezoTOwxfImA9t2Bo0cMIs59CMPpRfQnHbyxgSSsc+dSiDvVGKNGH+flI6KnwM5vVAZPNJkYL9LNle8sXrndIVQSk4mb0VrETmCQT/rfov8EtNXi5hvSJKDHDD23nT7IzwjJicTCgGBYe1BTXrpBSiBKSBHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=npwZAunu; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKK0Jx8Ng4ZDT4EksciDdmTsaPbMWOu1vnFkJbrzDYAaYP8sinEPH/IGD9j3jGoeehXhHC4/lcnglo8x7K3KFAX9TGK6Q/B3KIRv1MACmC0P/HSZRYsbL8bvjO3HrjZlDVWQFOtPZ2zjdjsNVo8U8IZaUeNt2SCaJRvxVt9HO4vjGIuh/Bd9ufC0iFbcdVQuzq8tsjklcWYegoxx6TBohoAwtVyb44J1UXer8voZFC6N3liDlWvNQPH/el0sAmMQ+ZhEMEnxNOZkNWqkmRfnQqRVuTzxbQzhtQXJHK288mfoobYSiKDVBdVlrrgACkGalS5O1JAS9NFc5cNl5p7RVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkPurEkdr9yCqUj8X70w8AYD3ORTl/hRi4YrUeyu4Yo=;
 b=kTNlHBoRDJ2bMhLNKqYrw66+c1bNzQtWKoaz5+fjFeIZ3V5tls/3vbJNCuUOAlK7FvzwkdZLuEqWAulr+//8JY92OaIprkp+CkR0baUSBv3LLdyim/lOnSxn7JpFveUnkFPAUPdEcGIdW7fQqGKN5vGr7rH8TynEnB+eIWl7Ob04hG1jz++sQpgE2ccFktSmmgK+NYFzdLzXIfTtKt775ieDfOlt/FygYP5NddxwdroOniBxqnvym1wm6ebXHxNpjs4k2biwax/DLsoIEaZQYe2yJHfOYdsBv+r8JX0ZLi1ckOYDwNdgjT9kYpmGbN8XngryFu2/gKnVU9OWoFARXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=albisser.org
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkPurEkdr9yCqUj8X70w8AYD3ORTl/hRi4YrUeyu4Yo=;
 b=npwZAunuvNlFEhoRER1qhsumjouuD78ZcDBHaE6n+cEeTI4nnu4mnwZBAKhP56di3JE+UMK5IhduRutcldtnSYtvOJrO3/peLLqNe2Il3AdRz0VN5xV/RZrqjFaPpnmKjngkEgM1v7W90+7H0kgQ5j91bTL/20Y+3bNdHZCWe7YOrFc5cYI8yN9/3II5LRlkUWJc3QWz8QmFDCxC1xsnKlgGThZa1W9If4GlUuIQ/p79V47ZVmAcYFBj1+sYMDm2fmz+lF0IIzed5C+KD4rMkMQHs1Q7NHrLBevNQycKiphYVvur/2fwVWN00mgr2ZFBWOkvT1MtvMiyAWcdVGKlkA==
Received: from DB8PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:a0::29)
 by PAWPR07MB10070.eurprd07.prod.outlook.com (2603:10a6:102:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 00:02:16 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::26) by DB8PR09CA0016.outlook.office365.com
 (2603:10a6:10:a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 16 May 2025 00:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 00:02:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 556E7200BA;
	Fri, 16 May 2025 03:02:14 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
	Bob Briscoe <research@bobbriscoe.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v16 net-next 3/5] sched: Add enqueue/dequeue of dualpi2 qdisc
Date: Fri, 16 May 2025 02:01:59 +0200
Message-Id: <20250516000201.18008-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PAWPR07MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a51c98-b4c4-4dd6-d9ef-08dd940ceaf6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MU9jVXp0OGJBMjZnUUo4ZW5CcnJ5WVRhbHZQRk5FVlRHVGg1c3JXSXhGb2RV?=
 =?utf-8?B?U05FTm1tWndrczV6TnN3cDZKdDJqYXp3QjVETzBndmx1SmJKYU1RMzZlalFr?=
 =?utf-8?B?Vzl6OUJFeVB0RGVGV0lRc2VzSHB3SjZ1eDRBejBrU0p1VkVISXZFSUlRSnhK?=
 =?utf-8?B?Um12dnp2QTFOV2g5T3Q2YXpsM0pqR1YwSk1GcjQ3dENjeGFoZmdSMnB0ekxN?=
 =?utf-8?B?N3RQT3IxRlRIS0xhdytSN3pFcFBoQVdlbWFMNGdLc1hVcFM1S2JQekJuQk9q?=
 =?utf-8?B?bFRpbDZaZUMxc0sxU3NmTndPT25kcHNZMCt1N05rMSsvU1Y3anY5N3JaTEpO?=
 =?utf-8?B?L3ltaWtMUVIwUW1xcjdMZmovNy9jK0M5UnNlR0ZlMWl5enBPU1JRYlVFd1ls?=
 =?utf-8?B?bFhtMkdBNFY4ZW92WHFvaFN0aUFvZjhCd29idE0xc1RaUG8xN0liUTlmYjhY?=
 =?utf-8?B?NUVSOHJ5TkpkYUFXNk9GUW5EMm5XNE9yZTMzNmx0anljT1hPeWtWMXBlSTFI?=
 =?utf-8?B?QnllV1VreUliQ0tEWDl3QzlKSEZEZGxZU0lhOUZVekdGeGpCeHVtaGdyNk04?=
 =?utf-8?B?NlYrdEFOb1UreFZQRERSdFlOY1NqZUYyRW1QZ01RZDU2eUhZQlQ1cjdIemI4?=
 =?utf-8?B?M3NQM0pIcUc5Z0FmeHZIRVJkRWxyM1RpZnRJTTZaaUIvMG82ejVFRVNVamtP?=
 =?utf-8?B?ZStNM1RaWmdPa3B0N2RUSDhRMFo1ZmoyaGo0UFpBZmIyVHJKa2tsbVcyVURE?=
 =?utf-8?B?SmFNTjMrQjdja1YvcXVmSXJycWJKaXhQVWp5U1cxWlU3ckZxb1ZiNERkV09k?=
 =?utf-8?B?ekdwNWRiMXBrUWlYNk9KU2ZuVkxuWUw4THJhUkJwNjQ1dHJsc3cyRXdrcWQw?=
 =?utf-8?B?QmNucnVqSGdGWkQ5MkpWUFJXV1hTaitJTit6Q210aS94QzlHM1JzcHF6UjFj?=
 =?utf-8?B?Y2xUTmRCOFNIWm1ReWtxcTFKOElnMXF3dGk5bWcycDl3TXp2cWJOdW5SSjQ2?=
 =?utf-8?B?Y1ZrRENrcG5aZ0UzY2RzbUYrREdIOUFoUUpKei84YS9UWmh0bVpSaFlMT2lv?=
 =?utf-8?B?L1FFREc2NWlVczlWN2Q1RXoweHZLOFRMMjVLVWhGWlF2cVdhSkNaN2lUR1Js?=
 =?utf-8?B?OGhzVkQ0WW13WmhucVk4TVkxNnFaT0VZeWhLL3AweXBNNjRDK29wdE9iUzhD?=
 =?utf-8?B?MUFxKzNKT2NkMlFacVFxM2tXeXpUaUVaTXZkTkMvU1BxMW9rb1M4MkpZaXBS?=
 =?utf-8?B?MUthY3duSVdDdXdjbXhuVzE3QXR5YmtraUt4TWlzMXI0TGJnejR1QzlQNDhG?=
 =?utf-8?B?SmtpbmFvNlJMNm5qeXFaNGJzR0JpTkR3YmlPUHZDNEFISDExd3drdlRhS3By?=
 =?utf-8?B?eU1sSWRyby95emRYdzhjVTE4MWNRV2VxYU9pZHlHVHE5bVB1Y0J0QW5aQWQv?=
 =?utf-8?B?QnhqTTQwZ3NCVU4xQTRVcTZ3d3dBNHgvaWZSL3REU0NHRXExcXh1RktWNUZx?=
 =?utf-8?B?TWZsNzI0RlA3UFVNdzJrOWo5dGFjU0FIbjVjZVVjbWpZVFpFL1JOZE1DZ2tS?=
 =?utf-8?B?SXRvUG1ETWFwNXRKMjEzU3AwOC9tdlVVbGtEeW96U1lNQTllNzVwUklmR0lo?=
 =?utf-8?B?ZWVEU3E4WE1YN0hiZXJlZERUUVVycndGbHdKM3NOc2RmM2orb0VSN3g4bndE?=
 =?utf-8?B?dXhMVW5kQ29BdzJ0NE43aE5xUllsTVE1WTZiVy9OeW94UVBVdEoyRXNpN0Ur?=
 =?utf-8?B?N0s2c1NsRFhEaUszeW80YTFzR0pnS1l5TXVFQllZa1ZMS3RDSjNUdStmWUs0?=
 =?utf-8?B?MUtSYzR1Y0VXbjdDRWJzUmhYTXplbHNCMGlGMURqWEEzaWNoYWZKanRMTERN?=
 =?utf-8?B?NzNKSThKU1Rpa2VuS1BkL0tDWFJFWXc2V3I1a3A2K3NMNHdpc1hvQWVvV0xs?=
 =?utf-8?B?a2dSeGM4RnplRFJmUGhlS2pzQTBvTnNrWHhxMmFiSlY3d0Z4eVN5dHh2VkFz?=
 =?utf-8?Q?sA4jQeSOE0M+UrZXMz5IuSmWxn3H1U=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 00:02:15.7946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a51c98-b4c4-4dd6-d9ef-08dd940ceaf6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10070

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
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
---
 include/net/dropreason-core.h |   6 +
 net/sched/Kconfig             |  12 +
 net/sched/Makefile            |   1 +
 net/sched/sch_dualpi2.c       | 449 ++++++++++++++++++++++++++++++++++
 4 files changed, 468 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bea77934a235..faae9f416e54 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -120,6 +120,7 @@
 	FN(ARP_PVLAN_DISABLE)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
+	FN(DUALPI2_STEP_DROP)		\
 	FNe(MAX)
 
 /**
@@ -570,6 +571,11 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
+	 * threshold of DualPI2 qdisc.
+	 */
+	SKB_DROP_REASON_DUALPI2_STEP_DROP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 9f0b3f943fca..dda66a3590d8 100644
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
index 97986c754e47..7ecd7502332c 100644
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
@@ -136,6 +172,25 @@ static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
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
@@ -155,6 +210,398 @@ static void dualpi2_calculate_c_protection(struct Qdisc *sch,
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
+				  SKB_DROP_REASON_QDISC_OVERLIMIT);
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
+		/* Only apply the step if a queue is building up */
+		dualpi2_skb_cb(skb)->apply_step = skb_is_l4s(skb) &&
+			qdisc_qlen(q->l_queue) >= q->min_qlen_step;
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
+			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			dualpi2_skb_cb(nskb)->classified =
+				dualpi2_skb_cb(skb)->classified;
+			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
+			err = dualpi2_enqueue_skb(nskb, sch, to_free);
+			if (err == NET_XMIT_SUCCESS) {
+				/* Compute the backlog adjustment that needs
+				 * to be propagated in the qdisc tree to reflect
+				 * all new skbs successfully enqueued.
+				 */
+				++cnt;
+				byte_len += nskb->len;
+			}
+		}
+		if (err == NET_XMIT_SUCCESS) {
+			/* The caller will add the original skb stats to its
+			 * backlog, compensate this.
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
+		if (!dualpi2_skb_cb(skb)->ect)
+			/* Drop this non-ECT packet */
+			return 1;
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
@@ -644,6 +1091,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
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


