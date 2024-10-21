Return-Path: <linux-kselftest+bounces-20232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB989A5A41
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60431C210FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C791CF7DE;
	Mon, 21 Oct 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lsE2HV6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B821CF7C3;
	Mon, 21 Oct 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491877; cv=fail; b=u1RpA4MNVRBP5AOv4PUkohaVOrw3cd6dJhjTzLtr+QsCJSZVLyp7f7owDCzlhjiXalHGvvtHAyxAWg3yOkt7Z/97uV9EqfvuXnHbzIJ70QgZ8GXX/qNsKQA9bOGi+xMPqWIPXtwaqDHfjIjhTLpogHTQ+24+j7Bmtxyklx2dD/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491877; c=relaxed/simple;
	bh=G9ewBhFcB34xufQPYi0PMYcU4rOHi6JnbgiCsR2/B04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q63JXfqopthBBN2fS4DWFHTfhQPU8TVAlmWQbmorxuGNNJFPur3ZmPQOQXMcjlOtdyvb0FfdKE4zkv5EfvIftSZZovGxTfequo2TRyyIHODFI5Er+IGuoPEsjnFTv6V2QoVdIm4glgAr2ELka6XRPzR1dE+74IgIoZ3mqceOE2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lsE2HV6q; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJejNHZ5dEOlYhe/pacUmTKI8TiEwI0jBRgNIv9ED3IiC14YvOfkZrvtDlh1+lYDUYhvoeTFHJeqW8KegYYG0rMAipIaf58kQ265ud5Vhj0q0CEjyhpICIHucK2dge6Eor7IaJMaDVUOVVi+xz9DBTv3xtkim4Nv1v56zw82gd099sQ3lk9yEFYchEqZxeWtLU6g82oHJEtlzrx1h8G5DxE2OF3OKP3Oj2CJJJs5ZyPzLOt3ZFoQO+NIH1EfSJuLgIhjeNFAlCqQhU368CtRZirjHepkxaxPdFbq0pYSZ2k4DVne9KQSsJ7zlU6N2zSscNFacRQwU1g0UJWof0+WMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzQnFEjrJDWgN6nJLiQ+aRhw4kj4MyJ639glRa9Topk=;
 b=j+AtJgK/ULoZDkxbTp22XyZHY/g1m9AofHjUGiczAae5AUqmeaM7G6DSd180KRVwL6S7DS0CBr3kTF6hUaCjjYxg8pHF4QSs6yGcZFvd1/oxjopdff4Z8/tWH7kLaOyccdf9gRYgin992bWfTHtY0g0v83R90tWVt72v8e/csuHjy9Mditu6XIgkpxe3d+XHFvkvr5CxC+/NbNq4Avvi/ThIrRLe9YOS9iCH8v0WZZmNgNrTMhFxuDIV5Ac2owQ5g3lyaZm8tks0SwMnXn0HvoxxBd6wmKHlO9YL77rZrpNgZ/bv9YxLdA4oNqeWuo94pScZLiGHLCHTN5xEOgWa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzQnFEjrJDWgN6nJLiQ+aRhw4kj4MyJ639glRa9Topk=;
 b=lsE2HV6qCb7Jjharp5TUwlqk74Km7r/8FVrK5qS/wBujex6Dc3mDm/sD3PxIAhGJxLALxCmmhq/GaV28sSm/6msy85+8wToz0rJ/RWcU/fBo6QMFoWvabqgkEWcc+x9KuYtqgvlKWW6YTLI2+PdQZl9cqAjli8Pl4w0zw3+kJBQ=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.27; Mon, 21 Oct 2024 06:24:32 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::8c) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 06:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 06:24:32 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 01:23:42 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 1/4] KVM: selftests: Add safe_halt() and cli() helpers to common code
