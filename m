Return-Path: <linux-kselftest+bounces-24405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868DA0C22F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E4B1678F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876B1CEEB8;
	Mon, 13 Jan 2025 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAw8nnKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D71CEEA4;
	Mon, 13 Jan 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798079; cv=fail; b=hrjdC9vonTS3coOEn50o0XVi2zFpEMHqW5duhF1M7Ng4HBnondfjqNVCpDyY4BjVZAgL/Yxb7wH8AAKZirkbaWKV6ixmoXpSpwzGZztowuTBOk9G3pHQbKLk9vC3PPYIfEFbnS7dNq9G/EPw9nObnOnwoVvpV9vpteILoLyhfCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798079; c=relaxed/simple;
	bh=MBKdJuaegIQrgPWFVnxHuTpwAy/62przrmkFrd/4YOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCOJm3ep5Nx0YmSDI3BPYFMCyEC1nX+wV+Qa02NvbBa93Kll/pY214Pdjjs/Qmqr+CF7A7r2aNDtkGekhOQmudrqs0hvcYDoVzESLGhxeJyltuQxn06ATc2Zv/nUmIVw3cpg7XfToWFa4iKecuUmU78YcWiU5b2h8w6AWC2r2aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAw8nnKs; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayfhynXtnvCSytmRGoPNKFQh4gfQ9huskHIPtYSWZMWExgulK6ZRX57aimd8yzOnBli8irUZaxKqLqhoyvGqhTZRyGqacGcTzikZUfA1JxU9DOXb7e2L2kw6zGjjNhF3Tq/I1Qvxx7BnWx3Mxf+sKVlZhdrammpwxO0ZVu9cTuyVeOe7L73Q5K9oaoCAuS6MnnWDpc4U9MhKd1CN9wkKBQ+juL5NqM01Q16Qu+Gl2VoaB4GQlCDT+cr27VUoc1AYK0ReSGVTJ8dVqY7t8FpHjtRn7se52GayfaduXGnzqcz7WYdKxhkWfnRt7Wxlq9nsmzDVMv0lufpuku3ZPI/HUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS84wuAMzku59UCchsvt2krRV7qybuOUlopYI6wnL2E=;
 b=PNxQKeUgEGHCH3QWzAjf0EqrUJZurYtCiwoMvmEPOm9Z5DiDFQ5wwLZd1fn/LK5J2m2KeSX3h2LbX/MJtaoJaRZG0/qLmFNVGVpMtJ2CvO5cOJ3PufgxvCtiKl+WFQQU0ozwfyKJL48B7SyTMuY18hx3PFD6Z2Ta6rK4nEproF8nCmd/onmITHhdB8uwV/D34dThze+E7k85zIpzpNNP+7JD4H297mXQjoiObEX+ZaqJ8wE29bRIQfyo3AWq8SyXxPIQo7r6LONh7XVg5RWbGTXCO1ka15NxdfRGjNBvFMake+ZiLc2MUl5tk6s/VnBw4w5XuYeWRY7Cd4iLmCo6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS84wuAMzku59UCchsvt2krRV7qybuOUlopYI6wnL2E=;
 b=iAw8nnKsYtcLByPTpPbYWMF8xaA5EDTon+rku/R19EuVewpc2CNNK0ZnecNC38Dnk3RUQcSIIYthMjvVUbRe+ltRr2mOwCdxR44E67xq1FgURVuQF92P68wzT+3P9/y65MQfWeAu0nG0sCK9iNMCPKiyFCtDLvi/mUCCkrvgB1/hbP3So6jC+L6iYp3um5aHxQakj8H10TghU35X40iExVf5Ak3+fWWx5LJSFg0SG3EH4F+y5ur5ztTyfmhGnfGR8kQ5cbl/UYVZl2hszJW7b1XG00uJ1sU6epuVTUybN51zW7JvtYnCqnqVyf+K4JT0HdljLJGuRicRrU/anthm3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:54:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:54:34 +0000
