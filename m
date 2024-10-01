Return-Path: <linux-kselftest+bounces-18718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A598B479
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883561C209F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B281B652C;
	Tue,  1 Oct 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5HOa8gh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D929CFE;
	Tue,  1 Oct 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764477; cv=fail; b=XyNqty9lhSTdGD23CNtW65s3MtpoLxMffahahq6MVOh6N2qg9U+v0/7ggSRa7efDVnT/PbX09CShM6fx+maHMPZMKoEMu1iH+rw5Jd7XyToJ5kVCWsKE78GkOwNtouFo5I2XNGP5ZcUH8lebwFFhoeONzm4iZmgssPg2eosSlq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764477; c=relaxed/simple;
	bh=W7rWJQnNG/rsS6Q0gW46trLmZg+EAZunfhxSdK16mMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gs17wMsUHwcQXmp1/OBON5mEBDNFq8tA8mjiz41Wjgjck0LU2in4mih/EjGntQpCwwPTcap2JJRifyRuJVJBBpr0M5ZRutiaPy1+51HMX+sPo8K6+ACJAIpatjz0CwT27KuBGTcSD7fdjJEHEihFq0wJ/0zPAy4HbSkjAVXhUKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5HOa8gh; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkdROzfNriUGwea2ybZ8zLJY1l5l50lgDvYtsl0RmfkuOJXFtqjEW03j+0PnzT6W/vDbH1qvE5Cw7clndkZlJNu2CvENi4qZdqKe7+49vyNRw8o5DuXpBCT05CDt8wyDQJH4Dp1CUxF6OhgteXu9jZ7MEhNJFm2rE8UXC6GlGWrJTUkLNIM5nw0Lex3mooAsfn/MihPXnImCW4j9wc8cQMH3akZ4tLDJi1b8MA0QbBPuzAtYLL/OQvbW3gCcZZMNHcxm7hqAYwNWcLrNauxeHqIH3Uat3xLi3pUcS+bXsDSsQSy5+jsdeNbO5dUpelSKq/2haA/X+oJQcQUVvkSV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqUjXN6tSicSc+0iHOqozmpfKWr1l09tGvQZPfzw0Dg=;
 b=Kd0atH0enefAozUMt4V1/U5lZ3WDzuGjJtEACN5J6Wu7HR/VCqFRuahdfhcubMY/6PBmDWzDlxS/33kYLI+z932paah44AGwkQ3swHIvwYru7X/p4KGlHsiIwRawJMompu2buLrR2C+tS8jW20L1onf7F3twY/yat6QVhr0f/IIvhFCwmJiVtWfLKdOUoYttV4Q1FYB2/g23XYz0ZBe9Qyk/lQbiAIQBCt+gVZ4aWbT5eiZojI8yitd5einMuqXiWwi7dg9NgMLJ+LZ5S/0eWX17BN95qAkQpX/2FiekhLvT/fHrpR/pCySugCW6SvyFbGa10Iauj0ObYSYLvyouJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqUjXN6tSicSc+0iHOqozmpfKWr1l09tGvQZPfzw0Dg=;
 b=i5HOa8ghilDhYJBXSsDhUX/QfVmAmZ8iMr7S3mc8kWtrhkUAB26fEWsHIbkXeH9C+7bKdXX5o01AlyJO+dlirSwMaB/wPRXIgPqX4Iyl+OzuunB8y9gADjTL4JkEP/BltZgGZkTBtT0M9O2DowXa6ucDzuh+k/5iDx/ATyCinZM=
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 06:34:32 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::21) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:31 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:30 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 1/5] x86/cpu: Add virt tag in /proc/cpuinfo
Date: Tue, 1 Oct 2024 06:34:09 +0000
Message-ID: <20241001063413.687787-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001063413.687787-1-manali.shukla@amd.com>
References: <20241001063413.687787-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3461547f-6a6b-4e6b-3ca8-08dce1e31bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1ieJUrhKaBfzcQrJER+Wns/XFQpd3LsB0fJ+3llI+jOvs9vN8GWAfzgSwCx?=
 =?us-ascii?Q?lCKlxUiKNoJa4uhRUF5FAWoNpgJDIBSMMu8rF+J2eA2lQqx8uY5A8N88unTr?=
 =?us-ascii?Q?g24foWbusiqYCrEEf134XGQZRRLWLe6koOeCYjecjT+Fj113zc4jQlqSIilt?=
 =?us-ascii?Q?CW/4AmX+3GlP4LFo+9yGbAJwgvr1MBk1LqQZd9EjKaP4pEnbdHKIhAvDT0Ll?=
 =?us-ascii?Q?oF3qARitdiPmbln8qVvzeE8t4A+REWQFiGFoUb8J1GeN5vR43GsJ16i1JiKY?=
 =?us-ascii?Q?f5Watap4GWLKtDrKKhmQaX6gofxm/CxK68KKT8DcxNmjXT/vPv3zRezSULlN?=
 =?us-ascii?Q?KqYuLmURNkI/C2I5hlHr+pC5miD41bq1K2uZM7Fq6zCCEvzBKoB1Da8N3w0s?=
 =?us-ascii?Q?pglVUfe3NVUD3Dc2Y4NqYqZsw7jLLw0Le09GrO8sWylDlufS9TqmVwzx2IyF?=
 =?us-ascii?Q?oWkNKvXA9p1IyoEAWOtVt+R/ODeDgvFKsKvN1MB/hKUBiidO/yS9fiKUE3ah?=
 =?us-ascii?Q?sKHiKZx9qnVYdwW65H5zibu9U50YfHN0YF/X5GuP3u6a53tJE1QjOFiP4dp4?=
 =?us-ascii?Q?Eevsopg730p2yWKFX6Dos2EPykbIxda2sGfLPXAG/EltTvJl/7gs4PrHljOe?=
 =?us-ascii?Q?OVho0nmYuGA4UPJj5AYIkaPgFGx7hfQ7YI6VhfbjOqdopEbdBcSftK3v0BfF?=
 =?us-ascii?Q?KM0wKWIllX3MsjQOCCRtGTZHC6zOVJp3R4KApqHKDMOU2lKcJ4vWLIN0+z+W?=
 =?us-ascii?Q?g4oovOqofbulkWcUBno3VlFChHa7Jx3YNMBUlyAM/Sy6Z/JURZtlU3Z0aMQT?=
 =?us-ascii?Q?840v1McIWo1po+L/mwnykaYgzjirJEGP2b9O7ApxTVuus086LeiDYbJVHWkQ?=
 =?us-ascii?Q?tMBj4blvPQ6cDGWQy5iFTFLj6yvjgkUAQaa/JwMfO6om75nXQDQWeOXDucLH?=
 =?us-ascii?Q?ONWlTPJH9DvBW+OL+qX7JqONJYK/PJN3mWrg3MwW8yEE+rsj+D3+NMIh+kau?=
 =?us-ascii?Q?RyV1nA8FuQLRPF4sRJP7pLToPRnJN2785T+tkCMzC58TqBqo5v/pX5GIp3CF?=
 =?us-ascii?Q?ARuNQvOsJJN790/XrsWrRufrQEbDFHbwACuhdEH0/Wbu7x/ltU8Ets4s/El6?=
 =?us-ascii?Q?YR9Jm8d1ny5zHxyJsVDRCV9Oef4OnCraFAE0ji8/x1rPCdYa7aKSSG1I9Xmz?=
 =?us-ascii?Q?21TFbNQEzWCKE1ASy71JvCWOZPJnK8P48rHyF6sXAwnIM1imiIQVbkfXTdNr?=
 =?us-ascii?Q?aYsiLIF0oiu7cal9TzSAI+5MTdne5qmm7ObtQa18pmHYBMOZcTpn0gIpBhWi?=
 =?us-ascii?Q?tuGTU5GFx79iTK0j6qaHMz0ckXf/5XgjtTh/ry0E8nHDqgBaAKxWVQuEbLw/?=
 =?us-ascii?Q?EBEaVGFFypYjyODgx5IJtKjC+X4M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:31.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3461547f-6a6b-4e6b-3ca8-08dce1e31bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

