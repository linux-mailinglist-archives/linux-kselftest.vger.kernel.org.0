Return-Path: <linux-kselftest+bounces-24401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22737A0C13E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E901884BCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F351C8FB5;
	Mon, 13 Jan 2025 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXYwQf+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40F1C726D;
	Mon, 13 Jan 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796113; cv=fail; b=kOP0XbB9iZbQUy0Nqwe94AkBoXznEjARu0l1HEpVMbjgKDLSSuhyjJ+adw0r0af6pANkzLzIroJ102a2+1ONf8eMVac0Zthick/TZg9ue/IRuPY9jltnzEsHIco3bGa0AnV8YBe+xRsr4yFasK+uIIDy5OZR6YlwqfkfdGWHHNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796113; c=relaxed/simple;
	bh=qE+DSmrZFbD0GOZZgw6+JBIVo2ZP63AktB1m3iglDAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Li/35h5kC2486qEdUcKbbJfSZU2Vj7msZ4iqod6O+4L7Nnq/11LaMQDNCQqMq2ZUaVXNApJ3CRWp7a01aXGojjjuyAAnu0vhZDWVklplJ8rf/2PTVDLPDJfZkxjHkHzToam1UzlgnVfC5D7m2k1g6fLPIVmf/4WenlTV9Q0SHW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXYwQf+N; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPhA0wRSlFH4xFQdmIBaWfDYzfF5Vf6BlroAOSgVlhgtp5Dx8FuDkBp4dcmVH+2mgRBxvzPb+HRWfjqfD9GZ+4Qz9+Qmos8Bv87Q2nx440dgyS9XjQl6BJJtQ4bfOKz1S3gEfkQH7NuNajdv9uHiFFXEWFJdpBTHB6biFITLo8fvKPfpBBN52DEDKk5dbh8kYQeQ9HD6Y5wyHzFd5yydhtNNDj6iovL31aUocmqDmqY43mF+/4jJof/DctBvxE7ICnSVDQn4QVT4f8EcSPvliCzRP3erL4w0/b7UYCkWgQIqkg1uCS8NLARE+OvSalFJljmtABkfH/38j3YNlE5Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE64/9G/szWMmsxSaxZRaPYNhkbmTbwo2Gpzv5uvluE=;
 b=YtkGq8r+7QuwOPxDBTaz9u3blikzsif68qS6/wTeld869SnwVMOnAXHlGpgU1qkoRdDMnDc5m4M2NTQ0sOauptkVtNbr3pIuivVM9rP/j0wOmmN0wtzzORxvQEtAUwHMw5JpjviNyin6n7x4pwz9QxoMwY71IDB6+ceanCZU8vZAJh9xW1P74ye86DXHanDd0329wDQptu6CxOTNEB5DSra+cLYMysf9S+ZpW+M9Dn1YhPc2z4Ie3FigxLrq6HqeFlP8CJQyvsDwmeC3Fd4QGvLML1UM70m5wX+a0Ne1N8cuguhGGhX8egPN34ZsPzDM41UvAjNa6taOIvzmGH4mLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE64/9G/szWMmsxSaxZRaPYNhkbmTbwo2Gpzv5uvluE=;
 b=XXYwQf+NZgS4h4P64v1qlHBrqLFv+R2H2klGPgoMhVkH8FLxkvxTlm7GIbaTd5Sr/ypG7WDceX8SdXo7pGXtXI0BkzDdVI/Gymgf0eMAxJTcf2mK/tJPnnKwaBZkjGDahS2FS3qTJbUj2Q0sbUyj+o7ctLQTKZDljOVh53XIZdNdgIkLuFeQrjUjppqllx4xwiNDvOyUMUk6hs8XWFvWLXQ04voLAfcFoK4VM6jNPjJ/7CVnLfsQYcWV2+DEN4j/mjT6oK3a0ctD/NkLAdoANLxfk06OJyVb5XXAvh3LwEs/ki8q3jXWyiKcx9lpbYpZa8LNoGAfVICr71BODZQcSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:21:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:21:45 +0000
