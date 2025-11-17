Return-Path: <linux-kselftest+bounces-45758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19449C64F5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C1A1328FB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E24296BD6;
	Mon, 17 Nov 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okpVjgwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9829B8E5;
	Mon, 17 Nov 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394629; cv=fail; b=lMJWmKHAijXUELsvimlRQ/GUY5axBRoVUjMCzX5YX/Kvj5EPhjYTBS2MKiP1CdOCupSHowKY66YCGoM9+OJQEaATKsUCofDnMbcnIvnXPCHjGc1XnJeq6/W5ekWYWak/meIcYyGPd1LI4owvZ2ya/weG1YS7uhfMwCWcDaSFMfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394629; c=relaxed/simple;
	bh=DEPOK0tVTmZvD22swXJg8duh+iP/Ec9FRxdx4fC0rlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dag3Xx7z9vn0+EUEpXf1TLYsr4vz3WzAU9CsJDPy8UdSq7EMnCE18sdlybF3wQJNGdtGFoCeSbhQU3FAVylet7IRx0oNvfdMTd9MWYzlHfg35th46YlnRMoc0thEQN4Zc4iv2geLQeieE9TeoWQYi+OJG30NNLuXQHB6I8bsEDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okpVjgwd; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvyimsH7BAJQi/ZnVh2l7JdDYt2BOc5hp58XBRCXKkhRqff5Fln+BkufrtnuByZPetnGf6/C99XBFdEQY6DPgR70V26CYTG+iGkrkloe4Kkqzeo3KKpe51pZOPt8eUZLX9opo9vHhaTcjnLaquBtHrTY1/00nNlIPWB7zHvSvy0+lE5xGYnEMIwe/1I/E5rXO15lvN/UqD2AKe3k1wI+mjEUH4Ndiy4uCth13Zzz0ifRMyPPm8YqRotEwIjuznuTeDXe4YSFgDKlikEtOVyK6eBp3K51kfde64ZibeqA4VAnklb6C9trHMOWCB1CRPzMgaDyiDEq4hKDsWvCsqp/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc37mD9QaSAYq+7w3aE6UnYrbibxytcTJLldhXdjVm4=;
 b=NelfxMdujLwxghZKa6A2IN16uDB0cUcLjq6h2W96YZUuAdGPGGXwMwiY/Ej4Mc4NipzocpgmpNGj4Nky2eZf9DSpqQpuJ9B+Z8O3z625IBH6UXcgsJqEOGKbDE68HRCcRqRgok3aw9iJRgXeVshiE1LMwZqmxdE3dPMXXr2KhyrD/NLlc/pduyxw9NDw5OhYyQUH8oz9MyzKmHKHmQXUTR2NE4k0/h5S2vKHpR6/09fLBRPlWJy72OCKJFR0intXhFEWse0CwN01uFUJA70g1CYpTkKKHN0c6OfDAXqe1VaOvweBiVcuZuSZj5Wx3XHO9wRNmSq4SCZCB670YDpmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc37mD9QaSAYq+7w3aE6UnYrbibxytcTJLldhXdjVm4=;
 b=okpVjgwdgV/5/Bn9Sa2av8d1/WA4hfsAGJoIuV9hhoIaLPTi6N9QwW4EftTznuuAt88SMFh7Z30xSLfqVwwDIbK2HdSfALvmDJP6hpyJBcIwcZM6pgmagsMtEna1qHVMTtGJQn/h2Y4e16UTh5K2CWzDG6dPzWaCjtg+jI5R8GE+NX5bort9xTJjYGVf+vYBc5CYUqWP5odUGldzkKWr+G34C83n7wkpUlegXfG7hKm4HyDIRAoovmWD4hR2awf4T8xuPYnD5XPLoTmfhEj47xO9dgOQts5QKJ19dpwYTZx1EgEjRbtJnYHGCbZu7mGcU4tn5cM5j5+6yYIKwQPD4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 15:50:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:50:18 +0000
