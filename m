Return-Path: <linux-kselftest+bounces-15047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED294C722
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 00:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC51D285C87
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F015B57D;
	Thu,  8 Aug 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qvy+ooSf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9C4A1E;
	Thu,  8 Aug 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157985; cv=fail; b=PIWmlbmOgsmcTgZ+immHJcfyJwQkAr5GhQAKD8/ZYYxfGHxtMqo4k2ivDgpIEvLfXANclaI1VB1gTH71uh/WDq6QtwXcAmbdSxpowiZpDiMJHtfnx8TlwoN9Nssn9XrUEqZKgNC6VWacsA/BXg1miL8/Sq0cs5M25AW3B9xJTlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157985; c=relaxed/simple;
	bh=/QVbRI3otnDyKn3dsbJmKA5jNBg5mDRthvosbvQ8yD0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlOE5y6SJLjgnn3nMpSy8QC3NC0fJxIiEVEWp4MAFPxUkm0abVzqwmvBs9/qTEe+ZfAFUL3UaQ5QGCbl6jpbTgkcLgHdYGcZdIlVM3d8Yi2Cryzsl8ylDtiUbjV1ztLVg/OSrHtMCzNOJlP2HL/HiRlWDDSaQ8asiFU2XPMmI+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qvy+ooSf; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQjXZN0CjppK7x7D2vduOdUqIPHq/zcE7PKDTgmWpl6jGLggBtZIl/+tDi9HSqs9nZKjlMedbxzQlZfVRsOGBonTvaOtvfOrrDhW6S5GREZqiaaTSdoz1FfmYsuNbthhEbJD6915xG3ZCXmQIAFW8uYb0l2gNXz+SNMCV431e58i920OgmtlfP7loYngpFhw2VYwiRo1QddKFZA9+Hnva+EN07eVu4FrjdJUhCyD9ir/ZyDL866EfWx3vrxDUTErAeICo+XLNlAAUz1R2KCZ1bculCSIY/xcjtKbYYnVwdo+He3fMlHFFxRLlW2FGWtIYE2Pw0eD2DUB+A9xpb+WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqpeD/RBoKpF5PU0rGqO0JeYpWpF4Z7YTcDsmG4Yvh4=;
 b=Vdi/g7XiP4N6cADw7ckl7AbTZamvfMUaAQRfI5NAhgXtocVX73+zFbtLP3+RqkV6WiGprU//DMZwKGNWUAqzlwqGggWt5UgYoDxrrKgOayW698RrtTKojsWZPqFijzFjFRoYoE2UShW8NJavDnx6pHecvRrLYlqjpy+MjXGN1pHvT0OxmugvJdndDjd7A3Bi/okwUi5ALkvoQIrWCfs1017rZrG63rDwau/ecL39kiU5nm2Wd8yJ0R8n0rVRDLg/gxuKGrPDTaUA/bN3AVF+C0tBoCTC0W2yH1KIR6nHMhuTx7AB2Qdxf2q29dqfkUf44TR/AW1uy1PKYkvhVOaXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqpeD/RBoKpF5PU0rGqO0JeYpWpF4Z7YTcDsmG4Yvh4=;
 b=Qvy+ooSfWS/U4k8DgGi0oXAUfrdS+kHD3H1dyAfUgWpQIB/Ku8JwEiBqYrD0B1x2tm64+XhwTJhdfYPeYxtTToSfqsUlGYRN/chrQ0iLgWGZBSua1z4IyXR518gqmYxsahSSmoU4ZdhYm9ecdUjE2+cCWJ9Bcrf8G2urgBm8j3TiHgLHa9BkWEJcp+CNzD6FDtxZQhvwuBotgqQnQwBYB/UfWSo4heWteDm88/RpT76zimFYUkJ791Vip5kL6L2Zg5NGyiNQOr6M6cpg8r8lVd/dsgr+Oq+R1mYed9yszd4UcTB7f20XBKcb+UpCVYOHlV8zup0LKff4cunueSDvAg==
