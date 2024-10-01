Return-Path: <linux-kselftest+bounces-18738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953098BE38
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDDF1F2237C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6391C4601;
	Tue,  1 Oct 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5R4nGsc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE41C3F01;
	Tue,  1 Oct 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790270; cv=fail; b=tt5HFFc07Jnmehmm5YdSE6UWhJDNLE0QmGgcDCa620AzuJxu0vQyQ6/cQvZv8YWYnJRZE2cEyUbT/k4n+KKeGbS1WxlghHIi5COcTnZU/Es3/Ma4TT6y4jRay7wZUNsf5MDMGdUqDaDErfTOOxbZD6URLZHA+J2t29McjkE8b0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790270; c=relaxed/simple;
	bh=rNEbxSrpEBD+xcaphe+geNaYiANNiEkzZSXelb8qVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6PS/XZ1PTkzOco1J4LS4QnAISurNMoQ7jJIcMP3G4gOpzFACB39w1+/UWM011KPMJ3HQyqCWt2atnY/gaWwNFiynxs9aMMOT2rtUJQHxbtb3HZNsMhCnmwg3zxaO2lrmjM2lokVStaYQCI08y8OtA38kp7jcD+L5qUHMppYPx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5R4nGsc; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylbzFs2dKTP0XHn7TOZ5dIYsEP1Igy1XWWd6V89IBgbuHh8jHl3BZ2FxIRMD8yOLnbw/qY6ZbWByyBtk7rJfRbfKLQA+gvtqayEUbjlbovGRL2vHWNRXLKVZ2EOEtRp+gs3/M1hoNK8LYnf3XFtthMzAxW5/H84d//TqUKy9HRXDqmTcGyVFcZ9PzspxnY1U14GCWiWkF5nVsqzqRH7BduMVreLtbS/1gc0AK1o3GDzSl+i+KnBCyHizT6pJ0bPOaEHb2AfFM4C6g2p5eaAym9JixWEfyGp9Clt/++nngq4hSEI5toJgwM2K1U1HZKdUIh4d5V8HOYDc7vNv3GmKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNEbxSrpEBD+xcaphe+geNaYiANNiEkzZSXelb8qVRI=;
 b=qAcD6ecboej5jRafhFGu4oK/eCLlmvnnTqZUjuYrfDNC9syuZ6bmXOf+hIc+SHYLP3F1ymca02vErprsuugiqLhgVHdr/zKWDLkID/t1I3HjLA8PZJtjOAtmERF4VftExXXq7Rp4exemW5tis9mRykXD4M5ex4i5uA5vh6tsB74i3Ya8FxHR/R1l8UpIHVfHgwkUPznY5OX8Wc+0zBshvtRSGeJpAwRTKwiTyN6/g/Qn1VOftPDdkrfkVfpoYM3q9ZvUOE3P8sXpzzdLlzPk7sYFt6orjUXNytH6SMYwsspp1AliVT5pI7ZZ0dE/EAMivzOs9curGDmiMl7o1IdY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNEbxSrpEBD+xcaphe+geNaYiANNiEkzZSXelb8qVRI=;
 b=I5R4nGscyKipE5DQ5WH3KxL2sKwxiW2zAWgYAlzBIMYoB7eQZ+hcHp2ij+ZdzFxwg2M1y4wrvoFSRWNfiiPja1+EkWjn5lwM6rTtbg6llCnfgurrcXwPynDUWZwJy8e2xfFjdTW/NxJ3VefwPs/MFxUbqRKIqYWMVhyzVufW30SRS6Aya4Gky4qMkNUbc5R8mLdnRvE94gAZUN08r7Y+MKrTkdEV23f29wFQBoo0EvY1tjzJWKvcOztsG3P5iKa8ieM2QVKUHdXGDXpSSIXRSFVdJplEzAssC1C9h/uRnseuZ5d4kgwdjpr/MyjevGWzEZgHDX4l42HGUJgP1pu5DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 13:44:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:44:25 +0000
