Return-Path: <linux-kselftest+bounces-10757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E098D1344
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D021C20D8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB519208B6;
	Tue, 28 May 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4TDxtQzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F81BC40;
	Tue, 28 May 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869987; cv=fail; b=gpQ6T/kdPWvP39sOcA0g6hCzLSRDGYCPgU81sU0iu88U1lP5vZyYk0IBkIWPNNKVgov+7pGLWqy5/6Jav2TRlx2QsyCWFMBaEVXHW4VaEzrc/8+MJ8P4etGZS1IZqWAv0nZ2eXFY3HsKatuqdgQIbt9KQ6GQWxQ/rxlg1r24TPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869987; c=relaxed/simple;
	bh=W3SoGjtP3/E+c/JuG/ackI/Xac4zWkk7EDVFsDH7UoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2T8/FX7mZ+I6vdOW9Hq7gtZuEI4AHh1aYe9LkC/DZ3C5wpGOEyCXnVu0+YiXbxkLpD28fUTicnUYgJJFI9sa0aA52AhiFS890jTWCijQwqS8B4SggF3PQYd3Bqi05MIBvmWbFnMj6XJ+x0r6/AlcFJI2KfXZJNBXA9iNDnPp3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4TDxtQzX; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0oyM/2qaSV57iNZltFGDhrRbQlagwiVq9aSomTN3rpEDAkXRRChOY2gV/o+1ZB8CEJH4LTf/jCOZSczmjDyVdoss/i4gSseMVF8XJSx/cWJzD2YGVzg3Gq2aiyV6zmTe4lvgC+RRuz7spysLv0D7uqNLSdVU76t4yp6LZPW43T2HxEiHNPJv1mL/0KN9u124c+Xe4agkGyYLApYY/+793xTKmlG0rktoNZY8zY8J9AGjzHpqRdp3/zjq3m8VZ+8nIXOMBgzrm683al1fzJ1au0Uzgieqvx9NBvUIV0C05qHg+WT0fNqgZlMs0jwCraj1dDIBUG1HyNr6xSXQ/q6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqDkOBpQO/PeplcaBdvoCMmeLxIyffTnBOx2f9spVP8=;
 b=euHXIrKHa7tAD4evkGWhOB3KG9DorWeyXgbwZyN9g+t9bJrYuwMzLlWEHrLsjMzmPAkoFzE0OQFp9UrEpSo0ZCCQmhZhT7sv5nPeZ7d7bAYnHSxCNvU+R4ivt859flhxqFdMWJvvkvPmZH6+e+y4hiDvfervHodkZmCddDTpmVK9/pXDXZIrAB1sSZEn2z+Yt65X1ObsBS1F17auS3haK0wPRk37c/7h58NISQgEWYaMYJ5rZgDOI7IonYskfKlcez00jWy/UiX353Fe2hHpm/06zaP17yChwCCwS5+P81TeTcIvNKE5bBx19ltNGRQhocbIJS8Z6z4SrsHye4SiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqDkOBpQO/PeplcaBdvoCMmeLxIyffTnBOx2f9spVP8=;
 b=4TDxtQzXYpHfvv4fu1odjYeMEuB2sayyjwivhXXzbguh9QzjlSrVPWKTZ4plzMMi9Tm3RP/1+stjrtdooKN7MTcmkVAV4nL6ffClHsbtpyk+KIJZl5wJF539VXxvAVNgeRQHGdHj5jgW7vEfg38n5acuI0/HWleN9ztJ3RtcDpA=
Received: from BN9PR03CA0845.namprd03.prod.outlook.com (2603:10b6:408:13d::10)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 04:19:42 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::6f) by BN9PR03CA0845.outlook.office365.com
 (2603:10b6:408:13d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 04:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:42 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:41 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 3/5] KVM: selftests: Add safe_halt() and cli() helpers to common code
