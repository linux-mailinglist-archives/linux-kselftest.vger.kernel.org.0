Return-Path: <linux-kselftest+bounces-23626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6C9F87E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 23:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD171898613
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294216FF3B;
	Thu, 19 Dec 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ID6W5xeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CC1BDABE;
	Thu, 19 Dec 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647452; cv=fail; b=LWgv/cwlgk4eMg/PNnqFVD7UFghQ7YHcRVa6jci1EPu9TAjfjqPZncrU6xcv8FU3wzF/5N71FsZqBjglCyUlMa51mC/5joX8TZKxL/pJsQVSuodBsyJLxeNQwgMVxMrVTlA2kA6lhFQclfkIrgacP/4NSL4bYN3h5hku+ylBXC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647452; c=relaxed/simple;
	bh=OoXe48t5N6gvHZpWrg5aeHQZPRUSPodzDjr+R0RQdj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQo+TDE/nMlZAjPid8qE+erCbk381f6qQXSraYqoOrGRQnaYux5yotC1mgmrUpwhcRgMc5Kkkq8bEvro+G3VcrRbHrNmkVBI+nO5+9x3r80Ndg5vwqZzO+qG4YP3cjWfQmgTwY8Mfe6q1wI5gD8sr4JlmsOGGwtAVSgGimFlzuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ID6W5xeq; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAhVSk82XunmmX9WnO8XdAfqWYiA4f+eZDQgvlg2RA6LmwppobKU8NudyIGw+KFjyGZbh5ILCu5rGf+CP3IAzgwl2Bo5gawXju01QOh2zZg1Ypk2FCYUCYcjYSDxhzdWQ1FhYecbz6BuewCaIIyzPzsvG7Kaqus/16johq56hZGdp1Oy+fvoHT1CjrNWkP5k6VMpFYFljQZ7MdU/cVQlKhVkywBoUZxUlHT01Wxw3Nvf6VDPB+s6v1QCCXzP3jybXIfTGcrNOZLhIGIp/Qr/RlBCHKEk5IHQqUMBU9m3TvaR1jrGEgo9G/3d8PlKo0DrViR1O7O5m8bECUv54EAGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoXe48t5N6gvHZpWrg5aeHQZPRUSPodzDjr+R0RQdj4=;
 b=kgdOJdskfh/G9JxNpkET6/8hGLoKWx2SwHCdwfXEY/ZwrweSUgcb2gdbRKQ2WRVzsdYZAcF81J6dml0egFkn+GDQizVyKwviQY0Evmt9ISiGFI9qpq7BOEcgCnL/s9ZOsWSZpoMdZoSI87SaFmpUnkmS4f7ac6cTfL8u76EO7ywK6EdCFcf81fwz2DNPwPKKl4iM1t1p0z6GGj032O4o4zbMXAEpqFxF50MCSud2aQyde8QtLNu1aqrVAzXzuDA6W7wmkFuRpbicOpcUZlbyInezK680gdSK1eT4uh+5b5XaXE9ZMND3SxPej7OgptHhL1+GC8ZNXM+rmfYieanIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoXe48t5N6gvHZpWrg5aeHQZPRUSPodzDjr+R0RQdj4=;
 b=ID6W5xeqcG58sDvcN5JYy6K/RpaS6SgF0Zv+fgwWn3R/pxRNdhBpmV2Cx6HZ353x/KxsEJHgNqNPl9gIrx9w11y/JVx0nltcowfN+6jDZTVTuGZHZfmXwuEkSnVVxaFroOo4scHzytoZG7TTG0lP1BU5ueOanbOWhzFZZN/FJPANor372g8SFAXP6iieHU+Zm4PTmpQoz+B9MkihGZ7wAUT/iFulsBqySxGNgrrzO1k4GVJd+XIvrfBmI4lTpZhDWKuc1JH+X6ySjWlEPb9QlPZuuHw8ZP0pWSYfCeoPumvpNAJubsHxcLnDy8SunoPQBYSuYI+uQj4lSNstrxrPXw==
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 22:30:45 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8e) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.9 via Frontend Transport; Thu,
 19 Dec 2024 22:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 22:30:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 14:30:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Dec 2024 14:30:22 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Dec 2024 14:30:21 -0800
Date: Thu, 19 Dec 2024 14:30:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 01/14] iommufd: Keep IOCTL list in an alphabetical
 order
