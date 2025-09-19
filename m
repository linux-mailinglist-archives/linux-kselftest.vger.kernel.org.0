Return-Path: <linux-kselftest+bounces-41956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AEB89FF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F3B165D53
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEAD3161A9;
	Fri, 19 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrVjqnOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76A1DF269;
	Fri, 19 Sep 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292270; cv=fail; b=jfRBEyOHouidxZLMo1NA3FY17Xg0oN2A/Y8KePgYvS3HOFv+XGC9t57lbmyAKxGRJnlF+uaOu0VfFWrleYXLWisYiHXaI0R6vUzF1bXXZnrMB1hECLELvTsqKtTsSFNNDVrO20Uxio9Z4nevnbSm0DP3E5Vby+X5WS3Q0H4i7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292270; c=relaxed/simple;
	bh=BcW64+XoyT1IHhBC7ZWvEkOCLwb/MD3Cyiw8Rb8zMVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cw2BhPLO6NPzO1ku3jJ1ACF5+eISkE+fmgUQgmoTqO7AN3ECqMNmQATvNnCCR/nv9WOg7Mm24VUwt7Z3aePGcXKovww47sAZmsdCcffj7+iSksKucAS6TWgtYVwLd0I5FbMBkHp1CI35ul6TityKCXNPduAim6uv8Yad+lYgRHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrVjqnOx; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaMGU1YBacVkFf0cojBe8wMeQeADeOyd9N92au+S1eJN+oTRYnTQQVv2vslItv/ziw1JNHBolM4vdjxAFj+BHRrv5q2DHPSsmySm8EX7spN5mMPjh+E0am0VKaJ2O3MWnxsefWjS0RY281m9yl1vMO1gaaVSxciglgZTGF8hBrdQwAvt35rls75xwITzb2tn+k3GRbmBl5M7zfaJplX3ZUs7rMPDeDPCL6U+FC+SM5eFMewJC0uuIPt2V2XCaGoRrhPQkXbt3Egs+uJxZLjAuN/9ZU9+L+rFQKEsGXd1FrWRgB30ME3dRxtOtAGpv5dlZJbeM1y1gdnQQXS2TzSNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOJyiyklQD7pwrb09JF2tQJXx45COsHsYG3mRCrdxhY=;
 b=f9F04ZhqleYgexpYYayJVxaFeCyH8AigwlipEndTNjDx7hGsqJEM4eHyXzA3B4t4Q+WOeFQfPLMwuzWmR8yFsKMHd3MZ6R2z6JExtjFsSkXkq+m+lchh59uiNJQeXrBVKHsylCF4N7XVn1e/ksYBh/MTPRMXF27YvkLoOkDmnAmLbYU+AprkUrbUmpl2YImhs2drX9+qckKELa7mXhmwoHaPjLDenI0dQIpSmotxe4wzOyMk2Q7xyd73plBOUeIqgPuwYDeLJsZUokbcYKdGgC15EBGvQeD1UqgLqxVyG0uxrelo8LLyIpyYPgUAdbOTKL69jQcSpFl61dcXJkSNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOJyiyklQD7pwrb09JF2tQJXx45COsHsYG3mRCrdxhY=;
 b=MrVjqnOxKwMLo9rKB9OIjc7L9lJqQmYPp12ChAKSKA49Ll1oGBWbZ0ZDk3aV8mZlRBspuCkcv6h+Cjo/kNVf884vfid0KW0jrLqqE/VuvOepYgGW9CqykEptV8tzu1cW+3hD74UCmG4TUy+yo41pCznkDuimykABpEGrwB5F5HqXUlHJbVvhOUAgqERhBiXVyi8f4tf8P5vBxWYuxSIlIl17hTgkYU0yEdpTUe0rBsdN3Ue1VOLuGx0XqGvRKQ57UyJ8W9fF2HpvcZfOAXiyWLILVadcKv2xvY4olqW0OGKf7Ok+vqPCtqY8zUQdMOqEvh1H6X0ki2+3PgqdanTpGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 19 Sep
 2025 14:31:02 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 14:31:02 +0000
