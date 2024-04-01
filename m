Return-Path: <linux-kselftest+bounces-6947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F446893CC0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B9B1C20FAB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A447779;
	Mon,  1 Apr 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4dUqYTKW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCE45BE4;
	Mon,  1 Apr 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984855; cv=fail; b=mZPBWVxfCxB8iwYql5MS4BwR5BNC+EX6r6wdaTp+7SbyO+l7MgprP63ogtY35BZS0OEBg1JCQdfe8aLEeH7hCrqk03k/MkTcA4InMhjJ8rbLi2TC/dXIY80onBKUc0zmG+PJegvDyzFtPYOX8GsU5FjAGDlyPGejKpIZ247F5To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984855; c=relaxed/simple;
	bh=xu17PwtHCaAeEXPk26mmE9BHBfYXC324StnUQVsPSXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmAr077RZHmt1bmLS2ruN7g8fDohd3BWCmPtW0n399L8eqq7NFlANXhvOOx/DF9qVaysnucfBltTJXkbkeh3pz3wBRORV63NvjiX/OIi0uY5zwMrW323zho1ApCrjLib8j2BrKUkT96ro5S2gwejpenHzi0la9mz27sYO9yzrHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4dUqYTKW; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igYQDAFmfFaglQu6mhteTrZSgoPzPvSTjJYEr3QSjtCCPxb5NGiU0dy3nL3V1ju1pg7d4JX39tgL1pP6ARNmYBVye1Fh08ETJu+usd6BCYzIH7j1npxrE07iCvfeKtQgD9QHMb7im54766RRx8+MKWplZP2aWH4j9FNRsCWY04TaH+aIAmkoMOdxNmCy5DZZVep05iDWTFiudyIPKB4e2NDPrrNdxR9z+a+K1fSIzDJ2WkCK0Sqfuxy7TJCcI6q53Xo9fbiSXkaGepkPzzvAO9Xfem40j5/Av7R4oH7IcwywRcm26XXpE9fK0PV6vM+eFRTu6fWh2L4S9zKIPlJXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHfffV19FA6H664Y3DD1tcHq0VSXk4ai7BIK9hWM34E=;
 b=I8ZFeBH5hij3k5edE4ovEka3AC2+6XQ8mPrGShMHRmnruZdHqwACfYrFQkK7Ha2ckMVozPmZAl/V/NY/bT0lvwKLXhCivjcH/WBLpJgkL6IjNUvXd/a+1GtwqrLsXe1UDdT77k8xVQSJ376uB62o0VIIlI2QU6QWG3Tdya3l/Eh42mwI2XR0IWEIxwlIiK3aNvAS+Pbe3kztbA+PdzOOacsl3sAb6y5nVAXFxfATYxfmyZcNQBouJKIf/mSM5QkuYZJ5CS/jhX3SNOlnymwqEiYcIoGfKNirYxcihg7vw9YygBLIwntmjcdmaU2FmA9VLBdqqua842ag4Lzxxy3d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHfffV19FA6H664Y3DD1tcHq0VSXk4ai7BIK9hWM34E=;
 b=4dUqYTKWIZHepCyihHzKUGuF8pGq3GXYbIfjDxPIAoJL7yNKTfEVOjN48ecKpYVIO9RkKVtlCn5CoxIM5I1FQzv0iaN2qPYyKbG+6VdttrTVaLLV4z4/iQn7qMiyasJH5/h39kwoW8Nbadz9HBtbVlW3FQ2Aza1/07CfBmrQQrA=
Received: from SJ0PR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:334::21)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:20:47 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a1) by SJ0PR05CA0106.outlook.office365.com
 (2603:10b6:a03:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Mon, 1 Apr 2024 15:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 15:20:47 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 10:20:46 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>,
	<ajones@ventanamicro.com>
Subject: [PATCH v2 0/3] Add a test case for KVM_X86_DISABLE_EXIT
Date: Mon, 1 Apr 2024 15:20:29 +0000
Message-ID: <20240401152032.4284-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 782ed2a3-56bc-49c8-53f9-08dc525f4ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zjgL8Ycu8y3mVXFftZDEjIcpV/PxTzrsMBWRKLN/3KCjBdEgtN3xg0ANN7kdZoljKiV0y5Himx0riWMeTSfiuv0BrwJTZZdxh6zkOf5tK/JXyDFCJ7TmMuZ0ha8FQ8IOzmr7s9O6q3Ue5N00iMrI+wn/whN252DzvYWoX8igUDChWPD0PJUuu808pLNRrRdHKcbkSyuSo9KJRbZFTJyJ8ni3g+EgwIiii7SeIW5y/fSzirQD95kYuq6IVS70AqIKjlEt+8bWTzh6jOA79tQVlFqrjekQnusEr/m8oeqAjn7ubTjtCMBZFFyT7wvUFdvgmwKv2YWd2ILvN+ATgIDe75OezdUXPWTzyAvctrs0OOiKst6QpL2SmlMNOAM4lsbhkf1XPCQjuabacvpxGzNzMK0ehf+vsYERETMxUOySkhjg0Yj3o+JJ/3YEXX2MXo/3TFsHEyGhAgtIbK9iUTwUMttM+aQx10YRWlpfSVLNfvRr7MLkSvaup1SmgSGKqVLbiP/1KebemhAqlYMPY4W1wEJr1QBIezyt4xTZcI4KFgBCA1FNGD5RHZIr55CywTuxZSWl10nfr37E1HcKLyb8iuneBZ7i1gprWhAHWG5KBc8iV1t08iED4PtiMvlIqVJ8/UDXXJeywEIT3N4ygw7FDJiQA5s0w0WawMp10yq34Nys9+dI+i4ZoxnP77UiyaOYlN6cD8MgPzjcM0eSW3n8ot6WVo84YKjCdkjOB64/Ib7dOXPlottM6s/kxLxIsec2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:20:47.5418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782ed2a3-56bc-49c8-53f9-08dc525f4ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

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

v1 -> v2
- Extended @shape to allow creation of VM without in-kernel APIC support
  (Andrew Jones)
- Changed the test case based on Andrew's comments.
- Few more changes to the test case to pass the address of the flag on
  which guest waits to execute HLT.

Manali Shukla (3):
  KVM: selftests: Add safe_halt() and cli() helpers to common code
  KVM: selftests: Extend @shape to allow creation of VM without
    in-kernel APIC
  KVM: selftests: Add a test case for KVM_X86_DISABLE_EXITS_HLT

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |  17 ++-
 .../selftests/kvm/include/x86_64/processor.h  |  17 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 .../selftests/kvm/lib/x86_64/processor.c      |   4 +-
 .../kvm/x86_64/halt_disable_exit_test.c       | 120 ++++++++++++++++++
 6 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c


base-commit: e9da6f08edb0bd4c621165496778d77a222e1174
-- 
2.34.1


