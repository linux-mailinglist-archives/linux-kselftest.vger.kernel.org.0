Return-Path: <linux-kselftest+bounces-15094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B394D7E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 22:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676651C2291C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B6168490;
	Fri,  9 Aug 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I73E85KB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A0167D80;
	Fri,  9 Aug 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234222; cv=fail; b=kw34kPWgH7yndw7Grv0cFEduyujsr4Ncm5WTvHrZ56jMKmBdfARd2r8+SVX64m6hv7HxbC+WO1gsBHPnlFEJ5keapzIhuNjtMmvst+sb6z83wTfy6rxmfub90YthTQI30KvMr4uMOlpGmiaGCvZwOOXzDI0PBtQ1xaUQpHRy9G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234222; c=relaxed/simple;
	bh=L3VOvwvs3ZCjDN+oPAuWIfpljyqGj3tIkL8/U071OIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH8ak6WpEzz/+dYliQNi9mf7I/hy85KYRYmXX27Z+3AoBWdq+Olc3lFSy37zLIfLBYY+bw4sRxiXQK+A+/CjfKwuZkYVpBIyXyMZEiEOnEr9KY/gLs93xdfuCXYRyDPQw2WdzAOrk2pmS/qwr3mFShKowMZg+hpsbwiO0xqg3co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I73E85KB; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQHP3IVwVLcgba0IG0j47mVDzqdUJDBjr4Pq86rBNvPn7FuUmk8sSc0io6RZs7tXdLFEYpjUZOeALK2FqQhKQD9rRRVKv+jMFNWyF0pZP+bk9/61WCSRu0Yg4S7tXHRlsiD8N0vFH5AasIOiFkjDJJZgTbD39zsNM5GbdNpTptDfcio5ieCB9EuHDm/eq5sXTS1FQ1DfJjImIPyE5pkONhnwGWSQddJcUm/aAfKUErdMwDgsFdjK8sUryRZD5PG8/IB2fL1tynU6UNXbsQAfIndSLLVDqb+BYCmcVwaDuwoQqTvQG6h67VFFvwO1tUbMHGlY6glHZx7QglhO+N9uCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EWI98+pK5RLS98oQifb4ZYTVOhkXuNQzWkKaySx4I8=;
 b=fnMCrlkJK4ajDomIKBj/lUDKk4sVxEk1i5ueX5AiRjwGwirBHZxlCB5+a+T1qgh0w6hng/96QgQY/8QQ1wq47/RILN2hS9sjsCXLTtAnhgS+nm2sWu05ZjSdPHe93r98kIt8213NYWpl/q6ysf+oZDHdy+oEWfJooCKkuLgAxXmrOXU+RLUGcnwHnuocZ5RLog6AzYHczMS6p7MHgG4P1473YuEZ0DtWnfERaHx4fG13n1OhQOzu5fx9Zj5138LMnNMkuJSsmi2D1fH9OIlMeXw8IE8FVhJqZvLoZQkw3f2+K2NSQTUvJwzTHFjWrVXzCjiO42tP5004OBRoNoOaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EWI98+pK5RLS98oQifb4ZYTVOhkXuNQzWkKaySx4I8=;
 b=I73E85KBclH1u7kuW4slR0utcSGpJVsl+92vVkIzNSSuSfbZygA4oydTCT/a1pLdRgWdwVNzrC8q5LGoH/uFBCV0JtTyiUQiw0/4sV9MciRS/VrUS/j/SB112R5EZLMeG4fAhXzu13SIjqb5HSdGyCJVIC7VFZLl6JlkBdEpMGL8speGa0ishUhumHJWvpCFzfzHyP3PdqPvPnMFJpOcZ5Xhw8s+ZMbCBgqZpon6hr0RklbJiRuQKqTyTor1N93P8mu4xV3QaCXAmkrcxb55HgxX0GHddue6se1f9qg8CzgjdWJNyvY24WfHygTVUfOPJMosM+LX7TCBfeeQA9nC0Q==
