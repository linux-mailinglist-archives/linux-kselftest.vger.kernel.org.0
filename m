Return-Path: <linux-kselftest+bounces-950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20063800689
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1BF1C20EC2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576801CA9B;
	Fri,  1 Dec 2023 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErYtsHwL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEA10A;
	Fri,  1 Dec 2023 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701421588; x=1732957588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zmqrYFuzPfSxMp8ek30Q6to1vWUdrbup3eX950r9K2U=;
  b=ErYtsHwLlKmbxZtg9H+rayvNT+udmPpy5nH8EgiDGyo6qXkNijTqgHUP
   wZk+QXflZ/aFrmtxMuqpGlsXrIjONtCB/e0bKYtX6y2AB4a7Br0hE5DCJ
   fEqLZtlTuVq7wTFW0P7hu+ypr6AgCl5mRm8BXrarBnqu9ufKw1arLBVgE
   FpmojgqNqVdNV6ppNSvFzLukEYXc7QH6WlPJY4yj5BKiH5pU8o/6zJpJz
   Ea3E1rPt5AMR4YXjhP85mvPixnLGWLJ1OXE6vHsxjmsG7xCIorL2fxLSv
   4HchSRg5xX+/Gz2NfoFAxKCZ16GFIu8Ycu3HKxWxfhvcHfNxmVkWnu9vO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="362093"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="362093"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 01:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016977446"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="1016977446"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 01:06:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 01:06:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 01:06:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 01:06:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 01:06:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxQTSvsti/Wc5m4P4n6z3mjuNhOApxfIXJv0pdNAdMEIsugqyuT2kV2tDW5D+ySN7DijqG+6ohZo8Ru/ej1ycWd0ZosmGaojiPNUyT9AuLJK2JPW5WCtr3P9glzIPvG8krjjePHbhjQQZVWVfXWez7yvcyma0+3k+M4I57xV1G7u8OfiKc194qcoLyXpfAG9216U0U+Z0nH7mkIn3NGC00pbi1Ll0xLjQptfmqzxDJC+3AgHQhV5cj2OCEZGMAvQgqG01AG9YHjtturnjsJjOrgL79tgtgj+lubSj+weYGKvHZyagAvbHOKIzz51lrUC6sqvjfSK0rVsBLbTsF/dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbA03i6MmUszryqLyeWPF5adnm37b8SXoKytbHWqnTk=;
 b=n0AnHsLIGXlUZvhGKqQWvgurlTcvqqJi17igWXAR52oDJFC6QBAZQUhT6rHAQ6jcVhcxehnjWaEwALZHdkKq4JWjQDSCaxOcSI/r5dZxukKZuNz/FxcodEOSivBzmZwRfxwRtiUsy/bSF4iOdEK/0Rm+NaI9OGOvkr/7zk3+3zVAwPpTYPnrfgYDHjlaGxipjQKaWET1G/bm19JETI33YTI/NaR8slX2q8dhi/OvSh7ffTzAkLbHRNKtqIDAHinIFff40ZY8w/0yil2vols+U/LcXJ+cIZZNfnGS+gIjSP/QJPhkI2+XozjZb1ei+G2CzfB8Mrc7JiZTrJ+GRJhXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM3PR11MB8715.namprd11.prod.outlook.com (2603:10b6:0:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 09:06:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 09:06:19 +0000
Message-ID: <f29ac3f9-0ab8-48e5-addd-82592c55838c@intel.com>
Date: Fri, 1 Dec 2023 17:08:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia> <20231129005715.GS436702@nvidia.com>
 <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
 <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
 <BN9PR11MB52761168800700D7131D601D8C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a19c55b-763e-4d6b-9462-4d0ea86110e1@intel.com>
 <BN9PR11MB5276CF2C6BD4163634F42D478C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276CF2C6BD4163634F42D478C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM3PR11MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 356d81b5-3e9a-4ec1-6594-08dbf24cc7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHZlGEyNQjqY4GXkcLR3uQVMZveX6DNMewvexOrCXwMBIAhQK0urkIF+5jkX8xkZUdpO6QBcj8ixkg6YP5vkIZysmmq+3l0zKZvUslRyFDSCmIEDd+3l7f7/mGBTqjQTzDq53Tuql4wd4SxjvkOoOxI34vseRg7RA5S+Q6DskgkIy8UFtBLN30xdxSrF5Mhz5gMFnCpHYTFFjppW2EEocFpu3VdQXjqVW34yxi0sWsKpKX9nmqMlMec67TB6vHUUE3guSu8052kSppHXQwpOv8phM3afwUhUfqMW3OYb3ehnh4EmTuPBkS19/GVHejw0n1HdnRvOPAe8tFI0DJi0r4+V8Qnqobej2qaAArVIIfCw8ttdV7xVNQlUpQm2kqqOB7eZSBvrWuz5Gcdx+6LFcScLi3Tt0T2jODt/1a6kjx5DO9zb2BpabaoMR59wskkheF60ZPY2POov7tiMQkz7sCCOU3cP79YcOWnee7JNLO+oL366TSVf8yWatvV565vnBfKMKh82PmZ1IKFf8IlaDbtbg9PLCUp+tGHNc/jpYcmE4Gig5T40QeVkmyKfUYJr1rxsvSIEMV3Q/xG6bUFz/HTyGg8ahLT9F68X3vpAlhLnAu278l5DWgDq3AHXyAtMsEGWBbtG56Ij2D0zuex4ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(31696002)(8936002)(8676002)(26005)(31686004)(4326008)(38100700002)(41300700001)(83380400001)(6512007)(316002)(6486002)(36756003)(7416002)(5660300002)(2906002)(2616005)(54906003)(66556008)(110136005)(66946007)(6666004)(66476007)(478600001)(6506007)(53546011)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNMdFpjTGFLelVLL2pNRkdKbldHOE1XSTVXSDlpcHFXRVQ4Z1NyOE84ckQv?=
 =?utf-8?B?ZFc0L1FuY094T2dFNDFxcmJCWmRtSEtuRkY5eGlybnNVZThSNmpERW5pbUdl?=
 =?utf-8?B?aWVESXJBWnNiZkd5NTB4b3FIOE1HTlNKTmVtTTNKbHkxdzF0MmtZVEFKTXkw?=
 =?utf-8?B?R05SemVmREJSYkEwZkJFWk1XRlh4bnMzcFF4VWhWS0hPWk0rRzMweHpMeDBh?=
 =?utf-8?B?c0JtVTNBeHVhMFdFYW5zOVhrNitUZVVWUm5oRjdyaHMreXNGY2oyU3g0OVBN?=
 =?utf-8?B?SXN1aHg1UkRCdDNHWEx4WUU0RW12bkJRUjJYY1ZnS3k3VGtPL3gzOEh6RXNL?=
 =?utf-8?B?TC9yYVhsem4xVCt3cHAzUFpoaWQwZ2RIMWFjV0ZCY2d2K3dYdXVSSUFHRVUr?=
 =?utf-8?B?a2kzUSsxdndpZFQ4V2h1c0xQcXN0cTJRcjBHQzR0MnBhdHo4b01FMkFyQUlS?=
 =?utf-8?B?cjFBd3pBTEM0aHRWYXJWR0MrekU1UE5wZ2ZzbFAwTXNnNXdkWktKMzlaVWxM?=
 =?utf-8?B?c2VDMWE4dm1Ja3J1TVdibm91S3BDckUyTEdybCtNN2dhUkJTRnhMWjFxNGhJ?=
 =?utf-8?B?NGtxRVFhVEhpM1NJaTZuWWU1c2gzMWUwanhsS2pSUFB2L1gydjVlQzdsV1o0?=
 =?utf-8?B?NW16RVlsUXBPUWtJRmlyK280bVQyU1hKSDVPZnRnb1ZmN3pSSCtFaklJS1BX?=
 =?utf-8?B?YlV3dWJHcU1PR01zeExGeW1KWjUrdlh5RGEzL0lEVk10MzAvbmVMcjFHOVY2?=
 =?utf-8?B?cmVBOUx2M0tnenhmbDRmL3RCdlljcDNvQ1p4dmV3QTA5SFM5Y051UFdKUVVT?=
 =?utf-8?B?bTczdVBUYU52cUIySHdPejM0RGV0SlVCTG10MVhQTkVkUW0yVmVENmRQS2pX?=
 =?utf-8?B?NWRtTm9KOGZjWlRMdndWQ1FHTUNXUUJ2T1pHVzZaN2RRcFJaTVZPWHd2cGho?=
 =?utf-8?B?bnk0MURFTWNKQ290eG5kZmRpS3IxbWgwcXdKeGpudElRSjlLd3UrQUpicmFn?=
 =?utf-8?B?SXBGcnpQN29nMHVWcHVTY1RVMHhFWWFOUUlzMkxLbVVqUEV3UzlNS1VHY0xV?=
 =?utf-8?B?TG5YaGJyZGNlbGs0NXJmMlI5TTMxcExoT0NybmJVVERxSjZtNHF5LzU3OEtq?=
 =?utf-8?B?Q0Q5eUFHZTh1WDFOZ0dFeS9VLzh6bGZGbUZIbnBDUVZmWENSYmNXVmdyMndx?=
 =?utf-8?B?cnVzMStKZDd6UUFJODhxN1BBVDlGNFJYZ2hlUldFQ2xkb3FCNkV6Q2xGMlF4?=
 =?utf-8?B?Rm12a3prUUlSMWxLVVlzT1VDRkplRC96WlVZVDYwNWR6eXByT1Exc0F1M1FN?=
 =?utf-8?B?WTFGeWY3Q01LYzlUZmYrcGFickppQkdVRVErYy96empBdTdTUFBEUHg4R1M1?=
 =?utf-8?B?d1BzY2Fod0FzRmNhc1crZlM0cmNDUEMyeGNVVllPVkEzU0tpcTRtNVc4NThi?=
 =?utf-8?B?RkxLbG83blZFVXBFbmpjNndFK1kwcXZaZEFSK21EYjFYb2prZlRROTMwNFBF?=
 =?utf-8?B?OVNHdU5lSWdQT3RSM3ZQTkdiREpoMnJyZjBxYVIreVFCTjF5ckVJMjN0cGEy?=
 =?utf-8?B?WWx1YmRVVUJCTWlCWUt5YXNpd3pBMUY5QnR6dmNqbnJsQ2htVFdBelQ5eFdD?=
 =?utf-8?B?YTJZWi9JMkptNy90K3EvMWpjdlllNHRLMmh4K2lxZ1hrRk05M3hOSnBBbDFM?=
 =?utf-8?B?bENaakYvZ1RaSDhhN21raWt3VmZtODYybW5ncnZublNnNzNIMEwxbnZEbFVJ?=
 =?utf-8?B?Y2Q3TTYxbDExUzNIRnRYRnJTZzhvSjhiQXF6Ums2V01vQnRSek94YUlJbExD?=
 =?utf-8?B?TEFWc0gybWF2cmVOeEY5cU1lSFJUcVAzNC80RG0vMEkwWGdBV0k2VmVURGkw?=
 =?utf-8?B?LzB2cktCMC95L2hwRWwwVFZWZUFiMzhHblY1dDFla1Nqdzh4ckFBZG4rWnlt?=
 =?utf-8?B?ZEhqTFRrN1N4aVpCdU84em9kczl2QVAyUDRjdE9TZk80L3BhWHdsMVp6UFJP?=
 =?utf-8?B?b0x3dGxRSytjQTJKekY2ZzdEQzVRaXBqSlFsblAyTndBVDVsNmVpc2d4eTlx?=
 =?utf-8?B?ajVkT3ZFbUV4SGVGaHY0L3RNa1RDRnFUK3ZQZ1hYYWwzdzAwWlJWYWx6REJk?=
 =?utf-8?Q?M5IqUP5Ue6oTrzqcf5OQXkOic?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 356d81b5-3e9a-4ec1-6594-08dbf24cc7ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 09:06:19.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zem9eDNVHxoxE9Wzo+Xm8VX3U8+cFh29ZJvKEAhSAUtOYWWhKOatJ388gdl1vJD4QXKeYzeDNI8yKvhSuHiq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8715
X-OriginatorOrg: intel.com

On 2023/12/1 15:10, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Friday, December 1, 2023 3:05 PM
>>
>> On 2023/12/1 13:19, Tian, Kevin wrote:
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Sent: Friday, December 1, 2023 12:50 PM
>>>>
>>>> On Fri, Dec 01, 2023 at 11:51:26AM +0800, Yi Liu wrote:
>>>>> On 2023/11/29 08:57, Jason Gunthorpe wrote:
>>>>>> On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
>>>>>>>>> I also thought about making this out_driver_error_code per HW.
>>>>>>>>> Yet, an error can be either per array or per entry/quest. The
>>>>>>>>> array-related error should be reported in the array structure
>>>>>>>>> that is a core uAPI, v.s. the per-HW entry structure. Though
>>>>>>>>> we could still report an array error in the entry structure
>>>>>>>>> at the first entry (or indexed by "array->entry_num")?
>>>>>>>>>
>>>>>>>>
>>>>>>>> why would there be an array error? array is just a software
>>>>>>>> entity containing actual HW invalidation cmds. If there is
>>>>>>>> any error with the array itself it should be reported via
>>>>>>>> ioctl errno.
>>>>>>>
>>>>>>> User array reading is a software operation, but kernel array
>>>>>>> reading is a hardware operation that can raise an error when
>>>>>>> the memory location to the array is incorrect or so.
>>>>>>
>>>>>> Well, we shouldn't get into a situation like that.. By the time the HW
>>>>>> got the address it should be valid.
>>>>>>
>>>>>>> With that being said, I think errno (-EIO) could do the job,
>>>>>>> as you suggested too.
>>>>>>
>>>>>> Do we have any idea what HW failures can be generated by the
>>>> commands
>>>>>> this will execture? IIRC I don't remember seeing any smmu specific
>>>>>> codes related to invalid invalidation? Everything is a valid input?
>>>>>>
>>>>>> Can vt-d fail single commands? What about AMD?
>>>>>
>>>>> Intel VT-d side, after each invalidation request, there is a wait
>>>>> descriptor which either provide an interrupt or an address for the
>>>>> hw to notify software the request before the wait descriptor has been
>>>>> completed. While, if there is error happened on the invalidation request,
>>>>> a flag (IQE, ICE, ITE) would be set in the Fault Status Register, and some
>>>>> detailed information would be recorded in the Invalidation Queue Error
>>>>> Record Register. So an invalidation request may be failed with some
>> error
>>>>> reported. If no error, will return completion via the wait descriptor. Is
>>>>> this what you mean by "fail a single command"?
>>>>
>>>> I see the current VT-d series marking those as "REVISIT". How
>>>> will it report an error to the user space from those register?
>>>>
>>>> Are they global status registers so that it might be difficult
>>>> to direct the error to the nested domain for an event fd?
>>>>
>>>
>>> They are global registers but invalidation queue is also the global
>>> resource. intel-iommu driver polls the status register after queueing
>>> new invalidation descriptors. The submission is serialized.
>>>
>>> If the error is related to a descriptor itself (e.g. format issue) then
>>> the head register points to the problematic descriptor so software
>>> can direct it to the related domain.
>>>
>>> If the error is related to device tlb invalidation (e.g. timeout) there
>>> is no way to associate the error with a specific descriptor by current
>>> spec. But intel-iommu driver batches descriptors per domain so
>>> we can still direct the error to the nested domain.
>>>
>>> But I don't see the need of doing it via eventfd.
>>>
>>> The poll semantics in intel-iommu driver is essentially a sync model.
>>> vt-d spec does allow software to optionally enable notification upon
>>> those errors but it's not used so far.
>>>
>>> With that I still prefer to having driver-specific error code defined
>>> in the entry. If ARM is an event-driven model then we can define
>>> that field at least in vtd specific data structure.
>>>
>>> btw given vtd doesn't use native format in uAPI it doesn't make
>>> sense to forward descriptor formatting errors back to userspace.
>>> Those, if happen, are driver's own problem. intel-iommu driver
>>> should verify the uAPI structure and return -EINVAL or proper
>>> errno to userspace purely in software.
>>>
>>> With that Yi please just define error codes for device tlb related
>>> errors for vtd.
>>
>> hmmm, this sounds like customized error code. is it? So far, VT-d
> 
> yes. there is no need to replicate hardware registers/bits if most
> of them are irrelevant to userspace.
> 
>> spec has two errors (ICE and ITE). ITE is valuable to let userspace
>> know. For ICE, looks like no much value. Intel iommu driver should
>> be responsible to submit a valid device-tlb invalidation to device.
> 
> it's an invalid completion message from the device which could be
> caused by various reasons (not exactly due to the invalidation
> request by iommu driver). so it still makes sense to forward.

ok. so we may need to define a field to forward the detailed info to
user as well. This data is error-code specific. @Nic, are we aligned
that the error_code field and error data reporting should be moved
to the driver-specific part since it is different between vendors?

-- 
Regards,
Yi Liu

