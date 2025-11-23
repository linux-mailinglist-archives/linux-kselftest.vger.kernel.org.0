Return-Path: <linux-kselftest+bounces-46336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD6C7DA9E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 02:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D59E3AAE8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163441A9FBC;
	Sun, 23 Nov 2025 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqYV4asz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBE50276;
	Sun, 23 Nov 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763863058; cv=fail; b=HpQthCy9ME+hvpBvxDwv2yscIzrnt16p2aLbpEcsyYMDA3NwgVUkKjUtbad5S549Xs0eBvkTwUA3MQKgS4qznu/3jn5+1bmb2rbvC94OqmwWeXT6lET8kI22S2WRmYDMUb6OeeS0/D7gWL4Xd9gCaG3iioTSw27Unmq3nbTAlg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763863058; c=relaxed/simple;
	bh=CeMIeU+OlQyHIkc/6eJ4W71aM2OZoBcBW8BqkeOUPtA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RryfgRGB8T6SDQHivGOfraBCMYBLsu+xmCe0ZIdiN31cOyCmUt4ypU0MmCpgVDyutOXam5dQoOQRhLxa2YQ6X+HY9f14vmoii0WNd32tXFpe1qLVE5T5cL9DbVL11dy9psujMlTLGN0tdm5VdtK8V2FVlgxmW7+rr+ZSofhsl8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqYV4asz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763863056; x=1795399056;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=CeMIeU+OlQyHIkc/6eJ4W71aM2OZoBcBW8BqkeOUPtA=;
  b=hqYV4aszqrJ8W9/YsLVtvaOOK8eSeAhiL3AzM9bIsgebJPmZ33ZuJZgD
   LRTz0rpEPpJ71WNv8oI+ScIImQUvQgrPx2lratja3vmbkBYszj1Nd/Asp
   +QuPt6a0cvU554cQamqQ0ZY+Wps4kQjGdvT7GTUaN2WBbFIXdNKDamYhc
   7h3WPGxPobUqUwCRFglabtEyjC6a4XNCaN5eqkbBqY8a3xicS+mnIyfBy
   y995B25pp1FqbITZ0TBQVNvczhHZ+7U1OSfx0JIZAUjsbfMcOGWXcWGkC
   S4ZxvAaUNnRs9duX00z9g0LIa0RuXC8StJiajtqDpOBHAY6PUoAgVZ1nD
   w==;
X-CSE-ConnectionGUID: 2gALf/yOQG+SuNWBEEySVA==
X-CSE-MsgGUID: P888Y68iQZCwvmWXRfxYMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="65794723"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="65794723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 17:57:36 -0800
X-CSE-ConnectionGUID: bLaxbnBlQAuR/iN88yaH7w==
X-CSE-MsgGUID: QhbX9gLdQpWenjoCWXX7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="196178588"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 17:57:36 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 17:57:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 22 Nov 2025 17:57:34 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 17:57:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvNyK40LVlRlhEIWmLCyn8ds/0dsV5ir/fzxUI+qX3gl2LBrHOyAazuVkZjCafvqERrnHINjQMMzzp6SYZvwgh4FEsdDhEUFbULtYC96cEhYXbs+By1QubddUiefqA9m+7ltTWS5g4yiJDYbVnwCFzPPQOEHuElav/up+jtXZSLfNU95jMd82CCQG9ANqNLw7krlB7U6aI+gwHdlpSvbnOWcOYJSaT4pNQECMdlnQnPAuW6PaDbFXHE2F4O79whq5r016NZHVbwIgsrcihosbIbiYso3ZOlmdh9ztnveGn0PnG8XqcCiz436Nl5jNO3nBIbm0HGCWf/zN+YBdyCOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOhQ22CQXjH9GnPA77otFVjcPCbcVt1xk46tXj78dik=;
 b=jVLCGLi8w1FBlCCl/MLHd4/ICN++o+csTxrvZ9t9U8oVrr/lXjmEEl9DJjBkStSho6KdK3mfmkuFM5PWe8/oyfcXIYd8hXqCCH3Vm7wE0Yc7n09VJnwbCnFq6tfgtsPv10eqL3D9yYxsYaYl1BGvlnr9BksXW2zRGKGD6rl9ICjlLok85O3++yjWZg310pVigWsA/+WPYY4Pj8gFN3u5EhYPbhbwLnmavVQ2QEfqom0km61Pl09Y0JU2BzP+14O7O9b5sdfvtbgHvxn/7LtsAlWqsSmnHkoRAWKUb1X7iw5+1sOT0ee9ODSbf5z+eBF3ft+KGGH2Ivn3Ow7zTOupAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 01:57:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 01:57:19 +0000
