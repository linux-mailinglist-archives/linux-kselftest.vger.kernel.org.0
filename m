Return-Path: <linux-kselftest+bounces-20820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B039B3437
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6281F22241
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1661DE2AB;
	Mon, 28 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvZJKnoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E315E5B8;
	Mon, 28 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127724; cv=fail; b=YGmLZ62l2jBMkXYtX6ms7FbndHPTd7d4+c/Acisqtu3qwqmnxRoeETb/JxnKZcEZX6/d5/mX34HHMB/2HkefkUdBq1Tcg6KfaDkh6h88l4wVcr8dVZuKa6mzk4a12HIdMT7FOb2lHp+hdMLvJsddBt2AK6o0n32Blr7Vy04OmzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127724; c=relaxed/simple;
	bh=kzHewhwwd8ao1CxsuP+JS1guIUwYEyBD9RK41jRZL0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad5jNQEzVctTTtuaYEey9fgXmgAvbU1RV2ArQKH4hlwC1C7jgIJBZsEcQdSwRN1BoTTAtwGpEtvkJb+3ay1DziO2XJCfE3UT//zVuXwZrF9fNdksNdpPbU6Wk/s97cq/IKFOfbKJcJKWNR7tPTNrnMEMgK7vosxxVGE0RrKiwQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvZJKnoE; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDw0lGCtew3RS7HdFBroYVDfQWC+aoPBi2GNupZDh4v8jyerfacOaYTgAC6BSmHaf8ulgz5+4iSMGotDeR3IGo8yB7eomhXTKKR4B8OCEXlKaVK8SiBhZmSiSkelG1I8vnVoHoHR6yPKktyzEo8T9OqNVDKgr7Gc6m4n3RIPaEF00vJwj3VC+DMhkHOt+NnNxaAmka6pb6lWVjSonx6Qi47CEozxsPjwg00RE1KBIUoAVP9r9aiBbuUFtYSJ3eLpg4AJW6RwQeC/trbHxaLd33L/7SeTXMI1zNLJNfw3oRU+svZQ13us3FmKlFJHPWzfcDQIzLzzcSvx4775JT+Z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGY3u7zO+pGvl5JJqmjXHuv6YVHyYlM+a3+QwvODDEo=;
 b=pQ9fdsinwkYdpl91hnkRWjzMmz1vVHi4ahV7kr+WKR5uUJxkpw6/hyUPD2s0WViKagI4hEHXu/LeAAXbIlxJF0Dv4Ld343g0My24k7azZEefVfxyf34J2Re//PZloMUyksgEJFz6GOlKpt11OFNxbDz99uvBrC4wRA5bYrR/VVMlrZR2hZM+XwSzm6rSuEL5TJCpEdUy3bAeeNgi7QRWYNq+x/Z7qm0J2iJxSKBtZ+Cdapha+pcEcz5sjQ0PeFirVn6nPpefrgCfwR9ze4JiA0dc43e0a4DPU5ieohphvvv4PiYx9Ggl+9zBd5FZhVpq8bG91x2pQxmr+ssWTdChNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGY3u7zO+pGvl5JJqmjXHuv6YVHyYlM+a3+QwvODDEo=;
 b=IvZJKnoE4D0LoYl9tdAz3jSIpKQ7dH+e5mXofDDiRKX/VAa/O66tvN87OXrB+BcD62+YdBNgAEwxhpHxc6czgC62hMmOPQP3PmMDNPXXrv8uwOICZwjUI1WCRF6148eMXR3ZeEnBNqqSFd7//FtI59oFeG3cYzU9mNn4G4Q3AS4zq8lC2oZxKM+Qnkz8O+EFVNq5HZAJJQCpO/kCoJTAFNONsJMrKJ1EsKbfe7B51m6XGWrXYgljipNc0tUcow1Rs8Czb/LKFUp0AcYOn4g6JKzS+rkXaGwG9QwAq581WQidPjfE7FunsG2NtjDV3h6wE4VrOdsPCxaDvKFE6o3MUA==
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 15:01:54 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::9) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24 via Frontend
 Transport; Mon, 28 Oct 2024 15:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 15:01:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 08:01:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 08:01:28 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 08:01:26 -0700
