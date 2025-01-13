Return-Path: <linux-kselftest+bounces-24402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB59A0C16C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C191886D94
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A01C8FD7;
	Mon, 13 Jan 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpHa0+HD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841891C1F0C;
	Mon, 13 Jan 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796574; cv=fail; b=IjnJOJUZn3c5QtjpvLAB7JbDghSpGokcJ4wqQVXvCWRH9hT69irhtbHhqaKRSDv6HUB+c0t6Xm2m0XgyRqRjgI0EnI+jEFaIAgDbiHpKsNlimHqasZEvKEUhYMA9QgxhOGmLyu54xPy/l2PH+xaporFJn6bbDGlnUb17SZqleU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796574; c=relaxed/simple;
	bh=Etjo+aan5GK2WReLY6Fk4u61tvy2DlgXBq1o9dD5sYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJ4Dc0w5hlsPdsKwhDwgLEqA/VGecRRDv7rztxUEsgheR1KiNwJNSvJRZmKpP+nXbaOx13TKCAsqqrxdpPznuA9MTMta7DjZHvvWunv171yIOzy/uJych+EWkfbNTDDofxna7cr4oD4QTBdhf0E+A52ewhMUwoKFxrvYiXrgm1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpHa0+HD; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4mc+WIYslsD4eJXkhbNousbNgM4wwWU36kIhCN+lFdH4KPbTbCFvAo8HpIKmBXOiOZIGNLYrMN0IZJKZTHI1FPSw8eNsHpaO+VLyNABTTCpMSKxitUHXuhGsTHrWsXPPIE0PruUFKDxaU8dB86I2ONUIqQ6RgnH94rHjIq9XzDZYAhdVVp9pJEz7IrjUKVk4ELdw1Q0GAvBabWn9DpwmWxI49SCj7SlI5LCnKcPL1eoaagZnzb5wEd82eOEN4miAcYkf0B9vcEh9QaoijROnIhyl0wxvFjygOkKVeDSk95LJZgYNtzXbwQhjGRSO+fAoXoEuEt6OUC7P0NkHqAQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tznFUpkm55GBM122K42pYBY0AK6rtwVoKb4/51ZMqtw=;
 b=HgxoGwdrghcgBsEj/5VQwDMgZiZTS7tJBEnvrEGrIxJjJhSY5Jfr9OLMAW5WUwGjpEFyII7s/4QGe9JCbQL3+i579fsoCClA0F1JoDCEliIbSwmBpi3ouzhROXR8T61ISuMWfLrIF381atkYAhmB4s6H8e8v20IF5jV0sKUktxJa+qZfX9pBkZ22/DuPyL5fhkW440zFda5aN6ta2r8ixFN1PDRHV8aznWuVcVNeFvs2DVQ810nu+XHulKUuZB3tI8iB2bQv9hPyK3kXVtyjKHj74rOoog3rm0ESsRkvDzU3Wsg0/PN023UeA2k47uC+Y8emtAE4HRQUoC+ENpR/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tznFUpkm55GBM122K42pYBY0AK6rtwVoKb4/51ZMqtw=;
 b=GpHa0+HD4VQwqx/EdGSARLoHP/nlr7fzQVpnChJspCAnSpwXBBwDhSNQBQg70Wb6GZAUTVoSvdPYyv7Kole7cr513QysjhVl87UWEh9cM2PtzuCWk32werQ5Wy75Vk+Ju2WlSUpSu52XjO/niqPW5BJf/OG8FjqhDnVrGMYnK3Xug/uFlQJqQ5ElGCZ5bVwT9YuyEkc8Rm1AtkEAxfXOI9UWz9KSABLIEuAbBNAXY6INjn8GB71Ne/e3QNXrmZxqevUp1XWRxx6tuDKCFO++wCieXPY1YOvIe3SklkyykSEvqSl2FS8/7QtOpyLs0E1BDgD4N0YcxsZ7J99We5pKYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:29:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:29:28 +0000
Date: Mon, 13 Jan 2025 15:29:27 -0400
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
	patches@lists.linux.dev
Subject: Re: [PATCH v5 13/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250113192927.GJ396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <115d6015219e5850ea49dc9f1247f9c3eb515770.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115d6015219e5850ea49dc9f1247f9c3eb515770.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:408:e7::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4763a1-5bb7-45c8-8f3a-08dd340898e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSGu9npLbcZ9WRa/EPZegtYkzb8cN2HLTcYNUmZzzaR0cGTizwWVoDQBoLwr?=
 =?us-ascii?Q?Tg+hhgQFz/R/02vhv5HbIV2b3WIkzB+pSoj+3GwMGrq7vssb4ZRt0fWKLBBX?=
 =?us-ascii?Q?WCRaw61L1GKLsEqcSHlVp9GVQpJLzSWoEpb5Wpe5JxEjduY4YKaUrLS5od/m?=
 =?us-ascii?Q?RkWnvZMY0EqrZBfQ4fSGQNMPM2aBe8U5s9BQZvPNcb+HI+WT7/hkZ0QMVqr6?=
 =?us-ascii?Q?r5h4ktuGkJdbuaxX8uRlBIwPWwrkAMA/lCuj0HmCx+n7zVqfHKZwcP5y0n56?=
 =?us-ascii?Q?c50KMXYpLDP2uPDHdYljXBF8erxgxLiiqQ2hT07AP9lAj8+qurYvKtvAY3qY?=
 =?us-ascii?Q?g2quTO/Tl1T4uv+1chArsEnxxmcUDEVg+TXFNz16NOlYN28X3qNHwRqPMo4S?=
 =?us-ascii?Q?eCqDRSO5bpP/XIxIG1BEjczonYWO7l29BMfxJTWackn5op30C28ztfsTls4O?=
 =?us-ascii?Q?zvqOu3NedsPtcnm5s1VBTP1ms2JQ3Ph5vl4uxDJ3tge6ELiP6T/+slzmEfdt?=
 =?us-ascii?Q?92B8D9ikVDA5TCL/jqO83hQZwPabd3JZ0d5+MmPBlueAj7jE4qEBCjENeS7E?=
 =?us-ascii?Q?fdtk/ZDUUu/BL4cCeHPnLsvcrAvZpgwNWfaA1nFKb2NEFrMPhPfmiuKXgoTk?=
 =?us-ascii?Q?IqPEp9X5RBuce2XUGavuTbgwAS/kYxQpWlg5FqALyGAw0wC6bfHjUnV23sUE?=
 =?us-ascii?Q?tpsnUNNGrVEbew+9AzsKxeySiPCC5T/s7bjeitC6J+/ZYA/cgALOXWR+LP5N?=
 =?us-ascii?Q?pT10pjjYgtkTso0xgxcjkZP8q1UD1nu8PWpUHhuhYKP2a6gEgbYBDYCp/+Ij?=
 =?us-ascii?Q?UATfCNdvHpWOY4ebIAUkWZQOQlK8Qa+wSOwPVDaf4Hw0h5kqc5cptG6Gc2rz?=
 =?us-ascii?Q?fT+EAOPQqG0oyaPS3ghaZh2ZbKKn5UJcQaQZqP1OoQXi2ulRcCpJLGwn509e?=
 =?us-ascii?Q?3CuzH3Zsx6dLU6jSjogkgAXiCpWn9Oy3mE4HAXsBxa85+VxnsOAWr7aIMdhS?=
 =?us-ascii?Q?86no4BW7uUVtCB9u4konnqvDjOPf2ylbBLWL5LytsvzWFjemQjBpqCBG1Yjw?=
 =?us-ascii?Q?hSeqRftM/JRao1hGzfoq1b/Q4kojLfibWsDPHSe+eEfSNCL0JsCvzAci9AFX?=
 =?us-ascii?Q?c7Fdp6gwOI+LvhekNdBapZz+uie10cuvaxf4t0K3rvZICyo7b8GlKGgQOc00?=
 =?us-ascii?Q?92jOpZVbROTLQxW+DblF7wBKql9i2Y7KeYN/h57hmaGZbOHLqFYynx1G52Za?=
 =?us-ascii?Q?tGX+e86Wx6WoERnD+mRgRZdwFImZOnrUgdyMcqKQx45VauPTiFWfQpMCsywy?=
 =?us-ascii?Q?BQvJT85UADreWpVHoul0tREiPfLGE9KdG4HLQOptexJpa0hHJhs8LaLiebMb?=
 =?us-ascii?Q?v7A7y7UaEx35ovKlzdB/GPUtLsVQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2LRzBPG0CwS6gSSDbXtmiecHGZ9Q47XpmWBVF46HScfNDnuiRcOvrD7zZZX?=
 =?us-ascii?Q?LowB+gwbItKFU/TxMv35OSpxX9NH5pVoCc0HKTymTKw2MKdK7A775kKKp+HJ?=
 =?us-ascii?Q?frNt+ttkNvoDIlb21DohDc9p5v2cVrqEUgO59uZUSv8K3w11+IwDZJh2r5Ip?=
 =?us-ascii?Q?UZqcR2SKA6J6NHqt747Jf5Br8CD4mvCt8MouQsAO1xjicweK7zTPGRc4+tcd?=
 =?us-ascii?Q?pgCG6yAFuxTxiz6NJj+qu2TJ3H/dmlWRF96JCALfEi4ry1vho9hgIiq89HmP?=
 =?us-ascii?Q?A7u63NArViCEEde0QsJTFUvkke0HEOCkHW4qIBnX7xB6mFSR3VFqPppussWO?=
 =?us-ascii?Q?vhhCio2YSOV/86NwecDFwesIDhHyHdmaL1sOXl8jLz7T4lqxZpkSf3L5EZKv?=
 =?us-ascii?Q?ZFCP/l0I4MJ8zhfNUmpZtTrBlonRXoHk8fXsBBlLbF0w0xSHhHx0minBbziX?=
 =?us-ascii?Q?CeJI+fNdl27hbTWill6pbY4L9BdN8mn42SRLLsuNS/j/zO1pf5e0qK0gFxxc?=
 =?us-ascii?Q?KTIvd8IwCUz4sDpE8BtkOXaxT7meHrrcLeSJVjahc8//bChS5t2fQ0x7LIPZ?=
 =?us-ascii?Q?fjVnMnXSrE2vyfYxqlDRFclIYaCF+zzXWge98hOm3r0kdzBCQmph6rlqRVGS?=
 =?us-ascii?Q?/CDz7ZRxJwiKcREhtqbncNtWzyB0Q9ErdN6jyReQ/HkqeBD+TnI03LPor1Y/?=
 =?us-ascii?Q?9sfFPdGm1UK2BfCLw7j68IBZNTm0F06l5/vHUHYIPKeNXLOPlXdEovKY+1ey?=
 =?us-ascii?Q?1BuFydj7sH8l8gQ/5MtfTI/5Tql//E0/L3HKOcMYbsj+6E499OvnGPTka0al?=
 =?us-ascii?Q?c3DJaZtjJQ44P5Z5kVSEIpBrTCECLlL3psFemwB1zMdwkUyoUfT9ov4f2UGm?=
 =?us-ascii?Q?azp8wdQkuMywjO/znqkeVG5FpdB6XZCnz+vbzfl3v84VG8EqSM5STgxN6nLu?=
 =?us-ascii?Q?QznOXbu5nDnXwz3bWSidIWSfFmghVJTZhsK753U/9Pdy5NDRkOKhZI55vgT3?=
 =?us-ascii?Q?x59X6HnkydmhI1R0oFfxsC7rUVHvbE6OIDFHQjqyPTnncmUVGv9VSEQ4ffvD?=
 =?us-ascii?Q?bydJFQigiF5ijsipAr9Myg+rIO6EBliSdRWNAWM1xKEojl9JeHBPlnA2g5nu?=
 =?us-ascii?Q?bMJFB9/r2IKQwiQmSznjgLnVkGAP18bc1PefVpwXRYMqD66QRjH21Y3opOwC?=
 =?us-ascii?Q?vn8r+cLRiRZZowAmIJvAjAmeHOGGAl9kqnfuQZAKjDEZYNWIOyCQtI/TcZbz?=
 =?us-ascii?Q?p1Mv+LZDcEu15Ep4ahIPDPtvXsxTw6GU/+0wqCgU9INpyuknkrbgWZWyWilP?=
 =?us-ascii?Q?77lBsQZrZ2ptob9yd3O6OdSP1KQtIBXjJ6JCsZe4H0t1xv/SmVi8IXZMiAuL?=
 =?us-ascii?Q?cgD+qUg4KREYbFrMSH7RIFQDIIYMWhbnutojjGthxUe8m8xexU22yripatQ2?=
 =?us-ascii?Q?a/dEbIW0cd2Z0u3r9sLiBIpjY3udgxVL+9anhghT89QCE+9xeD8qEkW8l6cb?=
 =?us-ascii?Q?7NY0e81xeX1Lxkluakj7Hs3HjtzbeEx6maClVzHLGexpQUCkk8+StIHSmlhU?=
 =?us-ascii?Q?oegbK/MnpO5TYzUqmEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4763a1-5bb7-45c8-8f3a-08dd340898e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:29:28.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYUrMxAq9U3GbIQtKbOK2VMp082fgd2NXSvfdx7lgwIa6Hq/pqusSqxk1DhNoAum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

On Tue, Jan 07, 2025 at 09:10:16AM -0800, Nicolin Chen wrote:

> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				    struct iommu_domain *domain)
> +{
> +	struct arm_smmu_nested_domain *nested_domain;
> +	struct arm_smmu_vmaster *vmaster;
> +	unsigned long vsid;
> +	unsigned int cfg;
> +
> +	iommu_group_mutex_assert(state->master->dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_NESTED)
> +		return 0;
> +	nested_domain = to_smmu_nested_domain(domain);
> +
> +	/* Skip ABORT/BYPASS or invalid vSTE */
> +	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
> +	if (cfg == STRTAB_STE_0_CFG_ABORT || cfg == STRTAB_STE_0_CFG_BYPASS)
> +		return 0;

Why? If the VM sets an ABORT vSTE then I would expect that any
protection violation events the VM triggers are captured and forwarded
as well?

Basically any time a vSTE is in place we should capture events that
are affiliated with the SID?

> +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +		return 0;
> +
> +	vsid = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> +					  state->master->dev);
> +	/* Fail the attach if vSID is not correct set by the user space */
> +	if (!vsid)
> +		return -ENOENT;

Is it really OK that 0 is being used as invalid here?

Jason

