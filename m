Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB367493A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 03:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjATCOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 21:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATCOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 21:14:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1E9F051;
        Thu, 19 Jan 2023 18:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674180853; x=1705716853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JgC++dL90KJFvA1AnCtwBy8Z0SWTXtzSD/rG4uVzh08=;
  b=Pkx0L/HY2Xo+t37f+6utfELf0dn4OrydWXcN5UW5Nmei568AjBY4qsDt
   UKJYqhAbTadcGPzIPEYa+Xqb+zOYUexBZ3EcB5N56FzyK7ooNfj463Nxx
   ZWuZ32j1+ZKhffcq9+EggEO6O/z9ZZXzl9D092ATHXLeFyeP7uUTRUjiV
   oKH5n7LB2W0vY6BlItqUGkdcHYUfkTzfd8ojjl0DQeHEH/xB4vMeQlVfp
   Ha1XFPcznSmS73cx8RHpnTCceeNY6w6BxUNTLdljuOW7sZLM9eWQp+7I+
   OGVF9UvEuCQflzWWAHxnWt9RvXPgx1X5uWUO/JPglsR8vIQJBh1FIOiSL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305164447"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305164447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905813204"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="905813204"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2023 18:14:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:14:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 18:14:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 18:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPDJ4PzCnZc3FkE4HBXFOhMYdIyOJjX8G2RTrv4cTr7FuAgfzPahnY+UrGTpB8kTcsOyTujWM6i+2hVfr/EMIkYiyOG9U81U/33a3EBbjOmSCkxytsiojJt3V7Xo6xYxJxgIIZUCmjmfE+kuI3AEylFMOZ3+K+IRRpH6xaiDdc4hi6g7mXiM/YSJTVWLdbZcMEO2sOA8Zay9zjV5YRovU3wqQbWRj8p/OWQmmfQ+bWqu9Ozc+paozB+2foJJzPx1mqP4rObqYSS2FeFIBuWNm7iWrcP/keACZakQZeCnJW1OX9J7Of8YK0YBBfAzn8tJdccGP65k3MKrK6vJdd+4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgC++dL90KJFvA1AnCtwBy8Z0SWTXtzSD/rG4uVzh08=;
 b=Qkw5gIcjPKk9IME70uEyMOf29pOelY9F2a2a/Dfl4TuTJOy9T1/F2I22HP6iCkU4MyYpo16ceCYQsNgIRa2qog0opWL+JvcYBsmHwMv3b12eJIqAjbq9bVLFZ+MuV+YRZIPewCnjX+ZEjN/v7aT2UOUjSVjeWFBRn4JT2++9obub9ESdaCsV49XQexKJpptpLSsWrjeG6Vxdq5uY3I7JMls09fS3c3Pl3uLIWLO6bazvbu4x22IWwYNK+uNywdBUoB/ANqSNi493KRozn1E4Ut28ttcEGjcMrEs8WMt2IU7q+DJyozWnobne+kDaHZZ/5bAFYHfTbyArh3jD5t24Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Fri, 20 Jan
 2023 02:14:04 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 02:14:04 +0000
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "github@mlq.me" <github@mlq.me>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "i@cloudlinux.com" <i@cloudlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gruss, Daniel" <daniel.gruss@iaik.tugraz.at>,
        "raphaelsc@scylladb.com" <raphaelsc@scylladb.com>,
        "boldin.pavel@gmail.com" <boldin.pavel@gmail.com>,
        "michael.schwarz91@gmail.com" <michael.schwarz91@gmail.com>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Thread-Topic: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Thread-Index: AQHZIQIql4irGLCJxkaX5rlFhWY8ta6P1SQAgAAH/ICAAAedAIAArb6AgAIMroCAAxmegIAN/taAgAJIKoCAAKftgA==
Date:   Fri, 20 Jan 2023 02:14:04 +0000
Message-ID: <595d50b8bf12acfbc4e5dadc0ed7379a7ed81db5.camel@intel.com>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1> <Y7bT0OL8RAWkCu0Z@kroah.com>
         <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
         <Y7bg5sxEZDIaGoXK@kroah.com> <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
         <Y7kqx5cBCVojq6QJ@kroah.com> <Y7vEg/VHWsp86B6r@ziqianlu-desk2>
         <Y8eCA7hdde07a4gz@ziqianlu-desk2> <Y8lsCzWJv73sBeyj@kroah.com>
