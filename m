Return-Path: <linux-kselftest+bounces-18486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7E9887B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E21F22333
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB11C0DEA;
	Fri, 27 Sep 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXTq5ws/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06114D6FE;
	Fri, 27 Sep 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449094; cv=fail; b=ZkGIeorCB0XP4q2tbhQdv+jBrR3k5C50yl6ybyThYJQogAIk03l7UkxBcuhRD9vaVoLuYMZFwakXO2LWtqljxe89/0a0j4/XuVPIVyhsOsQddxEFUiO5LKMn31J4E+NH+VJmGirct5m58LV6k4ZxQJ0Vbn12IWt2KsQkhGGeTds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449094; c=relaxed/simple;
	bh=QmKcdYrLTz73nBtDITKkCRfdF5bLgF3348VVLlC3a78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZL0YicpB32mi3TPR3JjK49B8w+Tecc5Sp9JfPQIfm6IjZYSW8bc1MaSdAgPsQQpQNoxk5pFzQvxDBBWL5wQhZyh8gyzS+80N3g+kUrpSX/7ggk94hGLjGH5+hQMNOebSQJAHzXSFjfZ2K4CdsTaOCjy4X6vzKVI+7HlQKWLwTao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXTq5ws/; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM9SaWJ8oTl8Oz0Ax1xYSyCxdlJ0igiZE9L6NMvnuUkT+KtjoP4oB5goGmwu5Uj8mR4KVtaFhLfQnnxYZbudPl1MqlNsFzs0clpTWWB/qbbjoagw7jUyXgumv1lF3F9xg18E5bibVVULaBNdMXzxHNRdl0b6ouTAdWbfpGajf55ybLyvKIuYnbSumjjbJyEYwZi6xAWZbiZyV5cUWu0vFe3aMXcq6er6frga8TKfisVxoJkGjPPAhHiTjzzCT/8jJeUIUOub45euw3/aQQ2J53afkacF0oZUlMIAY4C7UtrfDQZtb0qfGJfwxYJwlE+KfA4EYkf6DBeTdlFGQ+GxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzPp2jEaVu6hxDXIgVzFyz/krU8SU7fvE46iK99hESU=;
 b=B3BaurJqR7ulopBMAueWrZN4ez3rchuFaxHLHmVf/nWXPnhcKIZy/LtQpKm7FtGw6vOS8gGfKz8H2Gz7fOEX5EPP9S82BMiabeTzfbNshCbGF/5yOu4iaDM18HJMlJSV7NS0A8nLZz1I4CWEwHVl2ssYOujzLckFBC5zV1vZRnxtc3F6x/NyMg5tIVcJSba+XhriuK8csa9o0x6DRp4xLTyV3uBvP/lEyClOOpHJCcdhKghoUMCBgDk30ADoin7kIsxTk03AcJD2bqdktQ5bWgy5r707BcAVqZm1L7lIeHX61nNkMXxnWfNsg7RuC1iI4tWIABD5plyz0JFT8KXSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzPp2jEaVu6hxDXIgVzFyz/krU8SU7fvE46iK99hESU=;
 b=gXTq5ws/Gd6sNDb9tbEraTGVepylzZG6TUP9SRacyGCmeHptSM9kTziEb12p7TIknKrSxRAF5/E/lfTjF6AfcQF4d52dRTVtAe4gklE4T34JoUlDyVyqksnDaYGDvot3AzdciW7shYVF03UwdUVmRdGgQvqeEMi6/L/lRvsVRusO0euy0qKm/aeYT5+TtG3aSsP+3QawsjeuuonKwHYeoMr/ZAzem3/itatr2Ae1+Bdxdo0J2Ae06kTdFDZtHa40ay4EqjL+8eD0XIBKvaJyGUT+U5XRs5o3EP1XIrzgR8A+PU6XDNSbXzwOwPxR+nRptEKe30Uz7dKsAnCdM6XJxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 14:58:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:58:09 +0000
