Return-Path: <linux-kselftest+bounces-35091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F78ADB611
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3654D3A49FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF7283FE2;
	Mon, 16 Jun 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cayNwywZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802E19259F;
	Mon, 16 Jun 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089845; cv=fail; b=FX48432abSyM9IJHca+OJj8Q82rdfTX6PZC54TzKbJjwHPhGP/ijyR0niAP0d2Og4GeJK5UAYxSTYRZmzfN+DSsQ4YUvMCwCXb5RzdOL3n4f4dYPChUGO8lcwdpeqOG4tXbmc+fw2WrZWREHvfYuYiEIjIw54MINU1M3VKNjkuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089845; c=relaxed/simple;
	bh=mHkmLUOENgXTa3v+U00K9TZHcqWbuCaR7VEySrsJvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEBU5yP1lgpVdv/nLIAPEmtkipAzvNFIjmQQkifS++Zh9FsPMDY/zrDQwaNJBFF4EfTTJE2e7RHHG7i1n2NpYnlrGLKxQn2ziQ0PDMYPNsR4+GXNTSpwJsVPS+gy9xKY0/pEWyfJcfgZL8efiX+W4klM3G68LNFHb4ZHiGOEaFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cayNwywZ; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZc+Q8Q4YY1OJ97w8M+Qo5NkGrLlCqaslivWK4Fh9CfpcfMwoxYVrze0QGkxWpSwWhX+OkuCMPu69fU6IzyhX5C9bIRuE3rm1jKRwyg74ttMWiyYLvXT+gCLPWpMh7XoNpxgRofjSXowIFqFgIqBrQd1j0wx9U8HQwNVwJe/c4sCi+a4fzKFSVdLObeRP71Hwu797tRLcMXyA4fQgU3LSHMDUvlM23lCagyi2YKDrXYx9bekK9VY1C+n0fwVj67w3Pf596XHkuQkP8AojMFeyQlFFuYGV7LkB7lgHlXhKmvR0eUamNwWPhNVRAHE9IUDsEfvhP2uGSQx+j8f2ro9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytwUtg8g0nbFsNGvDxEPl5sooHYsGxyhLMvJ50JFIQs=;
 b=nW78EImf62hhVBpsOddPvrMBAtGQ3x8hPI4z/9c//TresOguPPWCfkIwolGmDtZ/Bg8sn6yVLUtQvsMkbzM4c4Qzz6JBsWMg+EcSMTS/8TZac1Fn1Rawc+wq0wF+tP3j5TPEWSsg8UKZEfNQpOrq+MDI4UaZHyhJNjk+I/ZXZrL+NowkWLVE747Iqy4hbIGQUkvBpIA1HStgOVDbE6Ava767BuH8lxFZPWQcARQbqPn92wg2JcJQZMZirSnrmVlCX+EqDhluHbLf/iV75VFs03SMMID2FyH9cyY97kfQBwrG4tx06vz4zBAn7lVekGyZUGx9bRtJ8tr+wQthf1Xo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytwUtg8g0nbFsNGvDxEPl5sooHYsGxyhLMvJ50JFIQs=;
 b=cayNwywZE5BVaq4SzQZN8BvcsB9yPYBeqbr/sze2MdgCXuqbZ1hHegX9uaV5Ku4ZTIBxaMCiygllf0NzL7N4zFyHw9SWa/+94GzJAepVUGicKKlF7lWKJGaU77eDHodlZPqomfUiUNoHwwXDserl2XMuz8+USz+Q8n0y/+tAVw5dlt4R7T7zleuh+3Vw8ID+Sb6JVJ091QM3ZbVbAHD7nq9bF2Sk8nLvxiXgbuKcnkprL0s02tv5khhIDv7u+5p0+81FSbeJD/tt4rBORFVi8W+LSKufUYayl4BIh1y/nwv3kMplOmDQjHhumz4RdW7dVHdnErvF6hWa0czVm3jzdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 16:04:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 16:04:01 +0000
