Return-Path: <linux-kselftest+bounces-37810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C9B0D670
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FA05483EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F622E0922;
	Tue, 22 Jul 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rsZ0Wfdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012071.outbound.protection.outlook.com [52.101.71.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA52E06ED;
	Tue, 22 Jul 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178373; cv=fail; b=XzGOWRZT32qswOjn2/bUIRr1DfXafcrWCcqw2SwXTUSyxP88B0N/yrxPVjLboY5HhizvgH1IImWVg5P4W6AM7lJndIHU7r510ZqcIErbyNnIPFGSffGAtAYTyr6pclA4EmqNnOdnw5spzY+h2HncxkCiaa1qFVurLd4dUwDaR/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178373; c=relaxed/simple;
	bh=1oxiu3mvJ/02N0o0KyO9tXXefOO0a8A4rTMQIFQXeD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZY2/nck76SuAFZgM6umwJCIEfoFig0PAeohmX7b5jn4BwKm7Ynz8NbLxn7rDC6/NRtoQHby4oSPoCuqr73WCBlLR71dVOOfNrgxda7hi+tUmWcwO25Ef7olwFu6/zUHd/e+r7LGcPKi0omB3Fpj9YGI2yr9F4ITU9bUpC/I+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rsZ0Wfdj; arc=fail smtp.client-ip=52.101.71.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC/SSWbLGzaknCZS5HNhZnf2WTdQAPOmZIWkhbHtaEEcd6hecUPvqZxSR61CGTywWI9SAl7/RzP/YkxYwA1+Cd1TpenkQygcm1jysclCc0mkCP+9Rk0bDqW8lCwWnhFawb4ub+CrZ1JJ7aEIYqOsZeEoWFvT6iGZoFktc+gUFFejVITuyJgV/cNIKYBUo7APa8eTTlM1zRCW+rnLkDFtKB1OvFgIXVUQT/E4wjJ+/+cg+iLNixkIo/6/jx/cGAVTcthVF+boem/ddy9CwOLAoz7yaRcPHECMWtGQhJaGrTRZKm1tZcEJneUHIRLNgL4Q5ZPbVfnw3VDfRslaUOSqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwaD7zZQXeIcCVUeRL0PIFsv1jb3GT9x3Pvw6MNIhm4=;
 b=DoY3KlBJBBgNvVcJd9nftMjEpj9dpmMsX1KPoK7JRObm9qg4PWvDuAbGSZ6VZdjt4AVcN9A/C3OURpHuQVUzDwiVHEh7twifIQvy6eL4CvbrtOS5wPWuFaKWLOgiHuNrJrma88zl+qS1FEHZAsRJCYefvhro73CmKv3eR7G+EuCvUZr4LRU29AsNXcaIBEfk/nznGokv9bXP3JB7jU4JBdKd2Z1LXCKzU1KDYRfqwPxdWNL9t50Nsiq5aH+35BRuwniKO5fqj6+11bIGeAX3FnbOLEhrX2vsm1hOOzwVrqN7YTekCafk63T8mgegFq/IcviBJkdWtsYv2t2oZcSHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=albisser.org
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwaD7zZQXeIcCVUeRL0PIFsv1jb3GT9x3Pvw6MNIhm4=;
 b=rsZ0WfdjKQg1Y2PZuKv35FJoWszigP9YbOZoErTdGTZ5AV8L+JD23cm/w2F8yEMYcxZlyI0k9LZOtpbSiGNfpsDrHy4xFU0PSqpdA2HeWDYJzzyAVduwG4lXpviNFlvqJZt5LGkGs5NY9m58ZMBynbJF22Q32QRjcg0qOe7dgchWwcgwSdNUJpcprWRXuZbEzAbNoz/bKM+hWobMjnYDV2MvYJrvP+9fvzxejE/xRF/SxdBXfj0dpnJyJKsNh7oCVuxsjnrnXlyjQsyjMgBr3UKY5aE2fN3Cm0PAn10+Pq7wHDrIVEUjRtGj0HfIffJz4DdBD+qvMGE0VHUg6UWK6w==
Received: from DB9PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:10:1db::24)
 by DB9PR07MB7705.eurprd07.prod.outlook.com (2603:10a6:10:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:24 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::9f) by DB9PR06CA0019.outlook.office365.com
 (2603:10a6:10:1db::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 90C8E68005E;
	Tue, 22 Jul 2025 12:59:22 +0300 (EEST)
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
Subject: [PATCH v26 net-next 3/6] sched: Add enqueue/dequeue of dualpi2 qdisc
Date: Tue, 22 Jul 2025 11:59:12 +0200
Message-Id: <20250722095915.24485-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|DB9PR07MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: cac33895-4e07-4632-9eb0-08ddc906700e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFNjTmowdS9tTXNpeVovWUtsUGl2TXJ2MnZpL28xSlErckwxRUU5YmFRS3ZR?=
 =?utf-8?B?Q1NSMXNQdDcvN2FISXBoRjU2cUJhbS9tZXptSDlYTnBTQ3ZGVFJPdGU0UXhB?=
 =?utf-8?B?TitxRlRWNVhNK202cTY0WndpazhzMjdIU2J1TWsxcFdVdUhGRFovaklmckFY?=
 =?utf-8?B?d1BrS1lERXRyRFRsSjVLdUdDWlpiRlUxeDJHdDFjMVZ3aEV3cmNPaTkwWUxa?=
 =?utf-8?B?YVI1ay9XcHlLZ3FxbGMydGJJU2xVVUVMVGhqa0tnRVY5VjRUMEJLaTZKVFhz?=
 =?utf-8?B?OGVteUt0V1lJblVtU0c4Sm1YazZxZDBTQlVod01aUlFrMjBqMWtmUFB3dlFy?=
 =?utf-8?B?SDdnb0NtMmRrTVR0d3RvaHNwelVHc3hWVEhOWFFyYWFxU3h5RW5qKzgxT1Zp?=
 =?utf-8?B?SjVGbzZuRWRwYWxVektEMHpaMDlSL0JSNE41eFlsbE8vRkFzYW9mRUJKNmx2?=
 =?utf-8?B?ZzMyZjYxZmpvVUc4KytFRFRnQll4Sm5vdVpLaEVreUNkT0NKN3NtaGplQWxY?=
 =?utf-8?B?V1BMakZUYmVqOEFoclJ2eWZSSjU2N3BvU1JnYmQ1b1NFQzg1ZUlFS1BoTVVB?=
 =?utf-8?B?cmxuenZMMHN6S3NPcTRjNzdnUWNIRDBjZ2M3bEUzVWNWV3IrbWdrc3YrVTZT?=
 =?utf-8?B?K1YxSldMUjN0UTM3UHVxdTRNYjZlK3B6NFZOM0s2ZnlEOWthR0pGTzAxeGRj?=
 =?utf-8?B?VnlwMWtUM0hhSlFzU1RLN291Uk80MjFtN0lrSWRIY1Y1MUVtWXBkUnZ6ZXZr?=
 =?utf-8?B?T2t6emFkMll6M0YrSG1tRndnQzRQcWdEaXFtOVg0RS8rNXByeEFpR1pIS04x?=
 =?utf-8?B?Nk85akd2dmJObzcrdjd2K2R4N0FpTGsrTmFUaWRCNXBvbUM5UGdybHVOT01T?=
 =?utf-8?B?WnpnMmhHQXBzNW5ocmlJdnRwMFhpOTVwdWlTWkVHK3JvQjdadU00UkhNbEt0?=
 =?utf-8?B?TlZmUmhuMWdrSUlBcHlwbStsTTZLeFU1cFlkdVNmb3dZUEtLTjJONnJqVjF3?=
 =?utf-8?B?dHRYaEMxeWpzYk1BSG1FcWY1dlVxRmQvTURLNDFyekdiOUlJOHZIMmdoRzdz?=
 =?utf-8?B?bDFpN1J5ZCtxOU5XdzROeVNJZUZ4MG11eWNHS0dBTFhXUFlXZTRkckVzUlls?=
 =?utf-8?B?SlBEOGNIV2x2dEFvUFZaaEJPVGNEWlpOejFiN0tLWUdSbWw2YVpURy95Tm5Y?=
 =?utf-8?B?T2RrSE12RUNGMzc0OWkxeHNFcnRHSE80b0xBQjBYMHQxc2NRM0N5Yjgxck1l?=
 =?utf-8?B?dlpubThjcEtQNXU2aHJ1OE5zaWt0YVFkZEduL2JHNG5mejJOb3FLNWE2ZHpq?=
 =?utf-8?B?M3M1WW9abHI1djRUZjZoTUJXcjZ1L0tXWnVRU3NyR1haWUVJdHF2L2duV3dN?=
 =?utf-8?B?Mzc3WGVHTVdEaFVZZVI0RlNpL3plQ1p1eE1uNitRalJGWUlWSkxrRjl2eEFi?=
 =?utf-8?B?YjVlS1prREVVNWdQZElRbnRRK1lxNm1aQktyY1VUOUxhTnBjMSszcHZqanZn?=
 =?utf-8?B?dFMzUExHd3Z3a0crd1NRek5wUmFNL3RiQUxIRzlGd0xzRjZIejZQVUI4Rmgr?=
 =?utf-8?B?YTl2WncrMjVaWERBM3VSR3lyR0NrNmlGVE1MS1lRWGVWajRIZlNFTkFDSTJU?=
 =?utf-8?B?Q0RzbmhJTjRjWTlLMG1BdTlSN1RZb1BOYjIwMCtRbzRGajdpbGxvR05mcU41?=
 =?utf-8?B?ZFdlbEdIUi9NMkNiaE02UVM1YWhrb1M1RmtjdjA5dEFCVlYwMzZSeDNyUkYy?=
 =?utf-8?B?d1U0VEN4cWpSZHhwcElmbWFONFo3ait6MUlWRjg4UE84N1NmcjQrWUQyS1Yr?=
 =?utf-8?B?dE5tVjZHLzVJdFRiL2pTQ0d3RFdhLy9NMEJUem1hNlY0cmhYSDRpY1BjWFVT?=
 =?utf-8?B?R2hGVzY1MXYzU2VrZ2VzRTBRVEJXWUhDU040aG5rMEYrdlVMcnY3RHk1N055?=
 =?utf-8?B?clgxMzM5aG1DVXhWTEpwY1BzdWJ2eFRzdHlkMGpHWDRlemQzR3RxNTd2V2NI?=
 =?utf-8?B?SStuMFFjSG1ZdTFjMjdHUlhmcTBVdk1QUm9EWjdteTMxSElJb1IvS1dxd01C?=
 =?utf-8?B?Z0JtTXJ3OVBQNXlXSWtIclNla0E1SUw2VWVKZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:24.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac33895-4e07-4632-9eb0-08ddc906700e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7705

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
index e19184dd1b0f..d8ff24a33459 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -126,6 +126,7 @@
 	FN(CANFD_RX_INVALID_FRAME)	\
 	FN(CANXL_RX_INVALID_FRAME)	\
 	FN(PFMEMALLOC)	\
+	FN(DUALPI2_STEP_DROP)		\
 	FNe(MAX)
 
 /**
@@ -604,6 +605,11 @@ enum skb_drop_reason {
 	 * reached a path or socket not eligible for use of memory reserves
 	 */
 	SKB_DROP_REASON_PFMEMALLOC,
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
index 0a96d57c40d1..845375ebd4ea 100644
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
@@ -559,7 +1021,7 @@ static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	struct tc_dualpi2_xstats st = {
-		.prob			= q->pi2_prob,
+		.prob			= READ_ONCE(q->pi2_prob),
 		.packets_in_c		= q->packets_in_c,
 		.packets_in_l		= q->packets_in_l,
 		.maxq			= q->maxq,
@@ -677,6 +1139,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
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


