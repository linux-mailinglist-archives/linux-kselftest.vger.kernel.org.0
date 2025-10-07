Return-Path: <linux-kselftest+bounces-42837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDABC210A
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7FC3E3431
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2102E7F27;
	Tue,  7 Oct 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfkOL1u2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778C2E7182;
	Tue,  7 Oct 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853548; cv=fail; b=KpyQL98U+cFJu4V+YDMHd+vYgcWTCMRsJ/zO2lISA+kP+vKHmaaUdjrj9GY/pk76xJcy1eyk46tMoHVkfmGI6OzsLdUpjqCxWZggkgV+i00YWpjrqRQRIbZaPTAlEwzrUIwqsDzuS3hQ6MULzIDwB+QQh/rTU2DK6taNiDl6KgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853548; c=relaxed/simple;
	bh=Gz6Pp71g563foW8gcwiwBD+9VJVHtDW8KCk5jZqGyCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIgRK8tuomKssytgVfJ3Cz/aHwJcyHlUz6F9QxzMu27Yvhpyqlb2/zaeGPGWV9XWMQhJO49O6E7uycP054jrsvqrmRdIaj3NzQV82w4+Bfw2yRJUO5Xk/fzgWHR8graO6lD6swWTCOO00m52TFZh88SX5mU5dRFnBX0rW6CC/i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfkOL1u2; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT7DipEP5YNgO2gkSsmafJxFHnLbWl8U0adoGRtcneeztAlmgvMbRCo3jX3I/I4BrPj+q+sXZTyKukf1g12e1s85y7uAgRBHopFXLoaAhYjrvE7sMusWDSmX4YM/pPF1EocQFeW1LWRvrKqkyIAr1dtJ/vc6fwbd67OAy65ttuAq1hq+aiOWjRE7KTerWtOaSfE1ILNNiMsDIeX1Y+19KFxpyVCQ2SjkWWsLSQvDQeAxH1RoxFumy/HY+km7N4MNGGuuxPtxrs8m/k7JZu2sWv1U5T5IFTylJf6+tsSkihgHn9ff7jLfW3ChC5sbvYJ+r8T9mPJ4Y7RsES7ccrWM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYdq5VfRyFhj/eWpwe96nvBZH+DZhFpPqHpGB5XIlDA=;
 b=QK3cuHEgnlv7RXh/Dr8nSVZT8j8Mv4r3qhkHavGlbnLe6BYQV57ehiU4/Bfqd2S7iATwtF4BZD0YId/IszIEmzP4Hx8A36KjdU2i9bimlyCcN1bXe5OLqjPlwOZG3ftD6wBDFzOp9Rec1lK2UKc6DAIrlEHHVySbbLVFVrTdC1L1SdOA4pGHcqDVo2aQATAWC0pBovOhPmtbwNtkg2O1f7rKDYJBJfrVx5y5NUKeDA+9WVyOIKLT1uDnsOJjeV8zKAnW0AGZ4HuzRccddIn24QR1rkOx/+CECCyOoLJOeiNgVdiRiJJUHCc9mKo8YkN9uvJ5J99TAjxuZ/We1BF4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYdq5VfRyFhj/eWpwe96nvBZH+DZhFpPqHpGB5XIlDA=;
 b=kfkOL1u2MHV8b4QnKCLWdfhq/lHTGr9HELvVZz6j3ErTg1njmNITVLy2vz8rwr5bb9SE+qTZfBpcVbkiBd5YDpu1Pm0MV7AYIOxg8zXrj0t2O1EF+IlxtAhmS6hNT+2zLvM+CXUA/7mST48OzeemLa7fuDsyZTZD0nARLW0v17TB+KTJ6alfi6HdVGwxQ9VOTqNPuA7V2HI8/7SL+FoNySSZGxqwzf1Rd+kubIrn8L0oORSzq8mdfTFx8Up9vFcRhAQ+tyyMrz7d6bc6Lvv+SjkYWu9nBxPFSTJAT6lL4pMhAS5zA3kVs5FcclI58F1A13yCyIQ1MmsaIFJbq4xcuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v6 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Tue,  7 Oct 2025 13:11:48 -0300
