Return-Path: <linux-kselftest+bounces-24812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC0A173D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 21:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1103A7327
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51E1EF0AD;
	Mon, 20 Jan 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlHp6yuZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC8188A0E;
	Mon, 20 Jan 2025 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737406347; cv=fail; b=lszpI1q5R5Z2UXV6lYovYHf4JkXTYjKEF8Lgx2Qpd4GXDyh9ossqz90kV0j7q1NgKjrMi2Qf2eEhTMrGUFItCEhMd0L6ut7h4Hdk24Wwb64/pocobLjxA7KVS3qlm8TRn8G91dJWJ2SPTvHIlykrIFNE+I5MorHuSL6Tzn+2krU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737406347; c=relaxed/simple;
	bh=vH7ytJL5saKvi3Os9MOrECdAs+PhajJ+GzTDPb0q/co=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA7AnsYlHYXS1igjn9W9cpeEMkhJvBRMWrwYzNAblQlBLgF6C3k6K4Xuc5NYTHYXBdIGg97rFbSXHigaETE1zVvS5KDHpqmb43spPYjg8xnf+7wqiQEfFLoKUVvQ+wFi56kgBjFEIS15RmvdMtz+AG4BfCiKEPyX0Mlup1xqStY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlHp6yuZ; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMugp/ULYC7JkRFHhC1bVxFMJhJBjye31pgAiFYf+Mc4SW+COPfQoI55Uos9f9GCGW1NUR4AhH7Zx0rNthKwbuaybYxsaKEkzqM7OlLB0QGFyeVamHIDoScbztrM3XlEO92aJncjPBkxDUBv1Rspx6EC189YJ6ITz+h90GEkl08DVuzRFoqEHboDQiakAQrFWfPGnIwHj89Mi2XO1BrcelolXl75t//myR214R92drYE5ZbnGyWWbuSsxtfoMWEBSbOprcQr4G+AzzWnsJsagKE3VQ+RWCcp9mZO31KiS+/QqHaIzNIXqzRRSxrBMBWocNod8jmsYrwFO/7PJuSW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QexsPUeDT9DhzSr7QVukDMy8urwzeBsGzbqHBILLznk=;
 b=hE9y0csvBQX3He6C/PGetc4Iwd0/BnlQwIwjIXB0PlSxXo1IH0811R1Pk/Zqm+hwtvAswAUc79ip0tnSkZOJ8C6/sf7lbc8sh12ki4xRT+EOlXKZNn6o1CAn5lSn8YXLdC4XmeR9PmNtk+4q6uVSFtxXCZYcr1Gsavl84rEjixKVNvAJ18GzJ0n6cWzdCHlbbRjQLP2wNMmgnDXjQqcYRdNHbT8v7F4YQL4ed98GMvI19yiLpRWvAXp9GgRMew0dT4O+jWoEAxUvB4jmWo5jkCvr++8vYsckP9inDQquLvEH3ugQW9p+qkNTs8Jcbu52nDbi1wteAcNHeaNs29MFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QexsPUeDT9DhzSr7QVukDMy8urwzeBsGzbqHBILLznk=;
 b=BlHp6yuZOVY/MLPlkEaki8lBRimJClrjccLXngzAQOAQ47g4lXgZkwPvsNHuG9hUIaABLXqsS1ezdp4Npuu8wAwVMX1EzgKhxw0UsXwbFjqSZpCdIQSxk8THIUfcwQctQFtGu2MJme8FlHUddjXyKYF/CnB3YFNdMQBa4asmy/zejrxAvmkHU9GcpzEbk14pxzPkgaZilFLkqrsyPB++QiuN5HAvm89z07Xs17SesXtFfiHJ0CegBKNf7dQiyOLQ4ILM/Tx3fHbxPrEYq9Tc91F02XFX1Z3gUMkoT3X4g5aatxtZ79GtBVPNiUx4ruBmzB3IpkPPWFTxt3DNauN68A==
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 20:52:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::7e) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 20:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 20:52:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 12:52:16 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 12:52:16 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 20 Jan 2025 12:52:11 -0800
Date: Mon, 20 Jan 2025 12:52:09 -0800
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
Message-ID: <Z463eXfgNArCOfPn@nvidia.com>
References: <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250120181854.GQ5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: eae517c9-140c-47bc-2f51-08dd39945648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xSkYibqociC43g4Km8leDtnOjSgIES7x9r/UbPsGiSVal+Y+gE0ghXEEBN0V?=
 =?us-ascii?Q?VqEDyfOhCCD7cGouxSp481f+iGQP68HGbBGDaXDlx+wR0TlhO071p0mfidK6?=
 =?us-ascii?Q?7bJT6X6dV8eHm5aPoXYImS5bBD/LaAZSYfMPlmaesScwB8FpfUcX1Xr0dDVc?=
 =?us-ascii?Q?8VzPpGAyhstaWd4y77Kk3P7Da7i+1i5Rt8l3kSs8TwCU/ba7bFzZikCZyPXu?=
 =?us-ascii?Q?R41yy9POiWexEQqsLKANlrdIZeBQPoy/LMJNshJBJHHJZgQma+7X/bQ4ybI2?=
 =?us-ascii?Q?TpVhN18/0T55U7AISIyB2EHQdsvQA3ub3YkG7JH2XeOXNIqMbeqH/IhpymFB?=
 =?us-ascii?Q?9rtu1Jy22A3jNh3U3f3EwA4TDF4Qu10JkE0xZWxpXKUUC9SIVa+pKm8kUqen?=
 =?us-ascii?Q?Wd+QKy1tqJCSOGIPzhMVA3WG6HCb8+MdBKaNXDC2ZjKBcaeOoXkDh74jM62A?=
 =?us-ascii?Q?clpAKIKZQzSR4pF8kpBM8VJ6H1ol0UXug0d+ELu3lETQZt0oMAiIDV0ter50?=
 =?us-ascii?Q?Kfm5Fonub9LZG3tUTx/mp3LJhm4fYtGZsrorBGsCxFj9fAtPnktAxQ/ST99i?=
 =?us-ascii?Q?jl7OsLJZRd0HTD75UDWtj8wbVRlIkv4YwnevnmGlme4C3G4gL1Hi6W87O3Gv?=
 =?us-ascii?Q?VQ3aXjSt0/BVPV3gWirfOP0v9awc1jtQyaRxSuYcGmo3+NwMUV5OjS77v/32?=
 =?us-ascii?Q?ebr4nVyATQf1peQbsw0oWqoCMTrAtdM6sm0AL16MDvWcN0xcB3kJfcZ1NoBT?=
 =?us-ascii?Q?+Z5lCrLmkPg66MPSALJSIZzklfQhKfhOj066mQwHIw8o7jW+MLUwR2b32dA9?=
 =?us-ascii?Q?/H90Vi+Lufpv3dYar0SPWQ1HThV6mrh013uJtyjauwMVbGmJSeT38eL8kONS?=
 =?us-ascii?Q?TEkWrbOUoaocacbtsZNB9uPybNmv32w67UO6xD0mgRt2mxxq62X6UvOlB2uB?=
 =?us-ascii?Q?fWIPulf5m8cu5NFqkGxyDudWT4OSeQWC/H3CcmI6h0CC7+1E8POOVK4Fc3bW?=
 =?us-ascii?Q?C/a98mjqVc5Pil795C9Z4pc8b2v/zo+pBlCFIICysbUyI5gdvPY7eiMDRA72?=
 =?us-ascii?Q?GXhDF5i2PuZ1qxC85CNOt9WEajsGATELjUStxxtn119jvE/ls1sw7d2RW9nB?=
 =?us-ascii?Q?st26wOUNz7OJN9XMUL8SUC9uj4ao/FQwSC2el5oywuNiQ9N/Zqw2UkMZClOF?=
 =?us-ascii?Q?gY8bi8cw/IhosWHZOTyLl9lpKd8YmRGvO7N37lgrp2TY8yC5J1lKARdEgqTq?=
 =?us-ascii?Q?zc9xx9Xg7m/5dOSpZ4lWzyBPiQzjlRGvPk/KaH1W+DiViDoPhi/FVlys0s2c?=
 =?us-ascii?Q?vLda8TRGlN5OHL50lo7r3tMn76tvWZmBmaxo3r7UT4vEwJWphwn6GIR1rFLQ?=
 =?us-ascii?Q?J7ZHHci0+XZts/vjOtlLyfKnzF3qUk/Bw2K+uhrKxZWEWE83RX0FISfYyB7o?=
 =?us-ascii?Q?k0cRo09CuIbF+q9K1CkZ41pMh6QC/5VYhT04SnqynxuGjvLRIHHziypENO28?=
 =?us-ascii?Q?tihkp/vQ9ruMf/U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 20:52:22.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae517c9-140c-47bc-2f51-08dd39945648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

