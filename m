Return-Path: <linux-kselftest+bounces-31802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F149A9F852
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703B9463658
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A186F292928;
	Mon, 28 Apr 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l8MFYUz/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113E22E40E;
	Mon, 28 Apr 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864277; cv=fail; b=IHdvjkI4YMo+iadXwWRxMR0AyGqoUxhQgbZ7440rxClEVJ5j19SLzC1X/4kMWePukvo6LvgIbeN6FdVNcD/TjYAAZghipJZXFN3i4DyA982S4C5lBoM9TJIty1mgrh01ujnjJsy+N6wGZEMiIQExRawf4E2HTmBN8aYCf2gitsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864277; c=relaxed/simple;
	bh=IHVUTuZ/7QZPXFrfF8PIKm5TweIsF7CSlxppQ5dJ9ZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfgm3z71zZFshWiJhfTMUa3jH7cMBqMD5ztkGqLNzHyb3rNaBolBkzBebDAoDBe3d3S9bGXpNL2IJq4rFr/qje6MkLynA9QRsTLzqPHKOMuMJDF4vBIE3Z7Qzi/VPNUv7xIgol+NKGB/kH9+6Te3rKBJl4sIvyBuMGR1H9pxMEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8MFYUz/; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL7YaYL7uWRd45x5UF0hmpGknDIVulhjKEdAvRprYwnWZj5Ae44+sApag46VWE+71ZXqUTlHXv4N1vj2wU3XDVv32UrBMjCfBN15zalCPobPQiSMAJqSwRBNjN5ms7DhU3OBf9Yb91TLxOZXF2jE0Q16+o6Grpt0zbc6eFIeB2Z8thl5ZGsXKS1dT3qpzAwQjLDS/WT9+t5n6wmiB0bXmgZ4jMZQ8Z4szY67HBL8yfUG/LjjTVTigcNGbUcRlgWjnOux+OlmWd4O+HMxZrS2Jrw2CKufmJi5yuXiN1wrtp6JqrfFW3aQeYDlzfCzdh3kJFm3KeEUAW1SU86n+wVVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6FeDULuq2Qx667iQwb3NOfJWrsqY5eIHOz8aTJUIY4=;
 b=Ahd9HXZLpHcVajWWK6G6VfrO2dbbuN/yfkkan4wQNdyMy7/wffjRFvJKtVS4A9wwvNJq8uDQdUobS16NdHcxv6lQ4x2huEA1H2nM52P8Pf27P28/fh29Z/255b6QChGC2pzBZNwYh2v0p1A46uo3IQVjveiyPLaAmoOgNfntE/UBbeOGxCzHI6MVDj4A1+Dp7LduS2xV8t8o3TWNIiybeA2cEZ1GwJV0uWspWmEzUrZ/7za40d53V3Nivh725TwlwckuUbIO5z6EiW/XL3YxnZK9cPnz6ELstETuvunO8bGjmeCANhl+/f14IC4NoX9nfEt6tkPkT5/QgmUgucXwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6FeDULuq2Qx667iQwb3NOfJWrsqY5eIHOz8aTJUIY4=;
 b=l8MFYUz/fkc7oGUHLdX8r+8u68HprSpbkLPb2dpWfDv8yRagqS5Gqf3//mQjCD8WA79kVjnkchTbFGQBEfV0slhXvjVu7fna7KN8tTmvq7fPaJ6eJDezD+lg10FBh5mcjsWIxtorWD5FW+JSwP3D/vimaYiw1M2z0irhkWw1PyrQ/WJv1Wo5C7JFijVSX/5ORxHjdIfcVK67SjbzIhnOAmwt3afk1F+oS8Ij6s05jSOVlW4rpTteLbx4oEmT82ajr5gXoiWyTR4AooxYy9jo8qHUqM9uuMzUZAH77O78airHhGmZ/JXBIf+AOONy3VHGCqiSrf+OHOdQixYc1tMAHw==
