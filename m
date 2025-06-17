Return-Path: <linux-kselftest+bounces-35205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE0ADCA13
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77661178755
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703C2DF3F0;
	Tue, 17 Jun 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkxatrE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FD293468;
	Tue, 17 Jun 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161349; cv=fail; b=QtAJjOE+ZGnOSlegetQoVptgxMb9YLbMqH+2J3/m6IWk2yEK6QXg5PSG2GXPTHDc1dvKfSNsAaLOO6A5Osufv8jrpXj/wAW5ZM+/qeCtqu0wNaOarMyiOacA+andre7hPulAOUw8flntMmk9d2ZfGQpJC7l9g7cW0jr2TAGrKWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161349; c=relaxed/simple;
	bh=MF//h/76Pxbe34dqp3uOtqjBtYMuePQrwrlPJ3hEKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFzQpcOg3Sc+3hkyEOwYPJwIsgAdfuNVsYLgjWzu9JiE1PJYa6KuWuvau9Am7d1Fx+QAK1JN17iH/3hlVHo2fwiU7u72HS43F78+/k/FuIV6hXrSQrrNoIVRgK3/D8J2E2hLURhGCr/Se+TohmFYuIwB18M3keUMDLzJrepgPrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkxatrE3; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzgR4im+eEB4nBWVaiHYQzbM8WWAqSfzzsx557xCF79Ml8+QSr5JPgspuqiYLG6z21P1ck+2zShLxcYXfrCagnRSdZXzMClvhsOngHm7BAlQJldqaRor0ePhha9l+1hrFCCIL1Xabwglq8andn9r+G5MXcBTK8PzJZfN3WZqkxzyNfqx1muvLwTHeAc1Z9rdbCu9BSpwNqxYY8bjt4OOlStK1A43eY+zG7UM5DTSNIAjlWBugiJ11vavjBjCvcxGRTKAEjR4XgJcgI3JZrYLPVHiYDBx9CHY9PU720TQQWnoZRQW1+KeHJZ8N4omsnfB3yGN24Mzw00vnnIKw1L7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWqRVKHWTC4R+JN/f03S5SSHmVzY2KCz+hRHOyDZQfQ=;
 b=dHZmqUia6CfzvXW7skPcrJIFEPHwf5uaZi4Jm3pc68m7gjlANpxbVbkKZmYaV6XpLP4P1RVB78WhA9xWU+EqpKWa0DOmF1dKA3D1/90NA9wdQrgA9IyEvYCKHEoQYpv30pozYp9d7kPJHRvWg2OtEyFlid3pj0J/cV2LkAjz8UlG5AeJ6CXUmiqxOmU9wD+lH61wMwXbnGGdCzZvq8Iv9fs8a7HPLzOYh7PfW6p+QDxbbZMiQDVLO4KeYCecMFMPN9T3t1NusGKoyak28jjesU0RKcsoTU1+5r18tIiSgFAkx4mdfPjIF/0E8Fl000F9ADAqkxxz58OUrHmzO2ZxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWqRVKHWTC4R+JN/f03S5SSHmVzY2KCz+hRHOyDZQfQ=;
 b=lkxatrE3Gf76aLX+oaHifSL62ZOLlpWnC5AxlGUwr+B2Xx1fBDmttQ8Yc/AQINn36iJIaujf39LlKdXxqWGT2vWfiTK/iZo+MjWemVAW89nZG/Giu9NAZs3O38PAkaP59Wbw0SB/dMBWqpnmg/KZkS6il2+1X97RDYt9VJ75FG1BhuLNimngwf+yARCWImoBoxAueUF3DxcIpIjGEpMgh2FptfwiZAtoDyvMoQlxKqXUn7IEn7MLsBp5icmaZNEZ01A/Na+GAPghtGztSdGcYkzsrR5MdsQA24xkTMNgr9WF5tjY17iHlAUsI7GVfjMorPNyPK4IPluEkLs0+Oktyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 11:55:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 11:55:45 +0000
