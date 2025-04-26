Return-Path: <linux-kselftest+bounces-31722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F2A9DC8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0354E3ACBC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B625D919;
	Sat, 26 Apr 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BR2sDSgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD91DED6F;
	Sat, 26 Apr 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688246; cv=fail; b=ngV1x/LgpM6Tw1a+FIFK4ERwLP2DvXfkFC3AkWT9FffMn6rmbVtoIG9rQXaq3f0pjDZ8V8u7RPwB5lIkUidf+f+onum92e8SsDsu6YiIThj4F5ZrrkLoKO7yGUiJhWEWa6H/RvjM++/4q1FkYIaVgtt1lCrR58913zD/lTFsXSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688246; c=relaxed/simple;
	bh=ubwu/rcYpCLBZbSiyygBc1/r98y2Yci856KJYHZSkJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CdWBEzOBVKcwptq0FbqBJ66ZOjG00VzAnM4z7EQ81Vu7MJO6qGMDJSUHF5FmJcIgism5kTqAvp8yH1W2YSrOu1mdncWG+/IvEHB6DbCbQX03hR3vG0RVPMb1x0Yp25ceiqzECYSOYR9lofC11bPniByEr+zpvwTPVBrBkZvog2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BR2sDSgu; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQWXJ72jWm8uuXs4m94W2Phtp0LtOBQeFbeoiOKqbjuzuD5vOLUTVUP/x2cVU17Veb//zSLmjA66Ff91ET33nv/NHsrqqohZW/dQVvOsIHV4wYkydGkf0NtwwiVK7W2Xn3WnIc4yPgwDNNGKVcJGxiCOKlhcuxbUD/qoGyvMJYVAtL3XRTCk3BvvKq845ja0qli8/b2WKczvSXGM2E5aQPMWaktbwmAoYUO83tnzyC+Dbb6yta7moI9GjWTHa3zEc/ncdNZ3MCvxWeLW4GRn7cx+W6B5y+be2BaNViRymN10Ge6lGo9LJbx2vIjfz1OQg/X3G9QGJrsx4AmVghJQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHOI6rSGRdyFKvJSsR+KJZYd/QoJ3fRN7DPBxRfHrUQ=;
 b=c02Motjx0wBOuUfdVxdGsn2BNS4tNOD5MVQYhxaR7K9ofLGAPjmXlo4jV91qBDoYLCpbayYsuUpP9/SVclHUJ9Zyq9DSJAaW9NtU+qu4fBtyslZIrGKSgCpsXjZj80vknD/b2CNiX12JtFSSG32VIWVcen8KXw+H2wuabsN75rPVwjR/eTEoqQMpmTmC2uxH4Fmv6PMVP/i1oKtlGR2ge7K2mykutUKbQE5WNssmBxoyMn+QJ9izLLOMCwKM0wa/sWFYMvJlF0NPt76ha/NtSp4HGYe31shXAsjdz+Xaz5kuQOgguPgBx23ul63E6VCj4+Jezs0a85QF45MoiJT28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHOI6rSGRdyFKvJSsR+KJZYd/QoJ3fRN7DPBxRfHrUQ=;
 b=BR2sDSguL87TlhATNwcgCuJRvZ/PGg/7XMZ70iph8lYUK5JQZMfaVFgPzbqqXEL69LK+7su3Cu94jYj/ZNUthtARrcCVA85vax7T4WDIwbdvi+vPCGKtTHrtWbCXElOA8alxLy8PJr7k+TJbldRIuoKp1aJKDyM5anZtCA4UY1ggOFTzRiBQQj85P+aPHHuYeqlRUXMNUhGV9xdO6lCJpSzejYSu/PnxLMnnzhYFBNzWJ7RbqueXk9DGDL/woEdDtneDRJmwyp96qBntDKYZGnjfNg1FH87Uk3KabwsN9fMtmPT0kLlxRO8uvXSNGvztvUgQkryrBbtsYvyrc7rIXA==
