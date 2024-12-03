Return-Path: <linux-kselftest+bounces-22761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9D9E2B0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07D7BC6884
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F971F8AC4;
	Tue,  3 Dec 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzsBbBXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC391F8938;
	Tue,  3 Dec 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243011; cv=fail; b=rDutMF2+fqmDHF2BQRgCdaF2sbrWTYVYEMROpbGxn1dX/H0wGaDhrbVt2cWlxlwNbanBQD903zQbAgj9AynZGrDeIEC1z8PuOfmF9F0iAsxjXmSFano12SNTB6gA9V8PeTMNoDG2pXPG+57oQl76cVhBQBvGngGq7tQQMO59S2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243011; c=relaxed/simple;
	bh=03Bsc2gQl16aTt77ZbDIpwKBTjPXpHUQYNVv5J0b+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTD9PgMH6Ov1gAYQGhx2IcZqLxNOeCKXff5Wb0w5ESms1c1JHPGe5xRYfItLiohjCCiG3FctSJSENklWGNbf1c4U2YS9aAKLFlps4qqeKgrQ3VuQRfEiOlqWAXhA3uozZRI+3b37H0sT3dKgfSHWu60xfiUhXdemFLiRSqpaqX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzsBbBXr; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMlUDXxR0KChY1FOq3brtwSnsXoNHZfRirpeXt6aO2dyrzQ4hmScmN7sv8PNQQyn49PTkc67nUxDA1eZCI4n82cjWHIgA5r+Uo4q8ZBPDvrAqhTc0dbpvSJMcSCZocZiSrYpnfellZwug65s7GYx9NHWrepBSbzATzKD6D394H+GD6N7Vr8KYmwafDT4YcV6DjunSof0W7xkSn5bEFOEuNE4iE1ycCTWci+u7HEosD3w+BU9JAQSXjG1zta+N14oK//qlxrnP+fhvMDN9PDP8+PQ6mIVI70edhiwxc9xY17GySHWNvVp6ZB8F+51y2gCHllNkbjrg1byShOjXyYsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5XBFSNwqthMNFg2qJ8ZBM51NFgNa/dyo54DDQvZwmY=;
 b=X+leHuom9luVhAFIGUMdpPXd00qDcTNGfOpSrkdKKQrKNH92jtdAlwxITn0yHYATY3XQIaR+pmYnM/wkJPbh2sfm6PuBrU58AVmIqyT50j4GXyuGWFcAfXOUPN9LChE3rCrU1x7kXfi7jRFO3T525LXSYj109f+wsObonydvT4Un+CF1zSkDO85DiO9u0GmxEXrdfNV6vQXr5xryXiK/ZGz/0P87hJPcCTPBlWDQxVKnvwOiGdwIXbH24ECozM/EYX6yTlMVX/4Q7A/9JqwW3fvzv05dlnPtSPXqNW9wjkSygndiv8vmBIbqaEthfe5lRLa42c5P2IN2opQymqu3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5XBFSNwqthMNFg2qJ8ZBM51NFgNa/dyo54DDQvZwmY=;
 b=CzsBbBXrqNPsKraJZCVV33m0kmm3IOvlCNniUHp3YscalMljU+a3DKUpkzQpV4643XVOkfLFkXBUM5H26Dkxipt/1Atxg9CM2CDCaF5Ga5TLT8fB1pRuELzzHb/ViNpx0qbRQ1jyB3zKKQdHtlHJ0t4r6z3P+UteFBfECWrbN2j8z1BPxYwSfe686x3CVU+i7ZYClN93veNcakxB+bUmR4nzYS1gVGW/9faLox//sB0N4TdVcDhHniQD0FZy4WKJGL6x7PPEGiIcSxc7uWVtnB59V3x5VNS9iD6APxXNS5gLY0KP+oOYwxFMeG/uVYxOQ3aX3DdLOzuVwmdpB1Z6KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 16:23:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 16:23:26 +0000
