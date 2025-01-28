Return-Path: <linux-kselftest+bounces-25304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD559A20AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396D87A3E2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026A1A23A4;
	Tue, 28 Jan 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XEahunC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B019CCEC;
	Tue, 28 Jan 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068529; cv=fail; b=XTZO6GBZGco3do+DDxIlnHY8igk0+cZVBZWaoD9jqqLJyB4RuluVdz0FJY0NHUx8RvpOii0L7uf7K+eXUvDtt2L8sUU4GCZ/htOjk0Y2uuHm3MlhVaJ32KxCFppHrfq4lFdO/tilhF6ctHQM/Bz+QgiHcOnd+JT12sMdykpq6E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068529; c=relaxed/simple;
	bh=tWgY8cTdlv/sJqINWImpRVT8JXFAkyy3xXinPp/CIQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxCaBsBmK41YkW3ha7rrS/PQi4BBQOfDswlP7/bHTdYrERWadtQlsUIcx8uIyvhPflStHrIpBCA9n4DTVWCTtwkwpBR794Cgrie3SORNb6ksJcpp+orLmcflcVF7cTLktZiarGK795WYTobE1h8WQk0E2rloUrupMnntL6t+2b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XEahunC+; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF8ooNIztllXnKaPDTUwQ+s6oq0Q7sywru13+hW+f58iwlASCbPRfW8Maw6gj9tHirgJnioLJttSNJ/InbHsluuRsQYvbEQmBO4pyVFSOHHlXzSI1NYdAuOzorT0gD/GqGGaDv8nyRgsORALblI6CGp0kZ/GaeD23WjZo1ONoUc6KYGOt64Fxs/z5/wPLasqQozfznl/G0buHgiGSEzUi0EmH4ZA0TnNPnx8H6gSmo0Lu7vy8rom6hxLGvgwwj78YWH8LvLFzOWzJinHFLqornfDQevTSKgvQ3up9075le+mGLbfHcy25LVWTn93pZ5DkKFzjEfNzRKvsDTd2HscfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp+59hqxTpwyVeLL3P84P3XqtRKn1hzBi6Y5kNfcaF8=;
 b=HpzmrYBHuuPpNldGAWn5Z6QGBbZEPq8KE4gtXdsLx/r2mxLXwoABfgncrhwhnFM5ZNPpyBiBgI0PQbvhkhJE465cG0tnHsBt6PPOGb0et9OEdmDTmEpdecKLzXuQZVIACmHoRK+/KiLaq4QMHlPhKzFuqypaglcLtHpVIeNFkt1ejtOmm8GE4bg35C0ZZYz5BWdLHHXkOe4S1g4eNKh/Y6Vk3UbCpjiZ2L+Sd9JiVr8Fx0pA11BvulWZztasYnlICPCU396EGObFiJyOf9TbVfFBw1SyV07j3cs37iBLjuuxsVbgpX/WOmVhsAw+WJJMEVBoYdEfbck2pFEp7OBaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp+59hqxTpwyVeLL3P84P3XqtRKn1hzBi6Y5kNfcaF8=;
 b=XEahunC+U+ZDkpPTgKGChOsYdHo/BYxbLh0M66w9jqNN8bjXREFKsYYSstpKDkkMkDKgX2lAj11F/ERezkA1dYYLV+ThR9UT1LTWxM5UVn6Q1PU+iBVdFs8C4NvXdBrPjEwWYOJqAtIbYt5K5KnUljaxy1p94jGaqsJuSxdGCPM=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 12:48:43 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::d5) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 12:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.0 via Frontend Transport; Tue, 28 Jan 2025 12:48:43 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 06:48:41 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>,
	<neeraj.upadhyay@amd.com>
