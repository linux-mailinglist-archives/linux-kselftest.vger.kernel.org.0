Return-Path: <linux-kselftest+bounces-18463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5649883E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD31F21B31
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8118B477;
	Fri, 27 Sep 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQfFRf1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1071187547;
	Fri, 27 Sep 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438915; cv=fail; b=ltLqqMao6mI5M05nTDNknDoN8lQyFU4wMCRCuzGIhI3owNBTBIPBN6qUnMIpKT/N8eLrrmGhaq25SDbtLKLryBfT6UpMp3m9ISXJgPr1nfMWD50I9wWtFzs9y14hg/63q4n7K511UgLKg+C9HQvzSQvew0+y3beWm3GYLI7IWmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438915; c=relaxed/simple;
	bh=K1DdQtwY8jP3bASPeLX3LJ/qys3W3JwY6JWfRYwXf28=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ivdT0mPF2GyWLVKOtmgUGoaxGfdjfjlG2fJ1WyPn9co85CSCuBIYCdaD5tYD1Xa57Tsq52jZzgB0nQpS4siW/zkymmMqdodVv46nAudsAEUnoo8Wt/rx7emp+H0bbKMYXptYFaz3CS4wAKxcpVquFCidIxUNb8rN5K/uhhycIMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQfFRf1a; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727438914; x=1758974914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K1DdQtwY8jP3bASPeLX3LJ/qys3W3JwY6JWfRYwXf28=;
  b=GQfFRf1amyfPpqb99OWnnoUcOXCECKRWWGPSRbCfC6I3rqMqAGCE6ymw
   mW9zSeqdXk/d49oOTe9/8Io1AiqKZKUrVPV8nmG4fMcwoWiPq8JUF8WaF
   2vcQ5XEe/DU8OIhB5GIIDDgK/A48tEZbB6s/otlnyL5TkDWcaj41xScMz
   15wsdAWYAeqNIkqmr9j43Wy0xMEeJ4x661qW/8a743WMP7eIIrkoNvn5L
   E+/txbGH/52w88bB1K0kM75rbnGbzDvI8tM+R1vHKaXj+UY/Q5Jfgpp2J
   FigSbjbiYIz0EKdxus3YY/iVoQfnKAzub1cwtJXvKKxJI2QBqtEfZHiEe
   w==;
X-CSE-ConnectionGUID: mI/Jqx/ZQSCIGpnvLnqhJw==
X-CSE-MsgGUID: 8S+Aif2oSkeRfIyjqVFx2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26452042"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="26452042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 05:08:13 -0700
X-CSE-ConnectionGUID: xtPs/ZY9TaiODxxNGdG1gw==
X-CSE-MsgGUID: 3VgM3CU0TASAOLn9hXbCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="77299535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 05:08:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 05:08:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 05:08:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 05:08:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 05:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWeov/yv/YAnQnwWMXqsiJuyFtZarpDL5/8cJRmdyIlUEMajXuMFA7GUErL+CCNzf6AVzzvY0gFblU/7pJDvEb8bVBvs1p9Xl00A0nEFE+9PNVbonMX+G9klBFn4cWZhNrkVG6ZwpAwY0dJNPa9WExCtHZbanMeA15HaJWT2XC0JJrFc9mriqWi/cfytIcgbeTCK9ozpjcKheWam/UbZYCWh8pfh2cxN0kngGDxLGgq3qrD6LhrNVGqRw14VVBQn00prrpmnFa6w1ug8Xn9Vc1hVE6suAEew3dEUISJh+o9x4ZVQIN1iNItEeMA/5O792srInremigDxDhfD4SjQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2tP1DYQRNW2TbyFgDwDIWXZ04tZJht0+SIb9DrBTx4=;
 b=Oprls3tZ/cZPpKTY+7bNIzz6AQIFJgikz1yQdJcHik4t2Q6HsnxLrjhyFpyT8KCSb0Anvh6cnrdZtnNdYmd3NT9Ou/1SVWR9eB7tRGonZCb4/zW+4t/8PlcZQ4CKyjxyKjOQYWOuWcgmLwDiEN6sSTrhWR69I7q0e/E1M5FgJFcbTGjuX9l9TF76XHmXxnsm225qEFdWA/WXgHBn5M6Gd5yIEqoaB/d3vftpv3xNQTR0GeVb9kGCQ5mGKV42uxG1ObgyfEE+NwBiEv96D7cz14tGqE/R9Wm1znWbhKNNMgaDQVEETuDQUSfTFBCYSdGlaDlInlEK0Qk/fHPndEJAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 12:08:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:08:09 +0000
