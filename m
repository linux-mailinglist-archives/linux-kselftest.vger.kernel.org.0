Return-Path: <linux-kselftest+bounces-42109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA52B94575
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB3D4832CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612B30E820;
	Tue, 23 Sep 2025 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JN+sfmVo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474AE30DEA0;
	Tue, 23 Sep 2025 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604524; cv=fail; b=OMpE+DcoOTmyezj/BVGTqhL1E5SSOA5Cf6C76L7SUSiyZVTkyDisqlciWgPNY33PgJXOjSR4jZNUUBBPjSi49/zPPdEgdBxS91/6pLFxmuqBLH6BUHYuO1iFk8JeUZm7Xold1LY/lUwEsgJKN80YVKOuIDjwpOI5Hh8daiNSlbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604524; c=relaxed/simple;
	bh=O5u7bZDATTLx+Hb2V6DP/e7nhkUlhTyAEPbMxXUWof0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JotJJv6AhFjBEpuW1wFJs2a2ot6JUyiBt30977YAUw72nXbqsU/wqiUItsQabyEaF51yxwBxmN0fos/3Ztp0P6P7Fjb0GjOQtlQWA0MKBwmF5T5vz6SYRNuX52kiIHYaRUOaPm2Mrg+gstr2e/6wwgAYxAArfyEtYvAuHd1J/2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JN+sfmVo; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs74x+u+IjE/FElZo29n69zAYjoygjkDkwPgKhVFzk3JFMwe5gWyKLfqrQd1pMuoNvNFKkvTx1O/CUd+JqVptbI4Qv0Y4zo5I+EEXY7vrSee2//PAamtG2a3Ix9HC/XsvJWguRHxhFMAj7+rAYHw+FH2Q1AmtMxUgeeRYBOztPA1UpebMKjs0WZgPUAY5qUfhOmNP/1qz3sNJfKl/Crgj6lTYmFtu9nNfKRsmEAcphnC/zaq6Q8K7q7sbgrgUtMoh+FydR1jX0EBBPDLz/g3qj4P29isbPF+6bKxZf/6PIuXNXRITT8Zt52P+G0XFteknVPwkz0jj2Xlrxvw92iowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRZ79i3OYun0giPHo2gKR/+rKAMBoH5rek6YJujAiPQ=;
 b=O3NjzOGIqfbXa/SDGr4fh0lsTruBXbQ9YqgwmahjesC54C8nex7+MPY35aurOemdPQB7H7mO1qa83gsV82HQuHa7giL9Jnx5DIMrcdlvibyzzsVqAODrzBocbaY54Zsnm9mUoI0LSqGhIsNqU/jwEL0Gwd20lJX2PHI5DXktaPPKYr6Lsm4MxBbAU2OL6zi8jIncJEu3bov/rTDgvf+Ps09hqvMOV5bV5popgXjsdqFOPivnCOCidSuE8eVl804bv0eQY0Z2zlatyAxcNGVOMW71qj8BC0H8KUp98M1pvQxDPfr7Kt9ZsJIP8aGuTMsHMAcG01gcbCQ+qtY8cyRXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRZ79i3OYun0giPHo2gKR/+rKAMBoH5rek6YJujAiPQ=;
 b=JN+sfmVofo2RJw44VDLtuGyhilJR/lok62PwQMrcXU0yTX4emRE3sS0fsGA/A96TtPZJGtUkK0dJsRc9LedlQ0q+ZAg8/1V+r/DQWupvn3bB0Kp8WpdkSmDPFZW0sGyPe16AaiGtGcBo9nQplXUNPBoO8QkQ/n1wXixf88eHS8I=
Received: from IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::6)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:15:16 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::44) by IA4P220CA0008.outlook.office365.com
 (2603:10b6:208:558::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 05:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:15:15 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:15:10 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 18/35] KVM: selftests: Add compilation for instruction decoder library
