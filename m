Return-Path: <linux-kselftest+bounces-31831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41AA9FDD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9970C466877
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1C215174;
	Mon, 28 Apr 2025 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SV1N9If/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF32215063;
	Mon, 28 Apr 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883274; cv=fail; b=OmAubeIKNLeWxAzdET4yoq8+KP49FMUYY9BaRegVWLH7HoxSX/LyjZsLSqij9odKTSixELlqAkahpPQaRAVUTKe4u6G5ek4jgagYvbjYw+E8frM7GUDW8ZpWueD9SB4e/QGF4vAuKFFdGqaAdpCffLwPzIFApz/WpUovbWOp7sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883274; c=relaxed/simple;
	bh=OCbMJINOZt0yexPMUXzUPc8PnFvU+TvLeNk2ZlSx4Rg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTPKGAPhakccvKhRA4Wqe9ZnDkXrhuVQAfVy77oX522splkLdEi7jhucW62PqOTuRsX2w0amvwiDKI7A3OcI8heBfqC9z3hlMDvEN+VHZGuUNhsbnquvGkLDwPk4igfOr9+siY6tcTtihr9VZ30/cTB6JrJYGpJvgC6tf3Jopf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SV1N9If/; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRkZn7NAaMSj5KHMLwXIJldMfHYY9Y6TgSCy21c2poyAHqGmD7X9d2QOrIusdOHVIkjxv746De6Vlpme332a6lmklBHpLrMkJYWSHp2zOZEC+mM2lZsqHLCxBv+8DqC7kmwf6jAEy219+79MtiyyQ+7DU6kvbFQpjeB7WfQcTOhBnhTuWnT0Os0/k/+pSKnDCXbaWeecO79hMgyRMkmntZRyePZmdaY/cdGRB5sgDsf+fVNfiX1Zsqvl2IazitxHly7V+O9eICugCI8a7nfC7V0At+ng0a1HxUJ6fNldxH65zaJG6MvhvrLyPT74X1kfk5Gt/js3Giu2gaqwxtVy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F7hl0sOww4JlJxvvJwWxhZL1ILZkPC7U0wHzjT7O0U=;
 b=stJZpDKWpkRrRmIbJ78/S//I1NN+NeAlrxlwgI6svXqv1H1FTYWGyrpp7ZF4FE3E/KGbwRUcqHD61Oa7h+DHkY126L8nWqpYECDjjmXp8DLPtW+soq0XFSCht/KoSKuva3njAAI7M2XZCMV0GzZcfhWrdOE2qUPzD5PmqqYzhHoYJ7SR1pGPZPtQs/UE3lJPxuZ+pGQlLGAWIoEhqVDmOfEqoHMYy4tHUqo9/wL3oPOSGpD7ga+zCQUo9QTxWPJepUy3WZH0EtCDz8ngOpgzISDTKI6o9BAav7U6RT+K7+oJrFhSue8t6RNEoH15KiH1AglaG/d6imIOP4fVHJXLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F7hl0sOww4JlJxvvJwWxhZL1ILZkPC7U0wHzjT7O0U=;
 b=SV1N9If/8xTtQh0h0x0+cdJs3RuiFUDfB0wdIP8Dj6/ZOoQTja9CBV4wKb+LVZv473nIZSqnTUb78Wy6nRVoEJo8Rwi7ed6N7qpVtgYFi5H1QdlApKtVHDoefWXy3dkGPhxweDTuUWpVpEje7xDjxzL+mRBXKt9lHRu+Tc7SYys/Tof4xplt71Kf+g4qf8w86YPPxqR7YiUbYXfXpNgGC63rc1to67DvL54RoskNAhEynYvtcqwNT57ygHox87Yv11ZrJUQRGTe190HfKUEB/2m7cn5l8wHxeKrNWbmTIs7zOrIYG4eAdFdgBs528FbaXdnnZ+JDVAYYM8xmMc/Tlw==
Received: from PH2PEPF00003858.namprd17.prod.outlook.com (2603:10b6:518:1::7a)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 23:34:29 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH2PEPF00003858.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Mon,
 28 Apr 2025 23:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 23:34:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 16:34:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 16:34:18 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 16:34:16 -0700