Date: Tue, 3 Dec 2024 12:23:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH v1 0/2] iommufd: Fix a small bug in fault.c
Message-ID: <20241203162324.GN1253388@nvidia.com>
References: <cover.1733212723.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733212723.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: ccae5a6d-edc3-48a7-90ee-08dd13b6d066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdOfxM4mOSmBplP4ySQQH1K5oscw4se7Gw42HZ3QcqGw797a+3FgQsNSq3ig?=
 =?us-ascii?Q?TWNjn0dePWwGSW8BGNQPGPNx1SlXeGoTlvAMl7EbTVEbD+ICE0MHBAvXq+ND?=
 =?us-ascii?Q?JPbWHOMdTx7j6TrW+BxY+jFbqiCuXTGr8brQwfML3c6rJaVWvRwtXjBOLGeY?=
 =?us-ascii?Q?V7w/QpODW8TS1en9PZo8OWw4hxGlGtbSqdhvJqlZFLoUwsCCXbMrhVldmMuf?=
 =?us-ascii?Q?AAgtfEaeY3fq3vb0XgXrgs0GZ9swxh12ZS0SRiISfxTfww5D5uXuYZzwRimO?=
 =?us-ascii?Q?GRDdQ1C4wBR4PydTDBrIVi4jz/5PAJZz9BOaeB8mFu0yeKIBkMqzhRXdWrbl?=
 =?us-ascii?Q?Px0Ev7/u77bA1DhErDBFM8ZH3hkoUa4oxES+bm+N8KC0OZuVFp24rmEa+7rQ?=
 =?us-ascii?Q?hQF79fz0FIfZyZp95RFcb3fLdNlIzqUOvnZq6bZAu3QUi0OVGolTTY6QyH6E?=
 =?us-ascii?Q?FIF+7TyfuBGF5yOuRdiEywAwWL/1jZbX8tMetVd8gBV7FyF/7PURXWh8GcBD?=
 =?us-ascii?Q?yPMRjO89mcwbAODHNE9cpyGFKvqc+PwbEHVAFx+6cBKgHwF5yN1Uw/LXLm8O?=
 =?us-ascii?Q?Jln5Do8/UmeRP3NVC5pFvGjqNiNXQqWlTjyZM/U8USXhVr2as4oan6okNVDG?=
 =?us-ascii?Q?VfJO6NQ+wIfaYFBIEp3mb265S8/IXARkpeXyZ5dgaOi1jwycJMeZxcdCm7tS?=
 =?us-ascii?Q?yhF6O4Tt52PLuqH109mm+OVNLH5Fla+JbwfSW/DP8JWxZ/asgFmFmV2EnRZ1?=
 =?us-ascii?Q?tpoyVadkgTqNL0v2bS+cOmD0MrD7vNA3Ndxag/moBgJ1qUtS7PEOzeV7h1/l?=
 =?us-ascii?Q?Qc90aIKBqy7cJzg2oTeFcWIdV8Mur70v8Giq011+VlEbO3sTyVtyshmJ9I+m?=
 =?us-ascii?Q?TzuKr3nMF1PEdVK4BoDdgMPpcVKVEBWmZyDmfOjaTjP1Qo2KRRe/6xPZJE4C?=
 =?us-ascii?Q?Jj5Im61qXgb5OR6vhNY3o8Xni1JRJeBHURArc8Ez18rG6+m3WbpHsppVXA/s?=
 =?us-ascii?Q?f53tzp2xUOL4o8I4vGDX+MGGJkeNPPw8zutay2V9AsURD0DpGXhwQBUOyzGd?=
 =?us-ascii?Q?QDXoPgZ+sMqhTFwHKMmYuOLKl7gZRaiiQOPDIkCBw26wM8GqcE4xmXqFs4kC?=
 =?us-ascii?Q?A4Q2rcc8/MKQJtQ+Yftcvb6EE0P6GzGzpJZ/KcNNDiaRCa0MSX1by1D3Be7T?=
 =?us-ascii?Q?tiyD87CYu+PlEHdJGRmHnyurp+CxNRzHOps83uENYftPFTZVSaqkfmtvD/qu?=
 =?us-ascii?Q?rYNSLRxBJIfdS9YFb71MeL+a+BrpeuKqstSzO29VuZKpXkEl6HacN67UDlUC?=
 =?us-ascii?Q?P7YLV45gMvgoIRAbIdAzD4rRpmrTq+lLEO1dzILNF6RyNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rH8Gm616lJvOBwZi1/9XeFLZdt1CeacQpojc1p+2Nad/W+dB1H5Zu5wGdtNY?=
 =?us-ascii?Q?r7/k4Gch0st1mfJVe6bsrkTFZrYRMIc21mZgFm3/pRw0r5WzZCs1EH8R4iPw?=
 =?us-ascii?Q?qBU81s4VQi0LvjknDD/U/+BTnPuqOSEQu7F35YC27efnobtyOxoTpSoA/WR+?=
 =?us-ascii?Q?A88MqkKR912zwXwzJFo/AvP4J2kk3SaFFghuCu0wQkueXbDN1WMnnxAOS57v?=
 =?us-ascii?Q?cthHYumA+nWA9wtISWUaDCLQbCzMeBqfUhao8a/ppgScKHd6DynJYbpKw+bV?=
 =?us-ascii?Q?THogXsVlV4uP23OLPvG5ZVTf2ASA76ol1zJL8nwZj2pdLNBPUhXNzOL+OvDz?=
 =?us-ascii?Q?HnRaVU7OE8MejTHBfY3bmj3uEpRWybnyJ7ULrprkMTwTQPRGciaAlmWOPOJb?=
 =?us-ascii?Q?nHCGq2duHWUIK2UtKzKM3IKS5LypTDZt07ZOJ7ZYxtYdvInVDpq9EH71tcun?=
 =?us-ascii?Q?51ZF2s7ncciTJAi/VNvdaAb59lcBs6h+ghMLsLhfgl2Ubj79iypqzLndJ6fQ?=
 =?us-ascii?Q?eBrF55h103Ns4mLw6SSSijMR9mEIWUIYO433ia766QhqMuuqIEML0OiIgWQO?=
 =?us-ascii?Q?/6Vl38QUd5ZNsprykO5vB+MSbPY4yGB0C/IOinA8ERX/dcVuN5XBB2+RMatg?=
 =?us-ascii?Q?BNtIZRmMEjAc2p5HkIoL2nsbR3OJstP4KtgWqWIQW8wTUc3CapvsxkxQoSyQ?=
 =?us-ascii?Q?6f5mIzsZwjb6HqbE2xaNTBDN79u1kWok/bdXHYercVwqCleQLuq3LAtrXt4q?=
 =?us-ascii?Q?LAeLpVaX4uJaRWUwdJORDztmKdpXqN3v8r4RURPUOK1AlcjMA29htof8VOyx?=
 =?us-ascii?Q?GpBy774CsQBfZkynmfDx1zKhk6SPjEHQ/gnLGjLv5E2Tr2umYSxU/LNtjgjT?=
 =?us-ascii?Q?VyK+C4ocOXf0P2eWswP+EqODEYyBe7bts0MokoMuBfIVaO6ErHKN1i26A582?=
 =?us-ascii?Q?p6KCUjXpFR+vx+QN/ys9d7blC8mnDZvxr+SS67TxlpGzPyMU6XjAPdTcSclZ?=
 =?us-ascii?Q?QOCUSmnLlx/ngGRSVjLnibzXDvjwTkW64jLKrDUI/mJcxq0xT3vhG+PjKSBs?=
 =?us-ascii?Q?Si56n/yufgL1vqTe3N/WcqKPYueBllb/BdrL/QzQn2sb6+y5/3XBK1FIxg9P?=
 =?us-ascii?Q?2LfmjlX2KDpVoQv7I+crJOg5P+tTQINMzNNQToNDu/25LeXTsKDUFyHKzCUV?=
 =?us-ascii?Q?iQ5k8FnYvjCNC1x0p7tOXe7ngsv+rB9SHh0yemEPmEX6tjB8AG/iMeEPTyB7?=
 =?us-ascii?Q?l86gfX5VkLBKLZLBJ2Pvg7bvpDa1AEoN7uwcbOZeEy1SHhOiA5YJElHNIwkq?=
 =?us-ascii?Q?PSpXjxM/xQlNrMpyqdmmizVy/5w3LEg5oWO6kHMKzIfAmqUDmvIOqHHoilye?=
 =?us-ascii?Q?7dQcdAKYI1VtuYLUxd+2sQYyeIaobtza5Kx/HV+/v6p12fvO2nTRuC/u1erX?=
 =?us-ascii?Q?qZTyNW5e/TsEx0aTSBKoThG4Z+HRXVFGGciGpnvNhrP2ez5CwjL8PrQTF4fs?=
 =?us-ascii?Q?inruTTjOOBQd/vtZwkHp3VSILZj5Woenomee6TdnP9rtMhLEb/f02unN6XzW?=
 =?us-ascii?Q?qYdzmVAZKT1h6ywdbWsziBMGy+HhAMptTnFJfquY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccae5a6d-edc3-48a7-90ee-08dd13b6d066
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:23:25.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvXCjfNnkomHGXX0bjjVvg/4umuTZabZGx7hY+SFdIUU9xBlLgTEsvHXo3Uebedm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

On Tue, Dec 03, 2024 at 12:02:53AM -0800, Nicolin Chen wrote:
> There are a few patches in vIRQ series that rework the fault.c file. So,
> we should fix this before that bigger series touches the same code.
> 
> And add missing coverage for IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth.
> 
> Thanks!
> Nicolin
> 
> Nicolin Chen (2):
>   iommufd/fault: Fix out_fput in iommufd_fault_alloc()
>   iommufd/selftest: Cover IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth

Applied to for-rc, thanks

Jason