Date: Mon, 16 Jun 2025 13:03:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 24/25] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250616160359.GM1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <f13ad49a67774edd3578b8dccb9f363faa2f1df8.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13ad49a67774edd3578b8dccb9f363faa2f1df8.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a673fb0-4114-45bc-e48e-08ddacef6866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HEuS+oqUBwKQRCtKj18xNaCYXMg8QaQ1PetN6Axaixk1gq81eZYE3i8RsZ5y?=
 =?us-ascii?Q?NC7BkEV2BbZPnETtmIp1NfAG/EMjrLXVCniYqROIDhL3Fv7TQX20IrYqXZff?=
 =?us-ascii?Q?8ZXYDWKWwetFiqueK49idZkPz/PK2dBtJ6v8T24ByTqriwNY1z7aOuWOlju0?=
 =?us-ascii?Q?xzpHrN3cwk3pgqxQGsYjM9bIK6Zu9GtbibRKJMyiMQpPUAmA5QnT/2fIQ2pl?=
 =?us-ascii?Q?SHKyLLmttK4n1EQAxHXwbtMUf+ddZOZEmm74gatEMDOIiHRZk7Kt2GlCXPNp?=
 =?us-ascii?Q?rkTG2PxnE7ecKxNTr9OzQpL4aQPoXvcUJgGBe8HhEGSLXrs107nsOPecfUwI?=
 =?us-ascii?Q?fhawUJ7ueYJ7sX7ybj5jWACOwlW4WqF8t0HPCoMpEZ272TYqPB7Z5RiHWgvn?=
 =?us-ascii?Q?BkDkKhD2BjGwGQRCJX8wVri5h1z1RLHhr6T8/a0aJ/UZ+UcC7W/7g/jNzoyp?=
 =?us-ascii?Q?eWVTZn3CH1MKxEynrx6SmrJzru+JpISs+ZSWwQRjkaqqLlP+tNEorVbmXZMY?=
 =?us-ascii?Q?1Rg1ybyRp77f5Io1JnoJBqEve3AkJnrvpSeoMNtTozBJ5kH595cBefrWOtnD?=
 =?us-ascii?Q?vO60+W9tsvNK3ypZWZgq3OgMLPYPDxs0Etlsj9qGOqJXuEN20GS/6IXHKdkL?=
 =?us-ascii?Q?XdNzQgZ1YZJq+v87MNCVo57w3SwMSCZX5cNKVpgD77uoSi37ASarhhGlwQlt?=
 =?us-ascii?Q?Brrd7+03GDDqqz95+3bcA1evG9G8mUJVWKbTdYT3tJId3RMwyJai4HuWeADs?=
 =?us-ascii?Q?vl7jyAWt5Lz46ItC1Z2ZzaGLBpUVyzVGbHAqHf+5M7X9ZP/zW4ftQVO0IzAp?=
 =?us-ascii?Q?8ygaFikQNgnTqfFjLe8ardMaiAs6YRIa//h7mWA/a+jqf+R7ZB1ifckCE2Ve?=
 =?us-ascii?Q?0GKdvAyR+yJw6kN+pGlr4PrCN87KzDO1S3xMZjFtWnxd2c7NQLIAuFV3TDZz?=
 =?us-ascii?Q?tCK+8A9+wSky2FPTng5K2yZZr39rYKyYaF/Q1QhSwauLvFtQ4279h8rtE4zJ?=
 =?us-ascii?Q?Yt0kLLvdX1OsYHt3nezg508ZTjFqAANuNlnWaYcjmI9sFchcI0ngubQLOvYf?=
 =?us-ascii?Q?Uw9OGk2DFLP95dDFthcqrSjnL+Pkt0pDFIp+i4oMAW+YQ6g4HXw4By/wRf6r?=
 =?us-ascii?Q?2Idb+9kMaFlP2CCRz7hDGr0Zw3oIzIaq6bUiqlZnq3CFpMEcbvP1un9A9ae8?=
 =?us-ascii?Q?zxerJHvOEs6NmbBRxQIhyB42JSE6KPuJPvk6ZKmL2WB6xxmxwpGOrc1/4YV1?=
 =?us-ascii?Q?wX4gexJ0RbTzIo5lttkeIYk0K6XlEEtiOClycGQGg6bsSg3gXe7yxXNxkTdP?=
 =?us-ascii?Q?M64pO2xNEoCBC67eL/rwhkbYdC4bo72nRoxAO6ia5+7oFzcht3xgwjMBXakg?=
 =?us-ascii?Q?NppfIDlzpqcv7FGZjzpgWx9CGKDAdTbaXcUj1Mt5poqlXbrWMzCdJzBCpUbn?=
 =?us-ascii?Q?xqA1Ufz9BlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYTT9n4JDsZ1sQgWH+07u0I7dHR7XGJuqTKyMrRPzshGAygjRh6E1Kin+Ii5?=
 =?us-ascii?Q?lvSvHZNMrFKiVkYY+1mOwGfUoCdBSeV7aySZ/Bu7Bnni9c+bcorVULaGT7Ur?=
 =?us-ascii?Q?iRCd7SvBMWOoezr5N/EyyeX4bEoP4JliISZbu726NcKMFf0KsM+ldt7uZW3o?=
 =?us-ascii?Q?8AbmyoNKSaOgU12nhgSmfSfr6Wz4PWHraG6bMcZLDsdq7nFN6baSxYfDeo+P?=
 =?us-ascii?Q?qin00BOp8IQ2wuRj38a9PyVpupHQNdGi8jVuLyi9r+RWlUsWASqla9IUvJ2i?=
 =?us-ascii?Q?bQqbm1hIjCrKYPOeRpD8DbntTYOH1ADTHWeK9d9X8bm+YUJ8gKHtriibvudv?=
 =?us-ascii?Q?Mqe7nYxLvPs6dRP+XKT8mM5Ngp1dhWiAuWI7p4nzh9K7W8G5E8dWJNrvEfL/?=
 =?us-ascii?Q?ZnIlAK4s3Cff+95olXB6/R8+xYYqrGjv6S50jf7EInCpjqrhzanYou4/ocHM?=
 =?us-ascii?Q?1Xf8e2/TK7r5TxVIChjm5zD7pYdwDHNlq4cdOk79K3HtRGpwu7OYhprlTtTk?=
 =?us-ascii?Q?swvxydqKBzgLjrJ5jXdMvttgiLZO0wP6ClpcHQSYnhqKZUGOV8tsM9zB64MR?=
 =?us-ascii?Q?dyHOga8f0L6cN8+dS8zCTDZqKEhtFpi5FO7RI67QQXdt9sM+ute7tp8TUpcT?=
 =?us-ascii?Q?+Eh00psu9kg1YEIsRnT24T5h45jV3ccg1M50SwMyC7e+jdfyRhUNpuWIVAdy?=
 =?us-ascii?Q?8V3LtzK+WSUK6+MqYaya+sTmN44veBQ4GWLrpo6x+ZGIX970q2kh4IptiXtn?=
 =?us-ascii?Q?HXq9pSok1xywkJJfvDyQbHAHzkYWfuYIb4njTy4r3Ph2cGbYI3Q0x+kvBAe4?=
 =?us-ascii?Q?aOHR1bRBdkDfTWIKQK4NoqpsTXQGeHYNfD3HHcm/NocLXs7taOjEeE6a/OVF?=
 =?us-ascii?Q?AySSIBYUseAvifNWSMVy40APm17KTAN1fjFIRmdMoctGmOnwg5I6YCvKtdDT?=
 =?us-ascii?Q?WlKp84SW65hCjqjOR2wy7NjNOQtvwRYQ0UcAL3WCBbEQHGkcVh0SKEDbEuh/?=
 =?us-ascii?Q?zOnkoSX3wOqXOZho3CvuutD1xNQJ8IvTC2Tss+i0VyTQHFxtS7lHj/N69Gdi?=
 =?us-ascii?Q?ucXGNFL6dTz0A0ySuqcUM9DUCbb6yCJuIOHSeUw9WlVvYGocYNiBeOqoBW1o?=
 =?us-ascii?Q?W2K6I5HMRb/DLTf1MJar/ZjHmAnNJkXEnjhnsBAL+a5ckocPlN493cCDAz7y?=
 =?us-ascii?Q?IK6qScgzCYRtmvymWltO/6aeiytBMVoFYD6WiBs42EJfiHgtdZVgFjZxDBuY?=
 =?us-ascii?Q?eR0fsXGadq+xgAv259vgLhuOe3m7bqaqNPeyraPBxEFDxyn8bsSm29Hes2nS?=
 =?us-ascii?Q?kn4k/axUIxGZXhPBGQSy45PL784YdxyXfLS4iNUz7p8RwulSX+hfgnl5Id+b?=
 =?us-ascii?Q?+2ZCSbRkigQsLY0hB3Eb4dansZcagMAoHp4ynMu8b6wZvE1qyPYNrPVTB7Zz?=
 =?us-ascii?Q?ARN38OhaHQtiFaFenu0UHStGJXxnnfm1Tvc7Rb/2dd/Rwl8EPdMguz5TT2H8?=
 =?us-ascii?Q?rVpMS0/ruN3ZtjPyo5J+WlTO4/aSktlsPwbuPVbld/rA12t8R3bW3qqWnZ0B?=
 =?us-ascii?Q?M2wA+m2iCBp/ssOG7OAc6Si3wWIAsQ0+AwEqPaON?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a673fb0-4114-45bc-e48e-08ddacef6866
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:04:00.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5suvA2nrvwqenwWH3gSto4WFl0verP9e06HFA0SXPau6v+sNgMdZtIMiUOrYXi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

On Sat, Jun 14, 2025 at 12:14:49AM -0700, Nicolin Chen wrote:
> @@ -671,7 +752,13 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
>  
>  	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
>  	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
> -	kfree(vintf);
> +	if (!vintf->hyp_own) {
> +		mutex_destroy(&vintf->lvcmdq_mutex);
> +		ida_destroy(&vintf->sids);
> +	}
> +	/* Guest-owned VINTF is free-ed with viommu by iommufd core */
> +	if (vintf->hyp_own)
> +		kfree(vintf);

else ?


Otherwise looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

