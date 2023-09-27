Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F127AF932
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjI0EV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjI0EUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:20:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B85CE9;
        Tue, 26 Sep 2023 20:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695784217; x=1727320217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9tromIp2kUJlksVZtYO/Zp7OCwbj86ImJBCowuaxkvM=;
  b=EzlsKR+1/PkW3StXIqijkCYe3GmIpx6k3DVY/gQT1sKnfCNNfPWDeAgO
   /HbJ94V46GIeXxrsXau+KMEt/ufgq4Mb5N/3XJqTvE2YHbPD3pU/s/exQ
   DOKy/33J4wQA+1KLyFrdmNWlvXmT38z31rBl4wJDG1ocn5/MfHdJqVAVU
   q60dM9qvo2Cf41cCncreIgh7qnHWVovZLZ0Ye0k9vhsQfxRq/+y3fg0UC
   bLCCwH52LIxE0J5UhWq6feNulkvePjLJLnpyr2M62ctU4upEtCN1f1zs7
   VQMOIVuId35cs10omT43G4PUH6aIfj/CFKCMVmxmHkQuKq8RItG4KrrIQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384498695"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384498695"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="839256853"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="839256853"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 20:10:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 20:10:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 20:10:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 20:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGNOkRYQ0hEL5eR5RrbvHfVXI3Bb/hAOGalhl3N5KrXjHQvg5c3oumKID9fw6gCY9CKDNWQ13achqTV6oKOJfcXK+ze0ErTALfnipQR7HyJ3AsYz36oL9YidKKl5mTDic2uTd8ygR6eh29TJNFBddugHIScDz3qM5uO/3vUF5KpogiIe7y4tI5vYx5FOQXXUEW2qQUDycJElD4D2JlDi+dnC6iwcpbvGdMWtlZZ1PwrlpKGvjXwQpGjJrlup2Ety4PkqY2szoHVAMrw0WK8PWFXSJxlscP0FIYTUouQby0BI1XLfQIe9q5Nn5pJqbMBRRbNMgQI08fQ6JDERnok1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tromIp2kUJlksVZtYO/Zp7OCwbj86ImJBCowuaxkvM=;
 b=eKOLDJyqGEgJMakhIW5g5O5s5wl7Nyq7f1VvmsIQa6IssEh+NDBDR+G654+ELMgCV+4DjI9yUoXEpanly98N+Z86GH09sjsc3QBaKYmvHTpZ+RVsNJBRzkHpMb1DzTtidr40pV9Dnjot+b5+QpgUTRUfZ5sEgAGLgO9MVymhgk8f+SPvYCxBUaNiUO/9aErf5ziqZvO+gsxL855DHX4mIRbkBAYcX2UvkuBVgCjcpZigFGRo/fb+8K8APpoA/aD1WdWRK6fsqFX1M4YieoNV7C74u5mPMNH0lOxeO0o19tvupYQ9Iq/QPFKqXjs7ssBaLIfkVObuj2Q4jtjab/UEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 03:10:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 03:10:06 +0000
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
Subject: RE: [RFC 2/8] iommufd: replace attach_fn with a structure
Thread-Topic: [RFC 2/8] iommufd: replace attach_fn with a structure
Thread-Index: AQHZ8Fua6Ou0I2akPEq6mAMBA4Zmy7At8NKAgAAMZJA=
Date:   Wed, 27 Sep 2023 03:10:06 +0000
Message-ID: <BN9PR11MB52761BC2182680172F71775E8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-3-yi.l.liu@intel.com>
 <e73f3a0e-5c1b-674e-7ef1-53d963a540d3@linux.intel.com>
