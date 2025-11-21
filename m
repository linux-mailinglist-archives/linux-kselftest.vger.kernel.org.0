Return-Path: <linux-kselftest+bounces-46249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89032C7AA14
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F8F3A117B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC81342529;
	Fri, 21 Nov 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YfshWTwm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A219314D2F;
	Fri, 21 Nov 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740277; cv=fail; b=ajKMZUvCmqLBxl5HDaBloY7rm5PG8S2tADsuj2yqfK4rJ30lZOKN5IkI25H3X89CxW8noft0JpHqCjOT2vc1iJJ7/6k89NUX3rdCKbiqA1eXDLXxueVNoVz6zuQE/LcAE779pb8gZxZ6p6JZF9lWB2jnkOPJzHh2gpD6s6b/jZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740277; c=relaxed/simple;
	bh=XS4zURsm5aFaocrW7qBM7S62R+YV/l/WRxmK+W09brY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9fVRxVohm+lxevCNrEpwsyU0VvriMacrF3nIOLfZ8c2xTtXiEiRjlaF5CvPm6VmhGdWlFIKe7jG91MZvPJvMqekXV1OebGK0PKf4yeW8O7SQyyoMII8DDMI8zs6iFTULYOmY/Lyh3A/WlruYouWnBdo62GGpFmep15Z5fn/4no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YfshWTwm; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdmkL7kX8HU3uAjH1UZzhQuyabF5wgDFtrnfFZXxocVgAxYNLlPS263pVx3c3qdYit4Vy/28vnt+VRTXuKBr0cpKNKe653yEpW3aCadkUzHRww1LRPj4MCnFCcKFrksOupjJNSsKh81bL0K9k6vjh0niUE9XJxUcRxvoaO6N/RCV2yPmPPKt349MdvSuXIHMABk/N0fJDLDLggWpcn6rEEK75jzU1a1VISqqc60VDtLK+wbKCPEvFFQfxb4WEhnXdXLI3UmsmG+tdooEPnhF1ssCHUr3awTVQZ0lF5VUrhuMP563s5HiGCiBbaQXDkBtNukcw8+/iLKlRQsPiL7UAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqiQnnZZnsrKkLHZ9nauUwrElpnbxQfLg0PzB7wfPbw=;
 b=VyLtdsPBe43hNrc2uCrLMPfFQ0RYkiRsVlEBwipSwQwXu7OMNceVor1dYigxXm+0QuVZW2gQF3dHZ+wa8Ce1aobmKPnvZjwER8V94ba5zRRbQ/KVRRJnBAeaaJNrZjPxXALdEdNifSdgVjCMUuAj2YKx5xuM+X5oB5ly2T5QqpBML4QlccIkLJzwIQYsS4a47kXqSFGWkuLdRfI989quvqpGF82O2+spTI+BzNnKxsxCTHVc866BNKaYSQCCvMLU9U89ktIkb8ey2g6bS7+97TTxXZJDE2PeKqf0sRI89YYw+Njweb0542iMfZrkgd3GITN+Hq/98wpJg+446sbpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqiQnnZZnsrKkLHZ9nauUwrElpnbxQfLg0PzB7wfPbw=;
 b=YfshWTwmRwsV3xxLz/0tL6zQdkVBPIbK4o6elvQwCMNMbDvXok7Ffd8ZU+A/ADzD3XaWi43hAMgOFnci5+oK7ERo0sbvKVDQ9D5lAxe4Uom2DPIj526D+to0caBvqjKoRAVhJZ1p4o9PplLDpl8Z6m67lI/Z35dJTS7g7ujKiR5O4oqQ8WNK8uQ+Is3ttmQYOurhXAzsAM5mKZp4Tm+NJe/SFo/D/a6XPQQmkkC0InAlISvHQe779MrcEcyMXOl1OCON3t9XMtas8x5rxn4yNQLOnXkmTZ6QunkwSzASALB8KFF7qvH362HdMsOnEoiydbSdvAvMqGiBreAmJqQfcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 6/9] iommufd: Have pfn_reader process DMABUF iopt_pages
