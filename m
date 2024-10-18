Return-Path: <linux-kselftest+bounces-20105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7ED9A345D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 07:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE11F23463
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA617B50A;
	Fri, 18 Oct 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ+4zonF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F040176AC5;
	Fri, 18 Oct 2024 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229747; cv=fail; b=VyKoNcE92/vvURe86+zKHpnm8DcfkcdVYMPx4ninAZUfJodw1IkhwSCAue25F1njoNuvGblR+yFuZ5XQaM+MegFMaCNMenX+0Lv0HQatpGcS3x6grmJCxXHibB5KjX0AsHQuq5WMampR50Npj6RBF4XnTsYZCwysU39xRpkn7sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229747; c=relaxed/simple;
	bh=/BC7ZAeCHiW1XjXDz9aIWiF/ROAs+6LfO49lgYk4lWk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJyAEaOQWH/ca+paOO23RfoOhFVwBwnnfPrjgO6lhpFP93ES6Oti7z7HGGPKVCe0ZLL/hlYMHPmuh1Tno35TtApJNk30YLeS9JCkqNFKKcS0g6X8964ZYlDO5fSgxnIP5zoaEhtRolUJrWNi0U4HWZQ8GLzZ9PNPTUuK2kQ1CP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ+4zonF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729229745; x=1760765745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/BC7ZAeCHiW1XjXDz9aIWiF/ROAs+6LfO49lgYk4lWk=;
  b=dZ+4zonFR1wmG3ZTNCNwD8a7wKaqneMhVbTuY4xxSPwxnZcyfP9+vLwa
   rQMbp19FJzinqb9rIFx3gOu6U7RTYrvTkRhpuVixnLRYhgg0UYeB6Q4yb
   k3mSUEYnCsLa4tI5uzy1gKq1xolgLj9tIg16DtzcUyZKu5aYIK/2YIWK7
   x5TgKru3T8pvi+jKeUcbfkpm/EZXP74xelCuOGYrc96P7rhbx/SHDfT47
   L/oBsvkkLiACiI1UW6YZlpt4dXkrmVTT3kQZ+JTICJWany/R0VO8PKuA1
   1RVQE+kP3rkcy2rVsLcxsD1xB1VReqWYziB4hpgtvGJzfxh1JVR7vmK08
   g==;
X-CSE-ConnectionGUID: KYLnFwBoRKGlgymwLzZaXg==
X-CSE-MsgGUID: 97fABitBSfm8lzNKr+DaHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39289018"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39289018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:35:43 -0700
X-CSE-ConnectionGUID: PoLB64zJTPCKx/bh/Qf5xA==
X-CSE-MsgGUID: WIJlBuLAR1asQfQS7afDzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="102067510"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 22:35:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 22:35:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 22:35:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 22:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZLzV52WTZxVrU3LkfAIpOfn+l2zv6domleFq98+XFxAS8rWeiCTZwcek6rsRvNA3zHP7qugxQRwbTLqUScfJThEM/d8WXQtQ4db4+IhHuuCq9fSo+UO99iJuHUwMnalecX5zOf2wLHvFPGRvOBkTAsJGquK4PdRtZpd27hPL+lQJmI/C1IE+oQppOPZKXjY/nve3ynsNw0sTna8BDQd5V+jap11el7HqqTD2munAriKYnrJJjRBGjnqzkZwAdZNdq77GI7vdIwdVXvJ1JGfHupXj7OcsNC3ZwdxeJwjjvBjmanWCI8Ku+5+m5r0mM+8/rQCc2v6CZVIeueBjkfk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIFHAouLHDL2ySB2eflIUho/z0oGHZDtoSxdiSmpCP0=;
 b=g86GV82FU5Hg0SsXp+02aHo4vYqijPWZoy3XF2uLrqpZA7BhJwxsQZHim8RIfU2hVZgnvYAJF31a0aa0SMYQbhTTBywApSHgMhLapMsIkSFJws2hz56Esm4jAseV41eka66OJK9I2uXmE9novi0eguJiuY/UzgcLD4WMqUszoV/0mO2ERlvFJwsXvVGZhYOohR8geFjQpJ0GK+dUyhT2mpO55DprDMwZY4MdDzc6cKHz1KF70I9P2I9WZOAdQHtknod0cH7adiMuZWb2FD0qNBVNzPYE9NXmuzrFD7p/0jDxi4C18cxWQAU3pr8HNvTNk8MT11oN4vK4kqaSDTbnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 05:35:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 05:35:38 +0000
