Return-Path: <linux-kselftest+bounces-6394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C085F87F04A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4011B211AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1F56748;
	Mon, 18 Mar 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWh53zCt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E595645C;
	Mon, 18 Mar 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789370; cv=fail; b=dVQRVL4Yfk4hgJlpeRm4Apn+L6PlCabdvzFhcDI9+7d58Vb3MurvobZOe9YP8+Aq5Ahnu6IOYCOVJe/+MvaJ1zIYucrpsICeuQ4SGNxjDBrg40Zu04/cKMWZqbd42Q1hirF6vrSzTpgY0TC7prEwNM68sDgPGEMGts2Jqtbg7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789370; c=relaxed/simple;
	bh=eVvd9lHfb/f9dy3kiDMygMz3jMLMr/Xx2QOTwK7r9r8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jRdyaOiuh0RhnBWigRQ3erFeQp2UxQm5Hq8xrQdLT2hGaGfcJ7GfpSUEk6D3Rvr7lj+aITFw6McBbz5hyyusVPf4R91S4qy+Ws9m3vAMKuKAjBXP50B2+ypu+VCMRu9bT9qlChDmJU1G/ZC1Ssy2Ve4BNGXuc4psVEGeCakW1Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWh53zCt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710789369; x=1742325369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVvd9lHfb/f9dy3kiDMygMz3jMLMr/Xx2QOTwK7r9r8=;
  b=WWh53zCtY8/N+ztVaFxnQKXwWyLUCHd+dBtzQdTWAliIfRIUVO7shtaM
   Z0nhwHxtDeK66IU+z27dsaHKKhWIARftBxaCTCGx6/fYrCWr9XtJ2Q6H+
   U8eazVu+uneQ/4TCmBxSylvogXUlTK16hPN30NFdXV29oQ04D3tDMTYrw
   WYA3dcMMV74plHPKtOW1P3uC41Hso/QEXIuS4HR30KAaoUqN3c5zltenP
   KxOtW+4+VO9XNf9uJ1cGShA0sykHLkysDp3s7HWsZJNBR4vn1GoJ0Ne6v
   jC/RHUN+PJinTO0L176N6M/8MfN5oJEW8FX+OM7p14RNyCUirQptia/5/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="28104544"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="28104544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 12:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="14038349"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 12:16:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 12:16:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 12:16:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 12:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJEaNxnmVv0uP1cyfcRdYCFEDmZYgmBAtslKMnO4VhEzWPJPah0i4qS+9MFXDUZsA0bQ5Ouz1BTag+CeyVUy8qYK0tCv/7Jde9g5XJUHnqdhixBLFZdcdH2m+w0MsBwt8DDtdnuGvLHYj0lh0u97v+L2qh+Fl0QpeHPctJea/GFAedO83cMSBjDcTkMPaWQpk2+R81jPb01aOtbkdc/HS3q4MCFr4A29qBgcWTX5YWLh4WBGxACpLEYvsiYT83Gn9kejYe1nrN+1702WaFfpT4ePO5AvlrseW+L736GcogtAbveJe3nAXPzIIb1hiOTCQeXgMMa9qNtandeaC/NA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDT+9QObBWyOwEW7buDvLVmHatW4g/XqTTcQpR6GR+E=;
 b=SySeyEncA+thwzSccPox+8NousftYhHdQbUpUzo13n9oheoV1TYXiC8QNwDOPWXPGwlsNWIYmnhuY4xSjtb5PHDPdKWZl7LVFDoQppIkvXJmpm7CGEQ1BsqVx3D7p3paHf+4omIBnAQBGr59zhVP5yaXlJ9onfiKdfomzP5izws1eId/fc+sA2PeK1iQ60RN4hIaZqplwxdfFigpayXLRQbiuHci41g3FK/2yhlxsQD1apMrrE24Mxac8Azf98mLS17OjqffUEkgCMe9pavZ0q3dqPFN/yJQdduHCdA2WNvQgxMg51cuFwhd6ALj1fNTzmBVQ4jceL9IZ/Nl/4xf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Mon, 18 Mar
 2024 19:15:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 19:15:59 +0000
