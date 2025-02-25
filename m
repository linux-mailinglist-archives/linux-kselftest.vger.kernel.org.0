Return-Path: <linux-kselftest+bounces-27471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92140A44498
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348D919C2FBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBD140E3C;
	Tue, 25 Feb 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIPyvfFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715C1624D4;
	Tue, 25 Feb 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498051; cv=fail; b=FULb5zOZIGK3Wl7oqdOqcUAcZ3H0+DYnTe/rczrwwr8BC1U3EHKrtq10zwuVoJS4L4Jt47uekVLlaFysZV1CMau+q1lSR05dOkn6zuiLpB2uyzTOKbogq2P1XmKEoJs2F6CeLK8sJt/3AxrCZCKThgLAZEk3oKoaC9g4y0ySdIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498051; c=relaxed/simple;
	bh=4OKh9uGfZic8JbYWirvwVSaBm87HKeJv7Avf4BHQiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+Tqvo5jc/V6FMUYWzXIHsI6Hs+trJVP79aFy3HnurMgmJh82oVeWCgFEFzM7wi58oLS1pbb/EfDpCydeXdTLYUm1vbUZnjeODVjoUu8mcExCou9K8BqZ/Eq28LxC3CpDVwlD+jt4AB+6Dsfev6Xb6hXXjlBzbYrlHu/Scw9NBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIPyvfFQ; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5Y0NYKJpg0MtZZZOWcxymb/R5050SlJf3AEkrIxqO7lIw+d/VZrnl4WE/N+4Ms6lM7uaW67Sg0g3mj4KII+vn+ESDzhGuR8H387v5CE5HSqD3nmzfPyFRi5iLXU5JtVpSNf7KO7baY9hrzYMQx929pJ7d2QHDB4a59ns6AiOwnJeAFq+vxtIKV0uDZo0rEKMAbcvgc9rGnOgVTNTjuQmckB6zYHg4LVkWO3EUzJdgpDJ8ahjt48KHH5x12kg+m9d6hUZHKF60BB96bH0Dn+fDKM2nKGPk59tX2qnyLbK6YT7MVqxGmorMh4X/6BiTyuep43bKwA6cDRxfEw0SjKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QJpbXtYH1V+yPjnUBqref1WfYMVCe1nSr+FrmCq7a4=;
 b=A4dn85oc82jVOyr/5q0oWAyXtKFc3vUNaTO4PPaoEy4MTbY3d5QfaKsQb3xy+6f8EMeN4lWt4e9sqlLeQ9bW5lH/oCJ016V/m0313f2ckev325sNCF5MUI/+d+c7GDtPtf5e9rtuuyrEGqwH/vYsHjhlQlgkD7ptGr3o/ukubmgcxM397Dig6GXIDlTvU85ylHP3SanoCoYlh6iiBSrRbIyQj248PHgx1oWbf+DcnptoyckJ5KXe2Vacdl7e6GcSnFDaBGRMUxGQQVY/qqTarv7w6Nsj8wDyoBT/B53Z+IiVvAEYPA3MQ9bNMOKqtgxmjYilnWUxtC791hFht6dRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QJpbXtYH1V+yPjnUBqref1WfYMVCe1nSr+FrmCq7a4=;
 b=SIPyvfFQNnaz2dFHVFvWH57530NpqoQF7sYkKnRKM0mFxbCeCjl3oUgdQB/TFGtZOJrtmfetCbYkCpLm+cagCYcF12U7iNdGfBSaifpD3UuQeOUpmtdY41GFHoHXDInzHGdrBMiw1p+2Itr6MSfTWIL93wtmSe03XZ3WivPmkxnVnsvWC2Mwm/tf0kMi+R+tUOKCBSzdD1I63SuxaCMFZOMfG3lbjUBmkStSsh6RpRoKW8phgDXLw+pzmdbP9750jl15IhxRIQposhQzRwtjiUTs0cQL0L4jK0KwnpjkU5HdOrbQdg/vb5Ej6spfkSzKYYgPYfpMYXBAjmgZixckzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:40:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:40:46 +0000
