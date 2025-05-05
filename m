Return-Path: <linux-kselftest+bounces-32403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A0FAA99B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B291166494
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8ED268682;
	Mon,  5 May 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0Sc24cV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479B1A255C;
	Mon,  5 May 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463827; cv=fail; b=CYLQPQksb1P+5S31aBoKsCZMio96gK/T2b9LftAgWy0OPskhY9MIwdjA8UZWhbshDfw3BsQyqmTlo3pbBG8vJktIh+VWVzZqlSIdogB1NyPLZz5wvJUln3C3hzGBo9G//Pd8/AEmqhZ5wz+rOnt4Gd/g+I7TVSujYaluDE/2Vbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463827; c=relaxed/simple;
	bh=fcjGJE+1Uv4pAHCZmMXinKbUEt5JmgLebj+PYBl+3C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fnU96cq7WU63+jQtniUGMOEcPrnjAUBh664+gRvCIw/J4oVNOVmHcnuWwjn++sF3ar9TG0R6qbr0bcUzayIUNRyo0RGg7DFuHWDoN9E3YJUdaBhCUKhVyIv3F20FA4MDKhjFJdOzIYa4cKgRoSjNk00EdJet9SI6r4CJ5REm0GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0Sc24cV; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRd6Z0GZOJ4Nyw7sAwWwbEaEWgptAGJNP2tzmNdR9fr2GyKYkqU9wjDUv9nE3Bq1waXoFZg4Q+N1RCc5EhpU+xhXErNf4Ad1rIIfEK2brJFSeIwbWbOgseWYOtntsB4ZzcXetB5Q6QFArfdb3aeWskegMqnrJ1QuYcAXIQ0NLn2ZqdyPMCE2woJGi+tD6PHjMUmJEZU7aTQoFlNwd4JF5rF26bxFMcXeDAF9IDO8PtA3pToEmfezgI0a7CaYQki8U01yFdfFtYA7+aNF0DSYrACoMed4JPrRa5uh2ZvQ2eAxGnfOURkKFBV9WeE8aDoLJm9CBfGrZW//a9/8GiktJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0n7Tspj8ibG8yEA3X3plcQ+ki3JQkq0ljbXWOv2hSc=;
 b=IE3V/Ghft0LvpIIaqhkRxTxNscbThuEnztFcfMTr+VAoxXiifBGavkX3sPqNXeRPjDO80kycjpcSUdhb8dGG5JF/xmcnJgQgDsXg0fYNPIFlBqjV+2XZOXf0g+aLu5tVlL6G2Ik9Fl79NY7f51vp/Y8F27YYmErDj7eRU+oogC02Cpe2uF4Qf0/1ASCuGAy7fwWhJzaVZRuwYpUK90PDd5EULx0N0nJzd9GwRu2NyoX5IJXOu7RNilWMUGWfw3VxLl4XJLm2soo/jcVH0kr7/h/vQCjTVZFPJP6i9Xl0Q/qqjwctnmtzkZcvP3XUOkKGym2hLqg7oAU/ehTOn6WN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0n7Tspj8ibG8yEA3X3plcQ+ki3JQkq0ljbXWOv2hSc=;
 b=p0Sc24cVoJVdofwY+i7ONbbSv7RD0uSqI5e6nWZwHo6niAsJwMmOwM95+fdz8RCewfPU3pHBDivLqwdEdDe/9NC9L5BbTlVCPMRiBX6QYHPLoljgCMOuWZdh4Ghnfiau013bOTTfZevJoRa66fKCCv+YPyN18BIbhdcQNPTxphWEwUt+EpU4CKOxCjHgBsZVLFiv248OJ1/f8eI9PCgt9VZWA9nhH+X8NP/CRZv1RSpUA/Z5uyFpFPfhF2Np2t3SSGLKunhLem+oabmVcN8VOwTffOLT2GWmw9b4SxpDKxPMEgywHLuylxfkIiXtzYHSqk9Q6qY+LGW7qE8Xeo8KGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 16:50:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 16:50:20 +0000
