Return-Path: <linux-kselftest+bounces-6034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337B8747AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E76285DCF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87441BC4E;
	Thu,  7 Mar 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x5NqXegt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033021B964;
	Thu,  7 Mar 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790409; cv=fail; b=YON7tnqonvvGEf+J4AGaORJspFdJXQBH6xIIV4NLDAIWoRROO2g1wX75Q80Mm+8eZIaZyDFBE90RVSQbtXNADqcML2LO5zsbfdbnx3J/fGHZl3LVPPl6XgHs/KxJgDnaACLPzJXyzjrvhwjCcXXBPj3E1RIbT9OaDRP1xwr6nhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790409; c=relaxed/simple;
	bh=mpMKydG4E3Nef+mM2bS7iSIlCZEycFsAf3S870ttOB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1ZMtiBIEiMC1JAshpww8OEgtJKfMUHhxHBwu6O9jRRzKzSP3vokGdAmOq4VOxoK1ySypNQYehe4Bw5PQ2QaGhjAHnPgXgqhYY1FffBwquAVrNA7UcI2CxGShhWq4QnlqBk85bTNgrddXvYUB1Ybsgpei8uhOk+1bPfJcCpvTK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x5NqXegt; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdTuUvVxiXh5EJu/cBxyuEgQkQXfQQEL3hZFUqur7P/JQXXl7oRz/j9abYMquDmvJBbY/DxZAs5PbU00nVylxHvSw4jE92M8E2TgyCAzqu2+oDciUE0rVNS78Gwb417HiZeCTi7HRFan5psUJ8UZ/akRclWAwMSPld+eF3MAcUsuZHeeieb6hHV85EuhsFLKbeXlM93O7j+qtWGnAwLIBbQ6cSZ5C7aMqeauiWE6RnOVGExyzmGur9AaQwIl4pE9J6eKQjhxw/CaPWvucE8FuZrFaCwDQFOcDe02TRfCD7o8sPcK1/NOkEawKtY51hOVAbgpnTKFW+ftxLqEIfAtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs/jMW0xWp4Gx8yTPxkF4XY2UBjwShaohPC2zMCXZhw=;
 b=X4bifw9QLA8rar1LW28+4rH4rx59YmDEGNKUZ8YdH+DuGf8yW4RpY76hLAKb8Wp0nvCFs0B4u6SVSWVRUnxeOmDw/KI97r4vyvvoiBEXRUB1ctdVOCceIo4kHWih4HdokybzKfkQgrtyYTPBosPxLRgkEP6AFSF1NGDq2cyCL2H6/IrSlm0bVYui1plgC6T8m0QByLWcUq3SEMyZiyRbdZ4zogpFH3IifZECbjhu3biwaNFNM6sY3YREWx14bFJbrmDWKrZR8XCoWxv+mjOe+AdKY/lwzsglTN7rrcTclwDfhafRXhQxFa+jGip56Fg3JiPgsD83dCoOJwM0m7ZBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs/jMW0xWp4Gx8yTPxkF4XY2UBjwShaohPC2zMCXZhw=;
 b=x5NqXegt7JJ7DPvytnRCQ0yAzHFiqagNM9uEL8vOpJt1/Dn7t/OEw1iy4SyYezgwC8JH3DFUQNlj7OmKLtqQTn7bd+cDevaiQkgGShSf/HuAY6gTniaJGr1TVWX/73Ti6N8TH6E6IU2QW77e0mN660lXdmQM/ttm5nNTAky8o3k=
Received: from BL1P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::11)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 05:46:45 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::77) by BL1P221CA0013.outlook.office365.com
 (2603:10b6:208:2c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:44 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:43 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 0/5] Add support for the Idle HLT intercept feature
Date: Thu, 7 Mar 2024 05:46:18 +0000
Message-ID: <20240307054623.13632-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 79290da1-c41e-47a6-1e13-08dc3e69f8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XpBRdG7V73yURmCVrw07knC28pZHSNr7AQ0867ZIB9A24B7RaBl+sBX9Rb4vhjBNfwlExmyBOcyBCVkGa/DtT4iuN2Ncx5BEtYGW46xBAoHfK26cAX+Q5PStHgnNtI5l/qO04Tutc60f22CZwKOOjJFJhvjv2fW8qEQK/Icd12MIUH3kzxDZ9m8lcgQp3RF7w8giuwwjRfUsoiraByYT3mL2hWOi9okml/DJKfmPNBfEWhgCN8G1SC3AW35UP+x/sC/DrsEI98paw8MKwQnDqP639+RX2bTDSd0Tmh+WgUM/DWaPvdWbcwAtzdZgflOnvd4Fqp+gneorPC77nbedNWPL51BwYJf0BpkCuOGg0FEpXzYaZUYnjnJZK52ruH6CnMtNSniK6SmN9GLMpCsny0iOO1wpruvR+fBbj23ZOnQtlRQGBZhPFi2ayxj+1XLw1xsOTcCeyTJYpI2Ccrqwd2B9CbWKuTh1iPSc4QLgiPw+LQSOgboB7XOb57LFzDabTIY1SD+NZ3kFn0YW96lAJKAZV5kuje0+5CMJfk2eV4HZBH1Mj+sVdUQgSgQyzwhaL+pNeh82ZrdVQRLJ4K4vD/SmopwiwABeQkPasuaQbQLcq0z1ohNxiZwRJ5RKNKVldH346ZzyqyU+eI14HjblrejBvGKgIf7LFc+IQtmB9QDLLHIQUu79gqwfMXNvvkArFnvQQOnAAVhuX1JavTI3zwvza2ttENSJFDNrrGcKA9MoKvQ1uaZM/4oEn0sM7Thi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:44.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79290da1-c41e-47a6-1e13-08dc3e69f8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature will be available in the
next version of "AMD64 Architecture Programmer’s Manual".

Testing Done: 
Added a selftest to test the Idle HLT intercept functionality.
Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.

Manali Shukla (5):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  tools: Add KVM exit reason for the Idle HLT
  selftests: Add an interface to read the data of named vcpu stat
  selftests: KVM: SVM: Add Idle HLT intercept test

 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/svm.h                    |   1 +
 arch/x86/include/uapi/asm/svm.h               |   2 +
 arch/x86/kvm/svm/svm.c                        |  11 +-
 tools/arch/x86/include/uapi/asm/svm.h         |   2 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |  11 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  41 ++++++
 .../selftests/kvm/x86_64/svm_idlehlt_test.c   | 119 ++++++++++++++++++
 9 files changed, 186 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c


base-commit: fdd58834d132046149699b88a27a0db26829f4fb
-- 
2.34.1