Received: from BYAPR11CA0074.namprd11.prod.outlook.com (2603:10b6:a03:f4::15)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 22:59:40 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:f4:cafe::50) by BYAPR11CA0074.outlook.office365.com
 (2603:10b6:a03:f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 22:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Thu, 8 Aug 2024 22:59:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 15:59:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 15:59:33 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 15:59:33 -0700
Date: Thu, 8 Aug 2024 15:59:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <ZrVN05VylFq8lK4q@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6da4f216-594b-4c51-848c-86e281402820@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 692ae60d-bced-4605-cf5a-08dcb7fdc8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0q0p7qk/TRZSB0sfkZfXpGWZWnj7o9yvcWklI43mpCtOILtPhvtmhwssfV+X?=
 =?us-ascii?Q?LFO/cubY1WCv51d7mcuxPwBxvXKN2sfvpeOoO/t8hIdQblbW3hrw86ybROq8?=
 =?us-ascii?Q?P1heqZPFbMXaTyAA3JUfOQ51FXZk7e2LWG4+P3ED15Y3dFREDvZ6X5Tqyjia?=
 =?us-ascii?Q?ELCaqeHjDdFqlAOKprz8ECaxeayMbfL8zDLzIDeckAXrkxoCiIDejO3rdoij?=
 =?us-ascii?Q?yA8/CQNDgb0XtSz/1f66Yng0eMb0M0Iy2o+gqCwr/rdkYJlksDVX6HYJ+cXS?=
 =?us-ascii?Q?mybj/95jdZ3zFLgJ6bQjf/bsiA/dSxsAhFE+uD9PHMwH0A7Dm986i1d+dfLV?=
 =?us-ascii?Q?7TVuNFA6E+nWc5/eSpE2mWoaOTrNKkEcxAVQj8oD/+d7WMQk9M9EhCDdRBS3?=
 =?us-ascii?Q?2pmzhGt4o6Oe0rYuVj2NkkuX3bCLXt5Aojbg6BYvJm+9sEyWKtFXE60uZ7S9?=
 =?us-ascii?Q?xQpExRJaB5JU+CZ7zoQgJchbX2x4BtYSxBdcwJ4P6RaRRXTWD7QB6fDjCcTr?=
 =?us-ascii?Q?f1ovkxkwBg7IuQ34aE+Wfhr0wEdG0QRxYL3GGyQKKTPTDOlGVJWJ7a5yBSGb?=
 =?us-ascii?Q?M795s0nh1wBjYxEe9yZMzas6/b5vZW6ByRg0tQtvGQqpvXT3YR5yPbi332g8?=
 =?us-ascii?Q?PgGSfnSel9T3CMsoztTkfd5uggUxDoKqiPI2c5lJeuh4/SS0AS+v4nD8SxoU?=
 =?us-ascii?Q?k2oVdK3g6NDBXGSE4LbZ5z1jVKCI/EMxhAvagEJa2b2QBYgKXv5+fkSs29wu?=
 =?us-ascii?Q?MyoKWPfeRBiA6a4QpoL9Z4C+Q9GfVUA1b3jvmbv+XeRxRrpY4BNdSSMOJVXW?=
 =?us-ascii?Q?4+/Lt9YUg14e2RcwGBNy7AdxjDWZGEFonw/RfjMf37l1Pi6zi0bZ7OGqlbke?=
 =?us-ascii?Q?qzyTNnKCVnlDHYqCjmblJIwEuf5LLVyhu9Ay4OaqmmlAkEftnuJNSeLR0o1w?=
 =?us-ascii?Q?hPpBJTtael92fXok5DUSrPVP5BrzRpFFOSDZga3bdssscait5fLNqKbat/+u?=
 =?us-ascii?Q?DQEEoIshfF6lSNKix9IIbGfmPOFdl3BRdiGpYf5wuIsfSG3tuLbBPUkyeAWH?=
 =?us-ascii?Q?b+rdGqDB0JZD+WJb/OezIhvHh3TSUIhrQp0Em40EIZdCMnMxA+lqIasfUKfQ?=
 =?us-ascii?Q?oYdIZzVzd/XsomnhQwWJPKwuVTjO4nEsDq9ujWQ70xMmpwgYgNM0kpc8yCW5?=
 =?us-ascii?Q?FIFx40gDmhDKPv/eHpeD8Wal5sS2Nd7s8t73lsQtYto+VOqP1MYMVJS7X+Pb?=
 =?us-ascii?Q?OoFpjKSMceRd64uAALjZol6oH+3qT5z8tDhky4C+Nk4vHjyI0zZqUuAe4Uq7?=
 =?us-ascii?Q?R7moi/KL41vgqnlgaZYs/Ya323lBFlIo6ZQK66gZXVh9bV3lCXHRciMskycv?=
 =?us-ascii?Q?XMcW10gfTYnGqJNIZXCvNyaVCMAaYcKWeBKgZS/7nO4rxY8VantSBuSojmY3?=
 =?us-ascii?Q?ABC0aI9GqiNMrXzINIv3nHYlPeIWlzS4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 22:59:40.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692ae60d-bced-4605-cf5a-08dcb7fdc8d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
> On 06/08/2024 9:25 am, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, August 3, 2024 8:32 AM
> > > 
> > > From: Robin Murphy <robin.murphy@arm.com>
> > > 
> > > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > > which might need to be aware of the stage 2 domain encapsulated within
> > > a nested domain. This would be in the legacy-VFIO-style case where we're
> > 
> > why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
> 
> Because with proper nesting we ideally shouldn't need the host-managed
> MSI mess at all, which all stems from the old VFIO paradigm of
> completely abstracting interrupts from userspace. I'm still hoping
> IOMMUFD can grow its own interface for efficient MSI passthrough, where
> the VMM can simply map the physical MSI doorbell into whatever IPA (GPA)
> it wants it to appear at in the S2 domain, then whatever the guest does
> with S1 it can program the MSI address into the endpoint accordingly
> without us having to fiddle with it.

Hmm, until now I wasn't so convinced myself that it could work as I
was worried about the data. But having a second thought, since the
host configures the MSI, it can still set the correct data. What we
only need is to change the MSI address from a RMRed IPA/gIOVA to a
real gIOVA of the vITS page.

I did a quick hack to test that loop. MSI in the guest still works
fine without having the RMR node in its IORT. Sweet!

To go further on this path, we will need the following changes:
- MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
  hypercall) should set gIOVA instead of fetching from msi_cookie.
  That hypercall doesn't forward an address currently, since host
  kernel pre-sets the msi_cookie. So, we need a way to forward the
  gIOVA to kernel and pack it into the msi_msg structure. I haven't
  read the VFIO PCI code thoroughly, yet wonder if we could just
  let the guest program the gIOVA to the PCI register and fall it
  through to the hardware, so host kernel handling that hypercall
  can just read it back from the register?
- IOMMUFD should provide VMM a way to tell the gPA (or directly + 
  GITS_TRANSLATER?). Then kernel should do the stage-2 mapping. I
  have talked to Jason about this a while ago, and we have a few
  thoughts how to implement it. But eventually, I think we still
  can't avoid a middle man like msi_cookie to associate the gPA in
  IOMMUFD to PA in irqchip?

One more concern is the MSI window size. VMM sets up a MSI region
that must fit the hardware window size. Most of ITS versions have
only one page size but one of them can have multiple pages? What
if vITS is one-page size while the underlying pITS has multiple?

My understanding of the current kernel-defined 1MB size is also a
hard-coding window to potential fit all cases, since IOMMU code in
the code can just eyeball what's going on in the irqchip subsystem
and adjust accordingly if someday it needs to. But VMM can't?

Thanks
Nicolin

