Return-Path: <linux-kselftest+bounces-16408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBDB960D64
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053D31F22F91
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4A1C4614;
	Tue, 27 Aug 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe6OMWpk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65F33E8
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768297; cv=fail; b=l0W3HbXktIcVj0vSP/ogDwxyabcm0T+wp3hd90vMOIWV5Ke4pEHziRBzB+0ka8j1kQISMrXafvxcbfhqC0WxJwxxy5Dm1lwMtaS1dPUS0HU4JyIDRVLVRj4dvDIIQlgsAj6rHCQFzjrS7NIoVoI1vaq8sKAwNLgcDmdjJcIOFp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768297; c=relaxed/simple;
	bh=kXwxfVo2S2bqln4Fb5PU3En7Oa4my6NAkRpwQNg1xfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZGR6doP05NLXX7BWgLhy4jDRclAXg0gReFjyD7771Dal46z/sQ/xpWutUuj2RGdIUgUEOMoEfpguL2QObrDDfXyirHk9LYcCnbS3OTbDJUFsY0MXBGYkHW10VRbjmU1a1WoJ4eqH02q8gL7tVQKJfsJjUwLBXeq1+X62FeGcxJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe6OMWpk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724768295; x=1756304295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kXwxfVo2S2bqln4Fb5PU3En7Oa4my6NAkRpwQNg1xfk=;
  b=fe6OMWpkbFkGvieLiUYM9xLxuKYlTnaYCZ3D7r1zxEcAOrCGT22TA0c7
   vi9Gvf7ih3IPIaln+OrVqU3Fp2VRSZNLdvv2fNhNPVKhVQc1LB2PUFqio
   5jML3XoW52lw/FlEIUS46lAVbWCm8QOg/4g8zEv7N/+540J5YfAqkBXLL
   LXv5bqIf5bg1Mov0mabMDt9oe19LTUYmRh7pSWCU/eBpfNMSpbtaRdZVN
   dxHRDo/mbxzka4GTLQpxdPXVCjTdhv8mWuVM2qUXk3a82OnzA2eMEwJpV
   DNP98lOnMs9utJ5ouwI5335ANc315j8+uthwVq5hNJ8BLkoENIaHZXjKZ
   w==;
X-CSE-ConnectionGUID: AxODW4ZwRGG5lOK2gs7EYg==
X-CSE-MsgGUID: cmN3NB8yTb2enyVqk9ojEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40721309"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40721309"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:18:14 -0700
X-CSE-ConnectionGUID: qhYhpW7IRtCZT5ePvmMCZw==
X-CSE-MsgGUID: L823TZ5PRVaXmfi0cfoqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93616906"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 07:18:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 07:18:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 07:18:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 07:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrVhg/sp18v6YV2z6dAlg+ABFyV5/YcwA10qP4YCZBpw+154ht9jZCtiZfHoGoOPUguRKkGY/W7T6TWaeABJzRQqfgQ2upEF3nuB/HRUri6igK2Km17BnqMcBT6gX2NgjySPXdz9haMRKWe9cVXeslurufEKAxOz7M0dhtmYyK7l6M3dQbD1+o/ksdxwWHSEIzznNvR8GEaXZBY4SdzzYQJ4uL6xfyeO2EM3mLfo8s/hkmji4LWuu6rXaJPLn/q3OgGQHtnn6uBQ1SXNRyiQLHY0m5rurbuWX+tpO3elTkngKMoDMkmTsFCbdwboX0difp0kXPpldIasjRg5cbTPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mer+jK1Sdiy4Rx0OGff/9Fzzq6LYxQMxlt0h+gSbqs=;
 b=p/wML7wzt9NtZJbhXNdm5lFCYVDEXkidhFAVqbRZBF1teReW5+WbKZhUhNS9ySyTQl/9D2fiQf3fo+4vwcYot3HjDeyOKBoctquPE1M0kkM8q+t51YoimRvIBGN4t8gbIuWc3IsBPVVY9Js8U95vxD0hZ+iIYBnYhSnZXoHl2KKFd/fXEVY/CbrRG7oxPxt0nPIdAFqgB5jhzXNdYgjPb+f/Zs2BGAtioBNDjo54sPg9EXkcz1WlD5ZWqGacK9zDClWQNc8LgLPsdseJhfM3zf4itJJt9IoQcU84JHVDspuFZTavihkRwtThvXIx2MIdka282K1/gNN6VFDPBUBu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:18:09 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:18:09 +0000
Date: Tue, 27 Aug 2024 09:18:05 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, Rae Moar
	<rmoar@google.com>, David Gow <davidgow@google.com>, Daniel Latypov
	<dlatypov@google.com>
