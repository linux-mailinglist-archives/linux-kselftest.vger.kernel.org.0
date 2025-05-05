Return-Path: <linux-kselftest+bounces-32412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07EAA9A77
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82CA189E4FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F726D4C0;
	Mon,  5 May 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwCjBXUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992826C3BE;
	Mon,  5 May 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466101; cv=fail; b=GehgpnWhjNDM5ASQpDdJQmJTa9ac9BkaYGMNE+AwYcR+X/mn1g9XG6GVZQ60QIC9ZJjFyVxLlw07yBgBU2HDRpSi64CKHZGLPpHCu+0XrNnzA+iERc8cWRZyltPg8pT9g18w+QvJPBipypHI8MoO2FoLi8/wXPnXMJHtC8ehEh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466101; c=relaxed/simple;
	bh=Ic9EMFAIsK98SSw53u3YXMH+7139VTZ2WldVLZbXt8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cjGjIxr1E98QqYqFVjJmo9mdKVpgqXPoRYjvYTWa5ySV/MCEEPtBmG6VPfmHQrzjIZWk0pqFUUwKzl3RRhk5OANNKnfn5ib5tjM7U5NtlDbllhfOuXDAgVE2KdqGMvCNGC7Q5aLFTjM7C61kb8GzsyJbhFa51T4S+SU2J4pxHl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwCjBXUp; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfyOdsPBau07/fR0q9P9s9jvSGbIBLOM7NmFwp0644YMZo+KksJ4RP01tR3YSIyZ3mRyEWkVbAOTctyL0MsMng+Z7Ct6SbSqgmFU5EvcaovCQr3H3L44i71iE7Z+hmo9GX/ap3doA6jAldq7+kCcE2IiX0OkL/7dXpj5u3AyMA6n8BrOBVEmfPyVmHFGDVOJ473gScqfG/BwQ8bQeCwv7Knu4qxDO7LY2zY6e7/v9N2ubtdcMWI4GHu5mCWDalog3Js0/TAg0vGvzUfzR8aGmS07DhOMLK1VUr91b+VRlwRFEDA2AxBj+juOlUpMkcTAe4SUph/Ed/Xgb0VdMS+8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or5iQoO5JMPI95XmR12v3VXbmWEi3hiUGKIZXX9tCwM=;
 b=C1rI0IU0YB9WiNqaJ6i8EQLEyFpRyxyANZ0cYAvoTcU8ee/+Sai4oxJ2X3xu2jckG3yvylnmvi5ynkHFTDC8fo3Aui9PcP6TTBSoZRNqaSDDt2u7sB7LU4N/NGIZpdRvclSKAc2JUeQ8bCFskEelbwqL6vPzUoPkvSl5hI/dGq1S7WiitqsRDuaZ/JkbnhZ+BGj+N6SJBMEe2CEZWUX0vKWVMsoHvm7Hsn1aUlzsUUt6eS6irosWrXkUvj5ieMv38tWTspF165re6GQFkZLEbas/vGqIzYJ0uts4rezLA2wBASCJNsK1oDCBkgnN9yEcu1Xiops1Lcuc7mnjhY/Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or5iQoO5JMPI95XmR12v3VXbmWEi3hiUGKIZXX9tCwM=;
 b=VwCjBXUpKrxwWVwxLn+SZGV4FXqYRvoi300crf5OWbZJOMyX60qpHKeClV3+9dfFqWI78GDXwy92mZ64OocPkZ/NtlMt9SU8f4QASxg4AaBE5HEu3WSsLRiap2Ol/R9g0+eKZPAdxqsZWH+b9njJupZ7nqleMKI4pO/rdY1gnJK5iglqDFBeintv7OGo8mWBFnsQx7O/83x2R+c/3+JLhyBCBGBGkoOj4DzelY7Dn9ggJ+mMYcpDiAxf7yuAzhO4WCovAopMuXpAzopAdm6v3Nd5mOd8+4CzoDOt2oG0zPjcrbpU9Q3BFmv1080YrEsp38ZC/6O7ephokLRSSi/EXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 17:28:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:28:14 +0000
