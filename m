Return-Path: <linux-kselftest+bounces-46353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC256C7E4F6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6553AB8E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108D2DBF5E;
	Sun, 23 Nov 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQ28NWvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEF288C2C;
	Sun, 23 Nov 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917933; cv=fail; b=RqfcGyGQ7mWt9n316771+G+Es/f0SeA8u3VsbFNneGQrEHRs40z4MORH46o7SDRphaK5ccYp47SK3fqEPCxJv6OI1VbsK0sUH3dcVjz+4kMJzPhNTfQz24rMQ9Fv6oz2+EaoVEK90UaMcdS/6eoPrBxB8YawZ9mldTSp8uMwDik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917933; c=relaxed/simple;
	bh=sAa+ge9ku5HAJWp87AI2671Isqrhhf89raCiPccET40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kr8gBrWrrYmGjgz00K9037hIVHVhk8aIok4iB/V458dODBSk/kx7pAIcDu6CczF8j6s2rtc2vjxaD7CiOp2LfhKGM3WXuytPDVtRgg+AUUfdgalfZf/4IrczjF/0ykvaADHgu/VPIhRTI6nFidHELdHxNf5zePX1YgWJhia1nfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQ28NWvp; arc=fail smtp.client-ip=40.107.209.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHcqICNmzzV88V5zR6CgWXxJV0hGZN+AskuH4jIuQshPDYwQv3w81xkechQidsCnRVPgKbqRYw+jIpQsIEHsSBltIQt3cFELnZJ/1SGXVU0mX0UXnzcW9or9O2i1wNv3ZgiFA4/qi90XHq/EMQaVRRrA5N2N+shsr1M7wgZJWD60zeepktkKkUFwVVMuCmX9JulxSDsY00u9T/kyZAkLzigLdG1cq/NJFfp7NhuoJ4DmIsLRIfrW86Nc69ybyB30L0TMq+rPCwv20EAnhxcOcWw2BTgjDu2eU16Uy8QlcG5WYFTxnxHZzORa46zImcmndJR3uiq+Vz8BLFzkvVWlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=utP0MLhY8XZfJmsntOM73JJc/QUY3tezb2SvLv+gjnr22uw9vcfea9JisUjfSDsh9G5g08RcFvymszMiKedw6tZYURWx3T68zl3dTs9YSQgVwMdLyLa20qV966F/37EicZoFPyKxnRhP1FhfXdUfz8AObC5gUTfoqVABAFQk4pXkIc2MTAGMZOLFbXfM0mtGFOnWP7DarGYXb7ImzjTyHH5bR1zQxdB/46svMGWWPjiDPVPTA+oHWN2KQf8L1iSaPJ5jc+K/MZgeOI01AYmG32rlwvCU+yDH9AoAIxQpGDgbR3MVB6hB3NyfWx4HiNx9raJGymei1a4iJi81N7i79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=cQ28NWvpAIfdeDxiJyKNsoF2uka7NhWU/dQDKjaoXyQDB4SzuC2ZeuT+/J4IcsgZdKYZCUrZNdVNbev1vBhyAKd4sN+4BIfzSRh6m3DiCEsK0qSlHfDflhjiNEhXvWzk6ehhiynIK7jrFny13/Ui8Sc8J1YW993/Y9YZ/h71yhwrE+RX17WcPGKiEWaRJZ9KOGVnmEi7/IRcIKQeZw0s17CjhHgK3HDts4aDpJYX33tCkJfZ1joDsPf0/ZhNLcM/VCQhdxlb0PQnA/PpzNSNGzmLB8p7E4eYu3qbJPnBKMhewTFbR2dpdSJBklzzi6A3XSd8tdh3MA3Qk4PMdeFHMA==
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 17:12:07 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::8c) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sun,
 23 Nov 2025 17:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:12:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:52 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:49 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 4/6] selftests: drv-net: Set shell=True for sysfs writes in devlink_rate_tc_bw.py
