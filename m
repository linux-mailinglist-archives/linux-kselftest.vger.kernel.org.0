Return-Path: <linux-kselftest+bounces-34465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08AAD1CD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DC188D5AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A32550B3;
	Mon,  9 Jun 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MbHIAPey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C61E766F;
	Mon,  9 Jun 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470807; cv=fail; b=URbN2fSqQp5AJxwf+fRiuRqph6DnW7xrKxz/JlfucGgKL23qIrt5uwhCinC0SqHtdrd00/0gA2WAhWv26/RZLLH7CLRWua/S0jFteCAtxlyosesQR6NpjpunrFslgztQ42q12Fy/HtUqwEEhUCInjFYu/s1O5ynP5rzxgiTW1mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470807; c=relaxed/simple;
	bh=335KkiFMN168r4bC03FNkU47VlEY7U58edqQ4qUDneE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2gn50GPtywYMJBo5l+WXeCFSqx7ulnfLZ475JOo4NhUVLa+qrEP6ANYWLHY3PKShpbwNY+FPDoCVelH32QNhmWz123uJ4KDewGQAmM2xP8xvO62R7D6n3xDhIp7IoN9p+PYh4iQmMCUQNSUHU3fDfUXODaBmvHVLvfdgPA9FmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MbHIAPey; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jno8lNPK8dDM6e13ASoc3YtnOg13bfmNnchrPxDkJXcFxczkNY8tvOKd3SQs7F3rNG8e3iLaNzTap3AfrffgiCDyfUOToWqi2PTAoGySYkp304p2eJbumlsKMga9fTohYRO7dovYQzAk6iy9QN58Fuv2HhUgpwrJ6FFJc36k3AqMiHvl7Q5IuumJ8BBULdhnFWTmD4YqUJOPAO6z+elCQF+6nyc9vRzOj5geAFw7XglChk5Y/lswVNK/OnAHtYmdbFbAKBu1ZjG4t/4ek/34X4PXUc0CSD1VpRlxEcw+g3esl65UmE2c7IqA0ns2da4VMdNrY5i+5H1jIxGuJvDGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C0q3BL92Hf6eDTUkG8DU3RSdleVEAkojkjIXOqNwMU=;
 b=fiubMo/kg3Z2i/vrSNCqBbxsPo19+DAp2ErtHEv4wi0b39vwUgbnRiV90Vl1bGOvxeU1xUmDJkrWryIOgqa5y7UkQZPjQuQpb7cs4gtIxmRMTOG0cZNI0f6CsJdOmu4g47buqvK9WIXjqQmCCnAWu2ZF296muVJWQZ/y0SoyrqbhGC0u1Wn0ODLPG0ZW+DeCb22YlVqbdUVH+TDPEbV+6oZWP2ZXmzVenlSf9A4I8cTQVDXDoH55SCS8X5qTahQwKCBgm6h2Hov696xBpG19Ug090tYigEqeySWes43pUVCWNs2WqwY+bxn0kAd0+lHdSlHbqoPnBzw4I9xtk8Aiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C0q3BL92Hf6eDTUkG8DU3RSdleVEAkojkjIXOqNwMU=;
 b=MbHIAPeyaKkFw7QIPhGW5Vk+L87LxQIzhDsw00/zKJm+Z0+Z5GbXQnXbE10KNlPZkpTqP3xIhiRYdxqe1hAq3C4RQfEhFFPpeHDBoS9G3U3gEUZMLDnhAQYyFzCXn3Cnx/kblW0nhmDrzQylgHHZtljhqjEAjzfuvGK5ppzuZsk=
