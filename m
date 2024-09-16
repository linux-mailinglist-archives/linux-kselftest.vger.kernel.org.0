Return-Path: <linux-kselftest+bounces-18021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3314A979BF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E9C2811D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361E13698E;
	Mon, 16 Sep 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6SwUMg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBB5C8EF
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471269; cv=fail; b=savVPZrsbg2vRchcTj6M7H/6CKogbzCcaeW2u8+c+/GPuhclav7is/dAQKu40vNRvsSeMjQNtsRQU3R0T+G6qwZUXKwNvW8rPNBY8HPdvZRBg4kspCS3uKRwxtCtwf919bM1yEdVl5ZPUo6M64L0Uq2UX7DvXFASJIFI0V7QBuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471269; c=relaxed/simple;
	bh=FZ2GjZ5TUlKeB7jz/Dkl7geRzbroECyY10pBgN8aBTI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=u2DtFAXd5tpG/9idKqzLY7WGZfd8ZUeUtxJ8jnt03D2+EvHIWT7wX8c6QyKvg3cp17fnhmLnJpi3vaj6RcUcmViHuQ1kDOGRwz0BOSkl7Wp9Wn2gp5oUe+coqciELIeAs3Mjacuzbd4c7zN9cuK8T76yvTBbQIdMjqbWa5orod8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6SwUMg3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726471268; x=1758007268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZ2GjZ5TUlKeB7jz/Dkl7geRzbroECyY10pBgN8aBTI=;
  b=P6SwUMg30zsWoAHOckzZ3gJDmiAoOzhcFUW1/8m9gp01jb3DmCfERJiV
   zttOd6w39Jp5787rFQKBVjWL/hIXx/J3IVsrlapS4cq5e3eAQDQAZYiAq
   04pPz6dLt4EWQe5pOJJj0VimwtxmBgFAB82F2Vg71VuYbqYPxo3a1z6Y7
   vg0cwFSxtS3zNqc1ifMnzWOvkr/e7EEqxOG9NnFI5rxsG7VlhwpgrRmwW
   G+1lhkBzLr+hZwRqBXQWSsXap+FLz0vZLln4u3MIzQcebgqQxaIZAIQH1
   HIm1BLLVOACIR4ZCeroev5+zi3CRAZUBu5FJxh1ZY7TcKoPtTXMAnVPeW
   g==;
X-CSE-ConnectionGUID: jLKH+fA4QlOcC7/q/VQbBA==
X-CSE-MsgGUID: U1QPelg3Rwiup8RqslAKiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25446428"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="25446428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 00:21:07 -0700
X-CSE-ConnectionGUID: 2pu5MsbzThSBZG3y0KEjxQ==
X-CSE-MsgGUID: poDR43a9ROuL5zkjbtsyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="68664655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 00:21:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 00:21:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 00:21:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 00:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSWL7BWWfuAxzUJ6QmUoqoSB5qUPulX8igEyPFjlVBimmXPw72VpCH1Dfrqsssnow1Ky4zZ7yvKHXlQccMpOXrylt55esMqreCyp2kxQ6Zn2j2uhD+TwXGTS1kXxqRb+YvGPm+OlAoXJvIFe+L4e4IswOegV1mt+4Z6XAwzRpfwCiUuhRFGX7aDaEiUHuuxJJB78qzMpsjdnGeDOYsXQhplyw1x3xoqsNxGNLbObZzOjRNwUYJ7LHughhTo3AmVnYGYvWcsCVhXi2upG5Orf8IV2b209Rhb8LwMU/YfUnrDRx9C9HsJYOK2h6hGLYDQ4vK1DYL3pWFj6G0s2FIecvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6i6EKwyBiOPxpySNgAzVOBwIoQCyElLA/DVh+nyIgg=;
 b=aR8BMLURO6suP/zaAmtGgXHjW5FPCMY/dpHkcQI4qKxdcBM4qNcksJlktJIGIUEtY04aaxr6tR8loshmM6eAIPDxllxVs0CEbySb16FXAmBBqjzcbOs3edU1pXHpH4FbfK5AxPhHGbbKhyLcTMDq1oizyvgWUTnIm1uftQtsOr327g5H2+wMFTz1TlqGXIslG+/XEHf4nwz9QUZI3a/aUtx7ZouVsAStvryqQSn3qePZkMFPzTWpuFRZRtjEXPkYZf7kv5PU3qg8//35r+YotqOXomj0P3wgVFWL6v80bJIMkVdv13Y3VWEAcak0JvzmMDm9Lro38SAayvlJjOe9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:21:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:21:00 +0000
