Return-Path: <linux-kselftest+bounces-6458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF194881C66
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 07:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6F21C20FEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3133A1C5;
	Thu, 21 Mar 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbVNGR5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0008F56;
	Thu, 21 Mar 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001604; cv=fail; b=YZRh5XaAah1PsXQNwZXGZO0JplY4c2XaHxorh0w6mS04+CJ+ekahgg5ylZjEe2+Id7l/hk55JIjqRDcYHJXYS0VC738e50Hzp+8jN/Dr59mKD4ax0yEfzOGGw26YIBo1/zesTZXvKXgwHjWcHy/rcnraYPrc2mbjyd0dM8I2LGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001604; c=relaxed/simple;
	bh=S4uHsnHWs3DBe60/SOVy9fL3np/B2533SmREQkCV8Tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTUI6XLGIJyPkqqJ61/fAhuajb2H/MSdYspPso6yyJ5mQf83L60BQiHs7svVwJRWGmzkpucgBw8RO2aEHHlzD8asmdwJI1GBHdaXr+lgalfy8pz8esPDH2MZ2gxLq58O8S7rEg/BigPAG5zqg+e46x3T8c5gSYBxSzLxB2mWkIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbVNGR5f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711001602; x=1742537602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S4uHsnHWs3DBe60/SOVy9fL3np/B2533SmREQkCV8Tg=;
  b=UbVNGR5fvQ1utfUDXE3TSi06YU3p9yy1H/zad51kBYeIaCiQCGkg+8WK
   V/AMTxqF/GzkwwWV8/WCR1vphShXd8ltbjlkQWHQusu7UNXOHJ0nQi/rX
   i90wPeF7vwuWYS6QsYmwim2R91j52n0rDOikidqOdCc53IEW0jMNLDH69
   gEcJPJLcsKjCiefNVT1nvtb245f6JNx3elkLVT1xSwfN9ujvP4/xAjP2z
   DIGUDImJf3VIComdyq8aZgyY+nI49CT1w7WBnYYPbPp0MyyttsS6Y3o97
   P+nA5RJZ0OXo3B4RYZVFA/G+S5Zns0w33jezeqTnqWg5CV6lCu27rzlJ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5835141"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="5835141"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 23:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="15042100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 23:13:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 23:13:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 23:13:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 23:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ+EkF+WFzSU5iRhYauABtM9F0D6AsPg5Po5jNNpAuRByAeZ9McZVsfSPUcDutZEWxsCE52BvmHNm1RIIpID0474gNNNc28nfWB0wPlSCCWJ2VQUpLPhvnja2fhSeP9KcNuazkHHjzkTXXy6av8mt0EusEoQF490wrMBQx2DixmgW8JWPzo7uhSSlE84uVJiU+kNOP4YnlMQaiBB6uBYmJ/pr3ZCd2dHEJDDleVNpWGyBoKY6X/1ViZGc/cY2LBYCTHFlQMtRWzNNSzayHCP/dI8ASCf+gBN3W6KbkeOHIA/OH7yaNKik4DcyDcxdJfKaNOJAXjUvwg71vGtOiJjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz7by7ZMKPxTKBCfpH5wUuN6hOd516+rJ8130A5IK18=;
 b=nV2LRc0LB2A3TTK+0D4oxpQhPuIev36Qu25abdktq9eykly/8Vdc8w2oHxLiCnLndccO4n8rofJwT85nph6jQvbNBRvXw3KKDRXqo6JeTznZBtDHIfmEb7o7clirotkfkuF1yn5vGJ/04iDd/iYPXkaOYEDw9QeuU5vUWb+SDhtuKBSyxmHSbNz5llIVF661Ym7+kWPXfr4UsABJJY33ilVkGfBEd23yBvx5AvojQMwTWA3ApQxAQm/NLwLYh4zmQZRmUMes4a5Ae2SDllh/KCANqDm2N+hpMrThSxjgMhz68oybFOiJOT53ZGrY0a0oRB4A3/xLKmggFf/USXLp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 06:13:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7409.009; Thu, 21 Mar 2024
 06:13:14 +0000
