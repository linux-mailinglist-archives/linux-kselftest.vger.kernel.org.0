Return-Path: <linux-kselftest+bounces-24446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30DAA10808
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EC33A48C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D42309B4;
	Tue, 14 Jan 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GYlT/hEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807611E47BD;
	Tue, 14 Jan 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862124; cv=fail; b=uzO01k3zSZV40ndMEXvt9087rknNhHqrTqOZjYUndxbupH0vQNFo5NIavya3vX4i3PtroDWELa0l5cGs3B7eNMejxceWQLrUNuxw/AlmWGa81RrC/yjJlT7GUfpM0rT0DNZ0fC92u3PQCTcRU0pKUuLpYF801MgrnGtdeEsdqRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862124; c=relaxed/simple;
	bh=wqXmCyZVqjCsulaZY9LBlfxFpYpdmH/DxfotB5Vty/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XC0JIuIwLJ9myfzwFDhC4T32U7DgowVlKxm6RoYFinBpe9KnjGFIBRDeqgg4dZEjphN0XrzDdyNiSInfKVg+L28+J5Ix9TunFMtboDuATpSdNn8c/NYtHuj7N6unLlGdb/b/gdnYJoX77f9tn04cq2kRAwPuN9Yan4dTkl7vwIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GYlT/hEl; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw2j37VEL7Ef4PptNFqpmG9uXuHzb1zAaJahAOAihioWZn95UhPwK2a4xbKipgsyS1w4vLN1pcEp3oBmED+HrJhuYyZWZw3C8OFLWs92Tm8d/NVrVqMlBUfCklaa4Fas4IWjm/A5By7RVqUA/eCm/6bOXXBxpDILEw0/cIm2XjpWNNtWJxjRwUWUjHNHIVAd35BmjDrSs8+Q9h1RKnDNQhTWjbGaUIaE6LICnh9Ro+tEL8D6cLaHerVsqqQ2DjVrtn84owDlreDfvn1O+357ZnWAKZK9TuwpgRO4Ue1BooipzEFJZ7wziv3qFFJ/Z7K8oLrMX57a1jeUbThyOaiDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuIeOC0xwsi/HSF72cuuZuvlATE9GhzO9LJwy0QUb0E=;
 b=H3ebTBqgXyL2vWSqZ52IwR468S6z+mYT+IoNXGeuNJSjUpuWTiB14Ew3g+J711bVleBFWGvohiF3L38db08A6EnFsFhGrarkbWlG+ZIYpMLmMbTYwMLlskWCV9Rh932+dpgvx5WKYiUXxxJzSXQtRy6jifV71X+g8HUQYLk3mcAIsqvQx9BGEdmRequ3lITQoPzse3LIlZBEn2SiThsVW+QaeKVqiJMst16GHhzRZCxDJFyIvWNRZDFZkMk+3EyQu2bfhI9jTpL3GHlagEUG/VjzKuY+NoiUBoJ7iWhJKNvzy45FaCKBU6ow34T/wDa7I0//z0o7NgFbdubD3OXclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuIeOC0xwsi/HSF72cuuZuvlATE9GhzO9LJwy0QUb0E=;
 b=GYlT/hEl9UjrKqWz9d201xiqHrCEK/cz/hvKmUmYoxSLgdi1SDLeIp3FoXqkKgWcNT/KwEUVI0wLqa2xat0c3k83/poMKtsfVGJrmlUxcfluBq5LG9seMtUBjTVbmK0sbDy/DneqkKUR8jdldajg3hDcjen3w1v1j+yhXqoEqknuJE2DoUjAxfcSphC+zRGnV6lW0aMKZAlu2gp5GB8qTu0yyguuM0qa90u/IDW16H0OamxxX8EYCxd9dwWb7GEtwIOARRjgLGJhvq81YU4ZmVCY2h782t13qObBlzPdsJQQ/VfHpMiEenIraqr0JBLL3s0x2FAot0aYAJY5H6Xorw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:41:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 13:41:59 +0000
