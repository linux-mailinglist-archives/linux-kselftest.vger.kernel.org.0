Return-Path: <linux-kselftest+bounces-6400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4487F1F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75F1F213E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B658218;
	Mon, 18 Mar 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThVjn3di"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB82374C;
	Mon, 18 Mar 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797014; cv=fail; b=n110b6IXEDuYEj+XXjUSlzOWZTs+dYKks2jWq3RkoyU0QRnXB6xVRqSO8WZdA0F0y6KKu/WPJ1keBCcRqmPWQl6gQB9R2NGj61q5DQeJJZiwZ4dl5wdautsBc5a1/S2ocB7fC2gbt9boNF0qM0ko3cRDNxk9PCDwuH68/3jneUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797014; c=relaxed/simple;
	bh=kOWVolFl8PEp2Oe3kXvIzOCC/WDj05Q13EX9qgL9iiU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RNImJI6pgKK7UlDB3Wpsgrn07j91aIoj+Nb6gOBn3ZDPYCQv5heShU6oQlmGhh6JxLm9MZ30gt87aHb7ECFmqbA+C9RSgRxQkKuHLsvxA04UD4RVYjdUQqFjcPBts1PfCrMAYmAmBBWaq/Of2GY41hZROQesnJIHjsgAtkLGOmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThVjn3di; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710797012; x=1742333012;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kOWVolFl8PEp2Oe3kXvIzOCC/WDj05Q13EX9qgL9iiU=;
  b=ThVjn3ditfAPy7S1am45aLH/PgUqJpFne5Tnuvnp3s2YHRYWmDBJnHP8
   Gq6Ye5Rmv6b134N9JFvkF6NSfBQg1hVU7JQSU8xwvf83ZCxTgj7gVAiOv
   asspkBeM+VGJhXLy/lJeokID/HXbrvABHwg1Xxh6RKhgOXxtXOurBIe7X
   eeSTDnjF4gEM6YPFXjSnc4g6/6FPxW4Oh94CiYqB/kXWTjLb9NMxVz8fw
   HfY+/mHeuKyqIIVO0oCSDIUAC41rmG1EYWHQUlndVfNQnCt+kpoR531pz
   HfFFoui6kK5S8qSglVLHBOXKn+X/XgVvAvEaIYRetCslwslArBTLV27wR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="17036079"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="17036079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18070468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:23:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:23:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:23:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXVvXz61leHWSuTskmvrEF2dEXcmkH7AFWAz2GMcbExuD+LaV1nEwVd8tm0O6BuuoKG8+L1RM/lrWxmmeMYmoLli1CytY2kaoNLOZWE+/ot+fT8a9Qlyvo2v+kxwb9y/MLBgB5qJkIXgGGA9zpoLuCd8JwcTLCbRn9dGuFJfNGdeROqE85m1xZEJmDY9GVlWCf8ROgBjs3INEY0PuCQyxbuH1DEYPYZNoCr9thGUtlAx48JB4Q56lKwdhxVSDY60Ty7II631hYqqNIq+/NXwYjBom1I+48/orHACnW7YuL4qmTVXLmJwy6SGpGY7XHrPLpXB5GwHJeW7ctOKsXka5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtFfn1aUcli1Hj7ukOn9IjY5x6tK08Ovn+AITAlTXW4=;
 b=mBloxGbOEuvLYD+Taru7Ta7F67TRwrdsvDhFsj4YQzsfRN3z7Vn8cMPLe1l4GbT3XHqrWN5A+dWuEJrVk3NAU/IRIZieKlKH6k0YqBK8QMaw4hOf4Ezdv8Isf+HG1Or22bZVqlR7HILPyAs4Y5AuQBGvlYgWUaEPdY1NUl4hhx/VAr//VMOZKjw+DLxBLu516VZkyHtnUxPdxZFWqdM+l4CAgiO8fbQPFRBVJYTZbuMRVV1ecG85u3HBRZSsdzkKSfWzs/QKCXxxmuxnXs6QEiDxHSiYxjshflQvXiSYeqNYV8aP7a//HPRugmpnopQoVg/omuc4pVsZrf0QosbYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 21:23:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 21:23:16 +0000