Date: Fri, 21 Nov 2025 11:51:03 -0400
Message-ID: <6-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: be542978-b0f2-434c-f8d2-08de2915c8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNKWTVrGCv9iZ13elFe5HfCAW6le7iBU0AvXccW5M6gzsLUam7kuAXD9wW5k?=
 =?us-ascii?Q?6KjjUh0AC+vkfrdD+mLY71BobnLoTDL328pgaBGV4rssnXo99XcGhVzXaJBP?=
 =?us-ascii?Q?2xxaTEZ9WYov90oIzgrnBJggMqUxKsNF3tkKrgqE/SwGfWqxbfC67el5T8uT?=
 =?us-ascii?Q?jqWXTKytXs5QJdwR/UI3ATHxEzm+VifLfD+1w7YNZf9neQDnS4LNrk52D0Ww?=
 =?us-ascii?Q?53suK3hxbD6ZjJwCggtFXu2hVwn/VnVZNtaE7aISVMS3VsPDe9AUZNFI2nxB?=
 =?us-ascii?Q?rOKgB4GWokWCW4sA4VnHiLk92S7FsThT9pvA+gIapmjy/8STXaQfmzLa9tkE?=
 =?us-ascii?Q?2gOjd+t0TjjYX0Qg2v9UZXh/NPUKFuk1THZ/oC2AV/TLcMjKnKf4jhZRDXkM?=
 =?us-ascii?Q?GzMlzHybjq20pqppHHQE2/rTrHrHzaZTXeXsI8vXdyCYwfK1agCQoLgjWf67?=
 =?us-ascii?Q?J0G9e7404rgPyKxiecqWaYgOqQ8hOEqyQ0QCv0Xj9By5jvrhcq7jww1TvkOD?=
 =?us-ascii?Q?ul2aFWP0HgsuwjY4aESwv4s48ClhAX3BMe5JVmHF2sDRl17XcP1D/ef2/mxp?=
 =?us-ascii?Q?OyC/+OSlYHkD7DJzyVwhrb2dMJ2OQzOrR83twaxWyuQk9oFMB8leGuxu4+HC?=
 =?us-ascii?Q?d9j/b0IXwhWK5w855T/AiGhAgNDth7AH8NTFB844LPwpHU4hYKbHLRdHc6mT?=
 =?us-ascii?Q?OUIsNW7hGjmrhsJWnRSStANeePNGZa/74Q58+ZfbiZdeDggIL5aq3Yc0T/8C?=
 =?us-ascii?Q?8pKoF/J4ZgTCwEdiCPILPZ0OAu81J13hz92fz+NvaPOcXYHaTqn9ZVyW/7YS?=
 =?us-ascii?Q?TcWW4eiJrtmnWItZollJJXXsFr2as9nWgAvQOvgIE/O7xGBgqK74nXsdqZRF?=
 =?us-ascii?Q?j/SOD/gVBc9BP6ixbpcW4c/LcKobdlV60tvIbv7xee2/0bACqFOhF10zg5zw?=
 =?us-ascii?Q?0H7+pFaUiVPsxY40DCO7GYz5JKk9tq5Zdnk/ZYwbSKHAD38/4w79+g6m4klA?=
 =?us-ascii?Q?pJYvqOO49+rBR9XopFzArXigDbmjLkqLWhzo1uAaUIRRWw21xUv/vlXzE5WK?=
 =?us-ascii?Q?9V2DQpVcFNuHmilFRUcbasR+EkFBobuJcKNBlJMe7wDRJGDLh8F4sgd6ZGEy?=
 =?us-ascii?Q?yempaM0jdPwIsm9g8iLsP+qoEk3w+cDl14QEnvtfGvT5jNjkBxwMzNsW/tPe?=
 =?us-ascii?Q?xy0GE05IpRIC3v+WV97do/AOYN6cq75TB3li2t3frQCmm3q2w2y6T7DnSTrq?=
 =?us-ascii?Q?WLBCH5/VzKN1TsZex/z2Zb3ETEoKqYWV239DiGbVLv20v3bDZxKuVlx5+VX/?=
 =?us-ascii?Q?cgQAPtsP6kkLmTkubihDS9usYQBi2myFXYUkE7W65oRmCMuhvw9xcqbWSsR5?=
 =?us-ascii?Q?uBEIWUdRfPLyxYCl7ZH5hQSlRrdTRDqlIb0/CvUxAV8EEOpuzXrnCOlm0TdA?=
 =?us-ascii?Q?Wl7LVT7D9RisUh2efDqU2RyqQSqabu6ot86CyjOO7MSXSTTJVS1crzUeAUcs?=
 =?us-ascii?Q?5a7mDxOW1CmC57s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tsCibsOVIuP9FFx69cwC4QflYSSvUmfgihb8/i23rXyGTCZw9+H7K8lxTG69?=
 =?us-ascii?Q?cn/J2QawgbW4HpwbzAoJ1bwvoXgtckNPabfCZ8nTRNkLDa4tLuR/B1olPBfJ?=
 =?us-ascii?Q?wBnDTyO9230hQUwDG+LaTfJ0FLi/9pY9bayWmfjGKrf0vDJpVZP6GBm7ev+k?=
 =?us-ascii?Q?uQr4b1XMPJmmjLd6q/W254ABlc0LlogSz6OKv3KS3CkggtVy2Iyvlkwo031x?=
 =?us-ascii?Q?UUOw0Zmee29bkZGmap0cN0f36dACfIOP+tOEkikTk5Y+ieHw5DpS/xRceOvj?=
 =?us-ascii?Q?Kz14DCpVcm7EXWJzK9SyOB0QH9/ggIlXwh9ghHX8I07rtg3+0n0cMjQQcsui?=
 =?us-ascii?Q?vg+Bd34c00qyRurQ2Cr5GIOf/w17w4peJWHKKCdUMN7wtL+YOJo/3pAcSkub?=
 =?us-ascii?Q?6Bekb7EsVjnn2mEy6yRxa+Ew5PNYbDVJFXmmiJYi6uBrutYk73Q4fgpjU4iN?=
 =?us-ascii?Q?bvFpGH2uXnGs+sENzg+G+/84YvsJXaMTM+LXBMAD2WtrE3tfHYGJ33hOzq+h?=
 =?us-ascii?Q?vyDbrSaoA73XwcaLgUqYuHNjtpsg/HnlBoe31h5lRWx8pMFEnjCgSKE16pHf?=
 =?us-ascii?Q?BpUUFqi9dClIzEbJlrmnr85cxLhfs5M8CVy5qmlQXKTonsPojzkF3hoSflji?=
 =?us-ascii?Q?p9zhFTdfsROZodODCkTs56ES0JVLgpAoOo4LkIyOKtia7Rtlv/DjWPgVNkky?=
 =?us-ascii?Q?YywmP/3jitHj4woGGwxpaGv94CcJHNcselgZ4nzY0ITgsQRD/Tn2yogOVDwD?=
 =?us-ascii?Q?lTy4uSBeMqjLjADhEawR6ra+JwK+UGuW36DXizN787WGNs4zRALbuUaIPhAN?=
 =?us-ascii?Q?lOFAZ/8ZWA9d0D36e/qfXe72p1PV5cTYV4pfQ1sTihrl+qE+Yeid71WOa4k5?=
 =?us-ascii?Q?MwPauY95myxg1cDAe/Dz3iB8FthALYVL78lgZUtqLz37ETM/sgZt5SGZdMz4?=
 =?us-ascii?Q?3d7U0XbFJm5hAdaKavEN4Nv1Tq/CW97WN9OlFdu0BnWaHbBlqQeYerRmotEN?=
 =?us-ascii?Q?ACjY5WUse2GBa7sL1lySuHobHjlBii9hpy2dzcabUnvuwrYkvPS+rq7O21nb?=
 =?us-ascii?Q?9ZStbRl4FXT2nS8CnwN2fmG+IwnLwRKwDTl+txzY70ehJq7/939T/F3GYHod?=
 =?us-ascii?Q?IdIYT0Ae9ZqLYZjpZcSEhAyUZeX8QNWLl3TVtAC3ql5vNtONM+4oCIultY12?=
 =?us-ascii?Q?eL7bRn1WAx/xhawsaE2zTk6DQRu+SoYhTO4lF+/XRcYHLgZzLpqmm1+6swoA?=
 =?us-ascii?Q?klanlCwe2uQMWdABTjrGbwEuNXLO8XCKoDIsNjeKXBUkHlUrBf2RO3c6IWA3?=
 =?us-ascii?Q?qs9cDTQ4y1OJKdy7Pyg3yBpJAe7X/XdfvJIvmmECijZ004+cDeZhAsTGF2jA?=
 =?us-ascii?Q?93Jigk5bi+6Hu+uBfLajoC+zfUNCvqWfOUQTDC+g4r6k1zSOdEkyCWSkFx7Z?=
 =?us-ascii?Q?n79CUEDIeL5aE2eKJYFmhFiMDoCxm6yyMz6qjBTDgzYI89ZsPZpTi5hnUryx?=
 =?us-ascii?Q?fs4Jh9/pXDXh+yQwSqecYJ1U0TZeLPxEVPXqONWXYbBpAgKBrrn+b9OHchCD?=
 =?us-ascii?Q?l4VEGBqHcDTdIcpciC8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be542978-b0f2-434c-f8d2-08de2915c8e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:07.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W2uboBMwRlu2WKs9pstmsMwm805AlI9dGoQG2F3XIEnPav2LtYXesTv6U2MzeRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Make another sub implementation of pfn_reader for DMABUF. This version
