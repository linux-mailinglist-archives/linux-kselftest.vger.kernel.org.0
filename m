Return-Path: <linux-kselftest+bounces-42590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8ABA9FFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9823C6A30
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97230C0F4;
	Mon, 29 Sep 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBHW0OO+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736961FC0ED;
	Mon, 29 Sep 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162650; cv=fail; b=sgQcX3yvimlNIjZSk04TaLP8Qcbh50J+5DN052LFzTsUqa0V4nijPsEgPgLGPKGSavvF13nOSp0dlFF7YQdo0sZ3Gpo4z+ryCBv8rb1fEhjBzFNjvm0GKG/Yzru7UdTO30bXMuZA+MxxamoeDsopeLRepMk2vAqgajmx2lGpadA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162650; c=relaxed/simple;
	bh=+XVDpvP0q6MTlIwFj0jC48/q0aMrgnSbQQZFLon3yXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9qjLrZR3w2gGQJsVYP7X1RONAIQ74UHaOEwB51KyY3FjiFZEC5BY0Q+GfEg8p24T5Lvxdh7hBljvk9TIjAsOHe91f/hMYi+av+JP6JwnPB+MOi+kKsxI5DA8//KNBxSiWz9JQ20giS33HdfBx19wIngEo6TKimem1ekIgapKa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBHW0OO+; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACAaXrZS+kxm5iyp/g8NzQ8LtxJk3eHrRcSPLAnGXGroLBUzQeuF4TOenFRM3enAXV6L0ZNcufip2jOd7e/d8RntdPqMO2R6dOuC9XqsvliK9NEbzGkYG8Nfv+NCPYUxiXnd6hvHb+lQU3lcDYSBvwy/FqeX6uwGY4WO7oeR+zpH0tsyEVOtnwaPDDEm+4mVC5wLM97f3LBheBTLxqgf7HY9ctZEgrJVZ9BDGM3hAP5DU/ZkVkghTADCfXnS3RZl1W25BBYiQG9XadcPQ2/QhQ2Wq7ZGi5vG05VSWfgBIQhWACSFqPqXJ7vLl5UDPDPAR2x7HHPyZtLJOA8nmo3xSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GGp2i0cTYCw4QvjwqPedUb8S3YtB2vonV2WRcsnC60=;
 b=quONlZpSzPJcloK/fhJ2Q8h/FrB++LHtIErYeOy9pHLXclVQX4hSAOXNruPHdG+TxY9uJetb0J1OkNDkPlxrbutYZrqcLYqRKz376rc1rje4J4UJGCKdya+tF9afnGhRSAHtkNMukm3QuHxVqPfUUlic4DXcJ0w0WJGDQ9PylvbVeSgAMFZS0DFWBNoRhYpcAQ+GTF3SKnv8eNpLTfTBinveMnCbAswhu/5SMl/QL8+UxKZMHcHZo6xD1ugJegLn3UTznRnNnnOobPdKdIQ7vH6ggvbjOyez0GTpWuzHnuKntrghlC50zT/Go89DRrEYSmNNnn2v20qFoxg1i+aOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GGp2i0cTYCw4QvjwqPedUb8S3YtB2vonV2WRcsnC60=;
 b=nBHW0OO+y/WPrqemaayF32CfqHD9MB3UpX8oaM1cGgsKOa+JpGYwvPHokGy0USj5vOcz+pEVYshcE6DQHhZjxN93OlCuUG3S+anPs/VrY48v+a/BM0qm2CqN42IP/5B/g5wydthIY+QcBRqDc/8dwLSgHCSUBSlH4O+zKi27vL/ewiMa5qE3bBQj7wM+2eFzDcyqKNDcpHbGGMhnJ+qDBZ9s1J8uRr6tL5h2xu9WyAZxe92x2bfj+mio52NNMcfSuyshULjZgJofoj4QCHolMQfA0AlLC4LEc80s6uxdIJTTGCb4q6fJcRresCJ1JbLk3qlyEtp0eqacu27CXrPLBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 16:17:25 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 16:17:24 +0000
