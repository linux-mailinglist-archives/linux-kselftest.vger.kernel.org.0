Return-Path: <linux-kselftest+bounces-48191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C2CF2EA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD5E307DBED
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F452F28FC;
	Mon,  5 Jan 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPYqVnIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCF2F3612;
	Mon,  5 Jan 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607527; cv=fail; b=fiIvcPozmOlCdqBA0HCQMNdrdHBrMnKxXGJuEY1ZXkp6QnGgJ6QcPssIaiBFRpWZb20pIzzzs48H7YEYSLif6KumB/X/1fE6J+xrKDK+iuJk/x/I6EijYAMlnkKhQMD+YrsgZYnqOu2wHt/417F0lb4+ACD7wjIcIFku4PeMMDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607527; c=relaxed/simple;
	bh=biEwPw3uAfPma5ZE1kmvp7zS5m6QFF39oKWK2ZdAiXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxU2BJ8Ms81NWQ3mJ3Cr/AnAaeuNFWF6zIBBiRBwSn1EO7tXDgqpWAPtBwev0hLInVnGHcxq/sKE3p4FkCeZr25OgaRDSYA4dNlhJrYNUDh4Es5VJXujR5Is4hU9o+FP6OkVGZ2E6uGCKDvnXOCat6+i17nQkI/QXXaorKU79m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPYqVnIh; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH1/3ml5LlYox0w6I3nsdwU1/4je05oFGRZTX9vV7CjAJB9ym2Ss0Bn9vBjAF5qJfAkKXvtvUlM49RezlBMFpUQV0RqUk/7CLtRRDJWQ1H6RlpZXWUsYpv0Br8y5xXrX2r0SgNg1IOp+3iophp7QUZFErgoGJZJb+DDOKFQqfanYRMVRZ7qRpLtLtVr9W0YbHZPdQZtHcRJ5fSvslRLhuQv5gADvsPkF8ik5eN4q/qJz0taEPhs5gUiv6dmNcz8M/v6vfBqWvpiMkxngnwTGNXxmUrq4f+oonsY5/fQ4SunGu1vrDZoeEoy4Q4bavzEnjajAdzkDrH5UACUQqzik5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqOK3omPNIVx6NMrJbapMgBJAlHOg/oserEzvXR9nWA=;
 b=jEvV1x08YjEulWqJf0KMcBBRSSt86reMelEaR207o61kv0d3IG/AUeGCb+Kd1pJ8eGtWn+TpGZv1croADxe3VLVaNwCQt57TUZFSxYV3ot/IaEFxXcTMkMpA1Q79dIV4LG3t0aZuLIwgvxa9TpnzZXksi1HCX+GhJihmUJFlSPMZwRvoHUTsjB+s/3mr+3hf3ybSAK3rCMpGtLIBnAKg4Dinq0Jv1NVQ+CMvLVp+UQgVLJ+zaPdup9fk5HXPr5yC3Du2FsV3sRms0esgV2Zu3UPGEiv9kjPSDrD4h/aODVcfYkZ7oqRmD9BZu9pKm67lJ4XKasGEEhHuZXapNaI0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqOK3omPNIVx6NMrJbapMgBJAlHOg/oserEzvXR9nWA=;
 b=jPYqVnIh4NuYIadGPj7fDRvDiIid7L4/YgYPFKpojM7K2BD35hwKsmFoh+7/CKQdswdNOQW+1TvFbl1H4sZbrLgmBQDfag6PGPivEGGRvHE/VJ4mLIiwClt+ZwpNyU03NZ4cW2AEWWJfsq1q+mOXapeW+ZQ6PqgGeFvk506rESyWnDKEUTYP+N0GhWCySa/zHl7xhyUOzjE+iADXux+dMaj7I1Y3DbSlkJdTH3PlSrbanXzSKF0nEoBwyH97YY1oteaydWRxKG+BvfL1Chuop2+4/Ccniuz4YArebyKnksQp8hF0GVmnv44zQt30O23Xy39f5b2KTgZsC9XgsgFj/A==
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:05:20 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::c2) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 10:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 10:05:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 02:05:06 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 5 Jan 2026 02:05:02 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 2/2] selftests: drv-net: psp: Don't fail psp_responder when no PSP devs found
Date: Mon, 5 Jan 2026 12:04:24 +0200
Message-ID: <20260105100424.2626542-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a21bc44-30e2-4763-d020-08de4c41ef08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7G+Zd+9KmK0BFG40LDM2YkTrRueICNGvCB7ql1uVa4Db8jmNzCRCvXbde7vl?=
 =?us-ascii?Q?Mxi3jteRtIcQXbmEIcsafY5pxb9u2Ni/AnZmdxg3RMJgefwBdxg+y7rpPXmN?=
 =?us-ascii?Q?prWA5we9oBaeK48qB72hRMKzkue6fqIFoAPTBKhpOtB+NoAD64g4+VwMgOYG?=
 =?us-ascii?Q?kQQPp5NjSJNLmNSKhXLMx7YiJ81GYYzxMgHgabhfgVTZk47EqciOIqox2H2t?=
 =?us-ascii?Q?XiQW3uBcl7POoYcXube0QLYedzKHZjy9W6FkG6LsVCPiZoaMcBO4BrIVz9zG?=
 =?us-ascii?Q?TD42UsOTC2s5COO1hixzPpseR5J1kyx6DKyFogAc6v3B/aAHcFE7tAZ8BeSE?=
 =?us-ascii?Q?YxN/FH7as6zp/5XdZFj+xhGUkgvOyf3kzIm501rqh09Ds6GQVPLF3dzBBTRm?=
 =?us-ascii?Q?Vqi9N2JSfVNt2dkv4ZoaZQGF8ZnRmybq/jDc8/Ro3nQIYzrArAKiVeMaozDe?=
 =?us-ascii?Q?cl+JMOWipLd/AQXW77cQ2kcpOvEPn7NIFL4OzoIWctJUmo7GNfdUJSZTOtqq?=
 =?us-ascii?Q?TEDka94c1lBtXbzu1fTRgv22EXSgI1sNf+/GZV7Xk4vVB+cK5Y/SbH0cmzGu?=
 =?us-ascii?Q?jTalbiq8D9v8pS9iaN8m6OzypFBTVq5KMDyk5gr7WzbmSE2OCnxJgGNydtjQ?=
 =?us-ascii?Q?YHk6bAksGb7HIZ8n+JfPOxGuNAdMgwEO0TFi1xc5xbrfEvb6QKGCWxcWgONW?=
 =?us-ascii?Q?ZOrclVN6AwiQMm6NTfD6qxyzst1xI4tv5FsLao87aEGy/MGSqyi5zqbvw5zc?=
 =?us-ascii?Q?ivmny7J5iFU/GCdeNuyJakkL+YK2SEy36PqepK6lQ6u2+pn+qUtWLqACj6UT?=
 =?us-ascii?Q?hld7vhoNgWVowu4t4s5QbhxvHy4vVmZuZWD/9lDVBfQ9nDhqAULUF0MjnhDq?=
 =?us-ascii?Q?8Vixf89/j+2+wjNj0e3lQvfpk8AFK0Z4bISyI0+95Wt8B/Cd3oDvpaghK4kp?=
 =?us-ascii?Q?a/O0lYHdhUz9gblFaJKhRRUgOFp2zL8tRpu3A3GFAuErszbPvt8tj6kcWgnG?=
 =?us-ascii?Q?K5k3kwmbsO3fDYBjztft+xK1ZD2qlZCb+lIcBBphasYOPHrdtItBEYyezb6g?=
 =?us-ascii?Q?TGRKhdgx4YH40YUooogwP+95y731sAfPgJ0K+k8H8THukiqpm0HsqmRr+5B/?=
 =?us-ascii?Q?m/kDnSozHPifxbNtWzX/Rq4ErzOUKYFpW1EmKAvTKAiPWPFOPzC6Lx9dpfxW?=
 =?us-ascii?Q?Y3NuNT7L2SMbRlYzfzTKALab1JLjbdIRS/WBDrHZc2rzM+pOuJPGENwSSv/t?=
 =?us-ascii?Q?soNVSYx7x9kMbyiLwMg9WDgjUwQ5CnS1eiIFyZBLg9m0CsjfLncXWsdaQSR7?=
 =?us-ascii?Q?QiSuzWzGyPtBxI75rno/rCLkst61boBOw7SUJiWSvj92Z46GaFITJ8kFWN/A?=
 =?us-ascii?Q?07y69Qb1abh4AcDkol/oIPk/J6ARJT5D5/HL4sz3E5QvfpPo84H9Q/Vkqvb6?=
 =?us-ascii?Q?XzP41c6CbZ3D+ktTWb/kiI9+q5UF2caQoSEvZcsUPFzDjUIWHeHfpBDkMuxL?=
 =?us-ascii?Q?nHqv7lhPocWPHqtaCifR4V+6t6VC1qI0aKB+5C0cqg6qLhadirIe0Wsz/4o5?=
 =?us-ascii?Q?JLP1tLvmQiOYguWwDpU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:05:19.8827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a21bc44-30e2-4763-d020-08de4c41ef08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

