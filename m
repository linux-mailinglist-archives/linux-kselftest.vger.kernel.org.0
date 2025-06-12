Return-Path: <linux-kselftest+bounces-34795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECACAD68CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 09:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3F17A1FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE2221FD0;
	Thu, 12 Jun 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xd9pSVgn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C121129D;
	Thu, 12 Jun 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712797; cv=fail; b=WSF6VQpS6E1L8psEHa/pHcxOOolDK787l3jWnzDjRFpU8KE365LtCyl+K8iCUyiGezTMwCDYEPhUizN3kxjkHq2D5Fhay8FLPjmOrY76PoirH11ZsP6qVZcTI5NbHUEucQTDKG8Th02StFIRLbuP5x5UGWcj4MIE9YEsq6dwkTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712797; c=relaxed/simple;
	bh=ditkKLmTwMVYrVSCLinzH0M/xGuUoKUrKY3k87Sxrak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRu0r5pxngkUQcZNfS7AUTybKgTc4sobjohtCspk2X5ETpbrc3sXgj2+WxaaStixNNuVvFnAEyw5EtdgIaCObmdr70eIvvjhghC0fA+TqsJo0N9G4L7AfEn0G9riGsCZ9oI4sLRYCWZ+M4Pc4FPgIOai3/XJc34BXzh60f9TTvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xd9pSVgn; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2FwMogsuVEnTbloCMT6npC5rw95y0KytVR6+sTePAh5IbyG9yFBeoV+fv2Kv9h6H28M/Hy7Y+WWAqC1ilDceJUY3xUDsns2+XqeTDnhDV6n+siD19dt0ze/DCeT4/Ns5OaqtetzEDeCEr4UBLKG9VoWtzDx3t5xWzojC/42duzyQYsC+XiKJWcKPeom4qr9UEYqUjsRAQCoSKB0LzO3PUKsk+m/Ow5SU0KXJbs+NnaMJgM5jtlcr7QdgHih9JjqNCIXv6wi1NxryJ4mWUmCMHXH6Tbml4MHfO9Vz8GIjGrxhJGxF8UUBC9QDT32gUma7YrSQWz6vRPpZWTQ4zz/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju+eTjZUwzyydxuPMYRRrQjh+HvMpAYG0bLNmkGmcpU=;
 b=BKOu3GzEdOjtSPl1z+P1vn8PzSRwcq4C/k7IaQdCK8O4yr3lFnzh7U+OXUuQY4OQXdZGtJFUBdWBzvoo9EcmBz8vN01f0mwMkIQyfDN3oDs42VIFC4bTkIOFMb58QIafjdFosfwYlnCCiJP6B3QS+rUZfxZ1Ws5odXkV5N7tqUS2Ni20ELhbEo1acq1AZEAotYVb5DEMLhpT72kZWwKnX98EI89rjUmEo/flNghw33bKl18UoSUg01kAurlz5zptb8uDnVJb8c3jBDfNvnTC+vAWnnjxF7HjuqjIMJyissWMVOBkditoRMrkq/jcMH6Pn51MiEsqHKZxHTpyXQSg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju+eTjZUwzyydxuPMYRRrQjh+HvMpAYG0bLNmkGmcpU=;
 b=Xd9pSVgnX4Fe3inXZkWzX/bQYd5Q9k3Ap+Qf+qaUybSi7vyT5Edub5h/OjEHFOH92ARWC+ixReiRiA4/QeWWGVAr7B4a5j9/q8zxkLEeyIXAHhRngSenf7W4gAl93z9d0b2az8pV74yaJ7zTn/GXJHIesZAh3b0ri0sOroMYrmbAT7fVbsniXtcscxTpQA4n72wwmpyvLtSIlMrx3OG22yA3h/TkRcXbsyQMvP5JXpQK5DZHpOX7Z3zJ/0qsz622H3nVqUKQ/brPmB6lstDgHri20dBexRV21h8GM77PeijfasHMDpRZw12bICcRooiACNbZIvHaPhZHlYmw9hElZg==
Received: from DS7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::10) by
 MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 07:19:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::e7) by DS7P222CA0030.outlook.office365.com
 (2603:10b6:8:2e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 07:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 07:19:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 00:19:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 12 Jun 2025 00:19:41 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 00:19:38 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net v3 1/2] net: ethtool: Don't check if RSS context exists in case of context 0