will fill the batch using the struct phys_vec recorded during the
attachment.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 73 +++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index ef90d086f1ac8d..a2574eabb93df1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1076,6 +1076,41 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 	return iopt_pages_update_pinned(pages, npages, inc, user);
 }
 
+struct pfn_reader_dmabuf {
+	struct dma_buf_phys_vec phys;
+	unsigned long start_offset;
+};
+
+static int pfn_reader_dmabuf_init(struct pfn_reader_dmabuf *dmabuf,
+				  struct iopt_pages *pages)
+{
+	/* Callers must not get here if the dmabuf was already revoked */
+	if (WARN_ON(iopt_dmabuf_revoked(pages)))
+		return -EINVAL;
+
+	dmabuf->phys = pages->dmabuf.phys;
+	dmabuf->start_offset = pages->dmabuf.start;
+	return 0;
+}
+
+static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
+				  struct pfn_batch *batch,
+				  unsigned long start_index,
+				  unsigned long last_index)
+{
+	unsigned long start = dmabuf->start_offset + start_index * PAGE_SIZE;
+
+	/*
+	 * start/last_index and start are all PAGE_SIZE aligned, the batch is
+	 * always filled using page size aligned PFNs just like the other types.
+	 * If the dmabuf has been sliced on a sub page offset then the common
+	 * batch to domain code will adjust it before mapping to the domain.
+	 */
+	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
+			  last_index - start_index + 1, BATCH_MMIO);
+	return 0;
+}
+
 /*
  * PFNs are stored in three places, in order of preference:
  * - The iopt_pages xarray. This is only populated if there is a
@@ -1094,7 +1129,10 @@ struct pfn_reader {
 	unsigned long batch_end_index;
 	unsigned long last_index;
 
-	struct pfn_reader_user user;
+	union {
+		struct pfn_reader_user user;
+		struct pfn_reader_dmabuf dmabuf;
+	};
 };
 
 static int pfn_reader_update_pinned(struct pfn_reader *pfns)
@@ -1130,7 +1168,7 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
@@ -1162,8 +1200,13 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 		return 0;
 	}
 
-	if (start_index >= pfns->user.upages_end) {
-		rc = pfn_reader_user_pin(&pfns->user, pfns->pages, start_index,
+	if (iopt_is_dmabuf(pfns->pages))
+		return pfn_reader_fill_dmabuf(&pfns->dmabuf, &pfns->batch,
+					      start_index, span->last_hole);
+
+	user = &pfns->user;
+	if (start_index >= user->upages_end) {
+		rc = pfn_reader_user_pin(user, pfns->pages, start_index,
 					 span->last_hole);
 		if (rc)
 			return rc;
@@ -1231,7 +1274,10 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 	pfns->batch_start_index = start_index;
 	pfns->batch_end_index = start_index;
 	pfns->last_index = last_index;
-	pfn_reader_user_init(&pfns->user, pages);
+	if (iopt_is_dmabuf(pages))
+		pfn_reader_dmabuf_init(&pfns->dmabuf, pages);
+	else
+		pfn_reader_user_init(&pfns->user, pages);
 	rc = batch_init(&pfns->batch, last_index - start_index + 1);
 	if (rc)
 		return rc;
@@ -1252,8 +1298,12 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 
+	if (iopt_is_dmabuf(pages))
+		return;
+
+	user = &pfns->user;
 	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
 
@@ -1283,7 +1333,8 @@ static void pfn_reader_destroy(struct pfn_reader *pfns)
 	struct iopt_pages *pages = pfns->pages;
 
 	pfn_reader_release_pins(pfns);
-	pfn_reader_user_destroy(&pfns->user, pfns->pages);
+	if (!iopt_is_dmabuf(pfns->pages))
+		pfn_reader_user_destroy(&pfns->user, pfns->pages);
 	batch_destroy(&pfns->batch, NULL);
 	WARN_ON(pages->last_npinned != pages->npinned);
 }
@@ -1687,6 +1738,14 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
 
 	lockdep_assert_held(&pages->mutex);
 
+	if (iopt_is_dmabuf(pages)) {
+		if (WARN_ON(iopt_dmabuf_revoked(pages)))
+			return;
+		iopt_area_unmap_domain_range(area, domain, start_index,
+					     last_index);
+		return;
+	}
+
 	/*
 	 * For security we must not unpin something that is still DMA mapped,
 	 * so this must unmap any IOVA before we go ahead and unpin the pages.
-- 
2.43.0


