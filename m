Return-Path: <linux-kselftest+bounces-19174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AA993634
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DBD1F20FD4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA721DDC32;
	Mon,  7 Oct 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7FKxFFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F8132111;
	Mon,  7 Oct 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325703; cv=fail; b=dfIcjRbF+jQPsaoeBCP9lVCW4QOlccnN2s6F4oUvmQLkajzBEzr5/HrN1hSIo/3l/uENCuz7T+78pyuQLVktPYWDrlSjV+m3mMnzYprVeFsvx2u6vTjnl1Nr+4sLUMSEHYBqI+paK5GMhyXT5Jihvm2f16FEmMQind2XUXi5QQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325703; c=relaxed/simple;
	bh=PxK0B534OKTMfsALVti+J4sISb/ugdNQiXMLUnGzKLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4GxUzufJN/EhzZ5q1DbWrgV3SL2beFqZVGEcAuWiES2mLt+EbViCBVc+WVo1sbpygth1sfB+9SZoNnJSMy53AJYDF9depEFDIED3sjnR1Rkyte5liAps+3c45uIOTJoMHKqObT5pZNYxCVCNKoTgiQVJf+PX8k351SggdZX6iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N7FKxFFc; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfzcQW84H6mbFXpGSMNUYPFxC+qxAk8ggjocQjYjXIxQof1iGM7OxoJJu4e4Ur3SBiwdVR1BYIlz7B5xYPXN2BkQEEnalXX7WawlyAoUdS+wltSt/hfcFpSmlwwUjm0usyPVhiHIkMsvdXXpt3rIl6I7yUiqUuZ4RYkiW/BZx7O08hSfOjjFEWTBltUc88Ospvm2BSfD1/DaXIRMQuW7lzdh1MsDDy4fSUOH5XXfoggN5jJa1MuKXfu4BFBZgS3MdV7ta3oyrmMi27sacjYcgsi8Op8wvK9QYXFZ4kAeW/8yTERUQOQNlr+26Rol+G05L37nB4PdtzhxXE5WjVwDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7oTc/DCthphR58HBR0CePI3LWzYF0j22cdUQl/+ziU=;
 b=a+38+4V70XPRlV/zFu3oQvRXH4vGEJoQmF6Ve2KCTUDQLzimVt1Nwn6t9yCvzwrzWgZyEZlYU6Uz41AVgzamRslSh1MXcYx46PJem4GLO/Be2DD2W7pU+maWV9J0SI2CK5rz7NvTX+U8e/Qn6sv6fDNxRZLiJmbmN9XlPTKccXPbNYqrthxvcFIUgx5l50Kzta+DEbqf0ISSjJgD/qAtwN99dEzMG0UWxMUaqQVRVUGTKpQTzINTV+jTkpgpHk7H4o3TMjrKFcmd+POkSh5ps3Tok9l8ORaVDx86vGxpt+JZfqC/2y58WLcoaLHXEApt36aB3WLnBltjIIXrisUQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7oTc/DCthphR58HBR0CePI3LWzYF0j22cdUQl/+ziU=;
 b=N7FKxFFcXKLNUc+lY4iDOqRayzvEB4eHiW/mR7tCSgRgNXNSayBWbM1c8a/oq8uLyPf3Hj0yIr+KFoAXe1ZOJDGXW1YHiX3ujAk9AFRpZ0PduEriGsLQ+WGN+207vclHBi66l5C58EQ41bVRW7Fkm1aulnmxbzoZtnJnvM6Y4P8ibIbvCyjaWk5syx7jAdwReIGj7DxApys2u2HTeWvbhQm2fL9ReRSfE+g3HToVG7iL5LWj6nlIMHsWNnq00zVwcIvnQYkcEmQlaS6/KDzwpA9+b8pjS5MVAtcIuE3fk1Hn3ozNtmOrOnEB37mncWSuhLvZ2+ThiMGBokAGD/jMuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 18:28:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:28:17 +0000