In-Reply-To: <Y8lsCzWJv73sBeyj@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3062:EE_|SA1PR11MB6824:EE_
x-ms-office365-filtering-correlation-id: 987ffa27-cb49-4875-ee8c-08dafa8c00c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/CCWDuM9f7VQTE3yXPfxIfjcqhSvBoReZ7Q8MFIZy3DBQps08EnZyA2GoNNqtnpOHR5FPH6F1/pHjtC4/3iKv5ROoaEBxQR84tsLiB4+BH/SMs/6kVmdDRm7lx8Lr/CSmuXn7EwWQi5OgQeYusLZyakqOcfLGIkQwPPCkXhe+monUmueBZF0G0/1UV8wiu5+nDeotUrK24ubolqq23A9Daqu5DurBoAZPekhME6WdL+Ec5VTWuLTBja0bk6tJ7yLHCp5y439aTdtdXYbPkwCh7y5En4yYtNFQiMnJL0WZxx8/lesIRzJ3m45v8y41z4TSRkXFoJwU5RHjhg8DaCKii2JS1q0TQCUvr51jDVJsrFCg+AfIf2WiAfuoVhS8ADYPPj73MT/gl/NFJHAbQxBYU3Y87C96Ve5qflA4AhhRdBpsT6ZWiOrw9CqtKQYN1JjoXbcqJ+lQEF1c12hU6grZuSPEgJ65tp1ZhLX6PlTVn7Q5wQVl/1Z2CWlSAmqZUwvkYUfOex+Wa9NR1r+5HxyhuL953XO2l1CGv0sE0uk3N6bisvxz5gV9jaeg8wDn/tGPQnojnu8BWoHsc4tKUo0PgtXNCL2qshPNd9mamUnu/FdKnLiORI2WQqyAhctzARsmSIkyhUm0++jbMTt8cl/Ix5sfbW4JqH4Vx+cCK9F+hmOZkG6usn7gH4oiRSzv7UfdhpOKCUD6j0raPS9rF3lABhFWIlCwo4x947zqrQuQtfKtkkN3sNSq3stXGGPfcLEOdFenFOxK81+1S11igQog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(38070700005)(316002)(8676002)(82960400001)(91956017)(71200400001)(64756008)(6916009)(66446008)(54906003)(36756003)(41300700001)(86362001)(6512007)(6506007)(6486002)(26005)(66556008)(38100700002)(186003)(122000001)(76116006)(66476007)(2616005)(4326008)(478600001)(66946007)(966005)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1k4N2dlemFHWHRlUWw3Ym9vYkFKMDZMY09kUUoveXJVVkh1YWlJNWNjYlI3?=
 =?utf-8?B?aTZRNjBpTytDWEpoalpRSFBLMEx5b2Zabk5wQnZRUU15bVpHc2pBSUl0Sld1?=
 =?utf-8?B?WWJ1V25DL251QTlCM1d0SStVRmJOZWtVU3labkg5aWRUUitPbEpJcWN0Smtq?=
 =?utf-8?B?NGtYSzZsMXhaSk9XemYyQWJybEJNSmUwYnBDTGNzU2NaN3NFMGlZR281M2xL?=
 =?utf-8?B?MVFNam9uQk40YXZYdmxWT1JtQUpGY0hsTGtFSkFQUVNYcGNkK2ZlQ2dVWXpt?=
 =?utf-8?B?a3hQS2tnZlpkNDl5VVAwMVl6LzNZa3VyT0JRdzZPNUZsMFJ3Zm5pUWJBR2pk?=
 =?utf-8?B?Y0syNFl5SmtSTXBaUVpHWkg3bkFTTHRDdGNxY0NCT2F2TE1GbHBVZktaYnd5?=
 =?utf-8?B?SkloUXoxT1BrclhZRXJqZjNTZnRKV3hDTzg3Z3UvbEJRY3NtR05ibDAvQjBE?=
 =?utf-8?B?MVAzdHRGM0U1M3FhQWF0b1A2bml0aWFYc2JiZ2JwdEt6QjlBUXMyeGhTbDZl?=
 =?utf-8?B?b0xTTXFjaGhQN2hJU2dXN3B2SzNHdFd6cENnWWNsb0xJTC9MbzQ4VFZvOGZo?=
 =?utf-8?B?QTlXVlBObngrYmp5dE82MzB3dFk3RWxzYnZYRmhnaUhnam5nM000dGlxSEhj?=
 =?utf-8?B?NndJTlJmSEx6Vms2emFLUWFMcXBZVXk2OWdSbVJDdUZTYlpMa3JteFRhZFYr?=
 =?utf-8?B?SjJWYmRhcnJqSE9BVXhBNWkvUEZMRlVuSmUvcVc4SEt3NktBS21EOVZMczV6?=
 =?utf-8?B?ZEE0aGxnRURpazV0SXkzclVZN2VoMmdIOXdxWk52elFlUUE1ME1laDdMbnNB?=
 =?utf-8?B?VWFreUV1VldoWHlyWjNodExvVk5keFh2K3JURkl2OTRyOTREcTkxNmhNMUtL?=
 =?utf-8?B?K2EydTJoajR5QjZZNllINGdWa3VrSjVXZE1DbVd2S0dkZ3JwakV1dXZaQTE1?=
 =?utf-8?B?bjl5NzV6WVAzRGJQT04wV0xNMWdQaTgrS0pnb3RTVS9FU3RadUtMQXpXNVJ0?=
 =?utf-8?B?ZVhXcWZseUw3UHFpSFI4aXRwbWU2b1BDRkwzR04wcnczNWFiVXRXeVhXTldW?=
 =?utf-8?B?TUdCNmxHS25MdVp5Q01EMW1oZzhkYmRJMjRPeDltUXd2NXJYcnZ4ckx4Wk5Z?=
 =?utf-8?B?RUNua2JrZlVPZnBBM3V6MEQyYmNndjQ1MG91ZVNwNDFXbll5Y2RFWUZ0NVU1?=
 =?utf-8?B?Q00yeWtGNFg2eXgvTk53TjVxNWIrRm1oRUdGUW5hNitPNEFrQmRQSSs0Vit2?=
 =?utf-8?B?YWdMK3dnNEhRUGJCUkxTUW5JN3VxekQyMWdsUkU3N001ME9iV3ZPcEVJL05w?=
 =?utf-8?B?YWUrS2FCOUZuSVJxODUvYVpZMmtmU09tMm14MmxmVDk3dzZCTEtxRTY1TG51?=
 =?utf-8?B?cnUrZjVLbmZFeTRSRDZzaExkTHU5NVVYVHI0bUJLQXBvUFg3L2s4YTFXRXl1?=
 =?utf-8?B?cUNqYzdKOFVVZE5rTGc4Y3M0NzdScHlwa2JaTFYyK2d3S3Z2OVpMQzlKbkVC?=
 =?utf-8?B?V2JFU0NwOGRvcEtQWnpselc2T201bDlZWlYxZnZObUFrbndEZkI5Sm1QVGFp?=
 =?utf-8?B?eDkzbU5VeFY0bGhvOHdWWWVSTDJpNTUwR1JWSWo5QnoyckRydDNUa2ZmbENm?=
 =?utf-8?B?SXBMTDNoVk9pNnFHSXQ2T1p0K2FKdVdHV2hUamtDY2hQdUYydGlUUHV5WlNB?=
 =?utf-8?B?VnVGeVI4bjJsdHQ4SnJMMEM1emFkWmtSS3BOMmhZbWZ3azBZTXBZMlMwc3VF?=
 =?utf-8?B?ZEVhckNOc1k0QzVVOEVQL1ZTWEpJYzNCWkNIMW9mbnh0UnBZQTdEYjYySytF?=
 =?utf-8?B?U3NZMUdBNWR4aVFKS1ZKWWpnQjdXRFhZaHFxUDF6S1UrenYzOWlVNWZsYW9j?=
 =?utf-8?B?eGJyRjNoMWJ0K2RmdG9Pc2VqaXNkL2s3QnBqMUd3WHRPWW1odFhUM0hkeVFo?=
 =?utf-8?B?enVKV1dBVzAvRWpZeU5rSXEyVENpOFNyWmo3eTNEcmNpUGU4TzhNWWYrd0x4?=
 =?utf-8?B?Zm8weWpUdVJhNmd1TmtIMTBCSXZpbC9PT2RZUlNicUZ1dHZaZTVFRnNUUHQ1?=
 =?utf-8?B?MitPaGFzRm9oU3BvMWRTbTB1eTNvT2pQQjhCT1Z0S1FFZ1pkWlBlOW9pN1dj?=
 =?utf-8?Q?wm7HG5QL5DI/alLGaHUcMw05j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5C0301987892F4E97FD3505074EDF93@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ffa27-cb49-4875-ee8c-08dafa8c00c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 02:14:04.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFZonVq1Cez412Ykfhdc7wJXqpD0l+vcLKQi5ZeZj12bx7ETK1Av+ils8MiHiVEKyOlpWzpsduJx4NIaL5CRWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDE3OjEyICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBX
ZWQsIEphbiAxOCwgMjAyMyBhdCAwMToyMjoxMVBNICswODAwLCBBYXJvbiBMdSB3cm90ZToNCj4g
PiBIaSBHcmVnLA0KPiA+IA0KPiA+IE9uIE1vbiwgSmFuIDA5LCAyMDIzIGF0IDAzOjM4OjQzUE0g
KzA4MDAsIEFhcm9uIEx1IHdyb3RlOg0KPiA+ID4gT24gU2F0LCBKYW4gMDcsIDIwMjMgYXQgMDk6
MTg6MTVBTSArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBKYW4gMDYsIDIw
MjMgYXQgMDk6MDA6MjFBTSArMDgwMCwgQWFyb24gTHUgd3JvdGU6DQo+ID4gPiA+ID4gSWYgeW91
IGRvIG5vdCB0cnVzdCB3aGF0IEkndmUgZG9uZSBpcyB3aGF0IEkndmUgY2xhaW1lZCwgbm93IHRo
ZQ0KPiA+ID4gPiA+IG9yaWdpbmFsIGF1dGhvciBQYXZlbCBCb2xkaW4gaGFzIGdpdmVuIHRoZSBw
YXRjaCBhICJMR1RNIiB0YWcsIGRvZXMgdGhhdA0KPiA+ID4gPiA+IGFkZHJlc3MgeW91ciBjb25j
ZXJuPw0KPiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCBzZWUgdGhhdCBhbnl3aGVyZSBvbiBsb3Jl
Lmtlcm5lbC5vcmcsIGhhdmUgYSBsaW5rIHRvIGl0Pw0KPiA+ID4gDQo+ID4gPiBJdCBhcHBlYXJz
IFBhdmVsIEJvbGRpbidzIGxhc3QgcmVwbHkgZGlkbid0IG1ha2UgaXQgdG8gbG9yZSBmb3Igc29t
ZQ0KPiA+ID4gcmVhc29uIGJ1dCBJIHNhdyBoaW0ga2luZGx5IHJlcGx5aW5nIGFnYWluIGFuZCBJ
IHN1cHBvc2UgeW91IHNob3VsZA0KPiA+ID4gaGF2ZSByZWNlaXZlZCBpdC4NCj4gPiA+IA0KPiA+
ID4gQnV0IGp1c3QgaW4gY2FzZSwgdGhlIGxpbmsgZm9yIFBhdmVsJ3MgbmV3IHJlcGx5IGlzIGhl
cmU6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBQm9odkVQV0JIbXJScFpj
UWVqVGtaK0NZdFlDeXU2ckZNZDRkb05uX0NNazM1dW0rZ0BtYWlsLmdtYWlsLmNvbS8NCj4gPiAN
Cj4gPiBOb3cgd2l0aCB0aGUgb3JpZ2luYWwgYXV0aG9yIFBhdmVsIEJvbGRpbidzICJMR1RNIiwg
ZG8geW91IHRoaW5rIHRoaXMNCj4gPiBwYXRjaCBpcyBPSyB0byB5b3Ugb3IgeW91IHN0aWxsIGlu
c2lzdCBzb21ldGhpbmcgZWxzZT8gUGxlYXNlIGtpbmRseQ0KPiA+IGxldCBtZSBrbm93LCB0aGFu
a3MuDQo+IA0KPiBJIGRvIG5vdCBzZWUgYW55IHNvcnQgb2YgdGFnIHNlbnQgYnkgUGF2ZWwgKGhp
bnQsIHlvdSBjYW4gTk9UIG1ha2Ugb25lDQo+IHVwIHlvdXJzZWxmKSB0byBpbmRpY2F0ZSB0aGF0
IHRoZXkgYWdyZWUgd2l0aCB0aGlzLg0KDQpQYXZlbCBqdXN0IHNlbnQgaGlzIHJldmlld2VkLWJ5
IHRhZzoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FCb2h2RU83OTZhZWk3WWZ1THNq
UVpvZXJtbnlCXzVROVljd1QwNlBBdUZkeDJzKzBnQG1haWwuZ21haWwuY29tLw0KDQpUaGFua3Ms
DQpBYXJvbg0KDQo=
