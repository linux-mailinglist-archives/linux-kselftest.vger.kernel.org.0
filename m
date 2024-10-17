Return-Path: <linux-kselftest+bounces-20030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810129A2CB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AD4B283F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8921A6F5;
	Thu, 17 Oct 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0pH+JF/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53972194B7;
	Thu, 17 Oct 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191178; cv=fail; b=WnVO/EV5gaLQ9BBkkflShQGrbH86z73AqOM0cgLu8NvmVznlPRVeKSAJbQ/p8ZzxN4h0a64upFVWJrxhjmT8911bwgAVPkLSV3jJOQlsDnY4Opgw3T+nOau4aXH7isxeTJsbn3VqPaopKfubH5slA16xcN1uHwSBVqDaOkUpaMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191178; c=relaxed/simple;
	bh=6bQ4aMTuaBJpi4MXDkvSUdkZRlwrmTwFJvV+Hmq0vqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jwNkYkZe8rrUViDFUo/qMK7BsmHauuk0+aHV400iSyndvfzEk+TfXqXXPGhrvCw0TeFJqjja1lXtP/N3LHs1EA5h5nom0iEzvmFQy18OP+7Pc3FED9B1LilfYXzhYn0BPVPt9qzsx1s9XX4p6f0yOCadiGwaZf3YB9qUTTR91FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0pH+JF/; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI2mZXZZmNgkFk1DU4GkcZOHYggssW3vVl7jLh4kC+njXcaOiu8VwR9TMHBnnQGbyYvntdy3rpAmPOxg3+IKRlnF91YRvMQiQnef5bYFgx0B0Oj3vEezwDmqP3eDsvM72p6rbm+62jsUc0NRkyax1fQg7MSGAqObe0YO2pWIDrR/FTzgPOtu2N++rXrZW15OjUIfAytM45TN14H15xIkT7MOBOyuuAt57hGfbCJyqsxLRzXu7okWRs4IcSWqUkJlskApvjGHEM/+Z6hNVJcH8HPkGutjb8e8gmUlxdCtEkBs7Fr5zLIuq+etqICV5SRnfFC+ceaEUQ/auoFik0GOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS9Az442Kednw3bOMuUKUpD3w3ORnE1QolGq7rBSCdM=;
 b=INT5Vvt7U3eNJm3wdDSxZNFj2KEQttSYLjKqddo53oz/btTs3mben2MWU53j+fH59dmTvewZEIckgMHx9hpnQBXOkFy8//0eYKRYduf3iZcnhAB6XH1vA2n33ZCVTM7maWYB75WMwVGaFGkWindbFvKzJOYPqvMyEOrxPrR7CRXYc1Y8adZZaI9f3NgapUkc41MW/gOl6EI30ukBxBvrgZ1UGZ/ERahfc3LzmdVXvtDYjahaLCbJlep6oUa/Pf/LteLXcSEPlUmdhiXJTe4lGIEZ/WPLFSf0renMFo1MzotVq11C0tMW+iM5m2DlTAP3wgENp6CRia+dAryFjXN8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS9Az442Kednw3bOMuUKUpD3w3ORnE1QolGq7rBSCdM=;
 b=D0pH+JF/ml4aO1oiQJeQ7h42D1Vrf461piEorVwgRxg3uorQpm2rQ9dHZCn4g2QGaCPOKNiQ4zDBs3WBGmam/F8+OVchQF9e6PpkHSDkTXHWkegus7A7Ev34ocFwopYSsE0mAk+HVFHBn6+tfVd1JLpGJ/XXSCZQ64hOvTnzzvNw+djajqvX1VLIyj9AENn+o0/OGImTRWRI9Og/dAHA5zbJBP7iSZJC9ykIy4EL2ghME5m2tQdhAk1YKryW2091y5NSQmQgA8i46Fr61YCJybi+kbJLGi7/bjtE/xN9QSvfITiGIip9XzRp+SCxO/v4D01u8xIwS5Gdw++CFL11Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 18:52:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:52:52 +0000
Date: Thu, 17 Oct 2024 15:52:51 -0300
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
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/16] iommufd/viommu: Add a default_viommu_ops for
 IOMMU_VIOMMU_TYPE_DEFAULT