Date: Mon, 17 Nov 2025 11:50:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
Message-ID: <20251117155017.GF10864@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <20251113113712.5691cbaf.alex@shazbot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113113712.5691cbaf.alex@shazbot.org>
X-ClientProxiedBy: BL0PR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:207:3d::46) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: dc728ff3-2ffc-43c7-2ace-08de25f101a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kr5ASHpw+iOz2zaDEJNoWXIdb/hBbToygu3EPYsR4ornbefEXbTzQ4lRvOzR?=
 =?us-ascii?Q?vgKPxGXMbqTdPwFjDf7bIurCmG7sWXRImaAytM+54s3H6vz/Jmq/iwuMHBvm?=
 =?us-ascii?Q?dm/EvVeVhx5oOrEeJbuXx3+ap4oOPoDDmc3kzPZ2lBjFE+7BcFimK1jh8p76?=
 =?us-ascii?Q?ryMw73RjWuBkZAqBvzAOQTFbug3bPlwOjhayuF51+ietb4X0LP9z7nyhGJ+N?=
 =?us-ascii?Q?utimxU7AVTLv28Z9WLqryU13VDL3wreu7DbeRZKGUQWETGoORboGYBGPr1qZ?=
 =?us-ascii?Q?VHYckgbBavpbGExrPdzJPhKbNI1XlCm89cQ71sUEhqrIKhyV76bc2D276UGT?=
 =?us-ascii?Q?s9Efie902hVpdJzDHsNAIZQwxDq9KBHHpgCPVvEs8VJ4foC49lKM/ouv/d3f?=
 =?us-ascii?Q?WTvnkk5WCLoI/eGW3Rc0T2S6Mv2qaqsTgDMzvZ4fmU4uYiDLHnB/9HyZayPn?=
 =?us-ascii?Q?HmavzrY0mtOInvFaCYOwlmmdFv6whwBTkIMdVykFOHF1rYJwo27itvKADwHo?=
 =?us-ascii?Q?eh6wGWCZbgl23lHynCOyZ3yIGVU+6X0TLU01ZN+SEFQlzDYUkg6NfAGMryQL?=
 =?us-ascii?Q?B3WbtcbXRKvUUfdqVAdlfGDb4PHmJmq6RccXxDxJY2x0mncRLvIQR1qDFjcE?=
 =?us-ascii?Q?rK+fogUMVyRUILYtWGGzMNKsadUdN5uYS3kOYbmFQiuRIYx8C+BewYuTANpC?=
 =?us-ascii?Q?wk8ufNdHx3765GsGXYmRf/KKleELMW5bzstmstpf5GLUZ1+gV1WTUDqdm/ZJ?=
 =?us-ascii?Q?20f9e+9okaAZrWt7Tmawes1wyUGNHYlqO6YbPenRoCV6QHUHDDb6psQmBVZ0?=
 =?us-ascii?Q?AjGsqmqLOKSe2QNt8/OrAmixxYeE6KX3ADOEnP0eS8yan3FjcSj/tjptO0+Y?=
 =?us-ascii?Q?2RsUAe26yUUS8B7tJSZaxod0ERkxE+x5UYASZdJlMJ2UoNINDLCHHETvVSLM?=
 =?us-ascii?Q?whmdhAI7+lKuH2qBkpEjy3eIDu3OL2plh4S/XKuRo39MeF/5j1j97ocbFIof?=
 =?us-ascii?Q?IhU1WwpCs8ZhPSruPbseHkxgvaAFFq/gDpPysj9xwk2uW4GBZtF4l2cSPN5W?=
 =?us-ascii?Q?SvtVy1fjwSdhvxmNh3xLtCevgDos+VoW7P967xnB0w7BQ/j1ct6lfZpj8ex8?=
 =?us-ascii?Q?Ws9JromENyo8KwJ4mOtcKvX9w2UoqN9Sd+QGcvyoZsdhEoQ4lUo7k6ST7s4k?=
 =?us-ascii?Q?RAEzqoaFm1cQ+xFpHF56oi/JW0yGDuNUU8hhHHTMaGHD9Uo0Q9Y/dur768LE?=
 =?us-ascii?Q?cT4p6VV+qA1z+MMohLZcQWyatR219n3oEK9PqewmoKDxH17at+Dg9sTEieDi?=
 =?us-ascii?Q?DpcK74wCP8ugicTfaLfeU9m5X1UmsDIS34y3mcrd+yJLtrtWhgNpMC+97Dky?=
 =?us-ascii?Q?yE8SABpY97hJUka/xef5dzqvqYYMpMVgpIUJX/v8eKmZEUDyDbCkwx4lIZGH?=
 =?us-ascii?Q?V/LJWUAeNUyqW4cdr2R0sHuY+RsItaksRM+9Ch38NZzSeHyZWL6shg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWQur8mpGTaYRNuNeZsm3vyk46/bInYJ+ffGoVJaDjysxWH9jATxbI7g/NJp?=
 =?us-ascii?Q?j4bIhmPPkQ2JtGADXRQV2m/5YeMDXEypk+lMHQsm/3nD36ibhqBYrRYLvuHw?=
 =?us-ascii?Q?kN+fBctlHHkNMO1OIOVcnsuhsMKEqfleZKtwUB3qu3tlAkeFgIM4Mo7ze0k3?=
 =?us-ascii?Q?r3QCX7K8pkNMcczxAg15D5XfXmNRFmI+Bga3v9VOgZwGrtadr9hRPGgLsKRv?=
 =?us-ascii?Q?e99plptfR+iUA4uYWV8g1vA7ZXhA+qDeNKHmFE/HAxhrWqcZfAxm2S0wNp82?=
 =?us-ascii?Q?Fg1RoNnLFsKU74vProuHCPXYt7fyBfcLk/Ce7RVGwoo5MWGR1vSfdwOiRYIJ?=
 =?us-ascii?Q?LduHgZDAVnlq50Q1ZAursvZmPeYspNIFS3O/xk+MBAfsKE1MaMjYM1vxZf/l?=
 =?us-ascii?Q?Qb9mOsKxLLVDnUSHLMtyuFFzGpxE+wPB7xmava3v2v8V0lBdgJ677eFnVkAY?=
 =?us-ascii?Q?1CS0UixwgI0PWKqT8SsL53dR9LkejaFBpKkO+RCjA+J2NH7lRKpEgGuiHMXW?=
 =?us-ascii?Q?Tf3OvgBuIgG75PQl6wdJZiNttpRZ2n1VCdqqmOztOmXNZdwRE30LGk/8T/0Q?=
 =?us-ascii?Q?FSAGt77Z2KMLsMlDadk+Om5u3rZyzypvLdoh94itY5LBRLix/HByWc6W6y6O?=
 =?us-ascii?Q?5FaYAM0FMvh5DZiOHARdL+/8vbOx8+JHD+XMHSe/HhehLvmVhBOJqwydlBXK?=
 =?us-ascii?Q?f7aXlNRwAVfWvI1vaQCgNPqhXe6zgbMn+J6JmLgVFMtnNN+nU3xqRVPhyuBl?=
 =?us-ascii?Q?Ugu1iV1/dC111y51hcCOC0MYPr82Vy68ZA+WDGkJnKGibk6qwUFxf71uIlOt?=
 =?us-ascii?Q?oxA8/Z3QajusdvUODnl0M5djFcJ3FzCLTsnUKWztsERYjoamPmsYHMwbBtph?=
 =?us-ascii?Q?Ixef/0DLHT0rzZlSh6pXEJC4UQeJFJCoGgPL8fNADKGwOufF0gmz3CZWCvQs?=
 =?us-ascii?Q?HGCObdNCffnzG0Ks1g1t5M685jkI78sXYq8R87ViQo5++aKj2sY0XbtGCEqK?=
 =?us-ascii?Q?SPupGWtzb4wUQJo8Lup3Yzv7pKeK8EvnaIJPl58140iWYuP+jAOo0ULq5uxJ?=
 =?us-ascii?Q?UgiBKKRir6XvPJ9UdVfKXERQeH6BwZJT2Av+Wn6vdEYLxvbtPvjMRXyOh/8o?=
 =?us-ascii?Q?onG2d9krmjzv7p0wMihFxRs89UXuiZMhZU5DLQdudzPU6u2+ntuqrsZ0FWlA?=
 =?us-ascii?Q?JOVjD88Y7NOJT3RPsKlzWQyJFJBFp6Wh9IgPtbR+FvcvLQNlIKBU/KkCYrK1?=
 =?us-ascii?Q?LKxz1/IwpkjzqQElpWsDMq9r1bKEckDQ7Rj22myJHM38udnEzokjTYbVRbXq?=
 =?us-ascii?Q?3Sz7g7A7KvyvwuMvIkhWNirYVgCuQC4SSkarDQwgUy31aTSXX36lXiKDevFV?=
 =?us-ascii?Q?J8KqxbyVaSdgqSoeHquuM0LzYSHxTERLQGiV2+MLyRbdrE98O0LMu5AENqa4?=
 =?us-ascii?Q?cSQctH9nbO/yriUhVkL+CYItpmjZra/3O3gnhGHI8TDeUn8QQ9GlGciJKCqc?=
 =?us-ascii?Q?H0ZuavoNGY0CcK4qseEJl+iEG5ocIU03mCgBuww9h6KL5CUluH0Ca8DF33ws?=
 =?us-ascii?Q?dwpV7A9eL2zz4QGltYM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc728ff3-2ffc-43c7-2ace-08de25f101a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:50:17.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLi8JcM86Lz9a7WNfYP5qnh61YN4kTSZfg2UqiVR3TPqVnFzBqB2ixQ6Q2UEfbtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On Thu, Nov 13, 2025 at 11:37:12AM -0700, Alex Williamson wrote:
