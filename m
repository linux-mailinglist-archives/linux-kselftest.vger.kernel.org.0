Return-Path: <linux-kselftest+bounces-35109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66123ADB6C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4463BA2F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0D286421;
	Mon, 16 Jun 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVRagjL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D571FFC59;
	Mon, 16 Jun 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091110; cv=fail; b=KFwxn29Glo/xhMvmOX6FU1ANyzaZ1iedeBu6hWtTCigE5vMebeLChpWR/8Ha3bo66RfzYxhl7U7iACqh1k3d51UY6dIBSV43ZS1JWcqGCAXotTBueg/duC1Yh9kHIXmQrXBPsJ1D/xnTu4q/FZDnw5rN/coayfo6np6U+u/9jag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091110; c=relaxed/simple;
	bh=NNp3Q7qiTMeM8BZFosuNskQUxpGbYM8X5kbOfnoOJjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bFvnQKFC2YJ2hZLTjlPLjHACoGAx+MhBRaFslDgvnozltk5NwXLtUFEIfgw1aiLabHU3IbyD/kzWLKSH/lhrFI5XIsyNpns3IVLDOBJZfvqdbEJCWr+tEoWOUcwdeSL6IJxrPI75sxLkyLFW/cq60G7aaN/K7AoHXEth+3I3MM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVRagjL7; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYHhKR8wliZrFJAm5hWiFS/NDQpIRRZiBtMbUNOxnz/F9T9CB/dKpERt9QUM17SNJy6Q7EWir6BZpQbZlu+dZcS0hd7aR78lY/lqRpvoIDHdzXKUoqjGoMDIjdsEvp7vqRuRfeKBCxzzk4vmrlXNSv7osXX1hsL0Lx6xeju8rxNrXL6hBWp1McVUTiB8BMHYJKbk1SBNOkGX0EQIUXewvn6laDKiItM8Jq6895lqbjgapOeCikZ+YXInSKxMnuk2oqJdbxE5GwaWhBR6JPoch30PxKcXXF9UAtXUQd2qxtJtRoCgcPoSUONDfm/GnOiAiM1GTaAIeJb/m6vGIyunbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGkXJvGQNUGRg2O7VsU6tiZlnvIOTsJWAx0hrtz6vlk=;
 b=qPcs7myVtkbDJjDBmL9M1MINMRIPFNUbn3jp9bUSrO7Muh5rnrBZzXmFvp5oXalHinVQ/4vgmhndh+OGOzmZWxBIEVF9kpKqDgFXnXUv07Wq4gjo0OP6UmDejCmXeb3pq+H9KrIIOojH00+S8jjp0FFdcppJttxo4xfTyOyGfYIH6q/w2btDyQlXSjwYz87E5aG1lc/EArqJmmS6O8Ka7QwPLa3IjtMrqZfriAziavsip2jqDDJXjcDQ8nOMFHhCORrG1pd+4SBYF+yvO9Om0os9A5r3SXaSwjoqmXyNGuTIOPSWoPMHa3Wi3xAzipeQMPRnCLzJyTHIpbXM7mYl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGkXJvGQNUGRg2O7VsU6tiZlnvIOTsJWAx0hrtz6vlk=;
 b=eVRagjL7Vv2JRbXG7EzNHDc2QMh5yK3OpAxXdkE6lXnbiG9vYHCYPguUgFs3FD2/UNzVATa8+0BBvvraK9VhSIM+XykmcmGy1WcRITOG2nF+Vfe37zkJM+pj4nkBo2vW97ZswrGrQ202Vug8x7weVoWTWMpMjVOHGEBP+4TyjR2ub1oiJoEL2a5/opOlwxukvVIQKeIsmSBz7C1QcsmT6vLOGWBoWbSk8zpYyS3gUV5SGJ64S8ZqpGd66xVGkpEhfi8/Z8t+7PhNeLQRKkYveFN0X2ZUFp/gpI6wHQQ/o2fozYhG7hHgqZKe8RCDfYooQfyAmuvYEQHPLUkdKqy+Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 16:25:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:25:03 +0000
