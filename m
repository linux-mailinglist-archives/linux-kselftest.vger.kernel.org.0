Return-Path: <linux-kselftest+bounces-10754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B38D133F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097B31F22B11
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B61799F;
	Tue, 28 May 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H50x4/s8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CD10F7;
	Tue, 28 May 2024 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869984; cv=fail; b=Q72JRaz83EiOxIzcfdYAKvzTe0+Kzvi0aJ5knx/sZ1s+boppNj+pQBJTPX6VEh1OGL5zt1rLQv1NDJE/kOvzMwhP+u2pYXirhxQwiBQJ6Ino3hW+iUI+oY6SG50j/luaREKcZt15PwLUdj77LsFY55EKTLnMObI69HTJcGd5bT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869984; c=relaxed/simple;
	bh=fJ9QLE1egOA0uFWDlxXrwK+iNrUiljuXNAMVqp99tUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k88ggTsIOUixHKx1udZBzGMfP4q291e4FGjGeH6l6jJq5BEXF59uL+tvqQC+YUhdZR8ovHJ9G9/0sCiE2UJonjJLvoKT2VTtayt0OSHZy4nqEv7MdInxE/qjAqNXqWkbSBa+LCSQphx46KBHLdNUoi97VWISXHoXZr0NMgkia4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H50x4/s8; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbaIieAGQJsAfwjMY68/LEVNdtKn+Es1X5YBBUoGhsdLOg2UzolEmHVxbrVUUd4fwPn8lmA5/G3vGzYXXYx7sSO+2cA6nRuv7eY0mJBC+FBdm7KXNphS5C1mDjW4ZzQ1tXV04OHu7K8ZU3psVyanWK1ShsaC34FBX3M2XkH/1NX0sJTSYROk4Otl1a+Lq6OKEyLT+k5Ao9i4cKckDvMWOgV4upGzVFD0JMrKSMnKDNKR2fs0H504B+d5Kt/Ypm4IMzO4xFZDugY7P9W4PMIG2XxYRQPPkuJgFkXFVBl+oKSmvMtBGa6PfkPYJY3owqYh/Ga5g/f4AaIMOxdc1T61Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAOUci5cR0YMno+yK8NqwlECIH321vUfqPHzQvBb4H4=;
 b=AeUJxYjVdJSW3XhYwaKnYPtNjLsqNcl5HPYjwTQPLzM19S1qubBSeNOLc6imFf0Rbe5ygB6ACJHycf2p+9R18gDmW4QblCAoC35xkRbi+/UtZYv+5O8SsEVaY5uVK3DAtobWg2WET43wOpumRIMD2L1vxzTyj7P9wYsYS4EE5jufHTKsB6tFenXsf/EpMh8sYu/rYzESVfTLXy8kZi2A0vFZAJz47s6KcD0qDyogwP+PgIT/e+OWE6Z92QRjTJjoFm2uTBwWs6DBr/FPD4XSeE0kFHEqdIT4+ndn0gDYdx+nqa6pNT1UCtlkoupwOBy9bQHdpahr5+lDTQ12fML9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAOUci5cR0YMno+yK8NqwlECIH321vUfqPHzQvBb4H4=;
 b=H50x4/s8vVpqpJuXoFnNskRJgaI7K/5KmmcdNcfH8yO8Px00fhyRtHHtK8fxUh1d4SLjRB7Eh1HhwrEuyigwxKHcpdKqfVbQWBQ0N9OPAR0Jy6ERkqwtNTSH2tj1ZyQQjDzLVyROjhmR/5WYYwQuxrgho7odKgu/CLs2hyepKco=
