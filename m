Return-Path: <linux-kselftest+bounces-26895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D900FA3A656
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236461886F06
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BF1EB5F5;
	Tue, 18 Feb 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E00uKsO5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100A17A314;
	Tue, 18 Feb 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904755; cv=fail; b=itwV4BrBXrMgmniHUn8WZFCc50cN2PlgO9wIluomS/gYGnGYUiGd2KHRwyYSHcoiOypDT67Ju4DNxHDS2JSm7bVHOVgLBVV5HpwQtZDYM2x1jwIZ9mAW3aqnPP7s9PFnOlvbzmkNKtA3uu18mUUN41R996Kr/wmn15PZPRzG0Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904755; c=relaxed/simple;
	bh=Sgirgjm0GfgYCEJYf4FKcTvjOoLKOITVJ9vtWgRmWUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZqwEZeIZca3/lOSja01g1DePL4Vmxta4rEOPeYhV+V7pZN7UFDB5Z5qmtCMQZWYl0IhI/fm6C526H7WJGDlHHhD8CKZIFVG057xlc5X1v8Y3P+ZZp/E8B4wedF6BTmb+xCG4YR6m/3B1003jZ8t0JRWEoalCEQFqvD81qOznkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E00uKsO5; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQoydJQHfvNJb+zVHr4Z9urrk/mZWddtUK2cgOtKS7uF5XtXFIdAB6BCgCUgUuQrdUl8kjNxut10tmi4EIySxHP3VosqIM3Cco2xLQlwTi4LgnLZWC3DokQQAv4SlxFfSoNT7HH9jY9ZY5eGeb+4IeGG5m2F+5BpgcbywiwvcONYCO7YiYa/MBwsXbiqUhcfEw0oVLJew7CVt9T7wzWM/AZnQHnDwAOLA/2L1fBHInNoNJT/3w3aCPS3ND+QGzAHRtolzED9LbTfp6B/96j7yBtByDldyjvGNxGgLrqvO50ipr/2U6/MX61KfXy6WnYPnivl4p4szfJ5iqr0ZQg9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX0XYlk3ppR5X1QG4gJKujjUF8YDas1XWY94eKkegsQ=;
 b=cleMAblxaKLRgcXFGLuqLY6xcvdKxB7OPVL4QZLMSymJGEoN3Yl7Vyykrzqshq+O2eeJVTAFnPWrpcPZZQaaSMVduk4do0pQ7bevr0x/yDNcNV9JaSlgiNPJSqF6wMvF7loXi8ihI4dhDBb9buJ5D6Lp+AWYWifB6nsG7s5Mji2dSCYPNgjd5XB3PDOZyShu10X+Qsm/cH16Upl2lKwdHe1Ip/ZK7Mb8UBDdg8X5mhKaiZaT+3llevlg3w9AX2Lpke6ezyDugS+NRVZLcfBA0dzIoTGOJE5bQKX6zPLzmXL3qcqg1K3poZMBoCV+dAWQMmZhvJ+NDPxGBWwlfVPSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX0XYlk3ppR5X1QG4gJKujjUF8YDas1XWY94eKkegsQ=;
 b=E00uKsO5Xq/9ZcePtRa7i2KanPlxyjGJynI81/3gKOAeQWz+sQ4YLe56lChLj77B/PCUIXUFAzj6PmoqA3q4DuIV8LvUWQ5dkp+RuCxSfhEejLT702i9ihc7wDvMwhncuPjNpxS7zXPnEpIjE6lGN0QqCMdr9gzo4MOQPx77Z5i2Yxzua37txASp4Xz514WSIS4LxT8TVU5JvLC7GdiXJHtVgha12hVLSrd+A4G8EUzH3uEh1YXx2s+L0e4MZiaLuLAVIb65AoYmDiQ0hz8E69ZgB2+KqHi4NvSj92bEz7FF7WW9xDmG9hW5gspzYzbgZ1z/cj0mMUhaWJDYMUk3ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 18:52:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 18:52:30 +0000
