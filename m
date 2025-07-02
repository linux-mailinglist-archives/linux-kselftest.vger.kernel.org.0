Return-Path: <linux-kselftest+bounces-36231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27046AF0760
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636E01C04EF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D807111BF;
	Wed,  2 Jul 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ST762DfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F6DDD3;
	Wed,  2 Jul 2025 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417196; cv=fail; b=fC1MRXGq8R6PFPPVGIL5nIB3ngMVngoz1K+6w2UlYgjcEIunI+JYoYPvBZnEcdbzwCyZT/GQHwUbpjDy4IsoLtai9ZD1tS24WvAb6NpNl+pojXDlD7lkDJTdxKK+GJuciaFb7yQ9H43Gu+lytbre8C+lHCn0sX/ESL7Dqklq2oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417196; c=relaxed/simple;
	bh=pvhL1bTe5C4KpHcR0G/zk4DIVquGyTgxTCQSJ5q+Bf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKfE79WeeWYJjUIX/ONNunSFr/kp//h2BYSpxmYK9aYoNUP3Q5PzGtW7zjaoMCY7M+t7VO7+J4Xhs2nczCZIX2u+SjjHE3U4ZNS5YUff1M17zAu81fFP3ouqAYXXjcFAdYGbdTjp83EwiL1hFZSzGXHJeST1zsy2jjm4wNI7FeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ST762DfM; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab6mggi9kFf45viq708BMkwis1YY4Zn70Uue1/VitJGOznOKRKaxwbwHWwuuGuFTr44LgbNOGpZfXdiVd5BdFAmGO/Uvy8a9T0qr0UyQbcHQxjGgetIDRDqetZ42ZiCeEPIFo9cMsQxNgRa9SfiUUrKhyZbKMfbTfO1lnGjrS4Qy0Fb1LIrXk5KtJ0oECOqvsKHVSph0J1iVf4dndBLj/hg0kJYa3hWXNAzzlVoAyh7nIGzKfz/k93QeoRG/Na5NCdwuZyJ26XWXZ+rAgh2f8XCiQkxqzFyBCWX6E64y8iiZnHqyvHRHFSFwPAv68Iyu/btZ1dBYs8pvsqz67G8iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaIwyDXc0jA8KvTlhANwsTPzXaYZb5nagliJv/mgXVQ=;
 b=nEYSB/PJoBdE5dVf78GPR/893ks5cK4hVaZ0x5lx/uBTbP5LgbNdS4/91VvEXxZWWSI+HoDnS856FwwDKvouFA+Vdc4ONQ9/UzzS8p40MXAQZMyfnZURfzs9K1QOsoVt4j8XX0f7UzKteb1MINrr3EIeO7fJtUaWk8va8+ufttuzeioLWWpgpsGjBx9KQOhIvhjjxBVUfW+kTRozCu2DShT/A0gf1gO3q0fiBc/21w1tBtZnajtQV0VX7gB/Ezr8KJc8ZYEEA8AYh/qZvFgd2eI9Cv6kuovJRz6VbXsTSEypiXjPnLNvwm9/zbz7Hv2XREKrlB36cbCcxdwGXVPxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaIwyDXc0jA8KvTlhANwsTPzXaYZb5nagliJv/mgXVQ=;
 b=ST762DfMk/ke9dqkMXEMVhaswPulN/+vYcMZ6UFERJgCE07qIOSPKvkfOs0OE3zb6e3JTnV4Iq6ifPTJBD4u1GpfkceNt38M/XOqseljyvzKqvXDIdXE040DNrwDuirRuG5cPNPiPD+vUSJZuC/Ruyl330dt38x9Sm/sP8Zk2EM7D26AJZIQsla2MKZZZzS/Ousu+VC92jY2l20GpJNaIOFHAeV2nDVcDwJEkNaPClYMr5mtm4QCpRJh9YcqoZ4qiVRd5292g4Ao/Fup2N3z7vosFdmA86HgrgP0qQOoPwivXFi/7ndiNJVKujyOz6trNeAxeaPCl3/RGbzJhXirOg==
