Return-Path: <linux-kselftest+bounces-33095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2BAB8D54
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B7A1BC30E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75925486D;
	Thu, 15 May 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ffNDHrXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BF25484B;
	Thu, 15 May 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329250; cv=fail; b=kD1XyHozseDXMJ4lompxlqGulU5X3PFRG6Rftw3vTTEKeCbo9PrrMxFtYxr0y8VMCUMy0SlM8IyB/TlhfqYaFwc6xTv6JF4hxK3kXWPTnipwcGdpuhbocgWgv7Hwdl0Gk9TpjxWAweH2R5gMm5pBdCPcFtii/ZhOIIn14COEbcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329250; c=relaxed/simple;
	bh=vF0a8bAIpG9WsWT7z6+V9S5TVykEbFSUmDnmQAAOcEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFG+iUUgnfffwJkmWcUuPeB86bYxEzDOIihqOxh1Pr9iAkyCJBv1LLrh32c/4e48jBt1hg0anvy4d7ohQYYVTIoGmLSaLaeNCrY2N05jDLmJZ2mcUNEpDpdm/kkb1KMSivGKXFX2OGl6v449hLosGjNS5KEwaUK/27TmOuac/d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ffNDHrXm; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF4f1NEgvWbpxEnQHvyqwv6MRqI7IAX91iz3BELi4TCsKQue+IKhCn0HhSKaUGeNeBWDT4/mpyC+6qDaR0mx+9opDvu1RJAmRO9INLrgdpeJOsXC5WU0UG7Ye57NHSxv3qclL0nu/gRJxx5sx4QsFldH9n5qfMt+hbodtgaB9YktyM/0VDbVxJ7pAjfwvKCyLBrP5Ihlltap0zLGypCkxIlIx7gSOVJFwvNBtiltVk/RNyHgAgpytcjef4o59lsOlh+7TV8FeaOblcC4dEvPhTV/2XCthNacNNY6A1f016igNE8ItMJTyV+WvZCeAAzLdjlcxeoXr92/8UnwirCddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0htuODCxwQaSqKrOOplOfFgjHpB+jL0anVSEOeXxe94=;
 b=duRh3JGjN+vJD2kNPXrwng21Bkvg70ddQ9V4iMEx6ul2bFe2NbIj5sFUMiTgChgjxONFvaxgpgwgjlmswUAr8c+0IoRwhivosrCcfxZD+m7UrbPErkCsUS953XtYbltY5mnu8UkECIBkmeuEmP69MQgtlCxFkYVlVJeVvgO2VsNhNJgvKFoK1r+MImBlkyu2wfYjhz0tRHNpaOxNP0z9YRYcUKCJJ1jXMSpMUqp/i7z4zumpWoc1IBi+UNYqWtwaXmtz4AWnI6AY2YT89b/MHLpFk9YoAkHOy2f1rfei2IX2wdNcFGHMpWWNLbtkux3X1H8p4KHzznMZBOTfGpFRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0htuODCxwQaSqKrOOplOfFgjHpB+jL0anVSEOeXxe94=;
 b=ffNDHrXm+KepgQXz+R7mHIts3ohJv5rLVhIkkZReGGWXCvLorJFu2OUg5TA4iaLA11BPjGvo0JWMfgsZAaoJx4MWQTDSKL4CrAdq4mP1HE618IV4lS0/i46tXb8y02JV1yTPTRomZ2kmd4ODsfUtp2V5yPoo4RvMVlTNp0T/FXIpSXIIVA4/zOkfSLEvUhUR6stssag4QWjgl9UK/B9tXUV55Zhi4LuzRSdTXB9/YTHZYV+0aUJ4Owa+ZmZuWBA4lrixjTenbOOYeB5DN+FD0o/YNkBuEpJDuSY4lqw5VhfLNpVz64Bj2RldtWt9/apbSAF1teu7zZejs5tvzMfrcA==
