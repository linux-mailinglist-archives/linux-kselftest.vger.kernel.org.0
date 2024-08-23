Return-Path: <linux-kselftest+bounces-16165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893A95D35B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 18:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C4B2653A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D818A6CB;
	Fri, 23 Aug 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xd7I1hHB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D5187335;
	Fri, 23 Aug 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430500; cv=fail; b=eJ/5U3NrzU4W5nUdF1aiPkFbbw+UP6jSC/AAYP/Ebm3dfMHRuSDzSzYW3LC0XaEBy36Lm8OIoL0dYNIeEsbqIm8C+bDWbo/GKlV/bbkGIZkCnusaByFdwt0ohuPr/K0Duc6eZ0sHZvz2ZwXE2Otzu653kiY7Nroi9ADBKaNm35U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430500; c=relaxed/simple;
	bh=89zFtlGNqR1Nd87CrTMvvXBjUT1EXPgBGCNpO9/MVk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGIcziJki4JiNUO/y9LxxvCpbpqTUaQlw4hrsKQsUXRbYum7S1b252Nyzy/0p4AfTb82vWMEIeKPbhXvlanNTnM3zHUehZI6PPrL4ewoC2YGmfEzkLL9YPFCRgrwOSGRYx01OeztOCJno45Do4FLqx8aGJrnzTgXQDNUhStE1sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xd7I1hHB; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMF/U9cDbH6ihNlMP+CaL8wuZelMPilDDsrpX6PdysTNMb7hpyPL9S7UNcxIATXMQkWA2P/f8/VjH0/brSsKT2ovTC139OWC1WCR3x+re3ivDRy/4CRkj9fbx2oviR6DlQpZxGMuT5TdMdx49RMDTdnxQCuJ8VZoTJySnJXOXv/lK+1MpK5FAt5ZSIy2U6xgVbA7Y46XHI/CIfJxGRjnobUpQGzbwBPS9w4dw0rwR84zU52x/ARyN1F3jR6+dZ0xHs20w2i/tFPF3QDRq4GGiwnx6nXJIdJ9ekR/aGDnuAaNacXjyxJst3zz6g8wH/8UE1YAm8Ozp5LgRyZq17dYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ3njMP4UpWBSUMV4TUDZw1dNpCdLh8dKWyGF/WaT+Y=;
 b=CiezpFdXuRaTpJhF0OvSQIVkyFBz2S7vgxDTzmNbCxXoUmcffk7zbMjg7wmq6PMIqM5vkpusuoUrP4JRrcK90CgN1SC2gK0B4pfdVvRHA0VEk8myazmCDEqnPZfAE8YcKQE93Up5LrJPIcS7n7QQ68He+m6AOatKNbd8Et4twBHrzZQH6wLq+7pW9U0lr+w1AMXB55k1H8E6HTyNpQN5otVEkY9/7zX7MXk0r3c21DF2n8qFghtm5kZE/hxo8ADwUGYeIN6XsOkOsNDu9TLfjwmo+t8kbqeKM731N0/QJkTz+X7ZPgX7BVtLIYGY8ysRk71pMVym+XDkgByfNDmW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ3njMP4UpWBSUMV4TUDZw1dNpCdLh8dKWyGF/WaT+Y=;
 b=Xd7I1hHBXQUGAxKSiIKlhJ/b9fPObO19CGMPh+CA4pmfDnMhdVNcGj2aQWZWQmMHCuI+3iahD3phzBYhein+SsbLF5oRMUHMCLo6fcGf3FRpvfPXaN1ulM0pfps5admX6L5GRkdPi6Teb9SvGujNZJQAqCwurlDzPwc1NiHcyiej5ModqdO0FpJdmsQYF1zFx48m438Zvm78tsACpmqSwv67fxZAje3JGsXuJJAgKsLNgU6b41vMe7RL7El56eKAyhEGUh4xQp8escwz3PkgIRqVuY9GWvzrvktrdNrdw51690xFGBbHl46Hbw25JRmB2EfjiyVrpAmUbEpvMmAnHA==
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:28:14 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::16) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 16:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 16:28:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:28:02 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:27:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: no_forwarding: Down ports on cleanup
Date: Fri, 23 Aug 2024 18:25:37 +0200
Message-ID: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb93a7d-63d6-4bfe-3657-08dcc390963f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jOVkg5uzYL2gM+/9RhJEquhgqONKG/NyRRk+J2dWz++hr9MN8GVJNyUcHbX?=
 =?us-ascii?Q?aLwYLTMKYdWejAbK+EN8VlKEx0QUEQxAJIhu0pVYJlP6i2PejG/OqopV6FoL?=
 =?us-ascii?Q?nzKjY04ZufFUg02L9yzfc2RMW+PuR/xsEMC/YXlNZQK/KfF8G0pLGdHpT5b6?=
 =?us-ascii?Q?j8KajWCv7NAwNn+Z+XUHOKLJRBXPAHtlQlKjr4idqbOgjr4NnH03yS3o5ewA?=
 =?us-ascii?Q?KBjAXkSDCpAcNWjrq+tJ+oT76vAuvW9XjDR+rbS1j7xY3PTYDU4hTBEk0VsA?=
 =?us-ascii?Q?VUlI89o/rDeDVyppdMIVuEFRwZSlIfgpH7JODvrYsyF3bsLZoOf23Ja1yHG3?=
 =?us-ascii?Q?LZX6Gr/MTmGAdDH7Rt65JV+A+1qjn2QItqxzWdoOgp4POOtP9fCfOLvVgeu/?=
 =?us-ascii?Q?6oFq14c+5bKE8DRieD6G018nyUuQAkWO5ZDlRnwJm2uJO/d0NMOWJK4Yauxv?=
 =?us-ascii?Q?dRmpfLcoVFDxVcrP01WxvU5fya5dYv+WbnVt8rlWyIkn6EoD6FyXWJHKiR9Y?=
 =?us-ascii?Q?EhWJpUeSgm1qfBgGC2c383DcWVnKpOGp7o6TepcpS1qisXQkg3X8+7DZZlSA?=
 =?us-ascii?Q?IaYlfrp4/lyu0mpqn7DXbc4ZiiKFXm8XwhMUGAPoeiYCeZ/IhnTJ3pXqKGjn?=
 =?us-ascii?Q?u/3i2Y5uPNC+yDCXcjfDZ13TRMiKlf3C+TJsQT4uR6xbI9kJo4dzmKZ/Pq+h?=
 =?us-ascii?Q?atnCp46hDbl6aMVdlwArtYicOMKRfCr987I3vlGHCIjLYVrRhYnzUKyjR6WU?=
 =?us-ascii?Q?qrEDygniTfYGqdeS5JD9Ra+krPwSj0XHCaw1oGNLuM8swaLgHg7LXh+wYVhg?=
 =?us-ascii?Q?RZFQ6aJHn36Am76cSklzC1N34EVcfnCJYaIFHEZ7EiG0Ysnua2v0H+Eompq2?=
 =?us-ascii?Q?1tpNnjOWmdiL5P3cTPxNUJ6K9kLwtt+xgZatpUwGIujOqmt7hjOWsYM8eywC?=
 =?us-ascii?Q?BW8FuNfki2+1AYV4g47deavoHHhAyzl6Ikxm1J2ezVBQBqCix/zT7ZuruqA/?=
 =?us-ascii?Q?w76BqC2OTPs/EeJjRbUJlPcGXGO04P4lWevIUu7reZtRg0gTxfxite4CpcOH?=
 =?us-ascii?Q?ZsvuNgHZf1XwjOeJQipILaobilUhKiUvtnNB41UU+fK/lSpqq+skTRDDNAaP?=
 =?us-ascii?Q?0+mWDY466MsAUQdFgPlAOYZomyIf4ZFgEt4Efuzf5+2VcQD1yDcCpEb921kZ?=
 =?us-ascii?Q?GNTiI0xqbj4dpJ8InKj4xZWYHEkq0rDSPGHxMHTddV6jujnltBKLl9j9xnlV?=
 =?us-ascii?Q?uhdfh2BD2D6thFvtRmuj8XX54u7zF3xy1dTVu5zsFbTJ3MW+Oj/dPqfAAjSK?=
 =?us-ascii?Q?MLT03DMNuh3yMSSZSs9nqLJwXQdinbibcilb5ijxyUv/dWhKa02C5Q7iX2w9?=
 =?us-ascii?Q?fnTHB4VqJNZdxziP5l1UovqCuyZkfmCWQsIveHC2dWuG2PQw//7PgfcMh3+Y?=
 =?us-ascii?Q?pzpmTi0M8kIzK0P1VV54+P09QfIPp5AJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:28:14.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb93a7d-63d6-4bfe-3657-08dcc390963f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

This test neglects to put ports down on cleanup. Fix it.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index af3b398d13f0..9e677aa64a06 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -233,6 +233,9 @@ cleanup()
 {
 	pre_cleanup
 
+	ip link set dev $swp2 down
+	ip link set dev $swp1 down
+
 	h2_destroy
 	h1_destroy
 
-- 
2.45.0


