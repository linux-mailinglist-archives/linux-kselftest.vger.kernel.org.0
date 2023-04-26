Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75D6EEC2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 03:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbjDZB7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZB7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 21:59:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B213E;
        Tue, 25 Apr 2023 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682474357; x=1714010357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xZLxVRPbDS7BdnEZWog/plt9Yoq9FWW0EQB1BaNOsS8=;
  b=BY8Ilxarx8aBqrOguXUCs/qlMxhgLnXBcN1+kZTzjzGFLyIGD24tVPrD
   3e9BmZO0bq7zBLwZs+FXBP7qbgO4cWZ5nmcL42EdLT88Z6jpdGUK6N0Xe
   R9LBSzOaSKLlheOAaksMQGkjpGJaoo8NCyXMwDbZFxX6OcdygPHHlUMjO
   WuYLL56djcWSf6vYYWA5tRzr53sinWdOGZ5jkBFWbyLjwfTf7BYLblt1x
   LLfKkhXnV/EvOp9WjKReN3eM/EbbS+pn1LBfLkLGTTyN2qq8fnD6yYuf2
   WscLSehr+w94cufV33wifwsAKdbng0Osl2uc4aK8PZTQgRm/4zgZwj/vd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="344418552"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="344418552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="693760575"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="693760575"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2023 18:59:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 18:59:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 25 Apr 2023 18:59:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 25 Apr 2023 18:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSSOVzAb2DHyKKzt+ly/ssMVAB3TlROD26D2LPsoB+lfsSITFg9svR6XGd6KBI5OCcicTTJx+iKf6dRazKhK7aJDQmG2Tvsb4vjPMKc/8znfNRkkMi4Fdn74TwRPull3uCY+I+fzDw/f8auBHcePg2pjkn/nDTZ1eISV1VNRVRyMPIdicIT1nDwK+BE+T6/agULc6E4AtRtMQfyzkeahkbC0yfekMcbSfh5fmIa7RHT/NGgxuS31rBV8uGI4n8B6b0euLZzkyYy6qRfGfBvJIeOZq7kyfyluHJFjkfNfopUv6J8R66A5c5GeAdOP6V7uUOK9oMxJ2NODmp7UKWTyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZLxVRPbDS7BdnEZWog/plt9Yoq9FWW0EQB1BaNOsS8=;
 b=XF4QLTH7Q5IdLj5Gnu8x22wYqOfOGLFwuZUqP0TlWFDiKNWAAM198A/Jx1IElq155XrZyjbCcHox1A56wwOo65ht4zzRF/I47Nas2m0BdRBOoDXdS0PJzKQKcgB8rzKj1QaBSKWHQTq3UAFayF4Z/C0J2wx1I/e3JE1lJ1TP5gRHop5uD6We3O0q5OhBNUzfKvP4820eZh1hqENJ5aaFBZCE8LgcB3WdkqRjcmzhIj4Ynth9/xE9s6Exre5qtV6+BjAYB7bmc0Dgo7JgfDk8cHRtfCPP06kg6hUE72kEFLvi79p8Pj/UlptNh7h4AlO0mhod9ygengRmXOeUIirVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 01:59:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2%5]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 01:59:13 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZbbn0bzmMFjR3OEyC2JtDS40vY68q0D8AgBH04YCAACTMgA==
Date:   Wed, 26 Apr 2023 01:59:12 +0000
Message-ID: <40b6ca5df5988305fea734e559fe5c8b3a22df78.camel@intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230413034108.1902712-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <632a9a27abb5da053caedbbc6bcb7d5e15b2322c.camel@intel.com>
         <0da37de8-6036-f475-d80d-92c77fb7cbaa@linux.intel.com>
