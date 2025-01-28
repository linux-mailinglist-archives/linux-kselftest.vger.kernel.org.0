Return-Path: <linux-kselftest+bounces-25305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D91A20AB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F6916607C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731971A2554;
	Tue, 28 Jan 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkbknGk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01219DFA7;
	Tue, 28 Jan 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068529; cv=fail; b=rfvyntyaLNX78jZmb/1tRGWD7VLRom4CVgPsy19uid4OjZ0ipjrNVfSH/TUxAz9Q3AqfqfH2oPc7kuFhRx7eyrdB3vwiuiofQ1fX8PkOMwqGIE+5/8/1v8sRqjpVxJtUdSF0IVuEIoymzvHojGSXgx9qQlFHUd3LEK8xSOgt6Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068529; c=relaxed/simple;
	bh=gdbrOASGzEgjH3zU2DWHsCB0oQ3s0Hvo3lWShpr184s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD2mfp/K3aAyH3DyV1dL8Jh9/os/9oB67voPJW3WfX7C6p9dDfp873kRHf4YS8/Mv+HpIDc2q7Tn6zn3OGdLTuJfYfKAJPIjbeb0N+3LAzRnWEFfGKxKJ/nQ/zarBFrsD/Bim9HlZTbH6RIrGqkVOgkkk2uLXxCAICfmWYRvJZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkbknGk6; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2HOWaUrg5cw02rX9Bm6rBhRZm6bG4J7ann1//89XIfkbJK26iD3Ti5DrarP+RYlFsk9TjZewPhz2xbECB783cssbaubAlXvB/ON3b5RLUrNWsA6m4QOWbDkq2rBjM3ixs7MYyOvIsZ44GzCIp9mx9bL4GKc1R4MnhGBokTgOcmu2muejkC6NkD+N2IBXf5HPkKnZu6Yr09tQ+LFHVS7UYIUYURTZu3ncQ0LiBLA7WxWWliSBv7Y8AeiWJdG6WjraIPnJUQLw9R0NxkH0yL3AQcARcvcRNOFG6JtCfFHskaj9o02XUs29MsmjdgZCGKNp+lUNWdgYVPtMkQwWjPk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpOaFw1RNV7Wa2HGXYwo2f/HUCqUtvxbTncgASLUi4s=;
 b=KI2ac77jLqMy6dl1UBCfJZcZgOMS8xHxvNty2hkfoXLe9fRGcRuFtckKrH5HDK3NRlhzzeCO69TctLCbRdWap41QederJIh38lfm6uZ3hOqdNQnnmneOUvaJWUD0OOw773Yhe0GJd/GiWSjUtaWN6mQbhG8iqTZGmLA0OQLDv7Axw8mTYomFoZ3OWV3/KrBb24GQLt34GXPjM6H2xNdspQKGtNFvB49IkAEDL19ibSb4ujlZVJUVXaVED8i/+ceudbp0ufe2jfNviUQuEFR5ic0YwWGmkSUeUwsOqfv+IV/pX/2Laf5JXFApWgOQSA2wGKX6P/e/CmmOT7zuSsJhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpOaFw1RNV7Wa2HGXYwo2f/HUCqUtvxbTncgASLUi4s=;
 b=AkbknGk6a3Cz8+hjsdvtwlgRECYrnoy5zp6FxVaj/uNzuTRD/vhcQ5VFzdDzhWWlAGLm2YvvcCCCNyongdtawFzURrMTc1TrVE6S6xOOm8wCcWg9kRsGE6gXcGtclC4OEQSgSRZpbHcue4+fh8uiwomycQz8ch8gFlNj/F6f070=
Received: from BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) by PH7PR12MB9254.namprd12.prod.outlook.com
 (2603:10b6:510:308::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 12:48:45 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2a01:111:f403:f90b::1) by BL6PEPF00013DFC.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 12:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.0 via Frontend Transport; Tue, 28 Jan 2025 12:48:44 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 06:48:43 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>,
	<neeraj.upadhyay@amd.com>
