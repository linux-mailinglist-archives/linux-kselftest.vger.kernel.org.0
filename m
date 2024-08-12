Return-Path: <linux-kselftest+bounces-15181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE794FA5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09551C2168B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234518455E;
	Mon, 12 Aug 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iuis0ogi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271215351C;
	Mon, 12 Aug 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506014; cv=fail; b=q7D0DiaavrDjx9JK66iCndmpiExzRarxAWJl31sf7/qAEvZMU7ttQna3YwaSCIywY9Ej5DO3ynjjxHcPydAwamPMzZ97NxpZImdKDT0sibWdCFcGixNpqEj8vxyTBxkir2GZTQR7KgYX+GLLWGa60BVlr5YX2Fbwmj3Fv7fqWkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506014; c=relaxed/simple;
	bh=cjJi76bv+7JkKFDmXwh1GJ32sirlJrpEEIg6i5Biq0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8iGmSvO+nZt7lplSgjNSGrkvZibACf8FB8A58pgHavKtOyPzG21LiMM2l6VkVLMyFTmC0gsrrUW07qrVv5DPTlfk/Iygubhyh5QKtia6+4fuDzMPiGfiYsSrSN5VrCyWfYfvOVnC2jy2Uga0h3hYmM3ptPcy/UFBw4O9IK63Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iuis0ogi; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723506012; x=1755042012;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cjJi76bv+7JkKFDmXwh1GJ32sirlJrpEEIg6i5Biq0U=;
  b=Iuis0ogi8nKZt9+Wm8V5ic5HL0ATujmlb/jjOWNUlpGidRHkQ4EOmAhI
   POBqy0V6P42RGhvd3R3I9P488bupQpoNs8xBJPrfW6APiKx2oyE041pKv
   Xkdl0eoMzPaBJtgdNKS8dRC/rxKXSXM9O2yJZGGcH9tXS6KrWnArwX9RV
   OeAx8NIJ0W+e3ZnMcOYnu/6QiS8ZYydawpfjSWPrTOl60+d4LsWjYM/ZY
   /Z2IRIgoSn3De2uak5GjEaNvOwwjykTwApjwVJuE0s3uaqRZmXqxJhIO9
   rLqwKwfEaxWO4w7AxkwOFNOfv0+Bb+cwjysMg16j2qcHrQiS9Tp3fFKZK
   g==;