Date: Tue, 25 Feb 2025 11:40:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v7 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250225154045.GC587949@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <c1d6974f3e61fdf94ca43ec5e3e6abcef97d31fc.1740238876.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d6974f3e61fdf94ca43ec5e3e6abcef97d31fc.1740238876.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 136cd658-81ef-4ff0-cc47-08dd55b2c57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFJgkST04p5PtWEnkQTreZREvZF+9fal27B5Xas/Mqmc8+Qgey6DSh/8QfBH?=
 =?us-ascii?Q?mlssRqQRcB/jo2+YpqLkcuqDgYOw+Od49VLpdvT7qXybWCjMO58KGSisuFej?=
 =?us-ascii?Q?XDu6w7BXx+3APjH4gfJk2JVdjiPzEDnppS2g5ljKqw1mViImpryCxlaGCsvH?=
 =?us-ascii?Q?K9v2iLyR+s2rjXm5mnd798SHNXkiD7WABbcAB1QIHjADRus+hmyvgfyhTSE8?=
 =?us-ascii?Q?IbAEap4KrB4ZahWOzcMDDWDB2gNNyARYcW7VtRNwgQIGsM+EvjGmPtlvEiwG?=
 =?us-ascii?Q?UuS+enbtsYWj6Lk+bPh6i6aAFlz9ODBPmxizEhAQhxVI6scLjsp8SMuCM44f?=
 =?us-ascii?Q?OFV5nP96sV2TTzZa+me6WxOd7zdW/9T6mZ1duRXIE3ZQEWbPzWKMQWY2Qgvc?=
 =?us-ascii?Q?qoW5tfyE8XIJQr0HBZMCi967BSAsw2Q5eMmynf7FodCxQYbqB2WQO3djVX7E?=
 =?us-ascii?Q?OQ872r/4fCvdrNVNlw/tD0YUk7jSOtGLmB0+miuFNGxdurUdNCEwg8LM+QqG?=
 =?us-ascii?Q?fBKPgs98G2Px/l9xrzFYKt0cOu5B2ah/5ABjKDOPrUCpk7Q/GXpRl0WCl38L?=
 =?us-ascii?Q?gJ2mlMtjx/O4kDAD1IBfEHvhtwYgIDYyOpK4+E0tkWSMsuNL0tn0TqvZL13f?=
 =?us-ascii?Q?/cSU0yNH6+21mDRAb1BHPWDQ3cQwyviypieMnFzQFYPmreSb/Av6gbJlngnP?=
 =?us-ascii?Q?Bvc/AQaVVz6vJaoFZa1A7Uh+XKFJFiynja8vMzZcLfXQKutU3zxkQ/rcVhfr?=
 =?us-ascii?Q?ExXqfgaHf9F3tMDoYjRLV2QFkGVJOo9pY+Eb10zq3yVqHB+zbmdzNUES2VgL?=
 =?us-ascii?Q?mXGrVs0Null9SrYWt2EqRl5IFy9i0opmOpmsTs6MAXM8AzYuRxiIPYumtoOI?=
 =?us-ascii?Q?2lK80l7gOoDkrhrMk1nvOg3v/BJDQgYCHsKjsBED4/QoEcKW53b63aOMRX9q?=
 =?us-ascii?Q?HneDTWCMYvfzbQglMXo1qLn0JasdKIz52a5zCPxqKcqFdcgC6eEpWjtpAGgF?=
 =?us-ascii?Q?3iaQBKM2jIMcqC8SEMeHwE+nSDglInfcepNWUPGY0YkGa7TlZkI7jQENBTln?=
 =?us-ascii?Q?KRq1Ry+214BNGunJOwQdaXbJs4ZDv2hR0CUiZINOCbuyOBOhZuaMVMLcHST8?=
 =?us-ascii?Q?XOSg5QNiebS+g2KeUlMnEZouzuZ6Yg4lWeytDcz42XYmz8NY/EQdwF5OarMA?=
 =?us-ascii?Q?FPs2mNM44qy76MDKEYz3SiZ+DMaFsoSZt5k99vticW8+VfLEeHvEH+VIIjZS?=
 =?us-ascii?Q?J6jT+/ffxfxH+bWH9j+2h7aar1Lf4ZVMrl6v9L7DHge3v/QBw4hcToWqx7kO?=
 =?us-ascii?Q?6p9V8+ScdO5x+otjUJxB6+iWvcyVvJvIXH+gYZ/dVibkwcRB3rKVyQUyNUPB?=
 =?us-ascii?Q?1cCeJx7UtsbS95f6ASSrE0GVC1q4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdVrtNsrvsnIDv3cZDS6MZ26zRpgIq1pUax1Fy+EXRg8+tjas7tOBoTPQAKu?=
 =?us-ascii?Q?BKPthgxKSvLsGjLCCfiTB5VaQQ+gTkE/6HHN23VTUh9jg3+T2iynfD+KpOmU?=
 =?us-ascii?Q?ESQz9KEKn8Yw48LWJakJk1MYrJjn37dQbknkCNyD7D0HUhLaUsRPWb3zMNts?=
 =?us-ascii?Q?PZCts1jnYbsFMfb6e6S3jQRXclelno1jR9eRDV9PY7UjHlGwLC5RJrCKUlLE?=
 =?us-ascii?Q?WAwx2z1UXimKUeOWuFWCCeaBodYVStjnrBlsT9/ZLrn3d2ncjjqDQCbThGCY?=
 =?us-ascii?Q?BZbv050P0Q1+mBVCApd/wmMq93m02POT1XX5uQ4GmauCNuLy5JpyrSU//TrB?=
 =?us-ascii?Q?CYz5TmZuTE7TAjo76/1Ie83PSxRnjdHgR7OjNC8/p8IMj/oLogNS8/3wi0A3?=
 =?us-ascii?Q?7LXTb0GKLvCJCXag56qZ0f8NodMmWWzWtOtqQH7wyhzAWBPkvspOZmzigVOR?=
 =?us-ascii?Q?etYfloRAMtNfFp0+E5T8eNF8B04Bo+8qgH//1dTt3GOX6doGAzU7s1n8TKjb?=
 =?us-ascii?Q?zIhsRY1r1u2R5AoI33nOQ4L4wIjGax9Z6UdrDGEsqneG/WXJj5aDuh65iuMS?=
 =?us-ascii?Q?EaufMY6JSqPtSrvl+c+kmaXznhCZHd+86/MKnhgSaU5yY0VK/mWs9YW5ZOqy?=
 =?us-ascii?Q?PvDdoSJMU7j9jo/IDgIeF3vjR/MKwzxMsSGk0w2B5qdy1e6zmgma9Z/Tl7rj?=
 =?us-ascii?Q?DW/u4AofjkFrGGYlxc94FohFKgn9TV+KoZulg1USZaOd4cHASGPjUi3Qcgdr?=
 =?us-ascii?Q?MaoOzhclslvIYwDpd7b9e4bNoivNlrkYfj4gYuSSX/03O9MBBlDwZjLmcQb2?=
 =?us-ascii?Q?GZYNygzmJBksrruJzkygFpGNaoIQHzDulfy92wcx/kg8Bdtqm671QHnjxjv7?=
 =?us-ascii?Q?7uLY/qGSdU+BGlfsJG7oPzICeD4wbEqng1lmQ7EByt39ODvGRpWrP7T3co/F?=
 =?us-ascii?Q?4jQFUvJZFlKKzhCP1YnwQNK3E71LHlkCXw2o7ZJj/SAILkZk2+AsYVzAF+IW?=
 =?us-ascii?Q?Ousil0C+I6RU7rDu6CRaV9ydmVzzPmjQph4nwPFtRglWIdIOEwZ9oObsxVhr?=
 =?us-ascii?Q?HKljkiyBIILgrdy7Iapr6aOVfJNDFPQ7TJNqsQQ1BLOD5L3o/3PQ/v0dpbA2?=
 =?us-ascii?Q?A0R9T2ow82aaffSzMv+F9myEO8V3SxIFnsIiVTEXibV7y50A4f2VrrCqw4dI?=
 =?us-ascii?Q?QlfSPJmgO6VI8dWRDm3PY2+6anP6WWcdf6phYcn/2B4vrKW2JM0nkd1JF5/z?=
 =?us-ascii?Q?SiCK/BiBL5Q8VebbvZ2I8hYqODcEyWV2WtFBVYkg4Ro2en7unCvWW0ASNcqz?=
 =?us-ascii?Q?31GiojutHAIFVAC6z9yJBDFGaIzy6eMy9FV2ALzDpPsuoZdI7VyKZBHPZZTa?=
 =?us-ascii?Q?GnKKHRoy3e/nZW7PLdl1NQCZVnpz2jt6q/oYaUgm1u0QBTL8yjSg5TXHhDil?=
 =?us-ascii?Q?m5Fi1jSlH3xzsbh94ChxVtu0S+r9KpTbl0nGJjj0Ipiu1uH2tNZtxwp3E90k?=
 =?us-ascii?Q?qdLbdLxyZ2h2PtTtZR0mrflu508lntrciLvbkZqrKbI4ZOQqcIgI1k34l0xl?=
 =?us-ascii?Q?weS9N2OIcCfgkt1WB7Nd8T9eiXt3zMtHP2ZkPBHz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136cd658-81ef-4ff0-cc47-08dd55b2c57f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:40:46.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR7iHwm3ejiTpiZPboJmfN/hP3VyRCAE0bHZZXJaxH6Vtoc0+9gvKY7briORjBUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

On Sat, Feb 22, 2025 at 07:54:04AM -0800, Nicolin Chen wrote:
> Similar to iommu_report_device_fault, this allows IOMMU drivers to report
> vIOMMU events from threaded IRQ handlers to user space hypervisors.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h        | 11 ++++++++
>  drivers/iommu/iommufd/driver.c | 48 ++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

