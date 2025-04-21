Return-Path: <linux-kselftest+bounces-31269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA15A95697
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 21:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB523A600A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D611EDA1B;
	Mon, 21 Apr 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XH+ccU7c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3F149DE8;
	Mon, 21 Apr 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262869; cv=fail; b=TzXDkY6mCUPHbdbWNuq9ctJNBZHqvnyIffrBvfoVb8zcX/93bqPzUBndcyB2HefrrrhDF/J9eRwNMNbvR5LFqunO5RpiFzbBrN/iVBYYaCNWoyswSzqVZ+mxEsaH/9LeENSGuEph3X3UCsUFMKXgLM+v7V1C3Xf+CWy2orGVtAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262869; c=relaxed/simple;
	bh=Z2NxxHGlS7nRnIy49Rx2mBaVPpFR+HgNi3x7UFlItGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcKsf8nM87S0u3LU94pSe7LMxarPy+aMJWAR2iABS7212QtlUG+RZv3hBf6FyrJ7i91FICgsbBlDgK2DSOr15mpdwGzEdJLoHZ5ilNoCbrVfAvuxzheNpAr3sW3dqGK6lmwBKCvaJg/B2ZPdIXsQOFUdwCVU3ZvfoDctGEnOXz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XH+ccU7c; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaklUj3aL/h3EZmrZJsDNRy79bClwZdpIP0inr+ykoP56r6o+Czis4htbomOmAnUdU9SV3BznFQZ+284dXaTbM8O8Oy+5czrkSxqE0vH0NWEkvGwhIcMzO+QmmSHXefXfqey0moLSWCEM+Drvkk/eU1jnA7JmN5jrWG3B4qWS+EZK++MLaVATIu7srURS0NdSwCbp31BLDGYXwhQn+ndI0on33WI9Maq5ofbo6HItYIFwzlH+pNdgPKNK14x+ma7yx4yIuy19ufpKn5lcWJxRKMuoYvczBJe3R/6ylvF7xnF6GN7RyBOHFme3cJUNJZ0jMLaCkexbE7VEMJVyVhvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijM6CkkdbQSEcyFX9EYG9G/0MO8q4W0XbCWQhsXdgYc=;
 b=Tecv6FUg9TJ6ltezEASLyokPNacbUSSmdFReqa6ARqAs0uar0b0l4SEXWV+hxAUaZ3+u4mlt+X9Q/eMF//w/IIhgOr+IhgyFPD5jAcmbkoHfexhWqsk1rQuAV2o28SmOrFPV8VyBwUSzimYhCK4fWGPyZJ6Bw+Ygv6xBc5C0iOoFFNgDk9ROQQtOn+D3J9EGsEQi4ORD1ShS62/WCmvEv3VzsaJHzZA9R6pVsTTn4G2zUmoJDqqd8XEhQ6ZMr4Zq4Xms9zow8t8qAGXd61NTAHiBToRLQ4jxI+82m2gARB1KS79pwrfKG3BZKMx7DKbcj94BMnsqEdzbuMDDtnKLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijM6CkkdbQSEcyFX9EYG9G/0MO8q4W0XbCWQhsXdgYc=;
 b=XH+ccU7cvwNAFZs99wAR/kYiO5HzbuMEAmy/zJn5BdzyvRxahWeXSKlrAoaKJJyuQOstWPgCWIGdpt/QPw5+G1vIU1cKQXNMw1sgoYO95qDdeHgcIYg6Dkh0uYhzcIi+XWBsV39TrW4+jrr9fDyIDCDC2nxt4aE+wJZNwZWUXCe++m5uUaxZeGKQzjV++QDu2EKtAKfbwror5inAcLczQQDsa6TC8kjIJ/5CSVtBfrbz9JIySOGx/uFWm4XUWR7FPJ/TFhsfa0ESyT3Go+S4l51cudNidgvuIQur666E8JfqauJTjFSAYuGqLcxxTRjT4YwQvudkXVEiFA5Ytrbg4Q==
Received: from CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::30)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 19:14:21 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::82) by CH0P223CA0013.outlook.office365.com
 (2603:10b6:610:116::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 19:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 19:14:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 12:14:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Apr
 2025 12:14:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 12:14:03 -0700
Date: Mon, 21 Apr 2025 12:14:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a25ce8-7251-4e52-1d6e-08dd8108b7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5jq0Y/wEgFj3V3DtVSBFK9NZX7CUK8vkcC+k2f3dp0Xv0KzgZKjIdGFBNZ5?=
 =?us-ascii?Q?yDCHqxhfgBdVoL6rF3vkdBRi9LvECqrEBTjhtAJ6rd4eSkXoS1HL7UleedvK?=
 =?us-ascii?Q?HRJIeOdxv9Q3yWPInXOmzJY9O/r6M7Wte8k7sZEqb9/3xRgqlBnKcFWcoMrR?=
 =?us-ascii?Q?f2Is1cNW3mB5B0iJ94BTEHQwHFe8YH3JN/BaHSQFhfooZ45V9BVhft7kb7y8?=
 =?us-ascii?Q?DYU59ffyJ4hUd6OC1K+N9DhpWR6dFl47gq3A6on9fmXbef/44JUwp8mmXj1c?=
 =?us-ascii?Q?BI1+lEYGsAlAYZLP8Q5KWsR/JOIbqhxFgdyxzX/Z7EuasWuMJdxPLJZRinO4?=
 =?us-ascii?Q?KsayH37vyXb4ZOic25+nCFfFRiD4nZ4QOVemuj0wlO8Ku1+cXiQOBcURZIrE?=
 =?us-ascii?Q?sfyvohaalf707SZeQziWzPKKST41f/Rp0kc05coKRhIUN87czz+/aF39JSQQ?=
 =?us-ascii?Q?m7fOTKgxxunGdrKBIan74kLLzvH0tORpwsC4zoOmCJpKS6AqVEHdLG0C5V+A?=
 =?us-ascii?Q?fZm1UiG9/VgnAKD89NT9TLnc5HmIIP5j2W71VF1uA6Wp9FxiNbH7Heby5yIa?=
 =?us-ascii?Q?Rrx+NAoYoIxusyPLlAVUnRFBVMrFEsaQRUpEtBLAF9P6rw8EKxF5dC4yEUYp?=
 =?us-ascii?Q?goH95zR8yHfa5fBFhFMBDQOTqOaDZKHwZZt3Lafwq3h0rZNSlNfyeoJW74Bi?=
 =?us-ascii?Q?7DtzAz6St1o0xDa+lB6MTZDU4k5lAMZu8qnxFEFxZgCTiRIlhAlfIS/HVcY7?=
 =?us-ascii?Q?cME/xqmDSY1nJ4LrK/zRJYu2RNelWQVl29RGBqgEnqMU2dErqWeH+09rG1kI?=
 =?us-ascii?Q?DcgLO1gL98J/PqtR4a47o1xaLJY1Xbi0GQaBzHIaYs0ifp3Q++bqssWX7em0?=
 =?us-ascii?Q?0bw2n3AQcruzf4wiSKl2sAgGDWWjHGdH7KKdwim0y32zVyqJA/NTW6iSzHHJ?=
 =?us-ascii?Q?l4UQGR47sNxdKQC6JLGk/vS5UXtwDA2kkWg4aQ1C9ooS+bTUrk/IAoMK1T0E?=
 =?us-ascii?Q?FsD1swx2mKBwZZ3rJpmYo1y4xqpgteAG1cGgngxH4Mtp+f78p1FsD1/gBwNX?=
 =?us-ascii?Q?gYFhjF7PzyTvF/L13/Z6d+TZ1moDsTW9SnrqDWwlhL5DGIP4ypHSscT/95Kf?=
 =?us-ascii?Q?jmlbKDylnMLIYTFaW95x86tcjDHkgOA7+pbhhaRV/9gD3dahciWhRfGCOBQW?=
 =?us-ascii?Q?GjJwLXuCeL9xhNVlj2FHIojnj45J4o1G9J2ZrRWGrNLJMw/P5P+ju4JL9Y8d?=
 =?us-ascii?Q?LTfD5h0WrdSDrGsCrHKsFVGusTQRBy7zI9XFEswIALxeVFrBQYLCJejDLYb7?=
 =?us-ascii?Q?/o+HQM60jZtdungAUhsZCxdqKkt+nwR9TYJSiJiZ52DBj9GpOlTC2CQZLygv?=
 =?us-ascii?Q?y1UI3mOK4DlatVit80J3Eoye/PYmvG+Hcuux+7PDtaHBGRqk0ADx1luOWkk0?=
 =?us-ascii?Q?z2wulaORuG4Ulu3k1cisjGUuoy9Gs3qj7sc1ZlRH7YK+AwN5+eMIpJGCbT2a?=
 =?us-ascii?Q?rBLchaSK09AYoKEztlQRQEasGDMcaW3FnuEh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 19:14:19.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a25ce8-7251-4e52-1d6e-08dd8108b7dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

On Mon, Apr 21, 2025 at 08:37:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> > Add the support via vIOMMU infrastructure for virtualization use case.
> > 
> > This basically allows VMM to allocate VINTFs (as a vIOMMU object) and
> > assign VCMDQs (vCMDQ objects) to it. A VINTF's MMIO page0 can be
> > mmap'd
> > to user space for VM to access directly without VMEXIT and corresponding
> > hypercall.
> 
> it'd be helpful to add a bit more context, e.g. what page0 contains, sid
> slots, vcmdq_base (mapped in s2), etc. so it's easier for one to understand
> it from start instead of by reading the code.

Will do. It basically has all the control/status bits for direct
vCMDQ controls.

> > As an initial version, the number of VCMDQs per VINTF is fixed to two.
> 
> so an user could map both VCMDQs of an VINTF even when only one
> VCMDQ is created, given the entire 64K page0 is legible for mmap once
> the VINTF is associated to a viommu?

Oh, that's a good point!

If a guest OS ignores the total number of VCMDQs emulated by the
VMM and tries to enable the VCMDQ via the "reserved" MMIO region
in the mmap'd VINTF page0, the host system would be spammed with
vCMDQ TIMEOUTs that aren't supposed to happen nor be forwarded
back to the guest.

It looks like we need some dynamic VCMDQ mapping to a VINTF v.s.
static allocation, though we can still set the max number to 2.
 
> no security issue given the VINTF is not shared, but conceptually if
> feasible (e.g. two CMDQ's MMIO ranges sits in different 4k pages of
> VINTF page0) does it make sense to do per-VCMDQ mmap control
> and return mmap info at VCMDQ alloc?

Page size can be 64K on ARM. And each additional logical VCMDQ
(in a VINTF page0) has only an offset of 0x80. So, vCMDQ cannot
be mmap'd individually.

> > +	if (vintf->lvcmdqs[arg.vcmdq_id]) {
> > +		vcmdq = vintf->lvcmdqs[arg.vcmdq_id];
> > +
> > +		/* deinit the previous setting as a reset, before re-init */
> > +		tegra241_vcmdq_hw_deinit(vcmdq);
> > +
> > +		vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
> > +		vcmdq->cmdq.q.q_base |= arg.vcmdq_log2size;
> > +		tegra241_vcmdq_hw_init_user(vcmdq);
> > +
> > +		return &vcmdq->core;
> > +	}
> 
> why not returning -EBUSY here?

Hmm, this seems to a WAR that I forgot to drop! Will check and
remove this.

> > +
> > +	vcmdq = iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq,
> > core);
> > +	if (!vcmdq)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret = tegra241_vintf_init_lvcmdq(vintf, arg.vcmdq_id, vcmdq);
> > +	if (ret)
> > +		goto free_vcmdq;
> > +	dev_dbg(cmdqv->dev, "%sallocated\n",
> > +		lvcmdq_error_header(vcmdq, header, 64));
> > +
> > +	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
> > +	vcmdq->cmdq.q.q_base |= arg.vcmdq_log2size;
> 
> could the queue size be multiple pages? there is no guarantee
> that the HPA of guest queue would be contiguous :/

It certainly can. VMM must make sure the guest PA are contiguous
by using huge pages to back the guest RAM space. Kernel has no
control of this but only has to trust the VMM.

I'm adding a note here:
	/* User space ensures that the queue memory is physically contiguous */

And likely something similar in the uAPI header too.

Thanks!
Nicolin