Received: from PH8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:510:2d2::18)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 12:06:41 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:510:2d2:cafe::70) by PH8PR15CA0012.outlook.office365.com
 (2603:10b6:510:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 12:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 12:06:39 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 07:06:36 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <shuah@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
Subject: [PATCH] selftests/mm: Increase timeout from 180 to 900 seconds
Date: Mon, 9 Jun 2025 12:06:07 +0000
Message-ID: <20250609120606.73145-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: cc58e62a-7510-4a74-1f12-08dda74e1776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8MW4L/XIXlFMf66m9aUWnHblTEQHsW0CzCkPS+HHnQk8u00yytJXOHSpgN+?=
 =?us-ascii?Q?dBpeAw5L93iuM7zxaVomFhYqc6Mzn/FrQzuk8xqLPNmQ02Yqpi3pF/UHItxx?=
 =?us-ascii?Q?brtUg1qFL1ewUni4grneT68W/yd4iwJsyHdSMeka0woVVgWwe8NptuyaXG1r?=
 =?us-ascii?Q?GpireEZY1t26o5/EG4uV3mqXltPp5rWfsfRQo7gLGqONfnWPBL/HFYoRMxtG?=
 =?us-ascii?Q?qpTb2dXLNyWleq0xdTS/W2dLaQlwUtvAQQ1sAKdm1RBaRDnhQl1Q/OLXCrWP?=
 =?us-ascii?Q?tkzImCBJ9hWSrlMWB3wg/yyqWfhE1qKIloAyeoXdIzwJZYQpAyB5FvIJqUev?=
 =?us-ascii?Q?B5R5uEaw/HO7uDAhpNujLcdIhjCo22pwQp7ejDbReAcuLNnQoaNy7b8zUPWf?=
 =?us-ascii?Q?kkocBGLV2yLNEdEp080z9U2Ls+YQngzsCHUz2FRfCE45M2rjZ51PPoAUHk3t?=
 =?us-ascii?Q?2NJTWv74GWHeuR9Z63xhZwJUDtgp7SIGj7enc0Zc4/OO9uJWgc21Oys75ljU?=
 =?us-ascii?Q?jfPQxKxAwrbHcEwk2UjkSLSmyt37wfTjsrJqdugCn65Dm6xKA9RV1b7FGK42?=
 =?us-ascii?Q?zeS3JCBuIOzsarALv39B1csP4V+YgIeytAtT7hqhvI4g9qFwvwJLbyhSwzGX?=
 =?us-ascii?Q?qlH8NIX7oHFix3p9Uz8AHAN/oChroTeZWf7iNx17hny+YI8ou3apUpim1U8V?=
 =?us-ascii?Q?dZFCSltPnU5aNyFxAJW0kFnI1cfnQtfP07N8LrKIjexQpsxq/PrFIPtCUdbP?=
 =?us-ascii?Q?+k4Dt7Al+LxPsre60n7G9olsEDoqw7zpyD0R2+jnhBD3vn5RXxyIxkSt1aKj?=
 =?us-ascii?Q?l4fxDZiL9FJEA5N7rj3NqU5iO7to4T0GZdWE8HTz1BGIifI6tdCefz3OJzLE?=
 =?us-ascii?Q?ygO5Ki7hk+faxWEwQlNG/qBG+qws+n9sH5aAyzeEpYSonwnaRIsX4eAPYgru?=
 =?us-ascii?Q?z7BrOwy2XGKAed0yL9LhnVfd5dAegTpiF4+7d4ZqTh34wCUH/1I89BzIVz71?=
 =?us-ascii?Q?e7CspCaRtNRX1gmWvoHwelghlNXdKxSqR3bfMbUWM+T5Oh9Wfs2KeL2iTZsj?=
 =?us-ascii?Q?v6Qkt5L5CD/DzRTmcmdAcptpY1mOVQKI8KHCTfqxc9K9CdNlZVb5Qf2RtkNi?=
 =?us-ascii?Q?n6IcmvvCvGFIKwenGt+ic9jnPdO2EfhZBwzw4avbXI0+sDScX96+J4f48vkp?=
 =?us-ascii?Q?e3pdSGTonys2yH2ooH7pK6gxjOgSbauXGlgB3GwMtsl8X7oYFXEnince/O+3?=
 =?us-ascii?Q?Y8WqVYodu7irSz+zZGbd0Eq5rPvTt8BO+VYBLrajHLGp9epPFdrXH9uGGdVl?=
 =?us-ascii?Q?0oGFQMax8GVSmE9TMM8pm5aXXHmxDUwnj63fwDvxPsla4t3xqyGM/+xDj84M?=
 =?us-ascii?Q?ArtplLrcp2swDxkyZL1kOXfw8dEF0T0/PzzAEsMnsxvcH8VYu6T5Nqmeap6g?=
 =?us-ascii?Q?ANgnYDDKz9lLlN+u6ZiWve6zUFdiNjebjMYeI7oQjTs0xv6dUaRzLibjQ/UY?=
 =?us-ascii?Q?qxSzftiU5GTuOx+XWWt6W4nvT+l8YZwajDxm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:06:39.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc58e62a-7510-4a74-1f12-08dda74e1776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

The mm selftests are timing out with the current 180-second limit.
Testing shows that run_vmtests.sh takes approximately 11 minutes
(664 seconds) to complete.

Increase the timeout to 900 seconds (15 minutes) to provide sufficient
buffer for the tests to complete successfully.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/mm/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/settings b/tools/testing/selftests/mm/settings
index a953c96aa16e..e2206265f67c 100644
--- a/tools/testing/selftests/mm/settings
+++ b/tools/testing/selftests/mm/settings
@@ -1 +1 @@
-timeout=180
+timeout=900
-- 
2.43.0


