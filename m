Return-Path: <linux-kselftest+bounces-4337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811384DCA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7484C1C26387
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4826BFA6;
	Thu,  8 Feb 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efOd8kR5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6051E51F;
	Thu,  8 Feb 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384007; cv=fail; b=DymUFW9o4VZAZKa3w8i+dpfET0glX4o/Pal+Thtj6IPbicM0EVmxqY5Ll6yVUkJMmqt4MiVyJYMwJX5q7cAz8CnX+cd/NV+j2qCfXl5SQYaxTrfXlDPRmyfbgN6BQvKp3pMSENjtK5ItPXNIyZeVgFRwCwAOv8rMTJ5FB3tMXBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384007; c=relaxed/simple;
	bh=Oe+1KpSdm6Qpb2Hs6rLOc6Lb5AYiu/7Dmg2bt6TlwY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgbpqpLCUu2G21MQUoXgzj8kOlCRVv6zl7bcGn0hZqdE2229Fg3fWiXzbkggWpZLwKIP5jkA9ISF5n4pZLHJqFSFqhwJwNs0IcMREiPCLOc9bZ5i04kJCn8NXangonLNO3glzOxtxBuWt9y+Nz8jGo1OXoohnPQr+TK1lPQO8xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efOd8kR5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707384004; x=1738920004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oe+1KpSdm6Qpb2Hs6rLOc6Lb5AYiu/7Dmg2bt6TlwY0=;
  b=efOd8kR52wBsVF3G7UuRr8QKmAwV3QYHAv6QtIZDns/nPCtUdnMqUgHx
   LFTin7kZuGKqzXEo0FU/0+XCkYSLkLmQgeAzPCJK+GdaVz0ovgxit+rJT
   q8CQL3qR+WJ3KcW3erw/DnVcjid/lv5uWLejdmbowRetvPDkiNKfQDqWW
   uEbYlH6nZUqFXL1IywxRZRIQ4X1u8/zO9zoeQPEwnNv6tV8QB8ZzFS31v
   n7NxUOlpKzTGaFSJPioW1EhhvWWvM1E/O/m817U8glzsO7L/AMV4/dChp
   XHUCWTvM6S7kNCry0vF0HHpbqEoD41oTUsmJHyJGypr7AC636FafYDtdp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12545426"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="12545426"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="24851252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 01:20:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:02 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 01:20:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 01:20:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwWqcaKxyPXdSxwxEhlk/uhagSWYftAP3phbu4Ux7BzHmX4LErCF/qutGzBi7qQYzE/pqAFowrs36DJWbe6wgV8FunzXtZV+KZ1ZTa26FfM6aIP0euHG3tehkMvDwcz3CuaKLODm+dAdwEHyHqOl0Vi47G/of9Af/wlMKjPWTPyiwOBlALWyXbjHCJgSjshm/iEUpE2HYsAwv5BFFXlfutfhTmDIMbxKE4orFzO/JMB83nyI0n1zyM83Q925G+Z4sun2AYF/YnF5JVdI3SwtZgZYnGwiJa2sEfQ7ah7MC1CuOWQJHNP0WJCjVTpAWkvYSFqKNrhOjRJ1IO2yIyR8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dmdGQNd383V7yvTkbEy5teJJpJ5Two3GzVQWkO5YdA=;
 b=WTTCepVRhUcyhXmJjGmSalHh5qAwzpdrW+vnRo08DQJfmboNCPgTpREjMG9OpjDe89Qrp8iHIAAxImF7VZNmKckhHeQtUGAMdMW2z0+1auzFKdSMwyarqIliHDcTPG+Cy32xFYfZoTSVaB1fl9RAypS/68OaqASGT50NUqt2PL8J9ocdz8ktdf2jLWsAdsbYt5eQwBPG3HR+rxOHOWNdw+CXqsG4HzOmzRw0jz8RN0W4nDDP5Wzjd5xqaX3RoGIQIlzTQ0BywXIX7K0DCpU5PwT0U+KECQPNCvjHrh8NDR1NSKzum/0PiKqXfzHZs9aa8z7pShunxzMcFoxkzYgVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 09:19:59 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 09:19:59 +0000
