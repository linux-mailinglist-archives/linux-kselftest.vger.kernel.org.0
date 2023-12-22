Return-Path: <linux-kselftest+bounces-2354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B467381C55B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 08:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D001C24F76
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6AA8F61;
	Fri, 22 Dec 2023 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYp5FdS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE6C129;
	Fri, 22 Dec 2023 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703228504; x=1734764504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TWnCjvPrHvXBAICVkFt+We3rTNwoJGr9S//qssfeMDQ=;
  b=KYp5FdS4GSIhiR7KrQVFJ2ZXAGZ6ZTflOMmVwTTbIcadTjJY1hn98Ecv
   j+zoVYLoM2K3Bol1ptUZiYXmGd+pwNpZYzwu3sdXtLeIAb5xWmjDa3vFK
   yi9Lrsgz53PlsAAEqA+0jsheboxkf/tRInoE5Q4GvtE8S5WvWsB8Zd2ve
   9pSasmLxv4Tc/KQyxiToCm3szGwysromg9xdhLZ2F4mLMqMNqczIhFLXY
   4y2W8PvrZuRTKApl0BcPAuD0BNevrm69lfG1sMnS4cUbpKqBo/a6DTLDW
   3zxEb0GSSWLLgJZ/K70hkKjvwib6L4GbdDl4ZFo9dA5hQBQKx7lsZOOuG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2921950"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2921950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 23:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="18612483"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 23:01:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 23:01:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 23:01:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 23:01:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 23:01:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM/C/3k1XXzaIVaTzg3on28mMaPJ4s2t74DizBbpL1Bs1QatuQ8CHFWh1SsEVljl0gOPJ2Y7JGigjO/gMGrFFUpbxkyzdXaOuwShmNCoy1pMRv8r0hVWnoiym5LnJBSw59L1zFIJs71mpKgX0ZOgIM7L2tjCjG5bcKMNOBQC8lI09sK3BQ1GAl5HKXvplaGPPQILWknsDdpcETpxuh8U8XttVMR5ZRuOY7wEXERLUWwc6F8JRFN4R+JXnAqD1E5lQ/STmpCbeqjYh/eIL/jk6p236jhIRJM6YdpeRY3FmdgwtlaV95mUUlZ0urx4dRUw448W597dCJHf6bisjeQzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWnCjvPrHvXBAICVkFt+We3rTNwoJGr9S//qssfeMDQ=;
 b=JNgxQAXDSa26/1tMyR9ovuxh6KsHkcMKU/r/y7lJy1yv72tietIuLHZgIq0xdOXs14myrcbCa5BugwfHKqBHe7Ni0PKz8vKlj5A3NUc2k3ug8tYlg0RsXCfcSrNxSabJaI2HZ1pMoEY4epgH4crr3bAJ3/JBlC8FUW1jxovf6JAbQWZvipzdtAUaafw7O/NFldBZ5PIbsXEq2mLsqrYYt/1tzt0e3agd1nQ48EBBKPXeBl1j8VxDjeJ96IcMK/xUfoDVj0npojOKudj1py4o/qCCwE94PFOwzO3H/mSmIGvZbX6ctOmvR73l7pYr+aUuISZ6JVlzg4rj3kFclihMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Fri, 22 Dec 2023 07:01:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 07:01:40 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Yang, Weijiang" <weijiang.yang@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4qRuDL+bDzEuyhcu89eXATrC0rU2AgAAv1gCAAAQBdg==
Date: Fri, 22 Dec 2023 07:01:40 +0000
Message-ID: <D35102EE-F1E8-4888-8A5E-A1A723B3363D@intel.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
 <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM3PR11MB8736:EE_