Date: Mon, 13 Jan 2025 15:54:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250113195433.GV5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:23a::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f79425-13a9-4571-e9ef-08dd340c1a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AO7a55s1p1Fwi+KrwnvmgJ5FRIBdZjGHnmqS3ttCqaKBrGf66cg1AAL+yD2k?=
 =?us-ascii?Q?9mXonPdee0S6BWBR1rZ0uafJPujNh9I2tLHEDVyE3ZrvzoIkGU/q9rov8eAc?=
 =?us-ascii?Q?ivQvbaM98GSrIMMN3ni+cJOLIi43npQylWPCweNGXEuWdXVweM4z0VpVkPkq?=
 =?us-ascii?Q?eKSIOd8MJSFb7C9TA54+rc0wjgW8EZrp3vX3zPDivlULqTZNfC+lsfZLlg7x?=
 =?us-ascii?Q?9aMDFLvBFacOzW58dZYBmf3ar2AFdKBoaDxJp3rbijRtBRlIxXxd6Kl9xylU?=
 =?us-ascii?Q?JrPb7SdUEjthv6RbMy2KWHVW9ACwa3CUergK1FVK1hOKJzK5Qpvm2xZDVhgF?=
 =?us-ascii?Q?fF4knPCJvVUl++SYC/5dJhOD7mi+4lNIl8cF5qXiGRAcIIxs+2Hql5Tu33cm?=
 =?us-ascii?Q?Ppl8vBEdwOi5vnf2uFR5yX1XJnPJ1DknOobNbdcXfIvIl5vwuJV3skaEXHHE?=
 =?us-ascii?Q?oAdhOre6YXlZiQQ8VSaYnncPBu8yiPSRfIRMwWYJdbNuwcXVLAqBZ8mPZRJe?=
 =?us-ascii?Q?l0e9KFH0xmBxBLKC+MyEb5m4ybOiChRVvZP9oPHDwuMD5Pe9Akc2gbOh6fta?=
 =?us-ascii?Q?1Sc6tMFCincTuKLNgwP3uotRsQPK0xrhSpUG0wh0UOv5BujGhste3Km2+PY4?=
 =?us-ascii?Q?UIm9ngdi/G0bpqDhvuiK7XLL3Y19VGwa+Ss+LNHCTPf3BXISZhNQJc4V6xT0?=
 =?us-ascii?Q?Gahnr+8IR8IiICoYTIB4pupe981EMKmZ3vX+OjNv6W9k6SPcQ88uLDr9gFJ0?=
 =?us-ascii?Q?ky6E9sZvAsj0TWWsbjEhmPT/M5cxofC6Tg9inDpklTLbmXGOtVKRZsmWC/9Q?=
 =?us-ascii?Q?26mGVa+H+4KEfVwPDnSt0flfLjcU8lvG45+qapEFe93c5XVZCAEUYShCet1k?=
 =?us-ascii?Q?A8cghndwLciOpKS2KLHnwvpOYaHSdzCZrtnd+C8OxzJUAXaj+edgAfGWt6A8?=
 =?us-ascii?Q?hrudPEjOBjxSJ2UcpDb3CKD6Ox9NtGLBOWAqMi175Z19V7+SCoPfmaXLEpcZ?=
 =?us-ascii?Q?dpCOQNVG6F6AM8WpNU9iDKdeeC+9QX5RP6PfBLjNVmgA6zLcfMfCeFaW5OZH?=
 =?us-ascii?Q?pbXL+3C94ACEJvEBF8yF7k6maFeHpwPATY9UJQd5Oqhrb73J9Mj2WFPxsRwa?=
 =?us-ascii?Q?2B0O1cVPCCaXzx+ia0Bi2/JlEkP3fDEz1sxa9Fl229rYUInZdgUaWPJHIOkD?=
 =?us-ascii?Q?ApnRkokEHm6K/uipmAzj+FOZEnX+f0j4/6qWIfXmVgsUkKgFzDp+jBqnab+l?=
 =?us-ascii?Q?nxF1h4Oqei0Cw7TLUFwqmup7zRDHhab+BNXYdgXu93Cb1xOxpmt2Jv3jDBaz?=
 =?us-ascii?Q?XKZpsD2lFGNKI93wluTsvnLgJ3fOyOIRgmgpaX/hHh9UY2s+nRVdYeHK1gRt?=
 =?us-ascii?Q?/2IhwHw5tfaJnL4ZZgHIWlxDov+i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVbf1Y3gCdNYuvQgNinJQ0k5Sw7gsuZuYi3HAWbx9XdZSqW+o3dnNCsPE983?=
 =?us-ascii?Q?vx9UaWHHEU2vx/vX/+8GfrpvoyHIwZJOAdu/aLslylIaIe3U+c4jxNAnyl5M?=
 =?us-ascii?Q?dx213QGCBLT08deharhZ8tgYLtihbIGktOkKILZkU4C7C81PPxgaa3mdVUo1?=
 =?us-ascii?Q?dZF+scJMWnWZc5aWxrtwMaZIX5CcL8ZY1vAUtt89H90brY9gqopVRYzt5cvt?=
 =?us-ascii?Q?d67s5Qu1LLj8TVW934loSMdszNZw6Drg1VD5E93A7CFcU1ndIhFvk6RhUqhb?=
 =?us-ascii?Q?xRtJXxjOfTaNvF3iUiPegDtRSl25whyp0gW5s7ZT11+AKQZRg0mYfhgSi+c8?=
 =?us-ascii?Q?6eqWnB9nyQ3ZjwOYo8XgL+WK+E+F9uAQtBi1ipVLPhV3jBJKEIlUc3zOPb1D?=
 =?us-ascii?Q?fW/QNTGdqFH2+IjLAyNSCK5vrCPNPN2VdSpg1broq2eorZoF6j2lFlB/1qOp?=
 =?us-ascii?Q?hHtnafw1tJy9wdEFslcT/yTWwpz6CswF1YmS/IF2sMk8ztAxQuKHedAbfqxH?=
 =?us-ascii?Q?dnHQYVYyf3XJA7IXenp0+PT49hvGCldIGQLfvB2OhrvFejPHOhnIsTED8JIM?=
 =?us-ascii?Q?qs1BRTktRGgH8IWdpphSNoSs/uX6+ZK2eiTvrxBKV/rkcmEILm6YxaikYhRU?=
 =?us-ascii?Q?KGfogqLgN/oaKVChKJNaU0V2/q8t9/A2y3zmlL8XEvaSi6M8v82looTj4JPx?=
 =?us-ascii?Q?1W/7WEk2GpSjuEf4adr1R4ZZbXXg11Q5R60UdeLwsFkOttPAoCWTPu2nQ+wR?=
 =?us-ascii?Q?3fZioOlkuBegYL4IfkUushOxR7hbOqEJxq8CI+uQsHKMwQX+8u2ZpYhX927h?=
 =?us-ascii?Q?BLuwQfI69ffWEhIxQphcpZVjEwX3y2/aTVw5wdHXneYcGqbs3yBodGFOQ3SQ?=
 =?us-ascii?Q?eFlbrEM/w6tUqC4iecnGNkqcf82wMEf1BH97fJCB9vIc9YxSmAdQrNGKbmc3?=
 =?us-ascii?Q?1Janyh+Ky3DoXltFXSCRKE0A5uB33//XkFsA7egT0ix6p3iYV6d733hNxueb?=
 =?us-ascii?Q?jGSXLzmwQzyOSt7RjCexRH0VS78moNiuOhAB8ey4QORaRVsJpN4t3SMRlDdV?=
 =?us-ascii?Q?AzKLiwcryaYBD3kLb/4OP2bBT90d32E2tHZ6dyHOoSEWfpPd3bfU/2rCg41B?=
 =?us-ascii?Q?hKcYROKBBw28TcnwjpxipkQpUqdGbW+YQtpbSNBA0E0Jh2/ivBFq6hnR2Iiy?=
 =?us-ascii?Q?FuTCVPc4zl87BaHhY/dbc15j8Vrfra78fYQEB0/C/Foj9V0FMpWb+joIZcdb?=
 =?us-ascii?Q?UMqK29HuatKW0LcHGVbkhSftOOxRrIQOFM3fx7CrJTYQ32H0dtKun907OK2x?=
 =?us-ascii?Q?5lfc4f7XjuQfCD1X6gtajwbv6dFVue9AeVaW3tENGfsilNQyazJ/pZHfjjhW?=
 =?us-ascii?Q?XAgRZ4hBV+nlju28iOglpjTdgQMN57XzX2vG6CGOn7ojyfcfofx+xYLmNQ+4?=
 =?us-ascii?Q?y6FaE/09rNnSQiVF8J7G4Wi9sNEC+tgAYEqHGfzuNAqiCazf8IH847hBIZe/?=
 =?us-ascii?Q?WYKJVM8LZAK+esqA4ozvvjT1qxuhTff/V8X3MivLCV1PytMZROX+TeQGpTq6?=
 =?us-ascii?Q?5qDuAjiPVGfTSwNf1PpAM4nPVPkAZ5CNFi8eJNoO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f79425-13a9-4571-e9ef-08dd340c1a56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:54:34.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNeGgpCvoCzrIYWUBwW4qk1uS82tf7QVYskf15H/U/vX1BuAR2m++2qNZGwbTfO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

