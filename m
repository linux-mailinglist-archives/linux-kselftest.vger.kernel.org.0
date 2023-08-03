Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6076DF4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 06:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHCENS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 00:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHCENQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 00:13:16 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E361B6;
        Wed,  2 Aug 2023 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035995; x=1722571995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UUYLJnmknKUcx3qbqpR/l95dzJIApJe8r4PMkVpnb/s=;
  b=CIDFgDa6fu+adNsZi5SNMvk3hO6ChiaRmpUKd4aVEtw/9c4AJzzElM9h
   CMDajDfvnbFAMrwKSUUo1c3SCT4OOmFaQqH2WqbcG/B+Op0gPKY0R7ELa
   7EgiaAtSwp7RTOJcC/8rjM1bsDtH1NZEBe+j8QZ8m+QXq0kwDVbwnz9Yg
   rtq6cLZIfsAN7oW3cu7ySkzn1onjljVhHjrSLmLukEqIZk17hjaLCqEBo
   /Gi+HqPbLCzvcXX0aLSVuLf9kHcUlZiPWbr/f2+OIzd2lk7GjQTDxtF/c
   yEfb83lrjf5BXYxTVZ0sGJvmopdqzKp2ctismCu9x+v7XxumI2fj4aqmR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="400700169"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="400700169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819472152"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="819472152"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 21:13:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:13:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 21:13:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 21:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEZvoxd00X975x/MJ8Zx7HI/Vpu52oEylip/EEETE35cGC91Yp2ZhrG4M5lCRoJ9ZZJ1Az3DiWGH31BsXKYwEm+5cfEAHOiSNNd9N6OwyFFxsYYzJvVqASyzTQf0oRkuXUHpnxRCCFVIP/zyQZh9eFb3jAbMWXei8NeveCOHXmSbicmwe0cAoK+SDK8WrhvUXOELpNLFnKbP9eTP3B9XVyjHqL+c/A/qBx0VCnmcNfyIk6569ZhHtX+cpfZvGTi7yK4J83PtGXQFZIZ6ce+DGZwZ+Z7WLsfPaVIcLtEpsG2U7CCCtDguZ5bliUmiyfNy8OJGfJtH1INfF+qek6M86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUYLJnmknKUcx3qbqpR/l95dzJIApJe8r4PMkVpnb/s=;
 b=jYu4OURfS4s/pOha5qHuzs2mKU1K0DKdIKMIbYbUZDYZ3eJ0gQF3kVaL4WX/iz/OixZTMP9e1MERv0WPlIGltewITAT0E/OzqQ+krVfl+/pce/CUDugqXJbFTaIha99d9FjP8OlzZ5KRAY4cCxX7cMBnOruOsBw/xCJzxvZKqkBhT8wpYee5rlKKsWOXckn+8x2JDpanMT4OAGDCQFtEAeppgPQE256nds/kY6f/VCqpBBpLaS1Wypt6A7VyWWGLcAhzA0H/2Vl2wgB/IpMD4wVKbtDRUed7pieUxiVq5g4uCd4MpCcUIXomyURXNV56IppuzOJ/GAUYMlJZ9b1U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 04:13:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 04:13:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAFKLgCAAAlqAIAAAgeAgAABBrA=
Date:   Thu, 3 Aug 2023 04:13:11 +0000
Message-ID: <BN9PR11MB5276FED948D84DAA81D09C838C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <58ae9095-28f2-a44a-b0e5-be82e1eae9d9@linux.intel.com>
 <BN9PR11MB52764994FB32B2B1CD9C95068C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <40d9b0fa-4a36-c3b7-53bb-4333ff89dc45@linux.intel.com>
