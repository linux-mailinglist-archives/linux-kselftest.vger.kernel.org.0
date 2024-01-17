Return-Path: <linux-kselftest+bounces-3138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C31830141
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29F0B24A41
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FD1170E;
	Wed, 17 Jan 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuFhmxzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055BD510;
	Wed, 17 Jan 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480015; cv=fail; b=DCKzvWsFE5kw3zCfEr/+G9oVKvZ46CCnO6ppFu4vFweIOFB42Wg2I/iDnNgBAP4khOGb0nVOk+2JvR02deeq8/TuFCUN4Lt16cDRvR568AKVikDeOoL3hT9L8oaufo9GyC7DNInyXMajgZEuvoBNAXcs2Cg8540iGAWvBwcYKxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480015; c=relaxed/simple;
	bh=Qv/AppUfN3iswJ6wHCfa6Z3iB6kZD0hKgxAQTdVbGqo=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=SAFhAR8IA6YvFA67u27126yhO7hRDvwPJb+HnwGEmb9OFT49gIA5A4ibQlefvCLWVRrIze4muypJCK2WjhxtOxj8aFpRv7l7pLsv/OAEsiTYVe+SAB25Yt3j4Ul8y7AIQpOnDsAyQT/VUjs10eoJVK7DXMzcXRjtEYDHur2yMao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuFhmxzz; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705480013; x=1737016013;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Qv/AppUfN3iswJ6wHCfa6Z3iB6kZD0hKgxAQTdVbGqo=;
  b=HuFhmxzzXKITuWxzRIefe/rdfpicoVpFjvEFado62JGxXu1dqhTjNz32
   480E1USenMVbDP5NaPPyb/Ouyy6oWPlTa8lRFylhaEeQNoumxoHrdidJm
   8j8rseMtPSqFco+XAtw9JUdkfinT8udO4aAsW81TLpVllUPputqa+33dP
   lhsi28kLqPLNqOHCRAYTxwEAQXkV26Fhw/D+bvvzCTOErqiQMNgTKYAlT
   w96Nw110Rg0+wqcKD9OS+2+HtsuEnThXVG+fiCYoqpIlVmPurzfNSbHNO
   edEpNYLYp9/vuyWWC1PsIGx7ZmvaYgkJ5PQyXhdkOg9Q27nMV74NfNWIv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="403866736"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="403866736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="733905941"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="733905941"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 00:26:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 00:26:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 00:26:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 00:26:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 00:26:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEg/dggDEnPb7mIQm6MSq1SHD1KrPl7kdTm5f03TD9102ryLg7OLoZCTXgznqVuLCC7bs7yeM04KtbRiwnP0y7JPTRvyAoZikpherdcbgdsWs+mYyHEIttJIJQkO7abyf4UHAqaZrSkhQv7oV9tAZWSEdNLSlyyTbd8e6T56IH/g3RmAiEp/Wx/2Ik4hQ9qCh9NzFeewFjN2Exlpy/AsdO7vbn0gu7c2hsljIxpmQspT3Jq7v57JR6YrCtnbZnYwCYFT9avNYZlTOm4hGnzfabZMloVz18HBwXDACgGW4BIMTfiA3s630X8O/n8+fpV3DPH9+921NtE7FTA+a7a8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1Sl81FcEXE5uHb4WQN62Dd4JkM/tXpM/2AGfxn+2sw=;
 b=n3RGx0Syx0isH+Lqun01HkEkEMl7CSqMjWeTxCDBhz7xT5lTQ6RiuPyMgupxcCeTsmPLYcxxruw+99O5lJbTyBziOjQ95hbmIt3cijrOGtq8NQL9y+e2dlIM1qhaOxpJ52z01Yv16CulHf84cz4K+Irn5s6qMi1fjlcVyouZ7vxINgm6393Im3chwmKFCNE0B7FVrIFi6n0tO36k2ZODLovRwxwiQksTfgOh7AgZ0T93OqsNwq58hZbcaSl+3I4BvTK9hYA/OCfUrd5882QdiDB9HPatCKRJ+lGroDMaOQYZJweyCU7+eOjXSpLLl+EmsI1VidnI4/3dyeMcp0OVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 08:26:34 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Wed, 17 Jan 2024
 08:26:34 +0000
Date: Wed, 17 Jan 2024 09:26:26 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: f91334fd-9ae0-4052-8119-08dc173603d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESgiFlphsezODLhftyuqsOWCokE7aei+vQvS4N/ZXZXtbJGCMAxOatYHMXmYdHwnyMoxgs2eyBjEAa0OqsooDgRb1BPjkQaCVGMAN99hJwYqOvJHVQrAzSMGa1ZK4EBjIrrAegYBLWOobAQME8YOwqTmo4Dw9fchMS/kVleWNvGiBiOPGfNfHPWHVx6fOqOqrglE5fOUxCvQU1AABVzUiNMfQDwed981gXY2Fyct2SjF6dMDP92/e0jcYoPcVdXU45HWY7ZWeBZsQsa1F9t4HLeMq4i4IYHk5dPfUEiIkr6ZEokjWwpBC+0rR38H8E82JmOjqCZhelbhEat8/5Pf7Bhfv0I8N5pW6/Pu2szBjWrjd50fhxpQgZd3Xj8SJSwZnpiwX8iUbpTarC5UhsyCh8qBHCYqDTHaaGteJr3u5H44wnkQHW2zDaRZA1O1NBqQ41ooDJXM4Yww61nzBkFzkm9bi/9oHPB9qGT6q3N5yKk62DYbpDrKYABa+wSb+0w+AsrfsmXmuFdOXdZBenivburj6Y+KP/KG3VuzA+37LYylLZQzZp40Ux/zIqEviMSU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(6506007)(6666004)(5660300002)(33716001)(38100700002)(8936002)(2906002)(4326008)(41300700001)(6512007)(6862004)(66476007)(478600001)(316002)(6486002)(66574015)(54906003)(9686003)(82960400001)(8676002)(66556008)(53546011)(6636002)(86362001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yND7j+XIeErp4rDifP3ZaE8IGuVN+sNWpgxy32oZ+5ui8/S1vhPv3Aa5sZ?=
 =?iso-8859-1?Q?WpCkTVPJAFKBW/T0/r18y3zuMjEgtHSdnCKthk2YPBDIGW9EhSabznLF/V?=
 =?iso-8859-1?Q?f/IAAUiA96zXLPMgRPBzcz6MKdUp54GSIdrOZzDJNQO5P4X6GEuB25kp3g?=
 =?iso-8859-1?Q?oDG7o5QMSUE6Q82WnFt6/Kf+Zj0Pa9jfNn9Y0EAH2ZJYuWfaeSjaa02yaw?=
 =?iso-8859-1?Q?hOao2DQZ3CtK16rYfAfYfc1E5EPX7ckVci5kdbNl/BIUuznHrQnp/PBzDF?=
 =?iso-8859-1?Q?Knd52fKq2agjwdnZzmJ+7O5hJeIfRyEh3qsvOqC3nVXkxZU6O+/KEBHMfw?=
 =?iso-8859-1?Q?+4P8uLBQcJs0ggM7n3nQiHYIW3N/gBcmQmAhMBJcYA7t7CALKkbw9qXOYa?=
 =?iso-8859-1?Q?mq4cXcy4gDhqHxPkVVejGWScw8f52mSoIr0dFAxXm1IjPvA/Qq3IARwsfr?=
 =?iso-8859-1?Q?H7acuX/fZEEtxP+bI/LYAW8VmnrBameMf32awwl2TOZyaCBvBtPyRENSGm?=
 =?iso-8859-1?Q?5yP15qys+XOfk/k7oJilRu9KgAdtWmD/XDzbmujcRF2AUZl8nTLBlHo/nG?=
 =?iso-8859-1?Q?foyRPRSBGQi+pzbHfAeZeQSJYAs6n/89mTqMOQHxSnfHlIL6OyZ5MXCN6R?=
 =?iso-8859-1?Q?mgMMpgpC56yxII3J0hMLqZzdv19sAbI1g0GAgoRkbS5vMkI1ROsAuw5Qtg?=
 =?iso-8859-1?Q?aJFkcHY+hpYAjpLQMe7BDeSkxWSAg7e1Gra25qGa8/pVdbikde2xfQVo6S?=
 =?iso-8859-1?Q?lkNgfjiu75LOsHLvAnDw/qI/ibgQ8cEy0Mm+h0rpoxA10OYkSS+ac7d2wN?=
 =?iso-8859-1?Q?t/oXW+qnto3DPsT8/HimLkIwYnhtzz+TJBWu+LWYviL1ETsU6YwkFcMK+9?=
 =?iso-8859-1?Q?fGzL5crXP+aO6IGAVXr++9VHpQdmYzEViNRTpECoshWyVGMt9OTnPynzgA?=
 =?iso-8859-1?Q?h8cHvDF3ASchPW02sSCzHUm/FhwYCSW74BQyFTM9IwA4ZHJXQHWQRVnWzo?=
 =?iso-8859-1?Q?XSrtN/q1fTj12uKGkjycX+L9DopJ3jp31gP4+tnkTMVs4VZwAl/a/iScE7?=
 =?iso-8859-1?Q?CjiOjZqbCKDuSOYdioxAK8OTOxzpsAjN8MHitI0/OSGY7fVT7R11nvFbsl?=
 =?iso-8859-1?Q?x5a7lgdfd8dp2ezUlr7IykvsHx3sh8t2lwnLz7xk3VsMzrQUV2TqUxiSBj?=
 =?iso-8859-1?Q?K6Cm8O7GpvMHF0abwTf7QaLNQoQevvMZwvqrQ93iuVRlQREe0nUOpIwWFp?=
 =?iso-8859-1?Q?K1TM6Y1Wa6m+BJa31RDordRgGvjWt9hkFakj/e2yrOV1hHkJACjzvhwaea?=
 =?iso-8859-1?Q?p/1u8qX2QbkSHhofLPYJw+BlonQNoxbqFoRAwjySoTBSsbWUBZSHVmRHim?=
 =?iso-8859-1?Q?xn4tag8YhbvosHfts87Cnk0bkiJf2/gQqGy0Kod3oTIl4QdTleAaGhzCk0?=
 =?iso-8859-1?Q?hlVaz5TxFOilCgJER3D9es46v30o0A28F6alhCry5ageC2jfkYMtd4k6IP?=
 =?iso-8859-1?Q?c3eRGXaz0NiYZVGksmscI7V6g0iu5vvGbSI7vjD+UQOO1YcdksLvz+5PLQ?=
 =?iso-8859-1?Q?r/TJk4qdaunOIYSBEtod17h5jx2G5MVWD8Zyh6tarQ62uRYiJfSOlqnL7W?=
 =?iso-8859-1?Q?AEEfkk9ZaddtUNy7XG1ZHt/G4d9lVjdsF8P9VLfcBVgGfLIGpZLKYL6zly?=
 =?iso-8859-1?Q?yyv+ebUcf/HxJh8hOPY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f91334fd-9ae0-4052-8119-08dc173603d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:26:34.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZMHgT6Bg+BkFqTmsCNFCB+QvH8IuBI/fgCjNYe7Wuffg7DAI/sv0HxQrSEFa94bHlDM8p25dz8ReZnLlaN2Zmd96tdpxRds9zH7wV2z92Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com

Hi, thanks for the review!

On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>> Add tests for both L2 and L3 CAT to verify the return values
>> generated by writing non-contiguous CBMs don't contradict the
>> reported non-contiguous support information.
>> 
>> Use a logical XOR to confirm return value of write_schemata() and
>> non-contiguous CBMs support information match.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Redo the patch message. (Ilpo)
>> - Tidy up __cpuid_count calls. (Ilpo)
>> - Remove redundant AND in noncont_mask calculations (Ilpo)
>> - Fix bit_center offset.
>> - Add newline before function return. (Ilpo)
>> - Group non-contiguous tests with CAT tests. (Ilpo)
>> - Use a helper for reading sparse_masks file. (Ilpo)
>> - Make get_cache_level() available in other source files. (Ilpo)
>> 
>>  tools/testing/selftests/resctrl/cat_test.c    | 75 +++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrl.h     |  3 +
>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>  tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>>  4 files changed, 81 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 7dc7206b3b99..ecf553a89aae 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -292,6 +292,65 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>> +				const struct user_params *uparams)
>> +{
>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> +	unsigned int eax, ebx, ecx, edx, ret;
>> +	int level, bit_center, sparse_masks;
>> +	char schemata[64];
>> +
>> +	/* Check to compare sparse_masks content to cpuid output. */
>
>"cpuid" -> "CPUID" (to note it is an instruction)
>

Thanks, will change

>> +	sparse_masks = read_info_res_file(test->resource, "sparse_masks");
>> +	if (sparse_masks < 0)
>> +		return sparse_masks;
>> +
>> +	level = get_cache_level(test->resource);
>> +	if (level < 0)
>> +		return -EINVAL;
>> +	__cpuid_count(0x10, 4 - level, eax, ebx, ecx, edx);
>
>Please do not invent relationships. Please replace the "4 - level" with
>specific index used that depends on particular cache. The cache level
>may not even be needed, just use the resource to determine the correct
>index.

I'll move this back to 'if (!strcmp(test->resource, "L3") ... ' structure then.

>> +
>> +	if (sparse_masks != ((ecx >> 3) & 1))
>> +		return -1;
>
>Can a message be displayed to support the debugging this test failure?

Sure, that is a very good idea. I'll add ksft_perror() here.

>> +
>> +	/* Write checks initialization. */
>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>> +	if (ret < 0)
>> +		return ret;
>
>I assume this test failure relies on the error message from get_bit_mask()
>that is called via get_full_cbm()?

Yes, I thought adding more prints here might look redundant.

>> +	bit_center = count_bits(full_cache_mask) / 2;
>> +	cont_mask = full_cache_mask >> bit_center;
>> +
>> +	/* Contiguous mask write check. */
>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret)
>> +		return ret;
>
>How will user know what failed? I am seeing this single test exercise a few scenarios
>and it is not obvious to me if the issue will be clear if this test,
>noncont_cat_run_test(), fails.

write_schemata() either succeeds with '0' or errors out with a negative value. If
the contiguous mask write fails, write_schemata should print out what was wrong
and I believe that the test will report an error rather than failure.

>> +
>> +	/*
>> +	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
>> +	 * Output is compared with support information to catch any edge case errors.
>> +	 */
>> +	noncont_mask = ~(0xf << (bit_center - 2)) & full_cache_mask;
>> +	snprintf(schemata, sizeof(schemata), "%lx", noncont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret && sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs supported but write failed\n");
>> +	else if (ret && !sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs not supported and write failed as expected\n");
>> +	else if (!ret && !sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs not supported but write succeeded\n");
>
>Can these messages be made more specific with a "write" changed to "write of
>non-contiguous CBM"

Sure, will fix it.

>> +
>> +	return !ret == !sparse_masks;
>
>Please return negative on error. Ilpo just did a big cleanup to address this.

I believe this is resolved now.

>> +}
>> +
>> +static bool noncont_cat_feature_check(const struct resctrl_test *test)
>> +{
>> +	if (!resctrl_resource_exists(test->resource))
>> +		return false;
>> +
>> +	return resctrl_cache_feature_exists(test->resource, "sparse_masks");
>> +}
>> +
>>  struct resctrl_test l3_cat_test = {
>>  	.name = "L3_CAT",
>>  	.group = "CAT",
>> @@ -299,3 +358,19 @@ struct resctrl_test l3_cat_test = {
>>  	.feature_check = test_resource_feature_check,
>>  	.run_test = cat_run_test,
>>  };
>> +
>> +struct resctrl_test l3_noncont_cat_test = {
>> +	.name = "L3_NONCONT_CAT",
>> +	.group = "CAT",
>> +	.resource = "L3",
>> +	.feature_check = noncont_cat_feature_check,
>> +	.run_test = noncont_cat_run_test,
>> +};
>> +
>> +struct resctrl_test l2_noncont_cat_test = {
>> +	.name = "L2_NONCONT_CAT",
>> +	.group = "CAT",
>> +	.resource = "L2",
>> +	.feature_check = noncont_cat_feature_check,
>> +	.run_test = noncont_cat_run_test,
>> +};
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 74041a35d4ba..7b7a48d1fddd 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -165,6 +165,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>> +int get_cache_level(const char *cache_type);
>>  int read_info_res_file(const char *resource, const char *filename);
>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>  int signal_handler_register(void);
>> @@ -201,5 +202,7 @@ extern struct resctrl_test mbm_test;
>>  extern struct resctrl_test mba_test;
>>  extern struct resctrl_test cmt_test;
>>  extern struct resctrl_test l3_cat_test;
>> +extern struct resctrl_test l3_noncont_cat_test;
>> +extern struct resctrl_test l2_noncont_cat_test;
>>  
>>  #endif /* RESCTRL_H */
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 3044179ee6e9..f3dc1b9696e7 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -19,6 +19,8 @@ static struct resctrl_test *resctrl_tests[] = {
>>  	&mba_test,
>>  	&cmt_test,
>>  	&l3_cat_test,
>> +	&l3_noncont_cat_test,
>> +	&l2_noncont_cat_test,
>>  };
>>  
>>  static int detect_vendor(void)
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 8546421f0940..8bd30973fec3 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -100,7 +100,7 @@ int umount_resctrlfs(void)
>>   *
>>   * Return: cache level as integer or -1 if @cache_type is invalid.
>>   */
>> -static int get_cache_level(const char *cache_type)
>> +int get_cache_level(const char *cache_type)
>>  {
>>  	if (!strcmp(cache_type, "L3"))
>>  		return 3;
>
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

