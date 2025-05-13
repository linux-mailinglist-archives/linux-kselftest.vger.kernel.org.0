Return-Path: <linux-kselftest+bounces-32915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65FAB5CE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CD44C0827
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD22BF96B;
	Tue, 13 May 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IfBUTovu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931202BFC89;
	Tue, 13 May 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162402; cv=fail; b=WQINEmGvlrj1vOIE/EXGtOFBklcS6nnKTGY8ubVZPKoooOqzZZRHlLYavcdmO93IGREcWLTsDu2SCEjQKR3Suf7ZoXWKzR1vFVHkDY8Xwf+KUtklmF5oSZaUBUA4evVsPOCeJoPJu1w9EudQhOgEfcF23SOBwmIOEW4s06jJ6fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162402; c=relaxed/simple;
	bh=h+71144dt+2T58u+RnQ3ymFKxsKtbDwsuXVKY2Ao4Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eBqaWtM/LevsIdwhkRGE1zCuBrBybkwneVgRXrp2zJz5JDuYinzlk67aFXReSb9Wfe7ikly3OfjTdoQji1nWEe3E77ohbhFQSTCo0ykGYSFbcAfdFSIhUy6m0cxOgFcKA8GARctBHM/+lL+xWae392ddEy+HVS+DETyCl5THvIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IfBUTovu; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhBm0ZMo6OqA4KXMXFaJNTryXHxLgNHZQKShd2oV9N6q/4tb0PB8D+L+2d9Hq/mXDzoQmY3P44tS8F6PI3/xYS2QoSToCPdov+nqRzb5aLWpffPjae3u9TjM/ymkZhjRhd19jnH9z0eNJVVKZTAOvaRIMSFqI1/Hxp5uoHOHAwQOsiSvBqmfWU+BBAzHWNXkllpWubMqWk8z81NXAdS6WwCt8JBAhNPEF8/268BIzOVh1dBGzOTX0Q8z0y7jGAef2tl2vcctlCdpDR7kofFsv+D3ipUiOiMJId3EYS6dUreeVpOgGHEuG1ck4Rf8i+lWWSjT/MQsvBevmQE6iMgJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrMp21WC+xE2uUatDKDfBDDao+sqAgjVDczM8mmx5aI=;
 b=q+xVt+38XCSnQtcW8eGpVP6igoX10qF4IvN27wiA+L/8SZ9TE6G6E19ztlr8ZCBUGaN4uPgAe5FJg4eCKw9klVvoBdZ6cqLyqdlr16qn3lSsEiZ1xCqTRPu3mLfruvByiZe1HTkDXfMlhrADl+4wa7FhWDnakjykDF/s3vvcqgxfiavc3K6rPU9dkKgwrGMS9VGrf3ENDDvlVaA4P/qLCMTHWJ3VGFgbs88oBsKd6ColR0QxeLGCB+KCHkhEQz3sXaEee+XZF3oPce0ZpwOh/ervDM8F5tYAZRPBgssrkEB101olNcz7NiG+ti/glGpbcjUkt2H43EbC3dxxlphMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrMp21WC+xE2uUatDKDfBDDao+sqAgjVDczM8mmx5aI=;
 b=IfBUTovutHhtxwUSNCXXQocc42UTvoC7363h2I5Vji3SpyNRiVWxyqf4+pIx7+40Fhfni0nEHtgZEUvjMwVk21sTziHVEsfd7WaR4kZnyODCqoMmSIc5kXg0gW/1WyLkscdpfzWbirT+CE81kBStTSGzaZpq6eYO1nrioKcVhV8ZVSSgRLZ2/l3B06RpwojKElj6jef0GZIdT+qHkZEqo6S+8R5vfjrbvp8/NcCsLz/OAwyUQA5z3/HZrjEtDGy07XEGs4fvemdlYeWilWQrPRjO2p4g5mYft4RS1MeAc6HEiqjDuLN37EH+ZMN8BxygsodyXaj8I9luXbGl33Q2sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:53:11 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:53:11 +0000
