Return-Path: <linux-kselftest+bounces-32622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3EAAEE77
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 00:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1453E1BC72AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E059290D92;
	Wed,  7 May 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gUDdqn0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E211F8723;
	Wed,  7 May 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655702; cv=fail; b=bCoPmg0zIsdST2yCg+Uolfa4qCBThgokx+qf9STUqZsS9HAHWMYG7z6ELU1iBaZe/1RkGV45LyQuW2UHk9lGwxwybZdcsHotLg6NoLtNU8RywP5vZmH4waP+fTTyP1p2b3byqk0vz7ziituLwJ81Hd+qAf3kJPZjtCMvVVGn0Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655702; c=relaxed/simple;
	bh=zJE1yYbEwwjqhZIpWZBqVJ45o1pwM4nsSB4FSfFx8KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXlmVz19oQ8RMGoOYEE+2YrkhYkC0Skubkc0izHPehkf2mZcw1ioVUTh1Fqniz6m6X1ZOR/n0Lyb511m/XX893fKCqpWHIzdKd8gZbhDP6sEWfFTHCqYZSU99rXhJs4sSLe3HZktDK7yD8U31bpBQcx5XBxc3hguvMje5kNz6uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gUDdqn0x; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwSQLlqLaoe+Bo4klYkCEmscno54Kc+Rb4Eg++Qg4Syf430tlivnUIu9vhOvtGUOVvU8N8+riDxsQXh9wSb91PPMoh8rHFKAvvYXSKKw1zdFMOBl6iMLzfL0V7IOhfGr2HK82mXxiVD1P/nh+r6/rcpo2cZelCrTkHeQNYwYz2nvqlmmSKsLiUbWCABDv4PqPVE2YSaPx0d+PQFUWxe9V/ljRB9cTm8l82YYlYRmatTladodCd9q3DvBLkjVMGHqIuj9tIv1sBnWyrTaE5yhj6Gv29ZBcctgrb/PTdzg0GFzDT6JMOJPVEr+rRe8A3rRcfiayobs5SOycCIEy4Dk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/6LdExZH06MwY4+AtZpl9LaiaTOhCeXhCXKgCYyx0M=;
 b=tWVBtSHXmE216xO61kW38adJdN/73eM2ktkpwT0JJMgv/onOhhmmm55I2yU+hTFqj3SwFPeEnsltPihfL1oERH9xvFFwTVyH+IBRmBBw0q35RQsGYmZXTxzlx8OwB/IuYaIquwidMnQs8B0WbqSDvR/uxxJb7ThsgMIr55MIHJr46SX/PaSjFSIcwdSQSIWo2MW/dFuPorTb4FrRq0cxmrpUvWRqp/udtjDAT1IFZ0txbB70ogEsLPpLiwz8ReuGvycUNkDdbGJQdWK8JFetCKEEjP+MGgKlwd469ylJrUQBsFRs7fJM0u8HBAoiucsZqicmXwuWoDyEk61s3Q9j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/6LdExZH06MwY4+AtZpl9LaiaTOhCeXhCXKgCYyx0M=;
 b=gUDdqn0xInWsT6XkdFnTI/3kIJd1JM1XITFrY0eqvlR50s6XZHOC8TR/WsJ7ZMmQjal2ZZtoqer+V7ep4D9hSGstsYQgELX8D3Ye8H3c6iUp8JbvV5OiBdSJ3guJxU/bpat4LAaKrm5q2rBoLiIduJtvUOPZBfMHCxZb4hOAkHIKjQ7yfIw/P1kbGwKSjDe/6jkTx0SdweLwd1tw1YsZToiG0faJ4f5/ErdnW0115OL4eDelYnPfvB2Gjyq1yjqFsuzBEnO3ECtiKcYhvLdQZ/rXVxv/friILIGKoZWaq7uoop1YQ2AMNU62aDOviWEXJ4bXkc2pRVeM7JHkCwfMTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 22:08:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 22:08:10 +0000