Message-ID: <7f95f2cc-6691-4f40-bc50-e4430ebdbf1e@intel.com>
Date: Fri, 18 Oct 2024 13:40:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
 <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241001121126.GC1365916@nvidia.com>
 <a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
 <20241014094911.46fba20e.alex.williamson@redhat.com>
 <2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
 <20241015102215.05cd16c7.alex.williamson@redhat.com>
 <e76e4dec-f4d7-4a69-a670-88a2f4e10dd7@intel.com>
 <20241016101134.0e13f7d7.alex.williamson@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241016101134.0e13f7d7.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 663056b4-abe8-40b1-01fa-08dcef36b264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek96MTdmZmhSek5iY04rclJYUEhmRUZoNmQ5eGcrY2xhNnd2ZEsrcVkzWEtE?=
 =?utf-8?B?aDdoQTh5cDZyR2wxQ05JOXdIT0ROTWExVkF6dEdMRm9RUEI0dlIveHVuUWJ3?=
 =?utf-8?B?RnpUdzZ2eUtCak1aVExLR2F2Z21UenM1ZVgvSFdDUU9ha09tdWJqZTF3aUtU?=
 =?utf-8?B?YXJBSFVpWWJwL2pQeHhCYUN0cjhwSVd1b0Z5bnptcGZNcHM0RjhXSVBjOWRV?=
 =?utf-8?B?YkJ1WDNMTFJHUEpNVEl1K280OXg4TXA3bjVPakFTRFZibWo4Vko1MXFVSVJV?=
 =?utf-8?B?dWgvYmhpVUUrY2hFdHhVeWZhZE10S0hxejhBUGdvd25GZFRuVzBSYUZFd25o?=
 =?utf-8?B?WC9hbTh6eVlHdk14VlBUWjFIa1IxdEFKSVdEdUdITGhad3ZFUDMrK2FKTkpj?=
 =?utf-8?B?TXIyU3lxNW9PSFRUZldDSWNyRGZXYWQvZXlrZjRTWkVKb2JwdlVWWEZpYkY4?=
 =?utf-8?B?UTFScU9rd014MytnNU5jZ3hWU2JBdG5JeXcveC96bGFzV0Y5akpSMGVkbWJ4?=
 =?utf-8?B?ZUVnQm9BdEEwdjVFQUtvMXI5UnNWWlVzSHMycXBZTS9STjRHNUpPWFhuS2hK?=
 =?utf-8?B?WnBCVlRrR0hXSE5OWjFmYWZFSUhHcE1rSUNYdmxuWkRET00yc3U5Z3N0VDVh?=
 =?utf-8?B?dEtqNHIycGVYdWcyWDkvOWdKQWxpKzA0TUp5aEpLMzdCRzFUcko5RGxpTmtO?=
 =?utf-8?B?Q3FucHQxWlJMZFdlQ2FYWXVwT2k1MTh6cStxeElMT0JTM3FvT0crbWhVSGVJ?=
 =?utf-8?B?WENOcnR3aGdkTFVJMlVhSjh0MUZTc3ZES1ZsUlQ3QXVPS0V1ZU14OHhUQ29D?=
 =?utf-8?B?RnBEbmpFZjdPS0hwd3dSdS92KzJ6ZEdIZWE1bkV4c0txbG9yNTMwZndKNWNJ?=
 =?utf-8?B?Z1VmMFNtQ2pKckJiT0VXeEc4SVk5VVQydzU5OHp0Rlc0Q3lrWVRoS0J3RVdz?=
 =?utf-8?B?amIvUzczYVBBajhjNjF0SExZUUFYcmxpVXlaWEVtYTYxTFNoQlFBKzlBZ0s3?=
 =?utf-8?B?M09EckxPSVBLR3pXdGlrTFBhWmpNd0IvVml6K1VVKzJZOVQzS3pYYXIrY29Y?=
 =?utf-8?B?RzNIU3NIQVdYRjdaOXBVZXlTWW5ERGQvNWlGZ3ViMDRlaXJCOEJDd1VxV2tC?=
 =?utf-8?B?bXI1cEJCbzQxMVBUeEVaZTd4c0Q3ZTNVQ0JUVnRhblg1ckIxZzlWbm91SHVY?=
 =?utf-8?B?TEl3STNiblFmczVzaDBwdXd4N1hhWkp0THJGVUpUdlppdUY1eGY1bkxmU3BU?=
 =?utf-8?B?OUJYV0tPZGhRWUd5ZjhneEVyNkZxQ21odWtUSUR0dlFDTlBtaGhNZkRWM29U?=
 =?utf-8?B?T3hiUUZxOE9ORGFHUlJ2V09PbStQRDZjTVdwOW02T3JMYkdtMHJIeFZMNjNB?=
 =?utf-8?B?QWpLWEttLzRyOGdENENWSUJmYlJMM3plL1l5VzV5SXh0U1NsZnJsL0xxaVpL?=
 =?utf-8?B?bGg2dVdGUEdWQ1pwWFJzdFZCR0dFRGgxajJnUjg3TTdpN1dhTVhGcUxIWkJa?=
 =?utf-8?B?VTMydGhIWlN0Tm5zaEZZQkNDN3MzaFZhNGVZL2tqek1RQ092MmFETVkyaXg3?=
 =?utf-8?B?c0FtWGRWQXprWGVUUjZPVzNuY0laYllhTURJbkZjZnQzTnZtaUl3VW9WRFBu?=
 =?utf-8?B?Mjd2UVdFbU5NZmVtQS9iOCszMWNDOGUzaVFkVHNKWnJTaVRwRm4xZ3o4YlpR?=
 =?utf-8?B?dER0SVhWWkgyVm94M1FqajVPczhha0FzVEZaL0NEN25nWHJDbGNNQ25zUjVl?=
 =?utf-8?Q?Z3YDdt8wxqXH8sSltE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJyakZTMHJlWmNvYlNVYXVMTXptTmw0Q3NNNDRuKys3YmNHVlBuZSsrUjJ3?=
 =?utf-8?B?eXhtVlhPOGZudnlldGZVY1FDVFZMSGZLazRtOVlzNDhObmtMMHpzS2NLamlZ?=
 =?utf-8?B?ZjN3by9sS1ZnQVgySE5PVVp4RWlPZWp3b0JuaXlNbENRdTBBUkh4RHNWN0VD?=
 =?utf-8?B?dVBleWNuRjVRWnhMN1gxdUE1U0ppMVZGY0VFWGhhRUNCZnY1Vk0vVFBEdVV0?=
 =?utf-8?B?STNwNVVoLzZqWkhUeEJoaWJqL2lKSEd1VVpwbjI5YkxXMnlkcHErWWh2cEZq?=
 =?utf-8?B?M0Y3MkhVcVowSXhXTDhNcUsxL1dnYU03NldYdElCaGIyNUxLT0xMZ0hzQmdi?=
 =?utf-8?B?bkE5bVZKMTVwZFZUWVArMS84c2psaXc0NnpFVVZtdjQ1V1ZWYkJoT0ZhS05l?=
 =?utf-8?B?azZNdGRFVHpFMmtIRmdCNGp2U2xINFo0Y3VKckZrY1pJeFY2UUM3VHFXN25j?=
 =?utf-8?B?aW50UmxOWHF0clZuY0VhODBjMFdRTmdJYUxtL0FxYXN6VVFWZmNjZ1JhZWVL?=
 =?utf-8?B?UWRoTVZtQTZKb0ZuRWMzd0RMLzd3K2lXVHdOWmRybUZhaHE2WitzVms5OTZu?=
 =?utf-8?B?RTFpTjFuMVVUN2V6LzgvYU5Id3R5WW44ZGxkWlQ3dHIrdGVYaHh0QnJRbkNq?=
 =?utf-8?B?MTRXZ0hJMURWSFVWYkNOWmI3UWp0c1dZOXo3WCs3dFBJeC85TmhUWnN2LytJ?=
 =?utf-8?B?M0VMMHdaeG0rUjFoV3hGR1kxZHJhMDh0L2VEWjV0OVprdXdhNGIvYitCVldE?=
 =?utf-8?B?dlQyN3I4c3M4Zk5wVURDaHBSZmQ3eGlER2x5S0ovWDAxdkZhdFU0bC9sTTJC?=
 =?utf-8?B?cUtCREJVZzhoZUZ4MTRaQXdiV1g4SVZVZFdrTUZncEYvaEptTXFYUkdOZDNN?=
 =?utf-8?B?SHRXRExLWlMxOVNjM0RFNnIxWU5JcVdaQmhNWVNNOHhXWlBFYy85eEtsZkFn?=
 =?utf-8?B?QU9pMHIzaFk0UTR1S0p1b1ozMDY5Ym13d3NpajRmWVd6eXdDcENKUDZudzdP?=
 =?utf-8?B?ZGhvdFNEOUt1VWJwUmpTTmkzSFJTeVRJdlBkUFJHT3RFTE5xZjhKTXVNZzJr?=
 =?utf-8?B?aGdpOGwyVVQ3QUZydUFyWUk5Ti9hTUQ3aXNESUgvSW5YdnZ5WGI3UU9LOEZX?=
 =?utf-8?B?clpNVFdSc0lRQVl2UFNRMmJMUllhMHMyWEprSVN3T2ZKRlhIb0x2cUNDNUNT?=
 =?utf-8?B?NzVXTnljUlErNjhlcENUbE5NVEd2Y3I1dXE1NGtTbSttcWt6VDNkek9oT2tJ?=
 =?utf-8?B?YmVRam5NclhtVklSZWhEc1JyRXBPMEVwTjZDMGM2VlVSZzdYMDZQdkRTWG1X?=
 =?utf-8?B?cnJtREM3T2hOaUQwbnJBNk9Vd2VHdnJQOW9paHNOcjF1aEo0V3UzVU04SGZK?=
 =?utf-8?B?cG9IYXBYendvN2dJd0xvWHJsdzEzcVpOSmtPclhNU1p4SDd1N2dnbVJWRXQv?=
 =?utf-8?B?K21DVldTaWlBL0VGK0Q5WHZrM0FIOHZxQ0YrNVJQa2wrUHlnZFh4WFQrUGt4?=
 =?utf-8?B?VFFBUzZqcHFtQ0hndWduQUxsV3NZWEw3a25mcXphWURxeWhuMTZSUVg5VEtp?=
 =?utf-8?B?bXNhN2t6TGFLbG8xa0JYc01jb3ZBei9iaWlMb2JLbkVSUVp2cjdLdFdNVHlY?=
 =?utf-8?B?MzFNTDVTTEVTV054WEJBZFRnTjFRWTFlZFdhbmdkRC9MTjN3ZzRGRTF3RzFL?=
 =?utf-8?B?bkZ6dTJSdXYxV3VIS0ppVEQyWXhCM0VsS096YUF3MGhjdDNqZmc2ZzhEeGhO?=
 =?utf-8?B?eEhWdUZ4c0RCenRsRWpEbXl3Y0N0NHVrYzVENjJVZmtFMHA2dGtZcFhKZTVC?=
 =?utf-8?B?OFB3ZVUzdW1sV0tkTnd6NFRNOHBlZDBrc3ZKQnN6Z3puY0VKandQc0EyYjZp?=
 =?utf-8?B?czdCRmIrVVJmWG5DSHo3M2dBOUFjdy9TaTluNnA1Q2FPb2FuMkhjakpLZTVY?=
 =?utf-8?B?MTAySFN3bE1SRUR6WVR5L1MrSm1YRnYyS3V5eVNjK2ZnSG13RTkvMjl0djA0?=
 =?utf-8?B?QWNRcUMvMDg3cVNWKzFmTVd0bHlhcFg3eElINm8yVTZPU3psNmpEV2laQ0Fr?=
 =?utf-8?B?dmIzeGdHK1ZWRlg0MmkvTEs1alJja3VSTjQraGZUdWRNNTNpRVpoMW1vUHJI?=
 =?utf-8?Q?Iz3xNeAUysPHsiXOL18gfeEjv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 663056b4-abe8-40b1-01fa-08dcef36b264
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 05:35:38.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4xl/+wwJQHJa9hxhO0suDlGvGBDaJ0ldFkMNplhjxruPPhmDlSKUWHfZe2E9NVlWZ8kEC7Kk8/oJXCN+X3LqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com

