Return-Path: <linux-kselftest+bounces-27850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63048A49585
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F057A7AB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD522580EE;
	Fri, 28 Feb 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCiF6RDk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C301F30A2;
	Fri, 28 Feb 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735703; cv=fail; b=JotGaq4z/K9cvIcdBPA3YXMKZDWzGNA4fqVxzDQmPItEP8cvyox6QZCDKun96xaK9SvUZGvWMIeuVg0d+3k7HtYF0HAtLIHeZ7/rjlZCbT/jl6XQushPGeA2Vo5CtqCLfddEVCNqYb2YyWGygFK4cOYilASHXEXHXsUwJPHr+4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735703; c=relaxed/simple;
	bh=dNjXxv3BO7f11ZaZeBBWY+yuLZ/Xtb00ia7/yhpafXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8YiSKCEqrl3H9+kui8SZoJyirpvPsJ0jde/fcyd7xec68JxqFyEZiyalNMiZW/hO2aMjXcZiqo4AT+B4fD20KfGG+vU3jT9ws9475tVKMap08EqbWlyZY8QD3aQ4QUaU5sp3Ib8pUSOb95QFtRJLFOLEZ0b3cPMJBp7MnIGxZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCiF6RDk; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ5wrnj6GBSJ8+aw9la8bqJ12VOrPhbKxhmOG/zbRS5KMStAGUmIE6+mmi4JnO43lhqTQxyuGPRmxzvIbFCE4RUzX+4vnOVd8cS1ErX4pTR9WNPu9AFGE91Zptjkji7o9bUEKhcvVR9XuHNBGCgosY3+afLxChADfynHM38AzJnWMhL9jP8XdrAbOMVTSKD6Y985m4n0NjUiX6smqhjry6nW7y61wZgvR3qEK6Q0SkMtOyAUFC9Wet1bKxTk1YrNGIyPThn0nbeqqSS4BPw4kf8YcSpZZCDVFUcZdRcq9gA41HsJhMx3riSkZe1Aaeq9icZBbTfnQu4EZLPbh1i/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QeGIWIgArPXOI/rlX9Uo1GEIGOqE6uyjaNnc9riVss=;
 b=ppqnV37HevuI6xHd6vfNeLPImxerbXAB+CGac68cwp2fnUNpms8X/YIlZ2DTTYSKnSvK+as6oIRoUKR98iZ5dKHrnd+LrP191oqDgs93OdEpz2jMeF4QkjIwiargfZRatkbhjE6LH9+MRxPxArHxA8728Ah9aGtcn0LkyNxblzvivldTafb1nGoW8RdlKBdAKJRwS9Uly8+Yc1WY0dSn7VsJNkiWv85Kj3qwmGApjA1sl0rOhYdUgSAWEzVPEySrnibUGsF+GtRBp4oiqP1o1N059qDWjCf7h3Ie/1EACdHTKcOSeGWqv5BH3hl+16xT+adjuE3YJRAbUF3l61N9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QeGIWIgArPXOI/rlX9Uo1GEIGOqE6uyjaNnc9riVss=;
 b=UCiF6RDk9KeE4mVtMbj3MY717RQqq/Avk1WJFfSUFAhqiqfCxVCWhdAMWV4tEhikipfBFd+2M+ARLK3Zum+qom69Q5WqLCnSDptSM5GvuRMW00wYlZgnsxctYAsB6EwQm81HUyuvqSbuIuJz2ngpOaXAtFBIPY/VsXmCsuz/GaA=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:41:39 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::7e) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:41:39 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:41:34 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 08/31] KVM: selftests: Make GHCB entry page size aligned
