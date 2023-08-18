Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FB780263
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 02:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356411AbjHRAGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 20:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356530AbjHRAGM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 20:06:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED3A3AB0;
        Thu, 17 Aug 2023 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692317141; x=1723853141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ci1t1l46Rvz80G/1kKza5CV94PPNe96/g66chm9bTfw=;
  b=Slk/cilcE1VW8JvKQBHV7BsMSw791ASestRNDs+oId9RY+Es0Yo8zNQK
   EcYp+M4rNQ+JjqfNX2LZEHMvJgTTVJyo1/voHV1gAnlnnWbTiK6yE2XX2
   rES6T9IgaFvGJ6x+SFkOZ5ihMEt32g+uIAmYV+BIcBDwq/xbQyYuL+m3v
   T3EADKD/AaNIb0poUXXFrE2fViQms1vYtU0uV0e2zt0zEGx752WrMi5gS
   js4RhdWHPg+GOtFXR59S2N1jCeVO6Bs47w0TaHorsO/TuQVRWBe1f5iaB
   lJvYy4W/1hECxW/RY/RN1TgKfWtlgrf12UDZ1r6yjHUqsazIsXvp1DhVP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403947851"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="403947851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764319124"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="764319124"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 17:04:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 17:04:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 17:04:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 17:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqY67E7U7FbJ/0f91zsth5WEmsIkDwFgxNwhYQHC4IhOx/w/h80LwItt00fSqm+Tt+Tx0pdP40xPj0VcTeTHAeoUBPyM3tVqadU0JzNaHwbnUrw0wX6NueGQAqUPbX9GL0Od2jG21piiYSRBkXrMa+J24oYP6bgaYhFJvFE6owV2JITljW9j40ubcM+GLjLwb76PiP7J1vjjJ111034GD5Gw7EiP6X/cXJXvG+1gmzg1tSoFf3R3PAuh+tPjv3zOMOB+evImokB4OIqgCuEwAeNJkOsC1uzo8BMNNDCW0ILlwR49ojJaVCG6yYKD07dTAMz59XrE2FzK6R0sRMWrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci1t1l46Rvz80G/1kKza5CV94PPNe96/g66chm9bTfw=;
 b=CbrcRY/fivl2SWthyPqcDTXKfqjV6w1H6SLP6fs72PDbe3VD5FZjYst4OHbQM38gorRSQ9k77NzOiJSEdktMKdcGSiLx7PyknfYZ0BOda2x2In7y/DYNIi8bDTCrP5o2ZWjPDPSZ5ok5Z/qWqLmnqNFq3QsIEZkqDqh9uk3PlKi9vZpEnAHRtl5WkAE2oguqw1N3jPGGBHSTirLu5J3rGrHwGTO2CjGGoNiNn5yQjQTNibutKXHFlLXUrEAwCGHAtPyvPVmkiA1Z/B8D0TfKTMnmkbKK2Y5iN7emCdt0HL9otb4hTe+tsoJ02anJL2Xq7pyKE0UhtlL4VgPJw5jXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 00:04:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::88db:59ea:ce73:7705%7]) with mapi id 15.20.6678.025; Fri, 18 Aug 2023
 00:04:30 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZ0DsuegTRGPJbR0SXCJLfw2ux6K/uGUUAgADkCwCAADDBoA==
