Return-Path: <linux-kselftest+bounces-27161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A96EA3F63E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47438170106
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4920CCF5;
	Fri, 21 Feb 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gqnUTJCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188F1EEE9;
	Fri, 21 Feb 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145154; cv=fail; b=dAP3wraDNQBdaaZ8WAfWY4cnG2sWMlrKmAjsw/Vs8NoHX7g6xjigs1Yjb2YxohbTZ3lndDo+AnVxVPVeW/aF0bTNLhnXb/NMkhlPZZN/o17DhJ6a+hXYe/BH6ZpC2+urmyRQMkgvz+mO/pxV6n2+I3gcgiH20jm72R3bVK5x9FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145154; c=relaxed/simple;
	bh=R9WEzvJnynQ3HCe+PvegRLkIEUNEIHRkH2PzCFiuvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klhwn2XPPkk9HHTkGpNeRLJDc/btQ0Rdvuo4st24oprw1emAKVO8QwOrotppYzGPXK/pM2RVFlT2Jsfic/T1rs3omnUhOkEXkcRJCvaLjuZp4Q/BXLINvBpFBNFGdyj2nh2NdzTnSnHFCkjOpimcjaMuIgx8TScf9pzF3e/3IzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gqnUTJCU; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8iE6xU37RumsET2fwg0R6K/Lt9n/o5tE4rMnkNkSKXGjzz92dAAVeQc+nOZpbe8x1Qt/Z7XqdbsvXY60h2nc7FtCy7bg8ld0XkhN1OWU6CSVS4qiazkh9pS7GuK5gw0+piGbWE7V0IFSdElaHpSd4xtMeJa0Q0GiE4UAkqq5nkI6FCAiq2Kpan1sfMDHTQdyZGHOtYFavVavEnDnFvpK56NtqXodVgreuNbWeb0ac7Uro2Sz9BfzNPnxn3pLzo8KoQscVCe9QbbC+Vg0QX52OiK63hyzs8Z3IHs3ukXQGmGu49H2PmnyqZX51sHA0/TDygkC5p4UL9AiNc63mC6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9WEzvJnynQ3HCe+PvegRLkIEUNEIHRkH2PzCFiuvG4=;
 b=BJ939lvXp/DDClq6wK1eFEk8IvhxtwvQRyU5iNJqoPM9/OVFo35Za0gzA1bF6/MmBjWiqzJQCRrn0p+tCJqh9+6Ftnymijlvy/cjTlumcbRYHO5TtaLE22ppjsQ/A/ahaxawSGr7jSSYQX97jjObb045dZWPM1F8Ma1TsI6WLs2DliXWbd0+v59Lj5N0M4+s2uRQ8El6uIIaSC6UDsvZSw1nYdfFK68WWQvVFw6MdrAB7ET5dhQ/vosNHgiTUeC3pVMpX2dHTWzXeosiuHAA5SJJqIY8n+n5OVcnQ6dHIx7AetdPBCFbr92t1tyqw6GK150ejqMNSSp+rQX9iUW+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9WEzvJnynQ3HCe+PvegRLkIEUNEIHRkH2PzCFiuvG4=;
 b=gqnUTJCU1j81A2uICIVJ4lWa3SwgCgnF4eq7Bli35odkYdF3fYoFInRPmOpklfcWhQaQZVFAl2m4T1oLrxgoki8Jbal6R1VlgZbSZ/pByo58whv4PAUTWch5brDpZ2V4Zgn4L6Mh6vYhHSILsHSEC8tUH51qf9SwKwILx6Q/MGi5DkNmZBqnXahR2S8320cURSQTrd88vu2/MWkdM1kKGQ7L5khBwutlj2v3k3fu9J5gcb6iu6j0/WrhjphUhtets3hyHiJlPLHzw2KRNQpLx/EdgaR3rfmjwrZPIZ0W4ZZMXrzUbAwQxmKXu87y3Ca+PtNNiI00dk+wXl0dn7K83A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:39:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:39:09 +0000
