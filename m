Return-Path: <linux-kselftest+bounces-6694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E788D5FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 06:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17401C243B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 05:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66017571;
	Wed, 27 Mar 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0RmUpBR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521251170F;
	Wed, 27 Mar 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518195; cv=fail; b=PQ0hMKNHEcnkC7xYCjXk3OSBBO6fZiHcu6lgmJ96+g0pfHXfHE0Gw3xKANSgLx7f4SarCKD/8lypqH2y9wZurJ4kFeYI8eYowN8IvsPMVV5m44eWhkxHZB3BUDuP34u16su4YDg1Gtt5zXZsixiIPQZXRTCGPfWl39v6idy6YTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518195; c=relaxed/simple;
	bh=NG9hMChcaCi+j6JGdaNZjk9tvIzR7RSDJ2hDKYwkoUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDCaS1QHSxteVWCHYUiuXbJqhLlU17oPGl2QBnWi3FHZ9L6S7TUBImosML2w8bf3V/SPjaC9Er/VHcW1A2EVHEsCgFwP22njqkFwY3b8MPUZQL1jGZaIBa6Nv8z2IXGl8tcSjzC6rzZ7Xec1WFJNC0ko9UWKGpT9rmptmYSwt0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0RmUpBR; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMxiYlLIT9lQYQJnBnvRVtpuuka5TiisVT/IUC1kI3ZgbH3pKZrasAql2qO81d9naFW2EGQ6Iz0CZAWF779czM8p5ZN5IsYyiOw6p2/ltH7obVTyn3N0BAmwMjXq4V6uTSD+QXg1o3606V/PNtXQoH1xWBenapnG6cerSpvt/89AkLDrKDALQCR+LGktLTMypOXPJYEB23O+HssppV7GhOI0P21HGxndHC32X0HcTG8FYjaR9Eu8rxk/Y2iaYPzip4cFLe90X4wfQusw1ZbzcBP3LUjLWBW/Wt5uvsqANvumMhl80TmIzGVmMquVvKeLI4qvSLR1YO1/FlQBP9ecXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CprrxlFKK3LRhWtZVs5VPT03qjw8ehkvVoW0C8gwK4=;
 b=HQUsrTnuc/UY8OYpNwl1+5oBXjqhsL+FVxKmBUDpEzWxPy4HnWEXcpUrcVExZj3NfpBj0e+6Evy8BTFPY3X9vZXbwOmdw9VzNLCRG1vkeqbiQtBPoxdgFUD7bleYgFjx1wCxhjMI4+rBVzx0VENEA+lKNoc8WDcP0kdIqaz99rxDe4rTgVUW3pIhtjY9E0De3aeJIQcanoSXswN1eozgYrVJCLHZ3VGMXMbTKtZocTT0mUvUsNtT6lQrTkXkJYB/SukyEen8ewKWuvSkb0ZB36e9OQnwZHvnDaCibVx6/Hcb3FV6q7dhmKupeqkBRiZnEL9AeE0NQd2JBqMzlIlh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CprrxlFKK3LRhWtZVs5VPT03qjw8ehkvVoW0C8gwK4=;
 b=X0RmUpBRq6A0rPVhO8zUoAXd4bU/gggm4Cikw1eMs5d8cPzN7jF1Ej5Oxrq1IpwraL9DJtzIynPa67a8vMBPNOeP6c3fnzIhStZ1hJWUbL5o3uV+05ib+J4suWx80DB8KUNqYOQp/j9iuW/v7BXIXQKRFADswi8zNxCsNt/JtVQ=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 05:43:11 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::61) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 05:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 05:43:10 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 00:43:09 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 0/3] Add a test case for KVM_X86_DISABLE_EXIT
Date: Wed, 27 Mar 2024 05:42:52 +0000
Message-ID: <20240327054255.24626-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c3fd63-e98f-4ef3-9c34-08dc4e20c999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oOMSimNS9azvlS9wtPL0mTHReGdrGbfWfXuAVrSdYwOWWu2PHryvqbJKMDX8+yDGzdbd6iuuJN0Y7vE/bGcqqKN1hZVXqIy/v8JRwLL9ateSAlROVByOFjl6OhqZXGc8NuyryS4/xSkAs0RTTlKKVPzR2bFc7A242wiOWAWmas72roI/VtfCco6rMQLpDE02xPnnYbUdQsxatqSVqPwle+8aFFVV/nw8cqfVGHS6B2tQWse8p/DuFwRd5p7A32VKPjy77SBPQGc8HuMa2NKc7wQBxpB7aaz3EmrDK6wgqes3tWRDqvbaT/TC8WAfqAdBQN3uxyhLWJlRWNab9tC6JkITUTiGS0FUyQeVkT1RqpvKBXQnJ7nyAIG7qPhZ0QAN3Rcxtf/z8jjpg2l/tf8M8oiy+lRMhLmpdymYdHziu6LOCw6buDHNaBn/FjYRWSH+z0pgybI6oOY5arLuzvvDFu0XFUF3UcjeUevNflpK+nP0XICQeSLATnZAhchcrQQP8iDpp+26CvCz4jhoc7shejiTS8UyqD9lGW+OOcvELoIw2CHD3y47QqLGX2njnpXayLSIb4iQxw6bPiJMDdSn+maB9uQ6jiFCDVr4TRsWJWuIld+dbShwowXOvtebw5otaPb2T4+DEDFEG1evrd7l3RbfC1dbHB3pr4d0wcn9IALeLLx7Ws4rImSzl5uv9XBseHocWZ2mvAxyfdUmT+3T69qo/UWYlqnctRROLHP4rEC/lEfHlVGFb6tWRc/P7tpP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:43:10.7350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c3fd63-e98f-4ef3-9c34-08dc4e20c999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

By default, HLT instruction executed by guest is intercepted by hypervisor.
However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
HLT by setting KVM_X86_DISABLE_EXITS_HLT.

By default, vms are created with in-kernel APIC support in KVM selftests.
VM needs to be created without in-kernel APIC support for this test, so
that HLT will exit to userspace. To do so, __vm_create() is modified to not
call KVM_CREATE_IRQCHIP ioctl while creating vm.

Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.

Patch 1, 2 -> Preparatory patches to add the KVM_X86_DISABLE_EXITS_HLT test
              case 
Patch 3 -> Adds a test case for KVM_X86_DISABLE_EXITS_HLT

Testing done:
Tested KVM_X86_DISABLE_EXITS_HLT test case on AMD and Intel machines.

Manali Shukla (3):
  KVM: selftests: Add safe_halt() and cli() helpers to common code
  KVM: selftests: Change __vm_create() to create a vm without in-kernel
    APIC
  KVM: selftests: Add a test case for KVM_X86_DISABLE_EXITS_HLT

 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../selftests/kvm/include/kvm_util_base.h     |   4 +-
 .../selftests/kvm/include/x86_64/processor.h  |  17 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +-
 .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
 .../kvm/x86_64/ucna_injection_test.c          |   2 +-
 7 files changed, 143 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c


base-commit: e9da6f08edb0bd4c621165496778d77a222e1174
-- 
2.34.1


