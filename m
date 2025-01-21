Return-Path: <linux-kselftest+bounces-24893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B07A185DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 20:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AA23A2138
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711B1F55F3;
	Tue, 21 Jan 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0/F1wCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013C1EB2F;
	Tue, 21 Jan 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489352; cv=fail; b=GzdcQArSNFb1QIueG8oOPUJA2gjK9B7EWvMTriw1yvs2WzFJpssVd5mGmaqi7pXgeYvOt7Fmvloc20TJySg4PxA4E4S2+Umxt/1d3TeGTJUsHdrRUvBN1uoSzAyGm+DY4z6zw+PuUa39CwvGuZ+Vm8/FyPd/FB1XQ6/QIx9TVXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489352; c=relaxed/simple;
	bh=Zc1gEYPENH6zPN6ug58fglDpfxfO/sJpGUO2HvBH+f8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG4UqhKNeXDC13m5BYHUNAna6LzIcOD8OlE416giSt93RZHztxNAI2gAR/FSGn/kto30628ffUXJogvRY1r/Rswl7JxPMfwazlCXQaskh88iUcB44H6p/LQkUQKCzw7/2mr0/QwjCX1MkP0X19dOaCpLw2PDaWd81ri2PPVaT30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0/F1wCA; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPIT2F0SekjKP3AEP0oliitpZmiB9+aAKLOqkH8/yYT/x+jTiY9Z4id9dBC0di/FbBMJ59EMx1ooTDHkNYyFhaE80iKA7BDJoWDrYIhleTuZp1S+7K9uXhWEnUXLrmGyN7UFiyjW2HvGHQ82+SLM5tG8vaZlyiqJRW5NWNjOieaMyLWkQfsfRpUfc0qN+CI6aorM2d05TTtuFnDEak8x0ZaE5iUsTC62qI8NmVFoVD8vVGCqXCckZxr0cr3uv3mazevDXc0u1deBq6JPSorWhnnCh2Qqqg5leERLWnA5BtCZ5hNtb9Ew0vUj3PFFA930vtRmQz9naiWLS+9qnMAKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC4iu8bXBbT0ZHSla3RRjIntqRdu00Oh4k1yf19TIxg=;
 b=cMPEt+i2eGsGXxHXMbZE1zISg9HZQ7UcYrtmsz7/xRFyqOVEVhQhRda4sTXT2PE4PQWfgi98iWlHT9LJogDQU7Cmyt1JtEBqQIJOp9fiTW+hnJ32YcZUmphyKD4JpfNysvIUJdjkqaLl9Vyn2vSePtIa7SbslYsS78EsO6eQLSlg5IVJrcTML0W9Y7sagklu2nVY4pD7IMt0L1wAH2smY6+0QkWfILYXlqSLYCv4fI42kHNOQzAzga+j6uHMMAOgTxEFe75/RT9KyLsORbX7kJMo0uLQna7ilYDCalyZEPyNlXqJE/QFqpkJ5xdpTn2e2l+EEkT6eR1H9SKIMDyO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC4iu8bXBbT0ZHSla3RRjIntqRdu00Oh4k1yf19TIxg=;
 b=D0/F1wCA/4WA3E3mQaBvZPms48DF83DNh913sjtQTtZQLoXSMkFx4yUrfUuOzXmgpJeVlSUfxPHPSbj6dZPF5xv4eGTMzi8zR2FMjkzCrXQ2veqEaLsFLToJvv5VuMazjQj5yZJjuJJDeUSO0VyOrR0zBybvFLjPti1G43aFOxNYPFyVupr+LyMXqTATXva9bftBS5EC7im5ZwZiyBD/m3oCEuJHkIaZlnCoiua80Lp2KOtwoPdFLDKksjjI7hbzkI2gOzjb4vSqWPZQx8ZBoW5oc2vEfnw5IhyD9lopCw2NQOAWOC0s+rBfgeoTXXkr5FfPfoxBL5vExA5XG3zCLA==
