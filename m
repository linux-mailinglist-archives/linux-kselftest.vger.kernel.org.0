Return-Path: <linux-kselftest+bounces-41900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24731B86F55
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D6B1B27444
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B82F0698;
	Thu, 18 Sep 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I41R/gTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D726214A9E
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228750; cv=fail; b=lv4X9ndDJgFjxmsHIw15NpHRdl25mxxPqKNPzdKkH/aOyAj6g97KRgBCVdmRKL5axgqAKp1nmzEE0ovavU8IEO1FVJesjBYXwYLbAVfNUI6GtRquweZG8EZklnbqgMwU1NowsfVKvV4b/7UryFm5jJjp9oJpWDTYlfFEc4obIsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228750; c=relaxed/simple;
	bh=eczphgyoEMWbO1toBukIEb1/KSxRy1H9tuavtoiZV80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWvdgOvlyb975PmE0sstr/OeryDMfc0gCDLls8eV0c0U/fMpQDNlGwbkIJaCzNPstNTsJ4F08f/npcLphY7cObKCfnj6PXuo0tpWbNoe+ypwhxv3OtRJS4PZihoOMg4X4RRRi0p89zJpgi4rMMwEC4inbtLiNCGbeuh6KiFe5OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I41R/gTJ; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIrvr5tn2b4UBXaPeAaZJ9/OaWbAQPmhRnySF1hzSW22Xpei9aXVdWMZW+3dqpKxTMlieaiE6PuRVr3axvHtkM4DIDCcg0OPEtcHe+w6s84V81aptFNJsYurrNYE/Wxa6i3nL3X70fvGeNzwJinKoGCtBzPz89NketoUlWh7Q6XbFPkzrr/dxSiAww6j3t8vGvBlnwSRRKIq+8TxlvZ6jxTxL4UzM8HwwpmQGt9cwb3NINk3JarXeCaB1pi/W/eqjk62K/JJ+SBeE6SWWAaonT58iQ3wEqKZRvwKi/N/Ka3ne67SfcTclmS9EvBICniHChrAiWVzI1wRHoEhmMenpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7QGWjDgl3Q9XcNV1x4VbiQk7i6tETOg+W4jgB7fyzo=;
 b=YYRqyFo6ENka1c3qhHK1IqhA1BKc4SfEdYDq+puOUiVUhn/HrhrMQow+AZwxTXUgpjvOgc1dadPdJxbhV+NIHyCUnKMgiMZ/ENwAXDU3n4iom1EhkER46cShO+uPVXRikPX910p5qgS631Y2oEvNP1WDyh9aQWUu5w+VUFsGBCVy3W1tlC/+YGhoHamhb9mQT2nQJNRCmIcD9VO4yoPV/jRtzhyoDqhcEY9GoLSi7+D3spw5i1pinFvvhPBjl2GqMDXmRx4Pdp7I+Jy0DYbh9sZu3P7ErPQcq5hseLRxdu5HzZSF3GBv2Xdf+AaxdetfpYwJuvXAHGmmbWf8jWAPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7QGWjDgl3Q9XcNV1x4VbiQk7i6tETOg+W4jgB7fyzo=;
 b=I41R/gTJEVDUrOhFsrmE8QrcJA+sv9yOujgaI6rwQKOXAekOwjDISwVhGQCCvXvEK8ni8H/wovUCCZIJfBH3J4K6PlVmjAinmuSN/qHz50mNKljszOdftX9QxodmUhkJr23tGQRot3BluMVyENsUxq7wi9Ri3qOPKya/99M3QqwywiZC+lHAo9lVMb/Twvtfkenjw2oy1db4kE6ubMu7ApJCj67OT077KW/n44qWYJysL/YsnYXbUaarFcsMgvCIP1Bri0Tq3HW1GqDvzza09I3b3QHz+Xb+Lllm52Y92TnImYoXBeYIPUUidK5v4ljR0PMlmWOFu0R6NSKtg/9C1A==
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:52:22 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::3a) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:52:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 13:52:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 13:52:05 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34 via Frontend
 Transport; Thu, 18 Sep 2025 13:52:04 -0700