Date: Tue, 28 May 2024 04:19:24 +0000
Message-ID: <20240528041926.3989-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
References: <20240528041926.3989-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d2f06d-2bb4-4495-b356-08dc7ecd661a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Jpj1rC/0YHPEFqcWaMsrBH089N5yumm1HNlDhxj5krliFp2877OcbpQyrj1?=
 =?us-ascii?Q?XeyL/aFlucg+mnAdJm+X6a2NFYCb+LtDakrkgODBo7sAayWh2Zx11FUAKjnt?=
 =?us-ascii?Q?HBVPCiNW6MVVvuVY5EBrjxPBJUiumzEswg/u9WpsZ9MF+qwpbAn3Q9BPfVid?=
 =?us-ascii?Q?IV/uelwJnIXe7voKqPOcTKxDxuGyClskQxseaKCjzXRfjCl9sRn25/VC3TCp?=
 =?us-ascii?Q?+mbrVnfOpzLmcwtEWtWXwCzQMA2u/DXhq6dwIY4QourLD0uKTamwqwUjJNRk?=
 =?us-ascii?Q?kITR2HZon3OdT5MkdgCrEgW49MLzwltgzQUAG2iUQXUPk8lIu9qTM3nF0Lsm?=
 =?us-ascii?Q?1h0TR0AtWInSJrd3wliwim0aAyRLpAbKstUrhIko4Sh2po1zyXYttZHuYfup?=
 =?us-ascii?Q?zGzybzy1F7v/CsDz83tDBZqnf2bpUeW6a7wTMP0ypwhEwJWUpafAH1PzW16q?=
 =?us-ascii?Q?PIEE+HRKqjljJev8HbJWxuj7rli+7razSG6A7NuueZ4n7vmHgF7bAlAV1GRI?=
 =?us-ascii?Q?uEwu00Cv71uql+MpxxeZRiptjylNxmAQALVRD+4WRPbv45PhfNRExYGKIjoW?=
 =?us-ascii?Q?1C876DWqvrQ8jFMo6fHHjiLQEaHg4ls3qQe3RgcgoflcJMQPvrjyuza6Hfot?=
 =?us-ascii?Q?NtS3fMZ9nGck5fMSpUnmcgrkTZDeN7sDAGw8WTYcAgViQ5RFFKTIK8nsGSEC?=
 =?us-ascii?Q?ELTnN/Wnd1/NEjeHY1V51lfyQKhXIFupQE9MkuAfsHGXxj0/5Di/XfeEhOuG?=
 =?us-ascii?Q?30B+JE94GIIIT9YFvDHUTD6/l2lla8qXYvTARLRMxnKhqw7KmjByVm2z/wFI?=
 =?us-ascii?Q?3PmY1U00czdQ54IC/+qMRAWyHZXc+UzASWY4zCR5YHig6vtd/u/GrRJwY6BT?=
 =?us-ascii?Q?30nQ+kXmoWRz9UU2EKdrk8oVmMvshEBQTidQxM+W7UvNvcbygJQ7zW0PbKld?=
 =?us-ascii?Q?6sc0jw8WLMUV7awk4+Z0PStKiWQASb/OCjxUAre6I8tx2PV69p/rh11uUBHY?=
 =?us-ascii?Q?glA96yJF6ftsOZ+enWZm2dgr0PxYH8SK3V+JxSPeM7/BhajS6mAV5oflclHP?=
 =?us-ascii?Q?YK5ORAfpslz12lqU4BPJTqQL366/mrr9j7v1P+FiL2waXrDhJLNng5LQjFYk?=
 =?us-ascii?Q?wb5ZLR/0JKyeEgGDPbu5v5h8kX3j69kbvZppu9koH2CKGJZKwWbwV+5trzZQ?=
 =?us-ascii?Q?SfQFQcE4zPa94XnxZncCtWU3a3CSZo2LbZCy8X+JmFRthFuyyuxqa3ZWlgjc?=
 =?us-ascii?Q?2HFlRP3jlB//0Q3OZjLB7zNGmAzqfzZ6pK4xk+rOAPhOl2Cjl3SjVRK777Dw?=
 =?us-ascii?Q?YTBQ6VLLoiEmV3aS27AtsMZl6nUeEAg6RWAOltDMdsh0Mug9tzr8pZu79c27?=
 =?us-ascii?Q?HLACDaPLJ4TbOmzwW26ZmQHjZCts?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:42.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d2f06d-2bb4-4495-b356-08dc7ecd661a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

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


