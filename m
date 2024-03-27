Return-Path: <linux-kselftest+bounces-6743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CA88F125
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E96B1C2CF91
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E529152E03;
	Wed, 27 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="CG7ZZKiO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2138.outbound.protection.outlook.com [40.107.212.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6C14E2D1;
	Wed, 27 Mar 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575876; cv=fail; b=rrt7KhzQY5zcrWyyJnOD/BJHunK8ZNmiDLZEl0r9rupowvxC702Ng5wyWsz89a2BwLhrYjKlCMXL9vvby3EsY4CSBE1euwfvLa0jstYAoRhRoNWw1d6kiHQoT/U8EYPUK96SRAqnv0uS/BU0w4pxU44U35E6j3mFVzYa2LrwY0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575876; c=relaxed/simple;
	bh=r785iyQiV9UY7L6S3poT1iaEbAUg1J3MS5p3RdcTvwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VDiL9h6s36N41e3e96UqeqNMU0i/7gQejZ4eYGn6SEWRYg1hmQUEZ49DhDZXHGMyUEDDZ/5dZ32WLMfTDqlaPqjlxjlqLG0oW9vAEbxJtqI/C4gGnKrCpWXaJxKE5f9navqFbG7OeIeg2K1B0JeyUrdKxx1jr6fIfW+ue2x5wv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=CG7ZZKiO; arc=fail smtp.client-ip=40.107.212.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL2nt4Z5qwjP1ftXw+ShYdZZsV1bmWEzs1ekmGzhw83mrTjpvntNILF6l3/I1rte0amgwc80p589dPGE8QT8uFITcHGmM1nBEwdosNX8igu6H5qJC7VuSHEFwXK9rsqmQRE387uoB0TOAOl4N9ojvr7kSsVVIPO+2Sm0uMImD22VhOm7OysKOLqHURtCDdbLWBjn66zZHsbOOW7r4LTvRpwjMIDjDqNp6HuIkd6/Fcc9kxyzzmPBYtN/wQa9kkemWiB4mpXAKEPG8GL3BU5XX4wmFBqOOLL4U69fPXiEekE9csiKQbfSUhN6AwIzCrqSATQe522EgMXMOpGan1LVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPrbadTmSdCZnFbXMz4gw887g5jXtH8Tcdyl8fb2vvE=;
 b=bCBaam+MpQ0jYRlWClsGLw8FbBI5fml34nTNIoqAgssP9Hct6ZgzbCYJGTdEl/PbfCJPP7Dvt4DV0tzH/EbE+iHTLxl8jEtoxUA7lxctCi0RAq5sCH8QNR+CiuissmFU32cgIAvGCLP+TgwGR6VTSJzdpAuzsY5ksYkeXSpV7CgwPjK4A55PSXnF8XYKB09E58TSrZqm25V2o8UCafBXl7MkDV5Y5S0SaI7G4PtQMIXhnkrx9cCvz9wrXbdeY8sH7ec7YyTEe81YJEJ56XRLDkWnlX5fAxxC/0vlrWMHDQqm/Y7ddlC+VKKEhgEZVW0zNWo09pSyxOlfnqJhv/HJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPrbadTmSdCZnFbXMz4gw887g5jXtH8Tcdyl8fb2vvE=;
 b=CG7ZZKiOTFmAgwLx6Wq1mwvri8G8ytM4uu4Do6rXghC8M9+1KmHcIDBtNC800oXZGwD6LaUElz3jcFE0eoLKvs0N3IIHHA2IJlmvVeaLGJyYKN8HyJZj/jodQt+cqIVgAfjPOQJISBgA3r2W1ghzzAd7W7DWUebL6Yjo8nGj/Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4415.namprd17.prod.outlook.com (2603:10b6:a03:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 21:44:30 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 21:44:30 +0000
Date: Wed, 27 Mar 2024 17:44:20 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>, Wei Xu <weixugc@google.com>,
	David Rientjes <rientjes@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
	Kairui Song <kasong@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/8] mm: workingset reporting
