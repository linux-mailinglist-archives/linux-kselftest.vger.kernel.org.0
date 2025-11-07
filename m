Return-Path: <linux-kselftest+bounces-45128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF05C40EE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7B3BBC1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115A3346B1;
	Fri,  7 Nov 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDTajDL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7133438C;
	Fri,  7 Nov 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534192; cv=fail; b=aE1oM5jcwtpm29xJ7vZ1FzIuTVAifNAoGuidAjf95K10e1Z6x1JvDPyjnFjFPN+kR7U6gRVDzQMdU8LZ7c4VZmChyX6SSdR6vRKuUqmyjDOtg8dq5a8B2/g4AD7mRAr7vVfARwiTRw5U0DCDW/sE7YKY/S2rCG7LbbR1ZfKulS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534192; c=relaxed/simple;
	bh=jei3G/126/y/ZjZLdAXXT3ErlU+muBHBWWLV/q42xpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQEd19jVbllxw5nmWJ6b8pXWaykHdI5sO52Sv5a+GvatHOzoMT0VaSL3gIOWA6659DcUXz2rV/M0K8132/v8gvx/fxQYEnjEiUehtl35cRI9wCvD9Iev9VtzZwD9LxMaEQ40YglyZTYGhsuz8ygSqWbhQlPxrhfEyQCA2k82OGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDTajDL3; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3fX1jOi+3Iviccjb2xVnOHZZQSUwjDY1nMlPWgrJyAXxv2dBlcM/HWYlQfAfdO1eQc+KY0uif1LOWIeisvCI78x68j5k16hk2QCxSb69PaMGzxy46eaJ7bhk2V8cyN6BUXqbTLbz6/ZJFturMiaY+Q9OKEaPFmbB+zIJIC/ZJP6JXLGRzm0LRvVFeVf00lU/gSzl5XpB3VxeExr0eG/3oBV5VHLD1IbP1kcE++JsXHxUSqsWCLJ5C7KO7aHgFTEFgfZoEqc2RRe5PIfX7TXBFk/s11BVDx42j/F9imis2Uu9uRv6TENUsXMXtzd2Xs/7wZ0YzIBXEFWXfyDBv+jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2thxiYpp4F0gQwybFdYqHsysNV0IagS4100RCONiCuQ=;
 b=ONlgm3DeKjk/3WNup6VxRdyVG+pc63hsryISWsYvKBRk0KXiVFB62SxHcIpfZuYzxMfwjI/3bU+outbgZea0Avs89yCeoP8g3fedhrE0OCWjAu9xOY/AFsYqseXQDI/ZmUmFl/r9VO+GfDdHBJNo7FWynslbTIDfBnD75ShfqD/X1uuodRwpOQ5BXH/bfasBwYwXvpudRYcAJK/o4mH8arzM41LN6d4OEjxHzKFOH0z5+vIyXunHbcyVoOI5HCNK+bUofqEXaryZ/xV5SPYLQJAejcaXrWjXwQ73nv6r6hstlKDRcqy4rw+NZn+z0/0qEw/QR/MPRkeNW/jgYPTaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2thxiYpp4F0gQwybFdYqHsysNV0IagS4100RCONiCuQ=;
 b=uDTajDL3qFiqVEqUB2qNlp9W53jpc35AwV4JmVJZg5CgXGh1cZfey4nv79gDCmAn1aX5oMLuz8yEPnUFDU6LIZPSxuHOWaGAT+LcCzhWcTSwsyq4tj3anPAtDjoszr+N8u9ycwPWb7FD33GEV3O9OTL3nE+Wky54oZlvgJhiZD0lQpE+41LNic7c1oA8dp5Q6ThZpZgfgUui0ySSGVLEBiuUEo7UrFDLb4OMdnGfHdN4p23vcR6C0HWcccjmLSB494gcGFiZv5fIZ5HvGXskiva4oixBUd5dCWOCx7p2Klp3anEVr9xBhiDjqpntZXWTXITEwJmcUr+8rMiqmWLKeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:44 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:44 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 5/9] iommufd: Allow MMIO pages in a batch