Received: from PH7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:33d::24)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Wed, 2 Jul
 2025 00:46:26 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::86) by PH7PR02CA0030.outlook.office365.com
 (2603:10b6:510:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 00:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 00:46:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 17:46:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 17:46:09 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 17:46:07 -0700
Date: Tue, 1 Jul 2025 17:46:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
References: <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGR55PUBnwb8qT8U@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 08527f4f-8097-4154-c215-08ddb901dffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/3mpHmXS4QNBUs5lO7ZS+cqHiutYkuprzIHUFqPUVzTqamJrr7QKqP3mvfR?=
 =?us-ascii?Q?tC82Y1R3JeMJ4lOJL0HzrwnJDMj6jSYO3ovGc7y6DI3yHyllqIjmwY7v5/IZ?=
 =?us-ascii?Q?LGbyEQ/Dk0/JEX6C0fS6hRT6nzeid9DNN+x1Pko5OON5Msj7p8EOSRG1RV0g?=
 =?us-ascii?Q?7xKfzcuc/DG3gX+YoeraSSpnGQsXqpyelMdz3InIhrw576HwbWxAqjiYgdz7?=
 =?us-ascii?Q?vHqe7MgeSjeBEhSQJgwFfQxZpyj43FTnWQKUu22tWNcJ2KE0wDjw9l2w3l4Q?=
 =?us-ascii?Q?vB306EhMloTq+b2adTjIhO02ur0hnx12yzpbugeCg22rInAo8/L9Ug0H3UiH?=
 =?us-ascii?Q?1jdBQniQOhUufXBUYgjkewYve+uGpH5oZCaIYaAEA/06UXFXzMrq0ZbEhIfG?=
 =?us-ascii?Q?HbDxgn2BCyWi2YQQOTXMg5AZnMKe6JsRocuA5KgP5vSzq8Qod2+7JVFN9nkn?=
 =?us-ascii?Q?NeezGgDaFQrBT8hp9wZiI3g2gfoKfivyL5S/DaIxd94qirhA7VsKuPI8pco4?=
 =?us-ascii?Q?FrWcLPkHtx9LLI8v3XRCX/0VWWHnZwTBqjaHqMvu+c2O9Ld8WMEh5S6CKdUs?=
 =?us-ascii?Q?KYegVimYSvCiCm1wBo9m30gBZLvZYorcuSqIpswsoH98a7XEyUL8QjdSPMJY?=
 =?us-ascii?Q?Ro2kiMY5Jv/C8e2L1nhrh3uN828wRhPSMArfltSC8zrEbzQCU+yHRDrn95ob?=
 =?us-ascii?Q?BHLv06r9JsK2/NG8Qn7dVPj84RDGYPB/SNkVxl3hQ12pTrgmzgc3kNQno5+Z?=
 =?us-ascii?Q?6VwxMA8po50NwaLfh4SXnWU1TtQD1YB60AhoOBD2yUNHszvtvjPr0Ej9Srvj?=
 =?us-ascii?Q?ObNxqDOgWeMiZ2ssvSyX8L8oVbPW6EBjf2zK2qlxDx3YPoS28OSBYqVb6C5d?=
 =?us-ascii?Q?rYdyY8Qch0rU+xjN8ZOs7gZYOr8jBfogXbD5+uw4MA3S9snAPM8z9EKnz/8h?=
 =?us-ascii?Q?dAtdFFcJmzjvwBGtVgSiiRhh5duAM4OhAvKcpWAch4ZrG5J8naP0vylsdm9m?=
 =?us-ascii?Q?omwGsf0z7Ftw4wyCBr1J5/P6TsJieE72glqV/tH7haV4on5IEJooakoN2Y3D?=
 =?us-ascii?Q?tWdW3Y6F+Pj8hoxIPl+g4q29P8nev5GpFYuaL63tTIMTHhik+IGnfJI0yw0m?=
 =?us-ascii?Q?mXNtlViddxjRjMf7w+dVhpHGJ7ZfufBElQ/+oRQq7ftOI98CrY+T/VmXtPkU?=
 =?us-ascii?Q?Zfk2jsJ/ZfJeiZu5kr9ZUNTaXm7DiwSNwSC5HKd7sJhffsvh3Q1LkNIpDJS4?=
 =?us-ascii?Q?Dme3HXDPs/gb4UxroLsVyNxXz4FZ93cbnoejvjE5x2SUhbM8fsJq/SiustWM?=
 =?us-ascii?Q?FLUq+z9mePDeoJBAF+GvH+uT489gLI4sihYkpYp0BT1gd02ObJsMu8XCDn+5?=
 =?us-ascii?Q?ak/Pr1dfjebp23MhKa7c20G2Uz0PFhCeLuF93iiRCWuhOVchRwEpQbzDZgxQ?=
 =?us-ascii?Q?GpSR9je3wcQMeLvmTFi92UJekVspDRJJXlkUKCaGuhMbTiVcFYIZCpj7Xn5Q?=
 =?us-ascii?Q?LjRKZjZ/36iG2ZyPdx/tb/cj4mDk4pkJRxQM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 00:46:25.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08527f4f-8097-4154-c215-08ddb901dffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

On Wed, Jul 02, 2025 at 12:14:28AM +0000, Pranjal Shrivastava wrote:
> Thus, coming back to the two initial points:
> 
> 1) Issuing "non-invalidation" commands through .cache_invalidate could
>    be confusing, I'm not asking to change the op name here, but if we
>    plan to label it, let's label them as "Trapped commands" OR
>    "non-accelerated" commands as you suggested.

VCMDQ only accelerates limited invalidation commands, not all of
them: STE cache invalidation and CD cache invalidation commands
still go down to that op.

> 2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
>    mentions we'd like to "fix" the issuing of commands through the main
>    cmdq and instead like to group by "type", if that "type" is the queue
>    type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),

I recall that FIXME is noted by Jason at that time. And it should
be interpreted as "group by opcode", IIUIC.

The thing is that for a host kernel that enabled in-kernel VCMDQs,
those trapped user commands can be just issued to the smmu->cmdq
or a vcmdq (picked via the get_secondary_cmdq impl_op).

>    what do we plan to do differently there, given that the op is only
>    for trapped commands *have* to go through the main CMDQ?

If we do something differently there, it could just do a one-time
get_secondary_cmdq call to pick a in-kernel vcmdq over smmu->cmdq
to fill in all the trapped commands.

And this is not related to this series at all.

Nicolin

