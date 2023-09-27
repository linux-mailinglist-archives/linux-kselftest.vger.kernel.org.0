Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF27AFC43
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 09:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjI0Hp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 03:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0Hpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 03:45:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1315BF;
        Wed, 27 Sep 2023 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695800755; x=1727336755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z0OjTI2B32unZ7drYYFErzvZmrgZ6S3Fkof66vCu3Og=;
  b=VD/IRktrdMvUeKcT9Er2/kda9YOwG2DPRmfIYpabHs3lbkgOnPVficO0
   bQlvqBs3OqIjDSbcqbVSWe9ndVGI/d3gM7KAojBH8ZdWSDzf6DpoaXo+C
   ybJyd7uB1g2C8BXEhUzt2/wrEMoNfNCzRKDaNmDoaPSHC//J+RJ5q8reZ
   GCtIJ4yeY8EI80GcM8NAJtntiXJ3umLJHrtlY4VsJw6kk2pl7GLWkvK+r
   8bOLkFyWFor7lVmrEzil1c7yKwYggU41s2wNJGijQoR/uFx1xPoXqClUN
   g3z3ehajvXp7bh43mJHZS7hnLeZOQHEo3JXIJf4dtN9TNlCUcSibA64+g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380623249"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380623249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892511114"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="892511114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 00:44:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:45:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:45:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 00:45:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 00:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwVodZ9d79oxd7+ZLSK1zD3VRjujO/j5CpuFMN/QeL4tIkUzOxpmvf3TI5JmAUIplYHhf+Q616WRb9I9sBUAUOqcqLmWcZCFUwM1M27V7P720TVXIQ0S6QOdocXPnOaOCXnU4YJigxP5C/So+3MJxNK3nyXuPFaQDY/srYPNYRYRb5FaqMceFzy1824BuHFXjeUYYPRBrllhXOqFEVXDG/Kj6+IT6zexI7thai9R35EvjLP3vchQowD44X+rsPEnfXxX+OoqvOouyr/AwV8nuIa103Heyvi56jA0Rrb7CnnyHhdnRglNGyNZKhC7dxDiWb8zOnj62tfYPcEy87ZFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0OjTI2B32unZ7drYYFErzvZmrgZ6S3Fkof66vCu3Og=;
 b=NEeysMM3cxdqXQMODKpETVpipsrGMkozKiks/PVlAuSlUK6wLfNWOxgOgEdBeS1DY2bPhXChVhLKRqutoJcRHwwZwvLcCkb0uuawC+bYw+C3n2urYCVqfYgdIlHcBxl9ajTnYcschOOMohbR0FVmNo4wzBWqNCSIZxRTXNLzHYt16Wxvhfak/zfvoL5YowJKbU1Nsd3UYsVYSzcurIaAN0Pnpvm0NwgIoiasGY5KbF0/eJTopvRYyrzvfWMRGG/WbJlylWL8Pg+8whxdMavQagwXss1UeKwivhgOTKpoDj8oQvUY85kzmK8ft6YmPGvm04aDGZpC7oRA1WIoXgc+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 07:45:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 07:45:41 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 1/8] iommu: Introduce a replace API for device pasid
Thread-Topic: [RFC 1/8] iommu: Introduce a replace API for device pasid
Thread-Index: AQHZ8FuZWR2xxq4Y8E2voyRsYvzo6rAt7UiAgABdzFA=
Date:   Wed, 27 Sep 2023 07:45:40 +0000
Message-ID: <BN9PR11MB527633951B081F0F3A8499C98CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-2-yi.l.liu@intel.com>
 <a5e18b46-cccc-a2f7-91ae-aa5c942cd887@linux.intel.com>