x-ms-office365-filtering-correlation-id: b12f4666-9aab-4e4f-de9e-08dc02bbd90c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/c9jXDXCKiECdbKBZZIwxW0bFuaqDpyJKAGjk+gpxCH6UYqGGWTuzMB7LJbOIjM0JvA+lPv4j3cbVi8vJcHPGLopCB4jZoS1E/BuWRYARqfLySfdLQDmVKI+8fktXJD2m2gD9ZlnFFE8uOjD7+Lb78gvPJbJ4QttgL8NXZFZw4/TR7Qi+vRFzwce9h+JSO3EKiGtK3mdOes8jqPpNkp+F74YHmIp8381QBgbTCHDwjmLfmlNerqSjPWPUjNrWP8STj0W9Dck4NIU4AN9RVd8tPr/Sb3fdbIFXV4nJO6b3gvCFxqLUujXYd+I7O5ijAkGrxSmygZhdZ/UHxW7NJsGtOlY1nPVIKol7yrpPASHBLtMPabKt94ZD38pQsVzcYZ2ejzNlcaDuPCZtFF1XwDjwYouikCXx5Zc45HDtySsPYXtV67Rv2hGRvhweaDzl5J33DKsLzo8IeofmgVKH/4rdBfq1GmTsJirXkrFXqvLc0QkS52p3Jq/h2jUNPy9a2dm5rbdBFVLUVV2L1Fd7aNW2bZFGrpSY/O78kiKCL9q8OnA9WrxdBpoi+o9IokwLLPVESWtuT86MvJ4wCS00q9V+6JMjZdYi14SSikHcsUsnY+V9aLeJuYiIrl+jli12qsjOnsraEIdMZKQSaD1MG3UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(53546011)(71200400001)(2616005)(122000001)(76116006)(38100700002)(6862004)(8676002)(4326008)(8936002)(5660300002)(41300700001)(4744005)(2906002)(478600001)(6486002)(54906003)(6506007)(64756008)(6512007)(7416002)(66446008)(37006003)(66476007)(66556008)(66946007)(36756003)(316002)(6636002)(33656002)(86362001)(82960400001)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzV5QXp5WnViaWtsaTRqYS9SZ2JiR2FTRUdCNHRSdG1memZJczNCYmJSVjRm?=
 =?utf-8?B?NjFpL292ZUU3RURpcW9WejR3eEViV3lHVjBDdkFTL0tCVEwyUjg3V3VjUi9D?=
 =?utf-8?B?a2pBTnkwZHRzcUJaM2NOVThFNUdGVHJRZDQxVjhrOU5zYmUwdUdEM281YllE?=
 =?utf-8?B?bkR1S3FxcW5qMkVKUXZoeGRsckQvMVpFRXJqdmIwaDNVY0ljOW9RdksreE1I?=
 =?utf-8?B?WlN4UHA4K1J3NG1PUmI5N29EK01FVFhhbC9NSys2ZUEraGorUDl2VlIrYlF3?=
 =?utf-8?B?T3VDbmhxY2lXL0NvKzU5TFhIbkdyZUdkZlhwMDNQeFBhbVk5em1HZzN1K3RR?=
 =?utf-8?B?RHBNRHBpeEFXT0FidU1mNUxYNk9CVHQzTmtrajVBUTVLK1YvRHJiaURyL3Vp?=
 =?utf-8?B?T3hQdGdDSk5RamRvalQrTXdkREphZUJ6dWg5ZWcyN1ZNRFBsUVVtU1RPd2V0?=
 =?utf-8?B?ektZbWVYMTlqemp0M1JKL2lic0hLRXlRQUpsL0liU1lHdjl4VHQ1RHBCb1Iw?=
 =?utf-8?B?elRrWUNPbUNTT1E4cTZpWExDSmRNSVF1aXNYMmIyY0R2ZDRzcURpL3RVN3lh?=
 =?utf-8?B?VjFRZVI2NHZMNW85eGRqL0tHUWNsRUREQlZSclJaYkdycDV6bnFGejZSRlQ2?=
 =?utf-8?B?V29QMi8zRnpNeGJzNGQ5SHpFaUdZS25wYzRUS1o5Ri9MMU1mV3NKVWpYTlFu?=
 =?utf-8?B?YmZWQjEvbDRwbXJoVFUrNGZ1Nzc3aWN3andSWURsbVVKcmpPcUtrSm1YSjJv?=
 =?utf-8?B?Z0o3NytwOWp3UHFqQmR4WFlXMHNzR0ZNaG92MDdVZFBpMnhtVzYvaEVuZkI1?=
 =?utf-8?B?L2xoUWplbkg5b3BJbG5PcDQ5OUhWRlJSaTUxL0tQamthTFJVWmxETE1KdXF2?=
 =?utf-8?B?QVFITkpkVW9hUVBMSTU0QzRwR2JxSk1YWjIrdUxaUWliUFNYT3R6Zi9jaUQx?=
 =?utf-8?B?c3Q1dnBGYWdrZks0TEJmVStzbEFGUXpzM2xIdWYyQStjQ1dBekNmSjhLaEtO?=
 =?utf-8?B?TENCb1MrRnpBRzU3c1VKVTRYUHdlZDYyQ253bzFEUWpZaHRkTGFtdjdUZmZ4?=
 =?utf-8?B?SFpkT3hkT09NUXNUd0FWSUtwODdkdGx5ZzFGT05XZjdLQnc4TjZvUjN1QVV2?=
 =?utf-8?B?WVE0UHhaWG0xWFZqSkRNbWowUjh0V3FoRFJLQjNKcU9idjlkKzA0LytOc1B2?=
 =?utf-8?B?eHA2Y0lkeGh2a0RJdE1EMW9TQ3IyMGQ2bmlHMDg5dTdyVEF0V3NWN2VOYjJs?=
 =?utf-8?B?dUNzSEFTcU8zWlM5U0lOTTVwQisyNFVXcGZabVVpNktndXRBbFlvS0ZZRzJp?=
 =?utf-8?B?SVJRUjZ3cFNiZXlmcVZkSVVLRndKZzl6K0Z5SHpnUllRRFJXUkVoc0hoNXZ2?=
 =?utf-8?B?Vi9lMjNtZzFFVzF5aWtrZHd0Z3IwYzM2YXZrWnVPdkc2ek1yVjRaUHdma3Fj?=
 =?utf-8?B?eHVoeTZjRmE2ZFEvMitzNWFmN1JOcDl2ZGhKSnh5dTU2eTVwTnY4cWtaN3ha?=
 =?utf-8?B?cGxkaU5aN1JUemtuanZtbjFOb1pGM2ZlTk5qcEpzWHgvYW9VcTZxbHQ1UE4v?=
 =?utf-8?B?RmRvQUhSMmV3cFNHQmpubW9aVHRnb3E0YWR6Tk9qYzllajltVml5L1dQOGZq?=
 =?utf-8?B?MWF1Z3hZRkRTQzU5a213Z29PNVF0VkV1VlpZK1RHeDFNenEvMWd0TEVadjFq?=
 =?utf-8?B?NlFkZTVRQnhHYkM4VzQxSTlmRnhBajRtVnIwSStkcW5tTHRaMkxXUUt5VWVT?=
 =?utf-8?B?bG5IZFY0NkRLNlk5ZmlOZ3haUmlKNVQrV0t5UkRuSnN3NUF5SU9RZWdwY0Fw?=
 =?utf-8?B?dWFaNWFuRDlXRi9PdExlVDVNcG1udkduZjkwS01QaTVuaWdSQmNnSGRVMnI0?=
 =?utf-8?B?SzVYZmtuaGE4bDVwcU9WQVRsbTRMMkp3Z3o0R2dDN1RXMnMvSWJyVVhlamg0?=
 =?utf-8?B?YjY3WnQ1RGVtaXd4N0lWenpJaU85NEhqUzRhYmZ2R05SeDZmT0JTeW5JU3Q5?=
 =?utf-8?B?RzA5NnV4dEN4YzNwcEhZZjBIeVJQb3JqSDNGNmZKM0xoUXM2SzU1aytiVVUw?=
 =?utf-8?B?dUhscmppUkNQSitncWNObFBaZzQ1b3lhZ3Z2UGRaZzFkam01VTJhWnhLdTAy?=
 =?utf-8?B?ci9QUGZ3eXRqaFZ0UFh1SWpKQ1pwSG5jVERPN05DSHFFckZUOThYTElxTkhm?=
 =?utf-8?Q?SXjlG+4LsmdhZuqb1N8eXqQIzCvMnrgtL875/l2NHnzr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12f4666-9aab-4e4f-de9e-08dc02bbd90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 07:01:40.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbbYXvEg8N36D2hnkHOGjfeN0/kHkeRTEyXoWao9uYXMLf66Poc7qHUCDiVXsda50gQwd1NO1baLMG8bGuFD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com