Message-ID: <ZgSTNCP5f+T5VtBI@memverge.com>
References: <20240327213108.2384666-1-yuanchu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b0b045-0b2e-4a29-427a-08dc4ea714f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6YbhuLZOSfCZtYaeiPgRbpCtuixDVi9eAUOjae49shBqERAGh7HQVveRErfR6PS20a6f/KahqDjdoM+Kh3qhpBv7n09eW9Ex5ui4BWNbkaRVkNlkwObko1YHXUfNwtnjrN6RCm9Js0TQ3UCQq5N9RZ8tTrXbUr4JL8ZcdAjw6KVDvm8wXQzSsLWRGpW8qgAe+WcI5CbmbxmnB2+cO9K/Crt/9Qrml12f5n3wizA6kVzlRs8ZANMSo3lJ+w3LV9di9zXbDbilf2M971NWzm7o/TxsBO8GR3HjdgOa7GYSEJT1rKHuh+dUjRxd2V7xvNNvbN0xnYJGM1a9EYQZ1egDGPY1us0VOOe5KAuvxSs0c5RxL1FrwlTjM5kDFoOSrKmfB5Tb2DgiGrpN/UUiMW4xuqaXkzoH7mkYtpLBJVmhd574pUFX+bU8gubj7WGPbeSJre7bltf8RhU5FnjJqUp9kpgHnnWMSFkkhNmnvWeqZ2Dlna5KEQYTHh6vDDLb8Bz1KrIhAxRvabadEbd9pr6XFFFzpZTN5QVPjeWGjl/jIFF5q0VcbRX2PF3qlYqLlot3pReTQpmLms2vflsy4bubKrgf2LXF3FlZGqQbwAaeTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opcnGY6zV3HhA/ubBvv0n2D52orFU1EjwDOa9aUyD7a/vxthwyYWXPqvT9P5?=
 =?us-ascii?Q?FCyluu7uSeRyWATN5Gl9tgqFg37MuRkjoym+pbxfC8r1Vriqgit5drQfS3Zt?=
 =?us-ascii?Q?6r2Z2GMPV9gTw9grJ8W6GvyvBPvcPFTYInPtmaRGgPHPkFjdUZzFPZK4Wdak?=
 =?us-ascii?Q?R8pGbXmmtIUiZCkFmaIDBl8avIT3ynFdpz2QXT/m9FuDMU6uVgH8LhkeQX7M?=
 =?us-ascii?Q?8ApfV+9n7WdrAXkHy6dYO47FTrwJ3YfwJNP+2bHQ08oT6X7ttqMPKo7lCRtJ?=
 =?us-ascii?Q?D2llU6+Zfye2Kgq4Nc+Rp4vdBOLgYKTDbpmsXQtAWQ9QbOt/qXDxZHhkzNOh?=
 =?us-ascii?Q?1PR4QckiS/bBNaDpqtFig65ALC8czwePJucmT6be/oizzUa1DwgIrUZbs/U6?=
 =?us-ascii?Q?q/R66ULZZEqYUPMQr8Qs3CUaMJ/68+DzdDeQrtASP7upGMDOPqHGhpCBvqlI?=
 =?us-ascii?Q?bAOEBHlrxBTL7mJh+b4RTRFwZIUPT1Xub4CcCxfUrE5oPW2zeVETOKafbvFm?=
 =?us-ascii?Q?RHsTFbfhsSfvunjB8aSaE763rHBiw6JMWgdhHFVUE4UgVMQ7q914zcYB23DH?=
 =?us-ascii?Q?+zJ7QCI9p1YKiy1tIz6hEs+vUF5Uai9Syz9Z6iQGQgtajozX1W9EjKQxeNqW?=
 =?us-ascii?Q?VnQR4/nfxH9TKOMuzVz00bqtsXYG9VV+Pkl+gg0y5n4b3ifhu+dMv8p1T/lR?=
 =?us-ascii?Q?Z3kLnUnvM9uywhmrm6CagHdjfyEfCh4wt2sNmSo3tZaKvY0Y10cPEmb3ime5?=
 =?us-ascii?Q?aC3KgdQX7BbE13x0JtfgMwfdg6TUkblFlXFl4HhxVoFR/uiL1iXT6F+M7bsS?=
 =?us-ascii?Q?YiHHQCCTmt1ni+qjYTE0CQBlJeJPdaggyKqR4WpSp4nFqniRUB2GEhhqSbNX?=
 =?us-ascii?Q?m74f7GmMhvumPjvZGxL/tz/A6bdpSItSU1ryYVOZ0ZpRa8gvsqS2JxuR2vyZ?=
 =?us-ascii?Q?OvJNsM0OKZBwtWvy8aXzOYQvOn3lhN+YMvQBSDkPMGgAI604WI/QhJz9ofkb?=
 =?us-ascii?Q?M6xtG0ik602f/PgNIOmZkjxS4tYy9IQvyqq16PVXNoujBE7eHMuGrxI7C1jg?=
 =?us-ascii?Q?fc81D/h5SHR+xP/05ha/7Pv59AHntCmEMCfYjLr4YC65dr6kJ/hIHELynXNh?=
 =?us-ascii?Q?ONH3+WC8TVkX1dDQrrKQxHTH/Z3aKdCxIZ1g689IXWdcp5mUUJuzjch9sbjh?=
 =?us-ascii?Q?mqKaoFoIC6KvZBP7oLd1mc1GX/1MvCI0Q1Q7xwel6K8yDtTzn0kRmBmnGINE?=
 =?us-ascii?Q?RQW+lX6gAghTuUavV8XLSuJlZoRMM8G51KS7yIknGn9Q6gXDoBVhDHvn+BHG?=
 =?us-ascii?Q?x/FtKPiooS9ByVhoa6YiQSCnG2NQk7jAFCFGQ9ObbRORBXYhkkNZfNHbXHyG?=
 =?us-ascii?Q?r/QKtu/3gn86CT0qoIHT9OM2Q8K3gm5oH1KzsCrHun32Q+toXZDUbHVHEnMA?=
 =?us-ascii?Q?2NRyTZVhyFKG7qvEkG8diCwmOt71KinBrrWOREO2ltx7vHTwFgJq5fvtSVb/?=
 =?us-ascii?Q?PJSylsK5+urA9+XI+ouH5ur9LO9wTS32gjX0wYH6m3ZEezXdzw0avWypeUr8?=
 =?us-ascii?Q?GOxQoYgu+NyjAXKlzVE/IByDwt0WpAGzqJvYz6F1VlKCh2dI8jHotp1PtbB7?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b0b045-0b2e-4a29-427a-08dc4ea714f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 21:44:29.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYpFakEk3+fZcHt45p0ZpBMAoZNcrg0eTijptV41JUG7T+qb2Vo3Wowi9OSA+9rfUiKb8PPCUdmWiL6GbYeDWHdXrh0+o3a/XrUojVPsRPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4415

