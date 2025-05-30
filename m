Return-Path: <linux-kselftest+bounces-34078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD0AC9464
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4299E4633
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91823536A;
	Fri, 30 May 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tw++u0id"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B41D9A70;
	Fri, 30 May 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625059; cv=fail; b=IukWhBpisW6jUyn3vegL/by9Y+SeXuhriKxjLfcHNh7cmI2tVXp3rtJyetUtBjhAzNxvzbwBYnqq2ivzqE/Jve/yyKhSZg9wSFTe4LzbN7G78N2wKwgGE0iu6PFpXOLr477mf1hSiEudsCPR83dM6l638XvPIWUQ/pYQBNFnEKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625059; c=relaxed/simple;
	bh=SlcMPAxQYdFcKoJmQc2iCYvA/6F08QWB9ijZICZBS+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hs7QXmgVjVnEB43rxAPGaMUdgECHCIlzbOaVmwhJpOsfAK5DJbIlXSCHNy1zbel7Yiz3qb+zdmAI56KdQ0nSyjz4YKgZEaM6sK+FOmu8U3hmRSU7Lfqc/D2rg6ZTmxRZyg2UHRpOx8Vst9FgSjXraPytj52t10VgqX4yV9ng1lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tw++u0id; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJYca31saS1lN8HN2xuACwwWwm99HUUCQdf8TT2fJ2QwdQW8WEqZU1u3NlfzBeiD0wR4U4+nWDVTr856u/mVf3hB/fjeEjF7mXXaLPT8M1wcjuwlg7m1nwW9kx3orFyYonitBuDtNCOdHP2+Z4X8i8lAb9I3O+9yagQo7kCpxpnvz4x41AGtQ/8KnPOtcABg+hkxijmTScco7E9G9Rizr5VJsE0IhScwoMn+VeonSaDaV4wl9V2q2S4d2CNgHlymmI4KeKwgnRYp97I6QVfDTUnjh+NmNY/+1PoRmtR0fxiQv9/uVCDziw4oxRY2AWB0hFsSE827nyJSo8pLoFrExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk0zYyshgngyjpVm+Luzu6lQPjTVH+9qRbH6qEE2nNU=;
 b=ye6BDHryU3p4wkN+eQ2A6v1PKnUtY8janl98veJKqVvjv/GVCaY3TYJGWuitJxNGyjTeBOndP5Fb69pdxfrOatk1kZs8Xe/yDI0GAfPJbUE728FgYjo53Y715l+DDohC6Zvnh0diPQ3h2tcbrxyCMoj86Vyw3vCnPyHSypNegnxYTAnb7CjKkcJiAZid4/0CGNbUxHGfqbv+OW4iQVF1IOIEOdzenyTMsZPtBl9aANhNOBcd2fUzxxQkEEvQGcsuUIKdu2ciQgeHiK9iAGfO4CO5aqussfnkYezt+Semc1XDLV0haL8iYUtWfM0qW3iy9N7FOkXmohk5IYI0tCq2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk0zYyshgngyjpVm+Luzu6lQPjTVH+9qRbH6qEE2nNU=;
 b=tw++u0idfpD+ondFA5TY0XtveM3tNUeJ6GmcmhrPI2PJrE3TwZqQs463vmpLXUkm47MruHrmJP4AgdqzvJTnMWhiA4G4Rq9Zj37MKQDSmf9g7Ca04oJD3FZhTO/jxPyTNDJzFoeJmUGFk2dpMXgKk5/PD7QSGmQ1ActijY3qcMG5nCofPjopoivbXUw3gPbftNz/2eur9fH6gl5bxWs65FqrfKsF5XmEJhjycui0FFfOfl9t0GDmse278iibP/nplKlhEwLvdk5AiWMUfFgQF5a15CPFUdURSxeDAv/OlTIbNIH+6RgxHIm0D7le+Gqxi2qbHD7C9I3p40VGGFxJ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 17:10:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 17:10:53 +0000
