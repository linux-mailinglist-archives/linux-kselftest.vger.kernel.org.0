Return-Path: <linux-kselftest+bounces-13395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834992C2D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D41C20326
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6617B038;
	Tue,  9 Jul 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PG1nXvjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581B12C549;
	Tue,  9 Jul 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547536; cv=fail; b=G+19rP1QDJBeJiNfR1w/HnqE/1V02sLlDOqknoPY23bnr+4I9F+356QFeqvijDk2T9iTwkKlGA3G/NEV9QVKsgXGOt5Dh4xPllLjJmHipgCeYFN7DLgMUCInfUF2hwIsfbX+aybX+CGnH0wXvca5/AhugMYzKoEsiYkFB7BzD84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547536; c=relaxed/simple;
	bh=RYFeQXDq5a4SpSU18g8zrw7GB9/95GsOUebeeNtSDds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnrJaWr8t+NlUEoIKX8uwOUI+ld7vszbwjE3D/Om5IFq2Ra9+mM3cV5BXfp9AhUBnv4pvwEbnLU1JNDkcpP0Oaq3SAZhGxLAgbt1JosPNKa6rl4X4ePVyUbZjHQF8jhBgjN4B25BllaGmkeQi6X+W3wvkA2olknIrLBn2jVhDcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PG1nXvjp; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZciqU8uxkprvFHUYVogxxMYSFb2W6e2Zbj8qrU0QwvFtws3w74I0zujn/ccd1XYMJ7/wZEgq8ETnEm/ycQJjzgBbHYEm2bxFdZSGtp1H7rfXIsEMhZ3OFbnoOq3haEXnUvFqapgs6J138Qfts1HCBdAN1MKYyOg06erqppR/KrxpKiGCYKk+r82jzSRB1TIqEU6uv7t9EMopo23JG7MAU/42aAv3y9coc4JPLzcPwv7tKameNLhdpVIVsd9wq+R0tmJ8r8+GU40SLbiaeL42pUMqfmx1Fj90Krcy7soKktRXNQ6DdZr+Wf3kSsCWRfSao5ocuagDsXP2p2QPR8HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ3rU7EZMDgqEVm9Zq5kmPmAJI1fRrZ+n7OniIGLPoA=;
 b=e4lHtBv9bKM+rdx0+Sy3IPXJvdjrC+KHm686IaqBLy+WDVWzd3Vc5xE4Mgv1J+RtiOP2MwirxL5oq0SlaeOaylLELlZQpGgvHr9PYuAQhAuSQ+1aH+hNpNL/9v1CNQoqQlYVHQitsJP8l1r1TsFZoe0aNNSeQWAL2bQIsfP0VgFG3OwG6MeiOVT1XVoKGuLyK+vD9vZE2oS4GNC0bILydFncooz5mpi1WcFR0uMbbbEtZvp8U+Dry/JWHmXzEINe44DOANQFaOSX5oW5UnUTnEkIOy4ZT1t7yo7QgVihgEanMZdid4FeRkM9kUrYZia5s6XdaWeUuoRR1LOaLwHUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ3rU7EZMDgqEVm9Zq5kmPmAJI1fRrZ+n7OniIGLPoA=;
 b=PG1nXvjpQWLlUW1ERDYd3aj1xiQwyU4AIHSH0sraKoP2dDoWc4hp6SsUkmQu36uTdywhmax2OOoSugWlGZzcFf0Gr7Tcwrxjp+4UgQFhHLce1e+UYx1VRJ5iwKqo94q7bvUZoNPM3aLZl0hCKo2ZGLMFZVjnKVIpGmBs6UsSW24=
