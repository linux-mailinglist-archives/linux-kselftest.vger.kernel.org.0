Return-Path: <linux-kselftest+bounces-18722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140298B487
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A453282D7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AF11BD035;
	Tue,  1 Oct 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3fifdbLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0F1BC9ED;
	Tue,  1 Oct 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764481; cv=fail; b=TcBNUmLgpS+zjS0wWMM1yF4u/TOYZHUl6AgYPjg/ul5U3zWAWn5MyDC4kXoXEkzX3m+pT4HLsr74q51xVsu7pDnSm9GEb0kZ2JLowPqj584KPZpUwcev1FiMLi6bEFqUG8wkrYuUcLjDpOm49nqwgogUB0gFXYwsvCxaEVaeDCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764481; c=relaxed/simple;
	bh=LHv6DngdlFAm2g5UCreA7fLqwd3lcbclWDeiI3qVX68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKLBfEvy2OevWnW7PgE5sVYfatEGgsJLXyxL+Ij8o8gYJcZXCcUwjKP+SpVFmbkbDvz24XeE8zR31UR13APuzHBFX8SVtvCpflI/m1Lv4U46f+BT5mx/WTov8PkErteusKEglM+uVQWybG9NNpwUNVy2fVcXH2NJFVnDJSS+3jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3fifdbLO; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSPPAsVGjmaEH/t0cBWMBznQMIT0nfUsroX5OoA1MfmZhBdnkMSY+9yqFJEuDrPXzRJ6rQ/RtVUnlu2+ELngVxZwDTth0tljXnka8xBR2CKSM5opdKqYgwwhavpvWmGhSiEs0XheAqePY1v/daic54FVZvVyubjilLgrKdzUhYB+TmHbTy+VpE4SSs17646+fJvxRxTcUF1X3xaaPS+p9ewVOCvI85JpJyMj233tZdfJ+L1Wy0pjCocxfbXlaUr9Q8U9/HwDTAAN7QXBXQ19Xgg/BD5J9MdWSDFVH8QEUcjFyO3CzmtRkopLb/wa5jNNiMYYkkruw64UxOLrGWPduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqzw9XKzch5uPZWKVULBHcAN/idajHGyVUzFJki0+SM=;
 b=LxKMGFY4rv7frmK6OghJ/oOnNGneYYSots1MKwwA5Ab2p9HqScaytUyegblnW3ObwfEon5Xhpwp0of0tN6XCKFUx6c+RPK5EAkmsgeWgWNS3n9Xcf7CCHB6SkedDmJXgGwiBcDKTKfRBGKc3Nq07yu/AvOiNEDUP2WTU/q+rPmkX8Iw5DcRkydw0Pd+bjsQqtIrIccaujxr71LC86HI1Zk20IbLyRNPkjMD9Hn0RJa+n05EnJl1IZH3Ca9ZCgEWSxGvBozXXvNXjn6Lxd60H1UlAbOleWA/BADNv3rN/4TwGsg6F47L5Gd+RPXOajAbLXHiPdY9YzeNHNnZ8NThAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqzw9XKzch5uPZWKVULBHcAN/idajHGyVUzFJki0+SM=;
 b=3fifdbLO/nvo2hDBXVm/4gjQlR+9UpFZuIqP/uFpcxuS8knmG22e2igw8iaaOx90DbbsDX321DRQqftgVmVQ0ijRWFVzizYoesrEiNAG+pl9TTdCG3b9EKD8lcytPXqHap/UdhvYjwGWnxrWGCfjklS6kAE8dcC/QGrOdrkYayk=
Received: from PH8PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:2cf::23)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 06:34:37 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::d3) by PH8PR07CA0028.outlook.office365.com
 (2603:10b6:510:2cf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:36 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:33 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 4/5] KVM: X86: Add documentation about behavioral difference for KVM_EXIT_BUS_LOCK
