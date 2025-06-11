Return-Path: <linux-kselftest+bounces-34732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130DAD59EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351091882CAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742DB186295;
	Wed, 11 Jun 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n1iUCXTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337AA95C;
	Wed, 11 Jun 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654532; cv=fail; b=Zk22U3RFlqrjp4zXQfgm8lWn5+3aDc315q7GkL1LRUyMGkb9XjOL270WzmaeqiKxRQSCMIQjX5hAhTX5rWp958p3Y/zMhD0Q82oOTlYzRy6U92FGu8HGmb4qMuSWx+Zvc49KhtFb2WYUu9+Fidh2oE5Hf1ZK5gVvNvJn/uQ/On4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654532; c=relaxed/simple;
	bh=qpCumqS3p32EREiIVaWE8Ce9aNJb3NcEIRsP5elvOzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rjj9SWxrXoZzUbWhPB8o7MXkJvYkCf6iNsb/0CZExoI83QpSJSv3QKFj7U0Edcpg7nDk25CBHGZM0lVgw+BUBw/iz6alIgpKCHR0rP+34kVPK8cbixKELQU4PXrpeeHZQ/wMW+LrA12gkYr82+emNKXzcSl8r6lB7D0Lfw/FUuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n1iUCXTV; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqUbrbEWzhnxCxYiFhuuEM0zZmF6CsVXv2FlnhJnW8104bady1mIoJ8Qz4fY6TZq1KdN4F1YyLzvVo+uJjcQNFLyhQbBwXGeinDRUJQGWi+/uWhHotJqgyn7QR8raMNMno1dhL9/4hfRDdziZOHXcF3ZGudqhOgna9QNYL0Y05vG2R3nhvlcZPXGN5biWdzjH3pIHQjGYaFVkOqGSrCx0EMEghHw4cAU6VpTGyd9maWmlhxl30MSF2LjT/e/H1qid59wH9ygMGY+crx+O9EG2PFfCrZRL7CAn26OjVd1mFpKNQxPyudB0ZC9Z2hZjXC4LbhKQkkRlOr2kvr1/RFaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpEvvuz5TuceED+LtPemGZI422eOXn9AOgU/Q+3uCu0=;
 b=RlA+ckwFo3qm77R+MYphd4aW0K6rKz8C+/l9o192Vaq0/1GbatsG+V6Z/O3+uI2v7cRTXAhXyXCKxorvsnHArSkjT/ia5gIm/erVVOPxqW3/Ahy+XLH5foBXoLUomvvGgo4Ke4O5mF9mVjNGSCTi8W3DEj8FZW3YgCaBA9ux1bBWCDhB1wA5UH4sBewYqkowhkJywsJALNYaf02Dq5VhE3sdSkCc8vJcVFbK8+Y3EHH1HGuW9vThCjeZ3VS8l4zOX5stWzfIPSfGmW59AT1JJViF4aSqnZ/G3hcm5sGrfO8i0R3bZQff3yVED2AZlopJaz91UY6uflev8YdDA4z2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpEvvuz5TuceED+LtPemGZI422eOXn9AOgU/Q+3uCu0=;
 b=n1iUCXTVJfVVZxVugqSC5EGr3Qq3yDf/TX3cM5M/KBnTEPP6kc5ZY9mzoQENy37qXVTM+71SztrjiL+gs4wwNB5Wyi3bv65p6tPTn/8A5Te8lvuVy3jQSMFyBk4/CCfUw6ODnf853yuHvTgK5iuI0CsDkru3qLOGXLgy0zEeqfoDiq9lhUbTgKQKRCUp1bNXemFhTuHSUEQmlYz6eyki+8K6ZAy4dWvzKkY+EHqj0qw8kCtqjvW8iVXFp8tQoArHEtL3AN4wSQkZ9EAXwPENtVMRCIlkYRYNNoE9QBo8G1gjOVipE+SexySJVXZaDlDNmLW/snd1it0LpW2VpHPiHQ==
