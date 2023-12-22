Return-Path: <linux-kselftest+bounces-2353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9181C558
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 08:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377DE28777E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BA8F61;
	Fri, 22 Dec 2023 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDb8GLhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29A8F49;
	Fri, 22 Dec 2023 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703228464; x=1734764464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tRixl6TRBkpFqQvSQBxAm1ls2W5FXzHfMytHdxP5JLM=;
  b=fDb8GLhSGlx/EJgDgkyKDI5qKMoeM0pq/k8o3FE1Sc2DKQIlzNtU1Vnw
   OVk1JgmgSnJt5Rakq9vwgx6530TkXfxtlAHrCpGmGaxsR72PYpcu7eAqt
   mP+eI97tHw9rzKO6b2NHSMETrvh5z/0EgJIg9AtJ6NeiIVB/yMqBMgJhX
   lQFCvf/iw7RXOc2R9zex4rlrE7EKh+hq2plY092F5AoceDpRl5jeF79Qg
   JAHarTt19Lo5XWzI3LTEzr6FUZV5FyMU6FTKLB66Tx3ShkasDqZraAoj8
   LTVotSK/UA5jT0PaveqktEmeQ2EN14sarVsyhrH2dpnR+ofP16vmtQP2Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394977894"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="394977894"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 23:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108376984"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108376984"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 23:01:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 23:01:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 23:01:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 23:00:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTm1O/5jAfM/hmlZF4m2+w8vsfQ5eh3lv+XP3jGVGm5jswQQ1LIBPo1qmpzltIYttl7neiutKsOPIajUqfpA0hlOptW3NbP7dYCMYKdx/zycqR5fxbZkTJkQj2i0xVEl+1ZM+C+JdIRxmziJPvzj3Ah7NdQ3ricuhTiGsWXZdLGTT7ERwDlHU11s1M5AvpFT/fNztq1cvbc2e3Zy3fMBD10JcFGdeDoQ88qtWxu5+vDwSw5qMHBR4QvsjlwvcF3nkB4+c23SzuOS7IydyNZ1AQx962Cmmh8DKtRHOgfP2hf7pqXQ3qDx2lpLwI6mQgRfrgR05J5GhOTOXODo9r1doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRixl6TRBkpFqQvSQBxAm1ls2W5FXzHfMytHdxP5JLM=;
 b=RJUfLIYbb9ti7eSCsZsPFIYoRl0P5T65wBOMSXRgqzfi1CdyP3Timqeo6uVfgEBA87eMO9qG0aXDUcmSunahm8xQTeYqUte6Cnf2imy9vsFd8JFwOcjZ41HjcQn7c/nv8e3B1TybBfI5LK+NixjS8yTMLPURB8RaSN3M5GmtxM+pZMBsHtdu6fs2wF3ALDtZTThW7SG5zOxGWVg0UFvG8YUzS8s67rUihphL1bZeSfKWHoiUakXx19PE1dUHLk9tPCXPMuBMPiG+VaYCczmRf4dkDYzq2BLiSA5X/nee6F+Od1SbGgnkdb3pCSfzpDcTU/swlsZX4gnb7EiPPjfqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Fri, 22 Dec 2023 07:00:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 07:00:48 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Yang, Weijiang" <weijiang.yang@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4qRuDL+bDzEuyhcu89eXATrC0rU2AgAAzmW0=