Date: Mon, 16 Sep 2024 15:20:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: I Hsin Cheng <richard120310@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [list]  17640748eb: kunit.list-kunit-test.fail
Message-ID: <202409161554.6c3e8d5d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: eef50329-4704-408d-6dec-08dcd6201d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8NhZFgPEF1dJSsKHaw4OuiNE99yWXBNA1PRLqpOPA/kDkieCC29PvaS4pmCC?=
 =?us-ascii?Q?43BCLiGSfkgpHdgvr0RLMj/Ysunpcn9/+c9dqa3/UD3s1r+94S0XmIMVY9B3?=
 =?us-ascii?Q?ve+c6qgTVSboznEBovqE5A/b2F4EryOkmnRE3S44qdFdZBH3OweZQzRZMHzc?=
 =?us-ascii?Q?xiG6/Xf56N/4IPgt//u7TGB4hBDQAGMPpRv1O2oizo49feQMur/ITtGquDfm?=
 =?us-ascii?Q?eNwmslrpxnH/KLyYPd1uhQcDk+eFD1224jTdCDg3Mr0S157vzm2duVSiZmEg?=
 =?us-ascii?Q?ClFKXWJAT5x/lr7b+/ZaPOi4HPx33aNqHmINJg5ULDE7vANF0eaZYcKU+A2c?=
 =?us-ascii?Q?bj6FRvyM/uPtdmpoMPTmghgoRdAhQ3R/NLcaW3/dg+1x0Dc9xs8EO/auJom9?=
 =?us-ascii?Q?PItbnriEm8V09uXUBTnbZHqkQo58b20S8pQFgVl2WLs+Gmn58IFS9Pyv1LSR?=
 =?us-ascii?Q?q47DBkzothm1OJrvcqHQoCtOmgf/JxQu9iP/Ja3BaWn931ezuH0a4DroXvmc?=
 =?us-ascii?Q?oKlE3RjhIIFS2YP/AXe7meubam9sOw03Z8QMhXj2QMneYO8zoC77cvdc8EP7?=
 =?us-ascii?Q?Pdj7aLs015uS/vnzGl7fsj33QCMVZIeb3P2pqsBU+EpWww/LpRROd0OSAz3x?=
 =?us-ascii?Q?2QDbmfLv93m65HSolMhtX0GyUtJTB+2SR9JAS83K6/ZmoGiTmTDdniBhKuIh?=
 =?us-ascii?Q?uYrmfbgnb4tXLT2zNDybqczgDxY3secU7y4a2U8G+bFwxRMeIY9jjsYCVzeU?=
 =?us-ascii?Q?3VWiN9PYxQhjMEy0XEjszIMEHm7KHTP61vcZaEjIgG2VyQFulVG8q/8j04MN?=
 =?us-ascii?Q?2nKAxhl/I39ZE5RSQr0eH3xnT1yBMaqXDWF/2yo0uaod9E/hXR1VEaIGNBSs?=
 =?us-ascii?Q?c62KiQgtgU33p3rPoCiGq4WFCw/3uAWTFLFeLmbdQysZxeMvZuTP++WTwLu7?=
 =?us-ascii?Q?uBSjwZzsVoy5Et21EtDpZE8F40Fd1n0ZIhaigdD6kUYeTiGsBB6TkJsmf3cl?=
 =?us-ascii?Q?HO0nqEqjhtxCFV3rCyqXfxM50AuvT7x+4mh3uBzS0EbNoqr88eSw3k3qcKnk?=
 =?us-ascii?Q?QhgJlu26n6i2eNJepsN/W+Bs1/bp5yMUeNo0NLz1fM4crkJ7r1eGc3ZbuFkn?=
 =?us-ascii?Q?KWuFmAWOb2qGZt8TtHXA2lxtCfp/XCOUqnLCfJhkxWwnRFJvjcbnXJoEwu9n?=
 =?us-ascii?Q?cP7APXaQyv4hvUqE241Q2EkaRsqUq9zcRM/6OrZFRjjM2MQ1r5jvtQs2ozNX?=
 =?us-ascii?Q?19Yhaed6tXREkQLEzuHInXJKCBgU3vZr4B7FI9TjI91/dk9Wl0g+9ib/lxJf?=
 =?us-ascii?Q?pkFDq4g2nibGJ/oyFm7PDyehNY9JEPeOFiOZzHC4QpqjEQZ1EZZ99YQqs3DL?=
 =?us-ascii?Q?W5GWdXo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAHJMYkSX6XY8hGYsz3tYa9jdmjne/tVfCLaXErMp5tJPnS2MgROI4Y1MjcJ?=
 =?us-ascii?Q?ypUK0JLKHyNkarOTU86SkjFENd7YeCl8AmqCyWN+/D3wxmLANh04JtaxkmW9?=
 =?us-ascii?Q?dZVpIiISluUmy7uC3h5LqNB0oXq0nGqmDIfeuWYtSPFmJOrM2P9ybAwySGuA?=
 =?us-ascii?Q?ZujJQVE8ZrqCZu/zs2l9uE0Rj7ktEidmr84VhzsQmofb3+tug889Xg7BBEz4?=
 =?us-ascii?Q?SaJx39lYlVeNK3GkOvSh5vaQuSac8Ss+96cioppNCxLddywb1t4gitu/zWAX?=
 =?us-ascii?Q?Z0o7Y3NYT0Ajk+H4v/MKuHXwmiVmlAm5ykhf4900/MAd1egNl3yingXOZoqb?=
 =?us-ascii?Q?i3XhI5znN0MFehf5LgyYjLrTFoYmAHjZlrpF+9nZ5DdoIGEkVTGDDN5mlFhO?=
 =?us-ascii?Q?JIWFt1v+4mLRYsjZMT20OnLOQlFxOXSkzeYisZBlNMDVVWgFSYheGXzeqGyC?=
 =?us-ascii?Q?zNq5rkB09RrBisZ1dHRrm5Rn4Qi1dKYiYxbs3iVZxk67Gcc1o1n0hBbctjBD?=
 =?us-ascii?Q?qktY7Q6rs8wtMhqSnS/Q7IKK4766UMxHuy6Goc+tIqZztN+jOYNecHm/bv0f?=
 =?us-ascii?Q?HTuxMaS5FEqhfdqK3ttvMCZNsr6QyCL24L4z1YQMI9+p2i1GllspS8zyBF7x?=
 =?us-ascii?Q?aOVcagmdEWMejjfWopnNLMivVNf002lVjbW0Dh7HYGeajD59BYeI04jjYaxn?=
 =?us-ascii?Q?NfcCVZCMmYXvlXuUBPO/BVJJoJNg02JkhU7ro+ZLfA6hzdJoq6w1m1pMWkjx?=
 =?us-ascii?Q?tV9Y+C8nuF2rDc8UGhGnLbCqkKiU7kMuwUosRVwXMLnxxwvuR0z9qJ1lxMiV?=
 =?us-ascii?Q?aTBJMt9g9pd9Z9Og+SAPxnEJqRxUbWXmaE023mvlDxmRCAJWncH6SIOMFd0K?=
 =?us-ascii?Q?TQ99muklt49nYWChBnnFZTmBjoRngswDV0o2Yi/tSbOuOK8ANxJk2et3JB2S?=
 =?us-ascii?Q?B6RnGLnpquLZ9y8GIpb5P0FQTTP5HRsyaxX2FderAOsnWnHw1+aJgwD/0FKK?=
 =?us-ascii?Q?ljfMWKFH+k132c5Q8AVUwwp6ivlAZheMcw44wBsn5uATQkTmjA4BSKha/xbC?=
 =?us-ascii?Q?uaQzBMMmgTGttLIopz/kTQViAgDx42gywWrM5r9VATNn1h87KNAEzgacIaL/?=
 =?us-ascii?Q?vR2bDsOMxO18sxbDePh2GSRc/R5/X+KiEMDfIHYowpUh/uSVOzzpnkTjP+hd?=
 =?us-ascii?Q?JIETWB7qeSqS8NORBL6hG8DrdbQmrILhUAeeX6FY3fymRbyTO/7oZWeTK8Nu?=
 =?us-ascii?Q?4wKG2JHmi89JXLhvaqEeOeXDQblyWjV/nmSt0Xc/usatWn6gF4d+WYBWsiPL?=
 =?us-ascii?Q?e3d0JroTg/cBaWOWiSxnnHQqyXQTN8eZN1LK+dpOziPSqpIPjI3yW4jU0ryd?=
 =?us-ascii?Q?KplZIGNa6qhoSIZe4gr1cpN0Wh5q37MGl+hOngYkIjjL75S4ZM9fNRZjHeKe?=
 =?us-ascii?Q?hCnxaGmey8t/NSIuwp9uWskKjcdUs19MJGn4V1Rmj73vn5IYPq37WObIv4Km?=
 =?us-ascii?Q?Cgfie7U5pc9BFx+RzTERFCqTB65NgJacprNYijvCifqbwt3yAMvT3MRzoB5+?=
 =?us-ascii?Q?huaJQWIaldhLNZY+TSImWCglpRQZdmSbFe2au+x/GMWQQfP4XcMlJUNpMf6u?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eef50329-4704-408d-6dec-08dcd6201d3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 07:21:00.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTcGqWcK3cEIg8jP5Hm1O8htqlkGBpMiV7f1sKi1Lqm5ACbEcOgw8E0agPLbG6mVWoVuyH08z3/nQYJXin9XLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kunit.list-kunit-test.fail" on:

