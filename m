Return-Path: <linux-kselftest+bounces-41957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21648B8A0BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 16:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9F41BC2179
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD228313E31;
	Fri, 19 Sep 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEA8enM6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1630F541;
	Fri, 19 Sep 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292942; cv=fail; b=taCnHNjdJmfZgIuvwKUgkAphzyY4QHxEokoJ6P2XG3/kH7ox3Pg3DBboCuNNnpB4sahDklLdoBi1KL6XiiZRVg/165A5/yWZj/7IEjh2gV6KG3VzFvT0vbmhBI4CXi4JvXa+tw8IOG1/R81LSn5gH6SPzzkH134+QBxtAjSYZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292942; c=relaxed/simple;
	bh=AD+MP9MUmCCCol0x7x40WM+wWGkYZdgKhxhHzp9be3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ns8uW0yDTow44pzNppxX8rU8jYp3N1M/QMK3p2UE0OwYaKECLytzA7DPgCkAH9ZOJMfcv3zAdJAGps+L6/QhVBxafs1JWsKhpuY33P4dIDMbBYSGNe+KDc+hCvbaYML/KewsjGBdwkQDN1tgkQOMkyX4lLE/3+Nd2j9T9ikPfGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEA8enM6; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okmpCmCe2TUd7f2veDc45GhwdT1tang/ufFGGbQ6CsXsZQ+niPHN8ivRkNIeiTxc/5OySWeU66UdhWv62WQ/06viufj8jD/FyYECScD2pk2I7fQX0DwMLixcWT17I/zMJC8o50jmvdhbD+85C0zw37YMc0mS63HCmxRTZRblj5l5pOzNfiZFeEnu+bCfDbg7t3RaRK/6S5bMA9/+7479i7LtRUqFu42YmbxAT/xgUbVKPVeVjriYtXMa3YkL38yHBHQ5mS2rYpuPtVavJBSE8ylw9FPaUlvXpgd4AAfQKPQG4mCQXPfcx0cmW87mIkQdD16t5uzWw+8FJWk1XzlyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFdh1BzzUT1IcP7mXi7OjuBVU2ldq6pHnuYuroSoLCE=;
 b=r8mEcYO6l12ZvdY1smasP001rgK1KHWQiC9fLXsVIt58y7VgzD0AgHMgcqZcQi0gDVGvXou6ZyZ1XIf/EE9xLaVbjS14Zo/77k2j6+AGhJTa9UJAgLhCmpo4GTRsfSKzqPPWDSldyf1rSOB8xMFmpzwfTptzjaz7lujOEO/2/9XOL8Z5sFdBo6sDkkb/Ep0irPrKJBV9UV6IoD3bD30NtdoZtkh8/5RZ9SXZ+5xdiKUh2db/GNn90hIKbatJPOXO36alm7MmybM+vD/xHnkE5J04hm2/tCCtyPe+4MeBilaOofQgziSfHGka11FkbAUq844uyhruRg13U2AXB3z7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFdh1BzzUT1IcP7mXi7OjuBVU2ldq6pHnuYuroSoLCE=;
 b=DEA8enM6rLBVaQGCa4Gh/PqYpIjrZ9csPBsUANjcs5AdT63N9SGN9XGrtzzCIdgxzOPMXLzn43TE/V4aZCYR/krGnMiktfTWrsY5dyR6ximE+W3MQl6ZKq50WWUT1tDko8vD/NU3758Mcko9yRBWECcyadQb+QhusNX6C2TFXZfZ+7ffkCcsTTU1PVXtfjj6s1/+e7Z+jw7vynCn3GJIiOCbFfggYFJ1RAgNrQziDJS19dejwe91kVOZkHcOLNQ22L1sFOKM6CN3AGn3u+sg00A35g18nZumVbnsZKyc+Ix814o4WqerF7iERJmn8T5mpHoyvMymuwt6ZzAzB6xT0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 14:42:12 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 14:42:12 +0000
