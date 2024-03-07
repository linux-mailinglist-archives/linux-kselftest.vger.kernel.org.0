Return-Path: <linux-kselftest+bounces-6057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E83875562
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BA1F24044
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A706130E39;
	Thu,  7 Mar 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko7FSwtY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAC12F5B1;
	Thu,  7 Mar 2024 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833302; cv=fail; b=P8Hwe1KnyGWN3pzmBHyCfAAJ1ejOznqeVdmVNHNKbcIcrSOu13ImUeM3F5fZMx4m4NyjJOdxr3aAnzzwMk2Gy3UNKTUMKVmQWt03ncGj7BNdRMdGozGStdCNRjXMJnjKRhzQnYimD5/5Ooe+SFGvurnGLb7p7GGfJV7pKIWZoMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833302; c=relaxed/simple;
	bh=HyioVml/NWEGn3ocO30VeUFqvYELgTiwV0psqiHeH2c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQp1rncfzcd/TGIWTBonhJyn/xeGzSouhkPx+U0H6zV3RsK4EkWDxLM6YSS6OfHE79NAy7btg1TOQPXfIZPvCgvx7OMCi1CkH9mqtcSWVGip54AS1pgkS26EJR9LpiavV3WPnZx4fpyi6DgSmq8i7VrNXEDFvSiE2BX+c1jke2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko7FSwtY; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709833301; x=1741369301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HyioVml/NWEGn3ocO30VeUFqvYELgTiwV0psqiHeH2c=;
  b=ko7FSwtYf32yK2geMm2sWzby2d0tRmQsi/65Nzveeo7sz4dPGwpQy2MV
   wmQfBCZhN2UenZ4MawioyZMyEZqFSYAu0zmiIk54NiV7pHhrpwRjB6Pg+
   SbB2ZBN7dI+YZXChq6YCn6NSkHLK4dA71lBPtDnehyNRw/j+hVhM2dd6/
   lGl81m5FwUJKGHhc3Q/Q7jujHJWdgwjlbznBU+W8dKT7rnCj51szYc+dI
   bDfaNrQtm3TG9eQjRxMlIP7zSNYJzahb7i/xTsCJ/aOoui6AMOu1/1y8o
   lFqjYXHBefX5V2j34qFBBurGGW1mAmy2FaLbPrstZS32DblbaS8XkfDLe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="21970006"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="21970006"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10111182"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 09:41:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:41:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:41:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:41:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyZpgXSUrXVzqkUFR+tIxC6QNzCkl0bYv6DFycH6v1yk4mHfWgYnt4A2NNZoOIjYg99zQOjI62uqdLuPNyL0yIL8KBXLbH++FSLua0Kc6/IeaaBXFmC01Uoz/anxNShDRVnXw5jGx6omQ5jMcPUn+UTzMad3KoGIKc6XynzRr+JmwFYPZrzuguzMAZpCPcd0TR3Kg9zse1fZiFlBcg8fA124ZjO2fYLDXS6UwsZib9plSjUy68laSzZyOhn+it7zek1W+8rHDUy96EyrGv9BJLCoY01JSqxoJKPi8Xv4PIFSAAWrD458+PhZST+K/tdAqyPQjHYXrZlifAiKA90FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkJfysAIddzdlyfXLhnMe14HlGAQT+I14E9eLhy22kw=;
 b=Q0kdgxVLTIhyABtOCYqZdS3UoGpK2ggYY6y0AUBQ41SIpgscokboiIYMlv8bnX3O5x9GldKheQ0vH1EtEPZo8d5n7bkcu+iBLAp8kCzLX25h7Yf+cNbvrvvactFq7xJ3WLWh/xuSbLHlXbEjoNVxGJfVA+jWS2MNZVSGW971SfCiBdQtHyeURs53M65emzTWPxpnVE+xXyCYQHDeEVNNmUGC8jVKNRdxgyol0i1zO7xLDnBvh+pY1p80nXMtn8HDnHT4ntUSn4GOX3pyYLzOro/ogCtxIe+UcEVfePZRyVbvpr9G+VmsBB5JYh0ObPJ9BdOtsW5tn9EL5zSHbzo+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:41:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 17:41:36 +0000