Date: Fri, 28 Feb 2025 15:00:01 +0530
Message-ID: <20250228093024.114983-9-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: d78b2514-efe2-4647-120a-08dd57dc19b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xris8klAUIpoQGF7xdOmw0Ck670gXtzhci+BISC1HVroOvKx8I5eCcz5IOY/?=
 =?us-ascii?Q?A/k66vBI00VtrYEuOJTMuFEkaDGxOMGwiWFGGUbB1SY0Ig7EcikJRwoFn1RI?=
 =?us-ascii?Q?r7OTpKrDf34Y4l+ZGl+JMQNKPC7cqJYnYEvwCis3KBcAdhcu6cnDalGrS3ei?=
 =?us-ascii?Q?BvjJpfxau/z9EJDBnkiNtxQFzwHnkmBITfXW+3mffDncHs7MtvnijEi5fh+7?=
 =?us-ascii?Q?1yHrKjmiPXt3grrl5+Kfd5UI/tACl/07PVmt1FuyYwN9woKtP3QtRKKrJgho?=
 =?us-ascii?Q?cJw8NoPwQETvr0+x+O1j3hwARTF2HkNKx+GMOENjTYPyyFbua+RvyuYIG/b5?=
 =?us-ascii?Q?Qu1R2ymoHSp50bfeC3Cacxk3wHG/24GioZCT3NB9j0MFkuVbAR8bwpA0SpY9?=
 =?us-ascii?Q?jnO2TAWxyUPrBuR7HyMAQmPXrCZLIq1bRWofqHdboOxwCJOEkmXEu+5Apn3L?=
 =?us-ascii?Q?3FV/S6BnH8AlMNEsRCrbaXer84L/YsbLjp1M26m0CwxzrD3kSaTdFZXMa2oN?=
 =?us-ascii?Q?iA+GHVMuYO9CX3jLtHweF1TSlX8rDu4/XHtuOLb4yZFmI+ivtKuH683y7p6/?=
 =?us-ascii?Q?Gf2mfzq8flc4bXUKwKhwjPzJOAeX1NU5PliYdUGMGGCzv5eU2w3iYw4ZpF9S?=
 =?us-ascii?Q?TyR74+zNRwInhP8w37FuQqb+Vmeku/pLq4zfw+m0v+T8sxd49UcJjJI8s+0Q?=
 =?us-ascii?Q?hDe7J16YR9mCifIyBMjpI6T4huPkMGL5ls0Py00pB9K05ttwSBmA/gqaZn3P?=
 =?us-ascii?Q?LS3c8Nzqd224ceKeUiZhf+HFOTY9FBG4myY+f4Pe2HSoPqborpVXVvC9uBi+?=
 =?us-ascii?Q?3QoHtJo3+3Z0Vzpmc5HZbw2Rugx7Pd8tyENtq1BkfM8s3o38OXWlOWUKpTv7?=
 =?us-ascii?Q?xnF8gS8Yzsd22TPo2LzUNID+uStkuxXsM7LHVNDnD2BpPYRn0BCRhc8yj1mm?=
 =?us-ascii?Q?tNBOo7LKu0GmgVhDL99ullaPK6KFL7w45ANlTGWgkrO2Vk4XRk40/P6XLACx?=
 =?us-ascii?Q?X9PVBL74qlRgT/yTj5uXUMpO/LyZKshr4yLsuSLaHS8ByJGeJmQ9t8/c7Wnl?=
 =?us-ascii?Q?FB8dLbXGT0liv2h0HWbvyq2a3N0tNfdQXnKJ9uGqNJDuEw/M5tZqTcfxLGi1?=
 =?us-ascii?Q?ydwdKQr/k60t9A23P2XkHphm7nAig8SbgjXhR559p5fKFjbCh0zMMBX2xjDK?=
 =?us-ascii?Q?oWKmpjY3vxrW0iUFBqB4EqRvP0GD426OzOQ/WATY3/g9bSBmwpIHzWyhQ7LY?=
 =?us-ascii?Q?HIf9bPyMPOYPSye34F+CAWiqSDfAuBYD8ElOP2AsiFZcx+0OJsrr7xOQ1jTJ?=
 =?us-ascii?Q?gYF5rW6YHKkKQcqSgagEM3x4RiRaAtP5BazyiCvnDJGS5NM9q5wD5n1lNzdp?=
 =?us-ascii?Q?kWUVYlqA9Tw5GUx8AqKOsuD0Y0b8PvPRuMOuAa6JvzaN56tX6SRjQMOlkIbr?=
 =?us-ascii?Q?3AAaKzwn/kpLBZ8/L8dtKI+oXrhd9/1Ye+ZwdJnVMKI9LMPG6RV8FUZpOuSE?=
 =?us-ascii?Q?G1cqcu1uUWXG4dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:41:39.1325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b2514-efe2-4647-120a-08dd57dc19b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478

Make GHCB entry page size aligned. Without this change
GHCB GPA registration gets incorrectly interpreted in
host as a GHCB MSR protocol request.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 228c446072a8..38813f60c252 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -22,7 +22,7 @@ struct ghcb_entry {
 
 	/* Host virtual address of this struct. */
 	struct ghcb_entry *hva;
-};
+} __attribute__((__aligned__(PAGE_SIZE)));
 
 struct ghcb_header {
 	struct ghcb_entry ghcbs[KVM_MAX_VCPUS];
-- 
2.34.1


