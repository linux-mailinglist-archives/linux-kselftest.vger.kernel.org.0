Return-Path: <linux-kselftest+bounces-34912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C614AD9181
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E223BBF32
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6D1F1909;
	Fri, 13 Jun 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZnVqPrGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581F1F0E24;
	Fri, 13 Jun 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828999; cv=fail; b=d8C2ktgfPnK/xCAu3JEK5tQ4rwp85cBet814lcjpoEoHGS5ZDevaRW1GPFLES37IB2mRN2duqTquY9Zw/VVjD6vnbSDa9s+Te0mQD2lV2fMDS0qMmVXIrsAR4oQx4yxXI4ixMXbsqv7iQrYMySJjKASE/PW1sV1SSukhjsDscAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828999; c=relaxed/simple;
	bh=AhB+Kv8Nj+mHoy9hs2J+/aqBxmb5vM2pBufGOc7wNIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gRi0RGxMqTlGuvkBpC8NqGQ69/ZtWKxmnxr6LuC4L2RAVcyyGsaZBC/UHXBmZvHpJDx9I2VfOqEoloiUGUOVunkW5q2GD+dOMi/tNNKxu4ZHGJumsQGdASD11tYUwtRXXYHEyMH/BbLSbRIoJf7VyI1oWbFJwLQF60KLhhtx5Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZnVqPrGw; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7n6fmmM2p4zM13+Ek3ZC1E2/N8LrhR6oDv8H5ok/+AdygHQkogVuqfwub4VhJHKnNQK3aG0LjvzvqarJKIGzTLQbCMxfFJWnudsYfMXGkxGnV/PuT6KmvL8Rr9lBLwO+kjMzcAKSIsRRG2SVsXmnKISxxa1h0GQjGAbiAvVbV5ioNrcR1ivSt+TITU28G4Dudw+wvRUvbHgcSBesjOEwidZ/B9s82QVr50OK7pBflPAi5XSOQsQFQfJbguhrBl8+AQZbCfDuzW3P9xWt5WV/rFAVRKHw2ZA7wdCjX93Mwer4rRb9tYUdrdQVVcGpF7Q5dxE22UrpUB6LPNbKBaftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuHv1FXOgLnYZKvDSnWzZ/qOpgSSMX0EEAAbBDmlXrs=;
 b=mHle57uLBCm9C1XFAa1XrZ8gi009ekVJx2mSguCSCs+nRukQRxdYvIX9h3tcsHHT6JoZC9XAath/jrV91SVbiAWjr/V+S+rwIYApc6j5XlLOwCi0pGLa9iU4RPAb/bkdTA6WnDens1wl92sjrYibn8e5DCrCfGw2ITxvRis2Rs4NLMqqESqwWi2M0oIp3+jrxQXvVn8FAqq2oz3k2diq9fYuAF7MbhAjk1qbEsUstAKjk4usbs7o+fRoJywdWbsU/QloqTGiKB3NcIfxHgjBfPUI85vhotCD7OET/2DkKxE/NXXhNdM+Wg+twLb3IDDYhUFH0A3TSDLxOh24pqzreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuHv1FXOgLnYZKvDSnWzZ/qOpgSSMX0EEAAbBDmlXrs=;
 b=ZnVqPrGwcyEaHDC/844bXoik/34hikYy4FQp4iumM//63f1ht7T8+a4Zz4mdyFLtwLIvsNEvNs1dYMYZaGmNoG6y9EUEIE16PduHQb0gfcnjvrA9VWYz1DHyHT/kTzseuSBKxTabLdv+o2VJjRe9NN4fsLvcxlpqcoduhYvjkPjFk0CTO8lZBelQRcyjgBM37sU3Q1h/i/EtNO+AVZGz8AdNvFQfJoK3nyLoK5OPNTrB8Vnjs/J/SJ5//ehOmGQQ/kUXRhXnxpJ1oID0IXNgZVbqJoHfZL5xOd8ybGZv9ME7LWvJubB6zomK0W8HsnDxIdbvCpzFdHu6XLSijkQieQ==
