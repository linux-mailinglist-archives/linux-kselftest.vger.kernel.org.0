Return-Path: <linux-kselftest+bounces-36212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45FAF0401
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3CB440DAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35284281353;
	Tue,  1 Jul 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WFDkkCCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50147258CCB;
	Tue,  1 Jul 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398981; cv=fail; b=oNDvHKi+kgn+zCk7VWjBYMm1xB48NVmjgFxBJn1Ufw12zNzDXo/P55irX7cwAu7laWfgNf+g1ODqjV9M8Kq7hmO33foMv9mxxKYHhvlPvtt2sRtRkcrQoWO5mKU5wBQttziitUD01tvspz5Y2i5VCrIYqLIwdE0q1IF4ai2zvPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398981; c=relaxed/simple;
	bh=aCCwoKqYKLhlr5owAeMVjtdPPhEgzSRQXRy7canfduI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwBVgAX4hHbDqOikGTTQ7kX5PMLdSfFV3jTpMuS6Z5ZMV1OsuWA8YMrjFH6T3BI69mgYPqRhqihRqbaDDaIyMYI9H8o3436mwb2SmUT9079KqBG+F+rB1rgDzDobcULZ6ls4rvcSwpz7IQe1wdtc8zIXy6Qh7p7J1vHhkpylENQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WFDkkCCG; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nup+73OqXh97crcqN+ljnr6j/huCZ23bwbmnVVKqJOYJ0MenmI/GEEyD6E/xESgfcws7LJCeCHhKUlizQka7u9qd05rQH3lo8qwg/gZErwbj0IoEZXVeVNLIek74TE15vuFai6CdmI1OiiLnqOOqn83QiXgAdMj7fNY9mot5jn4C6Fh2w7SnhdCJlvXBiH22a+CwHI/Pnn0NRZanm4rbQXy7kXbgXbxqr5qoStUafkTkXutso9VzZuBYcLks/oRa1nZdE9OlTgKidNSsvaOmJzs5LyJ9s2j7OmxMHegYGOi3in02q3Ub5iLREOkM5oMft27Hm88+LOuL0maYOul/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3M/GYKUxmi3D7lRcvh6Lva9NwKc1GCHPh4TcZe/a/s=;
 b=s7ahW9JLVjowYNzh/wbD9/ph/Oe6OXlam8T+2mpe4kR0WlNTc4cuJTv7NvuvTa6VafMBLcOCua0I6T09KMKzSg9/qe3gpLlGI9JegQ32CkxPMBHwF+4N3syEloGyzVx0SNZ9ZOLNDUi1LHpkz6s2OXdbimE0HoVuAf9i5O5uTxKW6t9HZKtcmR9GWFb8SM5pTYjb9LD4H5lUYh2m/9hqZEQ8Vx3mnw2CLD5VYrH1dlFdHdv3C4f3CoOb3Si3OVR25L4ociylt/IqvY/5F4vUwCq8ITIndN9apmqjAMT6IEH/9l1l1UdcM32FnFuFDAtQMHObM6mHJaG6KjvXbKzY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3M/GYKUxmi3D7lRcvh6Lva9NwKc1GCHPh4TcZe/a/s=;
 b=WFDkkCCGIR93EY0wi6hIb/h3nrfyqxNwzMg1u8e+31zXWubpp9+72V71wbD0AWio2+h22L0V753087SFOO8ynTaS5vgp6PW7H09muwbzcIvKqxiZtCQ8XIk4hjtuguJKoNKoCOMfbxBQmMGxFUuD3H0VmKx1xKdFoBKlFJwid/faj1WNOp5+gERRpEOvrJpFwb6/l/QA7NX/saUOWKHIZJmap1gFvaZoSO54QJFEVrPD7OLSXM7ZD4KnZoXKBGx/A+RBxsS+cCh3PF6J5TbI7l+fLd8za5nzdQqJzbCKrKssRyaHLfg7oJMpFRZNeXl06gfX68UulvgiI6sw7ZIdFw==
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 19:42:56 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3a) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 19:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 19:42:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 12:42:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 12:42:36 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 12:42:34 -0700
Date: Tue, 1 Jul 2025 12:42:32 -0700
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
Message-ID: <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGQGm1-i4M75b9Qp@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df2d0f3-9d98-4b81-5889-08ddb8d77a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+GgbX1PDG3AwFpnnocfS4BhaZ3IYyJsV0lZjHEyBEZ/vPLcZtUivS1Py/+6?=
 =?us-ascii?Q?Jgwgc8bhw6NT/px5rNNr5t8NGar3fkCorie8qW01ZNq7reYdT1EqpVDIuIvQ?=
 =?us-ascii?Q?R6mW12N+p6KSGzXoeKPpO4FoCzedywAfalNrMn4mafrJs5HRV3N9KgcP/dSN?=
 =?us-ascii?Q?2HZvFn6z+c+mqPhzKmgqb8s5zoKDGvPu/aU8ev0Ec8NM4ShfnSBOmRwMwo+i?=
 =?us-ascii?Q?/GxfnwpD2qHb9FWIQKKn/uiUszvBmpqHucdYnG2VVLcYxQ4S1rnnyUcw5lXv?=
 =?us-ascii?Q?a0i/8w582vKTGvBpncPv9D/Aqmu4ivreFAYErxnxaIdD2PW1FokVjq1GzFhS?=
 =?us-ascii?Q?+20Yv75hk8hGkra9VW3OiZFvFE34FfAMJ1NwkaPk+0fBT9A55TVsCLlxr+pk?=
 =?us-ascii?Q?8vqdBa+pnXj2j1r7oTW2LjdWeFM60AgYbCP4wMNvGRxtEjxg+QKz5hvLUD5j?=
 =?us-ascii?Q?3iZTyNddBthPNS/CIIdec3UDZ8O87jFVYAyquZhHBRcSmDtPAzNKK0HWcysQ?=
 =?us-ascii?Q?LXz33VMpEV8hz9JP3GRfg0w2ys5Q6ZMdzFF91/52fyTUTUIbJ7G0T4EGhXOA?=
 =?us-ascii?Q?Jd/Ao7jIzOK/PvEUh9H2Ex28afnq0n1GD1mAlml+sXIFYtn8/8oLDomHPBZM?=
 =?us-ascii?Q?o2V2zmDCUSlon/rHkdfLerbXVbcOCBukBSnrZN+gkpFF/gkXJV2C5Dx2SccR?=
 =?us-ascii?Q?PkZ5k4CPMAsZQDoY2mbhhYHmJMjVTK635lOj3T5XVF3kl6OpXhFBJfTePdF8?=
 =?us-ascii?Q?DItgY1V1IQ0rXsJn7bmtwCU+RfICwEadTGDK7JVQfiOMI6WG0LdjIY/90PjM?=
 =?us-ascii?Q?Nbtn03RsSaktyxYVhAp6IzFa5/LL5jXhbeh1WlxSJ0TfDLxCGvFEaV5q6FUS?=
 =?us-ascii?Q?8Y2/OwOtIoQxoFvep3cjG2dUyJ4+kqSWOaZ/Siw3WKyi8zqydHVpjOAV5k7v?=
 =?us-ascii?Q?OAihvxNYCwxxH2Nn3DTtZMffQ4+dHUroenrzWI9hFMxBloevC58OfHgKjwMo?=
 =?us-ascii?Q?s+fYmOY1hNT1aKm4CdNqUapCz9r8LnRGvtXoVQWnWyuISNmyesvz8YrUWQOn?=
 =?us-ascii?Q?sIPK7ZIdnNUsBHRSqlsp3cmnQL/PiKQO4VKcFeY635XAZ215oxKhKEXHUfFg?=
 =?us-ascii?Q?0YCfPr4w/CKK6RQClVRqCN5bNGJjvxxqzkTcfz79wZGsuVDtaD+XbPUtYAGX?=
 =?us-ascii?Q?8NqAabaDH/7QVmQL2Fl+HgqWAh52hM4noVDd55GLixi1Jj+yk9mw3gM9tG7f?=
 =?us-ascii?Q?hQNG2EL3hMByPAjakVO4ranuGGwOuSF+fz/BZjyYaw+wY+DwyKES51mlhsYd?=
 =?us-ascii?Q?v0EYhv2hBnt/PqllRORwszVu0Ahu9/w/Dt3ifWyHpb9f1OvQ7FVeY3jGBHi6?=
 =?us-ascii?Q?kRaVEXIPxGYGMMvTws6mIw6cbA6YuJginxY8OmkI6y+2DNPNDBSEvf2rypov?=
 =?us-ascii?Q?TgT9t2YVgjIOTj/jsgA89qOHtca6r/JiVAmMH4xu1meQ4AHeAlZwPRkG7tfO?=
 =?us-ascii?Q?DSh9VW7vUkrfRGGZh024MaDpAHB4VMh5y73Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:42:56.2153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df2d0f3-9d98-4b81-5889-08ddb8d77a19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

