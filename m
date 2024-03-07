Return-Path: <linux-kselftest+bounces-6037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4578747B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6132D285DEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789211CA8A;
	Thu,  7 Mar 2024 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xO/fxyL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4A1C6AE;
	Thu,  7 Mar 2024 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790413; cv=fail; b=N6BpsOk4/6t5D3GqaDLRZu/SWzKnDIt8rrwIiWTKuTpatdgHEaFA0rzTMGZocnrqlqE6GBWUzKc2+Tuu80Ou/PfY25vrYTLuy9iWgqBJxl5ulzsfkGfHobDKGoIhjZBp5SYNTHGwknpqCK5Jltw1yMeQoNjNjQ4Mh6bHm09PRyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790413; c=relaxed/simple;
	bh=8k8etlX8KlaiTcnM6tiirRwhXhhhetVLwb5sK9pBmMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otb0jTCuy0diQiDN4HwU+905WqOe3XnxOW6oTOgc/aOArV99CmlBZ5UNCegRd+wU9eM3AhbRAmyhbF6YMzPmBSmYI5uPTDJqJPYr3lOQUVLBDL/zZp0d83+1WNDm2DmY/4KtboySrZ50ukIXU0ghu1vJ3YcRmDVYCLTXi76+2VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xO/fxyL8; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri2RmHeANPBnFVj98sC1MFwQdndNCCmdnGrmQCGWY+jzzNfhye14QC/nKV+EtZ14obZmomyWAqWNUq/RSJPHnPWvFChK+vW4bO0F3lPlzPezMJw5pl8fijA6/Uq7LwnY1/xWwCB1B/osszCqNqiUPXJ+TDtIypujTpvmVPvW+6/wCRyB+a/0rr7dUxh4pfJyWAP/CSHI40sZOeIZ/1U/0E+uYoz8VZQ2YFiNsgBiabcsI6ych4GoOXY7cH7DLU1rUKw2oGoSXfXNKfGFaauoEaFrj1qJrptE26X7piKu8J2cSDFBF0y5iQDrvOSIlDnaUQ7C+QWZ65rs04Gbl85Cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTo9Z0i6F3Ihhq/epVa18YTienOsDxKtGDwr1/avamI=;
 b=HzivCmSwwuPoEgykmC2tZnFVGBQ+MoF67tQD7o8Ghpn+swF2ipqgweA2omsRdyoOQkXldl7oFWhdcLfxZ2tMM3hu3Y9X91gpmCt878lxjJTU6yCq5JXZ7xJ8kg4pC641LW6SGA+fnIzyzXOK7vbn17S6fiSNF53ErV6ynG0iIxz4pQdHLLZrUf4VUU+dAK4TtkxMytJe+dSZAKTbDKDXrXJXyYNzcejBP+M9guzA8xQf5lcwt1I2MFveXZ28x7BgezsGzA1H3AQMOc8/nuvzk+pRwQ0UkRjD977OnkdQygA10QhYrOMvq9RNf2h8AaTU+VelxdQq1OzDrmOgnOrMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTo9Z0i6F3Ihhq/epVa18YTienOsDxKtGDwr1/avamI=;
 b=xO/fxyL88H71gk1nG4yMJg4e56jo/C6cKjOSaXIHQPK+QpT1VcAymglJg4HdAw3zMrSy17+9FqfDGWySYJ/kgG3q3+oH58GQehRPCf+F/AGelSsLGwyMqg/yLGc6mRGY/dZE/iPEO1qdbIbeRormCf1JV3ESQ88LeMOyotBBE4U=
Received: from BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) by
 SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 05:46:49 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::cf) by BL0PR0102CA0035.outlook.office365.com
 (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:48 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:47 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 4/5] selftests: Add an interface to read the data of named vcpu stat
