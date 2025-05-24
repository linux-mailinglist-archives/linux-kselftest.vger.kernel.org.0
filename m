Return-Path: <linux-kselftest+bounces-33730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D8AC2CBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 02:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE6AA28133
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB351C863B;
	Sat, 24 May 2025 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iexzYLdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3835977;
	Sat, 24 May 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748046664; cv=fail; b=CuS1p0CWwSXUiaPfIjztWy8F8X2BIfT0VRB++4G0wYma208i+s3ukCc2Ko2b0IC67DRbuR7iuC2z8u8D8xe19vIu8BGqMUkeQEKVZSyQ0A3Q/fxAIzonjKRgMp3TprOxiGJ8KuEaUhHWgRMaZVjiiGq0VVMxpdtnRBcMAKeuZwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748046664; c=relaxed/simple;
	bh=oe08y/JWMUNcUXyj5O+WCJxn2ISKzTzHKytFHQ463QY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eajAgkO8ZcWuA6M1TQQKYf8WY5goluuaw4/lWoKzJueG1gpF2xaZW647qrTi6RRygzU5Std0zzLdM6aRIWt9HGBUUVw1hENW/9Ua+by4Iw6Jqn+U7z5KP9nB8X2zaBiNhaZfAEVuXYNsJ/ZMPXzn1mYNbmj+ObPGMO9dXNfMlR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iexzYLdy; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqILuVhylkw/P0zYbF4YBTkxANa0nodQ8njK5Y1OboefhLCIvICFmX/UvL2FvhWfB3Z1rc5DQbVv4640zEwKn2p45eRRvnHmxQTWcqfdPEreFmf/Jo8yOlP5vqKK69l1eCoEB2bRZucVcX4ypVqw5PfBN0BSaTvigo9z+rfoOzZvawe/06IkVblzuvZkMuUHBM8eMgn145yihbUc7x72zl5K28EN+08nanW+XcQDZqBTVanjPRhFPKY1BmunMHzsacIpvt4IE3ACD7Qxa488cxZ/TaXwtmy5xKQJOVrwsnsZjld8FgkGKqB+Ox9yItsnUZxoCZRAgpKjSUxA7H6meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwZFXKFqeE72D8GqV4GpraW6xUHQGDxYnVfRZKKk1CE=;
 b=FeYVGsjzBJAMGYTqLqrnRb1+6MdBRCJvM1n99/1c/t9zv6HCxf/zXHxaReOpzik4H6GGGjuEimZlr+EO9R4f09hQXx0YYsPslYAFlBncSrHYGcqA3dEjeAcH3BiPkFYITJbbYjOriUD2H+WAdzj++bQMwHis/1rHs7VQJCiBeEEnmiygD+/Pkla+k5uVmYnrveKzdNmhlUxy3MZFwqnfrqEIddGY3UzksOzeBNnI5i4CYJADP54iBhyJ9+zZjiXwMde01lSF2tFEHxytuVCa5wHOMgfw2je9E5u7yeU+OOzpsCZmK+WsOO/UVWJEGBrS4dLd+tHs8jDUgQFnGZ18XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwZFXKFqeE72D8GqV4GpraW6xUHQGDxYnVfRZKKk1CE=;
 b=iexzYLdyn9ZJVqtHjjRNe/R1tceY/LU4gfOwrnUW2D93IDGpuHjbxRzMrkWSBMqagasqi16bppjDbBLhBBGpiUSTaRWjJWczUzuCDtxIJgtqH6KlTOIPfrlShZWnJFhyOHeLNWDeNnbtyDejj7VBCO+0qfG5NOEmhwxMeYtcaZXdJMsjVI2pVG9+2mfL7GM74CIhdccrZm93AeKNjRKe6cHu4fBcfey/bdv/Ieof4RqGmuDP4EGw/j5V69PuqBMg2KE2ud2gnUL22Ni3ywL13L+QUneT9KPOuNX9csUeOA4wi5C1IDMQHZXJ8bztENzO6L+w1RaUqmYyab9WY9eDGw==
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sat, 24 May
 2025 00:30:58 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::16) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Sat,
 24 May 2025 00:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sat, 24 May 2025 00:30:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 17:30:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 23 May
 2025 17:30:42 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 17:30:40 -0700
