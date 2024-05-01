Return-Path: <linux-kselftest+bounces-9212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E28B8C35
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6E01F219FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF112F385;
	Wed,  1 May 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BgrMXuJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03E12F58F;
	Wed,  1 May 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575325; cv=fail; b=XPQPb++3XTHj8Hx8nj+GgbflXHh8eDAYG/EzgPyEJazPPtcXyb/JIrsIKPRj7YmeweuqT5uziKA+vjj7Q9YKUPw6sm2EfxE1zzKyoD2NjPuJk5zCDXbqohFtvwM6lPV0o2QkiPIQBdcHo7rw1gPpyjDw+rIZabw/AemRpdlEt48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575325; c=relaxed/simple;
	bh=W3SoGjtP3/E+c/JuG/ackI/Xac4zWkk7EDVFsDH7UoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEX0M/EJbUR08hNtoKi6N9HYjIOQJPneKsD7xzihT7qDhKYL376dMfcAW+aJ2VCZUy+gzMy+aLUI/4UPv92AwgOOI9l83XuXatvI6wVNjZ6BmpYdazlozoMo1qHPzH3xai37ksLIgSSFdOihzjWFRDfIOT/C5bzoGQALBel5wIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BgrMXuJf; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaA1OvnW0w8BfIvc/VgJyFo4xd3Fa4PiOOQinK38ZFKhll1ubguUsq8Sjp2YMzMNASHn6PnkiM5Kk2OsV28Kc8yutJV9s0ZzM7lMoMmc/EOrTnUeQBccHrdrBHO+aY+q4ZeufYZsgcnyggBg+glOAg8mjwmtYE3Ufb9Jf0hPC2yfdhZ/W5rcphlkqDNabLXiddHDQk1kIz7ZD9O0Po3CDAtLs0GrjYAuvaPlks5iU/dkmvL+k2Kup+0r590fXExmILDz2MR63LTmNXXzT2C3Btwp6Gh6cRMobWnH3ohpppOT6X9j+PZuVG4rZWNp5HH04Ow3vzs9HOelsSeTEzwNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqDkOBpQO/PeplcaBdvoCMmeLxIyffTnBOx2f9spVP8=;
 b=b2xCbi5fIsdWGFS8qCg4tUacVDoyWSHH0Xap3/F7TgQm8PC3rlKmOai+cLDs3AOimaidwZBmAb0yC1f4X5shImYtqc0yH5SfyqNiRCG/gAO1ifLpQn3eDZHieL0E67oiivWkXzv/KWjuc86AzpFyBl4HWGkuTQ+IeXjviweHtHiPrlQoSmOjY+99joLLqfSV/xb0FABQO/Ppm+0wX/L8dut9xhmMPDB1zvPFlnVt8nJApv9XWBjcE/wxqVSFtRozkG9TTv1ATeAxJ2c4E4Two335RtyegwrF5voPHf/smZGkFGpLuVSmMx3RCoxixNBw/DzvtsVG/qrfwoGCKyKFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqDkOBpQO/PeplcaBdvoCMmeLxIyffTnBOx2f9spVP8=;
 b=BgrMXuJfoTTvafBuMxtRgBtOVXqRk5AwcKtGDJAeFnvQvFgaGZt0qte1YW7D+QePN630NbYNNO0G2wfrtIGMQyKYRqYrAa8lKBtTxJwUUN7q0fW0MG8KoqY9Mdgq9/xQ1wLRRe7EKHqxoHZD10wIpYXE0xGbMGiIxc/xZXAiHaE=
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Wed, 1 May
 2024 14:55:17 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::12) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.37 via Frontend
 Transport; Wed, 1 May 2024 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:17 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:16 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 3/5] KVM: selftests: Add safe_halt() and cli() helpers to common code
