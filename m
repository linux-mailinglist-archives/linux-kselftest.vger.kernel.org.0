Return-Path: <linux-kselftest+bounces-30595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F4A85D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883591B8042A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCEB29CB58;
	Fri, 11 Apr 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XPLINIsZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="uRXj83v/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F329C341;
	Fri, 11 Apr 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374996; cv=fail; b=bjIK2cXE408BwrepPQaTAFZYEWmz0bghP8qfoJyc93GHxiqdAZpZNUOtTrpL2njdSJfNkm+/J/HTyhqa9osekedQGGNrecSUkuwRHDSyNnt4eBs55CYVnz5rlugUSfHY9boCUs5BwkvtrxUcumqGcQZ7MNwCPhKaChb/ACZnP/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374996; c=relaxed/simple;
	bh=chPGRvmI83TuOacd5Vv2kRXijvQ3iw7xmHaDCUcS+zY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dBRWxXE2xYJUzw4qpqbBIcdOomFVUauLRcbGc0KXUz5YwmHrI/iSiSVHqACtx3XcVHl7SNi23PYpC0o4epv3W6NZyepvdLD7U3Irz8eEEOmbxozPy5g38tzsO7wd7ZC/cRQPH6xyFIQNXm6B247eusI81i23Vn1YumMGns8ANuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XPLINIsZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=uRXj83v/; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4xQ2Q029246;
	Fri, 11 Apr 2025 07:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=L+ExDVpADn3oPIXQ
	tQO9GHyJOaWflQAx2wC3sdiFlgE=; b=XPLINIsZiCzT91Wt31KVZXTppVeu+mdU
	B7TEC2U/BWrcMVcIRI19XpTtir9iQIEVXfSGMuFDQ+KR25GFu6VgLgO5gJb+8HC2
	dxhFu030s4+ObfjIQlUz3Z+gKRpWAWFIrvFS0ESiJVSz7U6zAwA1haeCvgmgFIms
	Es5RKRWwYy0RYt6+VRT6jyoGY64+zbe4yw9hsFNtaGKvKVlNuoTM1xpPenReMfAb
	zcm1MxNQ5IC0frs6a0IxqwgKhvE87AOap5SW/YILXAUPN9WzvRWWUXRTTsEgLQgR
	zsS9YbDM+pOUg5EuaKaAIPukSVZu9whJN5oftPxpJP7hXNQdas+wxA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45xa4bhse2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:36:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whKex2UNKzRFC8V2p/73G2xgt33sPKdoyY0Gu8U2iQvtc+OtMXHmRMr0WZYgkjeb7oFqYLaMybZE5AbOTRfNLT0/OtmYoP/e2Wb4PGxBtXM5Zqr5gUd3Ldr4PB3JJHa4iI1qJHlOcuVfQbAG5FPG6eF+2TZ4dSslLOUeNTeOr5LWRb3efJfR4uHDG0Li2DReQokRVECELDpge8MAbS3d5eGhSn7dh6PjF34TqTVh9h/wTz7ceyRq1yd4TA9LhVjZRMKBVMoREsRE58deeCPbo8u2tC6ziDeDXCwj3GQZ3Rd/fHWoZHyk4AYUP9KdlpmC/iMII5QZ3seg+BaoizcW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+ExDVpADn3oPIXQtQO9GHyJOaWflQAx2wC3sdiFlgE=;
 b=w8V7/3TOAj7rdXc6MsUzFpy3cEgoWz0RbOtHGhSveZLO+D0MkU5JWm+QM4L4NK3GRXe68rnyX/iWubF/fk5f0Oqv6OqyHR//Bm14zGhHy+NnvfvgsV09rPWFFNeZpIT/NGXZLiYAfb9yU7Ev4CKiQ/Cmy2jMY9+znHwwWM6uFhWqmbCwV3AMhb+4oLGfBqCGB4779gfKpUT+6MabmCog4LeQ3DICMn7pzHyd1KREzlkBR5imZNwCiWM5alKpOXVNafYQQoJDtK5liwaHR7zFQNHKvPSegbt3xiHajsfEi4WpEtpEqedXgyUqpMVelP2JZv56hAm7G55FD6tDByCwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+ExDVpADn3oPIXQtQO9GHyJOaWflQAx2wC3sdiFlgE=;
 b=uRXj83v/aJ4cM9KomuwrbAMKFBbFNsoY7IiJUbtIbf4e1HlibHcuwgwZUIAxLjCg6JRWciifgrYse7kveD3tOW1Kla1gApbkJu1xTHwSA/S0JoSHWbflbtUrOnUqrDmNwcUbzxdpF53VWuGjkepVy35Y+s44YAClbf0XRTiWfdo=
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by LV8PR19MB8200.namprd19.prod.outlook.com (2603:10b6:408:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Fri, 11 Apr
 2025 12:36:10 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::1a) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 12:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 12:36:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4848B406540;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2FA93820259;
	Fri, 11 Apr 2025 12:36:08 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
        rmoar@google.com, npache@redhat.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 0/3] Fix up building KUnit tests for Cirrus Logic modules