Date: Mon, 7 Oct 2024 15:28:16 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <20241007182816.GD1365916@nvidia.com>
References: <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
 <20241007153837.GT1365916@nvidia.com>
 <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
 <20241007171119.GY1365916@nvidia.com>
 <ZwQZbYiCdf6WVGG5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQZbYiCdf6WVGG5@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8419f830-44c5-4dad-2e00-08dce6fdd052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfXhVk6Lx0DrLhEZaQyhXrc+UN9kjAyAnHdg0NtJDXVZguutzEbgMKFqysTv?=
 =?us-ascii?Q?PO1nris1wqKrdXqdk0Q/sHrpHpi9Fi6d6nKcR2Fr2GiJgG4HZ2LQzLeQd19s?=
 =?us-ascii?Q?xK+HEKwG7eP5K3QL+qV9yBeqf9sh6TaRUPe9iBfn7jmjtoE71IITQsgQp9wu?=
 =?us-ascii?Q?DZr6+Kpl/slz8Z1w+LAlOXMq/UsF84rXEIt7+n+09YxUJRVZlpaBmehU6tiu?=
 =?us-ascii?Q?U5PjzDs2TK7/UbvN3A5hmsdCAl/Xs1Edz9hyFZtJ948eyNHZj6kYe1zZ3TRg?=
 =?us-ascii?Q?7IcOESkWyMFU3XL4LU8Z2TM5Z6uffhSk/ofb3AqMJDrV9kLk8zq3jj7cRcI4?=
 =?us-ascii?Q?L2hBvCJWXbuIbDfldtyj58FAJFGqf9TfZ1LLwwx+asl/mFEEzfWUd7ArFhIM?=
 =?us-ascii?Q?s0vrG0YDa5Zze7rTHPj9AEuOxw7u0ksF0ssO/exJYFtww4mCMciYfZJU/g8u?=
 =?us-ascii?Q?3/z4KqveTs8MXdXngKXPG89Mw7Qbf7JqCNyJ8Cg3oMah2IKmodmltRW9Coyh?=
 =?us-ascii?Q?TvzarKAQrDZ0VS55dsQWPWzIy9PIbiafeezqrMjK5kECvtEA/pjeE3qZI02f?=
 =?us-ascii?Q?wp35IL9hwoilsqizb1npQZi1ScAYD12LlspN3xCKlTbQWZV6GKZp6PCw49dp?=
 =?us-ascii?Q?0b4svtUjcdXBgpOdBis8cQV/LjqpnNjeN1YLKXtm12GwKZenZj4xKCvvWtWW?=
 =?us-ascii?Q?An8G6PZzFPpqsfZCUogTADMzi4e+2+DNMbywtrU+0m023N3kZr1FQi76dMpO?=
 =?us-ascii?Q?qFpEMKiFacmt67S3CpIiXlL+Jz3Dgirhjp6cJ5zDkv5D3AxgYfZ7NWv8ZKpl?=
 =?us-ascii?Q?+GpsGb17d7PCUYKhCZ5f9jqcKBjJ2lqT80DLz2UfSC2/uXxrH+hEt7m11ozF?=
 =?us-ascii?Q?kTH+S+5RF20gNwUM283b+l9JEq6mY2svxytjA9yC8A5EVb5nOORRZ09rDSgg?=
 =?us-ascii?Q?MbGWKffMmCOfNEOqHmoA9DxDzCCQE0JGKWtmiLaxZ84EO809ZdSjWxIxgkzx?=
 =?us-ascii?Q?yGIJRmNVr0LCUmdHVPrftMwYM9PTTMsYBHGe8GOEtQIE2lwC9lSfUQEP3rev?=
 =?us-ascii?Q?+dh6GGXzIcSB68oLgu/2pln+x3zy2UGkm7RURzj5G0bw0bKaNunUoZ3ETw8Y?=
 =?us-ascii?Q?UwI60GBlGWm5urHro5+ui/Uq4dxpzf0W3z65kkLfOMV2zAs4Ex+CHJMek7Pj?=
 =?us-ascii?Q?7JB9aiMBJiD6jPNUoo0RlP43n3vep4fiTJOKvdRBB5hvM85H1aUT4GoWkOKF?=
 =?us-ascii?Q?KBVSGKnVMDz2JoxlTTeNoYtiXy7w5wH8vXKc7QcgHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRGpnLl2QCqjF1ZlZwejnMcRSesH6rqQ6HxEcMpUC18OPui34ICZdJ6Mpu73?=
 =?us-ascii?Q?g8sQl3bno/4KYW9LPVOdSKBwmhEFYAbqnJF2UnGJy2/d+SZPUhq5JSf+SDq2?=
 =?us-ascii?Q?ZiIkEO/XLx74XQmn6pYyyk230BBnq4T7UGPCkXbl0LlHSxmLWfNhq0h8DjU+?=
 =?us-ascii?Q?8gmDU/V3gaXPeCB1xeyCCHf5gGsP6hlytmBSEsgsYPEHeVdwIjBdoR3ufMBj?=
 =?us-ascii?Q?PbuaGOs+qWaWhRoq+TG7L5x5zl94WqPnopE8cRpQoR8ZM6TMgogC2V44SJYQ?=
 =?us-ascii?Q?ItGWz+Xc9X5ZsHoBM7u1vghf9/qs4YdAgrJAbZfGcEO/Jpkdyy57yJBtilGS?=
 =?us-ascii?Q?NjLaU+Xy7NlfAFPxujYKU6GKgP5fbQSweFaq2TO7MgST+VSidSp+ND3sctvh?=
 =?us-ascii?Q?4VSmw/MPMaaLQYBArijvACgere0QU5X/sWTop7/yN5dBzSQi9mc8xsnkxsWV?=
 =?us-ascii?Q?VAjnUHS+fvcxOkuh0Fi528T5zZrJHSRSL6KfbQnumHj0TDdRFFAdrrHmAsJN?=
 =?us-ascii?Q?CvuS6XNuXiPP/D9jQMAKEW5YJKWPOYwUqd4SMyoMBHvkfIIt2CZsjHRtue7L?=
 =?us-ascii?Q?vKIcOHQdThHs5aPGJQn+90JCOhpv02skKYBwtP0eOogPnJ9jL2M9Wglg3qG3?=
 =?us-ascii?Q?+gcqKMg5XVVhLnb0JYf8SYU4PmXuUGe3iGr+OrrtsGY7ey6QwO8fUPZcRgOH?=
 =?us-ascii?Q?dlqlMSxSQ8mjv/CgffsZPFgX+RHyosRjPmdL5WYdX+15MK8XP0gAoW0Yaek0?=
 =?us-ascii?Q?KsdjBwSb7nbNmnWCyhimTqzp5TJO/jiwtrh/0LilH8w5hK2ZWIJs10Xkd8wA?=
 =?us-ascii?Q?zdIBBHGNSIoKGP8NiI3Wm6daXGHPbv9tBJLollrAVfhnkbiN0KG55XumvMH+?=
 =?us-ascii?Q?AOb13uriffpTV916vfQq+9ik2VEcEGO3kA0gg6flc795YO0t7bEZx8E4q1sW?=
 =?us-ascii?Q?eRC86KVQkvc0D0yYbJwZnWVV7K7EMOR17Ety4osSd2QyGikto3gX4WBAD3ED?=
 =?us-ascii?Q?JPpG5uKSiBlhFiuDr6nFrHLQriRSwi5i2mhHysTyw2yzzlyF/x61fNlyXPLw?=
 =?us-ascii?Q?OUgMiJ8CnI8D3Y9QA8QSZ7IJvoiz2qtHAQFHunYTKDSPrZV5JDZNzkvWbraQ?=
 =?us-ascii?Q?JqY85MUeweV6T+MnudUWO5eNJ+fAJH/4MTHB1DiER2keq9BC6qkX0ePq5S7B?=
 =?us-ascii?Q?v3U3YepZHQxQK9REHfFLk2KrYhBD7t/iidzmoLQpwC7u46g+NQ3Dw7f2xsHh?=
 =?us-ascii?Q?wKgJdu3f+/CuFu8tCQsabyzHssxRIsb5icAZmptjNl4tfvZjliVmW4Qvws3R?=
 =?us-ascii?Q?9F/yc+n97ZyVJO4GZovqfTXnrDfLJDQnIf9RC8h5xVawQOp+iLyQqlwmYG7+?=
 =?us-ascii?Q?VX+7Mjr/a4u+U/lFFuCla98doOrCR9NBoBDhUtPhMMXz3EV2XyfHQBP6ktk8?=
 =?us-ascii?Q?5pthnjejU4qHZUKYs2SD3Og3/coZEMzjX9nkIJSgS199BCLrSpD6sYDeF4KR?=
 =?us-ascii?Q?TR2akGKkP8E9449LMT4W48AOVmpNeXdyUCXz8az+x+Bjkca2nCLGk76U/URz?=
 =?us-ascii?Q?ClHNCcFZ6UdcyQPJe9k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8419f830-44c5-4dad-2e00-08dce6fdd052
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:28:17.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKbB7M/llpG8nggQjyUtMZfuQ1oEqrTFGshnjbnHpVDOes4eVGlvXkn5Ahroe1Qg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On Mon, Oct 07, 2024 at 10:25:01AM -0700, Nicolin Chen wrote:

> This is for vdev/dev v.s. hwpt. We need the lock for viommu's
> vdev xarray.
> 
> Yet, giving a 2nd thought, I feel the lock would be useless if
> a driver tries to refer the returned vdev (with this helper)
> after the vdev object is destroyed..
> 
> We could only note something similar that caller must be aware
> of the life cycle of vdev itself..

Yes, I imagined you'd use the xa_lock for this an it solves both
problems at once.

Jason

