Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF1712566
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbjEZLZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEZLZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 07:25:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7FF7;
        Fri, 26 May 2023 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685100348; x=1716636348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=loQkGNXghUhUwcuriELEG/zwO2AtkekqEwpJNQsCk2s=;
  b=A1KQG8lU6o4cKTDdZI6+Qc72TW+CnZJtwd8CJiwnCIBjyxJ33GaSrQqv
   ifX2lIwX4kr2edN5tUVrm2WkGUYLDKdgR4OXChhldvhGAZEvNBdEYV+3n
   CZJ1UEd/aLcP6rnTVYY0oYVVEwVw8ceKYYLavMGaTZpkKkTeQFafyK/1P
   /CI6n6HRm1ARp+3DdHgIEEdiAqDu7uShTQFFiZPE8HtiSSOt0SUOgWIBM
   OjFt3GeQ/DCybRi7E9QmHAtSC1fkigjpLoAl5jvfS6J7pzhS+4Fk3JNnD
   1zTfKV+erwTgnh+cVCRzpJhVcjv0Kpo+hy6GBqeI+B8Xqjxc4RV9Skm54
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="419937294"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="419937294"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 04:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="795068327"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="795068327"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2023 04:25:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 04:25:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 04:25:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 04:25:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 04:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF4MwBOm70/ErPq29FJB5xlz9cXC6gfZSwEleIrzDObQQSm7HSsBKyIHrDpP2TB7s4FJhexdCJQT/P4L7zqzvTs5Tl5w4xW+Xn/abwyKcs5O5UDWMvSimIoNrp7EhuDmli97NrRsr6H/HWLv8ZElW8iSow4VcStnJbDSwl+Dnms5KvBIfbp/xQVt+XbWaCkI8UWTIjmSK5FLlfqZMUsG7/Kc3tycBYlylxaJd30XSyBmKXxWCmIJQ27Cp6JnQa57IDobVKGo37I3oCuhsB5l2g/m49DspqTYKhTH6v91yBg7KpbfXQTN6xJLsB6Mh5svyCL7+d9GpvodycLGcJzzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loQkGNXghUhUwcuriELEG/zwO2AtkekqEwpJNQsCk2s=;
 b=LeyNUuI9WowcjU00pTA7mnaAZh6lyzvxpzIUeUQJ7w1SaBg25dCcmvBq4EkqlXkX2nIsS2FHTEsQntxYwWl+DKEgv6imT7/7tK91LxknjYDZ6xd+zTQfyxLQFeizgL0xZ3uj+uyzvObHLOulKKBRg7qaroQpiWEurA3aV5r9EqLbENXizvkHGdHxSDVlf6AzVw5CthhzCK/o7AvAdsSkVbShEv37k5274F1bUwj5paj6vbRVDg5HF5RaXCCA1HWrVHi04QzppqBrtoZwfqKqOV+U6dymDL8B1Egpj6jM9jYOA5S/VsRuq/9UtYBoqZkPXyjOQIEykpnM3g3Ymujj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 11:25:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 11:25:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Topic: [PATCH v3 00/10] Add Intel VT-d nested translation
Thread-Index: AQHZhBgNtWChyqGR00+u6nwW5Oa+KK9pLIFQgAIypwCAAQtq8A==
Date:   Fri, 26 May 2023 11:25:33 +0000
Message-ID: <BN9PR11MB5276D83EB8A0E1F7428324208C479@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
        <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230525120648.70d954fb.alex.williamson@redhat.com>
