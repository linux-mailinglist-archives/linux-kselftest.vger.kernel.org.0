Return-Path: <linux-kselftest+bounces-48190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D193CF2E9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA09307692D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26032EC09D;
	Mon,  5 Jan 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IuxUISgi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B612F12DB;
	Mon,  5 Jan 2026 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607522; cv=fail; b=sc4Fwjo18Kh0sui/i0lgdyVhsqdfjkvIo9DLajQ6EFkOeHfSTE3L2HWcDy7eL7vMHetpgD7WPybkLweOWJxJQqsaYY0ZoYEOLh4pHznRsX/bU+VLwy7AY4qdjkRenW24MfZus4Ax2OmbvcL/hOCyXdwTxc9BFA1g9Jh6BNN+XLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607522; c=relaxed/simple;
	bh=HaRAmvPQTsvFHrCQ1Rgs3f4vOhTRk2q0ffxyQV4bcXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zffp9cGZ8kExzqxSZNDyc3iV0QVg+GV17ete8E9gEX1jQQwBKjOk4uCyD1JMuu0LG0/TzZy4lfyEARMrHm7RDBWX4Nn7egbQiVHLpV4HJn6DJmYP52GjniDkyc5D8u9iHaZKz2Zl/sHgsdaO4bD3bzkoXw4ZspVmtuv0Kah9A9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IuxUISgi; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFZWaQU/Q/SCLpxCp07me6ik9ZSWU0xsEUNhdFYO1AMRFqWtz25LBe9tGAMjwWIw02tdsiM2UMrXKNCM8xuWiJbP1tJ/OgCNA7HVJB84TTSn5oUWn3gD8/N0FRYPP20UamgS8dDmO6N98FtitBwPR59VIv5jl5zN9cBoUu6ZPtJCYnC/XrsZqxhf48CPyZbhgtsPjIqxohT0VP64tumHpnGTttehvFsnClKcdiRQxhv9JTMoUNlhKm7PENa+Csl7OGLUo79xIOKz9kHAYdqH4Ger6iXDiYg+3L9qyKSPUjO1iuRGZ/TPdUE8SrFJlgdz83ux9Kyu9qXMR0TD/Lf9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn1Lzo8K5GGwxo+we4rcbbj9k5UWdimiZCnzpBHgyG0=;
 b=xfHEhVJeFmIYkHKbNHqPShpK3ebOVUnwEfR0Dtb1v/mYAQfgljJtll+UgM+ufxVgJVwERm29mPGvi5enJFd8CuhduOVv0ygnzjuYD9yZcZl2Zv40EbxUP4X6A4eZNgjK1O2k2bf4qdrMRUnYBTPgDbvT3xasOHiw6/78v+5YMo06XKsMnEGM/622n1UkNrvQFmsneMPc1ncrPT+iaJ+cpIXKgtA4+BwECAeOpN0F11192ie1TVHgEfs3o57aOGsnwgIDPamVKYTy44LBM9Ol7J2iIa4VrylmLHkI/TPvf7EWVG4gglQ6Oh7wLIWav69cmzbSa1ZMWMRI/Jl3BmqHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn1Lzo8K5GGwxo+we4rcbbj9k5UWdimiZCnzpBHgyG0=;
 b=IuxUISgiz+Ot7V9zD9DjhzIgp7TX6Td3pEU/fZtqSmexV1iVGzfuwVpmz5CiTHNrDa7wIBH7MjYDBJdfFxl4n8DwRRkQS/Yrt+c1WaeDCMkMvqORRugpYeMX0NGnv4drm/DST2Dux3XEGgpLeF20s2HpbOr1aIcEGfn/vWGfkm7SsrAsqHeMdFT+qeEf4s0bzugBVsUen00tyns5iwqNZwcI1zujS300L6pY4l103wfedqsk9Ig4KItXBm4qQqVi1HFdQRu5fdljTzG8XezohhHGjNBbSu3HLO91KIkZQd+CnlPaq9F2ScmNCdLS+AXC8l1CaEOJA4y6dhkthhZ5Tw==
