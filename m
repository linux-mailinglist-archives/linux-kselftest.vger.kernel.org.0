Return-Path: <linux-kselftest+bounces-27845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B0A49576
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7F16398B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198B257441;
	Fri, 28 Feb 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dEMWkaJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E312566F4;
	Fri, 28 Feb 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735483; cv=fail; b=gszxEbXFwC79uKGpzNfOug84o+VcnIyWEPZdTh3Xyh3pg6T80PQAREbGONhOFmQDiJrbdLU4EZFsnHB5Pq59QowTmMmYbDvOJ4Tjhs7WGY0hTf8w7T5YlurEtgsotMATdudn52iqN4eGDSjbl+TFbQslUUtWlCgWTw1wSFHQ2mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735483; c=relaxed/simple;
	bh=iuXwMtuK8Qp+kBRhW2KBYwirb7fZ9EHNNjvq766Pi2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGc/u0nmw6BpX3KpjjUqHfNOzXemxFLBI6/emUvbzPgi4Vgn2T3nijggcuirI4fw2LxRIFmi2NxZUZGk2tdi5vnE05xj84RYUk2jrWpLvbT07PJ4jGz2ejf5ybb2OfmIXCMq0YErGqebcVWxwjCrWMb3uk4s8LM2mXZivPAHHmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dEMWkaJm; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNZoQqrRgIpHGdrdCIViPAwb4ZpLVHo3aVDSN9s3H2s2OywMYi/FYuIxVO7WOmdwm7Gk5TgLctakJv5Esv559pxKx+zh8slze4N5iQ0Ngri0DN5yO40PH6PaohF6I6DaX12h8tVisDXUpnUTJCRyvEBWiVVkaGArvN3D40zbDF/yUi4Do/FpQK3JJjxPaUIol1zLvFg9SQmxp/Uri9slRxCcF3d1QxTAGMJcLuTKC59oyFyp5Hs74RWsX7g1M9GiSX/jCdm0QSRtCWrXqysnG7mQd/MueQPuEOS9w+IttzjVgBXFoeXIRmdItHghAjkvBlr3jO4kX5NoHAeo5I4gZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfBY7B+XcSZMT1vqNjMwnDAibLm7YDtm6TmfpUeX70o=;
 b=Xex7Mx7rvGO8En3SOVpOEuSX9heXxzfVEvjeWCtY8jqQCqMJIVxUBS+mnEjjHZOq9vWP47iW6vKdYGZXTHblvfOChhHspiC2h2MeVG9CczpqhZGG9lxw8tMCLWqW4n75Y7v6YEqIQX6FkPW3FjXCP0F1gIIZ3v4i8sIiLV9Nb0d1XBfV/ss5tUcwh6OaPSjwOdjfE/l2WpySqsDwy9ckiP+e1qnrgoW52t3TOepFxBVUNulDGuoDFLhwTHy/LlMISC56IOiABzM50j508Khs/08ITS8azP4H/EJBHPr+3g4LeEHOC8cpElLc3FBWxKyfMIVRZNnCIUPXItWh8ejkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfBY7B+XcSZMT1vqNjMwnDAibLm7YDtm6TmfpUeX70o=;
 b=dEMWkaJmkHdVKQ2DqdJ1XJXq8gPU8gEgmFf3ZXZ5FJbIBX5oPHLLdt/cBED1P66TW0vi7IX5JtZndH34LnOTfoqtU/RDOlGnR3T9hQO0MPyabtpR67ok8wj6V/liuiOsJMN57qHFmn/ud4TLOJeQq1UL5L4qfi0cw857DrOsx5g=
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:37:58 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::57) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:37:58 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:56 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 03/31] Add vm_vaddr_alloc_pages_shared()
Date: Fri, 28 Feb 2025 14:59:56 +0530
Message-ID: <20250228093024.114983-4-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d937d01-71cd-4754-6d84-08dd57db961b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v29dP+ojUtUMzJOMWcrfUOn08SAoekWG6hsj4zhcpLc9zjrJ8w9E+eXSFlzD?=
 =?us-ascii?Q?re3SGkmaIimQJlDicMAfYNVl0jLfLTW3ZwE3LUa/obHsnfxkJFlm3fu4vZpD?=
 =?us-ascii?Q?zki1/vpb6U08zY8sTrakSCQ/IGKbtMYJ5xXz/h20ssq6VOwRvWGcvBw6GOif?=
 =?us-ascii?Q?2lyYuf/Wdg8O8veNFdOg6gXA6BjX5oi7GRKBskojV4VPyGCS6mz6hQ7b0W3s?=
 =?us-ascii?Q?eUEkzXJJ3nRwvxCgxfvkBPADZyUmAg06j08iGLQPKeTSzx3xIxbgHR3RHF66?=
 =?us-ascii?Q?iznS+137LURvK8EMIlDo50N8Vkzy+xTiqrUidi95iT3Qmdt8/9ecUSpYimNM?=
 =?us-ascii?Q?FtXrzdTUvBhXKuEJca9i49fmZFCmZfMlHrC0Q6Lck7FX/nerXevr0a8ksmi5?=
 =?us-ascii?Q?fySTFfhyAAk6rzqAzyDgCy+AkYc4GySY6PNt02LU1hyVPC5QtTEsDGkFUxQy?=
 =?us-ascii?Q?vKfgHBCZd4Hk/yXSOiai36FPflzmpvJ2IlLlLZPEEwOTQzu6x0BU4KNeAJeL?=
 =?us-ascii?Q?K+SETQMkTY9yUtKskAm+rACYDr+MyukF1ssbpa1DAD29MBMk62kspXDmVSCh?=
 =?us-ascii?Q?dFE1LUerNYl8PBgfOW2waDeW1GC3mQOPGOK974O9EdwAdsiN9HL1DH2NW8R6?=
 =?us-ascii?Q?V/9i1KsZUu1VfN3XMbc9r5IZZxEVbFOaHBjxc5l8GfRXSkCtOcWsGRUNWJ2Y?=
 =?us-ascii?Q?JV3LNLYyBJ50wu7MCCJujfex2RFy+XcbU6G8hqo+d4PDx6hwBDUDcJCC0bwq?=
 =?us-ascii?Q?hXhGN/Bh4qP/t6LiRvSvvcBYws94/o8o89zhf+EeDFzwlcMjOA5wQVc0fZsT?=
 =?us-ascii?Q?dvV/Y+KD0mhqqE0uwLMhBW/otcI8yT91HWMRcKaAjinTZ9L+Cn/ejfbSd3Wb?=
 =?us-ascii?Q?9hVKt9hTajcSZv3oXqnKDqRnHGJEmjkR3exRCFkoJ5APHft+ac5Eu2/Elmoj?=
 =?us-ascii?Q?60xOn19lUPhpmCDLbB6gHwx1hRlDVeaT33r8EcQmbYSLjqcqa8fCeCI8T3Zn?=
 =?us-ascii?Q?7Fs4aV92bdQz/DBqOjWjlIggbgSMtbRAH8utEGDmj8xIOtbXep3fQAXsIAFF?=
 =?us-ascii?Q?3ytf+t9uaTdjoDn+y2M38U194mwnLQS1Arbfg8W81TC+mWqXXmT4+tbDy2cm?=
 =?us-ascii?Q?xH7k/8s35OTEMtMDl3fWtwH2R9YwtyFRjaGddU8Ilu7vCx4pQVB9Y9k1eNUX?=
 =?us-ascii?Q?UZkEI63zOPMxYDbkP/NPCeCJWBVDc5zUeiViOs/O3DVWcZ5hTMxEoGT/p2o1?=
 =?us-ascii?Q?l29e9M+j2kzrX1N0i1ivQCTu7tz7Oltxx5gVbq/hAS/aoH3obZ1Fs9GNeKMI?=
 =?us-ascii?Q?4t4K5gwBMPP4g9HAVnyyC9MBeHe4ocMhksWdE2ANUC0tdNljf3wv/adBOxx1?=
 =?us-ascii?Q?/DwtCYjUZMfTATswpjOsxt4BR1yTGBdid02wIHvNQva8CP/uAuUGSwhn9xry?=
 =?us-ascii?Q?BO+4N/EE/D3TL0Xc0+7Cs7brA4A7Ael/aHbyww5QCxzIzDYoxVxx5pIil81z?=
 =?us-ascii?Q?AgMR3I1Q6/cashk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:37:58.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d937d01-71cd-4754-6d84-08dd57db961b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

From: Peter Gonda <pgonda@google.com>

Add a shared page allocation. To be used for SEV-ES GHCBs.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b621a0f1907e..bd963ff49bf0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -605,6 +605,7 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 18a44d8220ef..4f3240976f6c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1470,6 +1470,12 @@ vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages)
 	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), KVM_UTIL_MIN_VADDR);
 }
 
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages)
+{
+	return vm_vaddr_alloc_shared(vm, nr_pages * getpagesize(),
+				     KVM_UTIL_MIN_VADDR, MEM_REGION_TEST_DATA);
+}
+
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm, enum kvm_mem_region_type type)
 {
 	return __vm_vaddr_alloc(vm, getpagesize(), KVM_UTIL_MIN_VADDR, type);
-- 
2.34.1