Date: Fri,  7 Nov 2025 12:49:37 -0400
Message-ID: <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe785e9-1044-49c3-c982-08de1e1da636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oM16C7mfNFBH3gsmr39KgrFeAgsNJ218qoTtey1vcB2Lwqe6xSBj/XgRuZkQ?=
 =?us-ascii?Q?3mQdGu6N3Jtoa2uhkSTYGYE8wunhT2yK3Q0hmj9bjcICRnFH05acherMV4cX?=
 =?us-ascii?Q?XUwln2JcxQOnGVpHUj0vP5o6Z2s7aYJ5v8h45veVIkywx2HWtbgNY77QKiRN?=
 =?us-ascii?Q?Mes5+ghpBF4HZyZr4iOQre8rZ39b5pXoKiaygtVkgEPJtZBWLrPX0ZJlfz9U?=
 =?us-ascii?Q?BULv5aEAPDKRqQriG4WGQN3XWLIbNCBY6m1cfD0Sfxun6p0wRG0g8N8wngGz?=
 =?us-ascii?Q?OmXZYlSuzrvoaPT1dL1GQ/NXQG01x9nwPyxpH0IS57OD/eDFneyJ/kVVqn0T?=
 =?us-ascii?Q?pVVZ0ZfApBkCK9prKxu5uOcEY07+Vrdm3bais0nQgTi+TdLHez3PSMNg/U8E?=
 =?us-ascii?Q?G4gUGgK+cy5bElanXCwW+QB5Q/2Vh6MNvEhcRBB3Z2CQRUQg2QczxjGHJvMM?=
 =?us-ascii?Q?sCYjoAxmxR0nMPXDxy9yWRmpUaPpBUg5C4j7J458tsmJWNo0rJfwcqnuvDaB?=
 =?us-ascii?Q?+kZaikx1gMLZ8Nin3c448noASng1bF5aP+dvqxAtcH/wsjXtGGLaD8w+EpsB?=
 =?us-ascii?Q?SjEEhyyhDGdArDMSqRIIFbAP1aI/NyrZlsP2rZICOr2nlic7L9gfjLAI1PYS?=
 =?us-ascii?Q?ve7c9kd6gxb4B9K+TBBzSfFpq3lilP+HFfv3N4bXtA0z+l9NjUmRoD5CZ74c?=
 =?us-ascii?Q?sn0+iXazDCcVRs7WK4xNWXgXy4xAPUD16ze+SyCehwdgpIcivb1oihL0AIwV?=
 =?us-ascii?Q?P1S6v8rRBJN1g9RhvS1RyDrcDWLTHBzA3HyB7GE96amdhd1trgc0zPNma1w9?=
 =?us-ascii?Q?m59DWK1M4/ED/3UKviV7xU6iDSiOerOVXpFybsTOE8enCsw30u40c8ew0q5V?=
 =?us-ascii?Q?oc+E46Y+9kbdVCMNkQf0+PKkxQ2wTZ+i5L4OuV+L8jBYjdU5PxGAy7jmOn9R?=
 =?us-ascii?Q?m3ayGTBlR+HPLiAu/J1KKkFsGtSGor2Yt7vC7HGfn+NI7YLfwlPFP5zrfKbO?=
 =?us-ascii?Q?eOkg980kjj5r6R8SDitun4v4SNBQVavicSzkb0ld3494lSFDcRMYo4nkj1YL?=
 =?us-ascii?Q?i1FXcawoWTydcH+RAaUCRC+59oJxt2z+/4oryPnqq/4Qk9l1afx4cjiGSGPP?=
 =?us-ascii?Q?dHfevus2FNWZOTED+p4nCbUE7IMIGqgkrGmzr0eqsHL/fg842pMWvv7OUhPK?=
 =?us-ascii?Q?KxMM+PkwK617qSog8p4QPt7L1Y5xL2Cw6/KMCLHoglB0ABSm+dgbjyXQkyMx?=
 =?us-ascii?Q?XRvsJJAKPLw9jlT4/MZ0OOaSpyyxxeXmoBxoY3lkJJJziCsijTrJAqZEfvuk?=
 =?us-ascii?Q?786LRPKkmccxBsenoeUJLoHtchJZaJsqXqTf/FhkN8EQavPZgavd8WQ1Yvcx?=
 =?us-ascii?Q?4g7AhMuNMv0i/X1I4MpDks4ogsRUPeuvKUu2xe6jInHD6VDSuTdCFzh0SWG3?=
 =?us-ascii?Q?Q8CbxK9YcGXXG+e3Fr1PFCVeNOFNKR7rckE/DDrZMLWvFqTWGaoltBOYhEVY?=
 =?us-ascii?Q?226zq0Ak7wTU6R0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYXnjIFbMthyCfi6X+2bGJ/JlS6P8EeWy5q24CGztkTS0LpHKEhBInnTPaEp?=
 =?us-ascii?Q?OvpqRia/DP+MqxGBc/v3aC1GyAMyAEjtcjisErHrL2F7x3u6k1xd+Jy11fPp?=
 =?us-ascii?Q?SP73paLOrObY2iRm++PRWUczn5M/FC/YXeii6aq/dcOQ0GD/8jmQR+jARqsw?=
 =?us-ascii?Q?28i2fpnYWDrX0fwD19ixDHNwjB/e2Ck8HTUlQ3FXWdO8CnTFmhxqHX+HGC0c?=
 =?us-ascii?Q?ZgvRT8uLTix/6m+15i6mcA1C6kxcwaVytmBN/IcqzeaOBnyWvTvmd/tPPoWx?=
 =?us-ascii?Q?iGJM//Zc8FVXDclJexiDkkqR3AnKkEYmS3Y0WdkCJGYtcCx9Ijwjhd6AjtVn?=
 =?us-ascii?Q?aOEJf46SJyqFe4BU2rNK6S7voudzrbchTA3UZyqMwUM2r/mTflkVOv/UeEKY?=
 =?us-ascii?Q?SbKHaaAD45gFd6g5wcRpDER62IYTdshvOGWkpDDNLjIFZ8rGQhG1Rm6+wXWx?=
 =?us-ascii?Q?/9nPxnGoJRcViPSgG5px5tBJSeaQe59XXmKayz2REpk3asXtWoRkuUJIyj+k?=
 =?us-ascii?Q?EiDvMEGWXlxB1xjaFBtTywu8F6Iex8ynCn+Ts+3ooN5JytIfcrfyBohuhLwc?=
 =?us-ascii?Q?cA9Au2aHGrNrbD/zHd6SI8ylJCpSAaqB20/WaDA0P0p7NER7GgvpcymOfYhF?=
 =?us-ascii?Q?h+p2nDTosD9DA/T886CTR7HhH71jBAu24JutIm86NK5EL22zVfelJy47iVBF?=
 =?us-ascii?Q?sGu6zZLAJ1m7R/WYRWDSv/y3plMTSTFZpn6Nx045iBWBYqjORZRsArungcXu?=
 =?us-ascii?Q?JdO+MYzYTSBhrtSMynX1HnpMEJ+YwK5fkzcz+n0p2RvBQ56CJSGFfxgnRq86?=
 =?us-ascii?Q?H+KkjD09BW2OIcmx4njX/AjFrTQmw2bvOiculJ0jt9OEkp84aQ1j0nilvY+m?=
 =?us-ascii?Q?6a5drOKKr6fHyB1FSFoIrpA3CE+o9EWvTgG74n10G2woBaAYKmGDexcCUwui?=
 =?us-ascii?Q?U7bD5rff67OnN1QQUDEQwGURSRn8yi8f7Hpojb9g48TJn0wZn6XqvqAk87qQ?=
 =?us-ascii?Q?h4ltQ9t+zTyPdrosqqzWciZFd1i5XM47l4TfUIQl+P485p5jG7ORvgDwvMJE?=
 =?us-ascii?Q?VCcc9yNsOlihVIZ6foDSN+iQoNee6nLr4ZzDEoz9DCLi4DoSu17rxLFDqh7Q?=
 =?us-ascii?Q?eopm0dZLRS4rfrGTilIm88EEtBI1fkoqksB85qQExo8SWCFdVWgSUyVHTMCZ?=
 =?us-ascii?Q?JCHTlZ0W+43cD1nz8tHrdIXhKg3M3X7idVDQYWqShQIB5vzDljxBkRH5h2F6?=
 =?us-ascii?Q?OKs5zTN1n6TkCeq5QdXoBDaaykrFtvNNriV7XOfLAYlNGDbyM0/qoL73zxwY?=
 =?us-ascii?Q?pznS4dfxSKYzbGbtoWZUCa0LmoQ+cnRiymYov6e9i6n3aMNWak7spx2dELyc?=
 =?us-ascii?Q?Ho9cdWmLOslE/36fgrnJRzDj2Oe4/YtFjmi5zknkJ9V+l91OhAr8JRX/w67U?=
 =?us-ascii?Q?iad2s41G14RTxlTofq/2UKBPrg0pECk8ztMP4c1IZLIKWtQtTvxip35XIvwJ?=
 =?us-ascii?Q?LITb3yosYetnBLfZUxKCxjazx/otcfIFAbHeuuG0xBkSE1EaTvnNBWOg0oAp?=
 =?us-ascii?Q?e+mUx/QzDdyYZ/xXPU0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe785e9-1044-49c3-c982-08de1e1da636
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:43.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIsVz1vCooYbvY+10s22kSWYoKGA9+NPibJg7427gKZ59uDd6LtBfIp7J1rmQ3QE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Addresses intended for MMIO should be propagated through to the iommu with
the IOMMU_MMIO flag set.

