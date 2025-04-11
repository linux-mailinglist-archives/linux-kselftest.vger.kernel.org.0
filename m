Return-Path: <linux-kselftest+bounces-30596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A2A85D4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7321E9A0E33
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA82BF3D5;
	Fri, 11 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QFZuXANg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="l/1+Zs/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE792BE7DF;
	Fri, 11 Apr 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375012; cv=fail; b=gs5Mq8EMhbv3i1MOjcHtQRVU9qqflB69+vuAsTd9GqOO/ExpS919hjmimgH+kyA53EeYEgA0Dauw7DVFYNDeGGuDEqt27dkZAHbyK3D3Z23ebVPSMATFdLSqDIYpmymsobOUc1Ke6BAmUDMM+lT+lkJYsWHbR1FGKqw9Cd2mW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375012; c=relaxed/simple;
	bh=Z7PFJImfNMsgR0AUuqeyefat9cVtKP8QeWlAiJpYXA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWCY3aFzFzDVNUnCvaO3jFVTE8Ndxa99tTO16U4K3p3izG1BYsh3d6zRbCkHFtXqls8WvsNRWyWXhLOsc3nUYcsNNxd+brhoSrz5CsZcTKYwneR//pRxTLGE1ob3quKUhqMhZCoYEQV9N6NTqHdQZLUExtLMFSX2O420Mhuj2yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QFZuXANg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=l/1+Zs/S; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9pLBb022297;
	Fri, 11 Apr 2025 07:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1UrBHASLBqxzM8RhWWXux+B5TqxPPD+emGVd5gyQmzk=; b=
	QFZuXANgEUpwdYM4KieX303o8RCN/0MVAN2uh2/Ypze7jmLhm4coyv2lec4NnVnM
	xI47E2Ez6RbeotDiIzg2KqRPJQdECF6AhNrt69uNxhfd4EmgYnBd4HdIMH5j0Fky
	ZX+HdQaowypiT/qpXyAZpwnHbabmfGdUnYzpqMFpRqaLa4Kbc7my5KUN9dTHFSP8
	EJmSt0pRzQ2ofTmVhyJGUo2v32UG3VaHhe4qk9952UPC6mNQQsqF2HjL52Qa4n2h
	Yn0TJbKbsH8Smfl9ffD2cyuZDTah1bmiEwakRFVI351C7BDhAKR8SWbNeP/2rR3Y
	HNmUKTsu85pq6DUtFd39YQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45wf0gutyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:36:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9Hx9xFHJQF6Z5UM8deRKM7P2mh+pjxqkMAHDo8BX8ZziYNBmAOyA+HMKpOzQKCsOpCNCVIaDCJdTd5ZBoI1eVJlpBJxwQUGsLL+klVkJHolHiBOaRWyovKS4tQO/Vs2ulAU0R/XDcA3eFi+FVJYz4oAoRC6uXgEChLylbeEcRg2+HVj3/Gdg2FMrN1MXmt5FcMGDaPVpHQoIVaw9Hdo9Ws69K14hOTngiUdWketfT5PtBm1H+hpxKgD0XEHRuknPSiK9ViCsdMBn9suPQgpVfkcOC3z34BRulqI63a/Pl6FPNXeipElHSQ9tKqGUouqOU7612SsdSeCwYpRj42Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UrBHASLBqxzM8RhWWXux+B5TqxPPD+emGVd5gyQmzk=;
 b=MKTCRJIe7L0wxJxNS3J79TaXm5nupqQvwWLZ8MsLrSYqc384nQRes9IRvPIJrUI+7ks9n/DhzYVn2XQ0MwHpH2lMKMSIH0CMGik2SyL0mwZ7k9an6KKDlHoeeNamGwvpdk5E8Op2COiOne+At9nQTcR3JBd2W7RBYgo4Va+XXeZJb7J4SnuzHKuS4/+HIvEFpbvkH1lfMzIySmhD021vOyAfr2HIMzY+7F+VQ+Eo4+qHfPFcaMrhL2mBtIJ0HvvMOwB0XSrCZM1Nl0ofTkaCLy0GWY2meM7mnFILSLRLQtqv6dY+wZBgLaISq27qiJJ5iHg3A5cHmIQ5eTT3OL3Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UrBHASLBqxzM8RhWWXux+B5TqxPPD+emGVd5gyQmzk=;
 b=l/1+Zs/SKVT3RJPiIHAZUYmLfXqL4nVgtUALq0BNU40k+o1oyj7nlwg/CMWZddc0fVpE5rQDd92poeAqe5VlL+0c2I1ILT8TA59ICPjRvtsEaXLilkIQE5KYizabUSRKTcOXe1iT6Sww1zrr9mH9gLFU2tJB7DY3pcW7LBgZnYw=
Received: from CH2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:610:4d::27)
 by CH2PR19MB4120.namprd19.prod.outlook.com (2603:10b6:610:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 12:36:11 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::3a) by CH2PR19CA0017.outlook.office365.com
 (2603:10b6:610:4d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 12:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 12:36:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 52847406542;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3DD1382025A;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
        rmoar@google.com, npache@redhat.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 1/3] kunit: configs: Add some Cirrus Logic modules to all_tests