Message-ID: <65c517a9-72dc-4342-b2f2-c3c44735bfad@intel.com>
Date: Thu, 21 Mar 2024 14:16:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
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
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240320123803.GD159172@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: e71f77f9-c6a0-430e-3cd9-08dc496dfe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRmpdZ9RNqvpk2LXe56jxCUrc6QTn+AdQGYy88tKmkqDAK+25CWNonXQeVRfFf75M6+38YntwbSuodU1xqOOUKoblRXSE2yCZuUfwALHdDvchuLt83MMXPeESIL6yhentPCSElRXOTLLj7PwxAjnD3sz4SgAQz8DNFhkD6V03bs6BUyzLdHaC12ilN1KcBBxbjXUhwT5ME9ST2oY7AngMdX6t0F5eH1Tz0Ic1Ro4i26UBLjH3BjkbhLe3CJVIrfEEbJJVkSEysi4n+xPgx3gfUdMlEHrF8/Smz2pww7iCtB9lEjP9lPZY48Wc4UrCb7gvkYSMO9GGxfQSO/XIO6Nfi4DrQQINynhfp/+tiQ9demS9C1dqnvGwt2AA6fK/paBN0HVQEmm83P2N5MhiD1HjTQL8RdVMBEb2b4wPbMWHQ7CjGf72HA2Wz2J+Al4maG+gh41hsGpdCw10k2D05bRpWwN5NVXs+iOUpfP/XYcAKmw6+0156D+XeJvanbKg9o7hGcWAjssMS+pPfPXctnQ/ZEwnflvk/0E7K5oU6LMN6UY3toVofZgkIhSHv8FMh75naFqT9/CfFoMKFSlyk3IZYm1UyAiGqwPoOMbsBqqi4t8m8yuU/dpv1iqJ+AalzMmrb/5UvB0NDaaPkSyysYNZxN84heqGQeH8Ir0h5kkbVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lucjJMTWcyV0JSVDlkZHJLbk9VeTlwSTArajcwM0dHRG00TGlpbDRVajBr?=
 =?utf-8?B?Ykx0WHFEOEpOK0RvVE9VU2duTk9xN0dxNGJIaDREY3AxSWlXVlJ3QXo0RHVN?=
 =?utf-8?B?dHZVNGhLVlZyZHYwTDdLck1tS1doYUV2SmJFZi9VQVNsVEtUeG0vVnZjam1H?=
 =?utf-8?B?cCtud2d4OVcvdDNFanhQQ3Y1N0ZPQlNQa09BcVFCblhndjJRL1Q0Njl4eHJ4?=
 =?utf-8?B?TFNOd0d6OE9Wek1LRFRhODFNZWpTYlFsOStUTUowbDV3TUdsdnJXVWZ4bkNS?=
 =?utf-8?B?K01TaHMwdmNiRmRnd3pRNWpxQVl6eW5zWG5EaGUyVnk4MFpWQU5HRTV2a0py?=
 =?utf-8?B?d3dMZ1VyU3F5UWdBbW45KzFDUWoyUGJYUHVhdEc5aU1Sc1hlYzMwWTRVb2Np?=
 =?utf-8?B?MWFjaVlwTkZkMXhhVjl5UTVkaVY5azA3eEtwNVZJY09lL1hLNVJYZjhtM0Zk?=
 =?utf-8?B?QmFaZzhXVFBMb056UnRpQXcxc0ptYVV5d25nbUdLZDZzcE9DeEg5aWJOM3Nu?=
 =?utf-8?B?QVBoN3A4ZDJzQ0VyaFh5QldRWERDejM3a1VqVHNFVGJ6U0UyS2t5a05PdFJq?=
 =?utf-8?B?dUExUlAwVm03T0QwWTY3cGlPdzN6dG9VZEx3N2srSEY1a1hhZGVXWittYUNN?=
 =?utf-8?B?dWM5VVUrNmV2VFoya0QvY0lGdFNnaFByVm85d0lNaHhoU2cvT2M1RG5xc2hT?=
 =?utf-8?B?UDl4dC90R0xWRTRhL3F3eDZwbm1halpJZzUwblRZSHpOT092eWhqOHB5T2s4?=
 =?utf-8?B?SlAveUkvWGlRc2lqOS9FQk00VFdNbU5MakFiZm5tRXRZdUVja3ppNm1OcVFi?=
 =?utf-8?B?QWlxbzRPZ3UvUjJtcFBiTXdCNzlJRmRnNzZmRVlhUzd1ektFbVpIdVozZ0R5?=
 =?utf-8?B?cUtxMGpKUFFvcnBlczFwaGlSd3hoMFRDdmwvMm8vMHRKekhIeXhUcmtmU1lD?=
 =?utf-8?B?N1Q2MWRJSVNzbW1keHVBVTVJZExTMjNUMmlCMDBPdjh2Qkc2aVc4L2pIK2lX?=
 =?utf-8?B?OG9ieDV2R1Jqc3Q5a1dPSjZ4S1JPdmVuVXFlQ2xPZkZDdlFncVh1WmhJSWYy?=
 =?utf-8?B?bWMzZGZhZ0RIVUQ1bWRiazZhek5iYU90d241RUQ5Qjd1ZTRBSHBMVnZua2pl?=
 =?utf-8?B?VVhnYzlRaXJtdkpnK3dnbVF0WmxtZDYzdVBUMmcyUXJTenQxb20raE9GWGNE?=
 =?utf-8?B?c1cyVnZjaHEwV3Z2RXRaTHM3VC9ZWnVXNFNObEd0NE1yemx4UnNEVDdOUkh1?=
 =?utf-8?B?NHFTWnBRWktaejVtbU9pUXdMYnFKc1VSV0NSUE1ZR2ZSMnJMSTU3NzZXYmlp?=
 =?utf-8?B?L0NnSVRaMDB3dUdDMlF1TmdtNHNuRGlpWjh5UWdMTUk0OVU1QlBOQWlLM3Bh?=
 =?utf-8?B?alN5aUlpandtc3hVUm9qY0YyNWx4dlh4aXdNYkcrRHpOcFhtT2MzeDZMNzdj?=
 =?utf-8?B?dWdYS1dTWFA3akZTTkN6b3RDZno3SUh5YUVtK1FCaTJETkFRblRJcDVmUGVD?=
 =?utf-8?B?VERpMk1BWmpRSytoTUNyZkhkdHhWeEFiUyt4TWFoWmdZQy9RT09LVEV2VlpY?=
 =?utf-8?B?MmlZQjdRdWtOVklPTWZHWmFNYmFxN0Q4eWhOM3RmYnVCeVRxdExaczdVaWlQ?=
 =?utf-8?B?akN5d0M2cTBhTGNWSDl2bUt1Z0VNd2RIcHNEYTFSQm5lUUppNUZEbHB5cnRC?=
 =?utf-8?B?RHIycHYway92VXBMMjZUTEczWERtTEgzSWZVRENLVFhGNlRYV1I2ZVNOQ2tk?=
 =?utf-8?B?MDhZMU80YTZsdnpoWEN2Yzd4YWpwVklwQXFRM1Jsc1orcCs4Y21RaDczN2ds?=
 =?utf-8?B?RytDUWsrTmlxVUpiVGIxQ1hLKzEvcGZjZ0t1OW01Sk5yUUt1MmZtY2VGSkhl?=
 =?utf-8?B?WG5kTHNrSzlxS0QzQTVoZ1l4TjM4N2Ewd1dIcGgxZ3JqdWQ1bHpuVk1pMncv?=
 =?utf-8?B?ek9QN2cwaXY4Y3FKTDdXUGJMcUVDRU45VGNzQXozSnRadVp3VmtDR0pTNU95?=
 =?utf-8?B?RGtLOWtPSDAwUWFsSmwyWS9EakI3Y3k3Unk4OHBhTEEwbFovKzByN0pCcjVl?=
 =?utf-8?B?R2QzLytMWlI3UnhMYVE3MTlBK1JVZysvNFAyZm41OXhobW1GV2VWOVdqcW5U?=
 =?utf-8?Q?ct5PjmIkpy2wXb4jbntUU90Ax?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f77f9-c6a0-430e-3cd9-08dc496dfe10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 06:13:14.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H15FMIueAWx11r+1X4IwVo1Lilgv0A/AhpEwbFTajhYT/bCBrikOAHkUhcNE0bwaLU3/HAxHPdk3po/WJk5eag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com