Date: Tue, 23 Sep 2025 10:39:25 +0530
Message-ID: <20250923050942.206116-19-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2798cfa4-bc9b-42a0-503a-08ddfa602e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vMTZXPeQ12zpUKN8sbIoy98uz0+NQAlJh0Egv7GXmr3dehSGyR3ZvneeXNsp?=
 =?us-ascii?Q?h4J3/vVuNQre3siD07VF8njdQIITw2QRykvuT2g9WQSswDIWwGMwJKeHNYL9?=
 =?us-ascii?Q?VAp+aVzAa8AoK+c8yMjYfs5eSjr5nLvDrQgXln0VYkDe/Mfimfwf/Y2RtR/7?=
 =?us-ascii?Q?/cIr7YJeEcO9+RcUnv3AUbS+iuJ3a2dQ/qiptFJ8pferHn1FGHgihFkC7dRU?=
 =?us-ascii?Q?eMK/26LTKh578G4jz4SmFt/NWvFojlcDbvEnT6jDB5BWzZ5Wm00KWdlf5PTl?=
 =?us-ascii?Q?X9Hjlphndfa8xVRbbKDGwi0GB6IZjsyk5GA5rwYCQ34ekOqwfSaNWUQQWp07?=
 =?us-ascii?Q?DgmX2wT5enrJjzHGb4A1vunkjmlnCVa/YEvQg4UBc78WGDzCye+pItSqiLFi?=
 =?us-ascii?Q?p735b5fl65zfg6QAcJFm5AUuCwFFfqhlmDh9vt4I/sr7lG2csLuahKPnKFRj?=
 =?us-ascii?Q?6kQJPy1vf3vzdD+koAAkz50W62HgCvl3bxnZ462R0wUWICTsYg0ID3zSojvW?=
 =?us-ascii?Q?/2939CoSRTo48W+iJ5qjGl8OjliKlHT+69P/QhWa+dA91Id/xvtAGTUNxfIe?=
 =?us-ascii?Q?o/72jbbFeUG4kGg/FS7KMHbkl6jygGNEvbn+1H50FDKe4wHm6Fp8fAif2LsR?=
 =?us-ascii?Q?NdSgU9WyxIkbUwHnZSlWGF7ppzbuRNVOvoiTUrOtHEMihFwX65UwFnm8arTi?=
 =?us-ascii?Q?sfyPkc6awJG+dTXrEY5Y4c92sywpKh9Me/3X5h5yfrKQQN8LW4wLb2viiOTW?=
 =?us-ascii?Q?XokydR6JeR0GvP5M+fyrfiZNuTWscF+KZWVDzctF+sNOkcAEwjvbiPF7UOcZ?=
 =?us-ascii?Q?x0ZpbunNiWLzAO+Brz3HjjMjCY7TfC8vSeiGtRHSWqpywdz8lMt2bC4t5TVd?=
 =?us-ascii?Q?kFbQyhk48ke2Dl2clJXZhxzm8bnVJUkiKZLv8lvJEtcWD1fEHRYspwKg6p/E?=
 =?us-ascii?Q?rYF/hvHVheTSUN7USYTIl+bKK8SYPG8f74NocOep2uJbjeSQ2gCT7423F2QI?=
 =?us-ascii?Q?SVSzY9foQsfNACm1Ni4VHuOdafT77/36pinBiaii/CJgtoPxSP1nqmspGr01?=
 =?us-ascii?Q?c8LUQvs/r8Qxf6q2l/IjytfNm7tIyxsZHEkhwoCFPNJBByaJAVXIHuWYE987?=
 =?us-ascii?Q?zzP3EsO3M2UcBUL2aMcTeT8dANnGjFEg5b+SBx6fctgo4bKH/Ux+X25UHkKM?=
 =?us-ascii?Q?DiHoUw93O49QjWC/po4r9ZzAJcgqG9SYxU3dF5qD7tSZ6XK0tQUUzC5pdKm3?=
 =?us-ascii?Q?rxnPfnidbz8ctvhAdJZ1ruaGVmDwX9LTQ5tS3GMrzTwbvxVYnqekhbhB/czU?=
 =?us-ascii?Q?UE/T2IeX6lcD+XGivcDfHl8FoYmYFKWBq4/M5k1jMYC+tjRvllf9qrG+LWSP?=
 =?us-ascii?Q?1gtDt2o2AIoQ0vSY3Fwc/YjyGKo2ouecO2fwqXDGOLS4Cl1lc+EvJi7xO24R?=
 =?us-ascii?Q?zC/x5jpf2VF4xVkpq+sH3VLHuh23eKZT0mdi8orgsBm2LlQDoGuWW4B8+4Rf?=
 =?us-ascii?Q?f+YA62+68NYweVKdPLewZm7jyPo/2V4Jqsuo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:15:15.6796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2798cfa4-bc9b-42a0-503a-08ddfa602e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

The x86 instruction decoder library (insn-eval.c) has been adapted for
selftests, but it is not yet compiled and linked into the KVM
selftest binaries.

Update Makefile.kvm to build the instruction decoder and its
dependencies, making them available to x86 KVM selftests.

With these changes, the instruction decoder library is fully integrated
into the selftest build process and can be used for decoding
instructions for emulating MMIO accesses for SEV-ES guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6dd8675b4861..41aa99e5e0c4 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -22,6 +22,7 @@ LIBKVM_STRING += lib/string_override.c
 LIBKVM_x86 += lib/x86/apic.c
 LIBKVM_x86 += lib/x86/handlers.S
 LIBKVM_x86 += lib/x86/hyperv.c
+LIBKVM_x86 += lib/x86/insn-eval.c
 LIBKVM_x86 += lib/x86/memstress.c
 LIBKVM_x86 += lib/x86/pmu.c
 LIBKVM_x86 += lib/x86/processor.c
@@ -249,6 +250,15 @@ ifeq ($(ARCH),x86)
 ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=x86-64-v2 -x c - -c -o /dev/null 2>/dev/null; echo "$$?"),0)
 	CFLAGS += -march=x86-64-v2
 endif
+tools_lib_dir := $(top_srcdir)/tools/arch/x86/lib
+inat_tables_script = $(top_srcdir)/tools/arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = $(top_srcdir)/tools/arch/x86/lib/x86-opcode-map.txt
+$(shell awk -f $(inat_tables_script) $(inat_tables_maps) > $(tools_lib_dir)/inat-tables.c)
+LIBKVM_x86 += $(tools_lib_dir)/insn.c
+LIBKVM_x86 += $(tools_lib_dir)/inat.c
+EXTRA_CLEAN += $(tools_lib_dir)/inat-tables.c
+EXTRA_CLEAN += $(tools_lib_dir)/insn.o
+EXTRA_CLEAN += $(tools_lib_dir)/inat.o
 endif
 ifeq ($(ARCH),arm64)
 tools_dir := $(top_srcdir)/tools
-- 
2.34.1


