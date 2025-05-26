Return-Path: <linux-kselftest+bounces-33790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BDAC406A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9262E177BA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E820459A;
	Mon, 26 May 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouTo/+Ul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC091F8BC6;
	Mon, 26 May 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266156; cv=fail; b=gVP8VC2+yFMD/GO24F38gb/9WjUsJsms2FjmDDsieIuAvYBxJfPDDuIYGwFpG2n/7z6qhUb1ClE/GrWqXqjKe9BSV2c+eIhsBXVPwVEZlE3OE7t/a0bSsCRIbiYdxB0YibKoRWg4OVA34k1GM828opq5yZWcZOfoMcdCcqYw2aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266156; c=relaxed/simple;
	bh=6Q6EkrB+2oQWklyR3NxJGJUWWNNJJImQ7SVqtQ8AArU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2+urMQ45X0yvAuyc5n53kLzlVFGQ/g9wNQgNMYTU5pwA8An5GuGNmv+v/k6hj6uXZZ31n0Lrvt8xciQgkeTo5PE9v5qbCIvt4NqFRM/uXWmLahu40OLnjE6kXDpEHLy8mlzHR/Am+qQCHGicZ0XbER7awCxynGm8FNok4pAurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouTo/+Ul; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWHMQqZUp8QO0a8j5v1q7OSu1c2YwngVWVugqB2lukAtR1HW36QpqPe7ZBetbvCzZk/U8A1Nqv+YLhdpMH76V1pO2hOQp4PNDS7ItXFv0SkS+PpPGCVncARLaak1DUrePrVh39YsMCnhmWe5LQvMze5DxX9k496YaqLi3plGu3o8pD5pZc7iI7OelqxKaZcXGg35RJf/VHRv5LhW3AeucbDq4j0if4HqJ7LHggTi2Bxo1K0KLqItwZy9/KL9Qd6D8bLcVqwQQ1myn7Vo2OszSc/BF4CrIDMbgE7lTouyvqJZcZdEARXcdM4sn+5ovuCw3kUzeKTU9DZ9Jm7AONPuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8KCvv1XYcrzy2HINB9k25nyscmoZ25pcfj02MhV+Qo=;
 b=QxC5dluf39P9as+q/7+j0VUvnzZYycvjnpSWK64dfCNlXp5UvSbo3N7n+n03KjZxD10NY92QYDG8wph7ZFdUGKBA+INMvRWKX3rMKJa3pIEI4SdL9XtbGneSszdOqRR3Z4jrhbNUtGaWEo6bopH75ViXy7/z9UQaNXDccOapg2wmGRojcB+85v+C9bYPoxsQXwNsqRX8P3Vxm9oUjuUFpU++IuFmXS7fl2uG+BcagbFfKOqwznFamsAZoe/0SwmixRWNooEgMShD68TclOxUfdHnF8C7VeK8gBWUVYrMITFKnwVgGxIV2xiK99yxZrb37RXRBeBmdLPYNuOWWgYisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8KCvv1XYcrzy2HINB9k25nyscmoZ25pcfj02MhV+Qo=;
 b=ouTo/+Ulw3oYex+/BhhDpz1QwvN2tY5flUXNn6rVnfa/Qk3CSSpFBIGAwIbCTsO8/BvKzS5WP6qcCFKYnWDovS0WrCqXAa/6MD+OZSgAAKYMHM5RDDS2MowydDmJylYvcESB/xjSDDi4mhagR+N3G+x/uRA1uQDtP9OFZwqoLyoSCxMg2bGo62aGLDYO3X+4jMvpNexfQKBS3DQgfGmMrqmHdI1F67N/o6xqZFxHKrp1GOTiM/ke+erYhXAo9b8iuTRKHEVrueuTc+4Etohs3iOIB/OcO53RKjs8uQVJfTUSOyYmERovSrw/Pn/t5t3VUhSKaRBSO9Nfco0DzPetKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 13:29:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 13:29:12 +0000