Date: Wed, 7 May 2025 19:08:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250507220809.GB232705@nvidia.com>
References: <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com>
 <aBvMC7dnYghoX5Aq@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBvMC7dnYghoX5Aq@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:408:112::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f18077-e3ae-42b3-ab32-08dd8db3a77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7rVDTJckXje8JJ7EN1JDzgLtABptuw6eD3flw93wEIT+74sfw7LlBxg81mqG?=
 =?us-ascii?Q?V/5aeu79pgu0bSjZVAcSE0ZIwaLOUBppJOh019TmaFrPUqqfZIFa4ofk4h29?=
 =?us-ascii?Q?QxjGzyC/rHxnPw+PBOqC8funNIR6/+qRoFwnPexBMr9v2vIbBCeaMbFuvKpf?=
 =?us-ascii?Q?lqGkJ2ebcN4yZSfwr11Njx57HbYhyFIsRP8YzMynajcXzN7OY7bGa3oNufE1?=
 =?us-ascii?Q?1bM4EGWTRIechAFzwNnPPVl+ifiYjsrQZlsAGmoTqMqxUsCgXC5A4vpaKdfz?=
 =?us-ascii?Q?qEB3IxNWd9XFJ65eckoP1PLK3yDBpEejIjX1IGdvMSVUsQMjZW/uJqxVzg9+?=
 =?us-ascii?Q?cmmSWThAsg4xsIb7HM6oxjqOjA+n1RmMw2Bp71oD3KGc745W9aLS9Fj3cqhU?=
 =?us-ascii?Q?fKt7yOsh6dXKFciZ7ccfApPGzdQruuXu5fGeZAVV/2w+TmjilWILOt/+6jf5?=
 =?us-ascii?Q?JYFfZIJjXzP6Ur+sCUlaYHO1XSD4F95CaUWxCg/DkHg9lkCe8yGCoDiEhC8V?=
 =?us-ascii?Q?oY1GTSKpwsLnfpy7CwatyDNiZP9/znl2n/5mjeMPeVyokmowAVbNtU21flx+?=
 =?us-ascii?Q?at4eEbWL8UTHnAE5vEOaMGossnGoLvibcgF2gT9mglzlpi+GxRKD+m7+MRmy?=
 =?us-ascii?Q?u5asY3oaDdCP9GrjKGclQivsvixGDzG5hk2lMHpm5uOeH6+PFr2gWy01wePi?=
 =?us-ascii?Q?y7XufJ1XabNhWLQNm9y1aOR/+AxrqMvbWjZc17SoJEt+2VTDlGpt4jTi9S6/?=
 =?us-ascii?Q?icZO/nRfHmAombHar/tKu1LPSnfUAN0LQGwxRn7OmQstFJlSPgGcvgZ6CZNv?=
 =?us-ascii?Q?4m4h9W3U0kkbuxvvqoNYzPW+Nusn1SQjD5C41loGhrJbmSLdtgYB539JLAhX?=
 =?us-ascii?Q?U9UgXiVc7xdtPTZPj0oZ3/JzVbfbosPhAk5s6KFbYwwsCA5jajwY66OMEuYc?=
 =?us-ascii?Q?yhKZs3aKSnnDOvDv7Gi0QjdbCyAYvzrqMQgJ+jgB2tZgoxlOY6O7fv4/7cXB?=
 =?us-ascii?Q?EcjVnFvIJDWOwSAZ8odwmmCpdz48hw4bxfFG/W1I0N9eyzbEEJfpYtfCfzY6?=
 =?us-ascii?Q?RLcyELP/keD5q3g+azuKYt9c2B0Fo7Ygn5cUSONmZz0ERwrl1hSqwrj2oKah?=
 =?us-ascii?Q?GL52QR9GhXG86TZq7fBxQvB6rBypPzIkka6r862cIciu7Er3en5WHhaRttk/?=
 =?us-ascii?Q?TipdlLJWt0l0tgkLg3TEy7di4oJ3+os8lvt+nNxUub1XlWUbGv18EiU9kgDD?=
 =?us-ascii?Q?1O69TrG25ZIbK+uQbtV3sjUsPXO2cvh/JcXwP/W2ZjY9A9sWgctjxh53YACc?=
 =?us-ascii?Q?mDqHd8DCSEGYopVF27jwdWUbjIcP/5J9hgAvF8vNYKrBNnxKJy0BRiC9jGlz?=
 =?us-ascii?Q?lGlqhOob1LOxb9d7xgsyIyudDk4JwnXN0/geO/qLH86TLVTkqoYJ7BuM8OQ6?=
 =?us-ascii?Q?8qbPjjgkITs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EN655Ohf9HqzEldnz+0gKIxItVsaGYy1tBNTor8bfN7gpzrf+RsV9ptwO3Dx?=
 =?us-ascii?Q?I34wktbd1CyiMa6VVHO6nQ/6W+ZJ9YpvdDlInbb60DbCZCmCjW95FRTwHjMo?=
 =?us-ascii?Q?I8qp1lPHy1B7z4ZbFpZ1vQ0CXYCDkMA0e48K5iyUMqLc5xER7WKj30mfy3Wd?=
 =?us-ascii?Q?TCOSNWhKWXUM05neycQTCZkgqOSWnczfFwloQq5rE8gAYI530tB2N5b8DPiX?=
 =?us-ascii?Q?+dmuZkUA7q1HbBfbDOdNck0S9CcYR8SilO4qOEoXidySpYMY9la1ruRc9tqu?=
 =?us-ascii?Q?eNarM4cmet848uMoIJ7nLMb06cOEXqrBK6VRcbKSTI9b6crfn2Wp4MabhS0F?=
 =?us-ascii?Q?b6LbvgYH9uQI+e0kQMZ4pewrmAEXKjT1cgNdhLncolIhjEjJlhpmG3eL+J/X?=
 =?us-ascii?Q?VfOb6uLmEcJQsMnbEzhh4voBmgOyIbNR4ri1OEoT6sLdIXtQ5zM0esgju+Wl?=
 =?us-ascii?Q?GjvreaqG6ahmbXVFjnBXa/cBaczqHnXJmBI90Qnqo+g9R3XW/Y2CS4ueMbXs?=
 =?us-ascii?Q?Y8F3/rmhrdogGLCMhgZZRt6Yal5+UnoMrePEZ9E5EYL/PWcKDEp+JMz+qM3R?=
 =?us-ascii?Q?8LDiuAnoiZ6i0EFz+uwUzVCsGOI4A+LoVhLLOfNBIkjNR6k/tewvuTSKdZqd?=
 =?us-ascii?Q?DBPPgYJmkdDYdGMAdLWeAdp8RB8df1wvyzx0JrPkijcPDrWLXOc+1DNNB9UN?=
 =?us-ascii?Q?5wvl4yFDbLfu682BcKEdvHi8jDe7WtiuFjm0KqSVEO0Vy1awrG15nKZl8tL0?=
 =?us-ascii?Q?MRBLy5geF9JnS6UvRyHb31DPm3pgsUytgCGyvQ4T0Iy7DOLvzjj2/mKBbZAa?=
 =?us-ascii?Q?FY4HYaEk+A+OzPPRTKet9hFWpYFwxfED3VXB8gyYx0xmAkosiwWIKq4mvmae?=
 =?us-ascii?Q?lUZlmYjO/i8EDbytKKWBkAqixiDP8tLFWxN/RuLMgO6Ldh+pj2yDNmjW3yjS?=
 =?us-ascii?Q?uP7y1o+H1nwD7V7EHUUO76HpKFH3JtqqBn8dBhEZRWjRZju1MesMIr69sY6i?=
 =?us-ascii?Q?W0EeFwMPY2vFjIexIX9NyiSPr5k8eZWGnz/nH3cPiJrpaOaY8v2QZg0QpTwX?=
 =?us-ascii?Q?Y3DDRGADpt9/06XRA+KyiUXa3lOtg5ydKYqQUqAcfEsdcSEwc5LJlbGt+nE+?=
 =?us-ascii?Q?xyx5nTV8Y4qTEK3I3eb3XdJrMJV4f2wvyr2NDBbZUMiGHXODv40wDiMJ8d9C?=
 =?us-ascii?Q?TUSfwGaAcdOari+TmGkopHnUPdcVdXToey933ffMwfA1xTDmyImel0ppFtD7?=
 =?us-ascii?Q?VNYeD8iuyMuSaitw8dPDHjLzRl0E0Gl94Y9cgIwguUbxOBhAH9f5g5erxTNp?=
 =?us-ascii?Q?m/0OCPOaGowRvlgAYdwtaAqWd6ufj5EwFtJyHyUrWX3+oNnmQPUJqgw2s+uM?=
 =?us-ascii?Q?wClUQBqB8GUwwgJJSU1CSXHURWIhsbxHAVk/V8mH/Oo7tSXcW80AFBEUzgg7?=
 =?us-ascii?Q?UdvQEGJDqwDiptfke5hFqraVB7vKu7uMEi0DpxLsZxwtpuo0ODL2O++Y7e8p?=
 =?us-ascii?Q?WGG1ldangT7hbg8Ko2lpm6RKDjC4Q/f+1oYXHElXZ5cgAYJASp9ew+f5Y/7y?=
 =?us-ascii?Q?C2ms/BtqD2tIbvL2ZiWStDlKzQ2616lOG2SjwLZm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f18077-e3ae-42b3-ab32-08dd8db3a77f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 22:08:10.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /28NiB2LkeHN/uJVlBaxshXDgdo+hNcQn5XTQVeV6tWCgudDiNZMH+d6UfXF8IGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On Wed, May 07, 2025 at 02:09:31PM -0700, Nicolin Chen wrote:
