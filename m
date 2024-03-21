Return-Path: <linux-kselftest+bounces-6460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F16885831
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD01F226CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AAC5821C;
	Thu, 21 Mar 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pw44NNZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B457867;
	Thu, 21 Mar 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020212; cv=fail; b=Su5tf4ERV68+J1AZ767tw/+dnMSM+8HymqGCgiVuQkqTxfYUkNGR1wOeRjabpw/vzyWfnSHO7Q8zvmmLk6mD7CzuuhL+x9odLsa+4V7Ckqm2jBQm0YMHWuMjLe5DumTwnEZ9qGBMQ7IXEI97W5vgHlDQscOIq88mFr4q7qo297w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020212; c=relaxed/simple;
	bh=4E9hXhPdOFNdRgC4UX538e7QIcAI9tlWTKAaCc44g2s=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmP4yNBsozI3wS5f8l/DeSEH/jIzbOWh+eENQWoUOqAT4gpwwOzBC0T8d7FDhQOleadoa3wsGyMmfAm4CVSI5PAzaWQwSWSt4YIoOHPiX2OAn3RrC3Oim4eath5NpKrAaCo7qwBIQp0y5NPgi78iq0euR+HdmeQBGBWvLvkxToU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pw44NNZb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711020211; x=1742556211;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4E9hXhPdOFNdRgC4UX538e7QIcAI9tlWTKAaCc44g2s=;
  b=Pw44NNZbFzuMG2tua3rFgCYEsX8TSQAB2oLDfp6CISkv8rXGGP3bb39E
   CNsGU4pW1K7RV36fYrBXzloTmOcOh2kCGYqM6+oNGCke5uiQjoXPpCffb
   xWx5gfAe1AqUfTQSNW7rExUJ1KVmqHDO1mwFWWazoVK9VV6OcgsY9MDuF
   /BcTsH2cv3brY80fgXhqBcvElEIHi4e/YZr+XxvYzYkT4KXQKoi5RinVU
   v8b0qlZvaO5drccjnW2OyvM/eThBILGk1s/V57XHV07H2sUvaeFbObPTd
   RerI0kgINhz+0OxvwevTtQ4LFkdyFM03FWycvCDZ1fxo2grEZIFV0QB0v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16734234"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="16734234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="14477815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 04:23:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 04:23:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 04:23:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 04:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbt+kW9aXEsDjpTEidluZKU3+vFIl41Hr0JPuOjjxBBK0VA3YVQ9p3nSG6ySykY/EAjNxAfsXp6QZWZzSx/Z7mg+Mcs0w2+p03KGAotnPpPmnJ80TUpwKoOzg+3ArHnUA2lMDD9XI7yW5G99nukm+ZxA2Y6nyRO4SJzsoIazqZYVzxN9bBcRX86dRUGGRxk6sIMXFF9L/rich5MrDonGkErKCYWHMUBOZzAfSlw4+WSW7Pu36KDOS2Hqf3qRrgO3Ee3h71yc8yJ1YRef4Tj7iEFBWK4dPdiGLIJtBbCvuWbV3HkNpdNaDf51zgG13vpG50lh9gOD8NFgNojMp8uHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZO6jAKop416tNTsQJ9/u9R1AnrxQssaBKnMhiwGYF4=;
 b=KBHwOYkuoksDeB5+OQ+qXIQsg6eYbyWH1vxiRZohcPqnAigFAcA/c+8Xj9LUEaryLvF6kN/2zkOzvr8VzbBQ9cTwsCxQgP/iL9p7CgvXEub/i3lm1oE9NJ+GViVJ99jCr9VoXfRC+hvaBu3b3SGzaY+4HMO/sWSQoM5AvPm5esCwVBbytEgfgiRcDn8O9fpxuJN8AilhMlbIUQ78vid2T8xDD1crKNX7AArO46PqiNtDEbE1Ta6SMUutagEprHci0obBAYvQYRUmyz8EPLKyAtVLaF58ZfWnetVvOTzUJVpSfXnNSJTpphSxyUUEqvbo5v84k5UYUu4mRBAQahESbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 11:23:17 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 11:23:16 +0000
