Return-Path: <linux-kselftest+bounces-29274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCEA65D24
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917613B6463
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFAE1E5209;
	Mon, 17 Mar 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ta5GuCG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2471E1E0B;
	Mon, 17 Mar 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237376; cv=fail; b=dFVvvODVTwp5uIPH0Qxp3nDNEU7ZAMFA9nMz7GGU27Ne+mcMGReyOvQ4Rn1PLv4yODQDy4cVAHV9B9i2Ip+100yD2KmfHGp3oeO5JO0bYNrwwcOOmzVKAHDVOaE4DMxHW9fjW5NmYpNz19P0+NMhbs0QLqDebMjohyZQXjXHhGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237376; c=relaxed/simple;
	bh=7ciRmG86Kz+2ZX82GYtcjesbRuCbhfkyQi/IMmNRqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHljuKtOHkH2LH848dNQb3CcMgY3nWGo1JCkNF94JNUh55XuIMuu0EIh4cusOeIAT0sA9oCYorchplXaw0B1co3alw227RQTtK2K/atMzYvYzZNPClpjJ7eeJ+IWnGoFQy9bVzDWREwR/CT886ro1KwDYpMgBiYCyrGBBWhwLjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ta5GuCG3; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUSZfJJNsV1wfsTI1CBDGVotV8lAW/p0JySqHU5K9LPWSRmlgsy96HE2WliHbhEvuuCqfsKYR88qOgVVQ4ngzag+2/EYOrQpLtLzLODHudfWSby3jfFBXgjsfKnj+4fUtjRj6AW9tW5cuzQtg0A8J84huJgcIWvvxL74mKKGxwnVS06W5+BKOMOFFs1qpKWxtxdXjq43yfGxjkHNSwc4xDZY6hchsKuRRorCOB1zyl5LUZHZyr4s+V4WSViTKysNyZh51fvFPKLEBgh4u8OrAtgFIJ7NDMQR+XTcBuj5TqopYgoFcPQLw7IPcBKDaC+0fPxvX5QRhqD8lYBHsHeUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaDraG0VqnzTeusPbnlcILqKK+zWtIOw7ZP87wyWl1Y=;
 b=RLZjjPhOF1Fwu4X9zoqJf3u03fDemjkeYQIeaS4miN8FcmbiAeGCCpJIpWdvAeSy7mk45XxnmJR8ONS8SyL0NNWCVsxm/L0iYl+3woQJ4vcVYuBhZ1QWmtQ9vE39yAc32WqPuM8o5MwMHAvAbOBrFlmjrVUD6NIP2LweClPml1VdAGvSvIF603ivsT8FriVDhfgEvVgIHprauQ3UhT+s0f/LfaswV0DaBpAE2/Sf9P6pldvguMsz+YNrkG8YQ2DLNrqeMvh4wXDe+BZC2NcY3Kmcv36Vm40Xkw1Do+3W1X7LPNd9OxsN3XJpHTS+VSgtpb2E4fYMIzRUjU52SKfAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaDraG0VqnzTeusPbnlcILqKK+zWtIOw7ZP87wyWl1Y=;
 b=Ta5GuCG3BJxEtmGr2HTEdOEBIVUypqEGM1Pikg64YZNcTBncxDS80MkjXa1mn96zIC3SSdpNqYc0hSEgnNXOfZEtDj5VMPKiG8YO6zwPIQ7DXuZ8q10yYEQ1op+GVf0W2hMUDAgigYZj2AUkOoWKZidjQwKaXvqQHx6RP+2ymivo2dD/NT6I687hxQ6ywani6iLl0Z0BXWuQRgDD1jhzIAVL9FYV1vw6/DlRwxJJR4cbp3gS0+/JePDMgSk56e1QC0G0fWTdcHF9SdpphCGbSW7rwNOv1w4HM2QeFe+Vtot7CnwceIibC3WtfytF5+EoBoaFqJkyeLk4mN7HOo/E1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 18:49:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:49:31 +0000
Date: Mon, 17 Mar 2025 15:49:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v9 00/14] iommufd: Add vIOMMU infrastructure (Part-3:
 vEVENTQ)
Message-ID: <20250317184930.GQ9311@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:fb::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 58831bfb-e576-4608-2a1a-08dd65847414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8s9jdC09kAfLyKk2bBiBKGUH+WruWX4n+7/6MNftr/mc4XBgHMDIIodzOMY?=
 =?us-ascii?Q?NVX5m+2HdHf9yW44IfhT/tobGgG/KESBI7+2Y/a2cdXjI8G3AtrtKMEkvq5X?=
 =?us-ascii?Q?ldQsBkhiC7pkQ3KHZWCVAW6Sby7NLsM2vewzcAcXsgpRSnVA1+NSVjuGdFh4?=
 =?us-ascii?Q?AiEPYDkff4IDbeWVsgHyTLbLiBsUrRGonBZ5mkMF4w8Db/SkST3Z3yRMMbuU?=
 =?us-ascii?Q?bkOuKAiDFRe4XkjurE/oulkroej3p7wPrmnrYIDEJ2+NeZ7MBMFQFPY9L4cm?=
 =?us-ascii?Q?3I7ie2s5PZxffolnLS8LDJh1g+WcFCC/EXyE6wVqmqD2X9c7hkWoQq3EXdAJ?=
 =?us-ascii?Q?MSkfvLp/j3tcFgEEASGuLyf3toFTPx6D+bFKzs9mStALXGoyhg2iBuW95Rww?=
 =?us-ascii?Q?DbYGr0tAc9Ehfo68THQI5M8xI12l6ulBkWf8LVTQ/y5u33Weq4MfTII5yNXf?=
 =?us-ascii?Q?peI322hrMDlP652z+6SG7VAqqdxv87eVeDecF3koYtWHnILI7uzHj6E2k/Mv?=
 =?us-ascii?Q?MxsM7jX9HjTA+mcG+IOV51okC312dGn5I+djx/5VvcgfbfbnLYMzic9REm/P?=
 =?us-ascii?Q?DtpDwI+j91qG/PumFkXPu2pZvteBRc1HI+UAQOOBC4QBZGlo499C6TaOmbXt?=
 =?us-ascii?Q?l2O8rnjO4CT/1ZtBuj69OdWl+hkLnnm4E66SjMtOHJezzdkpWkx5w+cWQllh?=
 =?us-ascii?Q?Nzw2LEnqRjBFpS0d8bX3bVNc9/yrqWPDSQD8oC8aO5e8YQOSbMxUaeFpSKT2?=
 =?us-ascii?Q?K4F3RyNjNY9gDY4v0fsEneEkuuYy0lWrRA1rruN/Ds/waRE6K/i2602tmSCZ?=
 =?us-ascii?Q?x9G4jMvCOJ2um8y/AquCnhIJYAa9WBgH/QwwrsDOrMcQzBY47wfE3A33RXoq?=
 =?us-ascii?Q?swsmx9hI3nFXs/ieUIyyPOXBPx9zbDm5bO4o3ZhVghm9R9okwbyfOC3P9wwD?=
 =?us-ascii?Q?B3+0g/aRQrop3imvJbuoLlafSqHkMXyyXsIf4SU6K3Bw+g0UeNubrVn6Luwm?=
 =?us-ascii?Q?so+wrCcdsAvqih6Fgq1k/fkTfPX7BJVvQpz12IUVinX3j/YkURtMXYjHqZZh?=
 =?us-ascii?Q?qeJNoWulDTqeKpxvdzbElCEbXOF4tM9Tyk5Xmfg1V8i8dhyzqNHRjoldQn50?=
 =?us-ascii?Q?KQNXk5Kl1ZfkpikPBaTo3aIDcxoc8HmijHqrHqafonccaKOvhb3niGGyHRYM?=
 =?us-ascii?Q?QYX0tZtK3w4gc2ziTfohZEBWkAzMxFvZj91GN/0iJETyJCcSnaxwPqhUud3/?=
 =?us-ascii?Q?CMAGKDcGOb/JUMR2FC7nnEeyLKSqVzWi6jR59xs0QjHx/kvnJUph6kyPYYti?=
 =?us-ascii?Q?Ju4MBSKObzjZtKbSuxcRhQfLgh+H+hUWg7rEWoI/6nRdTaSkR43qz7Y25zph?=
 =?us-ascii?Q?E2LC8MHcimai8/OrNRN5Y4K+MABp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4svhi+vbEvVOv5bS8p0UG2YhQwMM2Lskxu+xEp7GeKAl1cwoVa87TqvXNdC1?=
 =?us-ascii?Q?rWRGb6QEiocTHYUyQkt5PFOhRBzuWTWHFftn2R1VTrJKr1vvTniVilgQWoK0?=
 =?us-ascii?Q?RJYOO2Iw6hupXZZS48R3ZRbYKSr8Ddp96HLWMrJszGzXK+hHIHdBndjg9FpR?=
 =?us-ascii?Q?h6rsUCNi0sdoEF6wpQa3/VcFb06ZVW2feqSSF0t3xwtpjE9MICVYcrepibUz?=
 =?us-ascii?Q?WMreaEm+h/p//n1Ew9eOOET4HC5/WSkmfeW523/Utf9sa+/ht5INZ/jVWZ9i?=
 =?us-ascii?Q?5c7S5AVL8cdFIeBTXO23TfO6kS95Ul5jXfHvef9GMlsPzMl2tKgqO8evf+Us?=
 =?us-ascii?Q?t8RNfzscapvgZcg4DsLByq78rnN7rf3RnQeXPKdw+mSiPBOB45zZSaqTBEQZ?=
 =?us-ascii?Q?EdfQe97KMVHDh9G62eb4h9NXEYzlsQF86ozBEjgp+9cih+lfCQVdmoKGg4db?=
 =?us-ascii?Q?vZwM+kA4Sx66MnAgvd7y+6qQDkm9in/xd3YQ9YaHmtNPmMRi6ujdWI9yUTm0?=
 =?us-ascii?Q?chGgN8ROyMr/q8V0UKXeXOH7hlsz/SlzmnoXTeyDkrpup8UWGTSxQy6HcFUH?=
 =?us-ascii?Q?x63VPwycfOhn/nv+Su32pODYc/eFu3v0G1rCggbx5c6/29xWHPaw0lrVSHQ6?=
 =?us-ascii?Q?LNP9a5D4rFzr5W2uHPG3/53mpWwXIW9dRoju75iY+XuBbfiG0Fu8ex0rEvhC?=
 =?us-ascii?Q?jJOXesB00VoTe6E+iQK4/ZZtbP59w+Ox6Qjzv2Oyta61VyEpvK5rfNfPx+kM?=
 =?us-ascii?Q?i55QL9uQtA7flLv+2dIj7eWlN2rk3RDbMLM0XSv1c60XZKnKVfVHxYIbxDVX?=
 =?us-ascii?Q?BKxOVOii/xt5oH5zMuLbtO/b/XqYlEtqT6rSrOMXM6jpbDULlusckIrbchcM?=
 =?us-ascii?Q?3IxJLYys7emyRdKjwgUNVwpVavzn4T3tja9MtknUyug2zY2WPgnyPOHR2EH+?=
 =?us-ascii?Q?tVD2oyg2M+9HsvA5M4OQK06WaJdS/LIssSzlU5ck2lsvfI9ih4wwee/mtvBt?=
 =?us-ascii?Q?Fjy6NIUKbs1aHzhsQAEPYoyUZ+qgy6PqNUErPKUSDb0XUklseaIOXss+GT+E?=
 =?us-ascii?Q?EQCOb1PA8MQaAwDTofDCsOvIRklUKr9bUzCWNOgM1VNRMArCs09wbIVark+0?=
 =?us-ascii?Q?Bzcp87jh1dlUhtS3niUMlSgMLeQ0JgcbHWDV+eRJojjVMVb7Afz39SZCUfZB?=
 =?us-ascii?Q?GyeExeiCdOzBfZ37WIbzxMItUu1XukKushqBNGDc4qWhk8nKfE4hz/2B+yr2?=
 =?us-ascii?Q?xe+vqddiLZoWKFn7OO925AxiGID+nHm0p3Ja1xKS6fx65/XUq6TUnrXc3rFV?=
 =?us-ascii?Q?FdThp/pLnJoVhyRK1dKePrpQHOeLCFPnS/Di0Sww/Sba+IZrqf+2sr1JKHx3?=
 =?us-ascii?Q?UpPY6FdbdM62J3c9XSXeQGyeiwO8JtkKbkSFjOLxrVx91oUvEmkUKJBnOlOS?=
 =?us-ascii?Q?wpIz9k2BGft1s2NIG63QvGASEo13oBxFLayOzErD9GvWase78Yj4JAeZLbnQ?=
 =?us-ascii?Q?DGNSIAJCVYK4FUJNR56rSvYNAQkvZICprhm7LTE2boF0kbm3zy7JTTcnytkt?=
 =?us-ascii?Q?wT7VoXhdGlK8x97ijxXpsHBwSOBcD+iSq59hvizx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58831bfb-e576-4608-2a1a-08dd65847414
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:49:31.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJWMjKH5Y79IZ852FkDE8m783iSB9sMFaNN7GqDW3zMc2k+R2CEQzuYjdgSVBhyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

On Tue, Mar 11, 2025 at 12:44:18PM -0700, Nicolin Chen wrote:
> As the vIOMMU infrastructure series part-3, this introduces a new vEVENTQ
> object. The existing FAULT object provides a nice notification pathway to
> the user space with a queue already, so let vEVENTQ reuse that.
> 
> Mimicing the HWPT structure, add a common EVENTQ structure to support its
> derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VEVENTQ (new).
> 
> An IOMMUFD_CMD_VEVENTQ_ALLOC is introduced to allocate vEVENTQ object for
> vIOMMUs. One vIOMMU can have multiple vEVENTQs in different types but can
> not support multiple vEVENTQs in the same type.
> 
> The forwarding part is fairly simple but might need to replace a physical
> device ID with a virtual device ID in a driver-level event data structure.
> So, this also adds some helpers for drivers to use.
> 
> As usual, this series comes with the selftest coverage for this new ioctl
> and with a real world use case in the ARM SMMUv3 driver.

> Nicolin Chen (14):
>   iommufd/fault: Move two fault functions out of the header
>   iommufd/fault: Add an iommufd_fault_init() helper
>   iommufd: Abstract an iommufd_eventq from iommufd_fault
>   iommufd: Rename fault.c to eventq.c
>   iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
>   iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
>   iommufd/viommu: Add iommufd_viommu_report_event helper
>   iommufd/selftest: Require vdev_id when attaching to a nested domain
>   iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ
>     coverage
>   iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
>   Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
>   iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
>   iommu/arm-smmu-v3: Report events that belong to devices attached to
>     vIOMMU
>   iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations

Applied, thanks

Jason