In-Reply-To: <0da37de8-6036-f475-d80d-92c77fb7cbaa@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB7980:EE_
x-ms-office365-filtering-correlation-id: fc6664ff-adc7-44d8-baf7-08db45f9d521
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFHDrlGrS64eqAyZVIg4kBed052FUynxm7alKIg4HvFzSZVCk9uDjpqq2lgoIpBD6VBPKvvH1prFUPrv3+HP4YPmQ9QO7RPAciJstxmuVBrhz/NMBiVwmebGC1lLQH0ojnc4zmyEspbHPj+MexSV54lHCWyhhKqtfTejEy+ka2N6Nz/YPjUTLdShM/+qtEXet1U6MVCKnbDzD026EwJBZAWvLY1sFS8GFbYXyW/nzafmViGEm3Tf6nM+T4Gl/OG5UNqagmrdigjeS6JaEgM/rsyUrOVfzZxTKG3rS17s1ZXD9wNQn37msD1bY84en0aoYPMixsfKBOZl/ZmGI9Mp8NL08msCzNKDtv7fWZj/IL8CUJogViCO8fZiEUQ5rYdH5PFMaFHFVXnGzY1sJ+G9Y0s3onTEHuPlPTxkdW8zvHEydRfbTx/JDbDUNzHmxdIDRCdLSfIhA2Q8Ig6qaib5DWo9LcljVbx8lJH1KwgMLKLvstoZr8pDN6Vsw0euAgzD3pwGIcFeqtZYXEy+IenrlOmDd3sf+VskU3b2b3g3eVetK2zEyioA0lcmKHuVXh+Go7nW2oLjYWe5CNDNiaFGi9qaGOkvL5Mn8icKUACqHuXQ2GdUoD2bozi9w31CJW0R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(38100700002)(122000001)(53546011)(82960400001)(6506007)(6512007)(26005)(186003)(2616005)(8936002)(83380400001)(7416002)(2906002)(8676002)(5660300002)(36756003)(316002)(6486002)(71200400001)(54906003)(478600001)(38070700005)(110136005)(4326008)(66556008)(76116006)(41300700001)(66446008)(91956017)(64756008)(66946007)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTI3YmRWZXZNOGZKZzVPaUEvYkFabitmUjkzRVMxYzFYRFRuZmJJRWdvVUZn?=
 =?utf-8?B?cWk0Qlh0S3l0VDJOOWlVRHhzZW1naVFIaE5lcXBUR3JVajlJUmlaT2FQUnBN?=
 =?utf-8?B?WG9DNlJ1YUNrZ1lzYTZOZ3orQWJ5SlhidzNtUXhhUURQU21ZUS93Q0lqK1hr?=
 =?utf-8?B?MzlCdnlQY1V4TWxTS3o4N2x4SlF6Tzh6dit3bzhpS2hmZFdCRkU5Vm9XS05h?=
 =?utf-8?B?di8yemQyTU12NkN4bVlqUDVPVjJndVR0ZDFEdzUyUVdPUzNkWmlCOVE5Zit6?=
 =?utf-8?B?MzVwQUJEOHdtSnlPV2NjZXRRTWtZa1Fhd0dQQzRIaFR0ZWI5Z09GOUowZTE2?=
 =?utf-8?B?QUxRTncyUXVnR3ZmSThlM1VCSkc1WHhQdk5wd2MzWXZWR05ibmRIeFR4eVhk?=
 =?utf-8?B?YXArbXdjbUdRMzZRcGJkbnQvWk41cWRyQ1Axb0YrS2ZBTVVuRkxna0VTcUJQ?=
 =?utf-8?B?RHlDajJYU3J1TVJqSmhMQWh6djB4RTVFY1Jqb3hjcGhxMDFCWTNaTkVuYW9r?=
 =?utf-8?B?VFpuczluT1VldDFaUHZNa1ZEblgvNnh3U0JjT0xnYmZQcWRVSU9DZHlYL3Ru?=
 =?utf-8?B?QTlhTG5EYTNpaDI0S3dvTEQxMTFIYkFuNDNMdDlWQWxTRlVybTVpM3lFSTFa?=
 =?utf-8?B?RjE0MXVEVmhPK3ZiSzg4QjVnTjFXeUZCWGJaRks4Q1V6QTd6eXlBS2dHY29i?=
 =?utf-8?B?d0J1MHBqMllUVUt0bU5PNUhtU0QxTHgrVWNlSGMxR3NkcVdWejYya3I5NkN0?=
 =?utf-8?B?MVpVUDhsZ0xPakdiMWM2RmY5MkV2QTU1QVpaU1VsYnYzeGFnLytONkF3RlVF?=
 =?utf-8?B?NVpQWHVIM3lBSEp6ZlpCZzBkTzhiZmtNRDByenM5NTBSTkZmNDg5eDFpdi9y?=
 =?utf-8?B?UjdzNzFWZElQcnd6bTVFQ2xINXhWNUNCTVhQUFFMYU9paDJ5ZDU5UW92dlNw?=
 =?utf-8?B?MW1Rcm81bHZWTmFEc0YzN0tjUXphV3g2M04yYUdPZkE3RmxZYldoUEs4Mncz?=
 =?utf-8?B?bklzeVhVU3RxTThVU2hLZUdVQmRVYytoV1MvbDdrQ2pQRFoxVTRackxmMUxG?=
 =?utf-8?B?cy9yUnNFSUVHb0NzUjZlMm5nY1NvL0ttWEo2b2RpWkNWazdoaW8walZSTUU3?=
 =?utf-8?B?bVhsYUJIRWZnQTBMZUF3TU1LbWxURWFxTzFsWE05SEZjZTRvOVFHWXV5OVVn?=
 =?utf-8?B?OENtbEk4eFNMRWpJVlRZM2ZGa2xSTkVXVU1aZTMrVUF5SVRBbFJMNkttclFG?=
 =?utf-8?B?dkpOcm9ac2NNclh5NjJLcG1xZWE0VjhldmtGR1dMU0VoQzcyVnk4b2kzY0hB?=
 =?utf-8?B?dkhLdk5vTEdna25iMmY5bCtOU1NOL0E3OFVSbTZFV3ZGNWIyTFZKWlRPTnFS?=
 =?utf-8?B?MElaNGtRRUZzcm4rbTVwQUZkYTk5NHNmZkkzLzVwZ3kzZktLbnFta2VYVllV?=
 =?utf-8?B?NEsxSXZWaXhQUGloK3pMOVFDbUkvbVBtdmhqZ3VHYXJncEhUM2NOWTR2OWhi?=
 =?utf-8?B?OXFYaExNQlRBSXRFMlBaSEtCYmNJVG9TNmJyNFc3Vlp6SWg4Tm0wZG5IN0dM?=
 =?utf-8?B?R0VjMjVQQXUrcEcrNlFyRDEyUXlHMVdCMHdVaXhzQWJaL1dtV0NyUXZqczlo?=
 =?utf-8?B?YTYwVmduak5qeXUvRjNDL1VFY2NqSHpCMnU4b3pTcDNNdmpLbkRkYS9WM1Jp?=
 =?utf-8?B?N0VMVEdnR2Q2UjRtdS9lUk5EVXd2Z3BYRE1TQThpeE5FMllSOG1FSXB0eVox?=
 =?utf-8?B?RXZVRHNEeHBwa21XUjlsVzF0a2h6TU4vaFdDejN1dm5YK3pVRGtYKzFITlRa?=
 =?utf-8?B?Ull5enZiSVZwN05Xbm9GUkhvUHpzSVNjNHRwMmJsMGp1NXFMaEV2QzZRd0Ey?=
 =?utf-8?B?aThZNzFMTC9veVE1UjVRc2JtenZCTDFId29POU5GVDBFZVpETnNXaFBqa2hB?=
 =?utf-8?B?NE13cUhBTzNBZ3YyVGlvbnljb01pQ1hQUkVicjl5NGxlaGlQZDczTTNHS1g1?=
 =?utf-8?B?ZGR0SzFUbTB1c3BpbDVISjFlU3lCczZLZDNjOXcrRFloTjg5K1ZFcjZwSVdE?=
 =?utf-8?B?MzFKeS8rS3pBN1NXMGN5clpmZkxGdXlTK2IvcUdaUVRBTTBmTlg4SmpYL2Nh?=
 =?utf-8?Q?kqZyJHXiUoZ0OOrCADuodSoKN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6863975FA61EC4EA25F6247A3CB7BC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6664ff-adc7-44d8-baf7-08db45f9d521
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 01:59:12.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pucvL16popzJ8qYFECC07Hw1td0pyeCYRhZrN6Bafemh6cAfeo9+uVIfSyaO7/6wzgq6tM8Jjh92nM7Q5rMN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDE2OjQ3IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gSGkgS2FpLA0KPiANCj4gT24gNC8xNC8yMyA2OjM0IEFNLCBIdWFuZywg
S2FpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMy0wNC0xMiBhdCAyMDo0MSAtMDcwMCwgS3VwcHVz
d2FteSBTYXRoeWFuYXJheWFuYW4gd3JvdGU6DQo+ID4gPiBIb3N0LWd1ZXN0IGV2ZW50IG5vdGlm
aWNhdGlvbiB2aWEgY29uZmlndXJlZCBpbnRlcnJ1cHQgdmVjdG9yIGlzIHVzZWZ1bA0KPiA+ID4g
aW4gY2FzZXMgd2hlcmUgYSBndWVzdCBtYWtlcyBhbiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQg
bmVlZHMgYQ0KPiA+ID4gY2FsbGJhY2sgZnJvbSB0aGUgaG9zdCB0byBpbmRpY2F0ZSB0aGUgY29t
cGxldGlvbiBvciB0byBsZXQgdGhlIGhvc3QNCj4gPiA+IG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQg
ZXZlbnRzIGxpa2UgZGV2aWNlIHJlbW92YWwuIE9uZSB1c2FnZSBleGFtcGxlIGlzLA0KPiA+ID4g
Y2FsbGJhY2sgcmVxdWlyZW1lbnQgb2YgR2V0UXVvdGUgYXN5bmNocm9ub3VzIGh5cGVyY2FsbC4N
Cj4gPiA+IA0KPiA+ID4gSW4gVERYIGd1ZXN0LCBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IGh5
cGVyY2FsbCBjYW4gYmUgdXNlZCBieSB0aGUNCj4gPiA+IGd1ZXN0IHRvIHNwZWNpZnkgd2hpY2gg
aW50ZXJydXB0IHZlY3RvciB0byB1c2UgYXMgYW4gZXZlbnQtbm90aWZ5DQo+ID4gPiB2ZWN0b3Ig
ZnJvbSB0aGUgVk1NLiBEZXRhaWxzIGFib3V0IHRoZSBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0
DQo+ID4gPiBoeXBlcmNhbGwgY2FuIGJlIGZvdW5kIGluIFREWCBHdWVzdC1Ib3N0IENvbW11bmlj
YXRpb24gSW50ZXJmYWNlDQo+ID4gPiAoR0hDSSkgU3BlY2lmaWNhdGlvbiwgc2VjdGlvbiAiVlAu
Vk1DQUxMPFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQ+Ii4NCj4gPiA+IA0KPiA+ID4gQXMgcGVy
IGRlc2lnbiwgVk1NIHdpbGwgcG9zdCB0aGUgZXZlbnQgY29tcGxldGlvbiBJUlEgdXNpbmcgdGhl
IHNhbWUNCj4gPiA+IENQVSBvbiB3aGljaCBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IGh5cGVy
Y2FsbCByZXF1ZXN0IGlzIHJlY2VpdmVkLg0KPiA+ID4gU28gYWxsb2NhdGUgYW4gSVJRIHZlY3Rv
ciBmcm9tICJ4ODZfdmVjdG9yX2RvbWFpbiIsIGFuZCBzZXQgdGhlIENQVQ0KPiA+ID4gYWZmaW5p
dHkgb2YgdGhlIElSUSB2ZWN0b3IgdG8gdGhlIENQVSBvbiB3aGljaA0KPiA+ID4gU2V0dXBFdmVu
dE5vdGlmeUludGVycnVwdCBoeXBlcmNhbGwgaXMgbWFkZS4NCj4gPiA+IA0KPiA+ID4gQWRkIHRk
eF9yZWdpc3Rlcl9ldmVudF9pcnFfY2IoKS90ZHhfdW5yZWdpc3Rlcl9ldmVudF9pcnFfY2IoKQ0K
PiA+ID4gaW50ZXJmYWNlcyB0byBhbGxvdyBkcml2ZXJzIHJlZ2lzdGVyL3VucmVnaXN0ZXIgZXZl
bnQgbm9maWNpYXRpb24NCj4gPiAJCQkgICAgICBeDQo+ID4gCQkJICAgICAgdG8gcmVnaXN0ZXIv
dW5yZWdpc3Rlcg0KPiA+ID4gaGFuZGxlcnMuDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IFsu
Li5dDQo+ID4gDQo+IA0KPiBXaXRoIHN1Z2dlc3RlZCBjaGFuZ2VzLCB0aGUgZmluYWwgdmVyc2lv
biBsb29rcyBsaWtlIGJlbG93Lg0KPiANCj4gKy8qKg0KPiArICogdGR4X2V2ZW50X2lycV9pbml0
KCkgLSBSZWdpc3RlciBJUlEgZm9yIGV2ZW50IG5vdGlmaWNhdGlvbiBmcm9tIHRoZSBWTU0gdG8N
Cj4gKyAqICAgICAgICAgICAgICAgICAgICAgICB0aGUgVERYIEd1ZXN0Lg0KPiArICoNCj4gKyAq
IFVzZSBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IFREVk1DQUxMIHRvIHJlZ2lzdGVyIHRoZSBl
dmVudCBub3RpZmljYXRpb24NCj4gKyAqIElSUSB3aXRoIHRoZSBWTU0sIHdoaWNoIGlzIHVzZWQg
YnkgdGhlIFZNTSB0byBub3RpZnkgdGhlIFREWCBndWVzdCB3aGVuDQo+ICsgKiBuZWVkZWQsIGZv
ciBpbnN0YW5jZSwgd2hlbiBWTU0gZmluaXNoZXMgdGhlIEdldFF1b3RlIHJlcXVlc3QgZnJvbSB0
aGUgVERYDQo+ICsgKiBndWVzdC4gVGhlIFZNTSBhbHdheXMgbm90aWZpZXMgdGhlIFREWCBndWVz
dCB2aWEgdGhlIHNhbWUgQ1BVIG9uIHdoaWNoIHRoZQ0KPiArICogU2V0dXBFdmVudE5vdGlmeUlu
dGVycnVwdCBURFZNQ0FMTCBpcyBjYWxsZWQuIEZvciBzaW1wbGljaXR5LCBqdXN0IGFsbG9jYXRl
DQo+ICsgKiBhbiBJUlEgKGFuZCBhIHZlY3RvcikgZGlyZWN0bHkgZnJvbSB4ODZfdmVjdG9yX2Rv
bWFpbiBmb3Igc3VjaCBub3RpZmljYXRpb24NCj4gKyAqIGFuZCBwaW4gdGhlIElSUSB0byB0aGUg
c2FtZSBDUFUgb24gd2hpY2ggVERWTUNBTEwgaXMgY2FsbGVkLg0KDQpJIHRoaW5rICJmb3Igc2lt
cGxpY2l0eSIgYXBwbGllcyB0byBhbGxvY2F0ZSBJUlEvdmVjdG9yICJmcm9tIEJTUCB1c2luZw0K
ZWFybHlfaW5pdGNhbGwoKSIgKHNvIFREVk1DQUxMIGlzIGVhc2lseSBndWFyYW50ZWVkIHRvIGJl
IGNhbGxlZCBvbiB0aGUgc2FtZSBjcHUNCndoZXJlIHZlY3RvciBpcyBhbGxvY2F0ZWQpLCBidXQg
ZG9lc24ndCBhcHBseSB0byBhbGxvY2F0ZSBJUlEvdmVjdG9yIGZyb20NCng4Nl92ZWN0b3JfZG9t
YWluIGFuZCAicGluIHRoZSBJUlEgdG8gdGhlIHNhbWUgQ1BVIG9uIHdoaWNoIFREVk1DQUxBTCBp
cw0KY2FsbGVkIi4gIFRoZSBsYXR0ZXIgaXMgc29tZXRoaW5nIHlvdSBtdXN0IGRvIChvdGhlcndp
c2UgeW91IG5lZWQgdG8gYWxsb2NhdGUNCnRoZSBzYW1lIHZlY3RvciBvbiBhbGwgY3B1cyksIGJ1
dCBub3Qgc29tZXRoaW5nIHRoYXQgeW91IGRvICJmb3Igc2ltcGxpY2l0eSIuDQoNCj4gKyAqDQo+
ICsgKiBTaW5jZSB0ZHhfZXZlbnRfaXJxX2luaXQoKSBpcyB0cmlnZ2VyZWQgdmlhIGVhcmx5X2lu
aXRjYWxsKCksIGl0IHdpbGwgYmUNCj4gKyAqIGNhbGxlZCBiZWZvcmUgc2Vjb25kYXJ5IENQVXMg
YnJpbmcgdXAsIHNvIG5vIHNwZWNpYWwgbG9naWMgaXMgcmVxdWlyZWQgdG8NCj4gKyAqIGVuc3Vy
ZSB0aGF0IHRoZSBzYW1lIENQVSBpcyB1c2VkIGZvciBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0
IFREVk1DQUxMIGFuZA0KPiArICogSVJRIGFsbG9jYXRpb24uDQoNCklNSE8gdGhlIHNlY29uZCBw
YXJhZ3JhcGggaXMgb2J2aW91cyBhbmQgbm8gbmVlZCB0byBtZW50aW9uLg0KDQpBcyBleHBsYWlu
ZWQgYWJvdmUsIEkgZ3Vlc3MgeW91IGp1c3QgbmVlZCB0byBhdCBzb21ld2hlcmUgc2ltcGx5IG1l
bnRpb24NCnNvbWV0aGluZyBsaWtlOiAiZm9yIHNpbXBsaWNpdHkgdXNlIGVhcmx5X2luaXRjYWxs
KCkgdG8gYWxsb2NhdGUgYW5kIHBpbiB0aGUNCklSUS92ZWN0b3Igb24gQlNQIGFuZCBhbHNvIGNh
bGwgdGhlIFREVk1DQUxMIG9uIEJTUCIuICBPciBwcm9iYWJseSAiYWxzbyBjYWxsDQp0aGUgVERW
TUNBTEwgb24gQlNQIiBjYW4gYWxzbyBiZSBvbWl0dGVkIGFzIGl0J3Mga2luZGEgYWxyZWFkeSBl
eHBsYWluZWQgaW4gdGhlDQpuYXR1cmUgb2YgdGhlIFREVk1DQUxMLg0KDQo+ICsgKi8NCj4gK3N0
YXRpYyBpbnQgX19pbml0IHRkeF9ldmVudF9pcnFfaW5pdCh2b2lkKQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCBpcnFfYWZmaW5pdHlfZGVzYyBkZXNjOw0KPiArICAgICAgIHN0cnVjdCBpcnFfYWxs
b2NfaW5mbyBpbmZvOw0KPiArICAgICAgIHN0cnVjdCBpcnFfY2ZnICpjZmc7DQo+ICsgICAgICAg
aW50IGlycTsNCj4gKw0KPiArICAgICAgIGlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVB
VFVSRV9URFhfR1VFU1QpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAg
ICAgICBpbml0X2lycV9hbGxvY19pbmZvKCZpbmZvLCBOVUxMKTsNCj4gKw0KPiArICAgICAgIGNw
dW1hc2tfc2V0X2NwdShzbXBfcHJvY2Vzc29yX2lkKCksICZkZXNjLm1hc2spOw0KPiArDQo+ICsg
ICAgICAgaXJxID0gX19pcnFfZG9tYWluX2FsbG9jX2lycXMoeDg2X3ZlY3Rvcl9kb21haW4sIC0x
LCAxLCBjcHVfdG9fbm9kZSgwKSwNCg0KY3B1X3RvX25vZGUoc21wX3Byb2Nlc3Nvcl9pZCgpKT8N
Cg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZpbmZvLCBmYWxzZSwg
JmRlc2MpOw0KPiArICAgICAgIGlmIChpcnEgPD0gMCkgew0KPiArICAgICAgICAgICAgICAgcHJf
ZXJyKCJFdmVudCBub3RpZmljYXRpb24gSVJRIGFsbG9jYXRpb24gZmFpbGVkICVkXG4iLCBpcnEp
Ow0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ICsgICAgICAgfQ0KPiArDQo+ICsg
ICAgICAgaXJxX3NldF9oYW5kbGVyKGlycSwgaGFuZGxlX2VkZ2VfaXJxKTsNCj4gKw0KPiArICAg
ICAgIC8qDQo+ICsgICAgICAgICogVGhlIElSUSBjYW5ub3QgYmUgbWlncmF0ZWQgYmVjYXVzZSBW
TU0gYWx3YXlzIG5vdGlmaWVzIHRoZSBURFgNCj4gKyAgICAgICAgKiBndWVzdCBvbiB0aGUgc2Ft
ZSBDUFUgb24gd2hpY2ggdGhlIFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQNCj4gKyAgICAgICAg
KiBURFZNQ0FMTCBpcyBjYWxsZWQuIFNldCB0aGUgSVJRIHdpdGggSVJRRl9OT0JBTEFOQ0lORyB0
byBwcmV2ZW50DQo+ICsgICAgICAgICogaXRzIGFmZmluaXR5IGZyb20gYmVpbmcgY2hhbmdlZC4N
Cj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBpZiAocmVxdWVzdF9pcnEoaXJxLCB0ZHhfZXZlbnRf
aXJxX2hhbmRsZXIsIElSUUZfTk9CQUxBTkNJTkcsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICJ0ZHhfZXZlbnRfaXJxIiwgTlVMTCkpIHsNCj4gKyAgICAgICAgICAgICAgIHByX2VycigiRXZl
bnQgbm90aWZpY2F0aW9uIElSUSByZXF1ZXN0IGZhaWxlZFxuIik7DQo+ICsgICAgICAgICAgICAg
ICBnb3RvIGVycl9mcmVlX2RvbWFpbl9pcnFzOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAg
IGNmZyA9IGlycV9jZmcoaXJxKTsNCj4gKw0KPiArICAgICAgIGlmIChfdGR4X2h5cGVyY2FsbChU
RFZNQ0FMTF9TRVRVUF9OT1RJRllfSU5UUiwgY2ZnLT52ZWN0b3IsIDAsIDAsIDApKSB7DQo+ICsg
ICAgICAgICAgICAgICBwcl9lcnIoIkV2ZW50IG5vdGlmaWNhdGlvbiBoeXBlcmNhbGwgZmFpbGVk
XG4iKTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfaXJxczsNCj4gKyAgICAgICB9
DQo+ICsNCj4gKyAgICAgICB0ZHhfZXZlbnRfaXJxID0gaXJxOw0KPiArDQo+ICsgICAgICAgcmV0
dXJuIDA7DQo+ICsNCj4gK2Vycl9mcmVlX2lycXM6DQo+ICsgICAgICAgZnJlZV9pcnEoaXJxLCBO
VUxMKTsNCj4gK2Vycl9mcmVlX2RvbWFpbl9pcnFzOg0KPiArICAgICAgIGlycV9kb21haW5fZnJl
ZV9pcnFzKGlycSwgMSk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gLUVJTzsNCj4gK30NCj4gK2Vh
cmx5X2luaXRjYWxsKHRkeF9ldmVudF9pcnFfaW5pdCkNCj4gDQo+IA0KPiANCj4gDQo+IC0tIA0K
PiBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KPiBMaW51eCBLZXJuZWwgRGV2ZWxvcGVyDQoN
Cg0K