In-Reply-To: <a5e18b46-cccc-a2f7-91ae-aa5c942cd887@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: 248920ef-1c61-4b1d-ca52-08dbbf2dbf11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYTRPVmqHweb0Yrqse5Pg6o6Rqxb0eNA0vvGFnaqXD31dRRfgL4lAvjNF+6s9sn7O0etE4OnGZS7ZnGMKjeCv0D7eWKVZdxwc0ntR7x7AGseusChYmoHYzGq0JVlIICJbtu/wICas38B7fEtFb69q9kZJxH1q0iyqXaZ9TiefqoiQdRHD0yRxy03PypF+RMBzMSshyjaAjY/1S5yHtBgWRpiONZJSVjqsbMyInQV9dkl4VPgwPwE2eTBTKebb3mABbLj2ArwlQLoUzts5s2qClursc85yy0BpZBS9vzh5PuB2dWBvXV1Eex/mAyW46v/Fbw5CBFMiceyeSJdrVLDrFD676vpz7R4gA3qPot7zLIClMPfuIiaZ/MsBAM3IUy5wtMTCDAuPf7jyOKDhyfUFHdE5rWijfp4dA5VQPXMKxm/nhFYOuJEcqK8fDr4EheOE9LwnvvGVzycrRgnImsu8ne0UC330+RgPXgdnaSidtECs9aKed0oWIQx/N8evhntbUYxloWgpwuaZZ0Kw+nHH2EH2HN5RK1aCZCKO/rPKT1sx5W1uXnsoerRNy0ic5uiZV8su6DRB4S06e1ztfhPx8p14hlT12PkbvN5ahE7DbL03VWPEnez9oZrov15Tlm8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(66946007)(83380400001)(53546011)(71200400001)(316002)(66556008)(66446008)(122000001)(7696005)(9686003)(6506007)(66476007)(26005)(54906003)(33656002)(478600001)(64756008)(55016003)(82960400001)(8936002)(2906002)(5660300002)(110136005)(76116006)(38100700002)(4326008)(52536014)(38070700005)(8676002)(7416002)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hDZUprTlFMRVAxUXE3d01zSFNsREU2Wng3alJidm0yTVRDRG5abkhUbXdR?=
 =?utf-8?B?ZkIvTjc0WXk5dm5YSkw1SmNnVXlSb093ek1wS09ZbzMvOG01MHZkc0xTeUFS?=
 =?utf-8?B?b3VycCt3VTVoSWZJUVQyQVdFL0l3YUx3Y3A1ZEJ0eWRkU1Q0SnpKeC9hTzZp?=
 =?utf-8?B?NmFweEdrdFFvaEJOdHg4K0lzRjFWZ1J3WEovOVhZSS9tWFYrOFlST0dsejdG?=
 =?utf-8?B?QWJXdFNkeGhvdEw4TlVLbUVhV1dEOHlzN3pRMWtZc21NZkZhVEx5Q0FiODJo?=
 =?utf-8?B?cXVJTTIvbThwRUFiZ0Y1R3BJOEhSUkZmY0tqOG9ubGJ5cm8vM3Iveld3a0Ey?=
 =?utf-8?B?blVyZVpVOWdUallYY1Y0dEs5b2l1emJ2SEJ1S0JYaEphRWhCVk1LUkc1b0Jw?=
 =?utf-8?B?ampGWUFOb1BpNmVjeTA2VHVaNUdMUGx5Umw5SmcrWnFzbW1nMm1nc2twWlA5?=
 =?utf-8?B?NTBSV3U0YzhWVWUraE1lMTE5ZXVSb0lWNGF6bHdYQlY2S0kwRGJzZ3JTVDls?=
 =?utf-8?B?WnhybEcxNEZnT092bXlsc1JobTduUHZnQ0xZeGRzcjV1WCtuQk9zdy9ZSVYy?=
 =?utf-8?B?ZEpYaXdNSkdaLzJsc2V2NzRURE9mSmN3MjlBQ3hUWVp0NW5UU1BXV0trRXJK?=
 =?utf-8?B?cm5FTE9xWEUwelc4MDN6em1qNkhIalZSakVncStmc09KMXpZbndvb1JuL09K?=
 =?utf-8?B?enEyZXQvQTB5WmlLU2VWSzZJamFZaEorWXdrNG1zV1ZjVGFUUHc2OGNidi9S?=
 =?utf-8?B?WkJuRTdONXpTZEQzNHVrOU93MVNUdnh6YVJPdFFoZEd2VFJsSU8xdzduQVlO?=
 =?utf-8?B?UWRNVmR6SzRkS3dYVXZrYzZoTGt4b0xzOEhvaTUySjJFWm1admZYM1YzRnAr?=
 =?utf-8?B?U2RvUHNpNU1hMW1sQUJ0Z080eUprSEFZVjdjRDdrRWxsUUo0TVhJalRCbzZW?=
 =?utf-8?B?alErT20wNjIzS1dNa0YxUTFBRERFZWYxN0NVbDdWejlaUDdoWFhxUE5QZ2Fr?=
 =?utf-8?B?aFZDSm9tcnd0WXZSeUg2cnQwMGg2MWxKMEJ4WXQ5SU5XVHlRdmhGb1JsSWpi?=
 =?utf-8?B?aTZRanFmTExkTXdNUVdWclkweXZDS2hmSkZicUR4M2xmWER4eU9jMmYzTGFv?=
 =?utf-8?B?NmxlenFyK1I1b09jTysvdjNwN2NOMTZUNVBWS0U0RWMxTHFIQUNYMWxrME5t?=
 =?utf-8?B?MFVidFo2dS9tQVZYUEJCSWhuQjlhRW1SK1BUOFI4c1hQWUtlbExabGVKMkti?=
 =?utf-8?B?VWRuc2Q3UWVZUk5mZGdDY29Hems5KzNIeGFIVW5wSzh4RXdVWWlRL1ZrMzRZ?=
 =?utf-8?B?NFBIa1FyaUk2UlZuMzY5M25rUzJUeTVDbytZYmhZajdmZ0xaWDF5M2l1amZT?=
 =?utf-8?B?ZHU1VjlRNkoyY0xObi9JRTNkbmt0NXNYOWxsM1cySXhDRnRnY2VjT25JOWlI?=
 =?utf-8?B?ckYzVHcrVjNmanRXNjhFS1JzSXd3UFZFZ3BCdSt0ZjhOQVFCUGI0aVRZSHVW?=
 =?utf-8?B?bGVveXIyOWhXS0ltZGtJR1hiaGJYaGxIbk9HSThEdG9LY05RWmlqdUZoLzBr?=
 =?utf-8?B?MGliUmtmaFdUUjQ3U2hLL0J2K0xlOXo0YmVjcEU3aVF5UEI0aGt3MlNZMjNJ?=
 =?utf-8?B?UWNzRis0cEhrZ0VoTWwwVmVmRzZpc2pkcnd4Yklyblh6UEtpaklCcTlJSG9r?=
 =?utf-8?B?OTdPejBvV3BxcHdFZWEraVZJSm10WEdNY00wYVp6UjZ5UG5YVm1Yek1KOGVx?=
 =?utf-8?B?dGpCZ0k1SHFQTEhCeEtTSUFhTkVRK1pCdk5RbjhmQkRFU1NFT2VocUh0NlFH?=
 =?utf-8?B?N0N5dkhncTdCRzFRRlpuaXZEeGdNUmozUTExamNLVC9UeVUwS1lGSzRaU2xC?=
 =?utf-8?B?SkgxUlViNzlOUnl4Zk5oR3BYNEkyb2NpV2tLMlBFK1k5QldGK21ZUEFnK1pN?=
 =?utf-8?B?bmhGclphMEgxb2tOaEo2OWplK0FrRlNlTmx6ZHIvWDRHSkRYTGdUNm1CcE5p?=
 =?utf-8?B?RVpWcUdYRCtzRXFBUGpOVXFYZFh4Y09rcFRBQ1dRNkJvSGZoSGRVczdjUGJ3?=
 =?utf-8?B?R2MyT3NqTXdCZ3h5UDR4WGVMSjdHTDZqSWdzRlNWQzhXT2NZOFdZZ0dRdisv?=
 =?utf-8?Q?Oh9mPf5hBXGi1toEBXpDiAjWf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248920ef-1c61-4b1d-ca52-08dbbf2dbf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:45:40.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlIbld9FUGfFx3+/JvM4caOm/wP9huuaw5AZY/RZ5ljiqzjx35C21YFVVOmeDIYE5SDv6zswmbvY4zbfuIr6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAxMDowNSBBTQ0KPiANCj4gT24gOS8yNi8yMyA1OjI2