Date: Sun, 23 Nov 2025 19:10:13 +0200
Message-ID: <20251123171015.3188514-5-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e17888-b383-4ed0-37d4-08de2ab36e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?asbgAPDy7LQ3qcnIC0/KPz8ihMJ4Ff3srfvMghEv+kauQvN3OCn1adFpbmWe?=
 =?us-ascii?Q?PVZcgSPetCce6R/HS/wKDu9MI2SMl7BmKRRfbb9cPhC5b7QarqNbNoCvpdV8?=
 =?us-ascii?Q?THP6ewpffLJd1/1nGIiKiJCmIxD2uF6V1ZDcc75ZccSXVRWxripeWHAUJAvO?=
 =?us-ascii?Q?KYqKvhI0xiHFNLOsEeKbteSNtonBcAO3BtF9MahvDhsmeiWKXyDp7ianwcKA?=
 =?us-ascii?Q?7sr4VJNC04Itzyca5htmt1z6p9dkkjLsOPNUO28XOaTtCe8oSYcQyc6X7giw?=
 =?us-ascii?Q?/WhtaYg7OuHKMbUEV/qCGq0YDOfQthL7fwp9O7k0zVILMEss+XgVcMPpDhPV?=
 =?us-ascii?Q?f03j0Prs6uo5QR29iVG6jTTpCV729cvg3s/+VljYfiH3llDEBLb+wp1OoXoN?=
 =?us-ascii?Q?oWKkPNm00COqUb+bEiVFul78Whl5y+0wjcQoQXvf5040zYE7mqrOi1fQPjA6?=
 =?us-ascii?Q?TnLZ48VMGUNyjHCFQ5x+/9S77R/ht6zMKnmB5BbAJV/akpo7zlXVnp0K/7wM?=
 =?us-ascii?Q?uIjZQwUWJSvwDDiVI91w4T6D1P6ocFyhHevFRE5XyYFglwslgTNsiQC0I2PD?=
 =?us-ascii?Q?5/5t31E5UtQMuBeJmfQYqsXYtI2RgbAofUVP/nI/WzSs2SlfVsJ50gqd5j8l?=
 =?us-ascii?Q?WworhJ371VN5eGn++gG0oUIm/ogMMmv0dYaaGFv00MIwjRC8OxFHvAJm7NM0?=
 =?us-ascii?Q?5ziXB3z1aCuAMNaVtiAdmL3CBCE2JVHkgutNrje7cdzXg7xLGQ1zOYMpq6Vl?=
 =?us-ascii?Q?hpF77rmjIWq+6YEoNhXc0VwiAEHBj9fFluIZ5VcL3RBXUQrXax+5zR1aCJvu?=
 =?us-ascii?Q?xoILtH9xhjAyC1vs3dhd9OBPE/yzd4DL+/8fBE7N/QUK7A7bFDCifUBar884?=
 =?us-ascii?Q?DdqM+r345FTb+zxmSr4Xsn8Vwe8ZaysAbi3+q137hLDqCqmXDNkhls3KKqHz?=
 =?us-ascii?Q?AdsIvGpdmJ8hHIcQXD7JFiBAY/BqN2RXXwTa9oSJOXWRY+SgtdKUdnhAFarm?=
 =?us-ascii?Q?A+RQJEkHIjE1JYHHa4KjftGMWvGBpec8r7l4M51x4Z2AxDZuvaK9ycKasjc0?=
 =?us-ascii?Q?rTi0fPxlGE1kxlfutKwQLqY6gRqDyrTWKNI/Fs4GxlHsePMvTKJ08ie4lVGM?=
 =?us-ascii?Q?yz++W56kRGOQ5tYag/Y45Dt1CBYlSvs5ldH1YIcHymrpgM/XppIG32Fel4ah?=
 =?us-ascii?Q?yAm6aEQiuFcnCKC5SMnXA0jJ0CQvlxn/KOLZUygDCVyTCVLrI/8BCOKNecdS?=
 =?us-ascii?Q?STsMtbzvB4YartWWKblOGdaoCSOytWpp2woRPmblYQq4A2eZFPIrhK3ka+7s?=
 =?us-ascii?Q?4Eds8rC+pvRmYywfjcySczpGqJ1qenRz3J+g/z6HkTJK/qC3wm8ETZpm+b//?=
 =?us-ascii?Q?qSNpMMWKz2dh2UXAZXol5vbJ4X6xLEtlftEC0uZzWWV7tlxdK5G4jMFzmibT?=
 =?us-ascii?Q?xGigEauUdlkRJoEJOyTs06g8ejV0NR7EUPfrGBTDWbeAyTT17SoKRkFSdFYN?=
 =?us-ascii?Q?sjrV4EoFOAf9aZ7h/xcqHKjnPz0tg2x3GEaAUsPxAmjKyA3jKN8MRwAQ7m83?=
 =?us-ascii?Q?f5gESNHjCw4t6KkPAUw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:12:06.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e17888-b383-4ed0-37d4-08de2ab36e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

Commit 7c32f7a2d3db ("selftests: net: py: don't default to shell=True")
changed the cmd() helper to avoid spawning a shell unless explicitly
requested.

The devlink_rate_tc_bw test enables SR-IOV by writing to the
sriov_numvfs sysfs attribute using redirection. Without shell=True the
redirection is not interpreted and the VF device never appears,
causing the test to fail.

Fix by explicitly passing shell=True in the two places that update
sriov_numvfs.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index 16e5dda5bee1..df71936531cf 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -117,8 +117,8 @@ def setup_vf(cfg, set_tc_mapping=True):
     except Exception as exc:
         raise KsftSkipEx(f"Failed to enable switchdev mode on {cfg.pci}") from exc
     try:
-        cmd(f"echo 1 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
-        defer(cmd, f"echo 0 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
+        cmd(f"echo 1 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs", shell=True)
+        defer(cmd, f"echo 0 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs", shell=True)
     except Exception as exc:
         raise KsftSkipEx(f"Failed to enable SR-IOV on {cfg.ifname}") from exc
 
-- 
2.38.1