Received: from BN9PR03CA0859.namprd03.prod.outlook.com (2603:10b6:408:13d::24)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 04:19:40 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::23) by BN9PR03CA0859.outlook.office365.com
 (2603:10b6:408:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Tue, 28 May 2024 04:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:38 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:37 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
Date: Tue, 28 May 2024 04:19:21 +0000
Message-ID: <20240528041926.3989-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6d97c0-828c-41d9-b914-08dc7ecd63f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUdTTnN1Nm1YNTg3V3NNWTlHZ1VuSjZHc0NhMTZxRUlEZXlWd0ZWQnlYRmQ5?=
 =?utf-8?B?TllvaWRQazdHNUUyWnlaZHFDcllPOExhbHhuV0FjTVBoSzM3ampyR3h0aDU0?=
 =?utf-8?B?bTExcEQ1SUt0OUR5cVBLRGRjckdBYkJjL1pKVmRSaDdCaDV1a0ZZZGxyQitk?=
 =?utf-8?B?ZjR3cDV5YUE1MjM4QTBoaW1uMlNaSWx6Q2RXYVZIcWhOQlI1Kyt5OUNJaEJR?=
 =?utf-8?B?dHVnMnNPQ21PdlRIaytya1NWTGJFV3hhWFdPaWtwRTFaUGxhdTlONjZqeFg1?=
 =?utf-8?B?MEdCKzJxK1U0cU5IU0hKSGRaT1JnL3pzcTRvQUI4dGNPZXNwZHhrWUhmQmtM?=
 =?utf-8?B?cjI0VEJIUzE2NG80RzZyOWtUTHNFUjlodXlLNzBVditWWm9XYnJzWGtPeFhW?=
 =?utf-8?B?YnV6Z3k3allrR2xCaHRjeUlWc0Nrdytjb2p0MnJ1RUV5eklWVjlOd25kZWFy?=
 =?utf-8?B?WWtRdWRQUUlxZDFPa2N6dzJwZmpKUXBnQUZCV2FRWmZyQnVIbEQ1azlzTVVJ?=
 =?utf-8?B?d1J0eXBBL0pVZ0dnNloxSW04R1VxU1E5bHJIWWx0VEpDZzVuWnJhQVpKYlgr?=
 =?utf-8?B?ZmV3bmZHcE9kN090cEtiZFBlS1ZHeFRtWmdWR3hKa0xlNWJuSEhJVmprdnZQ?=
 =?utf-8?B?ckQ3YTJEZUJaLzY1M0o2L25tUlBJL1AwT0VEVDdnWE83SzZsYnVnQUp2ZDVo?=
 =?utf-8?B?QWR3S1FncDE0dG9UMUwrbGtKOG0zelBBbUVBQSt4cDJHcXRMTVdVWmdaMk90?=
 =?utf-8?B?UTBMRjNzTHluVFNlZEpQVjJOYTNGSDg0UTJmcUdmRmNwTVpoZUZmNklHRzRn?=
 =?utf-8?B?UG16a1JzN1FXbXJrS3QzQnlsRk9hOS9DTmllWit5bCs0Z0xMM1Brb1Ric2I4?=
 =?utf-8?B?WHpmeVpySGVBdWFyVFFvb0tIRVlkVTUrUjdNQTVlbk5hYVBxYTQ4Y3dXNmlT?=
 =?utf-8?B?dXJ0dnBXUWZpY0J5UDNPYnF1TGNDV0R2eGNSQVAwZWtvTFExbnIxNDVSaG90?=
 =?utf-8?B?ekdNbjhuMFpoc2VDdFlYdzd2OGxkdG45WjlMTzFuRE43clAvTThnVHBMNEdl?=
 =?utf-8?B?VzBuQzB4cUJsYUtwaTdDNDE4MFA4L0hyeDgyeTIzbjJRSG5iNThYSXZiVjlr?=
 =?utf-8?B?YndMbW9HQW55MjN1Q1RNVmd4Z3M4U2luNUxIcVBiZVFaaHZYR1NVQitxUkhV?=
 =?utf-8?B?eVBBeW9sWk4weDRXajdZNlhhaFRMZUh3SmFtRFFBL2M3NWx3WDR6WFpwNERU?=
 =?utf-8?B?K0wwVnM5K1orNC9lTFRTNmNLTTNTVnljTmRvQVZoT0NsWnlkY3BHOVhBeWxr?=
 =?utf-8?B?c1BOVE0vd0NXaFlLWXNySlRCNnIzL01pTlJoY2dQdm5CZXd5c0x2RmRrV1J2?=
 =?utf-8?B?akZaWEJxKy8yMVNSL1lhR2k0dHI5RjhuUE5ta1JXOVdJRUVUZlVSV2dMZTV2?=
 =?utf-8?B?cVVWc0doWTVvZkQxSkl4ZU5UR0RHUzVGN2VpN1FYV0xVeGlHbStaaDdqeDlU?=
 =?utf-8?B?NUo4QnRlTFA5TDJZbFZZNjdScm91RklKWmlnUzZGK1N3aU4yQnMvdmxHaGp3?=
 =?utf-8?B?WEFUQTVzd2h5V1pDWThQYU5CdHduNUN3OExTTVRQZUlUZEFiR1plREphQzhU?=
 =?utf-8?B?YWhmOU50S1ZpZVB2Z1BBaTROck9kUkpyMkZLZnNTeVF2aTBNZEE3SnY4VUFP?=
 =?utf-8?B?SWFjdzVqRE5OWDhFdnNucVhhL0x3aUlNeFk1NlMveDFnbUZidE85eDlMamc4?=
 =?utf-8?Q?du+zkbgK3DaLAQIAZ5b7GNT8ktRnK6Gn4i9J3bo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:38.9939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6d97c0-828c-41d9-b914-08dc7ecd63f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature is available at [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Testing Done:
- Added a selftest to test the Idle HLT intercept functionality.
- Compile and functionality testing for the Idle HLT intercept selftest
  are only done for x86_64.
- Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.

v2 -> v3
- Incorporated Andrew's suggestion to structure vcpu_stat_types in
  a way that each architecture can share the generic types and also
  provide its own.

v1 -> v2
- Done changes in svm_idle_hlt_test based on the review comments from Sean.
- Added an enum based approach to get binary stats in vcpu_get_stat() which
  doesn't use string to get stat data based on the comments from Sean.
- Added self_halt() and cli() helpers based on the comments from Sean.

Manali Shukla (5):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  KVM: selftests: Add safe_halt() and cli() helpers to common code
  KVM: selftests: Add an interface to read the data of named vcpu stat
  KVM: selftests: KVM: SVM: Add Idle HLT intercept test

 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    |  1 +
 arch/x86/include/uapi/asm/svm.h               |  2 +
 arch/x86/kvm/svm/svm.c                        | 11 ++-
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../testing/selftests/kvm/include/kvm_util.h  | 44 +++++++++
 .../kvm/include/x86_64/kvm_util_arch.h        | 40 +++++++++
 .../selftests/kvm/include/x86_64/processor.h  | 18 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++
 .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
 10 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c


base-commit: d91a9cc16417b8247213a0144a1f0fd61dc855dd
-- 
2.34.1


