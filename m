Return-Path: <linux-kselftest+bounces-42177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6579B99D21
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2C19C73AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C92FC012;
	Wed, 24 Sep 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+6mPlWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770D2FB087;
	Wed, 24 Sep 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716626; cv=fail; b=obFPhY6tqkamUrez3VeSFRj0yAYS+yDGl7kXIC+5IDGsfEMDuoqmjw7R5ON2bgR+bEMsh4cEGJnQGVSVerD4/fbNtXjm4WtgDIrM7TLb1nQ5hARWOghkAOiTayV77botNT/L6mKHxpKw5ssn/4Qp+Y5mDSEGYUiys0PYXzgnMoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716626; c=relaxed/simple;
	bh=RuNnYomZBMz3Jwa2TVM4zDxuOaK+32p2TtuEYqyIeAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vu4SQ6x3ItgsbC/kLxXzlQSWEjKq7IvPgyaglj0AUaoToIvY9ZqpFS6Qpo4qOLu/YEIIJezeb546g25erSali7qvEUJ2e1HjZPPPQSA8Eg+PxiEeoIgKLnjQ9PYs7vA/beizOvvQflVfASymTA1TUTMCJsYKzLgLew5RPgsMBdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+6mPlWk; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAkNGHG5OSJyakmpwvmda8FwLsGKB4jZSW8RjTaSGJyenymWBdtNFZglQ3qpKuztoULL81vwQhWz9IASXlkKlUSD29EmmXZed/q7/DHM2anFQIrnI5aoh/oWG+N4KmGDqx2y0lGICBElQ430o33OeVjhu+0XpcJ61dQEIeFz9aiRrxN01SC0EL9iXAVB6UXL0AxIoy01Z7xdhwk+TXfD2N4JGMV40B6KeYZKK8p5xn13Jhan/KKrHVLCRcjVlapv91LoZUolqElBmYMQntQMvXTPm41UAQjf0D0MN1c8r9zfoLepQwFQoICqt48vvWtkg7l7+18XxMEQ/YosFxhuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vdUu1Wklr1IqH3zxph+s0bzS1TS5JtKq0s62Wf2mDg=;
 b=CxkH45hMKlaWvpDXUBBYL8tMJGxUfcNrPJRAOANhQsBSDWq1JYe3ALwNJJ2ToazVYJDkA9uBD/JDX8xpnazOB8pqbgFqpMAXSWSeMhcK5vE5qlXpTNwpDYc0bQ7eYO0oxoPSE1cff+XEJ1h66VXCtYgeZBqpZD6F3DGfsZ6ZKJoCIYlma30CR1Zy5uTFTNygtl1gEd/+c5l5zcjwAmtEwmMTWDWwni0UceYcvoumG1lt0wje7pywWTXdSi0rgDdR522oMWBMdfpFlNpU2BcSozBWrKu9wTWstkfEtNGj7Ui+kzPuDx0WnmpK0HrLQmy7qGgpBf96lCAFBFRlUOxP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vdUu1Wklr1IqH3zxph+s0bzS1TS5JtKq0s62Wf2mDg=;
 b=N+6mPlWkik0u1kdWzJPoKOw29d05IwLFa8F7j632D0fb7ddEuJJeaUucZVMkvBnKbVQh3e4PD11iCVsIL9++rHH36DQ2JDEs358KzJ5yGMKA3XxfpXLkSvr96zoJwQnk3d+7yyqGJvtqcXZwxqt/BTdGuqcuN+c0ct8QYZcRAMAlpOCR+7AE2N0uJmkCuoef0qlt2mPQKDmnXhbnmL8XMrHs4+7AnEuNdeauuCZm05b7d8FkpTBeqvWMQABYxH3RWthxwViXsJ0cb5QHaPVd+1nOXqfkThdxmZu4c3rFGORQDvVQ8+R9jEPz005R77w+UZUCkxho9AclFJzIbsA5bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:23:40 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 12:23:39 +0000
