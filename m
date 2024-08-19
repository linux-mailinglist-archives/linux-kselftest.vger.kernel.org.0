Return-Path: <linux-kselftest+bounces-15680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF829573F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA371F214A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01441189F4B;
	Mon, 19 Aug 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQpkvCzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F2189907;
	Mon, 19 Aug 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093241; cv=fail; b=YPUIrwgKnbuzSmUsdJbCnr+Zc5NpJG9udi9IzCEQHcPoVIqqg9aWa79XMdlGvZrT3xhWxtIl59YE9Igov12tp7i393Aqydh+knGY30kuLVwXV6uvY2XNkyCmcaQVCS3XGXn8lz23t7ETP+VUSXJKa3uXGPyG/IyAAbf4chmBs+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093241; c=relaxed/simple;
	bh=1D3hxbuLjlscoeBGAhgM6goyMPW31/obAp7TBtI5Occ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tB1FcbX2XpmaPhbGIjaSuhC5pSB7Nt6wR/1ZiwrLdOJFYoiUV4dA3s4SIuFJ3ndGF2UsltEzX34MdlJ+afFLQZzFknJQAf79vYC8MUidXHw3trqfG1shx1xc7efbDf7wx2o2nUYf0Xe97xQjQRiM6sD2BJ+f1gacsNHS27Eb+Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQpkvCzH; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFt5KXlNEudfuOsToNzA5gRVZ1H5zKjFr2uJdaouQIU6tc6nsDejWcXiEGJj/LcdNojIHnGCaer9wlNrN/xZhZJV4J/R7Imb/SUHSX6gpJ/mRyLenwO//zGT8SzyiGrWllo0eJUwEd/hvXtSQwpA85zBXGFfwli63htPuoCcwiS5cDjxjDHmvbV1g4/k0O2CxapoqH6s8JmvsBQp5ZAYwBoa8/yZ3ZRz4I3nCvnJApca0upgMdjEjUi+v2H5dSkRj42Susu1B20KshJotc0XyvhEemV/1vOzb2krhvBJO/He3elJtUHtaLUH/H1TLErt9JidHxY75xKunzQvFAAkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzdL0ENq7+/+L8CFU4NWHEjD5iuK+rJUwCXSLAuk9Yc=;
 b=GRUDffcxoPrhMlQ4us/+6LL5/Mz8yyZKLmZ6v5zJMqXtG3/mXDQ12sF1ssjOvvctz3BKMLQip01b6QXSnqFR1SjlxZWcz/4ah7BgVVH1NSCmE4J5zAX9TEOwAuUdmnmdI8fj7XpnT1NhwAX9f2veCcnnllQfn7BsaMSB6Ik3afG3NZqI6mBqGsGP78Nmc8YJnbh56MAxwA4OXsfr2IaTprZ0l59kvhmTYAnxX3oFj4ZMn04j8FZgpGcbasrpxFKu6aaiodVxVj7L8x5Vg0Smdh+7scxiQ7NvWsJCIGhby8ol99XeURnXkhgVKxX9VxDY6xvHu8V/o4SDCT3M7D2bsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzdL0ENq7+/+L8CFU4NWHEjD5iuK+rJUwCXSLAuk9Yc=;
 b=mQpkvCzHNVd7Mp7ngIh1F6J8WdoWboiNCiFC2CfrXltpYVMkxVCupreBbTduieabGyaA1J6i0lrmo7jHRulkwL2gZukEQdR55nkYB5ETAT6aFdHeU31B2tRIMNL1Z1TpdM8ZDJX/FRvSwL2TCZ3eArKOUD+v0Nz7Hs9vTOFCY3HRPv81I5hzxMVcyr4QF6bupgvbUzMxlX+Hjp7mKC+NQRD2BwTkYGHjpDXjbilWqB75Xsqc6wH1gsAdyHrvJqSdE2MDx9tKovR8piZRZkoLwwP3Up0o+xVlXDkZJEHeWRk9kJV41h74bdKO+gjRbGcWR/TTd6PQcspDzdf9LhNWEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:47:17 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:47:17 +0000
Date: Mon, 19 Aug 2024 15:47:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <20240819184716.GT2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
 <20240819173615.GN2032816@nvidia.com>
 <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
 <20240819182811.GR2032816@nvidia.com>
 <ZsORHnIKJsJaTkiF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsORHnIKJsJaTkiF@Asurada-Nvidia>
