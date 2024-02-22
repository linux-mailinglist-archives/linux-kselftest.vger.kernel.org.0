Return-Path: <linux-kselftest+bounces-5314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC108604DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A062B1C220DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBE73F2D;
	Thu, 22 Feb 2024 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfudIM+a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8D71738;
	Thu, 22 Feb 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637761; cv=fail; b=drWtBA3Wwg9x+RuwgFTafJX32L3jeJ7kexxk7x/iGnywxS0r2NmlF0bayd8pDntN6J6iIRX5gsyne+ucSEnRfWmyxzoyOpYQMMoyoALiyRUQOQ1FRTqyHF0LtHCjjiWlaY/Co5MFVWtF68P5InGIcEbI+S8rbFMho2XNEqrDqqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637761; c=relaxed/simple;
	bh=EF/ZJWlTt1HQUa7j+g+7njPInE64aeyOLM1d0guZKt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3RitZIdmk7z1VKlrlmBQtpTJhk9NLhyP0kN1JV6x9GdSlf2ZWFmERpTTGKkfDyLCRfvtqlh4QQuS8aqe3RjAkIMBeHX5Nwba6okRahOfMibHQB0UsTYlEgZ0ISJPLSGjJSEGBlWSreFUxj6zPMrXJ8cCdnpTTqzwE4JvT3mox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IfudIM+a; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQtKETVPRBFRbLYoryYca6jdgjoLfNcL7xdgVThdK3AYsSCvTArlBKU+a3wgEtlP9ouCohyNAGMYbIflF3ESEJnZCMibqHQ1AlrG1z4EM2uJEEoPPKjdLFXAsVJaIEs4xRyCP0MLvVuIaKuDdLeRNOsYJAd9rTvp+PcLFvDjwixdRliMjh10mrjjEqhG+pAXQgKYKmWbOFzuiLQVhjNbHAen9CyAC2KffPdsJ6Tpqh0cC6zxV7MWqU9UAwDeJoJdPjs6Cdl30DASFTA+A/6h1GPnFLqvDw0XJj6SyCuiPd1hpmjZSZmtehEQHAxeGf2VGZoW0zR44/nNJR9Ji3rdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+AjtPs8O4lx+gbuT8obaop0oqMUo3pZ5q9zXbD7BZU=;
 b=IIhYW/+E9/T85/x9XOkuBKS8bV3otrOw+W2HuBJyBm/YN8755HBGV54dbQ/NsOBhc2d/N5qj4LoAxhrb3UWLnBzDCDco18joV51NM5NjCriZEffs3WLU6Jlp0Rkx9npFOiHqjMHAvBYs70jllNssx1BPGDStNLxaafBYrvw5H55fH05//Fe6KVrVCqCCpZ3XmjjsNEynKqBq8+47X0ht7BTTXtTC/ywpvomeRAViMx5xnB7/JYZBh2YFLTrmbKgs4R5YbbwiDeNTXJis9LfBOOOZAKdrAybDmNgG3BDz54DHev22XWuAQUWIN9JmaItwdLCY1afizf7g9MO/bPZFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+AjtPs8O4lx+gbuT8obaop0oqMUo3pZ5q9zXbD7BZU=;
 b=IfudIM+aWycRtF7FB20vRngHac9qYAx2rwP0YbawQHgUmJVOC9kmZFq/1bIJRTj8/6sE4xHOrpVm2lQZYO/Hw3Zc+JEbOta9pu0b+DsX4Q8/t5exrn/NuUcXvo0KdkTHNtXuiAlylE9/gMRirR1KJ7QaXtlsZoOm+hSWrM30ryQ=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 21:35:55 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::7a) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Thu, 22 Feb 2024 21:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:35:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 15:35:54 -0600
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
Date: Thu, 22 Feb 2024 15:35:44 -0600
Message-ID: <cover.1708637563.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cc5389-ec98-4507-008a-08dc33ee4041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nNKkDUb8wZlJIzuvKOZLMigh1AS1XYATfZ2EjdLWY+SSWfn24AB4Tn1/8SSyNOVP0ftGMepbJdqaofoTuI1AahQWidnQds2wJ9FsH6IT4gSMtPguoXqk3EsnDwll9GbCOWXMjt76nTaLafSHaT7x8pJolTgUn/nBZzU5PlvGCrGvC2UxCnCRverYPkJzEhIuWweYiEYZeAVWfXqr8HtB5TF3fwWFWY6p585GqPC15n2kWOZ54aY6lRaSCON1OqhqpGBDLgk3m/7+2wYO1I1eHWlTUrJMQkoRQf++YeGDTDLXaRxyNS1VbYhHcfaXFHBHXqnHQXMuMOIxJN5u3vrjX/esqDwf2MHuZMvwV6HEGa8mpiqV3bhb2wImo4gl4GXigF/YpSMXD6GNKrqGun2c1mng38DZFHhCGXp99SqP4uhuwEeeZPITkFLsh2gvZUG977Hki4k0wBRtV9br/hWro0UxrNh4fUZg8vyXZkPY202fdyfNRbxal20w8I2m0ngYCHKogyyfQso+YzzUSUvhYIxZPrOcIuyeU/OtaB/a8e9On8L7vkz+ndVziIYnbPt3O82qRMIoixHgv8gNXxM6fZxHzIA1OpoA2ImcQqu2y5OVSHCJ2G/9T996xIfPHR/7j9Cng44q2Meclx2TIOOhr6Ff6kbX/9GX/BDn2+dqZjo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:35:55.2065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cc5389-ec98-4507-008a-08dc33ee4041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593


The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth Allocation)
features are not enabled for AMD systems. The reason was lack of perf
counters to compare the resctrl test results.

Starting with the commit
25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
now supports the UMC (Unified Memory Controller) perf events. These events
can be used to compare the test results.

This series adds the support to detect the UMC events and enable MBM/MBA
tests for AMD systems.


Babu Moger (4):
  selftests/resctrl: Rename variable imcs and num_of_imcs() to generic
    names
  selftests/resctrl: Pass sysfs controller name of the vendor
  selftests/resctrl: Add support for MBM and MBA tests on AMD
  selftests/resctrl: Skip the tests if iMC/UMC counters are unavailable

 tools/testing/selftests/resctrl/resctrl.h     |   1 +
 .../testing/selftests/resctrl/resctrl_tests.c |  16 ++-
 tools/testing/selftests/resctrl/resctrl_val.c | 105 ++++++++++++++----
 3 files changed, 96 insertions(+), 26 deletions(-)

-- 
2.34.1


