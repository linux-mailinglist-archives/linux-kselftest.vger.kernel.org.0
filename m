Return-Path: <linux-kselftest+bounces-41836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D9B849C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66121C83AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405252DF6E6;
	Thu, 18 Sep 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyNl1F+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC42FF644
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199146; cv=fail; b=uwX6Q8WG66imPBQHTdpsuwNjfTwPGVrIFLe4GJjKOUxrNfuMXvxRgXNQoMN33YmIh6naSrOaYlR+G3fphck86pDVKYBzb4M9Z2bCmeIxvNE/tY3WaWv/Rwa0DC8mr4Q0eQI/VEwTT6ZPyfzJ9tAgw9knEtDVX933qBpKTvjvQbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199146; c=relaxed/simple;
	bh=OxZP3ieveybUZpBKRRlAXwS9tiUY8dxlKGSWWgyaiNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajjuYaF2mtOFaUiTycTlCZyQGkR+s1r5xRI01JeezSgUuoapzhhBwlMLWdQi8IGlt6AMLZTkjrNLXCq3JZ6Q69TwZm0XbCfW3VPAHfsx7GDhpNTUV/xXqtYq158E91skdb2CZmCh+pG3JGvDYe1JFlCEeLVFNJE3AqNdKdRPNok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyNl1F+L; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMaYiV/KbF43yqkPBx0k2/hzK+pqqDnSbbiGVxVQp/VJaPI1bMYDOEg4m0UMMRYzcwqAfNcKBNhR8WrZUXBcDeMQAAw7yEUI2Y8DN0/4AzdXq69cdt3whmtH3eK8d0Nfh/KQF9I2Dvhinan4AH6dpHTr3vE7zTnGlWRXYuSJAEok9f4V8iJt4wWHy/2VNlARGYLhfdqxmfzYr2JZ9jGONClUU8vPBNSvhYaujkYWvg/0CoEnOL6ixE5AuguBL0H/zDPvml6kELKfjCKQGYh/jlWv2R3nFNHRXMcWe6/sgwBUgje5/t2Ic2GDS1Lqhf3L15YX4073M+j/bLEikNrULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jomRPpGfHF+KEa6GmU9Y3+1Mr22sYkkmXq/uVRHRmDE=;
 b=c9uCrPgPgUknTk9JW2qgCuy9o1HCiQaXNNR9bGKQzK/pSh13H0irS+XhrkYa2Cb32PQir5Lsfls8TkD5IMnvp/2BbZfBvTMUduphvxyHJoeytH1FjiNk+tvsUEqa/4nkbyYDGyXIN4MOCq/JSHl5DNsaMi0PXKVBuzPgtiTvDiPSWdTDNhcCtst4Am1HmRu53mN4RH0slf4wHSCFRre6yOv9JM5iQYTI+PcGsDkQVMXyTPhBX+4vQ95BA4KyImcqY9K8d3PQFFOmsjIOHwXwYoj6m2ZFd479ZsS+lwOgjMcCuT9UxPCAzKV01xF8LbFYzUhdthDZnXSopsSVQLftsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jomRPpGfHF+KEa6GmU9Y3+1Mr22sYkkmXq/uVRHRmDE=;
 b=ZyNl1F+L5i4Fra8znpkbyZiSJdwj0wYVjK490kH43jAVeUv1dFcpk1V/TPh5TlKGu4CHRBjR8jiSQV22GYQjKZUVcAfm+iftvnJ8SiTagObKOq5ZLDXqGJHGy6lmlLLE0JZSlpw/yLEufZlUH/X4H4I95/H5Hdnb24c0n6SPuBror59A5bW6zS84Yb3C5G/L/cZYGGhs6yvhb6S14moRJ7jYB4W9kenR33CDq8TGGdLZqOABnvj2zxlxj0VgAa4TXZlIJprIv9HnQRQVfOzj+RpJG+v5f+MGO5ohpI/SFeUarmTN1p4xVV4OxDtk2/4xmqhkuVxCCwAgJO3Sdd/Z1w==
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 12:39:01 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e1) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 12:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Thu, 18 Sep 2025 12:39:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 05:38:43 -0700
Received: from [10.221.136.181] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 05:38:40 -0700
Message-ID: <12171a1f-d385-4f40-87f8-004f37c50142@nvidia.com>
Date: Thu, 18 Sep 2025 14:37:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
To: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Shuah Khan" <shuah@kernel.org>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, <patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
References: <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 666d5096-2ae6-4808-f192-08ddf6b05849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDUrNnlqTlpqU29zUFBLajh3RlJUTm9EWkpKeWZJOC83ZTlodjI3cGlicG5E?=
 =?utf-8?B?R3dwM29jN0c3MlNVU2xnWU4vMWRPMGgvV3ZCbFUzc05DMzVhTlgrdVA1SEVI?=
 =?utf-8?B?aDgxYzNnL3FPdHpQR3BxTXQ1WFowTWFrb3ZuV1lNWjFYQUVWSytzZnJ6bjk1?=
 =?utf-8?B?bFArdC82QjluS0FkbUhGWUtkSVBJM0tpeWlWajZpYUE3Y29TRngrZ0x6Q1k4?=
 =?utf-8?B?Wm5VY0k1ZXBPZTlyb2MrVU1scFFZdGtsQ0JrcWNYeDdBVm1BemxYa1pKYUhC?=
 =?utf-8?B?T0UzN2ZEbjlseFloZ09oK29CRkU1cDRzZFJHM25RQWRORWw4Wll6TVBtV1VR?=
 =?utf-8?B?Uk8vNngrUHdONS9kN2FJbTFkWDBLU2h2MWxVUjZGVHN2cFRLNzdoNlZyQ2M3?=
 =?utf-8?B?YkNjZlRJdWVGVnpLcmEvK2tCWDBBNk1MYXdCWWJySjI2U3dZMjhNRXF3YThY?=
 =?utf-8?B?R2svWHNrQkVnZFg3azh2alFZN3VZSU9YYUkzWTVOeWM5NFRIaHJaREdJdytp?=
 =?utf-8?B?MmZYZTRLK250OFkzaFNFZDhhM3dFeDF3M3p4cGFpL3hRUWVVMFBNcmNIM3dm?=
 =?utf-8?B?V0c0WlFEaVJ3UjZsWkc0cXhwOXB1UUgrSWg1a0FSQzJuUi9UM0NBbWpKZXVG?=
 =?utf-8?B?WFBjYWN4L3F4eUYxQ0NBZDU3YSt2T1JhNHNYRFc1UDJSeTg0RWZpUEgxRlFP?=
 =?utf-8?B?dVM2MHFXTklvZ2Iyc01vdEFWVmhXbXpuL28zV2cvOFRrc3c1Zm5XSVk4Z2kx?=
 =?utf-8?B?OEV2VWxLVWM3VTFjU1JzUmZzdE8yOE11cGk3TS9mN0JRSUVXZzNyY0lGVE1E?=
 =?utf-8?B?QnJXVGhoazZCaHdFaHNjdDFBMm42OGptelYweWliSFdSQi85STZkMU5vVHpi?=
 =?utf-8?B?dE5XZWZiT21LOU1WQzVPQ0hydDNCazRKYzJYeXNWOTZsNTVSK0JCSnp3NlB2?=
 =?utf-8?B?eWRRQlhkckdsa20rMFhHaXNvNjAzVVV4TEpLWkx3M0VuR0RnU3RiV3o0K3JN?=
 =?utf-8?B?YmhodlMwZ3pRTjdJTklSMVRYaG1sc1V5QzdkeVAva2ZzUmRYZEgrcnc3S016?=
 =?utf-8?B?dWZsVHNzQjA2azdsS1ZYdm9ldzc1OTV3dDdzQzFkdFJiL1VYUExmeHVEVEdG?=
 =?utf-8?B?K2JiRkFvRmk3ZVlDcFRJbElmbmtpODdBejJZVURiVkEwc1V1Yk0wSWVvTE96?=
 =?utf-8?B?ZkJsaFgyRHdEbmFqdWRBUXV6cnhqT0VDaDVKNDB5Z21rTWNVVGxuMGdGUmVo?=
 =?utf-8?B?NnR4UE9hQ1FBNnZUZ3pTTThoTi9MSjFtdEVlQk56V3NKQVFjYkRIajNiWE9o?=
 =?utf-8?B?c1dNQll2TkpBNnZQeHhsc2FIQWdjRU1VejdqSkxuY1BjeEdjUjF2Ly9IcUs4?=
 =?utf-8?B?UHQybUF3WFl2REI0SExSbGxIK0R0cE9OcnArUjZ4RGlSVjZnMysvcC96cHlI?=
 =?utf-8?B?M3dLaW9nUGdOczYzQkQ1Sm9pUmVzOUpsbmVzUlArZGxhbHhTbEJDengwNXlK?=
 =?utf-8?B?NDBNeXRBL0NROURSeEVtakdSY2lhbWIzOGRaVEYzRkhaQTIxdlA1VGthcVNH?=
 =?utf-8?B?OVBJUHlVb3pXdW15cVVmaklDck9IMUZIUmxBMzU4MG5YeHltY04rWmQ0Nk96?=
 =?utf-8?B?Q2tYZC9BZnl4UHR5eU9OYUFSWjVkSThkMHFZd0lNQ3RxWTFldk1SZDlzak05?=
 =?utf-8?B?eGViN2ZHTWdKWU1jQkpNL3RZcTlKOGdPUWFqcXZ0ekxxL1dLcVQ2Nm52UmhU?=
 =?utf-8?B?aFJTM24veEtnRUlqa1VqVWluV1RCVk1Rdmxod0VvUGhwSmZRVmlTNlY1MnJy?=
 =?utf-8?B?QmpDc25ENGgxSlNHRmRwYkxaTFZmTkI3S0F3VFdHRm5XNWlpSlpaalBNZlVk?=
 =?utf-8?B?L0xZZ3FWalVpdStueGF5TEI4aUFhcW14VkQ1U0xzYlp5emZMZkQyTkU3c3RN?=
 =?utf-8?B?WS9PN3lMdWxQcU12cE1UUEZpczBOVWZtRU5rTkpLTDAvdGgwckd3ZHBkRC8y?=
 =?utf-8?B?YlhQRDJ5QmsvdkRQMXEwSnF1NndURXcyRzFzdEZ6SkFXbWlrT09yc2swcU5J?=
 =?utf-8?B?MHNqOEF5eGpOTlBrancwRnBYd3lld0V3MXRnUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:39:01.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666d5096-2ae6-4808-f192-08ddf6b05849
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731


