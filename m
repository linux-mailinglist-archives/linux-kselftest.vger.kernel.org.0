Return-Path: <linux-kselftest+bounces-9211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614868B8C33
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25301F22024
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398D12F586;
	Wed,  1 May 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFrmTerO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534812EBDB;
	Wed,  1 May 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575323; cv=fail; b=pdtKOJTTqW6WZPLXxomQQCnmBRXWKptjGNDGFVGGSy53aySwSfLT8OY1GRYJCJdoZoOVamwrMb9O9wVu05GanYO0YdBxlVnpQj8WnylmHxIDZmT9EN10Dagxmm1rczGjLgSGE1FsK064Ssdwfi9qelVj/EUjVrUAiuVSWH5WcGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575323; c=relaxed/simple;
	bh=yhiOSw02sfQ+2JEXPUMkAiQwnhoeWSZYG3qgCOMVQqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Chq3a7Hf2dRu0EqWxLy9j8JK3eXlITneoosT1NCC9CnccYcWHA2mzmVmE38Q3jsnbEme/89ItOiytca/Heg+WjZI+z+NWmpNL1ough7UmY2t41wvTYJ3i13Q3OSegdL8A0i9JNc9Ao7YwQSqqhAaIoDGgaNtkiQv1TJMkFwF6io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFrmTerO; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+56munmoc5yOfAPDZZKzeU0uKsMyW72UfrVsv68wTHYxyYRsw22/rp2NjD0KtdPZ/h8XUCLQ1On5AtF084kWesRG3IES652ZqBhJpYeDGH6lT5bGt8HWPY5r+TWDtC8DoCNYNQIp8FYORAEYickdlM3MM52RCRDlxtjh5gGGTJPFUQmqtJtRxmdsB7hdaGB4s9a09hwANWWsBYe0VOagfcZTLLcJb7NpYyx8xpWYbd8l8wy+dj/4e4k7UEEPGlnLpWTxg/ymafMCEuPcHKdMILv8D8si6L2C8V9t7z5vq+Lghgsk/7uUksRVBX+wP/E6pPiubV2lVOp9hJIZNKuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLiqfplFvQsiftF6GTviacnEqj4GbmvWGeDw4ye3uhc=;
 b=HD0VCxvciCPgX8DSvqIPKOu3gvvjGXZW8OtsKtqY4QrMWo41oNzhwAFXagyL6ZemaveI13xBhARBKTX4CSRULZ+Dacf1SVF2oIfwaCJwWxqYaOOTLuYxO0shrTPK2WALKN7it8f+FXcREOqkGd71qbGTEfRnyzt7eTMRXYMFLXVoVvI5rPfAo2gTr+G2AYbEhTGyWstf/izBGpKzDerUJUH5YGHg8quC9cQMYG4xIP57s97a07TcGcEFmWdLHr3MNYl12jOZtwGYIi/Ifs4ee6zuCCuwy8y2ojny5cjF/X5PKPInsgnJSaPsXpITpheKd2TfGIvF0hvBRs+nTqhuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLiqfplFvQsiftF6GTviacnEqj4GbmvWGeDw4ye3uhc=;
 b=vFrmTerO8WE9hfZi0vGOrJtx+n5wsnxT1OkWpL94qyCtQc4WkC450OTtKJE1YKuhK4Ee5NQkEhIbgsy+XzFsFsB9CKxGNHeknabnSE1Hc0Is/kv1tgZWcu630r/+cOMP+giJ0P+JNnAjwUZWRsESrZGntD4lbHvQyc7W6Ricz8M=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 14:55:15 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::96) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:15 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:14 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 1/5] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Wed, 1 May 2024 14:54:29 +0000
