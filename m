Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7676C825
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjHBIOX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjHBIOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 04:14:21 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81310E;
        Wed,  2 Aug 2023 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690964060; x=1722500060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5l14v4uKnjhcwbY7XUUtR2E2svP0paWzHI2oLjXN+N0=;
  b=ErtSDCW+eYkQOpicIg4epYBuANRPxoyCKdGhUcPsWga4srVTuGgPTYCW
   RxiceiY9j+9/SD9alsGNieiMrJAd3n75hWh4flio0eJ70HdVeUuF9WyCS
   Zg6k+qzRmt4fVMV43IG12Z2/btui1O/YVAWfcO2aRqtM+iDigs9zXqoBa
   nnQoi0bjbkTsrN9QEI2RtVRaL1i22Krpt8ZFzgtsBZzG2ZnHjrRkF4hGI
   KO5J8sMgQ5UaFHGMPYxNX6uSm2hsnM0kYgHNVv2lH5uvER9cWZFsj5sxT
   Gwn1gU4BuhSBeyzcpBh0EG4rQmZq0bCWe5o0L5DwZlCaxLNf42DPxWqfM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366977055"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="366977055"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="819102767"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="819102767"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 01:13:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 01:13:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 01:13:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 01:13:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 01:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2o/FMXV9/2R3C4XbDBW2wnwlDQIITHMM01V6BwRc0AYCyTAKIG6uTOLAG2ToPh7/6YIRhYEtDC3/xdD3BiH7zsSTeKpH2l9/5GqsiK6+2UtNZU3gG9bja3lsnXlp/wBrBbPPxbhMXYGsvKz3LBzqgorXCELGG4AoiV7RQbR6MRe84rlKO+i9GcxqPpalJNlABiHMPCgP+69Q0jFGF7c3DiJHDU2bWhXFUk5KVn76LrnIKaAms/p4UavEZDtMJ6VPECEf943UI69YyqUcrvDYeVuULkqd3W8bzreyY2PK2JI9HovZ2p1mm+56StpkyZhcbQJqJApmVVEKFYjz0OQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l14v4uKnjhcwbY7XUUtR2E2svP0paWzHI2oLjXN+N0=;
 b=Zdk/sJ96w1xqu0vkM6L31FR2yho4RgHCYcgKK0xZ0Iy/8EsKKJzAIe5gJeouxjnj+9Xz2siAXFPG3O9bcwaScezIQizt7OLK1Wa3Bgi4q5kDh46upYPO63zVDxCDoTn8Um6J175L9CIGYg7dEZRsYUEl23dFoQYnJQSJTlwezdkfKII1KhLrVAIcUWfC+cbbNv8wTp4YhF7Cb0m5nMuV7iVxBC3fCCh5k8QvW7cXOavOrUKx2Z/3JyT5Yo6Y1VZmjsGY69AIhs0NmZZCy4FxVV9/b6Tr7SMR+XLN1ef7rKMZTWaizToyWohDbet6JaBkllCzWAEGKOHvdEuVw1deNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:13:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:13:48 +0000
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZvh/rKXvA0HWuiEqGDjpQbJoG+q/WoMHQgAAUVACAAAChgIAAAFDg
Date:   Wed, 2 Aug 2023 08:13:48 +0000
Message-ID: <BN9PR11MB5276FCCFA6B73E646D797EBB8C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
 <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <17e403c0-f2f8-c3d4-9dd0-3a812be79b4a@linux.intel.com>
 <859a2d3e-a892-b02e-db1a-ca2503b8952b@linux.intel.com>