On 17.09.25 22:01, Jason Gunthorpe wrote:
> fput() doesn't actually call file_operations release() synchronously, it
> puts the file on a work queue and it will be released eventually.
>
> This is normally fine, except for iommufd the file and the iommufd_object
> are tied to gether. The file has the object as it's private_data and holds
> a users refcount, while the object is expected to remain alive as long as
> the file is.
>
> When the allocation of a new object aborts before installing the file it
> will fput() the file and then go on to immediately kfree() the obj. This
> causes a UAF once the workqueue completes the fput() and tries to
> decrement the users refcount.
>
> Fix this by putting the core code in charge of the file lifetime, and call
> __fput_sync() during abort to ensure that release() is called before
> kfree.

Thanks for the detailed description. I had looked into this but couldn't 
find a straightforward solution.

Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>


>   __fput_sync() is a bit too tricky to open code in all the object
> implementations. Instead the objects tell the core code where the file
> pointer is and the core will take care of the life cycle.
>
> If the object is successfully allocated then the file will hold a users
> refcount and the iommufd_object cannot be destroyed.
>
> It is worth noting that close(); ioctl(IOMMU_DESTROY); doesn't have an
> issue because close() is already using a synchronous version of fput().
>
> The UAF looks like this:
>
>      BUG: KASAN: slab-use-after-free in iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
>      Write of size 4 at addr ffff888059c97804 by task syz.0.46/6164
>
>      CPU: 0 UID: 0 PID: 6164 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT(full)
>      Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>      Call Trace:
>       <TASK>
>       __dump_stack lib/dump_stack.c:94 [inline]
>       dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>       print_address_description mm/kasan/report.c:378 [inline]
>       print_report+0xcd/0x630 mm/kasan/report.c:482
>       kasan_report+0xe0/0x110 mm/kasan/report.c:595
>       check_region_inline mm/kasan/generic.c:183 [inline]
>       kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
>       instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>       atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
>       __refcount_dec include/linux/refcount.h:455 [inline]
>       refcount_dec include/linux/refcount.h:476 [inline]
>       iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
>       __fput+0x402/0xb70 fs/file_table.c:468
>       task_work_run+0x14d/0x240 kernel/task_work.c:227
>       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>       exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
>       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>       do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a2.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.coz>
> ---
>   drivers/iommu/iommufd/eventq.c |  9 ++-------
>   drivers/iommu/iommufd/main.c   | 35 +++++++++++++++++++++++++++++++---
>   2 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
> index fc4de63b0bce64..e23d9ee4fe3806 100644
> --- a/drivers/iommu/iommufd/eventq.c
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -393,12 +393,12 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
>   			       const struct file_operations *fops)
>   {
>   	struct file *filep;
> -	int fdno;
>   
>   	spin_lock_init(&eventq->lock);
>   	INIT_LIST_HEAD(&eventq->deliver);
>   	init_waitqueue_head(&eventq->wait_queue);
>   
> +	/* The filep is fput() by the core code during failure */
>   	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
>   	if (IS_ERR(filep))
>   		return PTR_ERR(filep);
> @@ -408,10 +408,7 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
>   	eventq->filep = filep;
>   	refcount_inc(&eventq->obj.users);
>   
> -	fdno = get_unused_fd_flags(O_CLOEXEC);
> -	if (fdno < 0)
> -		fput(filep);
> -	return fdno;
> +	return get_unused_fd_flags(O_CLOEXEC);
>   }
>   
>   static const struct file_operations iommufd_fault_fops =
> @@ -452,7 +449,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
>   	return 0;
>   out_put_fdno:
>   	put_unused_fd(fdno);
> -	fput(fault->common.filep);
>   	return rc;
>   }
>   
> @@ -536,7 +532,6 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
>   
>   out_put_fdno:
>   	put_unused_fd(fdno);
> -	fput(veventq->common.filep);
>   out_abort:
>   	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
>   out_unlock_veventqs:
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 109de747e8b3ed..b8475194279a9a 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -23,6 +23,7 @@
>   #include "iommufd_test.h"
>   
>   struct iommufd_object_ops {
> +	size_t file_offset;
>   	void (*pre_destroy)(struct iommufd_object *obj);
>   	void (*destroy)(struct iommufd_object *obj);
>   	void (*abort)(struct iommufd_object *obj);
> @@ -131,10 +132,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
>   void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
>   				      struct iommufd_object *obj)
>   {
> -	if (iommufd_object_ops[obj->type].abort)
> -		iommufd_object_ops[obj->type].abort(obj);
> +	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
> +
> +	if (ops->file_offset) {
> +		struct file **filep = ((void *)obj) + ops->file_offset;
> +
> +		/*
> +		 * files should hold a users refcount while the file is open and
> +		 * put it back in their release. They should hold a pointer to
> +		 * obj in their private data. Normal fput() is deferred to a
> +		 * workqueue and can get out of order with the following
> +		 * kfree(obj). Using the sync version ensures the release
> +		 * happens immediately. During abort we require the file
> +		 * refcount is one at this point - meaning the object alloc
> +		 * function cannot do anything to allow another thread to take a
> +		 * refcount prior to a guaranteed success.
> +		 */
> +		if (*filep)
> +			__fput_sync(*filep);
> +	}
> +
> +	if (ops->abort)
> +		ops->abort(obj);
>   	else
> -		iommufd_object_ops[obj->type].destroy(obj);
> +		ops->destroy(obj);
>   	iommufd_object_abort(ictx, obj);
>   }
>   
> @@ -659,6 +680,12 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, "IOMMUFD");
>   
> +#define IOMMUFD_FILE_OFFSET(_struct, _filep, _obj)                           \
> +	.file_offset = (offsetof(_struct, _filep) +                          \
> +			BUILD_BUG_ON_ZERO(!__same_type(                      \
> +				struct file *, ((_struct *)NULL)->_filep)) + \
> +			BUILD_BUG_ON_ZERO(offsetof(_struct, _obj)))
> +
>   static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	[IOMMUFD_OBJ_ACCESS] = {
>   		.destroy = iommufd_access_destroy_object,
> @@ -669,6 +696,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	},
>   	[IOMMUFD_OBJ_FAULT] = {
>   		.destroy = iommufd_fault_destroy,
> +		IOMMUFD_FILE_OFFSET(struct iommufd_fault, common.filep, common.obj),
>   	},
>   	[IOMMUFD_OBJ_HW_QUEUE] = {
>   		.destroy = iommufd_hw_queue_destroy,
> @@ -691,6 +719,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	[IOMMUFD_OBJ_VEVENTQ] = {
>   		.destroy = iommufd_veventq_destroy,
>   		.abort = iommufd_veventq_abort,
> +		IOMMUFD_FILE_OFFSET(struct iommufd_veventq, common.filep, common.obj),
>   	},
>   	[IOMMUFD_OBJ_VIOMMU] = {
>   		.destroy = iommufd_viommu_destroy,