Date: Thu, 12 Jun 2025 10:19:57 +0300
Message-ID: <20250612071958.1696361-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250612071958.1696361-1-gal@nvidia.com>
References: <20250612071958.1696361-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 14991fb6-22d1-445c-735f-08dda98185e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aI+B2GIsOLE8ukA6F3pNZ1ObePTyXHqx4wx44Pp0PO192FIgD3XGZMYrSJlf?=
 =?us-ascii?Q?Jgwaaf10zopJvxkv7a5Y5JidscophieFRsBXhS+T/3aKZmoKcqBqx54qHRmT?=
 =?us-ascii?Q?/FJfJQyEqUnLVZKqa44s+rygMRVeiZbub5sEjT9BXRePbJjlnF9ItgqvzbfH?=
 =?us-ascii?Q?h/ZwlfDf0PuuHtsr5LNh6AE6yVz9AJRdPOTuDdZ9Y3kjB3XeqD37ciHl+3A8?=
 =?us-ascii?Q?HZcz+sexccdwR7wVqsZnA6rsbjVZiixLwX6c3Qs3/hsFMAWJVT37eOGyN+zw?=
 =?us-ascii?Q?Fls2GR10oDtCL0oX7CKxTRhYlJMSjhDBADl+PCuSrpJFt8O/otiddJVPEKvJ?=
 =?us-ascii?Q?dcIN/uZoMkUE3+B8kY8hAJSyUfUDvfHGzK6amFEo28jpdOH6mPNWySY54v5e?=
 =?us-ascii?Q?0n9h+IiovlOXoMw/wtGmZKDm5A3Ndqp6r9kFX47lj+Zqmc41q+rypLiHnlA6?=
 =?us-ascii?Q?Fbu9zEW1iH5A7GQTk90fm06YS8O7pZwlWo5p0Mb7+NHnuKZp3NWusul01XbW?=
 =?us-ascii?Q?CWQOMs3GJib+bRZVrmXRKafs8pEOGRRACb4iIlk9fC6Qrb48/yoDGBcOLOyP?=
 =?us-ascii?Q?RGTmyNpgp9WZXsQOUxUNUqQRuBUl6ECAwvehWJfOsBZDFJqZHBcJOsuhIZEk?=
 =?us-ascii?Q?xOhOvzkrhAotdrii4Plv68nhIPQmfV2FLsMYORPfk+bpNB+Cz82NKeH/IS5Z?=
 =?us-ascii?Q?pyXkY44Ng6K/6SGCa6kCUA93On+/BKPHDNTQet0jKY7dJy8woSOyPDrvAugV?=
 =?us-ascii?Q?vTMr6kkcf2ouvUORIBkHRKy5RQVxN05Ia4zCa3bFKPWvih412EfYjeRJp3U3?=
 =?us-ascii?Q?EDuRbRIu26YITeLEJ3J2Lec29jyHVtgzP/XA21Xm2F/ZkFH1++gX1OXjM9Ut?=
 =?us-ascii?Q?aENd8lC9FKBIs2yN3FVh2Pp/hSf99zXUPjaqnaFDBwuKY+pMf/5ODaSZDRi6?=
 =?us-ascii?Q?u2NB5JuMBYY1HGhQV2XSIeosMJ9c+gsYgLGgXj0pQz4nr5ji45kVnBQrT1/T?=
 =?us-ascii?Q?R/IWNnlFeJ5m3DBdCvHp4d/EfaucmNl5mBdWCUcQiwUBw35oi3Oddeec3i+1?=
 =?us-ascii?Q?tHGhrCzr2qCI7G+H/6IpQzuPyooAeL3VEi3KlPbU5x+xpwDmARc+8r+prNM/?=
 =?us-ascii?Q?NywtjqHJZIZYxD2TQlDXJ8HQHOkCve8aglj/yQXDSFTp3bp/V4C0q1mejMQP?=
 =?us-ascii?Q?NQbnkKLpnymrH48UUzaxT8NxuAAcPzXxDgpbHzGHwdJkVx3F+EXsguOquxPA?=
 =?us-ascii?Q?oinmYPg7YiSe0lLKiffAMNe9EyiSNLxuMObsHNulVNNKi3SqOfC2VwU8Qir+?=
 =?us-ascii?Q?NwhyYFhsE3nZIY6oT1M/JM7pd+MRwD1wTicMGfAYd4WGG70qbTMwoOiZ3Fp6?=
 =?us-ascii?Q?iluzKeaCZPHHbHWVVGE6lP82504EMFNjwg0zOWkbwqHhW31LcBrde0EQcjkh?=
 =?us-ascii?Q?ObcAKRGPYq4yFlp57S0ey1P84ZnXESGTJCh3gr+SnbKgqllufR+wwIF6bDT+?=
 =?us-ascii?Q?Qy/2vSh5i05oY+dOyGwh9EvO3FZ7hqedzFFR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 07:19:51.7356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14991fb6-22d1-445c-735f-08dda98185e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

Context 0 (default context) always exists, there is no need to check
whether it exists or not when adding a flow steering rule.

The existing check fails when creating a flow steering rule for context
0 as it is not stored in the rss_ctx xarray.

For example:
$ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
rmgr: Cannot insert RX class rule: Invalid argument
Cannot insert classification rule

An example usecase for this could be:
- A high-priority rule (loc 0) directing specific port traffic to
  context 0.
- A low-priority rule (loc 1) directing all other TCP traffic to context
  1.

This is a user-visible regression that was caught in our testing
environment, it was not reported by a user yet.

Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 net/ethtool/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 39ec920f5de7..71c828d0bf31 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1083,7 +1083,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 			return -EINVAL;
 
-		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+		if (info.rss_context &&
+		    !xa_load(&dev->ethtool->rss_ctx, info.rss_context))
 			return -EINVAL;
 	}
 
-- 
2.40.1