Received: from DU2PR04CA0211.eurprd04.prod.outlook.com (2603:10a6:10:2b1::6)
 by DU2PR07MB8361.eurprd07.prod.outlook.com (2603:10a6:10:2f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 15:08:46 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::43) by DU2PR04CA0211.outlook.office365.com
 (2603:10a6:10:2b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 15:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 15:08:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B710F2004A;
	Wed, 11 Jun 2025 18:08:44 +0300 (EEST)
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
Subject: [PATCH v8 RESEND iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Wed, 11 Jun 2025 17:08:40 +0200
Message-Id: <20250611150841.23203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|DU2PR07MB8361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: edee6d5a-e8e3-4731-ed2e-08dda8f9dd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0jdD8UG6aX6lGYUuyd5gFiw516XmYZaZbN5YtY4Zr6oI2I6O9VPMAE5ULEqI?=
 =?us-ascii?Q?6F+Z4S4RoybESM/lU6DQNkNOv9Y1tzsTBkbGzdvp+gKHQ6yz5dmMMwbeOGAy?=
 =?us-ascii?Q?XGmfpK7nPqGZmBZGJh9lSIoD5mceQY5xogwPbxhgYa5vhmhau+gOWVFq7uTq?=
 =?us-ascii?Q?jr+o/WlslZ8UgRlHdOAvNHi1SnVy9ppPS4XNasQxfD8uy75kIGHSZnEInbM+?=
 =?us-ascii?Q?uMluCBs7JC4xO78Q3OCbP10m6tGIPeSnE8JBndYIGndJ4rZ1vGZzVVqahTw2?=
 =?us-ascii?Q?34i9CdAQF/0aeJ9ZS1MKSdFCFw8bovHfSeb3urwPmANI7VnqQYY8UhkLpfHR?=
 =?us-ascii?Q?dKw8cN6K2rC+MblcjhTHTTKjXqMcKMRUGZG0g5jiAWwd/4iOGV/dvb2ylUO+?=
 =?us-ascii?Q?Hx9g2T3euVpHISCSiGQutBCmvJ53waHtgI9hupWa2WHc6C8ebuGpd4nz629j?=
 =?us-ascii?Q?4pKF9sgCJdssgMCO0YtjHsjiQBTVE7fuvDuxmq75UNXYbfNR/A05QDRh2p7T?=
 =?us-ascii?Q?KLXUKt8C5KOB1+HoABLl64TMQCvmr+JhNNB6kVBMNpkHta4JLjusxDzLrXBX?=
 =?us-ascii?Q?yLqBCLqSoVVRpyuzFRjJqgw1U7lQPi9fGo46UX6iZbWybiRo04VQkxp3MJBH?=
 =?us-ascii?Q?vskmgDLw/E+lvv0yEK+gdFDbLAuwdfQDjleM6k1rUbujxK/9wPtA6EYZwAhj?=
 =?us-ascii?Q?t9gtGi01mQqYDWSsLuH12tqk4yxamfMPr/YTrYZ0s+Q4SS8GPckaTVdZJ1EC?=
 =?us-ascii?Q?3Ed63+80Sv5iDKjbK+MXw2/M23A52NatTQ9ECCaJPrddGcvQvR82MD9kzUsQ?=
 =?us-ascii?Q?rzN2q2LgXn1jRHITVnGANlhUhGh2IY67+4eLKIMWw/xkQW71e9ybQkhQogkI?=
 =?us-ascii?Q?v4ZiePn4hQyNXF6oOmepr51WxEa0OcLW+JdOmufKT4WD/C3JcL2stMO2jtv0?=
 =?us-ascii?Q?Bj+lZyMOAMdmKyFupjNADVKIhtnrAkiwp3ZX1wdlxLKhDUgs09VyFAynvXX4?=
 =?us-ascii?Q?fjKU/B5ExJ6YER0TkAEWFSVkEhzG9GpW0TOmuvdUEWi4Vqd51RgoUoGN6+hk?=
 =?us-ascii?Q?ZCle627AMi+6swiXAHXsbT0rIcJP7JRrhbMc7e1ulkfPmDiP+woi3xe5cDfQ?=
 =?us-ascii?Q?emZ8Xe0oLBGMG7zoPYLN5kEB6NxDlTjwpRj1FtmYMGg5zxafAaUMLpQWOXGF?=
 =?us-ascii?Q?iCWK6K3GsWMrKPQB1Geir1NkLCyzIAjXyXgYFRHdV7/gC4HPjupgHBOWEbvk?=
 =?us-ascii?Q?pXc6ZKvwq/mhjeuACtiQpVbgZeVCkfyy0kDomZMRv4+cblz0Uod7+mz6qsN+?=
 =?us-ascii?Q?zpFtVJ+6ytXFZIJyD+ZFLJlnDe3pAuIHq4ifQZzUwlmcd+JlsPcY2yK0wDSt?=
 =?us-ascii?Q?sHGVdhrMooSL+6fyuKErmJ0Rbg7+Cki74rb+7ceA3gkaraqu4cReDSwA6V65?=
 =?us-ascii?Q?/jW1/vfSv9z3KDIgwh4klA0l9EJs5H8yR6xkwzT4RzyPnFsHunCfQkgWBbRd?=
 =?us-ascii?Q?/8CcIgc0fBA8vlJBYt7SsLS5rJaGeHue0nenlUYXy6kt4RwYp0YNp5zjig?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:08:46.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edee6d5a-e8e3-4731-ed2e-08dda8f9dd08
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8361

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v8.

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

For more details of DualPI2, please refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  68 +++++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 +++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 534 +++++++++++++++++++++++++++++++++
 8 files changed, 894 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