Message-ID: <899c781b-c2bc-4012-b0a1-794fc64eb478@intel.com>
Date: Fri, 27 Sep 2024 20:12:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, Jason Wang <jasowang@redhat.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
 <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: cd56a248-618c-4199-2fd0-08dcdeed0d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0pWMnNaUjB4cVo2THhTcFJIb0ZTYXlhcmlscGlBR2UrL0c4eVhwcTA4NUk4?=
 =?utf-8?B?UUZSRStiVldpWUhnV29ZRnZFMTQyZVBDOG5vT2VwbUwrd1llUytXeDB3QWFj?=
 =?utf-8?B?amlUTEl0MHZOTXNPNEVSRlFvbytwbEpVRVlzeWczMk1ZV3VBYzVLbnNkUktu?=
 =?utf-8?B?RzJFZFlRK2FQVDAzNXdmbFZtUTJlRVNEU1VTdkhKazRXdHZLUVI4YmdYemZQ?=
 =?utf-8?B?QVZBdzd6dFhsMmY3dnNVVENJZTAxekxnakQwRHpIS0I1WFlVdlNDbFFZcDd3?=
 =?utf-8?B?ZExROUZadkttWVEzQTQvSjBBQXdQZlI0M1FJUkJ5SUJUN0E3TXZ4bTgydnpU?=
 =?utf-8?B?T3d5WXVoUjZYSk9YTWxaVUdzODY5bkh1by9NZDdxbUs4ZVo1bUlLVkY3cVhT?=
 =?utf-8?B?UFpXT3lDbmwvd3VuRjhNVUFSNmJML1ZhQXp2RGdlUURPd05qNlpTYlM3SXdw?=
 =?utf-8?B?MEVRMkkxa3NUT3hja1Q4SEZIcFEzUnhhS083aWFrNHk5dzJSdWpmbTdtejhz?=
 =?utf-8?B?dlp1RTNmajg5MkpxMVpVY0NHUS8xR0htR1FFRXkrUVM1MnVCdFpHUHU5TGQ2?=
 =?utf-8?B?ZjFiL0lLbHpPcjF5amFjSm52T2w1V0FDQXR2b1NOVzY0cmZXdUVRd3ArdmFH?=
 =?utf-8?B?a3l2RkkvQVZFNmRjelhieVI5S3VHcFhwTklJU0JvV0t3K3U4NUlFWTZQaCtl?=
 =?utf-8?B?d3h3U1RjRm92ZytCSzBkaEh6U0lLM3AxZXFtdXEwWWdMdEhLM1Nna09RQU5R?=
 =?utf-8?B?N3ZPVThCV0ZKWFNzOEl5Z1FFaGVURFp2SVlNdDB3Tlh0aXV2MTZFOXd2dmdq?=
 =?utf-8?B?cm1lYWNkMW9Wb2ppWkI4U0d5SEdsbmcrMzlqelFqSUZncHlDRXF0R2hNK3Jh?=
 =?utf-8?B?QzhiblhPTEVxK0pkZkNHbTVSVzRsMWRBcWxHZFpuakVHN3RHSkkyTVZsZEh1?=
 =?utf-8?B?dFo4QTZTTzVrdUtHNHFPMmlvZEN4bmhJeGZkNHVGNHFHajRFMlZnOXZFV21Y?=
 =?utf-8?B?TnIraHI4QUtBYUZZc2ZUelZDK2VqTkVuaTFKTEtlbmpVdTk0MkxFNnZNY2VY?=
 =?utf-8?B?c2hZQUVRelZXaEtvR0NnOTVLTGhnUlFBOThCVnFlMnZzMjI2WlVXdXBFQTlF?=
 =?utf-8?B?YldQcmIxWWROYWRLQ09oTmZ4MGFMbEhMOWZPRWdQY3lPTWJSemFDb3puL1NN?=
 =?utf-8?B?ZlFlay9WTjFabUc0S0NQLy9QNndTREI2MUpaYmFOeFI1OXNPeVVNYjBqZ3lB?=
 =?utf-8?B?ZnA1cFhRWXlVYlhVWVFRUDlyakl4eUF6NGFRMENWOWpzaDlBdmcydmp2cFhC?=
 =?utf-8?B?Tk5Jang5d1IvMGhqcmNjUTJ0K2MyVEdtRDhRNEZsZ09uWmJRTlZQbmI4c1d3?=
 =?utf-8?B?ajBvbzNyR09QVjExZ3Foa1lBSkJ3Y3dNREhManlCL2h1ZmEyZHI4cWkxa24y?=
 =?utf-8?B?dGswRHJybzBiUDMrSk9yVW93d1Nzamg5TDZBTjYyVHdEdkowSTN4aHB1MTZ3?=
 =?utf-8?B?SVhiQWxIS2xiMzRkT3l3NklCWWlZQmRhMjExeGM5dHhiVGpVblhKZHRYR055?=
 =?utf-8?B?QzgrZG81bVc3RDBjeUNlMmRLaUU0RzZOSm5OeGk2MUFiaTBrZkVQVFJrQk9i?=
 =?utf-8?B?U3hySGhqcGpPNSsxcVJFNHNYbFNoR1RIRWZaWDJGYzBjalZNY3RueHNPaTFN?=
 =?utf-8?B?U3pUL21VOHdXZUZrVXR4Q2F6RFNGYndGOEd6MjhkSFdmK3p5d3JNQjdVells?=
 =?utf-8?B?VTkwTWZYbkxnczJvSkJTN3lBMGFjVGFrTzlrVXl1WnlDOFU5WEJzZUIxbmwy?=
 =?utf-8?B?VWJQV2VqWGdTYjNBL0dtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnFRQW0rYjVtUDA3elRLaS9tdGtGa1hrNXBNMGQvaEVFVk9JeFdVQmdKaHRl?=
 =?utf-8?B?eFBYRElobmFRNXV3SklUc1l2MGhJUE1KUUtPTlZhejkraC9OZE1XYnVmSUVu?=
 =?utf-8?B?amFwaXREVGJMS3I2MGgvTGtQQ0tGSFQ1aEx4d0NLTWN2UTB5d2RiWE1mRkRh?=
 =?utf-8?B?MEx5Mk12S0hxSFZEMU5KQ3JrYVhrcnVwaWlrMUNaUllBSklXNFhrMjh0Z3RI?=
 =?utf-8?B?TjUzUGE5d1h6dzJCb1ZuUzVFeDJZblp5ZnA5RVFpZVp6ZHd5ZlRjU25ZS21i?=
 =?utf-8?B?OGU1alBVN0xuQyt1Vkh2OWpmVzVqTU0wWEwvaGlKMm1QRVBtZ3RlZExtUk1P?=
 =?utf-8?B?a3BqRHUvakN6VnRtd0NoRWt1b210eDFyaC9ZZ2taY2NPM1dsK0FHei8zd05r?=
 =?utf-8?B?cXhGWmV0NHF5YTVWT1M2VExWSi9DRTYzeStLRk1YQzBHRlBiYzlJNk9Uc2M5?=
 =?utf-8?B?SzQ5SFlIeUVzQ2p6VXVSN25aZWpGbGpZZk9GdWl6Y05pbHFDRk5IYmVGb2ll?=
 =?utf-8?B?Z284T29ob3k3ZXd3SkFYQURYZy93d1NiU1d6c0xxSzBPVmNycnNYTEZHay9E?=
 =?utf-8?B?K0xDTUcveDF6YThCMFZHTXM2Mm5HMWx1UkRwWWRQM0hUQXpleHZSZTJpRnZz?=
 =?utf-8?B?Y3hPVERneUZNbUEyM3NreWozdDN3Znp0VU1BaWQzT0s2S3RYYzdEUG1BNUs3?=
 =?utf-8?B?UGtYMzJ4czUwNThuVEpPYmxicnhyRm5PcndueGxKd1R0YTQ2R21uWUhNWmN4?=
 =?utf-8?B?UXZFM1hyMjlaNUdTZm5OdENsdWsxTzdPSnpKMXJ5azZhV1BzeFFYWjAyUUxN?=
 =?utf-8?B?VGc3K0Z0aDJwclhGWUtRRDI1a1M0WmRIcFF5bDZtZ29MNGx5bDBYZStMVUx6?=
 =?utf-8?B?N1I5NjJVTHV3N0RVU3hyTG5xOGZkS0JobWZtbDU5a1lyNjB5SXo0UVVMU0NU?=
 =?utf-8?B?ankxMWtiQlpGZlU4aHVyQXFhRVhTOVJXaDBiMUFpbzNvRnhWVkM2UnpKT0hj?=
 =?utf-8?B?eGZ1aUY5ZTJwZDNaWmJnakhOdzJPaDY4N3pGalMyUjYxVGVPQjBVYURoSjNT?=
 =?utf-8?B?MkJMUGxGMGVLWHhHQnRkY29XWkZNVTFWMXZXY3YyanU4MTd6Qmp6ZllISlpV?=
 =?utf-8?B?djJCNzA3T29jRDgxR05kYWgvbWtuMVIrcW1lQmRJdGhRUUlydmorNExZK0Zo?=
 =?utf-8?B?MmN1UnR1OGpkMjhKTks2bTJBN0kvRllKUWpHTy9XZVEraCtoU2FaMG1UaTEv?=
 =?utf-8?B?QTNGOUFzaGlSOEc0djFxQTlvdndDMWpJc0ZwTlJSWm5GUUwyWlJuMmJqdG9E?=
 =?utf-8?B?Q2NNZStBRzF3b2RraUlabklad0Y4cUZaYW9uQ1ZJL0hOZWtHRFp4YVNzMk92?=
 =?utf-8?B?T0FVazQ5TGVqdHpsNXBLbW5VTndWSFEzKys2R1pydHo5M1JBQzRqK091T01a?=
 =?utf-8?B?b1dlK3hZTit6MkluTjY0UzEzWDNqcVFzVTJhU3dDTTAzQ2FPaVFLOVhod1Bj?=
 =?utf-8?B?NytwRXh4YXlqNExFK09DbXh0YkpUdlhGbkRKejB3b1ZQOUNNdk9qcTA2YkMy?=
 =?utf-8?B?K2RHNnkzSURpbkRNRlJ6K004aEZSZTNvQ0FIMkx6VWdFelovbXU2VzBNbzNs?=
 =?utf-8?B?RjdNOGJEOFNFaG1LU2xEaFUyRTY2VEcvZWp1OEUxSlUrWXk2bXNUTzZVekVC?=
 =?utf-8?B?NTNtNU9WQ2RNNXRLZXoyN2J4alZNUTE5Z2ZhRnJoQm9TSTU4ZWFlbGlmMXlX?=
 =?utf-8?B?K3I1eG56TmxJdHdHZXY2MzVRNmU1K3I3QVY1dGE5dnpzbWtzZ1FEY0Uyc3p2?=
 =?utf-8?B?K1JNUmREbUx6SjRmSWJDRUVmZnlpR0lISE4rRjBNVkJTd050b3VmS0FtM2Jh?=
 =?utf-8?B?MGdSdUxTeHhlb2hKWnRId2NLd1JVcm01TmlXdzRJYU1hS2thUThMd29XSUZS?=
 =?utf-8?B?eHRPZjBSMzVwMm5NSkFyMWJvSVZBV2svVFhHbHdVTUwvWXl1eWhEU0twS3p6?=
 =?utf-8?B?TnovVnRqUkNuTGNVVDdDS1oxNGQ2MUdiU2VnRnI1STlXZmQrRFdnOXhYME9x?=
 =?utf-8?B?azFBb24yS2hOdFR5UGkwYWVOa2wzdjVpb1BoYlJSWEExMkRzMThGV1JCVktZ?=
 =?utf-8?Q?3zB/cPCwAhEPvTdIRmFkdvNML?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56a248-618c-4199-2fd0-08dcdeed0d54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:08:09.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D64tjV6bkkfZgw1HBtkJHj/6C5tiqSFbGqmCZ/d+AQaW8SQl+G+s1WFUs/9tSm6yC4ZmQRQRQaiQiWASnM/0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

