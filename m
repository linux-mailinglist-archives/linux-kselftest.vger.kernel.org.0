Return-Path: <linux-kselftest+bounces-2601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275A8226EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 03:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579C9B20C5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 02:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B215C9;
	Wed,  3 Jan 2024 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URrwkuTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EB171B4;
	Wed,  3 Jan 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704248517; x=1735784517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q1ifKbxilCSVTviuXiKejhbFMpWM2XQpGjBnQdg8KUc=;
  b=URrwkuTw4iPwOw4Cw9jKhgz/s+82+eJtMR9jqIe6LeXwKjt5XqkZ9EDL
   sc7VeNRuHhzXaYz2hJc9/Dzn7xx9m5MaTjn42nJdxn+qSQAh5oMgVwkx4
   SK5OFZW9JeQukWD6zSwaZ8OjK7c3Xi/SoRSyniCIOPGRhD5oRmlQrC2nX
   bVFUW1JUKC0D1NMJH+THqHRkR0uQfyJBGNiWPGCQLphdKFwNqpR8o8wYi
   WJgQUP9VyHaBXY9SMN/iU3qSNAe/vW/8E8R5tIQdsS01qo80y2Qwt+L2Z
   A6zVbtAtc3gJ5Nj3gPaLsr7mdum31nCyGcmWSHa7Tp9PXbTjbiW6bHew5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463349607"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="463349607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 18:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953089988"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="953089988"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 18:21:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 18:21:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 18:21:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 18:21:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXaSs3PB3ynEFlkiFRgQsv0aYwGswJbnF3m3APK0Ehn1r/B7qx4o29N/u4YtYmZtKB4p+iVRBZFv9uBzfCx1pnQSVbTPIbu61ypLQpfBXWs1/KSkN9WsnlW0HyC05M97MXwbzrNqZgEYjucWwfHGn5OG5r2Eceo2F/JhXL2J2CZ9W8mRijbk0qu5fiJGJqSgLMjyhovH2MFgJDhQlNGT1ln6vGwjt17rC3XfQ9khQaNrh+BQf16J3141eZhWZaIF04IBj88JcAXQWguFl7DhkPZbvjxLwFHWvWf0CZp4shhf+uOcQF/jnguyq3ZINgO0CO9sKDDqA7ffKv1HTbhrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEQhOMvsPcFop0rkkta+mYazoUZwMGOV8Hp4Jo3Xylc=;
 b=Oay0sk5mtgTeXa0wh4qGD7KCyDvD0BSDym/NZ0aqCmGocgMGKSUivtbrrhHSXOlJJ0XdTJy6u4SSj4Tb3nTckVix3+nAUjQVTMd/vcvzytQE2G0aCVQuWmIcFBTCKJSPx/hPuByNj9dTCUCAyrfdLqPR6Y3tQYGiW8jmec/MdJwistrSBUTuvbBNCcw4/ahc/NwDMMZsTyMtUPHJKlZ8ESfqTpmlsgU0Hp07qtYfdPdck5qpVqw6Q8mLTymHWJRmNAPhbvZHIjhXeHl+T+1YRc9wOTOfC4isq6hPoZL2h1G8mTAuF2PvJW2DdtTVN+AwyQyehyrRD3UTdm2lTqS+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 02:21:53 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7113.028; Wed, 3 Jan 2024
 02:21:53 +0000
