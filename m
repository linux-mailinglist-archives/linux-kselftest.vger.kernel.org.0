Return-Path: <linux-kselftest+bounces-38239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71EB1A142
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EA16626D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C2258CF2;
	Mon,  4 Aug 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SLAOF1L5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91525258CEF;
	Mon,  4 Aug 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310049; cv=fail; b=QQEWfSnVYj1WbxUhZy5uqgbJQoY6NQuM7HlxQkmd8Dbnya5d5N2ugWWCamMbk9/pz74DW9ZllA+4P14GivruqH8Wru199vggNEc0sYGSdzG1NxmR+jgY2e+G5pPNlyha5pzyfzT3gDcZt9nVr7HXRxbIW9xwCSOL+QRTyZApx4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310049; c=relaxed/simple;
	bh=xfz4DpUZEVusoPXIUjDP27jSKWSYMSfcDWFGdBEqd+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uH6zX/0qVYHt+HnZAhOsVRbJuRp9As7+Evk/TjSBXFHfD7cFZzrlmRnbilwCQfPZWLmMNgBmOrxj8dN6S5Vt8gqZ2tpO7Vxhos3aeSx/+PZH4XDOYBKV48GufHYnxhoga3TQqfAu7X3KcABOEoGTq51eQjiAVy1wEj2GsDf+S4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SLAOF1L5; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeo/hT8l1WQ0W2XycqNTjIzuzW1CvQ1kiWyMnXN7i+NjliIikozW2GSAiji+DBiNUHhVMHl2JYBso55TSZpPYKBPgxOYwMahbV6ou8O+IdN3e6NW95eOlYe61j4I8mvXOESJ+ZEc6ogRAuqRNoxfF3RtvHGvYxMc3SJHqWzuGb5mQWDFUEigp+ZVO1BOHSvCqyW+U1PnRRMOiJS37EDX9sWHoHBN7iVPXDwFGuMPKSAg5L7hxzqy2+BvLsIK2LmNoYZEOwoNTSB398sUq2EGRiS58QhP3fB4acTD+AzOzmrSeR8zwXACbGGL1yKkUYl0ZKYPQcsIh4d2Svz2UaBFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/tP2H0sJckkKoJ68u4R2tICGb4xN2TVNx4fH46FQRQ=;
 b=HKzS5hB54JryBGHX8dMhaXphrOYq7UUzqXJc5C3D8BxNyWw1vtXJQ3RHJJXITQEeF5QsezHdPSzUL3KnVsxxtWCvXCO4SRUL0jPo7X89rgyf4RZ2jyxqJyvH5VkWur629XCLOUYNAIVevzFlUBTqbEWBbx2iRHiOPTkf+NWXonfHRrqcsHndAWPQdsNwyyN+csikmD2/Xn2Y/FrnY7jvyBT1onpiUBD0kCO0xADYMNabEH5zcg8vtiV505a1KX4qNNQWK3Ur0uxmkKfGz3TgieQ015uLKst9cy2cpuqLx2tcOCq4VhR0Y1PNAADVAg4FI8Z+CZknZ70x8awwPtStwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/tP2H0sJckkKoJ68u4R2tICGb4xN2TVNx4fH46FQRQ=;
 b=SLAOF1L5iHK64RPkvzdEBwj7ejkIVi8WgcAazvY5EM7eoBvrN+ftmawDyQhQeL0TwwlObJF8amKYdZtYuPrEn112J0EDcBdrMe6HbXx4mDxu/8d4rw0rxlDTe3t2vMvu1B/AGKH6Nl0L4fVDCJKOzMvtMka8xc8IO4A42ALCEzvp9k1p7XzO5Zk85T6w/P4cDbU2WpdaGRmG2K1tnJebHtXoohBUxoCGxqaAoA0+l+f+Xi5WYAaVmB5zbsOVa3t1gCJ4wFmvs+G+OXSgEk5cdmbqLJygGbGhRlPIdXX5pg+rjNU4Jd0uYig9Cgd7h2Uf1ptU33NfiyCfne37Rsz88A==
