Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB527A831C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjITNSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjITNSq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B6B6;
        Wed, 20 Sep 2023 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695215921; x=1726751921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WAr76/3bqMcrGFmIkZl835Rmp9LpHMyOu5vTaMiIM0I=;
  b=kk482GuOVGXmLbMIaKCGtgFIA+ESjLESP3vCjNq5bSqz+Nwh6GfQjF9i
   c5httSM1tnnVR8ok9Er0VLk24i6Ieo+vO6Bhx3JVWFJBPIY+KRsJOI5ZI
   Gr/eKmo1EN+AR3N1rXz0icNNGM0Dm4VeIkb0nQrx4fGt1JCQ/9bgLDSee
   JFHuAN5ku5m1OYm8B2+Kho7ScV/ix3Knmf+/RrIBin3y4ivTqwcUeYg6K
   JzQtlVt1vxYQ9gEZuDSg4+PXRolLjsE6/QgMFgfdA3Q+p2ttNSnIKJeBN
   yUaBPDrcThXLEsoAEkazGep5lAb3fKvVC5Zh8Usk2+UJJvR9OUW+o4i+r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411162730"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411162730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="889922472"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="889922472"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:17:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:18:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:18:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7d1FMEQAVotOqWpp66SJMR59NiRjx/iCdn1PTXV5QCLDAoXYsa1J3Pwb1SEkovAPVe7AwHUcOdYaP0wNR3Fep4XXYIXgHuZt3p0C0lrZOvnLf9lO4YQAoLkRiMFA3nbWOCCB4DFlvJ2Ul1HTDvdT611kpRX35taBxrCrEqyxhs2GaJmzR+xR3jTDplKAGwr56P3VVFkhtKJ5BjXc/lGud+fYKf+d5jguymsG2l3TWKB3iWM+uOgF9nN3YHgAcogHmopiVshycYyHf7jBIW/3EXYClPf9P80Iv7lih2JpHSJXAWI2t3TPE4mLbdOXf9rvEX67PjqIQQ/A56P5nqWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAr76/3bqMcrGFmIkZl835Rmp9LpHMyOu5vTaMiIM0I=;
 b=fW6+E9c4DITutoNEvYBliHkK7QAuUsYa+w+pGOhEc9WuAeXHL74SJumhJ0YwxzTJaWhK1XOlMhc1eSmHgqivCLzJkhjtteBi6x/tE6XXfQKSRCN3qOgyBiyZ5zm/F7eZvbpRDT1kFDSGqLfTmmISEf1mIgdZZNs9XAHbI75s7TZsA9m2ton+q7fEdSuyW6z7hTy32J9lXHuo9BoNa6305PSf414y98q4trMT+Tuk+6YQcZ/YjddOEeGP+h9huSgl8OslrgXdAeJmKq4lkjnlMUuCe0hnjryepe8nmj2heJn/OqhZQB3E7bbBQ2fj5AdfkwTHF/7O1fezDC/lhFPxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 13:18:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:18:16 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Topic: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Thread-Index: AQHZ6ttUqZRrjysqnUa2j9no88GC0rAjMOqAgACDIKA=