Message-ID: <20240501145433.4070-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501145433.4070-1-manali.shukla@amd.com>
References: <20240501145433.4070-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: ac22a883-aedb-479e-f196-08dc69eeb5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWx2R2RQOGR2T2pMaUlBOGhjTXBXQm1GSy9sYlFmOExHK3MwYXNySHVoZXY0?=
 =?utf-8?B?eTN4cnc1eGh1czZPeTlCcGh5Q1FEdm1MVHEzNHpkZE9LUm1KUVQwMDl6UkpS?=
 =?utf-8?B?NWhsTzRnOGY3MlA2c1loZ2NNOXp0M2I5eGp0TnIycE5hL0xmWk8reUNLTG9p?=
 =?utf-8?B?ZTBDaFMycGFZRkREMnY0cHR3Q1BMSVk5UlI0d2VpYUFLYUtSSjB6bUVKd3hD?=
 =?utf-8?B?WUo5cEJieFlqUGkrL3Q4WENENmkwQXZCczY0eFQ5eWxqR1E1RWUrWG5ETFJp?=
 =?utf-8?B?WDk3ZmQzUXVIaERrckk4UWdPODBzVjQ2TkhMNmpvUm9VQXlzTi9CWTVNVTBa?=
 =?utf-8?B?NGVwbzBudXNXMVlSOWlJNWpTd1FrZVgwOHlCb0crVzZRRDhLUmZWT0tBdGdJ?=
 =?utf-8?B?MVdUSXFXUE0wZVp1bFVVSlpqS1R4cUEyREhZWURKZmRvVEptcmt6d1Rha0Vt?=
 =?utf-8?B?ck05VXB4RzdBaTFvcHNYZlJWS0FEN2ZEZFJXZEJJeWFqekVONXhpbW5Tdm5F?=
 =?utf-8?B?YjVZbExBc0M5QThGSlU3dkpwL0JHTExBUXhjaGFJMUE4ZWw3eW5hc0dPb1JT?=
 =?utf-8?B?WkxRYzZ2WkxBU3RnclpHeGNpZW94cVFHdnIydjlYeHNpNW5lZDdSQ1NLOVQ1?=
 =?utf-8?B?alpFWU9SRmRoYjRZTGRvN0dqTUMxaFBwb3V1Ly81RDljSGNNQ0dDOFJLbnlr?=
 =?utf-8?B?amNSQzBIME1Hb2RscjNzYXFnOVhlb1gxMzJMcVAzU201cUd3M3pRZURxbFVX?=
 =?utf-8?B?dDdVM1RWcWl2dXRLcnNBOUhoWDh3WVRNSFcvaVBCSzE3dXNGSDQ1YjJzZVlM?=
 =?utf-8?B?YStqV3UrK2RJT3diTlJNY1FyT1FxQ1JmRlZlYlBVUllKNjRWYmNnaGszelFW?=
 =?utf-8?B?bGMzTVVSbFlBOWt6UXVabzF1SjlLMTZPQUREUVR1QWlzblEwdXNsNVFpeFcx?=
 =?utf-8?B?UUxZRGVtS2dnWFBVSysvcW9CRmY5TkdrbjZDY0VCenZGeE9ZODlVazVnVTRn?=
 =?utf-8?B?Wi9FdjhUSkdtTlM0NjYzaCtiUDc4c0YvRUhWRHpwSHRadXM5QWI0cVZoTEhU?=
 =?utf-8?B?MkJSSFJxU0JWQ2VSZlhHSFVKbDh1aFlrWERXVldqVGMxWmZYc2hlVVJubWlt?=
 =?utf-8?B?RTZjRlRJY0V1Ykdjd0t4b2svVXlkeEJQUmQrM29lYUFtN3YxNHNDNnN0dmFR?=
 =?utf-8?B?bW5Ibml0SVhxb3NWL0gvVE0rdkdVdCs0eG93ZHVHWWdSWGZzTElJbkU0b3pV?=
 =?utf-8?B?RWxuVUQrcitpVWZOSTBVdHhxWmhZNElzRDFUSGg0b0RKUk1QVnhoZ01tbE5W?=
 =?utf-8?B?MkUrZzdxeEhiTkMrOElvVnRBQXJjclZyZGdLWmdORkJndmJ5M0QxWmhIWC95?=
 =?utf-8?B?RThkV292cnNjeVJWQXorT3lFb1BPQys5d1l0VlZrSTNVU2dWeldrc3FCNUhJ?=
 =?utf-8?B?OTJpMS9mckhSaUpCUHluUDMxbXRnRkl3bHpwTmdYRng2Z2d1cVlhWlc2YUxM?=
 =?utf-8?B?ZUhGOGhXd2hXVkdzL21TSVNBRGREQkRKY3hsRG5rcGhqTkFtU2FXNVVKc1Nk?=
 =?utf-8?B?S2gzQnBNbWNid2tOL2g1RnNVKzZsNFZYbEZFSUZYQXRtSWNTVkdiaVJiRFI3?=
 =?utf-8?B?bkRmM0RNUENjeDBTcUxBeGd6VEI4WGw1VjVyMDVyZHYzbFJYTjdPVHdOWEJs?=
 =?utf-8?B?ZUdEK25qaURmZzNPY2JGUEs2RWR6Zy9WYWZWZE5tNnlFRHUxVGU1U2h2eTZS?=
 =?utf-8?B?dUhvRCtPNnJDMmpmS0EzWXhOZ3o3aXRRWkw0VzBqQytCM1Y2YXpITzhRUXBO?=
 =?utf-8?B?b2tMSXpYWTJTVVo5TFArOGNpb2VjVnEvSjY3MFhvc1RsZnl5dis2YnRJOGFp?=
 =?utf-8?Q?0Do5d4oiatX0F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:15.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac22a883-aedb-479e-f196-08dc69eeb5ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

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

base-commit: 2489e6c9ebb57d6d0e98936479b5f586201379c7
-- 
2.34.1