Message-ID: <Z2See1oS+Ogr4LQI@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <0bdb04c6dc32f428a7f181471a0d78642e80d3b8.1734477608.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0bdb04c6dc32f428a7f181471a0d78642e80d3b8.1734477608.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: b6670d5c-9b02-48f1-3042-08dd207cc77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FSG/Q8oFGre4yMrCv6e11QutC8ByK0pdgmtBTqwMVzxnB+AXReiHeadX9ufi?=
 =?us-ascii?Q?MLnoFQOHKX7rH3zrsvhDb5gO57TJHiFORVPRTfcYghlfmYijFP07YDGDO4em?=
 =?us-ascii?Q?cZcIHeZq4vVkr2figX+5reWkv41AdCXKir2m2AYe7G/6he1qbkbXe5D/vPu+?=
 =?us-ascii?Q?xDoTludeL33TDtSsBiy3p/WgsGa+43rwtbveqonHDEA5kUetGofcfEQa0WOd?=
 =?us-ascii?Q?WOm/Cbof1r7gSGK6T2oI+apdyr40FB9WUZ7lOHRQL3y+7TE8XEizeK0Ersd5?=
 =?us-ascii?Q?p1yiQ8or6iUTsA3qEzxaGOEXpQZ4XEeMnPXNp5JMvyVoXOjgMwQvfgFlKRW3?=
 =?us-ascii?Q?bERYkLVqONYYPP7xf9bZRhaUG7zsI+X0cnWCQNTita5tDgFvJ/3aj8RYRgBE?=
 =?us-ascii?Q?C2l7KK8zFV4lwSnb1Hr1Vdfc9vL+YqMuXXmSYih+PQfBTTkwI/eQByAjZFIv?=
 =?us-ascii?Q?G+VlvLaGLkjMNgeObOTbpV3WDkhaxO+AkELWfa0AaHol9oWpWuMQDNje1LjU?=
 =?us-ascii?Q?Gmuah/o7a/gE+1YKQ2BTFm3ACJ2HxvnPSXrMRK9Ubn00354xAtm+0qRnhYCj?=
 =?us-ascii?Q?slMJZP1LzZDwJ3bGZHjevUsizX55X0BNr25SAxxXFx1XnLuvP/ZmpUnM4WaV?=
 =?us-ascii?Q?Kr+22yu14H28wMFKITCojml9FNJYTkXjMolAAKkiFITRD2sPhjmcoiPPMerP?=
 =?us-ascii?Q?QD4Az8+SG6dIgcxpf/RM894GhvFLRgZx98WVjsJ+KBtKHmkTd+ceDW3A0CR+?=
 =?us-ascii?Q?Uqs2Z0TMNYTiHEnpjHitblehhS7A77AW0+G8By30VWFli23gd6KSiZwGd3V2?=
 =?us-ascii?Q?v9VBtgAQHtb3mUBHAh3IA3oJNJWtd/L8JDAFvY8SR0qYDhbzt86/vIYJ0yFo?=
 =?us-ascii?Q?cojTeIFnJqZReYs+yhBUqS8b5Gs+Pgjrn2Mw3AVFfcelhkOZ2AhJpEQNsuE8?=
 =?us-ascii?Q?CW9vj1HvB1aRO2ESI+jHYXxSLBe3+w006VSIOmjjwpHdlZTwsGiq5WNFXxGV?=
 =?us-ascii?Q?oXsZn5RywK1YD115aalPJoOAoKjfyq6q6twseOIMxPLbe6GUltROsQQ+z09g?=
 =?us-ascii?Q?hKhThzo0YdqDgJkKjcaTVMVUBX/pQq2SC0kzgGNLZXy9/ZlFfDxC0Oq4A7U6?=
 =?us-ascii?Q?m9hu5osow+ddCHkrmjTF8M9vh+E9Sqr2U9L3ZlvebNxqRwXXVKAHx3k+j7jK?=
 =?us-ascii?Q?8axskW2YtpMWSk2dbQFkCoR1Wr5+FWLpIPc9sCQUy3sbvun+PNa5GqMJLgPW?=
 =?us-ascii?Q?zIHTQcYqRTyJdzOMJ9+mYQHEfWYsN4tb0Z3lU0NejgCcWQLgXYhBNCP+Uz8k?=
 =?us-ascii?Q?I/zJ/3VibOpVpIYxc2iQFAMQvLHJvJukLsKywSFHrTZfmjmxR62pcRMj34bn?=
 =?us-ascii?Q?c4ONYdP8s0yMdttZCi65irHzSwwdBNEziT8KfloUFYohPG+eu4nXfNE6WXF3?=
 =?us-ascii?Q?sYrgSUa5z2fS0BrbfirsYh9N0O+4rbn/vbVNyfqztdR6gCulRJzgmJYYhgTl?=
 =?us-ascii?Q?pbpwfEE6HkOqyTI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:30:45.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6670d5c-9b02-48f1-3042-08dd207cc77a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168

On Tue, Dec 17, 2024 at 09:00:14PM -0800, Nicolin Chen wrote:
> Move VDEVICE upward to keep the order. Also run clang-format keep the same
> coding style at line wrappings. No functional change.

It should fix the order in ucmd_buffer too. Will include in v4.

Nicolin

