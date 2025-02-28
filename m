Return-Path: <linux-kselftest+bounces-27851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7590A4958C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2364218848B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D0255E23;
	Fri, 28 Feb 2025 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oZpiPmnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518B1FDA8B;
	Fri, 28 Feb 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735784; cv=fail; b=SAiFm/tlVy8DJuIIf9q6kFu48VATah2Bn9bTd7wgeR4uAEQ1XrpUMNThRBaorPpMHFCQ56gmLre8tib3QKAJ8PwXtlxEXG/oWOv6R5EVdDSfgi6B48O5TatuNiPlvxwoFZg913pmY2dUZwmnmswLCl9/wIg4Kbgzo4Gqd2V6740=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735784; c=relaxed/simple;
	bh=PhRW352o94JPPShsysnJdpsi0OU7P42OZ10BJMj/AAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbThCl9Ln2x+pOU+HwHeZKPewFyambU4WrrVUCm6Y9FUOS2KEG+oOgI8HKfeiREULoW9gf1Wmi/a4bM0wunTe8yXclMnSR11++WiCxF/zZLm0ywdy9SgefEtW/FJPcK+YXbB3cbPm2vBrmiA2MA+Ht5T7zqgoa9v0YBQcy5jHdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oZpiPmnx; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUXJyvNEu2XjNse5LCn4RvJZkdKa9ZP7kZUpO/nKfens/cBMd129auzWkPvDaQo8vlI8GZRVlYXMnoCxKEL7qfX0IRGZFGGi6umW7RbgelwvUc5K0BkKE71xsA7jXdHnjOxI16FXZvTxTaijMeKk3F7PXGrNIEp1WQLlKcYOcGZbInRYb6GYZLAtT6Fl/husqevpx25TMoNVp7F8y4sGrOi2YpyAv5xu0LYkEJcI4o1TynmMGH9I+TRQE1dxXGYB5oU1tHpZfnDrGQv/jfj1Jr5H2dVjKmnTlRTMk3D0gTJ67FXj+s6hhSaqaGgVSKdC7po7BTtSfBu8+FtpKnPpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PJTW92VFlCbweoGHo1wZnHEhehDGEBMja5M4pUyERc=;
 b=w99NwaS0CbAl+WbEeDKlvoVOvZFwZVDxb79IIxcX4zsdOjqDgA2x2SUtyIDpqrH3zMaWDe52pazi9231L06P59u5EBTfYe+zfpl0F84lUneSDJeV+TIr41F4FhaXDoPXTklOQd3CF6yEJx+uoA2kXur7lvjNiUy9k4MGCgHOoJvbbE77mEmkheCLqreAQiedMzkDxNr0G+hvevj2KUu9HDOQ8c7Gu5Gif0Y5RC+Ydphc6g/17PJ/5Bonp403M9xSaUVDaps7PDI2zU6lI7WXy9AQE5D7ObUhFCnj3MN9r0roDeMea77R+PZTZg8qafoszlaiDkN0Hzy4szRj5IUlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PJTW92VFlCbweoGHo1wZnHEhehDGEBMja5M4pUyERc=;
 b=oZpiPmnxHKZMXqv8p2g9WykvecOh3HQO5PbWu9SXQTiXhQCuox+ImJtZ6639NHBOyHKVp5JTwlZ3qMPPxTiYfU7bCB8BNSUip/ICm0lDhsB+UVQZOFRHWQDlsrJpafoex3NnpZe4it6e/h4dCBOFNiIWTk75gzb+LpnLgEZwi7k=
Received: from CY5PR13CA0078.namprd13.prod.outlook.com (2603:10b6:930:a::40)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:42:59 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::29) by CY5PR13CA0078.outlook.office365.com
 (2603:10b6:930:a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 09:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:42:59 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:42:04 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 09/31] KVM: selftests: Add support for #VC in x86 exception handlers