On Tue, Jul 01, 2025 at 04:02:35PM +0000, Pranjal Shrivastava wrote:
> On Thu, Jun 26, 2025 at 12:34:58PM -0700, Nicolin Chen wrote:
> >  /**
> >   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> >   * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
> > @@ -598,12 +619,15 @@ struct iommu_hw_info_arm_smmuv3 {
> >   * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
> >   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> >   * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
> > + * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
> > + *                                     SMMUv3) info type
> 
> I know that the goal here is to mention that Tegra241 CMDQV is an
> extension for Arm SMMUv3, but this comment could be misunderstood as the
> "type" being an extension to IOMMU_HW_INFO_TYPE_ARM_SMMUV3. How about we

IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV only reports CMDQV structure.
VMM still needs to poll the IOMMU_HW_INFO_TYPE_ARM_SMMUV3. It's
basically working as "type being an extension".

> Sorry to be nit-picky here, I know that the code is clear, but I've seen
> people don't care to read more than the uapi descriptions. Maybe we
> could re-write this comment, here and everywhere else?

I can change this thought:

+ * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                    SMMUv3) enabled ARM SMMUv3 type

> > +/**
> > + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> > + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> > + * @vintf: Parent VINTF pointer
> > + * @sid: Physical Stream ID
> > + * @idx: Replacement index in the VINTF
> > + */
> > +struct tegra241_vintf_sid {
> > +	struct iommufd_vdevice core;
> > +	struct tegra241_vintf *vintf;
> > +	u32 sid;
> > +	u8 idx;
> >  };
> 
> AFAIU, This seems to be a handle for sid -> vintf mapping.. it yes, then
> I'm not sure if "Virtual Interface Stream ID Replacement" clarifies that?