Received: from DS7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::15) by
 PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 17:14:03 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::70) by DS7P220CA0047.outlook.office365.com
 (2603:10b6:8:224::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Thu,
 15 May 2025 17:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 17:14:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 10:13:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 10:13:49 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 10:13:48 -0700
Date: Thu, 15 May 2025 10:13:47 -0700
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
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aCYgyyHwJsQvLLOo@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D8FF50750CF35D0DF1838C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D8FF50750CF35D0DF1838C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b472a8-fcca-478f-d2ec-08dd93d3e3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VimaEpP0BHSC/IdKI1P9h+l4afvdsOWioE+6YIfomU6n54qXP7UxHMWg8bNZ?=
 =?us-ascii?Q?39d1m5jM0zi4KDqvcDfCNh1M5SK1m27YBu+HruWWyGxR8DCqTeZBypf2pLc/?=
 =?us-ascii?Q?oBa/XnrhD7b9pIsM5dv70lmvqufqcgkJtZb/EoJ4yPzY+I6kBLXp35GGpfCc?=
 =?us-ascii?Q?5n17qGxOvXT+5wF1PTcfLxcju8HxAiyCoZA4XJ/GMyCojh5EzplMg9gnnNoa?=
 =?us-ascii?Q?59CXT7MMPWviOAtwWfVDA//6a+JaRG9JjFaWmqWwlG/QI94kV7roUlHlFXbx?=
 =?us-ascii?Q?5AVZzNENtr1jy6SvWJMh6Nc02G5TElUJr0G0px14BtlTYrJnJhh4p+jciCMV?=
 =?us-ascii?Q?ah/BkXq0O9ZWIWFrHDKtWXM4fYSZvyw2J2y+4H0V1D4CMNpuY4K+ciXf2Gfu?=
 =?us-ascii?Q?sMrSHoUdH6IN6u/Fye7MIPPT8Vs9XmukuH+EQohEmGjLX3560eSdiWLj82t4?=
 =?us-ascii?Q?VBkSYGTLk73kh2UhohC3O+xVuCRHJQzXohdHiTs4ipI2hSpEwNG49hL5IHv8?=
 =?us-ascii?Q?qKdBheALSDWLrT7BHWqRae3Z1QqKIY/dlfh7SvoH9+KZgAVt4Uld/6HAd+Lw?=
 =?us-ascii?Q?1gL+dWjXgvDaq25QNU3GWOrw2GDUTVYoKst/ok5X7OBPB9gsVfd1BYb+ykRg?=
 =?us-ascii?Q?PqcLMcer8x05l+jQG7lKeD5M1rTJEoRQS30n1LaRtTaZv0h0K0rDzDPyUCwa?=
 =?us-ascii?Q?QBMjWKlD2ZYxgD97rOsnstbz4z9Pf5fW+eMfuMhUPWLk9HEdne+vim9aunW7?=
 =?us-ascii?Q?hvqSg7A47gJbAw8d4WmfkqFE6VFpAG9CUk7s0NQoL7Gx/Q4VSyu9+WawWpCa?=
 =?us-ascii?Q?ibmV87atQTEWwyxM85glDlcK0BNM0DO5dxf/6srlaKQ3UIYcrNN+LS51K5xz?=
 =?us-ascii?Q?ESyou4TNuYWSaz2ZqfBp4w5ylU5YNYUulycktuXGGXx23DMDcsiSnk+1Sqa8?=
 =?us-ascii?Q?wPRulQzHEi8wLfxMD/QaoEvEZZrOiypd7dqcXIuE0ogxCGq8xOrHDwFTXmN9?=
 =?us-ascii?Q?ryKuQgoMUaY8njbEXUwT46mlJBs3ibfbpXAuYWnucPZAJEcJ7bUgz34KtsVa?=
 =?us-ascii?Q?WlyDhZYTgrML6SeIPpZSubxJoSGaZGwWmtunE3iMIA7ioao4cV1e6ofh2lIo?=
 =?us-ascii?Q?1DlqU5x5uYfZqmjm2KrPb/qWCVLvAbH65nuxHHVnlVKSbPvRQc13MdBKTDM+?=
 =?us-ascii?Q?4INXQm4FMwMEjcfz6EG2d0YqAlaqEh7F/KGyhzE6qLL/EndFkUnaqXZxVXWS?=
 =?us-ascii?Q?jog+fF9gOuWs+Im2gq6xH1veLTbja7fLf/oheX3Bav65+8fRva9D5g4SyJex?=
 =?us-ascii?Q?EQVNTOqxTqV0OaRuWxGKRbxne4wI+7oUgRwabXbewrEqjFBg0p7iZTFMNyTa?=
 =?us-ascii?Q?t7x8yoXApI74+kdq6K5WKgHBovzj5AH9AK0s2G22LdOmgORmYXv9rcu5Phmk?=
 =?us-ascii?Q?wUghI1sjEci3VLuMLxla04sAdVVWSMfYeSr8V8JftOKqwUqKhhWgRi+1/AQz?=
 =?us-ascii?Q?q0JfueCskFRq8UXImgraxXfcskPm2s0D6x5H?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:14:02.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b472a8-fcca-478f-d2ec-08dd93d3e3f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040

On Thu, May 15, 2025 at 08:27:17AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:03 AM
> > 
> >  /**
> >   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware
> > information
> >   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> >   *
> > - * @flags: Must be set to 0
> > - * @impl: Must be 0
> > + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> > + * @impl: Implementation-defined bits when the following flags are set:
> > + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> > + *          Bits[15:12] - Log2 of the total number of SID replacements
> > + *          Bits[11:08] - Log2 of the total number of VINTFs per vIOMMU
> > + *          Bits[07:04] - Log2 of the total number of VCMDQs per vIOMMU
> > + *          Bits[03:00] - Version number for the CMDQ-V HW
> 
> hmm throughout this series I drew an equation between VINTF
> and vIOMMU. Not sure how multiple VINTFs can be represented
> w/o introducing more objects. Do we want to keep such info here?

You are right that VINTF=vIOMMU. This is a per SMMU instance ioctl.
So, each VM should only have one VTINF/vIOMMU per SMMU instance.

For multi-VINTF (multi-vIOMMU) case, there needs to be more SMMUs
backing passthrough devices being assigned to the VM.

What exactly the concern of keeping this info here?

> > +	 * - suggest to back the queue memory with contiguous physical
> > pages or
> > +	 *   a single huge page with alignment of the queue size, limit
> > vSMMU's
> > +	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
> > +	 */
> > +	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
> 
> Not sure about the last sentence. 'limit' refers to a certain action
> which the user should perform?

Yes, set vSMMU's IDR1.CMDQS field up to the huge page size divided by
16 bytes, e.g. if using one 2MB huge page backing the queue memory,
VMM should set IDR1.CMDQS no higher than 17:
	2MB = (1 << 17) * 16B

Certainly, it can set to lower than 17. So it's an upper "limit".

Or any better word in your mind that can be less confusing?

> > +
> > +	ret = tegra241_vintf_init_lvcmdq(vintf, lidx, vcmdq);
> > +	if (ret)
> > +		goto undepend_vcmdq;
> > +
> > +	dev_dbg(cmdqv->dev, "%sallocated\n",
> > +		lvcmdq_error_header(vcmdq, header, 64));
> > +
> > +	tegra241_vcmdq_map_lvcmdq(vcmdq);
> > +
> > +	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
> > +	vcmdq->cmdq.q.q_base |= log2size;
> > +
> > +	ret = tegra241_vcmdq_hw_init_user(vcmdq);
> > +	if (ret)
> > +		goto unmap_lvcmdq;
> > +	vintf->lvcmdqs[lidx] = vcmdq;
> 
> this is already done in tegra241_vintf_init_lvcmdq().

Oh, will drop that.

Thanks
Nicolin

