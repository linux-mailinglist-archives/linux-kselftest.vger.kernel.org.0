Return-Path: <linux-kselftest+bounces-32797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9822FAB1F41
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A51B61808
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534125F78E;
	Fri,  9 May 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Da5fW5Sd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7D23E338;
	Fri,  9 May 2025 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827268; cv=fail; b=gYRzQKOIpS2/2qRKDUAhZOWe80LBQt7VF2S7pbLmmfEXkTVJRLuBPqMa8wHgHENy8lUoynRjkmCUAAKxr5dFpMOQ0a1zRd8KaIQVsjPDcpDKeo+XnRI/iu7qPHCn0JnDEb9A6poePzGCamL70y4W8P+LjaAg5syIQyuRfGA/EYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827268; c=relaxed/simple;
	bh=x/1BWafY63bYM2IUWlGYwMGAUtttlxwS1if0ioZWPYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dwf5xunELn+0Qes/4hIb/WSxOEnoe9Vjx0FMkwD/URv/B+jnCnkaIxB1QemuQbMy0uR2brm77HgFCKV1OcqNlmd2rUpQkobccG8Np/sDvrJX7NTFmMYqYALccPeyuNsZcA0ixRebKhUVJ3g2UFfmGqSf72uvHAG0WfM/9DDCntM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Da5fW5Sd; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGGVmGEHP5g4Wk6Xdm988AQCQUC8vaUKZpkG54dSWNpiOPABFKlfO3UUn47pESrREsaIPw5TrwDCo6eSm0JbXmovdkQRyEv3gDZkQQDm+5U6NBCmWXCl7BQDYnl1rUaNc66BdL3p8drYTzOUBCMy/enKNbRvKMaN+bHixH/oUcQddDMWR0wAK3N3ignTKD87uCiB8vqWYDMoC8Zrk39BQ/7z4IxuHaI9r+n8MEKh8eQwfd13ePAJQudTEooiRzahVq61W0gNsACOUScLC+OgG0tyvPaOxtFqCOV36AouMDaEbMd6Tua6doqyj1mzM/JflnDtUkB0sFXMuzAossI6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYIiIr05N9zABmjPGclT9K0FwpFU8NeQvvwVJ1MHJfo=;
 b=PunA8HFGUYat5+813LLJ6265ZP6MVKrCabmiKoJLqG2ssdCGThJe4UwcO/sGmNtw90DG+yWh3lGEzD0/a7TvUPyfeeqVJ+kU+rDNO0+IHJ3nm29GTIy8SCBXEGrS5+7p8lJ85hRzChHAYCI77f4/98pBcgv+xvmafGqRmsOLiOKlUHEr8YVIQdb7QKFB9OvmjP03RnrokYbyRvH1W7YssRpjIX3/dy0SCKvkQkc0UJ2cFqLX9OfzSjybYnaG8/qDs6A0PK3cAUWCZC54UM2bxKAdFVoOS0m+kh+tmvBHb9lCxch4HfkxxnGjfGOreyAEXNjxLgnGuu7sOrAGbhcmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYIiIr05N9zABmjPGclT9K0FwpFU8NeQvvwVJ1MHJfo=;
 b=Da5fW5SdUjD07BXLHGC6PYguowMOLHp3BsmA2r9r2QopeDICi3lEQtbYRyOR0nNiPIil3u8HVSwyYqoN9LSxHb/hBoo/0k5MDvs1KRlJHX1QxjUQF0t94w5g25vcnJ44e5OX3t8tMxZ/CXQkpuq5MVyipVZivdVtXe7FQL0mGkc7k70n0zDC1/hZuF1NMLvY8eY6YahZiIZTQQl7Dd+9AA67SIO3nUXnEyENLzqs1gU7I87dEq0DpvCjlCd+Nk9KgtddrzSdEvZ5rNXuHUdhwDvKZZjUn+WUBsXNT991Z0Z8Ek/fLDMZ32NfB/fO7dEHHEG1nFbrOsv2qSmyaOLmUg==