Message-ID: <ba25e0b1-fd7f-4813-924d-b116a88dbb5d@intel.com>
Date: Thu, 8 Feb 2024 17:23:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 1/8] iommu/vt-d: Track nested domains in parent
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-2-yi.l.liu@intel.com>
 <BN9PR11MB5276FA50EE70CAA0DDB758578C442@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276FA50EE70CAA0DDB758578C442@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: b731559b-ee62-48d1-86f5-08dc28871f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0vjWUm6tN7Qkik4GzL5zFNJojH6KGM8m8oJ4lTmHt7HoRg6Y2N9O/qagLxMdGjx8Shdn91E0DwLFmVZNV6twLg+UWB3PhGdqXjuqP5pTpA8859raIFOM4aBJS9yhkYYsYP/7TcrPS+yh+HfX1JmxKb+cm5iputvtcDD8BsMnYsemLXOXtuu4qDfvWleyIJtTnFVklKHJLx2PLhtZyl54/eFS1yOU/NEoHNQsUqvTmO+9URuWyWXPF4ZNUrWQaqRxlYWRUMqcvnGf6SYJMqQcSIHa7OkhQr2GQVzoK7ztaM6J7HVHDOgsee0LI5AHJRyimVLAxsJKvaY3blIic1zhDEaZiuJAmoYlgp07OrBsMQRiNJ6Zumt5+WJjLNC08WE17XSjsHhvu9ZnqIbfC+NW+VpbdwChbdl9A1w6ugpH/M4+vRRm9H5wZPmrxghEXOI1WJYv+NV+WaMNiBoo6aYSBRXlLCnNriqKJCnhmC9/u96E4MCdOqscogRsGQdzY++crsl/m+6+qzdJ/DrUylWoWDDO0IEu7ATSgpPkloRpHMUKU9qyUGVxckm4Wyp4ORm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(83380400001)(38100700002)(2906002)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(26005)(66476007)(66946007)(7416002)(4744005)(8936002)(31696002)(8676002)(86362001)(4326008)(6512007)(5660300002)(36756003)(6506007)(6666004)(2616005)(53546011)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZ1cnNFTURRVlc1dElNYkhNR2ZmRHVqNHowUGZ0US9DV1c5ckw0ZU51OGZK?=
 =?utf-8?B?RlQ3alMzb1p4bTFIRDkwMWo4cElVb2lDMUZqQnF1ZS9TRWh3cFpQS0tJaXhN?=
 =?utf-8?B?aFZNcHRuNzhvRkJKVDIyeWUweEVFWGdyV3loVldhS29rZjNRM0pld1lLY1h5?=
 =?utf-8?B?SmErWitoaHBQaFFwanVKR085SEdkWGVkbXlqYm9XakZuZ28vbktaRUNsTVkv?=
 =?utf-8?B?RFJKbGN5dkVhbjU2Uy9NbEFKK0sxVllreGI4eFBaaGVEVFRBNndZTGhMZjc0?=
 =?utf-8?B?VFgyNGd5M2tjckpGOSs4dC9jcWJQSnVNa28yTUM0ZVRzZzNjb0hjYWY3YjZ3?=
 =?utf-8?B?NjdKZnZvNWhmMGh5M0F4Rmw0SjlOYjlqQUNjd1dpSEZUcEhXeWhLUVpKeUhT?=
 =?utf-8?B?L2VBc3Q3cWswbExHMVNIZ1lzOWFTNTJmcytOTlRCbDFqaE5hVHZ6M1pEZEZ5?=
 =?utf-8?B?Mm5SY2RYR1ZRNnhIN1dvbUJpckdPV1ljUFNEMlQ1cTd2VTA5SDlzUnFTZVdB?=
 =?utf-8?B?dDcwM0t3ZTR5OXMvWVpzL0JqdFY0cVRkaW92R2J6RlRKQWY4ZTVPYStLVWxJ?=
 =?utf-8?B?Nlk1aEFPTTBZcVhGb2twZEx1ZWZkamt3Z3Mvcmd3cVprTDZhMHZrWGdZUXVY?=
 =?utf-8?B?V0YwYzdtL3VMSU5iSWpoRlUwTTV1UlVIMHlyNWk4cEU4R08vYUVtMTZkdXRV?=
 =?utf-8?B?OWx0RTBEdWdodjd5Qk5RMXUwbjJ1ZDVzN2hHQWFXRnFvK1dGb0EzMkVPeHBF?=
 =?utf-8?B?ajlVOGxmTlYxMEoyVDFUU09NQzlWeXJQZVBsZjRla3ZvVGZURXFNcGJJWXBB?=
 =?utf-8?B?YXFZcFhXSFdPUmRubVpnWjhaQUp0TW5PUkFUbHdJWGhFa3Vrci9wQjRKcVRu?=
 =?utf-8?B?T2pybXFKVkY5VTVSUTBHNXdyNVhFZFlnQ1RBaWFFWjFHM1pFUUdCVy9RbkVy?=
 =?utf-8?B?TU00OGZUYzgvY0FzWkRlUWxUeVFsOVQ2WHQ2czAvdFhnSS9JSlpzTFVNcWlY?=
 =?utf-8?B?ZG5qSmRWeTcreXhkd1orcmNxQ2kyejdzYmZiNlZlU05qT09icE5hTm9KYThm?=
 =?utf-8?B?TkhUYjVMckMyREtvUWVLRDNBZ053TlJ3bUlRWE1seWhldVpZM250UmpjaTJ0?=
 =?utf-8?B?WFNIaExtcHVDSmo5eGZ0M0UvdlJUWXFzK0kyenY3b3Y3aUV0dkI1cVJtQ3JY?=
 =?utf-8?B?cU1wd3ZlYU4weU1tdEZ1Z1RHVUx4d3d5cEJ0YmNBOUUrMnVseWFEdFhURHFR?=
 =?utf-8?B?b0pIVjVsREZEK0Fyb0RGdGpFVUM1YTBIajlqSER5VnhzTERXSEpKQ0hsR1lS?=
 =?utf-8?B?enVZTExRSzBsTHk5dDFIRldlWHE1RU5mL0tMSUNWNU1qd0hCbHhzODNzdVFQ?=
 =?utf-8?B?NE5pNERpVVFPTlNxdDNITjQ1V2lnSzB6aVd0TWttUUVlZVQ0WXpRSXNJdTVj?=
 =?utf-8?B?ZkZXVFJ3MEZ3NjlnMjFXVVA4QStrQ2hvY2dnM2ZrQ0RmWU1NYVpOOWFaNXE2?=
 =?utf-8?B?TUliVXpualRWeXhheXkxSFFhc2tlN0RBNG9KcHdPTE9WQ0h6UXRuT3cyblpt?=
 =?utf-8?B?cmkwS1hsT29xSDB2aFJQZE5rTXEyNjU1aTRRNW9LUWxFc0orZzBJTENIOHV0?=
 =?utf-8?B?aGI2ellxaDJUQjJnaXptd2R6d1Z3Qkw5cThrWkFqWmtEekQ2VzE0dE1KNHRz?=
 =?utf-8?B?SWtPMkMvSzErWlZVRDJJOXhMQlRISlFjelBicHVqNTJzdytoTlprRkJSa0Zs?=
 =?utf-8?B?UWx4VnAwZnVOWGVWYzlXVFVlTFRmMDEwSlk4TEVCSjBTNUI2elRwYXZtVUFw?=
 =?utf-8?B?MWVPd0NqTjRqTnc3WmVEazRNTUJLaGZHd3kvWWU0RWpEUHBCUUhqNWdESDF0?=
 =?utf-8?B?NFozUXdrdk9hcEd5RjB0ZGRvOWk5N0tSRTJGbzVWMnBBWnljT2tYWnVjbk9L?=
 =?utf-8?B?dk02SnFQZ21rc3Z2eU1FcFRIcE5CeDUrWTFVZG42TXJ2YWRVVUtLdDVXMDRj?=
 =?utf-8?B?bHR1N1lFc0NOUXlsQ0tiaTVvUmRGdmZHSTJHU3MyRko4T3ZPT2YzVktTOHZo?=
 =?utf-8?B?UVhwVXpkQmZBZ0o4NWZtQWlrSlpYeU1lbXJjT0lCR0puWnhjeHdEVW8rUEps?=
 =?utf-8?Q?crgoISDcUl4dpm91iQVkvzYsM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b731559b-ee62-48d1-86f5-08dc28871f72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:19:59.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NUT5g6P4Yk+bXwlf9rvJYBg9wqXPIPrH+Fr06pj1WMDdoZvyWbkTq2ojM6I6jK/k/aD8zKHMfIOIR/hYYyKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com



On 2024/2/8 16:28, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 8, 2024 4:23 PM
>>
>>   static void intel_nested_domain_free(struct iommu_domain *domain)
>>   {
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct dmar_domain *s2_domain = dmar_domain->s2_domain;
>> +
>> +	spin_lock(&s2_domain->s1_lock);
>> +	list_del(&dmar_domain->s2_link);
>> +	spin_unlock(&s2_domain->s1_lock);
>>   	kfree(to_dmar_domain(domain));
> 
> use 'dmar_domain'.

Oops. yes it is.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu

