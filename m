Return-Path: <linux-kselftest+bounces-41762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0AB81B59
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BEE18961B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41124501B;
	Wed, 17 Sep 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOxlzZO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA61FCF41
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139325; cv=fail; b=aygMrQTEj5XAEAMV/j7bnL0nxQ74Sh0vxJ47zMv5nhDTi9LzdU+oA/+Dae/toJDYeXgm6LqZACnAe02ErQHbybLp+iaWvL/wZ/35nAqBFsuK2Dswl9WDzX/Sfg99XBMLjCSN61pOwahkz9dh4KLDqlJ1OphC4iI6pfdspjGzP1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139325; c=relaxed/simple;
	bh=JofwjcQy8XFd+jnaVELVtGe4CUh65RoB7pU7rjC4fjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARkiFNJSoPakLAb94xOYpG2ZjP6EvqEzeLRKbib3h99yx77l9q+P7wjje1Rw/i/YGTeI7bAmI6ZL2V9GPrvpFrqLEVACN1xLNNCd9n0iffGAMmQCM2kosLY8CNwC5LVEH/tRyJ9oWA7b6vNtuQMLA03wZ4semsJFIZ/+UBOdeZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOxlzZO3; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8zcy9s5RvZRv+8VgXu6V7rBTHPEhw9gLQwpztthlg/baGHHzvKJ6egd028yjs0xCRS9fDdmevHWwitJc5rgbgN2T9HzK/5EfTjbMXaTSHAh3B8DNq3bIJGTA3Wv2oUMUQzfu568Xr9NvqGkYtaC3UIJCGk63QarZBJ8YDfmoD82UozGDIu/BZkTscrXQaV9ctNClfhoQvknv6w867rfJAFfVx5DHzCH2878j9+8Q+sF4NKHOErmTTR76MYQb+6AiRHIEd7+4FQXRFeJ/L69hiCYtE6az1wnEBj4ZvbbTzhbEXCxD/LzEfWGJaJ+23zljGu/3mBQZE3PiDdse/Ojnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujQNWQ/4GE9uj1zwrBmcMjHKuB3viXpPGZscy2479KM=;
 b=BAGj2QXynxM4gj/r2shQ8buqFbmvWAJJXzvhl5XfoeDh1Xg1MiQ3/J2/WBFfb0xH+heJlvTK3nSwYUGeGKwo7G8i2V1EJrx3Fy4Gt9I6UrRHm2OGMSuXZ6WdR7S0KMMQzythgJpU1PoyCOjlbVuPTTdJOBpLvdfpQamYkK7uY1c+GZfGdxBm5aA8/J/ZSQNx0AYQFNOmYkiLVBMofjGaj96OYKIHfTVa4+PuIxH95U+xw1vwaYKMBJZ7OirgcAndUyN+8F8jMA1ZI+451bXSTFTAuJV2XLAdQF0HjU4VnXWeYo/iyp2MIgu8lu8huwT4Oc6UWU4KH5B5bN8Wa4xyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujQNWQ/4GE9uj1zwrBmcMjHKuB3viXpPGZscy2479KM=;
 b=VOxlzZO3vgGQ//VRjxc4s5c069+3UGDD8hLjceBxyc1FWxYGeKUK7J3rga5UPxt4XAuwg/LcJfilMEx2I9x/i8qd+LJm6ScDKMABCSLoEcScEMFgmjxFU83TFKG9k0RnDbI3dUJJJFnxOX5Gdpjas6dEu1iG68IeJ1OlB78RcOnvG53ILcXzpqs8mRuRxUtG30yJU4S7oKBQnT9IEwfmwFz7rrgfuLfPND6D2IaA/G3WOS0UNERpifI5wr5xhEA0VWzIHUb6YRujVqgmzRdLj1i655byNULZ7GE5zBT79DBIiTRokAFNCswK0AzkZCuNywiZUZKrATBWCWruqwIDsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 20:01:53 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 20:01:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