DQo+IE9uIERlYyAyMiwgMjAyMywgYXQgMTQ6NDcsIFRpYW4sIEtldmluIDxrZXZpbi50aWFuQGlu
dGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IA0KPj4gRnJvbTogWWFuZywgV2Vpamlhbmcg
PHdlaWppYW5nLnlhbmdAaW50ZWwuY29tPg0KPj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAyMiwg
MjAyMyAxMTo1NiBBTQ0KPj4+ICsNCj4+PiArICAgIHhhX2Zvcl9lYWNoKCZkb21haW4tPmlvbW11
X2FycmF5LCBpLCBpbmZvKSB7DQo+Pj4gKyAgICAgICAgbmVzdGVkX2ZsdXNoX3Bhc2lkX2lvdGxi
KGluZm8tPmlvbW11LCBkb21haW4sIGFkZHIsDQo+PiBucGFnZXMsIDApOw0KPj4+ICsNCj4+PiAr
ICAgICAgICBpZiAoZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlKQ0KPj4+ICsgICAgICAgICAgICBj
b250aW51ZTsNCj4+IA0KPj4gU2hvdWxkbid0IHRoaXMgYmUgaWYgKCFkb21haW4tPmhhc19pb3Rs
Yl9kZXZpY2UpPw0KPiANCj4geWVzIHRoYXQgaXMgd3JvbmcuDQo+IA0KPiBhY3R1YWxseSBpdCdz
IHdlaXJkIHRvIHB1dCBkb21haW4gY2hlY2sgaW4gYSBsb29wIG9mIGRvbWFpbi0+aW9tbXVfYXJy
YXkuDQo+IA0KPiB0aGF0IGNoZWNrIGFsb25nIHdpdGggZGV2dGxiIGZsdXNoIHNob3VsZCBiZSBk
b25lIG91dCBvZiB0aGF0IGxvb3AuDQoNCk1heWJlIGFkZGluZyBhIGJvb2wsIHNldCBpdCBvdXQg
b2YgdGhlIGxvb3AsIGNoZWNrIHRoZSBib29sIGluIHRoZSBsb29wLg==

