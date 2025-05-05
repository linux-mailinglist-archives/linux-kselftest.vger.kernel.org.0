Return-Path: <linux-kselftest+bounces-32384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F49AA97BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E4217B48A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1925E458;
	Mon,  5 May 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFFfgA0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847538DEC;
	Mon,  5 May 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459895; cv=fail; b=OYKBeJr6pBQCvfKmTxsbZBg2lcIAoxTBvAFhydW+r/zQFDSkqsWVkR59mYpZQV+B9EO7n9nusJeMWcNzL3xke1YRK4PGq3YXTvcFguR/BIVTifY1sgjqmv3d/aR+I0jbqjWJu+ghNJSFHm5nG9n97nU+TlJz3PJOGApYIym+ics=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459895; c=relaxed/simple;
	bh=aJkwVQeSNL7Dqg7TjhDzEJl78Yzqoon2UWsM3K70EDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUJ2B22XWNSWsKKjmjQlItHbSCzvD7PE9OxYnuQd00vEc45D+aDsEzRw5SuRUkZ6sAaV/vvaDMhhizZLT23THOdj/nJ6H65kKWnN4+PkNDaYgxD2Jc8KqIqegeSmVVJ9baItoVBHLD4U0r2BcbOYD+8c03cUo94pxI6vPpKSQ2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFFfgA0M; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3m/XWbfq/qczEBHZjvsXLVxGGgwzCbAp8OCZo+OU12vxPXAk5xOhAGU3PNSOwH/1sOhQsiO9FGBsGIiTdpV0W0DqG8E/emuyr63EYQxWhzK4pXoCcXuWo0si7+0KxwhkhVrnaE5Yhwl09KzRXAtmMk7nj/zIZpp/IlE7wC6fw03PnkP9JyxSxvUU3s3CyZ02ORbqRuJNPMwWmuSEhtQ0Rkm5nFLv+dkftYQwEn6BsZ9RMEUZYk4sciznYnwil4Uywz+JlpaGcF4dEy2e1cZFGDn5cYernOKQ+SUA8bjLH3wSmdZaCNJKM/Z6Ghwln4VvDTeI5GiO6evWhesxul4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGjvbK8Bke3szgVnXQq7chsY7YnA5mhojeUUAmbsJFU=;
 b=ih/nTI0DeDx0zOvgnPV53pHOcOMKuuuIakOng+1idM44ymIdCN0ZG/iGlRLU0wzcb9bbUqETxGn0wb81X/Mc0Sk7mFnwDDsovilCEPeHfXPlaFlOVx+ab0kLDdFarNXOlL24M1cqMkszfyu4PiStIv9u+ZA4CQRBQB3gtAv+AtwlAYEiKNazTqGSwrQPaY1BtDBwLojJv2sDIKEC1tG9PumVg8C5yKKG/gtGd8t4eC/TFBzKKhXs129E9UtV6eg7Bk5zeIkvNQFR0Hw/1EutRFHNXcrgxT+cR6QIbxQ8spcgP+dvhmbMzIpfnEeS1GxWaX6+jesPOcJ+X/1cOotd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGjvbK8Bke3szgVnXQq7chsY7YnA5mhojeUUAmbsJFU=;
 b=rFFfgA0Mu830MK3dZqjnYCekv9auQ7WH3RI82bgMJrD/h28E/hqQQmfgTkkZP7Wl/G2hoPEvHxpPq+L2D6mel+QmLq1EJBfEVQLD9Ck597e9mfv/qYGhK0phA3mhXFa8sKlBtlsiesaIsd0l73r1zbLpfG4wOzEy3Bdx9GzAdJY/OnnzI1fCedVRqvnLHZctbh4oWv+WsMMrs71bp7R+1nNHGUr6EfEX3798r7JL2SMIORPbXFiaDcshouWM+iQQ0YmZoXiaGNH6r65sRMpkNkGpjtY692sAl36wSPI0PJOJFZIF3C1q6unkj+vQjaKitd305H7VHalirKzHkrDw+w==
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:44:45 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::94) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via Frontend Transport; Mon,
 5 May 2025 15:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:44:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 08:44:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail203.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 08:44:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 08:44:25 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 08:44:23 -0700