On Mon, Jan 13, 2025 at 11:47:52AM -0800, Nicolin Chen wrote:

> > You could not return any bytes, it would have to be 0 bytes read, ie
> > immediately return EOVERFLOW and do nothing else.
> > 
> > Returning EOVERFLOW from read would have to also clear the overflow
> > indicator.
> 
> OK. That means user space should read again for actual events in the
> queue, after getting the first EOVERFLOW.

Yes

> One concern is, if the report() keeps producing events to the queue,
> it will always set the EOVERFLOW flag, then user space won't have a
> chance to read the events out until the last report(). Wondering if
> this would make sense, as I see SMMU driver's arm_smmu_evtq_thread()
> reporting an OVERFLOW while allowing SW to continue reading the evtq.

Yes, this issue seems fatal to this idea. You need to report the
overflow at the right point in the queue so that userspace can read
the data out to free up the queue, otherwise it will livelock.

> > The other approach would be to add a sequence number to each event and
> > let userspace detect the non-montonicity. It would require adding a
> > header to the native ARM evt.
> 
> Yea, I thought about that. The tricky thing is that the header will
> be a core-level header pairing with a driver-level vEVENTQ type and
> can never change its length, though we can define a 64-bit flag that
> can reserve the other 63 bits for future use?

The header format could be revised by changing the driver specific
format tag.

You'd want to push a special event when the first overflow happens and
probably also report a counter so userspace can know how many events
got lost.

This seems most robust and simplest to implement..

I think I'd implement it by having a static overflow list entry so no
memory allocation is needed and just keep moving that entry to the
back of the list every time an event is lost. This way it will cover
lost events due to memory outages too

For old formats like the fault queue you could return EOVERFLOW
whenever the sequence number becomes discontiguous or it sees the
overflow event..

Jason

