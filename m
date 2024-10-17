Return-Path: <linux-kselftest+bounces-19963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366589A24B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACED81F2219B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1D1DE3CE;
	Thu, 17 Oct 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWs+Kga+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12F1DDC17;
	Thu, 17 Oct 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174470; cv=fail; b=ZD0bIBjELjebeSCr0invaaOoICVK4iNsKdMQKkxyWZn2FMXF4R2M6L2wUx/mA2TsTIge/6zp5L94vCUsPeaBXJazlWlMkC/HEgfd3zecwyW1DOtL0Tq+HVq7Tn7ClxmGqfsmFohuDzGf6Vp7lcqH32ayqQclrLfuL0C7oYaDczI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174470; c=relaxed/simple;
	bh=oBEJlRNTEh23HWRbsezHjdUvWvnVMosjrCIs7b2q1us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H87mIYVRsRAL7H1ik1qo5KvYwqz2bLy01yH94uCkTSW9Qt8UrG8DwcfiNW652HHwAG3oHfN+ZrjVMU25KYdGDXeMBtj3N5uq3OF4xZEqIy4DPC5CGpFe+mLzzQ+BZi7HpwEDqhwCsuC6XeOPxj1Dj/PryI48n1bLfQqWlO1CnRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWs+Kga+; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3vy07FeUGqy+EtEPJUFXD+Uri3PARBJrF7L5W5NyCaRHrUA0JhJJn04AqcqQiRfXR6HhJwPh5BNl0j0fx9qorJwWseUrZCVd6ULXjDLYwXIJI2vII8xm8H7Gh8EkJ9ta6oVmsZs923YxUaB7XikKJGn/SZYup4oid2RxV+HbMORpV6WZm3B2JVbPjS/hwLNqZPFv1pIDFrIi3/2FnXdiAnfKmWkJULrkZqhZRzM0aU8f+Dr+ip4tyWbnT1qAJwlMgnaisgEWLmU3O3mh+9l3r4dzmAf0mVT+eMYoCTBvGPsX5/G48+rYUaViHz5A4NehYRRQ6tHXd5pAjPYLzWyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HteckkG29hxdMShrKLr2ahb7DX7qmarYrGc+ytAjjRo=;
 b=nNZufTbPmO6J8C23ZR8qHmJQZ/eLiBHkNimivmn4Z9Cf/79s4g8qhBE5Nv0tmPRbNb6Bb46eiSo3ip5HrGMuIEh81HXKq4VtZDX1fp/kdHpdmzideVUQjNCgt2L5kwYcvDun/Eq2QspfPTjfXJ2vLthV2AixDZuKl12jQMzHQytb53EH8SCR8uOcdwzq5pvI6sXNf7e+JhiYQgn9FbVz61A/Dp3JJX543gE7Cq1NFnqdOegHoXGQpFzXefk2LVZ9t2zrwUtlO6j/pJgB50DAdNXN9isFgcgucKvUUwSJW9WiLMNvO0mG1sl8LHzfzYBb+T6hZpc0NZ74ZjeISWZicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HteckkG29hxdMShrKLr2ahb7DX7qmarYrGc+ytAjjRo=;
 b=fWs+Kga+RYKKg5vqGD44OXyGNz5H2/vuGTmrg3CTq0XncZwGxIj0tWTal14SiSaX1GainoByNL/V6D6bMD3wL86e0R96x/AojBes+y7r6q07dS4CvthqiblSK6ztpIKQYKNqMBvxeEbdg56Zj+QpeRjr1GB78n3h6Cy5Lkfp3qItJlWK7IBL57y9EoLEGsVboi1XbDfD3caNzrqKS9ZJCsxG+oOg4/BSeVOsf46me9WmBGtI1NCQZHNHf1I7ytD8OETxTsk35EiwTrqoKp2mEDwyM5VLbcQFX7N5LsiiDrwM3+Vkk7v6hER1nsdFRgmgGHgbhPkwvDLR6FMPcNwyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 14:14:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:14:18 +0000