Date: Fri, 19 Sep 2025 11:31:01 -0300
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
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <20250919143101.GB2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250918180657.GA2132010@nvidia.com>
 <BN9PR11MB5276A9B144DE3CE042A448D48C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A9B144DE3CE042A448D48C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f093ca1-ddb4-47ea-3b5f-08ddf78928e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZ6oUSIzsjD7H0ecsTuz9buROVjYB8SIPw2wnFmv00wAaol9YcA+xGNMEbmQ?=
 =?us-ascii?Q?KC+AWXHe4fD/ArU9eS2Y1mz720swkUAR+WF7uSBDhH2xeIgQWpBk8yAwJlFd?=
 =?us-ascii?Q?Rp1ap1mG2F5QfV9963AneMtIOsZFMEP2xF9Rm7FVn1oxRvrEmldZcJ01ZqZ8?=
 =?us-ascii?Q?Nz8/DwjtA4Kalgs5JyJNOZ2GZB8/PFq9u4+ZipP7PE+UK69V9oxKh27rm6y1?=
 =?us-ascii?Q?LpJYFAcfJo2FUQknQ6xHkAFJXk6srdPBhNg+o1ux3EAWYDdxSUAytZEQqB9U?=
 =?us-ascii?Q?ETTCWREbmBTX78gugmziPK+gZYKjkMeaS5q9ggfw3kcdWcI/OotUkggvIoVP?=
 =?us-ascii?Q?MChpUBTurTeBt0owUhhAb/Em6KLaD8H0Qui73pfG/ZogCTJyXV2cZco/J8Kh?=
 =?us-ascii?Q?7yA+4YZFHK+aW9Lr7njIskgr68YNOQ6KIRw+W2gr1eP0rW6VYe30UShLGy3S?=
 =?us-ascii?Q?Ly9xRe0SzOIvheDsVJt/LxUDrWLJACT6ipbwtApESDFrJYZTPFsD8k6Hzu8u?=
 =?us-ascii?Q?C2h4m15ETD+MXhCwyLtSZP5qaYwY5RGpgFmQuicfEKhrxDq6kaDUyGLTTjBu?=
 =?us-ascii?Q?sbMUe7GjGSqKXyIRkRLbLYDM8aTaiYn9edt4suUp9uLqPLfrrJQwFDFuXrKc?=
 =?us-ascii?Q?6j9GtVlvhsq7dJYsYF0fZTvcde3+BxTYmtVA2mAqQTqwcxBgB+0rtXeukOES?=
 =?us-ascii?Q?/JqUq1QhOIyIMowADDh6Z1DPfA2bboiwrvNyBezFeU4j3BxAt5EXvseECSfq?=
 =?us-ascii?Q?v392VUsEMsr07yIKGdoJJxXIn4onHHo1qhrUDFjlj51mB5uC1lYrNXIZ5y8I?=
 =?us-ascii?Q?3fhvHJi7nSxYOmbOwz+QtI3DUZyaT/l9iAIBajFqZ4heHq2i+igC6WgED369?=
 =?us-ascii?Q?yDn2rXiBZ5GQGLW9lljmZSu66TqUH4ibrSYaTfq9IlsE5/CBPeGR3aL7dDlZ?=
 =?us-ascii?Q?dtT3FRm/YpykCDS3HceB/w8zRm1HT9e+PSAdtZwz682BpYq4lTBgConuf10M?=
 =?us-ascii?Q?F2SdNovM5oQ+JRlS7G7RWruaJfzfkwdxGzpQTuE+HGQD9SIzbRl09kZ+7VdD?=
 =?us-ascii?Q?Yrhh2FqKAyoNwXCL/LU/Xf8di6KOMmBujjWRduxF2nXhKlXql/mydBt6HwP6?=
 =?us-ascii?Q?ohjV8dpwz+h6RKosvwPUlai2B+USgKD9p4A/7EKK2pUA8zEUdZU2p4Z1ZbCL?=
 =?us-ascii?Q?fNzp0L/6wTBe5e+QwgqwMfKXbZ+6/2K+UdH+wW3dTrQeP/botAM4EtCvvGgP?=
 =?us-ascii?Q?soMmnkySqGJmP5BcMkKyNJaszW6jnwHMjRLzszLuSCn4zRe/K1F4Jml9IPMw?=
 =?us-ascii?Q?4PPMy/PX5zvxsyLuaDavf0EeHjLLujQ2FBlIULMuCtvvqYuvtzVwL/uk+FQW?=
 =?us-ascii?Q?yOtcujqEOX68938o5vScImnIW0vhiAQEJLWOdrCFD5lQLkzjaLNHWTzEen8n?=
 =?us-ascii?Q?ZjnRx9174Jg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/YnPFbHQ1ALf2JaDsIWd1BFbUucZt8q0ODHuHY6yn2I80q8cd7I9QC0YkAw?=
 =?us-ascii?Q?jfhzqGyMG7eDpuxTZunQo0VNa7NKRi3C4bSIF1hdi86iWH2qUK8suncpGZix?=
 =?us-ascii?Q?TvdaHYFaVQzE7jLRjxaAdBnxbkJinmogs503+n/MaP8NnQ9REAuMOnZV4bKN?=
 =?us-ascii?Q?nx1j5nEC1UcKvuZDbAGasS8e0x7S8LPy21ZdlYh5tlI5vF1Ifiz+8gJb3tSI?=
 =?us-ascii?Q?H0XN1MwdBuxL3Tjr8ci3sRMMSLyaffjjH8xPM4fBCJtcJdXnbBRE3V6LhjNb?=
 =?us-ascii?Q?4LAANw3Xt0I1IDy1jThonMTLyO/XENnmWPcl+yIDzaagzhjmMr4Cjpe5pxMO?=
 =?us-ascii?Q?tg559aCB5u5OjkapEWo1brvKKfJl/+gbvY4x/x7vnKw0nJ4Cjcn5MnvyZCrn?=
 =?us-ascii?Q?fBhoy2O1GL8Mc948IyMrGjoV3+k4Ym0heIRqYN/Gx7AQuRsFat8WsaSm5soB?=
 =?us-ascii?Q?LcKFlW1CxqAR0F8ER/a8JlwDa6ZXreys4dd83QEHRHfSqH9CgxrKI1tufqjj?=
 =?us-ascii?Q?YZCeb2+0DL+26hGnEqpdrSHEVXNonqtjw/LFBbwT6Qk2GvTiBNjqDNC2qoNS?=
 =?us-ascii?Q?cSynZhhKydAXv+34Wk2F7rzP3u8SRQLPkEXRCdZoyo06lkLELDMiPiG9cdQP?=
 =?us-ascii?Q?C0V0CMUgMlv2TPrrY6mpyoGcL1z3QEjgoGsOQYfTBv9IRvc+YQBBmgQKPpY3?=
 =?us-ascii?Q?ZWmWouAdO0KYw6mOIfEhn3kewOu80Wu+Z+aOzxo85+7kykGm9H9McqBzUGmO?=
 =?us-ascii?Q?jafQFYVmmx1SDA6fC6AUPKLRWbixucskCCpHXX56dmPbDjiuD/TQ7mMTgJKB?=
 =?us-ascii?Q?+BG6rLLIlI4OENl4ht1t9aWqwaKGRsLroz0zGnDifxbvmwdDy05Y03fQH/88?=
 =?us-ascii?Q?qQijylo2zRGWSsbzoyJQMH0qoZ0Ki0StvHiMrIXFslg039U2d4QG2K9wnRfd?=
 =?us-ascii?Q?kjvCEJg6hl4Mm/mVztqwqPgiWkAF9m3fCctwx6tNzziHo0fBV3SDvh3hMzWq?=
 =?us-ascii?Q?jp9Nv15I6SX0O2W2xHRI26/by5k/kXXgoFWURp/wzPo9+v+MtL7fKoXAvw9I?=
 =?us-ascii?Q?+Be3sKZE1LMHJHP/njb/uB7CMRDJGF8qQbaPBaBawFlPW3nAxdWd40ZHvmPC?=
 =?us-ascii?Q?SRrcdLB0e63p6juKS2VpuhMgt583Xkg1OchgnddTw0UwB5UxMJpT1+xurHJ6?=
 =?us-ascii?Q?GfPbX/u6FpJSA1LCyV5v/ArhlyTdYiHeUwliLDA7VsLR9AhDgGuYVkoHf1YC?=
 =?us-ascii?Q?nT8WdyNs7JZ3Es594EEijNh2v9iAWCZUKXsr8/qLAHl4p6btQrhZ0yyFLFMb?=
 =?us-ascii?Q?GycywRQtGvlQdmbQZ3sAG1mdvqCfEN1Mn8y4sq+PyjauCX2B9YKIr5v2Se/I?=
 =?us-ascii?Q?llEcpP2t6LA8EHo3boMZQzcipLHPRp172w00m8nsCCSh2pHjABOUkm2ORYnH?=
 =?us-ascii?Q?dbHyx8/Um9H5DutClXynUW4+PaiwT6MHLtxrp4LLJhtyDGcl7a6lpLg7clQt?=
 =?us-ascii?Q?+pAQ84dugCMJ0zToKzCkAZ6SNCxD7O4ruiiFvLKYjpmQLpuGIJ43AHRo3nuf?=
 =?us-ascii?Q?lFZcvD2B9gDOQdgis5zZjJQffkvJYRnUQLytL2fB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f093ca1-ddb4-47ea-3b5f-08ddf78928e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:31:02.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cmg3ypOP8kDssyfvl01UaOawp1kmjvhXa6I4IFqEp92JLsan82LXwI5muKJt2ZxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