Date: Fri, 11 Apr 2025 13:36:05 +0100
Message-Id: <20250411123608.1676462-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV8PR19MB8200:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73f3368e-fcf2-43bd-82c4-08dd78f5702b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApThcmvbPuCmKT2e5A8d8GbShfi1rqJRmvwdNtHvzw96CcbacsG6xjSKxUkZ?=
 =?us-ascii?Q?fZvSX/mvWNod0octxOsxSZgEI+btYe4BRSKXqGUSG+5GWAAhFprX66417DOO?=
 =?us-ascii?Q?3cshkBLdDUcSU2VuDNs1Sbx6prZq/wwXvv2PmKWop6ZIyZ4AgLAyUoUF816W?=
 =?us-ascii?Q?40J9oYaEnuXRokjPcW1Tv6/Ch8skDWgt/fDqWwNw+NHoMtyw1+QiSQHYMLNs?=
 =?us-ascii?Q?b7c4iMgO8ljzbesc/uTxv93CMPUX9m6a7OxgphaVa8XrV3advwydOyHcYjmh?=
 =?us-ascii?Q?MpXL+AGOUeZLjuzXvvOOKMSo4qyuConUdbMxFKFC0M9Ph2G6mcY3W2l9m97M?=
 =?us-ascii?Q?EseMH63QHTtVhSn8E6N7zi2UjGF26OTzoUrBFSESa8EsfM8O63Iv7ZX6GG76?=
 =?us-ascii?Q?y4jiQ3jp2+3rh28ZWca/vjOuiZcwUvgStEdzNNG0e21h68AzLd0tDcUycIJv?=
 =?us-ascii?Q?bPXakwyddAuAXQtgTfdSocBg4348tmrKALQbkmRgkB7u8jQ3jqge3/0zSNFT?=
 =?us-ascii?Q?8Bi5cUqtVKOoaVCGvJvbCS7hV2iQUhWJpJCqzRbSKkEuVqM2DxpypUZNJzuL?=
 =?us-ascii?Q?1858Dvd1GZApxtEe+Tab14alZEXr+6UEB1RoKzt7vfc35NV9tf5lQ4rQdDYo?=
 =?us-ascii?Q?rcUaQPVChlUCdOweutEC42YiEQPW10MD73zlMH16hiqaE0ct3QrTpJiq3jlx?=
 =?us-ascii?Q?EqO7lEinoBt2ae1uE/ezw9dMfKLnR92cC773fyxqLlG8lkWXnoJvsXXSOJ2F?=
 =?us-ascii?Q?4k621R3WcCBQ71iJQYNYRNwIO+jE8vVG0sl0J5mLSJhdU2nvJA6qBZH9enLM?=
 =?us-ascii?Q?wGbOQIRMRKB+251eh9QPxtx3gZJ5DzTGuIIbvE/ZaLrKvrKlHfyu4XUS2hDj?=
 =?us-ascii?Q?817+v79HtdWFpwSkb66VHc0wI6tVFkqiTD4nhXsSNzyhQVN69yuGIOpsQ1ub?=
 =?us-ascii?Q?Ha4mAwuJrpDudgtuIXbfUB4jqSD4rfHsMjIlUbjLBgXgsJTNCPq+bJHhrgei?=
 =?us-ascii?Q?LrnZk58IMEwCr2KkStXru+H/Ca7fe2V/qL76XsO4pY4Z35BCOl6keo6VE4sO?=
 =?us-ascii?Q?E6UD+EcqHTXFpXRM20hw1BNYLJmDl/ZDx/jjKA0P/boO+DfvtHJgUuKXbFQP?=
 =?us-ascii?Q?aCgtZ3n5fmKr1GU4Ua0eZnoVmdJ8A6kf17evH7rIoCjzqJFx83f0dIx8ciRJ?=
 =?us-ascii?Q?I4J32uDCfGeoc8Omn0N689odtsS32V3jyiWlC41LwF8T/VeDoVTNDlDbsLUN?=
 =?us-ascii?Q?oEYmWFkRbl6Jr2C42KLPadHQfZP2rcVevtcYCbu9lPNhOOLybYRWCFjYk6wY?=
 =?us-ascii?Q?jD3KBruZt8IEJNzCfSMB2UYpU9MzRMIJvBnDRFi2xWTiHLOYfRgaNk8sGOkV?=
 =?us-ascii?Q?3smVEFSyW1zxfBGyJW6VqrVNnR+3Two4elw65zxBEacvXsNx4FLJ/tnnI5Eu?=
 =?us-ascii?Q?GJ55VJp6umGCbuWJQsqssR6EX8Z20i39E1BpYlMMMvBv/rEhJgmkjQxxyvLH?=
 =?us-ascii?Q?FCC5NtzDpAmNEtAbUBVPXFzO5TpLP89QwRqA?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:36:09.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f3368e-fcf2-43bd-82c4-08dd78f5702b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8200
X-Proofpoint-ORIG-GUID: Zx3XNN06Pj3i_lBzVazALoLaoGonA5yP
X-Proofpoint-GUID: Zx3XNN06Pj3i_lBzVazALoLaoGonA5yP
X-Authority-Analysis: v=2.4 cv=B6W50PtM c=1 sm=1 tr=0 ts=67f90cc0 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=D82aKkiKT0t7tNYyCrAA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

This series fixes the KConfig for cs_dsp and cs-amp-lib tests so that
CONFIG_KUNIT_ALL_TESTS doesn't cause them to add modules to the build.

Patch 1 adds the ASoC CS35L56 driver to KUnit all_tests.config so that
        cs_dsp and cs-amp-lib will be included in the test build.

Patch 2 and 3 fixup the KConfig entries for cs_dsp and cs-amp-lib.

Nico Pache (1):
  firmware: cs_dsp: tests: Depend on FW_CS_DSP rather then enabling it

Richard Fitzgerald (2):
  kunit: configs: Add some Cirrus Logic modules to all_tests
  ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB

 drivers/firmware/cirrus/Kconfig              | 5 +----
 sound/soc/codecs/Kconfig                     | 5 ++---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.39.5


