Return-Path: <linux-kselftest+bounces-21215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD89B7BB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3802EB211AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF019E7D0;
	Thu, 31 Oct 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1GbBMZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127119538A;
	Thu, 31 Oct 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381388; cv=fail; b=Xu3Me7Ih1Kw+qK2WXgIophaqtMaoGn3WA15MXPbgMo47nti2SuzfP+kIshjLiYe7Iw0GC01k0sziLPew4RidL2ia1+n205eqD4qWxHfFhucIS/A0mYR9Vxw053RWcKcGfMhyhBSK6Luik6dUrLZ5Is15YtayAM1vCuJ8qYZ95WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381388; c=relaxed/simple;
	bh=td5Y+8O32aYPZVSTJiRzm7dg0og4E01+l8pYQGk2p/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajoAkPJl5UdtFaXtoaPR+c+8ev9/kq3kySfE2Lkf6We5CzMvNTzJqzmyTefZBzTjAqcO8ItF0j644r5FSsmSegAa9DSz2aaYhpbrhMHk2J/2kpX3ccOHuTFLrK5NzndxlGfp52I0QS5CGJGz0Wl4NqVeDJTPgwDNclp6E61C08k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1GbBMZP; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6gTuhfxepwBpHNkN0MDGKmnGfS9o2X9MgY/x4HrSfjaqAaSievQbYZsFGMB0K367EuLwgUTmPDFSNc5qynY2XSPru0hasZ2VgOxkItLttMARo9ihyAsaDNICZdrHiKrXk3tdK3RWdrITwpB61Es1dV597sj17Ir3T6tzYw4Cjgqb/MCxwPPopj/885WtGUxxZSxaP33lpb23314h2D1EIe+FCeTBXZKBmpaUYIsEHsmSVZX8l5nySMshAyB65dzil1OMTB7HhI84HbnXxxH+e4Rt6xlfc7D9juqkMb/E8BCATl/wp0hHYH/LgQltlhtsVbkK/Uesj9LnJZkbZcvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pJTN6PrE7OWTBHhHi9uSN173Fta+bXuOJiRj/IgZfA=;
 b=NxmTELuaC0tvH480ZyE1u6DCGtM+G+nkNkJMEEw+DzQ/C0VK0+MYRCy6Zrxio/7htN4n9MyKBllqys5BF/ao/jKAkKnY/mY6zXK+AQU8EbnIK2FwFbajfdQtKr87E/cU1b8gtqCTef0yCthPJLkhX2Ror+4O84KXbQy0UP46s1lBAUg/qIuJkgBWXKjwPd2dQG+y5O9kvT3KlxKijrHQBbtom1Y3d1QVnio55Qlhypi4jrBBMwGvMeUHQYvZ3Qt9E4SBHFd32ZLFjmqcvPLvbn9MkXXeLAeyP9UCCcfKwNZjoW/IqJfDILtsEgek6SP8mQARwIC31ZvN+SCRukILJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pJTN6PrE7OWTBHhHi9uSN173Fta+bXuOJiRj/IgZfA=;
 b=g1GbBMZPe2ZqEtl5mkqQ/gOE8l2RWhljIoQKJ8uzMpGe66ohFpbjgdurI7X7LrAnaCmz9NHWlmMDbgAKKE/2CEzGQbEcaomDvruLvpYy56TDMECbluWN6GDvceikt9YEL9DbjuIXUMqpvLQe1JNjFgggIJ+b/c9hbEHAQB5E2NFaz8VkDT1TCySMSYbFNdGg+V/VFXEBcoBVMGmK3JuM6KekphdhddF84uOnXoxOttEYRtC7PY+cAnO9V6Gg1yEpja3VQy6vEy3C3ez4iQB26CU6UwJZevTXGdpLibEdR/bft8unG27Njz3k2ihUtoYuaN9CemU9oaACe0oqKJK0WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 13:29:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:29:43 +0000
