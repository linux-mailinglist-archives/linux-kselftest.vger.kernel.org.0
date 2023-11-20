Return-Path: <linux-kselftest+bounces-289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E618B7F0DA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D52B1C21177
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4133DF;
	Mon, 20 Nov 2023 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YO1JQBmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1490;
	Mon, 20 Nov 2023 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700469326; x=1732005326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/kU11Si2C8Q2cGmC0fpIcAKY7NNqkeefaJERNpcgUs=;
  b=YO1JQBmTJTFlf3XNtwn7xuEu7P4YE8OkR5aZMUGkm//RL7qnJON/V0GU
   blIsgg0i1mCR61t6kQsDKwCP+UXaDIvTayKd8xZ+urpBSN3mKx+khcY5u
   WeTdGrphR0c+2FxSRtAZWYE+Y93fsiZqwWyyjdCL1wRFERPnqQVIhRGmP
   t2hmDBtPXg/1Vu98U7EnZJuQT4Z8os/NYC669OUgfD2LThIMwXrt8dtrR
   OvMTFJdeCi9g/OGbdJwrtv3S4n1uEuA0pSnuJb8QkaVCkC5J169+BjWYL
   eznWDNBhfoGVus+6dxgv/24ET1YiWiZsW4wPPWko2I0WAR/4OtCze/AcR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394425764"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394425764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="14082835"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:35:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:35:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:35:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:35:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:35:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry/0qlfiJ1RNQbdhRjuFXSqNR+gFNXahPIqvOOzpdaOaCn5ei3PkWOSLYGCIYSfZa3BmI7kK9IncAPt03LBlnE3gdYKMhBFCR+kZ4do1xraUFGHVD/o9/eWWMTqfuxsQCn8KDkuC7tsVPRlAyGt6KUo5xrVu9YpKdq9j98dLnNkkthRdUVzMoYQ808ezq5sCYfevb4Zj9SH7ewM/dJ4RP4z2JQ7hHhQZ69Zk2+ZaWS1ZuSHNYP/QnCTGzenXB8CbFtv64lp3bkYchlIS8xb1OPF9EefnAPnoMJjlFByaE5ciYTvr5fuDOVQldb+l7BOWxZktbvSexpf6uLR6kvdNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/kU11Si2C8Q2cGmC0fpIcAKY7NNqkeefaJERNpcgUs=;
 b=VRDtU/nHdU7OyJ5PL2TyGZGWrFRTFvU9ACfzHV/K8BZamX1+eRu6RSQLd2SgsfqhqMejLHKcIhc1McaIhraaSoYDS28tRJNe8+MEkXJXarCoUSLPWBid6wl6DR69HtGscrFlTickDPf8gs62SKTCGHDToA//te9GAmP8RDoiuYNEqvsZMW0tMGcyfzMbqbI/+/YPIXU+AKhhrEJXZL8kkuPwtNyx9t6F7preXmRcQwvTXVB0jB4F01u4atxn9hwbxugIExJQpRfb8JAAzj8jLzApp7Kln80OFxmQLhy2l80sR8hWVFVJ+lA4XEhbAQFf6xHz6qcwMUDm7NggEjkXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 08:34:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:34:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wA==