In-Reply-To: <859a2d3e-a892-b02e-db1a-ca2503b8952b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: fc52bdde-a09a-4822-11eb-08db9330663a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hxV6T1yLk5QIeQm/WhOzZwYklg1wnfTqcWRkMgr42n62subvicLRwI914xUOqIZwWuo92mDL/gFvqObF5qAs96fVtdUtjGvz+Yy6LoJqosHuezmEGnUjjr3stTypLxOb3j8JLAjYg5hCrd3jw7ESgIU9sjz4gMfop+QNksKGqQnREoGZvFpG+P4FOJHlTv5pmRSzWc6RVSGE7C0yJVJUYy/lElLNPCqo1PMwKay4wY51zGwDw5LRGyQ1sFk1U/0nB44FL1lkQorDtEO3W9PDaiJC3+2VHhJX0IVJ6ewhNPtmif4a6kuovqsxnQSDoSXJqGeJnjA/3xczAZSq6+4QNmMLQucXWElqtuRkGmaNqxwkMYn6MSvyb0s0KPkN0cceT1V+ytUEBw0hYp2t7B2zY2HbVs+e/CL8SU50cQNZPj9g2qzRNFxGrOrG1u7u9/5Z6ofXpMQ/H9Ycndl0dY+2576lGzHBuVxmXt/2wtQxpUdCc5dsSN5XrakSdg5Kx6A+KZzMY9gN+9ys2bf2naN3594vKNvs2NpwRMFpmqcvQ7H33ep++0PKqm63Npai5+zO96h0vRETF2PYny+FdGFgyC523BP5aPs/UoP6n6KHw0o6XMYEePzplp4vmbsNweNhQqm/12vMXzx2PgvkqJi4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(66946007)(86362001)(64756008)(66446008)(52536014)(66476007)(66556008)(7696005)(71200400001)(9686003)(76116006)(2906002)(4326008)(54906003)(110136005)(55016003)(33656002)(478600001)(83380400001)(41300700001)(38100700002)(122000001)(82960400001)(7416002)(5660300002)(8676002)(8936002)(26005)(38070700005)(53546011)(6506007)(316002)(186003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlsMERIUUdZOHFGUjFRNHVFK0hjSmJ3TE0xV09aMVFmSEhwL0FjZXZTVEhO?=
 =?utf-8?B?T0xDbThtdVAvWW96czF4K1BQOWR1aGxScjZaL2JJRjdscTl3ZTlsbjJnOHI3?=
 =?utf-8?B?ckp4bDBmZGZ2cU5FMEYycllDdUpVbjFxc3lBaGp6NHgxL0V5cG1TSXlRYlFU?=
 =?utf-8?B?TGZzNWVEdUpTd29rM2V1dUJXSE42WEU3bXRCQzRwTG4vVXR5TjNaVHVuV20y?=
 =?utf-8?B?dnlKc2ZQbGFrT0FOeGJpZHRFVHJNMERjSTIwcVg5TURJQkpTaXIvVjVleHFD?=
 =?utf-8?B?aGE4WFd6RGd1M0dVQTVYbC9FenNzZ1dCNUdUMWJlQ3pHemVtTi8vOWhmK1d5?=
 =?utf-8?B?MWRWWjVMWEZJOUlaODkrM0hkWXNMb0o3M0lEc3diQk1vNHNwMldxQ1ZTc2lz?=
 =?utf-8?B?aHdwODlhR1hBbmJzcU9xUTdTZjcxSnFSVy9ob0NWMk9RazNncFZGcTd5QUhN?=
 =?utf-8?B?bzhHU01oT0xUOEJ1aytyZ29JQS9PZkpGOS92d0U1cXlKcUdvbU94Z0ZZYUln?=
 =?utf-8?B?aktlMVBqazFiRlR1SEcraVBUV3JIZnE3dmJnSG94TWNoSyttZjVQanNYQ0hF?=
 =?utf-8?B?ODZJbEVRckJmRmxiZHdWTlkzcG5vU21Zek9zazArZlJYU21RWUJockVFRWg4?=
 =?utf-8?B?WVFTU3dDR2RVSUpnRStFSHV2YUpYSlpraWUvZFQ1OWs2U1lkVWZ1RklLWHJi?=
 =?utf-8?B?Zld0T25BZnhkZFUza2hPb1JKMThnMC9qR0t1R1RJOG5pejUxZDdocnRJQkcz?=
 =?utf-8?B?MFozVjZIVS90TTg2a1lsT2V1WHZrS3B2MDNBUmNBNHQ2eFN2RU15RC83SWlR?=
 =?utf-8?B?V3JWeW51aWVTaXJsM1hlYlA2ejlWd2JRYkRiM3lwVTFZeStNWUp5M3ZxWkFs?=
 =?utf-8?B?Ryt1M3hFQTFIM3grQVpmSWRRLzFDcTl4MEo1UmN1a3M3Y2xsQm5pV2k3dTdT?=
 =?utf-8?B?ZmFFRXMwUSt5c1M0T1pkd1J0ZThKV0M3ODNRRjlGc1liSDhubkkxTllaL3h2?=
 =?utf-8?B?dWJaeWNOeTdoVlVqMDZhbVVDS3ZrWnBMNHVkZDZmaUhJTFZqcytTVXlLandV?=
 =?utf-8?B?UDFobW5mNDliMDQ0UDByVWJSL21JUUEzT09DeFZkc3V2bmdZUi9SYkNCYmZY?=
 =?utf-8?B?T2N6aDBueGtTNDJyWGVKSkJyMC96K01memgyZ0lzZDU1cTV6cnpySFpYUkJu?=
 =?utf-8?B?MmhxbXA0TU9RdUprTnlvU0gyU0l1TSt4MnZsaHI0aHQ1YmwwalBVcGZZN2FR?=
 =?utf-8?B?Qkg3TitDMnl0M0V5N2VMYTNUVVlTSjhYQjI4YlViY1hhK0FVcTFHSytiU0hs?=
 =?utf-8?B?M0VKRTM2Mm9ISVBQVkFVWTlYRDI2T2hGM213Tkc4RlZ4OEpyVWM5dWR0Vjlw?=
 =?utf-8?B?cTFTSkhyRWtxZE14L1ZNSTdhMDBoUDRGemRXNDhTZklobmhjWTRJQ2Uwald4?=
 =?utf-8?B?RFh2R2U4a2FUbjRob1R3QTBkVjJQODV2ejhoL3lnYnZ2NWg1Y1IwMlZZdHFk?=
 =?utf-8?B?OEk2Q05vKy91YXNBcG40MHhmWWIzWE5ZZlBaQUNVa2ErMEFOK2l5WnJOY1Vk?=
 =?utf-8?B?bGxOOWUzQjluM3lReXZIbE9oenFPVnJZdW9sUjN3TmNhTnRxcHpLaTR1SVEv?=
 =?utf-8?B?b1ljUENrTHZIenlCZzdJOCtmVWNsMSsxd2V5VDNUZ0FhWDMvNWFaWTNQZ3lk?=
 =?utf-8?B?N1FOSm92MTVXZSsvQ0gwT3hNZitqN2p0MWdZUkZuZ2dNaUw1OEZEU2NWR1F0?=
 =?utf-8?B?R01zUktnV0pqV3l1dHpJMFYrelRkbnBIemd5emRBeU40RjJpRlhQWXFVQWJx?=
 =?utf-8?B?NHllbzJpQjVERHFGRzVoQ3I3ZWVmaXVqTUtrekM0MUV0N2NoU0U4aTVOM041?=
 =?utf-8?B?V05IUUdJcHdFazJmbVdTVW5NRDNMNk1zOWkrSmI5Rmc1L0Nid1lyYzFXZFZh?=
 =?utf-8?B?bHZNTjN3a3BYaTNTRElnQ05UdFBSYzNoQisrTXo4M3NkM3EzZzRJMks3UUpU?=
 =?utf-8?B?cXRFQnhGU0hiWFdzQkdVbE50U2o2WEZOSlRONFJ2dVZZN3ZmakQ5RTI2M0U5?=
 =?utf-8?B?Y2RibVhQZ3E1TGZ6TTFPUzFWa3ZzZy9nWWRDNkYxaVFaZGl2SWxydWg0eklX?=
 =?utf-8?Q?W8YpKzIKNeLdedlwuAn9NnzgM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52bdde-a09a-4822-11eb-08db9330663a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 08:13:48.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+GIsygMW4nX4F0wh2WmZIRm6HqvhT0pukOS3dnOB+HvAd4n1ElYD4YsmgSa/PBu5Wn3XYDOJHIh46GSxoJ+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEF1Z3VzdCAyLCAyMDIzIDQ6MTIgUE0NCj4gDQo+IE9uIDIwMjMvOC8yIDE2OjA5LCBC
YW9sdSBMdSB3cm90ZToNCj4gPiBPbiAyMDIzLzgvMiAxNToxMCwgVGlhbiwgS2V2aW4gd3JvdGU6
DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgIHBhc2lkX3NldF9zbHB0cihwdGUsIHZpcnRfdG9fcGh5
cyhwZ2QpKTsNCj4gPj4+ICvCoMKgwqAgcGFzaWRfc2V0X2ZhdWx0X2VuYWJsZShwdGUpOw0KPiA+
Pj4gK8KgwqDCoCBwYXNpZF9zZXRfZG9tYWluX2lkKHB0ZSwgZGlkKTsNCj4gPj4+ICvCoMKgwqAg
cGFzaWRfc2V0X2FkZHJlc3Nfd2lkdGgocHRlLCBzMl9kb21haW4tPmFnYXcpOw0KPiA+Pj4gK8Kg
wqDCoCBwYXNpZF9zZXRfcGFnZV9zbm9vcChwdGUsICEhZWNhcF9zbXB3Yyhpb21tdS0+ZWNhcCkp
Ow0KPiA+Pj4gK8KgwqDCoCBwYXNpZF9zZXRfdHJhbnNsYXRpb25fdHlwZShwdGUsIFBBU0lEX0VO
VFJZX1BHVFRfTkVTVEVEKTsNCj4gPj4+ICvCoMKgwqAgcGFzaWRfc2V0X3ByZXNlbnQocHRlKTsN
Cj4gPj4+ICvCoMKgwqAgc3Bpbl91bmxvY2soJmlvbW11LT5sb2NrKTsNCj4gPj4+ICsNCj4gPj4g
dGhpcyBsYWNrcyBvZiBoYW5kbGluZyBvZiBmb3JjZV9zbm9vcGluZw0KPiA+DQo+ID4gSWYgc3Rh
Z2UtMiBkb21haW4gaGFzIGZvcmNlX3Nub29waW5nIGF0dHJpYnV0ZSBzZXQsIHRoZW4gd2Ugc2hv
dWxkIHNldA0KPiA+IHRoZSBiaXQgZmllbGQgaW4gdGhlIHBhc2lkIGVudHJ5LCByaWdodD8NCj4g
Pg0KPiA+IEhvdyBhYm91dCBiZWxvdyBhZGRpdGlvbmFsIGNoYW5nZT8NCg0KeWVzDQoNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMgYi9kcml2ZXJzL2lv
bW11L2ludGVsL3Bhc2lkLmMNCj4gPiBpbmRleCAxOWFjNDA4NDkxM2IuLjg2ZGI4MWVjOTFmMSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gPiBAQCAtODI3LDYgKzgyNyw5IEBAIGludCBp
bnRlbF9wYXNpZF9zZXR1cF9uZXN0ZWQoc3RydWN0IGludGVsX2lvbW11DQo+ID4gKmlvbW11LCBz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gIMKgwqDCoMKgwqDCoMKgIGlmIChzMV9jZmctPmZsYWdz
ICYgSU9NTVVfVlREX1MxX0VBRkUpDQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwYXNpZF9zZXRfZWFmZShwdGUpOw0KPiA+DQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoczJfZG9t
YWluPmZvcmNlX3Nub29waW5nKQ0KPiANCj4gKyAgICAgICBpZiAoczJfZG9tYWluLT5mb3JjZV9z
bm9vcGluZykNCj4gDQo+IFNvcnJ5IGZvciB0eXBvLg0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwYXNpZF9zZXRfcGdzbnAocHRlKTsNCj4gPiArDQo+ID4gIMKgwqDCoMKg
wqDCoMKgIHBhc2lkX3NldF9zbHB0cihwdGUsIHZpcnRfdG9fcGh5cyhwZ2QpKTsNCj4gPiAgwqDC
oMKgwqDCoMKgwqAgcGFzaWRfc2V0X2ZhdWx0X2VuYWJsZShwdGUpOw0KPiA+ICDCoMKgwqDCoMKg
wqDCoCBwYXNpZF9zZXRfZG9tYWluX2lkKHB0ZSwgZGlkKTsNCj4gPg0KPiA+IEJlc3QgcmVnYXJk
cywNCj4gPiBiYW9sdQ0KDQo=