Date: Tue, 18 Feb 2025 14:52:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <20250218185229.GL4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TOq-gIGPY_ztW7@google.com>
X-ClientProxiedBy: BL1PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:208:2be::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: cd89a9e5-8ea9-4e62-1875-08dd504d65bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psMSQLg9tcn8zUW8HmamRqt8/AEt2fIqS0fuWn6Ncy1dWNawu3n11iovee7W?=
 =?us-ascii?Q?hADR1HtWgaPJYCD95g6RZoHRSa29/z0cEIl6G7mgptBKh8YNyXhW6gDjouWo?=
 =?us-ascii?Q?jyZi//IRCqRgqhC9q1/KRwvUAx7pAwcfK+dtxVBrWuyTvStVJkt6/HF7tUrs?=
 =?us-ascii?Q?2DS06NBOzJjw0akcZNA8KC04G1457akq78ennCDr0z+t5NKmezKHls+lHM2L?=
 =?us-ascii?Q?PAAYX0Bq8xER/IafeLUPa/YZdxF0C41Q2AZRxcdCvHLTNSGa8vXrHzESpIs8?=
 =?us-ascii?Q?vxJlF6cNy12haQmakn1p182AluXViWiwb7Had/b/1xAh1vYYYBGOwtemGoT/?=
 =?us-ascii?Q?y6RDM4sOpSRsuyJ76H/0EicdY098DlxXrVJMTBn9a2Fbg9ImBHDO87YU8QYi?=
 =?us-ascii?Q?ZqjGmv+5PrJ7wyCpLZ6M/7ccWYINhf9dFKDUPUTKXk3nuHLy81+0cXTUWWry?=
 =?us-ascii?Q?v8/KKYNB80zsi3T4mQlobNjFyCM1tu4kA467uM+1ioJjlUFXOpYyqja0Q4j8?=
 =?us-ascii?Q?MJN8oed8H6aAMaz9A5ll6Ded2XmOq5axZs0N0DP28/3P8PHdDbxKWA4O5g67?=
 =?us-ascii?Q?FzQKLqnfFiQCIQRn+AwM9vlo1rFxtio+9m6mgUC36ZhR4KnzWGp0anmM7PVb?=
 =?us-ascii?Q?A3H3lUFSgFmeXTdVGCXyISUEZNP570L6DsfcalGY7JlzOlNUCCW24Vt2MQAF?=
 =?us-ascii?Q?5ttrjzUSg9PC7UaN9yUhNT0+geODbK/aYstE/SnErp2/yoCg0+J4/nIATgeR?=
 =?us-ascii?Q?tjGoGDxifXLRphLtFqhbutiBHI0p7igiW7tYnGEFbHZMNRI8HxT3fnysWvvk?=
 =?us-ascii?Q?A4BQRWlqbSzn3scdHu2nbGnuZOZ8fqLugOYMGzq52lquOWDZJsyT+90fCEVh?=
 =?us-ascii?Q?K8tcEqTbDCUjcv71eWBWIaXK+Jqv8J1pkrp3VNzQbqRiqoncYrXntN5cZcw/?=
 =?us-ascii?Q?on9gCifa5DOEvhJIpCKLVJF4NrUYg4nFhclgTPpz/AlpE4hzmGHz8OjcXZRJ?=
 =?us-ascii?Q?BUYozqh9qXZrOwKmttTmXLJBBsPbf2DDM8n4TE2m+gSkSRdvGP1bfKaEPRZ+?=
 =?us-ascii?Q?mfZ8tAQBZgSw/hfxjengfPa+D132d7MGL7OB+Jwvz89Z5m1h7i3gHqho+M65?=
 =?us-ascii?Q?bKFSMkz6q71HpqpwsEL3kqi0/ja8Qp4lo5MMx3UADB9M4BdjU7Tg5+bBI5rC?=
 =?us-ascii?Q?4y5I9wIRdOQV4nuKNVrDEsE5ER2To6TOvdRygfUcSMLiJcTCEuSVoY93XQL7?=
 =?us-ascii?Q?7bNKQPLAeeZcJxwjeisYvyYybguz/WoBWn7WdYZXbibP7Dcpu1fZBhCsKTX8?=
 =?us-ascii?Q?uhtlnRczB25618+c6GC2Jf+yavNKNrGr3xEfoSssXujLPagc402pg1VdKkz+?=
 =?us-ascii?Q?SlrZoRQ0ebMCaXDbV+XZ6tWBzZne?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5XqSKiOrvMIwj0DnwgLxVT0aGohDY4uNNoekFoLFjNld55ANZBkNxGTP23k?=
 =?us-ascii?Q?JGtTjjlejrlmlcWEB4iW+qNFFrEC0Mpwf3qkb6XF9lwx3syFF31OI9+tOAsc?=
 =?us-ascii?Q?fNHYgAy7hipuXcSt6Cfko3fvK0n+1yObayWPN/kOf66DjdRExbQoi/ySOBQk?=
 =?us-ascii?Q?wwCVJ3s2yiwIG/5pUS9v5vusALOo2nz79oC3Vq+Xwb3snas+NLCeM3ifBFx0?=
 =?us-ascii?Q?C8Q2wiAAShu67Fkt0ftMbJ0EeScyzsou7tygICBgSeZAo+ir7vcM/KebZ+rR?=
 =?us-ascii?Q?zmjiTsUigmYX9ULcnC1KLqYokltQKD5gU9NAUYQ4evmYMZxAsh50l/iz15uH?=
 =?us-ascii?Q?IgQAQpajb+SD8sV3jg++IXlWPCL/2KK1xF5apou5tJ2mN9A2OQmOt2xl+QGo?=
 =?us-ascii?Q?XVNaXpnCQPp8MFKCOG0CvButZqFQUW3GOr0d7r8qCIHOpK3z005mwZ5FBeYV?=
 =?us-ascii?Q?ofTPDyVvosSqUglEaDT+2WPHGsn2yf/EaNEegmu+J1qxOrkWe6pFr8Nj72bF?=
 =?us-ascii?Q?NoLWAIm2w2f6XlUhNTatMMjmENhOAG9eO0sznMtTZGYMwd2ukRKuyM6hOt9R?=
 =?us-ascii?Q?0zochX6nLRs4OixkkMAPh3Wh9oLDoovn6LgP7tBur/Nf/kbUd9T530e9wc3x?=
 =?us-ascii?Q?G/nzwBmVtKYrBv0Kh1jFfg0vmc4eiz1vxov7S4RAKsljrtJku3moCPjj20lh?=
 =?us-ascii?Q?xvxkNIUlHF13S5L/e38/mImv/VrJG+WBiYi9vp4w4XSMUkjI8L9WYESnomIP?=
 =?us-ascii?Q?yi1ENlyG4uryU4aVfOx1BMr67BlWfVE4tcWzaPYEyk1feq/JbA67+go7ywDl?=
 =?us-ascii?Q?2sxd5l9l6J6w5Vdk5VZT6/KF4s2drPPKXr0Ahz8OvddmDfNfnggmLIuVOtJ8?=
 =?us-ascii?Q?n2soaS4E78GSDly4GtOmsUIabWM1Tlbxn79pghIxmuK/y5V8iCEOER78CFvr?=
 =?us-ascii?Q?hUWpK/EFeFSxkFOYJKZIC8iTmzzwcvxtp4LzogYsQMo44Nn5PfNY+X+OP7xe?=
 =?us-ascii?Q?b37HslJHipM4+MpuXMzUO08IBvPWr7dCyNl5nda6Gv7tr0/8ZmHtBX/9JcYD?=
 =?us-ascii?Q?A5AC9cES6YWHSKQREXzKYAkTgwy91h7KTmWhsmwuJUwt5khZrbsesKR6fHIv?=
 =?us-ascii?Q?RZDDJuZrdMaLFbmwjqscJLh6D45Z+mFWMZIdUeeebvNX+c9Tmo9VqdXTxMRD?=
 =?us-ascii?Q?5tbU3syZTLdLA7/1hJXWMTXZAGOZoIyi6niZrdX0+ML7dFlSaPAbzaP277wm?=
 =?us-ascii?Q?MclDxW7I0X7WfcWp8MJcHSFyq4Hfa7fjUW/qt1HqjcXveSwPO/ztakPs5N4C?=
 =?us-ascii?Q?N1ZUPW1H0/YMF6fAiznxo01LRzcJB2dZqbKRpwhTUGR6v05I0ia+GMLh1A5p?=
 =?us-ascii?Q?4yCk4VxiXdSnBloHkIcAKiGR2Kowajwot8HqPu2pw0xuzNPK/8POMqwAUQ8P?=
 =?us-ascii?Q?OTvYe4neSstxiJuIRuh1A1FTRKaiwOCgybe9qTSSRzOP8XCVq1W4S4nLPKAS?=
 =?us-ascii?Q?05+Hr+sRMAL14g7PdTDvaU/k5tOg0nCZWGj7dB4uqnJHdo8Vc1JBtkjaF+Fv?=
 =?us-ascii?Q?xdkjVcvlnRocV92DpStMC/BJ5xwbw0eUcHzfpmjb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd89a9e5-8ea9-4e62-1875-08dd504d65bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:52:30.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfRIWuCrSdpZ4cyaFUvIjgEROdu3Qvw5OIcBeQVwXl/6E60sQErb13yYIkhLXlNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

On Tue, Feb 18, 2025 at 06:17:15PM +0000, Pranjal Shrivastava wrote:

> > Is MEV available only in nested mode? Otherwise it perhaps makes
> > sense to turn it on in all configurations in IOMMUFD paths...
> 
> I think the arm-smmu-v3's iommufd implementation only supports nested
> which could be the reason.

I think starting with MEV in this limited case is reasonable.

I agree it makes sense to always turn it on from a production
perspective..

Jason