Date: Sun, 23 Nov 2025 09:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
CC: <oe-kbuild-all@lists.linux.dev>, Alex Mastro <amastro@fb.com>, "David
 Matlack" <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Raghavendra Rao Ananta
	<rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 12/18] vfio: selftests: Move IOVA allocator into
 iova_allocator.c
Message-ID: <aSJp81+WCEKIXnDA@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121181429.1421717-13-dmatlack@google.com>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5963:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0890d317-174f-42ee-2054-08de2a33a24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VoIlajVIscFQC5ofCprVmqZa2QbItVZ+axbNJFUeyh+d2N2QVtKD/kowIcTp?=
 =?us-ascii?Q?ierTbwNrgZ2KoJSrGbF5aA/jUKS7RJsVjJV4IUWOOnG02I+fAXv45vwmOOs1?=
 =?us-ascii?Q?jEkrdCzIOtH9J34ZZg8C0DuLpuwdHPUwZFD7PE/mzbW+JUMJnB3uDXZt03dw?=
 =?us-ascii?Q?TCBhsG2vI6XBW0enMZIPzt+QnnXR2o/GI0EckYQmqVeEMAt0uz2/UxWH0XHa?=
 =?us-ascii?Q?BskX4KM+HT/XRc/IILHpigbViktbag0THmMrdXon/OHl1HI0Sfvu5fnmpl7a?=
 =?us-ascii?Q?HPXfk/SXtbtdTbec7EsnvcLdyTVwkmSNsBNYWV5bF+D2OksR204YsUiU1QdR?=
 =?us-ascii?Q?ofTAaKscuDc+uRAutPfd+0e1bLLxAyO81tPAIDB8Crdy59csr70pstRHzYvq?=
 =?us-ascii?Q?8CI9kD9UlwOYsdTwR+FCNxJ/qEWIeJLqTVTKZCTJ/vFRYQOByrZKaBgLgD+u?=
 =?us-ascii?Q?lYTJyvGuScV9IeVnxOko4C8aZKX1YqhQxcke5RcZfyXa/VTwx6dffJDzzp5I?=
 =?us-ascii?Q?RzpfQlwleH/MKM2DjjX2NADbGCmK/3/vydcYbY4HezfKabp1Hx6JG0N8id+X?=
 =?us-ascii?Q?OL1tlRDuHalIhvTa4ZLEcvElaoz2xjfT/4OrAcVO8J2Midg1Db1LdfWIog8x?=
 =?us-ascii?Q?cgqEggF824u8SCYOHEpEyWptERCR31VOQy0n58etHplGBKxSIbb5KVZaa5DD?=
 =?us-ascii?Q?aYmV10VGesoauW6mDGeconyCnqV1gfXdF6QYCZflO8W5AGuP1jbAO1faEOk3?=
 =?us-ascii?Q?v9JE5gywobUT7VdumCiKPsk29nugsmm6r/qb22tVE/yG30igT4i81Gtp80HL?=
 =?us-ascii?Q?cEk0bQUKA+bsRbS2rM+udm/jxsaK4YpTydgrSGLVqejEZqaHH9Hkr6xNqj0X?=
 =?us-ascii?Q?x2QdnLSohmltqrKEAYN04HAEwjQ9Wxz0YlTnSwOdyxwHaGRWlOk1F5hBGK45?=
 =?us-ascii?Q?MmTRrV6/hnKHTqMndHEG+C1iYhLmcsRbu0ZhDH8o5kJFZqkWgev5JvW78S+k?=
 =?us-ascii?Q?rIqd0EHgdx2GTge/V58xFm8UrWzORmJf2gx0JblvYpopZIWRmnc3fI92Sra0?=
 =?us-ascii?Q?kXFAkYhociawtAqTlYUUwmIqmFMYYjUoRmIyzfJtdOU1SGAcyALmfM/lH1xv?=
 =?us-ascii?Q?JMRvsZxHmGANFISrJvM3cB5EYljESGDkCg2djDfgtRhIyEvmLMZH12mM9/Dz?=
 =?us-ascii?Q?GN8YgR1z0gTjaPlqDc0GeiabVAPx1Us6yADVo/+nP5iJjQ1HPC0meZt1AF85?=
 =?us-ascii?Q?f2JFuFEvEVsgEm68WFM3m0bzw1lBK+OFHRQv0a3PlkPtJgJNKQBq7GhQxmmy?=
 =?us-ascii?Q?pjNjX2T2XLLNe8CX2dGu3vOZ6FN12ea8KRz49wdApa192TIMl0W67KeKlzUl?=
 =?us-ascii?Q?djojiGiz5T+XJntol7IKhWET/dGVWWWsYwrUWiVbKQxsUqsQGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWQCOMJroWZAO6u7cyFeAhAg5r1FjE3265ci+0SN3RtRfmAOU5knkZpqc7Le?=
 =?us-ascii?Q?M1Mtp9jOQXIzDGLJVT+0KU6WGEtKWnonsVmamYmM3TuShOphV0B3gIkgUZ/Z?=
 =?us-ascii?Q?q/yuW7ru+Qa6jar/6zYOQ1Y42bV2BuwHl+yrFWfLvtg2BaFbKF+ZEyM+asJh?=
 =?us-ascii?Q?ygcQ30oWlGNpaGv019oSCvSoHgdHNNXLLmRT5n8tGqBCOYriWSlMS9ehdbh7?=
 =?us-ascii?Q?WkZ3eyjBdXQfM8xNhGxTNt93eJF5t5gfKB7ZN034yutnzmIc7cgjdkwS47t0?=
 =?us-ascii?Q?DmsUPlYyLPkuJGTYD7Q7/RoDQmEqzxSoEjIgV/L7cRH27hBxAVGTfw28rUzP?=
 =?us-ascii?Q?TpXPSztpDLgwBKMT6Cusx05scdcKGkCWR+8MvmWQzw6V3KYw6tgyRGZj2izs?=
 =?us-ascii?Q?RoGMLwoUNNy0vHQ333xPyjxMNQtZV0gRdf6YJc1NxAA+6Mf6lgNm3JN0/5Wy?=
 =?us-ascii?Q?YMqTJJ3cw11nXSGI7Kf+x2XORDpCgtUCiVynNyMs4y/Y0ImCHnsChAqJNySp?=
 =?us-ascii?Q?eJ/trGZFz8kW3KRhTFYph96fkjV6Y+hNS69QMG7NKQDjg3RyEqlsuo9Qnxsl?=
 =?us-ascii?Q?ZifkLHKc1ZqiMaQtsSLdXzVAa7Kr1D7WujdLuNbh7tkRUQCo5ytVpTnRZKjP?=
 =?us-ascii?Q?5dpWQqEESX7x0zZPtE+4V5yPOfxHkUGdsYJVOgwIG6M7CAo1ssQFeHZ8eZJl?=
 =?us-ascii?Q?JUjj8iWhhyKMGssDFXDdav+NEAWaBIdKAVEI6GNv6YrM8bkud8pDInEHqr5V?=
 =?us-ascii?Q?tyH3IzKjG+lpB1RxAsqs6rq/C5B3CQ00dC7zaNf2SPljbd79VoSy0aYBpReH?=
 =?us-ascii?Q?E48CyDHcDPnhvyCpzM+C4Sc8gRWvrO0IBV7k61CnmeYK1qOEOSe+gqp9dpH2?=
 =?us-ascii?Q?D3f7vpgeqWeUmDBYl6bDbF2XlxvBpyd5xjoR7Ve9C4KKOmQlsRDFfozngiDy?=
 =?us-ascii?Q?KpxlosgLIPG0ZJMXWWTfU/Cuf9PT3ZL+6kXpOQ8obblcC5rAKDmdU+uG9VdA?=
 =?us-ascii?Q?ggU57goenHYYwFw6wUWb5NTpBoVnarwZsBh4NjMgpX0MM0h9pqiBW5qcxU72?=
 =?us-ascii?Q?JfLfrKTifCjBNOc63hJ/S6mRE2Nkv3PK46swhJKwPqRhq9VFlBSHePXzvuZx?=
 =?us-ascii?Q?aOFfcRJQruX/9rPZbV7EFGKPGkOYjXEvqQjzPBsply42P9pt8rAuhkgkgV4d?=
 =?us-ascii?Q?tha1OwV0xulUMsezc4iVLxpdGMjjRp4cpYSiviN8pF1p9BzwnYtBW1axtQy8?=
 =?us-ascii?Q?tkjImob+jJpF/tZ9pjkkmVm0VtVvjzCRp0DH5IakrYcX9dO9lqmaTI7VmlSP?=
 =?us-ascii?Q?5jWth8+JkSMXLKag81UWL+KiMowVmd80491BmJ+7ZWJwr81iOFai0X0jvqo5?=
 =?us-ascii?Q?tNUyNLbT7it8oaA3AsncM+6whS4yVNZmfgTam748rQliy1KOqUdFiNCjyRKB?=
 =?us-ascii?Q?MLZyEqMS9jyisgVQsVuh4MpxLBnXZDoOQ6XOldymjLztmk3PPyu7a0ihQY36?=
 =?us-ascii?Q?o3vvb4bL8aJ/X7meskgVJQvLMe8rwLIHQu4GOD4H4CFWYLhJCXM4XNldWQ5P?=
 =?us-ascii?Q?5vZhX7xyJU5wwMxk+3x7KY28lQTLq5NbguMmTH2Lt0no5AlHonZjivz0GiEG?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0890d317-174f-42ee-2054-08de2a33a24d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 01:57:19.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgHyy11R0XxNpag/LLRDBDPE6qf9l9LHPUcazv5nv0Q9cu/R47zkqxp8vTH56Qt39bOgWmWuVd4loBRM79rang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