Subject: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
Date: Tue, 28 Jan 2025 12:48:11 +0000
Message-ID: <20250128124812.7324-3-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 483fd466-ae74-46e4-afa0-08dd3f9a19ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0pBMEZMVDV2Vk84d1dxYjFkdTluQ0xzTHFkOHREOHMrR3JhckQvQWJSeHBu?=
 =?utf-8?B?UnRHb2JHVzdEdUtWZEJaZ0N5VVdXNm1HZjdPTUxFYmxEZUExMklYRXVSK2xn?=
 =?utf-8?B?dVFqN3o3OHVRTnFJQURDbkx5R0NmaWRVck1ybGIyK0dQZHRsZHgyMlVXeTNs?=
 =?utf-8?B?S2JTMzhpVmdqZXh4aVQrSWgwR0RLb1JFWGpMUkpOWWJmSWtpdHh1QW1FZGlj?=
 =?utf-8?B?VjNjeFNLMzFpQlVlajh0NS9MNVdKazk3WG5tZDBLTkNod0pacWoxNXYwYUlC?=
 =?utf-8?B?SVZxOUd2QUdiRC9zYTJlQzNsNS9VVmVBVDc4TUtZVFdwMWhOQWZjVlBhaTJF?=
 =?utf-8?B?K05HejNqZkNibjArMUp3RWMzbkVZK090bmxVUWoyZmFWdjlDSGlLTXExdU8y?=
 =?utf-8?B?R1FKTzJ4N3ZhK1V3SjdjMVpUTW1TelJ3TEh0ampuUXJOM2M1aXN0Q0UzWFdO?=
 =?utf-8?B?Q0czNVBzZ0RCS3I5Smt4ZlhEcUxFWlphY0hwREwxOEs2VmhxNlFRQVlPTmN5?=
 =?utf-8?B?bWdJenNmYjFucW5sYTdmNTczcndGMUJvRG1BeUZDeVZvUGhWOEM1aVdPRExN?=
 =?utf-8?B?RHZxa3F4WmsrQlhUbXB5ZkJuQ2JObGp2TlJoOWI4dEZjc2RKYlZENDBBRGo4?=
 =?utf-8?B?WUNsdzZmM01oczlJK3prTkVCOEh4NzkyS2I2UGJUU3FiQ0hPT2c4ei8ybjE5?=
 =?utf-8?B?YmRpemFNRTBzQ3lXeFlWdXk2QVhyOVBKMSttWFExWGhBY1doZi9BOWZFVzlD?=
 =?utf-8?B?eWlQS0ZyRFNGNFY3Tjcvb2I4OGdxbktnWGdGOVNCajhvalFmMENXbHN5VDRl?=
 =?utf-8?B?VndJNU9KT242eTZnaExiUS9Sc1gxZGoycWN0ekNjQjlCMU45eENFeWdXUkJI?=
 =?utf-8?B?ejE4RXJtaFNFNzcvUVM2OFBDQXhjM1kwT0JJR2VlMWdHY1o0WWw1dHdYbEdW?=
 =?utf-8?B?Nk1ESXRjMFU2RlcyZlMyazh5QkIyVFpzWUxVNnZPa3lKVVZwNTJSY2ZPck9u?=
 =?utf-8?B?bTUxdGpHNjRDTFdZYjFZRDZNR3AycXN0cTEvN2o2L1VuWGZoeUxYY1F6Yzl0?=
 =?utf-8?B?TFVHKzRMMlZVR3Zld1pCdEVxY2IyUGdvaVZVN1lCUGMxdFdpdUtyWHk0dlAx?=
 =?utf-8?B?dENuMTFzMVJwUWVSSlZGZEJYUjN5eXhvVWtQY0sybGNsWnJYdVJrMlo5YjZr?=
 =?utf-8?B?R0VkQWIySmJyUzlIZHRZNDlmTi9XOE5DNlpYOGg4S1lseXNIK3NTQlR6YmhX?=
 =?utf-8?B?T3hVbFJKUnUrVTRRNkVYTGJBUElNK0JoTzNNZ3FvRWxONjIvL3B4OWppbGwr?=
 =?utf-8?B?QU9sN015TEMyTjVXZmlWOTFsVlRQUG85V2VuMFRHcTlQZU4xdCtWcTFvclgz?=
 =?utf-8?B?Qk1Qc2xtUVd1Z3l6T3JjdFYxWFhRTFBzZVFWRHlQTWlBZWFCcDczRXVmVTRq?=
 =?utf-8?B?eHN1OEExUCs0TDkxREZLUkJSZ05QUk9ob1REeTFwTGlWWDVjMTVGYS9ESEk4?=
 =?utf-8?B?TTVpKzd0SGFvTXhsd3A1c2l4NVc5eUFEV0NlclE5UU5VaXBJbDlEQXM4dTJ0?=
 =?utf-8?B?S244alRQdk4zSkk2ajZ3WXhoTjhvQTRyQkVpSy9FbGpuSnlwbmZFNVVUeG1F?=
 =?utf-8?B?WjNjdVRkMWJlVWIvSUhhNnpWZjlESVdhbXlxZzA4cWQvZVkzTms1TFRBVC9U?=
 =?utf-8?B?eVh4VTZFVGdpc2FGN0hJaVVpcFNrZVpXb0gzZ0FqdlIyWWNJYUlzNjc1QVYw?=
 =?utf-8?B?QTJMcVRPeVVZMDhlSGpyNkhMWnVZblpNbGdTVDlHcWVkdXlGL3lIYkl3enR1?=
 =?utf-8?B?a0t2dzNNeXdUZzhSSHg0QlA3aml3VmdhWjk1bmRtTTVWSjlzZ1hvSWtRMmVY?=
 =?utf-8?B?QjMyOWxaa25CcGJFY3gweFNkeTVyN3o4OXBZVm1pMW1kNXRFV3FjZnBkR3Jn?=
 =?utf-8?Q?zFbjIGNffvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:48:44.4180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483fd466-ae74-46e4-afa0-08dd3f9a19ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