In-Reply-To: <20230525120648.70d954fb.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: 8025c8c4-92f9-45e3-9823-08db5ddbebc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMb0PvXZOkKmg3q4Ys1zzwdQ8Dr6sb8yxcQSW7ZtoeHN3uJlZexsNuWegag4Nufkbd47Npl6njgZdpP8T7/H9nLWg6LVi5NnoH7DKprOYEdimdcc9Gqkqml9RWCm7pcK/iTUZMuJrhOG2r2+etTaJkCRoY6GHCaotKSqrdlM3qFYNMJn0NRO3ZGsOseVFrA7RwWNwb7mTcDz9pZmgafUgkhCCi/M+5wnGOT8tmzgLkooLpdHY+rV9TAWrD2WOzybJ3GRWNDpspHgn/tAPqAiB/AdkkPWgOVZ5t87TQAvc9+psYIbQt2omes01kAmlFKfbbwhZp8yxPpJMNobTNejOvFWTOOwATfzAePf+V+b19y9k/zdVxHkKcqMPIqhKNB6iltqTRS9el2WlGSkXxBfZbRzxnQ5UpTETOh/AEtoxgwoka5HF+NaOkt77u/fjESMknfzF9rGF9k8TwlncTRcuJVFgn59ASKtDownJkhUEHDFC3f0hyO53xODk5BOKtq2H7NQ8bz6WLm9Gde1O7vtTsdI41xLS8QoqXDzj4itrhIUrP7MRSjA4tjiMekqDU1PeMWvJ2kVtv44rOXIHhAG29GFCLLK5m/RfNoim7tPG3M0wLSyThWx+D8+QSIAoI3J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(33656002)(38070700005)(86362001)(316002)(54906003)(4326008)(66556008)(6916009)(66476007)(64756008)(76116006)(66946007)(66446008)(478600001)(71200400001)(55016003)(7696005)(8676002)(8936002)(2906002)(7416002)(52536014)(38100700002)(82960400001)(122000001)(5660300002)(186003)(26005)(9686003)(6506007)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hQVWJ4R0NIb3ZKQ2RQcHBNUWdVczU0ZmtkbDBma2ZmQi9RSzY2MDNvaFNy?=
 =?utf-8?B?ZFpvMGdJcHJvOWY0aDB2c1V3ci9OdFBIOFdxU3pvR0dIS1AyS2JoQnVEajM0?=
 =?utf-8?B?Y0drcFN3U3pDNzFYV3lOdDJzcEJ0ZVZZSDRkNTIrK1JSYXFuNjVsN3pEbGE4?=
 =?utf-8?B?UUN3eGV6TllaUU5NZ21mM25BVFZHSDdLNUNRRks2TE9vOTUycU5JVHArcGV0?=
 =?utf-8?B?TFdKbTg4d0xsTklQT3hYS211d29uekViamxDQXZVWUFuOVVheFU4SXpOWmNT?=
 =?utf-8?B?WTd5bzZzeHFBMXpsMnlsT0tuMGoxK3ppL1grc0paMVA5NFJNb09kcDlMSW94?=
 =?utf-8?B?dERKMmdrQUhRVnBWTDAyUDlNMVJsMHNGMmRIcC92YjlYeSszTEw3c1pVcHpQ?=
 =?utf-8?B?cWJEWjR5SVdBS2xPaDluakVFQWhhZnlPSGNmK2VBU1lkZ1k2K0E1REFSVzNk?=
 =?utf-8?B?dkhTVTFPYklLcGtmNjM0RG9sMElzNktjRmxjVFlva3BsNm85c2QrMW9RQ3Za?=
 =?utf-8?B?QW9GWFZ5MWlackpCbkNFbUlxWWdvRnh0N1Vvb1c5YmVsd2plL3JRT0s5Q2NP?=
 =?utf-8?B?eURGaThPTytHTUxNQVZlakRqTWMzT1pMOXliL0ZPZTBmM1NNTnM1MC9EVUFH?=
 =?utf-8?B?dm9DenBVTkt2ZHllQ1lRbUtjbThzN3dwUitGV3JrZjhMNFdlNGo1ZGY4QnlK?=
 =?utf-8?B?U1dBY1RTVWxaa1Boa3phbGY1bUJEVTRZelZQVFpIUXFIOEEyZG9OVUllejZ0?=
 =?utf-8?B?NjVFUmNzNUFzL0ppbTRVdUx5c3BMd1J1UnYwNk93WGl2Qk5kRjZtV1FKL0tz?=
 =?utf-8?B?QzNBZ0lvNnhTd0E4eFI5bW13V3ZkcEJTY2tsQTRrcmpjYk8zVm51S0cwU0dH?=
 =?utf-8?B?a1liWUFZS25iNGMwMjlCRUY1UlpTMWJJTVNYbnA3djNDSkJPcGxTOExpWk1z?=
 =?utf-8?B?d3hJT2hrc3JZUWFRUC82a2Zja1NqMWlzd0p0TVByZlUrcmxFUUUvakVvTm0x?=
 =?utf-8?B?VitlT2ZkWGJsM3kxYkFJOGhkWlNHc1RTeGloc05acDlYU1FIRm51dnl1YTdR?=
 =?utf-8?B?NitCSEhyYXpZb0pZcmVTdmpDVjlYeHNFTWFXYjExOS9zd0lQTVJQVXc1WGRK?=
 =?utf-8?B?K0gzTGtnMG1UeUV2cFc0WTVhRUw3QnBwNkpkSnc2M2pKRFhWS3hRaitxa1dx?=
 =?utf-8?B?Um1TS3Zlb1JJcm1XWkVWWE91cDhYTm1QWXhuZFBwSnNhRmlaUFk3SUN0ZXlS?=
 =?utf-8?B?Um9BTjV5V1Q3SmsrdHlkL3lDZkVUdmdWK3JYYld4SmRISnJBU1lIZkYxcXN6?=
 =?utf-8?B?WVA0NlNKZEpQQ3JhbHpkSnJzZGdpRDlTdUY4K2xlZE1HRy9Ca3FxT285VHQv?=
 =?utf-8?B?cXZYeFFRemsrcnBBd3JPcUZSTUNqblRDWTFsdzB2UG5lTlhwSk5WdUl4dmtH?=
 =?utf-8?B?elo4RUR4ck1yb2szeEJPeWFCb1lUc0wwRGhSN0o2RU9DNFFzajNrQ0UxaVBZ?=
 =?utf-8?B?c3NLUFBPTDJ3enJtRDBpS1h4Ui9HOXMzU1kyNHVINWFueDk5Y2crYUVQV3M2?=
 =?utf-8?B?T3N3WVFjYlZmMGkwT0pTWW1ESXZDUWRZVGJUOFpheDE3TXJzMXFkUWtoMS9N?=
 =?utf-8?B?TjFkVFA5RFhpbTgzZzBOdC9FVlI2Sy91Y3Voa0RacVdOSGZ3THIvR0NxNC9x?=
 =?utf-8?B?c3I4RVJ5bXoxSVRCUnYvcURiV3Q4b1B5UnFrSHBYRTU5bE5HNS9TKzhyYWo4?=
 =?utf-8?B?WUxmTFlXcmxzSWJraDJvNFc1N2RIclRjSUpyaTBBVlZyT1AwTUhTQkIrU3cr?=
 =?utf-8?B?K3dKT0lGWkJnUkFZd2JwejBWNzc1ckVCSE9EMmNheVBvMWM1VnVZenRrZ3Ur?=
 =?utf-8?B?aHdoR1ZnR0RxWStTYWxKeFFqUnA3aGpwZE9zb2MvMUlyMG16MVJrMlFTS2du?=
 =?utf-8?B?TjBRb2lwQVNtbnQ5ZHoyeTNvTGNlcXRocUU5NndHT2NJRnVLbGpXVTQzMXhJ?=
 =?utf-8?B?VzNKK1pPalQwNzRBajdxK0tubzRzUXMxQjVTVXJqcHBLWitzbndPRno0RXcv?=
 =?utf-8?B?dlBFNmsyWUNMRjdFL0dmWldBKy9rMkJGQUVLbS9XaGx0dEI2MFVkQlVHOW4z?=
 =?utf-8?Q?1Nskpm+URkghVOqvdDHyQZ+ml?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8025c8c4-92f9-45e3-9823-08db5ddbebc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 11:25:33.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TzikcBNTRm221lfAI/Atp7LslHg3PzWWrWK5Pxxp/EHier1fVYZULP2cjPOL5t8aGjcfsas0VWiPcGmSPSPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPiBT
ZW50OiBGcmlkYXksIE1heSAyNiwgMjAyMyAyOjA3IEFNDQo+IA0KPiBPbiBXZWQsIDI0IE1heSAy
MDIzIDA4OjU5OjQzICswMDAwDQo+ICJUaWFuLCBLZXZpbiIgPGtldmluLnRpYW5AaW50ZWwuY29t
PiB3cm90ZToNCj4gDQo+ID4gPiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTEsIDIwMjMgMTA6NTEgUE0NCj4gPiA+DQo+ID4g
PiBUaGUgZmlyc3QgSW50ZWwgcGxhdGZvcm0gc3VwcG9ydGluZyBuZXN0ZWQgdHJhbnNsYXRpb24g
aXMgU2FwcGhpcmUNCj4gPiA+IFJhcGlkcyB3aGljaCwgdW5mb3J0dW5hdGVseSwgaGFzIGEgaGFy
ZHdhcmUgZXJyYXRhIFsyXSByZXF1aXJpbmcgc3BlY2lhbA0KPiA+ID4gdHJlYXRtZW50LiBUaGlz
IGVycmF0YSBoYXBwZW5zIHdoZW4gYSBzdGFnZS0xIHBhZ2UgdGFibGUgcGFnZSAoZWl0aGVyDQo+
ID4gPiBsZXZlbCkgaXMgbG9jYXRlZCBpbiBhIHN0YWdlLTIgcmVhZC1vbmx5IHJlZ2lvbi4gSW4g
dGhhdCBjYXNlIHRoZSBJT01NVQ0KPiA+ID4gaGFyZHdhcmUgbWF5IGlnbm9yZSB0aGUgc3RhZ2Ut
MiBSTyBwZXJtaXNzaW9uIGFuZCBzdGlsbCBzZXQgdGhlIEEvRCBiaXQNCj4gPiA+IGluIHN0YWdl
LTEgcGFnZSB0YWJsZSBlbnRyaWVzIGR1cmluZyBwYWdlIHRhYmxlIHdhbGtpbmcuDQo+ID4gPg0K
PiA+ID4gQSBmbGFnIElPTU1VX0hXX0lORk9fVlREX0VSUkFUQV83NzI0MTVfU1BSMTcgaXMgaW50
cm9kdWNlZCB0bw0KPiA+ID4gcmVwb3J0DQo+ID4gPiB0aGlzIGVycmF0YSB0byB1c2Vyc3BhY2Uu
IFdpdGggdGhhdCByZXN0cmljdGlvbiB0aGUgdXNlciBzaG91bGQgZWl0aGVyDQo+ID4gPiBkaXNh
YmxlIG5lc3RlZCB0cmFuc2xhdGlvbiB0byBmYXZvciBSTyBzdGFnZS0yIG1hcHBpbmdzIG9yIGVu
c3VyZSBubw0KPiA+ID4gUk8gc3RhZ2UtMiBtYXBwaW5nIHRvIGVuYWJsZSBuZXN0ZWQgdHJhbnNs
YXRpb24uDQo+ID4gPg0KPiA+ID4gSW50ZWwtaW9tbXUgZHJpdmVyIGlzIGFybWVkIHdpdGggbmVj
ZXNzYXJ5IGNoZWNrcyB0byBwcmV2ZW50IHN1Y2ggbWl4DQo+ID4gPiBpbiBwYXRjaDEwIG9mIHRo
aXMgc2VyaWVzLg0KPiA+ID4NCj4gPiA+IFFlbXUgY3VycmVudGx5IGRvZXMgYWRkIFJPIG1hcHBp
bmdzIHRob3VnaC4gVGhlIHZmaW8gYWdlbnQgaW4gUWVtdQ0KPiA+ID4gc2ltcGx5IG1hcHMgYWxs
IHZhbGlkIHJlZ2lvbnMgaW4gdGhlIEdQQSBhZGRyZXNzIHNwYWNlIHdoaWNoIGNlcnRhaW5seQ0K
PiA+ID4gaW5jbHVkZXMgUk8gcmVnaW9ucyBlLmcuIHZiaW9zLg0KPiA+ID4NCj4gPiA+IEluIHJl
YWxpdHkgd2UgZG9uJ3Qga25vdyBhIHVzYWdlIHJlbHlpbmcgb24gRE1BIHJlYWRzIGZyb20gdGhl
IEJJT1MNCj4gPiA+IHJlZ2lvbi4gSGVuY2UgZmluZGluZyBhIHdheSB0byBhbGxvdyB1c2VyIG9w
dC1vdXQgUk8gbWFwcGluZ3MgaW4NCj4gPiA+IFFlbXUgbWlnaHQgYmUgYW4gYWNjZXB0YWJsZSB0
cmFkZW9mZi4gQnV0IGhvdyB0byBhY2hpZXZlIGl0IGNsZWFubHkNCj4gPiA+IG5lZWRzIG1vcmUg
ZGlzY3Vzc2lvbiBpbiBRZW11IGNvbW11bml0eS4gRm9yIG5vdyB3ZSBqdXN0IGhhY2tlZA0KPiBR
ZW11DQo+ID4gPiB0byB0ZXN0Lg0KPiA+ID4NCj4gPg0KPiA+IEhpLCBBbGV4LA0KPiA+DQo+ID4g
V2FudCB0byB0b3VjaCBiYXNlIG9uIHlvdXIgdGhvdWdodHMgYWJvdXQgdGhpcyBlcnJhdGEgYmVm
b3JlIHdlDQo+ID4gYWN0dWFsbHkgZ28gdG8gZGlzY3VzcyBob3cgdG8gaGFuZGxlIGl0IGluIFFl
bXUuDQo+ID4NCj4gPiBPdmVyYWxsIGl0IGFmZmVjdHMgYWxsIFNhcHBoaXJlIFJhcGlkcyBwbGF0
Zm9ybXMuIEZ1bGx5IGRpc2FibGluZyBuZXN0ZWQNCj4gPiB0cmFuc2xhdGlvbiBpbiB0aGUga2Vy
bmVsIGp1c3QgZm9yIHRoaXMgcmFyZSB2dWxuZXJhYmlsaXR5IHNvdW5kcyBhbiBvdmVya2lsbC4N
Cj4gPg0KPiA+IFNvIHdlIGRlY2lkZSB0byBlbmZvcmNlIHRoZSBleGNsdXNpdmUgY2hlY2sgKFJP
IGluIHN0YWdlLTIgdnMuIG5lc3RpbmcpDQo+ID4gaW4gdGhlIGtlcm5lbCBhbmQgZXhwb3NlIHRo
ZSByZXN0cmljdGlvbiB0byB1c2Vyc3BhY2Ugc28gdGhlIFZNTSBjYW4NCj4gPiBjaG9vc2Ugd2hp
Y2ggb25lIHRvIGVuYWJsZSBiYXNlZCBvbiBpdHMgb3duIHJlcXVpcmVtZW50Lg0KPiA+DQo+ID4g
QXQgbGVhc3QgdGhpcyBsb29rcyBhIHJlYXNvbmFibGUgdHJhZGVvZmYgdG8gc29tZSBwcm9wcmll
dGFyeSBWTU1zDQo+ID4gd2hpY2ggbmV2ZXIgYWRkcyBSTyBtYXBwaW5ncyBpbiBzdGFnZS0yIHRv
ZGF5Lg0KPiA+DQo+ID4gQnV0IHdlIGRvIHdhbnQgdG8gZ2V0IFFlbXUgc3VwcG9ydCBuZXN0ZWQg
dHJhbnNsYXRpb24gb24gdGhvc2UNCj4gPiBwbGF0Zm9ybSBhcyB0aGUgd2lkZWx5LXVzZWQgcmVm
ZXJlbmNlIFZNTSENCj4gPg0KPiA+IERvIHlvdSBzZWUgYW55IG1ham9yIG92ZXJzaWdodCBiZWZv
cmUgcHVyc3Vpbmcgc3VjaCBjaGFuZ2UgaW4gUWVtdQ0KPiA+IGUuZy4gaGF2aW5nIGEgd2F5IGZv
ciB0aGUgdXNlciB0byBvcHQtb3V0IGFkZGluZyBSTyBtYXBwaW5ncyBpbiBzdGFnZS0yPw0KPiDw
n5iKDQo+IA0KPiBJIGRvbid0IGZlZWwgbGlrZSBJIGhhdmUgZW5vdWdoIGluZm8gdG8ga25vdyB3
aGF0IGNvbW1vbiBzY2VuYXJpb3MgYXJlDQo+IGdvaW5nIHRvIG1ha2UgdXNlIG9mIDItc3RhZ2Ug
YW5kIG5lc3RlZCBjb25maWd1cmF0aW9ucyBhbmQgaG93IGxpa2VseSBhDQo+IHVzZXIgaXMgdG8g
bmVlZCBzdWNoIGFuIG9wdC1vdXQuICBJZiBpdCdzIGxpa2VseSB0aGF0IGEgdXNlciBpcyBnb2lu
Zw0KPiB0byBlbmNvdW50ZXIgdGhpcyBjb25maWd1cmF0aW9uLCBhbiBvcHQtb3V0IGlzIGF0IGJl
c3QgYSB3b3JrYXJvdW5kLg0KPiBJdCdzIGEgc2lnbmlmaWNhbnQgc3VwcG9ydCBpc3N1ZSBpZiBh
IHVzZXIgbmVlZHMgdG8gZ2VuZXJhdGUgYSBmYWlsdXJlDQo+IGluIFFFTVUsIG5vdGljZSBhbmQg
ZGVjaXBoZXIgYW55IGxvZyBtZXNzYWdlcyB0aGF0IGZhaWx1cmUgbWF5IGhhdmUNCj4gZ2VuZXJh
dGVkLCBhbmQgdGFrZSBhY3Rpb24gdG8gaW50cm9kdWNlIHNwZWNpZmljIGNoYW5nZXMgaW4gdGhl
aXIgVk0NCj4gY29uZmlndXJhdGlvbiB0byBzdXBwb3J0IGEgdXNhZ2UgcmVzdHJpY3Rpb24uDQoN
ClRoYW5rcy4gVGhpcyBpcyBhIGdvb2QgcG9pbnQuDQoNCj4gDQo+IEZvciBRRU1VIEkgbWlnaHQg
bGVhbiBtb3JlIHRvd2FyZHMgYW4gZWZmb3J0IHRvIGJldHRlciBmaWx0ZXIgdGhlDQo+IG1hcHBp
bmdzIHdlIGNyZWF0ZSB0byBhdm9pZCB0aGVzZSByZWFkLW9ubHkgcmFuZ2VzIHRoYXQgbGlrZWx5
IGRvbid0DQo+IHJlcXVpcmUgRE1BIG1hcHBpbmdzIGFueXdheS4NCg0KV2UgdGhvdWdodCBhYm91
dCBoYXZpbmcgaW50ZWwtdmlvbW11IHRvIHJlZ2lzdGVyIGEgZGlzY2FyZCBtZW1vcnkNCm1hbmFn
ZXIgdG8gZmlsdGVyIGluIGNhc2UgdGhlIGtlcm5lbCByZXBvcnRzIHRoaXMgZXJyYXRhLg0KDQpP
dXIgb3JpZ2luYWxseSB0aG91Z2h0IHdhcyB0aGF0IGV2ZW4gd2l0aCBpdCB3ZSBtYXkgc3RpbGwg
d2FudCB0bw0KZXhwbGljaXRseSBsZXQgdXNlciB0byBvcHQgZ2l2ZW4gdGhpcyBjb25maWd1cmF0
aW9uIGRvZXNuJ3QgbWF0Y2ggdGhlDQpiYXJlIG1ldGFsLiBCdXQgd2l0aCB5b3VyIGV4cGxhbmF0
aW9uIHByb2JhYmx5IGRvaW5nIHNvIGluc3RlYWQNCmNhdXNlcyBtb3JlIHRyb3VibGUgdGhhbiB3
aGF0IGl0IHRyaWVzIHRvIGFjaGlldmUuDQoNCj4gDQo+IEhvdyBtdWNoIGRvZXMgdGhpcyBhZmZl
Y3QgYXJiaXRyYXJ5IHVzZXJzcGFjZSB2ZmlvIGRyaXZlcnM/ICBGb3INCj4gZXhhbXBsZSBhcmUg
dGhlcmUgc2NlbmFyaW9zIHdoZXJlIHJ1bm5pbmcgaW4gYSBWTSB3aXRoIGEgdklPTU1VDQo+IGlu
dHJvZHVjZXMgbmVzdGVkIHN1cHBvcnQgdGhhdCdzIHVua25vd24gdG8gdGhlIHVzZXIgd2hpY2gg
bm93IHByZXZlbnRzDQo+IHRoaXMgdXNhZ2U/ICBBbiBleGFtcGxlIG1pZ2h0IGJlIHJ1bm5pbmcg
YW4gTDIgZ3Vlc3Qgd2l0aCBhIHZlcnNpb24gb2YNCj4gUUVNVSB0aGF0IGRvZXMgY3JlYXRlIHJl
YWQtb25seSBtYXBwaW5ncy4gIElmIG5lY2Vzc2FyeSwgaG93IHdvdWxkIGxhY2sNCj4gb2YgcmVh
ZC1vbmx5IG1hcHBpbmcgc3VwcG9ydCBiZSBjb252ZXllZCB0byB0aG9zZSBuZXN0ZWQgdXNlIGNh
c2VzPw0KDQpUbyBlbmFibGUgbmVzdGVkIHRyYW5zbGF0aW9uIGl0J3MgZXhwZWN0ZWQgdG8gaGF2
ZSB0aGUgZ3Vlc3QgdXNlDQpzdGFnZS0xIHdoaWxlIHRoZSBob3N0IHVzZXMgc3RhZ2UtMi4gU28g
dGhlIEwwIFFFTVUgd2lsbCBleHBvc2UNCmEgdklPTU1VIHdpdGggb25seSBzdGFnZS0xIGNhcGFi
aWxpdHkgdG8gTDEuDQoNCkluIHRoYXQgY2FzZSBpdCdzIHBlcmZlY3RseSBmaW5lIHRvIGhhdmUg
Uk8gbWFwcGluZ3MgaW4gc3RhZ2UtMSBubw0KbWF0dGVyIHdoZXRoZXIgTDEgZnVydGhlciBjcmVh
dGUgTDIgZ3Vlc3QgaW5zaWRlLg0KDQpUaGVuIG9ubHkgTDAgUUVNVSBuZWVkcyB0byBjYXJlIGFi
b3V0IHRoaXMgUk8gdGhpbmcgaW4gc3RhZ2UtMi4NCg0KSW4gY2FzZSBMMCBRRU1VIGV4cG9zZXMg
YSBsZWdhY3kgdklPTU1VIHdoaWNoIHN1cHBvcnRzIG9ubHkgc3RhZ2UtMg0KdGhlbiBuZXN0aW5n
IGNhbm5vdCBiZSBlbmFibGVkLiBJbnN0ZWFkIGl0IHdpbGwgZmFsbGJhY2sgdG8gdGhlIG9sZA0K
c2hhZG93aW5nIHBhdGggdGhlbiBSTyBtYXBwaW5nIGZyb20gZ3Vlc3QgZG9lc24ndCBtYXR0ZXIg
ZWl0aGVyLg0KDQpFeHBvc2luZyBhIHZJT01NVSB3aGljaCBzdXBwb3J0cyBib3RoIHN0YWdlLTEv
c3RhZ2UtMi9uZXN0aW5nDQppcyBhbm90aGVyIHN0b3J5LiBCdXQgSSBiZWxpZXZlIGl0J3MgZmFy
IGZyb20gd2hlbiB0aGlzIGJlY29tZXMgdXNlZnVsDQphbmQgaXQncyByZWFzb25hYmxlIHRvIGp1
c3QgaGF2ZSBMMCBRRU1VIG5vdCBzdXBwb3J0IHRoaXMgY29uZmlndXJhdGlvbg0KYmVmb3JlIHRo
aXMgZXJyYXRhIGlzIGZpeGVkLiDwn5iKDQoNClRoYW5rcywNCktldmluDQo=
