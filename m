Return-Path: <linux-kselftest+bounces-31569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB62A9B2CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D066416FF2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8F214210;
	Thu, 24 Apr 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UpTaLqU0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785C130AC8;
	Thu, 24 Apr 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509588; cv=fail; b=kdBPsbIAZag/4/mmPHkyFsMsQk7bRE5NwNUFbWw+rgJMH5D2qYNNHOEv3oM5nWTAjBXZfzjLtXULSNwsDKeP7kBo3CuEKzQJiJP8o1aGbtVf462QAbhPxrSOqAcCEvWtoOMqxMYQAfmcGe+jp7/GbEMy0GSq3etrJLl5I974BMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509588; c=relaxed/simple;
	bh=gQ7AW1QO2Kskt4TpQ5LQf+ftjusZnnHT/Wiuk4ODNs4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx2vXcYCbo601AqqVKbtERwgOp62htpw/LcjV602np27EbdjU6FdP78VNxia+ItqSySwyIJH63JL+TdaiDTDY9vachnSNmg5GN2zBHJdt43fhZYUvEQoUwXVN2nhuxuS0L+EFHoyKgJJG/Bij6vTnFndjHt7BdH2RMYvScjMDSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UpTaLqU0; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRAoTWZsX2gXzvIRG1sL8cXqhbQdXPNWSOR49en7SVHKcch6RfOzYX5AAaCk9kXXVAObNXZ0VBunJ9OnAhFZ5me2/pWRJ4eS/v/7ZZxveo94T07axWhqte8PtFQUeyTaNq5z97QzhBa9jcIIkFK1M42L5jsF+npi4Yc0xlcHCBm/TSqoKNSrHc0130MsF6HF3XzytbqX4kCS9hSoxeuwW3ZVdrvuz02oKDb+l7egUtY6oqwOvAeMsv9XEqomQiwInU1W8g0d7qPoUqFl6/tsQAzmcgM0UmjjMHzd6TcukMA+AZxDbeWhKp+5jFs5GnK2Xkmfc1JJq9iDPnwb5PFH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xv/g1KmQeX9x0hlDZkYdKSr+yBW+z23WQaq6Q8BIKw=;
 b=iZbT5S1Ysf9JXxZAIVVVWDL373iS7wgFKDVmoL/Wk4cs0wC/egIn9dCQA01t3EQrJtZJu+bAu6EIa5IOIaSxfOMRYP7VAHkCECIf1jCbzoop5jhpoGAuhyClHbzns21/Jbs2tjkwGzO5zuvIK2BzWMf3KCnqijajCKI44HBeSznE+u1/TLJuzNT89tMLK7WQjtDijbHoOMzm17FfgmOq9ikldeYttSzyO8F7KM9rZuPvQoIDJZytfLDt6Cl0lBcgF6w/w9Cougg5Fmzzl/t5EW/AxC2iBouhaBQjaAk9vstr2anNqVC3hwbA2PaxHitSPUL8qwNc1o502ZPYMvHwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xv/g1KmQeX9x0hlDZkYdKSr+yBW+z23WQaq6Q8BIKw=;
 b=UpTaLqU0sOi8yYR9frMAWGD4PdQpOnpp4EiaAiWUsCMrrQeQn3x9d49eNoGyB5ThFP1atJG2V9OnvPE5Sr7cCm1PqAffhleBSOaC1uVtrK7u0LhYI3MjvVFlb+UAvWeCFGkSKQRxhUJ0YdHt4BsyziIL4wIhMnwzYnFRNP051BFfn4dBgP6wCeFNHdp3ljmJ5/xNzeHtdwABVTPXTVaXX9OgjeCliv2aNvj91Y0mnbw0yPHHoSzaL0JWlc2Dv8Y6cUfAAXG3HI8/+OG4SQj0RPkKhqH3sFc2C7A9g5xf7VlpXNyhsylUSWI8CFJ3yy4Usb1w0YuTf1z7qZe1AntV9A==
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:46:21 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::a2) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Thu,
 24 Apr 2025 15:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 15:46:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Apr
 2025 08:46:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:46:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Apr 2025 08:46:10 -0700