psp_responder, used in the PSP self tests, fails when no PSP devices are
found. This makes the PSP test time out on connecting to the responder
and throw out an unpleasant Python exception.

Change psp_responder to open the server socket and listen for control
connections normally, and leave the skipping of the various test cases
which require a PSP device (~most, but not all of them) to the parent
test. This results in output like:

ok 1 psp.test_case # SKIP No PSP devices found
[...]
ok 12 psp.dev_get_device # SKIP No PSP devices found
ok 13 psp.dev_get_device_bad
ok 14 psp.dev_rotate # SKIP No PSP devices found
[...]

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 tools/testing/selftests/drivers/net/psp_responder.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
index 8d2bad134e63..b240888068d3 100644
--- a/tools/testing/selftests/drivers/net/psp_responder.c
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -430,12 +430,8 @@ int main(int argc, char **argv)
 	}
 
 	dev_list = psp_dev_get_dump(ys);
-	if (ynl_dump_empty(dev_list)) {
-		if (ys->err.code)
-			goto err_close;
-		fprintf(stderr, "No PSP devices\n");
-		goto err_close_silent;
-	}
+	if (ynl_dump_empty(dev_list) && ys->err.code)
+		goto err_close;
 
 	ynl_dump_foreach(dev_list, d) {
 		if (opts.devid) {
@@ -464,7 +460,7 @@ int main(int argc, char **argv)
 		opts.devid = first_id;
 	}
 
-	if (ver_ena != ver_cap) {
+	if (opts.devid && ver_ena != ver_cap) {
 		ret = psp_dev_set_ena(ys, opts.devid, ver_cap);
 		if (ret)
 			goto err_close;
@@ -472,7 +468,8 @@ int main(int argc, char **argv)
 
 	ret = run_responder(ys, &opts);
 
-	if (ver_ena != ver_cap && psp_dev_set_ena(ys, opts.devid, ver_ena))
+	if (opts.devid && ver_ena != ver_cap &&
+	    psp_dev_set_ena(ys, opts.devid, ver_ena))
 		fprintf(stderr, "WARN: failed to set the PSP versions back\n");
 
 	ynl_sock_destroy(ys);
-- 
2.45.0


