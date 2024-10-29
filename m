Return-Path: <linux-kselftest+bounces-20969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A09B4E06
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4B81F21D7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98D192D73;
	Tue, 29 Oct 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ocvOUKwn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D6A23;
	Tue, 29 Oct 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215865; cv=fail; b=J2YTwT7T1EjygLcopIVjZh5dRwCxLXgOR/+LMDyrgtxZYZcBz5XE6nZRzg3/ufcN2NFpJ8T6ax2bm7veXEjvWxJ6TIbs+tXbeKq48DpRWNhd+c3T7sJQnLAj6iZEe+Q7sxFjJnPCDV4X8XQDN0B0iEEqy7RdzQTHZIHHX1sQqOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215865; c=relaxed/simple;
	bh=x38rlIll9WpO8fe8ojbQ8WWMKPHHuXtMoQrGt/jaXA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRH0E+4nbCkuJ+8pjwo+1TJRqUW1BVdCITWDvZsfqmJo/IPelIihLmEsfFyZrz+6jL+WdH3Qp3S5o8fCOpXFaDS/Io/1MALjorN0ZT63cR46YiEIgDBZEopcST6+k5DputN9DRiGBBCd+zF95BiJSF1JUjkW1WHqdJqPVwb5Zkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ocvOUKwn; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W88ZWa0+gihObSPjVbbNMEgV7rL4oFZnflumg7YR4qJSUtEhTyZqtT7vrX57vFwn01AUXDQ3kmvPiqxuaSmm+62nmWatjRPtLFfES67Dn1MBLReZ2+dLIOBJ6qXHonaxWaFfAJMIrynZCp/1M3hJz570YTvM4384DCWr9UhaXZjY30Vp5ZW+5rpyWgJNcdJf+trcblQ8LLXZLTVBeWpyhyYWTm++OAIMRkJD7QGR30qgk8Fkjyy7TbpZWxEBGGChdkDKQGZoKdGFpeyayDsntEaR2TIkXw9VNUyVFpD5AIVZRll/DAmdAUQbeVs5hqOqFzTYeOcCfPat4trCktHx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl6j8lL5OUm4D4erWXeE/IAAVrp/JZxQlnpZkUD9MHk=;
 b=OXCm8OIoe/Q9GEygvXNEjzYzNZ5NMr9/iUVg22yTjv588eFKp099VOFfmrRNHsMuLHH+ya1q8MD470HrOWs5BYQvZTS6iaRXBSIno9odM52OBUmBlK198SFBUOmXVLJfLniQWYsO0xHHFDsWYWZQDhZ9wqOYpVUc7M1wP51BrO+gwS7cLriyY3nrhZxIU/fkKuAP7MafOlGfIGkdx782vE7g2eMpBF9y4OLyRM7mSk+VrWsnHdSXq/rDTgLWOY6SA5DFQuNHAcDA/WFpMbEb5eL+5qPYz5fgBddL34bjeZRMfFn9oWgTQsVfki9xydcztyPbOLKCqYoomp2SRV5VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl6j8lL5OUm4D4erWXeE/IAAVrp/JZxQlnpZkUD9MHk=;
 b=ocvOUKwnNleDA6yT9rUqkOT5Pm60cHljv1m0X7Pdrf91QJW3fDYyrTd5ucu+gSHn20XMNRKxA2al5NwQEx8lJGmZjlgl358VQ+2YXDXHI8jhWtz5h58ZwPZheUoghro0V/+YWThPM8VtQ4AdjGD5uIOsPOYMfFB0bMtYIYLwYdmMpDPj72HqGYHfZi0aIuCQMfbocqsFWI0oKvq1JVPzV+dPC/aohbrszco6QjTI0raABMh7F6XpDCST+P3rps2lK8BLtCZUuQZ4JJ9KeClqHYsjJGdSMxGVwGcQokfdOu9Gbo+mFp7wVQ/hKCxsiN41vqKD88s0zx7dXcU52uYXdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 15:30:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:30:56 +0000
Date: Tue, 29 Oct 2024 12:30:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/13] iommufd/selftest: Prepare for
 mock_viommu_alloc_domain_nested()
