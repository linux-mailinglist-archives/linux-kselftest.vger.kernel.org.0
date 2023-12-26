Return-Path: <linux-kselftest+bounces-2435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BD81E5FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 09:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE25B21C22
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F14CDF8;
	Tue, 26 Dec 2023 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA/QeLHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB512D7AE;
	Tue, 26 Dec 2023 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703580080; x=1735116080;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ne0XSKgG5cLYb3uUfbCAV6VsYs3x8FrfFiQVPUqFAGg=;
  b=VA/QeLHSP6mZtYUQYz6XHQQw2vbksq091PvOyWohmHSAmqpExldlpOK5
   L9n32F2gAoicBHtd9cAeHw2MItC6RxuTVP1ci2l7yQX7bq/VkmXWVnayH
   r+ZMSfWIR2HBUr0W/F9+gLnIDx3zUZUmPia+ofO27jzItSWwaYqaAfXmo
   AIyuJRU1gOCx42TAfjQ19+kTLrMzDjl+t+kvuFtPuUHH8QmF0gNntuuad
   zC0vAdr4sKvU2UaKXxbse1cgb1DzzcnkGWOy5SFphOBCfcZr7X0mo8NkE
   rJa4C56PEgc7Ju8TY97XSsNZCa+fj6dMravlw64O31i8cqZ3oN+EjYYe7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400152968"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="400152968"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 00:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="771123033"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="771123033"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 00:41:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 00:41:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 00:41:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 00:41:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 00:41:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX36h8KtuapwfhJ0htxdEMMgRHAhXXqK5APjpeRC7rWQHrf5EY50PwhAzjJ4dd+QRUvSC46Gf4O+Wo3oqmO92Ty5r2qf+5s5Zv5luRYmnuO2aIsWYlf1fiLMI3WjtC3khDQlNM6zPKk8ZS4BMjlpcyOsnK1yTyaluoJD1AyR0QsRqI43+aU4d3kO52DgA1DntVMBL/hURywCTKZbMjePAfuPMSgWVPcoiSSTBLDBnay6DoQZrPC/q3fm6rOauuvExwTaaMIwVDajUf+0TUZ/jSzfi1GcrVgX+HYKTO2TQ5mE8JbYKIa/KBYpZXOYAKeowCX/4THvkUlewGB8DgLtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alKS/bRPvMklo0/P+Is+zVvxv7PRIjD94CkpEDqHsns=;
 b=YIFa/2iqEBJb6n0k6hkElv60YYj2+KiZwRoU/3Ra/OZV69YzU/uBisiw6ji//OFjyTqugA981aoX6+WhuAOGhUR7RPDJienCvQHpYtRhb4GnweY9ylTg8rFHnpJZ1ezKBHGvGMFPmybBP8PAD7KwqEf7fhM6h5K9ayj7MSlOnngtkCuA1koCAXlyS252Z0xlVzaC+Y53oJJOeXWfDwECZkB57ifAlMpkELo0/U7gS9G7eHXztD+JyYyn0F/mG5ILcI1onfPScD7jUwjpe3RwkuRsrVCvvMIkwDVXZ2EfHCWf4+AdDkusG2BY4fTDlLDsKlac2+5mqA1f3Y9ajkOjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:41:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:41:16 +0000