X-CSE-ConnectionGUID: K3w/3PhVQVao3DJpzHIayA==
X-CSE-MsgGUID: HPWgF0olTOuRAC/X7T8+WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21502455"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21502455"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 16:40:11 -0700
X-CSE-ConnectionGUID: EyKIsmwwTBW7yfeomg1Ebg==
X-CSE-MsgGUID: HqjYMdkNTOWb08v53ItNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58539871"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 16:40:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 16:40:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYs4snodpYg9x4c5yyd0mMBkhs8rMwQp44Fl1S/ywZaltjDOTWkHrKlwSIuOUrvCz9U71y3/dEM+XbdTC7L/EXy0Rdrys88S2CESLkVcj0DWef8RXBcFNEP4Oedj9TFwxwaj60KFItLNrv+cnhf4Ir7iZpNcdlWPA1WtzfejjTbeosg3Z9D6GCwevzDugbtCxF8VoLUfb/6z7LttlXLf0UYGAYgRbhzAsdAWKC/ew1aVBHdRn8jCwsTQyZM7c3/pTwKnp0zLHol0FcZ2l7iujPuSpyimqms4WOmv243MhMMajlXdIrM5ud6qCQvoIS0csGJYXnoZuINWuCTgmjNYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T0YyY4Vp05QEsf9TSKTwOvhFxgK7kKjwi96uzZyYq0=;
 b=G8BITufPqNoGjj90OwuoDj2bSF1mwJ66LhSgP8L1Usdf1YtX5uNGOWkpp39Ba2ERocRZREm6ELGq2ODKi8z+ERNRZGaXfm++eHA2nrL3UjHieQGon9Px0GhDWwywfUguGI+D5a+MgpWkadT7wVgPjCW14cgJWguBwJmu+BYPdE2TOS283/zpTXVF+za72Kxu6OW7qOIWXF9kRPsmCyqd32hQs7WXyOo93K44JIcWW2pnRzrTSTsD576c2QY6uctSbcjWuFkC4j46eFKddF8SCD4BZuwbpmBQ3qAbotOkqdLjs1JDij5Kno8EwiLtzfNjoqvVZD9v+qvXmJIlR9eKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6788.namprd11.prod.outlook.com (2603:10b6:303:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 23:40:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 23:40:02 +0000
Message-ID: <a132356d-d129-4cab-9c71-723d40869eda@intel.com>
Date: Mon, 12 Aug 2024 16:40:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <e5f2fbe4f492d37569c389aebcb91168f98783ba.1720774981.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e5f2fbe4f492d37569c389aebcb91168f98783ba.1720774981.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b522fb1-af16-4832-ae93-08dcbb281653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckJXMkl6RmZ1QmJEc3Q1RndaSEJyYWJWZmxCNVg1MTFzWHhuNWZqVy8rTmpR?=
 =?utf-8?B?eDlhVlQrZGhvL0I2NEVWdzJZNjVzVm9sWHZ2YVJ5ZXZhTDA4RTcwY0FVaDdL?=
 =?utf-8?B?eWtyQWphNU11S3E0Um5ETXZITWk5ZTFQQnRmVFV5bTNMMm9FZ3RUcCttZlZE?=
 =?utf-8?B?N1hkNFo3YVQrT2RWVDNNdEJqclFDTkdvYzA0WmJxRGx6WTJUL0NZYVA1cHBV?=
 =?utf-8?B?cW1DTnM4WEdBWTBid1ZmaFdVcVBxN1U1NVE2eUcwSE1NdWNPbzNpWHZEY3BY?=
 =?utf-8?B?TE1uTkRVUEttRUlET1dhVHhKeU1ZMk5FWXYvNGNhM1RMckJ4MWxRNkNQd29C?=
 =?utf-8?B?NVFIakJWQ01iNHg1aEFXbXREQ3p0R2V6dlFvczVaS3p1b0FnK2diR2Z1dk5Q?=
 =?utf-8?B?Yyt3ZDhoeUJ0bFBoYURSR3dmVEsrTzlIa1NYQi9mV1N0dXRQbnNSUmc5VVEy?=
 =?utf-8?B?ZlU5STVCOGxHU1ZDZFhsemR5OGZyWnNDZmluTXpvR0NreUx5Rjk3MmF0Z0lJ?=
 =?utf-8?B?NVFHK2xuYmxhTWoyeDVabVh4b0FUQmJSZG4xTDQ1RW9qNG9RdGh3QXRmNlBV?=
 =?utf-8?B?UTJoREhzZ3ZKbEdvRmtTRzBvQ0lGZlkrakZYTnYzT0V4aTJ2UlNFMzE2bDBC?=
 =?utf-8?B?cHBIZ0dSQUt6VzNiYTlpOTNGMVdlQTJlVjdmMTRDNGdlLzA5MHZhZmRNa2tH?=
 =?utf-8?B?ckZId3pkU00zd2hscVB2YmYzbmIyVWpaeHBtMlRKaXhYaDlQM2Urd2RucDdM?=
 =?utf-8?B?b2htQ0F3L21tZSt3ZUdlZmwrQ3ZkRDVIKytyR3VXK1dYcEsxSGpJOFp3RktM?=
 =?utf-8?B?T2lvMk5OK2Y1ckxHRHh1Qm4xVjFiRGJGS28xYTI3cXZ4alpTQmo1U3dDaEZX?=
 =?utf-8?B?QTQrTmV2YlEwZXRZOEZRcFRuZzlNV1BZOVUvbFkyUEJzNWdFdTExUFJlM0ht?=
 =?utf-8?B?RG1OVUxPeWdJRDUraXNhNUFYd1phbmtFL09VY0o3RjJLb1dDNGNjWGZKRFBl?=
 =?utf-8?B?SWNTR1ZQaGN0aUpkaWxzUjlSUnM3MG5lMDQwaXI3MkNmdjNJdW80NXpwQThk?=
 =?utf-8?B?cWJJdStkRGZpZmdsY2hYb0ZWbXJ5MWdRRUllbHNXUnJ0NFZqR1Ara0RFenFn?=
 =?utf-8?B?eUpWRjZ0WVM2c2dtN0tHSy9GaWY3UXp0Q1BQUEluQ2pMcXNXZHFFV1ZJUmdS?=
 =?utf-8?B?UXR2VnpwcS9rbC82N1NmZStJRkx3cGwvSFIrSGYzYUl3V0tseXdVMlhab1ZT?=
 =?utf-8?B?MmlVSVVLNDZCZ21MY29GZ2VMb2FlT1pXb2lwcGZxNGdHQnhjaUlIZlFxekNJ?=
 =?utf-8?B?ZCszSUhoN2lkY1VQa3Qzd3RkTnRKbTlMWXEzc3o0Z3VadDc1T2pYNUpvQURC?=
 =?utf-8?B?YWhxTzFIUnJvVFVCSjI5TzF6R2pML3dwRXdvRUpzN3IwNnhlMFhtSkFpU25E?=
 =?utf-8?B?MDdoR1gvVmcrVTJIMjdqOStxRnM1RGhWYXZNaldmaTM2bi9nOGNpSGZLMncy?=
 =?utf-8?B?aWw0RmtBaEhhUURXMEFsamdUMzZZL0ZlUnlGRDlMRmxiSGtzcDV3WE40MFBR?=
 =?utf-8?B?a29lRWpCdE9neFgxcFcrbjRyT1VjVEN0cC9qQkx1ZnBwV2ZYcWxoT3M0cVZS?=
 =?utf-8?B?bE1DYmN2SmtxN051SUJETEwvZHBEWHZvanhVL0d1VytESVRUZ2k5RVNoTWpU?=
 =?utf-8?B?Wjdyb3d3dThSaS9YcmdHYlZyNzdqS28vMjdKRXhTaEludHNNMDhoNDlsalpS?=
 =?utf-8?B?RTNOV09EdytBa2lnRWx1Y1ptWnVNMTJIZWJzNXYrV2srcURPV05XN21RZ0lH?=
 =?utf-8?B?aWkvbVRmcldramZKWnIyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGxHbkNQeFFocTRvdTBJejEyMis3UzcvNlVWdkprb0dadGlLZEdJQUlyYXhB?=
 =?utf-8?B?ZS85aWEyTEJ2Nmt4Wi9sbU5zcnVHYTZsM2pLd1l6OFdLTDVvMVZLQWVDUmdz?=
 =?utf-8?B?RFpEanVvR2RaVkhib2hNMzZjTDNqclhEL2t4OXdyQlgvL2hGL29Sd296ZUhi?=
 =?utf-8?B?THZ5bjJPendpampqMVdiRVc5RjFVVmh2eDREYjI2VFY4eS9DOFFQdUdQa3U5?=
 =?utf-8?B?OWl0OWdHZEFKbFVpMUUybDF2cStqZCtzSkJaUmtWUm5MQURKSFlySmpTelA1?=
 =?utf-8?B?NXF1OW84RU4wLzZFRlJWSG5YRW1JWWpRcThVZHFBaHVERVJaa3BvVjVUeE5x?=
 =?utf-8?B?VjlkREJkdmxBQWlEbTlSTTBIbnRMVGt3dVZoWjBLYm9ra0l2eVVWUGFjNHM0?=
 =?utf-8?B?OGs3V1lMMnJWcXVqVE83L1l4Wmt0RzJkSmoxcVMva3NaMFMwdWs2cFdncXlE?=
 =?utf-8?B?QXhoT2tHSEF5UjZUQVBHOEV0OWIzN2Zkd0tjbWtZM2E3eVV4aUx1cDh4ZnhF?=
 =?utf-8?B?UTJWbnUzanBIOXRtbkhsd0YzRnVNL3RZOGVVRUxKc2haMWFlRklSVkJUYlVj?=
 =?utf-8?B?R1Jvbm5OSFZJZ1NKeTlUS01BS0EwMUtHdHVDa1V2NHk2VHdleUU0OXB1eTRt?=
 =?utf-8?B?dVRzak4rL3g5Skg1QXpaUW1HTW13WlljZDdQOUpnaWZqNGp0cjdjWVJ6N1h0?=
 =?utf-8?B?YnNIVGdROVJiSlRDM1g0MUc0OHdyT0ZkNjZFZHVtdXFCdWxEVlZRdWhKMU0y?=
 =?utf-8?B?SjljcEgrU09kODEzb09jOEkzQXFFbHg3a01kdzZ6ZUw5UDZveW5hd2VHY3hX?=
 =?utf-8?B?SEJTL21UNGEwU2tWTlVDNmtZUWdiUHluM3JERjcrS2p3eGZLNVplekQ4Z2Ny?=
 =?utf-8?B?V2ZMR2FzMUw4dkRwbmJBdFhhWXpXVVBOckJSazVmSWdHeWxJdVc3QWprK01t?=
 =?utf-8?B?Z2xvenJJKy9yUllOSG1oNWxVcEpxNTlLYUY0OWlqSE1abGp1V2pMZVR4cVFO?=
 =?utf-8?B?ZDZjQzdmR0hucGkzdlJzbnpEeksyK3VhOHVWeVhzU1JMZVorN0MzUXdtaVh5?=
 =?utf-8?B?YTBQT29CQjRQMGxqeEdJSHdLOFdKbnhSOC9DTDBVelVDZlJYRTVmMGZNdlA0?=
 =?utf-8?B?UVhjU1VXWE0wSHRudm5PM0pRZ28yeEpxVjhKV2tWWUtaWWYrWG1JcVNaVjJm?=
 =?utf-8?B?RS8yb3FLNGhac2hITkczSGo4YzFCQ1ovOC9lRkVRdWFxeDZEelVNSWxoZ1FE?=
 =?utf-8?B?ZGE2V3FITXVQSUhnZ2pZbHBGWks0UFhGV3pYbzFmeEp0b0U3WGRNTS8vUXB5?=
 =?utf-8?B?U0x1cTg2TitZQUY5VGdlMmJPTzMxWmk3WmJWcURDV0ZZdzdMbXJZbUMyMjd6?=
 =?utf-8?B?Q2Y3UEgvZmtBYnRHdFdwNlc4ZU05NTlDYm1LTmxPbUxzbk0yaVNqNWFKRDI2?=
 =?utf-8?B?VldhMm0rRkYrVVExWktrdEM3SGFNNU1DWTRyVDl0VFNuaTR2bHJuMlVvMzYw?=
 =?utf-8?B?MkJockFrbWsxbU9tZWhzcHkxRys5bTl0TWZLL0ZTOXNYRjBJSnIrMGx5KzFF?=
 =?utf-8?B?NndCNkhsS1MyZTlTK1RDTXJlOXAzR2diaWF6T0lJSGlramZ5NEdqdCt3Y25Y?=
 =?utf-8?B?R2ZqOEVzL3ByTitQNlFaVVVuZjVBWVBrNWZiV2kxUkd4NUpGYTFvcnJkNVJP?=
 =?utf-8?B?bjV2OFRkNlJuQlBML3dDVWFEQmVFUERiZFAxSW1MTk1hVTAxakhlMm52L3ln?=
 =?utf-8?B?cSsrWms5OUttVTZrdTRmL3lPWjFmNDNWSHYyQ3lSS3I5TEV3aU40bGdReG11?=
 =?utf-8?B?dTY0TFdleXhOY09ZWkxsQm9hOWxQKzdPMHpzNk1uUWdETXlHbmJBanRwd3FY?=
 =?utf-8?B?NS9td1hMdmptUW55YUtqalpoMWIxM2FEQmlHUmw2Q1dpTHBpRjIxOHkyZzM2?=
 =?utf-8?B?NG9jUEZjK1FqY3JpU1dpZ3VZbExrbVF3ZTM4RFBsc3EyZlZxRmhTSEgrWDF5?=
 =?utf-8?B?WEhXSE9GUmJFc0svK21VMzYyTnQ4S2FxVDVFL3dpTXUreitvR3dqT3gvUFV6?=
 =?utf-8?B?ZnArUUVncDZIZFRkaUVoQjFsV0NtaGsvbjFGNUtJYnRmRFFrNStjSzlKNHlS?=
 =?utf-8?B?KzFnRHRaTHVxNWVya2p0VU1BcTNQaVRyd0gvYWh6bXp4Ymh5Y0Vqb3VjLzNW?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b522fb1-af16-4832-ae93-08dcbb281653
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 23:40:02.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu3ou2G6PMXUgJ4xCvDq/8TpJUp3nM1l5V36LN99+Os5KdvCcfuO5/2OoSmE3u58alxjzRKVtG81CSBXTefDbdbkB/Mxkyq2zbeL8IeSd8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6788
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two, three or four
> nodes.
> 
> When SNC mode is enabled the effective amount of L3 cache available
> for allocation is divided by the number of nodes per L3.
> 
> Detect which SNC mode is active by comparing the number of CPUs
> that share a cache with CPU0, with the number of CPUs on node0.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

Since you are "From:" author there is no need for a "Co-developed-by"
for you. Tony does need one. Please check: "When to use Acked-by:, Cc:,
and Co-developed-by:" in Documentation/process/submitting-patches.rst
(checkpatch.pl also warns about this).

> ---
> Changelog v4:
> - Make returned value a static local variable so the function only runs
>    the logic once. (Reinette)
> 
> Changelog v3:
> - Add comparison between present and online cpus to test if the
>    calculated SNC mode is credible. (Reinette)
> - Added comment to cache size modification to better explain why it is
>    needed there. (Reinette)
> - Fix facts in patch message. (Reinette)
> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
> 
>   tools/testing/selftests/resctrl/resctrl.h   |  4 ++
>   tools/testing/selftests/resctrl/resctrlfs.c | 73 +++++++++++++++++++++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 2dda56084588..851b37c9c38a 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -11,6 +11,7 @@
>   #include <signal.h>
>   #include <dirent.h>
>   #include <stdbool.h>
> +#include <ctype.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
>   #include <sys/mount.h>
> @@ -43,6 +44,8 @@
>   
>   #define DEFAULT_SPAN		(250 * MB)
>   
> +#define MAX_SNC		4
> +
>   /*
>    * user_params:		User supplied parameters
>    * @cpu:		CPU number to which the benchmark will be bound to
> @@ -120,6 +123,7 @@ extern volatile int *value_sink;
>   
>   extern char llc_occup_path[1024];
>   
> +int snc_nodes_per_l3_cache(void);
>   int get_vendor(void);
>   bool check_resctrlfs_support(void);
>   int filter_dmesg(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 250c320349a7..803dd415984c 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -156,6 +156,68 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>   	return 0;
>   }
>   
> +/*
> + * Count number of CPUs in a /sys bit map

"bit map" -> "bitmap"

> + */
> +static unsigned int count_sys_bitmap_bits(char *name)
> +{
> +	FILE *fp = fopen(name, "r");
> +	int count = 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return count;
> +}
> +
> +/*
> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
> + * If some CPUs are offline the numbers may not be exact multiples of each
> + * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
> + * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
> + * lower. Still try to get the ratio right by preventing the second possibility.

This all seems unnecessary since the next patch sets snc_mode to 1 if there
are any offline CPUs.
Seems more appropriate to move the offline CPU handling to this patch.

> + */
> +int snc_nodes_per_l3_cache(void)
> +{
> +	int node_cpus, cache_cpus, i;
> +	static int snc_mode;
> +
> +	if (!snc_mode) {
> +		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +		if (!node_cpus || !cache_cpus) {
> +			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
> +			return 1;
> +		}
> +
> +		for (i = 1; i <= MAX_SNC ; i++) {

(nit: unnecessary space)

> +			if (i * node_cpus >= cache_cpus) {
> +				snc_mode = i;
> +				break;
> +			}

This is irrelevant after the subsequent patch but note that there are scenarios
where above loop cannot set snc_mode and the function will thus return 0 since
snc_mode is not initialized. This is a problem in division done by following hunk.

> +		}
> +	}
> +
> +	return snc_mode;
> +}
> +
>   /*
>    * get_cache_size - Get cache size for a specified CPU
>    * @cpu_no:	CPU number
> @@ -211,6 +273,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>   			break;
>   	}
>   
> +	/*
> +	 * The amount of cache represented by each bit in the masks
> +	 * in the schemata file is reduced by a factor equal to SNC
> +	 * nodes per L3 cache.
> +	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
> +	 * allocates memory from its local SNC node (default behavior
> +	 * without using libnuma) will only see 50 MB llc_occupancy
> +	 * with a fully populated L3 mask in the schemata file.
> +	 */
> +	if (cache_num == 3)
> +		*cache_size /= snc_nodes_per_l3_cache();
>   	return 0;
>   }
>   

Reinette