Date: Mon, 21 Oct 2024 06:22:23 +0000
Message-ID: <20241021062226.108657-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
References: <20241021062226.108657-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dca4eb9-5c18-4936-9257-08dcf1990693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXxvTao7L6hVLMEXiH8k09Rtimt+Pj/msIFjDASvubTVkhRRQ7GEXLsxVX6k?=
 =?us-ascii?Q?DLacG+4fZatOVszAWtHTXnCs2EscaPsziRaZozarGiIkC+zbsn6Ub1vwDun9?=
 =?us-ascii?Q?25NhHYpUG8nqXGi6imcxbUcNxbajgrqzW+XCflvzZsIR/KSxDtrEcDoVjp0p?=
 =?us-ascii?Q?n8scGTcgvfFRV4OTc7HrolWNa3pqCfIg0+wSTce9dEm0XEundwfcRWi6gtiO?=
 =?us-ascii?Q?YkubkwfXHF8/qXJ8MehzCiD7piQJXdbtLtVy7+pyTANxu+1pkQGJwMCaQ/lH?=
 =?us-ascii?Q?27ugHQQB3JiFmvl7sQvsM1ei1TwriUuj15UbFQj0hCkKam1OcElWQm66GdO+?=
 =?us-ascii?Q?m6XYZYZ/UbQRVEleFMKYtV/8j/5Tw/nUaCsH/NYt5kiquUpRAUjlG3qro+sS?=
 =?us-ascii?Q?xwDjsn15+64meOq4dvkLejGTlNt5NbCLwWowAo3RIbId0ovaBjX1xw1Ani1V?=
 =?us-ascii?Q?HV/XbdmU/nr+Yw4qbV1qcssoRnB4rBBeqOOOjwlWwrunyDscaTRhyYnqzWNf?=
 =?us-ascii?Q?oMa5KAYDKEx3Ys+lBxL7FY8bP251cr5cDLrHwp87V/oRKJLlxiiA8YEPAO3r?=
 =?us-ascii?Q?XprWByqaBSBo6TNlVtdNK7Pi4ZvwWO1tzMReCC4dqW8f2atxkqXIHhBAp4vL?=
 =?us-ascii?Q?myciepwEoznXFSIhYotxuqmHz5Z1wkEFebUBwIfkb84uJ/o2kd3CA5/ZVsE9?=
 =?us-ascii?Q?v0iZVJBIOEyVpVE2l9qy4Z8vgXdf7grq5azjXaG4oEpQEKZakZvmbduwr1IJ?=
 =?us-ascii?Q?mimOYK24yF7ge7clL89Yb6pbOumIGbKvL+4/uOkppdgS3HwptY9uOy3MJ2hE?=
 =?us-ascii?Q?IJkq5dkeWuMypbvmdRYiYEtm0aDaUOBz/Y5Tdp6v78FQbILFJTgTnmNEOiG8?=
 =?us-ascii?Q?Xck+yzCv4OCXfZY8jVna7U3Oe1n59NfMBk/rCsssEYG9mqOmZp4HZBlHbLHP?=
 =?us-ascii?Q?isl8XeiCcEQzl57XwCHBFudOdrEuWttkTugdRuxnyEpxAKex+F58LaJsAW/N?=
 =?us-ascii?Q?9HmsaaDUWLfGtNW9kNhsOWwRV9AOf8a0pVPncR4ez5yaqATeFW66o4kwi02U?=
 =?us-ascii?Q?FrsIRqTznXcYZO9P4OaZauvoo38VYTtjvLmBN/ZkX2l3A7pnN5z0wvG+6vP+?=
 =?us-ascii?Q?0otuA1f2he1hNU/bkPZKr2QkkYYK9llLAeSF17tPhwuzqwAzWwRzs7ZkiT6w?=
 =?us-ascii?Q?U/Oum96ugTgHTJPM+A0qkYoVjf/Bm9AnGcuLL6h2r8/9R+mwBTpSiq9YTaCR?=
 =?us-ascii?Q?uIYOLJWWk56/7CaRCMJIVNcXIeBgxIHSOEE+hEL+IztnmX4UK4lL+5tXeBlv?=
 =?us-ascii?Q?CifriLXob8GunAe2RFGgiEplRsndJGh+tYKy5gfH+osMIdS/0k93m4VSXHbH?=
 =?us-ascii?Q?vBywbtLloKCIkvJ4owgwM/KyjH1bK6gxlhPU/V4PsYFk32rR0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:24:32.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dca4eb9-5c18-4936-9257-08dcf1990693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

Add safe_halt() and cli() helpers to processor.h to make them broadly
available in KVM selftests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e247f99e0473..8e36de85b68f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1325,6 +1325,23 @@ static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
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

base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
-- 
2.34.1


