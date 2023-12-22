Return-Path: <linux-kselftest+bounces-2350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F381C540
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EEB1C24E9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 06:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C604E847D;
	Fri, 22 Dec 2023 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnHXg5Il"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB2D530;
	Fri, 22 Dec 2023 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703227645; x=1734763645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OzMtoaUWHyao1TwvE0ypWLjg7cEGDTQLtCZOWeomYiA=;
  b=lnHXg5IlBMhpB/nAY4TzR2Xacg9r3irsIKn7tgcj1oX8JNAW4H8X/9cp
   kPWHDo5+9CmxAsrgrPM4GqoXirUziLJKkd3NnlraH7ULHZB6fnXMH279j
   j8N1veUxEG5HNt/I+zXHvLfaeWEUfievX3S5Y4HaFUaKMFCSkp0SK0eYE
   yuHqgjupsz80PpZcCk94k9a3kYq1kEcKvlrgAGTQ7eh49Gttdiw+N++2L
   YmX+lndFRyu/wRR6BojlfVJ5yVsT9oV2PhG8VfR3S8R0FXDhSkG5p2cta
   MlyoIXYqReDdBdB3BkCXv/ajBw2+IenrWf4yyor8cW2R1nyoHbpQBvoZl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17652211"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="17652211"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="18950495"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 22:47:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:47:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 22:47:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 22:47:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 22:47:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbyFBBi2JL6UuCA3N8T5M5Ai8HmQTu5sop62WHzne0PAHM65ddTnlAPs4LXfCIKaoxlXEpcoI8qH+6YqAKa1PGr6Ked22L1F6CZK3DfvdbmiOQMUOt4VcSMXeFRXfTR+GSLsjYph+ZKk3WSoFDmpkrRMeXhbPAUEY8xWl20mYRm0wlJwVPZRWfvWWEbLnrNbRMm5zNmZW0y9T6lHOvqC0qAcDUEnF/UkmOVFIjwlBeNG4E0yBKPeUND7axrdBuWiv9/V1ajb/VdZi42G7ez1Z+SJapw3DUpr1Y9tfze12y3GKUl+mGOeXzvXd+/2HMt8ExfuZdGFQ9Hk1jd6GJVPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzMtoaUWHyao1TwvE0ypWLjg7cEGDTQLtCZOWeomYiA=;
 b=WJkHc43L9rB8VVLIuz+Je8Myq7ZEqRKgJrIuF34HV6lD2vKinaz7WRL23V0poj8ZYFo87i60pCH9ZXNpyxTx6rSLciWSbgql3l0ywJ5jIB/J4m7z8Bab6J/6a0FLrJGHEC355v8yRHFgNdzUFz4qID5Lci4JDnYxFMr4yN96qOSWBU7GlxqrsETkvnJI6dKqPNKWLUHIhW4R9qvYuXvLuWme50IraOB0Ydt3WnPsf9M0Bfee5Sd3IEc1NrhgilVK63p1Xakb50HuJyGfWwHQRUHPS7Bv3vlj4oppx2MxNsyJnXVsGnLiH0EgqsRIdDwSD5ioRd9jcLIvpbUND7h/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:47:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 06:47:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Yang, Weijiang" <weijiang.yang@intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4zqzfCm0YG0WB/drS+mURdLC0rU2AgAAu8lA=