On 2024/9/27 14:02, Nicolin Chen wrote:
> On Fri, Sep 27, 2024 at 01:38:08PM +0800, Yi Liu wrote:
>>>> Does it mean each vIOMMU of VM can only have
>>>> one s2 HWPT?
>>>
>>> Giving some examples here:
>>>    - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
>>>      kernel holding one S2 HWPT.
>>>    - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
>>>      kernel that can hold two different S2 HWPTs, or share one S2
>>>      HWPT (saving memory).
>>
>> So if you have two devices assigned to a VM, then you may have two
>> vIOMMUs or one vIOMMU exposed to guest. This depends on whether the two
>> devices are behind the same physical IOMMU. If it's two vIOMMUs, the two
>> can share the s2 hwpt if their physical IOMMU is compatible. is it?
> 
> Yes.
> 
>> To achieve the above, you need to know if the physical IOMMUs of the
>> assigned devices, hence be able to tell if physical IOMMUs are the
>> same and if they are compatible. How would userspace know such infos?
> 
> My draft implementation with QEMU does something like this:
>   - List all viommu-matched iommu nodes under /sys/class/iommu: LINKs
>   - Get PCI device's /sys/bus/pci/devices/0000:00:00.0/iommu: LINK0
>   - Compare the LINK0 against the LINKs
> 
> We so far don't have an ID for physical IOMMU instance, which can
> be an alternative to return via the hw_info call, otherwise.