Date: Wed, 17 Sep 2025 17:01:47 -0300
Message-ID: <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 291254b6-ac1a-485e-2ef8-08ddf6250afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rX+YEz13h88c63w9xgFXHu0zpVqn/8zJ0JdOwwtovGhhkoZnVHtaFs6pJorH?=
 =?us-ascii?Q?LvDuqooeLBIJyTFCNhNxn0ZjcU1jroRAhr/Z+VMX01ndQKBfcPLwAsGPKLab?=
 =?us-ascii?Q?/YgaUBGwcY2VXgaoToVJ6boV8k2rEueo421kz3fy+0lOhoOAvm2AKTxb15Jq?=
 =?us-ascii?Q?GYH/2zw0Ur3sKghyWsAM19dy9aCYRUTHJr0h2Gnx0I+3vETmbK88CTSRgkyx?=
 =?us-ascii?Q?evoMjffaZqbSfEKUSjmAml5hDuWdXv+C5+4dbvdbCYdJr/zzkR6CpVULSNnt?=
 =?us-ascii?Q?r1B8ROAHCHp8GQ16jWVTntbXhwSl38ej0JACpCmTesWP34oPXutQXZHSNwZ4?=
 =?us-ascii?Q?hLZWTPTz2zTAlWZZyjQevDOB9cMB7V9ivpci9GW8RceUQSWtz7hvv8Ruq96p?=
 =?us-ascii?Q?Fga1rt58hhla+8uvOcR7wSf48dUTfPumfPSmnFewnvyZ0B424soTCoofheA/?=
 =?us-ascii?Q?zFoqUb4h15XOQCkUmIVu+juVcrzRTwB2DJfYUkbpUMLNndOZulDe1xlvpuKa?=
 =?us-ascii?Q?wW1axAzq6MzbBt+X5Q1rVGLJVWsdUjQgPXZZuam9kAUZePDPHS5LKOdGX2Yv?=
 =?us-ascii?Q?Jsh2ba39xiQPKOg8qP7V+OTI9LqGwyJ2DcLBsCJtC8Y+KHxq4UGCQKIri9XF?=
 =?us-ascii?Q?LH6iighSsESSSs7CddxZSvY4P5qAJOZzeGG+mt5lYCohrpRnLgwI1CEAe/Ah?=
 =?us-ascii?Q?/WzGnwDjcno2eyP7NZJmdRM0W2x1W9eBr5+FIVToZ8zuTZaLvd719VjgnEXJ?=
 =?us-ascii?Q?g24L4Wz+pN/EqJVbFGhD7P8uenaN3cgQNkq+wR7qSkwqIFTszKlnQTu9e63K?=
 =?us-ascii?Q?zHb2KEoD5NYCjxHEhS5supgskQFPuEcr736mRPQf6q4aGpx7mLonIBLyGAtA?=
 =?us-ascii?Q?Lziah16V02eOhcLmsigcnFOSdtwH31rl1ioKLlQl+rWivbEJ4pX6pOa1UGM7?=
 =?us-ascii?Q?L5+lgCxZN50LOG7EhDMgKbJI8B2RqqcGVYEP6qE/kSrlbd04VH8vyxUbx8X5?=
 =?us-ascii?Q?fQN+G782F+MBC82/+kLVkG4ofEcNqyDoaGkJ5Qh2VORL3sVbbTTsa2pvDMgm?=
 =?us-ascii?Q?FcXS9oTmCjxnXikhc0+151l53HL3nPTEmHv3zNs5lt3Hfu5MRIqFZAGv54Ta?=
 =?us-ascii?Q?fGlz2A1/JImZyq6AMwHUeCoIo8TFPF/PBY/M8SSZTG2vtGg9m2jzP6M1bmFO?=
 =?us-ascii?Q?h7ZSq630aVMtlFBXaIVoUowXgvD7SrpPLt8UjfKiJYalzMphOpc6Z9xln2Gq?=
 =?us-ascii?Q?6hGSCYE0CwJLx2NBB5zys9RleDbhyIJKDpUPoUJEF2Ft60D3hhttnmr/nF65?=
 =?us-ascii?Q?I09xc+enkqXv00vxculht3QsBOyF4AomlOh6UmWVgleuCPzUiyzIx33oVnW7?=
 =?us-ascii?Q?GqPzmt7lhpdVREfV6SzOSuSa3WE6J1AihmTy5juEeaUI49Xu619mqS4bncea?=
 =?us-ascii?Q?y5UtYf729uI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHxvHBIm/jt3XTDVjDXm3le3Zsd9EBjLB9CGv8aCb1lEO4UiFuRgbswc6ViG?=
 =?us-ascii?Q?SN8KyZKVsFd63yF9ZX6F+8PmkknYbxQAFS5uKswCOHffMon2Ix1Tf8Do5SsB?=
 =?us-ascii?Q?MyydnyioY1zxPPdUPmMDxuT9763WGhFJdcSirOoYr8k7ybwoSrzD4LVFmCai?=
 =?us-ascii?Q?wlecDsVU0oMkZNIkAIltin9lc8PWz3Kps6jdyL6/YHHUh4YE9mg2iMlmwnwh?=
 =?us-ascii?Q?TUkZoSdYdKKZsJ3hmbsESwrqJH40M6dv0cOUYAquXHFJZAIkNXtZGiO+o+/3?=
 =?us-ascii?Q?ypGweGl9agWu/ovzixFi0uy9nSK1nWStTxnoY5kjWJMozqcJuIEx9MiQ9Eev?=
 =?us-ascii?Q?JVO33tQ5Ktu1p1ZxVsXXDpHMrRJ5yU/YccizeNJYAU99INoe+qtpOcOdAe09?=
 =?us-ascii?Q?eHHUvXBXeYM42ehMfnpN6TENgnj4IjT9ZgKA3zT6IWw7WieErl4TpJe+0iIU?=
 =?us-ascii?Q?3DoCkMv1+Gi1qRHi9OJsOusMFhkuaIsnpIEsvoGgyf9y6Ghioghn+GpkiqPT?=
 =?us-ascii?Q?8oqnRunakRGN43zBHfAjKsIsd0E5EISXx3HHeDmeRTizmOgLUB9hH2aYCwgE?=
 =?us-ascii?Q?5EirRVRsm6tnY8oJ8nyYD1qXnVXDa9Ef7qn5w9iGXP+jIwLXTnN+qkoirGEt?=
 =?us-ascii?Q?/XRVxjkIGFkJYj297YSLWXSHaMYXWlrKeLXj99rcaN99zsmTXCFXIcYH+yC2?=
 =?us-ascii?Q?eE4iE3gdOiDV4NOJg7e7mt4T4LEnPk/oSj4RoIVNhlYin/3oRlpE10/mMOAY?=
 =?us-ascii?Q?MsdcIEOyURQny32IocZj2Wi9r/7/2zggJhKclpfEvyq+nygoo7LkLnW5kFKN?=
 =?us-ascii?Q?4My3oyhWWG3kSx4Ezf8CJHR4nAxTX0PwokpG7nCfgirPuM6pdXcayu3UlAI0?=
 =?us-ascii?Q?5Gm1L1N9NFzVd2g/4w2KBLr3FrDn1hkifT50V9xP32sZfW7QciBzpHdKVKok?=
 =?us-ascii?Q?ddgG9Cis/DiToZbwtsSGenIpSQzG0m1cpt62jvzqcDEK7u4iKYv/jsJIT1lH?=
 =?us-ascii?Q?qKhUyEWobYC5MBjxKdiZ1ThzKpaoO+R9D1+1dG6B0XRyJ/jB9ILipH8a854O?=
 =?us-ascii?Q?nBaYDVIxR6mTOzWAul6IPBL7JA3thHQV8YAhMjUmw+zfv2R9/zFR3OtTHMwz?=
 =?us-ascii?Q?CtWVIvFQ3QY/8tKhVo7XGRbGZQ/p8UMmsNVLMsb5JHPo9x+vwgiY88U8ek/C?=
 =?us-ascii?Q?P7gQu+wbAqM5484F1N7NI8drXZWKuYf9x6a1b3t96W0y41QglXJlMYZOe6WC?=
 =?us-ascii?Q?2N+22QAWzyGzJGPaiBYRraHKcPKiGvTa8Y7em31ersB0CmX13/v1B2J6zsoZ?=
 =?us-ascii?Q?PG5uhfZYkmEy1klnY5xj4nCSdXuedjNcDWUGXrgx5HX5zuf7LATBRRYG4mln?=
 =?us-ascii?Q?rhAH0G2umQmQ0R/4pGAUlDZz8T6mx19DjvOxvEsMiz0QWFcAUy8SmFpw5lLN?=
 =?us-ascii?Q?kD+PxAzspLhVc7hwhDqGCoxgfwx46RhKtlZUj+RES6voCpDJquFoWzQqnTMj?=
 =?us-ascii?Q?rbYIR2DrSaVjkwqiRq+RRBKPxQ9kd01fiPRHrBHFD5gXf7ZHIJ0EuOBCULfU?=
 =?us-ascii?Q?LCkTQUfaWB65Du/4hBc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291254b6-ac1a-485e-2ef8-08ddf6250afa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:01:51.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BCDErIamFBr5AfEywjSPfMDHb7xH+bbdTLp0WQahQAAjhJIAc7BSPnm+SqYSQsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