Date:   Wed, 20 Sep 2023 13:18:16 +0000
Message-ID: <DS0PR11MB7529AC66404B9E2AC3A6EB5EC3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
In-Reply-To: <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH0PR11MB5127:EE_
x-ms-office365-filtering-correlation-id: e114a460-bdb7-4446-fd28-08dbb9dc0cbb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLAkDGrGlpLMo8y5UliP+jKmOMV1c2P6SALjGHtN0Grvzl5OtLBcK6Q6Hg+mXaQgir3pKoqXKm8a522MRw3/L/WtG0ZAH3c2UmqsOEB67/VaHKbfilBvNvmte2wMUoV5GiA+wscS7vQIWcShdU0IMjmz65Udwk/cJBNWq+/01xP2VQsZh3ZSxwBuxekfzNWKFoSAwxdbnajzxwjvqDuyyTMA0JIPCPzIHD9ull+T94NmuIWjZ/gkc5A3Jd/2tOVDsm5MFm5lmdZmONnJX5YPa8HsqujyscXdLyojsGqFV7gpH1pmbMl/yfnqg0PxDxMmGTcd6fB4Ig6Hxvfhc6EfU1NggVRj3VhlhfRTCDQHPlbBUYVwSks/ElWj3bWjSJGcgns1RrR0jkyTU3/EJ6g5oJJtgw7AjqTURFmyxsjxS9Uj+qMqb8FlORlD6n1TgA1lZusR2UJ26TyASAKEOtKmpNOWleWdqkehfIJYQHfwnyktuOYNl7kdcFhYFH2uBgBUHUwskMi/89uB1LyNgWB/4glZUV7qNdR6iszoKCHyxobqX6aFMcCnvVNkyoem917MJTzS4+qJgkttOYGFHwuu8VXxI8r0JN1q84pEWhH4RUdJp47tI4SjIhwd0IlzGzfK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(2906002)(4744005)(7416002)(52536014)(5660300002)(4326008)(8676002)(8936002)(55016003)(66556008)(41300700001)(316002)(54906003)(64756008)(66476007)(76116006)(66946007)(110136005)(478600001)(71200400001)(53546011)(6506007)(83380400001)(26005)(9686003)(66446008)(82960400001)(7696005)(38100700002)(33656002)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVptTkR5TDBlVE4wZk5zckYwZnRHdzUzQzhFWjA3VUVDYWRzeEZXa3RyZHJZ?=
 =?utf-8?B?eHc2ZjBWL1dCYkllT3FZQnJYN2pqUzY2WUJoQ2lmNm1SNk5TcDBlcTVLWkoy?=
 =?utf-8?B?bDlUWGQvajJaY2F1SDNOZE5jQUg3dm1OUWo3MnNrbEtNcms5anlTcThNVlpy?=
 =?utf-8?B?WVlFVHZZLzRjdjBMblhZeENrdUc2U1oyOHlUcTlCWGsxUmNwUGZyUWFORmhh?=
 =?utf-8?B?c0g2d2RSdDBPT0VmMHJZRjYxckQ3bGlSNjN3alBISHI4a2JzQm5ncm5tQUJa?=
 =?utf-8?B?NkpVamxSM0pSRjk3UmRlZ2MzR1J5SzBFREdjTEFDMyt0MjRDYUZXRkFuRFNs?=
 =?utf-8?B?NUNNTXc1NEJhc0trNldDS2xEZmQxamxMQzVLRTRvUGV3L3NtRW9aQTBBYlkz?=
 =?utf-8?B?L3VBRXhoWENWNjZiL3ZKTGYxOHB1YXdIcE12dEhwb2RpajhFVVFrNnYrU2Mr?=
 =?utf-8?B?Nkh3azJjYWZLaExmcFdmYkFaYjY3dnpqaHNUNEI0QSs3djVJR3NsUHNLYVl4?=
 =?utf-8?B?WGtWN1VXdHVCTDJBWEV5Q2JKVXE4NnRqTEN0bDBUbkZpRlJLbm9mcUduZ2dJ?=
 =?utf-8?B?SkdDSG5oWCtaTGxVeW96eHptaFlmcHRtRE1BMFFvQytpUGhEbDgvZmhLSmIx?=
 =?utf-8?B?dmY3OFQyc0pGR0JNMS92dGZEKzFmWmRTc1BFSlpHQ2pMMnl1NGJScXpQMk9B?=
 =?utf-8?B?bmxXS05IVzMwRk5GMjVFenRmMjZsbHVKWGNpcTZ6VzdvazZFZ0pFUzFFTkhI?=
 =?utf-8?B?ZFBLRmdFSkNrbFJUM2EyODFlQ09ia0tVaDIzMEtGSWRVZi9Ud09vSFE4eVVO?=
 =?utf-8?B?b0dLcmVsMlRBWDZGb2VBYU9xbGJiWDhFUVhvNkR0dGJsQVlVNVlMM0I2Tzhu?=
 =?utf-8?B?MnpMa093K1kyV0lCQTJMUXN2QmpqZmxyc3lKUWtQM21mTFpUNXQ1RzBleTVF?=
 =?utf-8?B?Mi83YjM3SEhadXhCWnFpaUxYQ1BHbC9EN3VjNWJEUzNWN2tQbU9JZjJybDUr?=
 =?utf-8?B?N1h0NU1GUzJ2SmhnWU80Rk1pbjZLejRsellIQ2tHVGRDdldKVHNwWDFzRzR5?=
 =?utf-8?B?Sm5jdjJXY1FGYTRoTm9wWS9HVXZRZlRoS3dsd3BTdmo2eU1abkV1SUFERkxN?=
 =?utf-8?B?RnN4MXZDVlIxV1FZZ3QyQjZ0L3JELytDczAwUnhXU2dFeXBrZit4RzRHOEZa?=
 =?utf-8?B?ZGdvRk9Ub1pyZmR3K29BNy9ha21FcDFTbVV6T3hZLzNFMEpyMHFITktLVERS?=
 =?utf-8?B?blhhV1QwL1FOaGJrblFqaXBSbDhGSGttRUtoQ3JBelYwdnJYZTZqS3d1NXp4?=
 =?utf-8?B?dWtWeW90Y0tWVHdoUWpnWXMwMWlncFZDQjVjSUI0eWJkRkh0U0pLRUptZzN0?=
 =?utf-8?B?QXBjeG40SThaWHQ3ejRYcmgrYVM4Smd5RVFuU2tZaUlCdnZkZFltMGZ6V2RC?=
 =?utf-8?B?VDhTdUdOUU54SE1CN3hEb0M2NFQvS25NUWpwQlBDY0RCMUptMFhISmQxUGdN?=
 =?utf-8?B?VHVOMDZ2blE1OFByRkVWcmRBZDVmUm1xSmkrWEt3TmFPZ1NPbElCYXN4QkEx?=
 =?utf-8?B?eDRMcE56OHNzMUEzaVJwTzh2NFJTS0NTT1c2akFyQnR5R1N4OERoNHdXWTJQ?=
 =?utf-8?B?MHorQ01zemVlSm1SbkhSY2xxU0R2Rm4wR2FqMFNFZDg5OXZzR3JrakxIQ2VH?=
 =?utf-8?B?cWU5SG8xeU80cGtDWnpQVzBGQ1FHNUlPZEwyVDRjNzgyUU1QT0JrTHFycVdJ?=
 =?utf-8?B?QWV0dWFwUTZ4ZjF5VklVM080dFduVS9MSkVRSXhqY3QwRnMvdVJSZEpzV04y?=
 =?utf-8?B?Ymx4RUw4dlFsUHZzVFhOYWdDR05TbWs3VCsxU3hKTjc3aU41S2E3MjJzZGh3?=
 =?utf-8?B?Sm5idjg0SkJKWlh1V3kySVR2OFdBM1pNekxZVndxNWwvNmh3QVBycU94dWt2?=
 =?utf-8?B?bHFWSWFuUWV4cWdJNzlrWVhxa09QRTZWYkMwcTRMald2b3lHejZ6L3BRV040?=
 =?utf-8?B?WEoxMHNNMG91WnptWXgyOVVkVno4M085MERUSDMwYjRBdkkrL1hMUjBwb0Rv?=
 =?utf-8?B?a0thRnNlMDY3OEFqYmd5VE9nWkEzb2d2czJ5eng0cTZ3SjNpMGNsRTJaWm9s?=
 =?utf-8?Q?ZQME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e114a460-bdb7-4446-fd28-08dbb9dc0cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:18:16.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YM3tlXk/yL5UUvGni1gyS/8BXn0x+MdY+pwfYVdCOMeGceE3hij05s8v2H7WIL6Kyk+r7C5uHWOqJE1+NdsTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAxOjI5IFBNDQo+IA0KPiBPbiA5LzE5LzIzIDU6MjUg