Date: Fri, 22 Dec 2023 07:00:47 +0000
Message-ID: <6450C2CC-908A-4C15-897C-A4E4FE39CF29@intel.com>
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
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM3PR11MB8736:EE_
x-ms-office365-filtering-correlation-id: 631f1531-9566-46aa-cb67-08dc02bbb9d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPJZPKcw3sU151QQQb0dfbVPLz6pX1+s5dGVPTJaQsMux1pDU0bTgi1N1L8cESNdv8T/X5LqWuF/MA8HsKWs1IxolDnL02vsEu3HtXVhnB31UFx0nlkwD9j/xvPJ41rvaIfrxO9r6i5SB/i7Xp/S3xz7DWCmc1QHDDxirkcwJyAygK0G2uFM3wMMvsLX10MlKBq9IYOwWQNDsLETxaDyBn7LX2+3bFd4aIC86etmlC+rpalDYxy92J5i8VYbLOG5kvIJ5DcRHamcQSr4ovBKPAQF+QkLJHPQLIIF2u4SAYlXzWKzmvHJKl0rXy2K3Kt5L+KNvjG6BUAl5HPZqEG3BMY6q6Xt95S7cGgsDdYSbNWaR17JJYXmVBnzXqAv+kbxltfZzFw/qAecIhJs6YaGFNhKALcRO5kIBH5LQwl0GVUuiyE+3M1KG7+71gRk6Sn3iRDuzaPAypeio/25oM7nLVY4hnoWCvKX5nuY/EDp71sn8VmdE8OF/LEsW+auYoB6ETPYz12rroYKX+lr/msiESiQH+uiex0o0o0mcDstzxv2KSjondx0xzmwWVLQ4zUjJd9nYIEO+dhrQp0UVQtUod1VDHW0sIRDhuro7QS+mr+foyRTOqMU93rTbuCPGccJm9ehocyyKbM1dI/+6AtvOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(53546011)(71200400001)(2616005)(122000001)(76116006)(38100700002)(6862004)(8676002)(4326008)(8936002)(5660300002)(41300700001)(2906002)(478600001)(6486002)(54906003)(6506007)(64756008)(6512007)(7416002)(66446008)(37006003)(66476007)(66556008)(66946007)(36756003)(316002)(6636002)(33656002)(86362001)(82960400001)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk5iRjI1UUxMc1VIemFaN2tBL1o5ZkFTbmp4ZDdMZ3I0QmFmTCszcHNZYURU?=
 =?utf-8?B?SFVqRXQ5eGhaZ1V0KzFFZEovS1oyaFd1NmhhMTlJQWxHb3hvT2liYTlmV0t3?=
 =?utf-8?B?WmZadjJBVkVHSTRxMElZVkFOL05pdkJONjhxY0piQjY0bEY3dW54czFJR2tJ?=
 =?utf-8?B?Rm9oWUdGRDJhWXpzSWRhMUd2cGo3elB6QmRvUWlLLzRSRUVubjlTZmZOb0FG?=
 =?utf-8?B?OXJzVFJBQmYydXdJWENSN1RKaTVhZUhUL0NlVU8wQzA2UTNLU2tXTUZFOUhB?=
 =?utf-8?B?SFN0M1NzeE5NMzF6d0dpWk9TK0psbnNvMWlOTkxVQWc3U2Zsak01c1VLaTBo?=
 =?utf-8?B?YjlOaU9HVVlFZWxJS0YwdFlnNSs5QXJidHJLek9GN1QwNDhTNEJ5SC9wUVBI?=
 =?utf-8?B?V3ZxSklaTCtPdHZZeUxFS09ETmVSblovZksvdGo4dDJ5dXpnVnA2WUtDUWVl?=
 =?utf-8?B?R1FBT1k0aVhkd21qOVhVOXJZak82Y0dLUDR6T0Q1cGI3MXFjbzlMYUw1WTB2?=
 =?utf-8?B?VksxWXdKdWhXb0Y3aGJYVjBKT0lVRVBnKy9JTXh2cHNMNCt4VzlxOWFyRnV1?=
 =?utf-8?B?ZlNERDNBYlZPaXpSTmo3YTBySEJZZFFFblVseTQvZXJUQ0pOazI5dTd5Y1hP?=
 =?utf-8?B?MklNUmwwc1VueDJjQVB4aWVUMi9DeGJwSU5QM2dpcDBqeEJUNmhKVkQrQ051?=
 =?utf-8?B?VWcxa1Y2Z08zMlkxZlNZMlE1SkpxL0R2dGRXWU5wRjdTVFdzYXhzNU9CcjY0?=
 =?utf-8?B?OUVlKy84SHJBT3lJUGNDT0RxYXMvS2hiNDIzNW4wZDBNeEQ0Y1FsaW02SDlk?=
 =?utf-8?B?WWJHMDBnZGY3WmxTMUxYY3JyN2ROVWVwbW9pblBuRnYxWEJEREwzbkk5VzZO?=
 =?utf-8?B?SnRQNGJqbEhNNDA2RUVGaFJKMjcyVW1EcElPUFZWeExxR0R3cUx4V2YzMjBu?=
 =?utf-8?B?OHVzSTE4NWJVKzR6OUxSSEVkVmcyVGU1eFV6ZWdzOEJxWWkxSm5YOXBPMFVa?=
 =?utf-8?B?ejFKUCtBRm9xR3UvYitXcjlycG5nS0tIUHNyVjl4Y3VzVlBmNUs5UnNyZSs0?=
 =?utf-8?B?Qzl4UGR5eTEwYmthMjlxSkEyc3pRbjFnTXIwa2VKRkFyb3pwUDdwZ2toQTZN?=
 =?utf-8?B?bTNKTW5heFZOY0tvdjVULzF0ZW1OM3VORUoyd0hodXlpcVdncTFVVUxGT1pD?=
 =?utf-8?B?WnREY3ZOV3I3VkR6eVVJYkZmVEtPVlZsZWxjTWVYekFGamgvbmNnejdOSnZJ?=
 =?utf-8?B?T1RDWmxYeFlxTlZlenZqREZ4YkNWc1BsdWhWYXg0MFVMRnVoZzR6dndTSC9a?=
 =?utf-8?B?eFFaMnp3Nm03Ty8xUzR6c295VFgrMnRMRzBKNTFtaFRtbUFTb3NSaFMwMEN4?=
 =?utf-8?B?KzBtSk9nVnF3RXd4Mmt3eUdHdXNsNDhIOHgxQWpjYVBIdllXVVJkOHRCTTkr?=
 =?utf-8?B?cGRHT3BpUThMOFVoWlhsY2J2Ukt1Sm9GU1lXTmdxQmo0ZmUxLzdnQU5GZmJu?=
 =?utf-8?B?RWtMNEVERGlRbFIwZGhqVE5OVGk0M2IzR1N0WDVINVEraTBCSVNXQmhyclpQ?=
 =?utf-8?B?N2phcGZKOGVjdThEUU00TnNnWmxXa2xHWjAzM0ZkanFhc05pMUcvYWYyS2J2?=
 =?utf-8?B?a1UxM1BmczA1OFBGL1hacWJkZ05yZlR0NG1RcFpCbU16UXRjZkdHb3BzejhO?=
 =?utf-8?B?aUVrVFhnajM5NFBnVnBQUlFNUWxDVUJXdVdGa09kdmt1bjM1NkJjUUI3Um5Z?=
 =?utf-8?B?eWRKYmc1WVo4ekFPaUo0a0VBcThDcEc5THpNNlNPbHlHNnNyckZYb2xjbzdD?=
 =?utf-8?B?ZHdKWi9VSVhyc2JReHBSTktBUytaclArd09mY0U4b2FmdWJuODduMU0wSnJS?=
 =?utf-8?B?YVFnU1dTVk9DODRFOHNrMnZYS296N2llN3h4dDBYL0VCai85ZTgraEliZWx6?=
 =?utf-8?B?WWp2NlFmNmc1dmNleVQ4ZVVCWkp6amRkY3BZMGZNNTJhNmdPdlhjOFk5MFQ2?=
 =?utf-8?B?dTZUT1g2RC9xZFh3dFhPSmRUK3grci80Y2JtN1psS1FmeUN5ZjQrYzB3ZlFr?=
 =?utf-8?B?YjQ4U3VpT0loUVNKSWY2cXU1NUp2OTgxTHp0bEVKWkhQZnNBRGNwS3R2cCtH?=
 =?utf-8?B?anlrK1c0NkRuSnRJbFJ2ejNlMTliQjhoeDNuTXRIMnkyOHJXM0JtcGZ2RzBG?=
 =?utf-8?Q?fsSO63Ok1ISvglu2Xcezd6EMtdp/Wv8demvsgszq5xo/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f1531-9566-46aa-cb67-08dc02bbb9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 07:00:47.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaD9I5/CL+c0p7l5n11D0RrihIFtnGtn5VlMg7GFIBWX3zkIxjcWB1kiYagud+Ao0r6b8D8e7QjQSPhqPc/wwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com