Subject: [PATCH v6 1/3] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Tue, 28 Jan 2025 12:48:10 +0000
Message-ID: <20250128124812.7324-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128124812.7324-1-manali.shukla@amd.com>
References: <20250128124812.7324-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0306e733-2206-4542-eaf6-08dd3f9a1908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejIwTW5sRWk5NFl6ZDVVanlPTjEyM0JQNTA5QldrSVA4OXFaRHdLcDJyakVT?=
 =?utf-8?B?UWkxdFF5TE92dlF3cnVMMGVSVWgrN08vRjM5MUdMZk02V0dJcHNmcTZtZUhP?=
 =?utf-8?B?cnRFN2hCc2Q5L1pNaXFiUEtWUlh0K0ZGSjRHcDJNZWJMZkZPVEZsdnh2dG9E?=
 =?utf-8?B?WEYvQ0hUZ2NIY1NwTVBYTUFvNTU2YzJjUW5Cakd2Y2ZtRWZ1TUk5eFNQQWc5?=
 =?utf-8?B?ODFmRDdJVzhaWFdYektMUDNxYkJkalNXaFlhT080aTFnVEUyNUxJVXdhSU42?=
 =?utf-8?B?UXJrQmRBeXZaLzJDSGtHbElZMHc3RHBMVk91WFkwQmRrenVQckhESXJTRGIx?=
 =?utf-8?B?SUtNNFBPQVpjRzZ5Z2N1eDNncTlGQi92SlNUR2gzTXZHMlRJNWE5S1c0eDF3?=
 =?utf-8?B?MHhWcGQ5UDlqTUs2eHhkZFRQWFdNeEp4eDBTYXJJeXpwdEk4UEsxZ0NIS25P?=
 =?utf-8?B?TkQ4aW4xUlJyams3Y3krSGpMekpWU0NXdGFpd0YxeFdTWEcxSWpGOHkwRG90?=
 =?utf-8?B?NjhiQWwxVlptc3d0YXhVWnowNW9pL3JVTHdlSnZNL01lWU5nTmM5RkZsR21H?=
 =?utf-8?B?U2x3OG40cWFxZG5OOEUybmxsNlJQYmNBZ3F5amd6cjNDVk9oL3VXRGlPRVhF?=
 =?utf-8?B?dXpqb2lRbDZqNksrN3owQXRyVFpwOWY4WVNyWmgyNzcrN1RFTC9FUzUzNCtj?=
 =?utf-8?B?bWthZkVuSTQrV3daZ2sxZEd6UzN5UCtqUU9FbjFYaGMrYlRxemY3UStnWmtW?=
 =?utf-8?B?bGU1TkFNYTJvLytBYmttOWVaREg2NHNucXNLa201bm83ckcvSjZTdjgvUm9v?=
 =?utf-8?B?SGErbkJRYkh0ZjZKTDRHazBvNGxjdWJ1VXFXc2hLTHVXSTJaN0ZRUW94cG94?=
 =?utf-8?B?cnNqUzZha255b0cvQ3MrSmxrUEpTYm93T1gxK2VNQ1hPVUJ3RzdlRTZmVGpD?=
 =?utf-8?B?VGVuZDJsb255WnR5M3lSQlJuVHI5NWNjbzczYjdnbTJwN2NEMXFGZkQyYUZq?=
 =?utf-8?B?eWpxcVpLczB4ay80VkUwNXhwOHNrU2ZnVzEzYTd0WVdvSnA0c2tvcVcrUUpv?=
 =?utf-8?B?SUFYZU9Cd1QwRStaSEZqZkJCTWxaUmFIdTVTZ1M2TU03Y1c0M1B0U1BuVERo?=
 =?utf-8?B?dVYxSmUvZWdXOFQxUkVZaWx2UVF5TXc1dnRoSXFrMFFhbmRYYXI5VGpYcko0?=
 =?utf-8?B?YUtRTE8wV1Y3MGpVRG1RZUdHTmNWYWxOa1Q0eEVxVnFuSlRJTHdIamU4ZEY5?=
 =?utf-8?B?ZkRwdTY2T1lweit2NVVBeHc3STBCTWUydVFUUjJKKzVNc2dmMmw0UDF2VzlW?=
 =?utf-8?B?bGlZMUJWVDdaYXp6MC8xbWxQMVVGWUZTdFhON0tkL25GQjZjUTk1YnNTTGdU?=
 =?utf-8?B?L2lvWDZ1NDdKeXVSTlZObVF4cWNFM2dQSFVRMGRRcUpzYTI1SEhHTjk5QTJa?=
 =?utf-8?B?Z3paQm5ZTkg2MUEzcDE2MGhOV2N0aFhjaktzdjBObTQ1azYyeHBMZHczb21N?=
 =?utf-8?B?MFV2SkV6YW43cWdNN0c4RTNvazJoKy9oVFc4S1BZbG5PbUdYOFZuTytPUm1q?=
 =?utf-8?B?SmVBYU13NVpKN0w5TTFoUjREQWVkMVRJWVVmVDF5c096OHJ2UmtwMVlYd0Ju?=
 =?utf-8?B?aDNyWmV3anpMRStyZjBreVlKNWVZczE2WExnZGNMZ2JkeDljMkpPT1RwdHFF?=
 =?utf-8?B?MDA0ZGZ6QnZPQzl4SWR1cXdUUE5HOFFWQWI0T0R2QmhVaWJRUlFBVmRyclFB?=
 =?utf-8?B?aXBKYkNLd0l3b2NGVHNSQjk4QUp3Y1FIMnVvYmNISy9xRUpTTVpLTWl0UE00?=
 =?utf-8?B?Y0FLS3RNSVpJWTBZeWZQb2N0L1Rnb2J5bERwc3B2NEZxSnVqazk1WnNqUXow?=
 =?utf-8?B?ZnJGSmROTHBkOXB3alZUMWxtRTg0c1k2R1lLbXF5bm95M2kwaHc3bWI5dThG?=
 =?utf-8?B?RUdNc1UyVGN2M2VQbFFwREhxQkw1MGNXM05JY25kNUZiY3U4M091M3dTcnF6?=
 =?utf-8?Q?zVtJEXFdw98pjPYHEizYt1z38qv2Hc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:48:43.3225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0306e733-2206-4542-eaf6-08dd3f9a1908
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

From: Manali Shukla <Manali.Shukla@amd.com>

The Idle HLT Intercept feature allows for the HLT instruction
execution by a vCPU to be intercepted by the hypervisor only if there
are no pending events (V_INTR and V_NMI) for the vCPU. When the vCPU
is expected to service the pending events (V_INTR and V_NMI), the Idle
HLT intercept won’t trigger. The feature allows the hypervisor to
determine if the vCPU is idle and reduces wasteful VMEXITs.

In addition to the aforementioned use case, the Idle HLT intercept
feature is also used for enlightened guests who aim to securely manage
events without the hypervisor’s awareness. If a HLT occurs while
a virtual event is pending and the hypervisor is unaware of this
pending event (as could be the case with enlightened guests), the
absence of the Idle HLT intercept feature could result in a vCPU being
suspended indefinitely.

Presence of Idle HLT intercept feature for guests is indicated via CPUID
function 0x8000000A_EDX[30].

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 645aa360628d..4fef0533f764 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -386,6 +386,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/

base-commit: eb723766b1030a23c38adf2348b7c3d1409d11f0
prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
prerequisite-patch-id: b32c21df6522a7396baa41d62bcad9479041d97a
prerequisite-patch-id: 0ff4b504e982db7c1dfa8ec6ac485c92a89f4af8
prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
-- 
2.34.1