Message-ID: <fe4a54cf-7103-49c7-add4-ee4bcf76c7b3@intel.com>
Date: Mon, 18 Mar 2024 14:23:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
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
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5877:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4sukkcLg3dArax0O/rAl1p7PxQW8Mh5qLq3kVy9Z9//OUX1kcaTfAlnZTUJq0SgO+oiKqYMJv+bKH+crHbgPI6dZ8KVUqJiImQY0eWX8j8KhqNSipdmXtPJgSo4KOMSN5oenaRJS6imeUw2OuhCtjYufGH8YaoEDh8XqNGeJiUMO3Zhmt0vjRatDxIhw6jVXz0K/hyTm66ii+uQHNJ/l7KPRixihTIihLdrWSmODZMhdFQprvWCn8U2mSL52E+fHYiXAnvOojxXZohmbjPf7A17bia2qz+zfQAyBG84mclB2q8Smt6Z4N32/xACZXvuq+6KWtoPjhVHrJxbCAk6MZ43WmrhIXDC6roejQm06rzc/0rprJOqSRSM6NO15AvBBCsBnzAaElluBn86Yk00iGMlGmlSm31SUNx3Bras2nDRKQW3nReSyHX1JrtkH/kXhlGikwwrnKPjGrncamHsb0a4lC1m1+Ws7NOu9JODCwRdSRmX6epCI1g5EKFeLYoM2micIH9TWdSb/qC159EyZFD5mjNsYYcocGaVDEh/DzfuHMDyv0LDExyF3kwU/X04fgZBJCpQytSxb/BcQBQLzTiLbuz/mSM7s8PrC/3R2IFsQ0uLsXwpaGu9EtffEZkfmuWuJQU1WvCuBDcgyG3ecDAutM7rZpbboQssLqw7CYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NWcWwzc043TFFNQ2NXUDEvSWphcXRhTFZJcFltaHZWaENGWEhyRlBLTDlM?=
 =?utf-8?B?UE1Vb25CR2hjcTkvcUozeDd4MnZLZ09LbXc2QlJSTmhXS2RKbHh3TlBNbUtL?=
 =?utf-8?B?c2FnejB4ZzQ2a25yN3pIeEhnNlJyVUdjczEwcUpGS1pBRkR0YmtYOENuVUJQ?=
 =?utf-8?B?dVBlVUdPQTZVc2srWG5NeU9adFk0dmg2dVVFSmdHT1orNUszdmMzL0ltVnRQ?=
 =?utf-8?B?NzdkMDNaekNrUTgrN0J6SmRxVHlhNndlWGRWTGk4eFcwM0pWb3FwS0JGRHdW?=
 =?utf-8?B?SGFUVndZdDZDV1d0TU9wcVlWUzhRR1kvWTZJLzc5STRMZEo1ZlNqcHp1amZh?=
 =?utf-8?B?MWFTaEUrNzVGNU1penNacWM3VisrRnlsTXIyZWhmbDdUYlZMZFJBUy9OaDVJ?=
 =?utf-8?B?RmFmeVFQbXVqOXhiR05UWmtBV29OYnRJN0RpUDJwdCsvSis5NGhDTGdWL1lF?=
 =?utf-8?B?cEI1RlRzK1QreXJ1NTFLMWxhNkRDblEvUGQxVDFUQlpYeTFDanZiUllVU3F4?=
 =?utf-8?B?Zm1HOTNVZkh4Qi95Q2NzUDR4UkFYMWtxMnd0UGtKdGVOL0hzK3dqNFdIaW82?=
 =?utf-8?B?K095MjlrV1dJSnpWcE9pM0k4UHRLVmVDSHk0YkhYQjhpMTB0RlcyS1BZWVBn?=
 =?utf-8?B?VWlnU0tRbTBJRlZndkM3cDFybTdlemhMY3BUVkJjWHVpVEd5Vm9oaElOYnVm?=
 =?utf-8?B?V011RVZFWlB3VysvVzV5K2c2d0JuMkZlTmhMdHcvN0RZWlhYSWlVRTNnY0th?=
 =?utf-8?B?cXB1WTJFcmpjUjMxZmlMMnB3eENUUXozWCtnenV5WHFaQU1ob0o3R3FEZGEy?=
 =?utf-8?B?WDFGYWhBaHZrOHYvTnlieksvU3M3YkorK3dKRHdNd3dJakdzemRJa2R3dG5W?=
 =?utf-8?B?ZlFmRVFreVV2K0J5VzMrRkRFbnBuWHZxRUdRMzZoVUhYTk14U3kxeWRERHFO?=
 =?utf-8?B?Tkhlc21iczlOc2dRMFh3NUVObDNwQTlSM2NWS2tXUmhYUld1MVVadmdSZHd5?=
 =?utf-8?B?eHVzcTZhVjJnd01sTzNKaXovclYyeWMrZDU2SFBFN0hwZnpmdUhyTzd2Um42?=
 =?utf-8?B?ajI1MFFIYVdVYzl5MTdIdEVQdCtpbGwzNjRkVzhJdEl4TGtrNVBQUVlEcWZt?=
 =?utf-8?B?b2kxQm90TFVvc25Qc0Q0Y1REcC8vSlhUMTFhMnVNQWJFN2VyQnF6K2ZsdnRB?=
 =?utf-8?B?TitkZmFnY2V3RGhWTnJJbkdSTDhyTDZvNnoyakVEMjJUWGYwdU42UER5ZG1x?=
 =?utf-8?B?ZU02VTBoOEppZ1BFK3ZZazJKdVo1M0JCdnowWHZpTFBqQmxpd0hsOE84OEFz?=
 =?utf-8?B?YmZHQkc3aGpKWTVCZy9YbXYvTVVrSmpTc05JTUhVN0NQejRIbmN3ZlJIckl3?=
 =?utf-8?B?NDhmVTFiU3RUbDEvTVhZam5RT0lmbGcxMms3Njhka1p3OG84SzY5c1dYVUlD?=
 =?utf-8?B?bUZXUnkwazhDOW5xQitzVHRkaDNwZkMyOWlFSzRLVHRiMDdseFdmQmZOanhK?=
 =?utf-8?B?bUdhcEM5bDBpdW5uOVBEMGhsTHZKbWFDeC9sdkdJcUNaQVh0Ry9lUGQzbGJr?=
 =?utf-8?B?RTZ2dFNlNFBNakdJdFlQK2pIbno1T3lkS3pLWTNCb1JReGdlbkJSSHdMUkJ0?=
 =?utf-8?B?UFpHR2NLZ3BYekZSZU9ONFFhbWZlK2dyU2RtZU1QeHpkdW11UWdMdE56cURZ?=
 =?utf-8?B?UC9HWW8wK3g0WHZWSG5PdDYvNmNtV1pNN0dUQWV1bUdYS1JHSXVnNnNxNzY1?=
 =?utf-8?B?bzBFbGxaeWQ2ODRyVzM3UzVtdFE1M3V0MDVMRnpjSEVkMDhWZkpucEJ3MXBO?=
 =?utf-8?B?VTZadnFOUnA0d3ZObVBoakpuU1BPOEFoS2hPU0VIUCtDM1RONk94akR0RWY4?=
 =?utf-8?B?RWllc0tDWDBYTHcwdnFHbkpjUE4xTEVYRGluNzFrNnF3STFjRDExZ09nTGpa?=
 =?utf-8?B?YVZiKzYwb2s5Z0RhdEZxQlZHd1JHeHhhYi83T1o5eUt1b1R6NENEZSs4TVZo?=
 =?utf-8?B?dXorTVlteGtRb0YvVVZYWkloNURpcktpWHFUMGNFYTg4bzdkazJGN0VEWHZ5?=
 =?utf-8?B?WGdiQURHaEkrQ0FqdG5Jd3YwR2ljQ3VUaStTaUpxVU1ibmdVODRpRFpmL3NU?=
 =?utf-8?B?UUw2QXFyNHJteGdoSGl4OUV1a2FvMktwbjNVNHdWZ2c0bTZsWmVndm1HY294?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 509d5d8b-7d92-4d91-549c-08dc47919fef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:23:16.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jYBkMnkGk8InbmQPnASnKpKRA1I2qMbCQYoVFU78ojSqMnvYRVZT8w4xgJeii+0yTWWaQ0e1p6fq2qEVaiVou3fWPrr4hOUCZAKJqtcwOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com

Hi Tony,

On 3/18/2024 1:47 PM, Luck, Tony wrote:
>> What is the use case for needing to expose the individual cluster counts? What if
>> resctrl just summed the cluster counts and presented the data as before - per L3
>> cache instance? I doubt that resctrl would be what applications would use to verify
>> whether they are "well behaved" wrt NUMA.
> 
> Reinette,
> 
> My (perhaps naïve) belief is that in a cloud server environment there are many
> well behaved NUMA applications. Only presenting the sum would lose the detailed
> information from each SNC node.

Yes ...  I understand by providing a sum the values that contributed to the sum
are lost.

Could you please help me understand the details by answering my first
question: What is the use case for needing to expose the individual cluster
counts? 

This is a model specific feature so if this is something needed for just a
couple of systems I think we should be less inclined to make changes to
resctrl interface. I am starting to be concerned about something similar
becoming architectural later and then we need to wrangle this model specific
resctrl support (which has then become ABI) again to support whatever that
may look like.

Reinette

