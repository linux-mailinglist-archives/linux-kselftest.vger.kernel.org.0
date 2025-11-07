Return-Path: <linux-kselftest+bounces-45133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059EC40F2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1345A3BEF7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4B3376AA;
	Fri,  7 Nov 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ns4xII/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509F335BDB;
	Fri,  7 Nov 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534197; cv=fail; b=kCtCPe84sejwcmFIFYck6fNGcIEXdDCEhmZk9N0wcyQT8cNz2PG/ORZl8558fhbmnHH2scDOvBDOtEZXLA6uJP+gAvBbOxFK2HESP1wCXUEtnHlV3DivBWcw2rzkucRNUyzeQxCwq4cse+SrGPdv7AIK2Idu/9C7HhlLDCGgv44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534197; c=relaxed/simple;
	bh=0nBBKp2WarF2ZioTCeEQNYRy3G1gvcGsrHJgd+K8yME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0AwJfn0zsy43EIiOKMZMZNvK9I1olxa/34iIoszNIVqK8x2/IdtFlPK86KCqy8rU4v10F/ZxtJw9BO1RYM+nK8EqdC182iTeOgpNlcuV2XEm3FZmufFUoXkT0kKC61pNBmqQBwoewhXHw2/l+SThEwvZ/gpM38KHzWShaalbDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ns4xII/E; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktIqAJM0GHgg6g0tz00BQwpHmi7s3lxR5KS3WUsxrIePTVttEPebVLP96be+tlOvIfHmNyoGzSEOVtm96Wdb/r9hgGqHpZSlhzJNY9W4P/P1eBRmQ2BHZaFlg4Fw0/deGRnJCMs9kUXSEYVdhjwZ6JAL/y2Wrnf6Ehk8hwBTs/GvosneyA6y2039EGk8I+TibMaTzcZ0FoNntFvIjgOIDzLrh1ltovmiKJ3iw5A3bgae1KlP5hP3k6cm6S/jo7fv9nwl8ygWjWgMeM/LjqcdZQygIw/l7K8YGpYykqjrfASAT+BcGX+kalCm8MORqy+603UsV+7JZ7mb83fiFfcimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4t7/1WEvu7lpfCJSeOaUEzFdZrkgWVuNTUYhYH0Gxw=;
 b=Ms7I8m6E4f6Cg7JS2KMFZj3vdeiZaPnQ1FkAqM0Mi35lfTUI4wbmXmAPyTevVENkU5rFDzeqgJCOGOK8Vp/MUM0FWYAKCjwylPFwcaIyZIfEEQ1JBrBHqdLG0VHrbljV+TDaoK0TNkRMYRXHtSEw8mLm5OsMbCd7JHOyJ0sRgkvzRUjOKHvU/feJOacZG+AAnEyWEHssYho+2K7Ge1kRD/qA1YnzsfJ4gaRupp3eR1T+8ZZaGIVLWXvlJixXIZVlmbn7QkkyCVPDJvDDwVUtWGGBhduhhNJoYhrwLcOa/BDMyHhuhUqlRh5hqeZEcL5dB3JrRJ6uyrPsZyWH4SXXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4t7/1WEvu7lpfCJSeOaUEzFdZrkgWVuNTUYhYH0Gxw=;
 b=ns4xII/EanDhEJgmx4VLpH3BSXom9obG5B5uDubFrg14A3tdDfdQl5+T4gVTsjkxJudrIeFKGDyi1/zU5xbZk0unlzJT1WqD6kZ8oMoP80Y8YfkDxTJIrE90UWY0HBP5cX3l6Fv0UysxsZHdK20DB4LquelGU35Y1pPRcpTa111rr1v8E6o7hLMh7kVVvMiFFoMDhKlm5VwgHMCLCEQGXjMIeCHKuMiBCovIbfn0PTPwqVgVFinEHzPR6FqFWgvQ/gWNUxjpbWCJ/FM8DpcQ7yhTAUvTQRa0Z9snPDAQmYoRbMsdMC77g1uCIZtTzREuZzQQgZ+CLEZizFWKaSWJLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:46 +0000
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
Subject: [PATCH 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Date: Fri,  7 Nov 2025 12:49:40 -0400
Message-ID: <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0708.namprd03.prod.outlook.com
 (2603:10b6:408:ef::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 38481fa0-de06-40fa-26d4-08de1e1da749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1OdFSucqvyplCX+yn64WcxsK/obY9H0r2A2YDNR1JD6shYLEVrT0S1LIxeE+?=
 =?us-ascii?Q?gB9OOSTrUpoRWLcLvKCA4rcOlbCdUD7LPhlqNkb2zMdMVggG/+cj4l9INfDQ?=
 =?us-ascii?Q?5xmpAePQNuvHchgT3t/5fYvO5E2GF+BETmfl3M/8mHv9VXaWpTFWvax+M1Xs?=
 =?us-ascii?Q?XPbldooaE2u22WHbBk9cQeYVwk60Jq7eZMQChukmB498DIz/45BqReh/8O7t?=
 =?us-ascii?Q?drjLz4w58ugdvPkYdKHQ4Nc23rxOYF4tMXPPZSepkaI9B2DPH/4GVp5g7fgx?=
 =?us-ascii?Q?8goRAbVL857A728t9vpCcwUJ1xx6JFMXJmAY69aAyVUocxZoiHQTGFSbAbbr?=
 =?us-ascii?Q?eqWWIgepkEVuq7lhVyXEPwZOlqEVyJTiDxwA6V/XOQ6g9oPG5hExtXCJD3jX?=
 =?us-ascii?Q?b+NFsWUO0V1VA9SVrke6iXyh0XiMTc5xsJaVOMgMe8nmsKVuAQXqktfokcmU?=
 =?us-ascii?Q?T1yaRVWV/y11GTeLz1b8wusOKEczbCRmzHhtywbrADOcSeJ9IXg42jDwtNAQ?=
 =?us-ascii?Q?w7bKcj2wPX5CO3ocJEKQw7BQyORpGOmLpftffh58NIbFj0xVbjb/tY/Q3A+2?=
 =?us-ascii?Q?huY9THyjNSqeaXZYIsWJI9i2oHA8RaA7p2t9/toVcJd3aWXQTY2m1gHySOMS?=
 =?us-ascii?Q?QOJw6We0F35DF6z+DQtQwQ14+bniTStYVcTH1LK4fQWgsU5MhuMLN6RQVebo?=
 =?us-ascii?Q?KVx0UfMVFTS//nimHsdYmErgVt1rxERWmIIGGifCeHqOM1wGwNsXi3E6AkB5?=
 =?us-ascii?Q?RS3uDmSxd9neqnbwLnHTL/g/EXK0oaecEVlSdhhfKs4+ihhLruZ5t/9gme9M?=
 =?us-ascii?Q?IYzn+krBs3GGf75PWiszAwYOkuxG5PAvCbH1ygSYIK4IkhKm6xegGJjYJ/JQ?=
 =?us-ascii?Q?sQ/oJ9YHoBTy8s2nOjPEnUGQvfAX9XJVUgzT5hj40Cmckt59kZVFBdFE3jNT?=
 =?us-ascii?Q?P92dim34LVf6smzdh3LrzGdW1xcpxSe1hLP+dUHDmkOwRHS4C1nFH/UYQGZZ?=
 =?us-ascii?Q?vJE5f7a3+8xIsbfBuC1PiP7SkenRTsE1oRJoF3d6yJQGMbGzTD4CxRdW8KSs?=
 =?us-ascii?Q?z1R0j/cA9bi7voLYOcM7CIMJzWPW2RVJn2/w8YtI22OUTq+5qdRCZklqvL4f?=
 =?us-ascii?Q?5BCYDKKkC7hL0MOz3jIqQ4FyxQRYo9RY+Ag8KzSk8hIqj6BVh0cSNVxdfoPv?=
 =?us-ascii?Q?YLl4BdCPJOxhv1mc2VKCIVBaQcEDqgK4lFBW3pLh1cDcbEOysQMY8GfbkgcL?=
 =?us-ascii?Q?6OY5XeaYvX28DRlf5uWQTvCXKgvwKKmMOUEmMRb6NW+o08FW4q4Gi/feok3P?=
 =?us-ascii?Q?KpMZqECoRc5Va1ePeOUQdPfLyt/urvWe4xSrKucDwPMcQmEGRzR90Q1ZLV0A?=
 =?us-ascii?Q?Zb2OZaq/+NyoWBCOy6e8SbKEZf9XxWzXBjiVNw+2NyB22MeufM+B8XvadBLR?=
 =?us-ascii?Q?R/gTHlrh+J2Vrwf6uLGv4+JxdBKeVaurtzGI1GbkVBtdGK1c4N4LeSt6EEuI?=
 =?us-ascii?Q?h2jnC1CZ3c0pttA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDcD3DEDCdG2Wjov8c/UsK7VCLqkBo98q82LFDYhNwdCfod1Ai2BuaDLuxNm?=
 =?us-ascii?Q?Ec+ZU30V4ruJYUTuQVbtDlJR3quX/Zij65ECzACSy1vvOkt8PHg34kZTt5Yn?=
 =?us-ascii?Q?D9hDsieMsR++lz/wgQYLN4PlDGiv5cVYLTFNwF0w/ZZBbe0XBjG+GqD61u+w?=
 =?us-ascii?Q?mz6sfOz9lz/ow0H/tJdL2RMxAa4t45QP2ZCx8KY8fSM+PLt3WMdjFlBZDGew?=
 =?us-ascii?Q?o4WzszH7ItoYbEV5VZNP1nPDKej6CJCNFtGWP6GNLl2PbwC7raDnkHbwpcRs?=
 =?us-ascii?Q?1OsmmU/oMM0mQndcW3sYV0O+MQHhhBknFeoi9tLwRvgfD8L/4nZAj7sPDcN1?=
 =?us-ascii?Q?iKCZPrkzOjoe/Irrxx5ija3djW7/Md9lpDwfNWeHQb5mNDokXZkSP/rUJBsF?=
 =?us-ascii?Q?vS7DFTDDUthMnHqImFk1O4rp1cwSxibMzW+5E1DWdgBTBfb9V3FE9I+tFXvF?=
 =?us-ascii?Q?1f3476WIAg4GZuUzxqM93N8kIUejAjebnvJT8fRpwbpy8T1eD3M1zQ52r5/R?=
 =?us-ascii?Q?dEZsEsuXQjZ5wgWjIdX/XWmGWwvfFXawtozHOg2OwUKym8LxgE4qLoTdle+Q?=
 =?us-ascii?Q?Y0CwSIBoeIIDo3rU9sm+PosZuEcKuyWnG7AnyJAxa+0R5I+wtBOrOW6He8WY?=
 =?us-ascii?Q?TVusX/+jN38tGrgPxUYFNLp/NAxMqncDmZWyIePUdBfdydxQJjj44YpWiIcP?=
 =?us-ascii?Q?Xd3J+0ON78HHyEi4iJEOEwQyK8IyMGYFu2XE6efb308oJ4QjKLkXb1Hn6qYo?=
 =?us-ascii?Q?uJj3qhVYZcyQIPlJ7hKJF5bj0CB7Uzbs9GfEnCUsJpUrmii/uvT3dSVSjscy?=
 =?us-ascii?Q?P6zl1avHHdhw67BT5YawhYhUEld3UdGzLcfQn/WmQgbAMDKYmJfo5c7R1ytI?=
 =?us-ascii?Q?MKAghzefV6UG9n+2D0LpAaGRQ9wXIdEvXEyIXEGpRzrCiacxHdK55w3eK9SS?=
 =?us-ascii?Q?hA4cmQ//TLcb8BgqSQ0I0Cu6ofFVjNUntAW2dma1tJ+yVj1/E2HwAbjE+t5n?=
 =?us-ascii?Q?zgQDWRXcrgRgNi6+JPQYnJfjhWoN5uVqt57895oj6FzlDH8B235MHxqrZFaB?=
 =?us-ascii?Q?QWeJvIYob9Qp1+b4WoZ6C2hHOD6dEBBMsx+HZUJJ+fhoN2ATip9xeLME+iWR?=
 =?us-ascii?Q?4lC17w2h2eoL4YOVoQR0ESu5dVOrfyuBPjIsR60wLbZin23jvIJ6SsOze/EU?=
 =?us-ascii?Q?WS/XgD+4X+0ZVsx/TdyXSDm3fPxbz23sX2jtKqvWyDYpLyK9ZC7XSblr3Fsk?=
 =?us-ascii?Q?N45jAw48ChxXzDXskA5VOd+5X1cwq7Plz0XBvLIYgNtkcF4okBVR7B9XF//E?=
 =?us-ascii?Q?v20wyIjIsEqi9jROtlcEd9hPH901GCIEUJyo6UMCvw+zxNelJZ8wGa1AOMcG?=
 =?us-ascii?Q?kSFJoGkqf2ZaSX0KKAmPzZyi0zZh0D8ypuXGhBr1l+3Sp5i7pR0qrGYB1Xiu?=
 =?us-ascii?Q?uEZpgD14HoPZsd+fQXOn7v+whCPtEhBWjrWDkzF9L7Q0AXsiiPNUKgYC4Z44?=
 =?us-ascii?Q?QN6qduZNYABEH23lO7h9TtRk0O9AIab0t3heXzppwH53nXL7UXySuAjMZe1p?=
 =?us-ascii?Q?RKUqpk6Gywqnkpwcmhg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38481fa0-de06-40fa-26d4-08de1e1da749
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:44.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myaCsb0cTGqxKXkRSp58oHb6ldjloknmhh5mHo8RzLaQf9WmRHvqKW4dmaNxrGPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Finally call iopt_alloc_dmabuf_pages() if the user passed in a DMABUF
through IOMMU_IOAS_MAP_FILE. This makes the feature visible to userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 43 +++++++++++++++++++++-------
 drivers/iommu/iommufd/io_pagetable.h |  4 ++-
 drivers/iommu/iommufd/pages.c        | 13 ++++-----
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 0bf6ca77888c0f..44a0a7c79388d8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -8,6 +8,7 @@
  * The datastructure uses the iopt_pages to optimize the storage of the PFNs
  * between the domains and xarray.
  */
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -484,19 +485,41 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned int flags)
 {
 	struct iopt_pages *pages;
-	struct file *file;
+	struct dma_buf *dmabuf;
+	unsigned long start_byte;
+	unsigned long last;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(start, length - 1, &last))
+		return -EOVERFLOW;
+
+	start_byte = start - ALIGN_DOWN(start, PAGE_SIZE);
+	dmabuf = dma_buf_get(fd);
+	if (!IS_ERR(dmabuf)) {
+		pages = iopt_alloc_dmabuf_pages(ictx, dmabuf, start_byte, start,
+						length,
+						iommu_prot & IOMMU_WRITE);
+		if (IS_ERR(pages)) {
+			dma_buf_put(dmabuf);
+			return PTR_ERR(pages);
+		}
+	} else {
+		struct file *file;
+
+		file = fget(fd);
+		if (!file)
+			return -EBADF;
+
+		pages = iopt_alloc_file_pages(file, start_byte, start, length,
+					      iommu_prot & IOMMU_WRITE);
+		fput(file);
+		if (IS_ERR(pages))
+			return PTR_ERR(pages);
+	}
 
-	pages = iopt_alloc_file_pages(file, start, length,
-				      iommu_prot & IOMMU_WRITE);
-	fput(file);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
-			       start - pages->start, iommu_prot, flags);
+			       start_byte, iommu_prot, flags);
 }
 
 struct iova_bitmap_fn_arg {
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 81c6093beee2a5..e033d44b0feb60 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -264,7 +264,9 @@ static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
 
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 					   struct dma_buf *dmabuf,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 935184dc68be32..410ddce4e99d8f 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1412,22 +1412,19 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	return pages;
 }
 
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable)
 
 {
 	struct iopt_pages *pages;
-	unsigned long start_down = ALIGN_DOWN(start, PAGE_SIZE);
-	unsigned long end;
 
-	if (length && check_add_overflow(start, length - 1, &end))
-		return ERR_PTR(-EOVERFLOW);
-
-	pages = iopt_alloc_pages(start - start_down, length, writable);
+	pages = iopt_alloc_pages(start_byte, length, writable);
 	if (IS_ERR(pages))
 		return pages;
 	pages->file = get_file(file);
-	pages->start = start_down;
+	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
 	return pages;
 }
-- 
2.43.0