On Wed, Mar 27, 2024 at 02:30:59PM -0700, Yuanchu Xie wrote:
> 
> Promotion/Demotion
> Similar to proactive reclaim, a workingset report enables demotion to a
> slower tier of memory.
> For promotion, the workingset report interfaces need to be extended to
> report hotness and gather hotness information from the devices[1].
> 
> [1]
> https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1
> 
> Sysfs and Cgroup Interfaces
> ==========
> The interfaces are detailed in the patches that introduce them. The main
> idea here is we break down the workingset per-node per-memcg into time
> intervals (ms), e.g.
> 
> 1000 anon=137368 file=24530
> 20000 anon=34342 file=0
> 30000 anon=353232 file=333608
> 40000 anon=407198 file=206052
> 9223372036854775807 anon=4925624 file=892892
> 
> I realize this does not generalize well to hotness information, but I
> lack the intuition for an abstraction that presents hotness in a useful
> way. Based on a recent proposal for move_phys_pages[2], it seems like
> userspace tiering software would like to move specific physical pages,
> instead of informing the kernel "move x number of hot pages to y
> device". Please advise.
> 
> [2]
> https://lore.kernel.org/lkml/20240319172609.332900-1-gregory.price@memverge.com/
> 

Please note that this proposed interface (move_phys_pages) is very
unlikely to be received upstream due to side channel concerns. Instead,
it's more likely that the tiering component will expose a "promote X
pages from tier A to tier B", and the kernel component would then
use/consume hotness information to determine which pages to promote.

(Just as one example, there are many more realistic designs)

So if there is a way to expose workingset data to the mm/memory_tiers.c
component instead of via sysfs/cgroup - that is preferable.

The 'move_phys_pages' interface is more of an experimental interface to
test the effectiveness of this approach without having to plumb out the
entire system.  Definitely anything userland interface should not be
designed to generate physical address information for consumption unless
it is hard-locked behind admin caps.

Regards,
Gregory