Received: from DB9PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:10:1d9::27)
 by DB9PR07MB7065.eurprd07.prod.outlook.com (2603:10a6:10:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 15:36:33 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::8a) by DB9PR02CA0022.outlook.office365.com
 (2603:10a6:10:1d9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Fri,
 13 Jun 2025 15:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Fri, 13 Jun 2025 15:36:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 14B8B20176;
	Fri, 13 Jun 2025 18:36:31 +0300 (EEST)
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
Subject: [PATCH v9 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Fri, 13 Jun 2025 17:36:28 +0200
Message-Id: <20250613153629.7965-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DB9PR07MB7065:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9e7d59fa-9fd8-486b-1baf-08ddaa9012ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3R4IvAaa/hluJhdxrj4tPXDfxEtU7n+b30a6K4dC5Bfd1aDBF9WpHpTkKmg?=
 =?us-ascii?Q?Lg+VYfbYiWZRiwMtRMb6Q5FX47zbHEk1kMHaBlRx57YJM+tSUyimcCNjlecO?=
 =?us-ascii?Q?J3aJUaRoSPXJWMJEaqvsNf+umoKAfL6LFn/+iAuATJtenB+ZSBzRUmppBuIu?=
 =?us-ascii?Q?Fzl/Oya/9Q40NQRtFC9fDcRT99bJefIeKxBwXChz0A0/m62nK76NnEs5CLuD?=
 =?us-ascii?Q?8CU+hLyQkIHfAYjWhQVr5GR3rfl87MFRRTmhj2sHg2kZ7pfBYkwbqbjwhRgH?=
 =?us-ascii?Q?WuPNZuQLVpmgsG98IXVgKh2ZXEgFQfAxGyzUUk5xRI3OAkeSrbG4P9UWWKVe?=
 =?us-ascii?Q?KtlhByNTJUvm0nhtZY04D+kLYY9o6zvmg9iC3+PHkZ+V7cTOVXJ2LvWeH/Nj?=
 =?us-ascii?Q?XzREcKOOkqFO6WsNcf/FXFawr2gjAAhzudxyh/zZK7EEBvG7Pt1rb7tElyaT?=
 =?us-ascii?Q?hh/CUlcv3xGWzhS3uelrLHoUI9HOBhClmjsk1R+Z1x9L3ZH+/fORUcFW5eu6?=
 =?us-ascii?Q?UglxZPcyxGp/GRndhyihYhPWFpz0rLiMkS3pvyPGiWwOk5aOi2y+8dbwTmDM?=
 =?us-ascii?Q?5PBMx0m/Zd1SaIgky5GVX1gfaa4M+DIBO34qIbFlM7orpV3Q8StvkdanY3ur?=
 =?us-ascii?Q?HO1yybvt94Z0UisxpszAkv0rDQJJAs8tFc/+pDoMHRs7dMVCVcNhBSm3eKel?=
 =?us-ascii?Q?N2XFOrJ7k1iShVc/bPTCHHPmtzKQVHK7aQHFCIQbOVEd++yUHop85bxBjINC?=
 =?us-ascii?Q?Xqd1mrAmImU2Y2lyqJ36Ur2WwKA/oNW3cqEDlj6uS1VVbvfWu7mN8n6xHsmp?=
 =?us-ascii?Q?vNPf/1yVI6GxZSzHpltRxrVi1M53HNg/tYARORukSpQo0iYVIFacbf0gDRX5?=
 =?us-ascii?Q?6AFB52OIDWQ38jlTMTz4YYfs7snCU0bIc6Lj57y3DO6gjU8NxirA/3SVUlhB?=
 =?us-ascii?Q?kRx3mvUOZvUTLXqocDmQX2nIEUbyAK+8ZFpuhXSN12WoMjeiMT/bdE2m7K36?=
 =?us-ascii?Q?w6Mx6xKXABGYlMQK3Yo37Hiqr4jG0527vhM8g3K+9/oadFtJLQToFFrNcETs?=
 =?us-ascii?Q?97+Pd4MfmveyReCPZF/6B+9Pf1krjyNLRipeg+4mTVMyzkInLPQP2047Damm?=
 =?us-ascii?Q?pjVXcj3TWcIrJF+kf3WPk0J3htCfJJkxaEvIfg6BpTLB/E4nzYAULjVbI1nn?=
 =?us-ascii?Q?einNlE3bcm7IqXg/SyTGHcCfv/G+5HIK5ILLiGBSK9pZln6X5tSjwwUpMmZK?=
 =?us-ascii?Q?mCRPtusWw8V+4vy/f2LTcSIOHnRrQen4SJ3chaIdx9Fh5bUFJi/6sqGwMXlv?=
 =?us-ascii?Q?1wgo/P65oDmCh3Eu3ZON4P6K40d08QIToTolQYOdW6eaVzMtS2kzB7PGU/aJ?=
 =?us-ascii?Q?B3zhNxkOq5XfANyksnHMRVs504XSfEXqaz91A/Zq4d/xhsP5KBlClgN16JB3?=
 =?us-ascii?Q?638sRGN3VtRv1bLcAOgmtGVH5DWD9LtpBLo/kxPbCzuCLZ9HPxMHfzRGRmhb?=
 =?us-ascii?Q?PTiGvvPHrKAmUd5OSzNPQhlTcAm1dvYsu8ui/QZXFOJkCSw6nW/a4OHDRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:36:32.5096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7d59fa-9fd8-486b-1baf-08ddaa9012ef
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7065

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v9.

  For more details of DualPI2, please refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

---
v9 (13-Jun-25)
- Fix space issue and typos (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Change 'rtt_typical' to 'typical_rtt' in tc/q_dualpi2.c (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Add the num of enum used by DualPI2 in pkt_sched.h 

v8 (09-May-25)
- Update pkt_sched.h with the one in nex-next
- Correct a typo in the comment within pkt_sched.h (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update manual content in man/man8/tc-dualpi2.8 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update tc/q_dualpi2.c to fix missing blank lines and add missing case (ALOK TIWARI <alok.a.tiwari@oracle.com>)

v7 (05-May-25)
- Align pkt_sched.h with the v14 version of net-next due to spec modification in tc.yaml
- Reorganize dualpi2_print_opt() to match the order in tc.yaml
- Remove credit-queue in PRINT_JSON

v6 (26-Apr-25)
- Update JSON file output due to spec modification in tc.yaml of net-next

v5 (25-Mar-25)
- Use matches() to replace current strcmp() (Stephen Hemminger <stephen@networkplumber.org>)
- Use general parse_percent() for handling scaled percentage values (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 stats (Stephen Hemminger <stephen@networkplumber.org>)

v4 (16-Mar-25)
- Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step marking.

v3 (21-Feb-25)
- Add memlimit to the dualpi2 attribute, and add memory_used, max_memory_used, and memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update the manual to align with the latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2 (23-Oct-24)
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

---
Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  70 ++++-
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 +++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 534 +++++++++++++++++++++++++++++++++
 8 files changed, 895 insertions(+), 16 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