Received: from BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 18:17:51 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ed) by BYAPR06CA0012.outlook.office365.com
 (2603:10b6:a03:d4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Mon,
 28 Apr 2025 18:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 18:17:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 11:17:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 11:17:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 11:17:34 -0700
Date: Mon, 28 Apr 2025 11:17:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aA/GPHRvhXi3CLZQ@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <bfb7dd4a-0597-4b6c-ba53-1e4ee3b733b0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bfb7dd4a-0597-4b6c-ba53-1e4ee3b733b0@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00c3f8-d319-477f-b59a-08dd8680fd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F3ne3Qp4xw9VU3i9rKFQQCRTlZ8iTfzxXiQA/0ge818WLpiZ8s4lcJUBqf9w?=
 =?us-ascii?Q?Rg6FKwq6HshuBK1Chwe0ubhlKnIPtdJ3rAzgST0NT2oASiZzHzn74/tD8fBI?=
 =?us-ascii?Q?hzii0mK5v73Em5+F0oQuRYmK381jpTReQJhzYGI9nJy/7BSxmp4kQ9APgSue?=
 =?us-ascii?Q?6IG7FtM441ygs254Psa46TSMGnQ0uY0wTHbfg+NoZVDNG+h6e5PIXlmPq0HV?=
 =?us-ascii?Q?xMQ92BkLmQqRiqy6eAXmSaeOBDAPC9AuJUW4Bo0vQmiQzoocFzY85koRTQYz?=
 =?us-ascii?Q?fFp3H4kW4nmVR/YHQA0W8IvreQWhYuaOnSrREG7ClTVvrgQZv86YDb7mYsh8?=
 =?us-ascii?Q?nkiScBFE8WtFuaJM2ArCyhFOjv27bTj053xIqWLWl4pprUzyVL0zc9qJeSu0?=
 =?us-ascii?Q?+g1LByA+rmyFVSXxFmiBTQnDDOd3HPgDQbKIVPeyltX54GGgiBLfrsxIPknM?=
 =?us-ascii?Q?pknewL1kVAEQpIfXZOa/AAGW6lvmQUwOLil4RqxR63enRZpfhsZVChpMe/57?=
 =?us-ascii?Q?vuLbRSucE2GXFKJZb1pFlw5x9+bJ23/BgN1HsM9gfXM+nYRdLeqsANibXYRt?=
 =?us-ascii?Q?tUqVhSfw7Wkkfs0BorhDiThPHcHEnywuI8Z55s47X5rrxL6ZlACZGcoBcc1Z?=
 =?us-ascii?Q?0AwKE/+By8fvZ2PEXz3kUWKiQL8GEGfldQq6BCwzcmF6cuU74rN9P1M/7sLV?=
 =?us-ascii?Q?cRv9OQLEb+jIx6yMT/fu51lvsMjtTIQJz3wN0Xz09E8ctwsyKgCaEtzURERA?=
 =?us-ascii?Q?MnKx/mwLVqZJV+mgrvG+yMwZVgDAydGCikgJsEPB3eA45H692Gg04hwojgcO?=
 =?us-ascii?Q?TTiWXzNSlyqjpBsmqvaRWRAbfEbU1OJ0gScpcQvOWzop2WJ5qEPUT7eovTPM?=
 =?us-ascii?Q?46+TU5ddaxTSD/7ac7B42H97OrgY/itRnGGZHR9gucoML3BB2t7Qmdrklc3o?=
 =?us-ascii?Q?uZf6HkKJmvD8kGMZIo9/IeBOxQZCEdaLkh9ERAgXfQdFVAFiHZSpDiJDqRUY?=
 =?us-ascii?Q?CHsvnA7BlPg5vV/KiJiug9L5fiuiwIlzO4KDwJ0XdbY4rz9fOfcRPE7ddXBb?=
 =?us-ascii?Q?nDU+XOen0tBhUM/lUGHoBW6lOmAXd01frW5yCPVYnnCQR+xCy+utVcNnBPVA?=
 =?us-ascii?Q?DVaX1OTM+ho8Hzcas8J1wlZJ2gGSpRBRJkXBjuxaHWyjcMnckl6LyJIWILk6?=
 =?us-ascii?Q?adGnD5zYsWUd2WdrbdGIPBeXbU/JT/HAzQ6FFjksiJXuvGe4TMmMN0fiWVDN?=
 =?us-ascii?Q?+sJOS9k42ez1icRHEUYDmrJk33qeX4MzB+gH4SSTK6Wje3tdn81rrv6kamMh?=
 =?us-ascii?Q?S2/qWAJaDHAilZjWFs++wx3DqP3mpOHHT9t7ZnIpUJwQpxi3O4bW5ZNtuSW0?=
 =?us-ascii?Q?WTXE+DU2TZ4UtT7moQ4Z2jNaPOy2fXlY/qyIN6L0yFlZb//V2WIrqKKRwY4u?=
 =?us-ascii?Q?AXKAzrNKWXPdl7NjZo8cKVdX0lDvYngdCtFXkGmebCQM5zleYhqtYn5wI4mr?=
 =?us-ascii?Q?mkJ1ybqVQJlqLIdsmABR2ADJ/BJftXpinzEN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:17:51.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00c3f8-d319-477f-b59a-08dd8680fd0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

On Mon, Apr 28, 2025 at 10:22:09AM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
> > features to user space VMs. Its hardware has a strict rule when mapping
> > and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
> > mappings in ascending order and unmappings in descending order.
> > 
> > The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
> > allocation handler, however it can't do the same for an unmapping since
> > the destroy op returns void.
> 
> The key point is that unmapping happens during object destroy. These
> depend/undepend helpers ensure a vCMDQ is not destroyed (and therefore
> unmapped) before any vCMDQs that depend on it. Do I get it right?

Yea, I should add some additional words:
"
The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_vcmdq_depend/undepend() for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.
"

Thanks
Nicolin