Keep track in the batch if all the pfns are cachable or mmio and flush the
batch out of it ever needs to be changed. Switch to IOMMU_MMIO if the
batch is MMIO when mapping the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 97f5a173122b4a..e71796b0c4bf44 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -261,6 +261,11 @@ static struct iopt_area *iopt_pages_find_domain_area(struct iopt_pages *pages,
 	return container_of(node, struct iopt_area, pages_node);
 }
 
+enum batch_kind {
+	BATCH_CPU_MEMORY = 0,
+	BATCH_MMIO,
+};
+
 /*
  * A simple datastructure to hold a vector of PFNs, optimized for contiguous
  * PFNs. This is used as a temporary holding memory for shuttling pfns from one
@@ -274,6 +279,7 @@ struct pfn_batch {
 	unsigned int array_size;
 	unsigned int end;
 	unsigned int total_pfns;
+	enum batch_kind kind;
 };
 enum { MAX_NPFNS = type_max(typeof(((struct pfn_batch *)0)->npfns[0])) };
 
@@ -352,10 +358,17 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 }
 
 static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
-			      u32 nr)
+			      u32 nr, enum batch_kind kind)
 {
 	unsigned int end = batch->end;
 
+	if (batch->kind != kind) {
+		/* One kind per batch */
+		if (batch->end != 0)
+			return false;
+		batch->kind = kind;
+	}
+
 	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
 	    nr <= MAX_NPFNS - batch->npfns[end - 1]) {
 		batch->npfns[end - 1] += nr;
@@ -382,7 +395,7 @@ static void batch_remove_pfn_num(struct pfn_batch *batch, unsigned long nr)
 /* true if the pfn was added, false otherwise */
 static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
 {
-	return batch_add_pfn_num(batch, pfn, 1);
+	return batch_add_pfn_num(batch, pfn, 1, BATCH_CPU_MEMORY);
 }
 
 /*
@@ -495,6 +508,7 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 {
 	bool disable_large_pages = area->iopt->disable_large_pages;
 	unsigned long last_iova = iopt_area_last_iova(area);
+	int iommu_prot = area->iommu_prot;
 	unsigned int page_offset = 0;
 	unsigned long start_iova;
 	unsigned long next_iova;
@@ -502,6 +516,11 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 	unsigned long iova;
 	int rc;
 
+	if (batch->kind == BATCH_MMIO) {
+		iommu_prot &= ~IOMMU_CACHE;
+		iommu_prot |= IOMMU_MMIO;
+	}
+
 	/* The first index might be a partial page */
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
@@ -515,11 +534,11 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 			rc = batch_iommu_map_small(
 				domain, iova,
 				PFN_PHYS(batch->pfns[cur]) + page_offset,
-				next_iova - iova, area->iommu_prot);
+				next_iova - iova, iommu_prot);
 		else
 			rc = iommu_map(domain, iova,
 				       PFN_PHYS(batch->pfns[cur]) + page_offset,
-				       next_iova - iova, area->iommu_prot,
+				       next_iova - iova, iommu_prot,
 				       GFP_KERNEL_ACCOUNT);
 		if (rc)
 			goto err_unmap;
@@ -655,7 +674,7 @@ static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
 		nr = min(nr, npages);
 		npages -= nr;
 
-		if (!batch_add_pfn_num(batch, pfn, nr))
+		if (!batch_add_pfn_num(batch, pfn, nr, BATCH_CPU_MEMORY))
 			break;
 		if (nr > 1) {
 			rc = folio_add_pins(folio, nr - 1);
-- 
2.43.0