Date: Wed, 24 Sep 2025 09:23:38 -0300
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
Subject: Re: [PATCH v5 06/15] iommupt: Add unmap_pages op
Message-ID: <20250924122338.GJ2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <6-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276277E4171547C0B5F247D8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276277E4171547C0B5F247D8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: ca53d86d-0736-4e96-2980-08ddfb653171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJa/Y7R0WuigLeInIWwPWFh9imkiA+riaraAg1AeYQtOck5hCYB6O4bRCllI?=
 =?us-ascii?Q?SugPJCIzoFuJBoVCRWqje0oIsAltIWgelVZDfK3BFv4pVX4UmhLTDTKEzYrF?=
 =?us-ascii?Q?Ga59HyGn/f8souf0ro64sYfHawwtonmUTHWDcXB3XwU1qo/j1xPVG0Qxe3X/?=
 =?us-ascii?Q?sHyQE8rtjMbptDgP8NtNuSsxx1HIUsz4MwZpL4iGdp/f7zeE0zu04iYgdyVA?=
 =?us-ascii?Q?NBgoFrjlqCYlI0PxfLMTUIl1hJDaz0bi7E40ql1fW1l1axA7fQ6QSeOS4Hd1?=
 =?us-ascii?Q?QHpszKM5Vco52l+H12zpJlT7fR8LKMkR2BJdtscMvXWnNtTXBEtCEavulvkz?=
 =?us-ascii?Q?qLFyGIDyDpG+YHM8MFTNxzF7YPr6XjSmPpPi37W5HWOWBQRhJ1VvETueR29L?=
 =?us-ascii?Q?hl6l5G52dgqeC6hgFssrepLHijzjK5HGMyI401bOGyDZD6TWKU5AsiUCNUzV?=
 =?us-ascii?Q?RndLTLb8q71jZau6HLU3LQdtPAoSdsB+T5Nrpm9ISUo/XGGomm7b1GYuCQCZ?=
 =?us-ascii?Q?VIiQk5eRTXG34a3LsGXIJEDc6nwEtpiPVUOUL3yeL/mVjSAQCF0zIUERQxsU?=
 =?us-ascii?Q?Yfeqn5Gc/2NcN9fP4Bo2F/QdXGmyHsHsZDCTjm350NR+y1C0dSwJf7/uy/v+?=
 =?us-ascii?Q?T9p3bBWKXHrKx3L3/MhMXoDIseGbpO9PGz6Tgqc6DVGqZ/wmaWpQYRWwck8X?=
 =?us-ascii?Q?sdx2X8fq+qHof2yfmzqy7+PfVC0xan6kJBAjgRvuSpg0cJ+Lu2Y7APnTX1DX?=
 =?us-ascii?Q?BJVo5sVVWJBPg+0Nl4RhQZs7EBs7msyxsnqzbETHbEj9yVe/OB+jt5Cd8pG1?=
 =?us-ascii?Q?LSj2v2dU30zzXRVajciQ/chX3tTLWu08l61sV0k2JllhaWCg2klGdZOg49/W?=
 =?us-ascii?Q?EaaAdIGVTfxxopqhOqFVYZDk77wTKALQrvrbC3lXBatAIKQUDElXfTVoFjlU?=
 =?us-ascii?Q?iUc38vh4cLAKsVlx5wBMuw1kViDxbUYK5kIloh0JeuR6nWlv44/H16G1Y4PS?=
 =?us-ascii?Q?OikfMefCRZO3QlgNwMwyutMiuzb0d/xvsrn6CkT/BifDbybHU4HUKR4OeVe7?=
 =?us-ascii?Q?oGXNHkYZYJqLt4olahMAeXr1YVTuXupeQCCBl00Qjbp7bItk51qo1dFXWwbt?=
 =?us-ascii?Q?n10+LN6XCND+6SqEaJuv5YEOsElnn8sLJwqwnWuxg5cIPcQFx2yU/AmeaOT+?=
 =?us-ascii?Q?0qGBG7WwCzznMlWukcasNetGK2XMun7mTiM1QeZTVMLqULEi9o/pa99WmafO?=
 =?us-ascii?Q?hddlza557BI9avp0ye8So3YNPZurAvuOANuo+gESGM0nDWBn3TnaTQEUKEHf?=
 =?us-ascii?Q?E3oZOFazWO+s7ltNanIsyQWVuwkV7EiU7BcJ9o3pfdcsUIDQhvCRQK09yN1V?=
 =?us-ascii?Q?wB04pEOmdidJMJdPyarLzaDjVeTiBzd268GeM1UoMs6jo4O7K9s7FTcTi2vC?=
 =?us-ascii?Q?LknnDLubwB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEVnwSks4gubGiFZVQEspJ7QVZYp+wp61bQRF/Pesys27zP8gHu29F548XrV?=
 =?us-ascii?Q?2PmCJ52zD8Seja7euKhVl48iVMhLIKDsdAhH/uI38pbL5bw+EMjVt4M2Ma9v?=
 =?us-ascii?Q?8SEuzxNWWN00AknBYz4dSq/WNfGgfE3q+kt+jFY/NIlMS8XYtQ2dqS+0/u2Y?=
 =?us-ascii?Q?XCnW5HH+z2UBVOE38UYDF3SWOgW7dVfb79P6lPC/bvAiD4Afm3Nffbc0j6V5?=
 =?us-ascii?Q?Umw/5gqVcGi2Qqbjg6C4Xwg1nLNDqE9Yh6zdbHOE617uKt+VjbNCXZDlv04K?=
 =?us-ascii?Q?CKE3v7LLhSvL57dg8F7nDsCoAohkSzWF9ySrZzfMjkEGSBBygmxQtiShuJIf?=
 =?us-ascii?Q?3OM63kPO5rVY/GE9qzJStyQJhyDLa/r209/IwDqEFd52+vyw12PdMEaa9Uzj?=
 =?us-ascii?Q?ATuaWyQvute0yfz5Xim5hhL45Yeh70jbZU0dM3KtOH3rvHvsik44qkSBS8Iu?=
 =?us-ascii?Q?K0opcEHJt9xeIAe4WgTG48XIQw742UiwXGa4AzCrnBSEokXeTNrE6rSH9hdx?=
 =?us-ascii?Q?tCCTjelVz8KUilo2nBWB5vv2bw+uPpdoMrUYnpI4u6dwN4jOGA3w3XdptgA0?=
 =?us-ascii?Q?TLCY4qUtJ78YZEThXaC+TDZhpjlVRnl1m484u+mx0JMoAfKmIwnOJ9y+jYYI?=
 =?us-ascii?Q?6aGLLUU9/Mm1tV+LO/tCSum2gcjfTjZckadnsVt4/2j3dNEJXQQrrOO2oXVT?=
 =?us-ascii?Q?VMLt61wRWrt+P0nTvgnCP5FErzM8uLEzyHdiH0Oj7XLTceGnLP6pjxJvlNpe?=
 =?us-ascii?Q?G+KU8Hy4DIX/XaPj68m/XRN4XTHLxjnxugjR4xxMIwHsSwcpCuHyfS1igEfs?=
 =?us-ascii?Q?e9nb/e2EjpqHsJzbDDAFUyo5ZtZi9/w5sLHR9as5SVrSe35J6QGjTjzXSC/1?=
 =?us-ascii?Q?p+c0fGegi9OLS9ZsleD410CN3Hg56Rq63M+r7Zll5UyYZUxIh9cdAQoJSSBz?=
 =?us-ascii?Q?n41FLVqxCexlKqj+grgnDDviYeIGe6uT60kwf+C1TRlxhNtcAJ2stjcG+Txp?=
 =?us-ascii?Q?uEmZMHspxm92mCYO4hObHJzqRVTkib9O+DA1IEE+Zu95tcw4nlTtXkENrf0n?=
 =?us-ascii?Q?UHKZur8DtMVuKBP9j4c1xqJ5FoIuau3XufJ6mM4NVl+K6shVrsdAXaJDDjJW?=
 =?us-ascii?Q?Yb7DYj8xnQsZ/m3PhcyvqQPG45HBPum8QSzxV4DhptZCY7GaoDbsEBAL/TxY?=
 =?us-ascii?Q?LnxEOt2J1sItH0gX2tZ0zaJiSdrgN/OhdmwDjvrA1SA4Squ/0WCTk0gpeEUo?=
 =?us-ascii?Q?Ik2ClzyWOsi16Yp+Z8chKbDp4kp02lPK9XeNBZzZtyqc/gYUX/XM+lNN+aA+?=
 =?us-ascii?Q?6QTaBUrrz55d8NQCF8iWFA3a5lWacoYFr1sTPOeCc/AhbDPjq8E2bDsPOXI8?=
 =?us-ascii?Q?JdjfbAz3asmY79duyaJH4MTM61GVfGG6A1B93x8+lVdVt0TXKDZlPLPJwTXL?=
 =?us-ascii?Q?tPVRNGJm50K3WPlJ0aX6wBFMajydJ9Zws76wrgq0a7c4BgiDzJfX5PeECyQ9?=
 =?us-ascii?Q?Cjhy533PO/pkXcOgBVV+Whk7W2XxVNeSNclFgmCr2HMmKz2cvbPpEaS0avsA?=
 =?us-ascii?Q?505J6V4YO5ueN5FoDefbozws9x9cvKJODXYGFX0Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca53d86d-0736-4e96-2980-08ddfb653171
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:23:39.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjrQYSpQpaDlSSWThH0hcR550EHU+MlBfbrZwCzDySYqGrQxjw1rn757DEQUFId0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764

On Wed, Sep 24, 2025 at 09:28:12AM +0000, Tian, Kevin wrote:
> > +	if (pts.type == PT_ENTRY_OA) {
> > +		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
> > +			return -EINVAL;
> > +		goto start_oa;
> > +	}
> 
> it's not typical goto a location inside a loop.
> 
> Actually even w/o that goto, the flow will continue to...

Yes, but this is a micro optimization, can actually measure it in the
benchmarks :\

Thanks,
Jason