Date: Tue, 13 May 2025 15:53:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 02/15] genpt: Add Documentation/ files
Message-ID: <20250513185310.GA451051@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <2-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <aBrHU-OGbfqk1DSq@archie.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBrHU-OGbfqk1DSq@archie.me>
X-ClientProxiedBy: BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::9) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b24272e-e203-4e07-f99f-08dd924f68cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abANiR2WDt14+ihwsWIyVGfxYkJQ9jeujs8ZF7+5rSb2Q5wmVP0eOpXSqpWB?=
 =?us-ascii?Q?xVjkLSPJ87N0XeT67l7ImuZG9tQ8YIniCDY/LJpLvYdtsIpCa+UxEW4ZoZ4K?=
 =?us-ascii?Q?qPbU5vPJNeLrs6vJ6nln+ePsSPZO6NbbVpuEMLynYeR+KZQF+8Y7KEgx7wMg?=
 =?us-ascii?Q?9MLkHihA3yAgAgkHSEZ8UF6PdnilcBZTwvstvLUBseDR3TM6TrLuAjNJg3Oz?=
 =?us-ascii?Q?2SRXMkSUMC/WD2wR/RdKxN46pXYS+oNx5IhjjySjwPZBd7JTZ9z1wCYN8akV?=
 =?us-ascii?Q?BmEP06ald10N8FvhANGNpTQ2BfY2YcnF19zbxDEDtCBgsZNX+Kf6z+YXGsaR?=
 =?us-ascii?Q?jzrpXXZuD3gAMfLaIaYWkJ3ee+nM9OtR84frekI4yH9ifWvLlV19/EnFc8Is?=
 =?us-ascii?Q?hADYH2fQar7hVD+9jde1xvrW/ohBmTUVKe+KBzjhDz3AsRHc7h+kd++XnHn0?=
 =?us-ascii?Q?jdK+IKIvvxddaTGCAG0Uawk951VfOL2Y5leP0H4LZ9W0jwfybBzImqPrhlka?=
 =?us-ascii?Q?kyVB+7Nqp+jlDMnWfmaBSy75c/nSU8e8cwNVsPD7C219tpUbyGZC4+G87sqb?=
 =?us-ascii?Q?g1ASNFn8R+2hHh2mtEWC1rz3bjye/myqjWv6J03K3B9gmnyHYueI+dzzyWSj?=
 =?us-ascii?Q?NXAsFla5+a+VjbDXeFP2fJisFZ2iFql8LOXnPTeALeMIeLV2494gD7usiDAk?=
 =?us-ascii?Q?d5hft6Zkr8kh3vOBD33NnhZ2hSvdBkfXe8e3p4DeJoZF8vndixsmgdjmoVAc?=
 =?us-ascii?Q?kfqsnwOH8s5w/PNAez54BiWDopw8eJF7r6aN+FKySSCRmyByIEOnMvmRlKjw?=
 =?us-ascii?Q?S1CHf+MLMjurXBtnmTkYqx7hbIEc+Oq2oIgcq+iWqg9tvuXFFzUr2HxB8NK/?=
 =?us-ascii?Q?fiAODlYz4AeIye1vWR+TnVhR98UNZfhVe6x9+aCvIDbz93Y31A8DmnowaJLP?=
 =?us-ascii?Q?5/GMdyqLT5ZGyTawuPGRXnA+pvDTupYq3IALg73beVGKZgRF2Od9t+wjXOHs?=
 =?us-ascii?Q?mq2Na5Qz7tgyzGdhXtYSQK0aJ3eZHY3e7CmpV6PGNcvazXaesFttUdKd6fla?=
 =?us-ascii?Q?jZXnlww+8LYJNxr/qDLlzxQlMW+4AScrITVqf6b8lGtXROyk9wxZjBThAKgY?=
 =?us-ascii?Q?UONIN+r1MNy26feSYDWVB70t1FnVPiXXD7AX3MKUBNqhtwPlueucO2bZfeAY?=
 =?us-ascii?Q?4rCVsgEnTo2v2itCtw3wHPnkoGFfcFCMcI7DZlgLppZJLIaZ61JalDe/hFsu?=
 =?us-ascii?Q?A61tPXbO9q8DIi7gd90bDZULDBSqqoIfTstfXLs+6MB+iwcxDzHSkOKKoVrU?=
 =?us-ascii?Q?jlh+Hyv1lEVif9/uQe6ywQ8OPsf2KTH3I/tIEhxE2ZgYOuUQjzeanQkQMQRi?=
 =?us-ascii?Q?ocJU4W8YNlSANyLjciVenvAmzBReEAJYufR3LhFiMRCI6pLweA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yphClw+BI2o9x4uDxRSDZv9JiZS3cOtO50VFsLmwg9k2itO0cXeEoB2NI7yg?=
 =?us-ascii?Q?VytBi2GQ+mglmz/5Y/R55S/F5U3rWP1DrS0GHOHknEqb7lV1YxZSaNdlM+PK?=
 =?us-ascii?Q?HG1XAS7brlElzWC89uHCDx0sWI3a77Biu0rJOlaZYOHqe+qYOvskxNr66cdP?=
 =?us-ascii?Q?7uUtczkgpXlNGm0ljtSHXS2DULpFw1hOGP3g01UnKTx6ahXB1LRovwrFJXHB?=
 =?us-ascii?Q?Ja+dQUOoKb2g5ybjs901CkbnhdyDW2tXSipNuM7NEEzvH4/T+r9jq0LEs3iX?=
 =?us-ascii?Q?6GV7HmD17CSZXOjzhqxsRDNxDIJ3IYcSpqwKffc3K+MW+nKi3Np1/gVJ/QQi?=
 =?us-ascii?Q?Cr2WG+vpOqq0QoKhYMxI1sOGU5Ft1TEhpp9BEjihi8tTuhhzepJfp2cNrkyr?=
 =?us-ascii?Q?UP10U+SjT5MxRWlbV6006zAto3DFbB7SaagZil2nBp2TnxrR7iA0iQ9PuIUw?=
 =?us-ascii?Q?IH9c4uBY+ZXZ4TaC4Cjp9U5ViJuVJtmFIJ5RPD/ceddHUV9hwkYnBlAA+ia9?=
 =?us-ascii?Q?gOVFWecGGObQmOlJ66CuXB7d4mGMnoqDCIlDdQw3yisWanVOkhvrZ+fTvp5i?=
 =?us-ascii?Q?9zPQp8gv07c0ZXfetkOrTMLuZs18nY64p7K7ljRb/GKgUgf+ecWBvDP2LRGn?=
 =?us-ascii?Q?CTptecspX+AVCrIpfApmGnL2edtXmzAv2hLeMi63vyCzAr3uNqNKaSPu/e8X?=
 =?us-ascii?Q?ZF7N8I4Jub8i5aIcQQeNTXBrNNdAbp1yyQWhpQh9hr59NI3KaBG5UES8dEYj?=
 =?us-ascii?Q?Ib2hgP5iwNc1dKQDz7qDjiYU7mCNMWqXgr8xNduxkiK9chvfp/8EcapMqIBJ?=
 =?us-ascii?Q?9cujg6v07dySgyXvOFTXwmiSaESo63Ly3LAwvrgXHllFfMTD5S0Q87lP+NQi?=
 =?us-ascii?Q?P+REzKi+1cQMhyl/NKpC16XWNotHFPi6uuALjEUh18j/xsueCT58zciLYUY1?=
 =?us-ascii?Q?krNIYNuu0qDvt3Kt7kO1g//pVpNvWfgcSRmSwSeG+COplHBge6GuwppP5SVM?=
 =?us-ascii?Q?xk56XK7/rTR/okRL7IoBssvWUyiPpI6Q0qsPysqiJbl4gsvn87LmnaO3hHjP?=
 =?us-ascii?Q?ZgbJSXzdbBnrJMwcWgH5cuP7ecQSM8laxEGR96LhtGPfLx6cmBczx7uWotgD?=
 =?us-ascii?Q?M8qGulu0MzNvV2CBU/aY2zktm5sdG+yno6pMjqJeaiqpCJyiCzU6ftBjbRqY?=
 =?us-ascii?Q?iNmQVFuwiEvh90LDB6Cb60rEUtJ7jJr2snuOaMBukkin26ClGPqGwPV+Id0w?=
 =?us-ascii?Q?wvd65c4oA1Y9ErLVHmBSqQNA4V9mKDY2fwyiQoy94Lk0+2xo3qkZS8MQH6Pr?=
 =?us-ascii?Q?vnEapj2CqcfwYjghjcABFA4/OwqZK36mjDItwkTVLVf0M+rqiNAwKkD3ZmC2?=
 =?us-ascii?Q?uLIyIkAgqx8B+vi0rne99R+UgW0ueUz+wpQeTXHrczZJIC3AUep5xun8Wc7e?=
 =?us-ascii?Q?lURGrF09p9/NIhfwljTWji4cUFspFDz9g6hdaamIr5Td4zJPhCnlVh7+Rno/?=
 =?us-ascii?Q?4fiEBWAlgoJZ25FK9XLIAekMHSc8V/uhcSHYjscu4AcZ0gRAyH1nlQivsWDR?=
 =?us-ascii?Q?G+u2WFpet0gTJNGK0n0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b24272e-e203-4e07-f99f-08dd924f68cc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:53:11.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wYohHgmjviQg/NDOeSxrcZkButWL5VFsC3cPlnd9N4nWHdxPPVAs+c6iqrEPa9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