Date: Tue, 14 Jan 2025 09:41:58 -0400
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
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250114134158.GC5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:408:e6::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab389f6-4e90-4e2e-c9ee-08dd34a1382e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yqV4w0fxUYrXDThN+zyAgx0nKd0KQyWCND83TWReAPwfq2IZcDw6YQtuj9qe?=
 =?us-ascii?Q?Wtg3ROSPBbOEavHTgAxXeHKL7eDYkpV6k+WWpmwJVuZ/t65+U0xNVDVb4qzR?=
 =?us-ascii?Q?2n6MYT1T0dfzIJ3GqXCckGGGeXxjAC1FLuj/WDb7Z6q2oMgqhYDLg88G/4yT?=
 =?us-ascii?Q?y6R9MriNrEXy3HgyxCYBddv/MWlaIGQsfbj6TR3cSkEdnwmIRFvc7wLTkoe0?=
 =?us-ascii?Q?Bb9F8sdvjFyWrBJjyzu+PoItVaw4/siNDwLobj0z36aV3QlN1yt8BweXJ9EN?=
 =?us-ascii?Q?Wz55FxUbpPuVDswfnOxOjmrYSmg2aE9+/752+ODUPlaVuEBeXmFymZTUxsff?=
 =?us-ascii?Q?bQeUVj6dLMH59p9z3ogkjRhxqXNwvoQ2d2OCQlB/Gf/tOAs247AxasuVSCSM?=
 =?us-ascii?Q?fZKAfzO/m2054/vQizQ2cwwz8xUKpfYoyAi357gbkc/sem6O20LaG8cYvxDo?=
 =?us-ascii?Q?W+50eX0B3/CQ4K3vmWlKGMaxt5lbZroWNQH+11JyQShNI6uMVLzEm+mrufC8?=
 =?us-ascii?Q?34nEFgzQ2AWNqaQpR3iBTOMYtGaYxiEmZXo3i2jNjigBfrlZoYoQw9VxP8tD?=
 =?us-ascii?Q?PnaU+TK5rIcmVRHc+FX0Qo8kJNmbnoZWps2W9klgABxnXMR2X4eiqw5q3EIR?=
 =?us-ascii?Q?BYWYmIdebEdEVCNYxGUdpIUT59vA7/3b0QcPj75KVzfIcaAvhbgr2mQ3YRQA?=
 =?us-ascii?Q?DUifCkAhupgzU1PpZg1nbUmNML/1urZ3j088FKPXNg9EX85McDCkb2RsjgJb?=
 =?us-ascii?Q?8QnXEQY2ufNMMdTduDbFal42VNfp09DSzYvNAzKHgBSzfeR/0FAI83EboU61?=
 =?us-ascii?Q?f7djqT4Y+dbrMG2YW99p5GyS/fFVsD0pKb9hGF2Kizbk7550Kf+C8QptM6Cq?=
 =?us-ascii?Q?uZjgW9o++Paso2XpjdlN7tJpEJJ0c0mJggAF5eQob35AIc/+mTHbo4Zx1BM+?=
 =?us-ascii?Q?dqms7YYVPLLvWPBfmlQmEDgcVh2MKBpq9Uz4oeibzWkTzbRdLMwxh11KTX6G?=
 =?us-ascii?Q?HIA2pz5ELGzcie/yt1BKHaKm9eGdCbyOlh65+/ZOt2uuwZxYkkwNufvK6m6Z?=
 =?us-ascii?Q?9IX3gU3BuLhF7v4m7kMA8GRfmq9K7LmBLhTvF+52+ettSnF9k2BokpO7z+DY?=
 =?us-ascii?Q?tcwMPxlu2qwm7596X8IEMPABvGI0zNgO9BmFFiJ6drkDcFXRYDwmfBqkX6aw?=
 =?us-ascii?Q?BD/xGSxjrqm3xQxKWwsJMhKV4tHEmkQvORH/MgMiiPpUjlLEmBLpe3YMSwjY?=
 =?us-ascii?Q?XWLI5xe05L6csFp8dtAG76YtNfOw6TVN7cWaYuP0lpnji0xeaOdW+S6/fths?=
 =?us-ascii?Q?Dh1TpmxtU4AmPb77cG7pFN8WL4AouQ1hMtoBlDw265p7bSM8p5dNhAiq1Lgk?=
 =?us-ascii?Q?PR4Ma9TKMhovyjyPncIFp15WOqr1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ur8ssEaFqXgug4tVPFOT9sj3BNEDoqTEilvV3wDp2fOIW8jekwh3p3hr7F5P?=
 =?us-ascii?Q?z9Ya82dTCDV7VENOiIby5NlHpxPB7E4wQk4Ci68Wza7Dfwszkm6iSnrwXhol?=
 =?us-ascii?Q?qRIyGIZke9R9XtEo2tUtuRqfYRihPXpj49rDLMHq8RdgUOIc8NjSgoGvk1BC?=
 =?us-ascii?Q?urWih3w/eK0T82MJSLG44cpuOhvaLSGLad4bWJjXCj8j1QIkh81AhenS6nDP?=
 =?us-ascii?Q?k8G/mQIS9y+la9A40SSqVRUec/HJU7UXZm103eMfj89ORQ6ULC5WpTRYjSUN?=
 =?us-ascii?Q?1qf9Ri+8mOgZdr/VpmUUgiQRZaLTgdaq/l6Z0UZdslGX5tAs6auDJXoiGwuR?=
 =?us-ascii?Q?iydg6e9boJGroZCnciM1dEv4l5hVb0STKBIf45bt+xh7fG2pvpy8fq1Ra2u8?=
 =?us-ascii?Q?PJFkOo1uhMOzRrGN2rg5MSKmssNE+XCgPd0mPAVPBOAsLN4oIE7WCm/vsxoV?=
 =?us-ascii?Q?Y6kYPDL9xBHzu8SNyvLjGVCYRNWUBY5B0fuPLnL7C822xKetaC17unFXQMzQ?=
 =?us-ascii?Q?9kV038aGBTzMZ+xglHsneEkXOKKgmmk6vYRk7CTOz6vzEUY3IhhWl5Luzdtv?=
 =?us-ascii?Q?flzQFf5GMdHSscL1XlWb2xHNlAeVwtwnXNn8hyJeEeIHQxeRe9xKPH8AktVf?=
 =?us-ascii?Q?g1SScZyX6zBNLlORDOWFK+0J1O0h8k7nXzQDCJ0InQiCecBVNf8AHyWMMI+c?=
 =?us-ascii?Q?aDNnix8xXgAIjMdS8WdKTftd268rjp3XtkvEoMeTCN1Ac4ljqkQDk/0+Wa6A?=
 =?us-ascii?Q?+Z0e4NBa+FGxQEZfYTYoAL9InEuHdFEtHZsBE2md8qEn/YIt5RcadflGf+dG?=
 =?us-ascii?Q?U51oH75hs4sJD8isPs0i9ER+UiUosBHzkUfy526ptNlYkVEep31TA2t8LRF2?=
 =?us-ascii?Q?HkA7nkVA6HHBxA4Bkpo5KvSMox7jzCdOp3jRjb0iXbnZE3F/HdN92YwI4Rhe?=
 =?us-ascii?Q?A60sCxYrLYHVlT8Touc72D3WFiHKzIBooTguw99y7AnOX3rgrnjPZmEjj/z8?=
 =?us-ascii?Q?tTeEANsOmz1lk9SZX38i+CLyqcl2hc08SIpEpzU2rgLKVbQp7WenofhqNBB6?=
 =?us-ascii?Q?yrMllP8bvgB1IO8oc79pJHeFGcQYM4z8gYa3n7unEAM68MIoPFhUyBsesWu2?=
 =?us-ascii?Q?3htj8NLU/AhP5el+mNDB4TvAnO7g5Puhy979V7MYNcDm2w8mzY/fp+W1GrGv?=
 =?us-ascii?Q?tP6FLAhIEYMylIpdN7OJ04iQG67NHkzW/o4lE8uZeAhRx8neB3YeOwqDCBxq?=
 =?us-ascii?Q?bIzHQqV18fBpPapDl6JwmTG6sDmqfnApqNfPWidEtePWVXR/2tUx+38LaJif?=
 =?us-ascii?Q?1OsSxjnbY98kxjM3YkO0SD16CzeSIwvS/X7hlZlUFulpHizgBES7lFT6+mIg?=
 =?us-ascii?Q?WXAJyzs7IcBBOBnij2qXTMwkoVKYEOpgniVD+Z6+qgtvh7ar6DvGM5/lTMMI?=
 =?us-ascii?Q?/KDd9MLgPXFnTc/TCdOq1i83h2m5VYnxkAHHQEYlBuipzhvFg04Z05yWQYWG?=
 =?us-ascii?Q?X+NWQ7hd88Hh0E78O9vJGWvwnGQ7TO/iJ6ZfITUqs0HZpUzpjKuntQdfsgnB?=
 =?us-ascii?Q?WrPugiQFQzqG0fQo/kGzsDnRz5RPxo7IeqxwWIhy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab389f6-4e90-4e2e-c9ee-08dd34a1382e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:41:59.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCyvsdyyUkjSr3FWfVxhQd/v0nW4ndox8MwBXaLe9h44bVIzMtr+CKc1uC2GifsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

