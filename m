Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C570EEDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjEXHB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjEXHBi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:01:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C756A18D;
        Wed, 24 May 2023 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684911696; x=1716447696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mt04htW03WN39bKLkwCg2/vzn4nSJC4Oas4ugjjky3M=;
  b=MQ2ZR7+jVQBumjxU255F/5SeyT6Sh+3ijmq3+PfuyC6RS2SGPzkHrUn6
   +Yuz8UJejRHfvAHBfWrMctQAPc7+298N5FcV8ax9gG2NlcRTNzRoTukgN
   2RzDxusK/viDYbT2jzJ/dMvOGrVntSOeQ4A0uB8QxCbWzprqHXDFKVuJt
   RacFcryzdMvfgEJMn3LB4j7JUc92+W/Xw+jLGGBmMSCYCr3fFVbC+rpn9
   S86H/6FCep8z7vDlSfP450pC/6B6+Jk16seG+u6lW4bUL6w4MlqLcTMei
   7PFWSmZaWZgGQToApTiFAhH3Y95mCQQL91qqTj9HD/uV7U9YiRyJ3aJQR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342943442"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="342943442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="816455304"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="816455304"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 23 May 2023 23:59:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 23:59:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 23:59:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 23:59:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 23:59:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZupV2K8TGhFQIT4fhsF+uum4TPmTUaDB7qLqma0NnwvRiEflnu3Webi4u3mmuSm8Zo9Goe7+im0kEL1nmVYoMnt8+/FfLF2fpDXzh2sChh2VvLAjFAdLziro8Oy5zJIHHchHNo6tvip0h1icnFxfQlU4xTxPr3M0a1Tj/iiRbv/CTa8SKX+bIFBvzo0wheB2r2u5QQJ8Emkh5DrGipcTO6ZQdKACCh6jeTw7EDTyuR6EY2OZFujnAcQE95AXUbyv18NH6d41V8V6CKHQQOOmyb1l9zCvZCBjnF1Wcy+uWiBNVtOrxLICrnxx0qGBL0CYypf1wRpXBGRWbTnLi7LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt04htW03WN39bKLkwCg2/vzn4nSJC4Oas4ugjjky3M=;
 b=FU1oYqWg0DO9KWOjyjawtpofFsXEkEqncR7D5tbCEKhOCGnurxMZlZ//TE1gEWZl5u1nga4IquM25vrk4Yyy3hnZbaJsbnoAMekzoRS3F7VgcHPbngyRQ96LQmUmo5IwsmJfyctdgV7QTAKt5BVR3k/Q0epwq8YQWY+3tZ0rD7TiAyB4CeWWGJ7hJfrMPJYZUM+oul5p48fG0iGvMpiYDRXgA5UgNXuwgsWDxQq80mIRTFGVCa6ZVozVWFKrPWMl/a+b79OyA70Qx7dDn4bVXJcGtqzVQmXYrTiMXk00DCHlYQ41THK6d0Oe08qeZxhOfMDKkgcOhP942Bmb7x0Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 06:59:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 06:59:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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