Date: Mon, 29 Sep 2025 13:17:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20250929161721.GB2942991@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527644A664DC4EE3352D1C6A8C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527644A664DC4EE3352D1C6A8C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cc996d-7e7d-4743-b335-08ddff73accd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PDpDnx+h9rQJSiVrBAF04BEvrBjfjoPKsjLrSRfOi+ElNHdaioH8pQJ0C9jQ?=
 =?us-ascii?Q?CWQjYIT4Qn4FTe1GB72V5/xRt3IkfSG5RdFksYcldTU8FxAnCAmf1wwhlu+w?=
 =?us-ascii?Q?xojPk0b3Tbql9EFxKQsCJ4Icb31GePHsJ8/uu0Hx37MQP7y7xVZ52O2OZprK?=
 =?us-ascii?Q?p9vLltaGy7wirwq+Y7m2D2bgCYjEksD552+7+l8FinoHxeLhmf4HLOYk2irW?=
 =?us-ascii?Q?Xjs/nSkyIuCxREGfUiF1UducEt12rYq/Xm/IoDzRkf7+VTK99i44gOydA9uA?=
 =?us-ascii?Q?IjtyTz6N2egob86/VmMRUKcePhDusJPIuy2Ct1hEkXScmF2TkeKNuA4AIXiE?=
 =?us-ascii?Q?cyZB7e+UCO+dYtXjS7IqOnXgwiVCKZ9rVHhQuuBGtiUspX2ILWKPHj1sksbt?=
 =?us-ascii?Q?1Tf/TMJkg6yo/YeYYO++nIQy0vWZxPq04Ebs+LC0D/Fc/jOF39fY9zPr4RKV?=
 =?us-ascii?Q?vCyVJZoB9MINYX5j+Cb+h6dTOow5NnUSwpph9L8khSrPnYl0A19DTtBXfMoo?=
 =?us-ascii?Q?Zr2sP5vR53vbbQGc3rASppszkbApJ6cgGI+CMSqLugGSw9fQfDJimQnp6PPe?=
 =?us-ascii?Q?yDd/sW8EkbPMsLyYG1uN0b7Jf5hCo3xUCdgVDQ3WGejbpW52MfWzl0srl+rZ?=
 =?us-ascii?Q?/Bw6z4EhOzoExKdCgckPUTGBYrC4RtcuVhnaTDBZa/OQsuwjamhJ+BeTDQGu?=
 =?us-ascii?Q?6ygvQaUUBjdVqZNAzCRJ++kXipZlj8L7zbVEu4gQpS8fwGv1/JvR+s6vOiJW?=
 =?us-ascii?Q?kKxDTe3QmxLEG5Dxav75ATaEhL9ywUHJqOqLboVOO6d8gdvxhnUaQrGPhc3m?=
 =?us-ascii?Q?k9cZ4cdAWSmPgkInuoSmB67PH477ns2EimmNsUpNLpeQBWXQa07m/rtDhjCv?=
 =?us-ascii?Q?agCizA0/sjuA4cOOV/8Px9SPVrceLYz+MdxGrUtbfBgoiloP0VUBMKdZgQKf?=
 =?us-ascii?Q?pPLF13oYaMXH4vGR3lU0Q0KgLm/RwLtSTCC5qnBhIT/zw1VWPmn0pal1Fy/F?=
 =?us-ascii?Q?45VC+SeCK8Y9IpoKK2ipAkQRLIsdxcn4tWVPnk9W9IGgrGMA/1NfTw4Ttjri?=
 =?us-ascii?Q?m5HobTmOYcOsFuoUvPz3NkhH1+YpnyGGgZqqQQQCPn/3HFQ5qKIa1nMfggL6?=
 =?us-ascii?Q?eO7daOgCQPZBTxeAMr1RgWYIyRlTViMERRQp0gSnrIkbwOYkEbko1gm7Cles?=
 =?us-ascii?Q?1hQr3ZObnLL0yd8Kem8MrYLcPZyjbL92y+RIwNxHEMxdoDg5uw/1fM/yhCVE?=
 =?us-ascii?Q?By1V67BJdy67IQ56Lj2nqtv9sqwuGM12OnRZ7TZsDRLUunnpMFLYsNHkBXXl?=
 =?us-ascii?Q?9cuWcuEFesMEjHOxVeE3H2/fXDuxgc30V0kxRVS27dE5VaWkcPwgNsnnApJL?=
 =?us-ascii?Q?1x5KejrkPSO8lRVdpLCIzEhkU56QzuUo6j4EypTBkuWPqZL2dKCbCqaeP3p1?=
 =?us-ascii?Q?5fTl8SXSaWJF4nWJ05ljebkGB3w6ejAF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ux2CfrxYdiiDtsr/CLRNPQTMRovZAaYYoexRYgZX8RQ2UE0n6oeqUTO8gHmw?=
 =?us-ascii?Q?hi3tLmtOWFop7LuMdOjj5U7PS3yRedxIYfg3JGqsCrraz6PrTiNjm3Fb3K3Z?=
 =?us-ascii?Q?tKiwgNcJe/kRbG8T/v2K1NH7Zc9Zs/T6cpO9SC1tFO0R1SOiqVxwUgL88516?=
 =?us-ascii?Q?/u8AbshuUDT9mpgGOw02+pak6lhjcKJnu3qZIouYT6LWxnS/DZZ7wNfR5lg8?=
 =?us-ascii?Q?gOVtJ4MJGRTkTFALLuPC1cx3juXof0lrWrr0OZHMcsGQhhmDXv8fXA8F2/c/?=
 =?us-ascii?Q?CZEq4Tz8xSKKq0CSCT1LyGuNa/ApeBUpulAcvYZOBO203Pdodwtba7jK4X3C?=
 =?us-ascii?Q?giJbWck6kpGliYuzrjSzVti+bHE+eBDKjQO/p3ZtLSiV3VGiowEUfi8jEDw6?=
 =?us-ascii?Q?eOY3SwJFIOT/mbDKbFi6/cX1Tl916oTgKcfE0IOWMBvTsV7ca7oUaedQFm6u?=
 =?us-ascii?Q?fnea2BSDVqcfOpDKYLLoq6fJBK2qTQpqlnN4DPNn5kwwz2fEF6pE/jub57hK?=
 =?us-ascii?Q?NtOcZFFVBk12mY4kJSNePnRgoOW7LXAloo/Bu5wKWawJg+jdLVGRZ3rJx7TW?=
 =?us-ascii?Q?OYUfaWbgMRFLFOzPK4kSjMx9G+auFCI5odwOpI6UNVT6GUyRi3PUEY8WadHy?=
 =?us-ascii?Q?+FnCwJFdJX1mKOuF0E96JXQUJfL5+CLxI1l80GK6MY/YlPYdGVJ+Bx0zti9D?=
 =?us-ascii?Q?AlzXtlQgw9mXh29mAZFN5Ram21GBD/TMZhUp63da5x4bfuaGtx1eQ6v3LTW8?=
 =?us-ascii?Q?2D32cPrCq3FA7navXQlT05MOdkl3Tp+0YUxPTnTFUFNzgRPblQSsjR1SVcIH?=
 =?us-ascii?Q?dXTskcGEmbPCJ653vnL090cb1XXdotUyymvK+S6beVGhUw4vBCDXEAllZXIi?=
 =?us-ascii?Q?UJiqv75JrOLAQ6l5DHuUnz63J+IGHl/xqv5sK3FhVnLbh/sZdJrZ4RjfaK6O?=
 =?us-ascii?Q?Z1zXVyzNq384CCIMOuzU1JpdnmKahPrqwP3O85O7NOZJZroQp66eywgrTwOs?=
 =?us-ascii?Q?gpPYHGstOvyjal1MkU8FrRS0itQ7ioIPBEoyrgxWo3FtZFuulSJELdWQSx0k?=
 =?us-ascii?Q?HaxnNNAYl8cb4s5xGUv8/P/B1Jl0vwYIfe8FK+u4Z5aIYlcqOyzUe0vOuPu5?=
 =?us-ascii?Q?VyP4q+iGxM0fDxbzMGyvQEOS+ndNZ3GWBESGOhp7wXbwA7HqoW9R01DiMxGy?=
 =?us-ascii?Q?eFs+wx3ruex6QTIlhuOZhecVAhGQVOPR3TG3TyxX1tWMEdLBBCuGX6R1ORxr?=
 =?us-ascii?Q?AzLq0x9zu9phun7Nbryh1kA2+0sojNPTH7Myp+ZIDagf8CB7tousqOf4A+Ok?=
 =?us-ascii?Q?/Zu9KLU0rl/Cp4N0ltSEt13Zpqc7XLu5x1n1gPoSfpsSqO6QshVKS8q9pNe0?=
 =?us-ascii?Q?M4PZ1RvjcvUHFt5PqGt+9NPpnBAjbPBnecN7W4DdK1z2chD27cb2ZmoCnT70?=
 =?us-ascii?Q?7br0x4FzuymUqk/J+SsFBYw0ddHWaEU8iLYMi4GtRQcXgbP/TvH5oaPl8UmC?=
 =?us-ascii?Q?x6BjZs/+cKKEnXfEK/PdGNJJS403p/83wb9UmHrQi6ifZPXXiapgbUJCdEuS?=
 =?us-ascii?Q?XXcMyBWB61J7P/0iTl289NGzV93rrkZdJn2ArB2u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cc996d-7e7d-4743-b335-08ddff73accd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:17:24.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWx/bJVhvSV3worekrG2zeiVpVG10+Y+9xcCX7l0EzXMFTRoi9aIapGW9CgVA7p7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

On Fri, Sep 26, 2025 at 07:57:07AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 4, 2025 1:47 AM
> >
> > +#define PT_FMT x86_64
> > +#define PT_SUPPORTED_FEATURES                                  \
> > +	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
> > +	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
> > +	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
> > +
> 
> iirc we discussed that FLUSH_RANGE and FLUSH_RANGE_NO_GAPS are
> mutually exclusive. so it's a typo to set both of them here?

They cannot be enabled together, but this is SUPPORTED_FEATURES, so
the built .ko can support using both. In the case of VTD the instance
cap drives which of FLUSH_RANGE / NO_GAPS is selected for the entire
instance.

Jason