commit: 17640748eb3875e486805e2d98ca1044a3a69b93 ("list: test: fix tests for list_cut_position()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 5acd9952f95fb4b7da6d09a3be39195a80845eb6]

in testcase: kunit
version: 
with following parameters:

	group: group-00



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409161554.6c3e8d5d-oliver.sang@intel.com


below 2 cases can pass on parent but fail on this commit.

13a6473783aaced3 17640748eb3875e486805e2d98c
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9           67%           6:6     kunit.list-kunit-test.list_test_list_cut_before.fail
           :9           67%           6:6     kunit.list-kunit-test.list_test_list_cut_position.fail



[  143.881460] KTAP version 1
[  143.884865] 1..3
[  143.887802]     KTAP version 1
[  143.891541]     # Subtest: list-kunit-test
[  143.896316]     # module: list_test
[  143.896336]     1..39
[  143.904046]     ok 1 list_test_list_init
[  143.904607]     ok 2 list_test_list_add
[  143.909698]     ok 3 list_test_list_add_tail
[  143.915034]     ok 4 list_test_list_del
[  143.920415]     ok 5 list_test_list_replace
[  143.925428]     ok 6 list_test_list_replace_init
[  143.930900]     ok 7 list_test_list_swap
[  143.936712]     ok 8 list_test_list_del_init
[  143.941952]     ok 9 list_test_list_del_init_careful
[  143.947363]     ok 10 list_test_list_move
[  143.953422]     ok 11 list_test_list_move_tail
[  143.958536]     ok 12 list_test_list_bulk_move_tail
[  143.964192]     ok 13 list_test_list_is_head
[  143.970279]     ok 14 list_test_list_is_first
[  143.975777]     ok 15 list_test_list_is_last
[  143.981871]     ok 16 list_test_list_empty
[  143.987375]     ok 17 list_test_list_empty_careful
[  143.992611]     ok 18 list_test_list_rotate_left
[  143.998511]     ok 19 list_test_list_rotate_to_front
[  144.004367]     ok 20 list_test_list_is_singular
[  144.010375]     # list_test_list_cut_position: EXPECTATION FAILED at lib/list-test.c:409
                   Expected cur == &entries[i], but
                       cur == ffffc9000126fd70
                       &entries[i] == ffffc9000126fd50
[  144.016196]     not ok 21 list_test_list_cut_position
[  144.040950]     # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:440
                   Expected cur == &entries[i], but
                       cur == ffffc9000129fd60
                       &entries[i] == ffffc9000129fd50
[  144.047033]     # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:440
                   Expected cur == &entries[i], but
                       cur == ffffc9000129fd70
                       &entries[i] == ffffc9000129fd60
[  144.071616]     not ok 22 list_test_list_cut_before
[  144.096387]     ok 23 list_test_list_splice
[  144.102425]     ok 24 list_test_list_splice_tail
[  144.107897]     ok 25 list_test_list_splice_init
[  144.113704]     ok 26 list_test_list_splice_tail_init
[  144.119664]     ok 27 list_test_list_entry
[  144.126022]     ok 28 list_test_list_entry_is_head
[  144.131275]     ok 29 list_test_list_first_entry
[  144.137246]     ok 30 list_test_list_last_entry
[  144.143084]     ok 31 list_test_list_first_entry_or_null
[  144.148823]     ok 32 list_test_list_next_entry
[  144.155283]     ok 33 list_test_list_prev_entry
[  144.161048]     ok 34 list_test_list_for_each
[  144.166792]     ok 35 list_test_list_for_each_prev
[  144.172318]     ok 36 list_test_list_for_each_safe
[  144.178278]     ok 37 list_test_list_for_each_prev_safe
[  144.184235]     ok 38 list_test_list_for_each_entry
[  144.190607]     ok 39 list_test_list_for_each_entry_reverse
[  144.196199] # list-kunit-test: pass:37 fail:2 skip:0 total:39
[  144.202470] # Totals: pass:37 fail:2 skip:0 total:39
[  144.208908] not ok 1 list-kunit-test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240916/202409161554.6c3e8d5d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


