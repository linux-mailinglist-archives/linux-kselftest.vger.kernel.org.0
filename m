Return-Path: <linux-kselftest+bounces-30704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC8A8819B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78209188E0DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED315F306;
	Mon, 14 Apr 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bowhSn2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823217E4;
	Mon, 14 Apr 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636751; cv=fail; b=AYFmS6LSL5STCP7xkYIdU+scuxZi+VIGtnQfaqRlMQTHtUdy3w673h4aUNVRwZZNtzggw5/XRualMlbmAmkjIVGzyM5LIxKP6ccNWUspuRWKnLyszxCVUGzHx2nKXLuVrCZalqs9B/69Uw/trYoafqpzd5c1JN98hHHc1iAa6U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636751; c=relaxed/simple;
	bh=4sgpQ7f4I3yUANtvVpOPWHyCFoHGvRHomTsAc5RHcF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ltK1IN9gbLpM/dhEcM7WQcWW1gi714W1p+F4W5/g+RdQedR0ka716XOZm4H4AzkOz4Cmb5SX6LGWMve4Vo+nGWhXUyWgPCKb4OybFPiZKc6A3Vij6NBIuMf93kUKp81pChJeaHYLJubnLDsj+vVeM7dCYrU4g3Y7xc9MZ9hoiP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bowhSn2k; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi9/iLbfjfzH1dOiMR2JAvltCZDmpUtYm6os8RtmkGYJZrbXLURlQxYOIJT7VC+jQ/PRqp36VUDNqR69y6gqePrb4/stD9ieyCvP4bEhorknIttJMbHHQHfS/Q+Cnn9rwdzbdKIcsg4oqA5ZzGGhYuieds1/RzZOAjkpgu4gO1qOdD6aQnj1RALU2Hb8w257351WeKfyZ2YU8086VWzrEsGN+PNukINUapMdMe1ITlyIhhKLKJhZnvCq6K7XcBv/fJY7zmxK/qoYawNNH+ZFfld774UYgXGiWoNq+niTPIKkHD/R8FH64ZWbGKVGzf7c4e6l9oT8uta2on2UQht1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOExgHc3dICviRF58uoTasWU3DOp9GwRx1JceNTDDqw=;
 b=keEVC3FGRyaIelxIP1L3QkwzqcaFfiIemu6Q/wBZmimBwpykr9qazq4FuRnnnmKE8WaLbfZevrjLBgdLNp2C5o7ksQv1NMmMM8gloTlKfCEdCLI6u6z6xgXs5YceV05HYahQUSXOZT3SHP40IpE6iinktNFz0FXdTqcYOkRfxGPepFrV16UndVfGc+RwsHNxxDUcaIv59qvfjqBX9JW2Zu59cxNf/nXbXix/9yYy8mL1V8LhW3UkAoA1j1Sbq7M5xKRcJQVnhHPr2rIH9AioFhQ12Ue1jgpbvz0ILg5iqJ0Omkit2agLnfbmJB7mEbiiBpSZWCD7A5IRKs9m98Z3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOExgHc3dICviRF58uoTasWU3DOp9GwRx1JceNTDDqw=;
 b=bowhSn2k+e27Z2jmWaFBjomnJlKWGGDFHMMCPWfDIoHfw4/Y7WfULbWFboMD6ewi5lT+ZTgoQOQJMOWDCgi9UfhNL89SPpmemIvvLqSzZaX81j8MmzM++outHWzxPV6ni6BcrUDUEdNqBmrb3mOfyCTgCeO4oI2+2dAmqb0mOfhcTgvnDrutxR1ykkUMyn1zVOy8fFTk73dZDpl2zvrlDmQ/tGpIUHW8Nx0Tixw6C0kQjfJ+YLHKW9QdPzm0yXqmBQy6StgNFfwiwNNL8NVp+QJJZbiH+xTQXK6jagJIc2EbnYWjN2WmvcFc6ERmPqZCNBYQW7uqrdfvmK36ILXHyQ==
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by DBBPR07MB7434.eurprd07.prod.outlook.com (2603:10a6:10:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:19:06 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::32) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 13:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:19:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDJKYr027866;
	Mon, 14 Apr 2025 13:19:20 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v5 RESEND iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Mon, 14 Apr 2025 15:18:58 +0200