> > The latest series for interconnect negotation to exchange a phys_addr is:
> >  https://lore.kernel.org/r/20251027044712.1676175-1-vivek.kasireddy@intel.com
> 
> If this is in development, why are we pursuing a vfio specific
> temporary "private interconnect" here rather than building on that
> work?  What are the gaps/barriers/timeline?

I broadly don't expect to see an agreement on the above for probably
half a year, and I see no reason to hold this up for it. Many people
are asking for this P2P support to be completed in iommufd.

Further, I think the above will be easier to work on when we have this
merged as an example that can consume it in a different way. Right now
it is too theoretical, IMHO.

> I don't see any uAPI changes here, is there any visibility to userspace
> whether IOMMUFD supports this feature or is it simply a try and fail
> approach?  

So far we haven't done discoverably things beyond try and fail.

I'd be happy if the userspace folks doing libvirt or whatever came
with some requests/patches for discoverability. It is not just this
feature, but things like nesting and IOMMU driver support and so on.

> The latter makes it difficult for management tools to select
> whether to choose a VM configuration based on IOMMUFD or legacy vfio if
> p2p DMA is a requirement.  Thanks,

In alot of cases it isn't really a choice as you need iommufd to do an
accelerated vIOMMU.

But yes, it would be nice to eventually automatically use iommufd
whenever possible.

Thanks,
Jason