Date: Fri, 27 Sep 2024 11:58:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240927145808.GB4568@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <Zva4PJ3FhpMlWxhF@google.com>
 <20240927140141.GA4568@nvidia.com>
 <Zva_nFXZgT4MEfDg@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zva_nFXZgT4MEfDg@google.com>
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 551298e8-989c-4e75-37aa-08dcdf04cd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2xpceZfgGXzTuUoc1+0/DzBS4mCOykJfwsaMftJiMJ46hsFoUmtlxXY/AqF?=
 =?us-ascii?Q?Lf5uz1gta23xzLrsIuxKjDof8mZGdOSJo7vpO5SlaUbR20CwrHoo2EUUX+WO?=
 =?us-ascii?Q?vi7G6lm9z+rDTVyepaC/1hRbdyLatSDfPanWfjmrMwszFdTZ5y3EwucJ/q2v?=
 =?us-ascii?Q?UXT730tO5YqZHdLPmN3ILB1XHYK5yWOHijwUyAPt9rYEg4/Xp7VXCZlwN6It?=
 =?us-ascii?Q?/MqC4GBx9HzRj49Bez394r7PPsGybR4nI0bjy4KENb7C2xu4ahMRuCVBZ4Tt?=
 =?us-ascii?Q?8vlzTjYOyzCzmY+sfVW9cjbuCChaCNfmTbf43U4Q4RPwVG+slufUsQuwvkTm?=
 =?us-ascii?Q?6tMarYn+sfa9EPyWWYXcZ1zAfkLkVT/U83WBrQmP3QvBuJH3MeblGTH4rTk5?=
 =?us-ascii?Q?LushPBJlpYQDXt7AqRkgtBgclTFmnnNIMRNzobHIMkDk7MNqD+kLmDvwV0gv?=
 =?us-ascii?Q?tVc2DDIgS5DMq6wo2Vr6lfuGgeAYb5OD+TQyxVIsUfOFyVG99Klh4dpxxYSL?=
 =?us-ascii?Q?KKxOTIxdecAwsx1v5IMCm3woZq6wIyLDzq2ExhrnWgF7knEC8fxpd3+2LlRC?=
 =?us-ascii?Q?id9xTLune49DeAPJNBUv/NZkGFw/c7L1BBH3WPYVZU5liNQ2NfUG/+7RTMKW?=
 =?us-ascii?Q?AuwFA7DqLIlx33idnRuUmWI+aGFuceDnkVUYjT81/9aOII1gEUPuBdZRqDI1?=
 =?us-ascii?Q?jyOKCJE5CQzeH8PBzOT8H2f0xlHTBt3YWfLKAQirFDFzbIIJlLMmi8Y7x9pJ?=
 =?us-ascii?Q?TXbJEu0umdSgv8rNLJjzXpPQQ7ID9k6DWZHaicT8OcBPAZ08sVS1Qz0IwDaI?=
 =?us-ascii?Q?EOtksnP4T1gbnkAVzdgJwjwKmd64FqZ7+B/i04jAX0BPNKvtVGuTJ+tnDFRS?=
 =?us-ascii?Q?WM5FLdjiCuYMxD/mSKrK9XtoD9X2UPJXmFfs+LnaYD8Az/qQzTtNxzcXf/st?=
 =?us-ascii?Q?odq4GB5F+SlvfqfFlGyQ4Jmu0JZ/qXe83Umsucj7zg2UuW1egG/Fveby+tOW?=
 =?us-ascii?Q?DyGO4aOEZImusWVpsFHvG3yJFr8ZC9XIZOf2bFE9r/QzZ5sJ5nq/N+MFaTJ1?=
 =?us-ascii?Q?4Q9OENhRuJk3rnPjF7SCGFFRyorr9CLEA5BY9tKqZXTMd8AI4bjTGl6svF7Q?=
 =?us-ascii?Q?H7rJ0xvuYGifgCdVmRV/G2y+naXsHM7FLQ4DLZ+uJnHkZCZxfSBZRwxQYDmd?=
 =?us-ascii?Q?NiwaprUEHAn+9JoEILh3fSrbB02WwqEFK4BYGYVgwuYl7us6LqoJf4GGmidt?=
 =?us-ascii?Q?llkbpo32BFI/CO1oX4cOF68LlNDi9xyoMdepTblnLrp5l0ccfar9iEXpPgIi?=
 =?us-ascii?Q?h2w6QLSAjyqXd6V7jqoiKxL2a4ckWt68lOP6+Ro7jcMIRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWDGZmIerhhc8CEiz6tVFnHaku1UpmQFhZeNH7dLAZVHtCwc4FZYxOG6PH/F?=
 =?us-ascii?Q?M+QwI20xX4Ofp6W2/c7vdu9U2lTHcUgu+BkGkVPjMo6O1qXIma65i8iN8ajn?=
 =?us-ascii?Q?czNKwUBMpKfg5zA5BBUmGxc0KFEfzf9i5ebS/zZiYec07hY+fXXPqEmgx+W4?=
 =?us-ascii?Q?fxUxmA9WCe7S/U3zrIerzFcgVfX02V1CDHLb4dGI9Y+tDYmj8p9iTaHBkHsg?=
 =?us-ascii?Q?N50O+bGGFKym1BmAidRzjD1Vs2kEKAfixPqD1bt1bd8f1cN8q8ZFkB+5dsq3?=
 =?us-ascii?Q?1lyQHY/myimDUT8Czi8gD7L/zbT7QdHER46gIZvHbszuJUVI2NxKdzpUR3UC?=
 =?us-ascii?Q?ElOSwcxOeUGljegQ/Ih7EyEW0mM7jLergJukZjw0LvMwaqnIT/nZGGWHvA9C?=
 =?us-ascii?Q?oCanC6mFeYRp/jH0+V/h0xvH94XLiYhu4ibVkth0neJcHBjw24CMfAki7QGr?=
 =?us-ascii?Q?R8EIUGgHY6PU60eNyM4MDYtC5YUhQfsxC2An/5g52NY0Z1vygwImdxy/rVTT?=
 =?us-ascii?Q?G1pZGn4yF2PW1Rbt2yf6PSp2ukcce8hieiSvPaAwk26E3r2/l7ZmJ9fhIz7m?=
 =?us-ascii?Q?CqxpApOFbdRXHJpaIuIa5tcjGDyRVl48hM2NkLYLTpsqwn1QbyhDMNcm39uK?=
 =?us-ascii?Q?8rvZUIlj5YlFRNxkDYMQhYdUmsiTbiG92p+Srlii2CvCIdAritrTB6Ylph4K?=
 =?us-ascii?Q?DTicvyyDKwE51oK1SGyJKzTZwgf6grHzWlkST3nZ+NU+0uR0UJnvz/2ZqmPd?=
 =?us-ascii?Q?Q2PqG1wS5rNbEF8vbCbckpzb4rSaxEzSZBHhqMVrBk1xK57T3e4jnlq1LS5v?=
 =?us-ascii?Q?Bdhd3/hJQiy5egZxzZ1Kq5vmujaft+iufOG7n/d1eMSVM1enRMcIlO+UrjcC?=
 =?us-ascii?Q?NO+mlhcgi740Zmeh4kaDmDqJ6aRtH0CzasZXpCMqG0IuWrOGPqnwXGjtkmvF?=
 =?us-ascii?Q?AxtY+HwYzDEmAnXNrjHEuJEsEvg0zcK7g644ZiYAWtSkPhL/ffZJxA8nwmt2?=
 =?us-ascii?Q?5cytX+oAjaUHolYmkQwFvtNkanYyDMCUYleq65WL0vVaKb0kc8LqWGi2UwEH?=
 =?us-ascii?Q?KpZXt/TP+XONFz2PblzTQIMMLbm9Fz8CU8ShHJjVH0O/pVxIbdb2Ipj/9MLo?=
 =?us-ascii?Q?8FnvIMPBhO4qTdOR0+xpoEO9fHTgorQi6W3q59sntpPaftFeEouHY0yAq5CL?=
 =?us-ascii?Q?YHxYuJgnV/7sfgcsW7SVy9vPQCJ8Orz/p0wc6YDTNcjQ/P9ZNAaPwq9DUZBH?=
 =?us-ascii?Q?zPi9cmEjwQwz14xKPgy2dVGUjti/uL68lKqmUySj/UWxFujm9YuXnPmN+rHB?=
 =?us-ascii?Q?W01VLooobuQCC/TFHbG3cCTutlJW8RDCNt769rRCyZBguXHtca2tFHDixsrY?=
 =?us-ascii?Q?2JvaxcuD2lyKNmTckypPjH4LNJdM8A13CvzX8c9l0MTBdKtoOAOPGeFRuCdY?=
 =?us-ascii?Q?fq3bLmd/Xu8XrEbQoGEJ3303274sSabylTb47FTyR/7KnYdHsDRFZvoB4fYp?=
 =?us-ascii?Q?cb8YaDueYE4pm4mXIl4Rr2yrA/DWLDGOuIlUMbsSp5iT+gfmI2T4xyqT2GBz?=
 =?us-ascii?Q?fVehEaJpdic38NAmkmI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551298e8-989c-4e75-37aa-08dcdf04cd0e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:58:09.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blWDX6QxT+8n9htGQy0BBqnVhuPOQ/gyySIUPtTYKqlMiUBLyR0Hh3yTp0JPckcx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

