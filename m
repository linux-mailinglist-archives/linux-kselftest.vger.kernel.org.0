Return-Path: <linux-kselftest+bounces-5002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3A85B28C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 07:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AE01C224C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F25731F;
	Tue, 20 Feb 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yysu/Cl+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F357302;
	Tue, 20 Feb 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408849; cv=fail; b=VHoWckGEW2zmzZ4j4P66A3GIs65LJWBzTc66fzuDnK0fVwWlNkwS/BFsgTXkldihbStyGTMWaoMCDgbuQs4J6kyEnQLoeiR5PcCNdYSw+JxsvHStsHGrfKm23awR49A3up5/ruwK+QgHQ5IzVzcUD45CeP2NLzZlsYPeYd1pvMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408849; c=relaxed/simple;
	bh=G4Tc+7Zb3w+pmvhaBq+QwaDIX9/OWcq55Yha3Uk8pl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BM7SR8YfLJvTWHsdijH8tn7KYHIKOu0n3HEOTjSwJPdzRSDV6YKxzT2DhrjXsLq7JDCP8ftlBnHbjZoaw+r2QVgK80hnBsMxeKFr1HmqOO5etA57MbYWTOzpRajNeKSRwdE25IuWO/og0n66r3PHXsXouLq2oXM43Kzjzin3QSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yysu/Cl+; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK9gmoKms6cI2QK+ep22w2yNCQ3af4jD0O6Nr5qstbu9bHgO3qaGIdXeAG4HGOVmkc/6ZLeK8QEIh7DAmnSCJnNuwcVhyXzUD2LApOtvB4gnP0YVpBN/nPnuK2qBH1zhdWCUnJ/hiX4dfsmZ2xY9nusbNf93UCLRpaLiaI0GRQOqewLcpAADdrS/QVhPogPxxX9NXFpzPbSs0GnMo4KGXSOFev95WZRcqKZ3Z4A9AaTDRDvLqN/EUz1wuAIDxfNAkdmFN6TS513f/WFsPAtH32GvplK3ExenOI+inqYmG18KMREaMPoQVhIMbHX13sQG2p9iGkAqGr0nI0shhQ80Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=KOQ9AGtzG5s94uoWHJbyT0ows+7f6XynC3CAeZACahRedNxDz48WPIPH1Nc1zSeEjsxENu4roxPDAKvDqmY6LwiR2sO+FqH/I/FhiVd7DANlybvVfy5qrFX6r7y3MrGyON1qi6ZJBeEo1K0dTcUium5mMmrbPc3Mts++wNr6nA/Fz3dYsZGG8Pzhuashhe0CZyMK1fI3yoFaAZk9bfI6IJUgJ/GukzZhg+VVV8HUmCCr4i+XavOfeo1+olhIY5JIvDWZcqogiB2tp46U6J5IQLf1vs8OcgCi4PLp7mzrwpMc3RNcuK1zG5y4qo791iVzL8/UBQFtPeYTe+9g0o6IZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=Yysu/Cl+nCRnYxV7om0gB59rED1W/MjqXFiESrV+R1io64HnbeeW085NP+wLOpSRaim2rqKACajdPEvDSLj4kBr+owkZK/QkBRTHNrNvB3xvsqv5Ewta+0GLV16IUNR/9/PXinL2y+/hu6n1E4geNpHJk/pzjgGmeJv05GJRcqc=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 06:00:45 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::85) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 06:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 06:00:45 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 00:00:41 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Meng Li
	<li.meng@amd.com>
Subject: [RESEND PATCH] selftests/overlayfs: fix compilation error in overlayfs
Date: Tue, 20 Feb 2024 13:59:40 +0800
Message-ID: <20240220055940.3563308-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: f21f3f58-9515-410a-608e-08dc31d9474f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NKD70da/Md+FtySDEGKpzKK/L8cSQZtjuLV2gmAPNtNSGnXSdQNqw/2+WCCXHhp3obrBguPvlu1isleWHp2ZTiw776Gcw98VhT+FHxXpZ2/JSJiy+kikCQ/GwhvdA89XA3tMnJkwu2MLO9PgAzMYuL3fDKw6RcgAtwfMvnWlQGmLYDqABx8+ed9Mehs21wacec1FdnLVWMpkFX3XHVfwBKuAMm7HfFtLrSqD+vZyrA9i8EuS54bhigGpzIpUPEeH5B6r+nFeJSjuFIpx1FH47JkwXbZrtdxg08rObM1vyJ+JRD02ZC82t01xF5jRFZO80QZ0D4Jy9rKR7zOVjgeNPVSNMmf8Ww5nkAe9ZScPn1pIO0fEvBd8LHU9zrbot83l4apJjkT6ouwyau4riTo45TtPsT5TySdzV9PXR4mt5bwnpb3L1xhgomIpt52jcrEaW1mocjYM5aUQv6S+kRqtg0vZbymRsenJyEzAFMl5cuAJWjwBhBEh8ceIUdWisseKS71N/Lzu6Rkk0XHtnroRuWmLYp5iYbLG33RRe/nQ0tu92tjGLd+tMfBG67l5KdHVs2p/sjERiu43QgIvNqaMbSKOcWJi7Dt08PxG+9GUuXmDqjUdLAlIW/chGihStrMPEeHa4H5t1z52Kz3+xowOYnR66vw6tCM5VVdJ8hGOQ8c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:00:45.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21f3f58-9515-410a-608e-08dc31d9474f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339

make -C tools/testing/selftests, compiling dev_in_maps fail.
In file included from dev_in_maps.c:10:
/usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
   35 |   MS_RDONLY = 1,                /* Mount read-only.  */
      |   ^~~~~~~~~

That sys/mount.h has to be included before linux/mount.h.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index e19ab0e85709..871a0923c06e 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -7,11 +7,11 @@
 
 #include <linux/unistd.h>
 #include <linux/types.h>
-#include <linux/mount.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <sys/mman.h>
+#include <linux/mount.h>
 #include <sched.h>
 #include <fcntl.h>
 
-- 
2.34.1


