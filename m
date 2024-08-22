Return-Path: <linux-kselftest+bounces-16070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D695B8DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AD52835AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245E1CC173;
	Thu, 22 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g8p/omd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734491CC8B5
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337962; cv=fail; b=DdJZi8pydDswgUkWa1Z62No/UM8UHrQjf3tMxrQXRA7DinEpJopEeNBfKGn2jnugVx2B1LXgcYMgh5q9z1GtDQ+CDZ7dLzpxRZtzp8z8uDD/Gyft/3yNUd9pl1JnKUM9dI27q2uRmnNe6044ciSlRsGljAfpP50KyMX4OOqrBU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337962; c=relaxed/simple;
	bh=9TBFYcBbM90XVDKgV4dzUV2zGri7dwoSiFLOMlSONFo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=osCO1y4ISN5vw3X3WbwL3OtUCpsiKFTz6CGtZziZ3EWbj3DfOXOIpPFnQJS0yHwRe8RCnR0PEDekcEkGhcwH55o+N+ttRT2iYrih9qMBZbfuipmBNP5W2t/n9sS0lpGuEkrRHAkV0QRoUYuXHviDd0c+d4LPP+16oPaJXCYD+yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g8p/omd9; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDBrUdQNPRPmmx6KotrL5WJXI3mf++RLoWY2oOKwrbv8uB8cO+lcRBhjXWULQ0DBRyU5sqtaGGBZGR5sHpEE364YU+lp7HtocLFt6z1sHlBkfahbKL6R2A39cg9rFJnYlqYaMx1NV7tzksCVP7oOXvwnknthVshQFCJ++X32+qjyAmXKgpFQBzDVmYi3CAvyUDBG0ZR6LnouoGFL8n5/AIoNnFa9CVSVfe+RdFUPJ8p3LhQZjEiz48inbXmh7EZqVTeTy85UNRLw9/a11j97KVB524jbhWTrHcbwqtYlc0/hKUO3tefwphD1EaJJtxwBM2wnnPkT05Pa19eFG/57Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTfmH1xYGy35UYf2qFPtrSGTuvFrihILDFY4iKdqKrM=;
 b=c25F1PoNcopCk7IwcB5NQlTEHz3hA1EWAkL9Q7Lu9YRTAzZXR/V65UkElBv5wPKFFFcvqzzFYtavIWFW01kTRF2Z3jEjAwMJnlcpmSJm9RAjSbTZ3ZBrq+HzkDIdUB1KFvfYCljusc0Gw53JY+Hw+12R67/R0tBwAgmrPErfmn07Lfk4jMhqhlHcgpMiwDrq43V9xbvIPvJgV4nToFAKEA97Y6yxKgiaWk6eXk8z/Xpiu/pazahRpTxdTj2N23rPqtnpHZLa/jaGydarmUQdrxooC0inhomP3J9VBaF14zBLR2zf1zIPw6TWDk8Aw0UA8YticAwrJgZrCvBNjpvPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTfmH1xYGy35UYf2qFPtrSGTuvFrihILDFY4iKdqKrM=;
 b=g8p/omd9cg+3gs1f+Hq91jEbOddgvD7LwgafIM8ggqZ8q+vz7bQCgmrrk9hh+vW34sSKnBVbRezvwFuOzgVAHh1xJfSHg4k8l3DxIMuvh45ytkN9Q9nuD/8aal7JhhTX2cvDG7WfMMkPPDZmnBIlMi+zf53ys6d9RrvIhGFlqg3P3PmFptK5x/m+NGySNhuJMDNLjti8twTw5R7gviqpHBJfRM9SCMPrGYIoyEbqV+4gvRYYebMDwskrdBy6Ds8CziUIIkdCNahF5wVp7scw/ZuWN8d5vyZhVHTIM1NRba7sETNu1DIwi0qAfw43l6nqPbwVxzoFu3Bq3u/CDWsZ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 14:45:56 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 14:45:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Will Deacon <will.deacon@arm.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH rc 0/2] Fix maps created without READ or WRITE
