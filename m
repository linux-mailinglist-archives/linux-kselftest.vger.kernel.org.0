Return-Path: <linux-kselftest+bounces-23282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35F9EFE52
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F6A188D474
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973371D6182;
	Thu, 12 Dec 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNOwBxMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851619995A;
	Thu, 12 Dec 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039288; cv=fail; b=q52ctvWUBUFzYENlt1dTCGrjuVAUGYROTFmdLN/BEW14Oaq0bYBkzT6GpecBasWvPG4eS9Z0/LbzsUZ1n7rlPH4YQXCSQXcij3l/8NpLurkMBVGRnoALtiK6XcuK+L87vAJmGlxwWsfaRtKAq6aLMdFqCHKNIjUUMK3cyFe2DNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039288; c=relaxed/simple;
	bh=kZSnkVcdF7n7TI5iqWi1ivQVmRSoKJ0moKjHVE9VZCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSsCl6/HoRIxQU8Xov8oi6lMkl0Bb4pfPnCKBwWvaaNyLf8jRpriS9R4xGq1kfguUk+FsGy+2B3MB7rG4NibBa6wx7TK809rSOBfIg5m6Ak97FEVNxnuapnwPQSvex+/1npR6fprjErfDFvveZ6yb3FcIfag2+LIVE9FEECqeM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNOwBxMj; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNQXWE6eoTHuGggOcq9luL6UWDtAA0T9Cdf26IDmolEvF+2VVvqIk+lE98SWMdnfvM3iNAnkWYj783cTItVbHRSFm+kJNf6rJY+JfGdsNB0FaInyx/fypEiFbkneDLzxn6GdiikSmu2IOE8l27qoGuAjVPP789v2kEjeDgEMuSR22Sfgeovzmt9iBP3m4tsuphur45W3cmKGlza9I+Cqe4knAvwNDUXLZ+O9FxEfhtl4qqRfvFSUmKeBAK7yPlZreJRS0MPFLtmHV+V6M8i3nbDGqIWFE4o7rvWjF92P5cK7PiE/QN+Q3NkNd2PYJmz1YIPFCw44Q6Fi9k1xXsv0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsKSQWxOHwDmr+lT7KbIv4f3GMmduVmZ5AzWsdOOyiA=;
 b=kORB2E3gIZ8J2GRAJ2f0/cprntgP1mKtcwouObpltT1v/5/X1TMNm5FVnPbPHVapHyF4gQN7vFQVa25ZTiMnwBiOSju8iBWYQoM7nWT+y/XOnx2OAUJg70D9dquB9+aWmSso22JgVTRV3BNTcgxp9fAjjnOM8YQ0lm113wMMyE1M4JQGuO+V70mX8NSN5t+nS4bDtsLJ/hA/L7reNysRwaUws4rVh55BZmt7lt1jY53b04xHBcGyINvbYw5tVMqdrQMyGD4r4LNKmnSqzCiYk7DhnW9A/HqZxm0xKxF5GlxYpOMOZUq6YxgbQUiVRw8+kuiqJ7o54/3Mns6GwNsWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsKSQWxOHwDmr+lT7KbIv4f3GMmduVmZ5AzWsdOOyiA=;
 b=eNOwBxMjGq4dpHmUrXxOvlkZjCiKlr1CVwmm0uBXB4p7yYeWm9f/ipPEAILHJwv0cF5OBI45neIWSdLKO5skRwpOusVsmpmQ3zA37G2druHTcSQppK3ZXfqgmemyGwrrB6Y1/UQ3vCKx//l3Lrg5zycxJXI7bN9Azq+rsMfHIkzAqFFLXpWuyObrSHFierbS6GzM8h7+L8+ueCGmf6aVEui8Y1GwSYvft+Bh9HJGwWvV4ydviTrBFDjG3mJ1xBrhKd58uyCXeJjFL9fi0r7bUJMCwb+f1C5EmO1JtyGo/sVa3+Cct7u08L0/AEarixKOIgX0VwAHA6zkK/kvnk02eA==
Received: from CY8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:930:4d::20)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:34:42 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::cc) by CY8PR02CA0023.outlook.office365.com
 (2603:10b6:930:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Thu,
 12 Dec 2024 21:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:34:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:34:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:34:25 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:34:23 -0800
Date: Thu, 12 Dec 2024 13:34:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 13/13] iommu/arm-smmu-v3: Report IRQs that belong to
 devices attached to vIOMMU
