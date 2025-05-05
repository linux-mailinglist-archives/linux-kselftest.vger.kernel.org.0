Return-Path: <linux-kselftest+bounces-32387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA85AA9810
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3917AA206
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56516264620;
	Mon,  5 May 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JjxCEqEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395A1487C3;
	Mon,  5 May 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460512; cv=fail; b=T1Xh3DSf2IpBKitV80nyM8s4vqp/yGP24TqunIbOhnO36CiDUUlwpzWPKNkeGCcwom1e1I+eQQMWUAT+SeZiniV1M3hodXAvwcH9cNpQEbAHxWDxxyHGHFll3Drjqm4cFWo+EKZccYNUA346UrPcsA9p7ijceBKWgW2v/Isze+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460512; c=relaxed/simple;
	bh=5hdWaRE8SNXlciQ0ypw2SR1A8dbMR5qbmsdJemPPHHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYfjbtV1usipDwt0SjLch0dQXh/XbJynxCjYzc0NfOEZEO8Jm7Q8JR1Oj1sSH6xQd8xNQCjzoGZOyy26wE0siE94e8pKb6LRpke9H3HjLCx4QB3PmmHqWbh055oGR815A8oSv1zZlx/NOaM1WapZPuHcF9Kv1GTNVYnkht5b3DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JjxCEqEM; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FS8+k6qEFnIcofCF9fyhk96clyb5BUtXwZys03DwTw0pP0Asuwh38X5c//6tAxI4SLl2tl1twneIUQNhbBCjy0l+Fr599GeKWDOdlQkX23SAEvZU7Isb6SgMSEA58F3NlRzYr6cAUAiXcQjAPRh83JxvroXJ3Mgi2PnBOKZ3oiB5k3/VTwWQAU4INHuSCC+rYT2uMg7QsMvxAvtPBKxhG2LtIbccjEbWdb3KBtFLShn3c/A1LHLK5Ti9XrTR132j2DLUnwxbvSk5vOmPvS1Z9nBRZe9uOpL0GfcFNa4Xk2Zb/wu8k2mdl0E3Kk1/s/7x7AkoEuV5gAyuUwUmEwp6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siXMnVe2htpNyXVXFudrlLn/yZfzOdHnnYHFZGs49q4=;
 b=bKYgK6V830JpfnYI0pBA0PzqFaj8sG82LKlIzh9ZfkmJH4GG5xGCnbmMyxMSVu/oZTB7mpejJrTv00EGX+t2RuIADunaT8dMyDan8Cp15oCLkiuEb+o8/NKEUPTZHsGUG2NWMwyf9kJ+yU8SWSHFX9XvQUPl6VcXnU+LuHZaREHYDQHlYWinu2bC5rgipijgzNCsO1v+ioLyOt2VTLFithsvshlpf7fXwAiPWUgll/SHsqHO3KbbichwW8tqo3v+0BiNpNIDV54nY42X3EsO6+VJpH9RWqKsuDBnC92Xxcc7mLO+8vsuil0PxQUTJUxfIf8lVBY1vV1MncZqXaO0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siXMnVe2htpNyXVXFudrlLn/yZfzOdHnnYHFZGs49q4=;
 b=JjxCEqEMSr6/2K1mECMtb+ZgBUoQ57miWGmqBjRVCgXqbyOBCLTE9oA4CAHEv89YioyvwwHf6NEI+d0NQNnS6a5qeeVw5dlKWIv50AHG4iW9ClKfSIaMBwlGdQQGWsksWfU2LEB5oJr3IMVMOg4glqH2HSp3IqLb1oiRP9xCcmhyNuLBMVapdhj52kpJgbBsRcwXwJeMDhj9OlDiBnVCtL3m2yNBCmqqa9Pa0q5b1eDfmmAokvpcSlLfJSZ9xp7803YThIpzRV7byR36Cdoxpgcnu/cqGGTcC3mrJXuVqYZqMhAW/S16+0HcHVCXiGQP0yTgBqwbs6DlQBHZ8toIRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:55:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 15:55:06 +0000
Date: Mon, 5 May 2025 12:55:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250505155505.GK2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
 <aBjc1ny0Zs7K7gDX@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBjc1ny0Zs7K7gDX@nvidia.com>