Message-ID: <20241017185251.GT3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <b7acc7b61f1ffa156d5922a17e3974f41adb964b.1728491532.git.nicolinc@nvidia.com>
 <20241017184729.GR3559746@nvidia.com>
 <ZxFchFtb8ilUf9Vz@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFchFtb8ilUf9Vz@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0871.namprd03.prod.outlook.com
 (2603:10b6:408:13c::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfd9ade-e7f8-4fa4-e9ad-08dceedce7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSsgViIHKnS01FqjLqWmZNTtPSewBmaH0qs0gm9ESVAzx4iDkYHMC6Gvl+B6?=
 =?us-ascii?Q?Gd4fXk6wpj+f32oJmefXYeQTlO3DAJQ48YGdehxo9ZKcYZNtBMtOn7ViM588?=
 =?us-ascii?Q?H6HBNjUvQcFw9O3ZFvEfY9VleDbbv5unONwxcQ9tx3qtKRcF+6V9t9t0S+vB?=
 =?us-ascii?Q?FLO8hswxUuVAp5ELzcmwIPZrQmasT3gQrrCHA8WRsRXFedAN0xsXp38F7x4b?=
 =?us-ascii?Q?kCfwwc1f7WIz+rHi4n1dxA9P98eLwUWuxYYUMe9p7SU/xl9TQIHY+dZhI0YX?=
 =?us-ascii?Q?vurxIIGHldd6cnnIsJNHFrq5V7WrBSyEuFlou8YoLKExnAQtR5gvINIxjxJt?=
 =?us-ascii?Q?9HMCfWtpSN19nWTIKeZ2Z6bwQ77F6N+H0wTA9Rg0svN+KWCkgrp1ide8uyOO?=
 =?us-ascii?Q?UDWoh5u15Yx0KdOgZeFDZ7ZlHc6Pp0zHF40FJnRBZdiF+kfIvyava5ieOnTo?=
 =?us-ascii?Q?rN+gg/dYBc6/vNxCI1dK0qIKEL8GON6DvrXQJur1uk+3QPohp8PJuUjWGzim?=
 =?us-ascii?Q?Web3pKBtahZ2rBpgGsw9mmNLRjRiRStXElU0NFIKsecK/hYcXTpl+80sTuoV?=
 =?us-ascii?Q?smEsD9Jt+Si7ODZ20EPzmIGFmDu+S80wUyC0R5jBSCv/bPQiFvc0q2hZ3Jc1?=
 =?us-ascii?Q?XUocB0gB3kvdyXVOE3jgPZ0Hc+AchLZ6vsn5/NRekOLM+eMQ4df9Cqn65lCQ?=
 =?us-ascii?Q?uEyGZ2vFTsHrGbd5K58YzVpbQ/QQ8+ajpKhvrvyhmjvsVz7UtkkALlMl7McM?=
 =?us-ascii?Q?m2JNhh8C7V/rX34OzjAU6n5iqQ/HaR054pgvPvaACLHRlzhK2cG7+HGfhov9?=
 =?us-ascii?Q?4hYaRaIOF8LNPwTeNE1ISUvDfFrpNTy+XVzBuXOW+9FibiWtRj4cevhiMHwO?=
 =?us-ascii?Q?oEeqbGVWzT9R6SR+TDuV4CEC4JvgehKYgl6ESvvhc/FLoEWNKV+qEOZ16lcs?=
 =?us-ascii?Q?2Y0LH1rIm5mwF/7J0dPxytbYMPn3Q9BcxfO0UrUbGSOAS18knXeSQ4lcYEBA?=
 =?us-ascii?Q?DU5LkBs1V9Cjsu4C2GHZXuVvc/0/rmG5EcrJ2n4xJ1VLlEhLVHKG8+Ix1Iy5?=
 =?us-ascii?Q?JIk7Knx35pjelsEJBlbrOY5jn4x5/JEMR9ofAxbo3Fe2NoFkq7rel9oMbm3p?=
 =?us-ascii?Q?HIoxULOI7W6nfXzparuF4nD/ShkrDTcYTr4KexUo6BQAgJbxKh9NLWG15hSB?=
 =?us-ascii?Q?q7EAknZKWE1uP69ldjvAJaGdvkrhFxXExv1F3J0igpuv+N1b+Z06zcLRUect?=
 =?us-ascii?Q?lo1zvdSEbbdLbNLjX6brBRG/erMIKhY/fLG70/rbbrUJeRk3/+hqkhYlR347?=
 =?us-ascii?Q?YvU4qXONTBghqgEYYxdPXhvr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bEmr9odz/W/Ni7haxq4GNY+MIjWwsS9G0ZYgRFq8m8vCLvVefEMp8g/+l0Tp?=
 =?us-ascii?Q?UEd8zFkZKDQFHY7TJ2OdZlAaP3J0nu6lc+GYMhwSOQfASp30sj0HMq0s8e4B?=
 =?us-ascii?Q?D7yB/6Ot1DqDNr056WvUu87En6PBLSD83iocyDswgxDaJDiN6AHN8paYwdMw?=
 =?us-ascii?Q?RCkBD5Y1Ds3cj4DFSyeCYo5WUwDjsKPE9KjHUcETs7f+1AoJc0UFE8KilYZv?=
 =?us-ascii?Q?Za1ZumiBoIilDt2pw0q/4yw06l1zJDGorhkX3FD2NbmGkyS6GauRpUuurYEr?=
 =?us-ascii?Q?RGVrl8oamBwI5diznhQkD46M5rfEE0ZLnUPxq6GAlo1SjSw3rGKvLU5+ciaS?=
 =?us-ascii?Q?/naOWQPrbsNfJpvB4HD3xeIkWZDEsR86eFTdycAqmrX13e/FmqZqMOHp9zPF?=
 =?us-ascii?Q?y2iJ+nM3z3H0b3CPmqPEydh2FJ3kYpy1sNFIs4JxJI9anDsJ4BNq2B8jWjRE?=
 =?us-ascii?Q?akjDeo2P5sI0kgAg1pm1N3TbnMEOh7eNV12/ZvAQ+024ze+6LCLneFr5bCi1?=
 =?us-ascii?Q?DyLRJ6wQpdP/dJkj/nZ11zNQhQ/IslhWX++EsOnAXESEynA82U2+h8iMjhcT?=
 =?us-ascii?Q?rkCe82epicleXrAWNLp7iIx1c8gVDUyg0w8RvjuW5J4xlaVj1Au0FFFNtJ6w?=
 =?us-ascii?Q?725vBbHSZQSF6tOC1HAPTz7ZhRnEWt0Xl8+Exs/sZmE6lR1L84nMtozcotRP?=
 =?us-ascii?Q?n5cR1leQZKqlhjmLYDdzrQ2zumvpQ0zwHAC68L040ED+z+SDVn83S/YC8YGC?=
 =?us-ascii?Q?erUMvo75wnJnniI+CjpumFjide5K6P7PXyQiJ51OLzts6fHGVB/TYeQaubuY?=
 =?us-ascii?Q?HcNGWWPv+i2AMyz8X0pvV4QBHuXhrKYItj83pH58Znd/VE6qwcqqossRv0GJ?=
 =?us-ascii?Q?mEL/hKFApGvTsRMDYkB2BnSsrnHq1D21/0gZ04sR78x2a+RaJ2t9XmVK72Vp?=
 =?us-ascii?Q?lVS9EbHvgejHgKcI6R8HWd4ExBAg4mZYzKw6anRpinfdARXraLHfzbBAQm6K?=
 =?us-ascii?Q?4lXY6P8X8zy2QNeoIY7THHh4J6c2cn5fbs6hgl+GnvAjlqtoHvKCJuXWeEyX?=
 =?us-ascii?Q?I7x1HE2SX5x19xMQBkwb0Lwffb64ndZie1WrBb53qVStOB63h0bFSbrj9fCA?=
 =?us-ascii?Q?9Pm70r9mPX5+ej4a53uwJ/Anqx/BOysmwOwqb2JJlhNReJSMJNkq0s0avo+K?=
 =?us-ascii?Q?mAVkbwmgoPILGF/6w5hU002rWMyIAhSJg4FsfTobdz5qQ3wNNaMnVMsFgcdo?=
 =?us-ascii?Q?zbFhDsXT3MeEhoJi8KEjzqvLiewhtPq1R3DqEYeNvFXL5hxzjljXGL26ZoOu?=
 =?us-ascii?Q?Li9uJixNPgS1p3EPNMOZreDk0hI8J12IBDk/8X3+jU8ssAxPxwf45fpIyYCk?=
 =?us-ascii?Q?ECO9+1Hbf3vKjW/f8/NlcMx2fgL5sQjebxawh7t2bXtLgVzkRuJR1MRhmzZK?=
 =?us-ascii?Q?ljvz+ICGrSzJN+O1kBg6ThjE093+LjVD/mJaYdX7Wj1RO9cD3jQ/FYnaSqtb?=
 =?us-ascii?Q?GXESOuykODDlALNtif1QWdlrNW9Fo5duD4AGKuu2LFlJQLTs99MweN0Ds2iN?=
 =?us-ascii?Q?ddzjZpkr3pq7Vw4PyMU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd9ade-e7f8-4fa4-e9ad-08dceedce7ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:52:52.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhN5VRqLlu1NGjxASZr3b7CJCltij9F2KDzY+oeSg6vdTpAlJgR4WS6GZrNFbcNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

On Thu, Oct 17, 2024 at 11:50:44AM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 03:47:29PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 09, 2024 at 09:38:14AM -0700, Nicolin Chen wrote:
> > > An IOMMU_VIOMMU_TYPE_DEFAULT doesn't need a free() op since the core can
> > > free everything in the destroy(). Now with the new vDEVICE structure, it
> > > might want to allocate its own vDEVICEs.
> > > 
> > > Add a default_viommu_ops for driver to hook ops for default vIOMMUs.
> > 
> > Why? arm_smmu is now creating its own viommu object, so who will use
> > this?
> > 
> > Do we have any use for the default mode? It is already a bit
> > confusing, can we just drop it?
> 
> Hmm, that would make the default model completely useless..
> 
> Should we unsupport a default viommu allocation?

This is my ask?

Jason

