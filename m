Return-Path: <linux-kselftest+bounces-1642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722C80E315
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383031F21DA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574FBE5D;
	Tue, 12 Dec 2023 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHJXpJU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B2DC;
	Mon, 11 Dec 2023 19:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702353383; x=1733889383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5JXSV8bF1Tf84vfe6DgGFV7kgNvhN8rNVuG8fNTVHZI=;
  b=mHJXpJU7kS5NZ31MrYLcBxmPIAyk9y87DPzbJZfurVCdBn58eLiZj5XF
   c35/IqYCEHucQCKiABqG+5T14Z+A2uduaqFwEnBO3UENgNWaw9TI5Q58H
   Cm2E48WQzLZxEtZKGJI5utuUxbuhNi2SlFtJT3lgBa4oKjyHztd3m7PhH
   DkpTaHtQKaA1UE+qqTeP2/cIJi4qebk++XnYiyW7rEgQ8OGiNV45ifplX
   gwkY6zyDXLb9kr463sF6i4l1ED6TfmV+HrSnFzYr9yvp/ztGeO/Jl3Nv4
   +Tbhv8icXJJ+ty1rrxV4CvVLqxMHLKfcEq86tKChhrY6r5rpxi51v33Ve
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="425874515"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="425874515"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="21360671"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 19:56:22 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:56:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 19:56:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 19:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYU+sVQAVWnjTcZUy7IkoQqhDTSUVjrjX3r2NVCUjg/gtNJTy3w22B6w4dwCOw3EsxbZyN5w8VswwjDZfETVXe4VYN52s8NqR0rOMdWnMOkY3y4Ua57h2kiMbiEJ6VJTx14CaZkerBxqVRF++jjwr9FXjfJubI6KZc0EERbuYbPndI+FoYL5vrBXikE6ZDnGR64l3XhT2+1yLZU1tls2qxe+UX+xSxv6JPBdcDRNdAZoxZp7bg/C1bQrW4DD9WkcdccUWTln8lci/hfuxbnmFZdIKXWPwXY123+ZUgWqgLPWcTS+ONZRDIpTaPtwdiJ8I1nf/5foYh8XcTQkDV2xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdaKDeZugsZlZ4OlGop3dHgIKItrrF+Oickzvck/dCI=;
 b=FjAYr6p+KH9V6HfY6Jn1kMO8IOXiwQ64jT6SvfB8iIodMkpxK8N8cJWkNF8VuRlP2t1MzvJN6mV7Tb4CD2tLNgknr5IOS/9YMNnaBlenEjrm+UFd8XnX+/LHS6PGkWOhjOPtPO9AoaEa72o8EapTBRU3/MqJRtqjnFNXCDP3L4jh2eYWWCn6V3MLJBkonn1RVONw0VF2BDXwfECmbIkyRv6lKEM0Eny2buZsjgkFXubac2KdgW5JmbIo08T+Xjt0DyB7TIH7XHhHm2OzLUdcc5axQJ/EyA1jEzZkJEbXJ5XZgQb8288Alazt3FTtRnPaYhcJYzUqDauYv4fF80BEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 03:56:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 03:56:19 +0000