Date: Mon, 5 May 2025 08:44:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBjc1ny0Zs7K7gDX@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505150109.GH2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 91620095-2ec4-4b1e-55bd-08dd8bebc242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7uNH6fNf3nMao8L+3YxRRzgiHqDxkRKDOXdbs03jRLyMI8fpbw5w+TZPxp8?=
 =?us-ascii?Q?DOJO/ka5EAW4iGWU5B+/ycuoRq913klydhrQfsnFrHKk8E4pSc34XD49pdBc?=
 =?us-ascii?Q?jmUUqjaJ46ml//EKrpuhIpVslruSY5vQJLPur0nsAntlDnqhm/RfTmwYLo2j?=
 =?us-ascii?Q?XgNOxOKpE+4LPC06YMsjKGL2rFS50OiKbnElwROmz9OjlrYzTjoRUmnK20nd?=
 =?us-ascii?Q?OLxDI03UHE8bL+W51LKmNtVn0zFhvtNzw5QMimjKZfSt/YB5IIhmVZPYtFpJ?=
 =?us-ascii?Q?BNmW/x3+BZ/Jy8QXC7KRXqzPIafv/q2Rq+nAfbkwg3VlDKmfSAo9G+WcP97T?=
 =?us-ascii?Q?bz01l5mhuT5SZZBg6vW3ntTedXPmMpNPvQTFyjIkuGGwN3SFpQEXNqFfQEty?=
 =?us-ascii?Q?vvboxW4UGvNxIpGRNAYwrqRaJcr+DpF/wCfZd3zPiDwGXKYVEUoO+DZmMeVF?=
 =?us-ascii?Q?FhO29elT9DcxzJ7VeJbH85Gkc9I87QIU1anIXJpotbwF0EsbgOYG5JhiuEcX?=
 =?us-ascii?Q?RglO4D0UxspcsJyYDAlJiCuow6d7UGndMwDKRAne7paVb4Is2b4FVz0HY+7+?=
 =?us-ascii?Q?C48fmTJ8JARxo3BLDZvTc9rWRcMNgMLT3qtYNPTc7PpdmdqZIxzCmXB0fWCr?=
 =?us-ascii?Q?ubMSD1qYnfJFvA+ew02Tz+YqMXqQmZ9+P/mg7aYMizmxuOmntbrk1hSCSPfh?=
 =?us-ascii?Q?s3LcC1+VAiHad61x3CiU6/SMQUshCgDUZowmn75+xowabXquDU8sHrI98Q5G?=
 =?us-ascii?Q?S3/sZRlDCb4fJihtH0Ii/7OcvYJ/b68ySNA/3WP2ftbpMiLCZPyHqsMrE5Lp?=
 =?us-ascii?Q?MblS3NCYMPx4bMZTBCdplgzsl1YPa4RNosdrrZaFH8BJGzZNliGw/cCKu/G0?=
 =?us-ascii?Q?bDkO1WglKq1bJuJ+USIo1KlhjMmyWGiyUnFUq6tj3OideWz8uBfg/VNnD36t?=
 =?us-ascii?Q?opllgnG4A8bkIBzGVfspOLVc4p25xa0zaCvHPw6Rc/WyMhDQHZfkUFQakkGg?=
 =?us-ascii?Q?U6y7obLZ/xL0ymEF9fgzC+3FZY0OCAqbHAQh7O1Hx/Luo25KeD3LItT/y3Qg?=
 =?us-ascii?Q?zvExX33wOnP3JCrAd8Aihg+7/v7H0yqkeqLOXmGYn0o6bhBMhv37qV9U09Ra?=
 =?us-ascii?Q?gY4RgpM5xn8h3Vrx7RQ4T/FHf9l3bx0YwlBF0aWvQZ5fXqJPOXIiY5s3B2vr?=
 =?us-ascii?Q?alUJsRwciCnZvGy7kwFyIKOT+PomY0a1bNBzMwYjE1S56266YIg/3FApmrlO?=
 =?us-ascii?Q?ROwTR6F4AEMttcl5ekLfBYds09RwOl7foSM5jh8bj4ZBj1D/zMclmwz16m7f?=
 =?us-ascii?Q?MjFhNT5MfoX+HXKuSBNm3iBYbWhh+tHvs599BDswlJ5op1fqVRKBXoYF/vaX?=
 =?us-ascii?Q?ZLMRvkMHCz7Cxs8Fqh6jfLe4T2kVOk5jFPMhC5CsxAdqNT8W2grge89xXuM4?=
 =?us-ascii?Q?f0F2efmQqo16pog0K+SSilS/i5SuOGvW11W5gdjPFfvMmLRnGqvn0ONxcy5e?=
 =?us-ascii?Q?6lhqZjeDHvgE+GfM35ctcuhsIJ8qmXC8H7Fb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:44:44.8521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91620095-2ec4-4b1e-55bd-08dd8bebc242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

On Mon, May 05, 2025 at 12:01:09PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 28, 2025 at 10:41:45AM -0700, Nicolin Chen wrote:
> > > I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> > > alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> > > with kernel call traces in the kernel messages, which might lead users
> > > to believe that something serious has happened in the kernel.
> > 
> > We already have similar practice, e.g. iommufd_hwpt_nested_alloc.
> > 
> > In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
> > which shouldn't occur in the first place and isn't something that
> 
> Right, so it should never happen from any ioctl path and syzkaller
> should never trigger it based on system call randomization
> 
> Is that what this achieves?

The functions would be still used in the kernel path. So, I think
we need to retain these warnings for that. But given that an ioctl
could trigger a series of WARN_ONs, WARN_ON_ONCE is something that
wouldn't bother user space a lot while it provides the kernel path
enough info to debug.

Thanks
Nicolin