X-ClientProxiedBy: BN8PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:408:ac::41) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: cb18e866-193d-4017-ff49-08dcc07f5943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cajj/Um+Vm8E7+HubY0mFCrJ3+iLiWM+dUCJ+vkNYcC774GPwnFD1naHBAVI?=
 =?us-ascii?Q?Wi/FhIB9OzBpxRImt2+Wn9zbKZJ26NlYD7bLGg1lsK+15pQtskm+DPj7kIIM?=
 =?us-ascii?Q?ntLtr/zNGmLZ4cgztgFKchw3u9etofwg5GMuohqxtvviiHrwqG054WoySWfT?=
 =?us-ascii?Q?2Qa1btyyUvjQAVb/9/eIMjOkcqNCxGG9Z93S5WLZykw8eIuqRhEyIfoM0NzV?=
 =?us-ascii?Q?KDyMD9I0PsmFWfqvy51ixUGmPWldOaholAmGOY45buQOv01smHN6NT0bFWXj?=
 =?us-ascii?Q?44hzYnlgzlCTkzTtMoUcYNrhlL3z7CDtWirjA/0BOJ57g1SzCzlTitZKLP4X?=
 =?us-ascii?Q?vmwIuagtXsn8XvrHiVULnvBjH61cZjcnrwUEmrIfFMaUOwjMErN+p2V9m6kF?=
 =?us-ascii?Q?wzs/Zd9HcYinF9Ga5pI3+ybBdXQdFyppUiujI+JEPtMQjULVj4ptBVaViAik?=
 =?us-ascii?Q?ReNuruJHfIcFXEfaWznTEODPj4nCozAx8LQe5Xg3sCTrrDKwyeQ38DH3dACP?=
 =?us-ascii?Q?SjMU6RnVHPOFoZHlt2W3YAVedC7mMHUR38Yst7MMxsqXR3bqapbT9bdnEzAJ?=
 =?us-ascii?Q?dYek04RrhWGFP5eT3fmLt1J9x0e9vERDDYIp4jmgMxRE5rXqpXxbTjRQrafw?=
 =?us-ascii?Q?pdR7tv8gMy9hNT210JsQsNkdoOVYIENlqZCexnHTKgl5rD6lQOYb5THL6Zid?=
 =?us-ascii?Q?QiRG0qmYxcu3F+Ium17ZWcRpZ0P6Ho2de3HKNGlkHjPBezZMyKW7gngXrCNF?=
 =?us-ascii?Q?S1xYKr5VKu5nCzgbyt+1IY6DupSAhKNvWNpypOpyA9OihwH8bj79Wdh+XnKQ?=
 =?us-ascii?Q?TMZjFg7/tmPZfhqGXSYeXYwkd4fM9MDgAEH/DO/OKQ3cQihF4qHXwJZjY1MG?=
 =?us-ascii?Q?cgtpHn9nMGpyezR+fNxM9lKSxgMgvdXsS7661eycOxw/tveZ3yImWIqwOQbx?=
 =?us-ascii?Q?ZlCo86fldzSNnkr7J63tZlS7Ex2dwnvLrEuWHWjQ3LUvZNbhbVzqFkmSehsd?=
 =?us-ascii?Q?AHxufUMZN6OHX74rzblUKy57cJ9PFfKpCLCUrzDjB1plXJSvxnYI7ku498iM?=
 =?us-ascii?Q?qBOG5wZqs7Wb27FJRlmcHnqujW+AZSm8zihoV90rCt1kJ8pZsRmEdfXNqph3?=
 =?us-ascii?Q?qmGpOBxtOhHFDu9dvayhKb6X6W+poHJjZlQQj6wHIT+4pFZMY9dPTftvjo/X?=
 =?us-ascii?Q?IuyKH62AtvsFbptHokNAu+8x1vZqfCV4Q0Vt0tXM36gml03jAqZ+7zR3NOgR?=
 =?us-ascii?Q?RQIgJPyWOhKFGSCxFOxvuhLAqldZFvdhCm8cJXLVTrg483New+GFV7o4epjH?=
 =?us-ascii?Q?NR0pvwHqo4L3rgCVFcRlv5Opm+pMndCB8xPb+ubUVAIzOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?183KYQrfB09EfNVojDcAMlZdKEKwrkbQbVTtYkTFC8Si/xOFTFl1oNaGL9dq?=
 =?us-ascii?Q?8vllX593WbZNKueU8yQyoZSGzIuVzdJq9vq76RIytAq8PZsgGEMhlUXK5zpB?=
 =?us-ascii?Q?Kl0bIoQTtfiXyGujHJ4DHPGs4srpaSXhZNeoeOPScW4p9HgfWg/n0PqiW1pt?=
 =?us-ascii?Q?T1UxQd5rzjtHPxqroTXfNmXGs+qgReI2QgFf39zcBfsMJ7Qu5M9WxKcbnPFg?=
 =?us-ascii?Q?BuecTnS3cyqZpyMlN9+Px1lBCmtS93Je005i8dM2A6Os9EtciagBzm4+o/AP?=
 =?us-ascii?Q?J4DjUn/YG0ftu0QNgbQxSG0TM7mGyvRRBTh3RVjA5QQSNcsyzTQCs3WA40sC?=
 =?us-ascii?Q?khnDQFlublXLcN0SJMZxVR+abrdjjk1FwkdZZVHaxik9LSvud0ypqmj0S1iU?=
 =?us-ascii?Q?BBatlwdaOU51nDTuXnSyyauqEwKPa6MIIua/AkcLL7xqxcccwiMivw+NBceB?=
 =?us-ascii?Q?04yV0BYdO92iIKiq3xq/7Sdf1ZbQ7qq5HMpHroYTy7Cr1NXTWc/QZz3FnJBN?=
 =?us-ascii?Q?z/WG52vIQ35pHILpPo/vEMwpn86qMFpBB9YhxsiinWaKLQiv/rrYMncdcDTG?=
 =?us-ascii?Q?BtWDpMpKcJLRnY0LlbjqsTo0oO6jTqd6simAzdj8sx9JBLu1Ugdj+n7i9Fst?=
 =?us-ascii?Q?fQd95ikI/uR8zZ8NCPxh8qrUqdfjiPFr8B9EkUV+W/cQGoLvyrg+in68xSIn?=
 =?us-ascii?Q?yr/kIjshZmn7ktUdv979RP+xU9o3J0W1vuwVX1Cou6H08T7frIiHGQ66qli1?=
 =?us-ascii?Q?R7Yq1pw4MNlrwQPTquAsgj+ybkLp1hx2vluHuM64/dHReBuT1iXuOX6oGScg?=
 =?us-ascii?Q?/LLA5niMfVmvSAf95Cckexo3kW2iKPdmTSRD5eIgipxBtJ7sqG96ybd4hIr4?=
 =?us-ascii?Q?4VCHWCfwVRAhR2tRiTAUBiLkxEtpt6Q4nue+bPsJQ4no0X9VIQfIouvs8IEV?=
 =?us-ascii?Q?0uSopgrqfSylAFxQgZTKQzuWMbpWxQqr6BkTgARGiNpzEvUnzOXq+PKGRvD/?=
 =?us-ascii?Q?tXtaWsTZtyeTn0iNqxItZSK2z3/kCH6f92J720Pop5LUtoeEtmpU0V3dSfeE?=
 =?us-ascii?Q?oviYMD950ndHu53lMUdAfMgCWBQiZlQYTmQRQ/GW6/4IM7oEvgGrwR0+wBfO?=
 =?us-ascii?Q?WnXHVdc/s5nYUULZnpgQb903AymetAO98+8B0y2mYZEE0u04p/a1nr+vX8Tm?=
 =?us-ascii?Q?F6YtbDEzXrj4zI5WSkC4LV/NiZFRvf9M1qNS84gXYBBDVmXGtfCzHx7NjxXK?=
 =?us-ascii?Q?gU4dIqjrGI/dndqht8/m+3+eyzYbQnC392guTsw+qSZ+inujSERnJP5zhdvO?=
 =?us-ascii?Q?OcLruoILfTMbai4IseXKrpoqxC0k0opY3ZiXUK9Vj15/D1NyRmWtSDBZl8lN?=
 =?us-ascii?Q?XOKzFConscJG5QpXAlsMktIuwnRBzH9jWKw3VEd23GcXDvKWcvHNZqevuFkH?=
 =?us-ascii?Q?BWIGb66iJUeHD7R/6aH8N8I5tBuV7ZWrjLbe5CpJTTboCLqT9Xp6kA+vb1UP?=
 =?us-ascii?Q?az2NlMz5FMBzc4U4P3p9ZeGWanEvgemLgNgiarYVhn8qYteR3Vp3AmCdVi4X?=
 =?us-ascii?Q?PvLFbRyY12te2nkVw/UK2xC6p55ArnsQjnIoW4/r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb18e866-193d-4017-ff49-08dcc07f5943
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:47:17.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1qZTHRFSM47CrAA/a2vYoNdch8onLN2K0elCtWgglmlJMtpncNJU+dNJ9MMGKrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

On Mon, Aug 19, 2024 at 11:38:22AM -0700, Nicolin Chen wrote:
> On Mon, Aug 19, 2024 at 03:28:11PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 19, 2024 at 11:19:39AM -0700, Nicolin Chen wrote:
> > 
> > > > But nesting enablment with out viommu is alot less useful than I had
> > > > thought :(
> > > 
> > > Actually, without viommu, the hwpt cache invalidate alone could
> > > still support non-SVA case?
> > 
> > That is what I thought, but doesn't the guest still have to invalidate
> > the CD table entry # 0?
> 
> I recall it doesn't. The CD cache invalidation is required in the
> viommu invalidation for an SVA case where we need a PASID number
> to specify CD to the substream. But the CD to the default stream
> is only changed during a vSTE setup, and the host knows the PASID
> number (=0)?

I think that would subtly assume certain things about how the driver
does ordering, ie the that CD table entry 0 is setup with the S1
before we load it into the STE.

Yes, the Linux driver does that now, but I don't think anyone should
rely on that..

Jason