Message-ID: <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
Date: Wed, 3 Jan 2024 10:24:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240102233849.GK50406@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: b62ad54b-8d6e-4d08-1917-08dc0c02bfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZWgx8pl2tFCngZ43owrrkFOkFRq86u+Arsl9l15Am5g+e5sZa6S3lJx3Hi+Abx7QPD5o85YhNey28vZlAIydFYC58o1ga9fzcbOUBUH+I8+gmMD0qIuww1wOV0PMEz812mTrW8t82tdXWjCJPBmUCqvtSS/sTd7MPNz6RCNez+/fb2EF7gyvmgFYbHXushjTPh32ywFKzlLHlHxoylZ9vf7GymZq8aEiy6CjzePy0ovPqpCstugACWtWiHuamuHoZw0mejkyTKT37EvMwdTxC7BuUZi3aENtVYfVajCJkPahxVNq9njH+jjyGZnDCAGBVlDT09I6G7UMMMvU0778KTWchpTqT1fnXouiw8JG7SSY3LVbFhsxX5SjDrOrwdNuCOKGa59Jf7gIU7VnQFV69XjUcnSTKPvajS4YLIDVfPDpk8iwWeBIK0TFc6wbKcg8rXX5vHh6oDFW7xb/GMq+Tw/GRIXauzoARhh72r1hWP5lA/+uxz5Jm0eS9JhxhJy/lQS5OYzQqzyQyqRniXmpvJpFkbB3NDaVKtKBpZDCTdMK2zR1/TGUzDWy62W5ObodxjDKKzGAcqHawW3bpWRRDJAJu2crtx1Q6My5oHxcRmy2ZbFGTMwp/LnucqXinbqx2U5FTThJZKfI7AN7z+NYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(26005)(2616005)(41300700001)(38100700002)(82960400001)(8676002)(8936002)(316002)(54906003)(6666004)(5660300002)(7416002)(2906002)(4326008)(478600001)(6512007)(66556008)(66476007)(6506007)(53546011)(6916009)(66946007)(6486002)(31696002)(86362001)(36756003)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhiczlrWFU5L2xDT0VIVUtpRXppR0RENnllRWM4QmEzSGxMK3F0d2tLM2dF?=
 =?utf-8?B?RVR2Uk9QMHlZT3hhWUhqejUzeWp0TVdHSXpqN0lsSzJvTjdFWmJKV1NEYUM1?=
 =?utf-8?B?RWdPajlhT1VkaW9GZUpYOTF2cXN5UWtJL3NiaTh5RlduQituQm5ldkR3amhl?=
 =?utf-8?B?K1JvakF2T0VKUGwya3BHdVhKbmxLcGZVRTlSNGVKOVJxYk9RK0lMVVZwNGpG?=
 =?utf-8?B?RWI0THNRSmpxQmVVK0hRQ3c0QStnMjArTWFSc1lMZ280Y050QkpHZVRuQUtD?=
 =?utf-8?B?NSt6SHAvUVFIcmg2Q21pR2srUXljaUszbXFVb2VUbXJvSWFQL2ZuNUQxd3hy?=
 =?utf-8?B?c0xTQWh2NDJXNFIxY0Zjc2VvQldCcVd2Vjk0aXFXZlR1NTB0ajBEdzROSWl1?=
 =?utf-8?B?UWFnY2JqbCtVanNhazN6WUVESEJGb0VTbkZ6RUgveWpWMTFkUGtUY1pwa01T?=
 =?utf-8?B?ZVZtekFmY2NLRGdGQVVrcjNYb2FETWpaMFQzbklVbVRWemJBelBFajZvQnpT?=
 =?utf-8?B?QmUzLzZBZVliZVdFaWJMNDU1TDB1QzZkdDlUZTFjT01Jb2FiZVAzWTlQT3hD?=
 =?utf-8?B?b0VFaWFWL285WnEzRlllTTRwNS9Rc1F5UDg2ZmMwN1lSMGtoaUs5RVVjVVVV?=
 =?utf-8?B?blgrOWNvdFZDV21kd3Bsd2dxdUJnZ2hrT0hpQkxubThjY1NCQ09EWFhXbTJB?=
 =?utf-8?B?aDJ4ZEl5ZkFZcndjNVNvcmR0bmFEVUdpUzlIMHozRGFNSXkxTG1DaTl1ck15?=
 =?utf-8?B?N2pFdW5kbDBwd3FsNHVIb1dYUEFLSFJvaGRBRFl2NCtrMm9hYWZIZ2J2WXRC?=
 =?utf-8?B?dWtjZ0EycHVyTGR3VjVVeUUwVVhXcGQ2UzZoeC9Zc2d0VHhjY3VzUEdLL0Zl?=
 =?utf-8?B?V2NiSGFlOUNvZy9adW14NE5IclJ6TWhkYjZsOW1YYXV4Zmh4ZjRQdW5xRGZ6?=
 =?utf-8?B?b1JjalVTMitzN1JWZ1VNaTRaKzVsNDRqZUFURlp5a3BpV2JJMjlHT1ZOWmNv?=
 =?utf-8?B?UWNKbGs0dTFibzhYaGR5UDdMbmF6VXlFVXZVTFAyTld0ckFCSTcxUU0yTFV4?=
 =?utf-8?B?TjJlSVl5Y3hBUzFzMERVR0xPMlJHNlExd3BKVDE2dlJGZW9jVE43ZUZUbFBq?=
 =?utf-8?B?bm9ORGk4QVYxUFJBWk54K0lYM3BSSWI0YkxXY2g0TkdOS3NMTTdYVXl2VEZY?=
 =?utf-8?B?NHcrMmhoRXNSRlYrc3BmMDdvZkJwZGo4bko2clJza3NJNVg3T3NnK21MMXRV?=
 =?utf-8?B?WEVaS2JZbHBDZzlYMVVjUjMzREJjSUlVSkQ0WUFmMVAvVW5ycy8vL3ZNY2gz?=
 =?utf-8?B?R1hDeFl5NHpNY1RlR2svbjBjZ1ZXdS9LL2JNMTgyQ0M0bWFVN2hxaVo3UDV5?=
 =?utf-8?B?dDNFenBzTW1FT1hSOW1hN1ZIc1R3R0hyUkpxb2xqZ2dsNW9UZDVVWDRBRkNX?=
 =?utf-8?B?eE5NalVZVG1EUjJrenF1Qi90cFFNWG1qc2xGWjVBZ3pvTFNKRisxSTNQbEpt?=
 =?utf-8?B?Rm5RS2o5UVp3WUJ5QkdleWMrZXhETlpLN1ZQWHFjcHQ4WXlJaldKMFZyZ2VZ?=
 =?utf-8?B?N0xzKy9Ua0ZJYTZkcm4zVHZLdTdacHZ3UWRyS1lOMFBRdjBZVHlXME5HRTBm?=
 =?utf-8?B?elYvM1ZDNm1KNmp1T0JXZ0Zjb0hVMFViakNUVUJ6MUFydE91UlZlSk1pL1dV?=
 =?utf-8?B?NW5kRnlvOU5kc0FTYkhkbmI3b2lmK0RJN2lkZXRLcGhHdFp2Q3dwOWNpeDE4?=
 =?utf-8?B?VU5LR2xUbXJneHYxWjlRenFDQ0xXZ083amM5V1NuT3BUQ052T2JsdHV5bHJz?=
 =?utf-8?B?eWFsa2ZQVGVOZ3FnWUNVWXJ1eDFSejhyYXluRmxaS3JORUoyKy9zQVBkRHhF?=
 =?utf-8?B?ZVRyaEtpN0hXVUtZYXFvZHFWdjMwajhuN1lOOGdlaktlY0U4RUwyNXd4SVhU?=
 =?utf-8?B?UW84Z01lWVhRRTV0ZlQ4ZlNEQlhORnVqV3B3cExNQXdjQ3grK0QxU0xmNjVl?=
 =?utf-8?B?WEZUTlpZMnNKNTFkc3J3Y3lxOEt4bFZaUTVHWXcrU0xMVisvSlhYUy90MTNB?=
 =?utf-8?B?WVozeEszU3hrMkdHaHJkeUxqcVlXaS9WaXZ4YS9PeVhtT3VqckhrOC8waUMw?=
 =?utf-8?Q?sqYkXQhNBZQs9BJWgD+yLOmWF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b62ad54b-8d6e-4d08-1917-08dc0c02bfc1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 02:21:53.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsKyS47DmppcFOiEiMUL4DgvJksTytrtd0C9HqltU+tBe+ij0/IiyTz/LeqZvQvf/B0cny/WopQsxq5z1vnoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com