Date: Fri, 30 May 2025 14:10:52 -0300
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
Subject: Re: [PATCH v5 28/29] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250530171052.GM233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <4a84673ef6fe040f1b551d059be466c2c7bdf2af.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a84673ef6fe040f1b551d059be466c2c7bdf2af.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 571467fc-ed5f-4c5f-ed6e-08dd9f9cef42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?liLkRQCRXAqNZrEqlt2dxsfHfYJw0ZWgMG0OGKy6UQ+8Lh3lr9zrwerTi/Cm?=
 =?us-ascii?Q?n0IxaL5rnEQfjJJh95YaP6+V0eHoIf7b5w/qPbdhJYmvxmHoSRG3Ckjxrimi?=
 =?us-ascii?Q?cGBysvFdRPJd7YVrhkC0WiEQfPXTCqKJBcPW3HtYCQ2YHrpHnXHTvHbE6CtP?=
 =?us-ascii?Q?XKAcfRceETtl1mb7/MDZim5JOSgi6GLm/i16EWVuPRNNdWs7vYs7t3ZAoDj3?=
 =?us-ascii?Q?q4qhX02RqSZJuG/E6GrumTNwEoe4ApO3j3CWMkd1asadNjKTXD1JjDcV9PFa?=
 =?us-ascii?Q?EAX1BlwyfTbeSEUVooOQTQRnH93uOhxaIPd0f/qu6BxXKhZ7h386MapvdSi3?=
 =?us-ascii?Q?mSrtylI7R5XqTeHjcFnHKf/9eZruO13kxCQ5rZuJZlJqd+VNhXAkvCNxh2f8?=
 =?us-ascii?Q?hSGRMdnV64x7bl0glY4RPNwfvh0xHHaLDa+W2GamcsUkgLFyyCGwzoAB0lvZ?=
 =?us-ascii?Q?2AlKzBgOLbBLa5TloU7/sAcXoR20tlfXnc5RuJk604cAke4PZtmT53Ij944F?=
 =?us-ascii?Q?7UbLagoku0TPsdCMnl1lr4EEb/VZIpWWoslyXyCPOPDnSQEU5tCwtyWmlEXl?=
 =?us-ascii?Q?1tmzMaUbkE7Q3HFKNGvRULFc12fWY0yn3z06ulBUMfaFdMg6qLHGFpX7RhCb?=
 =?us-ascii?Q?wVv3I/EO5AGanNoVEiFoIqG5mQjjESHgkZ+KSyXcNuRBerLWy1TLWBefP+hK?=
 =?us-ascii?Q?+C8eguppYDD+Q2IinbXePeMJ14blWzJz/v1k9hr1rjpV5hrcebqdHD9V2kQK?=
 =?us-ascii?Q?4HC4Y2QCSmT5Xu8Ia2x5/KX1za9soAb24+pKHQPOuwrWNlZGJJkgAnpxKvou?=
 =?us-ascii?Q?54RurZcRfo2Y6nzyc5T7SSbx38OHzQTlnDaFPPt8daiTNoMgn1kF/VRdCsMj?=
 =?us-ascii?Q?XJ1qYMCuDux1aW2YdJ4X40ZWeONGba/PaGF2Y4L/oHKgylubfoU3VC6M9wP9?=
 =?us-ascii?Q?MvE8rWNoQjyr3ub/q2IGnyWL16pbsTJFKywEBL8rtFg1ri0P1wnXyH30oT9x?=
 =?us-ascii?Q?8hWGC7ZBPh5YymSIUZ1j2TZJfZFzhE6NO+P0NyQ1P3owWeV24ewf9xrxLRJE?=
 =?us-ascii?Q?bqjjP9rGmVqtZy+FBOnPKl2HpvAvQvl16cOHJwBm/zF5b7IJqMSREIB9Bm/F?=
 =?us-ascii?Q?ZHpG4Xiq5fVxzXRy4eguWVKP7GljQt2JmdxYUVC7lnv1TuAuklGg5tMIYj4J?=
 =?us-ascii?Q?Cw0tBi8vZch6ct4k8J9ajzt+N2N08rmhz4Ps37O9SbB8XjQcEPteCm9GsX9W?=
 =?us-ascii?Q?G/Ho3MNA7aqFyrByvtpK4ovb5pAUrDjbrPoM/zKkmh5E8hsHY+VbN2Oti9IN?=
 =?us-ascii?Q?mthaEKI9x2fZjbJTzIr4asii72Pi5UkOtI26hw9aTlab9QyghEMMSvAhnaHR?=
 =?us-ascii?Q?2fR60vfHVJGz57XChdQcddL0PEZECteTaFFgKkOCWthNsV53tHGFUBcQ8YGe?=
 =?us-ascii?Q?vfO3xCq4k3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0mpz/Ntmy9H88VaDWgTYbxLBE06PdkoUhJk+66DzB+XidYepX1smCVAkyYS?=
 =?us-ascii?Q?A4IpKNyxRXPhx76Bx3YcHJz7LowChThmzY0/tyBuvwfAFYrfE2nUmhKHNSfL?=
 =?us-ascii?Q?n3XHAKTcutWGcKk7YXut8LOG+FvoJyU/EQOJP+Y/5YjCaYIF27luZHKPlXg2?=
 =?us-ascii?Q?StKx3N/zbjPyMy8jmOmKrGHhdOX4HL0hVTerYXx7tPcphXQjiZcxIHSNqUrB?=
 =?us-ascii?Q?146XWcF0+qJEn8eT4BOpnQIb9iOmsUyJwvDIF86ErCy5yT/FyKyX07QFPHOz?=
 =?us-ascii?Q?FuVF06RPu87pZ0Jn5AN5BVOUDaEXUmA5bjbOtjDqMgElvQXvkn/FIx5/gPDy?=
 =?us-ascii?Q?D4mdfaMELuAJgKgDn13sEINoVdR76/OClju3v9tf+NyEpZRo8yDUrVP8Bd85?=
 =?us-ascii?Q?UD+Y6fOA0W/zmhuAT4Xp2lMtPrwbQw1dCfzGtw/2UqHLEFPJp6rCummjWidO?=
 =?us-ascii?Q?ASDgJNn+5baKUBokuVzcQ4OqztYKm73ve3JlAQPoQQpsXFmmKJqAsHxEp24h?=
 =?us-ascii?Q?XdSoZmJ/Ia07Kk4TsKV2icEBUtDdDz4YII9oUrxJak+2vs0YF0FCx1hlgYwU?=
 =?us-ascii?Q?ETCMvd/E/DRE+kcohTIx0+C1Co8qn7Xw9jsbWszuGQCQ/iqDxKCpjywhEJZp?=
 =?us-ascii?Q?zkovIo4bMRbMM4mIoLnCIE6wdwfFXcrhqp2jN1/Rq8vKQ2EEDqYLOgGBBUbo?=
 =?us-ascii?Q?IVU5u6gdJt9eASS72hjNEE1FnGI1J6kc3d1TUskDzUJQRskMYRnTOFrVlJC7?=
 =?us-ascii?Q?eIj+HxiFl9gQCiajdrBgDU2RQdabl/wIGa5Ot/kRXPPr+KE9U5JvFs893RXS?=
 =?us-ascii?Q?xw4vRU8ltICMfsou5Up7NprvLNuC1bwCHnLkBbXqge0pPb5mWQoGHn91JC8A?=
 =?us-ascii?Q?CLEJFNPgQG5EyOMfC0uaN9Ep9lHE6WkU6esfZoq9HXsAujR39q/vWX6Qv9wd?=
 =?us-ascii?Q?rUuHwFnQcmetUCkam9/C0R8abuKuMg8FL+UqbsDAdrWHtK1AIO25kidXHFo9?=
 =?us-ascii?Q?0wEp6y2du6TmYZsiCV9B+tEo6blwVI34c5xUs8acBTi7QjlpwG+hEaMor6So?=
 =?us-ascii?Q?GHPF964IXwRnLXUQu2alFyl+wLh1MrXVrxl4Giu0qRkpeORsZ7+DxLC+R/I6?=
 =?us-ascii?Q?0AVhECOr3BwecBkIUtoHRa5duxSOo2Gs/3ZXr5oX1gPK3s1h6vSIdWGgbZGJ?=
 =?us-ascii?Q?BOLHZQQSJaJA3H7lfu36PxMQvXqr6b100NknB6iu56zekpqI9YjItYxgSYg/?=
 =?us-ascii?Q?NAW5aJYIvsVud47C3xrtvrjdXkogzcMy+F9SjdEWiTJKRRhaCBhdA9Xy2Xks?=
 =?us-ascii?Q?ULknw8KRz2VujSx74PW5VqzXsW/C6iW9ev1mwaEu/QAeza0CBX3LO4YXNrK9?=
 =?us-ascii?Q?JCpikRK+nUCdqfA179kEY77tjkafLiMEFMlnH93q2D0QbmS6WvP/Mdlytn8Y?=
 =?us-ascii?Q?g/vt2QJcZTKHkr+7TEhV4tJ/jjqdzdM1oasaAPJCa5xcMeIzy1vrKUCNUT5K?=
 =?us-ascii?Q?8PwUMj3APj402NN00xeCbq1HzBL61ro0xxgP/ZoGFYJ10oRXiSGZjMoK4EQl?=
 =?us-ascii?Q?Tx+QnXbq1fy49XUmhZirBtZAjbm4iNE/5UDlhB1T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571467fc-ed5f-4c5f-ed6e-08dd9f9cef42
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:10:53.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD3gJXQG41sr4djTmqg5sym99Fsd9DCZzucIf//MHHdVS8S7MtPicpxKPKNv8+sp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060

On Sat, May 17, 2025 at 08:21:45PM -0700, Nicolin Chen wrote:
> +static inline phys_addr_t
> +arm_smmu_domain_ipa_to_pa(struct arm_smmu_domain *smmu_domain, u64 ipa)
> +{
> +	if (WARN_ON_ONCE(smmu_domain->stage != ARM_SMMU_DOMAIN_S2))
> +		return 0;
> +	return iommu_iova_to_phys(&smmu_domain->domain, ipa);
> +}

It is not allowed to call this function unless you are holding a range
lock on the IOAS that covers ipa, and this path does not.

This is why it has to go through an access to get the physical as that
has the right locking.

Jason

