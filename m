Return-Path: <linux-kselftest+bounces-20968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27B9B4DEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51D01F2150B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46E19342D;
	Tue, 29 Oct 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZw7Ib8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E53192B90;
	Tue, 29 Oct 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215712; cv=fail; b=TI1WCVq9/Lw9M7BP+AjuwymmAToEg10vX868gLrBjwFxN7VD6jEYCGItO71UOLXCrRDA7IxyMumr/7lxmmvOQS34RQ9MOTjoMwQ67BgpMTw6EIvZChWDDIYWpfJmKlnpdeaBLcosA5+3Vd5NTaG//u2A0L8CWJOiQS2fF3LO4P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215712; c=relaxed/simple;
	bh=CIt6b66uemwp7/l0wcAqLv/NITaZSY84kKwiB9535Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sbxSwzUnGUeL7cXEW9Hao+gYt7EO1GNVlBiqHLbf66Mha10fLgyl1zqjvvqWYmvRxW5naAEr1qXh6dhxBNxXWN2XFkWn5J4p0h8o46XajcnaLNajdLB0PIge9Jd7kugkYeh4kkszunKSxeSYeEKbk9DPhX8PtOpYaLuAbrK3v3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZw7Ib8R; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaoYZaXuedOpX5sxTtdV4BwW1IhJ2vjywasWxU50mu1usYLqIPKSba97HV0yHlqbeR0e3OQ6WkuSE71wzrtNzL86uuEmS2CoK2uCtsbmZwRRBTNNDmTBV3MXVsxMk2CaH2abzL7Xcy6Fx2k6A90HqL+opYQ9wO5PkLz8u0DlcIrzN2IiES3vTzNGSPtcORirpOgs6kSC2PSm8PYdY7c+5BxwgWzhYVKXnJbnx0ftLoGwLb5Gmf8B8oX6zJH9UGHK29pfUL6bXjFHR8VHYF5slg6VBkGxtPizlUdyO63BSyMpYOHOGJ23iX0mD8PwrrWzRRbfL4OIwKym1M+Qj8jpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EyVxNQmCcIBUWAKxjfOuWMPX3eMeadLo3eCcUN2GfA=;
 b=kOIVtqi5KNqe4RqbMyY9sEyxbV3uekQILJcDSJNOdrXpaCWREzuTmr1AD4kYZAX1GXE9BnibF+dl872yf8oH9rgsimRrQ4jINLfytLDGC3beTgFKCRiYmUvmMROGlpQA/Qrk3bd36PORIvl7WkQ8purliNTJMRxB4Qd6cH2mXYXo6htsOP0b1H0XvHrg2qQVfxXE0UpFuzfSR5HPLuJ+galXLhFKq2H22gFgnB0GAyvTGhA35GJ4nYAIaBqef+M0e+w2E8E6d49zwp8XgFK1uHBVczlUVoBm7r2lkf2iQrMdZ+juClzVcyFuSFaQQ4wmQh1alowI0+RPCF1qrU4lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EyVxNQmCcIBUWAKxjfOuWMPX3eMeadLo3eCcUN2GfA=;
 b=gZw7Ib8RJFAxXjkEgGf/rhxnxlKLIhJ72YFrCBKAdLcGc/vgiKHvcsuyjWlZDIiskFO5tIT+5ProNZzKiDRdYnEGX+soF/8argaxTaSKEmMmLNidCdmUQ1bDovZjAvw/peWzJ8VS3WI6s8E+JuU4m+P1ZmKHT6Ac9PwXTN/WE1oQrp/znRgiPtXvErRvTIP7z8oEWe9AHkVzmwqDaw9jtr2uB8Ne+SzkXsGsX72BiyPz/2WCSMdhCQm6wujMcdKjVKqzmgxB0qxaR1qGxRTtttfqO4iA+kcmFNMqhc8GLF9SQu4LJxQmqnBBc76TDY3QzwNphflt4eeCeRUDKyr1Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:28:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:28:27 +0000