Message-ID: <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
Date: Mon, 18 Mar 2024 12:15:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cc809b-96dc-4902-19a7-08dc477fd83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8g3/9/L1H/K38Jqt+3TDWTXR85b2Mu+EdoY/X+B76HgqpsfHqx76VJzfJk0lWVesVeULFKe8yLxxEyGS2m6Yciiedqq1eLtJjrk+Imfz2+5RAYhrYOPoTb91CBEuWA5n/C3LNgDV8gSYaLRafhQ+ebhyU0HJCWlQeIOpEVqOAtUw3HQJ7Jsg/+ap19bajKMhfaOoB3BfrfFrQqOroUVfdz3sR9vEiSkbw6ATlJ8bve/W2n3IXgtJCjpaVTlIdP23vOwk2qwd8o+1IzsdGL1QVePRJHJeeoOwAF528buTWl9DKU9aI/Tfb3mQ8oeMSLT6b+DinEFZWiAlfqYLLHn47nMR+es1JwFy8UhZ1p4Na2PLiBBIUOksL/jASf7KjhvUeZiSTyZ3Fs86BhedDXnYibWCtA8kpU/uTuXOWCrdHzrNpF+3c7wbtXIVdjwd6b/ys8COMNQHsKe2OTlIa06ZGSV5UqSpdHRMggs7wpy8G8nO8CeGcCKrCxgrTeQqQGFhePFHxpJ5pkQ74aYvAjkctcxNJDrBjxjbKlI76RcpvchS3cbFXS32/aM2wYQ9bWwTDUe2zQ2w/JTqofHrxReVh117xHT0mnEvy3jPt05eQyKFpd9mLjk47wINuVPWnzKdFXIpvlzVdlPe6IcDjdds6+nILrHI4WB8Afr/E/ysYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9tZWZOanpZeXBLUkVDa1FXMVkyZHFvR1VYZ3dhcUJpUU96dTcwUUV0RXgr?=
 =?utf-8?B?R1JjejlRSVRxTzdjWG1zMlROZjlpT0U5RmZMZnFQWHptSjkvbW04cm13Ung2?=
 =?utf-8?B?TXBMRHMwZEpyZEp5OGJoQ3RsUnBLTGFwUVNwTmw3bGRmR055QUpDTWJkQWov?=
 =?utf-8?B?d1JORXJxTW96SjFnZ29nOUFmWFo3Y1JMQzYrNEtvb2k2eHkzN0hKTlAreWF5?=
 =?utf-8?B?Qlk0Zk8ydEZnYXpybXB0QWJnS3NpSUF5VXBBbGIzZTRDc3J6ZkhDOEJvSFZC?=
 =?utf-8?B?UlllZTB1U01DbXJLWVFvVWFFS1RrSG9rNngxa09uRFI0NDRuUTRpc3hpS210?=
 =?utf-8?B?UnJra29VdlJrSVVIbXMvUEttMjRPMzdsaUlJeTZWVFU3dzFqcWpLbkkrZXFp?=
 =?utf-8?B?REl5bDljcCtBSjVGWk1sRVZ4Wlc3bStsL3VXejN4bHBGUE1WOXZGTVVINFBr?=
 =?utf-8?B?N01ZRHRxUzFxaEc4Sk4wQjNza2VKKzN5S1RxMjVKYjRHcVovejR5TXJ5eHRQ?=
 =?utf-8?B?S3o2OSs2Y3lRWTNrT0NmZUdUQi8vK3BVVmJOQ2tCOWJCWUM2alFPM0pnei83?=
 =?utf-8?B?K0lBUytHbVRKbVV5OHh4S2t5MkgzeHVRM1B2cnl4eUNidDU2RWErNDVtK0RG?=
 =?utf-8?B?V0JTVGhva1pxMVF4T3dJZG1rMXJRSUN0QWZvZ0tlNXZQcUxEMVk4MG9oa3lO?=
 =?utf-8?B?bVF5VnF0NU9GKzVReVFBcE8vQUtuVUl2Z1FKY1gybmx5aFZ3anpZL05nR0Y5?=
 =?utf-8?B?anNRc254T3k4dWd0SFlnbnNZdUJGMjlxYmZJaGVnMW96ZWNKck9qY0FFdCti?=
 =?utf-8?B?K0tXSVBXUmdqVnZqSXJTRkUwQzBFSFpDU0lrOFNWZ2xEY3BNTE1hNlVDTVpo?=
 =?utf-8?B?MmlvclU5SG8wTUhuUXJIOWEybzExK3RwNkJ4amFlcFZkWHJydWRMVU12bDN5?=
 =?utf-8?B?aVdMOUZ2MEd0bS85ZHg3ZkFZSzJGNzB6b0p2ZGhpNmVqc2dNYjNjWFJiWlpJ?=
 =?utf-8?B?Vm1sYnVXYWZablZtMGJrY1Q5UXdUL1dWTDBDM0dWanlYUjRiY3ZUTG9WNHh4?=
 =?utf-8?B?emxYb2o0Rm5OelFrRmozdm5tbVNOckZxTk5Bb2tLMjlvNmJkTkJFMkJ1REFr?=
 =?utf-8?B?ampxMThzSm90Qmsvcm5CdUtpM0RySDhnZ3JERDVOaEZaMkRWOWdwTGl5dlRs?=
 =?utf-8?B?SWFFOEFnU0l3NHhrNlN4NldmbXlqamVGQWVKY0RRVG83Qit4djNxbUhGam1F?=
 =?utf-8?B?M1I0YXU0UG9OZVFxemY1N3R4eWllLzdGWFptcDJSNGVCTEZwazRrUERpZmZD?=
 =?utf-8?B?QmJ5amRwWmJzZ0hQeDVGNUMzSURUSks5NDRVdUs4dTAvR3dyS1Q1U0RJTTNJ?=
 =?utf-8?B?ckVvSTN6bHBaa0xzR2FMTUpCZnpVMEZQY28vb0tONTJ4Wi9EQjk4UXI0VkF6?=
 =?utf-8?B?cWNyWWNmNUJDWlZ3Wno2UHU1WjNrbEZPOUhQeCtEU2lBa3NPYzM4VnZRV2tU?=
 =?utf-8?B?QW0wYVJMZW9EcHJuS3hGNVlFeTV1c01lTGl6cERvaVFUZ2lrVSs3TXdiK1Qy?=
 =?utf-8?B?K0hrZ1JDWk1zd0ZweUxlR3hvMWJJS1ptU0JOYWhXTGtJZE1oUllwMkVQTzBs?=
 =?utf-8?B?anFQalVZZlJZNHpMZ3dGUzAvRTc1ekhsbE9VdVpSYjlVSXg2bkkxdWF3a3lW?=
 =?utf-8?B?NjhOT3ZDUkhMNkhYTXFlOGhiRk5JaVJ3eWVoZzN3TDB4dWxHNDArc0lJZDRy?=
 =?utf-8?B?Q0RGUloyQjlreG12SDFUb2tvazkzNk5oanpjU1lKOEQ4Wk9HRTZ4QkZ0cDcy?=
 =?utf-8?B?K0RvcVc5dFk2TmUrZmFnMnJOeFBjbktPZU1CY0VZTDI5MktGMGlGekRkbUNo?=
 =?utf-8?B?MCtNd3J1YzdFUVdKblZzOElLemhEN0N1MllMazA3dzMvd0xuMnJyRlpJQWxT?=
 =?utf-8?B?QmhNNUlCbjhsRVVuSVVHcWlVdCt0Nng0V3g1eFlWYnBibjRpbnhiclBJRW03?=
 =?utf-8?B?c1l1MERhM0VrMTZ3ZjFMRjluUVBvQ2EvMTNVVm8wREpnZG9jNEdVQ2lldDNW?=
 =?utf-8?B?VnVKRG5TTmhPMmxmcWR6aHJQdThPdGMrWG9DcU1jSURmNTRRWmhabEpGRlBw?=
 =?utf-8?B?WGo2dWZ5a2xSNVJ3Q3BrWThkOGl3UVp5NzJIS1prUWhjci9saGdPNXZIQ3RK?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cc809b-96dc-4902-19a7-08dc477fd83b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:15:59.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYv7ZGN1oq2siQoteVZkDP6/7EV1uAKf958XL5id7xY2Y7FKpSVHnazRc4QQ86/k0wz4gAkXMC4AnHy193iAYDrpXCEfKmoxNVUDPYJ75+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com