Date: Fri, 21 Feb 2025 09:39:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250221133907.GJ50639@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
 <20250218153541.GD4099685@nvidia.com>
 <BN9PR11MB52766CE9C579D3EE1CE1A7058CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7ebqtJUwzgOIeSC@Asurada-Nvidia>
 <BN9PR11MB5276DCBA230A17136BEDB7FE8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DCBA230A17136BEDB7FE8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7c3997-f92d-4fe1-f9e6-08dd527d1e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ekp9hWBWQ4gHdFtndcCqt9KJ27Padr5X/PpeGF4kfW1uZDfA12umebRpgrsL?=
 =?us-ascii?Q?+17Y9Caw8wqh2/3ITTOCkZhFx86MT5YCe21Nw7ljMsdRliOyNYmMc4fYIHsA?=
 =?us-ascii?Q?7S4D2v7MWMzPkHR4ppCRqaH1Onft2AoyiLzYmFPTJdN6L22/FcZczRVwsvyE?=
 =?us-ascii?Q?oThL8pJWpD+7Kkcnt7V/qxfgEsIas+JCXqr+40ObPI0P3w4Zuhd6gbH4THKF?=
 =?us-ascii?Q?yIAjSNs7jpEAbDfhWcEcq9cvrqfUcWqp6DaFZJVqOjXWgHu9a4hgB8Qp8LC4?=
 =?us-ascii?Q?lz6JUtWWNTCbJSPIB3B1CBN61Cs2Ju93gOvp/Mu3e9YMW+sgpfXwmGiL7zKm?=
 =?us-ascii?Q?c9WuGy6Sey04yeBTdwIL0d2SYvKMIonhXLMV55B402DfteZc/qnE3EIgqgQX?=
 =?us-ascii?Q?XXyu/GVzzqWeWtLzfWpRkTxXvJaOthr3f2x3h6DPqd4wf64jFgtDfnb3plq3?=
 =?us-ascii?Q?abDewgjXSYcWncjTxl2k/1yfLMlqvJAjOlFBPLyiotsPfI0xphw4ZsQbUnHv?=
 =?us-ascii?Q?4jj16yfNoM1Bd3pKBdYlmQGT9zjOJKSJh63O1p6kXoO5+nlqaTViqQu9+k/t?=
 =?us-ascii?Q?+QjiyqVwmBX0tkIAuQr1PeSKBWjFPtjAp7++ZwhaFiU7yg6zjgpTVcwJuDb6?=
 =?us-ascii?Q?InZO87mPlex8xZfGEgK5SsZ7XqWWvQUYV+4+JsTd4D1CrC3Mz+Whz3+DsZDn?=
 =?us-ascii?Q?nTBy/pHCRSN+bN1F0m12oFK79T1qxbaaO5LhSURUyKf+ag5ep1JXLVeuIgEm?=
 =?us-ascii?Q?lEUfP71Ya2Ogo3Oo0/4o8txeGClx+gKaWVYX1jnv8YpuIAIa1xsDOQo5i0uN?=
 =?us-ascii?Q?BpiA0q6QdJTPOi5sG1szfhL/6jKjNzLrSCTFrQgzhCASWoSys1XRQgVzl3yA?=
 =?us-ascii?Q?x3PFvS6RY2irxh4YJHwtCUfz9MY9KPgXf4sSfja309vJ0bBPXct6UhzZji3H?=
 =?us-ascii?Q?kfQqnCbZ4Aj3pWPKbVEFfXSQLg0g3tbJWb7wMfFEvjsqbj4TZQ7k2l+a/gAz?=
 =?us-ascii?Q?TbrEKUX28bB/2icuax4aS7qmauU5EA3ZxFdJ2ktJQWaHNOymI3JJxcVKfKqd?=
 =?us-ascii?Q?NMJsQ47Jne18BAN8UGqCXiFpx8+wcV0rYx8JIlIG/Lunng4AyNpQT3Q78eS+?=
 =?us-ascii?Q?LXmsDSAFlLA+7/i3ql7MJSAVBVmsqRUq08sHCcgqhYqLKsjM3K9z6qcXsNyf?=
 =?us-ascii?Q?loNK1auxXeBaHVo3NbfeLxqCFRlhpX7XNCioItCXRez/qGBiVJX2O2Hq1fTp?=
 =?us-ascii?Q?OmCT3iiD91vKQlPYwXvkMQKHSnXNXqWIQGuUR/tvYj4d250P7Rc5/R+2/YlG?=
 =?us-ascii?Q?vexv7sre0prIOFHsnbk7g3VFXBp8spc3fS/GTn7za3ju3Olj4ZKA+blOm8ij?=
 =?us-ascii?Q?XvgkaxPU8vtMQsNAxzXmfvrM+UEj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+uK8PZC9Co3eeQFijFjprSXqPDbbkMvf7XtvEB/a2A0lrAZj61gXnZgaGom?=
 =?us-ascii?Q?8j5D2sD0v9HK5zxgFStN3za67ga4l63lEyTiI0QGXEe9VZUv9N9sJZx+w4hq?=
 =?us-ascii?Q?uAaFMa51CzK3jzvKQmqkMkt07Lynh4SuDEADS0vmR8ySvxoT3luFOl0jFz/H?=
 =?us-ascii?Q?Zt6V4p1wlGeDe5hvTXXLdO2a1Kd1eGGmHqypShcWQiauDv8lOr1B8d8Nb82f?=
 =?us-ascii?Q?QNGgvIM1EPn34qNVaTCU9ZKKCGkAFIzaLdltu8NGdsOy/17gM+e76PsMdt5C?=
 =?us-ascii?Q?EobuqvB7/KmSQ2miAH2cTEcm7vI0FbJxJpH2z1j6nxbI9G9ClEJUiXl5Vg3u?=
 =?us-ascii?Q?xAojR3LCurxMMR4owtEcp4rMHQg2MLJjYHMT7+VQXyFZyrDIgQBeflLK+UbR?=
 =?us-ascii?Q?R/WqWFKHkwHIfA+82DFOA6/dBGQV1b/PHJViDol4rWxIUDmN1yR/bctPoQRW?=
 =?us-ascii?Q?6w6J9E0FuWfcTQR3xJAAwY7Cl6DDz85zq57vR9lfZ3Al8sBd+Q3Ybe+/yArZ?=
 =?us-ascii?Q?nU/tqFltPdeE1XZg1qpPH7yIUup5/vlnATIHasat6XKfuMuhWcbahJHi2PL+?=
 =?us-ascii?Q?Mx82JzTvX8AbUjDEaOXiMGG1AhYTM8XZIXwKIs/VEFP8vbAekU1iyey7VLw1?=
 =?us-ascii?Q?JSVFQdRlw6iQyAtiSKDcV1ZhZXFZ+sP2Fwjt4XfFPN6KMqo5yb4oXsmPjqGe?=
 =?us-ascii?Q?cgUUGl28ZirE7vkM15MJtrv73ydfvr/fjYV1UyeXCIF4HZ2uOpt8V3uF5wqT?=
 =?us-ascii?Q?T3CcfzD+21LDVNNtmNtRnQhD/4hh/sHfY5J8dXQFHP+O1jkxt64QgmIWlxEw?=
 =?us-ascii?Q?x/Bg92HHBJnaXJs634ZKFPXxdWCIZWRt/bABOGLm5uS9XOwE30kGO88W/7vm?=
 =?us-ascii?Q?Tp35ByUih959md56x5mwfPQ/Hw43tk2QLNtdxGd5kmQdXYbuQE8+OY3Pi2QJ?=
 =?us-ascii?Q?d7Rj2iy+qUbm3SuPds0V6AqLOivrS+TFXd7WN1QjcXrR02chJmKECt9bEbpT?=
 =?us-ascii?Q?dvJBRmF7aJ0fDDsDIxzuZiEcbMPd+MCQOVR7EELpDMptPpJWpfktx+1uTM14?=
 =?us-ascii?Q?lL32AiCHfAjOs/sBjYz1lnVc11oDK9SA5TQBDjH0un+iR0zy2KcsyLO5cK9Z?=
 =?us-ascii?Q?tbbGmSBgqrq4ddV3z6NPxc02fSPmFSqeGm39AVrzEjWTZ7+m0YyyuTaI0wEc?=
 =?us-ascii?Q?fchEwyhOD6AKZDOy7WZjBXwIwCDcVaK+RnF13/Mfg0IIt9I/hA5528cy9lIz?=
 =?us-ascii?Q?qWn/CQ1UJmM5mwbjWxMKJdoyCEG6ak/2ecNFde3Jr1Sj+ovpdB6XGDFj2Ore?=
 =?us-ascii?Q?GpPR6/f1wGtaSWB37MRobKv5CeFfBUgLDrpsDoRrdrYT0f99eesGcFOzs0Mh?=
 =?us-ascii?Q?JYdy7nXZF7SZKnBt/VmhIX2NewvZhInbEkR9DWH7+J3r09MQY0YsCnnEacKZ?=
 =?us-ascii?Q?pDaaxBvCU+bxXFRwTZDMchUHqrkt/vy42vTcEgvtrzhw+PET+xVVXCLUF1Vj?=
 =?us-ascii?Q?v64cZYM3L0g/8kFExWIhKS55KfZ+Sk2CN64XooQNAFv1nm267q6LRa7cB+zy?=
 =?us-ascii?Q?TUL3Z4NugaUn/W+jdpE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7c3997-f92d-4fe1-f9e6-08dd527d1e43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:39:09.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6fv6g4zAJDC8RPA1EmLkweI8zCFxUQTPFJHIqzixkEJI1S6fj74j+6PkKgjPg3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

On Fri, Feb 21, 2025 at 04:27:32AM +0000, Tian, Kevin wrote:
> With that in mind we don't need provide reason for the static node,
> and IOMMU_EVENTQ_FLAG_LOST_EVENTS sounds closer to the
> real intention.

I also like lost events - it is simple and to the point

Jason