On 2024/10/17 00:11, Alex Williamson wrote:
> On Wed, 16 Oct 2024 11:35:05 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 2024/10/16 00:22, Alex Williamson wrote:
>>> On Tue, 15 Oct 2024 19:07:52 +0800
>>> Yi Liu <yi.l.liu@intel.com> wrote:
>>>    
>>>> On 2024/10/14 23:49, Alex Williamson wrote:
>>>>> On Sat, 12 Oct 2024 21:49:05 +0800
>>>>> Yi Liu <yi.l.liu@intel.com> wrote:
>>>>>       
>>>>>> On 2024/10/1 20:11, Jason Gunthorpe wrote:
>>>>>>> On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
>>>>>>>          
>>>>>>>>> +struct vfio_device_pasid_attach_iommufd_pt {
>>>>>>>>> +	__u32	argsz;
>>>>>>>>> +	__u32	flags;
>>>>>>>>> +	__u32	pasid;
>>>>>>>>> +	__u32	pt_id;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
>>>>>>>>> VFIO_BASE + 21)
>>>>>>>>
>>>>>>>> Not sure whether this was discussed before. Does it make sense
>>>>>>>> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
>>>>>>>> by introducing a new pasid field and a new flag bit?
>>>>>>>
>>>>>>> Maybe? I don't have a strong feeling either way.
>>>>>>>
>>>>>>> There is somewhat less code if you reuse the ioctl at least
>>>>>>
>>>>>> I had a rough memory that I was suggested to add a separate ioctl for
>>>>>> PASID. Let's see Alex's opinion.
>>>>>
>>>>> I don't recall any previous arguments for separate ioctls, but it seems
>>>>> to make a lot of sense to me to extend the existing ioctls with a flag
>>>>> to indicate pasid cscope and id.  Thanks,
>>>>
>>>> thanks for the confirmation. How about the below?
>>>>
>>>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>>>> index bb1817bd4ff3..c78533bce3c6 100644
>>>> --- a/drivers/vfio/device_cdev.c
>>>> +++ b/drivers/vfio/device_cdev.c
>>>> @@ -162,21 +162,34 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
>>>>     int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>>>>     			    struct vfio_device_attach_iommufd_pt __user *arg)
>>>>     {
>>>> -	struct vfio_device *device = df->device;
>>>> +	unsigned long minsz = offsetofend(
>>>> +			struct vfio_device_attach_iommufd_pt, pt_id);
>>>>     	struct vfio_device_attach_iommufd_pt attach;
>>>> -	unsigned long minsz;
>>>> +	struct vfio_device *device = df->device;
>>>> +	u32 user_size;
>>>>     	int ret;
>>>>
>>>> -	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
>>>> +	ret = get_user(user_size, (u32 __user *)arg);
>>>> +	if (ret)
>>>> +		return ret;
>>>>
>>>> -	if (copy_from_user(&attach, arg, minsz))
>>>> -		return -EFAULT;
>>>> +	ret = copy_struct_from_user(&attach, sizeof(attach), arg, user_size);
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>> I think this could break current users.
>>
>> not quite get here. My understanding is as the below:
>>
>> If the current user (compiled with the existing uapi struct), it will
>> provide less data that the new kernel knows. The copy_struct_from_user()
>> would zero the trailing bytes. And such user won't set the new flag, so
>> it should be fine.
> 
> You're making an assumption that the user is passing exactly the
> existing struct size as argsz, which is not a requirement.  The user
> could allocate a buffer page, argsz might be 4K.

I see. If the argsz is far larger than the existing struct size, it might
be large than the size of the new struct as well. Then the trailing bytes
would result in failure which does not fail with old user and old kernel.

>> So to me, the trailing bytes concern comes when user is compiled with the
>> new uapi struct but running on an eld kernel (say <= 6.12).But the eld
>> kernel uses copy_from_user(), so even there is non-zero trailing bytes in
>> the user buffer, the eld kernel just ignores them. So this seems not an
>> issue to me so far.
> 
> That's new userspace, old kernel.  I'm referencing an issue with old
> userspace, new kernel, where old userspace has no requirement that
> argsz is exactly the structure size, nor that the trailing bytes from
> the structure size to argsz are zero'd.

got it.

>>> For better or worse, we don't
>>> currently have any requirements for the remainder of the user buffer,
>>> whereas copy_struct_from_user() returns an error for non-zero trailing
>>> bytes.
>>
>> This seems to be a general requirement when using copy_struct_from_user().
>> User needs to zero the fields that it does not intend to use. If there is
>> no such requirement for user, then the trailing bytes can be a concern in
>> the future but not this time as the existing kernel uses copy_from_user().
> 
> Exactly, the current implementation makes no requirement on trailing
> non-zero bytes, copy_struct_from_user() does.

got it.

>>> I think we need to monotonically increase the structure size,
>>> but maybe something more like below, using flags.  The expectation
>>> would be that if we add another flag that extends the structure, we'd
>>> test that flag after PASID and clobber xend to a new value further into
>>> the new structure.  We'd also add that flag to the flags mask, but we'd
>>> share the copy code.
>>
>> agree, this share code might be needed for other path as well. Some macros
>> I guess.
>>
>>>
>>> 	if (attach.argsz < minsz)
>>> 		return -EINVAL;
>>>
>>> 	if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
>>> 		return -EINVAL;
>>>
>>> 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>>> 		xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
>>>
>>> 	if (xend) {
>>> 		if (attach.argsz < xend)
>>> 			return -EINVAL;
>>> 	
>>> 		if (copy_from_user((void *)&attach + minsz,
>>> 				    (void __user *)arg + minsz, xend - minsz))
>>> 			return -EFAULT;
>>> 	}
>>
>> I think it might need to zero the trailing bytes if the user does not set
>> the extended flag. is it?
> 
> We could zero initialize the attach structure for safety, but the kernel
> side code should also be driven by flags.  We should never look at a
> field beyond the base structure that isn't indicated by flags and copied
> from the user.

yes, zeroing the trailing bytes is for safety, and all the new fields
should be indicated by flags.

>>> Maybe there are still more elegant options available.
>>>
>>> We also generally try to label flags with FLAGS in the name, but it
>>> does get rather unwieldy, so I'm open to suggestions.  Thanks,
>>
>> There is already examples that new field added to a kernel-to-user uapi
>> struct like the vfio_region_info::cap_offset and
>> vfio_device_info::cap_offset. But it might be a little bit different
>> with the case we face here as it's user-to-kernel struct. It's a time for
>> you to set a rule for such extensions. :)
> 
> That's a returned structure, so it's a bit different, but the same
> philosophy, we don't break userspace.  In that case we used argsz as an
> output field and flags to indicate there are capabilities.  Old
> userspace ignores the flag and argsz semantics and continues to work.
> New userspace checks the flag, reallocs the buffer with argsz and
> retries.  This is however an example of userspace providing an argsz
> value that exceeds the ioctl structure, with no requirement to zero the
> buffer, though it is an output structure rather than the input
> structure here.
> 
> I think the same holds here, our policy is to not break userspace.  We
> potentially do break userspace if we impose a requirement that the
> trailing buffer size must now be zero.  We have the flags field so that
> we don't need to blindly base the structure version on the size of the
> user buffer.  We should use the flags field to determine relevant and
> valid fields beyond the base structure without imposing new
> requirements to userspace.  Thanks,

got it. let me send another version.

-- 
Regards,
Yi Liu