Date: Mon, 5 May 2025 13:50:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250505165019.GM2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
X-ClientProxiedBy: BN8PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:408:70::44) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: f1edbe3d-cb35-47fc-53bb-08dd8bf4ebd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?btgUnlYba+pFJN6VNLlMHquA9nwx8vICp52kiymDtNN46WggwE+dQ9WSvRPN?=
 =?us-ascii?Q?kCH/RHVP2sYbXrVmotA/5uqGkdRliDbfWqMDU99PbpBrtYzBUL700NHLDogc?=
 =?us-ascii?Q?y1zJDtTk6RbK7Nddksk+w2FKEOC5HwyYZB+5BfGXYMl3M0fGnMjdiMArfvEF?=
 =?us-ascii?Q?GXP261dQYfp+9y9Oddz2snwe+UdIxGUDG4dm/xwyX2tl6R4792fBo+qKPZrp?=
 =?us-ascii?Q?hXezxg7O260sds+c69YAD6GNUv0iRigp1Gh/iTORyQBoh8+uD9kfQW85UA4q?=
 =?us-ascii?Q?XJzIDEEPTnhYXqSl5d6SqYJWxFw2adEJQKmJm+wUbvMMPU7BolUOE8ZmJfph?=
 =?us-ascii?Q?SkGGzYQIv+7P52XTWQj96Mc9TqVQ3M8IUdavTlMqOi4CzbkRjo5TWiVyMQAc?=
 =?us-ascii?Q?Y+DVAms3kbWi6cU1eG3uDea7IyYEq6h+kce8L3GuFdwXj30YdZybP2p6GVRi?=
 =?us-ascii?Q?jkmM7cpEDuq6oh2cusLIDqaMiJeCu3dHB9DsVdu0GnINWtmEbyjCAMLxamGG?=
 =?us-ascii?Q?5KmeFCSrzqcUIK+8ikQ1HJKcGcGAmWhBqxgXvX7tdnRtg5X+Wq40PCAKglWq?=
 =?us-ascii?Q?7VdsKdTd7ghBoJB4iWPheOe9xcsTyERFdoheJu7MPHFLOUs6ruuOqG7b7z5d?=
 =?us-ascii?Q?n8vzowmQUMFfbdC1mUiyS/2aZYYfKnHh30KnSw9blKQL6gP9FbLV8ekRl6uX?=
 =?us-ascii?Q?87CTNkLw+EJsRrRNrfhxNoDSETtDmiWkC3VW4N0ge/e+ZtYReYPv+URkz6BS?=
 =?us-ascii?Q?/WomqT7B/JcfjfUBWgjT/TRE+p0ojcdcPwNd8QvjmoCPbSyzNTwvbdv1VqYd?=
 =?us-ascii?Q?pM7j6ltowJKCOt3gIxmbV/4jK2oKTNiKOg6BKN8o6/hnUK/GbsqD3l0BZGzo?=
 =?us-ascii?Q?b3XA+0IhTF4s9Ka0sQQLr2U/DZTqHpCVtDvNuQo72DXyL+K+Oz/pHfjeX+PG?=
 =?us-ascii?Q?oUVHrpUe2t1Rac+Ad5Pk7fRlAzMipIT6ITUNcLrKu25jzaSXzPCiduD1YqVd?=
 =?us-ascii?Q?83574FJwlJhoshn9qYt+MctxHuAxbGxSlWPu97uS+UoQ/ISE6JV/h1csMJW1?=
 =?us-ascii?Q?RfOko7dnvNfgo7bH7R3nIDUvtBB3MVL+AUybOAEU1llFHlsuz1iksfwJj5Hu?=
 =?us-ascii?Q?9oXIhuwvT19HhWwzN5tisXaKtBz5hEUrOEz52M+RMzZr8loaCq114s1OTou8?=
 =?us-ascii?Q?uYRnaGFpQyFl6J9+fSunsAPfx+D7INd6JZbgThvcPJKWic2MpPuxuHA9mDP4?=
 =?us-ascii?Q?7LfkGRBDJ2WQ3LGk3W2z4HF4gIWVnv53hO+egROxn6Sy6rrgneP1vw1ltKzk?=
 =?us-ascii?Q?u+Oz/5f0qk829Pv4m/lKA1a3naMKfH0JTxK6Ojj2rZxXkTcCTsWkjsu2wNkl?=
 =?us-ascii?Q?l+y2BnPiIUvU61zgL7ejNxZc+XewkuiL4V/sDvLnIxQNVOEwkImVe8M3zO6U?=
 =?us-ascii?Q?p7fM78F9taM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8N5+VaGFOL7ZVYDMlcq4FuGhYKEyf1adxVzVMhAKqDqlRV7J433plBR6DU0?=
 =?us-ascii?Q?ninBp0m/u6EKa5S+amT3U9D2XF2nwzhN6uNMn5EYCwF6rtCbatQSXP8Y5KOV?=
 =?us-ascii?Q?ovWQQQgyNi2MnxjFQs7sEnc8jT2rzL5ki+Uy6mQT20P1avMXmHKkdGW1fX2x?=
 =?us-ascii?Q?eOjJ9ak31f6slpll0MZjOysENNFcBBANrJ+DTevQ4q2A2CzBYo4XrzO8pu/V?=
 =?us-ascii?Q?stgEvLRh4UVGVU4I2MSa0IxhVC1bKhA5+dtcEiaMVT/a76owD1n34tHtdDAS?=
 =?us-ascii?Q?ti4+SWSnloRnYaDbP9UXu8vRr/3ux4RQXBdPK812HvJ4lOJdPwDr23hvDAn7?=
 =?us-ascii?Q?Akn6Hn8g6nlkoyYkjMkXUQRteNCwCh27bXmsmmVbokQUpsvPX8s+HWN6Xbi9?=
 =?us-ascii?Q?3+YfMaGx/++s7qOQK2CGajDRs21cLn4tVFr36prhwmGhf7mob3UeZKEXEAko?=
 =?us-ascii?Q?Caf+YOo75nbgXImABF7DkQNeZDO2S6Gxths1l1lA6Xf0yOqTWxIQKJhMNUdu?=
 =?us-ascii?Q?nZlCNlROt+Q5jAb31FBxI4Q3P5wbDobCnXU12LBYWEuwiBiThqVREqoh1bi4?=
 =?us-ascii?Q?w+K/qYlxqN6YrjlnV5ujJ1XRmyoKFmbpUt6P6OAVroYNdCgcsCnHSC1np3gx?=
 =?us-ascii?Q?XaOblVENPTpT2bDoDSK443fk64pdXvKgMkXlSsZaJyJnE8QbLaaJwT/BHI+e?=
 =?us-ascii?Q?y/MfzM75La0slwTaiC+8L+OcNoxTxtfSRFCk6FV0qTt7TbJutSigIGVT8IbN?=
 =?us-ascii?Q?Otw8S15nSvvOlmjoxsU+Vsh43moQuuAkmgXxHPr3D7jBUqZ2IBDFaQx7Bs11?=
 =?us-ascii?Q?2/K3KSlG/wZ3XZ+sggZdnHX++ElSV9q6SoZ1+UPb/M4woJwbgNyumMZw6Qnf?=
 =?us-ascii?Q?a324VpV/XNFj+h02Hdn05fblW1D2uOYDUtegHIuxJY9ecJP2YPrpCJlNBIu1?=
 =?us-ascii?Q?DTwHeCKXuHZUkK7lUS3e5awMONF20VK5VExbZBhIGWQ+J6Gg6nAvjnLrchJ4?=
 =?us-ascii?Q?izdNmQEu/Hkag/fC7GrVUXHvBqBnt5WNZDwLXYVJzEQY/0IYRmP0ywQ6ikcY?=
 =?us-ascii?Q?qblYEmUGnHItE0olktBKlAqmDRQXPcXl5BSEiCp8s7nSLEUbTmjg2cmLtlUC?=
 =?us-ascii?Q?szdGnlzxdstzqLw+bYNLvQBAbziJ9Tgjg73WOdeJqDVi4Mtcj39yOk74QC4H?=
 =?us-ascii?Q?AQ0PUznf7OXR7PYdV/pdAE2gg5WfG4zZmfd798+0xaX5QwXQcXJ333A3bfMa?=
 =?us-ascii?Q?nhydRZxUMrNZW79q+aCps4yak6De3xPKS7c6PnvMUeSFgDx1bM+AuqXoE35D?=
 =?us-ascii?Q?v6ulKqOp791tWbN6zd8ujeYGXP5W/2z0RNeUmipdH3UXnhrLK6IBP40V6YCk?=
 =?us-ascii?Q?2+YmrTqO4MQC/gO4SeyUV7oJ9m4gA4wdpMA6XWpvL/s2MpjtlRSKOIyT5oIk?=
 =?us-ascii?Q?o4/vpK71fNu66l7QvOQ0RPf1O6sg82NkTT2T7TwnjDOUgOqfRd5JDn2GhC4b?=
 =?us-ascii?Q?/Ri9ONBqlXrbNU9l8yMBMamess1cRTk6vdWoWyhV1YAi6V/Xy8ErnwM05jcy?=
 =?us-ascii?Q?Se/fC+Zf7uEPbLqjPJYpiUu0k8ZwlFfAeGhB1bxJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1edbe3d-cb35-47fc-53bb-08dd8bf4ebd8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:50:20.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGuZn0E9fw+nWb+8Es/XBoWUjgh9tdSr6sIY7P6QfxIF1vM126Kkx2rOy9x3rhnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