Message-ID: <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
Date: Tue, 26 Dec 2023 16:44:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
In-Reply-To: <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a92c577-e040-49d1-2f2a-08dc05ee6c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgM1v9XbRqM4DFOgN9rG3ehWbM9frYFrbn3iA3PCzxtoxllsfYjNG0qNwGoR/BRrayPfaXlGFmz6Xa5cteJyhYYxvvbuVqx/j+QogVfVhgOl8eo90DMLDTNWDDCoJrzrntW6Ae58Z3XsIi8BI+yqLbYiaBtuvYzRbG7nT9aCBLEmvNdAH1C0DATAbvjvWWLReAqlnadknc4w9+qSnnC9E3y8hIsUVnnXNiWhiG4iK0IUKOa8qEN1Tp0ql64K2R3cHUmLTwOnLef2V4GD8zr5F/ZboW+uaiauKu0dS9irGwKOlxZvBxffatqzL6YZoHFNdvOW/YQ/efzu6vdLEQE1g14I3seZ0eK8FkK6vFKc3c22o4hHX+S3Nzc28IjNM0b+Cz5BJEeiFzntDCMrCUbksOsV7vvB8Uw7joF1ac9ZRsmbJ1uwjkFNA7Kr0bYy+l6rLX1u3+zd/Zj7H+p0bDEjziGEnZ3rAkWEMdDWsFLlINFDdzPein5nUFkK5RiZEyONz72RJKz28B7NafSJ3Rx3vHK/fUrJmNoWEF1668vFy1b+4cKjpUrHcrKH5TMqUFuAdfo8OZADu73qOWW5P5AP51/+L+yniY55+NHjZdE3XhZoR1CHc9KGJQ/EB5ySkv2JRCgFlELn3YEhChRw/UcG4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(31686004)(110136005)(6512007)(6506007)(6486002)(53546011)(38100700002)(82960400001)(66946007)(66476007)(66556008)(2616005)(316002)(54906003)(31696002)(6666004)(478600001)(86362001)(8936002)(8676002)(26005)(4326008)(5660300002)(7416002)(2906002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJMSHJONEp2NkV1TXdZZXdVTjNnUFI4WlpYbWRCK3VqWU1LZHBuYnF3R1ZG?=
 =?utf-8?B?aUlEYmRSMU9icU5FblhIUmpBREt5TWNMWlJFTGQ1ODFET1NvVW40bEVHdWh5?=
 =?utf-8?B?Vnc0TVJTODBOSkJtdjAxVGpCWDNaQ1pDdjNjQUdhNFVnUVZCNnFoaERzZTFj?=
 =?utf-8?B?NytXRXNDaUtjTmpNZW90dFJJNzQ3MDlFRVhGay9MRmNrZTdKbGpmSzU5ZEVj?=
 =?utf-8?B?VzAxeW5UZC8za0JHVERML2JFL0wyaWh6Sk0xcTNxK1RoY09XdFlOOVFMWUJK?=
 =?utf-8?B?bVNrMnJVWms3RUNVUnlVaEtDWVpDaVZIcWlPcFp0OVVtUnh0RDVkcy9oU0hu?=
 =?utf-8?B?ZzNnSVVabHZkZGNHaFFDRXA2N2tYOG9pa2FoQitPOU5tMVVSS1RGZXJxL0pT?=
 =?utf-8?B?cTI1dVFVUjFaU2YyRVlVZEdlcnJwQzg2TDVUcGhSNDFGWHFNRkNyWjU0L2Qz?=
 =?utf-8?B?TVNzL2x3RDdpeG90ekdnWkxVNUc3bDZOa1hYZnR0YkF3Sit5emRxRnFFUlB6?=
 =?utf-8?B?TmJIbzlYN2pCVVpaRUpxZFM4YkQ1azhicTNiVG5vR3lYcnJMcVFTMVlYTVFD?=
 =?utf-8?B?UjJYQndXckNoVmRycGt2U1Rla3RaVXEzV3JjVHNRMDZxajM0WFVVVWVXRkFH?=
 =?utf-8?B?OFpQN3RRZTlMMFo3RzhleHByNWFPSTR2bHphQzl1NUtXaUJEK1BNZXM5dm5W?=
 =?utf-8?B?MWNJejdBL0JqOXo1Sld4VE04QlREUEQweERaZC9NMkpqenhla3hUc2NQdHZx?=
 =?utf-8?B?NTExVCtJZTl3UkdYdjBIVnJoeU5nYVZla05ac2hOckxjd3hiSzAycXBra3ZE?=
 =?utf-8?B?aWp2RTE4T2hHSWlMaXpDd0tNUkI5S1E0bGl6UlZFR1h2bDhQcGFDWnAxQW93?=
 =?utf-8?B?bEFJaUdxWkxjeTFjRmpSSTRoOFZqK0lYeXArcXgrL25EbmNuQTdKV2pMekNW?=
 =?utf-8?B?dVlwZmlEdXdjOXRab21XcXgxQWd5VkNGdzBheFRXK0RnamZhL0hPNy8wdVhB?=
 =?utf-8?B?QUtRVEYvTE1QNyt3TmRPV3lSN21pV2FUNDNwTUhDbHY3UVI5NU5JV0lWNWpI?=
 =?utf-8?B?VHo3QmdZVXNvcjVJYkpRT1pIMDJocXB2QkljNlpoZUtCZlJiTzNNZmpWQ0s2?=
 =?utf-8?B?SG9UUDJyN2FpMk9KR3FSMEVYenJoNHpxMklEUkl5NnJubkdJTi9sZmJ1MWRo?=
 =?utf-8?B?aklBdGg4dE5lZ09zeEw2dnp4QVhvRndmUVk0SWRkZ3lkM2ZjT1VjUnYrL09t?=
 =?utf-8?B?QUNWVDVINFRBeEtxNFVEQVhod2c0ZlQwYUtjRGJFOE4xVmRGdnI4d09qV0Vp?=
 =?utf-8?B?d2poM01lNTlQcmt5VUs1TlFwQXdRT2tUZnJDUk1KQTk1eUZjMWdPNFBaRGNO?=
 =?utf-8?B?eDlZYnBYYmdTRDd3VHRDd3grdy9oV1MyTzFhVjVHdjl1SjVWNnJGVEZqWkhz?=
 =?utf-8?B?RU5VUjBycnRzVkJqK29QZ3VCM1pnT3JsYTdhNWNYcTRSM3Y5RUtUV3Y0NnFN?=
 =?utf-8?B?L2hielM4T2hnbTRPbnV5WWorVitVS1pZN2JTa0VBMFJEWCthSHFkM093NW9G?=
 =?utf-8?B?S3RZOHY1bFVYOVBQSk5LWHV2eHZ5SHBPQ2lNdHA5a0ZzK2hBTVV6Q1g4Q2Q3?=
 =?utf-8?B?bjBlZkE5TGkrQytPakZpZSt3RGIwSlhlNzdZOFZFcUd3Qnp1akJlNVk2RWc3?=
 =?utf-8?B?R2lBRjVxdGhJa0RtMHlzeXo2VzJMdVJxbGNKR0dDeHMzRjVnQnZHcW5aZTFu?=
 =?utf-8?B?Z3dsc05GbEZHdGx4d0I3SEdqd2Y1MndROTkrc1NBNzVESzIzYi9oUXROaVZC?=
 =?utf-8?B?alpaRUJOMXdpODFTd3BDVkRhYk9GZjBacXJXV1UxYTB6c3Y3VUwwWk1GSi9m?=
 =?utf-8?B?UGp6UVhwek9CZDBpTTJLTk01UDVvSkErQ2Z1N1MzdGlSTkNqSVZCSGE2NU96?=
 =?utf-8?B?aGZpSnhkTFNuaFZwclkzdmZwWXhEV1UzbXN3OWNBYldOdVhjY1BMc3NWdHEx?=
 =?utf-8?B?MnlJWnJzdjdpNmlDNlEwbVJsbE5IdXlHMzhjNWhLc2hrREpaZ0FaanJiQnZQ?=
 =?utf-8?B?R0taQ2VpNmRHV1E3b3p4Q0UyMW40TEtKUzg4bHZJN2R1OWNwejVWS3Exc014?=
 =?utf-8?Q?d4tbtYPL0QXsGb2goLNCJI4mD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92c577-e040-49d1-2f2a-08dc05ee6c2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 08:41:15.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0T+p9LTzMEpgPC45ogzePfk2LCtdoPNLhv/HsOPSy+sp7E97xfNzXXbHAb8mxaY2Otglz8ynDwj9iabmpSXJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On 2023/12/26 14:15, Yi Liu wrote:
> 
> 
> On 2023/12/26 12:13, Tian, Kevin wrote:
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Tuesday, December 26, 2023 12:03 PM
>>>
>>> On 2023/12/22 12:23, Tian, Kevin wrote:
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Thursday, December 21, 2023 11:40 PM
>>>>>
>>>>> +    fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
>>>>> +    if (fault) {
>>>>> +        if (fsts)
>>>>> +            *fsts |= fault;
>>>>
>>>> do we expect the fault to be accumulated? otherwise it's clearer to
>>>> just do direct assignment instead of asking for the caller to clear
>>>> the variable before invocation.
>>>
>>> not quite get. do you mean the fault should not be cleared in the caller
>>> side?
>>>
>>
>> I meant:
>>
>>     if (fsts)
>>         *fsts = fault;
>>
>> unless there is a reason to *OR* the original value.
> 
> I guess no such a reason. :) let me modify it.

hmmm, replied too soon. The qi_check_fault() would be called multiple
times in one invalidation circle as qi_submit_sync() needs to see if any
fault happened before the hw writes back QI_DONE to the wait descriptor.
There can be ICE which may eventually result in ITE. So caller of 
qi_check_fault()
would continue to wait for QI_DONE. So qi_check_fault() returns 0 to let
qi_submit_sync() go on though ICE detected. If we use '*fsts = fault;',
then ICE would be missed since the input fsts pointer is the same in
one qi_submit_sync() call.

-- 
Regards,
Yi Liu