Date: Thu, 7 Mar 2024 05:46:22 +0000
Message-ID: <20240307054623.13632-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307054623.13632-1-manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b7ab72-dc53-46c2-aed3-08dc3e69fb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIErOIvrtTQ2BhH1npxMgqwmKnzeB5YK+alVxcpeWgJkeK1qeQSuHtQXy9Ageyi8FkxpbKvizDAggmK6bX19rB+96EGpyNUBPeVNLIalazsKcYV03lBJ8gX/bg1jAlIiNtSR2tRwnPuh9mtA7IJY+YeJQn9bH/BBMkMVhJ+i6TsqRN82j8E5P05nPB5qXwEK/sX6Qt4VQi8bdNUbxDX+4jHXNQqjY1aTXPfud7FzsD8dMBcIdbgm5Ff6AKIcSk/WzojvXs70812I81SuZvxbosalQloQXXFTaDMQi8sxHiP/AXF2TPEOItAbQXg8LmW3MDkSalNuOeYBWvd2kR0pzI/LCSZHC+BoJVgrzfddFDI+WifiQHgIpIIsWE9zNPdRBSpw40GXjT3Jk056dKBqyU9TtGQSfh79WL5ZFdriHm5LN/io8BgXE2Ooz0EMZ5RqK9FuZ//ExqKnwLCOZfGM/N3ErWOzaD4+6nECu8QMUCj6+4TiXzLpl2v4n1HzeGYXvhapNSh4i/Ev7n4Y0WE4mYsIH6QfE2uiV/tZZBC/wwO4UljeZ6t8vYdBhDXP86S9Nso/N5KCYQBnbE4W17YZdryS//Ki6cA/GtjLFjaZr7WmiFXjR2kV6ev51lUXJN/Sa2/mpQsguN/NKIu6e5kYh7lAG8z4EAsmAEiaE5MjQsHnakDO4eGCozG45CAUn3iEiMTMDCwBG61jL6ol03PrjUbDFZlSsUK/ADGw8+DFovIqlrbygfF7nKP+EMxC/yTx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:48.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b7ab72-dc53-46c2-aed3-08dc3e69fb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

From: Manali Shukla <Manali.Shukla@amd.com>

The interface is used to read the data values of a specified vcpu stat
from the currenly available binary stats interface.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 11 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 41 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e5afc472c14..294bb42b6940 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -512,6 +512,17 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
 		    struct kvm_stats_desc *desc, uint64_t *data,
 		    size_t max_elements);
 
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
+		   size_t max_elements);
+
+static inline uint64_t vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name)
+{
+	uint64_t data;
+
+	__vcpu_get_stat(vcpu, stat_name, &data, 1);
+	return data;
+}
+
 void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		   size_t max_elements);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e066d584c656..3d3a67ea0c7a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2166,6 +2166,47 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
 		    desc->name, size, ret);
 }
 
+/*
+ * Read the data of the named vcpu stat
+ *
+ * Input Args:
+ *   vcpu - the vcpu for which the stat should be read
+ *   stat_name - the name of the stat to read
+ *   max_elements - the maximum number of 8-byte values to read into data
+ *
+ * Output Args:
+ *   data - the buffer into which stat data should be read
+ *
+ * Read the data values of a specified stat from the binary stats interface.
+ */
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
+		   size_t max_elements)
+{
+	int vcpu_stats_fd;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *desc, *t_desc;
+	size_t size_desc;
+	int i;
+
+	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
+	read_stats_header(vcpu_stats_fd, &header);
+
+	desc = read_stats_descriptors(vcpu_stats_fd, &header);
+	size_desc = get_stats_descriptor_size(&header);
+
+	for (i = 0; i < header.num_desc; ++i) {
+		t_desc = (void *)desc + (i * size_desc);
+
+		if (strcmp(t_desc->name, stat_name))
+			continue;
+
+		read_stat_data(vcpu_stats_fd, &header, t_desc,
+			       data, max_elements);
+
+		break;
+	}
+}
+
 /*
  * Read the data of the named stat
  *
-- 
2.34.1