Message-Id: <20250414131859.97517-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|DBBPR07MB7434:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6480135c-73b7-4e7a-207a-08dd7b56ee83
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?8yM7/PUDzrtmITfAORZidsDd84CIUbp0KPHr9/+YBxJrORBHZOvAcnZhyB6B?=
 =?us-ascii?Q?tcFjL3ECgiawpuqiLvt7Vn5IeRT1GowBzIIgNFm28IeitC4oS9Y/SWc5oF9J?=
 =?us-ascii?Q?IfggcRqOa0qwnl3251hR75x8jCJXCIZ9OSshJfbsyw8MJWbpDQOcXmLHqhFA?=
 =?us-ascii?Q?+6QgmZXAeyPfPXlpDsBV3SSzNEWAiVuuiCejhngXysxyCgo3Sib6Xye/uUcc?=
 =?us-ascii?Q?W5tCFFmEoQVTHgojSJl3UZi9Pzr7vQSBaL+KOQvTKnnb39y/5jg3PLHN/kjl?=
 =?us-ascii?Q?tbl7HnQRDjiut3Yixke75iM/FXW/PrnhYZOKDFVMi9Ni7+XJOXirQjkIv2w9?=
 =?us-ascii?Q?mG01ZhJLHQO3KD1LqIeiE4Dn3xCrSUo2dI+KtEjE4V4oz+ObBsifwNO3/gfv?=
 =?us-ascii?Q?O3pKyYuXWj5sgXcZ50aEHyChbwAXtWRHROtK0COI4ltEXooDpoECoJF15tKF?=
 =?us-ascii?Q?oB9GbfVPN79g7meA6d8fz2WmWaEslAP7s37/98Ef5UtpHe9iBZlfOtejZd31?=
 =?us-ascii?Q?ZZKe+bZDPr1IAzKi3serMH76dTATNs0Q7ANvLUOrfN7MPSlNzr0Kz9cAhAOu?=
 =?us-ascii?Q?7ZBY0FdFoSiTugzoaQmFyyWZfiu7nVw0SHtdupV+rFMk+KhgsSqsRrQo7S9b?=
 =?us-ascii?Q?Eu710zkbMaGvbS9BGkkEmMlryIdLw0/4fXF4WNjSk4xr85QezE7/tom5bgya?=
 =?us-ascii?Q?zkY7RyXu7l2xQjqrNbiJORXzIhQ7H1t6y/c6Nk6ZqYT7CmivVjyvxmZ9g7Rc?=
 =?us-ascii?Q?0dD+5D8bjGZX/nkNoyjbcSDGwwJhQejaES1JUB0cu9HNt/13SJFjrurtQcYo?=
 =?us-ascii?Q?9vRfl9zqyMB8svkDFcSBKemyDNQRbu7Mdfejz3Bd2KpTWRr/bWSUf0u+w8xd?=
 =?us-ascii?Q?PTrDjcPDSNgeAZVQPVtMvwIhOH8sc7v92Y/6fW0RScGjaafaESeinQZvFYbZ?=
 =?us-ascii?Q?BLnYiTTJf+qYdwaKpcCxoHfYE+igcmaj2ZETBkES7sm7+c9bA6HZTY9LDcxm?=
 =?us-ascii?Q?rCUuidxCVtvzFJHGicnjzlcvSQ8zvA9umzEZWmBgBUfMMv88ncPh/phZMq0m?=
 =?us-ascii?Q?5mkQ0seAZJyU0ynzpVCGbAyQgsbDLaDJMUIz3vZI7Pb8FHok/humCOztIO8Q?=
 =?us-ascii?Q?he0dETjlaQsFRiIGPEeJFsujXfBEBTdXr+3Ug2USJAnpG1bYRAsyo6efilYF?=
 =?us-ascii?Q?UdakE+jyZoWOQLm98s1UOlm0DL5XqQzu+2f9j6wlgOvKeS0tv5t7FVHl2emk?=
 =?us-ascii?Q?e867f+yTSB2nE5XRT43devjVp0MZmn1CbRrOtgW/b8x8+A8dG9+NJwtbchGl?=
 =?us-ascii?Q?vZdfFSTV2GD3I1rG4/GTAsOVjImj6U9meW4F/4Qkt+YIeT6xuq8n3AQa/Fos?=
 =?us-ascii?Q?OHyfrs2XArJbH/p2j7hGDPmmZbGWQzqhMjPQlGKrp15p3ep4SWyZHKMHMSQr?=
 =?us-ascii?Q?OwaRFWtsCFbOyFkJNNftGVjEMGjvDWems6QOykC8fsh1Fb1wxyBz7SDS2ryU?=
 =?us-ascii?Q?eRf+3bl/lOJj2qLrwfaAXhCtJCC6TXNeRkHDheW1IZCgPJUs5T+77kNd/w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:19:05.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480135c-73b7-4e7a-207a-08dd7b56ee83
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7434

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v4.

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
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 519 +++++++++++++++++++++++++++++++++
 8 files changed, 850 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