Subject: Re: [PATCH v2 5/6] kunit: Add example with alternate function
 redirection method
Message-ID: <jumo3i6lnzu56x7tduioxvpnfhwdncu6trqogxk2ahtzmayrqg@7lb7oyhnrni7>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-6-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240826222015.1484-6-michal.wajdeczko@intel.com>
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 99648e46-43af-46fc-c38a-08dcc6a313c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EF0wR4edZ1EnCciDs9+jOmuFhodC6pxs4CmXNmuKIIrGEMyjwjtsKFlPqoCZ?=
 =?us-ascii?Q?sck4+5JoU/D07MES6BMmdsL/TTlIJBaDpNs8CKDyUQ4am5+sgtrP4qqTz7gd?=
 =?us-ascii?Q?3KDoaaao+T6bg1xh/fTHeVQ/RToINjw0DnU3W8+02fKQavVG/zUkYzXdiyK3?=
 =?us-ascii?Q?7yaR4uxeEdZGAZoyFO//jY5otfSgw9mcZgNggspkrOkPQvTVs7mJVCwJaX+i?=
 =?us-ascii?Q?Cg9PPEz3u/7ve4hZO/R6CLL+U0YiIJSBKv5H63446+IFiOg/p/zF+Cw6zkha?=
 =?us-ascii?Q?Wj8e4RICehhzTfH2yq6cXxwWQ74wrOA931t8j9fWqiTgKSCU0Qdh2LUGOILi?=
 =?us-ascii?Q?23AU1DMdM+sH3OVPKs2wa0k5jBF4/OOaMUkiNYEg01S0WU3SBZQohLt4gIu7?=
 =?us-ascii?Q?rIUZkApxha8dUYZnOXmaSa8zCnQEBBCLoXbQTdx1E9O91cOl6MZetoGrgp/k?=
 =?us-ascii?Q?OPPUjy4EiCEdYnrYDbDHcXlBWSMAyiL3A+H72S2WF2Rs695ix/4wwFQfKaGO?=
 =?us-ascii?Q?Nfe5/pH28+vsT4NDUKQTJWaDFcACFP5GL1x+iexSsVRJbnKhcCZ0G4o+Dm2g?=
 =?us-ascii?Q?FQw5/9Wec8J1RJ3cVzNp6jdLrVpGhHYOdYhEReiv2Dy1lkBTrfQh49OTBe05?=
 =?us-ascii?Q?tw+tljlzO0xfDMcQQX87SX7OHQck4IeQoOLLn9j5/exRHO5SOwryJ6/ymwVt?=
 =?us-ascii?Q?xsXoHgtBVSOMWEAVNKaqAS4uYy558l4yhMHllkyXMKwega/COPCIkni9hWlm?=
 =?us-ascii?Q?4i2L4SXQFWDvoBpmVI7pRN4vuOKNM60RVssdQoWTIsF4vOBYh6XuhX9Q7f55?=
 =?us-ascii?Q?HXLIVS0N8fc7tg1Aivva2bK8L2oURVnOxX5n0KFfHWCnJb3IVgpxgw3yXiU8?=
 =?us-ascii?Q?OZ9aMivwp5x+VMBPG4kCgpZqNszh7VI0/kShvIfNqGliRdX5oiVsCptHkZNR?=
 =?us-ascii?Q?zuCbQ/qSHde9c5c0hTnAiZdUEdJI2nOyLYeVUo1oc+tOEwP3eUZItA31b3Vw?=
 =?us-ascii?Q?o2MIpSYBYhxlLlOsWpErwk4nLyzMDFu6IA5jXKe7ylJIeZWi+9rq4mxn6GZ5?=
 =?us-ascii?Q?CtpmM+nG9X1gZTYhL+BO7nrhpQiurUQwWQ7UT2KlapLqGA9N6Dev+wmteB3t?=
 =?us-ascii?Q?rDOcyQJHLff4NMT79LiUqjEmbM46/usXnwx/UNAqk1JoRVf2H9y6/8K8kNUJ?=
 =?us-ascii?Q?2cgvAg7UgImyIcfaPksNAK0l2XMMkoOmNvtUMyxHeDW2zP7ywwkponUw+Rg3?=
 =?us-ascii?Q?ftoXpnfuw3duntTYyJ6n0K2nbrxg9DNN+fHcP4O5IflZzuycUZ/r3frLsuso?=
 =?us-ascii?Q?dKyqckcDRZbx0GNDAUirELhry65vf5xQM7PrFfRvVMHxBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2w3+ZkHp9NWv5mb85c2EvcJGaOjH6pcRXVcPLy2Zw/OAdBzzryoVytFRPV5?=
 =?us-ascii?Q?M82MKIZN7EGM0HdBb4wneQm2A/bX1qNwl21x/ykBfuh95gU712VLhP+kOhCT?=
 =?us-ascii?Q?whiK7InFilaazAb9ajeuz6WKqDdV0zwaVbgx+A4OdchIGmsI7/fKPOA0P9KE?=
 =?us-ascii?Q?fZr/0w4eDHahwJA3YgUlnwQrX3XKDyyJPq+NJBKjlqlwEjPZ4JpNb/G/WxRH?=
 =?us-ascii?Q?SVYoTqz+YQ9isU2lpdeZAY1yuMie+kH3HzLmR0JkpnIPFk9NvPNCA1jOyRl2?=
 =?us-ascii?Q?LJVfwq3DPSlvf4aJpuqwWTbw9advKfcXf80X+QyURsV42x1/7S2E6f60N4PZ?=
 =?us-ascii?Q?IDBOMu1ytwSjbZF/bqJb0fDU3s8UNfGQnkPVY4d9yxY4O9QjSPMqngHUqkzN?=
 =?us-ascii?Q?tpYXXdYdmaKUo61sBdUl/yoQuFndIVYcjCiDTG4WkcTgaKqGg3yTc3TKBgch?=
 =?us-ascii?Q?SWgHg6JffRrRkoj0pRRud7js9BYQGRggkBYS0oIMZgpPT3qJVpLjejGTHoHp?=
 =?us-ascii?Q?c1Y0jP5i7GdZcQ+fBZN/wx+UlsewQYrKEHS1nb5Z1VePeR//HDbiq/8a+wGf?=
 =?us-ascii?Q?bQt8ovA1DzvMo8S3FuRFzi8z5duuAMzmyQoQlNe89mIm5CCTu98jQLLClhAe?=
 =?us-ascii?Q?odxy8kF0dJG0Xz4rm2DKvRuv0T6kOblh42itH6YejQCaWL1yLiY7GLnNyi3y?=
 =?us-ascii?Q?9hI8V0knEk0h2vBvxqqmb1HVOOh5TxX+bJf44wFnX2mt88VqEBjyWiUgZDlM?=
 =?us-ascii?Q?NZS6kST5Q5I5u/SyuNpdK6AqMaSwEkNR/P5up2e+O22u3LaRs49qg5rAtDAh?=
 =?us-ascii?Q?0X/uszPZ/qacpdc77XdAfLnQl+OF8FufcdOw5+EHmirlI4FxJLQWpqLzjzLj?=
 =?us-ascii?Q?p6+MR+LU5dXrSP26JMX82ePLpIVmC4nCG0EG95JoaXd1STpE98be7yuensAc?=
 =?us-ascii?Q?T2lpx6kpXn5+2gn+bN0mSj4tnESGSd4PRffIzaM1RDmnxIednJiNdFdFMBwc?=
 =?us-ascii?Q?5bqTWVq25ZmXEVwjqrkGxam3FwppmBDgupMJQnmsFJkvFDW+YwnnGSsJLKtV?=
 =?us-ascii?Q?DMmOhXPvaNtc3kMwFbBlnTWV5WlfCvWP+iP/2Nvt7Zqr8MsiTzwpDR1e9cwP?=
 =?us-ascii?Q?Cc5KGsY5DEXykR3SbUcKy4J1LxE7IfjHlH3evEhy8OnsHd8l3oSj/JXlFFUn?=
 =?us-ascii?Q?XII8QNmZOwVX0nqL6EjbCYpC5108Y5RZ/pkKRmCjHCZmfI4Nxcuui6AVx+ae?=
 =?us-ascii?Q?f2IVRIKA0SXq1oiiG0k2LaoRM1cHqMSK1kYvIQKTwmgYF7e4M18Z+vfoqlZ6?=
 =?us-ascii?Q?D8iNs5glAozycId9ZIyGOcIGWlEdsP4MZG2M6kQLvCmBnGMK1sdMU6aL90Q9?=
 =?us-ascii?Q?yIQdfNLcksWfHuRSgwj4gUmFyRc4qtadMAUtzlp7hEdq77fA2d9dmT+WsM3r?=
 =?us-ascii?Q?hBto3+ltEiFu+oNueJlA9n5U4WwcxzNa4KxtijHfFO6ElpuWpUiVZf/NuZPD?=
 =?us-ascii?Q?lCBfyyOGDQSwjf5+NozY62oUUJQp84QDdn44+/vXGCHCTrLoeocs4Um/JPF+?=
 =?us-ascii?Q?WOzr1v8+eC3BcQyWAx5rFQpD8SasQUPxrkxOvdDE1lGmRc8M9vpqnGTytMwd?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99648e46-43af-46fc-c38a-08dcc6a313c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:18:09.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHZCiRZNRp4ei5Czp8ZNxeZZDV9HkHm/V2/hpQCAcm/4oIJ1JOebCBogZLAGm62DDj7n9RLcGGAs4Kb+0V38apP2UN16/vVhfLJ2rrkWgxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 12:20:14AM GMT, Michal Wajdeczko wrote:
>Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its

s/FIXED/GLOBAL/

>usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
>DECLARE_IF_KUNIT macro could be helpful in declaring test data in
>the non-test data structures.
>
>Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>Reviewed-by: Rae Moar <rmoar@google.com> #v1
>Reviewed-by: David Gow <davidgow@google.com> #v1
>---
>Cc: Daniel Latypov <dlatypov@google.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
>v2: add missing testcase description (Rae) and rebase
>---
> lib/kunit/kunit-example-test.c | 67 ++++++++++++++++++++++++++++++++++
> 1 file changed, 67 insertions(+)
>
>diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
>index 3056d6bc705d..146935a16883 100644
>--- a/lib/kunit/kunit-example-test.c
>+++ b/lib/kunit/kunit-example-test.c
>@@ -6,8 +6,10 @@
>  * Author: Brendan Higgins <brendanhiggins@google.com>
>  */
>
>+#include <linux/workqueue.h>
> #include <kunit/test.h>
> #include <kunit/static_stub.h>
>+#include <kunit/visibility.h>
>
> /*
>  * This is the most fundamental element of KUnit, the test case. A test case
>@@ -221,6 +223,70 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
> 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
> }
>
>+/* This could be a location of various global stub functions. */
>+static struct {
>+	KUNIT_DECLARE_GLOBAL_STUB(add_two, int (*)(int i));
>+} stubs;
>+
>+/* This is a function we'll replace with stubs. */
>+static int add_two(int i)
>+{
>+	/* This will trigger the stub if active. */
>+	KUNIT_STATIC_STUB_REDIRECT(add_two, i);
>+	KUNIT_GLOBAL_STUB_REDIRECT(stubs.add_two, i);

Nice use of an outer storage so we can give it the same name. IMO this
should be encouraged.

>+
>+	return i + 2;
>+}
>+
>+struct add_two_async_work {
>+	struct work_struct work;
>+	int param;
>+	int result;
>+};
>+
>+static void add_two_async_func(struct work_struct *work)
>+{
>+	struct add_two_async_work *w = container_of(work, typeof(*w), work);
>+
>+	w->result = add_two(w->param);
>+}
>+
>+static int add_two_async(int i)
>+{
>+	struct add_two_async_work w = { .param = i };
>+
>+	INIT_WORK_ONSTACK(&w.work, add_two_async_func);
>+	schedule_work(&w.work);
>+	flush_work(&w.work);
>+	destroy_work_on_stack(&w.work);
>+
>+	return w.result;
>+}
>+
>+/*
>+ * This test shows how to use KUNIT_GLOBAL_STUB_REDIRECT and compares its
>+ * usage with the KUNIT_STATIC_STUB_REDIRECT.
>+ */
>+static void example_global_stub_test(struct kunit *test)
>+{
>+	/* static stub redirection works only for KUnit thread */
>+	kunit_activate_static_stub(test, add_two, subtract_one);
>+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
>+	KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
>+			    "stub shouldn't be active outside KUnit thread!");
>+
>+	kunit_deactivate_static_stub(test, add_two);
>+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
>+
>+	/* fixed stub redirection works for KUnit and other threads */

s/fixed/global/


with those fixes,


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>+	kunit_activate_global_stub(test, stubs.add_two, subtract_one);
>+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
>+	KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
>+
>+	kunit_deactivate_global_stub(test, stubs.add_two);
>+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
>+}
>+
> static const struct example_param {
> 	int value;
> } example_params_array[] = {
>@@ -294,6 +360,7 @@ static struct kunit_case example_test_cases[] = {
> 	KUNIT_CASE(example_all_expect_macros_test),
> 	KUNIT_CASE(example_static_stub_test),
> 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>+	KUNIT_CASE(example_global_stub_test),
> 	KUNIT_CASE(example_priv_test),
> 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> 	KUNIT_CASE_SLOW(example_slow_test),
>-- 
>2.43.0
>