fput() doesn't actually call file_operations release() synchronously, it
puts the file on a work queue and it will be released eventually.

This is normally fine, except for iommufd the file and the iommufd_object
are tied to gether. The file has the object as it's private_data and holds
a users refcount, while the object is expected to remain alive as long as
the file is.

When the allocation of a new object aborts before installing the file it
will fput() the file and then go on to immediately kfree() the obj. This
causes a UAF once the workqueue completes the fput() and tries to
decrement the users refcount.

Fix this by putting the core code in charge of the file lifetime, and call
__fput_sync() during abort to ensure that release() is called before
kfree. __fput_sync() is a bit too tricky to open code in all the object
implementations. Instead the objects tell the core code where the file
pointer is and the core will take care of the life cycle.

If the object is successfully allocated then the file will hold a users
refcount and the iommufd_object cannot be destroyed.

It is worth noting that close(); ioctl(IOMMU_DESTROY); doesn't have an
issue because close() is already using a synchronous version of fput().

The UAF looks like this:

    BUG: KASAN: slab-use-after-free in iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
    Write of size 4 at addr ffff888059c97804 by task syz.0.46/6164

    CPU: 0 UID: 0 PID: 6164 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT(full)
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
    Call Trace:
     <TASK>
     __dump_stack lib/dump_stack.c:94 [inline]
     dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
     print_address_description mm/kasan/report.c:378 [inline]
     print_report+0xcd/0x630 mm/kasan/report.c:482
     kasan_report+0xe0/0x110 mm/kasan/report.c:595
     check_region_inline mm/kasan/generic.c:183 [inline]
     kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
     instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
     atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
     __refcount_dec include/linux/refcount.h:455 [inline]
     refcount_dec include/linux/refcount.h:476 [inline]
     iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
     __fput+0x402/0xb70 fs/file_table.c:468
     task_work_run+0x14d/0x240 kernel/task_work.c:227
     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
     exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
     exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
     syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
     syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
     do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a2.GAE@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c |  9 ++-------
 drivers/iommu/iommufd/main.c   | 35 +++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index fc4de63b0bce64..e23d9ee4fe3806 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -393,12 +393,12 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 			       const struct file_operations *fops)
 {
 	struct file *filep;
-	int fdno;
 
 	spin_lock_init(&eventq->lock);
 	INIT_LIST_HEAD(&eventq->deliver);
 	init_waitqueue_head(&eventq->wait_queue);
 
+	/* The filep is fput() by the core code during failure */
 	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
@@ -408,10 +408,7 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0)
-		fput(filep);
-	return fdno;
+	return get_unused_fd_flags(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -452,7 +449,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->common.filep);
 	return rc;
 }
 