Message-ID: <7a4777dd-2359-4bcd-839e-c2d0b5f6be14@intel.com>
Date: Thu, 21 Mar 2024 19:26:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
 <20240318165247.GD5825@nvidia.com>
 <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
 <20240320123803.GD159172@nvidia.com>
 <65c517a9-72dc-4342-b2f2-c3c44735bfad@intel.com>
In-Reply-To: <65c517a9-72dc-4342-b2f2-c3c44735bfad@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: f59d8caa-a06e-45e6-fb22-08dc49994dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Y3TFheWJwwo4aNzozFglBFkCtXptxcVqUjXLQXH5thtnr1++oEMekrBGf7Al+0gY3FtKDJ28Nd/FMWjeAp4WLuT3nItr/XWzk74ItSQBWqponz0tr7tg3vZYxqFxC9ZnktO5TWVnzKWLFvMItfER1CTa84cqj82GY9t/TrdwNuSV/N+r53pQFmsHy8sPDTIR1gOupJwQhiggNQJxEEThGcA+0AzH2vhDTjl2FGHQO4XsKhujSXKuWpNNO4eNfcISPI+0YJvGW2O78pGAFsDyNoxBz+xpapyGGwCEqeqrw9uL6CjM7L7jUF9gVL6ukSiOWR3ELdsaeZbQlr/SIZfPy8Y8rwIk7P7HqvwOnAPzeq6PQX9GFdHMnvLA+Q2iGuY16VBGHglVndiNHxTq3J7iFbS3fGllcofARWVSES7P5CCKmSJKrpkNNFml+kLtxFIbGwWcMVPZI6f/6usc20tZY2C4TyXVaal/QDKRjOh32H4VSd3wcV3IP3VCoAta+HMaylOy6gWf9KCCgGWXEfxhPJZBZkUfKSKrrFlSDyp2TzAEAfkr0JhiCjrjqm4iu/Qlvuq7PFhjRXA5EANNgdk7RqUzw+4Z8UFjFtPReawqigT4vodqGjeYnpcNLC5cA7m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlEbzF6WW14WlVwWDZIME9IMWRzS3BCM0NpdGFOOUdERUhkQXU0Z1lWSzBr?=
 =?utf-8?B?Z3NqalJmVGRheUhVdHhWREZmSHR3a0JtTFNJVE5HcDJZL1FudUFiZGs2LzFL?=
 =?utf-8?B?R2d0dHE5ZzFXYlhMY3hGZm9XRjVvL2RTYW1CbHo2MnZPOElkZEpOZGRKNElG?=
 =?utf-8?B?eG1jeEI1b2E2WUdqMlJ2SE1SY29td2RkaDRjOUh0ZVZCTEswYStSVkNTOHZa?=
 =?utf-8?B?R1F0b1FXeFhwZGNKV3FIcE5jUllNbUlTcmNKU0hPZ2NvcFd5OE43WnRQWjU3?=
 =?utf-8?B?OExmSGdzZHluUldKMGtaWlNIWHFkd0hLNFE0VmRkRHlsMGhiYXhzVnQzbUR5?=
 =?utf-8?B?Rnh3MHdpYWtmOW4xMmJiSUgrLzZSYkl2WDB0ZjNwb1JRc1NHY1Nud0MyQmNr?=
 =?utf-8?B?Ky90UDZwZHdMRjQ0MUZYd2hZWnluM1FrMTF6T213RXVxNjdHaXBvdi83aGVY?=
 =?utf-8?B?SldLTEVBTlRwTFBiVXV1emZUQk5UMmx4bFErSmQwczA3TTYzOFNUQ3Y3dFpj?=
 =?utf-8?B?dnNyeU9Hc1J5a0RBcXpReEp5Q2d6SFViNlBjYVhVazFQL0N5eEtKQkxFdGpi?=
 =?utf-8?B?RVRRay85NncxV2VWYjJPYlU4ZTRBMWFKMElaS1lHUk50RUNPYUhXazR3bXho?=
 =?utf-8?B?eTRSU0dsdWZUUVViQXRmRWdRRmRzN0hBQUVFcjRCQS9IMTVrdUFyUStKb0cy?=
 =?utf-8?B?cUhJdXJkWGJxVUV2WGxOTGQ5c1VUNUJEaHBpOXpNYjFBS0hod0FLck9ERDVk?=
 =?utf-8?B?ODJaOFFCWUxWNVZKUXZLUFBldjc3NWdPVnhSQ0tUNTVtNjRFZmVJRmZjTE1C?=
 =?utf-8?B?OGZZazJjY1hpRzlyRXI3VjREaGlDM2VhVHZUSHg2Lzl3K2F3SjV3Vm8zcDI1?=
 =?utf-8?B?cU5TTEJsTGk4eE9ERzZRM3RmQlNDQnF1MUpLL0tIWVErd3RKam1tWWx6S0dJ?=
 =?utf-8?B?UHhhelJSRnFXVXRZUC80S2szQUNTTVpuZ3EvSEhJQVVmZW1yVElHU21pdElq?=
 =?utf-8?B?MUl5S0hTeUx0QUN2Rk1kbDRuSGZGMStZTzNCZnhZWXdhZjlrQmJ4N05SaWRz?=
 =?utf-8?B?V0FqMjNhQUZxbWQ2dDJ4cHlPZUFycUt6Q1hBR201bGhWUVVXKzhnTEZwZWtN?=
 =?utf-8?B?dERsbXhWanRrWTZtSjc2cUNVdVZUbHhMZG9MVjVYY0pBZHpwUmRSYlhGRW5P?=
 =?utf-8?B?Z09JMGpQMUh6VUY4dVlBelQyM1NKcTRVbTROdVkxb1l1MzRIRjRDcFFvUkF6?=
 =?utf-8?B?SlRUOURpN05MMEI1VDFENldrazNWUCtib2M4bHk4eWVJYkY2d1QrY2czVVRv?=
 =?utf-8?B?YnVLTDlRREpQUlU2MVYrYi9vd1hoRXhHZHZtcFpoUGZ2T24zaVdTeVk1aU0y?=
 =?utf-8?B?ZzJvOVdsNEs0ekR1S3Q0QkRHUW1OZ3MzMXhSdVk0clNtWGgwOVU5cGFuaU5O?=
 =?utf-8?B?NDIwY0lVMmI2MFdoYjlPcXdjNXpCRG5Bdmt3TEM4Yk5RMWppWTMxUWtDVWUr?=
 =?utf-8?B?dUZiZ3k5TnBtaTg4Mlhsdis4MjdvNk9oNmtFZnZreW5qajRuNU50MXV5ajNS?=
 =?utf-8?B?NHdZbHFyM2VBRkF4K2lCK1BHT3BLZnpUQjBxMFQrR2cxTTYxMmZLWWpaZk95?=
 =?utf-8?B?NFdvdE9ZVkpQdUZzUXVWdlhzM2YvbkNyVUlSRFRMdFdLc1QxbWFsdC91UDMr?=
 =?utf-8?B?a1ZIVnIrTGhGalVQYXJLeFFEWGJLeFpTWWE5Z2MyRUt2V25QZnkvcytRZGor?=
 =?utf-8?B?cG9LRndZN3JBWTFEU2lZWWh1VHVqb1Y3a0tmVUtCemwzaHRVNlNoRkN1WDg3?=
 =?utf-8?B?SlQ4QlJqUldiVmZTejZBQXp1WnpwaC94VWRyNjl1cVNCMFl1dEdlVmhrOTR3?=
 =?utf-8?B?OTZ2N0ZZdnZkRmlWakhScDVYL0oxb1pNWm5sYkhESitNRENCS01saU03WUdm?=
 =?utf-8?B?WjlRa29HZXdPNVU4d1BjZmthREJ5dGRtL3VXVUxlRGVyMlJVbkhmVlhMZUs1?=
 =?utf-8?B?dk1DbXE4TmJtUzVnQWNpcStUU2N5eW9sN1N1anBlelFhMGd4WUxKSzhsbkVC?=
 =?utf-8?B?bHF1aDE3a2hmWk5DNFJKSW9yODE1SkZLMGdNV0c3Wm9FTndoRGxqVEVEYndJ?=
 =?utf-8?Q?sVnbaygoBktEcA5WFJZ4N7CLO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f59d8caa-a06e-45e6-fb22-08dc49994dca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 11:23:16.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHj5eAQEWaT/g43vfu+irkX728v9g+xYv19gHiLzloFvn5D7+4eEI8HXPmBGeivDiYA0lgBOJFms0v/nX6lKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com