Received: from CH0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:610:b2::10)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Fri, 9 Aug
 2024 20:10:13 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::f0) by CH0PR13CA0035.outlook.office365.com
 (2603:10b6:610:b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17 via Frontend
 Transport; Fri, 9 Aug 2024 20:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 20:10:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 13:09:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 13:09:57 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 9 Aug 2024 13:09:56 -0700
Date: Fri, 9 Aug 2024 13:09:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <ZrZ3kyftb4FA1bcd@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <ZrVN05VylFq8lK4q@Asurada-Nvidia>
 <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f4c4a142-d0bb-44c5-8bb9-56136c8f7cf2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4c4a142-d0bb-44c5-8bb9-56136c8f7cf2@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa513d6-4a84-4ff6-4a96-08dcb8af4704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTwDI81hACoXNW4MCjs5rPe/lXaJf16hxEVT+EMqxL+5QxEE/4YwV+PqUL3f?=
 =?us-ascii?Q?u5UAplUGGZ3HpsPMDUPr4sphuX4PWZluLHqT0rKYYGpe3swgflZc4QeR5sBy?=
 =?us-ascii?Q?bIaCHilM+9lR05gNVONljoqXodp8TYIDrc1YGBIB2ZJfnFdeATOpVfqnpisx?=
 =?us-ascii?Q?J4PdMDO74pHY+fz4XJ4j8aNl1s92h8ak0E4rA2rRjdkCGlAbUzYm5VxzHndg?=
 =?us-ascii?Q?gG8wdr7Mj9zFKRGKNRdwj4LP3PqnjCwAT5R/6kGPi0Y2SVLNdJdbqvrwWXwK?=
 =?us-ascii?Q?YxM7VhO1X3LXvFH56xwPok7RAHLzKCNACJ6UZ999SfhzVWGCqCLmVbV9XkfG?=
 =?us-ascii?Q?CuKMmyWyoQUuQlHed2v7UCJdDwkfFYySknxhUNiIyXjMg9I3alCEHVM7c247?=
 =?us-ascii?Q?cw/ZfeQvrZrknS5xRy22XZUFcIO8V7U6JNw5BgeG+UVcR+lQoAEWzan+IA/W?=
 =?us-ascii?Q?b5QnND9yunmO13XXIqqnq9KLBb2wzYqHcYKVGfclteSKo651G2R0Roc2ExqK?=
 =?us-ascii?Q?0dSMCWpmeb7iqP96mT4NGi9NwS04Bsd6KTjvdZC7LR4DdMyk7ZRJBq5WmbKD?=
 =?us-ascii?Q?qrphykrPvcakiiMXBmItA3iA1oaW5q/bSsUtHGF2aOpu7hX5i5QmUTT60Xsd?=
 =?us-ascii?Q?bgyTJU0mYI2uSmsKGdWaqtZQMN7ss81xvURme/ZGBW70p6g7zPOELQTg5IL0?=
 =?us-ascii?Q?Gr+LTRjnOt0vfbLWiRMxMPkpgVNAwn1QIcgkYpEQedKl1CEYkWCevJWXlZ0O?=
 =?us-ascii?Q?7fVR9k72p6k19BzY2yEDf6W0zt7KGk3D565Is5l3KFLKEKloq0HxN4BD+7CA?=
 =?us-ascii?Q?9HRnEvCnb6yIcfNfNoLEQDHGzbgDZ6+oOBLP3LAkM5kDsmgHeerqtz9M/YVP?=
 =?us-ascii?Q?Ae4MRqoHpaTK2l3mtWi/69pg5YwdomW+Xi4uMKQSr1vd/QkIV5ZMmxKaqVrh?=
 =?us-ascii?Q?Y2pWg6U7ZDg0M+JP2PjyPD0LWPVce/2mhTDR2auXXYCLnBiM2QhvdsUrGl8T?=
 =?us-ascii?Q?Q9bDYhLYgb8VLt90/pYNR9HZ4YGZAO0J1gYN3lkbiCG/O3I57nxoR8XG+s55?=
 =?us-ascii?Q?SzgWoxsL4fKyALj4WDNwaCPrsCP9AY6DttRZBZyCOYNp1dBMT4BNMJswtQJX?=
 =?us-ascii?Q?JRcbVXp0QDhXG2oDp8rR1p6RoKMf8GIi/qG3IvsucgTvgWQkEMTaHe0EBizc?=
 =?us-ascii?Q?yXxdV49T7GzejlgqUe//lkCwKmqxxBtpZAsT2J0We6aXFJs4XCu/FXclhjfy?=
 =?us-ascii?Q?QrU1d22qej2IwecfsdqabsaCfpVABrcPkhn0P8Q97aFrleoaqqh/Wrrls2We?=
 =?us-ascii?Q?b8JfpWZHI9ma+Zke/P1z0Yjna4mbjO0GnqWq+IM1PDkhsLpO3CJUzVLXuZVq?=
 =?us-ascii?Q?21Ps6jJ/8T13RjmXKmcpvWOKpmSH0ODmwf5fin9uqye081SsBOrwWcUlvJvH?=
 =?us-ascii?Q?JmdubLKEkvurwqPA+Iqg8pWZb7YF6DTN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 20:10:12.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa513d6-4a84-4ff6-4a96-08dcb8af4704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Fri, Aug 09, 2024 at 06:43:47PM +0100, Robin Murphy wrote:
> On 2024-08-09 9:00 am, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, August 9, 2024 7:00 AM
> > > 
> > > On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
> > > > On 06/08/2024 9:25 am, Tian, Kevin wrote:
> > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Sent: Saturday, August 3, 2024 8:32 AM
> > > > > > 
> > > > > > From: Robin Murphy <robin.murphy@arm.com>
> > > > > > 
> > > > > > Currently, iommu-dma is the only place outside of IOMMUFD and
> > > drivers
> > > > > > which might need to be aware of the stage 2 domain encapsulated
> > > within
> > > > > > a nested domain. This would be in the legacy-VFIO-style case where
> > > we're
> > > > > 
> > > > > why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
> > > > 
> > > > Because with proper nesting we ideally shouldn't need the host-managed
> > > > MSI mess at all, which all stems from the old VFIO paradigm of
> > > > completely abstracting interrupts from userspace. I'm still hoping
> > > > IOMMUFD can grow its own interface for efficient MSI passthrough, where
> > > > the VMM can simply map the physical MSI doorbell into whatever IPA (GPA)
> > > > it wants it to appear at in the S2 domain, then whatever the guest does
> > > > with S1 it can program the MSI address into the endpoint accordingly
> > > > without us having to fiddle with it.
> > > 
> > > Hmm, until now I wasn't so convinced myself that it could work as I
> > > was worried about the data. But having a second thought, since the
> > > host configures the MSI, it can still set the correct data. What we
> > > only need is to change the MSI address from a RMRed IPA/gIOVA to a
> > > real gIOVA of the vITS page.
> > > 
> > > I did a quick hack to test that loop. MSI in the guest still works
> > > fine without having the RMR node in its IORT. Sweet!
> > > 
> > > To go further on this path, we will need the following changes:
> > > - MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
> > >    hypercall) should set gIOVA instead of fetching from msi_cookie.
> > >    That hypercall doesn't forward an address currently, since host
> > >    kernel pre-sets the msi_cookie. So, we need a way to forward the
> > >    gIOVA to kernel and pack it into the msi_msg structure. I haven't
> > >    read the VFIO PCI code thoroughly, yet wonder if we could just
> > >    let the guest program the gIOVA to the PCI register and fall it
> > >    through to the hardware, so host kernel handling that hypercall
> > >    can just read it back from the register?
> > > - IOMMUFD should provide VMM a way to tell the gPA (or directly +
> > >    GITS_TRANSLATER?). Then kernel should do the stage-2 mapping. I
> > >    have talked to Jason about this a while ago, and we have a few
> > >    thoughts how to implement it. But eventually, I think we still
> > >    can't avoid a middle man like msi_cookie to associate the gPA in
> > >    IOMMUFD to PA in irqchip?
> > 
> > Probably a new IOMMU_DMA_MSI_COOKIE_USER type which uses
> > GPA (passed in in ALLOC_HWPT for a nested_parent type) as IOVA
> > in iommu_dma_get_msi_page()?
> 
> No, the whole point is to get away from cookies and having to keep track
> of things in the kernel that can and should just be simple regular
> user-owned S2 mappings.