UE0sIFlpIExpdSB3cm90ZToNCj4gPiBUaGlzIGFkZHMgdGhlIGRvbWFpbl9hbGxvY191c2VyIG9w
IGltcGxlbWVudGF0aW9uLiBJdCBzdXBwb3J0cyBhbGxvY2F0aW5nDQo+ID4gZG9tYWlucyB0byBi
ZSB1c2VkIGFzIHBhcmVudCB1bmRlciBuZXN0ZWQgdHJhbnNsYXRpb24uDQo+IA0KPiBEb2N1bWVu
dGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdDoNCj4gDQo+IERlc2NyaWJlIHlv
dXIgY2hhbmdlcyBpbiBpbXBlcmF0aXZlIG1vb2QsIGUuZy4gIm1ha2UgeHl6enkgZG8gZnJvdHoi
DQo+IGluc3RlYWQgb2YgIltUaGlzIHBhdGNoXSBtYWtlcyB4eXp6eSBkbyBmcm90eiIgb3IgIltJ
XSBjaGFuZ2VkIHh5enp5DQo+IHRvIGRvIGZyb3R6IiwgYXMgaWYgeW91IGFyZSBnaXZpbmcgb3Jk
ZXJzIHRvIHRoZSBjb2RlYmFzZSB0byBjaGFuZ2UNCj4gaXRzIGJlaGF2aW91ci4NCj4gDQo+IFNv
IGhvdyBhYm91dCwNCj4gDQo+IEFkZCB0aGUgZG9tYWluX2FsbG9jX3VzZXIgY2FsbGJhY2sgdG8g
c3VwcG9ydCBhbGxvY2F0aW5nIGRvbWFpbnMgdXNlZCBhcw0KPiBwYXJlbnQgdW5kZXIgbmVzdGVk
IHRyYW5zbGF0aW9uLg0KPiANCg0KU3VyZS4NCg==