Received: from AS9PR06CA0496.eurprd06.prod.outlook.com (2603:10a6:20b:49b::21)
 by PA4PR07MB8576.eurprd07.prod.outlook.com (2603:10a6:102:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:47:40 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:49b:cafe::66) by AS9PR06CA0496.outlook.office365.com
 (2603:10a6:20b:49b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 21:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 21:47:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 549LlU2I002561;
	Fri, 9 May 2025 21:47:32 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com, donald.hunter@gmail.com, xandfury@gmail.com,
        netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Fri,  9 May 2025 23:47:05 +0200
Message-Id: <20250509214706.37291-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|PA4PR07MB8576:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5aeb6e2f-31e7-4e85-ad6e-08dd8f431eda
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?XJ7Lf7RPezje0oEtIh1huh+rTZxVv9jwVTCYd27Tctm20+zjKRFqQ3nEHVmn?=
 =?us-ascii?Q?+RQAGKCPWjUibyJS8oXW5FNmZbHKgfsAyztt0FL1tV0jBYGXNep25z62lJGe?=
 =?us-ascii?Q?2zTdW8HDSvm6r1YemX57IzLqQ3eawgo6hXtFY+K8OTwVJ+mhFFzOwrf1NJbY?=
 =?us-ascii?Q?sdUg1TjVYM9RDqoqsigOtTcngLVL1eHgA2ky6EH1c2sqUz9l66Qr3SngwIAr?=
 =?us-ascii?Q?Ah7uTMjE35duD3/vZGfNfQnQ+QXHP/9bigXmwjcs1908MqEVEnYnDAQG2qVi?=
 =?us-ascii?Q?27ifGlIVIvX40yABVFkLz+67z+0pFAvodg3UzScPwPH61J3d0ZSN9gtlQxkA?=
 =?us-ascii?Q?uE0/svP8q+mAd7CUhp5l/xiM44k+PcVYiO5csdrEmtkoM4lsStQZJwDaeKmQ?=
 =?us-ascii?Q?yQqnS1O1EP6eHRyVhnPPa/+HkHX2frVHD4dovQWo7RQulNIsesyrLFSWZ9mc?=
 =?us-ascii?Q?OFEG+BThTDJxoeRJbG9K0NG+bt5cmdZJDaQhvZ1wH/UyA9Gka89QgOdGB6KA?=
 =?us-ascii?Q?CCnE7SKdYck6vymrbE+mw5YW9+zeIlcuWoTQFh+peD1L7NGmdfbYvTp8WZTH?=
 =?us-ascii?Q?ZFOZt2vxa7vNBmAd0TsoiTCaF7wum39okgBBWtQK6eCMMcJObRD6GpEQ+rzu?=
 =?us-ascii?Q?NFuFk0ghSyWeSyWlRbXILuPyCnvnhaxMMDaHtpGjlskbWyqU4xLIzHhRO4bj?=
 =?us-ascii?Q?jJVKCzVOjJ8ZQCzsJpzAKp9UrM4blyhpopiLXb/Y+aBcqtLeLq00jChyYF64?=
 =?us-ascii?Q?gbZ6rooz63EI4wfgdE3edl9WBG5OD3cWxtf/sJy1WoZ83ad8TmvFQN0C3efy?=
 =?us-ascii?Q?lTU8EUXKJy7cGVmPAke0ExdXgM1TtzUKSoPbxnQYPjIgjs21DY5UiCIFQtnm?=
 =?us-ascii?Q?b7r4UOQTOVi8Rt81TW1aKeKcHiCy836gYTjASzWtE44GeDiUYzw6cirvvtoU?=
 =?us-ascii?Q?s3heDhoQOwYUFAGJJXiDIMAz6VDgIp/EmCUXbQiKIpbfZDfJvaOQYextIieR?=
 =?us-ascii?Q?vtJbDPh68CReidVOMleRGXbGsxVbtPWowaCDZw4Uh1LQIyNbJMMdIOQthPmk?=
 =?us-ascii?Q?Oi0pahlHTz1kweMz0YH8FfDBKlMVMo7xkKfa/U/B1Kp3ZvDJJ+ySzduB0qeM?=
 =?us-ascii?Q?E+8R0Fv/JI1h4nURULk7X7IZ98uIZNrWwJIsuPAuUFIJORixl3xl9/7n2NnE?=
 =?us-ascii?Q?u5Uc2fiyayLvu+foXTw+yFeMljt0T6XCDJ0rYpHzYG9ESdJu5erCScRJc65W?=
 =?us-ascii?Q?Y9C+ebzVDO6B5G5IqAMxcw/UiKhjEdFJx6Mxmm106mv2gvgUwb9il52CsGd9?=
 =?us-ascii?Q?Mx/miniIOHdpHJXOyqAit9S1eDtAaS9HsSxPSlWvAcUh8E0ROMaNRFcvv1+5?=
 =?us-ascii?Q?OnOuxe7Yqys9GnF91rFVBHsU+CGN9dfmFzG6PqP1COhJVXlMDxHcPfCyOTiN?=
 =?us-ascii?Q?0RGP/722n08hOgdQsRaybjdscNnSDJ3iagxwjFMEGCOfV/zOXpseUsEkRh60?=
 =?us-ascii?Q?Ju2oeWf/1/oTdmwDVdNvjHrixVpK0Z9+EqjjgLPuYQnRvwEX6qwmZQYHfQcR?=
 =?us-ascii?Q?CbuWPkmwRBib0oEx9lA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:47:39.8696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeb6e2f-31e7-4e85-ad6e-08dd8f431eda
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8576

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v8.

v8 (09-May-25)
- Update pkt_sched.h with the one in nex-next
- Fix one typo of comment in pkt_sched.h (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update manual content in man/man8/tc-dualpi2.8 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update tc/q_dualpi2.c to fix missing blank lines and add missing case (ALOK TIWARI <alok.a.tiwari@oracle.com>)

v7 (05-May-25)
- Align pkt_sched.h with the v14 version of net-next due to spec modificiaotn in tc.yaml
- Reorganize dualpi2_print_opt() to match the order in tc.yaml
- Remove credit-queue in PRINT_JSON

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


