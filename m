Return-Path: <linux-kselftest+bounces-46124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FCDC74B93
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6452D2BEA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA67B34A767;
	Thu, 20 Nov 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVEs8wAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B233A027;
	Thu, 20 Nov 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650790; cv=fail; b=FAHRhepkRFWnOG06C5Cc5/V1dh8okUTIAqD5QYpETOcAiQOI7kKzmldq9w7+/3rrbF2ripfo7EdXGeCi78BM12WG2vUNE4/BhxCJYSLzT636zZqc5aDEQsixrbpAYmKWMARX585uHtbKATNIPJgioBU/LCbtFZ3dYdGiDx8a4JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650790; c=relaxed/simple;
	bh=aVEUPOVDrep5FNX8ubLMN20bYk4nmPeO7XB6LqnZVLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZzR1TJo+ZSr2GcR/O//DQkq0HNyFPF46zqZOeLmJoHEdcK4EYUehs+9NKIsDt9jfav2Q5c6SEdVypfbVcXV8eoLj5M5JcYBiA1t2zDj+Lgo1x3d0m6kTPEqCtQvV0eExvB1cxO7sQ3i+sxrQmTBt2lI15YmucFO37uQntGrwn9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVEs8wAV; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBwLl/5f1YY5+a03Onq7O0EKlacexcVC74tHOp5RfxDBvaNrxFIRtJ4m8KUvW3vGYu/aKSKFH88l2Bo6z9C3ZuaqR1LCzD2wjQOSc+WwDFRYidYqzEaEJpKMbEPJhBpodQ+hUmJc19JDVgtJ8W1UE5kr00I04wQKMZ794OyulWKJ5CaGRKpcBGVetLXbysmWn+zs/uy1HIMXn0iN5nrWgKOZJZUHqGpKi12fLYbdKScQOCWpAUJ6x7JRPRfRBXFvgFVkMU85wmH9xEQ3gqezLFRgDF3+uLYBr+x1lFeU4gdpbBBPXNde9OJPmEOtkX4y+AIhnRTucEY/oMV7lTnrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85eUEXCFIH2fJ9ddRbG0jzYyR06m/4rKjpAqPy+Pooc=;
 b=V6G+BN7ZKqAHlKCqX9ygQG8rmUDdbvL9yaEZRPzxSmlBZV10mL/qd8+FyrNng8Kt13GtQmd5zM9UBhxK0e6kJPcO5mICKxQUOX/11MvzLmASx3OM5+vZSWDyjGKG7HYa3FuaAP2pN+VJmoHrc8N8kGrONwhdozpRr8MYATxZmmc1dBx4op9oLCj/a5yBnS0x64hMidymVLws8mKgCXTf0wvQ81gniCYkx6fWkt+dFkRtQtzhyfoRhcidifRjUsAZTWCPWQRLHBPwydErw6LwDRqdApdMcRBsqovH43fOvXNyUzePuQuAjyNaYPE4kavPdY50UNpC6CDK/zUHP/xccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85eUEXCFIH2fJ9ddRbG0jzYyR06m/4rKjpAqPy+Pooc=;
 b=eVEs8wAVTi9iHtM/S3Kgd/IpB62lB5HKlocPISmi2U4i96q0vhaLNlGPsfAbsjTho+ld1qodkL51LaLAq0NLaxIrv1owa/v6KJJhXib+3y/2l+ydDW1QOA6vTobarOQqmCkzJ1Z0ZHV+1TSGFtXeiEmA/8invgMWzqMBLMmIntm9cKBAV3Ve6PuzcqVUTKuRtP2iZKcUFtYCjxBEVltrzCTfViiRep9SCrOpUtX/TJwFIDWnO5GqRduyJc8JShT6PohwfCWPfK5idKd/oT/J3EEnpHNKTRCrQAeUBU/u7T2cATttXrhnOU7+TWQIFpaAsQE10q4AyeejqrXpnws68g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:59:42 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 14:59:42 +0000