In-Reply-To: <e73f3a0e-5c1b-674e-7ef1-53d963a540d3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 66f52ff4-e16d-43c3-f575-08dbbf073ff8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hR8x/EvfqWOyk99DMD1Q9az0DRvXwQaXlz6pFd8+khQWGeKToWQO9hnc9s5c+oXUr9w0FDLJZVDlOyjMfZPWv5I2zA85QIqeKuTDF5VOKY7t8TXS4ZZ1HEaEaiUJLHX4KUb5qOXBMMtKkFTa5ikJVB6M6398jYAbOew9YZVFrOL9zg/ywZQ+gafbYlslexe/7B26/D46ZSQmLKUIOFlfFXE0ACjOcIzEWHizqbaaTjmTPT/v7s5Ctyc97+Oj883u6Hl9NAJ+UCDsQkUme8083dU3slafwFI5dWVLGEfj32HPItyd3a6dx6H55uDXvRYm03M6YMrFzKFykEMCk0WSf8IHn/kIdQRXoxMQEd6CGnkNGfJC8dXBs5GphlYebLJWOyFJDLjEeCvw4l1A+hMo4sUA+3bk/YWVbJtjBI92Bw8KlUvUCOBRyomdYkSU+GY5lPrAiXsQFlXI6OOJXl9MtWE5HIXfaObD77QlHanouYNMSTMpyH/iC1xttQJrf9CTpoJHNJWxh1u/UiIRwiGnYMDIgY0N9KF85yf+Jr+VobfHqZJXFJvKjMVXvlif5RZYKS3fCGD8/IO8RvWiODpYs7AXcbjvKG06eSXfl6V0lf4czZtoB/1DYZynARqvBNW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(2906002)(54906003)(41300700001)(316002)(110136005)(8936002)(76116006)(7416002)(64756008)(66476007)(66446008)(66556008)(66946007)(8676002)(9686003)(4326008)(52536014)(478600001)(122000001)(26005)(71200400001)(5660300002)(38070700005)(33656002)(7696005)(38100700002)(6506007)(53546011)(55016003)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek42Q1dtT1gxaHhYOVFnLzNRVnpyOFFDYWVBZ1J0M25KWmJ2STUwQnprRUUz?=
 =?utf-8?B?MnZrNGNIbER6NHlmZWlIS0NOUm04bzNiNHVvL1pLUzhvYit4U3RSVmxNNUhk?=
 =?utf-8?B?R1ByMVdKVzFWWHp5OGtPOUxNeEp2NlV2aHRXYWN5aTJOa1YzZGRyU3BrVm1H?=
 =?utf-8?B?VVNCVE02WWxsL255SCsrNzRDOEE3S3RtaFRteHE4NzRZeVVnM0hRaFF0aE04?=
 =?utf-8?B?OE5NUXo4TWFDMTREdHhqZ0xWNCtWZVlUajdhMFFwb3VJV0JaMTFlYktCN2l5?=
 =?utf-8?B?eGl6c3J4eldIYkhPVXd1cDAvbXVlVHF0dUFvRUVBWEpoRGNFR0N1UXY0Q05M?=
 =?utf-8?B?S2E4MmFoOTZidStHS3Z3Q3kwNXVqaVAvcXNiUDFyRXI5TG5rK2gxb05PVFFM?=
 =?utf-8?B?Ri9oQ2tGcEJXVFpzOWVaLzJMYUxpdDZXUXNxZEYrR3JrL2cvb0V4c0tjUlpm?=
 =?utf-8?B?RmZjN3BIT1BJOXkxMFVqbEcyNTJaOFI1RnJDb2JuNzJwV25ockdqbkFGcW9n?=
 =?utf-8?B?Q09xSVZBWFNzV1EwUFJtdUZkbjFxN3prTFplOGUrNmNiekxYNlNMcnhqdklJ?=
 =?utf-8?B?SVJEc3VhdzZSNXExYmtucEx4WmVtRkdSVHgrd1VZVWl6K3lLTlc1UVBzdzZQ?=
 =?utf-8?B?cjA2ZnhjbE9OVU8rRlg5Rmh1WTJ2VW1md0hLeFgwSEM5WXBCMlRBbkFQNHU2?=
 =?utf-8?B?aTRnQUVRclNtRi9BYlgybk5wZTI1UVdOdzdTSUUyMDVsUkluOWxYOVEzNVcz?=
 =?utf-8?B?L2RNejgyOWEycWpoVnpOZnMzdkk2T1cwVzM2ZGlVU25KUm1kajEvN29QUk5O?=
 =?utf-8?B?Tm5XYXhheVdIOTUzN2VYZGZ0RG9GL1VyVi9iRCs5N3lMNHltbG5FbVk1RFBV?=
 =?utf-8?B?VThTMlkranFsc09pV1RnYXNMUGFSbkk4WnAvSURiYkxha2tLOG1oTW1GMi9U?=
 =?utf-8?B?clBjSnNnUzlTeVJ6ZTBBaXh1MVhJRG03VEFPaVJ3ZmZzTTFPR2g4VlNSWTA4?=
 =?utf-8?B?dEpsL09iZkloYUxIWTM5azErK3lUNlJPREp1SHI4Z3BUcjFZSlk4UzMvWERF?=
 =?utf-8?B?dnJ3UFh3Y1JteXhCd0VrZUtZZUZoSWJneWhOUXpGbVBUQ3A4czVrZTlVRVY5?=
 =?utf-8?B?T1NDOGFGT01HQzdoem9FRVI0Z1JpZDBYYXZVSWFVMVF2eHUyZ25KRldTTWx1?=
 =?utf-8?B?RUVleXNldlBHNDNEQ01kSHVHd3ZZdEg4ME5BOUhJQzIyaGxWUk9oVU9rbmhj?=
 =?utf-8?B?RjZwSFY1Wk5oa2xBTFlnMDlnaDdkUVNOV0M1MjlaMkJNTHovSmxoSVlpWHBP?=
 =?utf-8?B?d2UwTyt2NFlmK28rWHU0V016U2Z6YUlic3ZjUDRoNWRZNjlJaTBiSllTM2FM?=
 =?utf-8?B?Z0toU2lJT05zTkxkWTVWUkRwc1BQQkNQTjErR1QwVHh5UE5YeVNCSFhaZEdi?=
 =?utf-8?B?S2dKZDBqdVQvSUlHWmN1Rk8wb1BYY3hQcjJYMGRTWWJJREZBeU84K1NndzZT?=
 =?utf-8?B?OVlvSXBXQzRZVVVTNk5PcDdoQ1RDbzFTcVUvWkFhUGNzN0R3UUhOL0lHNDUw?=
 =?utf-8?B?TFFBaGJxYkdxUkQ3K0lHRDdjK0UzcSs4TU1BSTZyU2IyeE5FRkZ0Z3ZGZlNh?=
 =?utf-8?B?RDU0S0g4S0ttdjJuakQxY2VMR09ZUlRadEVVWGFYWmZoQVpzeElRU3U1bkFn?=
 =?utf-8?B?L25NSGdDYVpWcDg1QmdPT05kR1gxQ1cvT0hPOVlhWUhIM2xSdDcvWUZWUk53?=
 =?utf-8?B?UWw2SWQ1ME9EYTNXdnExeDJUanN5NHB2ZzM3ZUZVVkFLMTZDNUhVWjZpSkli?=
 =?utf-8?B?WUVnZUpEcXNTWnpKbnZncEFZNkJId3k4cXRLaHJKWmh5Q0pVN3YvelVONUFE?=
 =?utf-8?B?cGwxZWdUbkx6N0FNeWxDUTRRNWRjaWZKQ09YOHlWZ0UyOVJuckR5SStxdW5t?=
 =?utf-8?B?a2dOVktwc2JLemNaQkdVY0lQRG52aFlsZVBlVFZodlI0K2xtc0J4akZmWTJz?=
 =?utf-8?B?Q3RRRm9ES2FlelluOUc0dWtJb0FKL0NWdWhHRERaYjBxazRCR3MyeWIzdzhW?=
 =?utf-8?B?QVlJQjliR2FZM0dsMVh6TnYrZHd3L2oveXhCSnNkZ21wVVdkRXdJNDhwN21s?=
 =?utf-8?Q?QChDt4oWWclu1xCtqFNwGaZte?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f52ff4-e16d-43c3-f575-08dbbf073ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 03:10:06.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJj0QArzhzhrLicXsLajlOvkFSS2BldW1nv2mzeDKgq+05C9T1vFsRnRqv7PiBfoZHo8mugU6coact6DDFUwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAxMDoxOCBBTQ0KPiANCj4gT24gOS8yNi8yMyA1OjI2