In-Reply-To: <40d9b0fa-4a36-c3b7-53bb-4333ff89dc45@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8107:EE_
x-ms-office365-filtering-correlation-id: 84bea76b-f199-4ca6-1f3c-08db93d7f38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyDu2qM1K9wLwBrIeljJHSG+jflzmIeUj/IFhvG7lO4BfHq9PMTZdcr9ChqQrr+Pl36UIpA/jsPD9oH19iHVfXw6qsFR/I/zwN88kJzbmWeK/N930QrhYF1vjoGUBa6KtEM4gz4VZ92HoUKuMl2HAP2kvlCJu4aVeHORGpETDuiEqGuFRcMKAb9wE3bzXPo8/Y2yyOPGOlubbhbf1zQUhw1XvaMHzPSoerftbym2HfzpJo13ALvUWP+ypfUxlMQIc5OrIXfSIzL5eJjj2TpwUoE7Z5kX9P/Toy0W2paVYH8JLFg1h0HlMR6H0ZhFlwj03Qcqw8UHmzWxvQ2MxK/sG9OeF2h9n10rUa01VCS+BSwRnlkvSH3ov1K2HjIHsCWS9puqORwSP7/j6R9BcPgd0JbkgwlCz5H+NiwzZY0crPofqvGX+ldkgCfQ9phMwUS4EB3mHwUH2F8EDmFVtigLWjakTH9uMljl/YjLL6kM48mBgPY6n6cSrRhsjDiPpulhT8bZNZB9AG1zX2iunyYOHmePDWOH+cnhluHB7+thjhzQPrTN531nKi1yZDHVw4OhNv2dsFk4W2QJtpUFj6Als3bN3th2mVlkWaRxgbpO1V+/1GqT5aS88BUbOiEyptLl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(53546011)(6506007)(26005)(186003)(83380400001)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(7416002)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(110136005)(54906003)(55016003)(38100700002)(82960400001)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzdaS2s3TUZJVDVkeGw5UU9LYlk4Z2MrZ3dkdFZaWGV0eUVDa3YyK2VjWlJE?=
 =?utf-8?B?cGFudnVsWkVxMmo5OGxjYm1Yc0FpWnZETGtUaG0wcnJodDBRZElla1BLemVY?=
 =?utf-8?B?YmxhNzRyRFBaYmRLb3I2Q1NOTDNSR3h5NjJxWEJkRjV1Mjk1YUhDMGl0Smtn?=
 =?utf-8?B?WmhxSTlzaUR6MW5tWjR6dk1hZXpPd0EzNzk4bU1rYjNveHdzUTVZRWVEL3h2?=
 =?utf-8?B?REV6WFgyZmNzcklKVGhLRENJMkdWYjd2cWN5WEN5ZmRrU2JLVzNLaTFyQmh2?=
 =?utf-8?B?YnhrcTNSazEvWDh5RzY5akxVc29VbFVqUWpZeCsrM2ZWdEhQdVU4d2VjR1c0?=
 =?utf-8?B?STBxWjhJRDJ2VDk0UU5qT3ZySi9JVXkra1dCNzdDRjJ3a3pOSnAvaWZtME44?=
 =?utf-8?B?QWVqRlBDalJhSXo2MFBCaGxsTFl5WjFkMVVxNXg5aUlZdXM0OWdVb09RWUhC?=
 =?utf-8?B?T2Q1eUFEcU5FVTN3SVVMeFlnRXNWWnhkV1NFVFJ3Ujg1SVZmQUlpVC9aQXdS?=
 =?utf-8?B?aTJEck5za3UydXhGWjBiUGZzeGRaODRwdE1CSkJFV0ROYS9RWUhDMmhsSUVk?=
 =?utf-8?B?RXI3ZFFmVGZJMU5pNnp1Wk9VZE9wMUkwWk96VGhDcCs3MGF2UjFKMThhRDhh?=
 =?utf-8?B?WHhlSjN3U1VLMjFsTVYxL1hMNG1GMFM5N2lGQ0JQQWZERzRYdVg5SldqVWZL?=
 =?utf-8?B?QlpLVHBIUVJkRllrT1AwOVVuTTh4WFRYcTdCbVF1b1dDakU2RG1tOENzeExC?=
 =?utf-8?B?cDN3b3pqTStuQUlucFpLdjlOcG9aWWJwcmJXWkdlKzN0eFFPTVN2ZHE0VDla?=
 =?utf-8?B?MHRNckpydldvQ2wrWTVGRDZmaUxXZnQva2Q4aCs3ZzRqYVhtbWhrZ2JVdzcy?=
 =?utf-8?B?QVJHOEdCbmhUVkZCcm1WaytDVHp0L01JYXk3TTNpdGFOUHlkOFhtcXJxRDVM?=
 =?utf-8?B?ZzNxWlU3aEdIdVl2VzVhNWZMeCtWa1RBNDVjL1V3bFF6NGllOXgrSGgwTDYr?=
 =?utf-8?B?MVAxWG9BYnZsc3k5VklpR2Z4ZHhTbHBXVWxHY1d3UjhIeWdjUXhDc3VaNHB2?=
 =?utf-8?B?UEFEVjFJZUFPQ2U2M1V3UEJBbGIxMkM4a25PV1ZGbnNpbzVReHhZOHg2R0xu?=
 =?utf-8?B?THpkUXhSa0hBWTczejhRZ0xjdXAxb1hEN1VESG50OHFWNkJwYVVwZWlyUTJ2?=
 =?utf-8?B?UXNrMnhXZEVlRmtrMFB4aHl0RHNaZ0FhTi9PSFJVdHFhdG12RDdma1BpcFph?=
 =?utf-8?B?STBGazMrV2RoOTFvZGtrL0hjMk1SVUlUb2NmY2hNTE5lUVRuTkg5cDk1Tk5a?=
 =?utf-8?B?TGRlNk4ySTFodnY4M1ZSTnI4dS9ubjZLL1B2L1M5VVBHaDBFNVVuS1Jwd1ZU?=
 =?utf-8?B?K2dhelcyMzhuQXhQM2RhMTZpMER2T21sdUJlRlVPZXZDL0c5VmxBWlZjcmtj?=
 =?utf-8?B?eDMrK2UyMjNPcE9DMGVSV0l0L0xkbDUycjF2dEZMV1Z2cDRWZDhtZnY2c0tX?=
 =?utf-8?B?bzNmM1lhUkRleWQ1MWE0bFBpZzNPekZrdXZJWHVjZk56WUdYL1JlUDRPNG5D?=
 =?utf-8?B?QUNHWldmUFVGWHNIeVhhTFZ6VFZUL3cwSEdjR1hJalJXRXltWklQcXFZT0Fo?=
 =?utf-8?B?c3NzMG9rd0xTRDdTbkdHMW1Hb1N5TTdGY0FJakZNU0VEZ1BrS0RMNmtzWGhL?=
 =?utf-8?B?RUhZZklNTVNNWjZ2aGdzb1pONWhIYTF2ei9OemZqZ2tmRnlvK0dVZ0E0Qk9n?=
 =?utf-8?B?MXhPelFpdXlaYmxNSnFUQzRYS0FubUo5NU5OQ1kxN0FtVGRSTXZJQ2wyS2RG?=
 =?utf-8?B?WmhVTGV4MlpEMFFaTFR6QTVnYWZzY2E4Z1kyRXUxa3g1M0IzOVdHbnROT3JR?=
 =?utf-8?B?dHYxZGdhYmZnQUxCcThTRTBHNjhDclVsenp0eHpYZzJ5RllSTXk1ZWhqRVZ3?=
 =?utf-8?B?cUhIbXg4SEhSTTdFS0NhSzA1ZkRPdXVaQi9LdGkrcGV3dlBkQTNXYjZZQjVB?=
 =?utf-8?B?N212KytTMWZFZktndUk1aVVBR0diMjJEdUdNWUQ3NTBsWEw4ckZyRkVYZnM0?=
 =?utf-8?B?QzVBUW5sejNDbzVqdWpQRWdQU1hVdHJvVEkvdFEzWmc1bEpIa1FZSnNPbnV4?=
 =?utf-8?Q?VmoH3b0r2P3aC2iMvmDHQZ0gA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bea76b-f199-4ca6-1f3c-08db93d7f38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:13:11.5616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHHIwac0jlJBKwDStI3rar3+J7NMrqlNw4E/MacthVVGq8yfzAE1aZS0So0+JYg7PSiOMMBYpOqIwYFJ1GvIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDMsIDIwMjMgMTI6MDYgUE0NCj4gDQo+IE9uIDIwMjMvOC8zIDEyOjAwLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAzLCAyMDIzIDExOjI1IEFNDQo+