On Mon, Apr 28, 2025 at 10:50:32AM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > For vIOMMU passing through HW resources to user space (VMs), add an mmap
> > infrastructure to map a region of hardware MMIO pages.
> > 
> > Maintain an mt_mmap per ictx for validations. To allow IOMMU drivers to
> > add and delete mmappable regions to/from the mt_mmap, add a pair of new
> > helpers: iommufd_ctx_alloc_mmap() and iommufd_ctx_free_mmap().
> 
> I am wondering why the dma_buf mechanism isn't used here, considering
> that this also involves an export and import pattern.

The provider will be a memfd or something, that isn't where we want to
put dmabuf..

> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	unsigned long pfn_start;
> > +	unsigned long pfn_end;
> > +};
> 
> This structure is introduced to represent a mappable/mapped region,
> right? It would be better to add comments specifying whether the start
> and end are inclusive or exclusive.

start/end are supposed to be non-inclusive range in iommufd
land. start/last for inclusive.

This should be a u64 too

> > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > +{
> > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> 
> MMIO lifecycle question: what happens if a region is removed from the
> maple tree (and is therefore no longer mappable), but is still mapped
> and in use by userspace?

I think we should probably zap it and make any existing VMAs
SIGBUS... Otherwise it is hard to reason about from the kernel side

Jason