Message-ID: <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
Date: Thu, 7 Mar 2024 09:41:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: db8190ff-f310-443e-a691-08dc3ecdd60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDpWa+dd+rOx6w0sayJMEqVR8MNCBfX5tVN1mvh3jszbbqwchagsC2X0fMX4nJJqKevuDU8D3RURqALwghVtyqdvLG5bsnsSpAA15wE6t00czAAE+ehQR/0WK7+4xeddr1g4KGF8gJm/YOKrQP6xLsIlmVb6R9anpN4fSAzcmFIVxd1dH0iQETdB8ZBA8MsFbnFUICUqrcsfDCwOEkX/SSlDygcwDDwRnT5ZPP9uJE/c58yFLLZ2A+iNQp3byvite6dSohi3/ZoeWYgR5x4Zy9/srkRdpItHpQ7vl4jwCiyZKS7DRvTWxdHKcleYlZ5QTZAyypgQ5aD3WNdrItwwfFGQi0q0HKh4dWH44bVPJr63ZXyCw7ypMxUb5z+XIGD5nhdG8GIPGFGIkcbsQ6DZbVz22HyAg25mWCyRhS3vu7FOSNc7c4HMTuSjh666EdPLLAsvmv/ua10o6rFePPANXCAwN7fwqlZ1QNzXjn80OtJnwbRAy46X/Mz0S6wgxYGWNw+7Jz31OyRDv8nVZmtiTb62ifmLDaOQqB9SB3PSO13gK9b4C+cQuAXugv4itjRAXWbiS1zZTE4WOFHAXXL3vsmdGNNlKg5pkp7KjVgfNk1wI8g1UBYXdObW5NhBYT7+P3N9l0gHmM2EXbY4fwnN9yRP/ZXGFxJhnK1z+abltE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjV3M2lFcEVvdnhEZnl4a25KNkQ5N2VEV0xPeWprUkpPeDdiWjZEaVBzd0gz?=
 =?utf-8?B?UGtHM2t3UXpWQkEwdlk5Q2krVkNnTngvazNETHgrZE5xeWhEaGpVZnAvT0VL?=
 =?utf-8?B?WUlQdEZpaHhYSVFhZEhvMUFPTzk5MDFZOXVqOG10Nm5LSlhWTyt6U29kN2dr?=
 =?utf-8?B?a3A3WFhCSmVPYngvdHhUczc0cU8ycjVvR1F0NEpJVWtRRjVEd04rcmN5VFBj?=
 =?utf-8?B?QnBOWEk4djNEWHRaaEZ3YmVRblM5eUhlYVdDOVFrV0JHRG5ac3lqWjFnTlpz?=
 =?utf-8?B?eWdhaVA1SEhqTHNQbzE2R1dBdXFLYm5IRUEyNGxWcFJib1pMSDVKRGk5K2dh?=
 =?utf-8?B?QmJkRks5VlNHTVNPdFB5Vm43WlczY0dmbHNQNEJNbmtVS3lpT242N0g4OEhQ?=
 =?utf-8?B?cysyemlnNCtOeE5Wdm1XWUhHZ0Z4MHRGYVU5TU9tUGhBZXo3dUw2cmJTTHVN?=
 =?utf-8?B?NDNNTkZTYzNwaDIwczRGRFpOR3QvY3lDTjN0bDdYL2V3dUlhZ0ZzUnlSSWlI?=
 =?utf-8?B?bW1XV2ROa2NVUnBMbGJoNi8wNHB2c2dtUUQxZ2V1QlAxWGpaM3JEcENac2pO?=
 =?utf-8?B?U2tlekcxMzd6YzFZRDZNT1gySVhMMFAzZldlM2RvTi9pK0JESUw1bkJ2ZTYr?=
 =?utf-8?B?aDZlcktwUXBhOExBR3R0cjBQL3AvODhjdWpMYlh2TjBXTU1DWGlZb1dZUVlW?=
 =?utf-8?B?alNzYmo1R2tzdld5SkJCZTJuZXVLL1IrL0pTdjAxQ3htRHNLRW9DUjFZWDdO?=
 =?utf-8?B?N1R0WXlZWmhXKy83YUs4VGdsYUhKRm5ucmlVQ2NxdDVmeW41azBIcFAwRUQ2?=
 =?utf-8?B?eTZDc3I1cXdUbnlhQWFHalpYaVY5MU9ldWRJaWgxcGRJYzEzcFdxOW5WeW5t?=
 =?utf-8?B?Rk5rOE9vM3ZHa2RRaG1CQW9JVHRFWXJYaE9ZMklidUtNMG01cEdTM3BmS3lK?=
 =?utf-8?B?amNqRDZ5am1mcHdMNjdsak1WM2FESjREV0JxTU44aEhhUW1ScnFXVE8zdVpD?=
 =?utf-8?B?allJdzJnUGdkMkw2UmxuK3JjUzk3emxkSW50Q1lxMjhqSDgyQ2x4eDZBNzkw?=
 =?utf-8?B?WFUzNTNoeEdEN2lQZGlJUXZva1V6N2J2ZCt2LzdXd3hnbE5JVTB1M2hFOE5u?=
 =?utf-8?B?bUk3Q1Z4bUFWUWFSaWZPL2Z1Smd6NUZGT21VR3h6THhwVEx5TFRSbzgwdUNa?=
 =?utf-8?B?TnptSmlUcCtTQ1k1M3FiRUUwRHRWK01nVzdTd2IwUlZMM1VKaHhDRnNXZXlX?=
 =?utf-8?B?UVVjaC9WVUpTeFdPT0hXZmZoTkF0bEpmYVNUM1FkVElxZVlHUWNXSHlKWVR6?=
 =?utf-8?B?NkdWZEtNN2lSWkdYNnVIMzA2OGlSUXB4cW9JcXRRNjVYTitVQ0lCeGduOEVx?=
 =?utf-8?B?MnJLN1d1NmJVK1NVdXBLZWFMNXdWRjBKM1ozT0sxMXExWmN3eHpWcmw3TGFp?=
 =?utf-8?B?NmJmVTdzOWlPcGMydVA5T2ZueDY4U0NBRUF4VzYzUkhlSkwrcGQrZFJ6QXVZ?=
 =?utf-8?B?aitiS0V0M25ZdUVTVzZabE41aTJsczBkaG9ubXNrQXhRWXZJSW02bXpoUDhk?=
 =?utf-8?B?SDlHa1JTOWxrbXA1ZmhuVEppMG5BbjJQRXBHQzN2TWxiY3NEcDVwUDNlcDJZ?=
 =?utf-8?B?Sy9GbXIvbm5SMHlBajFENlFZay9FTSt2VFRiSDcrRGYwZjJFWFlqQVcrcFZU?=
 =?utf-8?B?RVRkZDlPWEhQYjJMeHoxS0hhcWNXU2MrT20rcGJOQjFvbFptNnZDMnN5QklY?=
 =?utf-8?B?K0lLZWJQazdUa016b2xBL05obGxDWEl3TWxjaDlLZFYrSEJ5MVVoVGR0OHZB?=
 =?utf-8?B?L0RidFMvZ2d3bmttUWtCbnNHN2pyL1laaEh0ZmZRcDJuSXZXNUpXT0Y2ZWhz?=
 =?utf-8?B?YTRPRFlIaVRzenpwaE9ZSGErUEtPWi9aQXJNMTdWTnVaTHUvYWFwWGlDcUxw?=
 =?utf-8?B?S3RLY2J4akNJZ29IY2VwTDQ1MXAzZ0dSMmw3cG9hTTB5M0l4ZlVxRlQzYS9n?=
 =?utf-8?B?RmNBYnM0SVd2aTJUM01LcEhBd3p0aGVNejQ1ajhMS1ZjeXFNekNnNGlpYjV3?=
 =?utf-8?B?WFBKWFdZUzYzLzg4NjZaN3JONWMrRHpuaVJ4THQ0V1VwN0dEVWlVZHV6aWhP?=
 =?utf-8?B?VGR3WGZ4TkIwTWhTOVBPMFVwRTJpTEhSWW9UY1ZKOGwyMmtnKzBRdzFvd1kw?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db8190ff-f310-443e-a691-08dc3ecdd60e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:41:36.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUVO+7ZFnYcjHaM/KeOnBAsA4WJR8il6Mdz54C2kaIJPeUMZLeQ814Ug4ExPoZV/AwlsAA2Aj77me3Zmqzy1pGOL5y6Gn9wQtQohjSQMF8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com