Subject: RE: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Topic: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Index: AQHZhBgPUNohmBlUrUC7FifZPdGQI69pD7wg
Date:   Wed, 24 May 2023 06:59:55 +0000
Message-ID: <BN9PR11MB5276D9CBCBBDE2F6DCB4D1998C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-2-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6046:EE_
x-ms-office365-filtering-correlation-id: 41940ddd-a2ed-4b27-a79f-08db5c247b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKPPA7RUs0jCUVrbREQvzU7oF4mFO8kNjAjZJ5eUyfhL1yXdvMuX7BWqydggmFv8OjDuNQvqlBzg9URiv5XyX3GI93nt46h9EUrH2z/zJX/U9d7HVulcAUoJp07tjOOPf2pT8P77yNtmU7qTMJyrONv/8n8CqhoQ+pqXDx6Vfzwmnc2Ir8JZjmfzEX9vrEqheGNGuS2tbZgY5+XqJnpTTCTIBJx/8lvLbTVFymmDDtZN4IPVk3v3y2xN7b4rEaNwDBRhnVFj6p/dPIi3tM1KCr3V3ua+nm7a3KT07G8xehalQR8qw7KpP3Pktt9Ffkf8W55H7qIPcUxqtbgh1hd+h2HBlyDRyUIl+B7U+JCDvhpwrxA3ktL1IWTLR+v0yfU5oTOl6pNdyO8FqlaSgoXFBeqC6xU+hFg1+NiXVY2ZFFT48HJYppCfU75aAzgkUUAvMNB8L3KJ0qqo2jC6LUGJXcbp0qCjZ1U8jsCqFLFBTOdRPQuxYvfzJwhSynfRKKL1wcnIl76wLY1hMc8F/fRfLVOJK+SbHMEI7DIa9h41GBctS/vlNL7ZVx9x6AT3BIXBBGXWSO5/e1KhGFZVAbhjQQXkbGdZ1pgi1HHzpgxpT+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(8676002)(186003)(83380400001)(2906002)(7696005)(478600001)(4326008)(66446008)(64756008)(66946007)(66556008)(316002)(41300700001)(76116006)(54906003)(71200400001)(66476007)(110136005)(7416002)(26005)(6506007)(5660300002)(9686003)(52536014)(8936002)(55016003)(38070700005)(38100700002)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpSZVlEL0drUzFLOEs1bkh2UzVTZjE2M0N0bXFiLzdycUZ0MlhxaVg0NTQy?=
 =?utf-8?B?dEVMRzRibG9KWlVmOVdBc05GamVzVTRFTnEzNlNTNVU1VkJkVkw4ZDBTOEVq?=
 =?utf-8?B?dCt4b2o4dC9OcTYreHlkd2w1TisydFBqTStBYTNYOGlIZnBHd2h4cWF5NHI0?=
 =?utf-8?B?cVJkSnNzT3YwcEUrdjVLbjVRV002QVAzMDVQblZON2t4Nm9Jei8vREJBeEww?=
 =?utf-8?B?TEJiTTdtUVRxckxFMmdwekVsajhNTytjWnRRYVcwNXZtQW5mMmo2elNJcjN6?=
 =?utf-8?B?MW9lQUFNcE1oWktiOVIxSjBlN2FwZFRpYndwU2gvV2lYRHFVTjZVZFBsb1Bl?=
 =?utf-8?B?K042bS9ReTc2SVRoRzRSREJOSndzRSswaFl2bGVCOVhCQk96VlJadHZuUlZs?=
 =?utf-8?B?OEhpMUc3SGkvOVhwemFUWktscTI1bWZrRm1UNU1wTEdoQ0tNN3d6RTRsTks4?=
 =?utf-8?B?TWFhTGNtNE5UdndSeWZVY1M0d3ZPV3gvWWNQbVZNWnlBM2IzYmFrRkUrQWJp?=
 =?utf-8?B?YXAwaHI5K2Q5T2Nib3E0V0JEaUdOQXNISWRSMHJ2YW5yd3JxeEFqS2xvVFJj?=
 =?utf-8?B?dVhObDR4V0JtNW5Hd1FNdmVFQUZlMkhSWVdra255L2l6b1NZUDdpcHVmVXdY?=
 =?utf-8?B?cVJZeDRXTGhhNi9GMGZHakM2UVNHNW1MQm9TUk40LzhxalJJVHpkR3dtYkQ4?=
 =?utf-8?B?a2plZXNaVmV5UDhxMW9GV0pLVU5JK2JhTWxNN3p1U2YrUmRZK051RGZVb2Q1?=
 =?utf-8?B?bzhvdUUrdzBBRC9ld0RyVGdvUk04NmljZFVvb3V4dDRWM2F6R1orWk16K2hT?=
 =?utf-8?B?aVZRU0R3WWJZY1R1Q242Z1FNZ2h4ZXg0WFk5OTFKZ09MWmVROGRGOGpseXJs?=
 =?utf-8?B?SzZlZ2pzT01BaUVOY2FRejB5bkFxN1VDb04xcis4ckdaUnJKSXpzYjJpdmJB?=
 =?utf-8?B?SS9yOUkra0Ywc1FhaW9Ga2RzV09KVXhJY3RCT01ad053QTQvM2ttU3Z1cHp4?=
 =?utf-8?B?dzJ0WTlwaU1Jd25nTVZLUzA5ZUtOU3lxMm9hZUZqNU9nSEk3UHhDSUZxNjZF?=
 =?utf-8?B?NkRoQmxHb2I2bEgwL3VEUDlYSWR6MEtwcnZrU3l0S2luOE1PVG5uOVJ3QTVv?=
 =?utf-8?B?ZmtyRG5SaUpLSGNab3NnbC9ubk9VOHppdUxuLzVwVGJ2Q3JiVTE5UGlFZkJy?=
 =?utf-8?B?NmplU01XMjRYN2ZOaDB6S25kT1huMTFRKzdtVVdsT0F2OS8rZUNUbjl1RlJF?=
 =?utf-8?B?cERJRHFtWmlqOGxZYWVDY1h2Z2JiQjlhYnlBYmZWc3gvMkFnU3hDb3hlNGp4?=
 =?utf-8?B?T0FmZHpXc1NFVDRlL003UEhodDQwN3pwSE9yUXZyVkZ1cUM0dExaRmZ2Mlh0?=
 =?utf-8?B?UFVmNlNWOXJCYXN3cWJ2aUdsSzlMcWo5dloyb2o4eVYrWDB4QXBhTFNRZkJN?=
 =?utf-8?B?c2tUZVZnaEh0elBIMHRTSXdUWU5Gb1ZwK2hhN3NGbWwycWEwYzRGME1UbHQ0?=
 =?utf-8?B?b2tIZlBUc0FXd2dYYWh0b2VSVTd3OGV2SXRVYThTWEp1VVFKL0dSVFduc0ts?=
 =?utf-8?B?a0tlcUtVdllwc04zUk5iWU1PZFZFMUdkcW5MelAzS1NnSFg3dUVZVmVsUzhw?=
 =?utf-8?B?WmpEZksxYkNBYVhQUmR6Y1pKN1lyT3dsdkx4WWY1RnBIMEhscGVMZHk5eDZi?=
 =?utf-8?B?clR4eTlod2VadUU3MnBEclFLdUhEdWM1aTkzNU5YaldDdEMzQTNKQkx3bHkz?=
 =?utf-8?B?U0hwYnp5cVVFZUJmalBGNUdqTTFPcGNvY1BXa1RKNEJQa2pQK1kwd2VLNkVo?=
 =?utf-8?B?QTJCVmJ2Q3dPYkFXNTFadTdCcGlIajV2OXY4b015L3hIRURZMGpiT0duNkZp?=
 =?utf-8?B?UmNJU01xM2lya0dEU3FWUk5ZTnpsN3dhdnlvZ2xDcHduRWUyUlU3TmNPdi9Z?=
 =?utf-8?B?QjUwMjVINUhtTmducXdaQWNWK0F3ajVYNHRwYUJzU3lKUkZRd1RVRHBuRUxO?=
 =?utf-8?B?M0gzNUlwd1BBNzZPQm5kdFZCUnpWNkRBeHVpU1UxQk5pYWtKcVdvZlA3UmFI?=
 =?utf-8?B?R1VnSldadVpSdEhHZXlOV2QrZGFFVzVqL1NnMzB6aGJIRTdENWxtcHJMWlRH?=
 =?utf-8?Q?IBO8vZF+fgPfhr0sL6Vyt6MZ7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41940ddd-a2ed-4b27-a79f-08db5c247b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 06:59:55.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJsXY7Swlt7JEZO+oHP+wjTIiBvKmmmO1bKahesqiIr25I+uyNII3JZg9VTuZzScCf/fa9YnB/Zh6vgACGwIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
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

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IE1heSAxMSwgMjAyMyAxMDo1MSBQTQ0KPg0KPiBAQCAtMzUzLDkgKzM1Myw2NCBAQCBzdHJ1Y3Qg
aW9tbXVfdmZpb19pb2FzIHsNCj4gIC8qKg0KPiAgICogZW51bSBpb21tdV9od3B0X3R5cGUgLSBJ
T01NVSBIV1BUIFR5cGUNCj4gICAqIEBJT01NVV9IV1BUX1RZUEVfREVGQVVMVDogZGVmYXVsdA0K
PiArICogQElPTU1VX0hXUFRfVFlQRV9WVERfUzE6IEludGVsIFZULWQgc3RhZ2UtMSBwYWdlIHRh
YmxlDQo+ICAgKi8NCj4gIGVudW0gaW9tbXVfaHdwdF90eXBlIHsNCj4gIAlJT01NVV9IV1BUX1RZ
UEVfREVGQVVMVCwNCj4gKwlJT01NVV9IV1BUX1RZUEVfVlREX1MxLA0KPiArfTsNCj4gKw0KPiAr
LyoqDQo+ICsgKiBlbnVtIGlvbW11X2h3cHRfaW50ZWxfdnRkX2ZsYWdzIC0gSW50ZWwgVlQtZCBz
dGFnZS0xIHBhZ2UNCj4gKyAqCQkJCSAgICAgdGFibGUgZW50cnkgYXR0cmlidXRlcw0KDQpObyBu
ZWVkIHRvIGhhdmUgYm90aCAnaW50ZWwnIGFuZCAndnRkJyBpbiBvbmUgbmFtZS4gVGhlcmUgd29u
J3QNCmJlIGFub3RoZXIgdnRkLiDwn5iKDQoNCkFsc28gc2luY2UgaXQncyBmb3IgczEsIGxldCdz
IGJlIHNwZWNpZmljIG9uIHRoZSBuYW1pbmc6DQoNCmVudW0gaW9tbXVfaHdwdF92dGRfczFfZmxh
Z3MNCg0KPiArICogQElPTU1VX1ZURF9QR1RCTF9TUkU6IFN1cGVydmlzb3IgcmVxdWVzdA0KPiAr
ICogQElPTU1VX1ZURF9QR1RCTF9FQUZFOiBFeHRlbmRlZCBhY2Nlc3MgZW5hYmxlDQo+ICsgKiBA
SU9NTVVfVlREX1BHVEJMX1BDRDogUGFnZS1sZXZlbCBjYWNoZSBkaXNhYmxlDQo+ICsgKiBASU9N
TVVfVlREX1BHVEJMX1BXVDogUGFnZS1sZXZlbCB3cml0ZSB0aHJvdWdoDQo+ICsgKiBASU9NTVVf
VlREX1BHVEJMX0VNVEU6IEV4dGVuZGVkIG1lbSB0eXBlIGVuYWJsZQ0KPiArICogQElPTU1VX1ZU
RF9QR1RCTF9DRDogUEFTSUQtbGV2ZWwgY2FjaGUgZGlzYWJsZQ0KPiArICogQElPTU1VX1ZURF9Q
R1RCTF9XUEU6IFdyaXRlIHByb3RlY3QgZW5hYmxlDQoNCnNpbWlsYXJseSBhYm92ZSBzaG91bGQg
YmUgSU9NTVVfVlREX1MxX1NSRS4NCg0KUEdUQkwgY2FuIGJlIHNraXBwZWQuDQoNCj4gKyAqLw0K
PiArZW51bSBpb21tdV9od3B0X2ludGVsX3Z0ZF9mbGFncyB7DQo+ICsJSU9NTVVfVlREX1BHVEJM
X1NSRSA9IDEgPDwgMCwNCj4gKwlJT01NVV9WVERfUEdUQkxfRUFGRSA9IDEgPDwgMSwNCj4gKwlJ
T01NVV9WVERfUEdUQkxfUENEID0gMSA8PCAyLA0KPiArCUlPTU1VX1ZURF9QR1RCTF9QV1QgPSAx
IDw8IDMsDQo+ICsJSU9NTVVfVlREX1BHVEJMX0VNVEUgPSAxIDw8IDQsDQo+ICsJSU9NTVVfVlRE
X1BHVEJMX0NEID0gMSA8PCA1LA0KPiArCUlPTU1VX1ZURF9QR1RCTF9XUEUgPSAxIDw8IDYsDQo+
ICsJSU9NTVVfVlREX1BHVEJMX0xBU1QgPSAxIDw8IDcsDQo+ICt9Ow0KPiArDQo+ICsvKioNCj4g
KyAqIHN0cnVjdCBpb21tdV9od3B0X2ludGVsX3Z0ZCAtIEludGVsIFZULWQgc3BlY2lmaWMgdXNl
ci1tYW5hZ2VkDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGFnZS0xIHBh
Z2UgdGFibGUgaW5mbw0KDQpzdHJ1Y3QgaW9tbXVfaHdwdF92dGRfczENCg0KPiArICogQGZsYWdz
OiBDb21iaW5hdGlvbiBvZiBlbnVtIGlvbW11X2h3cHRfaW50ZWxfdnRkX2ZsYWdzDQo+ICsgKiBA
cGd0YmxfYWRkcjogVGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUgdXNlci1tYW5hZ2VkIHN0YWdlLTEg
cGFnZSB0YWJsZS4NCg0Kbm8gbmVlZCB0byBoaWdobGlnaHQgJ3VzZXItbWFuYWdlZCcgaW4gZXZl
cnkgcmVmZXJlbmNlIHRvIHN0YWdlLTENCg0KPiArICogQHBhdDogUGFnZSBhdHRyaWJ1dGUgdGFi
bGUgZGF0YSB0byBjb21wdXRlIGVmZmVjdGl2ZSBtZW1vcnkgdHlwZQ0KPiArICogQGVtdDogRXh0
ZW5kZWQgbWVtb3J5IHR5cGUNCj4gKyAqIEBhZGRyX3dpZHRoOiBUaGUgYWRkcmVzcyB3aWR0aCBv
ZiB0aGUgdW50cmFuc2xhdGVkIGFkZHJlc3NlcyB0aGF0IGFyZQ0KPiArICogICAgICAgICAgICAg
IHN1YmplY3RlZCB0byB0aGUgdXNlci1tYW5hZ2VkIHN0YWdlLTEgcGFnZSB0YWJsZS4NCg0KIlRo
ZSBhZGRyZXNzIHdpZHRoIG9mIHRoZSBzdGFnZS0xIHBhZ2UgdGFibGUiDQoNCj4gKyAqIEBfX3Jl
c2VydmVkOiBNdXN0IGJlIDANCj4gKyAqDQo+ICsgKiBUaGUgSW50ZWwgVlQtZCBzcGVjaWZpYyBk
YXRhIGZvciBjcmVhdGluZyBod19wYWdldGFibGUgdG8gcmVwcmVzZW50DQo+ICsgKiB0aGUgdXNl
ci1tYW5hZ2VkIHN0YWdlLTEgcGFnZSB0YWJsZSB0aGF0IGlzIHVzZWQgaW4gbmVzdGVkIHRyYW5z
bGF0aW9uLg0KDQoiVlQtZCBzcGVjaWZpYyBkYXRhIGZvciBjcmVhdGluZyBhIHN0YWdlLTEgcGFn
ZSB0YWJsZSB0aGF0IC4uLiINCg0KPiArICoNCj4gKyAqIEluIG5lc3RlZCB0cmFuc2xhdGlvbiwg
dGhlIHN0YWdlLTEgcGFnZSB0YWJsZSBsb2NhdGVzIGluIHRoZSBhZGRyZXNzDQo+ICsgKiBzcGFj
ZSB0aGF0IGRlZmluZWQgYnkgdGhlIGNvcnJlc3BvbmRpbmcgc3RhZ2UtMiBwYWdlIHRhYmxlLiBI
ZW5jZSB0aGUNCg0KImxvY2F0ZXMgaW4gdGhlIGFkZHJlc3Mgc3BhY2Ugb2YgdGhlIHNwZWNpZmll
ZCBzdGFnZS0yIHBhZ2UgdGFibGUiDQoNCj4gKyAqIHN0YWdlLTEgcGFnZSB0YWJsZSBiYXNlIGFk
ZHJlc3MgdmFsdWUgc2hvdWxkIG5vdCBiZSBoaWdoZXIgdGhhbiB0aGUNCj4gKyAqIG1heGltdW0g
dW50cmFuc2xhdGVkIGFkZHJlc3Mgb2Ygc3RhZ2UtMiBwYWdlIHRhYmxlLg0KDQoic2hvdWxkIG5v
dCBleGNlZWQgdGhlIG1heGltdW0gYWxsb3dlZCBpbnB1dCBhZGRyZXNzIG9mIHN0YWdlLTIiDQoN
Cj4gKyAqDQo+ICsgKiBUaGUgcGFnaW5nIGxldmVsIG9mIHRoZSBzdGFnZS0xIHBhZ2UgdGFibGUg
c2hvdWxkIGJlIGNvbXBhdGlibGUgd2l0aA0KPiArICogdGhlIGhhcmR3YXJlIGlvbW11LiBPdGhl
cndpc2UsIHRoZSBhbGxvY2F0aW9uIHdvdWxkIGJlIGZhaWxlZC4NCg0KdGhlcmUgaXMgbm8gaW5m
b3JtYXRpb24gYWJvdXQgcGFnaW5nIGxldmVsIGluIHRoaXMgc3RydWN0dXJlDQoNCj4gKyAqLw0K
PiArc3RydWN0IGlvbW11X2h3cHRfaW50ZWxfdnRkIHsNCj4gKwlfX3U2NCBmbGFnczsNCj4gKwlf
X3U2NCBwZ3RibF9hZGRyOw0KPiArCV9fdTMyIHBhdDsNCj4gKwlfX3UzMiBlbXQ7DQo+ICsJX191
MzIgYWRkcl93aWR0aDsNCj4gKwlfX3UzMiBfX3Jlc2VydmVkOw0KPiAgfTsNCj4gDQoNCkknZCBw
cmVmZXIgdG8gbW92ZSB2ZW5kb3Igc3BlY2lmaWMgZGVmaW5pdGlvbnMgYmVmb3JlICdlbnVtIGlv
bW11X2h3cHRfdHlwZScNCnNvIGFueSBuZXcgYWRkZWQgdHlwZSBjYW4gYmUgZWFzaWx5IGNvcnJl
bGF0ZWQgYmV0d2VlbiB0aGUgdHlwZSBlbnVtZXJhdGlvbg0KYW5kIGZvbGxvd2luZyBjaGFuZ2Ug
aW4gdGhlIGNvbW1lbnQgb2YgJ3N0cnVjdCBpb21tdV9od3B0X2FsbG9jJw0KDQo+ICAvKioNCj4g
QEAgLTM5MSw2ICs0NDYsOCBAQCBlbnVtIGlvbW11X2h3cHRfdHlwZSB7DQo+ICAgKiArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0rDQo+ICAgKiB8IElPTU1VX0hXUFRfVFlQRV9ERUZBVUxUICAgICAg
fCAgICAgICAgICAgICAgIE4vQSAgICAgICAgICAgICAgICAgICB8ICAgIElPQVMgICB8DQo+ICAg
KiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQo+ICsgKiB8IElPTU1VX0hXUFRfVFlQRV9WVERf
UzEgICAgICAgfCAgICAgIHN0cnVjdCBpb21tdV9od3B0X2ludGVsX3Z0ZCAgICB8DQo+IEhXUFQg
ICB8DQo+ICsgKiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQo+ICAgKi8NCj4gIHN0cnVjdCBp
b21tdV9od3B0X2FsbG9jIHsNCj4gIAlfX3UzMiBzaXplOw0KPiAtLQ0KPiAyLjM0LjENCg0K