Date: Thu, 31 Oct 2024 10:29:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241031132941.GL10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0752.namprd03.prod.outlook.com
 (2603:10b6:408:13a::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ab8659-b2ee-4a4e-6907-08dcf9b01423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FP0EAhJy/M39ASE/N9TdkFWnBFrAE+Z+SlbBqnjvfCpKusYvOgUyHNt+b0GW?=
 =?us-ascii?Q?CvcgUKeTCTuUi7hozBOWE8mvCm8VlQFdDWMh/arDdSOYfPVANu5DEJcLdr29?=
 =?us-ascii?Q?UadNq4sIvfCG/KSOFGZp24W8aOtoBSv921HJzSXJsnLmdQRwnxQSUx1/nIBG?=
 =?us-ascii?Q?zxRGmKkT+bqn+me2/4iYSq7d469KnK5LDJNmlFPNJDfcQqJyNulSi3VYbcnb?=
 =?us-ascii?Q?DfopqaoGoVZkKpZ1uoRI+j2x1HtQ+J1ApYfOLaU7BjTKqVY5wwVkv7tUPAXQ?=
 =?us-ascii?Q?tSh7x5qjBehRjLsl/a00JunJzr2D5LYQOTpURxpDsXSumKhERgLoTp/qrDU0?=
 =?us-ascii?Q?ssSCKo++1Z208Am6EO+3EqjBp6efsXcd133nPo1qJH4Evi0FASm1dCBIDOf0?=
 =?us-ascii?Q?Q7M+3UztHYLuy++qX4YPq8qKDizfZGU+Ox0o56mJb5vLZM9Jv3vYnXnVWEvd?=
 =?us-ascii?Q?nACsJMdBjv1zwWBZCLEVsLBkyYq6YBkGwulXdRLtF5W1ALhwBCQCniW4n1BQ?=
 =?us-ascii?Q?ZgP/KnnHVI+bNLPiB2rWCp4hKF8oU5REl1DZU1dm0ciK8QLsH+0hfezZU0YV?=
 =?us-ascii?Q?B6hZ2o2Xi0APR/BUHxD4zdeKQ4s/sCvliyB9YSpH0Mh2D2a3NX5EJWejy4Ss?=
 =?us-ascii?Q?Og0qt7jYyYkpAbgTPAfn2RRqZBSXNMTtLITyf7DhCX8R41teZjwYV4W5hdbu?=
 =?us-ascii?Q?g+lOruj5YRqNUoJfdbqXx7KJO27otnIPGiK8Y28K9PNMsfzlTlgOrIsY22VF?=
 =?us-ascii?Q?bx5BTiFj4YNTJNOHebtvsIZpTmliTs1vHMZ97rRgTX1NXxLz5V+YB4Oj6vrl?=
 =?us-ascii?Q?seOli8mclRsSzztrp0gpE6IauZU2amBbPBjhugnwYVWXyDtUvTkEbHf2ztBr?=
 =?us-ascii?Q?+ozQwTsv31RqqHkpJtQZ/LHwP1IIBQaGlUwGrYgLb2cF2h8/i3JsRGkb0Ve6?=
 =?us-ascii?Q?LNjxIKtRz2fQVuQXXJLd4FxyyZaAlyRA20jJSaw5qepdRyzqfhxeuTYgSilF?=
 =?us-ascii?Q?hl+h/VdieN23piG/fU5STVrfuK2SG2eE8LvAtB4EcLhxn+7tHInrOdosLacT?=
 =?us-ascii?Q?85ozIlJKkrTmR+fsGVun9WHkeI5qsjxvkcpvBa8NAWO7fG79wDGq+7XlJWlj?=
 =?us-ascii?Q?StkNdESyFdBVbJM4j8p9QCHGDNAudxKl6cUj9kjoG6EE44+tsH/QHO+sBCJY?=
 =?us-ascii?Q?XC0fsNXwUna97QqcLTMGBA6FwFf3+u4Fkm/MkiJacmMiF0dRtC++/o5OQ4OP?=
 =?us-ascii?Q?xlA5NeudSNYrFOacybnIOb1xePzknI2E7s3zwO0HHlUyvIyDDN4fpn47Wnjy?=
 =?us-ascii?Q?R181am7v5KZoXHo/j8Mi2gA6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xn5eh9O4P//oKwF5YtxtPSQqd3LxZkz2GDfwmodu3oPF4vJay/tG793ivN7u?=
 =?us-ascii?Q?SnBYaRz5hpPPGt0UhmIqC6RbPIdSX88Yc4RLOaXDqMPpgjaUl7Gv0anBHkdG?=
 =?us-ascii?Q?Ftjo/Yus5Q6jh+GZCRGScDy+xmhbFYu1cOtjfgOza1+1D1JUoTfHbGc1rNSC?=
 =?us-ascii?Q?Mo34hL2hmx/QNRjETJjjd/mgEr4xwTaU+znoepQB6csnse9d/B6tNVb+MJA4?=
 =?us-ascii?Q?9iUlGC695eqMIjX3GaYde/08pf8pTglAes/ECKQkz+eDztycmPt/+KOXMItl?=
 =?us-ascii?Q?xvh/Rwf9dDBMyTu26JdygfMWodQbwjdYh3aHtYM60dJOyA2qe+NKXVr+iwo1?=
 =?us-ascii?Q?8l7+107kFD0Sdr/tuKrpthl7O2X7IKWw/vZSM/MQLlh/WYZ6/c5Y0J685zMy?=
 =?us-ascii?Q?Nt0TmQCq19dz/Qu9rlbFQ6vQBQTWSxpojf1J/wJp3XNszRr+BHtI8gf5LnxA?=
 =?us-ascii?Q?CSe9WNJ50jn4l2DHpHpYz2OSykRP+FvJrdb5eGu5bOp0HL0HpvcxBe7KJTCa?=
 =?us-ascii?Q?PAuoo6yzbKCK+2tfDuLY8eRy2NxbGM6l5qdlGr868Y3zymaFkadrsoOZ8nzM?=
 =?us-ascii?Q?NOHnx5FpBYAF5jGS5AmYo2uFmaMcA87Km308z8ey7wp7q2bh0Mq5fzsRplgZ?=
 =?us-ascii?Q?yz1841zEC1rfJreX492+cqTsolB+Z2m8PdlqUdYMSziCF/riVZEWjuFXXTst?=
 =?us-ascii?Q?7U82hReWebdLYY9vfZxP2ihTc7Bx1TXYgONaqWV17E4CMqOpCyZo4s90NT6m?=
 =?us-ascii?Q?xlAE+JKhWx6X46PmkBDHUu9F+IlAT7qbbmuSYR/iTTfr5T+OE+BpKY3bHR75?=
 =?us-ascii?Q?9zAe+eHePwa3oyow++Okddg+LP3VhhhiCU47ekffYMxJdPIQsA9e7tpNLPra?=
 =?us-ascii?Q?UA67O8B5kf0z5Eh+kkReF8bP+HN6ps8ZYvMcBWgrEsEhhsdMEWArNdXcqwxo?=
 =?us-ascii?Q?3SjqRlOcJT5pAYTNkjcHWAmj7Ocvcc3uI5tv0jFMgqmirIXm2S+Vr0znQdee?=
 =?us-ascii?Q?if21AWg36ZIbVStyRVXnDH1Ei55rm4P4+tLFGuBF/KbGgCIX/8u7tb5HIO6W?=
 =?us-ascii?Q?hNHtrJAtHLHWpyzlvihfwX+WzIRKz8tVi7os4J2UQ9jDuOwF4cciKco+cW2U?=
 =?us-ascii?Q?ZSfZuZgaPudnIotCIMCiEBHBYGV7KJTpLgI9vSu3ERs2a7QDHp5tl36zZ3m3?=
 =?us-ascii?Q?rmpvh8LTeakEQ47Rafx3G/hXSGygsnmhFPNOqC5/YQXPF5ja5FtakEUaGzS5?=
 =?us-ascii?Q?8+2q2hXNCSVdDB46mOcX+14HrHJi44FVTVLsbi846RMSqK8cBixSyfBmdRko?=
 =?us-ascii?Q?Pvap25ienGcTPG7UbgjhgGlg/jlZdMOl9Zm4qLf+Huq7MTZBn+KHpTMbVTs/?=
 =?us-ascii?Q?r5ZuK+G7fqiZlXAXqUKHoHo0PFkqOLO8F7f0JoJeysdEJDuU2/nYOPBV1aY4?=
 =?us-ascii?Q?DFsOtB4VeOZ9oxDQDavlZauXob/1Ad9T4E80KKJEY6qRCy+oaqWxc9LgWhL6?=
 =?us-ascii?Q?oxNI2i6ojdwQmYxk+X7DrbyuZbuS1M51+3ivYWWQFusfd3zblU00SmulKjsi?=
 =?us-ascii?Q?qGLIftdEVXrVzU9Ou4Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ab8659-b2ee-4a4e-6907-08dcf9b01423
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:29:42.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvNxNvg9K0wjKjHYjlwffIbU34cVOjQmzvVImq8n63ljjbrvIVbXaeaby+kYaoiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003

On Wed, Oct 30, 2024 at 02:35:27PM -0700, Nicolin Chen wrote:
> +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_vdevice *vdev =
> +		container_of(obj, struct iommufd_vdevice, obj);
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +
> +	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
> +	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);

There are crazy races that would cause this not to work. Another
thread could have successfully destroyed whatever caused EEXIST and
the successfully registered this same vdev to the same id. Then this
will wrongly erase the other threads entry.

It would be better to skip the erase directly if the EEXIST unwind is
being taken.

Jason