Received: from SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:05:17 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::63) by SN7PR04CA0012.outlook.office365.com
 (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 10:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 10:05:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 02:05:02 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 5 Jan 2026 02:04:59 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: psp: Use first device when multiple are present
Date: Mon, 5 Jan 2026 12:04:23 +0200
Message-ID: <20260105100424.2626542-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260105100424.2626542-1-cratiu@nvidia.com>
References: <20260105100424.2626542-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 729f662d-857a-4348-fce9-08de4c41ed0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vpi/k4WxSuo70r9xQ2Bl8u5dadQc94PI9nW1O7EszX9YUMHvSkjk8WryRvSa?=
 =?us-ascii?Q?oMAhORWYEqh9lS93zV2DxOHL2nzQOOGO4WtUJcuVIGnuhCqnkzPuHfJ0PkUy?=
 =?us-ascii?Q?gLcnDc/jgkZJaem9fFoAt/SttI6GUq2sXpBUJYr0ORNG4hNARAjUZdEHnQnS?=
 =?us-ascii?Q?6t9UD5Km4Af17FzdpfCpfwvdnvajuMRcI3WfBj9knZId1EBJKsebjLF+zy62?=
 =?us-ascii?Q?B1SwY8oXPifEZQeyQ/jy2dF+YWperAxZM5+NQZE4UTSOr6nUT4Y+Jr62RlVC?=
 =?us-ascii?Q?9Yjk1WyD0wnHWgU6HLaz/59bkLDu8SOfSMP6yDCcXEp+0TWLp0mGohVzeJli?=
 =?us-ascii?Q?7T+Iz5yhvfBy48WUQRYtunqO3TQ3//PkLoGR1WwkRQVWh7VtBx8N9r0vV4EB?=
 =?us-ascii?Q?WwC7uJ51jg8gfc6ga9CPigGLbOZpaRgRWAy8oZ1ewfbQh6mGj96owdYbR8zL?=
 =?us-ascii?Q?6zF2HxgdgXZONIpeYv51d21fUwSq2Wy92Mcc7Po/w0TRRGxRX+bmsFCZx+aA?=
 =?us-ascii?Q?7VlO6iNJeGLMYOjgCkvFKgoMqxZffhVGEZnGO8BMRYa472sQ6BNxbPrh+ke7?=
 =?us-ascii?Q?Lqa5r3GqgdfsREvIe7/ooyH+cbrPehnLaA8EA2A+50E0jhU/XcWN+BXeux7T?=
 =?us-ascii?Q?0Ok5K5p3S3BtCJu0Yyt3q/TCsognfwiCSDsFZv5Pj0vsCHETRVpKQsa6gxR7?=
 =?us-ascii?Q?rD/iEqDNTBuU+oTMCxGaCHx4USt5btwympqXhQa8gFdGDy2a5fgA4+6P7ZFu?=
 =?us-ascii?Q?ifHstZb+YpDfSo/UG/gX1CFk3JKuorWV3I2IqfJ7SiBtWp97ZuKHc0aY8A5Q?=
 =?us-ascii?Q?53+E0kZf5vW/I5KyNJkQH1pC4hu1ysbD5tVHaPi+D2cInRgk45MNvZ1j6sJp?=
 =?us-ascii?Q?32ICsc5BHSx73wBQE+WZxyMl2V7Uyu1xSb0CR2bmAkrk3VHsQnYcKnh5SMSP?=
 =?us-ascii?Q?eLHjdLMzUqWYdK+Poj7MejD3gM28WGiOvWltaw4ok7Wz0QdpLrDtF6zk2zNo?=
 =?us-ascii?Q?qXseyPvcIqrbuYLMQ9qRwMMBaHQpkwUlhQLkODeNCoIqkkZRW/B61iCm4s0s?=
 =?us-ascii?Q?8bs8Ut7eZG+eAAVtiBEIoCeUSOtRwNCJxXDx3j8MVr3UsBbrdtl/Cp3R5y0g?=
 =?us-ascii?Q?Cq+UdPxLU8jtRvltwmM/gHUVBO50EuB3UqFA8nsu8125GrltStbHHeHxPFBV?=
 =?us-ascii?Q?HjUvYoKotDpOEeTy3vd4AjbtRx4wcmDmp50d7aDfDY3FsMpOibUKqXvpk1MR?=
 =?us-ascii?Q?h7JuZhenxKheu1RKcdzx8o/jamOeUiNdASHiBOuudxTOxbfCJrGqrAmelWMh?=
 =?us-ascii?Q?NciZS+HmKPiEevJDXYSa6nLT1c7UsasfMvIfPPOi2X5BTaEy+WRN/6TX80uW?=
 =?us-ascii?Q?zYIeajOTFkcdypDcwZQts0NhRqQhHbvA786bYMo5RmKgQ/YWXq5+zrvKaRBv?=
 =?us-ascii?Q?wrY3tomRNXy43s3qVHsorvJVyo1lSOtbZLZ9QjMAJSPhckM7baizW2uHursw?=
 =?us-ascii?Q?IVYWczvGLe92C/u/dWA1H6d9LEeCnmgzl22ZfEpy+ZX5KJKn+ZLsORs3Ao7b?=
 =?us-ascii?Q?6qBA6GDAjwDknmKbjfw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:05:16.5401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f662d-857a-4348-fce9-08de4c41ed0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

The PSP responder fails when multiple devices are detected. There's
an option to select the device id to use (-d) but that's currently not
used from the PSP self test.

Change the default behavior of psp_responder to pick the first
device instead of giving up altogether.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 tools/testing/selftests/drivers/net/psp_responder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
index f309e0d73cbf..8d2bad134e63 100644
--- a/tools/testing/selftests/drivers/net/psp_responder.c
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -410,6 +410,7 @@ static int psp_dev_set_ena(struct ynl_sock *ys, __u32 dev_id, __u32 versions)
 int main(int argc, char **argv)
 {
 	struct psp_dev_get_list *dev_list;
+	bool multiple_devs = false;
 	bool devid_found = false;
 	__u32 ver_ena, ver_cap;
 	struct opts opts = {};
@@ -446,8 +447,7 @@ int main(int argc, char **argv)
 			ver_ena = d->psp_versions_ena;
 			ver_cap = d->psp_versions_cap;
 		} else {
-			fprintf(stderr, "Multiple PSP devices found\n");
-			goto err_close_silent;
+			multiple_devs = true;
 		}
 	}
 	psp_dev_get_list_free(dev_list);
@@ -457,6 +457,10 @@ int main(int argc, char **argv)
 			opts.devid);
 		goto err_close_silent;
 	} else if (!opts.devid) {
+		if (multiple_devs)
+			fprintf(stderr,
+				"Multiple PSP devices found, choosing first one with devid %d\n",
+				first_id);
 		opts.devid = first_id;
 	}
 
-- 
2.45.0