Date: Mon, 5 May 2025 14:28:13 -0300
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
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250505172813.GS2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBjzf9PrYnwF5uZN@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: f74e475c-e004-4fe9-cf62-08dd8bfa3750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1OQ4lZL1ALeSh3I1D7Zyil3SBGc5NnBr1wZD4c+Mir+NNMmwjZpupdj+Ifi?=
 =?us-ascii?Q?9RzrG6L31TuTtdkAKJTzvhXOvVk0zWLs/feceuFSmdQVfMQBmhcpqIxpMdHc?=
 =?us-ascii?Q?RAjegot7yb7G0zh56v+8WAYBax5KjebEdUq89Y3CVhIF5UF+rK87clXEmOqQ?=
 =?us-ascii?Q?jL8CIwZCYDYjpmK7cFm4na9jct9ATkbTgIqPXJ3UhVebDHJpiuMb9uD7QiKL?=
 =?us-ascii?Q?IGuqesjapwPxOwoAG8lerq2MCJG5rRG8fDigNPgGuV6hSJ2CXJnvR3Oyt9T0?=
 =?us-ascii?Q?aZizRE6ygBfryG8k8s8ONo3sOC6E2+myr2dB4xCacyZ5ypRDOQpJ+d308Ku1?=
 =?us-ascii?Q?1/2z0DZVfGPQisgS7IvclnfLgruuI3cvqp8yV+RXbYtgfTqa7i+ED5g8vAmC?=
 =?us-ascii?Q?JjV96dJo3UQN+bXkLCSy3kmQSJhYEGHxUghbBbpTzxcuFpPw16fDcMLKgWya?=
 =?us-ascii?Q?/WeFHdhZCdHH2bPASjCaNVpX9u2iHIOGniaI4nAKwq5O0qD+8GcfqzVYFDDN?=
 =?us-ascii?Q?gu8un6JlxPEVnUQBWShXqlWr2Zrv59cIpdWE4SZ1CkWxTzlu7U7OiMlSs4fB?=
 =?us-ascii?Q?wNvjdKH25oaw62qQNCHXEnYSRYN0FOPZexUa3eMYC8MZTiZXQqQ7jN+fLW6J?=
 =?us-ascii?Q?WquD0WQJ6oUPuRl1zjVzdRG9WZXlD5FW7hJG/dq9TuwKFqnGUQbZAw0EBhMf?=
 =?us-ascii?Q?+BDAAPb5e21dZPHhGtLJWa6fPgZzVlW8NdgS1dG1dLVX3pzZs/ZOFbVfglqW?=
 =?us-ascii?Q?BoUCXq6FKuP8hnR+5+RW5y7h0dH8xOoSpyb9ddJ3VbsUrYBpB8/TMoKRnKEi?=
 =?us-ascii?Q?mJyRllS8Pj9pOnZ7XohLlZE+9VsGkZA/9fJIWwknL8D/7zxv6a+v/2NcAvi4?=
 =?us-ascii?Q?tNtga/c9XyMt5y+ByyzVSWbmpL0oemc6FE6xxS/V/AnmSng9HTOfHvK5wc9L?=
 =?us-ascii?Q?3IHil8VYQu3GJszv6j06WiQqDCUZ2ZgOYiKFldHXnWEivOSEHpVwFIfmwGew?=
 =?us-ascii?Q?t0ex6C/PDZlOTefh5AMXEVNe32HdCirRd5LtOyMT57BeDjGnX7icG1LC01wA?=
 =?us-ascii?Q?jbbpsWPPAjE0sXbgCFTBVnpHzVT/EfDRZV+iWTvR31YG1mWfVjKXRZ7C5SOe?=
 =?us-ascii?Q?VvT9vfXquCxnm4V7LokEEsszg42DXUA+VyA+wlQ9+NPXfd7j8Mgrld/9QmsE?=
 =?us-ascii?Q?UGFKBXMwdsN00x2s0Wy0StSIO+L9mjK9MrIdSzddeMz6VsPRTxw3MbsZRRhY?=
 =?us-ascii?Q?m4nSgjrLYkmIne+pkZv3D2MsdjOhrkKylgvtpzeziYxMusAYoA3gNDur6ZPJ?=
 =?us-ascii?Q?aRchQZEMFxJYsuZrr9s8YJEHtDtHlcFoBmM0CGXJEI33ZTJF50CPymFXIgMD?=
 =?us-ascii?Q?/B4bBwSnpGLcPA2dSqvaUOB/BZ9QF5PJxESMue6+Js6LEOqm8ziDpoN0SrF6?=
 =?us-ascii?Q?WJazTgjQ//Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+CZIBCkXYVr+qaZE5tnho3OSeP3fw9jpVjZd81JFuN9wOnonLmcZxncEkDX?=
 =?us-ascii?Q?ZVgtoFb42K+sviAayQijU24ZaM3YemYgQjCRVcLJYZ9JkC5Zp69QMunAbd8D?=
 =?us-ascii?Q?BQZI8i0cwLfcqhNUzESb4Z+xdKvMAvLdF2ykaKI94NBqoU8Ve7qyX1WJf80z?=
 =?us-ascii?Q?FM5rbkH846pc6JKeGMVReKp7lriIx2sHybQI8t/ihe059pJuDb9tsADx2j/Y?=
 =?us-ascii?Q?nxWTtvQTXrmgRo9Bo04g3Vu+Z4tuPmzJo0wxeo7EVSndppwMrIzGybErYFpf?=
 =?us-ascii?Q?47jGQgmIAHIykOhlB+S/slwxO8E0W2HRfYB1cmvyKDuOMIWHYNsfSAm0QUV9?=
 =?us-ascii?Q?CfJxE1LIMHYsXTf+s2nbz+2smR0j70kfk0+2fGzfH5Ei+lLmnUPdHDPkkrbZ?=
 =?us-ascii?Q?N5/l8KpauMDIeK3kPb/6ZO5a4jQj4LWF+3UMHt39BDfNLmuFKxLjs+24KNPm?=
 =?us-ascii?Q?T52mA7fZRXHQ9HpqTd4ACPyniTCtDrDSr5XQsu/8ePLumpPFsNpUycuZ6mS8?=
 =?us-ascii?Q?UaPhSagUyEaQOZG3Ukqn49rz6FD8Ibsbwfrie/QrunDXhtOCg0d5mHVh9SAF?=
 =?us-ascii?Q?NxLQcnBb9UD0D8DUN0ysg5ADNQCHAZmBmRhPztlC5BhcNcOh+RYoIfxPgDeh?=
 =?us-ascii?Q?MCqu8XqwTgtVDL9T5BQZ0TkBVDrvZn93LLKinJZlD1WRew4KBOt3us0kRSyJ?=
 =?us-ascii?Q?eVnRwXcpj6kCTIvbRGEgy6DWJVyUkkoaaFQ9qwhNH4lNyJHkBtGHbeolCZbl?=
 =?us-ascii?Q?TXgNGmGYoG0Mw5GuB/eXgDm5QolvJ8vwi8uX0G+AHEcGzDIJz2pcZTQVMLZK?=
 =?us-ascii?Q?8MzOb7b6czgx+z/7JtPyG3hNvPJMlezMoKVzJi5H6qAq1uFslzxQF3XMSFEZ?=
 =?us-ascii?Q?qSHCkTaFy0y8su7T2x7ZcA/psx/2uklyrLHe0t8+afNdIMTqbUlZ2UlHqvN1?=
 =?us-ascii?Q?P0V5FXyObPHu8IGXo1SEl68QSr1dXQnQzCeNoBm3zyhXXxFG+obbFrDz/o+d?=
 =?us-ascii?Q?xCiolA+N+cfNwMMq/7/PNSvdrr0JK6CjJlEJvFRlmzJSAn4tFtR/QkLN7xUF?=
 =?us-ascii?Q?Ua6L6WWm9813mAwvKvs32ofThtKv+WE9lLgL3fbngqQNC/z96VEhEdQOKvDb?=
 =?us-ascii?Q?5kYgHFbu7L8bRlMqAiTZS1PDEzDWc3rOfwZZns/WEOifVskcWbzcARVaFwYb?=
 =?us-ascii?Q?M4flxQOnxdt+k/YBh+/7JxFD4mRm6WdSjSGvez9MU80Kzkp2QTWP4NghSB7T?=
 =?us-ascii?Q?A7SRe0t1cywDKo7YkpqvnVN4izd/ZE0b6AoMS+aM7euIlqcjKxMmCXnEauxv?=
 =?us-ascii?Q?3UhmA02SswpnkU7tleXU9udjshjrKAUVXqm0AV60uHbCxBfQ69S1O6XOr8xe?=
 =?us-ascii?Q?iCRzGibVSAtsePRncL8rhLVng2ctWUU/bk/d3P9yG9zCpODxCcFcFdUZZ7NJ?=
 =?us-ascii?Q?lz4YtL7BuwbubRYLsqduJY9EEcYUjp3yaAunYoy+wnsT99AD3dCc7vMVyFX3?=
 =?us-ascii?Q?z3EB6W/SV+Q0b4hnshJ0SqWBhNQQXVxE4xpOAsqSFyJRTZMZokdbOHcXZ5D6?=
 =?us-ascii?Q?2/8L+nb8HUtzNDIprr7rvRjnxjPoypd8CnekpZgV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74e475c-e004-4fe9-cf62-08dd8bfa3750
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:28:14.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g82bkFfnGTtAf1cK1eWOY2WYevpPn/WqqpdsoAkJQ+2ax0Kv+ixrt60KLDvZaeWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430

On Mon, May 05, 2025 at 10:21:03AM -0700, Nicolin Chen wrote:
> > > > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > > > +{
> > > > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> > > 
> > > MMIO lifecycle question: what happens if a region is removed from the
> > > maple tree (and is therefore no longer mappable), but is still mapped
> > > and in use by userspace?
> > 
> > I think we should probably zap it and make any existing VMAs
> > SIGBUS... Otherwise it is hard to reason about from the kernel side
> 
> I added in v3 a pair of open/close op that would refcount the
> vIOMMU object (owner of the mmap region). This would EBUSY the
> vIOMMU destroy ioctl that would call this function.

That's no good, we can't have VMAs prevent cleaning up iommufd
objects, the right thing is to zap it with invalidate_mapping_range()

Jason