On 3/15/2024 11:02 AM, James Morse wrote:
> On 08/03/2024 18:42, Tony Luck wrote:
>> On Fri, Mar 08, 2024 at 06:06:45PM +0000, James Morse wrote:
>>> Hi guys,
>>>
>>> On 07/03/2024 23:16, Tony Luck wrote:
>>>> On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
>>>>> Thank you for the example. I find that significantly easier to
>>>>> understand than a single number in a generic "nodes_per_l3_cache".
>>>>> Especially with potential confusion surrounding inconsistent "nodes"
>>>>> between allocation and monitoring. 
>>>>>
>>>>> How about domain_cpu_list and domain_cpu_map ?
>>>
>>>> Like this (my test system doesn't have SNC, so all domains are the same):
>>>>
>>>> $ cd /sys/fs/resctrl/info/
>>>> $ grep . */domain*
>>>> L3/domain_cpu_list:0: 0-35,72-107
>>>> L3/domain_cpu_list:1: 36-71,108-143
>>>> L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>>> L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>>> L3_MON/domain_cpu_list:0: 0-35,72-107
>>>> L3_MON/domain_cpu_list:1: 36-71,108-143
>>>> L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>>> L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>>> MB/domain_cpu_list:0: 0-35,72-107
>>>> MB/domain_cpu_list:1: 36-71,108-143
>>>> MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>>> MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>>
>>> This duplicates the information in /sys/devices/system/cpu/cpuX/cache/indexY ... is this
>>> really because that information is, er, wrong on SNC systems. Is it possible to fix that?
>>
>> On an SNC system the resctrl domain for L3_MON becomes the SNC node
>> instead of the L3 cache instance. With 2, 3, or 4 SNC nodes per L3.
>>
>> Even without the SNC issue this duplication may be a useful
>> convienience. On Intel to get from a resctrl domain is a multi-step
>> process to first find which of the indexY directories has level=3
>> and then look for the "id" that matches the domain.
>>
>>> >From Tony's earlier description of how SNC changes things, the MB controls remain
>>> per-socket. To me it feels less invasive to fix the definition of L3 on these platforms to
>>> describe how it behaves (assuming that is possible), and define a new 'MB' that is NUMA
>>> scoped.
>>> This direction of redefining L3 means /sys/fs/resctrl and /sys/devices have different
>>> views of 'the' cache hierarchy.
>>
>> I almost went partly in that direction when I started this epic voyage.
>> The "almost" part was to change the names of the monitoring directories
>> under mon_data from (legacy non-SNC system):
>>
>> $ ls -l mon_data
>> total 0
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_00
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_01
>>
>> to (2 socket, SNC=2 system):
>>
>> $ ls -l mon_data
>> total 0
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_00
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_01
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_02
>> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_03
> 
> This would be useful for MPAM. I've seen a couple of MPAM systems that have per-NUMA MPAM
> controls on the 'L3', but describe it as a single global L3. The MPAM driver currently
> hides this by summing the NUMA node counters and reporting it as the global L3's value.
> 
> 
>> While that is in some ways a more accurate view, it breaks a lot of
>> legacy monitoring applications that expect the "L3" names.
> 
> True - but the behaviour is different from a non SNC system, if this software can read the
> file - but goes wrong because the contents of the file represent something different, its
> still broken.

This is a good point. There is also /sys/fs/resctrl/info/L3_MON to consider and trying to think
what to do about that makes me go in circles about when user space may expect resctrl to indicate
the resource and when user space may expect resctrl to indicate the scope. For example, 
/sys/fs/resctrl/mon_data/mon_L3_00 contains files with data that monitor the
"L3" _resource_, no? If we change that to /sys/fs/resctrl/mon_data/mon_NODE_00 then it
switches the meaning of the middle term to be "scope" while it still contains the monitoring
data of the "L3" resource. So does that mean user space would need to rely on
/sys/fs/resctrl/info/L3_MON to obtain the information about which monitoring files 
(/sys/fs/resctrl/info/L3_MON/mon_features) are related to the particular resource and then
match those filenames with the filenames in /sys/fs/resctrl/mon_data/mon_NODE_00 to know
which resource it applies to and learn from the directory name what scope measurement is at?

Reinette