Date: Mon, 28 Apr 2025 16:34:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBAQdq0jeoCdKdsC@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <aA_hm_AD4Xzm3qJZ@google.com>
 <aA/9TZq99TF+MRYv@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA/9TZq99TF+MRYv@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bff512-626c-4772-571b-08dd86ad3838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZHfmfJii5Q18q1THjNj29q2gldetTaDkKNDCmhAkDqTb95xLLScWTIqmhDom?=
 =?us-ascii?Q?ssUAvBqvElkV3SEy4qULK7CXwMoCRd1KV5gHPjd82mpFEWrtbEeVgVIjFzh6?=
 =?us-ascii?Q?Sa0ZAYJF1chsx5Sd/qDfQPFaaPlU1Rkg4mhGqXXqeqEE9B7WTadbFFZpzyQF?=
 =?us-ascii?Q?/0pqmFYo7aYKzhUnlNH2Ut3t50vfJIbiKW5c80yco6av9UQNG28B19yMgG82?=
 =?us-ascii?Q?mnhTXsL4nHabCgHaMifvG42ub3/q4quzqLhp/6gwHjMovHl7HFjQk0neQFh2?=
 =?us-ascii?Q?0UkVvAPwO4SRX6BQs8zKoy5Wb95Ior3hm3JYPEvGSAPFtHPGhwj7SDCb35WL?=
 =?us-ascii?Q?VgNY9SYAnQQ8fYrPX2LaXcuDsG46Bi5YbYh2jMurxGMAQrtuGMFQ8l1u0AI5?=
 =?us-ascii?Q?LzypmnIduV+at9VJ87eNqoTE87Hm49Q+nb/u37ddY6dDuJjuRa+QVnyBGn0Y?=
 =?us-ascii?Q?6xltNU1u95CBUqbEw96aMrYKi8hm2xI0NpTUcCEeShUFb8ZPuIOSS5hwai3c?=
 =?us-ascii?Q?71Cy98ctDUhTAa8K5XIKDMa5saroOf3krMAAcvm3e46QO2ITQ8OrmrqydeT5?=
 =?us-ascii?Q?Cx3uSCJX5VHo82gZ7Oe+yLqYmFLmjO0wjwK8e8p0AYuLGqvyKd3E6ZfxK/9B?=
 =?us-ascii?Q?dpmHyUg1CFuqrFOq1EDTBn+UDeKL3nbRdsfiJYjlKDKGFTibKha0HY9BpAJs?=
 =?us-ascii?Q?OqDRbobSE7uTWe6sYMhtkTFvO9c3YXE4XiOvW/P3IVfOcN7t5WG+LzqMc4LZ?=
 =?us-ascii?Q?pbLz3HI+nqDcNR/ebLBHjtbwjWyW4Qnjj2vwaAIEtDKS8f8IBieUnuV0KNoP?=
 =?us-ascii?Q?ptVStAHKMDes7KoKqIvlVMM0Na0RSo22Xyfzo/YrtzHt1XSkeiP0TbemP0tu?=
 =?us-ascii?Q?Otcd2MqgoI0btHb5QmSXRA7PGCfPeYz5JwgRjrnabDQreSMZWP3nodvCYCiU?=
 =?us-ascii?Q?+nODoPFvyr6qQOoVwanxMuY6eEwl0LaEbcwqyOZ7REXKe5RfAYpxqIlCr+Jr?=
 =?us-ascii?Q?FR11g1hEfMFrHyt+Yq1NwC8bD3yDJMoiUzSzE+zd8CFEc6RFfr+Dz72L6yCX?=
 =?us-ascii?Q?SxnkdrcnCcnYdP7C42IILzjzaBe6ZYdbRPpx8zt+Ak07tDKqg+0mSX+vYfUk?=
 =?us-ascii?Q?brFqpO4JINbeX3Li2sG/nDAYmzredCineW/4UC747G+VTkR2GBjNDhm8FF/B?=
 =?us-ascii?Q?ebT6DKg4clkKwt/mwe1asC5jK4V8sz+k2/gLIIOoCpGqzlv1TVbb1coeihCd?=
 =?us-ascii?Q?M3ZNJJqMxymDXVSzYyOFkpu9yRXLvmk47fjSvLoEcQD4CWdYyusZyfohQpMA?=
 =?us-ascii?Q?UaFcESj+2LLXYE/8SKWRunmDv3NsQfAqWn31gJ7CWguZPgHYwS6Y7435yCYS?=
 =?us-ascii?Q?d+D5xlnziHokutJ2814EalWqM+lRXzTQ/wCED8GpNNv74t3Sa/olosQsloX+?=
 =?us-ascii?Q?VZWDnvBzXFqIZEf8n1JHdxei8ar7yX7ixfwRKNBP0KyGVuMt507vAIm9NYJw?=
 =?us-ascii?Q?JYB2Aq3te22S+ie/drxcA7e/ZxxynKqXNWBD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 23:34:28.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bff512-626c-4772-571b-08dd86ad3838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

On Mon, Apr 28, 2025 at 03:12:33PM -0700, Nicolin Chen wrote:
> On Mon, Apr 28, 2025 at 08:14:19PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Apr 25, 2025 at 10:58:03PM -0700, Nicolin Chen wrote:
> > > +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
> > > +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> > > +		unsigned long last_index = iopt_area_iova_to_index(area, last);
> > > +		unsigned long index =
> > > +			iopt_area_iova_to_index(area, iter.cur_iova);
> > > +
> > > +		if (area->prevent_access ||
> > 
> > Nit:
> > Shouldn't we return -EBUSY or something if (area->prevent_access == 1) ?
> > IIUC, this just means that an unmap attempt is in progress, hence avoid
> > accessing the area.
> 
> Maybe. But this is what it was. So we need a different patch to
> change that.

Rereading the code. The prevent_access is set by an unmap(), which
means there shouldn't be any pin() and rw() as the caller should
finish unmap() first.

In the newer use case of vCMDQ, it's similar. If VMM is unmapping
the stage-2 mapping, it shouldn't try to allocate a vCMDQ.

-EBUSY makes some sense, but -EINVAL could still stand.

So, I am leaving it as is, since this patch is just about moving
the functions for sharing.

Nicolin