Date: Wed, 1 May 2024 14:54:31 +0000
Message-ID: <20240501145433.4070-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501145433.4070-1-manali.shukla@amd.com>
References: <20240501145433.4070-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7ffe09-37c6-4baa-e6d2-08dc69eeb70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t32FEH+rMWn3TtGEXF+33zArCy6EodW8FXXVf0NF4heSYS3/6LibTFJKy6lV?=
 =?us-ascii?Q?rLSs+YPndJhPdhhKIpkSuWrT6zwkY0vScC9DQiPin8rjwVNnonUZJ6t/hP5o?=
 =?us-ascii?Q?08xxfopwkAKthgAuW4NB05z+EgaeVrD8pZaC3jDXLBZH6PT+zJnU5O3JRyER?=
 =?us-ascii?Q?DnKRrR5dtP1YljotsJrPwGHSVBu0Susj/klEH8OqKLsF3nJIaZNm+EcVVg+w?=
 =?us-ascii?Q?ShjrO7vW6ciPNioQtCRRUFUrBszfxhA/lACyabc7q1+MQprg26bYZOviKtsd?=
 =?us-ascii?Q?/11PhpqB5S77VBTyWHE8Gritp+HZlhrQA0gy0Qhtw/Z3IkOyjO21ydVf5hCi?=
 =?us-ascii?Q?1osKtDwRRQ6s4EJKrC8npSIQmxcFyFuOgd4x87TS0k8QXlufqNXgL+qit5yr?=
 =?us-ascii?Q?8brd74Hvt5O6dF1ubLzQYv0WhoTxOyX8vK0NLN6Ji5LduX+kdN9xis9hCOmJ?=
 =?us-ascii?Q?ikSUkZZmmUpomUyYPad3WM3TWtjl1IUVgUsgasKNRWL5ZRyhoV1Pt8e6l9jx?=
 =?us-ascii?Q?/Y6qphm7lZbXjzBiUAETzILRBykcjGesLayhT0mol1sgAHCMOCcNpfJ5TZ7K?=
 =?us-ascii?Q?B8uZwA2Bkv3Av7uNm7geEr/3LTBJ9Fr0SQ+eMClNkz5OMW5kbOLaXaHPobaf?=
 =?us-ascii?Q?i6gfBRXiKYgWmtyKzxWuEZC4weuSQygGPTnzQ4nqwfky9OZQZxAqu4c1Ymp8?=
 =?us-ascii?Q?UvOr/y3cphm5fJM1T2gjzgdE6aXiv7kwpsb5rmNHgo5DVyHNkvtwRhzSKvZB?=
 =?us-ascii?Q?Rf4/bC39rWg3eMTpm+CTnRxOKrbodX0dHNKdPx7VtLLX6L1OxUKodkTJ0Afq?=
 =?us-ascii?Q?b79QqXw0d5flLokIkw/KdtbBGhVhHXviicloK2rvUjc2J+/+KLJro031+srk?=
 =?us-ascii?Q?E4I16cbt4E/OdhQ8vK7uyzj877gZiNcdB6eNGCv8r8TioGoLk/fsToAdTm9k?=
 =?us-ascii?Q?AeH4iYcgbtFOryDYMXFaE1e0QXutKNMSjgMZYaE2N7x0RBEZoNxUDa6TbJ44?=
 =?us-ascii?Q?jlQA20KE+/PtHDC2HSZQQJPsbGi85J+I8QaqqFj1IyeHK/A2X5E0QGmHkB+o?=
 =?us-ascii?Q?7x8bX3/5QPCOuE/9r1AP1iGbHhKkbn/DbmM9TJzhI/dJI8PR4zyOsTaoeXSO?=
 =?us-ascii?Q?FcfpQXhF4w6D1H5TZz3wB10QCr7yYBWVFY5cfEiaoPelbovp0z66RyBCTvXN?=
 =?us-ascii?Q?Gm/SLibNGxePffhIzPfvHLmBaS0S5CjD9t8/sJRI2ZyOPv6N7NAjHe9gxQB6?=
 =?us-ascii?Q?eq2RUY3lv4cL8yQ0JFue2d4oVocaN7YrFDF/fFZvrQU6UW2DHQY3ssskrDyu?=
 =?us-ascii?Q?aUGPXLwNJXeXBDkqdZEEO9ST7y1YzuaZmVg6yyn5XqvrwZfEuZ1Ewvwcldx1?=
 =?us-ascii?Q?Pr11vfHtyfqxIwvXIL+C39blIAco?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:17.3482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7ffe09-37c6-4baa-e6d2-08dc69eeb70e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910

Add safe_halt() and cli() helpers to processor.h to make them broadly
available in KVM selftests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8eb57de0b587..f74f31df96d2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1305,6 +1305,23 @@ static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
 	GUEST_ASSERT(!ret);
 }
 
+/*
+ * Execute HLT in an STI interrupt shadow to ensure that a pending IRQ that's
+ * intended to be a wake event arrives *after* HLT is executed.  Modern CPUs,
+ * except for a few oddballs that KVM is unlikely to run on, block IRQs for one
+ * instruction after STI, *if* RFLAGS.IF=0 before STI.  Note, Intel CPUs may
+ * block other events beyond regular IRQs, e.g. may block NMIs and SMIs too.
+ */
+static inline void safe_halt(void)
+{
+	asm volatile("sti; hlt");
+}
+
+static inline void cli(void)
+{
+	asm volatile ("cli");
+}
+
 void __vm_xsave_require_permission(uint64_t xfeature, const char *name);
 
 #define vm_xsave_require_permission(xfeature)	\
-- 
2.34.1