IFBNLCBZaSBMaXUgd3JvdGU6DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIGlvbW11X3JlcGxhY2Vf
ZGV2aWNlX3Bhc2lkIC0gcmVwbGFjZSB0aGUgZG9tYWluIHRoYXQgYSBwYXNpZCBpcw0KPiBhdHRh
Y2hlZCB0bw0KPiA+ICsgKiBAZG9tYWluOiBuZXcgSU9NTVUgZG9tYWluIHRvIHJlcGxhY2Ugd2l0
aA0KPiA+ICsgKiBAZGV2OiB0aGUgcGh5c2ljYWwgZGV2aWNlDQo+ID4gKyAqIEBwYXNpZDogcGFz
aWQgdGhhdCB3aWxsIGJlIGF0dGFjaGVkIHRvIHRoZSBuZXcgZG9tYWluDQo+ID4gKyAqDQo+ID4g
KyAqIFRoaXMgQVBJIGFsbG93cyB0aGUgcGFzaWQgdG8gc3dpdGNoIGRvbWFpbnMuIFJldHVybiAw
IG9uIHN1Y2Nlc3MsIG9yIGFuDQo+ID4gKyAqIGVycm9yLiBUaGUgcGFzaWQgd2lsbCByb2xsIGJh
Y2sgdG8gdXNlIHRoZSBvbGQgZG9tYWluIGlmIGZhaWx1cmUuIFRoZQ0KPiA+ICsgKiBjYWxsZXIg
Y291bGQgY2FsbCBpb21tdV9kZXRhY2hfZGV2aWNlX3Bhc2lkKCkgYmVmb3JlIGZyZWUgdGhlIG9s
ZA0KPiBkb21haW4NCj4gPiArICogaW4gb3JkZXIgdG8gYXZvaWQgdXNlLWFmdGVyLWZyZWUgY2Fz
ZS4NCj4gDQo+IFRoZSBjb21tZW50IGRvZXMgbm90IG1hdGNoIHRoZSBhY3R1YWwgYmVoYXZpb3Ig
b2YgdGhlIGNvZGUuIFdlIG5lZWQgdG8NCj4gZGlzY3VzcyBhbmQgYWdyZWUgb24gd2hpY2ggc3Rh
dGUgdGhlIFBBU0lEIHNob3VsZCBwYXJrIGluIGlmIHJlcGxhY2luZw0KPiB0aGUgZG9tYWluIGZh
aWxzLg0KPiANCg0KdGhlcmUgaXMgbm8gbGVnYWN5IGFzIGluIGdyb3VwX3NldF9kb21haW4gYW5k
IGlvbW11ZmQgaXMgdGhlIG9ubHkNCmNhbGxlciBvZiB0aGlzIG5ldyBmdW5jdGlvbi4gU28gSU1I
TyB0aGUgZGVzY3JpcHRpb24gYWJvdmUgaXMgdGhlIHJpZ2h0DQp0aGluZyB0byBkbyBhbmQgdGhl
IGNvZGUgc2hvdWxkIGJlIHVwZGF0ZWQgdG8gbWF0Y2ggaXQuDQo=