Date: Fri, 19 Sep 2025 11:42:10 -0300
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
Subject: Re: [PATCH v5 02/15] genpt: Add Documentation/ files
Message-ID: <20250919144210.GD2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB52765D0FE4A9CCFA3F2D73208C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765D0FE4A9CCFA3F2D73208C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a09c04-caef-4f4f-0ec2-08ddf78ab82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDiEzCaIa6RrevtLdbyOQJ1l9/MkO26FYEcfbGbrXh4S4/F82mmfREah0Ln1?=
 =?us-ascii?Q?tDhPl8RVspAutAX6UZBWKgEAQ7gP8s9TDWtQ/lalCA2VvlinXTYWD+Pkjgor?=
 =?us-ascii?Q?Uwk9w4dsgG36hMv5JQh/EFey/xPjtsi/L/hKuZDzeD+tD8m1rRDvDO+ljnpY?=
 =?us-ascii?Q?laacUghafFrdcjZnuBruYKwA0Gy7aTVAqpbG1d6VtrhelE6RcjNR9A1VL54t?=
 =?us-ascii?Q?jFCff147t6FFAkdmRUoEBOHj6jRzpMiilkIShckPWzel4fJjki6YnNQq0Va2?=
 =?us-ascii?Q?qxuui1uuNRGK/EC4NhpJ35s9k/2LkWAOXpfUVdDwhjXu4dhIKsyL+rU0SedS?=
 =?us-ascii?Q?gZDHPAQiKI2C7c+XaWSUMnG0gxF74D+dNBxfPXDv/mHc42wFhw1XENgYCyiM?=
 =?us-ascii?Q?e8ViBTGD0AbCszGp9k3c/tUwEnwSZDkOxMO12CDQEt5WgJKBS9IlhjIr8FEG?=
 =?us-ascii?Q?2KHh51tjFf56PM5tAZW3y5kC29bbgxvZEuN2R3JxVvArZiSausuCNR+O9uDk?=
 =?us-ascii?Q?9M+r7+/2g4DqCiX3wdZcx/40uGdD6Jxzgmsq0KYaVcg+m+6aaiQgWOs20OqJ?=
 =?us-ascii?Q?NjAp7tUO29FdfmPLr08MXvDcXXwaEH09mPgpF5eWb9GdfRn4mD2hwzYnr37E?=
 =?us-ascii?Q?x4IhPl03Cqfdut9FSSaE52mDvAl/19L9p1lg3cB91Exszn6ft+VSNoJlvXoi?=
 =?us-ascii?Q?N8ICi0um2rRy+X5yk2nPzkeDJvD/zUnPsELXi5Cw6Wzjq4XaV6lxpLTzEvj6?=
 =?us-ascii?Q?egzsBSI6hj+qixrXnKy7XWLL240xFPKUbTYz4j6UFJ3Khm0xAvjbbdA9uqov?=
 =?us-ascii?Q?K/QXh0HAGuv8BjALuCvtdVkmuNNWW3tU96vYWjwIvk4jGfZUb0bxay87jd/p?=
 =?us-ascii?Q?7NOYabY6lkWGHbub+ih0owFu6VZtvKCgAhCD6whN7B9wZyLBxVIvNdjUicfz?=
 =?us-ascii?Q?yFv2kOzFZrL2zdExN8BtdLskeTnTeQ4YxReiezz5tpNmTts/ighHGPphXz/Q?=
 =?us-ascii?Q?XFnFC1vXgQN2esWXmmGHA2+LAUbqRk/4Bvs/Ex8xe1bMckuOo9RGVDyc8auT?=
 =?us-ascii?Q?Fge+7+gKiTc30rR2pNkq6Nhq7q1wN7cliu7wXPs1bXeZe9Gw4/97R0kWEB9i?=
 =?us-ascii?Q?nzH1jgXqfnMblgjjOjQHFsJT8co8LuGumHPrrWoKrtUpEiQgZt75cl4ZUrOs?=
 =?us-ascii?Q?AST9PnVuqn41dwGJiYLdvzL7O64q5ssL0WjQNXRQ0iq4bsrmEsh3Tu6HT02u?=
 =?us-ascii?Q?NgiOVbXPweJX0uUh3F3/kqlegH1j+eaer88mrXsvRQ1WBWkiF8Lg9bxsQl+B?=
 =?us-ascii?Q?lS7JdzbCinfKH5OLayK3xPDmVFd1rPyRaUOQft7gBF4iEo78n/r9L2NLlzQm?=
 =?us-ascii?Q?WUjYPox//zXNFGTUow13GXqFAjFqFrSNpQbrh3DuxvZJ3grzbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZSQmKsJiFxQf42Hzz5A6hJi6PeCpb/PRsnrAdhVx3pdxDi/JHFjGBFaK7HT?=
 =?us-ascii?Q?h1m1TkksGl5NBmYGXdPoIzTcq9VUQx6Ulo8fTlnFrq4RVzhU7jhk6hftoO6w?=
 =?us-ascii?Q?a7GgJ3jfyc+5a/X7ScBAfeZN2/pdwMLtWQ7z+H2n0AMI49tZ1lkWdv5zVAgP?=
 =?us-ascii?Q?DAet83iTnkmJ0sSU01sepkWpB6+QFUlaBOjomk7h7eVTcHdVSAbdYbyNnpTa?=
 =?us-ascii?Q?MNUovz9Usv8uhMnuAIXkyUsJCzfCfYFpvx3J2Mz6VgE9yL2RWZ/lOKPWOz3a?=
 =?us-ascii?Q?uHefOOENDD0sJSS+eWR0erjzyVmImMj0srXX5LL018wTLW9moKr+3+ct60/k?=
 =?us-ascii?Q?kXagM88bnzyN5jyLDLBWuqUht1WfzezQCLcPL+/Lc8T4iwHS+Cc5PTI37OpW?=
 =?us-ascii?Q?Xbqloc44zd9MQLw7oJWp/LiO/qyvPH4FxJO3xnuohDMnlzgcTLlAeuaPeDA1?=
 =?us-ascii?Q?fnbFoOnYATGUZrKvX0r3Uuh4APVF9gnT3Jrk9acWz7hpvJrjMBltJygeIlJJ?=
 =?us-ascii?Q?+Y4bj1d+o4LRiIBtnAS0ql+/3pS0IR6+2Na4J2a1uZJ/nwGw+obnBiXydswo?=
 =?us-ascii?Q?1f3CnUW4+5Uk7gz2zLcbtpFFzG7HAEP8PFFU3Cbgy7wYnigIjvbobPTlj2Jx?=
 =?us-ascii?Q?qrGxgq7Wi+NEj1fEKr0enO9vLvfAIaibErwX893Buxe3TRrJeAErgUau+N+U?=
 =?us-ascii?Q?z8FP+KwIKTT6+oiH82C6nN17XgeV5xqWpIkGOhmPTJc+QV0MD6jsQ3wOui4I?=
 =?us-ascii?Q?xXiQh2GDZzbg/gLt4YnNClWPRRAEa4kMmPzb5iU2rEoPigZGJrTtUceH/w/q?=
 =?us-ascii?Q?pjqAkSQhIuKUegR0rVHxXivZZCoptys8d2VHl6OARsG8GH68ghP6BcSout3m?=
 =?us-ascii?Q?NxUAjhgZ+YiHU7A1WmGg9yzO2IP5Z3GdeY0IoebU6+TjCa7Yy3Ee8cNanxIJ?=
 =?us-ascii?Q?33oYEhrrfRoCEoij+IJ8cqVyw+HPX9Aytko49kRnEyiXdTa5vjYiPIhs6/N6?=
 =?us-ascii?Q?P0po6jI0wH8y/a4MQulMYUE20NpB8Co5j/24TGeAZDvB0oypqXqF0SjjRJRA?=
 =?us-ascii?Q?P4hhqyD4Itdd9l9NExYC/16NDkVQuLGF+vFAB+071YMeonQ+URbPEPrJ7UcA?=
 =?us-ascii?Q?8mHAM1Jz3q4Pihgv+42f7sEL4/HQO+Q4upXOemYCxOhMhZg7W2sQXjfqRy6B?=
 =?us-ascii?Q?n3ySF1tDb6fvZscBAy+m8Ai8e/hBWlRpXcrYQsOcWJiwU7Ma9JiGYT+6Lh6+?=
 =?us-ascii?Q?9zlQWNu2rIiGl3U8MREf03N7SDB1XezoqMzEOXYy4Cd29afPyarnSRF9ypAK?=
 =?us-ascii?Q?e629o+DXzIbqVz+GlJ9t3UXhJq6bX/ygtpeEJr9QMpvMmrlteSNv4UVJ42aQ?=
 =?us-ascii?Q?pOC/Mz5nEbVSn3Z1+9v7aqGJQDd/p+XvyDKqMvIBOpNUmzDckZsnIYtKanXD?=
 =?us-ascii?Q?O7AacJcqJMXFeoRC+cDcNMiBAvkzi0HowOK+9eJ4aAdDQLspmRTJ/zHkogCK?=
 =?us-ascii?Q?k3hjNyLkF9c4spsiQuceePZ3NQkes4skF33LQzYdHu7CJuJWNV+l0BdEVr0l?=
 =?us-ascii?Q?P5AsjU8eooYAzUkpH6uIHsejNIUiZyDH0RdPLKro?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a09c04-caef-4f4f-0ec2-08ddf78ab82b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:42:12.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQy7l1eU2TDUkQBgM7tK5AubfDFvefOAd0e0/eKhGewGOxBAxS5tMFDysP1nNVgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

On Thu, Sep 18, 2025 at 06:55:31AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 4, 2025 1:46 AM
> > 
> > +For this to work the .c file for each compilation unit will include both the
> > +format headers and the generic code for the implementation. For instance
> > in an
> > +implementation compilation unit the headers would normally be included
> > as
> > +follows::
> > +
> > +	#include <linux/generic_pt/common.h>
> > +	#include "fmt/defs_amdv1.h"
> > +	#include "pt_defs.h"
> > +	#include "fmt/amdv1.h"
> > +	#include "pt_common.h"
> > +	#include "pt_iter.h"
> > +	#include "IOMMUt_pt.h"  /* The IOMMU implementation */
> 
> "iommu_pt.h"
> 
> btw in reality the C file (e.g. iommu_amdv1.c) is put under fmt/. From that
> angle the path prefix above should be adjusted.

Better?

generic_pt/fmt/iommu_amdv1.c:
	#include <linux/generic_pt/common.h>
	#include "defs_amdv1.h"
	#include "../pt_defs.h"
	#include "amdv1.h"
	#include "../pt_common.h"
	#include "../pt_iter.h"
	#include "../iommu_pt.h"  /* The IOMMU implementation */

Thanks,
Jason