Received: from DM6PR10CA0008.namprd10.prod.outlook.com (2603:10b6:5:60::21) by
 IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 17:52:11 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::1e) by DM6PR10CA0008.outlook.office365.com
 (2603:10b6:5:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 17:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:52:11 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 12:52:08 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
Date: Tue, 9 Jul 2024 17:51:42 +0000
Message-ID: <20240709175145.9986-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709175145.9986-1-manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c5ddb7-e852-43ea-9998-08dca03fdbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vRFnvnChW07UAq6SSStoGe3qEgsy0HiqJsS7TUX9bbfz/gphUzH0Ds+XKqtC?=
 =?us-ascii?Q?3wcd2kh9V6YXLdBFWcXY9xELVk1lP3yVT9yOEJbbse9SmcAtVZRPzSS9mBMb?=
 =?us-ascii?Q?V17rkM59N2TBomTPb7L1SJJCKmCXlkVzEFuKD43ctQCBCyROyCimxDUMCWQA?=
 =?us-ascii?Q?m+AFXvr/mamgWOfte4QnlXo9uK3OfLzCV4azInKyZhfH1g3giGZ9jx0B15P2?=
 =?us-ascii?Q?6DOIPHZ7n2VOtwZxc0VLHuwA4SEVguBWeoZxvtshz0znSNmKvHQgvvR+zx+B?=
 =?us-ascii?Q?oXCaI5DvU8jN/FG2XvURVIazoZB5SoOJLCtu+Q0EATgpYnKgr/qNPv+xmPGT?=
 =?us-ascii?Q?bzRrZ7G2gIZ0rVJoZiFSdYowxn2jZgNkBlUqGA4BgFY0NUKhXqiAZrVg/Qbg?=
 =?us-ascii?Q?do83S1kJkBgdOLjyJA5+vbjKqPXlWDmDjM2aElQ/lNVTa6C69ueslfCxt36d?=
 =?us-ascii?Q?d8RZ8Pp97v2JB3j07iprXxWiuRe0pqycYKR5WH8zGrpz6J9Lg8y//HzDW998?=
 =?us-ascii?Q?91YblvitsYDoO8lj6Pdnvw6BkMOdDWG7dVhBZ4inKcJDd7DifQV37GgNgT2g?=
 =?us-ascii?Q?/E3Bp9i+Fg22+ym1qKc0ng0hYyR/QHA9ji8fR0F9eVmit5FmfUC298KG4zke?=
 =?us-ascii?Q?m9MWzJ9D0WXw6lJye9RbCjPMN6w6fPYWCeglzyjlKZYZi0BGfSJpLedPVzYv?=
 =?us-ascii?Q?+HGhTqaH89Stoz4p9RX8wW2Kod/TG/i6aopgnWUTk89mH78WEa8EaAQ387ut?=
 =?us-ascii?Q?jXfV6F0wUA5Nq4eY4LDitSBQMN6dYW2LN9Yzndm7ziOVAkMhGnm28+1zOHyW?=
 =?us-ascii?Q?h5NcGD9f0AXa5WSLWRndEwyu82PaghaUlaEtA2ALT0opC4jZhQhGX6R38ziP?=
 =?us-ascii?Q?H3ig7r7rXaA7XfIH1qE4ZsE2BPUdps7ySnDljlLTUyVW0mMcat5s94wX044U?=
 =?us-ascii?Q?8+PYpNZxHRQvRRXAp8q9ECDfpKEMB1BwQVl9eaE0vGZY1AUwyxiRalOffo0H?=
 =?us-ascii?Q?a1YZHZnpnoQEK4wYCNiIEA5kaWYrpHdi3P1ix70VdOrT9UdhramcEeDgGrw/?=
 =?us-ascii?Q?UkOqFBzKmbj2h/dWqjU83Clf+iHVyTIlqQVaRybjsTFkRoTExngTHdeoXCEN?=
 =?us-ascii?Q?3hVsK/IMAq3KVAkwd9hOP8AlkUKw+NoCC7vrR18ay2qVN8QciVA67HbkIvSg?=
 =?us-ascii?Q?NmW+rdUCxMe2n5mX0oze5uUHcgc6HZ5q2WV+pnXlTjG/A5A5xjarlySw80BR?=
 =?us-ascii?Q?2Xe5eN+Yy06n04BwmAdFLjlV4wnS/1nQMkICuT2jhOrQsEWU3av+xtqWf1iI?=
 =?us-ascii?Q?6oBq4aCixkv8SJYmutS44RWAUETrm4WTrUnu/WxacsOURbjU/jRTwGuh3hBA?=
 =?us-ascii?Q?WdD2ObmA40LZPsSfkkeUk5X++RRBk2iQ0On/vdZSSHn0+eA8YBh9dlUY7Lc6?=
 =?us-ascii?Q?mtAqYHZ9lmn69RZrzyDNAiEZHMeHkd+9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:11.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c5ddb7-e852-43ea-9998-08dca03fdbf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

Malicious guests can cause bus locks to degrade the performance of
a system. Non-WB(write-back) and misaligned locked
RMW(read-modify-write) instructions are referred to as "bus locks" and
require system wide synchronization among all processors to guarantee
atomicity.  The bus locks may incur significant performance penalties
for all processors in the system.

The Bus Lock Threshold feature proves beneficial for hypervisors
seeking to restrict guests' ability to initiate numerous bus locks,
thereby preventing system slowdowns that affect all tenants.

Presence of the Bus Lock threshold feature is indicated via CPUID
function 0x8000000A_EDX[29]

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..10f397873790 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -381,6 +381,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
+#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "" Bus lock threshold */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/

base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2
-- 
2.34.1