Hi Tony,

On 3/7/2024 9:18 AM, Luck, Tony wrote:
>>> If so, what should it be named? "snc_ways" as a kernel variable was
>>> later replaced by "snc_nodes_per_l3_cache". Is that a good filename?
>>
>> "snc_nodes_per_l3_cache" seems okay to me.
>>
>> And I understand that the file content would show SNC mode and the presence or
>> absence of this file would tell if kernel supports SNC?
> 
> Yes. The existence of the file indicates the kernel is SNC aware.
> 
> The value read from the file would give the number of nodes per L3 (obviously :-) )
> 
> SNC not supported by this platform or not enabled:
> 
> $ cat /sys/fs/resctrl/info/L3_mon/ snc_nodes_per_l3_cache
> 1
> 
> SNC2 enabled:
> 
> $ cat /sys/fs/resctrl/info/L3_mon/ snc_nodes_per_l3_cache
> 2
> 

This would be useful. I believe "SNC" is architecture specific?
What if the file always exists and is named "nodes_per_l3_cache"?

I assume that the internals of handling more nodes per L3 cache should
be hidden from user space and it should not be necessary for user space
to know if this is because of SNC or potentially some other mechanism on
another platform?

I think that may reduce fragmentation of resctrl .... not having
resctrl look so different on different architectures but maintains
the promise of a generic interface.

I am not sure if this is specific to monitoring though,
why not host file in /sys/fs/resctrl/info/L3 ? 

Reinette

