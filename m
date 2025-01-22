Return-Path: <linux-kselftest+bounces-24913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32EA18D51
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B8D16A0DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1121C07D8;
	Wed, 22 Jan 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YaXdqCqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC519E7D3;
	Wed, 22 Jan 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533149; cv=fail; b=pOt2kJiFs28FL9Cqlu1xicexLgL7b0kI/5Zj1A2IiCIxCRoV4XkDepjYIxqUk3wjFM/Y7yWlJ/jEqZggxTuhOCJhgvVv5S7SV/wXJBp/ks1DQuwPw+viwl3JcxLaYiYorNg1QSMqv4/onlobFdD7o3So3McqRALHAPhagw1YvBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533149; c=relaxed/simple;
	bh=PEdC2LhEg60lro0U11/Z7tD/CGRY0GtVO4O657tZbGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKpO0WpDYahKlg9kR4mJldV2RD2LTLiF8gHTXJgi5XOSmaxdiQMT+DDvHcUmywf5sw0FrbfFzKmukpYYUJC3zDJzQ4z4n1nl3d/qL62RxkUeGCcSmElT7DLZA7dYpWPV0p37b9KRxrKcR8oEUqLa/Ccf6o0EOTbE1n02FJB0n9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YaXdqCqM; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktll2yiSOX+xmv58QK602U/Reevso32AyekkCKjf/7tXZDixCSXyx6yXLSlUZVrEGX9syFCR48UhJQa22vFGB0AnvV5P+i4yzcBdmRSWdlK9r7AbYmComAp8baJuVKG8luykBx0ixgbKG2p9wVgrK+d32YTgZB+t05uqk+FsAvEfrFnKnJQ0g8ElHW4rsHwEyv0g3QBHTO6org/0tX2uUAU3Lbq+L77t4u9Yc8NOBtmudaY8a7t5i88OV4XZIrjoxxIdaNpx+jTKe+p8bkAteBViqgDZlV6IV6Gy5QoaVp0WmaLPwYkGas5owZl1MfPQVvRwPbv9JzPuCKSMJgCRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubF/gbwnxhF0YG2iCjGvMkPSPY2jfUoMjouIJewvoGU=;
 b=rf6pGt2S0LdMts5HchY7FOrvCv8GQjVv0hHS7y6Fb3Fgs4WY2Hkf/cqvQC8nckCY+aOj5lyr8LIyJKJeZOxyHd0sGs/N9AKaXmP6Ec81uTK34m67pGaYVL1qfDrzr7xxaajxAlfEn87ryeA4NZHzYSLauLL+t7AhgA8qxUJopXGJX20kydnqczpDAjkoc2a1Yd9mFtTeapOSlFB7OJupGOJx4rxwbrhVTDQVyrJgiXIAaJRqlznwPnqg5K83Nd4NZYjmFxlv17Wb3rJ1yRIa5AZNHYEnZmE6kOUh3CMpBF+SVqU+Eq26tv8jgOILGww/ADSBgn8xqPO+uzV2uD6wSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubF/gbwnxhF0YG2iCjGvMkPSPY2jfUoMjouIJewvoGU=;
 b=YaXdqCqMpWROJHqDSWKMLMmj3U/cLzXim8bSDQ8x1i1ndFZkHDXGgMwHTZ+Xi97V4fzohi5pcjGbt001bJvPpAx6/1ZboqUkyTZQDggbvOL89QLZM9OtEuDP0m/yhZyLz70/etk/D/9tiasjIUmwkgSv+2rG3vDFmjqfOEosxXFE+ZQhyTqVVsOKaaJIHN7bylNQ25Ax6WpMxbkckrSprhxmWiBB3pdooppr6if3lESu/0ipeek03Pjcq1JpChhdLwV3ri72CGkoO976fbdH+OljhEgPTgQtGNz2PJZdoH7l2cPTL29q52HbYD6i4HH/TIXSRIdUqvsQpnfm2f9YYw==