DQo+IE9uIERlYyAyMiwgMjAyMywgYXQgMTE6NTYsIFlhbmcsIFdlaWppYW5nIDx3ZWlqaWFuZy55
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiAxMi8yMS8yMDIzIDExOjM5IFBNLCBZ
aSBMaXUgd3JvdGU6DQo+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
Pg0KPj4gDQo+PiBUaGlzIGltcGxlbWVudHMgdGhlIC5jYWNoZV9pbnZhbGlkYXRlX3VzZXIoKSBj
YWxsYmFjayB0byBzdXBwb3J0IGlvdGxiDQo+PiBmbHVzaCBmb3IgbmVzdGVkIGRvbWFpbi4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Cj4+IENvLWRldmVsb3BlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvaW9tbXUvaW50ZWwvbmVzdGVkLmMgfCAxMTYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKykNCj4+IA0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvbmVzdGVkLmMgYi9kcml2ZXJzL2lvbW11
L2ludGVsL25lc3RlZC5jDQo+PiBpbmRleCBiNWE1NTYzYWIzMmMuLmM2NjVlMjY0NzA0NSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvbmVzdGVkLmMNCj4+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvbmVzdGVkLmMNCj4+IEBAIC03Myw5ICs3MywxMjUgQEAgc3RhdGljIHZv
aWQgaW50ZWxfbmVzdGVkX2RvbWFpbl9mcmVlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikN
Cj4+ICAgICAga2ZyZWUodG9fZG1hcl9kb21haW4oZG9tYWluKSk7DQo+PiAgfQ0KPj4gICtzdGF0
aWMgdm9pZCBuZXN0ZWRfZmx1c2hfcGFzaWRfaW90bGIoc3RydWN0IGludGVsX2lvbW11ICppb21t
dSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwg
dTY0IGFkZHIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMs
IGJvb2wgaWgpDQo+PiArew0KPj4gKyAgICB1MTYgZGlkID0gZG9tYWluX2lkX2lvbW11KGRvbWFp
biwgaW9tbXUpOw0KPj4gKyAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gKw0KPj4gKyAgICBz
cGluX2xvY2tfaXJxc2F2ZSgmZG9tYWluLT5sb2NrLCBmbGFncyk7DQo+PiArICAgIGlmICghbGlz
dF9lbXB0eSgmZG9tYWluLT5kZXZpY2VzKSkNCj4+ICsgICAgICAgIHFpX2ZsdXNoX3Bpb3RsYihp
b21tdSwgZGlkLCBJT01NVV9OT19QQVNJRCwgYWRkciwNCj4+ICsgICAgICAgICAgICAgICAgbnBh
Z2VzLCBpaCwgTlVMTCk7DQo+PiArICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRvbWFpbi0+
bG9jaywgZmxhZ3MpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBuZXN0ZWRfZmx1c2hf
ZGV2X2lvdGxiKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLCB1NjQgYWRkciwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgbWFzaywgdTMyICpmYXVsdCkNCj4+ICt7DQo+PiArICAg
IHN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm87DQo+PiArICAgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+PiArICAgIHUxNiBzaWQsIHFkZXA7DQo+PiArDQo+PiArICAgIHNwaW5fbG9ja19p
cnFzYXZlKCZkb21haW4tPmxvY2ssIGZsYWdzKTsNCj4+ICsgICAgbGlzdF9mb3JfZWFjaF9lbnRy
eShpbmZvLCAmZG9tYWluLT5kZXZpY2VzLCBsaW5rKSB7DQo+PiArICAgICAgICBpZiAoIWluZm8t
PmF0c19lbmFibGVkKQ0KPj4gKyAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gKyAgICAgICAgc2lk
ID0gaW5mby0+YnVzIDw8IDggfCBpbmZvLT5kZXZmbjsNCj4+ICsgICAgICAgIHFkZXAgPSBpbmZv
LT5hdHNfcWRlcDsNCj4+ICsgICAgICAgIHFpX2ZsdXNoX2Rldl9pb3RsYihpbmZvLT5pb21tdSwg
c2lkLCBpbmZvLT5wZnNpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgcWRlcCwgYWRkciwgbWFz
aywgZmF1bHQpOw0KPj4gKyAgICAgICAgcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVzaChpbmZvLCBh
ZGRyLCBtYXNrLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICBJT01NVV9OT19QQVNJRCwgcWRl
cCk7DQo+PiArICAgIH0NCj4+ICsgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZG9tYWluLT5s
b2NrLCBmbGFncyk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGludGVsX25lc3RlZF9m
bHVzaF9jYWNoZShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwgdTY0IGFkZHIsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMsIHUzMiAqZXJyb3IpDQo+PiAr
ew0KPj4gKyAgICBzdHJ1Y3QgaW9tbXVfZG9tYWluX2luZm8gKmluZm87DQo+PiArICAgIHVuc2ln
bmVkIGxvbmcgaTsNCj4+ICsgICAgdW5zaWduZWQgbWFzazsNCj4+ICsgICAgdTMyIGZhdWx0ID0g
MDsNCj4+ICsNCj4+ICsgICAgaWYgKG5wYWdlcyA9PSBVNjRfTUFYKQ0KPj4gKyAgICAgICAgbWFz
ayA9IDY0IC0gVlREX1BBR0VfU0hJRlQ7DQo+PiArICAgIGVsc2UNCj4+ICsgICAgICAgIG1hc2sg
PSBpbG9nMihfX3JvdW5kdXBfcG93X29mX3R3byhucGFnZXMpKTsNCj4+ICsNCj4+ICsgICAgeGFf
Zm9yX2VhY2goJmRvbWFpbi0+aW9tbXVfYXJyYXksIGksIGluZm8pIHsNCj4+ICsgICAgICAgIG5l
c3RlZF9mbHVzaF9wYXNpZF9pb3RsYihpbmZvLT5pb21tdSwgZG9tYWluLCBhZGRyLCBucGFnZXMs
IDApOw0KPj4gKw0KPj4gKyAgICAgICAgaWYgKGRvbWFpbi0+aGFzX2lvdGxiX2RldmljZSkNCj4+
ICsgICAgICAgICAgICBjb250aW51ZTsNCj4gDQo+IFNob3VsZG4ndCB0aGlzIGJlIGlmICghZG9t
YWluLT5oYXNfaW90bGJfZGV2aWNlKT8NCg0Kb29wcywgeWVzIGl0IGlzLg0KDQo+PiArDQo+PiAr
ICAgICAgICBuZXN0ZWRfZmx1c2hfZGV2X2lvdGxiKGRvbWFpbiwgYWRkciwgbWFzaywgJmZhdWx0
KTsNCj4+ICsgICAgICAgIGlmIChmYXVsdCAmIChETUFfRlNUU19JVEUgfCBETUFfRlNUU19JQ0Up
KQ0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChm
YXVsdCAmIERNQV9GU1RTX0lDRSkNCj4+ICsgICAgICAgICplcnJvciB8PSBJT01NVV9IV1BUX0lO
VkFMSURBVEVfVlREX1MxX0lDRTsNCj4+ICsgICAgaWYgKGZhdWx0ICYgRE1BX0ZTVFNfSVRFKQ0K
Pj4gKyAgICAgICAgKmVycm9yIHw9IElPTU1VX0hXUFRfSU5WQUxJREFURV9WVERfUzFfSVRFOw0K
Pj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGludGVsX25lc3RlZF9jYWNoZV9pbnZhbGlkYXRl
X3VzZXIoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGlvbW11X3VzZXJfZGF0YV9hcnJheSAqYXJyYXkpDQo+PiArew0KPj4g
KyAgICBzdHJ1Y3QgZG1hcl9kb21haW4gKmRtYXJfZG9tYWluID0gdG9fZG1hcl9kb21haW4oZG9t
YWluKTsNCj4+ICsgICAgc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxX2ludmFsaWRhdGUgaW52X2Vu
dHJ5Ow0KPj4gKyAgICB1MzIgcHJvY2Vzc2VkID0gMDsNCj4+ICsgICAgaW50IHJldCA9IDA7DQo+
PiArICAgIHUzMiBpbmRleDsNCj4+ICsNCj4+ICsgICAgaWYgKGFycmF5LT50eXBlICE9IElPTU1V
X0hXUFRfSU5WQUxJREFURV9EQVRBX1ZURF9TMSkgew0KPj4gKyAgICAgICAgcmV0ID0gLUVJTlZB
TDsNCj4+ICsgICAgICAgIGdvdG8gb3V0Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGZvciAo
aW5kZXggPSAwOyBpbmRleCA8IGFycmF5LT5lbnRyeV9udW07IGluZGV4KyspIHsNCj4+ICsgICAg
ICAgIHJldCA9IGlvbW11X2NvcHlfc3RydWN0X2Zyb21fdXNlcl9hcnJheSgmaW52X2VudHJ5LCBh
cnJheSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfSFdQVF9JTlZBTElE
QVRFX0RBVEFfVlREX1MxLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmRleCwg
aW52X2Vycm9yKTsNCj4+ICsgICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgYnJlYWs7
DQo+PiArDQo+PiArICAgICAgICBpZiAoaW52X2VudHJ5LmZsYWdzICYgfklPTU1VX1ZURF9JTlZf
RkxBR1NfTEVBRikgew0KPj4gKyAgICAgICAgICAgIHJldCA9IC1FT1BOT1RTVVBQOw0KPj4gKyAg
ICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgaWYgKCFJ
U19BTElHTkVEKGludl9lbnRyeS5hZGRyLCBWVERfUEFHRV9TSVpFKSB8fA0KPj4gKyAgICAgICAg
ICAgICgoaW52X2VudHJ5Lm5wYWdlcyA9PSBVNjRfTUFYKSAmJiBpbnZfZW50cnkuYWRkcikpIHsN
Cj4+ICsgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0K
Pj4gKyAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgaW52X2VudHJ5Lmludl9lcnJvciA9IDA7
DQo+PiArICAgICAgICBpbnRlbF9uZXN0ZWRfZmx1c2hfY2FjaGUoZG1hcl9kb21haW4sIGludl9l
bnRyeS5hZGRyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGludl9lbnRyeS5ucGFnZXMsICZp
bnZfZW50cnkuaW52X2Vycm9yKTsNCj4+ICsNCj4+ICsgICAgICAgIHJldCA9IGlvbW11X3Jlc3Bv
bmRfc3RydWN0X3RvX3VzZXJfYXJyYXkoYXJyYXksIGluZGV4LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKHZvaWQgKikmaW52X2VudHJ5LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKGludl9lbnRyeSkpOw0KPj4gKyAgICAgICAgaWYgKHJldCkNCj4+
ICsgICAgICAgICAgICBicmVhazsNCj4+ICsNCj4+ICsgICAgICAgIHByb2Nlc3NlZCsrOw0KPj4g
KyAgICB9DQo+PiArDQo+PiArb3V0Og0KPj4gKyAgICBhcnJheS0+ZW50cnlfbnVtID0gcHJvY2Vz
c2VkOw0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IGlvbW11X2RvbWFpbl9vcHMgaW50ZWxfbmVzdGVkX2RvbWFpbl9vcHMgPSB7DQo+PiAg
ICAgIC5hdHRhY2hfZGV2ICAgICAgICA9IGludGVsX25lc3RlZF9hdHRhY2hfZGV2LA0KPj4gICAg
ICAuZnJlZSAgICAgICAgICAgID0gaW50ZWxfbmVzdGVkX2RvbWFpbl9mcmVlLA0KPj4gKyAgICAu
Y2FjaGVfaW52YWxpZGF0ZV91c2VyICAgID0gaW50ZWxfbmVzdGVkX2NhY2hlX2ludmFsaWRhdGVf
dXNlciwNCj4+ICB9Ow0KPj4gICAgc3RydWN0IGlvbW11X2RvbWFpbiAqaW50ZWxfbmVzdGVkX2Rv
bWFpbl9hbGxvYyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpwYXJlbnQsDQo+IA0K

