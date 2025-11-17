Return-Path: <linux-kselftest+bounces-45757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DBC64E5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A162834D88D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7273B265298;
	Mon, 17 Nov 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRgCPfNM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B07405A
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393664; cv=fail; b=M61kNJSkEKVqYQRUfLZ1aAuBSjuDwaHhFIbZq3jLOIBveGdcyBJuC6lbiJOYMpwmbFk4VHlpxTy+3Q8rnVAiSqiqxsRucI0XqsRuajvnpJIQFNHNr9OQIwEUBfBo2BOZtPmdYHLg4T/b+wn3zCV+3kYSvVckaznshhpuuD49tp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393664; c=relaxed/simple;
	bh=uGjgrKBHY+4LDFKjpRcRanPBeq/XFisJvMopN7862kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aH3/Lk4qSNl1XfaP/hoAFbUh0LLc/fFIK8f5qlfTxd8oXb7PhzbaYJRGsi9eX7h9Kh0+8cPFaupqnqQWbOBvKPkBNrYDt5O3QuY0sEwTepiS98E0KEjvN0LZXEDir+bs0P7yRYuClo5eZVRiTo/HSvrrXVCZ4ympGGSi6vS+0O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRgCPfNM; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNWbQuwAwSS1yVoebh+VWXYbqgQE6VjMZ+M1gZncJBspbJgcaIfHU+z/xjiYK1H5djONO4MKjIvb/L9LWgjx+SDVM2Eyjfa3eYp0un2VZac4NJIV8EA2O2CSahecm/sHIpULLcStX4g7r9B9++/FS6kbiEoU7YqfGzfQ9r8a37060QklKfU/HRRlovekEbMVDwacZz8AQ5kiuUna2T1QZ+MEqayabSvEdBStU7KYayAbjzaUROXBkxoyWfXgOTY16jNHEu9ro2gBc+YkXtsIWuYcQrMg9JBYQPx+R8coZNxl1pafXublA6zR1e224QSk7AEs9vtuh0Hb05ZrBob+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=334kaAxn6GXWzwVnKe6mr8qoyzDIIk42ANueEcd/kC0=;
 b=WUMewXWe2m9k6GbAqdqmntbfDj31iYfVAik5NwHipF03dpXCnY/AalJ/I2DyldB4PdFF0g1vi0qH0z3EB4Yoe+nEizFVLrOZoCDHCNuwUsJ32bVqC8KKqZofuOESoI2yscL63t8NONUc7E5vJMSb8I57zsWjy4joZGBr/VRA6osJ7bqqsbm3DWW3UkGDIZicsuVOt00JebgjFBD6wkzNKaUPxIHcr9xEsB9YpHfk418P+Kgta8lV9aNob8CRgPMOv01z8Tdq1Pz87rfM6DejKIeY2Ic7OOdVQZswBXtUgUmABrUQJuY/f+EYulBt6SBmyzA40rvXH0XZ+2GxM5NMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=334kaAxn6GXWzwVnKe6mr8qoyzDIIk42ANueEcd/kC0=;
 b=cRgCPfNMlXVx9XYFv94Fj6vQr1RAsdYcltLl6D9p4VIr5/4l0HlzBIYaY7l78a2qzI5G7YSRqvbSM9JHoF6uIrx3SiqK5ztsTFJ0TvF1FTD5XQYKVyXwHI+7XwEJbwJvRIyqJkAX5XEPt4hYPtA8fnHLOXOvozZzz8PZDknKpInJ9vw7nKYJdHGlSwuOX53cu2fJYiOdOItikk/5d0X11p+uTxv/MSoRNlEnoLSCN6jEdZ97+4/Ev//dKhFo8fM9P5GteJDdrD1uY7ux4wNecK2QQeU+nE84Qxk6eE7etFj08MEiw4wZYzWrhzyiQUv+halpVrR8zqh48D4/lrOGrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:34:19 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:34:19 +0000
Date: Mon, 17 Nov 2025 11:34:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Alex Mastro <amastro@fb.com>,
	Eric Auger <eric.auger@redhat.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the
 range is already empty
Message-ID: <20251117153418.GE10864@nvidia.com>
References: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
 <BN9PR11MB5276EE15198CEECC799B3B568CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EE15198CEECC799B3B568CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fefe19-30aa-46d1-05fd-08de25eec645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hxm9D5cw14w/gvSLbbQoc/lMr/lNje2sqeuYz0KIUMd+bmgqbz6TXvXSBMFL?=
 =?us-ascii?Q?joRi1CZkbquReZMhe4cC7WliW7FIXXuqlHg2qpgQehj8m4M1SQVhWBDEAwag?=
 =?us-ascii?Q?G25faVtiaw+of6W4A4Pnl7RRK6mzQuaXGUD72I827J4p84NhE7hF3rSEHhj1?=
 =?us-ascii?Q?S1ZWkAsz/4fBDJZSIuvX0DcrQWD0mOMgSscPIPw2IQmX90scdOmEXAbTYTSU?=
 =?us-ascii?Q?nPZgVSr2kJrtScE+H/OVAd8KgKOpdwMcr6ZId1FTJ1Cbp/n0pvOcHWjbxxW/?=
 =?us-ascii?Q?1dMrA79jMOMf6sCl2OYSLuBNtVkc889d69XXx5e2uj8iC4UfjXFgC2cRzCKn?=
 =?us-ascii?Q?jdbGEF5rWZq75dWAXJVJIj1drGhC2pMPHDOxSiuN/oApF8JOTmiGVvGu29r3?=
 =?us-ascii?Q?FAHw50WGNTIbBQBFpyQd/w/ta8mkK5lXnwHNXlbg+L5vb8Rc2bP4r3sCNH89?=
 =?us-ascii?Q?Xx5Bc2P+0Sy8WMgGbKptb50yJRg592BP9IqnbL8WtzQbNBtdmaRM7aONcAC5?=
 =?us-ascii?Q?bkMShUi37Aj4zc77jgnkl7WKsmpgyxx0H1z6gJ/uwgRs0T8jRY5jlivMr6Fw?=
 =?us-ascii?Q?9LFdFqWresvHaPPVB1IEF8YiR0K+IFfQXu1mkvsP8LSv9WShbenLg/YiROLs?=
 =?us-ascii?Q?mHwVyMsECxCSTMbiAK72McusvTVar05NKuvciQ9q0R88xg2iEmmPytVquxxV?=
 =?us-ascii?Q?qgKsP6Emaq9ugOp+5TezqM/idehByZyFjQgU5O8GCrKY+WNmcFZ/Uzei0I2G?=
 =?us-ascii?Q?zgi8IdC08uYmwgR6howjpvk2O/zeQvH1L0FKTeMBMwv73Sn8FAUUo6z46nf9?=
 =?us-ascii?Q?6NiYmxM5ZJ4NuDZMUDQgLewv/P8rYJW34XfgSDBmvtZekJVsHCIA0tzI/9VH?=
 =?us-ascii?Q?rLgzpwUZIuo6inz/pdxeBzYFoVunZ/HT3gwAfGj/1lyAGhH8bTApGMJ1gcOl?=
 =?us-ascii?Q?1dAhY4vTw1nEnk+ZfJiklEC7Y4YnOXcQNJaSQTSuK8ZzBiX7K8VlRBvhrHac?=
 =?us-ascii?Q?stiVG4rBbBoubfSCIQ7zwohcmBqLeo7JXGEkznWvUx7sp7Avm9CNr3RSrVKg?=
 =?us-ascii?Q?5SQTKpm+gOzxmXJuoT1ruffJOvCC2nFqAudl17keFEsX70L9rMrhNYSltEyV?=
 =?us-ascii?Q?wlhrHn4PK+72TkVhA1LTIIBlQFQM3+MasGIWGZE1UI1T/fiIadv6izxaD+3I?=
 =?us-ascii?Q?0tmEGnHCj6ncKtO9khy9D9tLufUHdpBI+SXKKID4leHrnuj9RcIz9wJ4VVF3?=
 =?us-ascii?Q?0Gw9mZuuik5nmA7mLzxgt/5oIAuJkM1/wB/9uhTY5xPKnj23Vi4VI5hWC210?=
 =?us-ascii?Q?QrpWpceugqgbTC9ky4mQSE37UcUw1GANre/PNKWqIHC30ObKlm4fb9lyj75C?=
 =?us-ascii?Q?HI1u9q7BGD4xLX9oktbM7M7XUWAVmbyQYrrYCyiRsK5ML4Nke7cuw+bgvdQh?=
 =?us-ascii?Q?isOeChRJ6eQJS75mAPBVL4E//ZT4X2mm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cA9n9z1ryVSXeYMi7DdJCGKS1cs7x69aZoXmvXsYaoSFQ98CVguEvQRlO0AY?=
 =?us-ascii?Q?PNllFvZ7yzlKjjImF++ZU7d/UtsI3RZDA1OJ0LaKYn7+hzy/wnX1xPLgGJSe?=
 =?us-ascii?Q?GMq/0Z8QgRCzh788Nw2xVDnUKSqjkUPE7IaAjOwxBsjwZI0AU3BDu7j4HkQe?=
 =?us-ascii?Q?cVJ6ENSsL5sE2KTDVc70DV9vTzI7V0HWIBkHsOesmgVc0xG4TFtHBFB3fXz9?=
 =?us-ascii?Q?UxB6CP7/vk1B4iv1KeMdtrEPHIfkGrghr4XawejJrUB2ftyBMZOlQtceSUSL?=
 =?us-ascii?Q?EmMw8O2aLKnqU7KEfSd2u/ZiiPCyluwqfW6809SjN7uek2Ou2CHsuggNsU9m?=
 =?us-ascii?Q?m4zHOCNrTn8jg/U+W52xkD6ynozAsbb4ryDXrJkry+6pRYKTjSJ503viJFh3?=
 =?us-ascii?Q?HXmsDvm0RvZQUQg8JWN+gPvWASulmgeyDML4/D8uVHG5cCYvjA7x6/kQAXJr?=
 =?us-ascii?Q?4L8MvsrhTg0aVYv0Mi3U9HWq870N9qObjE84qprgwEs5goaV9KFIAfyXPNQb?=
 =?us-ascii?Q?6kxai7CRYgBdZM7R17vkLoO4muozn4MZQWhi1UTd+COAtvlhbpyYCIFhMOVF?=
 =?us-ascii?Q?OgAZygF5yXhQmT21lcl6VRcx5dU424tNW/Q6yIVE7J9++xK93NAl5/Lplmgf?=
 =?us-ascii?Q?4/lzcTuggpfVcGh7GsHZmHp6ODWyBUKhxjCCTnkEpg6OhHZ1r9dGiDn6hTN3?=
 =?us-ascii?Q?FMBrdmHij2/S0/EXkRust4upQwLmNsLBcgtEoSA9ARro2oQrbFuwzD6sthur?=
 =?us-ascii?Q?Gv8gLCBLA1XgQqc81LiAfdXZyiugLOSi0wKeJ2gMKRibpN62OKUiOCnitutM?=
 =?us-ascii?Q?gg7vhDOLMgJngkEKckPhT57AEPHY8Rd0TSNBUU2U8BhHGgz31U1bxIipfQWj?=
 =?us-ascii?Q?UaGro38qjaRfR+D5JSQAF6QpvnY3HIXS0kuKm68coczhHDRlh2OCqqPvGujp?=
 =?us-ascii?Q?x4oRllwfGCDOP0DyKIyDWAlGrBMugXeDFiQ2NXYRjqH2AdWplMS2W1yNS7X/?=
 =?us-ascii?Q?4Bdzb8RUIU5drw3tOEXIsALMFPhKtHTKKcsp/hnI9ElQaqm2H+o2LaARERyK?=
 =?us-ascii?Q?77mZ6HguZkj1T78UxgAcwTLKmuLS0Z9+miqblTZWYXxfSN0IXSMFn0KaKMPi?=
 =?us-ascii?Q?e279UPrtnThkExZ1bl10u/Pa4Obr38GIurxeucPjDMGNUh6n1ei3KK9f40Zp?=
 =?us-ascii?Q?RR0YGb0HqnCAfOzHCa0/+ft8GCeIa/dJmlQA62oDwRzpJ7f6UJZayokVf4r+?=
 =?us-ascii?Q?rDU33FmnbBuAW6x0B+MQnpaciWF7dl57xUQIoWbPVEfSwNBZypcsqp+R881A?=
 =?us-ascii?Q?l89fgjG4XpZBHDLpCTd+xsFUtTFYVUXNIzEKajbpZukGEfNDudUds6R1d9/O?=
 =?us-ascii?Q?Eog1EBlcQDQx/TJR/OWSRz4iFZTrldvuOCiet82XOyyMLLnG8Aa4AKlX/OcB?=
 =?us-ascii?Q?Is2SxVv63uefT7wG1udh54qX9EtkzhI7KiousnObR6vAHooDz1Rb5MF/j7bl?=
 =?us-ascii?Q?5vXMs2PPys/9kMpMMoJLro28a8G40/XKVE87ZcfLLo4eYobPi2TXnHJgdnel?=
 =?us-ascii?Q?glj3/Xz0KETtXA4RiJY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fefe19-30aa-46d1-05fd-08de25eec645
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:34:19.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5nqoUA6UQPHxYdsSP0VtoPjk2ruyDOZX+GEYxhruiTP6D1+bmG++8RfRz+fmE9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

On Mon, Nov 17, 2025 at 06:56:56AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, November 5, 2025 2:12 AM
> > 
> 
> sorry coming to this late, but why do we leave inconsistent behavior
> between unmapping all vs. unmapping a range:
> 
> >  int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
> >  {
> > -	int rc;
> > -
> > -	rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
> >  	/* If the IOVAs are empty then unmap all succeeds */
> > -	if (rc == -ENOENT)
> > -		return 0;
> > -	return rc;
> > +	return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
> >  }
> 
> here empty IOVAs succeeds, while...
> 
> > @@ -367,6 +367,10 @@ int iommufd_ioas_unmap(struct iommufd_ucmd
> > *ucmd)
> >  				     &unmapped);
> >  		if (rc)
> >  			goto out_put;
> > +		if (!unmapped) {
> > +			rc = -ENOENT;
> > +			goto out_put;
> > +		}
> >  	}
> 
> ...here it's a failure.
> 
> from uAPI p.o.v. better the two scenarios are consistent?

Maybe, but this has been like this from the start, so I don't think we
should change it..

This patch was about aligning the type 1 emulation, not changing the
existing iommufd uapi.

Jason