Date: Thu, 22 Aug 2024 11:45:53 -0300
Message-ID: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::25) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8bf4d5-4f39-4d2e-6877-08dcc2b9214d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mooxyt089q1Fvm9k3tKfLLLJvr20kYeEWrtmJpuDzIyqgEeTJeWJsICeRWBC?=
 =?us-ascii?Q?5vV/YPz6yqscCyGzifUqjru/cRHb27DUV55I5Ab9TD+ocWasjIZCBEx0NmBv?=
 =?us-ascii?Q?chpk3w4k7+Z09wXNVpQ/4MDr9fO2e3ehHRKlCHYX47tQgx4J+5D3Fhbia9SZ?=
 =?us-ascii?Q?RAmfUTZxkukGu3u1oM4zE3ClvfGgNLL59EIbQrW8FbT12z5FmbpIGezdyBDJ?=
 =?us-ascii?Q?H6vACZN31ins5Gobs6SobfUZYmM1BvJO10sszOGxgAqcKBJuNhGRrQ3UWxKE?=
 =?us-ascii?Q?f4IEvRWVznmOPP4jT8muaPF+33Mt1PoETbImXaHYdlUbK0lHDpBDOVv6cJ/5?=
 =?us-ascii?Q?0tvHnYd1q/3vwRdjTU1M+NZzvFRl0hYIg5HnGXiNIvCkyqGTxjZbDH4ZSf4l?=
 =?us-ascii?Q?+83yy27gq3wL/NsIIn6NvQxEWekZtSfPJ/ipq0opjnXYKwfSINaxo3PPgYXX?=
 =?us-ascii?Q?vog4rDEpUrNGzh4yrU2twZGYPhYj6kqY6cWGtI+YITrQZyNTjj0HtTn/fQix?=
 =?us-ascii?Q?6cxG7gO3x63LRL4Ha1nudmC47s6wjb5e0kAWJBN2p4e7sjIS9zNn1Vgz3m5I?=
 =?us-ascii?Q?4AJz87zZMBz/RpyLIIZSoyUQ946p2xJTbpGcFMJhdcO5OsPvQqWmqnqESoXR?=
 =?us-ascii?Q?WoA2wRHYCdJOp6ij73hwgEczBxpaGEdugSSquftV4r5OQmYm4RaBaWONI5Tq?=
 =?us-ascii?Q?lQChxBOYF/OaWTW5mtbZbUqGYSctf6uk6D2F4MGB5f1f9qXhqg9qJV6rVarA?=
 =?us-ascii?Q?vPvNsoZEFmwvimkXCmBv8SJhy6IddjWp1Rg4sMvk4daoGtnHSXLNIsb2RAyj?=
 =?us-ascii?Q?t7Ck2pljE6YmlhhBEfRt/pzCOPkEDNYuUQOV53SBZBAVhowwDdo44pciieFW?=
 =?us-ascii?Q?Qhn/3QX4UPsh7ulAoGEFqa2h6txRNiu31ylZJMvMcO5ZdxdwLd338gPUHR9X?=
 =?us-ascii?Q?sOwjSIglu/tJ+j3rMQQYSrWoVWr5KmhaUEEpfkDWBXGUrSSrYEGooHfYOjro?=
 =?us-ascii?Q?9usKwxUUcBN+Tdj2IJZzRDg2BOPG3isYRG0Ej1OVY/2faIYdNf+S/uAoGdpD?=
 =?us-ascii?Q?WdtCFpjbPu8xESlImHpk3W2fcoR5vn4pH7+A2rR5gx/Uh+NMYa7VeklRkzmb?=
 =?us-ascii?Q?OLKKW87JMbL6Acd8aQX9kdgixFPT95k/wOoRL1DSbWwDBJo/DKe/FcZtqxkR?=
 =?us-ascii?Q?ME/zdzML6woKCNTbuzfDXaBIhuqjiRtGQ1w+/VtSkiYHx+UlssKoUJklgPrY?=
 =?us-ascii?Q?Q7CJKasdZxNUOGwULDRfGPj8GaoSmcQqSGe9MCF9ZO3eBOp79NAjlgecTzZM?=
 =?us-ascii?Q?8ltvOzaf9A2PfEofKupOXdURY2LoMSIbqRgZWs6d/A+aFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BezPmE0DVdcA6RN9syxfKmq8JhgjvzsNGeUW1L4yjpcQdRg6TNS8w7k6i/Ba?=
 =?us-ascii?Q?x8dQ9gl329INkobcBshPIhz5hpeK4VSbZWaHBcvblR22QZcsF5/Hdy8+FW5H?=
 =?us-ascii?Q?9p9YCxaYqgu0GWs7ybR7OYZoWSmQqCQfjFXJjJK0apPqUVBGkpIzLeImVXOE?=
 =?us-ascii?Q?mu3IU21TJ4fWN5uWuEazYt+vfo7xukryxfYZgjCvY6C/Xra3A2nFAuDJsPzm?=
 =?us-ascii?Q?Is+x/sRowmGw9wJh0K8xvqNZG+LkGh/s7kTJ9N9epQ3cdt8FPGtdsmkY9jTb?=
 =?us-ascii?Q?u8xdOYUEq1V9nkEAdCVkQohEZawQ4uBlMbEDkaCOPkvkL4Gy0p95zybWW0Bj?=
 =?us-ascii?Q?/KJW7fy4Cty5yoFQG2JxhMtEgj808sheozyk92yS/fdFEOyUrfiBHNnTbiKW?=
 =?us-ascii?Q?q1nvkF9alYXH3J0nzv316mFt5/n0yLZCV1iFa5wpHbOKNdqC1GfyRhjeBfhe?=
 =?us-ascii?Q?wDOc8xwMRVBbxK3/fHVyRBlEPXeLXX62GZt0Iy6+NtF4/xmS0BW0rzuVYEDU?=
 =?us-ascii?Q?SNuCgwWcbu2RYCzq9suJd0Yk5JzFnxori0sWPMjfnXuCh57MNZ4nHiOvaBdO?=
 =?us-ascii?Q?FlKvJ3FnKzL7BtAauT0FYm4aR+TGUUKM14ORM2U+ZFOSgH3V7hTZMovW/V3k?=
 =?us-ascii?Q?g0kZfK7/tj4rB7HBl8ByNQeoIMDkEXqI7QkQ9i35p1EYTsRqorYZpIKjFdq8?=
 =?us-ascii?Q?cp5HGNEEftyRh/RFK1427w48Da5fQSIziGLSl6X53M+aAyYSFWeqDADLRGrg?=
 =?us-ascii?Q?f97ZxbksNgss3BdsHZaH5IMSc0eZ8Ji3g/hZKXJXVs8IVPFtTB4hNV0tuxG8?=
 =?us-ascii?Q?cJAXgb2yV+EhLXUTvhCmZL2UyGcdqxESZeTYJ4n1OVKlYv/8GmGOS3P32PQS?=
 =?us-ascii?Q?LUJjc92139E0T52gNHWI66qz1TQ7jvtQCucZRjcTr3E+I3xqINlIb6bJNN8p?=
 =?us-ascii?Q?P6Z9qTRUAAtfXN9brmhnwQTMn4TRlUJ4R21olEu47Y8MpD/FU2jhDwzf6GUk?=
 =?us-ascii?Q?zDuLgER0C2dOmawRrcGy38sYzBr8Q5vCba6bjcwsLpbL0te3CtvkqzE0Geat?=
 =?us-ascii?Q?JLsiRLX8kLBITmEiomRDYQ+YjiwrS+XCdhXkjdUpVxhnxnaGn6I9CMtWSRgq?=
 =?us-ascii?Q?y2A0hHsogEQmElO7nFLC24vDeZkqQUiArZqwj0yt02Yn9wzJMSVCo+3uAeD/?=
 =?us-ascii?Q?gzukAdIIFkLf7bNn7mb6mu0C1+fH/iEUd1nSh/z1I0rMLJUpm6NbyGNjc8LD?=
 =?us-ascii?Q?yb16jwVHh1EXXcW/EQ8txogh+USdPkVYl4wUP7ao+cOFNrPO+iY7j4kmy4rv?=
 =?us-ascii?Q?bNKetxZ1bsDymjwrwnrR0ceuarIBQB1yr4ZOU8KbrmULtH7bx0a7jwgpM52C?=
 =?us-ascii?Q?BVcVf0sDlGU19xx47bdc9ZEy0cVrQbh/KhEIK0/0zZnMGZc+gJwYmwEB/tId?=
 =?us-ascii?Q?ESZvieIZGQOQjN0grzQ+A+DyGrV8gaLCi0opyXrabaw/2XRoEqyo+fXYHq50?=
 =?us-ascii?Q?eX+eHfxPo+Ur2+ok8f8CJLO5rsbFQSET13HkGmwBuQCLRAxEmN8h7NMbFv7Z?=
 =?us-ascii?Q?ZomwKMh86P66ukiITUOxl9vd51EoiDtEPQ0KxOxs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8bf4d5-4f39-4d2e-6877-08dcc2b9214d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:45:56.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHzv8ENAFjAnb9Tlifoo8H6i4Edtm0RmZTIFQUnskMBjS+xYkiAEeZHYcp2/2+gZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

I noticed some bugs here while working on iommupt. Fix them up.

Joerg, can you pick this both for your -rc branch?

Thanks,
Jason

Jason Gunthorpe (2):
  iommufd: Do not allow creating areas without READ or WRITE
  iommu: Do not return 0 from map_pages if it doesn't do anything

 drivers/iommu/io-pgtable-arm-v7s.c      | 3 +--
 drivers/iommu/io-pgtable-arm.c          | 3 +--
 drivers/iommu/io-pgtable-dart.c         | 3 +--
 drivers/iommu/iommufd/ioas.c            | 8 ++++++++
 tools/testing/selftests/iommu/iommufd.c | 6 +++---
 5 files changed, 14 insertions(+), 9 deletions(-)


base-commit: 4be8b00b2b0f669989486e9f2fb9b65edb4ef8c4
-- 
2.46.0


