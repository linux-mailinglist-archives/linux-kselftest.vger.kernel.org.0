Return-Path: <linux-kselftest+bounces-14821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77B9485DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 01:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CF6283B0E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AF170A2D;
	Mon,  5 Aug 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LiRThIkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798716F850;
	Mon,  5 Aug 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900172; cv=fail; b=XsTpZMv35TpfvTKxeXW3+znQb05J8dG6bTZB9ddG7vpECmzzP382orlVOWh3dTPAuiTxbuPJOh37acUwPx37vSiJH+xJzM5/p91Jp19wY9IErJzhpBI4CrP0WgMRJGLrC8z7xMwAYzDskSkGEw7FB1jyhNzhP45pJHP+cVCg3Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900172; c=relaxed/simple;
	bh=hDhfzQyOi46IFdiK9QlSF2w6E/B9B7mZezk7+SsxzzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=szHrVglm3rhTkQBy3ZxYxpaouG71emvxBQT26XPYDUJjqrp5fGOFuf6RXVTp3047um+V5axngkFGWhhaZddN4snDnfEkf1IHe2zgmFUFwAvdEX+DwPPFznUBopSBAX+7s+croYPOwUWmmv89N2E1blDIZZb/vXHcehzU2PU5F+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LiRThIkw; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkzqeSPeolrWpcGcXpCqOitEQUYJeQYqdsPdl6Qa1w7sXLNvzkvgfWYNdZDHbUhYDhsZlwBFNsqdI9c8uc7Rfl1MvpmCw7PyAmpBg5j81w/9id63mtpk3KSbJTRSexe+Aj5fRW+jGjJQ91phad4mLT0fS5PgeQiojUd1MCuPNm34LsgyHeS1129h9pR2kCxVspUBvyrapDu3kkfRdj7cCHcVJ6t5d3YTkMkwxWD/fFg0TyFtKcowqFCql6KquPSNmjf+7VPP/vTfelIzXN/qsb3HhL4zlGkKU396wbB0MWv7ilSMoheJxdVNNL3jc+3AJfcZ0ROENRbhzSqCH02zzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gGkI9rlG9Urw9tFu5PhAn4nYrBKWtbgT5LPtu/WbdU=;
 b=jtEc3UfllzPfBNdtWtEAEaOvTleF/ctBR7+gG1PNvcehaYF19bdY8uWSE0EJetFXWmciPkxg5cfrnOWkB1L+/y9edNSjzQh2upZ0GVQOwTCLQUK+NJ6vlP1XqFdg/O/6Av2UTrfwrYPktAuyj9nO2/SQr28otqreVNfjTYl26qaLPz30ZSClqtG1wk4LYrcqOSn32+vaNq6jP24i/21Z8wq0ew4t+LBVazIzXG4tSvCO7NEVRLYQ3kDtjdMoPqJ6AuO1f7sZPl1coW553Xit9tWopUFqY+BSExpkolwmid1Ehg8JzIat6Aoy2J1pZ7MZ+KgnHdX2ksFEwG1X6TxavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gGkI9rlG9Urw9tFu5PhAn4nYrBKWtbgT5LPtu/WbdU=;
 b=LiRThIkwIEghZV7iSID7j4jhe0hRWeJlUxa/bmogrQM+lwEqgp2riC3lkYki9phRwsZgnyxsuwei/m4072jMiQ6JkspE5hfQ1cmor+8omNjP57XYBygHQOyTopmGhXpOkNfRcfmJmIbtxKJJN8rWtkLmF0vKI3pDTYBcBHHXfb0Uzy/Hzi8MirPJJkg+rKjnM1SfeXlyIE1O/i65S9hcEFCqbG+defWoFkQqly6Cgb1HwOSigdz0ezc2cEnBoUTHqsoE90OX1u6xw4nYVUZTbPOxlB/bZi/lUiVn++K42hLiWGnDYVA3qiAp5CWLzZatNnBJH+hb0C1yB7KWwDpw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 23:22:47 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 23:22:47 +0000