Date: Mon, 20 Nov 2023 08:34:58 +0000
Message-ID: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
In-Reply-To: <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8549:EE_
x-ms-office365-filtering-correlation-id: 1d7d9f79-293b-437b-f350-08dbe9a394c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAC7mrhh+ZYW4KE+L0cbfz+eMuxbz0OUL1HFtkwjp8wmQIlfDQEnq7ecDa0iP17OmxiaqUoTkAluqk7umLvJCGgt+Yd8bqwhXTSpplrzJxI2/vIufNSlFb/qzDEqD0CB7c7l2UlH5kV0dY4yx82XkwpxrNSrvJ2/2Ss5fez1Fqc66rUcuGZu2I8uZPBdzcFezzoHknwwwhpaaCxPmOR3CZReyvvktav9+gHIno0AMV335wKUiBwbkBheUhM6IBPBhV54FThVAaM5KQCg6DeLYdINdFNXfIStl+3LJ3COaG9L0C7HPUq/aRFK6V7GATG7Ld6Fsr494DztOQSaBUfcbtrq+G9SqA/xX2UkEQTUCeq5juFXI8JWvYGd+FiYTIfoBLZx4uB1YAM8Wbp/1j43lpvVc1NkExu2CTgzuPNq8Du2QxMIyRcaFX/EQHGMefWj/syrFdP+Lehx0879mZtDobCmzMp/RVf34XMlYgplgYSC+7lltCrOTUP51pROMOmvtJ/ed76fsIMaXY/LIPaslVR19dWpPfLaeIIHgFgRV+G3FI7WNZj0dYledrPlF2WUVionY2MGO15gdAqvntON3AdSX8DLZYfHQvhXDnbIWVPYvVAe8HflxxQIDF7OFg92
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(478600001)(122000001)(7696005)(6506007)(33656002)(38100700002)(71200400001)(83380400001)(26005)(53546011)(55016003)(9686003)(82960400001)(66556008)(66446008)(76116006)(316002)(66476007)(66946007)(64756008)(54906003)(110136005)(86362001)(5660300002)(7416002)(2906002)(38070700009)(41300700001)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlUwY3ZUT0tScnF6bmVGbDdZRStHNUQ2VHVIeThpL044bHh1bm1OZE1NWEsv?=
 =?utf-8?B?STBGK0wrUHVZaXo0SU56dUd4dkRjVkNHdkVZUTNrU3VRVjFJVW40ZHFMei8z?=
 =?utf-8?B?QUJYRnZBeTBuRmV4Q2w4N2VXOG53K3FRWnRKaHhtME4wSzB2TDVRU3lOLzFL?=
 =?utf-8?B?ZGNDN2pNc3U5QWhFVG0xQnFCd3hBUkJ6QXhZSFpoVkxSRXVJNCtCbzZRVUVt?=
 =?utf-8?B?RWZMNFY5VWUxRzhsdHoyRlo0eEpGdS9McmorYlF5ZHJnUEQwM0E4bnFJNjEx?=
 =?utf-8?B?WUFFakd0Rnl0bmhSWXVsM1RsSWU2b0xYSFJCVVNBZEdnendKMWJobUl6T1RX?=
 =?utf-8?B?ZFB5TlkrTU9kZ3JZTjE2TVhPeTNUTnByN1JaU1psZDNIRm9QQU9GNjU2RjVn?=
 =?utf-8?B?K2tGdzh0anlGQXcrcVlIbzF1cnh6NFloTkxZY2VMcUFXYXdnODN4b3BYV1Fn?=
 =?utf-8?B?VUEyNWVVdmsvN0QvRklEbUJleEVvVm84SFJ5cWJIUE5JWjRzN01aMGN0a2pn?=
 =?utf-8?B?TGNKR0wrVTloYlpvRURwb296TnZIU2s0SEgwSlZUR0RFYXFrczVPSkthZVhn?=
 =?utf-8?B?eDV4cCt0VTdrL2t2UnNKTVBoNWZ2dXlFSkFla2FvakNzQ1FoM29WNXpNYUxK?=
 =?utf-8?B?bGNOUTFUS0htakFCTzhBNlB5L040YXM3bjNQZTZVTGNYNHZnbDdkNi9jTENE?=
 =?utf-8?B?bGtyVW01VGJUUForbDgybmZWTWlMRG9jYW9pMnFqelJubzcySzJCTjQ3TUhS?=
 =?utf-8?B?TFFpOThXWkM0WHZTNlZISE1HV004NHJWakJ1RkpWbys4U25zWmltSHZqaUt4?=
 =?utf-8?B?VW13a2d6b0ZOMXEzMEJTaDBNeHk2dGtHekpBQlNlbFhSSWFndFZDN3h5SWQr?=
 =?utf-8?B?dFZ6UnJKN3VYV3pQZnQ1RjkwRlA1dXgrU0szaWg5M1g2bWNhTEVkcmNXUkhB?=
 =?utf-8?B?STFtYmpZa2FvU3ZCSnk0djlmQjBjaFdWTW1rMll1UURDcWJLUFM0R1dKVEEv?=
 =?utf-8?B?c2hMVjFtR1UrcjViUUFQL1N1RTZJVHhSSzZubXg0OElyNFk2dkRuRUFkdko2?=
 =?utf-8?B?Ym9uSjNmUVU0dDA4OXRlMnZ3Mk5rOFZxcjhwRzVlSFFGVC85KzMvZ3lQK3hM?=
 =?utf-8?B?T3pZUGFKUjhyZUhGa3hreFpZVzJLM0hmWFppazJ6Z0lhYUVvOHdpNmw5YVIv?=
 =?utf-8?B?OFVBY1dRZjY3bTFRR1F4ai9ZWUFLYUpaUmh5Q3Z1TGh6QnNHczRSL0pKL0t4?=
 =?utf-8?B?SFU0bmN0TTVPSk9vb0FyWkp5RHh3SGl5MGFTSmlZWms1ejZ4WlpVSU5RSGdT?=
 =?utf-8?B?S2dWWGVIYkNFTGc1d0UyUDFPTm9MdTlYaHBBNTdkWFRsQXU1d3liVVcrQ0dy?=
 =?utf-8?B?RjRrVGxuWW54cTVrSFlLVlpvcFVFMjFReEhQTCt0ZzJBM3lNWlYxWGtpK2Za?=
 =?utf-8?B?aUdlUWJ1aVVId1NzYjBBMzArZEJSdG5LaHlINForYkg4WFdpbEU1TExpc2tv?=
 =?utf-8?B?WTFTYlhmczhjY2JXOGhwaHlHTkxPY0ZCZlo5RS9VMDFMWnJkdkFiSmVHUk9F?=
 =?utf-8?B?YUJaeUtxc1IzaExJOE9CUVl5VUNSNTgrWENDWFJGV0dZemZrY2RyQ2NiSEdR?=
 =?utf-8?B?MFROL3JpelYrS3A3c25HVXQyVmFiRmxtRldJWnFVdVJrZXI3N0lmdWNaSnd5?=
 =?utf-8?B?VW9Kb0ZDUFc4aVpGTGFzWHZNRlNiRWUrODFDVDM4QmZTZUpMT3ZUd0hlR3l4?=
 =?utf-8?B?SmVoKysxV1NLUmFpRlpVVExVMWMyUStBTlpEN1ZMaW00T0pZRVZuWVZRVGUv?=
 =?utf-8?B?MEhTU3k4WFhpS2krZmJVelUrOERRYlRSMUd3SXpwaE9DOHpZLzc2UldhNnlL?=
 =?utf-8?B?N05DYVJwZzB0RWYwWlQvOWpmVWlDcndld2NjdkI0SnJJY0dmNFdOc2tTOXRu?=
 =?utf-8?B?djRsbjVZQmVHUDZCWEtPMEJBbzJ3L3RLdDU3aDY3NVBISmNSUHlaM3RlY2Nh?=
 =?utf-8?B?dmhScy9NSXh2czU5Sjl5WDhWVENPRHE2enlEU0NWUVJ0VXZzaXBsT0xCNllt?=
 =?utf-8?B?b3hjTEtCRXFJYStiWUVGaFBGcDdqZWtIQ3l1cnJNRWR1MnpzWU9iTE01bENw?=
 =?utf-8?Q?UWikJpqre80FbNEf354lza9Sw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d9f79-293b-437b-f350-08dbe9a394c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:34:58.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QDIKS72/RK3YK60OoJQQrrNmVKAakPXRnUyP/nBHAjuoP2Zut5KvfENld7KF7l4e1Yab1ehpHmMLhdyDCfwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBO
b3ZlbWJlciAyMCwgMjAyMyA0OjMwIFBNDQo+IA0KPiBPbiAyMDIzLzExLzIwIDE2OjA5LCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+ID4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMgOTowNyBQTQ0KPiA+PiArICog
QHJlcV9sZW46IExlbmd0aCAoaW4gYnl0ZXMpIG9mIGEgcmVxdWVzdCBlbnRyeSBpbiB0aGUgcmVx
dWVzdCBhcnJheQ0KPiA+PiArICogQHJlcV9udW06IElucHV0IHRoZSBudW1iZXIgb2YgY2FjaGUg
aW52YWxpZGF0aW9uIHJlcXVlc3RzIGluIHRoZQ0KPiBhcnJheS4NCj4gPj4gKyAqICAgICAgICAg
ICBPdXRwdXQgdGhlIG51bWJlciBvZiByZXF1ZXN0cyBzdWNjZXNzZnVsbHkgaGFuZGxlZCBieSBr
ZXJuZWwuDQo+ID4+ICsgKiBAb3V0X2RyaXZlcl9lcnJvcl9jb2RlOiBSZXBvcnQgYSBkcml2ZXIg
c3BlaWNpZmMgZXJyb3IgY29kZSB1cG9uDQo+IGZhaWx1cmUuDQo+ID4+ICsgKiAgICAgICAgICAg
ICAgICAgICAgICAgICBJdCdzIG9wdGlvbmFsLCBkcml2ZXIgaGFzIGEgY2hvaWNlIHRvIGZpbGwg
aXQgb3INCj4gPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgIG5vdC4NCj4gPg0KPiA+IEJl
aW5nIG9wdGlvbmFsIGhvdyBkb2VzIHRoZSB1c2VyIHRlbGwgd2hldGhlciB0aGUgY29kZSBpcyBm
aWxsZWQgb3Igbm90Pw0KPiANCj4gc2VlbXMgbGlrZSB3ZSBuZWVkIGEgZmxhZyBmb3IgaXQuIG90
aGVyd2lzZSwgYSByZXNlcnZlZCBzcGVjaWFsIHZhbHVlIGlzDQo+IHJlcXVpcmVkLiBvciBpcyBp
dCBlbm91Z2ggdG8ganVzdCBkb2N1bWVudCBpdCB0aGF0IHRoaXMgZmllbGQgaXMgYXZhaWxhYmxl
DQo+IG9yIG5vdCBwZXIgdGhlIGlvbW11X2h3X2luZm9fdHlwZT8NCj4gDQoNCk5vIGd1YXJhbnRl
ZSB0aGF0IGEgcmVzZXJ2ZWQgc3BlY2lhbCB2YWx1ZSBhcHBsaWVzIHRvIGFsbCB2ZW5kb3JzLg0K
DQpJJ2xsIGp1c3QgcmVtb3ZlIHRoZSBvcHRpb25hbCBwYXJ0LiB0aGUgdmlvbW11IGRyaXZlciBr
bm93cyB3aGF0IGEgdmFsaWQNCmNvZGUgaXMsIGlmIHRoZSBkcml2ZXIgZmlsbHMgaXQuDQo=