Date: Fri, 11 Apr 2025 13:36:06 +0100
Message-Id: <20250411123608.1676462-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411123608.1676462-1-rf@opensource.cirrus.com>
References: <20250411123608.1676462-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH2PR19MB4120:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ba72ed0-7f8d-4e8b-ac21-08dd78f57007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9t8hNfl2lJG0ltfLmsNNdrgPB7tV4zMJ0sxFo2lUIKD9XfAGmwKsQQxdVKX?=
 =?us-ascii?Q?1E/Zdro7yw9G+MJB3AaRvpRubOdbpCMlZVVkkOZQcUpWXOfvxfrwA5x6EZ48?=
 =?us-ascii?Q?6f9DWaS07CVmhNn/BR/9I8mHCTJ026l0AgngNo41xH9o/Dkyxxt2xoVFbk8K?=
 =?us-ascii?Q?dJB/8a3q+FjXZZVuWUa0a5xABOr/E6G808lu8KzYfatES46IJllG6Ukkzh0V?=
 =?us-ascii?Q?mePR4VcIiLAwMxAOZyq5rQnD4DUNur1ls+szOMTSo8qMsNpym+rdurHrazzm?=
 =?us-ascii?Q?epAKpjPsHxSQVlxDFnKfU72yqn4PebCpa1IkyFOYC6Be5jXB2/hxsZyDS6Gf?=
 =?us-ascii?Q?gDjwrTfcKNMIVPDNplFGhv75hx3awiiSlAsoUQza1ikfxwx9KNYbpa50ezCn?=
 =?us-ascii?Q?MGM0KVql+r+wUwNIQz/pdL3gClOteiTOEuA8iPdm+4eWogYsVH183hKky5ZO?=
 =?us-ascii?Q?4zGlYjTXf1TPG354w6FQUmW8S/C7ZR6hD7La332zU+sqg1ilCOoYubW2dBcH?=
 =?us-ascii?Q?wUmzNsjE8NypuVswQQMbqIKSl3xgF/p0EUH8u65LBP/YAr/50wlscAI8WpIj?=
 =?us-ascii?Q?eN4f83CwmAoYtTOnqCRgzVVwOk1gI/JIsEEjGxxESLCe03lt03inkCwXahKA?=
 =?us-ascii?Q?OZ3hn1MnK8k2M9/4xYwvQwH1Jic1IGYVTh2XPPxHswbY/YLGH6m9G0w6lDH5?=
 =?us-ascii?Q?g15zPniq/B0CB2fztE+8xaCRduIB7xpuOLzGI+wyDDV+AXop4OlIsopyP16B?=
 =?us-ascii?Q?/2rhXWu271FilrSjGoBjRP2xehCMyT6E2iBcJY1jfATptKfq/lMovjHEtsoF?=
 =?us-ascii?Q?svsXhI4iV9eopVkA0kEkP6npsajGnk4zMkSpOFX03iC566I/JFXG2fSKhQGm?=
 =?us-ascii?Q?xnhMJjr4xS3mBt0Hs1VtmzqD86EazYIhOOAVPdXHCQOkWZdph6t41YS9p0Yx?=
 =?us-ascii?Q?nvni+FIcWjBhjPvTk7ugEp/iuE1q+jDhvnFSzcjL2k8v/KngD2LmaTQq/vHP?=
 =?us-ascii?Q?dJBp8qrAjph9NPQ8UubBbkJeyV58aA6P+XxbfQih2giGqNurwp7YDgjE+Q00?=
 =?us-ascii?Q?z2W3oWNPProJoGbtqILmW83aBD1VY376rX46ojCyJ2Vx1W/2Ey0D8Pd+uc/c?=
 =?us-ascii?Q?yj6a3HmWRzQxE0uNaMNOx9cgRuA3qpZVRn3X8YnU6UqBJ2BSd/b5z+IK7MpW?=
 =?us-ascii?Q?LX4vYAwLudCMCC1vTZFeWTeYPchKOPDaJNSeXHQ58q+S0TCnszh6zF31wKs8?=
 =?us-ascii?Q?o1Ac8FS7YCyz/7EKW7OwIzEQmbmmkkZ/0f36pZTWFtXWJEoB05ED3pywC2YL?=
 =?us-ascii?Q?X+a8M844AOuaTNlMETxHTbtcv7lPjJ//AkjNUwSBMm24pX/tX0v+IWL5LjMI?=
 =?us-ascii?Q?BvUpiRlxrnTHjoTZac9Fb06jlsxppc0Hl/3xpi3OQqJXPK7DYtfpyYT6Ky6T?=
 =?us-ascii?Q?SnbC6MmLzAJwfYwxlgJgzfcBXab8P38S9IwtDiQD72Zr/ry42yHaqjXnXNkx?=
 =?us-ascii?Q?9EkiKcyxMLnYIeU0VRSN4lHKJ18i9GwFsRlF?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:36:09.5850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba72ed0-7f8d-4e8b-ac21-08dd78f57007
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4120
X-Proofpoint-ORIG-GUID: o1yKg7Ia_CoucwzUMe3T89fS-FOgY3Pc
X-Proofpoint-GUID: o1yKg7Ia_CoucwzUMe3T89fS-FOgY3Pc
X-Authority-Analysis: v=2.4 cv=A71sP7WG c=1 sm=1 tr=0 ts=67f90cc0 cx=c_pps a=AHWEOuZXH7ukEk4XErmcRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=w-sTTJ3WBIU5oXKZYMYA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

Add CONFIG_I2C and CONFIG_SND_SOC_CS35L56_I2C to all_tests.config
so that Cirrus Logic modules with KUnit tests will be built.

The CS35L56 driver doesn't currently have any KUnit tests itself,
but it enables two other libraries that have KUnit tests:
cs_dsp and cs-amp-lib.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 4a60bb71fe72..4ce38c4f697f 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -21,6 +21,7 @@ CONFIG_VFAT_FS=y
 
 CONFIG_PCI=y
 CONFIG_USB4=y
+CONFIG_I2C=y
 
 CONFIG_NET=y
 CONFIG_MCTP=y
@@ -52,3 +53,4 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TOPOLOGY_BUILD=y
+CONFIG_SND_SOC_CS35L56_I2C=y
-- 
2.39.5


