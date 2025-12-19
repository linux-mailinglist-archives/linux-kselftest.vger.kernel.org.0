Return-Path: <linux-kselftest+bounces-47738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB5CD0D9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 279A4300DB86
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F637C11B;
	Fri, 19 Dec 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P4pugAqx";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Bih/C2pR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6E37A3EF;
	Fri, 19 Dec 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160792; cv=fail; b=F5P8sJB9LMek4pZLNc3JEomAK8vaJyPW2j6vZhc30lEEI8vnPPWogPnCFfP+IZLxGRC2C+WnVy25w4QiX/g27BjR/XPMeYqAnUqoxS0Q9tZx5O0W9o9EySK7tUclzzVS7HoxQ5VwhTRZhDimmRb1k1y/MtmqlkpAnePYQbCACfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160792; c=relaxed/simple;
	bh=VJG1mrmoCxHn16e/bcaac7I+41En6wi7jXAugF9uzpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3gWUhMI/AMRZuU79P27LpsUNcv9D2FWedPvNr3MzcesmozCpBqO8UvYJEiVjYQGbFmROOuzMB8Uq6LQLOAM2Xc3qFh6S4eHfKAQCEQH1Tmb4JUs3iopDA0AOJYjZ3fnMHBQXO4YO0g4g36VVyxuBkp2vtSsIaEuIvwumhVH7SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P4pugAqx; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Bih/C2pR; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJEgGnb414839;
	Fri, 19 Dec 2025 10:12:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=IEgw39MAo4AqKgba
	/aSiFY9kKrCdD52c+gmyGCp+FTI=; b=P4pugAqxpJek+R9uN1iFxw9AmwMlUL5b
	iafJr+Nz2lUQy55yFcoKB2LYfOWm2nIDe/a3Vg96xC3ctEam5UKIYwtqulzRucuK
	rJYzqMmR/oiWk0tkxFplybYe+eU5DJ0pEA+JC3uXWV8WF9InpMKgbrWHqV5vABTy
	vMG08C+PIGaygs7Oh5ATOEoMYzCr3O3dB+8USLZe/YReAi9FPzyWwhuKFINl/4vU
	w1CmhRmTVz5095uswxM83hc9SMKGhK7xWA7AwkZrhJTBn6xrQABsfF6YNXH3BFSB
	Wl+qzM+zDGR0/dxFvQoTf/nHkmG6YgR8JdiVekyoKl9/eZwO1+nOEA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023139.outbound.protection.outlook.com [40.93.201.139])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4b4x2x8njm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 10:12:18 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woMI6/BHlCFRMmS58C3nkn/bkmn8vigOGK+IXJJStXrWU/t9mYzzXu5fDOeiDAaHUDmUsRk83EjfawhEjyGNDgJYsiXC4ey7J2+HmnNIoCRdJnURlJSdQ7rOJ8kjEagaDWZaG963iTgox9MdjuOQH3dfoMtHvDUqWQvbNrPxziR0a/e24bL2OvaA51kMo+63VEMXIoHy3nePbPU2VosyhLPxWpe+zR+9EeIq6pCo21aZzDj/ZrIKN6PpO8APZEPx97OTmdHWXWCWUe3XB8kbBqxQucb+4485sqnYCNsQGAPgxXFiCXjXCLbWsdikiiiFBndWz/lfQ2VELAD19VGXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEgw39MAo4AqKgba/aSiFY9kKrCdD52c+gmyGCp+FTI=;
 b=A0q4+MARP9MxQXcq+qHNppk764n3huv/c5s+5HmsM4fLIheAxhcR+75wtVSasLdJT+Sm6kxofqZ4TJbH+6Yq/8Lxu5gJF3TaKhNiE9Fcy0bcPhGeZ9vpucRwTjO+9LcVsHnz/9MIxYLJtsL+sSzy6CUO8HY58gas1GAnppo4xdAXtgbCsAevIuaj1bxuybb8G/as86fdQp+UjW0oT3HOJoV9fkhiyB0ZOJfHqIgdqbB3T+ESkUWVHL5X2IMqy/JUsk9BAoEzByI04ue9BSF1sfSGj6bS6GshDG8DqzqaLZ9Fiy+oWFKkRGF46z9uX/vCKtl5HIPQHOK9LoiB/yoJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEgw39MAo4AqKgba/aSiFY9kKrCdD52c+gmyGCp+FTI=;
 b=Bih/C2pR/0CH9SxH5ZsxVf+z7KoWNjKcjfHggsH9I0EeX/ji2tky+/JtuNRvoEzCmXr0EKaniN6ShHovsGXugYgEedg65Dj9eNliYwJBQEQ5OVoo/tSCKiB4b/nesyTvk0/V/82ewYIlW7riDmu2Vruw6RhHUWX5/NIrg/rguMk=