Message-ID: <Z1tW3sZgrJfUzP1e@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <d335936fdeccfcf785589800b7e5d9b1b26a766d.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB5276EE81D21EC5E4156EB7D58C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EE81D21EC5E4156EB7D58C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 736a520e-7795-43a1-d632-08dd1af4ca40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdPGD0q/AXzsKfEGb0EIjAxRmusBr2P1fuf1KdCxdHLLvCUcCzCAW8c6c2XS?=
 =?us-ascii?Q?SRoNQFaGpoKc1J9yShxmjdcyXsZXedojRDjJB1bgA7ANwR/AgQnhb05icXmV?=
 =?us-ascii?Q?JDbH8L+xbH8JfWgxB/JbAHVHrP/0Ivq4ynflYvJPfcuCsr/uxSm2WnxhZlv6?=
 =?us-ascii?Q?+TPnh2EozgFEgCYPbykOx+D3O+W0DeZkPbj7Rqfb0kO+B+sdqF8zYktSVyZ9?=
 =?us-ascii?Q?u0ahDVebsWnk0nuY0Oz09XvXJ3hq+Ivdop/7nu352DDVGUJjbVzWeUydPEu6?=
 =?us-ascii?Q?7FXql9RdsvyXgyJjTA+n18noT/qVvrJONwJvBM86AM6ssqqyEGaUQVfdoh1w?=
 =?us-ascii?Q?9c8AIU2WttMCgTexpHF7W3uPrbbe+DjRDaL+i2e2tu/UDEaHVN6pJju/PcFy?=
 =?us-ascii?Q?NP2BcggPylFryEAExno/jZwDukOkmWTCcqc73rJKK+iwsMNsqp6zyagIhh9H?=
 =?us-ascii?Q?U/jRaRVdj1MnfyJB8S80uSfUXDfsclk054Nb3G4UULT3GBv0Xz8nTGPbkv/5?=
 =?us-ascii?Q?W3hSCZKaMlV0Mu3rba40N2VSahUiWA0Pua39ipLVYpKrCKi8JRixMua2UOqG?=
 =?us-ascii?Q?7z6MZoH9eSdFH55wcy5l9Fnvjzobnb77k3/lIsS3+MWwW6ZktDse2kJYb+GP?=
 =?us-ascii?Q?3QZ2HtcJYnx2DGEAqOpWVimruDVBpZRXW4dF7Ty5f4alepUbVjUzk/aDfY70?=
 =?us-ascii?Q?NW/2jhIlXgxl0KUgXA97F1kHpd261Zeh9K0tIn1N9aw7k2jm/dFRiwic5idQ?=
 =?us-ascii?Q?lFXsuPSECgdZkAAnrtamHbPSSkdqpL/7eXwgR66SonZhYy5lxUskoggb2vhy?=
 =?us-ascii?Q?aV1qxaDDP565lKVlAlFELaws+Cr4udLWa3JXNTOnDjS/Op71hI+YPuVL7WMA?=
 =?us-ascii?Q?xLUJcQGqvVSX3T/tLfXbPqKbNwFkvwuw/QKo+uwBhI97sh5jbSLZqc2ynxJe?=
 =?us-ascii?Q?z5LFInyNYzBgIsWE87xUT5Jp3+Oz4RFJh0dhCIG09J+J3Qg91OfcS7H/1jgf?=
 =?us-ascii?Q?umfir4M8MyaFxLZtIUGdiaNPCrj4+UEpxobevx07sywxIuyTJ33n/vFC4TW8?=
 =?us-ascii?Q?sJUff3z67jTekDYbaz0nqc1BgAu/T1vmv+GiIZyO79Hy+UJibBmDCtopeVYB?=
 =?us-ascii?Q?UtTRfctTWZ+Xu48pl5srnjD3wDn395DBW26avZZlfjYMMOe0EaBGC/PSiT2v?=
 =?us-ascii?Q?c4qpIoQm4Zw+nEtiuVjdeF0zki2SvmruZ4hmMcONpCZdlb7Th4z1+AA6y8En?=
 =?us-ascii?Q?uwzR6RNt4quiVEX6mQUXGvDZZm3kVDDOklTM81R3nJ9FpJGJJd/w7CvNGs/a?=
 =?us-ascii?Q?JLY1SqiRZSVSrP1Z+iv1hD67G741MYZxF6MyHAqBiXQRb+RcTcsse8aJVE04?=
 =?us-ascii?Q?czEBpJPMkzKfGiRKYyXZ5y2XazQhUdMK5xDAHdrqaWlrY7oyMPEry6hscSev?=
 =?us-ascii?Q?8Lyj7L1Yoz/tQ+YbTFk73KkqrSky9zOa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:34:42.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736a520e-7795-43a1-d632-08dd1af4ca40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

On Wed, Dec 11, 2024 at 08:21:42AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > +
> > +/**
> > + * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
> > + *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
> > + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> > + *
> > + * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
> > + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> > + */
> 
> similar to what's provided for iommu_hw_info_arm_smmuv3, it'd be
> good to refer to a section in smmu spec for bit definitions.

Ack.

> >  	mutex_lock(&smmu->streams_mutex);
> >  	master = arm_smmu_find_master(smmu, sid);
> >  	if (!master) {
> > @@ -1813,7 +1786,40 @@ static int arm_smmu_handle_evt(struct
> > arm_smmu_device *smmu, u64 *evt)
> >  		goto out_unlock;
> >  	}
> > 
> > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	down_read(&master->vmaster_rwsem);
> 
> this lock is not required if event is EVTQ_1_STALL?

No. It only protects master->vmaster. Perhaps I can rewrite this
piece to exclude the lock from the EVTQ_1_STALL chunk.

> > +	if (evt[1] & EVTQ_1_STALL) {
> > +		if (evt[1] & EVTQ_1_RnW)
> > +			perm |= IOMMU_FAULT_PERM_READ;
> > +		else
> > +			perm |= IOMMU_FAULT_PERM_WRITE;
> > +
> > +		if (evt[1] & EVTQ_1_InD)
> > +			perm |= IOMMU_FAULT_PERM_EXEC;
> > +
> > +		if (evt[1] & EVTQ_1_PnU)
> > +			perm |= IOMMU_FAULT_PERM_PRIV;
> > +
> > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > +		flt->prm = (struct iommu_fault_page_request){
> > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > +			.perm = perm,
> > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +		};
> > +
> > +		if (ssid_valid) {
> > +			flt->prm.flags |=
> > IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> > +		}
> > +
> > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	} else if (master->vmaster && !(evt[1] & EVTQ_1_S2)) {
> > +		ret = arm_vmaster_report_event(master->vmaster, evt);

Thanks
Nic