On 2024/3/21 14:16, Yi Liu wrote:
> On 2024/3/20 20:38, Jason Gunthorpe wrote:
>> On Tue, Mar 19, 2024 at 03:29:39PM +0800, Yi Liu wrote:
>>> On 2024/3/19 00:52, Jason Gunthorpe wrote:
>>>> On Wed, Mar 13, 2024 at 04:11:41PM +0800, Yi Liu wrote:
>>>>
>>>>> yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback
>>>>> and pasid_array update is under the group->lock, so update it should be
>>>>> fine to adjust the order to update pasid_array after set_dev_pasid 
>>>>> returns.
>>>>
>>>> Yes, it makes some sense
>>>>
>>>> But, also I would like it very much if we just have the core pass in
>>>> the actual old domain as a an addition function argument.
>>>
>>> ok, this works too. For normal attach, just pass in a NULL old domain.
>>>
>>>> I think we have some small mistakes in multi-device group error
>>>> unwinding for remove because the global xarray can't isn't actually
>>>> going to be correct in all scenarios.
>>>
>>> do you mean the __iommu_remove_group_pasid() call in the below function?
>>> Currently, it is called when __iommu_set_group_pasid() failed. However,
>>> __iommu_set_group_pasid() may need to do remove itself when error happens,
>>> so the helper can be more self-contained. Or you mean something else?
>>
>> Yes..
>>
>>> int iommu_attach_device_pasid(struct iommu_domain *domain,
>>>                   struct device *dev, ioasid_t pasid)
>>> {
>>>     /* Caller must be a probed driver on dev */
>>>     struct iommu_group *group = dev->iommu_group;
>>>     void *curr;
>>>     int ret;
>>>
>>>     if (!domain->ops->set_dev_pasid)
>>>         return -EOPNOTSUPP;
>>>
>>>     if (!group)
>>>         return -ENODEV;
>>>
>>>     if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>>>         return -EINVAL;
>>>
>>>     mutex_lock(&group->mutex);
>>>     curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
>>> GFP_KERNEL);
>>>     if (curr) {
>>>         ret = xa_err(curr) ? : -EBUSY;
>>>         goto out_unlock;
>>>     }
>>>
>>>     ret = __iommu_set_group_pasid(domain, group, pasid);
>>
>> So here we have the xa set to the new domain
> 
> aha, yes. The underlying driver won't be able to get the correct domain
> in the remove_dev_pasid callback.
> 
>>>     if (ret) {
>>>         __iommu_remove_group_pasid(group, pasid);
>>
>> And here we still have it set to the new domain even though some of
>> the devices within the group failed to attach. The logic needs to be
>> more like the main domain attach path where iterate and then undo only
>> what we did
> 
> yes, the correct way is to undo what have been done before the fail
> device. However, I somehow remember that pasid capability is only
> available when the group is singleton. So iterate all devices of the
> devices just means one device in fact. If this is true, then the
> current code is fine although a bit confusing.
> 
>> And the whole thing is easier to reason about if an input argument
>> specifies the current attached domain instead of having the driver
>> read it from the xarray.
> 
> yep, will correct it as a fix patch.

Hi Jason,

It appears there are two solutions here.

First, only undo the devices that have set_dev_pasid successfully in
the __iommu_set_group_pasid(), so the problematic
__iommu_remove_group_pasid() call at line 3378 [1] would go away.
This also makes the helper more self-contained. Draft patch in [2]

Second, pass in the domain to remove_dev_pasid(). Draft patch in [3]

Either of the above two should be able to solve the mistake you mentioned.
BTW. They are orthogonal, so it's also possible to apply both of them.
Which one is your preference then?

[1] 
https://github.com/torvalds/linux/blob/b3603fcb79b1036acae10602bffc4855a4b9af80/drivers/iommu/iommu.c#L3378
[2] 
https://github.com/yiliu1765/iommufd/commit/bb83270767ab460978a3452750f5e032b43e59bf
[3] 
https://github.com/yiliu1765/iommufd/commit/bd270b7b6619b8ba35dfaf9870df8728e370163f

Regards,
Yi Liu


