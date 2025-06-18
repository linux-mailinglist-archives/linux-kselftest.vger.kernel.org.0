Return-Path: <linux-kselftest+bounces-35255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5AADE576
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB173A9424
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04092749FA;
	Wed, 18 Jun 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loRFV+Tk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00C35963;
	Wed, 18 Jun 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235079; cv=fail; b=lV6+rRRMMd9rVVVrlYvLHAbQha4l3mFlKXo6oDZg2A4RWZqyqJvstmUN0xxyXAj5E6FWop4vbDXSCJCY9CqUK7Uez4cplwgABbPc7tcSXphNOqwdMnclc9L4P25Zku4JfHQazrG1ozZnO9P3TX6SZBrwqNJPrW5ax97gZ5ntjtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235079; c=relaxed/simple;
	bh=iJDe/XiJxArp03Yc/QRR15PdW8brZLmLykxKUOZW57o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmhyZDZAWfE+zABmamOVl19DveN6gGY/RQ+VgiYcY1oVONu1XCXokF6rKJ6XrECI5jEIXhjoKZJKumtNxCSht6Fc43P1OWbhNYLzJNbUvdR4U9P3rmh9OrCc2ZSvNLT59gItpUdRm3WwEVXKJnOvjovRyw928a7sW114G1EL2LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loRFV+Tk; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhBKiC8tK0X7Em3JzjLMMkrWc8b0/dHN6EM097PrD7QZRIYx/LSkLTHs4PwHdo+2q98r4RRRRTMEP/1mEnS1aUj6dN03OVWBm31iXqW6G1dGYi2NjTQXvE1Kl2JrCtNwaeQ6liHwC5RJYaivEffvrSkDTVKaTMbEpAITeifEz78AJRdYogiBBi4WXwAJEKqgWUhpNknAi1A6pIV3K5p7RRw+g063+ejmqRuWTmH3IBbS0YWkximCGPAk79aDqVHdlOVqhSNjSIB9GUFTpBe79fjODItHcP0wRS/ysQRgkfHsKMi0GqcGCIwqEkGpKqO188LtSz/2xoIF+ycKJ8xwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwwELUu6vzexH8mh3upiNMwxON1SnlXzZJExOLrbU/c=;
 b=S+dqCJfPWKwvi02hn1VLNBsCd+TbkDzzKSLLo4MIaSXbIaecik5vUkaWdf2RXE+cFaxOqnO3UEomvxz/QyHlUjb4RcXra+O8zEV2slUmFyfUTySp5pf8Ln69cMxXu4D2rbwX3eLGrDKuImgURAJps1m5gvhXBhm7dmgA8SfHRHmMb7xZMw2RWSA0SBStJlwofK98+8kAefLjuHTAGWMMlQCYienFdEtVnpHLznlj3hf2RDBoEVZzNRM/ctOk525pLSbFlfXGl82JfdMuwL5no4dL8Cmqhh57jS25R88vfawmkbh6nGgOMnd+PC8Rrdgg0gLPcTZt7+16adeVF+zkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwwELUu6vzexH8mh3upiNMwxON1SnlXzZJExOLrbU/c=;
 b=loRFV+TkDfJeHeHcOh1owzQSZ8exfHHQq44io9XmiCgxOQONvflxX/jqZ/VRhL5iH3m1hzOJpFBNfOF6G3at437j+IZTEpl2mW3q5JV6ZvA0LqUR47GUgWaN/GjbtfyH+IiV9OgX/AYcUEOWshUlRJixIcqf6XRCTcx+lOEaWUaeo7fpBbd/gKO/8t+7Lk2WNXL3X11YsIpoJeIfZe/LgBqfTio1/zph5thSE7yMm26J/XyVivlKg06Mpk2ve4cWswF1J8/Fu7c/YoAxm/RvGQiZKEJnPTlIO5rVM1ckgOdEmoYJL2rXv/1AD0coEi9jGDbf+feCuVb0/dU9SPoDJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 08:24:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 08:24:34 +0000
Date: Wed, 18 Jun 2025 11:24:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skalluru@marvell.com,
	manishc@marvell.com, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
	louis.peens@corigine.com, shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
	horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
	tglx@linutronix.de, mingo@kernel.org, ruanjinjie@huawei.com,
	razor@blackwall.org, petrm@nvidia.com, kuniyu@google.com,
	sdf@fomichev.me, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com, linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net-next v5 2/6] vxlan: drop sock_lock