Date: Mon, 26 May 2025 10:29:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250526132910.GC9786@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <0019943c-44c4-4dae-a175-8a5bdc02f017@amd.com>
 <aCt0/kOwCn8wZJG0@Asurada-Nvidia>
 <9cb7879c-5158-4fe0-bb80-91d5af6d3ad4@amd.com>
 <BN9PR11MB527614B4CE414911A181E25E8C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527614B4CE414911A181E25E8C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 700ef129-272b-40c9-c751-08dd9c594d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HN9j1LqeuPK5ixS8aeCrrH2BlUY6IkhqXwKxqNVFyFJ6DxZohzSXahlHFSMN?=
 =?us-ascii?Q?wVDlEHG8Is0g/zbyZebYPiZVJ3le5JpkPFnCyUMmUz8z6BNZZNHOmqMTGwi1?=
 =?us-ascii?Q?udzN5o7MBIPGyU2JqCHYG5fOiOcbMcRCkIRPUOCfgh7J4Y/RtZJh690MPRmb?=
 =?us-ascii?Q?+trjyvIvvIGnGUfp3rwoukc3F/KgXycoF3e1btuIoTEoBk7gVI5yM56RO8Fw?=
 =?us-ascii?Q?nzPu359MvTRe2gz7vLLgqoCb9nS+JqBw0HgSzyxi+Z3aXBkBEeuXJSSeBslY?=
 =?us-ascii?Q?eJ+ex15ChYD7b6MpBdWEB4nf7+iT8UtIGJgfB4Lr6W9Nxdz/2YDdvwb/FGzd?=
 =?us-ascii?Q?nfUJDGkiLIOR9x5jsgTEesPjgw+TY2vh2BDgVjs23cOP7eJbZZ7zX+1qpgv9?=
 =?us-ascii?Q?zh4vTJgPbinwtvT0MOgILgpZDl8IDKakrR6yefju/Yp2rbzqkClJq+kCz/1K?=
 =?us-ascii?Q?OoyZBwB3sQ2fSBUETsD69ACssbQLgl9EHDgeAlruRd1AjkF6JqPxWiST0z1s?=
 =?us-ascii?Q?Q4Qd+kqQ1bv3otooi+KMLuVtxADkUPzJzpnAyoFbE+v7Ab8uvfE6xvvIHxln?=
 =?us-ascii?Q?ppLWqPzWWhTgkHixYcZg4ZdFJC54qD0F/T67/XJ6u3ZQ01CJxprWwfINUtEH?=
 =?us-ascii?Q?TPN4j7NIUp7XI8wbmbLYPVhJDQK8MifnMEbIvdZdtkY6jypbf6hJ98rASm4J?=
 =?us-ascii?Q?tbf73mU5qMxv4nMeT2aGM9+xdrsnZoZGFvNPzadNdDHj9TL9on35h52FjKlp?=
 =?us-ascii?Q?bMLge9CoFfeUBT0gjRqPn4VMg/+IBe8tkpfv/rCXNsiss83OCzn+9nODjAq/?=
 =?us-ascii?Q?dti9mmiaZnh3NPDDhfiERyvpJHJcj/xd04kanlrdu3TAzAbhCuIwe4hyvJBy?=
 =?us-ascii?Q?5OTkOIeA5WfNrZ53ICajZBS1sNf36pAnZxgt/aUiggl3JmJrFpuT/FZ5G8t3?=
 =?us-ascii?Q?153lW+UyfD0AKrkbNY2Mvu34HoBJQYup2h/CR+Nvta7SB5czohjLa9wQ2Yrn?=
 =?us-ascii?Q?AP01im0k9OgAqeNmdbAUhkOq4v/dpTpiwbIDVE5zQSJQFn7gqJmlQzybJn3X?=
 =?us-ascii?Q?wmOueiJ1vo25szhSS8QTk3mfkwDFP1Gqyxrr7pPbC5uPAUk5u5NJZ6e6Ucio?=
 =?us-ascii?Q?HuryMbf2NTbaLooqu66YTPgFrk/b8ovOghhT8Ru8d/GcOfjFuDytneLH/fcm?=
 =?us-ascii?Q?LhYce4S73x0LT/56SdW4zU7Bw3mda3w/HKjTATclPnVgwbKph+pM2ppUzT8h?=
 =?us-ascii?Q?z7+gH+ltErH+H5J305y9UjIyMyw1D+zPSlTBnwsDoOa6GiEBkTwYPWdYP1zA?=
 =?us-ascii?Q?CG8D4ErqKudi+utnjc34ZHkOsjBG5vN23YCZotDLv8AI9jbA09q1yD6POxVI?=
 =?us-ascii?Q?+QE2ayoNvMIAVMOpoz/e9isGHDW+j63JdYNBuhWxmahbggxWJdTnKf8kp/p0?=
 =?us-ascii?Q?Uj5/rcQWFo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PHjBmlV+ERJZmg33n7dG8psvnLtW8YDosKUNoOt1Ehj0lSUZUkpinxDZu5/?=
 =?us-ascii?Q?1764TIFWm059w0pewvI3+3Tgy4yAQxapDLY9qYG+zAQNJKBqnf2RMg8/remg?=
 =?us-ascii?Q?3lZccu3Y5IA796u8RZrbQcUHcaHPRd/Dmqn5Gmh1LNYxCxaIwBZKd1+Eesvd?=
 =?us-ascii?Q?B+iNWhOitN4UmYEsS+aoyXL72ABXiok1CYIcqU7iPE2MWFCgK2IE9Hwq419p?=
 =?us-ascii?Q?DC0g0Yrg/70tPy3k9VSsQ1dpEsEm1o2ZwvBlWR3caQKekjhnstcC9NItNg84?=
 =?us-ascii?Q?cSLSQnKh+f+o80A3x7KoaceE0B4RqKo8HfLFSvv4QHhweJz5vSg8a7XGPHvL?=
 =?us-ascii?Q?dnNrw+JiqF4TV5RFnHw8Gp6N9VooTnQCbazS1jrPLWW4py+3bJJjQJlrsjzW?=
 =?us-ascii?Q?MptNI1xUawcLh9PFof5NILo7K5sbapSR2iVUxDMFun6FUtbm/Q09M2hZ/KdN?=
 =?us-ascii?Q?hh2BjFbq5yvt3kEEzAOenn6GmhdM09KNUgVSsudevaRKEz9nrHh0AyRp7qjO?=
 =?us-ascii?Q?tXKh6rolkHBds+QUlPqBeT+wgLJqJ5NNAEnZwQ1bSD2dPbES1CVRS82AC697?=
 =?us-ascii?Q?8004/nSlLQ+f8M79FdDZH9/zasRvolVpuXz+aMTm5FEKQ77hXuWOibWj2Ce+?=
 =?us-ascii?Q?/YD294LR/yVJaWadn1QbcwrjUBdMRMHCAjRj1DvQgN6woQtvgb66b7zM6ofL?=
 =?us-ascii?Q?+/SPmgYX+UyNZSMfydh+gyJnC+xpNRwGzhpvCS+I5wqWPWWLIwmLFgM3L+5M?=
 =?us-ascii?Q?79NNDamxUBBfQHojyvLE6j9a18BjfkjAepCRvHBKBTxUaDNrIGyqY0Yubv/J?=
 =?us-ascii?Q?JVyWSwB5yhLubGRd+uSomgGgBNiceRZg8MY+0O9rgzzZ4ganXepxXhuHUGiJ?=
 =?us-ascii?Q?U12GA/H40/fYpC1KKWem7asotwEN09YMdK1PlAe4vabuviCqZZ0WaPMbaKzJ?=
 =?us-ascii?Q?Wj26QMRRRTJR+vBaHgKOwT+TvNAg9jJmcCplHz6MpczFZVguNlTc0Cct/LGw?=
 =?us-ascii?Q?Xt6/0ovsMysYySl0njy51LyaCC2DKJ9oAeeV8U9gaqw0BiOLrmwcRo3TmorX?=
 =?us-ascii?Q?W0iNUBc/U78baHwxzIjMkYMi7hrrsipIi2BJQ2NoGSBjp2eKnXznD1cMnGaL?=
 =?us-ascii?Q?jnTbQb5ewOwrQGdzL5w5THLRipns/6WdeQ7IrK/whj5CNlJNubNdNHWjzb3a?=
 =?us-ascii?Q?PHKQjXpsFiW9bx8S59xIOjdqzJltk5j02y56W1AQTg41eucMoeFRAVmOdxXF?=
 =?us-ascii?Q?eVgsaA/mVZlH2Hh+D3ZZbsAMB39t34m70e5QfiaftOcfHkMjBPSejF/lQF+p?=
 =?us-ascii?Q?VswGB7cW0ctJlKqxdOOsj4zZD2cJ9ApxM6YKWDDgnWSiT2SMpyWiu5d5unTb?=
 =?us-ascii?Q?mwvNLozyL8TMU96TrCqA6dadpGeRVhiQ4WzQT3DJWYkw7T4WAZDrcgIzqVIE?=
 =?us-ascii?Q?Ayj9SpZyaJEGKa2R0Ddhv3U87/Rs85qBYKph1l3pmzzie5jHxEpCO1wvjoCu?=
 =?us-ascii?Q?vdTG0CBUeDUIsaCweoOkgw9AGhvkFdFgTBXqF/s3Ful/GwObvy3l1Y9SqWXc?=
 =?us-ascii?Q?8Tff9Xp6ujUMMNNPOBUDFtLdxSZT0FyRdqM2YQjh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ef129-272b-40c9-c751-08dd9c594d3c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 13:29:12.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqw5XTlluWhGwe0/yjGqTrntL6O/t1MWuGEJW1UADKT8mVYWAD77zclrX1mNYwhr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

On Fri, May 23, 2025 at 01:51:25AM +0000, Tian, Kevin wrote:
> > If page is unmapped then stage 2 (Host page table) gets updated. IOMMU
> > will not
> > be able to find page and logs fault.
> 
> As long as the fault is contained only for the relevant queue, yes
> we don't need another pinning from the driver.

Yeah, that's my expectation too. If the guest uses a bad address then
the fault should be logged in HW and forwarded to the guest. No need
to validate the guest IOVA for queues.

Jason