Received: from AM0PR02CA0109.eurprd02.prod.outlook.com (2603:10a6:20b:28c::6)
 by VI1PR07MB6334.eurprd07.prod.outlook.com (2603:10a6:800:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:20:44 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::2d) by AM0PR02CA0109.outlook.office365.com
 (2603:10a6:20b:28c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 12:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 12:20:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id BEDA568003C;
	Mon,  4 Aug 2025 15:20:42 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	alok.a.tiwari@oracle.com,
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
Subject: [PATCH v12 iproute2-next 0/3] DUALPI2 iproute2 patch
Date: Mon,  4 Aug 2025 14:20:16 +0200
Message-Id: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|VI1PR07MB6334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48627ba0-4945-4901-8afa-08ddd35155e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HH1+X3fNSJgcBTWRn2EQ1FYl73OlWGRu4I88p4+ANuRX0A/99rNwfcvBrVc?=
 =?us-ascii?Q?TWss6OjPPgTQHlsJ2/v2HGvXeYT43e53gnMb3XUkbMB06Tps0G0Due2PiCEa?=
 =?us-ascii?Q?6gvW6Gie7aPakfgHyKuA/M8tSgmGu9wUirv5RKF/OxaoIH4rA5bEtg93wFim?=
 =?us-ascii?Q?E9K9gA+ZK5dapiIfeietWI6/bYE4+EjvyxDQ/JOc13W4cRFE2c0GwklR1XHP?=
 =?us-ascii?Q?klvqF30XU0Guw6LcZt6mMrDr3c5tJELpjd3CbhpdIcwW0Wgj7SREeBdG2Tq+?=
 =?us-ascii?Q?d2oGZ/JgM0s/NqiVir8ZRDe/7Ocp5rZtcvqKgv+zId5k5C+gSZZyq43miDL7?=
 =?us-ascii?Q?yQ/eaP2+HTbWbR2yNWwWlY0SKBqHmjJaFLAWJkbQdZTBCbbj45ZbtmPHhDxC?=
 =?us-ascii?Q?LyX44ij0V/L/idJMj70y7q91IoAu+N1+W8RnVZqvqXks60+M04ioC6ystjbA?=
 =?us-ascii?Q?diqxpDvpHHpPNCsK9R5Oo4MGSIhIq3HqNC7/JDYvfBCZtkMVO0hZmgRZvGjg?=
 =?us-ascii?Q?f8uVi4nzarx3r/JmF6lTht495VJGMQTRfCYQ4K7e7NDBxRFA5bcYo0OYlIrB?=
 =?us-ascii?Q?Pt2ODa+sc0UTyHT561QOefQd6UVdu1uk6Cu6F+Ew6JJeAlPfek17Xv6Z+NSJ?=
 =?us-ascii?Q?f6LbBXgTbicX0SRWsp9+k7g1+kB7V2ErejPZR2zfTHuOJ2/zMsikS375ay4L?=
 =?us-ascii?Q?YBud1sHfJpZ9kk1itw5I1Df+rZromKVb3Rdcjm7/ZJnfLig6OeYgd24O69q2?=
 =?us-ascii?Q?dLVHo2FAKMW3WbHIpLnAtI+6O7LcrQ3+M/O9H6YKLi1iY38oYLLfNzExfGZ+?=
 =?us-ascii?Q?sLLNnlfFtxkoa+dpte5kpSpTLgzAmKEKncLHb78E3CD87/oyy5Zv4N+9zov0?=
 =?us-ascii?Q?SJj/B+blJXY/YpDrTF8wyeopIS4h097AozCdr8AcL/cYNeVV7dIvE4OFvDSp?=
 =?us-ascii?Q?dlYYuPYjIGk5+18T/etf/PQ8JuG9C2Jw5NtiHocghxcNA+hFAy1z5ueC9iKX?=
 =?us-ascii?Q?FadvBR4JxVqf9tcLXg6jBQvO1SqNl9yPzIgF4KahncXeo4d/OaS132T0UNTO?=
 =?us-ascii?Q?6bbQHAxgEtCwgyIEwPzdmce7gSphScAfHgNnbOpqQgGfZ/CPAL062uylO3x9?=
 =?us-ascii?Q?3rUXmVguufg6Q0E7wD+TYVmqQq2isPxq6RpqyChuypU/t0zI5ErNYy/HT5jG?=
 =?us-ascii?Q?bf5WDSm4u+Y+jIGjYr7yLsj2HIaZwPmslchGRpECC16vrulpeokPpzQKU+FO?=
 =?us-ascii?Q?tppjWf8pdhZfzrtx1RG5qioQe9IVKY240NpKEGMRbgWtE6PrSV1UGvd/DTJb?=
 =?us-ascii?Q?iuYOHXhB4ZIssQmydRHl62JwLVHYWKifWhOjc9Ox969AkTLvZkSnCAihSjz1?=
 =?us-ascii?Q?+SEOcvguYI1FeKDQT13iz6yI5EMjw8qnICM4z8mJ2MPJHaHYGz9QskWpxN6P?=
 =?us-ascii?Q?ri32VAoX+62FIPagFun/sRODH/0/rnP0VVQOk6CW/UNsmxKjQ1RDQjPAwudX?=
 =?us-ascii?Q?YI9UGCw3trw8w4PL2vx1RcUGw2B6EjgOoY2s4bii3vKTM/ocNrvoUoSNRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:20:44.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48627ba0-4945-4901-8afa-08ddd35155e5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6334

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find DUALPI2 iproute2 patch v12.

For more details of DualPI2, please refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

---
v12 (04-Aug-2025)
- Split into 3 patches: one move get_float(), one add get_float_min_max(), one for dualpi2 (David Ahern <dsahern@kernel.org>)
- Repalce matches() with strcmp() within get_packets() (David Ahern <dsahern@kernel.org>)
- Apply reverse xmas tree listing of variables (David Ahern <dsahern@kernel.org>)

v11 (18-Jul-2025)
- Replace TCA_DUALPI2 prefix with TC_DUALPI2 prefix for enums (Jakub Kicinski <kuba@kernel.org>)

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
Chia-Yu Chang (3):
  Move get_float() from ip/iplink_can.c to lib/utils.c
  Add get_float_min_max() in lib/utils.c
  tc: add dualpi2 scheduler module

 bash-completion/tc    |  11 +-
 include/utils.h       |   2 +
 ip/iplink_can.c       |  14 --
 lib/utils.c           |  30 +++
 man/man8/tc-dualpi2.8 | 249 ++++++++++++++++++++
 tc/Makefile           |   1 +
 tc/q_dualpi2.c        | 535 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 827 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