Date: Mon, 16 Jun 2025 13:25:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <20250616162501.GN1174925@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 31666360-4ce9-40b1-e47a-08ddacf258c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvxRInFcOiLY7wshhokbEsyHoL5Ye7dYN+Jc2mk+vEuZLdoUVF/dAPeOBYRz?=
 =?us-ascii?Q?6KEHkjWoLRaJBQpz+ZWPjePZACpvgDkLhJuO+JXo3xnYRtv2VkBjxzHp+jkS?=
 =?us-ascii?Q?MIriB6n0+T0zxkVCTFvQAuhYGwhiu+7jfR/60isbLNI/tH1CA9+cu+Y2wdcz?=
 =?us-ascii?Q?Nx8Hynv8n7xXzBQXqD2033bu/5kIkT0rO0Zq6spMaDeCx1aDqLqRxKLhWDRM?=
 =?us-ascii?Q?D3bqb42dLoaIivjsRKMpVDeGaSZD8uYlx+Coe1XAQZwhGCqcdq2TdY1B8H6h?=
 =?us-ascii?Q?CawOidNa7KIW8n6OeegPGvp9Xanf/TY/fJGlK87g1PjErJmw7VetBpirKIsl?=
 =?us-ascii?Q?ISQSp6nLCNXGRUjcNICNG/tIQut8HcKE0IajvezjGVAaToRrkvjhMp0Q+3Q7?=
 =?us-ascii?Q?KyevSbgUVng1m9Xmi2WY/IeNgG2ihc5tbul2PujZP7lGzwjiV+ciZJwuWzF/?=
 =?us-ascii?Q?RDGQiXbWvxJ0kIurNREulsEst7oouQcvLBPQCqlzvtE+tjGUXyvzp3Rp26+O?=
 =?us-ascii?Q?fedSkSUSEc5zO1P2z1BefslPpSPItDOgDP6UL7O8/0f8tGS7F7RUa4AxsbXK?=
 =?us-ascii?Q?mv1Cx7qDudxgogXVoKZZ7hvYUD1uQbhTlRtuem9ehuLenDegOo+QwqzYSHex?=
 =?us-ascii?Q?Uo2gvW8l4Gfd5qDPfHD4fC2z/6gVaorJXkB6/jzoLxXoF/3x359GfA9QBVZ3?=
 =?us-ascii?Q?hT+jbfLnTCegGht8A2m+D/KbiaabyuIUJFuzD2RVZsLhr8IIITsMUqjyRyEY?=
 =?us-ascii?Q?u3BlBdHCjQ7OFV9jFptHbTvAdUh5kwvs4JAEHRJiVqe7+FoGrq0lx84XKOek?=
 =?us-ascii?Q?15GorlPIu7rdEWcobyH9ZV+JFyCeBTJTNack8UeKncF+kaC9L+0E/fwMPaz+?=
 =?us-ascii?Q?D8DVSS/TRCB6hMMDQtUBJqbXrsJjvYNCfsgHCarUEEmdKdGCzzB3bgZzeIO8?=
 =?us-ascii?Q?WJaSosE3InmOuBXaHiMdChEbRgF7fj3pZpIl3Dbmex5Cy60USmCYcA6Uv0a/?=
 =?us-ascii?Q?pcHLpFjX4MtEMjxZzaHINjxAlac72vysqP0rbUCJKNY2/5qJ8OZSITrjyj2A?=
 =?us-ascii?Q?OppqLJW4Ri8ssnlSdKxtpuDEp8Ea8l2sj3FmaapMp6FQl1Wbq6YhKfKewWC/?=
 =?us-ascii?Q?HPR4hnUpoWBBR4QwLwKFCosTuD97HwzQV3a7WwXuxLxBHA4zZbBB8OFWFazv?=
 =?us-ascii?Q?oZ5OVAlJTgU7mmNT0NRT6k2ocrHee+3r6eVOvXDmMTnfr0MO5+eEYlCzLGrD?=
 =?us-ascii?Q?dJzetctdqn/ipJVQbM9TP0bcwlws2ANTRwtWBLmWa8BjSX+Y0NOlw3Nqau70?=
 =?us-ascii?Q?21crMgw/cAUyTIZ7VQOUj/N/DSihdQOg2m/6hUSuol6ycgaWXq8hInPRzsFG?=
 =?us-ascii?Q?R6gmNMhFe+0Ee/BArzpv/LqHxV0/VI71s95AfUVO+pVsJym/wzmGR8lD8V0P?=
 =?us-ascii?Q?BPySEetzsOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PtHpIiwgIEiBfn3OkIXi+M5Dn6xQNcu/C55IV1Dsj/gK8p26a6xMaQDGSNB?=
 =?us-ascii?Q?mX/Hnqnu/ITh+Em5t3Gzf9QRzAg5Fxur71A0HQW3ssS6mmslhGeNDqsphMq1?=
 =?us-ascii?Q?lSOkkkjDh7cKr3k7I+dCFpUYfEZVdGXXPoQyQRKaHQ137kRltxgc3q5HHasB?=
 =?us-ascii?Q?vhIWx88BqvNfkDlZ0ebUyB9EoNrcJrxlp7etCaRMtWnShnjbGuVdk46akMyB?=
 =?us-ascii?Q?k5Fhuoi+VOOU0vgxpz0uPqSG10GQN+fFEsvYHgVHC7mEvmf6Wbh5yR4LJMuc?=
 =?us-ascii?Q?52Z33Ak9O0SG1WqQ6yqu6m2V4PF+3qZDDKFXrYKTyNcU5PddfnA7gZqJGMPx?=
 =?us-ascii?Q?Y7wryAYOOOsrtfTj7hM7vC9FZwizdRvEIgjbCSK25QuEUEznX3GNxHn5SpNy?=
 =?us-ascii?Q?fN1s4+2dDmlsUlM6hNLrFuaSGS6JMn8/knUUhLY2G65ZhROaKW5Qr+XezCox?=
 =?us-ascii?Q?u7wnxHDR05ydnEt/jf4aEpoGWiJfX1lyJ5gI1Mq1cf2RuzZBFfGgdu5jm5RS?=
 =?us-ascii?Q?Joxuc7tmVfExnl11JyMEjuWjjiH2CZa5MsUg7bls5OxTBYE5gxxAcTvVEIUN?=
 =?us-ascii?Q?7NMLiT4ngr0T0uN2k6lhrWU9m0rbcQbAebWrHlMntGUqV1njHXv1I9MV9O7l?=
 =?us-ascii?Q?6um0P3rzGPkSpyHU0BNiw6FeR70TSriZjkTZuWbas3KK/yRttVBbgmwGamZh?=
 =?us-ascii?Q?HMPZTAoO929/zToGx6zJbBLB5+0bGi/AG6tsUwWvY0VLvn41ELl4z6iSvIpr?=
 =?us-ascii?Q?y+IJQuPVCIyUDynb3kAbhwYQFWVdtQFIAxg7QCODfbfizEuHKrMAE8mVADT3?=
 =?us-ascii?Q?vtwGCoSPz2slNKhULn2K6sr1RJGAYCGfrg5QnG092ckXKIaDVp7QXlGtdaKR?=
 =?us-ascii?Q?TEpl2YX1HI7h5DqTEuECdLMm4VinBIwe855GHkvT1ikE4YQ/ksZ2bm0Wwdn3?=
 =?us-ascii?Q?PESvNeWYQkIMu3/pT731jrQLIkv5ghvCcq9AJqNxfk1UF3rcoqOzgGy/65bA?=
 =?us-ascii?Q?yebepojgETd3c53LUUoF9XVD4mgsYpWYBTk4IQkgHGYitCaF7vTKUhaMnADz?=
 =?us-ascii?Q?LlUrhIvKh/zQ1HWlWnBcJ5ew5QgUA4PqLjebPVOp3YIqozH0opB+SOuJTxTD?=
 =?us-ascii?Q?FIRzkfVmJmqCt/BWw0E0YrfWpIEZ+A5rJwXZnOe9LEd+AnOT4NH/f7SJeLLF?=
 =?us-ascii?Q?hJ97rmCV0WZqi4v739fwqKZkz03yjSOQb+DRI4UbVMwZ/R1c3rfw6HXGpugD?=
 =?us-ascii?Q?94HQjN/kuOWLq+VwkQEQKEoZDnLFmu64jJUxIgTZnOHBxRT9LDxbGsZfs8Ce?=
 =?us-ascii?Q?agVgAhhTLKO8Tlgu81ZRtTvkMUNmsVBkGXsNU9q4C1IdzO13fYCs8azesuXI?=
 =?us-ascii?Q?fgLjtFtNtHqH875vtH+qEyhxe2pThREuBv5kTUNKCpRLVZNwTZK2jRPfvbKV?=
 =?us-ascii?Q?Ag/8kzo762RaA9adUDn0Jzuo43gyx0RRSbfmbrmO19FyJn5Ww+jXsDIq4oEN?=
 =?us-ascii?Q?XDmFaLPW3wDIoMfVbW4tIc/6TCk3SF86VhksnIG3pmPrhjNzd2CDJzPELOYo?=
 =?us-ascii?Q?nXumVwvv15TfQ/RDKEMLpKGeG7nbgObAOI3puJ2O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31666360-4ce9-40b1-e47a-08ddacf258c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:25:03.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsBmwIQENdf4BE7AUgx6qj0OX8znGSqSl0PfiHgyrX6kTJndz/o19PGNySVtZAd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

