Return-Path: <linux-kselftest+bounces-6693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FB88D5F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 06:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4951E2A4BDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 05:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EAF14A85;
	Wed, 27 Mar 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4NJwciGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B5D304;
	Wed, 27 Mar 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518195; cv=fail; b=b1MswBddF42+yYbmpKC1j9jTnDDO+BiAyxVog3ubfu8DzXoRvCASQF1dsE8N8hb7yJ0wv5xTzc0tOHCUz7L1F9Ccd4BwkxoL4URQmKw8KTJpsJBatUnIBz/q1jHppuSzYXGADeP83pl+D6DHDafD81EnSQ17tjfQdK0i22jmwxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518195; c=relaxed/simple;
	bh=ySJgZEUorsCyEp4Jdek9zGeISNzGTW7spH/Em6PGwO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sj1uSV0j0y0rAwJ6JSHv1IKg5FfHnIJk/l9vgK7uq2R3EU0OYnIzJ9ywsu8dA/YUW2yMp+NZAL1RxS7BWaIcVsiwZ2GZDNXsTsqi+blVrSdNnSVd8KoGNSbTnaGjsQ1ygay8Z58Oc+aaH9pPppVN8o716SOhSnk0pm/58NNjD08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4NJwciGK; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfzgCY3uZVQLwJSDuKm76KfQBOEmXtgJOCFSZr3Ci5+Ww+f8mWnimqdkkUplWjK5S4VJPpA8dGzqsPehPBnNHYQvA1XQVGdFJvcZ96V06v4GgcBHH+LJBb6uZEkH0mYHitLcDF/QlwLnA1THjMhhhJNZjYG/Ej5TrcWk5T3gEhoZa3ckOa3IbDHF7L30HT2qpQg9YVB8Pg/UR7s4RxJFG793d7RFqL94mC/ljf8F+bEZPidMXpZTlmp90/LtB7RW0rFQ5NdlsIo565GaAGW512KhDve64+EJGC4lNIZ7YqkP1KSPcSKF8g3bxFZ/ZZ2IDfzODWfjL8KzFJgZ3wmMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16shPcdruHzE7YytYMcJenoFtLuSK0lr88DixnfrsIM=;
 b=d+vZEGPeQzV5mrLhfTF5afICPN9HiXVDSVlwFk+tzCV8NpGnI7VbaDNe+Kr/WgOP7B87seFJZC8W9E2mQRXoHMojR3lSbPiMugGxGgk8ASAo7Z+DXspTNuJ8oaLx3UoDvjIR2hHr01OxXtoEcRXJsDrYnn9URK8GFWQ5fywzSDtV1C96iK+n6j7TLmKna7ogQnqU5wxKIwW5JZD8doKHuuyjm6cjRjGJCxHqtx285QfhRQx20gi1b8fqrtyuSjFcAqiVNqyztPz2cPrrz1m+X8k5+QFqDY/qFOV/GcegkHFgKh7lRI+hKch3lh+DBBGEKPsbc/Bi0nFBdtJwICcUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16shPcdruHzE7YytYMcJenoFtLuSK0lr88DixnfrsIM=;
 b=4NJwciGKAp6r+e5S4PqcpkH6zhZCAkdbhRL9QqLULnSqFqFqBo7qTIBcwaFTcbvUTBXCsHSKOkFcR0TstVZonb10uUeBNrFK1pfE933bxAy//nAOk5FUp+4tNte4Pp7pRHLYKzVJQrR4qsOBZf9qZ+Ox7wyBpGUsbw+18O33Zuo=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Wed, 27 Mar
 2024 05:43:11 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::94) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 05:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 05:43:11 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 00:43:09 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 1/3] KVM: selftests: Add safe_halt() and cli() helpers to common code
Date: Wed, 27 Mar 2024 05:42:53 +0000
Message-ID: <20240327054255.24626-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327054255.24626-1-manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f7ce94-b90c-4404-aad1-08dc4e20ca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CjfYFkPcVZp+lD5/B+Fpu/b9gHDP3SfLRUZ3X04aFzNG7pX7dAwve7YpD5D5KMwTAbI9ozde9r+9NgWY98pPGKjKJifi9xRNl1Q14eKEpfzOFaZ3gH3MKN0/3iCN14NbVgDsUddq29e8zIC/ASG8SyKWv/gkwY+7Ql8DEO9V39Sc/01MWqhnlGigtjqqRdOiy5Z37Owh/68uuaFCSwXL2A+lBDLmCU+0c6le7Pfril+QZyF3Abuv0G77hTCG57/MNZSyvrkCf9XnsaIpW0mCmIsx04luilzwugqUUSx/csS/oS8NQlJqvxGxeueogIk8GeN9Xf9E/BVnT3J/V+083tfLAtLJgCMZGco6neZJFuP2H6q9w83N+8Xog8ETxo+EsVunI5+js+JFAH9LoqPA1FvOB0XMglY+HEXgUqgnt5RISEAsMUHUsTr3jEmOoTUZELf446bLimJUN6LFi6l9ZTJkcsYD+A3u7BafDpcAbsa3UQxOykGDhe88ypTSOYOx3QHCdkfdNMBtPnlae5Pi/ImLM3DfCfc5F5X5gDpHtKgjVzBZyAYv1+AlcTSmwq60ircQrLelJLWb6L78yGTKfEJ8pKAByJcIHu1t7BmPJwlKMdpvsrkI5yPWaKz/l1bUgKX1Wj/7hL2qGalbcJc/ZlKellqZ2J3XaUyTq1aAbuHc9nC37C0OAl6v2W97qMfH8ljV0f7SM3n0DotBvIeVCSU+RO5V4mzyj4lhuSmbiVx2H2m48ZgYcJHxOlV6yzI4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:43:11.4693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f7ce94-b90c-4404-aad1-08dc4e20ca09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761

Add safe_halt() and cli() helpers to processor.h to make them broadly
available in KVM selftests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 20c9e3b33b07..6de37f6b8ddc 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1217,6 +1217,23 @@ static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
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


