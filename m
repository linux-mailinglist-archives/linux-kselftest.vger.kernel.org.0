Return-Path: <linux-kselftest+bounces-44126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2DC0FA80
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CC54EDA04
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3C3164C5;
	Mon, 27 Oct 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgQlHgcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15331690A;
	Mon, 27 Oct 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586281; cv=fail; b=kSco06XhRUtySobEUyNExfo0TK0u4qNfBX06/dfB72dGW6ZRZ1Vb4vvq1JZUVDb9BnRIaxaR27Q5Xr3xEnw/gLicc0v/C0PvnN5+7so8LVEtJk3WxGmvzXT9mkKQvezUwh2ZYmoAGiQ5M+ky5wOCbM8p9yLeauvYFWtxkBPBifo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586281; c=relaxed/simple;
	bh=GhQTDK2sd3c7mIqImyrF3TWma0JZFGIwjxwS2AsqS00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcBkgl42ujkroBt2QmrIHyLK1WKW2RCt4AxRWABbsYgXIbHWQGZnXv0JtCZ2i35fTPqKKFrEoXpxni5OdoSPK/+S5xN9bsl3VLq6QLxDjNIaWXEQCDxUIUaCk+bCinf8pmBI4uevTRdVwGXgYYxLfOezGbGGvhSSU5bQIeha/nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgQlHgcP; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClZ6CCZSg3WHXRHycWfOdAbLJY334PLOFE0Ws8vrB5hpIQ00q49MMVIaWs+RVor0xKvA4vHoIbShhgJGlctKMrxafldupwRP1HWs4NTrPmvQrxz96grY56/kjxquucRY/QeBu/cbb09sqf/pGvyhBIgOE9U4dGLezf+S5/fpofuB9ZCKj29jF1kSkvuIPdJmnFsUqsUwiOAjDXOik2bXmIbGaOUAAvLXsVLDLLlZP2oBDc7VLyjFjYH2g06pFStkdaGGGE202f8s2ZsAvwHRwqg6/UG8QG6ZEm5wr5x9mPhwYxbNn+ilSaTFxCGjf49vJTC3rWqmBiaiagSlE9Jw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX7EVSmKhKBVDYToG5LFVLRapdZxAzK+ct/4rSr5xL8=;
 b=eFEFjj6fK3IU8LB0LDIPolYs4M9ZUuBWp38r0bpTuJ0+7Zmu8/97Ib8l2pRSMxayj7xaWyNsOFhZkRTw45/Bsna2gkWfuP9ISY1mJICrpGP+MihaeZoFk+fhjjAm8Buh5LDt7J8RQOcRrtwFNBv/iXFGTAtw83mfR2s7hZm4l4KtA54+kwA+k2YfPe4k5NjpoPt7jkP1ZwMeSFe3rT1VJfu3SBDH/sjQeLCLSQr3ZZv/HZ/5sB7QrBT0T0q0lfxd/T0KPz7dkhbypls2RnbboEA/oxOKAjzavFD9f+QadeB2YBnUyYtEm4KR5j6NqDVBjPg2yCl8Ri9PBXAYoQt2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX7EVSmKhKBVDYToG5LFVLRapdZxAzK+ct/4rSr5xL8=;
 b=PgQlHgcP68UFz7Ei+orxxNe/AhzbcQYebP9AK9ipkQbQiiz+i+HtGQTpyX460Ye4wt60z1UVYAlfr0AiPQkS9919GF3nYYbBCGg7fUrVEHQsDtwWZ7CkRLwisc0/z8QMjslewZQsq6GjyOxedn8iA5ZNaH3wAStDdOLY3RrPLXLXMttNrx9eG4ygSJOyYhce+fLSao7KXgbi/Zp1tzr5QEzwL3anTVnfpmGEnpejgASvBpjs7m0aG9AlJQcOoi//7UCnQ54f3mgX2UuDR8dgKqH5WIWaw/pETRYxjLO8WwAtx5qaEOGXHGSXH1smzcAaLz/X4OcWI3xtWKHO8RfpZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:31:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:31:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 4/8] iommufd: Allow MMIO pages in a batch