On Sun, Jun 15, 2025 at 10:02:03PM -0700, Nicolin Chen wrote:
>  FIXTURE_TEARDOWN(iommufd_dirty_tracking)
>  {
> -	munmap(self->buffer, variant->buffer_size);
> -	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
> +	unsigned long size = variant->buffer_size;
> +
> +	if (variant->hugepages)
> +		size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> +	munmap(self->buffer, size);
> +	free(self->buffer);
> +	free(self->bitmap);
>  	teardown_iommufd(self->fd, _metadata);

munmap followed by free isn't right..

This code is using the glibc allocator to get a bunch of pages mmap'd
to an aligned location then replacing the pages with MAP_SHARED and
maybe HAP_HUGETLB versions.

The glibc allocator is fine to unmap them via free.

I think like this will do the job:

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa51..e0f4f1541a1f4a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2008,6 +2008,7 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	size_t mmap_buffer_size;
 	unsigned long size;
 	int mmap_flags;
 	void *vrc;
@@ -2022,12 +2023,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 
-	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
-	if (rc || !self->buffer) {
-		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
-			   variant->buffer_size, rc);
-	}
-
+	mmap_buffer_size = variant->buffer_size;
 	mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
 	if (variant->hugepages) {
 		/*
@@ -2035,9 +2031,25 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 		 * not available.
 		 */
 		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+
+		/*
+		 * Allocation must be aligned to the HUGEPAGE_SIZE, because the
+		 * following mmap() will automatically align the length to be a
+		 * multiple of the underlying huge page size. Failing to do the
+		 * same at this allocation will result in a memory overwrite by
+		 * the mmap().
+		 */
+		if (mmap_buffer_size < HUGEPAGE_SIZE)
+			mmap_buffer_size = HUGEPAGE_SIZE;
+	}
+
+	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, mmap_buffer_size);
+	if (rc || !self->buffer) {
+		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
+			   mmap_buffer_size, rc);
 	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
-	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
+	vrc = mmap(self->buffer, mmap_buffer_size, PROT_READ | PROT_WRITE,
 		   mmap_flags, -1, 0);
 	assert(vrc == self->buffer);
 
@@ -2066,8 +2078,8 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
-	munmap(self->buffer, variant->buffer_size);
-	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
+	free(self->buffer);
+	free(self->bitmap);
 	teardown_iommufd(self->fd, _metadata);
 }
 