From: Manali Shukla <Manali.Shukla@amd.com>

The hypervisor can intercept the HLT instruction by setting the
HLT-Intercept Bit in VMCB, causing a VMEXIT. This can be wasteful if
there are pending V_INTR and V_NMI events, as the hypervisor must then
initiate a VMRUN to handle them.

If the HLT-Intercept Bit is cleared and the vCPU executes HLT while
there are pending V_INTR and V_NMI events, the hypervisor won’t detect
them, potentially causing indefinite suspension of the vCPU. This poses
a problem for enlightened guests who  wish to securely handle the
events.

For Secure AVIC scenarios, if a guest does a HLT while an interrupt is
pending (in IRR), the hypervisor does not have a way to figure out
whether the guest needs to be re-entered, as it cannot read the guest
backing page.  The Idle HLT intercept feature allows the hypervisor to
intercept HLT execution only if there are no pending V_INTR and V_NMI
events.

There are two use cases for the Idle HLT intercept feature:
- Secure VMs that wish to handle pending events securely without exiting
  to the hypervisor on HLT (Secure AVIC).
- Optimization for all the VMs to avoid a wasteful VMEXIT during HLT
  when there are pending events.

On discovering the Idle HLT Intercept, the KVM hypervisor,
Sets the Idle HLT Intercept bit (bit (6), offset 0x14h) in the VMCB.
When the Idle HLT Intercept bit is set, HLT Intercept bit (bit (0),
offset 0xFh) should be cleared.

Before entering the HLT state, the HLT instruction performs checks in
following order:
- The HLT intercept check, if set, it unconditionally triggers
  SVM_EXIT_HLT (0x78).
- The Idle HLT intercept check, if set and there are no pending V_INTR
  or V_NMI events, triggers SVM_EXIT_IDLE_HLT (0xA6).

Details about the Idle HLT intercept feature can be found in AMD APM [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
     2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h      |  1 +
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 13 ++++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b9951c90..992050cb83d0 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_IDLE_HLT = 166,
 };
 
 
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 1814b413fd57..ec1321248dac 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -224,6 +225,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7640a84e554a..456d841298f7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1297,8 +1297,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_MWAIT);
 	}
 
-	if (!kvm_hlt_in_guest(vcpu->kvm))
-		svm_set_intercept(svm, INTERCEPT_HLT);
+	if (!kvm_hlt_in_guest(vcpu->kvm)) {
+		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
+			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
+		else
+			svm_set_intercept(svm, INTERCEPT_HLT);
+	}
 
 	control->iopm_base_pa = iopm_base;
 	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
@@ -3342,6 +3346,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -3504,7 +3509,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 		return interrupt_window_interception(vcpu);
 	else if (exit_code == SVM_EXIT_INTR)
 		return intr_interception(vcpu);
-	else if (exit_code == SVM_EXIT_HLT)
+	else if (exit_code == SVM_EXIT_HLT || exit_code == SVM_EXIT_IDLE_HLT)
 		return kvm_emulate_halt(vcpu);
 	else if (exit_code == SVM_EXIT_NPF)
 		return npf_interception(vcpu);
@@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
 		if (vnmi)
 			kvm_cpu_cap_set(X86_FEATURE_VNMI);
 
+		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
-- 
2.34.1