> On Wed, May 07, 2025 at 09:39:01AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 06, 2025 at 12:30:54PM -0700, Nicolin Chen wrote:
> > 
> > > So, if I understand it correctly, what we want to achieve is to
> > > have maple tree to manage all PFN ranges. And each range holds
> > > the same entry, a structure that we can use to verify the sanity
> > > of an mmap? Let's say for PFNs A->B, the tree should store the
> > > structure between index A and index B (inclusive)?
> > 
> > And tell you what has been mmap'd.
> > 
> > > If this is correct, mtree_alloc_range() that is given a range of
> > > [0, ULONG_MAX] would allocate the PFN range from the lowest index
> > > (i.e. 0) instead of PFN A?
> > 
> > mtree_alloc_range() returns a new range of PFNs that does not overlap
> > with any existing range. It should always be called on O->U32_MAX (for
> > 32bit uapi compat) and it should always pick the range to use.
> 
> Ah, so it's like an address translation table. mtree_alloc_range()
> just gives us a virtual address range (i.e the cookie) for mmap()
> to translate back to the real PFN range.

Yes. It is just a way to adopt the mmap interface - mmap is about
ranges in a logical file, so we want to create logical ranges to refer
to the objects to be mapped.

> I have another question: while I don't think my code is handling
> this well either, how should we validate the input address is an
> allowed one?

The pgoff to mmap? If it isn't in the maple tree it is not allowed, if
it isn't at the start of range it is not allowed, if the size is not
exactly the same as the range it is not allowed.

> Because mmap() is per ictx, i.e. it's a global translation table.

It's per-FD. The pgoff number space is per-fd calling mmap.

> So, the following might happen: let's say we have two vIOMMUs in
> the same ictx. Either vIOMMU has reported a cookie to index the
> mtree for the real PFN range: call them PFN_RANGE0 (for vIOMMU0)
> and PFN_RANGE1 (for vIOMMU1). What if a buggy VMM inverted these
> cookies between the two vIOMMUs, so it would end up with vIOMMU0
> accessing PFN_RANGE1?

Oh well. That is too buggy for the kernel to do anything about. The
mmap cookie comes out of the VIOMMU_ALLOC call and goes back into the
mmap() call, if you mess it up or mix up the pointers then too bad.

But if two VMMs are doing this then they each have their own iommufd
and their own private numberspace and VMM A's VIOMMU cannot be mapped
through VMM B's iommufd FD.

Jason