Message-ID: <20241029153055.GG209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f080c65265372b56942e6d1008ee114654a23f91.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f080c65265372b56942e6d1008ee114654a23f91.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0425.namprd03.prod.outlook.com
 (2603:10b6:408:113::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b52ba4-6d93-4aef-57a6-08dcf82eaec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?po2HkPUIwzxjo+iNzs7mCBKBJ71YdbKF02eaxzCvYSd0wyTIilp9lxVJJm6J?=
 =?us-ascii?Q?RakD5S/KokMOQ+49nuu/f1qT+oQAs54SYb9k7x9lh3L1Ce479Uj5n0FRCAc2?=
 =?us-ascii?Q?cTvtrXs38EVVaW8RnGO0SIJR7eNrYLn0M/n0QgZ3pnLcbQZcSmKn3SO3HlBK?=
 =?us-ascii?Q?vS9H2iaVewCwRRboEk1B+TBk9LKUhi3PBNq7kiGRkcyv0mevgP+mnL+S3CLh?=
 =?us-ascii?Q?LGwTbfrOb/PwxezSNkrdPRyJarsI1kTmiJj4RIs1dFwb5Q7UsJPW8d5MZ3vC?=
 =?us-ascii?Q?BSHEvIMtMPUWKLjBSEPwWGqSpgtVBKI0+lpkf8Plkha168DKQAPpm1vO1pm9?=
 =?us-ascii?Q?/zXa5uFmf/0q1LFPNdsxygob/ROMsbjbtQF4KPTB3vlbl9JL6At+qWNpXDk+?=
 =?us-ascii?Q?G+NET4mhRQ13I8Hduf1RkWOyZDEx5g5QsKSuzQ6je4ill0xRFGcrIg6/wxCz?=
 =?us-ascii?Q?4sSJKUeMxpYgIB15DbyOxx1RioVYpu7fQs4qDzpo1+rW2N6QnSahQqy/xKVb?=
 =?us-ascii?Q?n2/cgdQz4xmcF/mV1+3HwJdWY8l3vxnCR09LdiKMLax/PMEHP25ayMyf+D4n?=
 =?us-ascii?Q?3glrzXXdtvRHhEu+Ldhfx2LiRiMk4GzJv5sLQxMwF+P25HRd8DN8GoXlIZcy?=
 =?us-ascii?Q?Hd2RwO5jLJVPzejOWtj4MrO3yt/xkeyew6xP5MLdPA+S6p84GY0DySLBb8Ye?=
 =?us-ascii?Q?Gjxa5EObmbXlQx4RzNe0P9xznlnSE+8u4lFh+hE6O+g7s7to/kP2MiAQg3Qv?=
 =?us-ascii?Q?FsJAOhc/jvonLRdY/J4+l3hxfcmjRN+vxM1KWa+Vrs14bE8WNc2Dn0rhHcvl?=
 =?us-ascii?Q?y9OxpzkMYIPVM0oMajluq9kq/GJdhrdDYwMRlD9LfJSfqLMHIoo6SJmq/yAg?=
 =?us-ascii?Q?l03OS07TKoAnB7iKIZLa3kF9HAxwLysAMBt78S5yRvW/7uhu5KBcq9bbr5IG?=
 =?us-ascii?Q?ZQUyefJCjdgNzsvu3X2uYawSZGXJgjffDQCPwSs5c0fKTBuH+ZeM44CbQae/?=
 =?us-ascii?Q?glqHP1e7BU1PTk92AfRSJ81N55lpwuw+bxG4qcaYNpTDWSr1rpCPWfXiWDRV?=
 =?us-ascii?Q?i1l8oTreE8vedcHmYANs3ORde8Lcp3xSIgMCYDqII2elB90Wy9orVwaVu73l?=
 =?us-ascii?Q?gIdhEm5mPs1sjGnOOvxMyAU1Ag92N9I/Bl2yoFAuMOjai/fBJllR/mjYqaIC?=
 =?us-ascii?Q?PF/0TuNIk3GrnN4K3yhZyE+sgSDKyehHj/wvfWewnNgNUGk8v5sBIjKij/pO?=
 =?us-ascii?Q?qOWSjl3ygduOsxFRCQ0ERocJjds1AAF5Fux2pifceySESr82Ri9icI5C3yaM?=
 =?us-ascii?Q?zj335B4O2DJbik+CX8/aRxrk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBitNs+xs7fQfHeYWlR1x4WvSuBhmqawarMSjkdnt0U/NVNFEN2anGHZ/+n8?=
 =?us-ascii?Q?OBwSMukGyoBeIcokWxHsuCS8jS0xfj6S/V7lLbqpxyeMkkwYl6Dwf0bUpMuR?=
 =?us-ascii?Q?bjASH6+1eYw0V7XNw5ZzyrT3FK/MvD+aw2cyhMuv3eDnlRg41kK9vaUDM+RU?=
 =?us-ascii?Q?ldro+dyiFhzv3P6I/aajhFbeneTzBFg/U8+FR2j6gQpu0vtEulb5XMazTe2y?=
 =?us-ascii?Q?wfkMSpNqoyKIsLdy0cS3QuZmsV5Ac89j0nDKoC/ngq8T5+BDEJeTelUpWaDn?=
 =?us-ascii?Q?l2XsCbt3ha0hyIlLzWXzCuPH3NV8iTg+mAPMpE7BrwtU0Qg01kQvUR0hSBnE?=
 =?us-ascii?Q?cNenTZhgOp3GPjFhbTH+4jOTim0fi0i5P+VpKtrdkfAGANVIJqPniwSjtOhS?=
 =?us-ascii?Q?Bd6bpAk22/ozwdepV1eh7P0+fQQxxRNmskbacpg420XeNTgAgvXHou2BNNOf?=
 =?us-ascii?Q?8kMWQ94UUaAHqJPowv8j2o/zAMbRFDNRGPp1ueXv7PDVCaE2JzUvdYF9QAN3?=
 =?us-ascii?Q?HwHKzHPFR6o2B+GleBVLbHmXPOlEU8O3Dr4NElm2ECuUECVgmRBDNM0NCYP1?=
 =?us-ascii?Q?SZfaP4+OG1cOgICZ890+NJem7EMZ5+hlxaSINuTX3JS+p8pX7TmXKa0vo3Jv?=
 =?us-ascii?Q?lBqTOBPPua+o1nMoQnoJd+5gTAYEbHKJRAR8pymdSCTGs+x2re726EaQ5uEZ?=
 =?us-ascii?Q?WHNhhpzn8uzEtiOsO4u4lw8lxfPZY4HKEu2hlGcdDRd7HcpfNEx5NYE3/wpS?=
 =?us-ascii?Q?haO0hhk3PFT9nDB8TnXqbL56ntih+ycy7E1EYL59jHYcAKHpTcvF+ObswZIl?=
 =?us-ascii?Q?rJodkKW33unx5T0M3n7ylZzBR2qoXlIfaQXC5RMFH6d/hOVk3ngfdMyj/73Z?=
 =?us-ascii?Q?PCjlKu6WRMs148Py4QX/oiQ63fXSl+sp4qulsTXY9MWlZe0++SfRUoVAg/9K?=
 =?us-ascii?Q?g+eBtR0NUgdtL94m5b8qNrc9xgsM1UVNOzOnSPPrWu2n+DCCG/lzzQeA6CkL?=
 =?us-ascii?Q?WxZkVrIeB2p1Efe3rGWOs8cSy4pkEBldJKe3yAgVjM7e9nYtxNxYXj7iawkk?=
 =?us-ascii?Q?kJjgA1e91FbPWoHehS3PtGuVhRIK4b3Fw64wm+d1TDrVkPY02kbpHuz2xI3k?=
 =?us-ascii?Q?A3NvYFv1HlqmmVlTDD3F8jvML8sZcnSCDMOpBkC/awymfaA/bYXXf40mRVVE?=
 =?us-ascii?Q?Am1NlU5aoG/jysmNr+guRQODlNuuEG1Llhe8GhZ57ujeeu/z1E2v1wAnCG8f?=
 =?us-ascii?Q?Bb7ffif9iFwAw7NgPWQWj0U678kS2T1NVFcfJjwN8l56EuDCa+8Kja6a5mTq?=
 =?us-ascii?Q?2LlSEpYeq8eFQW2f33F1G0TpDfQzPlGhwi+sAiNsqbwW0H9L3cHdOs4eFT8q?=
 =?us-ascii?Q?zkaoKRb6sJLkS4ATOW0RgcFoUGJJGMg9bIM2SFxktIDjsaZhzGPRW3PiezxS?=
 =?us-ascii?Q?QfAR1YiiOnTvr6LsqgeI7se4npQVPf85CSoAXiegkRprnl7gqcbNLfvohKhw?=
 =?us-ascii?Q?T3LCP+AtPsToyBX38MMl7uDnrC1XGOR1MvQvc+GYZgfjR96Isr4NXXgOgpSz?=
 =?us-ascii?Q?AtVw/rQ3oWlg4usENjo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b52ba4-6d93-4aef-57a6-08dcf82eaec4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:30:56.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 408Aizi7jEglBJfWoUIF+PN91aK3wJGp8PYxspS9CGMdynb4Tx0zsNdvUItYj5DH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

On Fri, Oct 25, 2024 at 04:49:48PM -0700, Nicolin Chen wrote:
> A nested domain now can be allocated for a parent domain for a vIOMMU
> object. Rework the existing allocators to prepare for the latter case.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 89 ++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 39 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