Message-ID: <aFJ3tnfby14zIBm8@shredder>
References: <20250616162117.287806-1-stfomichev@gmail.com>
 <20250616162117.287806-3-stfomichev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616162117.287806-3-stfomichev@gmail.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: bd250b08-aa17-4804-0f48-08ddae418e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxK8TIe5HbkenqpBOLqOt8/HHyFK4qVm2Q0aq5n3s/u1SFczLS9cdCmzDbRv?=
 =?us-ascii?Q?Gkg4cKUvBoaJzXDeQCv5uy09BPGKJXHeatO3tQ49/YMEuz7qkm51ms8hKR+I?=
 =?us-ascii?Q?KGRrKsbl1wdoJsqPlM0eCdb8hJ+KRbGD5tj59mVn7fbgwliW+7n0nanDxRKi?=
 =?us-ascii?Q?ltCfIXeOwhNpJJ8CITOmkKURs8UDNgzs+jI1zOHHyeRP8Lw9II56P8yx9DWu?=
 =?us-ascii?Q?5OUjLgZAaItAVlsXDPcQ6a4Cob/e9ip5D0Z/LhRnRGg7pWP5JjCfTQioRR65?=
 =?us-ascii?Q?RAIdwL3w9I9zRYmJ9eKx2X0KJv4KzTN+ARykYMJrsA0WTWdtu570LZk7HUme?=
 =?us-ascii?Q?SXXh4HxjbBGJ9hehABZG1n2xCX3KwvrUhI1hVFWaJJH1DArulFU29MIMsTNz?=
 =?us-ascii?Q?2HgLgKIG4/OrAEjAb/owzMUxbBon/PTYTf3++HBU8xpVXeeXNUSTLNcILU4Z?=
 =?us-ascii?Q?PhHqHP9JpZ3nSJAqGj+57J7oLLy6i0sUqVq59z6DlScGp/QZKgvQWUw2zpCx?=
 =?us-ascii?Q?IuV0qhI495o4I6Ri7vdMpfLF6Wlt8e4KCkVuyH+egubOrpfQQ2hYFTQiys1E?=
 =?us-ascii?Q?zYgp45NLPVLyoa2NttxqN6XwRlU1aUY3WT2UhZ9LA6GnsUYyOewdd+q+Tygx?=
 =?us-ascii?Q?X2fmsNZhLXGt7bSQj7n4MaQg+27ElmvKzUeORWiDA3gVcAR+HWwZJSINaEbG?=
 =?us-ascii?Q?o+wK8aMxGm11/1tqkwWvAL9aSTJJVLtbkkNY4Ksh3+8JtO/ahv/NZBuZoCOA?=
 =?us-ascii?Q?B0rOV84GgVS4mkw5j0pfZ0ltIrqITc/MF1TiDxC7VFP1A9qokoIxv0KsxHpu?=
 =?us-ascii?Q?Qq6ah2e2R7x2GM6XMx4EHDIgNACVn4VS4yFvK0t9EK8xswwfYlpLk8A1WmD9?=
 =?us-ascii?Q?C4hh21mkuvtlyc1htogfd79fOYJOYFQ9KXSlOZ4r0HIR/Yy1u++PlhY/RNfn?=
 =?us-ascii?Q?jlp5Phjb8Frwvxd8gJ7U6ybpzETYkA1tlZTTj0eqXjQnc6YzW4SHxnMH9siY?=
 =?us-ascii?Q?oAWxn2M98yJpvK4VV1P+Bc2Ew6KtmLtnTxStDCHYcH2VWOG0KC2NCDviH7oV?=
 =?us-ascii?Q?k7afHEizdfKKBXFywnQCqha44fzDcxcQOGdDQWULBoWTms8dEELFIdFA8K0v?=
 =?us-ascii?Q?oyihSRfQ9Afa4Nnn67L8Utxfr1TLMzrPfT8I12E0TZk3lPPYfClSCTnWBb8R?=
 =?us-ascii?Q?EQdC0G57APLTMw/8ss9GPKyofNmMWeHPxUXxZQ+avUkZLEI05WI/sJV+VPQ6?=
 =?us-ascii?Q?fVex7dZKYvrYGYswibneHqOIUYONVzjfrRBdcIfbpsd72rEENkgxRwnJwVd+?=
 =?us-ascii?Q?J+HYxXBME2klJsd6oZO2U0Mqso/5ccM4EkIicRgkDnjUmM2z0nZGUmMCqr7K?=
 =?us-ascii?Q?iAD6ue5uIsVyA2v9kCco79MrZaCH1+RymHmFRcfq4mtp3wAhGAt54QDm1FHh?=
 =?us-ascii?Q?l+/5UDhsiK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18IjXM+LgeUWLxzLTiwxM1rBIHBJOV7U2bSkU8Zhd63O5918QlIszS/WttAy?=
 =?us-ascii?Q?wsC/wZDoEvybOU/omYXrGevtxdwMvVdtNDLNlKm+jrTfXRed/RO5D9Keato0?=
 =?us-ascii?Q?5A8Iphxwc2Ed+/QDTv347aF7Hk1cXQaCesDxhPd6eal5HulDxqMQ39C8adFL?=
 =?us-ascii?Q?NW4nPX7uFu0ESXXaD/SskDA0gkzLsST8/CXFzMJKZt6CCxpaxl3Q7h9yE2jP?=
 =?us-ascii?Q?L8bcxoOmsWut5+FN0QLeAqDDQBIi+G7nLmH6E2Tyki25zRdVj4V0+hNqYDDP?=
 =?us-ascii?Q?NsgOoa5MNhfCgKKK9k0O/oIEbLP9O2tBgI09czPZQ8vkMOR8T6xiVaEYuFqz?=
 =?us-ascii?Q?Vab133eD/CmrGBAmqyxUICUHkC5gp1tyoN1nS10MIzqSZ5iPS9TXE+sdWmPH?=
 =?us-ascii?Q?vMTOwCqmSYSp9PNE6BxIFp+b4WKsz+NzkzClQgvRe+haDlmTdzRd+OBAZ53n?=
 =?us-ascii?Q?DCoM7kexhFxlOtqrO39yv9GQdt/GEdjNPnLO+lbIQfcesrFzNDqED7Q9mNVJ?=
 =?us-ascii?Q?K4u7gr5kgZ7NZWp5CTrf3L9PFT0MWZBqlruLpfRDGjpBroz14X0HmaQhpBu6?=
 =?us-ascii?Q?FS5p2rByhgtN/4bx0hWwhaxyG6WlhFirfktyaHGBFBPTBZKPdvsBVi/1q+km?=
 =?us-ascii?Q?e/aPpXusUmRgXj7/gC/BmMzMjCm8sQNoX10SULBrZIRHuyoWCeFF+3nfdIUv?=
 =?us-ascii?Q?o8Zaeph7l4gasEflg1cYtkrCrApa73F5l9JA1aihEhBgh/X01o0KNgkOyKRw?=
 =?us-ascii?Q?26TUVq6m9ofNaQIbT75Rt/IDwokV/loFvdfCkLJeOiZ17hpsg9ablxIkiTUe?=
 =?us-ascii?Q?fKxv8hASvkAzXtZaPLTr7nADTiwF6R8oxKOOihxqarHLmcJcoGMURDEma5t5?=
 =?us-ascii?Q?0LtC8cOXQ3r6uV77qKwUW/g1sjT5nz2Ar3Yka+u58+lVdETZcvV6ocJ1gmYN?=
 =?us-ascii?Q?/xqsLXoEFTV3b1TVO1JZRfLCwGSdpvSdGidxb5rQRU3UxbOZfxGgSwZCzUqS?=
 =?us-ascii?Q?vWScj/A6kLrlqPoLNXkrnLA8XiGYS6rWMsBsprdDrmQVCnx7bZAQbZRZh4Se?=
 =?us-ascii?Q?5WScVKDJJ+2kOyPkhyY70vfrYcz7jUHNr9oFGOZsph5wjcPfuycAd32lTP4T?=
 =?us-ascii?Q?PNy7cZy+lWk56ZxjgqfFbBqxRTbJmW7gVBVZBcgnvYiMlNWfF+LQsi2IUbpK?=
 =?us-ascii?Q?yl0JAeah+k7+WxOqpuBKY5HAuCXDx5XfLTuYVXDLelJ6vUUlL9TjPVPKScjP?=
 =?us-ascii?Q?v1TTVZAo6j5rehWzNv1BQ9EL158Y9Uua92UpPURusllpAsObHnhj8zUZxJij?=
 =?us-ascii?Q?nocd+PZNXN5qqMSGJZ4s6b1BNBiJCJS7J3ZhsM+xkTT4yaU29WzVlLp/QHnv?=
 =?us-ascii?Q?d7odIbflLt4eZuFYV85+aKoxMSwKa2HASwsMGcbn+QzYCxXEOwv6AbfRfMi6?=
 =?us-ascii?Q?1rb1k+S+NjXceSGoDmjX/Lkzw1R+BN6bvdb5FCp2nHSY2OwBTNcIroxUiF55?=
 =?us-ascii?Q?kk1IxAQnLyk4DTY0qOw6sSe27RHPUeBh4sl2bzDiL/wLFm9UuTTsglJ4/2Dm?=
 =?us-ascii?Q?j/GXXtG1wBsOXmiP/l/cfZMjCfcYDUh6GsUgUPo3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd250b08-aa17-4804-0f48-08ddae418e44
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 08:24:34.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WcDMjy3orOKo3yeVM2hZmE28+c7xIQjbxKD0xIdSblJDgxl1R/RU+U2ZFEAmH3wKd5FHabS4gAbvk/JAy0c5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

On Mon, Jun 16, 2025 at 09:21:13AM -0700, Stanislav Fomichev wrote:
> We won't be able to sleep soon in vxlan_offload_rx_ports and won't be
> able to grab sock_lock. Instead of having separate spinlock to
> manage sockets, rely on rtnl lock. This is similar to how geneve
> manages its sockets.
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

