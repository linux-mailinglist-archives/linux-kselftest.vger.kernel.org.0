Return-Path: <linux-kselftest+bounces-27139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FCA3EE04
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797E217EA52
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B681FFC66;
	Fri, 21 Feb 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mH73UYVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2611FBC8C;
	Fri, 21 Feb 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125423; cv=fail; b=ukPd0AvmX4P/a6JQU/QyM87ADzo+5ErvlK+AgARfEvK04VgyyRn28Dp5noyFPIO+YY6+Xl98jjWCpomlRw+BYIEcVMYk8UDe8s7E9GLMsSFErqSY4B7mi0g3FZZq0SrIJZtt2kMgdStVpwpbMNM30OHwGrz1LzyfmC8TSAkohr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125423; c=relaxed/simple;
	bh=I8taA1BzzL682CYyQApjF8Zv0axItyINDN8NjoLHFUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1DGN1ISP0PahoAkH6in1uLq0muVavU74zWFohUhimJo7vXBxTjnUzTl9pV8s0vZ/iHtI67hpE5fjpVOTInDaxcO7ShFEHJ91BwGu3Z3xy/c1lSHZwJSfElZwpJdgDl52Kvaa+eCI7Rr7t76Y3CHgYCL0gEpc9uyugKTDHZfE5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mH73UYVz; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES4FcK0bmXV6mKw9G29+2tKV4lyfaKe+PMicLwHdcUnY20QtzgKxumzWZcClQB8ghQOblLgVU/tipbHuDYPY7ejoVJBFel9qrmZNmnLANqB7TbFkcGhxH4pR9IunLqZFi2XeoSM8uSPcP+QZwl1oAQOYX4ljlv6BvNzJ7LVmSf2FrpoBWvUayFgAbIsGTq7dEVv8IaKCLwmM1DSagwVUi2RLeoT4dStZ2OiyrzWxlLbCM+AlNwX6Gr8anrdvielMmMstEI0goKCCKTmGjpvGHwHkBZ2j+x6emp3JN8707wc9itVOppkj+AqYjFeiBWN8XtzO6osDaAEedp3TCTsqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0PCCULBEkFfT1YZceXnXb4hX967beD9ysYp6X8httw=;
 b=uUTT9+Q6wLrGTWiD+90CC7LOIBaAmP2k0PJC+HE0VviM/i6PNSWsyr/Pl9SrUy8esioOojlGb9zO+SmFi+pbSP5hHAOwdGZD0B7kdmfbt10ivY7p2ftY+Rhwb2sp9iSMECAps1IgCq+jLAnANeAtUezo1aFsrsocxZM/Xyg0nRUief6t3n24b9A7ps9+uN4oYxDeJkDz+CItpfBKIFoIsQGw0FlvGYoKJf+l3Rb9AHbjRMQ/tIavKqxazlTFY/6yUU/mbwYUUmL/iDNWt/e4gXQlTi0YCy9hg3HUHD+J9whh9oPnJcKq9WaiqX9rb633LQ4kTbTaYrbiLiQfTda4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0PCCULBEkFfT1YZceXnXb4hX967beD9ysYp6X8httw=;
 b=mH73UYVzY9xc7IDiDHwItzbOQeJcU7lAnVKdWfDOIeH5VmgxAyZBTNfh3A+nMSyDubvWmAaKI1lhX0jiUTxLFQX6j01MjqfTSWOaBEYUTZsCSdEFtslRq57cZ4YIOH8Kd4YPF6HsiQSYQW7mNuSi02pFXjwIULv48cW2fN2yX1msshemBbFwrmznU8gnglawh9W/nIwU1CsZXB/htugzxdXKej8bm0aPkUhxoiEOgE+AvFXURpAenuKJlu3TegN4wOEJDn9Qt0LBET71VN3RWcjneJvhmEbSSzWqJYnXXwUdQb/NyywPRup5uenH9R/6U6/bHNCO7hqN0Mdysyv6+Q==
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 08:10:17 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8a) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 08:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 08:10:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Feb
 2025 00:10:04 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Feb
 2025 00:10:03 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Feb 2025 00:10:02 -0800