ID4+DQo+ID4+IE9uIDIwMjMvOC8yIDE1OjQ2LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+PiBG
cm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBNb25kYXks
IEp1bHkgMjQsIDIwMjMgNzoxNCBQTQ0KPiA+Pj4+DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJCXNwaW5f
bG9ja19pcnFzYXZlKCZkbWFyX2RvbWFpbi0+bG9jaywgZmxhZ3MpOw0KPiA+Pj4+ICsJCWxpc3Rf
Zm9yX2VhY2hfZW50cnkoaW5mbywgJmRtYXJfZG9tYWluLT5kZXZpY2VzLCBsaW5rKQ0KPiA+Pj4+
ICsJCQlpbnRlbF9uZXN0ZWRfaW52YWxpZGF0ZShpbmZvLT5kZXYsIGRtYXJfZG9tYWluLA0KPiA+
Pj4+ICsJCQkJCQlyZXEtPmFkZHIsIHJlcS0+bnBhZ2VzKTsNCj4gPj4+PiArCQlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZkbWFyX2RvbWFpbi0+bG9jaywgZmxhZ3MpOw0KPiA+Pj4NCj4gPj4+IERp
c2FibGluZyBpbnRlcnJ1cHQgd2hpbGUgaW52YWxpZGF0aW5nIGlvdGxiIGlzIGNlcnRhaW5seSB1
bmFjY2VwdGFibGUuDQo+ID4+Pg0KPiA+Pj4gQWN0dWFsbHkgdGhlcmUgaXMgbm8gbmVlZCB0byB3
YWxrIGRldmljZXMuIFVuZGVyIGRtYXJfZG9tYWluIHRoZXJlDQo+ID4+PiBpcyBhbHJlYWR5IGEg
bGlzdCBvZiBhdHRhY2hlZCBpb21tdSdzLg0KPiA+Pg0KPiA+PiBXYWxraW5nIGRldmljZSBpcyBv
bmx5IG5lY2Vzc2FyeSB3aGVuIGludmFsaWRhdGluZyBkZXZpY2UgVExCLiBGb3IgaW90bGINCj4g
Pj4gaW52YWxpZGF0aW9uLCBpdCBvbmx5IG5lZWRzIHRvIGtub3cgdGhlIGlvbW11J3MuDQo+ID4+
DQo+ID4NCj4gPiBldmVuIGZvciBkZXZpY2UgdGxiIHdlIG1heSB0aGluayB3aGV0aGVyIHRoZXJl
IGlzIGFueSBiZXR0ZXIgd2F5DQo+ID4gdG8gYXZvaWQgZGlzYWJsaW5nIGludGVycnVwdC4gSXQn
cyBhIHNsb3cgcGF0aCwgZXNwZWNpYWxseSBpbiBhIGd1ZXN0Lg0KPiANCj4gSSBldmVyIHRyaWVk
IHRoaXMuIEJ1dCBzb21lIGRldmljZSBkcml2ZXJzIGNhbGwgaW9tbXVfdW5tYXAoKSBpbiB0aGUN
Cj4gaW50ZXJydXB0IGNyaXRpY2FsIHBhdGguIDotKCBTbyB3ZSBoYXZlIGEgbG9uZyB3YXkgdG8g
Z28uDQo+IA0KDQplbW1tLi4uIHRoaXMgcGF0aCBvbmx5IGNvbWVzIGZyb20gaW9tbXVmZCBhbmQg
dGhlIGRvbWFpbiBpcw0KdXNlci1tYW5hZ2VkLiBUaGVyZSB3b24ndCBiZSBrZXJuZWwgZHJpdmVy
cyB0byBjYWxsIGlvbW11X3VubWFwKCkNCm9uIHN1Y2ggZG9tYWluLg0KDQo=