Date: Mon, 28 Oct 2024 08:01:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <Zx+nRJrlmAD/7H8w@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
 <CABQgh9EgXsyHDzZHK2FMuUw-eu9zeczyMGLTUjS3AKYUHKwwDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9EgXsyHDzZHK2FMuUw-eu9zeczyMGLTUjS3AKYUHKwwDg@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5a494b-d0c5-4ef4-a667-08dcf76175d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jIeIy7r0EuhMQlSmnvUTsz+nH/Prqr5ia26uaD+RXVigo868XhVJs828iJjh?=
 =?us-ascii?Q?MjWTsxzb4/qtDJ6YsCpX5eIkKR7ucMGeEoeyUAmi3sIHi1+/Aaorc5Q78pGD?=
 =?us-ascii?Q?U/9vQMBH9VD/6uRnfwv8hbaLLNkCSSTI1jxHURzmbQQ0U0xR1220zRDT/y34?=
 =?us-ascii?Q?byrU5vOJPEEERrrBtgqhBzuRN2ubliPy6tQOhXEVq7AvCI2WmOP6n8f5fp61?=
 =?us-ascii?Q?x8+EOKeAJfQ+rlGrBRGyZdCVukeTsXsSKbRbY+ZiweJcDrLEjZgB4MloqiUB?=
 =?us-ascii?Q?z1f0Kk/bclVrG6QEg1kAdfO89zuIFDubMjd0l3ac9tDWeJP7l9Ut7U9ZY+5S?=
 =?us-ascii?Q?WiKvMg/fMh5NBheBL0e/Cyrf+24JH1jGtgn1GmfAQ5Mt9/cIkWZP4xlgifvw?=
 =?us-ascii?Q?7cty7I/CDRJpWDf8sanfhR1NUSsB0NTOF1IDQQgD5ELeHKJtPM0ITf+/GyJj?=
 =?us-ascii?Q?hARd9xMkMGqUSxhC4hquhcaFfqHcNy/zy8a4EGSOVmtijpiiHw9HGRfwlZgS?=
 =?us-ascii?Q?JOzfrpZlvIReljMKFTuoombWA1GmwOQJYz+Oa4x41V5bSwHwOw5+pbPMimEM?=
 =?us-ascii?Q?kosLfi3twmjBThXuHPggiKl7VL4V1lCFfcRnYEe4PwdQXpHpQufhyLPJQUUb?=
 =?us-ascii?Q?NaUxpw5NJTx03QCb6oWRUtrQnDWPfkUhy11iOa2vy+Hf+UHD4Hz23BC0ayTj?=
 =?us-ascii?Q?dLZ+Dcqri1CBu7WyZz0JfAZfXfo4vrXyJQFsugaKdZHDHvgH/uFNotc+jpC8?=
 =?us-ascii?Q?4PM+Z3UzTWizsR1X9J3zAYrtap+7ORPcq7VhcyE8AZb1etY/wDRzY2KkcMK4?=
 =?us-ascii?Q?KjRQDieoqkjMtkm0LXD4m3xpNtvM5kuvAlYrqgJV/8mq+/d93OFptWyqbOQA?=
 =?us-ascii?Q?EFcJZtUiX+vhvoMbMvsz5pRmvldzukNni22VBqx+vPq/wrxzhP6RVDDnw2gx?=
 =?us-ascii?Q?v/1jM0e/3kcxipZwy2HAbHteQ0hdij8hcOWBb/JdWbQ7ox1xiFeMvKVLQ1xn?=
 =?us-ascii?Q?IPQgmkU4STSawAgcHCQ/HmDgqQAz2iAKLV13yAEFiNAtzdf5fhNMwrfKcydl?=
 =?us-ascii?Q?Pv8zGkbnn54Qix6aofBMiWGmXZIbyVQri8Z1ELRnrimxIf7Z4/B/gMOiUoIe?=
 =?us-ascii?Q?wH+BVUI6CTADj5M28myipJ0MTFXPrIwQH/UHsT+jGQ7I6UU3powWZmfWf0K1?=
 =?us-ascii?Q?MePAPHHrMsROsJ2/QJf6/439pKGp3feNYvPKatSZbuddiRP6OOPJkdmHrNUc?=
 =?us-ascii?Q?JiDcjuBmneURtQEcJwymO+UtXk60g/okj+hav7UAcjp0wFWATTgUpW4rVTH1?=
 =?us-ascii?Q?CdwT22THWkH+4ybg/s2hYAqCoRDX7NdUdkFQhBKjg+iS/iB0t2ODHNDetg4C?=
 =?us-ascii?Q?HIDNpl8X1nqgURz3jxstRauHAMR6qPc95GNzPen2EGG0YkwmYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:01:53.8898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a494b-d0c5-4ef4-a667-08dcf76175d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

On Mon, Oct 28, 2024 at 10:53:38PM +0800, Zhangfei Gao wrote:
> On Mon, 28 Oct 2024 at 11:24, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> 
> > By the way, has qemu changed compared with v3?
> > I still got a hardware error in this version, in check
> 
> Found iommufd_viommu_p2-v5 misses some patches,
> Simply tested ok with iommufd_viommu_p2-v5-with-rmr, (with some hacks)

I see. I put those RMR patches on top of Part-1&2 in v5, v.s.
Part-1&2 rebasing on RMR patches.

Thanks for testing!

Nicolin

