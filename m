Return-Path: <linux-kselftest+bounces-6946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C99893CC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79125B2226A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7024776F;
	Mon,  1 Apr 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZUXEsvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC445974;
	Mon,  1 Apr 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984855; cv=fail; b=SeJSCXm3XtPyfWGmH8tV9v4iW6xozKcmrArMbliTmEWAG0MQGPVf+drJXzpxgC+RXWREtuMg2myD57BqYrn9JTSCfaZJ6Lr3aJvog6KPPSh0CIJ1pgCWTM2Ssc26+NlyQE0oCgdB0GuVXM5Aj1DeDU6sbaUeIAq1fmjSpfoGYVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984855; c=relaxed/simple;
	bh=cIXPCP9VIzqggJSbJ2xL1nWa0+tx2BxN39ziiPIF2fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4dqBXrFvNbxWmkjtwise9rGPeDXX1eS72nFolNtY2DBKNPhyNig2rWXbGp/alRRzLYxTk1nblCZ1sXmnO26711kCbLbJv/0kbJkpsl4OJivsrfKm7uXDJIBgqY81D1LRYqWugXvvxY5Q7zpNU/h7RCP8FXHTPeZggWRGM3vJOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZUXEsvZ; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXYlG9AR/cstapQtIw2//qPo7gd8iseGMyJjZt5vhH9MntDMjmxx1uEjvc8t07SvyAvdsb5FCwkuNZK+B7LYe0F9ea3bIM/HdTpf5ZJt2WO9GeFW2qYneN9v4fAuAUmxc1Q4TYa3FZKNUEc9e6iHbuYqEnZKuZBBnB54EYzjzpfe5HaZlJVyz4OBAMD/YuAHUvU/A3nWKzZ8b2jn0MeV2CnWvMTW9xSwDnMpaToRvSlEqS/S+aNSZHcCri5aSioQmf1mX1qjalY+8C5uME3DDpSzI0IH2Ar81Dl9wx3CmN1GJ4I2TLFZ03s7Yev+/USSYiZZcTZNMsoHXinIsguGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX+rKTonKC/Xzvc3qReLHgMb8uENoiOV1/dTUvezd8o=;
 b=RCZjZKyw8h1xVEvEw6924NKpqeUor6wE4eyQMJAoGYuk4ZHpucFF3YWdxpcOVd/ZYUgvrhjLWif/mENZxLe7w2OwFy1GgWd8k/uLFS3Z2rOjEULqrINZY4NIzGLVG1fm8UmEd4PopsSFILYr/4PbJg38RBSMSYv6ApITzvenqu9ghGnvJtyoe6ELUfyajICHGLjw78JzLWNg0+BKXYEO4A3YekgmOx3qrqUaCmIQGflCuWI3l/erUEiT/Q4RteK9jirogab8Lf+uvKRAcpLTXwEmJm/8WumRfhdU15HFotdxdSgrmgBGYxsDI68u4hpGABKXaT4UvLau5OMPAnCvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX+rKTonKC/Xzvc3qReLHgMb8uENoiOV1/dTUvezd8o=;
 b=wZUXEsvZczTif/XIcJcLG2MbXLEN218z9K2VCPwH2TgpFzsnLUzTK3fPG50yoSid/Lv8g33xpDFd/WBzqeLoqZdoGXts28NrWbUhJTFHdswCOdtICh2V+wmzZyLtGmA83Xz8Nlj27h+xgQJSYt/HmZYDOOFOF1vgaZbr8dYDzaY=
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:20:51 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c7) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Mon, 1 Apr 2024 15:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 15:20:50 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 10:20:47 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>,
	<ajones@ventanamicro.com>