IFBNLCBZaSBMaXUgd3JvdGU6DQo+ID4NCj4gPiAtdHlwZWRlZiBzdHJ1Y3QgaW9tbXVmZF9od19w
YWdldGFibGUgKigqYXR0YWNoX2ZuKSgNCj4gPiAtCXN0cnVjdCBpb21tdWZkX2RldmljZSAqaWRl
diwgc3RydWN0IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpod3B0KTsNCj4gPiArc3RhdGljIHN0cnVj
dCBpb21tdWZkX2h3X3BhZ2V0YWJsZSAqZG9fYXR0YWNoKHN0cnVjdCBpb21tdWZkX2RldmljZQ0K
PiAqaWRldiwNCj4gPiArCQlzdHJ1Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKmh3cHQsIHN0cnVj
dCBhdHRhY2hfZGF0YQ0KPiAqZGF0YSkNCj4gPiArew0KPiA+ICsJcmV0dXJuIGRhdGEtPmF0dGFj
aF9mbihpZGV2LCBod3B0KTsNCj4gPiArfQ0KPiANCj4gSSBhc3N1bWUgdGhhdCB0aGlzIGNoYW5n
ZSB3YXMgbWFkZSBiZWNhdXNlIHdlIG5lZWQgdG8gcGFzcyB0aGUgcGFzaWQNCj4gdmFsdWUgdG8g
dGhlIGF0dGFjaF9mbigpIGNhbGxiYWNrLg0KPiANCj4gSWYgc28sIGhvdyBhYm91dCBwYXNzaW5n
IGl0IGRpcmVjdGx5IHRvIGF0dGFjaF9mbigpIGZ1bmN0aW9uPw0KPiANCj4gdHlwZWRlZiBzdHJ1
Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKigqYXR0YWNoX2ZuKSgNCj4gCQlzdHJ1Y3QgaW9tbXVm
ZF9kZXZpY2UgKmlkZXYsDQo+IAkJc3RydWN0IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpod3B0LA0K
PiAJCWlvYXNpZF90IHBhc2lkKTsNCj4gDQo+IEluIG5vIHBhc2lkIGNhc2UsIHVzZSBJT01NVV9O
T19QQVNJRC4NCj4gDQoNCnRoYXQgaXMgb25lIG9wdGlvbiwgYnV0IGFsc28gbWVhbnMgdGhlIGV4
aXN0aW5nIGRldmljZSBhdHRhY2hfZm4oKSBuZWVkcw0KdG8gYWNjZXB0IGFuIHVudXNlZCBwYXNp
ZCBwYXJhbWV0ZXIgd2hpY2ggZG9lc24ndCByZWFkIGdvb2QuDQoNClNvIHRoaXMgcGF0Y2ggY2hv
b3NlcyB0byBoYW5kbGUgdGhlIHBhc2lkIG5lY2Vzc2l0eSBpbiBhbiBvdXRlciB3cmFwcGVyDQph
bmQgY29udGFpbiB0aGUgcGFzaWQgYXdhcmVuZXNzIG9ubHkgaW4gcGFzaWQgcmVsYXRlZCBhdHRh
Y2hfZm4uDQo=