Date: Fri, 21 Feb 2025 00:10:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7g02Udkmis26Fno@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
 <20250218185046.GK4099685@nvidia.com>
 <Z7eUeg/SmiJGTgbi@Asurada-Nvidia>
 <20250220232407.GH50639@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220232407.GH50639@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 56565827-b936-4ae7-bd38-08dd524f2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jp7SHlDYolSfQw0vDO0OGb+A7xV/tesQ4a82f3qL38ehQGBuzbijOYg1Xc8e?=
 =?us-ascii?Q?dk1J5+sEAvBMdT5EfHsb9IyPHyQLDgsfZBE+Us53DJR0ttxbeo+gtocusmyd?=
 =?us-ascii?Q?zyOC+++HKeCBQ3YqUkURViGHVP60Gm1UiAv8k4X+PNSZT4rwCKRj+gBggLl6?=
 =?us-ascii?Q?f7mZ438UpOd+Eokf59lMo/glnyJjoc2zsFBb+QbLjd1w2gw95lyFxxIFh++S?=
 =?us-ascii?Q?jechRAkmz0uL3riS7dMnhwd0OIID/zCWNxc+hDsiklS5GIdTaI3CHbQ9KO9T?=
 =?us-ascii?Q?Qwb8VduxPyGxlVk0Q3cZt8aPVnG6ddg4hAruLEWVtzFbMEaCLVM/rXX6IB4I?=
 =?us-ascii?Q?a9yjZXJG0umtUc/mJ65KnVKsr3Vi9aypj3hQeF7XJAVxDu8dAf8IkTGO/zgf?=
 =?us-ascii?Q?85T0dCABSFGajtgkzxlYZCLGZzJhVzRYeVINlp/BGtCqouXhFoanSHaCADop?=
 =?us-ascii?Q?1aQSKtfDezCdIcItC7VvnTEPyraHbmEu4oq9pTxR5TGlr69YLW66USJ5nZrH?=
 =?us-ascii?Q?Osu7gXM+aqfEOkDhQLVpehiy97abo+iqvrBttVPyv0QbHfVzb2UL9Tph+IL/?=
 =?us-ascii?Q?M7qNapTuu0RyvmokHKC6HG8fTaUnv6C33Xc2miWHyXFpHl3P4h+KOUlkKl40?=
 =?us-ascii?Q?vp2gADD7DmnkAoR+qusflfwPxbHxDNE/XV+qYMJUMgKq4vrI5+EgAt6vdW5L?=
 =?us-ascii?Q?KFzABgma7MA/Ud1pWbB/mrZD1SjYWXNriYdR9IFLEsQn0qivHph+4z9HQXbc?=
 =?us-ascii?Q?13GGnp33KGj+B+lYnWj9X2D41U9vO7jbaNm4Whzsvx/ljoT0f8mX1w9JRNaJ?=
 =?us-ascii?Q?7+J11d4+sNKEb24EdBoNUyWOcf5Nru37priU8l4vhGjUbFrdLgTU6tf5XCf9?=
 =?us-ascii?Q?2VV+9RueVdGXFLQqfoc9PphHgvSW2XNyFIdc8nt/kTxDsl7A/sZpsojc5iFT?=
 =?us-ascii?Q?J7DWigv6QlhUMIMKj/RZzp0uCxL2P4Ft+dx3Wpb4EzC1OUw/TX4+suztcduU?=
 =?us-ascii?Q?URTeMP5vo1uAT+VuvMnWEshZ7RZnlff0p5JcWIQ2YStc4NlmLOpIoJRtaF79?=
 =?us-ascii?Q?a+JHcbZVUVQNexfWFVmD8xjIFMNqGnawH1Fksbq/2cgLIzLr4XrPt8RYCjNI?=
 =?us-ascii?Q?uTvXnirDptn9LZgxsS4UxtrTh9m/xxgwEvZJVX4JquE0zmUxBjDMpRKC72d2?=
 =?us-ascii?Q?KAAE42n3fJ1VtZvPkcqnQdncOrNXnPPG0pIfOudZDnJlrCA59GIM60NZQj85?=
 =?us-ascii?Q?xG2O9tC3Gu7bX2aRoFpECC/w9eJxMHXy1OD7XQp6MVRqhXunZ2cbcNr0kI3A?=
 =?us-ascii?Q?q4D8tn5Titp5gQmVlDaC0ZrelIxggD0FwwYJmv9g4zcrb67/WWYDzzJJtiaj?=
 =?us-ascii?Q?Mze24H/ifDIb6C7AC3HKCAt9IjQttFy5bu2uaKoBbL5DURLiJgRSSTS518Bj?=
 =?us-ascii?Q?hHr+FG8JNgubdQqdzJGs0E9dZ78Bv6wbshEFnnK6qHo8UWBrHReCMoUBG1zx?=
 =?us-ascii?Q?5bPDaJT87soZ4cw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 08:10:17.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56565827-b936-4ae7-bd38-08dd524f2d53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

On Thu, Feb 20, 2025 at 07:24:07PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2025 at 12:45:46PM -0800, Nicolin Chen wrote:
> > ------------------------------------------------------------
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > index fd2f13a63f27..be9746ecdc65 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -1067,7 +1067,16 @@ enum iommu_veventq_type {
> >   * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
> >   *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
> >   * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> > - *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> > + *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> > + *       - 0x02 C_BAD_STREAMID
> 
> This is documented as 'Transaction StreamID out of range.' so it would
> by a hypervisor kernel bug to hit it

I see. Dropping it.

> > + *       - 0x04 C_BAD_STE
> 
> I'm not sure we do enough validation to reject all bad STE fragments
> so it makes sense this could happen.
> 
> > + *       - 0x06 F_STREAM_DISABLED
> 
> This looked guest triggerable to me.. so it makes sense

Keeping these two.

> > + *       - 0x08 C_BAD_SUBSTREAMID
> > + *       - 0x0a C_BAD_STE
> 
> Typo, this is C_BAD_CD

Fixed.

> > But F_CD_FETCH and F_STE_FETCH seem to be complicated here, as both
> 
> F_STE_FETCH would indicate a hypervisor failure managing the stream
> table so no need to forward it.
> 
> > report PA in their FetchAddr fields, although the spec does mention
> > both might be injected to a guest VM:
> >  - "Note: This event might be injected into a guest VM, as though
> >     from a virtual SMMU, when a hypervisor receives a stage 2
> >     Translation-related fault indicating CD fetch as a cause (with
> >     CLASS == CD)."
> 
> That sounds like the VMM should be catching the
> F_TRANSLATION and convert it for the CLASS=CD
> 
> > For F_CD_FETCH, at least the CD table pointer in the nested STE is
> > an IPA, and all the entries in the CD table that can be 2-level are
> > IPAs as well. So, we need some kinda reverse translation from a PA
> > to IPA using its stage-2 mapping. I am not sure what's the best way
> > to do that...
> 
> And if the F_TRANSLATION covers the case then maybe this just stays in
> the hypervisor?

> > Otherwise, perhaps not-supporting them in this series might be a
> > safer bet?
> 
> Yeah, I would consider skipping F_CD_FETCH. May also just try it out
> and see what events come out on a CD fetch failure..

I will skip these two for now. Meanwhile, will try some hack to
trigger a FETCH fault.

Thanks
Nicolin