Received: from BL0PR02CA0084.namprd02.prod.outlook.com (2603:10b6:208:51::25)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:55:43 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::93) by BL0PR02CA0084.outlook.office365.com
 (2603:10b6:208:51::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Tue,
 21 Jan 2025 19:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 21 Jan 2025 19:55:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 11:55:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 11:55:22 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 Jan 2025 11:55:18 -0800
Date: Tue, 21 Jan 2025 11:55:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z4/7pGx6F1mpAUuV@nvidia.com>
References: <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250121183611.GY5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: cd08dec5-5a7d-4d27-715c-08dd3a559721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqRb2c7hwdBjo5xtVv+HCZ94huQ+WjUloBWdZOm6f8+ofJINXXrIADTs3Faf?=
 =?us-ascii?Q?uIx1jaNpDYl5a3DenBdYbhxHOJby7f2aWXmCxUotZZNL6QbForMuMM/jwW2O?=
 =?us-ascii?Q?M/V1ToA1WOl8GBaG5z3EHewicOgEOVvJvfe/M/QOnIgHY4Nr+RIbVW0UjgSv?=
 =?us-ascii?Q?Q0RIPydNYN43u4Vyq4NyK7eExDSKvu8+IY1Se8km80aGwFNMLkql6rVrBnlB?=
 =?us-ascii?Q?BqL06DIhj6F4XoLhAX8TwoPI6UACx+Pze6G/6QSbsWcFDCBQxCF8ll3PeTSx?=
 =?us-ascii?Q?jp5mJR6hgRte2elkGJ1IpwskG/uHVaqyxmHdAIn8+NPI4XFnplQbeMFYLQUO?=
 =?us-ascii?Q?d7gGobmXew2xISLiRsi5brUcIcDRPFukuf2X7kbPVu/OPIzXOuXUUFpZ3f9h?=
 =?us-ascii?Q?/IyExVLokkMCWy6lk7MkZjvclsNBgByzY2ABA4cySpy4FxYSTRmUMeWsSeY5?=
 =?us-ascii?Q?Cy87HWESszOI1rfVN7UvDjFqjYmMPO0iJi/FewfDm99vmIW4hPsqoaBc8q/m?=
 =?us-ascii?Q?uZ5N1eH6ysfZi87CfBxSXTvKwdkIm3vmEdfAeVz3qIRHjPodbhP31JEjugyG?=
 =?us-ascii?Q?t5efrYhQ4q6Ws4g1G/LTz5aXwyC+eGqleRV1D+HRJXZGqg0snmQJC28e8TA0?=
 =?us-ascii?Q?7pbylihbRDblP5iuYIzK7KewjtqNZp+NcBKayng8d919oHmSYaKiFhbxcmDh?=
 =?us-ascii?Q?xlb4O3V4zYhtV/uAPhxd7AtsQmR32EJjnyve9ces2g2xS9ajZwQB4JJinXdD?=
 =?us-ascii?Q?27KhEg15VJLvz29jvNLwiuFBpUVc4pM0kwir4/PTr0rQQBK8GoM0P+lZRbzS?=
 =?us-ascii?Q?f/fSxQJCmfQMIz9rTIcGMi1QTC9DSAlL5obsPbUAj/zAlKfuEljt7Ix2x7xy?=
 =?us-ascii?Q?10uVae5duGCXMfshSvqarNlbLqiWHZAHND+hAWYpDhytLlcINbWYfOECK3Sq?=
 =?us-ascii?Q?DU3fI++dEU3gzbFc8tEJs8JJwerTtnlL3ebmJdTAZPD3nsV40FyR2KEJ+2cA?=
 =?us-ascii?Q?mPjSXohvZjGfKvxo03uiFqFlsws5/d7WNts7jEXR+D6DehZDoWvhgmiEjRKP?=
 =?us-ascii?Q?LolLABwHQy36xjCL8wJoFedzznfprFPPVa9txKkuY+yEqR83VfIn70fUPMLa?=
 =?us-ascii?Q?l21nXEG+RUqTjs3teNwyLWmmyjeWn2ooIoFZucUWtKl4eaBBX2I6OwjBu24b?=
 =?us-ascii?Q?lxIxRpxR9j5FHQ3NFcuTP8W8c7qk3AnkijbdR9MEIof2L4KZxWjEos7ggK0c?=
 =?us-ascii?Q?ngVTpveOfOV3ZTa83GrjLPAYiNvhbdlOorYDgOmvDHbLQ6L9zWVzCaltWNpi?=
 =?us-ascii?Q?NeENoITEiRS/iHt7OTiExBzORnD/CTWiXv/Pe0tpbw0KVYJi/0uZ9ovTkmnq?=
 =?us-ascii?Q?SHZ3D52Vwl78ynyDq8GGx+GFVORVNywhFWaUSGaqJQ6VTKTaVN4VzOND5wRG?=
 =?us-ascii?Q?Hru776RbfmaAbjAODY+FFeHrs04/aFkgRxdnIB2B1F6TcPRMWcZiiTx7LEUA?=
 =?us-ascii?Q?VOWpXl8La3be868=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:55:43.6629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08dec5-5a7d-4d27-715c-08dd3a559721
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

On Tue, Jan 21, 2025 at 02:36:11PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2025 at 12:52:09PM -0800, Nicolin Chen wrote:
> > The counter of the number of events in the vEVENTQ could decrease
> > when userspace reads the queue. But you were saying "the number of
> > events that were sent into the queue", which is like a PROD index
> > that would keep growing but reset to 0 after UINT_MAX?
> 
> yes

Ack. Then I think we should name it "index", beside a "counter"
indicating the number of events in the queue. Or perhaps a pair
of consumer and producer indexes that wrap at end of a limit.

> > > IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> > > have been lost and no subsequent events are present. It exists to
> > > ensure timely delivery of the overflow event to userspace. counter
> > > will be the sequence number of the next successful event.
> > 
> > So userspace should first read the header to decide whether or not
> > to read a vEVENT. If header is overflows, it should skip the vEVENT
> > struct and read the next header?
> 
> Yes, but there won't be a next header. overflow would always be the
> last thing in a read() response. If there is another event then
> overflow is indicated by non-monotonic count.

I am not 100% sure why "overflow would always be the last thing
in a read() response". I thought that kernel should immediately
report an overflow to user space when the vEVENTQ is overflowed.

Yet, thinking about this once again: user space actually has its
own queue. There's probably no point in letting it know about an
overflow immediately when the kernel vEVENTQ overflows until its
own user queue overflows after it reads the entire vEVENTQ so it
can trigger a vHW event/irq to the VM?

> > > If events are lost in the middle of the queue then flags will remain 0
> > > but counter will become non-montonic. A counter delta > 1 indicates
> > > that many events have been lost.
> > 
> > I don't quite get the "no subsequent events" v.s. "in the middle of
> > the queue"..
> 
> I mean to supress specific overflow events to userspace if the counter already
> fully indicates overflow.
> 
> The purpose of the overflow event is specifically, and only, to
> indicate immediately that an overflow occured at the end of the queue,
> and no additional events have been pushed since the overflow.
> 
> Without this we could loose an event and userspace may not realize
> it for a long time.

I see. Because there is no further new event, there would be no
new index to indicate a gap. Thus, we need an overflow node.

> > The producer is the driver calling iommufd_viommu_report_event that
> > only produces a single vEVENT at a time. When the number of vEVENTs
> > in the vEVENTQ hits the @veventq_depth, it won't insert new vEVENTs
> > but add an overflow (or exception) node to the head of deliver list
> > and increase the producer index so the next vEVENT that can find an
> > empty space in the queue will have an index with a gap (delta >= 1)?
> 
> Yes, but each new overflow should move the single preallocated
> overflow node back to the end of the list, and the read side should
> skip the overflow node if it is not the last entry in the list

If the number of events in the queue is below @veventq_depth as
userspace consumed the events from the queue, I think a new
iommufd_viommu_report_event call should delete the overflow node
from the end of the list, right? Since it can just insert a new
event to the list by marking it a non-monotonic index..

Thanks!
Nicolin