Date: Fri, 23 May 2025 17:30:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aDETLwnxlt8PpHo3@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276B1C7B8827EE2102824998C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B1C7B8827EE2102824998C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bad1086-9391-42e8-b762-08dd9a5a40e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVTXZVmMmitA8RiwH8+XsAPfIGD/Gj2rvEpLGBktITcmXiq4W29+p3KWC5Y5?=
 =?us-ascii?Q?MaSyAgxZmJi4heUQvR6g2EyBPLExqDORQAU0rNlV6xWugpSk/pJATwjohBF9?=
 =?us-ascii?Q?q/pojYvCZuQSSEnv6zY0bWfT4CJXS0FApiUQbCXD8fSW347Oun5jbtD5kaGx?=
 =?us-ascii?Q?4YMI/kDUo9rViY8l8clQ01Kmp7V5zfl7lyyH2HFVKuJjgUTD2n5yxuYXSONP?=
 =?us-ascii?Q?9n77MjnjpBdObPaIwg4I08dKk73T18iizoq2xAEXf8R1S5ZA/WbGjQQAhKII?=
 =?us-ascii?Q?fnGdS0G3BycW4ai/dlBwQkQdJ3ROIDe8hKk12GIOAewNcBBrp47kfsgbt/75?=
 =?us-ascii?Q?rxA32kGUDdfZfqVh81LcDF3G/EKsAxhKobaLULHrWlRO4NOYFVMEPXfVNmX/?=
 =?us-ascii?Q?OHI+A87A1strkKjvsO5KtfvQlgWbBBi0GUas73BDmwsMofiNlYg5oLAVBWNx?=
 =?us-ascii?Q?fkFttMX5Sr4dzgtf1EtYQgqGsO90zy1EX2RMy0hBpbOFEXFkGXURXQmTGchA?=
 =?us-ascii?Q?53mSI22KfvpGSlH0QDDgOVK8Xs1bjU2TIoj04f9nf2fdcEhr3E8ZgIcNMzgu?=
 =?us-ascii?Q?Qvfxi0j4q1NC8wZaA69P+GUFNMrwOi3GstWlu4sYWfpa963xmO3xnQRVTp2n?=
 =?us-ascii?Q?SqEwrM6t5GhMXxZQi95iR9qYxU8OKO5+xtrnlDK5p8aKoMyaSiG3667GAqkH?=
 =?us-ascii?Q?YDKELubbYSFs4juZBrnCgbVpQ+ZEFjSgHeQQmU8f3AurJDiDf5pKN00t0D4N?=
 =?us-ascii?Q?sPt2Yg7KJTQ1QQEk37pc7Vkh9RhP/zJTSQDEfkA5hWO2sP4UAfZBnVzRVNic?=
 =?us-ascii?Q?VKnDbwvcoH2/oZFOE57JLsW54gFKJKZmrfyFtDaJn47hyD7CZaMG5UFWI1c/?=
 =?us-ascii?Q?9xiA0RYQZJhcOIuRmBkQp1yPzWnZKF+CL7sRwhYgeD20bwbMR+iqvQ493zER?=
 =?us-ascii?Q?+wld/RroZhatZ0zQ6d/X4XMeLm/NlNpSAvDqcW3Thm9YpxzdNFrgIzAOd72g?=
 =?us-ascii?Q?OEkitwnczsm+rkbAY5Z2/Ymzpvu8+7iRgw63V2itdYZjCn+MSu1y+6qwdrnr?=
 =?us-ascii?Q?3WM3eHfB3k2X9whx7/gG5gqt/84aafzydDVaDVvbzJFD+jN3Vj84T5OhUnzm?=
 =?us-ascii?Q?LJ54DAw22oJsgkNrb+fN4RpF3UmY7AHS+LvmovpjdB5/zTXex3TVpJsNbLa9?=
 =?us-ascii?Q?+bPrYHmX8vKNKfnpIYeNAGNhnrUxsrdVDGrd+vuLPwyJYopo7WaXu7cH95EK?=
 =?us-ascii?Q?HLfoYh2yEBYJw0oLVK0HcZoxqAYbUCkpvoQodeo8E6zfTkeMQaIJjKIbsdWi?=
 =?us-ascii?Q?zEhe42ZMOkOTLAFUUBNYF8Ci0rmLXTSnIsi2caP/+dU9h37pqPiG59sUqmNU?=
 =?us-ascii?Q?8mBVu3zHoeO5BiEy4AhqTcjc1IXJMtkoLeI5CKdxFE4cPl6h3CVwfOZqHr6B?=
 =?us-ascii?Q?/IaFhoy/2Bym4NHNfrLMYHXHo5VQhKVzDLcLaZgQvk5C45SoJw8aJxzpox6+?=
 =?us-ascii?Q?zARNGbzYkeCr6isn41MZeCqIFs/cf/3dYeCEBl5ngpVjeHGrT4+1ifm7qQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 00:30:58.0804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bad1086-9391-42e8-b762-08dd9a5a40e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On Fri, May 23, 2025 at 08:00:02AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, May 18, 2025 11:22 AM
> > 
> > + * @nesting_parent_iova: Base address of the queue memory in the guest
> > physical
> > + *                       address space
> 
> 'nesting_parent' is a bit redundant. 'iova' should be sufficient as it
> implies a s2 input address.

Hmm, Jason suggested to highlight "nesting_parent":
https://lore.kernel.org/all/20250515160620.GJ382960@nvidia.com/

> 
> > + * @length: Length of the queue memory
> > + *
> > + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated
> > queue, which
> > + * allows HW to access a guest queue memory described using
> > @nesting_parent_iova
> > + * and @length.
> > + *
> > + * Upon success, the underlying physical pages of the guest queue memory
> > will be
> > + * pinned to prevent VMM from unmapping them in the IOAS until the HW
> > queue gets
> > + * destroyed.
> 
> This is conditional.

Yea, forgot to delete that.

> 
> > +void iommufd_hw_queue_destroy(struct iommufd_object *obj)
> > +{
> > +	struct iommufd_hw_queue *hw_queue =
> > +		container_of(obj, struct iommufd_hw_queue, obj);
> > +	struct iommufd_viommu *viommu = hw_queue->viommu;
> > +
> > +	if (viommu->ops->hw_queue_destroy)
> > +		viommu->ops->hw_queue_destroy(hw_queue);
> > +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, hw_queue-
> > >base_addr,
> > +			 hw_queue->length, true);
> 
> Check the flag

Oh, right! Will fix.

> > +
> > +		/* Validate if the underlying physical pages are contiguous */
> > +		for (i = 1; i < max_npages && pages[i]; i++) {
> 
> Page[i] must be valid otherwise it's a bug?

Yea, I think so. We can drop this pages[i].

Thanks!
Nicolin

