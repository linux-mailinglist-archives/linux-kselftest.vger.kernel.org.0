Return-Path: <linux-kselftest+bounces-10755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05F8D1341
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08FD2820F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BC1B969;
	Tue, 28 May 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6vUffjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C0442C;
	Tue, 28 May 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869986; cv=fail; b=uHjnaHtjnZMJRjP6v1IZD5IV+8wqkAHkFqCNZSHex4wzzgmxRRFwpzS3wX/9NO8VisXFPbdJeUelEa0sIIinVXk66oCPydn6dk0KHSdMpMTkczI4+JgLIrxJ48zFmf+uGkTZDQjAyS22pDK6BLDl6PRHNbbv6nVBXVnZju44caQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869986; c=relaxed/simple;
	bh=QigwGiAo6it6zUdtue6alaHEgr0OFO7JUGjv4KgpzR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+EoKICoAuR9gYmkJp8fcmFLAgGSiAf0l5qhjYijZrEoGJP9D+ls+JVhtHv0/hHAdl9gTuhfFjjuxRvjTsyqUPkGYLdDST/0MiIOJv0/6eLTZQzRRdBavbyw1g//NhwjXniLiNYmrv/z5Nj3bohhMwuqhjjbpOHOgvdXuMtPu0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6vUffjb; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6TMIf4ZJuudhFsQtfYCEla/Iq+mdEwUyG3EsyXko8MEgwAA3mFF92SataBRt/yrjYip4V20d+3mvTMUDwji7r4r1vnAbtBGqxv6EIYfqmrNrhWJnmT4TTd+BvOLpb74O0RsD6wf0wYxa2ZSo+xizmCoXMS8VvsR9jh9Swu5hDe/wZP8dnrGDi/0ifnQLII09xzwhEIq4D6xxb3fto0im+/Yn2x6CClI2xm/rFBQped4vbSzLLnEZ1Y+s6YLX0DKAMvWOG02SSzr3RXdy5ib+SqrhMkr+GsCxACMlXrSXKlRgljgQID1PjOMZ42p4qhtJOf9B3QYk5PSlULfxGwrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgZCoOnHZATsQYnzsBa1FDCDXWeL2/cS6zDFGCgSotQ=;
 b=N5j9tHCKA50Ad04Y9Adi2xhrqEUF1wqUR92i0iPV6JGbNOyYQ5/seLbdooedIGdMI8B4S+OCpp95odCht11976K4gmCno8RcQfXYIrCMBED5rc0s2Dxv0EPDk/f+JinX7Za7bi0Kp5I1qnFw6QK30hI2NAlktFPXVGG+vdJFKXU1ZXZTzpcPdt4QOFQQOaG9lqq5OiQ8/OKyD+BtrMLQYgVfrgsGASC0aXUn/S1pzN93CfJev3/9MAiuc/M/rprcc3P6PNmkjq9asuay21Q4CrMOG2E0sAQ2zMY/tZAQZCcUbqtZJh94fMIkGBnF/pPt0dzvXEjDL5gP3wKxBuFJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgZCoOnHZATsQYnzsBa1FDCDXWeL2/cS6zDFGCgSotQ=;
 b=B6vUffjbslsg47SPHr4kahdU0JHfhGcvfCsRa1VEeALlIX7Q0qZaQVHXOJ13bjUHcH0jOJ1Wve/mBOIKTAn6tnif76PNj9x/xXxZIn7Oag8b8YOT+x11eSmnd9vDRW9XczzykAS2qECQAkyHhxUe01l5TmFPvL+TvjR6BKu4CvU=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 04:19:41 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::2d) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Tue, 28 May 2024 04:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:41 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:38 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 1/5] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Tue, 28 May 2024 04:19:22 +0000