On 2024/1/3 07:38, Jason Gunthorpe wrote:
> On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
>>> I think I misread Yi's narrative: dev_id is a working approach
>>> for VMM to convert to a vRID, while he is asking for a better
>>> alternative :)
>>
>> In concept, dev_id works, but in reality we have problem to get a dev_id
>> for a given device in intel iommu driver, hence I'm asking for help here. :)
> 
> I think we just need to solve this one way or another.. Even if you
> use a viommu object you still end up having difficult coupling to
> iommufd
> 
> Some:
>    iommufd_get_dev_id(struct iommufd_ctx *ictx, struct device *dev)
> 
> Callable by a driver (using the driver-callable function
> infrastructure we made for dirty tracking) Is really all that is
> needed here.

yep, I noticed IOMMUFD_DRIVER was selected by intel iommu driver when
IOMMUFD is configed. Maybe such an API could be compiled when
IOMMUFD_DRIVER is enabled as well. This does address my concern on making
intel iommu driver depending on iommufd. But still need a way to pass in
the iommufd_ctx pointer to intel iommu driver, and store it. Hence intel
iommu driver could call the above iommufd_get_dev_id(). One possible way is
passing it when attaching device to domain and clear it in detach. However,
this seems not ideal as iommufd_ctx information should be static between
bind_iommufd and unbind. But we don't call into intel iommu driver in the
bind and unbind operations. May need to add new iommu op. Any suggestion
here?

-- 
Regards,
Yi Liu

