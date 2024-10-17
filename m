Return-Path: <linux-kselftest+bounces-19986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE69A2931
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AA51F23395
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929A1DFD92;
	Thu, 17 Oct 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpdtMZEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FB1DF27F;
	Thu, 17 Oct 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183225; cv=fail; b=AbEG/a9OgVbnFrRqsMKbAw1k4zw0YxACI0dLBlsvQVkmJQBxXTa4x8HcRR/pWeWFYXEsx51VzvJQKazrqRQ3SGDGKaHXMu0xn8hfKPORFcS2bxGBsbS2ALvSFhReT1LX2UjY/j+kD2lbRYXXbrY46AwE1+6kMjbMRYj4rWiT76w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183225; c=relaxed/simple;
	bh=65TLD8ilOkO2fKmdQEG5mIiYo9Kr5Bkc7FLibVZoxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ITWFxX/WZCsT90PHlSjdTgWLxp5/NtWxy8pU8n1ONs4OA3IhmFyIr2aFnBzjsrOi/69QyZh29pXk2YjJzA6mMX5fZuYGP94rJdcproW8B5dKqoCsCKrDKbMZ/7DDZ38EIx2NjPP7H71r5F411pe/4LivGsmzmYC7/aYuXjKvQx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpdtMZEq; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIYfJm4IdGzDxs77tI/BwlBgUZJuqiEmYZ/S1kvdnnm77pSlcdYOCUhBI7+Ao2y5FeTIl915M96IvDbC/NQV+ms7mXemSNcyGUHdsEXv8UGPzF1962h0C8lMri5Ly8N9o2Xdwh+E48ZPDfV6y3foK0JYuAjuD1j4VJjjW1zM1TXDI6JLAChcKK2aSHSN50Bwhuy2RJF2S4GAbDONxGGG6tviT/k/LbACrK3xflSp9DEak4iqwYDooVaRCi08++t+s4m++bd4w8e7t4zT7RN0ID/r2VTRcM4DVnHTLnvNYTe0RLzU+0wCTbPNb/buevh3nrzar67l/jzNo4b7B3l00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR8FJAMTI2VOheO8YAtlFu0dyYAxGn7/gWE/DVnrCes=;
 b=bj1+8AtZZlaNJqc7MrvyDlNgB3edM8EtSWvA5SY15RTiIap2D8+MjO+6rBBRWRJJ/8Vdoe3a1K61MlJR0aAPkaOGDHY3Oa07fZC4kLsLmyxqzSNQCx7eaLHf0LIosh6Xj8fk1slke042LYXSJnGtqFgmAwunFtI/P5xXih15PLdcI1ALUAkPL70z6qNAQL81G8Na79/VbLymyRDPO7RJs9wDvguEg7Fx5lqz2OHz7k8vh6iNqWyZnG7SfeidlDmjotd2yZQ5jkORxrVQv7IBAzmNwISg0X91LUSNCwMHgejZPMdXJygJq8bgMsennM61nhbZgg8vNzSflECOB/aYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR8FJAMTI2VOheO8YAtlFu0dyYAxGn7/gWE/DVnrCes=;
 b=qpdtMZEq8ZBi18yQQyvL0pbrRHCFG8pMJjGiK3rH8vIhPGU5CC5AGZIFldyQfTJ+GtUJdL88YP4EK2giigA7Yh17o99GF/+pqZacHuFpEvYnk65A6tGiywddIJsDnDGlRShPk0j5jGyvt3axuGLowWyP9HcdDByxg7pIZDrlGmhq3L6pjDDQGsQc8EHL6WnihBjrWWcqWGlXv00KijQJcUcRN6X1r8dfA7u4RwfSHAcw/rfkA3JK10PoD0a0v8qktRcc7nJLjYYWk18D5JuaSDl7k7BK88JaVQArQT1GQUONFud1mB8DqXj3xdP/OVpuTtjoNxJovUilMgTCn0V7sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:40:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:40:16 +0000