Date: Thu, 18 Sep 2025 13:52:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 0/3] Fix a race with fput during eventq abort
Message-ID: <aMxw85zecJepXHdR@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 066de89c-4e53-432e-166a-08ddf6f543f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VN2k2jkYT+T6AbPL0wnYWdSi+HjJf41PZ57O10yS2EfJGAdN3Zm6LSTt2/og?=
 =?us-ascii?Q?32Z4BrA8HnMo5z4diKGDS1yZ6cVyHvdV36QCyWfG4nKGJP66yzQm5GwHcTLs?=
 =?us-ascii?Q?iGb/aZJAfldxTXQTepOsYJRiDqcGKRBl8klcEnKfWUBxVh6YQqu0zmXptZBN?=
 =?us-ascii?Q?w3XYHAtLx00t+PmkRDBG3E8qGC0zhHPEal9T1PMUwqVyEu6+0ZXrz6X9TSYG?=
 =?us-ascii?Q?cNE5R1lveNCoC3CF2TzCsz/TAo+6KxpKVU9e15q1VIt2ebfyB88JCfcBO+1Y?=
 =?us-ascii?Q?0kJYqev20PswzZT3rB9Jj78GtwbF0xrTG5lT+HIZOW8PJHWu1hxQF/HCkZjd?=
 =?us-ascii?Q?lFvJh2wBOyAD1NQZdsBfRFZsEC6JYXYiLFmjEUN0snFpyT3ksPPQ//XrDsOr?=
 =?us-ascii?Q?TfJtZSmLwlo0dzSQsJmdPFh/g4FP9ZD8pqJYZEReMH6rBtMHMPzh1+bul2SI?=
 =?us-ascii?Q?PwL68CGzzSWhuFImRY0Hyo4D9rH9oNMziWxgQmgDVF2/vPWaL2Y61G7uKqUh?=
 =?us-ascii?Q?fxaYaPeb++KuBJFx2MNJFnrAM2C0MIHt3t8ZgHoxJVnxLq4X7OxQPPgUtSfD?=
 =?us-ascii?Q?MZ12C/5PS77nXA6edm1yIzBhnvFQxThrXllOjSQSB91emfxDAsq3DjtaA+jN?=
 =?us-ascii?Q?8o0Hb7GUM4sXiT0cjBRCxo94yIclYIjTC+5PhKIKzOglLJNHj6e7rXAKY5gw?=
 =?us-ascii?Q?LGyTOBdFIvJvyJJAdFkPLioX7LdQrUlFE3M+/dQZAvQZrH/EcCF2CKcuuLsu?=
 =?us-ascii?Q?F0NaEUWr94Fn3czxTT7q2h0PTKkCepSg5+CjnInBza3VruuL3yUBoy0CK5KW?=
 =?us-ascii?Q?y00/h2NP/xQc2o0pUIY++rlKLlWBIk0jD0NcyQdvOPJxfztqh4SGxTUjaszQ?=
 =?us-ascii?Q?RYPOMCJJDrncWqpys22T00O1LgUqLg9dFWvmpV4lNTwW4LHH39usxN4+kdgZ?=
 =?us-ascii?Q?CXD21KMOe8yHAbFd1bLxb6CKvrKUfc/MUhIgGqu72jQPcQtDqKiULguqDmNh?=
 =?us-ascii?Q?NIS9voY3cTKBwYGVXv0GfBylkA1SkYEh4ElsmF+EJiKv1ZHcgG/sBZQBdD4z?=
 =?us-ascii?Q?hUC5u9wh07Z1jBf7j6AnAz3jCYn2SGnwQ4R4ydVHAv0KKuEFj7e9NzDvuLiO?=
 =?us-ascii?Q?Z5oXGcZi+kAIFvbshSX1yskjSZ5S0rcofhmnx1p/b0mJ2X2U2kunsjtdhbPR?=
 =?us-ascii?Q?8eJI8u+JWDD20lG4OGvILnTkOHFlwJpwNdhEYJsOCJDH8imIZgBXn2Yh49r/?=
 =?us-ascii?Q?3+MW31ccPpIuBm/unRyASGCZJLxYObNADN1H1KPN/g93hbjJCdFDW3SkneoL?=
 =?us-ascii?Q?YUvWJyv0I7xWe0JI5gPQiiZS3SIgI1c2Sijeb58ZDhQgRW2vG2V0b9DMTKpZ?=
 =?us-ascii?Q?TciPYuJHODFqNZ7LHgliw2rZR/Htkp3Da/woWbYgMleNb1Far0C6lDT05LAr?=
 =?us-ascii?Q?ItCGiFkvFXJoOBfnXXVDYdR50qlmGvRjajqv61syQNFDtk3uwbQv17WaBo/y?=
 =?us-ascii?Q?4qMfA68vSDvCvhoEwq+3TZZm0AhCIh4nI8ak?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:52:22.3492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066de89c-4e53-432e-166a-08ddf6f543f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On Wed, Sep 17, 2025 at 05:01:46PM -0300, Jason Gunthorpe wrote:
> Syzkaller found this, fput runs the release from a work queue so the
> refcount remains elevated during abort. This is tricky so move more
> handling of files into the core code.
> 
> Add a WARN_ON to catch things like this more reliably without relying on
> kasn.
> 
> Update the fail_nth test to succeed on 6.17 kernels.
> 
> Jason Gunthorpe (3):
>   iommufd: Fix race during abort for file descriptors
>   iommufd: WARN if an object is aborted with an elevated refcount
>   iommufd/selftest: Update the fail_nth limit

Sanity runs without a problem.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