On Mon, Jan 13, 2025 at 12:44:37PM -0800, Nicolin Chen wrote:

> > You'd want to push a special event when the first overflow happens and
> > probably also report a counter so userspace can know how many events
> > got lost.
> 
> How about this:
> 
> enum iommufd_veventq_header_type {
> 	IOMMU_VEVENTQ_HEADER_TYPE_V1,
> };

You don't need another format tag, just describe it in the driver tag.

> enum iommu_hwpt_pgfault_flags {
> 	IOMMU_VEVENT_HEADER_FLAGS_OVERFLOW = (1 << 0),
> };
> 
> struct iommufd_vevent_header_v1 {
> 	__u64 flags;
> 	__u32 num_events;
> 	__u32 num_overflows; // valid if flag_overflow is set
> };

num_overflows is hard, I'd just keep a counter.

> > This seems most robust and simplest to implement..
> > 
> > I think I'd implement it by having a static overflow list entry so no
> > memory allocation is needed and just keep moving that entry to the
> > back of the list every time an event is lost. This way it will cover
> > lost events due to memory outages too
> 
> Could double-adding the same static node to the list happen and
> corrupt the list?

It has to be done carefully, but under a lock you can make this work

> > For old formats like the fault queue you could return EOVERFLOW
> > whenever the sequence number becomes discontiguous or it sees the
> > overflow event..
> 
> So, IOMMU_OBJ_FAULT is safe to return EOVERFLOW via read(), as
> you mentioned that it is self-limited right?

The idea for fault is that we wouldn't hit it, but if we add a limit,
or hit a memory allocation error, then it could happen

Jason