X-ClientProxiedBy: MN2PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:208:15e::44) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: eddc090e-e898-4e07-63c5-08dd8bed3486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zCRShK1SNxB1hcmxOIdRkINotX7qXMWSQWZoeQ/GjmmC+dgOLj9c3XWzcZpa?=
 =?us-ascii?Q?mge5/STg5XdlgsR1ei31hhwXaC9cwUiF6b6JnEQ1+7ulxC3kVBC+aZaGoxeF?=
 =?us-ascii?Q?FVRxpUnCn7rfYPaniK0OzIWOuT13X1YSwIJcdXOrbISL+QsKOEYVbbK/GeVO?=
 =?us-ascii?Q?pBYv0lkj+6G5b8dNR2/Yr2PPYAyha/SIH1zSu6Yt8sJSIoAfsXDH30KINRrI?=
 =?us-ascii?Q?HpU+1vVZSEDq/VS3BQX67zn8Vv4IiUD0k3jzQfoXHi2tLEhv+t/dCVlSLF5i?=
 =?us-ascii?Q?9lk8WcPiv9TPftInMz198qNTwTKNBjbrz0jpbOMvrBu2VFSQrhB/GKhUX5jS?=
 =?us-ascii?Q?wkm/ImdbMCRRZe3NRSOioaOjcMRq6TSJh3/dw8h6KGuT8PIEVa9fsnH2WRzw?=
 =?us-ascii?Q?k1EXWl+qwG4tHcdJWO9tktT4gKtWsKYV4PtZ9OnPY/OyyWhwM5UfAxaKP4BG?=
 =?us-ascii?Q?/dMSYBSemBWU6oxoBuqBDpfihWReud6eNsR+LvbMbokRyCucXwBXDGGEQUnx?=
 =?us-ascii?Q?aElGtXBlgyX0e/4GLATYtda1v7oAXvfMueB4phN5N9kp10LCULBrN5Su/Ptp?=
 =?us-ascii?Q?TVqezM+KsJISuy0KVOfcD1OLnMPLfpLsR9mZEhgvPE3lFh7M4MvjJTVD+S4h?=
 =?us-ascii?Q?aQ9fCH5HNZY+tEm8HCKQX3DojbGpLdt5UK0VosEkqWnJc0d06Y9qANILYfhP?=
 =?us-ascii?Q?uFIhwIMWaDwhdRq69cWOAbSlEMv8aiQLBlswEqgbeZSzvqJAUTWktGAFtLON?=
 =?us-ascii?Q?CIC1UBK6M5yFzcwZaDXtBPuOOdU6Ncg90esKAwtdgMUB25wnRM/F4Ze6peTP?=
 =?us-ascii?Q?dT8rpvxYZs3jyeavjk2PWN35wS8CrK/5J4IBdEwASgaeh/wOJE8jsyXon25n?=
 =?us-ascii?Q?e32MDudvezwGTlVbo7Cln1PRjum6Q7D/8IxlpyeagKiRN+scMrdfQFZsftxY?=
 =?us-ascii?Q?Jt6NUWZXe+4RoOpT0dwUjFuh/q4onA2GRD0gMAQeBqbGnVK1z43f0ZOLvDJy?=
 =?us-ascii?Q?IYOckuSndxolo7IBdqtuFxhkDKTWuMXq53j+zA872aT1xy4ZeO91z/p485zH?=
 =?us-ascii?Q?oIJjhVcGg33FrLx++72uNBbxqfdl52eH+Z1v4WL8NBuOwljjrS2/bmw2cTUU?=
 =?us-ascii?Q?aRotIhr4q1YWAxMe/V3hxz3oZTATFyOAgFHOZN37pAxNscWN5ZIsjGlf9f/q?=
 =?us-ascii?Q?b5sc36ahmy+K8BC8Vk1KnzrO7QBzsqkKN7Hf4tTW+vYiqt0k83EvLNp20r5j?=
 =?us-ascii?Q?d7INC8ztdiQZ9mf0+YgnXWLLBBlWPQL0StH2l8jrfQLuJrZb9dQy/X4Z789v?=
 =?us-ascii?Q?j7/rMDPkEAaBVlg5Yx+Ey76r5P1cpr4EMkNrzVx8O8LrH9AkzshqtS6ZAdYt?=
 =?us-ascii?Q?CxBIvFnzJw82lSoMWhL1FVb+oKaoJ4K1+xhd5wHzt946oBmuKz3x92c6i88A?=
 =?us-ascii?Q?e9LS3ueGoPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bz6TTRs9EQhZML/6/bBtMTy08dngOeTkTRbYwLA42spIbizPkmX1MiRxHDw?=
 =?us-ascii?Q?AYSLWdDdJiGFxUp9lYuHuvKeE5Id+2OdY9rFvRfndqZsWusB0BFE1T8YyYcu?=
 =?us-ascii?Q?oYHYv7s7ybuj1wEb+sPjOcZ6CSVQjExWOoNveWJEnWwiR2O6e9Ij3XojQIpI?=
 =?us-ascii?Q?T130btnx0hqeOEu31jgzgBJv9EDM54S1VweMu1kitBFUpHchlrjqdA/zCQxC?=
 =?us-ascii?Q?HgaD3aaCqL2ANJEAxRReDh2pCvT68OZJAE94++rruvsa/PS8HOWdL+glPbQh?=
 =?us-ascii?Q?qRInTVcfygoBerfOYge9qhq/VU9Qh2Qrq1cV27LdBU9v548pD8GhEsRmeLd+?=
 =?us-ascii?Q?SiHECiVNKLlgBIQsyKAI3fezDG9S2HkNIvUDJi1ixMP9I2d8LYVxyHKME1oQ?=
 =?us-ascii?Q?s5jm2u4Lhyccf2rCvziOfvLSz0i3pdZD+CjQJkz78xTeTC8GPSMLQT//f74T?=
 =?us-ascii?Q?Z1RbND7/jegB7BEiE5okfL+BEIdKAMKIdO8zZjo0VzJrQuu6xcKbkEAO5BN/?=
 =?us-ascii?Q?+zRi+fuQ3ajw7W+IO/iH9U9RzZD9jNqEsQiU0V7LmABKtdPZfvUNhjXL7am+?=
 =?us-ascii?Q?9ntukcsZPB9tSpVCUxrUplLwZvjRD8G5k35v7nSKX1fa+zTvjJldPQf3clIc?=
 =?us-ascii?Q?RLcMtJBVeADEj0JULomo7BAYBz3cvESYJwbhXdxHaLLOta9pwXOheln9yzuk?=
 =?us-ascii?Q?We78nlDmeUojlxNNfVAiiOgdsEufHinh4di/knH6JSm/G80ZVC1grHPtVc/X?=
 =?us-ascii?Q?37r3MWOiU+d1FleZsBXgoW9vWGutueqR/+0iyhbv87KigBmw1Brcsm2TrWrk?=
 =?us-ascii?Q?3KUDYYw6MOfAg5Rz3kxePiDMnFb+7Ltmk29yrzptgyNYpdqslrlOddezildL?=
 =?us-ascii?Q?kEksZH3mMna0p0J1b4KzsJEIjX/9MPjlO/PpvPJisko7bMvRVEYvTb/UgKpH?=
 =?us-ascii?Q?dC5F3/ioi/RbbRxVE6GKFf6wyuULMV3pzKunkJ9LUyr4Xx6tNBK5YkctXjsr?=
 =?us-ascii?Q?IlxbOVjYw2hyY7M6iSfdS8m1a5DIK2VvKkO5n/QvIiH0OczYuvaA9UD9eHe2?=
 =?us-ascii?Q?IkLj66X383TQEOQiX1P/Wtx8b8lhAHoRYZt6Ml6QZwoRxDBsmC1vlQwrriDG?=
 =?us-ascii?Q?t5sfg0DTFe3OTwXDlPS1NLmjSye0PYGwhwz09bazZPviDR93PtHtZ+1iHT/L?=
 =?us-ascii?Q?r3ehBjF3lg3pZ/vWgpGhzzOu2rZUY64V1yVRrPa7ruyqUmXZ2iy4NMsKdv98?=
 =?us-ascii?Q?jeamce3S0f28dC0vpUVu1OW1LzDjjEWGynB17DF8yegOuZFu9ZDzFPg+ZN/9?=
 =?us-ascii?Q?ElSH+1vQcpcrHjD4XbLXrQH2r/Vy1uB6AOvi5O/mkC+tGwkYiyAj7yFiyyVd?=
 =?us-ascii?Q?ijsX3d6adjjWyTJVBkt/fXCK2Tpu6ZCTg+XH5JMGHe4coWwnD8oOqTQwtVB6?=
 =?us-ascii?Q?RWIxczBUJHVfySoR2c21qVU2vGHyBsx2uVaclSzYCdRgJ6ASEUm0FcRga62t?=
 =?us-ascii?Q?3fkVGqjmN4W77CjqzssvjiQ5/Eu3BhDe4MZoam09vOpLRDEKqsXw/cRDXLid?=
 =?us-ascii?Q?1TGz1u7LsCT0+eUQX2s84vQSIN1RMVfBvcYlmf1M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddc090e-e898-4e07-63c5-08dd8bed3486
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:55:06.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1d3KRD0BC8NNvgXSe27P0bbl1Ooe+XZVh1TAsdtuC01M/KUE3s2imr9CLyMfVcPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024

On Mon, May 05, 2025 at 08:44:22AM -0700, Nicolin Chen wrote:
> On Mon, May 05, 2025 at 12:01:09PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 28, 2025 at 10:41:45AM -0700, Nicolin Chen wrote:
> > > > I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> > > > alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> > > > with kernel call traces in the kernel messages, which might lead users
> > > > to believe that something serious has happened in the kernel.
> > > 
> > > We already have similar practice, e.g. iommufd_hwpt_nested_alloc.
> > > 
> > > In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
> > > which shouldn't occur in the first place and isn't something that
> > 
> > Right, so it should never happen from any ioctl path and syzkaller
> > should never trigger it based on system call randomization
> > 
> > Is that what this achieves?
> 
> The functions would be still used in the kernel path. So, I think
> we need to retain these warnings for that. But given that an ioctl
> could trigger a series of WARN_ONs, WARN_ON_ONCE is something that
> wouldn't bother user space a lot while it provides the kernel path
> enough info to debug.

No, it does bother userspace, we must not have ioctl triggerable
WARN_ON at all.

Jason