X-OriginatorOrg: intel.com

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Matlack/vfio-selftests-Move-run-sh-into-scripts-directory/20251122-022109
base:   fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7
patch link:    https://lore.kernel.org/r/20251121181429.1421717-13-dmatlack%40google.com
patch subject: [PATCH v3 12/18] vfio: selftests: Move IOVA allocator into iova_allocator.c
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251123/202511230306.1hPcCizQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511230306.1hPcCizQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202511230306.1hPcCizQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> tools/testing/selftests/vfio/lib/iova_allocator.c:2:10: fatal error: dirent.h: No such file or directory
       2 | #include <dirent.h>
         |          ^~~~~~~~~~
   compilation terminated.


vim +2 tools/testing/selftests/vfio/lib/iova_allocator.c

a1ab4208a86852 David Matlack 2025-11-21 @2  #include <dirent.h>
a1ab4208a86852 David Matlack 2025-11-21  3  #include <fcntl.h>
a1ab4208a86852 David Matlack 2025-11-21  4  #include <libgen.h>
a1ab4208a86852 David Matlack 2025-11-21  5  #include <stdint.h>
a1ab4208a86852 David Matlack 2025-11-21  6  #include <stdlib.h>
a1ab4208a86852 David Matlack 2025-11-21  7  #include <string.h>
a1ab4208a86852 David Matlack 2025-11-21  8  #include <unistd.h>
a1ab4208a86852 David Matlack 2025-11-21  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