Message-ID: <20240528041926.3989-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
References: <20240528041926.3989-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 230df140-dda7-4a68-f462-08dc7ecd6599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGZsdWdETGdYTlZqaHRXODdkUXhwVjllWTFKRzdTampMZSs5aEoyWWpDVjdO?=
 =?utf-8?B?VVhDbGhoMVYxQXIyRExaOU9XMUZJWXBYQVlvdzVheC8rLzQ0bnJFVmhiYWx1?=
 =?utf-8?B?TGJ4ZitEdG9BNnVXaUpIaG5EWmltNy9UK1lkajZBU1dBSmM1eGI1eEJxemJ0?=
 =?utf-8?B?Vnl4UE84aExjVE04eTg0bU5EUTRoN3FacUl3b1BhV0VocU5hRjVYTHBUcWFl?=
 =?utf-8?B?TmlqSHFDMUFocis0ZzFkMFhBN0pYRXdiV0t1Q3Z4QTZpMEVsR2xGQlgyV1N3?=
 =?utf-8?B?QkF4anhDNU4vLzZObnF4L3JvbFpBSngrUmxESkw4NXFzZm5BL1AzaVZVNTZx?=
 =?utf-8?B?OEZ2S2IxbFVUbG9mazNrdkUxRXduaUlNZzZjQTI5dkxRZ2s5Nk9vVmt0RkZp?=
 =?utf-8?B?TXRHQVVjcmpnYUdNQ2VpVE9qZnZIVThIVUVtTFlXZXJlbVZBOW5qTS9kYVRB?=
 =?utf-8?B?SDc0cERnTHlUQU95WCtEN3pyNms1SEpFd2lHaFN1MDVscHVHSFBxMVFzYXFK?=
 =?utf-8?B?NkVPdW1PNWpwUTNKb1RWdlhzVUJoTi9FLzFua0h1K2s1YnkzZUxFanVoNVlZ?=
 =?utf-8?B?WjRyZUhKL0R4ZVFoOUNzOUZZSm1lSytvOGVlQzhmdHJzSVp4SFdZdEhwTUln?=
 =?utf-8?B?V1FkOHViMFlSd3ZxOTZOaE5WbWlGdlJ3MkQ3ZVh2SUpSUkdualpZMnd3Uncy?=
 =?utf-8?B?KzhheTlZWjZ0ajdOblgzQUdaUWc5VmFWNFpvbFUvQ2h1d1I2dkJUOVhuR25M?=
 =?utf-8?B?d3hEYVhTRENxanFVdlVyYW5Gd01jbk9mT0hWNGJJZzFESjk0WHh3QzhBK0Jh?=
 =?utf-8?B?bXFYbmNYTmRPWCtlckswcTBHY0svWUI2ZVFnMFNIUzFnYlE3RFJRRzRxTUpo?=
 =?utf-8?B?Z1lRZjRjdGc4NUhSTHNMemMrQVBxYkJnVHJwQnNQakRGbi9GUFF0M29ZZVBR?=
 =?utf-8?B?NGxIdFZrbnQvKzFGeFQrejVDeWRYV1JMMXhhenlhci9IM1gvOFZZNzdHNHdl?=
 =?utf-8?B?bnp4QWlUenVUdXp5Ly9aUXZRSEZYeVM4Q0FnOTV4WVB0RG5YcmhaMmRUY0Rr?=
 =?utf-8?B?VytZOS9yLzJjMUFQL1VWcDNra21VYzBTSDNmbmc4OE4zM2RGMzFPVDVUcjRD?=
 =?utf-8?B?aGw1RWtQcGozOVZxclpMSFZmVjQzS2haMDVCOXBpS0VkRWlUYTRPL3EzS0dG?=
 =?utf-8?B?MVplWlNNVzgybHVPbmh6aW9tSHE3Slplc1RGZlMrZndUMlVaT0dmdVNYRWhV?=
 =?utf-8?B?dEFzckJmNmg4dEFWTVdIOTdET3pYRnJGR004SDdDY0pXcmYrT3RCSTBZTmNR?=
 =?utf-8?B?VEZ3S293dEoxVjJmVzBzVVZZUUVXL1BKd3YzSTREcWdrTkFKZXNEMTRWRjNC?=
 =?utf-8?B?cEVtM3JiWVNtNEFSRVhPdENFYnYvUGdzNzI0ajFsU1RtWmQ5cnZ4VGplM0lx?=
 =?utf-8?B?azJRdjdTVXhGSXNxTlRrUkFZYTdIc21zSU9WalRmWjFKdDgrMnQ3RzRWMCsz?=
 =?utf-8?B?OXcvbStUSnpxVjVpU2k5OHh1cEZtR2EyQXptTmdxcEhGcG9kbkFUOUNoRFVt?=
 =?utf-8?B?dktlVUdxRjIwUGluVjNMSlpONElkWDZsNDlucnBVdE15Nkg4SStHQzR4dFNn?=
 =?utf-8?B?cHhZSXlnUkR6d1A3UEVSSUlna3RPalRpa1A3OGlici9mOWVtM0hRNHB2UjNj?=
 =?utf-8?B?TGMzbzRLODhILzhzekx2QXdyUW5NV2lqS2I4MDVtUEJ1RTBySExiOGovd1Rv?=
 =?utf-8?B?ME1Hdm1MRVBqYVZabXYrZEJwY2hSY0Qvd2xySGdnV0p5U1ZLbEF0YjdzSUFV?=
 =?utf-8?B?V0dYWVhVY09zb1Q2d1pOZWdMNk1DS0g0MVhFaENUU2l0Z3N5ODloMWdYN0dt?=
 =?utf-8?Q?6uSK+vY8XNW7S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:41.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230df140-dda7-4a68-f462-08dc7ecd6599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

From: Manali Shukla <Manali.Shukla@amd.com>

The Idle HLT Intercept feature allows for the HLT instruction execution
by a vCPU to be intercepted by the hypervisor only if there are no
pending events (V_INTR and V_NMI) for the vCPU. When the vCPU is
expected to service the pending events (V_INTR and V_NMI), the Idle HLT
intercept won’t trigger. The feature allows the hypervisor to determine
if the vCPU is idle and reduces wasteful VMEXITs.

Presence of Idle HLT intercept feature for guests is indicated via CPUID
function 0x8000000A_EDX[30].

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a38f8f9ba657..a8c5dec042dc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -381,6 +381,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/

base-commit: d91a9cc16417b8247213a0144a1f0fd61dc855dd
-- 
2.34.1