Message-ID: <3-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:408:f8::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 4398f11b-9d83-4a6a-3182-08de05bc41ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4AuDjIs5QXYBj3Ut/3GycbMhtVmNGqZEn1m5Qi64Bzhf3Z+CFI6nt9vppBrn?=
 =?us-ascii?Q?8bp2yo0L8n/E1mur4lRYle5l44YcHCowCbMOG0gnYGarANh4RqWeQbJbJ8jH?=
 =?us-ascii?Q?rB9JveDc4F4qXX63qkxp0hQlotOX1qEJREymqXXWaFeM+sU3LhjEnh+1+ZhZ?=
 =?us-ascii?Q?b3RwpslPefCOKO1GFi0BzRoE+5leCipibPiNTUV5sZ689Xpgdfm+wBVuTqmQ?=
 =?us-ascii?Q?aUFBFx4AkjQ9EvOhEP9Fd+ESxdBGX9W7QEtGxzZKZDnv8bkuM1Q6q/iHDJUS?=
 =?us-ascii?Q?eIjwX25/uKnJ5k1oGPtPk7NCYJNe6upsqgxscE3Ei2VMKaosLW/q1dN+Lz2R?=
 =?us-ascii?Q?jtQchVW1f370Qm23IyMba3Jpq5N5fe+75kJrjPiXnTOXif2+IsVs5LxkJHTG?=
 =?us-ascii?Q?Ve+ONdHlppn6Hj3wGTnQ+LzGjNAaAzEXkQ1NG3AKV9ZtRxc+WhVy0fT+Okfm?=
 =?us-ascii?Q?C2P5UrqspDskWwQu9pp6a36kC3VH9xYMnuA3QEdaVbjRrCj4gAU/omoQwI1t?=
 =?us-ascii?Q?OdSCiOQwpyKwa40f6CsfrHB19aUsje9qa1q5xzfFe2oQEl3IZBw9O+DsqLER?=
 =?us-ascii?Q?xYIXkw3FdggBJZYhB9qQyoePTpBfZjC95zqKJvo2/i8lOU2vbrZK2aOQ8aJz?=
 =?us-ascii?Q?1HE7auQO2lnbkAVIl3ZAvpNxkBpWsTGJm60d3Z0erPGO41maq+Hv7Hm+rEmb?=
 =?us-ascii?Q?NC1JET4NiuDRMIp89gnh0fCXQZyqSQlRE1hRbNO7QGXIm1ltKx69MURFzMPs?=
 =?us-ascii?Q?kV1EghADu2Ak4rvBTpJln0aSo1M5DFyxqQbExYusIZ724GWmcklpgP1Risbc?=
 =?us-ascii?Q?QtnmUX71p9xnPHHZGtortagTwdS7aKuPZIM008/lvCuwvgqBqu3mfpYGNXAQ?=
 =?us-ascii?Q?di5HJ89a99sRsu/Qima0I07R9g83rwyf7I37+zG2zrbs42lj5eVHZ9/ey9se?=
 =?us-ascii?Q?34szON46Ih9HmR9Dghz50SikXGuVDi7ejwnVT0o3dbucEJ1eD8BHrwrjdcyE?=
 =?us-ascii?Q?GLwaYEZpe5lTqvI14kt55NvN6H3d56uCFw6JhEZzWGRw/7GAeu7U5mCQjWUn?=
 =?us-ascii?Q?T7yyNGvWsZt4NIUy7DOS6HC0wnxcJziomlh3XbpZ27ySpmSjpCgx3f+/d3YR?=
 =?us-ascii?Q?dW+KhmYfUjemNjhwKEKarKtmpNL59F4oxRyyfzC5B13rduQf7oB27pyg6wyN?=
 =?us-ascii?Q?yDHaHIYLTTJ0zNwTW4HZvGgIL7r71kB7ZxzSSrq1gbmuJnM7488F9zh4eQHj?=
 =?us-ascii?Q?E1JWr1riAcz9ebquSRv2UequpwWBHNfvHoT3iHNyWWEhfYxr0WchSNJG8rvO?=
 =?us-ascii?Q?oA9bv/Gt+jkzSItEDovsXgLofZ4Qcual2uwnZE+4oa7nl9wv+Gea5k8CFJt6?=
 =?us-ascii?Q?v/aPEnJKEcAe2M8m07Djj3pyxrRRFsf9I+/bUoZdp5+sbtAh8wQ16uPntmZN?=
 =?us-ascii?Q?aCoF9bIxozD0FDjDdct+7nhuxzIg0L5gV5ewylkHX6Jn4BpWezPwbT34c6jw?=
 =?us-ascii?Q?C5Wn8hWaOn525sY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etiWu5YamMnCaeUvPBWWoNn+HEvCh8CEoes8qBbfV+fmolTfF73X6+/Jn66f?=
 =?us-ascii?Q?V1SZDdXdq0KDuvoQF0daplH3prGHLzw6Dj63Bchw/3XeQCswwvyKq4AP0RPh?=
 =?us-ascii?Q?5WyoWY7PWB+XqjA6Fi15p6wz73a677gkUtSSUsv334oI/9+XCkwNIjSlOE/u?=
 =?us-ascii?Q?tyAq9u4dhlHvK+jT6FEthOu5elZ5ImjgbGtR/BO9f0dbvnzwbWyqNK4Cx+t+?=
 =?us-ascii?Q?y3t+7mo3Eb45j21N77/BlkOHj1/BrSC0w4akWeCcy5AFFEm5n2j+T3DWttqj?=
 =?us-ascii?Q?n4iskPzHb/72XdEnpK3mBsRAbaJUF6nspCXsjh/g1X7Yg/wHLKXJUu2M4mH0?=
 =?us-ascii?Q?QSrlUUMV/uKK6J9NJLpsuoYJx1QB9M7Lq+a1zpj8ic2Ac4GTYS6ve0EZB9x3?=
 =?us-ascii?Q?ofVzGbaCKGIIeYeWZawhsau6HcTXshZVc3uDreCn2iHZun4ONhuKQkNiwzmc?=
 =?us-ascii?Q?U0yrd5gliM145IkulPW2aK6ggRKb6512DgSH7nLEdZYZ+HiQsLs4MuTjB/7L?=
 =?us-ascii?Q?h/yc+AwKE6QtMdYh7Um+VCCWSNzqNkJa/+k1RR2bWaISov01MpVaNyUdHafA?=
 =?us-ascii?Q?LDAMTLJZ+VeExCqeBhHqv/wpE8AIE37AzNlMCAzyFBuATvwZzF8tOIeZT6Cr?=
 =?us-ascii?Q?PPEcjAcaxxXLhX/NeXHeIq2rL496gyCHvJPGo1Sd6054ArLGwB/6cpjQ8iiO?=
 =?us-ascii?Q?IGJzO/Yb854GGM9GJKX3yE+AeCWMBJq26Vq8/YCgs7RXHhFwtHaFd1LOi9XG?=
 =?us-ascii?Q?ERr4eLbWo8bcDkQcCi5tJGeGgnlrrp9O8fEPCWMdCd2LyiUk1gaqA9l9KcfU?=
 =?us-ascii?Q?L6Vz7zHF0yddfeCYAi8/3Zfsq8AUrEAnULAmD8OkVEotpVHx7CPbTnwRBFzy?=
 =?us-ascii?Q?EuFRCeIEjt3hA+4Z0MXFgbSGSZVcb03m7LOjoebtEpWxqjEc7yyGIO/sbT6k?=
 =?us-ascii?Q?mZArdywfHhKruxBh9IHypxRTYneL9hSIPIhMHASchpnyVefc5Hr4XBGCms49?=
 =?us-ascii?Q?7zY73kYEBX2eCry0qc5SCC2khEqOHme73lKPFX8k4sorQw63g5KlIDXOlyCA?=
 =?us-ascii?Q?Odend+cHHiIjrfzBGfO3Vvf9t+DNOdCQ3k6y4lvFWy4drKoe+uPTp1IBQHxo?=
 =?us-ascii?Q?jwnPtQ9eOS2lWzYAXY7u42rPtcMMTOgdZFEi4Sf74xeaKTP+/b0fjZvSFIH4?=
 =?us-ascii?Q?DkN6Zh4JQblAkEwhzxm0Y5PeJOuZipWCWONP1RsR5KygkHN0PLH6a+eiGFf6?=
 =?us-ascii?Q?gE81/PR0RwlhDYXg/hixw63+WBCNKv/vG/jRkeTBY9bn7cxFQtRjW6zK0CiW?=
 =?us-ascii?Q?uSleKL/x2PQidfzB/W3/jdthTWjSrafjXNq1fiXuLpeYCtB8dv4v87e7Wr1G?=
 =?us-ascii?Q?Os8lOr2+/siPrmj0dsn1zsEGK0W7mSSVjqEk6bq5Sj+u42cT4XRPbkeZQQGI?=
 =?us-ascii?Q?++4hbD+UfzZXfqbY/LOkcmeK3SQgBc4E/zgZN7txMgcUHzsSJ18UZjzlHvWX?=
 =?us-ascii?Q?mRZCJZbEpA3h9iwDYOm7/VXS36xnA7RXmEo5YXi61KogPWGCfLN53qst9Yyu?=
 =?us-ascii?Q?C5h57ITCp602697ZLfo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4398f11b-9d83-4a6a-3182-08de05bc41ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:05.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Cnl++Y4FYk/WHKgpJI9fAoXLkbVZjasIkeW7vz47aKc6lF6OXjIEYBrRt+hEAY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with its own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  12 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 259 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 150 ++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index fb0f431ddba0a8..c35ddc7c827e92 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -17,4 +17,16 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related struct iommu_domain using GENERIC_PT to abstract the page
+	  table format.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..564f2d3a6e11e1
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/export.h>
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (!pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_oa_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_oa_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/* A 64-bit high address space table on a 32-bit system cannot work. */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end should be called aperture_last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_oa_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..defa96abc49781
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The IOMMU implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for IOMMU page tables
+ *
+ * The format-specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain: The core IOMMU domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops: Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the IOMMU page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap: A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * @get_info: Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * @deinit: Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NULL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features: Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
+
+/*
+ * The driver should setup its domain struct like
+ *	union {
+ *		struct iommu_domain domain;
+ *		struct pt_iommu_xxx xx;
+ *	};
+ * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu, domain);
+ *
+ * Which creates an alias between driver_domain.domain and
+ * driver_domain.xx.iommu.domain. This is to avoid a mass rename of existing
+ * driver_domain.domain users.
+ */
+#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb) \
+	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
+		      offsetof(s, domain_memb))
+
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
+#endif
-- 
2.43.0