On Mon, Jan 20, 2025 at 02:18:54PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 17, 2025 at 02:11:15PM -0800, Nicolin Chen wrote:
> > +/**
> > + * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
> > + * @state: One of enum iommu_veventq_state
> 
> I'd probably just make this a flag with overflow as the only current flag?

Ack.

> > + * @counter: A counter reflecting the state of the vEVENTQ
> 
> > + * ----------------------------------------------------------------------------
> > + * | @state                       | @counter                                  |
> > + * ----------------------------------------------------------------------------
> > + * | IOMMU_VEVENTQ_STATE_OK       | number of readable vEVENTs in the vEVENTQ |
> > + * | IOMMU_VEVENTQ_STATE_OVERFLOW | number of missed vEVENTs since overflow   |
> > + * ----------------------------------------------------------------------------
> 
> When I said counter I literally ment a counter of the number of events
> that were sent into the queue. So if events are dropped there is a
> trivial gap in the count. Very easy to implement

The counter of the number of events in the vEVENTQ could decrease
when userspace reads the queue. But you were saying "the number of
events that were sent into the queue", which is like a PROD index
that would keep growing but reset to 0 after UINT_MAX?

> IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> have been lost and no subsequent events are present. It exists to
> ensure timely delivery of the overflow event to userspace. counter
> will be the sequence number of the next successful event.

So userspace should first read the header to decide whether or not
to read a vEVENT. If header is overflows, it should skip the vEVENT
struct and read the next header?

> If events are lost in the middle of the queue then flags will remain 0
> but counter will become non-montonic. A counter delta > 1 indicates
> that many events have been lost.

I don't quite get the "no subsequent events" v.s. "in the middle of
the queue"..

The producer is the driver calling iommufd_viommu_report_event that
only produces a single vEVENT at a time. When the number of vEVENTs
in the vEVENTQ hits the @veventq_depth, it won't insert new vEVENTs
but add an overflow (or exception) node to the head of deliver list
and increase the producer index so the next vEVENT that can find an
empty space in the queue will have an index with a gap (delta >= 1)?

Thanks
Nicolin