Message-ID: <8b36ee07-c5b5-4cf7-8eb5-650de86bedc1@intel.com>
Date: Tue, 12 Dec 2023 11:58:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
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
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-4-yi.l.liu@intel.com>
 <BN9PR11MB52761F99B115765CCBCAC9F48CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52761F99B115765CCBCAC9F48CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: e1389733-67f0-4397-0e41-08dbfac64bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEO98siWqCUsP4mH9M7/zMTVx+RuFfEcS+EFE1us1NMzIdqpHD5pgqWST45rLh6PqPRWuQMl0gJ7PAG5rRDpFUkUV/PgWOwPBo6RBemv4ewzzKERO+q6YH38n4K9F+cHAHMT1Tx+SJ6pm2dioFEnP0YToSKOXzYV1ahvfpNk71Ff75uG1fyzhnC03HM08a6H4Ye0LKxBsA9P3O0BzFsvPQa7SnXdAzm+Cfb49op8brRBrKNVxTcTFu2M9pakw90RENhBxMRCALj1CgJ3fGYMKbcVnzdCtX/dCjWDotc7D5djcoVKUAp1manuWlRq8ccbYxUHLBGb+hlGCsEDG3n5VMun4BZW+uPb2kmsTxgX4+Aj0OSJhspv9Ok0R7r6iNClZlHpB6MV6v1x6eC9xxgu0sDJdg6IVlGjK+rMsCoi/ICjC6XmV09N9evCmc3qijSJsDO7U9Azk7DpB2BFW3+AabRVbo1r+sHNL+BJASawujiybLENGniNyUd5R9Ski9s4xa448Dri4CPekZD0nrcSoGZoFm+w27LF6MNzw/PWHpngpZ6z9njodvpHzB2ihf5LLG4QaezPEr67t/gb+uJydGfBdR1/eEJ9r2xvnZpQ/Nc5QrC4W7X3JuOvRIdQJQ4mS1s/8FbuSfJ9LlrVkZcbMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(53546011)(26005)(2616005)(6486002)(6666004)(6506007)(478600001)(41300700001)(7416002)(4744005)(2906002)(5660300002)(66946007)(54906003)(66476007)(66556008)(4326008)(110136005)(8936002)(8676002)(316002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBRemVHQ0twL1ZONkEzL0gwTXE2Tnh4cW1qcVl3czEzUDduVnZFN2JpQ0g5?=
 =?utf-8?B?a2dRYTRuVDlub09WdjBBakNITmJaRHlDYXo0WXJ6QTRVdy9aOUZXM1I5aEI5?=
 =?utf-8?B?b2RIdFhZbi85c2RVS21vd00rVS81bk9NVlVHMDNZVU8zMlBNSGU4cWIrL2hY?=
 =?utf-8?B?bUtPd0pTZDFNQzFQbkZxdVFWb3pBdzFDeTVza1VUQUdFT2VETEVlN1kvUWtq?=
 =?utf-8?B?V3VpMHVucnduV29lQkVydVdjcm9YVk1xaTd6a202eEw1R2hoQXVaMHdZSit4?=
 =?utf-8?B?V1dZMEx6dUlqdkJDbHd2YXVTMUpzeUhGWEVmYy9rOTREOHlEM0htSjhDL1B1?=
 =?utf-8?B?T3I2UlVEcU1WTjdRRFBvVkpubnEyd0lhb0VjSU44YWpGa1RicmprNFRhU2Mr?=
 =?utf-8?B?Y1J6ZlFJaWxqYko5RC9DTm0vQW9YWVhJNUN4eGpYRUtMOUlvV1F1bTVuV2dR?=
 =?utf-8?B?RXV2aVNCMGR5eTlLYldKckVUUTdKcS9hUjA5Y1lSNzA1RWpXbXQ3dklmbjlP?=
 =?utf-8?B?dnZpanYyZFhNMzZzbm9keFZ5Z05XamdPaTQ0L25sSGZOOE1GbEpIUUR1VVZ6?=
 =?utf-8?B?YmZ6R3duQlFDV1FnWGhNRDFnMEx6YnRIWTZoN1lnZW1WeTlrZWVOTnhkUGhh?=
 =?utf-8?B?NFpiSTY2VzJsTHF1T0xod2pOVklNUHN0bG1SZkw2QmhxODg3QlZSdFZNM0xx?=
 =?utf-8?B?dy80aEJDVGpWNytpZTBBREkwVEpkSk9tM2k2eEJOeFVablZaOEJBVUh3eXhR?=
 =?utf-8?B?dW9HMW1JWUdIeE45MW9tY2syM3VVSVMxMWlQWUVIcVZwU2lMb2JxV0pxRGlr?=
 =?utf-8?B?VDZaS1B1RlI5ZWRvR1FsTXIzMnB6SmNwa3dFUEN4S2FCb2pYRmFXNTlYTW5p?=
 =?utf-8?B?WGcra0l0bC9CQ3JCTDZaS3BMMjMwVWt1dlFUbzM2WDVHZG9FTElRZ3Z4TDNB?=
 =?utf-8?B?MGQxbldNOThRVGdtTUhUZitKSFRnZVFRUlU1bGtxK1hrWGMyTmJodUxIdzVN?=
 =?utf-8?B?aE1WQkRRb0R1bTdJQTlDZXRlVlFJazFmNm56UmZVV0xpTkphSS9Bd3R2TStx?=
 =?utf-8?B?N1RIaW9OZmJzWFRiTElNV2xYaE52amN0MDBueFp3V1VrK1dWbEk2aktjcEFq?=
 =?utf-8?B?a1hKbXQwVjVKUDJZcGtJQ1NEUmVtVGs1MEFCNC9WVHVHM2lXa2pXbHNOcStC?=
 =?utf-8?B?b2RPZmx5aC9OT0lVZDVRRkgxUVU0YWVaZjBRMU14Q3JzWEd1dXFDWThLRjZE?=
 =?utf-8?B?VTVROXVoVkJBeHFpQWZDM2x4K3NJZ0VLakVQU0U1M0lKYnBaMGtPcUxwc0Rm?=
 =?utf-8?B?ekgyOWZBb0E4bUIxWUhvT2dkb3RYLzRRUngycjBaei8rQWpyb0lCNjdUMzk0?=
 =?utf-8?B?NTlaTGY3UmVUOGtmdFlxWFdTdUt1N3BVemxDRGNXd0liQXk2Nnc1L0E4bU1v?=
 =?utf-8?B?azQvQnFPTHlrcmhmSjc1d2dCY1VjMFJRL0F3V0t0VzBNazhhUjNvbVlRWVAx?=
 =?utf-8?B?L2lUdUR3d0pQcUJtc0NGOEJNU2I2ZVdxUkNNUTNNMGpUNUR2Y1VWd25QZUow?=
 =?utf-8?B?M1RKOHVBaXBqNGJGVk1jZG5mZEFUMXI0bnFnR0tTNm1Qb3VETjlaVUNCdm5y?=
 =?utf-8?B?a0ZRSXhOd2JXYkZpNHNPS3hGcXRHeFVBTlN1YzNuVjFZMFFzTkc3eXQ3V3hN?=
 =?utf-8?B?RjZFNURlNi9lWWVsbjlheUJDdTRXM3N2YWNldFFpaWo5aVM1Tnd0NXNKbXpq?=
 =?utf-8?B?Zk9ndGlsMzE1STVIbitXbW1tWUlDSTUwY0ZsYzZhYmZ1eldJWEpuRzQvdHlQ?=
 =?utf-8?B?REZXVzVOaG1zS0JVOVNWNkhvY0U0aGdaUGFWUDYrNjAyYXhiZm5OcXk0WDJq?=
 =?utf-8?B?c3Q4ZUhOcXp5bER6SDEvb2xJQWxvbHNLUXdNekFETXBXcGtWeGhxOWQwQWNN?=
 =?utf-8?B?dGlpQVkxSUpIaHhOdTVMMDlvcnpnV0FUQzEwc2ZzY2xmYXBSeUNHVkN1MVpW?=
 =?utf-8?B?VTNYTXpXOHk5RS92ZEpQaCsxWFJqdXZMV3FIbHpLS1cxdXNKdkIwWVRKWWZk?=
 =?utf-8?B?QXNQeXNTeDZkS2xXcXRwazA4YjBFN3ZhN1Vya05KRlF4cHZXdXJZbjdJbEJq?=
 =?utf-8?Q?FKy1KrifZCMQ08KDxXwUZx448?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1389733-67f0-4397-0e41-08dbfac64bc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:56:19.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEaL4ko3D7bmKOUajd82CsOLVkhu9x1mqSfLWhzp3aiHjUgbdPNmaOwE05phWXrh002HTGSZTlrCG8NHvqz+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com

On 2023/11/20 16:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Friday, November 17, 2023 9:18 PM
>> +
>> +		if (inv_info.__reserved || (inv_info.flags &
>> ~IOMMU_VTD_INV_FLAGS_LEAF) ||
>> +		    !IS_ALIGNED(inv_info.addr, VTD_PAGE_SIZE)) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
> 
> -EOPNOTSUPP for the first two checks.
> 
yes.

-- 
Regards,
Yi Liu