On Wed, May 07, 2025 at 09:37:07AM +0700, Bagas Sanjaya wrote:
> On Mon, May 05, 2025 at 11:18:32AM -0300, Jason Gunthorpe wrote:
> > +Since each compilation unit can only access one underlying format at a time,
> > +code that is intended to be generic across multiple formats has to compile
> > +itself multiple times.
> > +
> > +In an implementation compilation unit the headers would normally be included as
> > +follows::
> > +
> > +	#include <linux/generic_pt/common.h>
> > +	#include "fmt/defs_amdv1.h"
> > +	#include "pt_defs.h"
> > +	#include "fmt/amdv1.h"
> > +	#include "pt_common.h"
> > +	#include "pt_iter.h"
> 
> What do you mean by compiling generic code multiple times? Including
> their headers at multiple places like above?

How about like this:

Instead the function pointers can end up at the higher level API (ie map/unmap,
etc) and the per-format code can be directly inlined into the per-format
compilation unit. For something like iommu each format will be compiled into a
per-format iommu operations kernel module.

For this to work the .c file for each compilation unit will include both the
format headers and the generic code for the implementation. For instance in an
implementation compilation unit the headers would normally be included as
follows::

	#include <linux/generic_pt/common.h>
	#include "fmt/defs_amdv1.h"
	#include "pt_defs.h"
	#include "fmt/amdv1.h"
	#include "pt_common.h"
	#include "pt_iter.h"
	#include "iommut_pt.h"  /* The iommu implementation */

iommu_pt.h includes definitions that will generate the operations functions for
map/unmap/etc using the definitions provided by AMDv1. The resulting module
will have exported symbols named like pt_iommu_amdv1_init().

Thanks,
Jason