Date: Tue, 1 Oct 2024 06:34:12 +0000
Message-ID: <20241001063413.687787-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001063413.687787-1-manali.shukla@amd.com>
References: <20241001063413.687787-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a6bac9-57c8-4edd-d031-08dce1e31e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gHB0i0ohA6p9ZieP/PUfWtQZM49z0br6aLO8sUhjlMLHAcYe78gfaSCKmun2?=
 =?us-ascii?Q?gRqO6jTlOYcMtJLwbRj9iHyM/RHt3UgLaRoDYRxogQ9fed2VHHJiVYyIFtmh?=
 =?us-ascii?Q?XUM5unc2lLMhG6JdJe6NkWAUdZfpv75yLUxPeCT7USPgNLMVUInHXXJmo7ej?=
 =?us-ascii?Q?g/qKNtPqBCBow4UU6r+CQA0Mp9l3W+KLU3WQsQnD0S4RfvhAr9tgolVaxCFr?=
 =?us-ascii?Q?6XS1uOrWlptkfxd+F8ZQJGxWKN1DZmH7nIdRGFa1VQhai9SnH0y0ebLiLzPP?=
 =?us-ascii?Q?BOKe6Bxv9rXDfDYizsfikIJWnRV+lOxs1Sbzw3ubJIGzZnV/a0ZaVrqs5Fpz?=
 =?us-ascii?Q?nosoxDoXojyzu2M56/51zVppj2S0BgMV7S/dR3fRoLoh9J5r0GfOamKf/ARS?=
 =?us-ascii?Q?Fs82X905dQR6wQyNs8OATY+EDnKbH5Nsyn/TmXX4eYIe0Q39SqRwHtIsq7dt?=
 =?us-ascii?Q?66tNJCM78fEwDf8k65ZWiYC1DKzCHURpnmjNupsQIbbgYlR4rlf5hx9djVw/?=
 =?us-ascii?Q?ALi3sY8a/Ejj60xEJlU4pUIzRjA8SyBGEVlcX7zTh7envmYaxFC0iEDzBc9z?=
 =?us-ascii?Q?NsO++tNSKCfdA273hxxAn65HxtUyPgV/9lcrjcMwjbDleNiOklT08J0PDvds?=
 =?us-ascii?Q?SevawZT8c9HOktwAa7HzCeF0Avj55TTjClTVRM9AZq/+rC0fifdhy5qM+foK?=
 =?us-ascii?Q?7bLgIMRncdyidrPQ41pzTCKMoYxabCFiZ4D0IOBLCrHE0CHwFh4XJSd03yPe?=
 =?us-ascii?Q?ewzvzD6OcFKFdVEU7s86qt099lXtXUaQJiYfRzKKQk0cigCPYy32Tm4gePHz?=
 =?us-ascii?Q?VUVfWSQgJ0vjBQ4VTwqOv/DB+UPOwdwqyIjhhfTfY490LB1BaA6lYORMKTOk?=
 =?us-ascii?Q?x6rfcMVnPD6k+AgVmMQGePiZqdvMSjxQ1w/0tNE3hoqrr8h23S4wwi2V3FSx?=
 =?us-ascii?Q?0l6n6wMEvI5VYvIUiXN1TFNm65ZUo3SBESEeSNrbsfCdMQ/NLMuU1MFXjcgK?=
 =?us-ascii?Q?chE5JJ+EaEqLyjAj2cSvhR2aBmP8c9841xG/yo0FQYk7CC8rfWUCQbPSEnYn?=
 =?us-ascii?Q?6SMprtHGKmsk+JO0T1fL5vLZb6GXmc0UfZ/6dhKzgTsPgbsonOZnmX9u1QsY?=
 =?us-ascii?Q?e5Vur/c9cIP0GT7cLVs2eoniVtKN1sQvXvLlKw7dz2vajK9D+iXppX0RvvFn?=
 =?us-ascii?Q?9BU3ug0bjX5ID5EpjS6QLSkEhCYpeKq2lUxPPJmMqtf3oMPp4/Gi5RcO1Qgl?=
 =?us-ascii?Q?npQo2ZG0iABCYpVFeYLux4PPF6Jdnn40mVaUEGViznvXeatGARu0T5hHSUx3?=
 =?us-ascii?Q?w1K6TL3jp5C0DqqROMeLSt9OklUh/F5ehXKCfAgWB4uS99TrTzBUDhbAF5dJ?=
 =?us-ascii?Q?vPFb75LxFfeK3owHY96irZOQrrvBQgVVwdmmCaJgh1D3j5yIAsFaOUEnFlzz?=
 =?us-ascii?Q?TbthYtLWRaqP9FfUWsgcKNaBbQScz0fs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:36.5463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a6bac9-57c8-4edd-d031-08dce1e31e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164

Add a note about behavioral difference for KVM_EXIT_X86_BUS_LOCK
between AMD CPUs and Intel CPUs in KVM_CAP_X86_BUS_LOCK_EXIT
capability documentation.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b3be87489108..536010e1df1d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7869,6 +7869,11 @@ Note! Detected bus locks may be coincident with other exits to userspace, i.e.
 KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
 userspace wants to take action on all detected bus locks.
 
+Note! In KVM on AMD CPUs, the bus lock exit to user space occurs with RIP
+pointing at the offending instruction. In contrast, in KVM on Intel CPUs, the
+RIP points to the instruction right after the guilty one after the bus lock
+exit to user space.
+
 7.23 KVM_CAP_PPC_DAWR1
 ----------------------
 
-- 
2.34.1