@@ -536,7 +532,6 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(veventq->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 109de747e8b3ed..b8475194279a9a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	size_t file_offset;
 	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
@@ -131,10 +132,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
-	if (iommufd_object_ops[obj->type].abort)
-		iommufd_object_ops[obj->type].abort(obj);
+	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
+
+	if (ops->file_offset) {
+		struct file **filep = ((void *)obj) + ops->file_offset;
+
+		/*
+		 * files should hold a users refcount while the file is open and
+		 * put it back in their release. They should hold a pointer to
+		 * obj in their private data. Normal fput() is deferred to a
+		 * workqueue and can get out of order with the following
+		 * kfree(obj). Using the sync version ensures the release
+		 * happens immediately. During abort we require the file
+		 * refcount is one at this point - meaning the object alloc
+		 * function cannot do anything to allow another thread to take a
+		 * refcount prior to a guaranteed success.
+		 */
+		if (*filep)
+			__fput_sync(*filep);
+	}
+
+	if (ops->abort)
+		ops->abort(obj);
 	else
-		iommufd_object_ops[obj->type].destroy(obj);
+		ops->destroy(obj);
 	iommufd_object_abort(ictx, obj);
 }
 
@@ -659,6 +680,12 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, "IOMMUFD");
 
+#define IOMMUFD_FILE_OFFSET(_struct, _filep, _obj)                           \
+	.file_offset = (offsetof(_struct, _filep) +                          \
+			BUILD_BUG_ON_ZERO(!__same_type(                      \
+				struct file *, ((_struct *)NULL)->_filep)) + \
+			BUILD_BUG_ON_ZERO(offsetof(_struct, _obj)))
+
 static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_ACCESS] = {
 		.destroy = iommufd_access_destroy_object,
@@ -669,6 +696,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
+		IOMMUFD_FILE_OFFSET(struct iommufd_fault, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_HW_QUEUE] = {
 		.destroy = iommufd_hw_queue_destroy,
@@ -691,6 +719,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
 		.abort = iommufd_veventq_abort,
+		IOMMUFD_FILE_OFFSET(struct iommufd_veventq, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
-- 
2.43.0


