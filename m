Return-Path: <linux-kselftest+bounces-6945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3F893CBF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A9D1F2277B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA846420;
	Mon,  1 Apr 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2D9Wwej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5A3FBBD;
	Mon,  1 Apr 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984855; cv=fail; b=MRrfIG3ZN3z10MxjN4z3gE16FQl/WYLfhgqWXBZQ+ZDD2ib4Hc9SiADH6iRxZhykXU0dv2iKO+8GReesdckug8rPQUdLV8qznifu+Seob9WB7t53cxkD8W0EFfEZUrtG4rljXr+4EbZG8dAQhe8LnVaUu4bDKcZG8ClnaLjC+LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984855; c=relaxed/simple;
	bh=ySJgZEUorsCyEp4Jdek9zGeISNzGTW7spH/Em6PGwO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJvj81E9VAZ6I2Px3ltQGYHw4VeETKMikzuQoxGzItQu3Wam7O1VLK5Y6cWtyt8cktkvf+aEhUDM4E6WxfoOv9IBUYVK+uvcTn3CbxF6pHWCw+aXxka9Orb15LhiN2xbJ2VrqiFPF/LRprVXQLFtRAX+WbRJRXvJGAydjzywyvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2D9Wwej; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNhZNmSaQiJePPCVUHgyPfyf9YSDHxQQgPU7101gKtQjhPwHkJQoISLzsuIDORomJcXG+Sc/b+iNpGKwcYkiVqMhBlXm2rBc7BzOk36qBwuF5cKnmOXopS3UdICwbhDP452MVqOxruTVzyWm5PFCi2gr+F1/RpTf0i+zLIEELdCacjuublykW9QJiuRBvnhTMqFla6AECIlw3WhnRpI/2RKyk1JO4bL3FZZRyYdneGHM183NOeeM28MRG9KiP5pUQBSfJhSmmVw9XXWKGQzYHiE0IVbvncTqRQq2C56TPBdHKXm16BYuGhO9MoRudOQ+T/RxgPMTlKiQuimok92aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16shPcdruHzE7YytYMcJenoFtLuSK0lr88DixnfrsIM=;
 b=Pezv+JSCFBfz2pymCgGbnscnB1gIU+F+pyLChguKjSC6I5SntFK6xlrfre+wrp8xBGc4+s7GrW5muUvQgJmo3qW9hqBbEBDHfS80iq1MEysi6nwF+Fn/xyAX7PvnAkFKFhp49REIKTVkOK0a23ODtD600Jk4Rc1KHSG2YtUA+5f6dRZ1jC8Lm2MaBnsxkRzK9GqaEjN7X+uO2QgggfC349eevzDCBIdqxMNMhr+VX7hdcWIHl4RKPIak856ERR3xWZpvAK+RTlEyVkSxxtl6sg9JCp5k6RUrSXSzcl7eJLnYLjMCg0lXEuQCIy0golyTWK1kFVKS7uagsLC8g24R+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16shPcdruHzE7YytYMcJenoFtLuSK0lr88DixnfrsIM=;
 b=U2D9Wwejy0j40GA9KM1BYJ6sn2mySvEZ9/EQ0r3GBFk2HzqcbTsAaN8//TjsJu6ZDfO3j6kBLnn2tMkYBsjZ0327gZCUWCP5EBTHNkrK+MY1z8+7432kkxhmeVLklvH1Kn0RHUuvvhcQ5LfBfI429pSe8/mK9AJiQUFhOiKvKfw=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:20:50 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24 via Frontend
 Transport; Mon, 1 Apr 2024 15:20:50 +0000
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
 2024 10:20:46 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>,
	<ajones@ventanamicro.com>
Subject: [PATCH v2 1/3] KVM: selftests: Add safe_halt() and cli() helpers to common code
Date: Mon, 1 Apr 2024 15:20:30 +0000
Message-ID: <20240401152032.4284-2-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a22a416-f76f-4586-ccec-08dc525f5044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2ClRr9IpfGNQRAJZyRSpPr+g16QdoExQGyEw8j+Kf4FReDj2T3aI10GUu6G8IL/qdUwUljxmn2t/0UzdTOB90J0WL0I0Wg3AAJFXSHuZhc6oTl4VlUNKxeLHjBMiKkwr/cCWzv6+/NMNMQY1RIxZq+I7O/iu1iu4OV7J8yHHKpX0FESA1lADGhIRUF7EFg0Nvu4HRNvmVi5zNTsBU4cnH/Rc0P00djP4plOYhiUnfHsy5xAWhk0y8AzkFE0K1Rc4knO4Kv7snNuy4r3ujgNSwJXtaafvCnUYVqkfAYPg5J2vFDNurTFV5PklMOWguPVlcvrSUOx2Xmj2aUXVvTUukuI722lWJivORVb90asWFmshJDO97ZcgUXziXuNCKl8WREE2EwOcvuJt4gYZjb0ZWaBRkZ7XsCBY+Jl4mUHw916Lj9fVBkeYrVC3Ef9N9DnhSPjA119oQWyZxiiNbT1MRvKysxzur/gCXe1li4UJbBI8wInDSWV9Hdv8xKbL92f9KHUCjKrJ989mQdsMrFnUWi5Jh/bInIidnViln8kNBCl3tg8iKX9oLi8ofpbg7OiLCr7zdPZJ1pBPmczRxEEgabkPU9uYsvCgLG4Vpur9Pkwi06msmzNjLsmRtp/Q470qWgajWP7epFAnxSP7gW8b8PDjPCHQzUpnomhPJd7vJ9qNMql5vIvSDiyem0lRQ189MJRQV4aj6jWjEVw5U9rihd2ZaM8udKzUmFPXdjCa9AONjkja7RXrlk2XX8zDDDQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:20:50.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a22a416-f76f-4586-ccec-08dc525f5044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

Add safe_halt() and cli() helpers to processor.h to make them broadly
available in KVM selftests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 20c9e3b33b07..6de37f6b8ddc 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1217,6 +1217,23 @@ static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
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
-- 
2.34.1