Date: Thu, 17 Oct 2024 13:40:15 -0300
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
Subject: Re: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20241017164015.GD3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:408:f8::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e09bd3-b81f-4997-1d81-08dceeca6126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O6CD7zVM2g+xfNkH8rQVn4CyL4kuodaRWp9hCNGE5Cr4o1J+yys9xu05lB4a?=
 =?us-ascii?Q?sD/X08RYvDy3DNXU7IYX79g3ZHi88WHau7Yxcz8xFtT6b/Xs8T98m3WIXMjU?=
 =?us-ascii?Q?duIjCrl9RliGvJ31WTh59n/9YoQFQyemU6AOu3JtxksEmQc1mKlhzPe+H3Dk?=
 =?us-ascii?Q?7oi5E6aOYsaLzOQBGGMXdM1M/gpJhkDQr7ohe0BmMwHRxJCDAxD8U3lvMXPX?=
 =?us-ascii?Q?5yFi7XYIPPEaASfnSQGMcDPB6rXF+K913FjtT48SuhGZ9Ik9pFKkzG/21Tf+?=
 =?us-ascii?Q?iLl3XmKs5okDPV7AuFDGC+xgE1RqJxcBjJWchtLyS2M8gMZoKYXznFH8hjfM?=
 =?us-ascii?Q?6XxG8lk2GgpRE5FFERTppPVD2iFoZ6HPM/6q6h2S6oiwHhM/HawztsKdAHLV?=
 =?us-ascii?Q?Z2IJbyMQizCEAtR0PsYIUtsKBPB81csLfI7/CTvAeSrsztqdweWv9TNrplQB?=
 =?us-ascii?Q?1pscCWlkPu72//cEJM0Sje3sRWIPRJ3iCht5Uj5It9hAexRe9P12fBHgToCG?=
 =?us-ascii?Q?dnWXJB8ySCEfgw19nG6L9o/+uHU2GBxXnX5R+mUZ9aqYK2kUO+tTc88x7Mez?=
 =?us-ascii?Q?SOQCMDDAR8z5K97L2UOQVUBZQQ33gkFB8zqw7fbJ8a8XqAvrhgmlZVK69wJh?=
 =?us-ascii?Q?OA4PTDtApNKndLww7eYqcITpTSPqMWMtZxAMRaoTkFeHapy2lacxIdX5Raxq?=
 =?us-ascii?Q?r8UsuXoV4wNIpKTUANUCzGsQgP85cFOzs5m5HXJnYgdKvJqK5I/6VnF0TcyH?=
 =?us-ascii?Q?uWFDIEjyobYwE9MXlbpTYu8d6VHrNKl9jMnHqP2dpOrC9saY8poRMaWJr5n5?=
 =?us-ascii?Q?hjSf6PYXbYs36FC3qMhuhQF5Maior13NwUBPv6M4TppAfpmoveo5Y6pyAtmr?=
 =?us-ascii?Q?NTuMGn3agYEg6J7DrO+6AocFyQNzFNaHcoUtVCU3ZLY9u0tEkhnS2uOx1Co7?=
 =?us-ascii?Q?YltBxY0/yxDqEKA/It4FvSCMQ5q/lSaLbBwdqkZSzZc860T1zlYLxJWPjHGB?=
 =?us-ascii?Q?eZjJQAgSqazk/rs/9+FAOOVDNougTtuzhOImf1nOKke/hGXwQ07RA1B2J+5Y?=
 =?us-ascii?Q?IzTJDsizoGL2+qN1vv90IYHuTLb8QJRE0D1t0UBLfuHVpmjTl0WWC8tpBSBL?=
 =?us-ascii?Q?HiO7Lw2EHWFpDuv+EBFT8m9lDR1IXnvjr9s58eRMlPQ8PorsdO+WLq2ep/sa?=
 =?us-ascii?Q?lizYN2TRyYy/82OR4wvriNLCRRpMAqw6ojX4WcCsUvszkvJzvXKP/NFDywqj?=
 =?us-ascii?Q?PvOYWlCeUHJX3FFU6bCyJvFCko4Ny9vK6WVj65ONEwWCcVAxJbnxu3VWMFXF?=
 =?us-ascii?Q?NWIMdur6IqTkAWv5rdefUdTg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5JRh14/RkzBE6BFnxiqJFPIQOzREd+zjOAnvf3p7oeSVbmW1VARE4MXFRKq9?=
 =?us-ascii?Q?7qKd/Fp6S2WUMNaCHkXRJ8llCwJ6qF8fEJD5CP5CBEy1ubP59KllLYxTo1QG?=
 =?us-ascii?Q?W5f7ouSHhbPY8yaIAMq8dk9JSk0jyBn+M/wFM/rHGeJhz/6fQTk8M/quBYMt?=
 =?us-ascii?Q?jLbLpnzqZG/ab9ZdzG9mA4ZFCc6zjBGKv1+TRyg+KGA4OLUxUgCPAlqdSQuN?=
 =?us-ascii?Q?aixIKZAGTtIZmV+hFfC0bcst8GSNVm1vhpKJpzQG+b8D/4eNpuJtyNMVYD2z?=
 =?us-ascii?Q?0YDKgVOn6mLpGfXYYssS7wJIDFWCe4e0DhWk2ahQuAH6mNbUauP31FRop108?=
 =?us-ascii?Q?3fFW/EUDpBj2U1xExHBEFnEtVzdewOmkQuJkYgykI7aIMQTY2Lj5Khqadmit?=
 =?us-ascii?Q?4S6FsBlyXNLS3Q5UgtH14ZNCXSnPvwyFnmut9LbMSSOZ5di9GkSD8SX44Ycb?=
 =?us-ascii?Q?jlmEVoebjisDDkRoMxDURfLSNyvf7hySaNYN5tmNCg8e2FJJDvWEyl74Qtjw?=
 =?us-ascii?Q?Sf4QsC9TrOCj0Q6Zv/hVkcPWp41rncLdL3xOIMiHGrJ0hb+8iSImXf+08ZKo?=
 =?us-ascii?Q?zZ2u8DxlFYjRyjX1t7caapzV6QUyYjUVJnYtcJT+jcuGVRtMGWXHtVm+6u5U?=
 =?us-ascii?Q?O+ts3vR7cYNCRSJNJz/xgW+zPcZoTjGDqW0jfh0qZ5ZlRrV0Bu+a2R7mx6IT?=
 =?us-ascii?Q?QRfjo2MWciu+78Uas5FosKQlHkX9QznWWJq6YVQmkD4HEPdKB2yAd/k0RSK7?=
 =?us-ascii?Q?keHShqzEPUz0NH6rALqSep9d9XRt4IVd9spisFmRb8YML4wADMPsJmzKcofj?=
 =?us-ascii?Q?hmqkwn4wGnormV/Qrv2jJtcPcyT+z2H3IvBMI77iSyhKbuD/GqtSCmwp96jC?=
 =?us-ascii?Q?EPfBfXmuyF0onIV18+WP2xTgFnxdunVxe1zVH8Zqa5NUv9lmeR6SOcAbGd7U?=
 =?us-ascii?Q?fa9g4NTGQS/+XklW5z49nFGvp0EHId9Qrbt0UlaRTTl7WHG64u4dN/572Jv5?=
 =?us-ascii?Q?8SdIBw90Lmjvl83pw8nJqJScVZmnCa66t/N9bIDzElnwGEbKmx/srsk2/5Gv?=
 =?us-ascii?Q?07BDFlK9A47GHelM6XCde/ImbxWAauF0ylT9QPw/ly3EZGlStYjzdN2nzwcP?=
 =?us-ascii?Q?EPUigDZOOEe/aebo93zfoJwU4ReEzloh8inOSrHEbV/VecJlnI4FPIJ5DM2+?=
 =?us-ascii?Q?Kd6hkCOX7fCELq7KIFFIqlAxUT4CriH7mU60Nt3SKE/VWWfYI/jNWyxOYBSz?=
 =?us-ascii?Q?Gh61/lsJS2CYlT9Q2iOI2ecYH9GAlPq5s9qobZ64IKLkNv6sdWkMNDUxqI13?=
 =?us-ascii?Q?HKTv/lim/Nreck7OuzXAEwypJtMmwhGHE2LHUVdgRT/9mCjimkGFyYafHN+X?=
 =?us-ascii?Q?GQsThJttM7CHLUpzd5GqHbskVgv4vaZ2eZDZdzd17QcvlmQ43X3GrDhljkCJ?=
 =?us-ascii?Q?nUjhoJDrrcWWYPW1/r9fe/70PEY4DlQirR8jJ1o7ch/+B0m2uiBevCtrrfNE?=
 =?us-ascii?Q?WHkBnIG5PPpiLZI0ToyIgnGByydRl2l5Qm0ojHKLMJ8xIfhnqcevpGoCrBMN?=
 =?us-ascii?Q?5NBS7wHDRcebdLkDNhw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e09bd3-b81f-4997-1d81-08dceeca6126
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:40:16.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qxnL4bKq0G4NIzAKiChgjKQvZZWvox7r2NnJXnxypbM2grO+q2fGRSb2+3Df4SV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Wed, Oct 09, 2024 at 09:38:04AM -0700, Nicolin Chen wrote:
> Add a new ioctl for user space to do a vIOMMU allocation. It must be based
> on a nesting parent HWPT, so take its refcount.
> 
> As an initial version, define an IOMMU_VIOMMU_TYPE_DEFAULT type. Using it,
> the object will be allocated by the iommufd core.
> 
> If an IOMMU driver supports a driver-managed vIOMMU object, it must define
> its own IOMMU_VIOMMU_TYPE_ in the uAPI header and implement a viommu_alloc
> op in its iommu_ops.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  3 +-
>  drivers/iommu/iommufd/iommufd_private.h |  3 +
>  include/uapi/linux/iommufd.h            | 40 +++++++++++
>  drivers/iommu/iommufd/main.c            |  6 ++
>  drivers/iommu/iommufd/viommu.c          | 91 +++++++++++++++++++++++++
>  5 files changed, 142 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/iommufd/viommu.c

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