On 2024/3/20 20:38, Jason Gunthorpe wrote:
> On Tue, Mar 19, 2024 at 03:29:39PM +0800, Yi Liu wrote:
>> On 2024/3/19 00:52, Jason Gunthorpe wrote:
>>> On Wed, Mar 13, 2024 at 04:11:41PM +0800, Yi Liu wrote:
>>>
>>>> yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback
>>>> and pasid_array update is under the group->lock, so update it should be
>>>> fine to adjust the order to update pasid_array after set_dev_pasid returns.
>>>
>>> Yes, it makes some sense
>>>
>>> But, also I would like it very much if we just have the core pass in
>>> the actual old domain as a an addition function argument.
>>
>> ok, this works too. For normal attach, just pass in a NULL old domain.
>>
>>> I think we have some small mistakes in multi-device group error
>>> unwinding for remove because the global xarray can't isn't actually
>>> going to be correct in all scenarios.
>>
>> do you mean the __iommu_remove_group_pasid() call in the below function?
>> Currently, it is called when __iommu_set_group_pasid() failed. However,
>> __iommu_set_group_pasid() may need to do remove itself when error happens,
>> so the helper can be more self-contained. Or you mean something else?
> 
> Yes..
> 
>> int iommu_attach_device_pasid(struct iommu_domain *domain,
>> 			      struct device *dev, ioasid_t pasid)
>> {
>> 	/* Caller must be a probed driver on dev */
>> 	struct iommu_group *group = dev->iommu_group;
>> 	void *curr;
>> 	int ret;
>>
>> 	if (!domain->ops->set_dev_pasid)
>> 		return -EOPNOTSUPP;
>>
>> 	if (!group)
>> 		return -ENODEV;
>>
>> 	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>> 		return -EINVAL;
>>
>> 	mutex_lock(&group->mutex);
>> 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
>> 	if (curr) {
>> 		ret = xa_err(curr) ? : -EBUSY;
>> 		goto out_unlock;
>> 	}
>>
>> 	ret = __iommu_set_group_pasid(domain, group, pasid);
> 
> So here we have the xa set to the new domain

aha, yes. The underlying driver won't be able to get the correct domain
in the remove_dev_pasid callback.

>> 	if (ret) {
>> 		__iommu_remove_group_pasid(group, pasid);
> 
> And here we still have it set to the new domain even though some of
> the devices within the group failed to attach. The logic needs to be
> more like the main domain attach path where iterate and then undo only
> what we did

yes, the correct way is to undo what have been done before the fail
device. However, I somehow remember that pasid capability is only
available when the group is singleton. So iterate all devices of the
devices just means one device in fact. If this is true, then the
current code is fine although a bit confusing.

> And the whole thing is easier to reason about if an input argument
> specifies the current attached domain instead of having the driver
> read it from the xarray.

yep, will correct it as a fix patch.

-- 
Regards,
Yi Liu