Date: Mon, 5 Aug 2024 20:22:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Fuad Tabba <tabba@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240805232246.GH478300@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
 <20240620143406.GJ2494510@nvidia.com>
 <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240802112205.GA478300@nvidia.com>
 <BN9PR11MB52763711D023C0A50171C2EB8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763711D023C0A50171C2EB8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:d4::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a692947-3e10-446c-8523-08dcb5a58429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ceh0GqEcLcmYGn2Wcvsi2mjE8nud11c5NYCEnz+b4H1PMiu69D6U1ZhrIzQE?=
 =?us-ascii?Q?jk03d2x2FczqHwVySHtARRc5fx8BnvJ/tgwjdIe0w+JtT0NAbecA6AopzbVL?=
 =?us-ascii?Q?LqqqtMviwvQCP88Kg+UQYVtVJe0CiTIuf4Il74n4mV21JySbAXiYkt677nnw?=
 =?us-ascii?Q?uPKSameTxn3oicxThZ6NiUuUPhMuJ5eK+7wn+DaYlxnhiXX/hgzlHVCfHHG4?=
 =?us-ascii?Q?uOQEAETYuiG/4cjKZB34M6Js650hBd+XRqst7b9FxZgIeOhu3yqbjrJwbmDX?=
 =?us-ascii?Q?l0DMvv4K+Z7J201aTave5Btqv/mouzeUSnOge/SGv12XGbrOwYEsAX7jPSv1?=
 =?us-ascii?Q?OPbjuq0bNusWC3s2Wgr1p9bRimUF2Sesp9WEY6bnAXNUqreDBX4pQOqbMv0R?=
 =?us-ascii?Q?mC8Dvk4RfDsQK7JYso4CbUIPaaNzqHj+IAEcPdlgReZuYmokj4I1ihfL/+bZ?=
 =?us-ascii?Q?Rg5Flc73Nfj0d9M7LChy5bUITnJnbKVAgfmZ83Ze2giwu8UuRR4yINnNzjSg?=
 =?us-ascii?Q?pIkL1eFfQKscS/VGyR9LYmkWAchCvZvXZfBWw+QX1y0mOXi1sWlSIA1NK+F1?=
 =?us-ascii?Q?ci/0pLw8b7os5aJt921i8FsCP+1YWCykAVVPv4iYvivdx8JsYu7hkHUt1n4K?=
 =?us-ascii?Q?TBbqCSqcu7q3ZCu9o10LNZjEbxl441iJIUCVNPp5LgKJ686vcH1r1ZMJfUW3?=
 =?us-ascii?Q?KgQZ/KXRQauPSK2KmDhNfGy1iKIFoyza/ABgeFxlnC5axBMITKotdxxCP0YZ?=
 =?us-ascii?Q?fsju+VH41i5c4VO/ZBUlypi5xiXIIXydpKhWO3AArFadZAXOpROk/bMNS019?=
 =?us-ascii?Q?LxyRMo+lj7c7JoxCpru4Nh+8x2RaBnB4e6ed3lq5HR9pg6EFXDSYI993V4K2?=
 =?us-ascii?Q?8+6PLdEklWfUZZKij5cpL3/RHeiN5BdcltE6Ro5J/YX1ybmu3GY+EI9Zee33?=
 =?us-ascii?Q?vbHjwjV4LiHvjHW4a0JxVQRtVGy+H4phj1TMsfSbP8OEgk4w3VV5pPaCIBlD?=
 =?us-ascii?Q?hqWiXasYwNdZsYZsHrJLQSOig+K+7KfP8tYSw1gkqH+xxm/q9/cI6QXJZdp8?=
 =?us-ascii?Q?BZaEq+IhK5U+9kQpbd22kXTQwfzaZjj0tLICjPWvsvYb+0xPbeGPsq0LlXxJ?=
 =?us-ascii?Q?4L0bqKFyU+bJruKBDjd2LQY62bdcpllsIMLpYYW8hYORgYo04bsRX6x6OsPi?=
 =?us-ascii?Q?9PX2His0qmbPceAoyQBVDrymDOgZjoXvu4jIz7K5+i4pA2g8f6/tUZvMr9yf?=
 =?us-ascii?Q?qED/t/rdeGitjMxtbg1gn/684+FdLMzXS1oafkGODDJtffrlrWf8+thPkgPI?=
 =?us-ascii?Q?YbNjoYXphbkbuL3htTytEzUnimAB08zRQBdFBwdALw0JGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3OTGZoLJEkWgbhC/RgtNajM9vHL6HWoPOQcjLbZ3AblSlw9iCaUtMzhIDmlv?=
 =?us-ascii?Q?fAT5QMifvtmkvZKq/Mw5HoTbzcWuOreX0JF1uo5LWCpMVX6j3bgquP2XATGx?=
 =?us-ascii?Q?hPCD+mlBYM/S0895kLjhxga9Y/CJS5Wnc87uyggW7IYE3lj0iJqvRrGPbGJk?=
 =?us-ascii?Q?I/YUraqzdjEjFrc2q6SV8n2T23jG2/LZukl37Ba/PPYKVUni6YyIgsJTDAsy?=
 =?us-ascii?Q?6f8oR3APgA2NqVCbt4o2IzIfBNf2PLVcXXNFYnEQNhBUC6UgjTnW12CBt1cN?=
 =?us-ascii?Q?/GIYJLo2c3H62x/r/AxeobFdq9gk1e2/RBVe57w672po2X24EU110BRxt0L1?=
 =?us-ascii?Q?0IPd5YLCPTAYKFqAZbfGOJM6/OUTVXXS7LK5WjhZfKR/USPOHv9kEkUJ+EGg?=
 =?us-ascii?Q?cnyHD55DKTTP+kxuBTfApuL3LjNnRUzLKOZGWV1Ss6OYVdKv5qAjYw5T4YjZ?=
 =?us-ascii?Q?kc16s1aoHW4MRGl9dz7EZAIl0StvXYIaHGQ1wM/3m05ut+ULy0sm/sV58EB1?=
 =?us-ascii?Q?7nC+QKTAmmnM/8GeOe2meri/NWS5anRQ0DVAOnG0jchJXBjZ6ATQMB1vxAb0?=
 =?us-ascii?Q?UV7lXoIFI9mqyudAEXccTpdACAGOnt7pXx/237PW4Vv/qSsM/hyF4HvEZPpq?=
 =?us-ascii?Q?EEV2ZhNKuBPmdzw62lloMmuNyq0SQftEGw4HRs3HuEUthqV2FpHNcqX2OZst?=
 =?us-ascii?Q?RN8shgArefGkhvidNaCrMDmkpdCaO5Qtm1TG5SpKcl3BrLi8axxIFk+6U4bP?=
 =?us-ascii?Q?CYSLeiPCgguFCwxvvnX42+AOG5ATh6Hj1s9n3E6QzPFIyadaPutgR/hBqjda?=
 =?us-ascii?Q?yirkFujN46XJw1AnqBbyxuPQgt1XGiLt1JgbEgPRIsqkIX76McsXXf6UHFFh?=
 =?us-ascii?Q?ITxpKRL5ai/pWW3Ds46S/WvC+PYRp93RryrP4lUEYqxKRVLMXLUk6z7lEzLf?=
 =?us-ascii?Q?Y4NzC24Jw6A5HYVIEkcZjoCB2kI8dMqxk6XZJCXk+fkunNmEBgZKWeK/4C3k?=
 =?us-ascii?Q?DIcU6WAORkv/IHaVIPKu/Ffhl3xioqA9qJXIqGLDXo4UnSPQuwc30Q/CRTtg?=
 =?us-ascii?Q?Sw9t7h4coTb6iOH2GqVkG8B5IOdda1hUvAC+yQc8O2W6hrhjuYTqK+2D2DOz?=
 =?us-ascii?Q?f/JD4ZO0zUZEbge2g+zNuLuw2LPSk44Ri8xjNNc4bB544A/jMxU9sHZzSmxd?=
 =?us-ascii?Q?6OUDOaPl9rDLFG1EtyhDmZUJc9NlQxxw2AvBL7oY9eggJe0ETrd9OHJ8p1a5?=
 =?us-ascii?Q?+8DNBifruYO40yESgoiL1Jffmv1bZno4wk3Cwt2kQ8jXAyVbUF0wgRKCeayC?=
 =?us-ascii?Q?sRUw8G6XRhyHuT4Nfyn01YN3EGlxf0M8tA1wPmgZ1Jkq9ZUa0ObfY5OmG6vC?=
 =?us-ascii?Q?dMbZSLCNU6mkFKaGyaymQMUqbABPyhvDxxBmdUm/KOpNRtC2/gjQkzpsXmQU?=
 =?us-ascii?Q?okZsD0TEDB3aR+qyK1nD9AU6Bc/PbhnofZFYCQDquhSOuaBVdC1O4NFYyfS+?=
 =?us-ascii?Q?aHgn6ErQ9McSI7ZrTwCuwmt2mOrAmfMpwIJRq4Yc69FhRwK0CYx5CTDq0YHf?=
 =?us-ascii?Q?7e61VbGLpx/NGRbcJqM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a692947-3e10-446c-8523-08dcb5a58429
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 23:22:47.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1yqoKreBlhMEWnMXvqKZ/LUyU+kZU2GbC/I1N6d7fZToCCOSt4o0DqDOC3ddK5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On Mon, Aug 05, 2024 at 02:24:42AM +0000, Tian, Kevin wrote:
> 
> According to [3],
> 
> "
>   With SNP, when pages are marked as guest-owned in the RMP table,
>   they are assigned to a specific guest/ASID, as well as a specific GFN
>   with in the guest. Any attempts to map it in the RMP table to a different
>   guest/ASID, or a different GFN within a guest/ASID, will result in an RMP
>   nested page fault.
> "
> 
> With that measure in place my impression is that even the CPU's GPA
> translation can be controlled by the unsecure world in SEV-SNP.

Sure, but the GPA is the KVM S2, not the IOMMU. If there is some
complicated way to lock down the KVM S2 then it doesn't necessarily
apply to every IOVA to GPA translation as well.

The guest/hypervisor could have a huge number of iommu domains, where
would you even store such granular data?

About the only thing that could possibly do is setup a S2 IOMMU
identity translation reliably and have no support for vIOMMU - which
doesn't sound like a sane architecture to me.

It is not insurmountable, but it is going to be annoying if someone
needs access to the private pages physical address in the iommufd
side.

Jason