On Fri, Sep 27, 2024 at 02:22:20PM +0000, Mostafa Saleh wrote:

> > We don't support multi SID through this interface, at least in this
> > version.
> > 
> > To do multi-sid you have to inform the VM of all the different pSIDs
> > the device has and then setup the vSID/pSID translation to map them
> > all to the HW invalidation logic.
> 
> Why would the VM need to know the pSID? 

It doesn't need to know the pSID exactly, but it needs to know all the
pSIDs that exist and have them be labeled with vSIDs.

With cmdq direct assignment the VM has to issue an ATS invalidation
for each and every physical device using its vSID. There is no HW path
to handle a 1:N v/p SID relationship.

> Ah, I thought IOMMUFD would be used instead of VFIO_TYPE1*, which should cover
> platform devices (VFIO-platform) or am I missing something?

It does work with platform, but AFAIK nobody is interested in that so
it hasn't been any focus. Enabling multi-sid nesting, sub stream ids,
etc is some additional work I think.

But what I mean is the really hard use case for the vSID/pSID mapping
is ATS invalidation and you won't use ATS invalidation on platform so
multi-sid likely doesn't matter.

STE/CD invalidation could possibly be pushed down through the
per-domain ioctl and replicated to all domain attachments. We don't
have code in the series to do that, but it could work from a uAPI
perspective.

> If possible, can the UAPI be designed with this in mind, even if not
> implemented now?

It is reasonable to ask. I think things are extensible enough. I'd
imagine we can add a flag 'secondary ID' and then a new field
'secondary ID index' to the vdev operations when someone wants to take
this on.

Jason