I see. That'd be ideal.

> > > One more concern is the MSI window size. VMM sets up a MSI region
> > > that must fit the hardware window size. Most of ITS versions have
> > > only one page size but one of them can have multiple pages? What
> > > if vITS is one-page size while the underlying pITS has multiple?
> > > 
> > > My understanding of the current kernel-defined 1MB size is also a
> > > hard-coding window to potential fit all cases, since IOMMU code in
> > > the code can just eyeball what's going on in the irqchip subsystem
> > > and adjust accordingly if someday it needs to. But VMM can't?
> 
> The existing design is based around the kernel potentially having to
> stuff multiple different mappings for different devices into the MSI
> hole in a single domain, since VFIO userspace is allowed to do wacky
> things like emulate INTx using an underlying physical MSI, so there may
> not be any actual vITS region in the VM IPA space at all. I think that
> was also why it ended up being a fake reserved region exposed by the
> SMMU drivers rather than relying on userspace to say where to put it -
> making things look superficially a bit more x86-like meant fewer changes
> to userspace, which I think by now we can consider a tasty slice of
> technical debt.

Just found that intel-iommu's MSI window has the same 1MB size.
Everything makes sense now!

> For a dedicated "MSI passthrough" model where, in parallel to IOMMU
> nesting, the abstraction is thinner and userspace is in on the game of
> knowingly emulating a GIC ITS backed by a GIC ITS, I'd imagine it could
> be pretty straightforward, at least conceptually. Userspace has
> something like an IOAS_MAP_MSI(device, IOVA) to indicate where it's
> placing a vITS to which it wants that device's MSIs to be able to go,
> the kernel resolves the PA from the IRQ layer and maps it, job done. If

Will try draft something.

> userspace wants to associate two devices with the same vITS when they
> have different physical ITSes, either we split the IOAS into two HWPTs
> to hold the different mappings, or we punt it back to userspace to
> resolve at the IOAS level.

I see. That sounds like a good solution. EEXIST for the case, so
VMM will need to allocate a different IOAS/HWPT for that device
to attach.

> Or I guess the really cheeky version is the IRQ layer exposes its own
> thing for userspace to mmap the ITS, then it can call a literal IOAS_MAP
> on that mapping... :D

I recall one benefit from the IOMMU_RESV_SW_MSI is to expose the
MSI region via sysfs. Would it be safe to expose it in the same
way? The reserved region itself is per-device, which feels quite
a fit...

Thanks
Nicolin