Date: Thu, 24 Apr 2025 08:46:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aApcwKmb2PPPR8hf@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com>
 <aAkyAbO5UQRySizN@Asurada-Nvidia>
 <20250423231333.GN1648741@nvidia.com>
 <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
 <20250424134049.GP1648741@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250424134049.GP1648741@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff0f3e0-fe5b-4217-d1ad-08dd83472946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vpvrd5V7wtSmwtCWrgzjqkX4mrDgBUNXanoWvDotpOytF7C9qmMRDAUEuxv?=
 =?us-ascii?Q?YO2IQmlNX6t5WZjSdz9SDg8hvDx3cXQsTrSFCcVk7xLyScjW8HKw9RwnHj13?=
 =?us-ascii?Q?3eXcZGaEthpzeowZje/SaPfwSM8D7JjwxqxMPEo2Z5Jlmr9+ojT2qfZXObRW?=
 =?us-ascii?Q?iAi0hLPPYgOpW+rzKelsWFXWw1DZ0vCvpiXGX2ZXaoW3s9P+psssIx55S/wO?=
 =?us-ascii?Q?w6RBAMvod5YDN4W/+OispwlAnMZfx5nhC17Ne8iulgS+InYzMe6MTDuNSQ8n?=
 =?us-ascii?Q?KLh/J4OiTjlVzwXGjNy1xuuWTPjHFkCIdezJNvyM8TMtVfvZ32jQsHxiUb7C?=
 =?us-ascii?Q?hzDdfLqqVPhe2jMQZUUUH+qWT5qJV0Duja6rZck9cRUTkdcJxmNzNQuEckrT?=
 =?us-ascii?Q?bYHAmvmgFjCuwHOioen8MwIH9HIn7HRAUOA2QFoB2Pb0yuHbDzszjKOSH/uX?=
 =?us-ascii?Q?02/jxYtMbl0VVSbiQK5Hv5i0Imxkx8FGizSpK0SRefxz4zhNXsZg0hn7P5Py?=
 =?us-ascii?Q?HIyJkrb6tPxYMAgEbdb5OnfLo9+pP7MqYXjdPCdbm/5qL0LA8uMd/u6QlECA?=
 =?us-ascii?Q?TJei1nfiGOcckMMXri9qhmhrTHUBPcofo9ZUgXPo8ckPckFYCApajfRsRBoJ?=
 =?us-ascii?Q?6nOu48cpHD1ZWyODPb3rQ78ioKw5vq7xMZa1ZW5jGVVNL7uSHLZHvxTyWNpL?=
 =?us-ascii?Q?opjIwA3b7BwYuz2taluem1LmTDCv1vz3DETK9TMP7SHm2dFAP+RZ9qEeIm7j?=
 =?us-ascii?Q?JNDKThKVCq0bLJ8eEYOQ+2rSIqWCXQdAUEWPVVjVHzPuK45HMmRrAgQKs5o+?=
 =?us-ascii?Q?zi//qDgJu0AThbTkaOpcS3/Py4E3YMcvKEzstdvQgI9ObZCZkChtbX3yAByk?=
 =?us-ascii?Q?iuRIYvfVPmWPlfyL/UBC4YZBE093VQQNIH5s9hZj/zrH7DPLFomx9KhpMgrQ?=
 =?us-ascii?Q?i5gmf9YjbOn7Wl8lah8hqOvDkbdDRLcfAnlP5KWNR9yNOwZ+As+LeyNJ/c7o?=
 =?us-ascii?Q?gqNxAyBzztdhACH3URVkh9R0YrwFm9JKsK9e334DY+fBbFPm+S7PaLe1eVE9?=
 =?us-ascii?Q?/1tqR3IImixQqO23N9QsodtLIzCyF8xGYIywYLDEn9JOvX9dyQvUhvRlG9wz?=
 =?us-ascii?Q?M7r6ACiP1axKcPdD32cpZEzSvuuaXH0jEsWh3jGZqaeGy/tiqogHcscuC6Qy?=
 =?us-ascii?Q?NoLjZOAg5pZ0pnj4hFtzYU1ko0dHcOiG4u4TTA3iKx8YVbW5OY2aHycScqqY?=
 =?us-ascii?Q?xwqUYaXPWPL84rIZtL6dC6XoWaAdQQl1FxxKtByXlXKgvVRy6S0YNQhPFJwV?=
 =?us-ascii?Q?OUKhTHhPCaRPSnmlBnU7n0ft4wPNaYbcLwbVyv81RUqYcjzubdA/13GwdY6h?=
 =?us-ascii?Q?MufF0Z6uYjuIGnoYtSaJ4jx2llxYmbMzGWqYRhdp97+4+UXYVc+XJoXF8f7a?=
 =?us-ascii?Q?H5zJiWZOwUYGZWK56SywvbuY858nE6yiRrP1uCR9dZbyuQOJjhmhmr557o/G?=
 =?us-ascii?Q?OQRtYV6xHJJNXbaXSbMeP2HpANII8eJcCwW2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:46:21.4589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff0f3e0-fe5b-4217-d1ad-08dd83472946
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On Thu, Apr 24, 2025 at 10:40:49AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 11:51:53PM -0700, Nicolin Chen wrote:
> > On Wed, Apr 23, 2025 at 08:13:33PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 23, 2025 at 11:31:29AM -0700, Nicolin Chen wrote:
> > > 
> > > > > It also needs to act like a mdev and lock down the part of the IOAS
> > > > > that provides that memory so the pin can't be released and UAF things.
> > > > 
> > > > If I capture this correctly, the GPA->PA mapping is already done
> > > > at the IOAS level for the S2 HWPT/domain, i.e. pages are already
> > > > pinned. So we just need to a pair of for-driver APIs to validate
> > > > the contiguity and refcount pages calling iopt_area_add_access().
> > > 
> > > Yes, adding an access is the key thing, the access will give you a
> > > page list which you can validate, but it also provides a way to
> > > synchronize if a hostile userspace does an unmap.
> > 
> > The new APIs are very like iommufd_access_pin/unpin_pages(). But
> > to reduce the amount of code that we have to share with driver.o,
> > I added a smaller iopt_area_get/put_access() that gets an access
> > and increases/decreases the refcounts only.
> 
> Maybe the access should be obtained by the core code to avoid the
> driver.o bloating? All the cmdq types need a memory buffer, right?
> Perhaps that should just be generalized

Yes. AMD just confirmed that they needed a similar setup. I think
we can do that!

> > Meanwhile, I am thinking if we could use the known S2 domain to
> > translate the GPAs to PAs for the contiguity test, which feels a
> > little cleaner to do in an IOMMU driver v.s. with a page list?
> 
> You still need the access, and the access already generates a page
> list..

Right. I was thinking it could save a few lines that fetches the
page list, but then that would need another around of translation,
which is unnecessary.

Thanks
Nicolin