Date:   Fri, 18 Aug 2023 00:04:29 +0000
Message-ID: <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
In-Reply-To: <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS0PR11MB6400:EE_
x-ms-office365-filtering-correlation-id: e36094b4-6bce-4795-ef28-08db9f7eb156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiZoKlP810PqgkMxQ+lOZy4zLmOQuYMyGI7D5qij/ZwUAdDAlFa3uDfgrtVlEWcAsFULXoiObUiaT21TxJ97Rzj3i+LekI3q9uUz+YuncucaCcU/sKkhn43UEWCyRZwohq2r3timG8FYsIu23PGRgnUg/9Q5BTTzq1tixSj68zTd8xNY+/98N0/15LSv66HT/E4NYrnAHQDDKhQLZt4I3Aj2s5jKMjLP44Qe1K8AuhZjNJPm1gunIX86wWXOf9JcQ72Nyx+AF4KWCDLYScNkM1nPreC+LybShGlGbypcOwBSZaghtuUTwhj5TFtmAut3vtm2nnm16GjBBG6ZQkAKCINqW2ZC0w2pZPn64fJxpRgR59a1+8YO1cHxYdj+zHYCHdiZP7ByCCa86Ft9SBWjxOJv6bT1uDITyn6aTyNyC20q0fF9CM073c7wK/7VqUsTufleJv9+HbN26TyZ3Y1IxgWCva3w2tJfRgCDbfOwe6WgwrJsENCZXwErVom4dcRxAxQyZnxFiwVF2O9jiIQyui40CiHL95CFU6lmVhWFBB9y3lLrODs5qbcyQGL1PJrPHBdlVdSIQpgvjrYlTwibnDSlnBIfrYlk4PEqoxhkMGfgf5M3jEeKgdG0Pi8yDmuH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(55016003)(7416002)(2906002)(83380400001)(66946007)(76116006)(6506007)(66446008)(66556008)(66476007)(26005)(7696005)(54906003)(64756008)(316002)(6636002)(71200400001)(478600001)(5660300002)(52536014)(110136005)(9686003)(41300700001)(8936002)(8676002)(4326008)(86362001)(33656002)(38100700002)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bElvZ1pqNjFoU0w3eE9WTGRhRVJXVGEyanpiTGNaL2d6bjN4cnhGQ0tsQWFF?=
 =?utf-8?B?ZzJhZWx1bWNaUnpYK3VZSk4yMzZFa21sOTFxVFRiVEpaenNxYzBScnM5TGoy?=
 =?utf-8?B?M3lBTjlyOWJjMEJUT0RpYUtGc09ZOFQ5QitsQmhQRk9SOGthcDlGZzhGNEh4?=
 =?utf-8?B?VWJaRXZNVnBzWDZOMU1kQ3lUWVk2aWdjVDZLQkVveE5UWGtjSG55QldkeGpL?=
 =?utf-8?B?QTdDeHJtQnBkczZReUtJZERUaFU1aUhRajk4djZjaVUvVm8wQXJNTTBidDJL?=
 =?utf-8?B?Z1d4cWZDT1VYRDR4QmNmK2lRdU1vcVR3cUlibTlWK1FzemFrZlhrOXU4eUxH?=
 =?utf-8?B?M1pOQTNQUW4wOG1pM2RDcncxUWNyTEY1bUsrR2szU2pkV1dLQ1BpVm5Nd2k2?=
 =?utf-8?B?WGpHOUxzK092TmllSW9hSnowelo1QkwzNGVndXlCU25aUXo5eVlNV0ZjdFFG?=
 =?utf-8?B?alBYQklHTithL0hiUEVRSldWRkdxL01qR2dqTStFZmQ2UFhBNndnMXdyaklF?=
 =?utf-8?B?NFVmcGNKL3ZvVCtNWnk1bnh6U1pNR1NRLzU4T0k4eTIxZmh5SzNoR3VIaHVY?=
 =?utf-8?B?VDAvUXo3MXVlbCt3eFZEYjlIeTQwMkpCNEp5RDIzVDU3V0JrWi83SXZoakZM?=
 =?utf-8?B?dDlTUDJSOGV5MitsMFk4WUFtaHc1dVRCcDdyak1uMm5xQi9KK1hsU0I3ZlUz?=
 =?utf-8?B?WXVRdHJQU0tFTEt3T0NDZGdSZnUybXZEVVY3RjRYU0hWRXRxTkZlUXF0WTQ5?=
 =?utf-8?B?NGEyYWlwZzBMZjdIUTFRNFNDNG9uMU5VTDJWUTFQeUFNd28zKy9VNWNpb0pH?=
 =?utf-8?B?TzRtSGRpSXJ6RHFsbFlSVFRXOHdZcTlNakdEV0UvVnZIajkwcGxIZllRdm1T?=
 =?utf-8?B?SWhIQkFhZDI5SjhJRno5dXlrUnRlU0E1ZHhUZlBmRmZjS1cyMTdxSkZkdUxL?=
 =?utf-8?B?UFc1Wmg1S09UYjBPRWNiTmd1WEF3WVZqSktwNWI3cFJ0RmtobkdmYXN0WUlr?=
 =?utf-8?B?UlBWVUdxRUxvWVJVdUJnQXZKU0tHZWVHVFY0TTJ6RHRMbU9kV2MzQVo5cjE2?=
 =?utf-8?B?VitNdzlyeS9PWnRadEJwaFg1cXJEV1ltSTNnYitVQlZsT2FJZi9EWEk3NUhB?=
 =?utf-8?B?aTBJbmQwVEw1WlF2QWdvekoxMzRuRVpHSWdWUWhEejBYT0NxR0hqRzZZbWlB?=
 =?utf-8?B?dFRmWllxTWZnQWIwckpDM2w3bzNMKzhWZ1pndnlZcHJ2clQxUkNydG5rWjBG?=
 =?utf-8?B?L25oWklhcWkwMjZOeG9LWDhseU55TWZaV2QvM2pjVXZLdkR0QWphYXVqRHVn?=
 =?utf-8?B?RXNkY2hFaDloRzk0QTVwWDJJazlIc0J1TTh4WHFleHlSVlhjbHJRVjBmUEt0?=
 =?utf-8?B?ckMrR1pwNlMzbUxsZ1QwdUhXdEp4aXI1UU5EOUNQaHRHamhZQWpNOWgyV0pK?=
 =?utf-8?B?MGtDZ3AvMVNxNmhVRTRhK05hamFTNWNCZVUzclVxS1R0WkI2M0F2R3Q2Y0pn?=
 =?utf-8?B?QjBSb1FBbXFFbHl5WFpaUCtVSW9vU0MxQU1ab1BtRHRYd01GOC9RcjJibVB0?=
 =?utf-8?B?VUtvd2RyWkNRRldJVjRiRGFUcjdOVDVCdDR2Wk1aUVJSM1d5REpFYXNGSmJF?=
 =?utf-8?B?dCtIZ3ZVWER2cXlhYWJXelFDdThOclgrb0ZjTks5Qzgyd2gyOEZkcEgyZU1L?=
 =?utf-8?B?cDZ3ckFnc1BiK3J5dkM3ZEhRUHArNkM5aU96NGFDL1UxOHV3K0VqTjVLRUlK?=
 =?utf-8?B?enlreUE0WG1zM3BqWHIwTTJnL3paVXdoSkdrbUN5VjN3QXhETVlzQVliTmZi?=
 =?utf-8?B?aFc3czNKL214dUJ4TUJUU0dSOHZsbEl1TTRYKy9SN2NzUTFvbzYxeUdZZk5j?=
 =?utf-8?B?bDFVZ0pqeGtTOG1VWGNMbklNSC9XeXZWMUd3WTF2OXA1eld5SjNuS0U3dE9S?=
 =?utf-8?B?UDNGZ2g5TzFWWUlzOEJYNHNHdnJPZjNsVUhlNVlpaGpNY0hmNmQ3dldqZHZh?=
 =?utf-8?B?NEZGWTNTT1NzdW5RNi9zczgzcUVldWtKbTYzcEFVc29ZVU1Ob0laOGNqMlFW?=
 =?utf-8?B?WXBVeGI4bGZYanhHY2Eza3BVRzVtbE9WV0RuemZZdXVuMWwxL3VjekQwUTE4?=
 =?utf-8?Q?QJzea3eDhPRiQn/BpldaPrPlH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36094b4-6bce-4795-ef28-08db9f7eb156
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 00:04:29.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gh/ivF9k2k3VffK/5JpY33we9ZxuOHMRHQKpjYlvi5q90jrt5GzkGIXxHP/FFoHiEaWh0v3HSDEy85Vto8l7lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgQXVndXN0IDE4LCAyMDIzIDU6MDggQU0NCj4gDQo+IExvb2tzIGxpa2UgWWkncyBsYXRlc3Qg
Y29kZSBoYXMgbm90IGFkZHJlc3NlZCB0aGVzZSBjb21tZW50cy4NCg0KWWVhaC4gTm90IHlldC4g
SW4gcHJvZ3Jlc3MgdG8gaW5jb3Jwb3JhdGUgdGhlbS4g8J+Yig0KDQo+IA0KPiBPbiBUaHUsIEF1
ZyAxNywgMjAyMyBhdCAwNzozMTo0MkFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gDQo+
ID4gPiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgQXVndXN0IDE2LCAyMDIzIDg6MTQgUE0NCj4gPiA+DQo+ID4gPiBVbmRlciBuZXN0
ZWQgSU9NTVUgdHJhbnNsYXRpb24sIHVzZXJzcGFjZSBvd25zIHRoZSBzdGFnZS0xIHRyYW5zbGF0
aW9uDQo+ID4gPiB0YWJsZSAoZS5nLiB0aGUgc3RhZ2UtMSBwYWdlIHRhYmxlIG9mIEludGVsIFZU
LWQgb3IgdGhlIGNvbnRleHQgdGFibGUgb2YNCj4gPiA+IEFSTSBTTU1VdjMsIGFuZCBldGMuKS4g
U3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZXMgYXJlIHZlbmRvciBzcGVjaWZpYywgYW5kDQo+ID4g
PiBuZWVkIHRvIGJlIGNvbXBhdGlibGUgd2l0aCB0aGUgdW5kZXJseWluZyBJT01NVSBoYXJkd2Fy
ZS4gSGVuY2UsDQo+ID4gPiB1c2Vyc3BhY2UNCj4gPiA+IHNob3VsZCBrbm93IHRoZSBJT01NVSBo
YXJkd2FyZSBjYXBhYmlsaXR5IGJlZm9yZSBjcmVhdGluZyBhbmQNCj4gPiA+IGNvbmZpZ3VyaW5n
DQo+ID4gPiB0aGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiB0YWJsZSB0byBrZXJuZWwuDQo+ID4gPg0K
PiA+ID4gVGhpcyBhZGRzIElPTU1VX0dFVF9IV19JTkZPIGlvY3RsIHRvIHF1ZXJ5IHRoZSBJT01N
VSBoYXJkd2FyZQ0KPiA+ID4gaW5mb3JtYXRpb24NCj4gPiA+IChhLmsuYSBjYXBhYmlsaXR5KSBm
b3IgYSBnaXZlbiBkZXZpY2UuIFRoZSByZXR1cm5lZCBkYXRhIGlzIHZlbmRvcg0KPiA+ID4gc3Bl
Y2lmaWMsIHVzZXJzcGFjZSBuZWVkcyB0byBkZWNvZGUgaXQgd2l0aCB0aGUgc3RydWN0dXJlIGJ5
IHRoZSBvdXRwdXQNCj4gPiA+IEBvdXRfZGF0YV90eXBlIGZpZWxkLg0KPiA+DQo+ID4gIlRoZSBm
b3JtYXQgb2YgdGhlIHJldHVybmVkIGRhdGEgaXMgdmVuZG9yIHNwZWNpZmljIGFuZCBtdXN0IGJl
IGRlY29kZWQNCj4gPiBhY2NvcmRpbmcgdG8gQG91dF9kYXRhX3R5cGUgZmllbGQiLg0KPiANCj4g
QWNrLg0KPiANCj4gPiA+ICtpbnQgaW9tbXVmZF9nZXRfaHdfaW5mbyhzdHJ1Y3QgaW9tbXVmZF91
Y21kICp1Y21kKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIHN0cnVjdCBpb21tdV9od19pbmZvICpj
bWQgPSB1Y21kLT5jbWQ7DQo+ID4gPiArICAgICB2b2lkIF9fdXNlciAqdXNlcl9wdHIgPSB1NjRf
dG9fdXNlcl9wdHIoY21kLT5kYXRhX3VwdHIpOw0KPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IGlv
bW11X29wcyAqb3BzOw0KPiA+ID4gKyAgICAgc3RydWN0IGlvbW11ZmRfZGV2aWNlICppZGV2Ow0K
PiA+ID4gKyAgICAgdW5zaWduZWQgaW50IGRhdGFfbGVuOw0KPiA+ID4gKyAgICAgdW5zaWduZWQg
aW50IGNvcHlfbGVuOw0KPiA+ID4gKyAgICAgdm9pZCAqZGF0YSA9IE5VTEw7DQo+IFsuLl0NCj4g
PiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gPiArICAgICAgICAgICAgIGNtZC0+b3V0X2RhdGFfdHlw
ZSA9IElPTU1VX0hXX0lORk9fVFlQRV9OT05FOw0KPiA+ID4gKyAgICAgICAgICAgICBkYXRhX2xl
biA9IDA7DQo+ID4gPiArICAgICAgICAgICAgIGRhdGEgPSBOVUxMOw0KPiA+DQo+ID4gZGF0YSBp
cyBhbHJlYWR5IGluaXRpYWxpemVkIGFzIE5VTEwuDQoNClByb2JhYmx5IHdlIGNhbiBzZXQgZGF0
YV9sZW4gPSAwIGFuZCB0aGUgb3V0X2RhdGFfdHlwZSB0byBfTk9ORSBpcw0KdGhlIHRvcCBhcyB3
ZWxsLiBBbnkgcHJlZmVyZW5jZT8NCg0KPiANCj4gV2lsbCBkcm9wLg0KPiANCj4gPiA+ICsNCj4g
PiA+ICsgICAgIC8qDQo+ID4gPiArICAgICAgKiBXZSByZXR1cm4gdGhlIGxlbmd0aCB0aGUga2Vy
bmVsIHN1cHBvcnRzIHNvIHVzZXJzcGFjZSBtYXkga25vdw0KPiA+ID4gd2hhdA0KPiA+ID4gKyAg
ICAgICogdGhlIGtlcm5lbCBjYXBhYmlsaXR5IGlzLiBJdCBjb3VsZCBiZSBsYXJnZXIgdGhhbiB0
aGUgaW5wdXQgYnVmZmVyLg0KPiA+ID4gKyAgICAgICovDQo+ID4gPiArICAgICBjbWQtPmRhdGFf
bGVuID0gZGF0YV9sZW47DQo+ID4gPiArDQo+ID4gPiArICAgICByYyA9IGlvbW11ZmRfdWNtZF9y
ZXNwb25kKHVjbWQsIHNpemVvZigqY21kKSk7DQo+ID4gPiArb3V0Og0KPiA+DQo+ID4gb3V0X2Zy
ZWU6DQo+ID4NCj4gPiA+ICsgICAgIGtmcmVlKGRhdGEpOw0KPiA+ID4gK2Vycl9wdXQ6DQo+ID4N
Cj4gPiBvdXRfcHV0OiAoc2luY2UgdGhpcyBpcyBhbHNvIHVzZWQgaW4gdGhlIHN1Y2Nlc3MgcGF0
aCkNCj4gDQo+IEFjayBmb3IgYm90aC4NCj4gDQo+ID4gPiArICogVG8gY2FwdHVyZSBhbiBpb21t
dSB0eXBlIHNwZWNpZmljIGhhcmR3YXJlIGluZm9ybWF0aW9uIGRhdGEsDQo+ID4gPiBAZGF0YV91
cHRyIGFuZA0KPiA+ID4gKyAqIGl0cyBsZW5ndGggQGRhdGFfbGVuIG11c3QgYmUgcHJvdmlkZWQu
IFRyYWlsaW5nIGJ5dGVzIHdpbGwgYmUgemVyb2VkIGlmIHRoZQ0KPiA+ID4gKyAqIHVzZXIgYnVm
ZmVyIGlzIGxhcmdlciB0aGFuIHRoZSBkYXRhIHRoYXQga2VybmVsIGhhcy4gT3RoZXJ3aXNlLCBr
ZXJuZWwgb25seQ0KPiA+ID4gKyAqIGZpbGxzIHRoZSBidWZmZXIgdXNpbmcgdGhlIGdpdmVuIGxl
bmd0aCBpbiBAZGF0YV9sZW4uIElmIHRoZSBpb2N0bCBzdWNjZWVkcywNCj4gPiA+ICsgKiBAZGF0
YV9sZW4gd2lsbCBiZSB1cGRhdGVkIHRvIHRoZSBsZW5ndGggdGhhdCBrZXJuZWwgYWN0dWFsbHkg
c3VwcG9ydHMsDQo+ID4gPiArICogQG91dF9kYXRhX3R5cGUgd2lsbCBiZSBmaWxsZWQgdG8gZGVj
b2RlIHRoZSBkYXRhIGZpbGxlZCBpbiB0aGUgYnVmZmVyDQo+ID4gPiArICogcG9pbnRlZCBieSBA
ZGF0YV91cHRyLiBJbnB1dCBAZGF0YV9sZW4gPT0gemVybyBpcyBhbGxvd2VkLCBubw0KPiA+ID4g
aW5mb3JtYXRpb24NCj4gPiA+ICsgKiBkYXRhIHdpbGwgYmUgZmlsbGVkIHRvIHVzZXIsIGJ1dCB1
c2VyIHNwYWNlIGNvdWxkIGdldCB0aGUNCj4gPiA+IGlvbW11X2h3X2luZm9fdHlwZQ0KPiA+ID4g
KyAqIGZpbGxlZCBpbiBAb3V0X2RhdGFfdHlwZSBhbmQgdGhlIGlvbW11IGhhcmR3YXJlIGluZm9y
bWF0aW9uIGRhdGENCj4gPiA+IGxlbmd0aA0KPiA+ID4gKyAqIHN1cHBvcnRlZCBieSBrZXJuZWwg
ZmlsbGVkIGluIEBkYXRhX2xlbi4NCj4gPg0KPiA+IEknZCBqdXN0IGtlZXAgIklucHV0IEBkYXRh
X2xlbiA9PSB6ZXJvIGlzIGFsbG93ZWQiIGFuZCByZW1vdmUgYWxsIHRoZQ0KPiA+IHRyYWlsaW5n
IHdvcmRzIHdoaWNoIGp1c3QgZHVwbGljYXRlIHdpdGggdGhlIGZvcm1lciBjb250ZXh0Lg0KPiAN
Cj4gV2lsbCBkby4NCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5A
aW50ZWwuY29tPg0KPiANCj4gQWRkaW5nIHRoaXMuDQo+IA0KPiBUaGFua3MNCj4gTmljDQo=