intel platform has a kind of ID for the physical IOMMUs.

ls /sys/class/iommu/
dmar0  dmar1  dmar10  dmar11  dmar12  dmar13  dmar14  dmar15  dmar16 
dmar17  dmar18  dmar19  dmar2  dmar3  dmar4  dmar5  dmar6  dmar7  dmar8 
dmar9  iommufd_selftest_iommu.0

> QEMU then does the routing to assign PCI buses and IORT (or DT).
> This part is suggested now to move to libvirt though. So, I think
> at the end of the day, libvirt would run the sys check and assign
> a device to the corresponding pci bus backed by the correct IOMMU.

and also give the correct viommu for the device.

> 
> This gives an example showing two devices behind iommu0 and third
> device behind iommu1 are assigned to a VM:
>    -device pxb-pcie.id=pcie.viommu0,bus=pcie.0.... \   # bus for viommu0
>    -device pxb-pcie.id=pcie.viommu1,bus=pcie.0.... \   # bus for viommu1
>    -device pcie-root-port,id=pcie.viommu0p0,bus=pcie.viommu0... \
>    -device pcie-root-port,id=pcie.viommu0p1,bus=pcie.viommu0... \
>    -device pcie-root-port,id=pcie.viommu1p0,bus=pcie.viommu1... \
>    -device vfio-pci,bus=pcie.viommu0p0... \  # connect to bus for viommu0
>    -device vfio-pci,bus=pcie.viommu0p1... \  # connect to bus for viommu0
>    -device vfio-pci,bus=pcie.viommu1p0...    # connect to bus for viommu1

is the viommu# an "-object" or just hints to describe the relationship
between device and viommu and build the IORT?

I'm considering how it would look like if the QEMU Intel vIOMMU is going
to use the viommu obj. Currently, we only support one virtual VT-d due to
some considerations like hot-plug. Per your conversation with Kevin, it
seems to be supported. So there is no strict connection between vIOMMU
and vIOMMU obj. But the vIOMMU obj can only be connected with one pIOMMU.
right?

https://lore.kernel.org/linux-iommu/ZvYJl1AQWXWX0BQL@Asurada-Nvidia/

> For compatibility to share a stage-2 HWPT, basically we would do
> a device attach to one of the stage-2 HWPT from the list that VMM
> should keep. This attach has all the compatibility test, down to
> the IOMMU driver. If it fails, just allocate a new stage-2 HWPT.

yeah. I think this was covered by Zhenzhong's QEMU series.

-- 
Regards,
Yi Liu