Date: Mon, 27 Oct 2025 14:31:03 -0300
Message-ID: <4-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 37efdc52-2751-4865-d293-08de157e9d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STA56NnlOcsXNlFx8XSK7bQTTXZIxEDj9fkjw0umWpD+IwZAB3j/yxx8cVtw?=
 =?us-ascii?Q?3crfH0/Q4DywG9uZ4to1+pZjnDCcTrPqZI7VUk1Fde5OroHOwp8ejjibOW6x?=
 =?us-ascii?Q?5Vzq1fNvqd7A3gyCRfwXUdTmJk54fo7eA3Wc5AmGKVOO7MyOguyU8j/aAemY?=
 =?us-ascii?Q?iKyDKQ5IjsSXe8l4qONsd0N2pDDCK3aodbD7l+RFkC4KTJ9BKt3sXcqZMCiD?=
 =?us-ascii?Q?ZA3oZVjvxy67Dq91QUH10fwIkPTtPiHEWpytK3WEUnW62Gk89Fv8CI6seivP?=
 =?us-ascii?Q?GbuoOeAs9M3c3H01ZvZced4m4gcz7UufVCVqBuvs0cTJ0HuociG5pyEvytIR?=
 =?us-ascii?Q?yNu6HjUtwiNhBYvCTrNTgGOVy3s1W4Om+JQxs4JmwWXOguzXdiJ2dlR3C2NY?=
 =?us-ascii?Q?S5bhCTM0T5kxdoHxNEivYnWHCJrZiBSfc03iQBCvrEQe783icRXqfgO5Sb4l?=
 =?us-ascii?Q?DBX7os9kmaOGUykzwVC0FcqVsUu8Dag9W9p+n8AOMfljc94Hug3/xuR0cq46?=
 =?us-ascii?Q?1VxRe9SzUjyTCMnqNmXyKpBujrEl/49g0KaSIGkz0zSVi2L2EGybx+z7Ug+j?=
 =?us-ascii?Q?fg2Y4lHXuHV9k1NTMI0WNjIJN9lzUtfNOsEHZgYA+2JfAT2rTrr9oOwXHGyA?=
 =?us-ascii?Q?f17pXxW3m2pkpvdzGCgvwcHQIH5DZKdtEZRIFKuSPYiorBxGS03mmgvFP1v/?=
 =?us-ascii?Q?pYKCwdKXyMR6Q1SjSxpBerp2yFpvoo/Z0qMhRhSFdnllfZEVUqD9f5uWBNyQ?=
 =?us-ascii?Q?lkNX0uMedCLtfEUTQfoIl6VAnPZaZp8+OV7gjpm86gB5NeR5MMaLLoTa2QN7?=
 =?us-ascii?Q?ak5cF8oo/xjZx5C0u+xoaF+LgHuJNjOrSacYpsnlU/wo84HynPqhjQZjca22?=
 =?us-ascii?Q?rM3OqLRYG4bpEYrV0YlmcGrLzKiYXhFSwVeQJZltHYaz0jnDczD5jAlt/Sul?=
 =?us-ascii?Q?2zaZ0O+fhvU8yvQ5SX+weOmQIvpk8zfsG0vxnoz5CvVd01fJqOxCoogjUHXy?=
 =?us-ascii?Q?ZDO2Ci5zk5XsV1pLzs7m4EZ9niUoj54Q3PqyQHQLtrwijRDD8Y3kwE9OpiTC?=
 =?us-ascii?Q?JO4gTKlnt+bR21/cF5p+4xxwmyER/e9WvipIKM+WQEckQiUo/uOJJIzAJyev?=
 =?us-ascii?Q?T6YrPYq1Dd3eqQsEnGPNleMo/VHRkojl0/Qw31JGmbo/epOWhKD7Jl7p9Qq3?=
 =?us-ascii?Q?0HqPrg/UOrGXWWeMwX/iUucOLrVjm7OTEwAPI+xmdntbV9u71YnKwILB2NO3?=
 =?us-ascii?Q?B+OKQrvRhuIyMFK4xFOUJ9dTx0LOPbFN+J1Lrcn/98OzNZcrPBureoN76Dp6?=
 =?us-ascii?Q?f/idKDM6P/mtzWEf1xVkhmsLNLEemW4uI1MPneyCsp1Bb5KtaA8I1SRCrFZN?=
 =?us-ascii?Q?FS6CRnrye5ICSsihvith5Ph9le/6V264aMQnbCv66vqGQko+2oT2kxAkT75V?=
 =?us-ascii?Q?rpk1AiXasecDsqTMqqHRZmZCIxg/I89nv3LdHDlPsbkEM/lvPRbu1qTobp1m?=
 =?us-ascii?Q?sBVzqmfFZHwCVis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgQoZffcxhtSDl4/JMZu2Wjfy+gS91POfeerxE4zxrWIsKrZD2ERWTHCt+7W?=
 =?us-ascii?Q?ltqPUtGR1ORwFodjo04R1pconkRXOJx1i6H5+z25HY1cL4cFOxXa1D9TKBEk?=
 =?us-ascii?Q?PSqA7UGJ2rfdfOIDVFxpJ0rHrJHTKR4FOBTcaipBjgpeN/Uple1LTEnROJpz?=
 =?us-ascii?Q?Fil1gxNp1QQ+svgto99gZnYEEHNtrVJHAIZJzIdo1Tzu5dDRweJXghM/CZv0?=
 =?us-ascii?Q?GBmpFAiuJJ84vVA+RdctJvOO+LCMw1N95MsTmqwAUSqaC3HJZXY9g6hJMOfJ?=
 =?us-ascii?Q?pkOkRwvmLeI+Wp6GDMmgIF5QgIWWjBh0s0a7NecG5pBQRDIuoN6czxeooonb?=
 =?us-ascii?Q?SnaRRO4bLGKBMKgNFi00ESVpMRNHOawAwbLj7y+5t/cr5d+wtIl0o+5YGnJ6?=
 =?us-ascii?Q?LC81rv7+Ud/sU+E6D1x7qsetF626Zb8+boYCW/FExUlIE6mcaY78kSPM3+t5?=
 =?us-ascii?Q?wSYzlyJp/nXRMQu2tMh0fJYz2uS9xs9n/K2iBG/GXuTr7NuI/N3H+ZpeRsDF?=
 =?us-ascii?Q?ZH+jnfatwkvEkZmhcoRrNy58gC9JyRU1QmrXL3jgCmrhpbr1BXoXEi9DSGuR?=
 =?us-ascii?Q?hMm8IcGAFf/E7+OI0nkj/Wy3Anl1bqBlFNQYGY16qyCnGrHf0y+vk4JWNr9d?=
 =?us-ascii?Q?5Yglh067XoiMIc6iRSPKdyqTszUXA1ReXxdrBH2S2l206nJcEuCtVdzXN4dT?=
 =?us-ascii?Q?QySf8qoC8gCtVRX7o1edzYtljQJYXcrswOJoyODpBKLyDy5IowAO52EW7UFH?=
 =?us-ascii?Q?e2tyNVecLBJB1EjHaupIUofwMA4LxPdXng/vlELIJN4HdOvXReoH3INu/LyN?=
 =?us-ascii?Q?B/DJqoEgRtlp1m4CjJnMWpTvPHlGriPTO96WgCIjMpcNk2gfw8TKJ1kMtedt?=
 =?us-ascii?Q?J0VuTxuSW+4lYxKly39NiN2nDOiwgXIo2km8k8sxgu1tHw8nYbMNfesnuPBD?=
 =?us-ascii?Q?zHz4JExfMOIJ9Bdh0zRJ+0txtPo3cT3feTo1D9N2orwzxPlq/yVpVou+RsYL?=
 =?us-ascii?Q?20BLk3l6dpuJmsGlUwBpwfgrnu21+ilRiMR9X/t0Y95vAVb0sQJUOuolZzjS?=
 =?us-ascii?Q?DeVlef5DrwpYHANtmoxljxVkioCCrbJrZK1klSQvnYNmP4LHh0fENH3ODKz8?=
 =?us-ascii?Q?ceqNqgdbk64MMBSxFG/aJlVR84+SZmHk7/bFS0f4YZ/Z4aMm0wP7qpuZpmtN?=
 =?us-ascii?Q?vskP+UDOvf1i39av7EtlZpBdTAoW+3xQFcZy4hMiNZ5PaDt/G0qt/QhGf+8C?=
 =?us-ascii?Q?TaQwdT8tkTQMZso87ZgE2HGZH0Hjqfci42YLyVpsZ5IT9zjsa33PYqnTSnST?=
 =?us-ascii?Q?ZCJWq+AE8Eflc7b2xFxH0A/7L1ChZ5hGegWN2M7pMTmEv1lbnRj8Zp6csxt1?=
 =?us-ascii?Q?Qs/Rtm3RXvWoZjr2mpWuXsA5XYJGMABq0seRsWPrxzSVLRiyqshwMNtt6E3G?=
 =?us-ascii?Q?iS0nSLpBOyKWnNUQdwiRz6QQ4n1YxLZJOojzby2YG0SiWIsRC6CCRuF5pPxg?=
 =?us-ascii?Q?q0GKEzZxKPZjhNRg0m/8iH+WS5Q5dTepewHXOKWILfF73d2gs1+m/bTuqEA+?=
 =?us-ascii?Q?fiHkNyREBll8SWyAESg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efdc52-2751-4865-d293-08de157e9d5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:09.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4CFCuYLM6VmfoyaB9S3C/ij1cpKq/pIWCFHSarypYI5nORWy6/+be8bnuv4//vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

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
index 463d6340de1dcb..caafb5faf55a12 100644
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