Date: Mon, 13 Jan 2025 15:21:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250113192144.GT5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0634.namprd03.prod.outlook.com
 (2603:10b6:408:13b::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: d650c75b-908e-4a94-59ec-08dd340784c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKAmUgjzjr4fHUH7XJmPPBOMMLPmYIfcw/QoaKakIJu6I6hHB8sAOa+zldg4?=
 =?us-ascii?Q?lyzzB+LuPPA8XjiTER5SlSbBrvjehmSUuK9SOOyWRt/BY7c2mCo6J9CoC76x?=
 =?us-ascii?Q?pClh0Ur3mBuR79l558BYGOWDGSzwGOIWQl3W/sHVPZQQzqT1EokeS0/vtRVA?=
 =?us-ascii?Q?ZzZdBi8Wdo6fzdDDa8idPVLNHl8OqhKDewlxnH+h1f715iUPZo5ZT10eO+S7?=
 =?us-ascii?Q?7IXxWZPT232qBCk9cc+fHzrkH1lgAHG21894DaFuO9HJOaFIDocMt6ZmL2Ph?=
 =?us-ascii?Q?o1bquqjwWtXcBsQJP244DX9fHuf4NldMZMPppIEDlQ7FSuFjrexQV9I3jeQZ?=
 =?us-ascii?Q?R5MYA4RNSeiNo7hHMcOs4js4AAMouRtcsWLjGAUevOJdt6dLF3iYGdJWSFAf?=
 =?us-ascii?Q?jiLe3l2DvmhWGqticI3uES1TF7LHLNpmozQwd8DkK2Q6R9uEgV9WCYrFwUJP?=
 =?us-ascii?Q?8w+9J9zX7yvIorAGoDt2o/9mAg5u4/RkWTdO2kZ3nZVDu8SZBVOSOX4xHLs9?=
 =?us-ascii?Q?1MNrP5XMdtIKcrO+4KuLv9nL+VlptOdwope1N2GMXxa+LWWZUQ/HBJfkHZjI?=
 =?us-ascii?Q?1IIZzFNejpLU5w1F3m9wO+vVRkOEUaWKVM1m+U2bWKaiKnuYIBmFFvCRw3Vx?=
 =?us-ascii?Q?EdM1iIfyoMX2bGDwvOXHy+TyXVBL/QHs94YJXC7GH1dqruVvBO7LNzDZnxgy?=
 =?us-ascii?Q?04wVm10vUZLVvZvzHqgbK+iwf4K291ENfOAYRGQCAhns2qgcRiqwtVYEj3y8?=
 =?us-ascii?Q?wIIZfNbQTcyE0KGwuRUnE4R/lbkcq36i3VgIv4zpaq19ABcZj5rTHPDw6h4C?=
 =?us-ascii?Q?mm1LFhNveSDfVfF1I8iDmgI5K3yBghfqi8PsblvZ/jd5yXMK/Wnvz4N8U5Ne?=
 =?us-ascii?Q?oPKwMni8aSiAyjAKeCtu73LszOtvGDSYcsVXnBuTIjbMbqL8o6Yron52nvmm?=
 =?us-ascii?Q?3ACS2t6toYec0+s1U/WyVxOcJn2tvw7BIYccVWjr1PCgeYSh59hVhYqAD/3T?=
 =?us-ascii?Q?ciUq3/CSeSt1QLQU1g9sCSzoGo7LV892wiqoNImdh3+bDqll5d3s//3Ifa6k?=
 =?us-ascii?Q?j6zhzAryHVqSRstWpK6rYWjOm0SX5yh2cAz7D6PVtJT+nf/Vl5gu23tqPYnN?=
 =?us-ascii?Q?g6bSKKUnRx/XR6hPhKOOY7IaceQCGTUWKd/0QBiGtR4oZTp9YTWTTqcRVoA4?=
 =?us-ascii?Q?gCO8yjS3O5TPR2imYbajrteOiM2v0feMqfW0DVxXdDkBmrazNLydtEYpJVTS?=
 =?us-ascii?Q?C07Q/SvAbvJUgBbfTVoEAAJWMvpA9uVqzExx0sObmHOQLaH8Dhntdu3i3w6p?=
 =?us-ascii?Q?IMD3fugiqmnzVgUAg5FSs3oxwvrWGsnXJAx/Iq/i8sCFeooqJhQyKEWx4nrI?=
 =?us-ascii?Q?1btUvrlrurSkhU+WQKKI9oEtS9TO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Q4VfPiO8OkvqzgXDggYIx9+9ukJViloohgyABDfWDVc6kbHVfp0bxVb9sxo?=
 =?us-ascii?Q?wQypm2U2K56iUewhbglqaBacfCkJq+1sDIIkIiPQGpmQcO1A8KWADHLkZXjh?=
 =?us-ascii?Q?mc9ZOE9Yg7wC9FEleQjGrnu3yGN0C+3St1XdshPdxMy3R2Utu9qbjrUjIIAG?=
 =?us-ascii?Q?npHKUENmdvV1KBpKqDrWCTk/g40q0J2eJWausfe/0BG+v7WFeglG9s28upTA?=
 =?us-ascii?Q?9vTVu2jPgzJGugfhFSqy6aNNs48WiqkTqYfjAWlBSaUUAF1upjmLqH3VLtkg?=
 =?us-ascii?Q?Hf6bY1PR1RPHfkPgnCx1jGJiNjYX9VlObJjTo+wHMMcLKRJTdb1MtWOHNR7I?=
 =?us-ascii?Q?6sarp3e8coDlerO6q6fSxD8Zu+xYhndzQhmIDX6w93vR2DHUeOrZb/fJRHHH?=
 =?us-ascii?Q?2Hqx6bC5WPmyFR4X8N4CBM2U20h6YlZAFBJ9oDHB5kfSMtnc7GeUJcJNJeHS?=
 =?us-ascii?Q?kHCdV73tChpphJMTCuyVvwlC/eiRvm2g8mllvw7U4kBD87pW2bQepLS4zDDk?=
 =?us-ascii?Q?qpbDq0mHHgRSfkaUXu2xKdiGXQ7HiXXpL1xE9PTU+wJCwytsKUalt3DmuOJO?=
 =?us-ascii?Q?R+suCt0sAaN7sumYTIf5m5czTWJINeNs4/WAmxpcO7NdpZPflzgNEDQltU72?=
 =?us-ascii?Q?amEuAJLUFTkzz6BxI/AbQHibPoBI5z9gLy6hwKZLGzHaGBbSGjEIUbjrnzyG?=
 =?us-ascii?Q?1sKVqjtxbE99MrVMy7DyQfNh+WP7kkyQxiaqYEhd0gBAqWzL4c88+VdjD0O8?=
 =?us-ascii?Q?7KpW6LQeU9tZ31i/p/lT3su/gSohsg6WPgvjKjwVVF8yYWEaASDejrlUfp47?=
 =?us-ascii?Q?p1517p24mloBx0qql8mZF7SGwtVEHeGA+CJpCCEJh2IISo6Si1wNbU5hr2tP?=
 =?us-ascii?Q?fJeHLRz0Zs8k7CDX8ZXBNvZUX8w6kzYL/jB1+WHF0iygKLpKSGvZ3X2BbcM2?=
 =?us-ascii?Q?pa+qSecMgmxDPc7I8Al+hhTwSgBpvzUIc6Q5isz1LmAGTuqsATlezMrN1u/4?=
 =?us-ascii?Q?HsDhJhGVO/mBWn86PgbYIWihxL8a+TTZbxegVLdMPAgzll+/+u4CCIcSnWW8?=
 =?us-ascii?Q?ihsKWVgTpS4vNDwDObZrUu7LFwxTe0Auq0x8q5VBBeMXQA7YoRlaQrDxJXGo?=
 =?us-ascii?Q?Q9CsTFXUr+cX60Q3hsOdNuwpZXsFAOKalFOmwFZFA+QTy4vXqad1XKjk0i91?=
 =?us-ascii?Q?feXAzhzoCjjSxpXuG/Oz9o0MlLwN6l3zuGROjAb5Eq+2Tkj2mA3wiGto5CEI?=
 =?us-ascii?Q?oE6jrWoMuB1+/5s2hvrdt0pDl4KYj+vY/lY/S9RKLQb/oakmCP1UmUP5aaCl?=
 =?us-ascii?Q?KqnZY3eCOwIM5n0V3NhDbRWHGjQ+6KFPkydpK9Yve+L8SBrJyngMrloW3/A0?=
 =?us-ascii?Q?pGqPqIHbalpoYSr5NBx8IcktYFI6jaTPnuypahQRVwEkbrN/dySXQsksZcOi?=
 =?us-ascii?Q?Ki9Sm7oUhfInSLMu0DjQG0YZ8TjBq5VdxGhX7g8ql1Euc+PUo07tpZ4yJgdw?=
 =?us-ascii?Q?rp+U21gj9CQ/J8CSA2wkM+ZRhIxbdjAMwfnpqF+p9yT1n1AwQZ0Cz+CixzSW?=
 =?us-ascii?Q?S/aFBbFt4NuBl9GaOfgCq/QGmj2Mumcs5Py4AeXW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d650c75b-908e-4a94-59ec-08dd340784c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:21:45.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At/SkKyb0W/sBf8mg6fYil4BpGe2sNly/KcIsMvtjGU1034t/0UOLVFZy/gSEjqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

On Sun, Jan 12, 2025 at 09:37:41PM -0800, Nicolin Chen wrote:

> > > > I supposed we will need a way to indicate lost events to userspace on
> > > > top of this?
> > > 
> > > Perhaps another u32 flag in the arm_smmuv3_vevent struct to report
> > > an overflow. That said, what userspace/VMM will need to do with it?
> > 
> > Trigger the above code in the VM somehow?
> 
> I found two ways of forwarding an overflow flag:
> 
> 1. Return -EOVERFLOW to read(). But it cannot return the read bytes
> any more:

You could not return any bytes, it would have to be 0 bytes read, ie
immediately return EOVERFLOW and do nothing else.

Returning EOVERFLOW from read would have to also clear the overflow
indicator.

The other approach would be to add a sequence number to each event and
let userspace detect the non-montonicity. It would require adding a
header to the native ARM evt.

> 2. Return EPOLLERR via pollfd.revents. But it cannot use POLLERR
> for other errors any more:
> --------------------------------------------------
> @@ -420,2 +421,4 @@ static __poll_t iommufd_eventq_fops_poll(struct file *filep,
>         poll_wait(filep, &eventq->wait_queue, wait);
> +       if (test_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors))
> +               return EPOLLERR;
>         mutex_lock(&eventq->mutex);

But then how do you clear the error? I've only seen POLLERR used for
fatal conditions so there is no recovery, it is permanent.

Jason