Date: Tue, 29 Oct 2024 12:28:26 -0300
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
Subject: Re: [PATCH v5 07/13] iommufd/selftest: Add container_of helpers
Message-ID: <20241029152826.GF209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <53484f80a671edcf337e93b2e2292f318eefb540.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53484f80a671edcf337e93b2e2292f318eefb540.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1fa0f7-d167-4a3f-1143-08dcf82e55be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nD/YqisfSwFCY9pQv0EZmzhSdLhZ7cP4iM8P9Lng4iYzb8QosLdpNXdkEdPL?=
 =?us-ascii?Q?vKr7Aogj4cmQB6X2UZ3zCgA5txJ3/B9DATDERPjU4mJtrCd9ynDoBuXMYRoZ?=
 =?us-ascii?Q?MdhHJMH7RvDRp4AwpnZuJDYhnATY0z+IV1qg0OeWJ55Jrm7rhBQbv0hKn5RE?=
 =?us-ascii?Q?uxD4CGGAWm2r+F/sL9iZ58dIAT86Sqs1GIaKQr8OovatG6Rf7EawaH/9WTgO?=
 =?us-ascii?Q?n1rGkesgXkveK1SlZF3ibUcwhk4ZAkWY1wQK68zkI+I6HPltgJcWDpWtl8Bj?=
 =?us-ascii?Q?HMuQD5EhNez9e1g2kxMp3g1Bmcn4GHxhV1tH0wItuffgn5JkfNpvy89qWI0G?=
 =?us-ascii?Q?N7GN4a4v1WMB1rNZja/xfOdUWzY6DRgOMynN1EAZRhyXsvv/Wapv0RPOxUgP?=
 =?us-ascii?Q?Iao+w/LJJtPQg/Y0eaSBRLGEdb3GaVuSAsV/LsVlXpN8p3FsM2vYN3zccGw3?=
 =?us-ascii?Q?+i0xqDhf+F6acHpyrwWkGkVR6wTVY0ZsOXc0OkAAxpTxkiPNZ9Rhi46fjhEO?=
 =?us-ascii?Q?Hz61g9/YxOMkNm3bSplvCk78lZLFqfmA6elhlxeqMxQKgUhOpTZCbsE8b1hz?=
 =?us-ascii?Q?j17dyjEBVmce2DHh7q40+Jn8OBy9oQLrwwpqvXldh6ymD6T1eWnaSbw92tY4?=
 =?us-ascii?Q?0TSVqpWvc5Zgw0q5kz+NoEQlCydOc+Lds6T6+hXFM0AyTnbXO2ky2Vx2J58R?=
 =?us-ascii?Q?N/UjNnZTGwiE/8iIgaPLTaii3+A9602uHvjrA4pEKXHQqgJiOXWZgNZ4kpU9?=
 =?us-ascii?Q?awgs6esMQqY+BdX/NKF5TGIyxVqbQqQ6yLhKmywMBXX7E/xGjW7Aym8rL+rM?=
 =?us-ascii?Q?Pv+Z4p3hvS3dvp0+E0VgK9Q4zNXA8kXTH2bucyG6uLeMX++O+Is3oDuq3QeF?=
 =?us-ascii?Q?F0jvZrF4uZOy5DU+TJjJ2EMxg4NiU/SlWory1mq+Z9jFlf1e1tQVFCfn272t?=
 =?us-ascii?Q?FpJXli0MDMQ3+Kq3Di5Fk0WUc/b1vigGuSoslWlOjMDzxZxpnu7sUYkN611Q?=
 =?us-ascii?Q?QCK3Bl9y91+iwyZ81c99yBWIQRn1Cw/YOhqHvNYJiXoUhiwMScCRkLI0RQl0?=
 =?us-ascii?Q?cNCu0+LYsqpYNbc9IVvabU9xyybLb1k57kD4OrpXDNY2x0juJxV2t75DHCu1?=
 =?us-ascii?Q?xXp0gdwVAviNjqGeZRNAUqtXm7tuBZXAYP7ErEEtIFxE0yZW/oi+t9HRYF89?=
 =?us-ascii?Q?I3HAIXukNARLtCTAmM5HuN7b+0Wo7RK/dSg1pslhSGsg04376RUIAABCGEIQ?=
 =?us-ascii?Q?ziAs0fAhqJyWWzcDpQYJzOijpRmruriN5enp0iuUNL4UCMVccR0mulMf9oo/?=
 =?us-ascii?Q?8J9uvOQS6evlsyFetn/bOsb3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIxEbU01KliZ6Y3jfvVPqOGN40HfZ/CBzTufFZGfUDCU/nEPBso53wz/A1KS?=
 =?us-ascii?Q?neraL971HJVJugxRwgNk/NyC6bu0JnYE0l2r2lpavOunw1oMbQKhoRvkK6EW?=
 =?us-ascii?Q?ydR7TxHPlh09fUfNWnqsH3Ri8wVOfqgcX4nl29G0bfucWwnhPCe1sh5cdiYA?=
 =?us-ascii?Q?w0bc+8AIe9a9NdqW23f6QKDUTGRyKpJyZ/NqLQs6Bl+yHhYHc0OJdWOMmIlx?=
 =?us-ascii?Q?i4yW20im0CjwIw09DZQzcyzQHBudHWyPyeMwQN4X6yCxmKn6ylLIL9GZzHvg?=
 =?us-ascii?Q?qNmTneY+rvdn/TN2lwj/9Qu4n+Dbc+EKD3G0t/2lI+7ASxMUYeCOPwO58xr0?=
 =?us-ascii?Q?ZH7c2STCbUxcj6AcjPHE805j+DsBMHBq7MpwhJaqb/F4kSjbcgzkhkGvS+u8?=
 =?us-ascii?Q?FFP1Fsr7qWZWDGzCEB8IOZN5Wu4dY8hzUVCSCHUJGlQNCOdv3zEtlU8N7mMt?=
 =?us-ascii?Q?9Zhy1plLNynEBjeb+GLndG7jN5kkjvt4UyPzP4hP2O/+lRic9FEl5lJlI03X?=
 =?us-ascii?Q?QEvwV9pN1Jjq9zoSn6klJ7d61skIdFHPfP8z/adgGa8E3H7CIFPm7+TOJvnL?=
 =?us-ascii?Q?M60hMSHE13zODOIUCCkl3oU3TEPTTQ4twyl/KCbn+dxXOsV7HJ4z/4RdEWOr?=
 =?us-ascii?Q?+xMfB9bj/g80+63Kkvcv0U1KAfsC8tbFy8h5TIiTI3vROfedf4jYP2cfV+oK?=
 =?us-ascii?Q?F7M5lJi4a8j0pl8V0roABbMu1fi2xWUFIlTawqDGWYbwDoU35ooNOP/OnHV9?=
 =?us-ascii?Q?PnuAtab7K7fVEuEpwbVsUQ5NzZw161VdE5nv1P9FWAZESd4nOCwZPFzsLv0Z?=
 =?us-ascii?Q?mBCKJgi2mADENn5690BMkyEm3lyDnbKbqRcpRSsUrunwrLdbAyOreaDm/RdM?=
 =?us-ascii?Q?vCHljGFjZmkj6x4NDXVe0gAJz9+Q608e/grJvboEE2RORS5DNYrWVyG4/xkz?=
 =?us-ascii?Q?UpLd3BPtKTR6JSX0GSAIxWH7p4iN+nFgunK+bCKV2Z8IMuLtA1Kn8O+4J3w5?=
 =?us-ascii?Q?Y1rzMQka6w0JsAy1JvgP0sJfJYWY8n5M4PCPcOmRNsyBNDvpTkNlINaWPwbp?=
 =?us-ascii?Q?UNZURdMtY0lFJXFV9Liw4Q9+Y0XahIg+aDCNHPXieUB3inGJ6sKyU8dQdCvg?=
 =?us-ascii?Q?MRqC8yk+5xznj3pKSiy7UQMEbMnkU6clESo1NG4stQZOwc8VaMbRzKDhr6J0?=
 =?us-ascii?Q?LP7VdhlUrV/1paErrnvHzvgd/nAKOQsfwFXv1jxRb/tOglQKt3Qbf9L8eNAV?=
 =?us-ascii?Q?eqNxDdqYkpbjZ72hS1ZsEQWQ4oqX5z2dH4pFi2xMCMmGSjakt+mTm5xhLKEJ?=
 =?us-ascii?Q?LwsDw2d90Cjsl+PHyqs+q+izSCm+lqG2UdZbcjvKAOqxNTfsEylmoB0zJsIN?=
 =?us-ascii?Q?oNntLspzkJnSBnq+Jha9npZoKpxv3t4xdLrAFWxbTEMtF1aU8+z7x8HnSpKB?=
 =?us-ascii?Q?VGUTF74+yj9cssCHIb0J1AsD5/zBIBoMLwNxMeQZ1JOPXm3NbZXpxotJzZg2?=
 =?us-ascii?Q?4OeyTohOp/WvWIj31CcVC7BYgq/5n7ok2PnXSOxxJcnYkdOVS78DGkua4naJ?=
 =?us-ascii?Q?wLdWX5RvEQKnzknShSw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1fa0f7-d167-4a3f-1143-08dcf82e55be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:28:27.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnXEk5PMVLnxRNemM8W210b76osCbDcMVRC9zvpKZyRlXXQ4vc2ODRbwm6sNHDmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

On Fri, Oct 25, 2024 at 04:49:47PM -0700, Nicolin Chen wrote:
> Use these inline helpers to shorten those container_of lines.
> 
> Note that one of them goes back and forth between iommu_domain and
> mock_iommu_domain, which isn't necessary. So drop its container_of.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 75 ++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