Date: Thu, 17 Oct 2024 11:14:16 -0300
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
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <20241017141416.GZ3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:408:ec::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: d2310efa-fabc-4981-c49f-08dceeb5fca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?totkhgc/WU67lZbxN9vdWHcpltg9lKWfBoXud+RHKCX7ubxO878El0BcouSf?=
 =?us-ascii?Q?3sBOCCI+HneGCgJ93OyVayBoO3PGqMSF/ErFbsV/GDXCi9PAKxZp2OvUfY2A?=
 =?us-ascii?Q?8cxTWZPRZ3Fol0W3qtMGsmZu4qU94fqbnsPMk2lx3eue84hFNSEhUruG4oP3?=
 =?us-ascii?Q?HpUNc68eeJFlexEVpqi/FHLgQiSaiKVpOFiKm9chIapMkF9V0PXMHPssKFHo?=
 =?us-ascii?Q?QmtA2rwhVEQcX+1PwyWDM1Hd7UShLMjKMkCdQXVlA7DikvvZlNxvmqHif5IG?=
 =?us-ascii?Q?WSV6L2duB/NYbwFR56tBE5llWMkXqYrWSHEfWrv6ojUGfh7Vk6LlInGiQ7+8?=
 =?us-ascii?Q?suamfRof4EwKarc2hg50X2hPRQcfBgpf0CWf4y+SxkqpUVzX2jHrB2d8WAAk?=
 =?us-ascii?Q?kw1yBst6yvQyomxrvX+X5vyEDiduPC+TwHGw5kyT5IJnIKzdwUmi471fFuM7?=
 =?us-ascii?Q?y0esybDK997DccQvaVMeHerinu6dXarxqh7s2nMeih/zV3JCqpL5IYfPRQ8U?=
 =?us-ascii?Q?MB5pVg3U5uaATKWuJWOCZ+UdfI0i5HdxulMqc0c128CUQWcj2Mkj4K/a7TnK?=
 =?us-ascii?Q?njrGZyX2cs80onKrxMT3i156PlpQ+TAd2rsKcXD9MZY6DaBZyE5lfJeQHdae?=
 =?us-ascii?Q?3/FNoaXDS7USRb950EOFBVLGIJqrUSQmnG6H/kF2EADmGuymvDGAPFbzv4rn?=
 =?us-ascii?Q?SqyQ+lSzlI4J1JqQe3aX/ovyLRTTrqTO1OYmCxdRy7zCghxEnWqED3PvuwTA?=
 =?us-ascii?Q?q5eAcHj3zwkEzWU1wPqUlse4E0SCJOqY2vde88wvVxdxGhMiXaF/cwvnbiLu?=
 =?us-ascii?Q?9TDcobLllUsslaTeQNq6+v4Cu5XXJRJ/DlQhl1i9A3MMX50upfvZQHwtNxkl?=
 =?us-ascii?Q?XmzbJ9kl5WAqZALJK8riEYvYljlNZ13XMQHi0ih+ycoIlZaWhr1XP+6Qx4xj?=
 =?us-ascii?Q?4ollrgQy1kXOni1m+IViLDh8AnpMWw2HS8wgK8XrtNiY3CM5QB2X9NdFNqnp?=
 =?us-ascii?Q?bkhQ8JGgMO+HGLBu/KzmVz2jschQHpKn83uDYhKcxQSGGfBLkt1WNWu+3FZ/?=
 =?us-ascii?Q?zN0ttMFOb9sIkjjNXN86xB6MxkfZjDk6RD+FP/C9zzvKAwd5GGNAIpizT63J?=
 =?us-ascii?Q?yZnPCeuMmUVH2Wi72mQSwUdOoDnQcTECdEsDFAR8M7R9RKSftCXdlmmcLtIe?=
 =?us-ascii?Q?IYwxzo8Y5kxHgOiaO6EHgeiFRm36HW9hiafxiLrIuu3ON7xkDYxMbbr9KALm?=
 =?us-ascii?Q?R94WVZE7lfaLo4l1P0uZquZukFZMknvYhPFBldKoFWm9sERkLSPZ4QFclXEY?=
 =?us-ascii?Q?edk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfjr5m61iJ/sxyxg9Fvqrs8KUNzTjz/N6/06y2Qdc5utJpzCIrZt4KMPy84u?=
 =?us-ascii?Q?9dVES9tNygVHlvgKIJW88ctPSLbVEiU7cFJ8Az9Mkq+jMaAV/7D2FgoJPmwj?=
 =?us-ascii?Q?TCSWF2hUHfNAWSeXBFfT45cVRVAPuOrwVSPc0wjByWuzlSWO0QqENQvOoPIG?=
 =?us-ascii?Q?Va6Q6FgFD2b8vFDfYX6gTd2zpnhhkMeHdp0yn0CRpL6m0ptSkHBqKoNdx9f9?=
 =?us-ascii?Q?VgVadvna3UBnc+YxYOHFvM6UTcZBwdVtwK4hqCqhWiLkLqD70KP3IMAhC4tq?=
 =?us-ascii?Q?qHR4/5qMsXiLVdnPZmfL+4KMb7oqEJ+IuOTY5/oRG5sm+SW9Sa7U3IiSqfzW?=
 =?us-ascii?Q?jzzxSqZ9Vf4V0hQ6GexXcyE4q08A95q5ycZxL3QwVTjmqxZ8vYDBj5GyAZtC?=
 =?us-ascii?Q?8Mjv144xzQiGNS+lWq4MUhiIsCu+1tQZSwj9yb9igA8btfLQjZpwseR6LRBT?=
 =?us-ascii?Q?a/A219dPBHM7JufHFCKpSLetG0zxLlRcRIyrGUZmqpD5tqUuipZ2t2kKceDs?=
 =?us-ascii?Q?el7TlGwMQ5SOiIM2wpH9WzHlwktUqOHKLfnmOeHOb5K92I9j75dR63eVNaHa?=
 =?us-ascii?Q?ijqKbGNQ4Ebd07cZpCPlGNQSkT+GuOHp6192gG5HUw0NVc/+JOZCPmoDUzub?=
 =?us-ascii?Q?L9mAtyck8leyIU2RHxVGODoqdOU0gbExY3oE6kVqGhC1ksjBqdPF9hd+Uetz?=
 =?us-ascii?Q?92zwkOlYykC6LLTjeD+TNLxyspaphJQQ1b1UW2+2gd03iYG1gTGEgGdOFfhv?=
 =?us-ascii?Q?0EIe14LU4uLdCuUH/F/Z/GLEn7LJGW+gWBrs+JT4z4HIItRoMtDRVBLHDhzU?=
 =?us-ascii?Q?Hn/T6ZzDrUVBKjZeBGRYa+yuZBeADQV4zPoeyDx2dWFh6NZ7XmFh2Typ6xlk?=
 =?us-ascii?Q?bSAuqkVrzvQTjboxBw6RBShzI/UmVV+7bGlOWRpG1tRWpRUvREpulh/RWZ7o?=
 =?us-ascii?Q?edCk41uR4uf7f2OYXCvg7toFSFeqGyRjdP69mPK3yKqb0ut2+K6kG1JlMIsS?=
 =?us-ascii?Q?BMbxyeDWioo+Tz4NUYTURzhhJVCsUTmbWOxk76C/ZEDjgl2JBrVvQrcuSQN1?=
 =?us-ascii?Q?R8O7E0+m74Psd4mJrC+BO7Dzlmvy26rorEZXJeESKRdb5T7J/ndygzbgZGbO?=
 =?us-ascii?Q?ctVC1QoLM6nh9/HvwxjwedWv8qsOF2X2oTlvG0JunervAfhqurLOA5lKb7x4?=
 =?us-ascii?Q?PA1gmtbJuAAYLsKLhNhXQkPGrG0JzgTrKczeA0ZZuBGl72bo+Yy8yRE8iugJ?=
 =?us-ascii?Q?/zBtFivMDdzn0MNQmx0vpQS2vaWjsLvcXqPMPoNYQ/5ivJbCLC8j0D4e+M5O?=
 =?us-ascii?Q?oI8Z6icCWvwC8fbfu6HAxT1hwZ63wW+qf7TDUwdN53+O1kKOZSvAa46wV+jz?=
 =?us-ascii?Q?1Kaq40cwyQ0hTFoJPUuw323DLCYNF5rXjXSnqSiQoWUZ78FP8bbHV5p2FvuD?=
 =?us-ascii?Q?UaXWblsDMajKtf7wDY4lhzWCfH5rnKwhn5q7d22G6Pc2R/+9yATrUme4Swci?=
 =?us-ascii?Q?nwvv3FJCCgbkmV9CqyK9K3cS+Sa1BmrG5vVOBFqM6Ay/o7rTOk7YYX1VWUJX?=
 =?us-ascii?Q?dadeY/vcQwYPHC5HGts=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2310efa-fabc-4981-c49f-08dceeb5fca3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:14:18.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPadZehil5guNE+AIhNHAS3hg1LzYmNbgieXeSScHIN7teqr8bBaPTGyhIPm86HV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Wed, Oct 09, 2024 at 09:38:02AM -0700, Nicolin Chen wrote:

> @@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
>  	iommufd_object_remove(ictx, obj, obj->id, 0);
>  }
>  
> -struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> -					     size_t size,
> -					     enum iommufd_object_type type);
> +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> +						size_t size,
> +						enum iommufd_object_type type);

Maybe call it raw instead of elm? elm suggests it is an item in an
array or likewise

Naming aside

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