Received: from SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25)
 by DS0PR19MB7645.namprd19.prod.outlook.com (2603:10b6:8:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 16:12:14 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::21) by SN7PR04CA0230.outlook.office365.com
 (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 16:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Fri, 19 Dec 2025 16:12:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B78A2406540;
	Fri, 19 Dec 2025 16:12:12 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A078D820247;
	Fri, 19 Dec 2025 16:12:12 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: brendan.higgins@linux.dev, davidgow@google.com, raemoar63@gmail.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] kunit: Protect KUNIT_BINARY_STR_ASSERTION against ERR_PTR values
Date: Fri, 19 Dec 2025 16:12:12 +0000
Message-ID: <20251219161212.1648076-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR19MB7645:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4d0ec30-93ff-4c77-188c-08de3f195f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vEJzWC/Zcl070RzOKDkuIQVxc916GWdtXCBYXXfEUYFfe6m4hkc9VfWsOZCj?=
 =?us-ascii?Q?lfL6FhdL3r3NSCSoLBpQaPv36HgoPHSNOd0rVR3rtUl/9CNH9yd74Sk04Bub?=
 =?us-ascii?Q?2Q8HOw1xOg2oMfn+JyB5q/TbMGmFZR8e21BEflO855nD7sixORx0uBck19x9?=
 =?us-ascii?Q?89M1IbvMLqy0wWfyXhffPZ2w5QnnwvBQFGPz0Ku3A2LEpIr2DGDrXppBXKsE?=
 =?us-ascii?Q?Z8P3xiKficrbGFAg0M2SfNn7AMHLM33HEcnvvG115GfAZCpL9+Vf1f1TXkDm?=
 =?us-ascii?Q?Frf8FMXdmPMhwDutuXCqgBTDfX/S5Vg5QVdi4mUfcFYNhogdg0n3Z1R7cj73?=
 =?us-ascii?Q?f3mpTNbMRcFgYPeX+3dBZ5RhlAnhVC0FCedmf5YYcChDQMZW1uh+7qtaEfRz?=
 =?us-ascii?Q?H/+NPQD+mSjyj/+g2do1zHF/tZ/JQ4ajYaAl+VaY7OZILla43NKkNLXdBpu4?=
 =?us-ascii?Q?b3Kl6GegN3Um16iyT3Q8V5xfPagPeXbggX4pXwoEXuHaXFbaDBu/wwaIDIrG?=
 =?us-ascii?Q?BmqQCPcjGGoVItn8xZpq4NhxrLikUQPL+G9XGXudG4ge6zhd8zSvelsSqlCB?=
 =?us-ascii?Q?5PrG7ZBwT1b42BTgJKfBko5TlJzilBA5ueFzZ+UiaHVpZyD9hcHEy7mx8lG9?=
 =?us-ascii?Q?+YsukUp7r9fQS7UaAICMakMBmty0MejrsmMVohlCAaFxqAqbwreVIP5JGIFq?=
 =?us-ascii?Q?9uR77TVyXQCR4JI5mvmFL8tKYP0SNfyhcpyBmHnKhDlnTB85BR+9AAcIqwWA?=
 =?us-ascii?Q?ag7rPEl2yfXelCMEGoRZM9A9GLHdCzT/uHPkRMp+1Xdk+aP3TqcYe/zkvfhy?=
 =?us-ascii?Q?jzHJwuDEgw5SyDeVbkI8Q1INsMdYBdjZNiddWuh83jLyLQrflci10eXshs7P?=
 =?us-ascii?Q?a6e6LgolZRr1HDeHAdi/BJNILDSWglosQWks2ALyHx1JpU73FbqSzN3pfpr2?=
 =?us-ascii?Q?MiYWDl4m+7ma2X350QWP8sMty+TGe586Q0qJOew4sUNVQhpIrJbp8Kvh0KoT?=
 =?us-ascii?Q?9Mv4noOidQRWxpawOAm4CIsy/NYUp/3tqB4bAj1kCa3E+0m0V/s6jPOf/WUq?=
 =?us-ascii?Q?R3+zTgpcGxjwahAWgt+aSLgFdRugRn+VAGaLc5bHCVxnYI8FKyQf7Gb+g8U3?=
 =?us-ascii?Q?RJaPkToBoSMLGYWoZorL7ZPAbuEahxMfF/LTSFYmzFr9jwUWjMZuIRT49bc5?=
 =?us-ascii?Q?6LDSql2+swpmigsnaz3g7UYFkJsIKHNZ7k82o67bovzgKBpUNbaWMzE0XdZ/?=
 =?us-ascii?Q?C7WCHZCQeyBnqB5ct4M13xm0QxBGRe5q4OO0+cUqNXeLGc3/KT0Jao7588pU?=
 =?us-ascii?Q?ckF0K09oxdyZK95swkwdNCRX1myyAC8/wbmeLVoNaDjmmSDqPuBwpzVBbojC?=
 =?us-ascii?Q?v7g+YQpktBCA3Lzsxob/4LUzlAefyORdo84J/s4H3f6KWu5KZFMFnpTWzp00?=
 =?us-ascii?Q?SiR1I4KJSNyCwxXfrXI+tVqlGN3cyiM83oiJqVfJj8ZW4q2jsbJAsFGZUsFd?=
 =?us-ascii?Q?qVSUpMaZqW4BEqiGYGxuZKQUnXUDhhmiPElgDxhkxYaRFwe8yR52zRCTGNI9?=
 =?us-ascii?Q?kKur9Ni9TcHoBW2dXoA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 16:12:13.7568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d0ec30-93ff-4c77-188c-08de3f195f64
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7645
X-Proofpoint-ORIG-GUID: BiU5SCHkGueKcE_ATj31C9IrpsmlzhTW
X-Authority-Analysis: v=2.4 cv=e90LiKp/ c=1 sm=1 tr=0 ts=69457962 cx=c_pps
 a=nTChkIIWaLHlKa6Ix9xfsg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=3Mru32M5jcDWYwrjL-8A:9