Date: Tue, 1 Oct 2024 10:44:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <20241001134424.GE1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
 <f6899837-b908-4401-bbb7-5e205b6b3a88@amd.com>
 <ZvtuM1nG8UCeCLdM@Asurada-Nvidia>
 <3414d639-50b7-4175-abb4-b3d87f5744f0@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3414d639-50b7-4175-abb4-b3d87f5744f0@amd.com>
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0da5d1-3198-48a9-2f2f-08dce21f29bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nytSkiI0o8X6cT8pL9EwoiA4hKnbEU9oT7yu56TBjIx/NhWUPAlXclq0R1a3?=
 =?us-ascii?Q?e74x2S+p9QMiWUJuVhU02a7yMKXRCl6iXQWHFQ/ApWt6TE5zYb9QMmFe6PzB?=
 =?us-ascii?Q?2anDS23rj98foa6ixgFubdb+kyzTjNCc7rHDm/DupmuDOqSQGFA9rnrJtM17?=
 =?us-ascii?Q?Da3Y0mpCQZ31/A5fqyQxUxhCkD+qsdTXPXjDKSUmyahI5Hs0QEsowQWyHDjF?=
 =?us-ascii?Q?OixANKyDN5zzYNJnvJg+fcjYMmeoalidGyW1T/2S2WHqnq6WEboplClhksRm?=
 =?us-ascii?Q?KuIrkZz79GYUj6my87iyIpqobJD3vm+FwL4vlJ8C39MQGN3TlZCkJp27fL2M?=
 =?us-ascii?Q?7m0ScH0MUWTfYvOkhE+Xg1xsZKYw1z+61Tfg2APL0PiKracVrFAD7XQ4Ni+Q?=
 =?us-ascii?Q?gq9yT9npm+z4NsxC8c68VbhJ7lqwtCfFY6ewDPDW2otJtDhm5M/Afifxzf6X?=
 =?us-ascii?Q?5aMPREBJ6z4ccIkM9pW/lKP67Uw3khiq2OKXSiWIf0vjyCXQ+Ni4C1hYDTNo?=
 =?us-ascii?Q?NCgul6VdKBQhyP7J8j9lHBaaEiO5wthhNgQYAcdjARFZeHq5Hw8kXGdJotyp?=
 =?us-ascii?Q?J7P+IJtz5M7XjJNIYcdf2KywiWAULY1+t4K4G/+4o+edDVdOWtJv4LH3WCms?=
 =?us-ascii?Q?s3W55AdJENFrkGASVITCe5Rqt3/r1XRdfI4roG7i3OrckS9fqonjHy7fU9pi?=
 =?us-ascii?Q?6xyY/Sn2xB9jEWXlFNVqEn1FSbok5wQQ7GeSpvc849mlDmU+XGRMi7J41PWk?=
 =?us-ascii?Q?lQFXKcl1wqPCd1m4vcC+PAIWs+0VApdTp3IM3G0ea0rUX9kI7uTQJ/Evdr5w?=
 =?us-ascii?Q?5GjmqDCsH9Oeewa1SrhzMCpG+Z0TL97SnJEqmk3qvN/U0Q9+XMlsbpHyHF5I?=
 =?us-ascii?Q?6/HZtd9hRyeRdn4m/1wRKbeTCiVdWAkG77g39+m5QfJFJ7SQrzXkW+5+T6pS?=
 =?us-ascii?Q?UETtF34c2zRIxBGOsxixp6ojVGqWBhTTW3bWdm9MTPv+/T2JMM2wU8Hvc+t8?=
 =?us-ascii?Q?AlniecolpqvnQy2JIsZDG97iuQ7Ng4Pz27STBsVhHhXO9g80+T/vZ5Y43iUw?=
 =?us-ascii?Q?IbF/nOID1GhmSTRd6LhL+A80rVAJ1FFWuIdyxP1dJp4FplXqI5RAX1hgD4/y?=
 =?us-ascii?Q?1PTDbBWqbuHnFJu/Ge6egZodXr1hwNX+fDN8eOutsyyQyYscTo+CloSxtwsQ?=
 =?us-ascii?Q?NmB4oBs1dFET5+qbrgr/nK/rttA6xGhK7U9MyPYRqLYbjUAqF9a8N3RVeVY9?=
 =?us-ascii?Q?cwUNSKcGfrcIwDVcYetWjptu7SiYUmvF+R+LntCftnk95IQ/RD5kx/CgoB7c?=
 =?us-ascii?Q?JippRULnSdFaOfUnx7mOCSnKnM4vke+e1vcud7RsZwbUeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0REC9aUSQmvENsz7/ECGND/wLjN8eeEVB+bda5NDrn+YKRcS+yqyOOcBMBHc?=
 =?us-ascii?Q?mTHHpkhPQegTGjrNrrLmvR1zXUbJRRuCBA4bdtCfs72xBai03jdaJe4hUeEc?=
 =?us-ascii?Q?vCfo5qBNODXWTKeQ7A2JAzVBIl7KaO/vR5ldujuy09srjIk7XDRj98yUaFvK?=
 =?us-ascii?Q?VeSuT95rP2G1cYIoe+PgR2n0yl5fb47YaWvi6D8lscITk4nA4WAvo+xtJJ27?=
 =?us-ascii?Q?DrJs/96t7K4dp6BMjFl1JmuVYIqCZmsmh3S6/xH1ZURrnAfSdtRILLTtNG7V?=
 =?us-ascii?Q?WhGjNx49KgWTBTAAPQ+QLZ2doy7RgYRtvi3DyvA2oHlcCJO8rd0Sfm9PMQPW?=
 =?us-ascii?Q?eyIe44V7pu1YmcRAdN4FXt43Qp5Zc40ylhIpXf+/LpEbn1FKq9kHNVJf9yFe?=
 =?us-ascii?Q?EefZOOsYe/wES0Q3wGHHRvx/OIB0l/RbA5kgNhsiubqVrih4MPw7t2f+UmQX?=
 =?us-ascii?Q?K+2NqD3KMuKrp23wGDWzf++VCoNPp7djD9d2CATd1Ad/TQZJAdVPcmTbRrre?=
 =?us-ascii?Q?OZhPUJ+OnMEbOdQhsczl1D4psRJtvzWpLv8R6+8G7beLFP3N2Utg3aYRMcVC?=
 =?us-ascii?Q?TUTFtdJitBKb8uHb1AH5I2U7c7RS2irtVwOdcIWgm6um0jIj6w/ejc5PrfgR?=
 =?us-ascii?Q?16eSHcU4p1mrPejPQWD3pbcJr+ASsTg9TgJYqytHJRkBmB258ut/8/Mj4mIt?=
 =?us-ascii?Q?fNkm8uPa3IzzDktHULZTnOWkF0cBsLa5KPlzQX5nazmpdsbPwXTj0TTbdJVh?=
 =?us-ascii?Q?GUNlBBTu7e3gykJgL5bSBxH/Z3Zm3//vfr9cJoZtn60XKgKSomoY6lLx/Tb5?=
 =?us-ascii?Q?O0/MVrz9ChPrUnzEpARvYPNM4O8kRCsCpRJ0PZ7h3TT760QK5YCIB0MIt9d+?=
 =?us-ascii?Q?kGtPitO3Tp1bqZM4In6xRsKGy/WlSjVLbl/rr4EoUX89Pn9ppmXhrCKUKeMU?=
 =?us-ascii?Q?AvCxv2IAPwbAX6ZxBkVrwQlq23rKaYw3u8JlTv2JWa0DqUXzzQmmuwfn6Lt7?=
 =?us-ascii?Q?TuRXJK3kLgjYXCjYfweNortvrc7KFiQPTtBnaPMy3Bqp9/CZbeZf8lXZqyQD?=
 =?us-ascii?Q?pO77zgWWZL17qY5WjpnoVj3d22r9dRl24bj+YT26JtYq1vNvEn16xMFbS5Fa?=
 =?us-ascii?Q?Lkppb/nQdEHeAwN3Fi3nhWs/fZ+by3ptdfCClnhZ8iHVQ8S8JDyLAm+rYBNU?=
 =?us-ascii?Q?5b8elv5VcxN4VOhpSCJlDJX8lcPLtRPgAgjHeFHF14uh3qJM9kQ0+s99nyL8?=
 =?us-ascii?Q?/D/fRJZAfotYMS3Pr+TMozgggaTq0C6SBBxARG2cahABFGXp5BSSt+QLm2NV?=
 =?us-ascii?Q?hUguZ0cbimaQxiyvl0TkjZevtS/GubkEihYVycra0uc1Y0m3hwyOlnE8Kw82?=
 =?us-ascii?Q?3slCg8IGWRGqPrfMM+kJyzDhtqmGzk0H3CviWY1O5i0Zu7b60o3PcfZsuTsf?=
 =?us-ascii?Q?YvuxWZbrLLeWF8dX8Zi07NvqZN1vM06XLnUiBD90xx8ofjlyVSbBR75F1qOM?=
 =?us-ascii?Q?j5tyLM24+ZfDCsSoGkQqOZtOURX7st3pgNPk382AMngeZ5VcTOuV3uzztgUO?=
 =?us-ascii?Q?ZMCF5UyAztFagkFd5CI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0da5d1-3198-48a9-2f2f-08dce21f29bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:44:25.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoArNXXTv0HqJu2DbyXFi0kejaml/UORDr3D91nlEMO14CJXoKJIAmtrGS5od4fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

On Tue, Oct 01, 2024 at 03:06:57PM +1000, Alexey Kardashevskiy wrote:
> I've just read in this thread that "it should be generally restricted to the
> number of pIOMMUs, although likely (not 100% sure) we could do multiple
> vIOMMUs on a single-pIOMMU system. Any reason for doing that?"? thought "we
> have every reason to do that, unless p means something different", so I
> decided to ask :) Thanks,

I think that was inteded as "multiple vIOMMUs per pIOMMU within a
single VM".

There would always be multiple vIOMMUs per pIOMMU across VMs/etc.

Jason