Date: Tue, 17 Jun 2025 08:55:42 -0300
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
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
Message-ID: <20250617115542.GU1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
 <20250616141319.GG1174925@nvidia.com>
 <aFDU5kf9lQmvNDdd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDU5kf9lQmvNDdd@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: b67d3ff6-985c-405b-fab1-08ddad95e41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GiSePe9moIfURthddT1xv/zInjf6YL8Q5AZ0xf18GoioAV8Ure1Mz1dfjclj?=
 =?us-ascii?Q?LUn9hAjUuCjXtBryhuwsMxZEZQK2X16KqKaD/p833/3nmnXUroBz+xXrB0E2?=
 =?us-ascii?Q?c3NaIDec461ml2pievxgbjkqzAmvXsXXkpVau3xjNLyZORSbfOO7eLBjZZD9?=
 =?us-ascii?Q?CrXMa7J9Mu+kOv8+a++g43TJclHHIbckj33Xtrgfk1RdOWR/CLuswWl4aneH?=
 =?us-ascii?Q?r+BG8q+S7zebM6FdQyKT5Fn9w2C3gmliO/IoWV8ugqlHhCIiEJsIlecITB+0?=
 =?us-ascii?Q?a8r1+lRx4rNxpulLJei0rU5M6W3uNkO9qpQcs6kuS3G2po7Qp/2kj2CuM6Zi?=
 =?us-ascii?Q?5U0ozeJOduq3v3QcJ8Co9tCYrOMJWgskUQbIPQ7ejdppGhaJ846EXmYbPUKE?=
 =?us-ascii?Q?P22yjCLPuqdGm6gEcbGkX+KWLPRFEQfERmZCRiHBm0VMzooKSjwgqLkx7pqz?=
 =?us-ascii?Q?HdFqtac6VFCqCm7qVZE11o0NP+HlZrx+GJaAY99dhSPXZdpk5v6hodRD4M1N?=
 =?us-ascii?Q?U6A57SgJXWqu3YTk5huuqjye9v5NMYLgWxm0TmoC5sb2HL3hO6yfwqDxA3tq?=
 =?us-ascii?Q?wPRUXnNdNO9iKpaY+euU9eG+0vXm5pWZ+SbL7J2esjTpAhWiryklwr8QcYIv?=
 =?us-ascii?Q?pi2iaXQYLm+jOlfdPTa/72ZAEK5yddKylOt1G1qeFzzAeBLaBjf/vqM4GPas?=
 =?us-ascii?Q?euPc4IgqPEfOFBisSfrDDvKVL98x6Qu6W7bao+5qsCf46wpejcqTEqQohXh5?=
 =?us-ascii?Q?5jRPBh/7P9zR4J0pSIa8cnZFRjixv0vLy6ur9RoiX95m9dQ2HsIehUqILk1W?=
 =?us-ascii?Q?dS2BZxJ5Mn6eMTrlqVSNU5KMbu6UcOWYqwb2hbkr0bWN9VsOZQ/n2OMDwjl3?=
 =?us-ascii?Q?3Hv3A4zQlGZRaobhJQsIoemBz/X2DT13oQc1rqsgFscytW/qG5TYEH/yPJ55?=
 =?us-ascii?Q?esioji1DyaOuPvKHZSMhJrMxb4wGbr6TuEJTpRh9xsYsvLAKSKhf1qgnR6Cs?=
 =?us-ascii?Q?MSV7GL9/lbJiC/R8iX6JNVrKKHRj3aP4Pfrh6KYRigOYbd80MMX/IMlWiOaP?=
 =?us-ascii?Q?Cw5j40eaGg42pzHunx9SJzMAR/FCdWyTfSIAAJBDa5i7+0WFpI9mF5V+sIK9?=
 =?us-ascii?Q?NyQR8bWm3uHpMddBCwUAG3iD1SIt43HsGVqqDX0yvRUxLsOAv/iuDqyORFPO?=
 =?us-ascii?Q?9qFW5U/VVu/FVwcomkrL10mlNGoBGvZE1jCjcFOsuK+NppDpJ0Cws7qb6udW?=
 =?us-ascii?Q?dfT+g3CcacI2N+3rpHklesxVAri6bbXXolUoSDGs0jrUorvHqGLtBB+RAG3+?=
 =?us-ascii?Q?cpMyP9b1aZ42+6lvaCrFtpjGLyJWMfAxaKoEEds3UsGjnhT6RP1bq0MW3qYN?=
 =?us-ascii?Q?yhPPFvdYEyoeQpsY9WYt9L2VN/NKXgY7ZB+DS8Rd/Wyfn7brd9vfMLSO5QIN?=
 =?us-ascii?Q?2XML3Q2dq1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROal3bCm7eDcx7N4A8Ri0NCWxw1OiePCNLfq9IUcLplGfZcNymJIaXU5FEgx?=
 =?us-ascii?Q?XadkxijjMxcvUCkoA6q9/K17aPdmoi8B3z0x9kBKHUog34ktvQ6M+izBjX78?=
 =?us-ascii?Q?CxJOe3ra1Ka8MA1X+Cr7KNxCrNj635YIegM9OO89/BH0ImSK2ti29Cw5YvEk?=
 =?us-ascii?Q?JuNjCeeiPW/JbqvyhrW2Hj11CeHWB7pB4mI6ozMdipYnxyb6Qo/6TYM7TPnj?=
 =?us-ascii?Q?5w5L8FgXqdMkk6gdDNsjiw7tMjTAN8J6643t3a6UWWJhOJU2SNX9NmdjuCq5?=
 =?us-ascii?Q?gD6SlEgJvZT5rPZPP9dYMLOqQXuiMWLZhhHtzPslYc9Ly9ebMfjL39rSlbGV?=
 =?us-ascii?Q?57JJWT5ilf8/skcXS90Dx5PomAe+07b0ASMDdlMKXz4IG6AYLEWbETcJ6sEZ?=
 =?us-ascii?Q?CU8cgkQTPWgKvR+dMdlJydptQUn9jb9NAOmykHeWh3QpwLIrLcqSnFZobXNl?=
 =?us-ascii?Q?6ho8ZY0TUKEwTGcIlwWsCgLtIvVGXTtNOJ06cwpGgo511/fKGp08GbQKDLoJ?=
 =?us-ascii?Q?dxySGs4aCsZzo3BbtSlwi7LmpFejxJPWBwN0SLzoBNF33rxV9PaKFt8/VpFa?=
 =?us-ascii?Q?tqUQfIbSN1awxBz3c84Hf21VfnYN+aQIQbFvjI+5gWsl+1DSAYFKsbpN6qNg?=
 =?us-ascii?Q?bAdKk316vA0CrRzU+42X8cx8t8fNAuhxciy3OERTxeeANJuH0fNJ62nCvHBX?=
 =?us-ascii?Q?C3DpUUCpuWgSJOLgv9eoeyjpNR8Hh2Iqt1Uu0qorjLLdqVtRtrP1VyUSk7sy?=
 =?us-ascii?Q?MzdSGDI7W3L4cA1CjBFAhXMKmXMilbNPQp0FMKtMF1YTv7VIjQZ75iTihe2D?=
 =?us-ascii?Q?0uMFGhMzci4a1TrOUGj8dy++2X8fC3n9NcWaAP5gdOfuiNorcwBdZvjPUex9?=
 =?us-ascii?Q?anH/rlHQfaCNIPGwN2PoLIBP6TdRv1HvS4A5CFZ5U4PgiCOpGKxEweH8Khb8?=
 =?us-ascii?Q?8ZZdcZy5vFLOPAkX+xdHeq/iI5jxZdPJTi+oBPRSDZbE6CLavQiJif6HIB9c?=
 =?us-ascii?Q?tacorcS7havb/j9HJ7N6CdzlEElI1QA2HK/ifBPRh8gtwmGSf8n0k7LVeJCj?=
 =?us-ascii?Q?NyzObvK5kHYdzva5WVmdvb4kuNkkBNsXdOsmlAewUyo5EjM22AfRgHfW7H0X?=
 =?us-ascii?Q?gG5wUG4IFobUqXv+14egiv5Uqrw52VenO24zVujV6oQhHNezsjVbQ7aAgygK?=
 =?us-ascii?Q?nSwSsvTtwsWdt6Ek5PPf64DdyyzVv14zxGrgp+AT3qkyySrv2PzKXOfw7bf7?=
 =?us-ascii?Q?0uB4NCiZ7AbccaQWSev0Alb8+3oK1945gmOAv/5tZnz0vXYPdk01ewQAL+z1?=
 =?us-ascii?Q?O3xuSVN+hWIhtJ8/iMgsnlidH8YZMUglwoZgi47zMj4bMxvk3qZQ/nEpKep3?=
 =?us-ascii?Q?i2aTfOe+jZR5x/Sfv2LapPMJA59WHC7oOlGOeXk742ZThZbv+A+cG0FDpaoF?=
 =?us-ascii?Q?tq4dsZGFLuJMYIYstwk5ivA2xboTwePBNgRnDPQFfZdcU8DXuHCyPx2rhYO6?=
 =?us-ascii?Q?9pSdq2CgyXq3I5utxlWSuK5sXwxEs/xmq5So0xPl13lnhL0XZAsix8q1j7oF?=
 =?us-ascii?Q?ycWD+/oE0OkTF93+L3yNcifQ60aOx1mkaTRu9jnR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d3ff6-985c-405b-fab1-08ddad95e41a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:55:45.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZZI143hHYofPTg+vR2MM3c1V4E82jToJ81SE7ghBhYgN43Zg1VTyrAc0KPmUOAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

On Mon, Jun 16, 2025 at 07:37:26PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 11:13:19AM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 14, 2025 at 12:14:38AM -0700, Nicolin Chen wrote:
> > 
> > > +/* Entry for iommufd_ctx::mt_mmap */
> > > +struct iommufd_mmap {
> > > +	struct iommufd_object *owner;
> > > +
> > > +	/* Allocated start position in mt_mmap tree */
> > > +	unsigned long startp;
> > 
> > pgoff_t, looks like this is already in PAGE_SIZE units.
> > 
> > > +	/* Physical range for io_remap_pfn_range() */
> > > +	unsigned long mmio_pfn;
> > 
> > physaddr_t and maybe don't use pfn?
> > 
> > > +	unsigned long num_pfns;
> > 
> > size_t
> 
> The mtree stores in pfn units. Looks like you prefer doing in
> PAGE_SIZE units? I can give that a try and update them as you
> suggested.

PFN and PAGE_SIZE units are the same thing

Jason