On Fri, Sep 19, 2025 at 08:11:11AM +0000, Tian, Kevin wrote:

> > > > + *  item/entry_size
> > > > + *     The number of bytes of VA the table translates for.
> > > > + *     If the item is a table entry then the next table covers
> > > > + *     this size. If the entry is an output address then the
> > >
> > > s/is/translates/
> > 
> > Don't follow?
> 
> entry is not an address. So I meant:
> 
> "If the entry translates to an output address"

Ok

> > Oh, pt_contig_count_lg2 didn't get kdocs because they are internal
> > helpers to build other functions..
> > 
> > Like this:
> > 
> > /*
> >  * If not supplied by the format then contiguous pages are not supported.
> >  *
> >  * If contiguous pages are supported then the format must also provide
> >  * pt_contig_count_lg2() if it supports a single contiguous size per level,
> >  * or pt_possible_sizes() if it supports multiple sizes per level.
> 
> could be simplified to require the format to always support pt_possible_sizes()
> if contiguous sizes are supported, no matter being a single size or multiple.

I had that once, but it is a little more boiler plate/complex for the
formats to write.
 
> hmm I didn't find ARM/RISCV defining pt_contig_count_lg2(). 

static inline unsigned short
armv7s_pt_contig_count_lg2(const struct pt_state *pts)
{
	return ilog2(16);
}
#define pt_contig_count_lg2 armv7s_pt_contig_count_lg2

/* Number contigous entries that ARMV8PT_FMT_CONTIG will join at this level */
static inline unsigned short
armv8pt_contig_count_lg2(const struct pt_state *pts)
{
	if (PT_GRANULE_SIZE == SZ_4K)
		return ilog2(16); /* 64KB, 32MB */
	else if (PT_GRANULE_SIZE == SZ_16K && pts->level == 1)
		return ilog2(32); /* 1GB */
	else if (PT_GRANULE_SIZE == SZ_16K && pts->level == 0)
		return ilog2(128); /* 2M */
	else if (PT_GRANULE_SIZE == SZ_64K)
		return ilog2(32); /* 2M, 16G */
	return ilog2(1);
}
#define pt_contig_count_lg2 armv8pt_contig_count_lg2

And I missed switching riscv, fixed it into:

static inline unsigned short
riscvpt_contig_count_lg2(const struct pt_state *pts)
{
	if (pts->level == 0 && pts_feature(pts, PT_FEAT_RSICV_SVNAPOT_64K))
		return ilog2(16);
	return ilog2(1);
}
#define pt_contig_count_lg2 riscvpt_contig_count_lg2

Thanks,
Jason