Subject: [PATCH v2 2/3] KVM: selftests: Extend @shape to allow creation of VM without in-kernel APIC
Date: Mon, 1 Apr 2024 15:20:31 +0000
Message-ID: <20240401152032.4284-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401152032.4284-1-manali.shukla@amd.com>
References: <20240401152032.4284-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c8a016-6d2a-4737-b2e2-08dc525f50cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQqAt0Bb9V6w5yLUBb0CZtwGAZv8C80Um9fswU69B1UWTuWx71G2Md2wkc2GjqQh4LZwBtatK5w3Smn4oQG++tdbtvIUkrv+FXApIDtcDXZ1XtxtjDtmjPRiMigSU1PA2rDbMcE/1mZjcVdjoZKRm4T3MA/L0VlEv9mW0BGkexzp5wFZze6UE8mYIFKEiAaVS/mrtuRxyT0qmOUG96ngBDGd/bSFyLA3y2hGFCz4/F9cv1H1x9KcN5pigk7/ENzt6AYZoOLb/hWrjTmxXma0f4EeSeAFgvOk4GQ0NsNOHAuyDFmAHKAnnX5ZPR5pPwxjCsaTho6/SVFTPdp9BHg2QhrrYAg0sAUI0Wv0RpkKM9wtb4QCxFESBgMEiYIPe/7VGSkIijLwj1b0DSg5COCrBJuJs97+2fsFEBStH/eLtury5/vfwQ5r4WljElzE8p/f56vNowVLP6PoVK/LXINe0ySkfVD4hJA/GkTLFZONq2KzO5wH//nnw7TMb2/TvJwtzgho9lDMDIRAzMgQiZYIcJ20KXzVeVmU9prjonJuI3WlR+yXP/hUR6EEYI0/DrBvyxXzyrjg/K6viZMQYZKSzxSFS2loLHymNvCXEfnZDk3J7OaYCGz5DqSydDCzju04MBwr7rpRPx134DK1rkjBLJ2VLVxnZ7IjO8SnxKdPE05RA1wi433vltPeRf5OAYk0Z78nVf4nIajY7udJAfSB8vUWo/1NiFtvslCweim59e86Sdbp7VPkQy0DS/6f1wgn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:20:50.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c8a016-6d2a-4737-b2e2-08dc525f50cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

Currently, all the VMs are created with in-kernel APIC support in KVM
selftests because KVM_CREATE_IRQCHIP ioctl is called by default from
kvm_arch_vm_post_create().

Carve out space in the @shape passed to the various VM creation helpers to
allow using the shape to control creation of a VM without in-kernel APIC
support or with in-kernel APIC support.

This is a preparatory patch to create a vm without in-kernel APIC support for
the KVM_X86_DISABLE_EXITS_HLT test.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/include/kvm_util_base.h       | 17 ++++++++++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c      |  1 +
 .../selftests/kvm/lib/x86_64/processor.c        |  4 +++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4a40b332115d..c94cfbdf0150 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -130,6 +130,7 @@ struct kvm_vm {
 	 * memslot.
 	 */
 	uint32_t memslots[NR_MEM_REGIONS];
+	uint8_t flags;
 };
 
 struct vcpu_reg_sublist {
@@ -197,11 +198,14 @@ enum vm_guest_mode {
 	NUM_VM_MODES,
 };
 
+#define NO_IRQCHIP  0x01
+
 struct vm_shape {
 	uint32_t type;
 	uint8_t  mode;
 	uint8_t  subtype;
-	uint16_t padding;
+	uint8_t  flags;
+	uint8_t padding;
 };
 
 kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
@@ -218,6 +222,17 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
 	shape;					\
 })
 
+#define VM_SHAPE_FLAGS(__FLAGS)			\
+({						\
+	struct vm_shape shape = {		\
+		.mode = VM_MODE_DEFAULT,	\
+		.type = VM_TYPE_DEFAULT,	\
+		.flags = __FLAGS		\
+	};					\
+						\
+	shape;					\
+})
+
 #if defined(__aarch64__)
 
 extern enum vm_guest_mode vm_mode_default;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index adc51b0712ca..86546f603959 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -226,6 +226,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	vm->mode = shape.mode;
 	vm->type = shape.type;
 	vm->subtype = shape.subtype;
+	vm->flags = shape.flags;
 
 	vm->pa_bits = vm_guest_mode_params[vm->mode].pa_bits;
 	vm->va_bits = vm_guest_mode_params[vm->mode].va_bits;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 49288fe10cd3..e5ca92feae67 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -574,7 +574,9 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 
 void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
-	vm_create_irqchip(vm);
+	if (!(vm->flags & NO_IRQCHIP))
+		vm_create_irqchip(vm);
+
 	sync_global_to_guest(vm, host_cpu_is_intel);
 	sync_global_to_guest(vm, host_cpu_is_amd);
 
-- 
2.34.1