Received: from AS4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::12)
 by VI1PR07MB10092.eurprd07.prod.outlook.com (2603:10a6:800:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 17:23:59 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::32) by AS4P190CA0012.outlook.office365.com
 (2603:10a6:20b:5de::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Sat,
 26 Apr 2025 17:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:23:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E33922084F;
	Sat, 26 Apr 2025 20:23:57 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com,
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
	donald.hunter@gmail.com,
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
Subject: [PATCH v6 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Sat, 26 Apr 2025 19:23:55 +0200
Message-Id: <20250426172356.9490-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|VI1PR07MB10092:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ec80b9d-e66c-4675-78eb-08dd84e721a1
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?79ltOK3XA7H1XVL3SECXkP06Y5ajYyVpoc5nAvtycdSjpJJLn3Pg8UektB+S?=
 =?us-ascii?Q?MyY+QiYnfMo0iOXZZv+6IJ0qlgrxwmR5K/EkGL42e1v/eSuK7Gf8Ao6tirrX?=
 =?us-ascii?Q?yZ9W1L9sh8f6ztOAwNem3AL7IE2mcx70cl7A8T7AJz5/6zc3w0qZotXcNoND?=
 =?us-ascii?Q?TS6FmBs1eKIvi2j5xW0XfevxToSgmuBD0IDE6ycZPyBs+QtrXn3iv+qyUyfA?=
 =?us-ascii?Q?+S9zEhs52kmWCV7yVC0rB4F/BkmOe2vuDl5QYsw2iWlo6g/h90pUzujRJMfw?=
 =?us-ascii?Q?rPYuf+ZqRQYVFQvtOt2PqmEZ3L1nCZx02j0xOXm3XecwhRmn6YiERZnVXG+0?=
 =?us-ascii?Q?Zgsc+vzcIEsWel0Lts7SAPhvBiiUqjai2wh3UTAW+bs84riz2Gp/We20hkIt?=
 =?us-ascii?Q?GrIUfYnOMkRwdwn6dff0yADq1nDyBUqUmwvOLuOmHJayrqH7m1jO8ZgHCldR?=
 =?us-ascii?Q?sdaVP3T9P4Es7oNWGUVwPhUk7ZMqcc0T8O5W4fU87MDYJCeHcXuJZf4NczDQ?=
 =?us-ascii?Q?lKOvg1sfsIBqf+slaPiZNg1Izj31w85LDKoiE7BMZ6uViTd6vhKCtMIy4QnI?=
 =?us-ascii?Q?IOEaLD7k5NUnLBASWUYx7KU9RX9x60SUbxvcw6xPb0yILuTeK5Owiq7ccTKv?=
 =?us-ascii?Q?r1JXbI1DSTjhMLEgbpcM/Ij3FGOCXDHercQZD62gCsuOmyl+JWpGsHPaYSM0?=
 =?us-ascii?Q?rYlHY5EQwjp7PkNheu1y60EZewVBSgkAEW7NcHhsM9g2QBjFNlDhyhr9wMc7?=
 =?us-ascii?Q?on1vpwNRzuOjF9UVT6GrcBAjQ1oKMRz0YCe0lBVOdb+beG2TaBYB3+MoibT5?=
 =?us-ascii?Q?wGW+ZbctKeFd6wHo2+B2RQcTLgyRJd6NQiNBhFYlM9mWyOU0neVwC0FHCpkT?=
 =?us-ascii?Q?6bu6w42y3WyqVEmPSg/xnnQXiqOZm1c3JBMrhzmNmEDuXsBI9P96FpLGl6hq?=
 =?us-ascii?Q?P4fGC3rqzGoDlfb8CqrsvbcOavzTsW8T3HQLghx/VQ5IeNu0vQAPHCtVISk0?=
 =?us-ascii?Q?r8GwPz8IjYpocCPVb0du64Mw3A+fy3vcBUC3shLsbGxkChkSU3AGPjqb03V6?=
 =?us-ascii?Q?tKDtAq9vS+LeLT4hIEBFt1NwYVlfb6tF7q8ex46Pi+SXucJr8H7qM6oJ/HqY?=
 =?us-ascii?Q?wZKa6B1WJ546CiSyZnvArjmiyrxqjYdSg1Nn5c6IqcvmPIJFWbDOccKxlAUs?=
 =?us-ascii?Q?XwiNxXDq60LZsbyXVS1LNdZnfVMXoEF6ZbsQl6rCOCWSF0sNWiSSq1reZstD?=
 =?us-ascii?Q?5g6E4UsftIWb4xKfQ+B/M7BT51aCcb1gndK9mgx27WpcyV1E66yFHKFLfQ6J?=
 =?us-ascii?Q?g+0VKmr5l2anD/ZGt5V9Q+WtyDcWY0XkpIVBYfo5AR9R8oTrKhEXbSF1/gOD?=
 =?us-ascii?Q?mzXgVbwCJddGD3fm1DDEVK2XJAuCURVRgHo0TS30PucFBCDVMIgPfnHMZEEc?=
 =?us-ascii?Q?6zxymv+hgvAG/VqWL34MHPZGZ3tf+i5tJWBTg1rcnKv8wUO84TqD/Xz+na/v?=
 =?us-ascii?Q?1Eepl9Y64XJaBUpzXNu/TdlnqHO4uvrapVI53hlhdCUJQjqhrZ3/TT3SUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:23:59.2083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec80b9d-e66c-4675-78eb-08dd84e721a1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10092

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v6.

v6 (26-Apr-25)
- Update JSON file output due to spec modifiocation in tc.yaml of net-next

v5 (25-Mar-25)
- Use matches() to replace current strcmp() (Stephen Hemminger <stephen@networkplumber.org>)
- Use general parse_percent() for handling scaled percentage values (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 stats (Stephen Hemminger <stephen@networkplumber.org>)

v4 (16-Mar-25)
- Add min_qlen_step to dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step amrking.

v3 (21-Feb-25)
- Add memlimit to dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update manual to align latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2 (23-Oct-24)
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

For more details of DualPI2, plesae refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  39 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 +++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 538 +++++++++++++++++++++++++++++++++
 8 files changed, 869 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