Received: from DM5PR07CA0090.namprd07.prod.outlook.com (2603:10b6:4:ae::19) by
 DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 08:05:44 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::ce) by DM5PR07CA0090.outlook.office365.com
 (2603:10b6:4:ae::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 08:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 08:05:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 00:05:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 00:05:25 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 00:05:19 -0800
Date: Wed, 22 Jan 2025 00:05:17 -0800
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
Message-ID: <Z5Cmvfp4JW9vmMTP@nvidia.com>
References: <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z5AUNVHzJPATVqAY@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb1e901-92ce-4dbe-7971-08dd3abb9267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/6HX69zayoBH37fHzvDODjPfIcaAXKBUX9CWt4/woF5XQH4hYSF1ROmKONl?=
 =?us-ascii?Q?cViBPIX03teYOwnmZmRQmM4S01Ky65858Pn+1z28V85023IiyWyc1D0Zkmx6?=
 =?us-ascii?Q?uMbylKKDHl7/PgS/3v2lMzf2ugYc8N9aKXrJSjz7t8qGuCa9C4qsBPQfWMew?=
 =?us-ascii?Q?kRGrfscCYBZiwqAwQAoaB3yqNFf2Ne2+vTFkRhevMNkviVHnlImRBP0g8VsE?=
 =?us-ascii?Q?ca79vnXB+51CBixlndjmbzCUSMsGV2vv/DCplygRE12E9iys39v9p1NP3OW4?=
 =?us-ascii?Q?q3Z5FVF1r/unwdIAW08zNk/XoZUiiks0eXaLyjh3gZqap7NaWCVs+gVtRQym?=
 =?us-ascii?Q?OExKneVKB7pdiwZBguaY63BguHvcdQ1qAVs0kyjBaajGfFaeeTOKPBYByT3e?=
 =?us-ascii?Q?egVzaUgWl3epd6E1GFJTrFN0yJhYS0znrkBhV8CALWioF0IXBs+WYfqFFQSM?=
 =?us-ascii?Q?LHSriooLC8Es+mWqSfP3Pgp2ISDNtaY2k5a8/WXvTyW27J1usSoKew5wiwlf?=
 =?us-ascii?Q?AuXjqYk3R4cryKNjhfVb/FlVGTY5+fw9cwNBU1aoMR3vrfQ658ctNee31kSr?=
 =?us-ascii?Q?8/vRJ6wVgU7kCKTB1CmKKq9RleVhwi/lYfwo7sfQviEK7om7DGI7XnBQxOpj?=
 =?us-ascii?Q?U0+mbXA1PTRTLRsl84pZ6YO6EAQnSmysc+3AVavg0uLc4X8BbnSs2cSCpUkW?=
 =?us-ascii?Q?4wIYdkTX8Hh+9w+tT7vEd082m2x6MJsQOZd5r5NULDX5KAL1aLo3B7hHxAqA?=
 =?us-ascii?Q?I8ZpqgIrpDNFEW5stXYHdbfOo/Q/VsfsYL9PS13tdCKxfXAYrFT7LkIKX7xG?=
 =?us-ascii?Q?9bVCJwEHcqVd6ahxJhoA0mr6ATLpVE6C5Yj23iXF0r3gUddjDoPB0B11HJYK?=
 =?us-ascii?Q?bLHSnk1hsy9UcgluTxSSDZ9a7q9HLjAagfCPtQDfROlXHTIF9kmMh2N6HCIx?=
 =?us-ascii?Q?qIKGCr2jRId0EG+rUsqoyI9haWsAnWC+wcTZUQVCjnPh39UeQPSpU9Exbzxc?=
 =?us-ascii?Q?DRcYPe5xjRSsKwAgYDZZYEtTxVhOjG4YxrZNtT68C+eqTePYATqVDX+MsLc3?=
 =?us-ascii?Q?5WLwcV0SXvzo4hmfuIRaYuel4K9s/vYz471z9z3j1PsX4IPesEKGSQglOr0m?=
 =?us-ascii?Q?cttY/pOLlfQZTdAmoHMNC2oZcGRYUFngKtSzCB8Ytn5TZxAQIDNwUKaVZR5e?=
 =?us-ascii?Q?MYEkDlHHaLNp2dDE9+YfPFN6KpBibYUvsqDt3YIsuPcX//A+MTdeSekN863O?=
 =?us-ascii?Q?xtLyeXpgs2rANWB/q2cLBUdOWH5eIxk/XzIY+7j3lgwqgdcUd/yRFjtZsm5m?=
 =?us-ascii?Q?elJEqiMhyYBIGeJiEpk4tt/57GGWRDRkcqCtLs8aXqV6WffAYKWfPq4ReNrk?=
 =?us-ascii?Q?YJVfkzZVK7DYBxdAFmVtCKHtklZosdgTWCieuVhyizYL/FDGE2zsrqzs3WVg?=
 =?us-ascii?Q?pR3cZGvDFg4Xn1aMinNoj2E8xZnvGdrvIYZI6F90s7L7VIIAJqO276+bcKc/?=
 =?us-ascii?Q?Yv6TXu8IMEDvKzs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 08:05:44.4466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb1e901-92ce-4dbe-7971-08dd3abb9267
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

On Tue, Jan 21, 2025 at 01:40:13PM -0800, Nicolin Chen wrote:
> On Tue, Jan 21, 2025 at 05:14:04PM -0400, Jason Gunthorpe wrote:
> > Since we don't hold the spinlock the whole time there is a race where
> > we could pull the overflow off and then another entry could be pushed
> > while we do the copy_to_user.
> 
> I see. I'll be careful around that. I can imagine that one tricky
> thing can be to restore the overflow node back to the list when a
> copy_to_user fails..

Hmm, it gets trickier because the overflow node is a preallocated
single node per vEVENTQ. We must not only check list_empty for its
restore, but also protect the overflow->header.sequence from races
between atomic_inc and copy_to_user. However, we can't use a mutex
because copy_to_user might DOS...

A simple solution could be to just duplicate overflow nodes, each
of which contains a different sequence, like a regular vEVENT node.
This certainly changes the uAPI for read(). Though the duplication
of overflow nodes doesn't sound optimal, it's acceptable since the
duplicated nodes would have been regular vEVENT nodes if there was
no overflow (i.e. no extra overhead)?

Thanks
Nicolin