Add support for generating Virtualization feature names in capflags.c
and use the resulting x86_virt_flags to print the virt flags in
/proc/cpuinfo.

Currently, it is difficult to check if a feature is supported in _KVM_.
Manually querying cpuid to know whether the feature is supported or not
can be quite tedious at times.

Print the features supported in KVM hypervisor in a dedicated "virt"
line instead of adding them to the common "flags".

To do so, define flags which are needed to be added in a dedicated virt
line in /proc/cpuinfo with prefix X86_VIRT_FEATURE_.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeature.h | 1 +
 arch/x86/kernel/cpu/mkcapflags.sh | 3 +++
 arch/x86/kernel/cpu/proc.c        | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..74c52bfd8cf2 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -41,6 +41,7 @@ enum cpuid_leafs
 #define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
 
 extern const char * const x86_cap_flags[NCAPINTS*32];
+extern const char * const x86_virt_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index 68f537347466..3671c7892c56 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -62,6 +62,9 @@ trap 'rm "$OUT"' EXIT
 	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32" $2
 	echo ""
 
+	dump_array "x86_virt_flags" "NCAPINTS*32" "X86_VIRT_FEATURE_" "" $2
+	echo ""
+
 	echo "#ifdef CONFIG_X86_VMX_FEATURE_NAMES"
 	echo "#ifndef _ASM_X86_VMXFEATURES_H"
 	echo "#include <asm/vmxfeatures.h>"
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e65fae63660e..3068b0a110e4 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -103,6 +103,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
+	seq_puts(m, "\nvirt\t\t:");
+	for (i = 0; i < 32*NCAPINTS; i++)
+		if (cpu_has(c, i) && x86_virt_flags[i] != NULL)
+			seq_printf(m, " %s", x86_virt_flags[i]);
+
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
 		seq_puts(m, "\nvmx flags\t:");
-- 
2.34.1