X-Proofpoint-GUID: BiU5SCHkGueKcE_ATj31C9IrpsmlzhTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMyBTYWx0ZWRfX24k52+f1uhjV
 M9zYx5BnTBwE/eRieI2DucDxYB0l5qQcxJ0zHLuBuo2ugnyl3Nc407lgl853qt8/wNIZqSFAsjl
 ynhkfa1g0NqOnX7qd3WXUNB64krJQ5+nDWfXVIDGFJJAWTsffYeCas1/tMpCmForp2QAJWrkjFJ
 azsoafUcY5GFVotMaTBMgi7CVuz9wb+kif6lOXEf23HfzzmQujt/3D2Qj49ePFuJnzd2CdmHaD9
 Df8wJfTrtxbrRVjz5IhH4R1CDiiqXWRHPoGXCU3779wI+/sRFvP8w87ZxfcKjh67w9ERv7M/llv
 blC5s+dkCLP1RnIceBcukjjHpN11UAuBmfqqwkgPzzDQ6pm1j5of8IszEW1qBClSzyXaoBk1avP
 VT/navb1ke1DVqWJDMypo2uezYYg1mNyIOyDCZ0ffTJouxZNQfWiqM176Mf8j5rdCc8aJtJNu6G
 sXh5AFMY5S7ib8TKbfg==
X-Proofpoint-Spam-Reason: safe

Replace the NULL checks with IS_ERR_OR_NULL() in
KUNIT_BINARY_STR_ASSERTION() to prevent the strcmp() faulting if a
passed pointer is an ERR_PTR.

Commit 7ece381aa72d4 ("kunit: Protect string comparisons against NULL")
added the checks for NULL on both pointers so that asserts would fail,
instead of faulting, if either pointer is NULL. But either pointer
could hold an ERR_PTR value.

This assumes that the assertion is expecting both strings to be valid,
and is asserting the equality of their _content_.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/kunit/test.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 5ec5182b5e57..9cd1594ab697 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -906,7 +906,8 @@ do {									       \
 	};								       \
 									       \
 	_KUNIT_SAVE_LOC(test);						       \
-	if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
+	if (likely(!IS_ERR_OR_NULL(__left) && !IS_ERR_OR_NULL(__right) &&      \
+	    (strcmp(__left, __right) op 0)))				       \
 		break;							       \
 									       \
 									       \
-- 
2.47.3