Date: Thu, 20 Nov 2025 10:59:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 5/9] iommufd: Allow MMIO pages in a batch
Message-ID: <20251120145941.GC153257@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <BN9PR11MB5276C73B3BA7E689EAB90F648CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C73B3BA7E689EAB90F648CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 48893505-3016-4db4-fbdf-08de28456f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uWfTxbN/mDFb18V51OuA+JTg5mVZasQXY8gH4/EbP+99K8aYpRpiLCXPuSZx?=
 =?us-ascii?Q?tvWWkgq14dCwrhPbB5kEM/dHZYbilkulh3ERMiWvP8yVYZKdvVS9DmFDkY3D?=
 =?us-ascii?Q?CMVkcmFgqY1JABtS7cvdybxm0+yOEwh75xM7HCv4lNP5iJ34KbkOokqllMDz?=
 =?us-ascii?Q?WkEtf5e271ede9L8Q+Y6CxCJw1XzvLnYm91wG4E78b5JMsOCit3IgMrtte0S?=
 =?us-ascii?Q?5P7R3S3blTKudL9tuzih/zHuJ0MzKul13aZsq1UqiMhaKo3RemDsethNLzKm?=
 =?us-ascii?Q?tEWK+jCoq70te/6MYgdJ6DnRmKcefq0iQY2BijP1kQNPO1gws4pv0VBNHOpC?=
 =?us-ascii?Q?muVEd4xcnDkm4aHxOJnXwryt+Eq61KTkoN9ZDDq8eUxELs5jBp2pxikebcxU?=
 =?us-ascii?Q?uBjYlJCNvgFLHnI/YPczMZa2qldlNJ9q8zaTcgO5+D18T4KjhA4aBmEFhLk/?=
 =?us-ascii?Q?Fb6Gn9NrwCkJSK38P0TtJqB8IrEK+QZ4VKakiBe3Px3OoMpekelKmLfS1d9t?=
 =?us-ascii?Q?BVMMAQYIVzIHWSUMbE8e9FQy19qTvkhhOrmyTuak22u3IK3SNYHBAd52eUGE?=
 =?us-ascii?Q?FN5gzXTDY/dpYgCQ3HMehNqmhkoARDoZNASsG6QKyUX17hSR0Y0VVNPJ1qIY?=
 =?us-ascii?Q?t+Ds4qaVESdAL5FSEdKCBISLUT6Qv9MZr44uRVySPT2dcfZE0vB8x+vHUZZK?=
 =?us-ascii?Q?V8jZ6aaZE3keaNLcaCCZWhoBjhUv2qbW8lUTXG48K9jtXT4i3hXPHXmnKLAR?=
 =?us-ascii?Q?Ojj8+2ehmzjl1wepAIjfr7IsFK3J6bmn4c3J/b0l5zAlzHA9RakVuq9E1E1E?=
 =?us-ascii?Q?AE1ra2ULmFENBx1qrhPMZL4Ijy7nhcfY3QptuOhjFktIihdBmka5Zqy7O65M?=
 =?us-ascii?Q?jtZR1AN8pUoNU5Vlyhb7P54t3hSa4btKUSDCKbNMQxS5ZnzBnbu7mau8/lml?=
 =?us-ascii?Q?DMzDRo3aycc7+I+mqctlrsDkBKfNE53dIZhJ1AnTVdi3CcAdajXZAje4SzUM?=
 =?us-ascii?Q?K2EGBu18rUb0EUZwFIehg1dnFkKyweWWPS4Nljw9FS7YQYf22ib9qVXHiCRc?=
 =?us-ascii?Q?wQf0dSzr0+CJgjfUOKLzo/9AhCRkTIrFcZo5ruidFBrdR3cZFjRn+Fa6B0Kb?=
 =?us-ascii?Q?ljuURrF8PBI/uxGWIOhRk1+UIvCNBiy6IPxrrNtK4oGY/meVJbpji2Fb2Zko?=
 =?us-ascii?Q?GSg5o6SC4UQKv7a9yqNz3xO6DRnh0cL98RQb/f5iFB3jPYF9QdsrIqPpooqL?=
 =?us-ascii?Q?BGT7rgsRcLNinhQhPBvP6+crn2tVpkHh+WGTCwA8b/jPD5d02K8AgZ5nImaZ?=
 =?us-ascii?Q?xUHbwJhVIFT074njYyhytWQypSyDEqV43PyH1YQlZMMw/FPzAepe9IHUDgx9?=
 =?us-ascii?Q?00fvtajFtVOMkV2v5wLqruzHplJjdOd/x5gN0m+fHGltYKuZuikNuoSYgTsz?=
 =?us-ascii?Q?9QNEyzjIlQ4Sujshv5Xa3rHVnHwodzsm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mK+iGE5Rpg+1sFglOZETIDWm0Mkmov0bTguZteqkvDO+OYUT+XTShrksFhba?=
 =?us-ascii?Q?glpJW16pi9hzpqfCXOgJJQJ/HHzAhwUWo0QfwLi6hUzpf7Lj/hzOxXqpvvAl?=
 =?us-ascii?Q?db5NCd5yzORBtq9LSL6/R1HBQbJNNyMBv0kM10kYU/lgtfle9m6ywpk7y0to?=
 =?us-ascii?Q?5D4Htb3w8XaaBFEtQ9iYyHLpHAcP2+H64MqLrhtbDzpYC59m5GWKX77XX//A?=
 =?us-ascii?Q?ndJYJw0WIa6QgivCaYkeCBvolbA6C+bQovlXzWWoTvGe33O4rDIZfTddl/BO?=
 =?us-ascii?Q?dBqrKmx7mSWE83QqxOvnqEKmdEBuEozEA1HehxpiSkBVCPtETIBi/34EslMn?=
 =?us-ascii?Q?c/W7vIoT9fkAM6fA/FDg2l21zPtit1cr8n9Ktod/takCBSOdifSWAPzTf9ed?=
 =?us-ascii?Q?Ug0aYrSW6nyFolUhOL6FgW+hkRGjRHBTcBG/8q9s86Lp2SVyEUkq4Ck7XPU6?=
 =?us-ascii?Q?CJYR8DTMV9jGXzShTKtUZpcDzLlzNnQ1KALl2uECLxQKzp08kYVACtqG+Cft?=
 =?us-ascii?Q?9gaoDQbP/tMcYH0VLX0pVD0JGU+bkAdhP/zXmCILUKtfhpKsgIQrzEvNGqLt?=
 =?us-ascii?Q?q/421TC90EniASbrbzViD8xJP5KvUtG9IwiKGwKS2gQ7Ql3PjgR3RPNjlGyE?=
 =?us-ascii?Q?+o4yz3CN053OK9CRJZHZekZPZ8ZSu4ZIC1YV2S6SxK4YZzqk5dK9Oc3MI0n+?=
 =?us-ascii?Q?/9ZI31ziTgyDgSiVgT12FudaNhnICC0dEBp6q6/obvilw1YZ0VZgGiV+eDmC?=
 =?us-ascii?Q?JQRXUOpGt48MDwLFFi2T5zVQ2xr2fQK/U90eO+33k2gSu4nX15WKbCGnedOj?=
 =?us-ascii?Q?xR1UiMzUewzlj3rsTQAKAdJgFMk9U4UdmKZO3OIqRWs6hkUlDf1WckZf6Eck?=
 =?us-ascii?Q?rA+rY2JM/K4eMmpkHK81xcjRdVYdXvkv571CLEQkS8cYAaztfqZXTQvuf0qM?=
 =?us-ascii?Q?iPbGKsjDHGXXN6Rjfhu39WKwmaKOXAYa5Fpyp9s3EsdjZhxqq8e7eKfKJDen?=
 =?us-ascii?Q?IYpAxQe38Tlh+9uDHRIngHos773KezzyyXGspbiBRJrxOmSet4olUfkkRKv+?=
 =?us-ascii?Q?kPs7djnv0Ye3ZHu9n8ThspmK2id6yWzV5qJahYUPEzJbyMaK4WVwI9ptM8/e?=
 =?us-ascii?Q?YMmIhpLNuWQFtBXn1YGVCcgkyUlwnBWYFZHvBx6bqughcIsugNrslLeoWAnc?=
 =?us-ascii?Q?jfI3haRdvGutB1hez0x1VXDztLCemkpqX62J9Bfz874dcJuBPbtzjzVue19j?=
 =?us-ascii?Q?fyynNqxLF5t+Jo+YPIS94l5l0ZECW0NDz8RFCrVtsi6uNSVEJtuewiaCgUki?=
 =?us-ascii?Q?HBF8NNEbJkZXEwZBVZX/HkHCioVA92XRpdDlS07Dd5BIRPchJP5ONbTeANvi?=
 =?us-ascii?Q?ag74WGu4NU+Q7Xqs00Lv0LaUeSxRTLx0kcVjDGn90XpgNiyYpgZz2ak73/HG?=
 =?us-ascii?Q?ZK5MFVPhiKps7e+Q0X0QOTxtzdrIcB3bGqq25+DvwLryZWrt2qjH/vcy9nZr?=
 =?us-ascii?Q?5WyfB5+vAoLacCBhBg5LZOYBPAToasXQq9oj8I2IjN0jHm/iIx/naVljfKj7?=
 =?us-ascii?Q?0BSsiEbWxCQk8SV9Olg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48893505-3016-4db4-fbdf-08de28456f7e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:59:42.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mkr4xX6VI11hK2uIHf89zIOCcv8lw50cYTo0DVUjwDxR3890dW9znzEwTuRU7Ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On Thu, Nov 20, 2025 at 07:59:19AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, November 8, 2025 12:50 AM
> > 
> > +enum batch_kind {
> > +	BATCH_CPU_MEMORY = 0,
> > +	BATCH_MMIO,
> > +};
> 
> with 'CPU_MEMORY' (instead of plain 'MEMORY') implies future
> support of 'DEV_MEMORY'?

Maybe, but I don't have an immediate thought on this. CXL "MMIO" that
is cachable is a thing but we can also label it as CPU_MEMORY.

We might have something for CC shared/protected memory down the road.

Thanks,
Jason