Date: Fri, 22 Dec 2023 06:47:20 +0000
Message-ID: <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
In-Reply-To: <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8125:EE_
x-ms-office365-filtering-correlation-id: d0703ace-daf1-4d69-780f-08dc02b9d8e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVbEL3CwuoC2u7QYM3Z/SA68LnHyifD2IXd9PH3jzPFYlvRkp1lKraeaq4PcXHFGSzLNdcCzi7M2FBGcp6WjRgplXKmCIY78VNOrIN2Eb3l8AtfBlgvL2kT9+HZeIbFKM2y+w+ny+/oWHup2lKYQ75sbMigIj0VDivW7uhQAWwRitbKuRlQhiC/Noi4CqMaDyvM5DwMUual+2WRTNT5JjnsK+V9Gsw6E8VRbSnV39Tvw3ucLY5I3PCwfEpYTwxiF/pgFkoiwBhthj/WxrUZwQIBvmegs92mLdf4CmC/lRdDfkH0yN8y+cwOnwwMZUkSS2f78xKX3uviYMfZcyLEF+X9i8s14zRsHO8/lxDT0gmw2VWNutI4w/9QveVb+fqr796Mf2fl8GjekwrUy89euT7Q6b+fPdhn8bOIv1P6YmnSlLt4Pk27p1hjTva6L5nmbAUkrIxtYB/DbOlR+XrIxQY3mhMVJF7MnL76SkQhhexWOvjHQL+e8GpDz6+DoJ1ykwG48ReviVlHwMbpKM6QAaxlgHivdZnvLuRKyRERpP/ny2K6IZwR1SP6fP/+ZPafUro+r+N8+W1abgU/Lf1My2qgEXdKP+2lbIx0mkFB+CaO+mZ/ZtbYkFs3TzHpouqbz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(76116006)(4326008)(122000001)(52536014)(8676002)(8936002)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(54906003)(316002)(4744005)(82960400001)(7416002)(2906002)(41300700001)(86362001)(33656002)(38070700009)(38100700002)(5660300002)(478600001)(7696005)(9686003)(6506007)(71200400001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1hRXg4eXJrU1VWcEU1WStZMSt3RkVqQXc3NDNSL3c1eGdvQ1dPcks2QTYr?=
 =?utf-8?B?clNIOU9yRXNhQ1lDazB2czVRQ3VSNUlNa1lRY1dwTjk2bzgvRGozSFJjV0xn?=
 =?utf-8?B?azNUTmZ1L3FOWXg2eDJBUEN5NjBmK09kRjhsK2xiVWF4NkN0bGN6V0VnSGhz?=
 =?utf-8?B?MGxDWkp6NHkvdmZRMW9aVUV2Q21JRXlQb3o0RXBoZzN5alRkd2dIcGUrcVhs?=
 =?utf-8?B?VkVuNCswcDRHMkNrNEwvSEVPRlY4VUlJdFlYT3VWLzZwWnpQeUQrcWlEY0x2?=
 =?utf-8?B?d2x2Q0JvRDFaWXRsZHhMTmNxOVY1bDFVSmFjZXVoSC9qMlR4bTVvNGViOG4r?=
 =?utf-8?B?cmJNK21SUlpnOEFZK2wxamloblVOKzNuWU1ldjVyTlh3ejlUSytkSTQxQ1d4?=
 =?utf-8?B?Wk1jNllCb2JGMVE5MSswcWpCQVdFbTFRY2tzMlRvc1RkVFpaMGxwMEtGb0Z0?=
 =?utf-8?B?bjBPcGZsRk14WENGbnBsMCtDK3JtdTA5QVJBN0RFQk81ZnA1TWtOTnExYVda?=
 =?utf-8?B?c3lkR1lUckJzdDhIV0xjeDdhbG1Tbm44eFh2cStTYURta0FpZ28wTkY3QXZH?=
 =?utf-8?B?ZVYxcE5USVl3V2FINnBuZWk1V01uRXlrMTN2Zk1pSFd1RjUvcHJHd1Bla2lF?=
 =?utf-8?B?Q1J5eGFPZThHMEZHMEIwWktlUWNxektwWXZWcExZV2FFZGFNZW41REw0L05y?=
 =?utf-8?B?eXI3Y1lPK1kweHVGNnoyd1VXdVUyWS8xZXp0c3JrS2FDQ1BBbHkzRm5LK0J4?=
 =?utf-8?B?V1ZNQUNhd2JUQ2ptUGl0OFlEaFBaM1dIbGZvZWFGQlZwOFM3eVpDT1U0M2l4?=
 =?utf-8?B?bm9HSEVONmxpTHdUdlBRQ20vZ2VpVjduYVpKVlI4VlFqcUROZHRNK1luMGRu?=
 =?utf-8?B?eVk3QTQwVlBFZGJaaVhVWG1neEJ0VWs1dEhORllXR1lkaXd1UnluSXNoeGN1?=
 =?utf-8?B?VlZPTHB0cFRSKzRaMHdBNjZxMmxZV2VmdkV4MTl3dmtFcjgxOVpTMW4wZDNX?=
 =?utf-8?B?SmpwWlM2dHNxZnRqNDhBaEttVmRzVVExY2FRUzVseERQRStUSDBiYUFzcHp5?=
 =?utf-8?B?dDNES2laQ2p2OEtYQ2ZMSVlMaWhzN0VMWnZZaHBVWFV2a2dmMHpqYjlpRFFF?=
 =?utf-8?B?eHBScWttRnVSR1A3L2R3RlhNaldCMHdDNWVvTWM2S1hWdjV5aWJ5ZE5mUlpZ?=
 =?utf-8?B?QStHcGVNZ1NyRVNaTVhib2ZEa05lQmpUa0FXeGg3M0xDUlBNc3lyMnNxS3dS?=
 =?utf-8?B?cm0rb0dnNTVPb0dJSVRONk82bEJoM2FPZW9DZGtBYTNReXJaZVRTRmI2aUda?=
 =?utf-8?B?UEVTWFhCVjAzS3hxTkdMTFk0UUJ4cUJ6RGdETllRbFFsRS9RaVhHa0c3amhN?=
 =?utf-8?B?NTk4cGlCQ2FsbE0wRHdveklVUy9Zb0JobXhpRU5SWlQwSVhPak1XeEtrVDFq?=
 =?utf-8?B?SXFqNmUvMlhSOUFpei9yOFk1cURZM1hGRmpJdk1uSTB3dndMenRLL0wyVTN3?=
 =?utf-8?B?SVRqM3IzUDJRNWhmZTFwN2FNWnkvd0trdU92WUdCRFNRTmlMQVNVT2FYQzdo?=
 =?utf-8?B?ZE9weStjeEltUnZYZWluNldRK0hPb0hpa1lzMTdDZkx2a2lsU2ZyWklpQTh0?=
 =?utf-8?B?dlpuSmhTc3A4bTFYSHlNZVVaRHIxWENuTmdmVDlXMTNzOEppcTFQN3ZZbCtW?=
 =?utf-8?B?dEFqZ1ZZSVBuY0J5dmQzSnowdUtrUEtveFRsTXUvLy9yVTk0blNXZ25CUWVR?=
 =?utf-8?B?WEpiYkhHSFhvcE1TQTY5aTVVZXBpcWt0dG5OYnZZZGR5R1ZWaVBGVS9pVk1n?=
 =?utf-8?B?VGhJSHFoZnhaWGtOdFVSZWNnRlRlOGxKVm03MkpMdUVKVjFIanJHMm10eFBF?=
 =?utf-8?B?SUF4SmFnYTNtZjMxSnpDVUg5Q3JnVlQydDhKNGNGcHRoRTFrK1NXd0J6NDhH?=
 =?utf-8?B?K253QkwzR1l3UWZCZVRNSjdyR3grMVNqb0VGNXBFbGd4VmJHYmZ6andBNHFr?=
 =?utf-8?B?VEVOUnlaaG5xTTdlNWNaYmZlWnozdFYzbDhtSHdNakZ6Vk8xV1p5V3hNdTQ1?=
 =?utf-8?B?b2VpZklJb0NTMzV4NE53RjFGOHZXdERhY0R0SjlKdVJWZjNtamZDQ0djakhs?=
 =?utf-8?Q?YV24bdJ0wJEovagDam6Htxrab?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0703ace-daf1-4d69-780f-08dc02b9d8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 06:47:21.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObW2pQ1h++a2UYqO+7mN+7chRd+/u4UYPWXNWKjrh1kRLYWa86KhmVUYAKPEBEV45DCxAj9nZ6cSL54p6kIpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYW5nLCBXZWlqaWFuZyA8d2VpamlhbmcueWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgRGVjZW1iZXIgMjIsIDIwMjMgMTE6NTYgQU0NCj4gPiArDQo+ID4gKwl4YV9mb3Jf
ZWFjaCgmZG9tYWluLT5pb21tdV9hcnJheSwgaSwgaW5mbykgew0KPiA+ICsJCW5lc3RlZF9mbHVz
aF9wYXNpZF9pb3RsYihpbmZvLT5pb21tdSwgZG9tYWluLCBhZGRyLA0KPiBucGFnZXMsIDApOw0K
PiA+ICsNCj4gPiArCQlpZiAoZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlKQ0KPiA+ICsJCQljb250
aW51ZTsNCj4gDQo+IFNob3VsZG4ndCB0aGlzIGJlIGlmICghZG9tYWluLT5oYXNfaW90bGJfZGV2
aWNlKT8NCg0KeWVzIHRoYXQgaXMgd3JvbmcuDQoNCmFjdHVhbGx5IGl0J3Mgd2VpcmQgdG8gcHV0
IGRvbWFpbiBjaGVjayBpbiBhIGxvb3Agb2YgZG9tYWluLT5pb21tdV9hcnJheS4NCg0KdGhhdCBj
aGVjayBhbG9uZyB3aXRoIGRldnRsYiBmbHVzaCBzaG91bGQgYmUgZG9uZSBvdXQgb2YgdGhhdCBs
b29wLg0K