No. It's for vSID to pSID mappings. I had it explained in commit log:

For ATC invalidation commands that hold an SID, it requires all devices to
register their virtual SIDs to the SID_MATCH registers and their physical
SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
lookup table to replace those virtual SIDs with the correct physical SIDs.
Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
structure to allocate SID_REPLACE and to program the SIDs accordingly.

> > @@ -351,6 +394,29 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
> >  
> >  /* HW Reset Functions */
> >  
> > +/*
> > + * When a guest-owned VCMDQ is disabled, if the guest did not enqueue a CMD_SYNC
> > + * following an ATC_INV command at the end of the guest queue while this ATC_INV
> > + * is timed out, the TIMEOUT will not be reported until this VCMDQ gets assigned
> > + * to the next VM, which will be a false alarm potentially causing some unwanted
> > + * behavior in the new VM. Thus, a guest-owned VCMDQ must flush the TIMEOUT when
> > + * it gets disabled. This can be done by just issuing a CMD_SYNC to SMMU CMDQ.
> > + */
> > +static void tegra241_vcmdq_hw_flush_timeout(struct tegra241_vcmdq *vcmdq)
> > +{
> > +	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
> > +	u64 cmd_sync[CMDQ_ENT_DWORDS] = {};
> > +
> > +	cmd_sync[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
> > +		      FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > +
> > +	/*
> > +	 * It does not hurt to insert another CMD_SYNC, taking advantage of the
> > +	 * arm_smmu_cmdq_issue_cmdlist() that waits for the CMD_SYNC completion.
> > +	 */
> > +	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, cmd_sync, 1, true);
> > +}
> 
> If I'm getting this right, it issues a CMD_SYNC to the Host's CMDQ i.e.
> the non-CMDQV CMDQ, the main CMDQ of the SMMUv3? (i.e. the CMDQ present
> without the Tegra241 CMDQV extension?)
>
> so.. basically on every VM switch, there would be an additional CMD_SYNC
> issued to the non-CMDQV CMDQ to flush the TIMEOUT and we'll poll for
> it's completion?

The main CMDQ exists regardless whether CMDQV extension is there or
not. The CMD_SYNC can be issued to any (v)CMDQ. The smmu->cmdq is
just the easiest one to use here.

> > @@ -380,6 +448,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
> >  	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
> >  }
> >  
> > +/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
> > +static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> > +{
> > +	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> > +}
> > +
> 
> Not sure why we broke this off to a function, will there be more stuff
> here or is this just to use it in tegra241_vcmdq_hw_init_user as well?

I can take it off.

> > @@ -429,6 +504,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
> >  		}
> >  	}
> >  	vintf_write_config(vintf, 0);
> > +	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
> > +		writel(0, REG_VINTF(vintf, SID_MATCH(sidx)));
> > +		writel(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
> > +	}
> >  }
> 
> I'm assuming we call the de-init while switching VMs and hence we need
> to clear these to avoid spurious SID replacements in the new VM? Or do
> they not reset to 0 when the HW is reset?

The driver does not reset HW when tearing down a VM, but only sets
VINTF's enable bit to 0. So, it should just set other configuration
bits to 0 as well.

> > +static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> > +	.destroy = tegra241_cmdqv_destroy_vintf_user,
> > +	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
> > +	.cache_invalidate = arm_vsmmu_cache_invalidate,
> 
> I see that we currently use the main cmdq to issue these cache
> invalidations (there's a FIXME in arm_vsmmu_cache_invalidate). I was
> hoping for this series to change that but I'm assuming there's another
> series coming for that?
> 
> Meanwhile, I guess it'd be good to call that out for folks who have
> Grace and start trying out this feature.. I'm assuming they won't see
> as much perf improvement with this series alone since we're still using
> the main CMDQ in the upstream code?

VCMDQ only accelerates invalidation commands.

That is for non-invalidation commands that VCMDQ doesn't support,
so they still have to go in the standard nesting pathway.

Let's add a line:
	/* for non-invalidation commands use */

Nicolin