Date: Fri, 28 Feb 2025 15:00:02 +0530
Message-ID: <20250228093024.114983-10-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: a506aa78-a1ef-421c-11a8-08dd57dc4989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8kEksL7xKVquiN7XizVW+noKgm6ulg0hdLBqdoVKtHWnVXboNxnIcEWcnHqE?=
 =?us-ascii?Q?KVYEWuvu7it8EEWHqUAzUr/xjsWo0+2EAQPmo3B8cxLYzZ8lwFmFEEOmKSlh?=
 =?us-ascii?Q?Ipyg5N5i07K3Ou5SPl62/XmDGb9WY9rjMzrCjtmmZVZBIRh5+p3S04kEXRkP?=
 =?us-ascii?Q?/FvOs7TRYjhngtatQciL2oEgX2Wgq6Rv4IJgOXdDUpctslJkLh57xQXhvdzC?=
 =?us-ascii?Q?OTyrGj7V6qEzmhYm1mWFZPI8xkC8Ejkqd/mhZ4Lk2WinfkgSgWmSB7O54Aqt?=
 =?us-ascii?Q?zWDTPQVxSX8mA6g1c6k2/OqnQjR5WGkN25Mf3qebE5MeXjw44g/LJ0TuZcII?=
 =?us-ascii?Q?sidDs8yTet9cPVNEvSTJB3/k5isLjaq3MnbbOdZt2co9blVW3L+50/Axz5J8?=
 =?us-ascii?Q?d0YmP9OGM0ZUkqtygvywDO2d/YlKa+tJ5LWjbI0AH4d8/hIDkrrZtvyVIf64?=
 =?us-ascii?Q?oGP1Lb+8AwIhGA8l/pWpiycmV8yz/s41O9uXOJQa+qAPD4FqyLenvkGu5VP1?=
 =?us-ascii?Q?Rqso1X7ZUTVx59UmgEA1zhLc5C9TKZJpJrpA16Kr3doluS7RpcJjs9NTQgtO?=
 =?us-ascii?Q?xO0jOeS6/oiteXzc5KFsoZLRCAZvMg0yF3vOloofZOGTAlGmM+hy6TPZjleG?=
 =?us-ascii?Q?4D8Ar42KyfcHJ8+jwf+dPeJevKK6ab7EMIbIxkxt8uM3npYn29UJiAnIgcM/?=
 =?us-ascii?Q?WD4BtSOgebxryT7Ft9TjfpY3YhBIpgW7NcL/lLq1uzPHR+YXgrGg6T4Q/7Xj?=
 =?us-ascii?Q?lZbKVLj8fXN9awc27iT/n1a8JuSsMTp0G8lkUr5m8TfAfq3ikiUyawj/aXP/?=
 =?us-ascii?Q?zFb8Vaa0SHtoERC6qgvQ8bTly2Bqg9HVgBOn68XPsBo6E0dsdGHipgjv9D37?=
 =?us-ascii?Q?YDI6LlDdlwcV7wCs/tHe1gu53ecZZPpy2J2PPzYrTi/t9WHtd0T1dgNQPnrn?=
 =?us-ascii?Q?pVczWhNr7BBlh7Grwd1NfawoQTxfd/pczZxXGien51OhLS9U5ATIEmbbnJxc?=
 =?us-ascii?Q?NLJMTmZpg8gtKGaVbFjk6pTR1AdPXJaaPhVKgMvWYOj8rgmJiyKt9xxw+7LV?=
 =?us-ascii?Q?UsFouZ0XRcaE2QUIB27LqVznh+71meJ2FoYIM5KvnIzje7YR4Yp9m2+F2GSG?=
 =?us-ascii?Q?W4lRo+Tn9+Jr8p4jLc7qe24MqDSzlPqBHPgJoMFWUisBoFuXmwMYkOmsCMwV?=
 =?us-ascii?Q?s8dre6K08IQJKsH/jclohWbHxdst94dWm6UqardI3g0GqjiAyeO7Op+5i5aS?=
 =?us-ascii?Q?L+Q51ebeFa8lGUlKD5hmgO3hYkicwQY+7ZlWeE+PuGUmOBPQlpyJzahN7i8W?=
 =?us-ascii?Q?nCIAmyzDUDHubisrCDw5uPUHvLxDmXVkkg0j3zwqFDMmiBzH1bdCVUolqekI?=
 =?us-ascii?Q?MqaECfQ2tRIqsFH/pMAawOYtLQoh/pWKyX04UPm3voQsXdjqpNbLLIO2Lgm7?=
 =?us-ascii?Q?zZbM/oPnZftTJgLf8FYmQ03DAcAPbsy/fVe6He8xjI0kZbYOFy+nLbC1uRDw?=
 =?us-ascii?Q?lBlzflXWP1BuBII=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:42:59.3213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a506aa78-a1ef-421c-11a8-08dd57dc4989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

VC exception has an associated error code. Update the IDT
handler for it.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/handlers.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/handlers.S b/tools/testing/selftests/kvm/lib/x86/handlers.S
index 7629819734af..19715a58f5d2 100644
--- a/tools/testing/selftests/kvm/lib/x86/handlers.S
+++ b/tools/testing/selftests/kvm/lib/x86/handlers.S
@@ -76,6 +76,8 @@ idt_handler_code:
 	HANDLERS has_error=1 from=10 to=14
 	HANDLERS has_error=0 from=15 to=16
 	HANDLERS has_error=1 from=17 to=17
-	HANDLERS has_error=0 from=18 to=255
+	HANDLERS has_error=0 from=18 to=28
+	HANDLERS has_error=1 from=29 to=29
+	HANDLERS has_error=0 from=30 to=255
 
 .section        .note.GNU-stack, "", %progbits
-- 
2.34.1


