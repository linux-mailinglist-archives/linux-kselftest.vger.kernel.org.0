Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF66F6AB9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 May 2023 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEDMBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjEDMBq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 08:01:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164CB6183;
        Thu,  4 May 2023 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683201695; x=1714737695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BWVDMVtVxHosqi6XwzjReGBzY98zN+I/jjo4/ZWw2Wc=;
  b=SL1nOSbySkqNw1LVvCKD5zpweGkiwg7uf8CJAvHLOp0ei8Cb6PaKuCLT
   aFfngVLG6lKWhGIvwdEoyd7r2yqwUH2hxBUF3zpJrYi9VSBD7kSW1HVYu
   DIlS0NgJLNFHPFDCVeCKdsHEWKQSYe6x5+tycZa4h0uMcj3xlvKhFZdpb
   b/LrVfFJgPM3UyRgBVCmexCH1ATd8oBiDNzWFJnykF7Yf/w2W/bg6AlT6
   pB0kG1rAxu+NYYjNdAC6KTVjs25Q1cHOzhooTDrmqreT82XH5oQHUG2C0
   WeKTF/Xg5Mjbl+7dvxp+ElRZbnqYflpn3mw5sOjY6dP4AvCZ65rjNLXEY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="338060337"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="338060337"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 05:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="729766688"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="729766688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2023 05:00:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 05:00:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 05:00:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 05:00:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 05:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpdYovXRHcDKMV5n6/rmnGs2IKuTE1l0vUYr0NcpseoNm6j2qaKQ8+rpm5NJ62snoLWpPKQYPyHADHkhIdhpESWizpjFXHXb/PGQbEqrpRGyfln2J5EnlaO1qwEvCvSIhrPNI4Z+49/pg7c9UM6sFlya680gY8efHQEbnqKd0PItYXenp7C+doYcmoAU8N1Za2+keybjPeAl7SdBlvORI8ySyeCaSyT+U6EbVezpCt7ygiuRhPkL7xkP7102OYDr45S3FrMSOhVYsmi/c5CJHg0MPL5gnz+G+Z8MyY07sFAvLUNQ2jlw09jI8Tp8/PbLivf1SEOYdoY0oQhWoeh3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWVDMVtVxHosqi6XwzjReGBzY98zN+I/jjo4/ZWw2Wc=;
 b=XVsvwETYRM62EXxZnab+DSUPzU1+OulGaHcUoCVLqEBUvxTx3zv5bSACjtRieB900F4EA/GdWElLV14fYPQfb4T5VThDJTiR3KjMunDMctOIfVfqDP4ss588n3DNBck1ylwTLG458jQex8cGK3O9r5IK4gKxnhLoWYAKG5ESXwzBmqd/H/ynjlgZF5dWgrUw8CSXR/YZNwNGpm1Dqtx0WhpQbf09AxmE+IoPrijvBPKiaIcb/gS5NNfK6h/ih2vd4hH6j52I8pnr61aReqrIHUj1/ravweWxIM9LRt1y+cVVZML5o8PDCOHKUeXRpEbfK/vBya/XXGlhyQQRGAf42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 12:00:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 12:00:47 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
Thread-Topic: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
Thread-Index: AQHZbbn4ML2XQOJ7RU6SRFNWYMPkZa9A1PQAgAQ06YCAAHEogIAEWToAgABQaQA=
Date:   Thu, 4 May 2023 12:00:47 +0000
Message-ID: <2477493b6fd7efa34aa2772cabf5f575c4c9ac8c.camel@intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <f33fe0bfb5b6e603bd259942d017076aa5e0015f.camel@intel.com>
         <dc7228c1-d37b-205a-ba81-3fc709fc51a8@linux.intel.com>
         <81c54b8e844d20fe080ddd65458a6036ee22ed33.camel@intel.com>
         <6d4a23ee-e30b-3b7c-f911-56b5b1d125dc@linux.intel.com>
In-Reply-To: <6d4a23ee-e30b-3b7c-f911-56b5b1d125dc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4665:EE_
x-ms-office365-filtering-correlation-id: e230952b-ce10-4154-1d46-08db4c973266
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRtcQ5SUTL0w5JRvm/FSApNQ+dN3KJT40qUhxZzv4lafx2HZGzaRw9HQ25OzAh8fFleDKBjKcUg73VINZxHjDER7fKxtSy1VRchfp7pJQJDZmSbteAac2PR3beupC0VVzrDXKwvUuLDzHB/nc3AG/FuGbQ/B8tPRt3b3W3a17bygsglq+wMlV2KGk6KxrNvHAg+bO+R41OLdV11EQoxiVLdP84KY/uj3l3DidvjoZdMNwWbULwEb5YS9psFS8oMG07MA+DyC+lr75sKdUE4hyoE4cfO6g1ctBQxnq4zgdzkiXdT08bakb2sA+vd6JNQQYxg2e6lHKqP2mk/Oded6It8qoxf/HfixtzO52+fB9pc9FxqtjRJuBilnWhO3RMybVBp7Tg7MovQkoGm3rjHUmwY5M1g3n39cHzvCQax+GIe8Mx/wq5Lm8b5DEcr55tenZIv9wKk1zLjBsFJ71gwOGAzXi1Gx99LvPuUiGyVqzo/APHZbii8DFhqNhtlQ4jLVCpFqCuayCUqGugGG43z8dq0sHGNlqJl4+jDAK9N6zJQNqrmVNcsslN+uYviJBwRMg8EYSIg/InN3nRvGmVHtkjmrlg8aNL0O4N3gKd80SpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(41300700001)(83380400001)(316002)(8936002)(8676002)(5660300002)(2616005)(4326008)(76116006)(66946007)(91956017)(66446008)(66556008)(66476007)(64756008)(38100700002)(7416002)(2906002)(186003)(53546011)(6506007)(122000001)(82960400001)(26005)(6512007)(6486002)(54906003)(966005)(36756003)(86362001)(38070700005)(478600001)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZzMkNqSU1HN3JDMXhXRk9HcXBqb1NFc01xTmhPM05BRDdsQ1NUZ0VveHRa?=
 =?utf-8?B?OVpiQTNFR1F2ajkzaW1BTUpQOUxyL2tkSWFmKzYwVDZDZmc0b3dOelNyeGw2?=
 =?utf-8?B?N3ZKcVhGcWtYMFV6SjhCMFRkUnVhTER0VkhaWFBSbFZPRVZGK2hsUXRXVS9L?=
 =?utf-8?B?Y3JVZDZScmd2S2g3Tnc0Ym05SnZyRTlab0tkWUN4REFlc2ZTdEFLQnF4anlW?=
 =?utf-8?B?bWI3VWtXOUZUUVkrUXVibVZ0WXZ6SmI3MVI5YW5BYi9jVEF3djJ1TTJPaS9H?=
 =?utf-8?B?OU1qb2wwVlM1VExjYXZXUS9xQjhTRUdkTmtaclE0UzFkQXJRODRGd01DdEIz?=
 =?utf-8?B?TUpObWZ6OGNQL3ZVc002dVJIcHVVVmNaaE10NEZIK2puMVRUT2lnZGJOVzBv?=
 =?utf-8?B?enNPdENBMEZiWjNHUyt3N1J5NDU5bzFRUFVyV09TdTBrOTB3aUV0WUhiVEFq?=
 =?utf-8?B?cVQ5V2dVcG5mTTgwNFFiVGNTRmg3Um1RbU55VVRWdFRtYm5zWms2OFROM0NJ?=
 =?utf-8?B?cE1TaWJOcDVUS2h4NUphM1puWit4blJhak0zdnBWQTh4anMrUmVNTGMwRUhz?=
 =?utf-8?B?dGdmdmJtWmVmaEcrOEJtMjQ3azFDT3YrZVREc2UzT0JxR2FtYVVzK1djSlA0?=
 =?utf-8?B?d3ZobXlxOTBCeFRTSElZSjF1bTRHdkxRS1laSGVrWlMzTHJsU1BIQVRpbVgw?=
 =?utf-8?B?Ync4bmxpT0Q2bEZJaGFhZFYvUnJWZHQ3VDdHTWo1bkdQbTM0a21ZSEs0ZTlC?=
 =?utf-8?B?YTc1Ulc2Slp4eWZ0M2NNeW9kcERyclJzRjVsMVJ1NE9rcENUdjR6Sm1pQlZP?=
 =?utf-8?B?dTU2SVJOaVovYnNULzFSdFV4RnQ5UHd1bXhHR1ZOb3gyMTYyazdrN0JkMnBx?=
 =?utf-8?B?R3lNUnRoV3hpUVpaYTN6ZlRtcXNlZHhGaFFEWFhhMUNGbzFyUExtdGd2Z2o5?=
 =?utf-8?B?YkpnUkozREJyaHRnKzA3MkppTDNPeFc0WFFZUGcxcHlnM0dEczVBRkpaTXNo?=
 =?utf-8?B?aStvNkdJcU81QjJqdkgrdEZaMGUxVy8wVGgxTVMxNi8yOTZmOFBhbWxYbWtu?=
 =?utf-8?B?TEYwYUhqVUJqWDExZnRPVEpzMlgxYy9rNzEzVTZsb1I2OGpJbWFybDNSMUdk?=
 =?utf-8?B?cW52YW5FSmtjazdHV3huTXRzREhhSWt4UytvbHlSQ3hIQlBvbzkwMHpDbzRU?=
 =?utf-8?B?aGtxdG9TQjNNeFNLcWtsUHRqSG5KMlVneGxIMko0Zkw2czNUUUtKd1kwdjV5?=
 =?utf-8?B?NXVFaU90MHk4UjN2NDROb0NnMlRaV0Y1S05kTnMyRVdIcEdqSTlWdVlDajhj?=
 =?utf-8?B?aUo3Tkt6TE5qUk9qOXBUR3ZmR1I0TWN3RFZFSFdpbGt0TE8zYlBwSVFWTWRY?=
 =?utf-8?B?TXZMcTNWRVAyMVRhQ2VueVZTYTc1RjhHLzdZQzViZEQ2VUQyWVc0bnNuZGZM?=
 =?utf-8?B?WEIyZFQyZmdCbEZwdGMxeVRoYzBLeHlkUEJEdTREZ0hGR3NnUHVyWUhUdFVP?=
 =?utf-8?B?VS9ETEIxeDloS1h0aHdwT0paeU5zWTgxMGdSZ3ZTQ2FsdkYxemZOcTN3NGFm?=
 =?utf-8?B?cGlxUG4yNlVHUjQ5SGQ0TG5xRDF5RHZVSGxYeEdTNUNMTFFkUjJGRlZrZnpU?=
 =?utf-8?B?bWlCVlVsVlViMTBJSzJMQ0NVbUgwMVZPK2o4ZllYblhRamc4UXJlS0xYM1dv?=
 =?utf-8?B?REt0L256TTJnLzBCRElER2ZPV1hDczZybWpCMURtVGovQWJKeUtvUnhybmFi?=
 =?utf-8?B?YTM2WnkzNEIvZFRyNWNrUDdOK1dVclI5eGVmbndDNUJ1cTQ1MjZNUzQ5c2h2?=
 =?utf-8?B?elZyWmY4MGdSaWhpbjBybDBuQ1l5cGhaZkwzdG1PMXJWd2c2SGlXaWlYNjlr?=
 =?utf-8?B?VENjYzdFMFlyR2xJalBabk1SOHRGamhXeHFWRjIvVXE0NWwzTzBneDNTZm0x?=
 =?utf-8?B?K2RWb1JBbzZNZGFmNE9HbC92eUtYQ3FNd3VGcG51UGxOKzB6TVVySDJhS1g1?=
 =?utf-8?B?V2lqZ25XSmpMWTZzVzlROWd6NThhSWdKcDI2T20vbVJoNlFrRHZYMTJtenNv?=
 =?utf-8?B?c2EvYkZrS1pUdzhVRGtmTEpHS2NoLzdYUWJkYTFIZHc2TWlKckhEcEFWVWhV?=
 =?utf-8?Q?jJ2PXVzoCLHTqh1GQxpakMUZm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F932B28042C34F88F0B56D8277878B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e230952b-ce10-4154-1d46-08db4c973266
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 12:00:47.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AHRIafXlK12viOjfx5of60NPbFl2YmQGqerZ7FDrRT9I844MzDIlz3leg50zSFWaxDvHCPk245X6pI3/VW74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTA0IGF0IDAwOjEyIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gSGkgS2FpLA0KPiANCj4gT24gNS8xLzIzIDU6NDggQU0sIEh1YW5nLCBL
YWkgd3JvdGU6DQo+ID4gT24gU3VuLCAyMDIzLTA0LTMwIGF0IDIzOjAzIC0wNzAwLCBTYXRoeWFu
YXJheWFuYW4gS3VwcHVzd2FteSB3cm90ZToNCj4gPiA+IEhpIEthaSwNCj4gPiA+IA0KPiA+ID4g
T24gNC8yOC8yMyA2OjQ5IEFNLCBIdWFuZywgS2FpIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gKwlhcmdzLnIxMCA9IFREWF9IWVBFUkNB
TExfU1RBTkRBUkQ7DQo+ID4gPiA+ID4gKwlhcmdzLnIxMSA9IFREVk1DQUxMX0dFVF9RVU9URTsN
Cj4gPiA+ID4gPiArCWFyZ3MucjEyID0gY2NfbWtkZWModmlydF90b19waHlzKHRkcXVvdGUpKTsN
Cj4gPiANCj4gPiBCdHcgY2FuIHdlIGp1c3QgdXNlIF9fcGEoKT8gIFRvIGJlIGhvbmVzdCBJIGFt
IGlnbm9yYW50IG9uIHRoZSBkaWZmZXJlbmNlDQo+ID4gYmV0d2VlbiB2aXJ0X3RvX3BoeXMoKSBh
bmQgX19wYSgpLCBpLmUuIHdoZW4gc2hvdWxkIHdlIHVzZSB3aGljaC4NCj4gDQo+IFRoZSBmb2xs
b3dpbmcgbGluayBleHBsYWlucyB0aGUgZGlmZmVyZW5jZS4gDQo+IA0KPiBodHRwczovL2xrbWwu
aW5kaWFuYS5lZHUvaHlwZXJtYWlsL2xpbnV4L2tlcm5lbC8wNjA3LjAvMTYwNy5odG1sDQo+IA0K
PiBJbiB4ODYgQVJDSCwgdmlydF90b19waHlzKCkgZGlyZWN0bHkgY2FsbHMgX19wYSgpLiBTbyBi
b3RoIGFyZSBzYW1lLg0KPiANCj4gQnV0IGl0IGxvb2tzIGxpa2UgdGhlIHJlY29tbWVuZGF0aW9u
IGlzIHRvIHVzZSB2aXJ0X3RvX3BoeXMoKS4NCg0KVGhhbmtzIQ0KDQpbLi4uXQ0KDQo+ID4gPiA+
IA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAqIHN0cnVjdCBxdW90
ZV9lbnRyeSAtIFF1b3RlIHJlcXVlc3Qgc3RydWN0DQo+ID4gPiA+ID4gKyAqIEB2YWxpZDogRmxh
ZyB0byBjaGVjayB2YWxpZGl0eSBvZiB0aGUgR2V0UXVvdGUgcmVxdWVzdC4NCj4gPiA+ID4gPiAr
ICogQGJ1ZjogS2VybmVsIGJ1ZmZlciB0byBzaGFyZSBkYXRhIHdpdGggVk1NIChzaXplIGlzIHBh
Z2UgYWxpZ25lZCkuDQo+ID4gPiA+ID4gKyAqIEBidWZfbGVuOiBTaXplIG9mIHRoZSBidWYgaW4g
Ynl0ZXMuDQo+ID4gPiA+ID4gKyAqIEBjb21wbDogQ29tcGxldGlvbiBvYmplY3QgdG8gdHJhY2sg
Y29tcGxldGlvbiBvZiBHZXRRdW90ZSByZXF1ZXN0Lg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4g
PiArc3RydWN0IHF1b3RlX2VudHJ5IHsNCj4gPiA+ID4gPiArCWJvb2wgdmFsaWQ7DQo+ID4gPiA+
ID4gKwl2b2lkICpidWY7DQo+ID4gPiA+ID4gKwlzaXplX3QgYnVmX2xlbjsNCj4gPiA+ID4gPiAr
CXN0cnVjdCBjb21wbGV0aW9uIGNvbXBsOw0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiANCj4gPiA+
ID4gV2UgaGF2ZSBhIHN0YXRpYyBnbG9iYWwgQHFlbnRyeSBiZWxvdy4NCj4gPiA+ID4gDQo+ID4g
PiA+IFRoZSBidWZmZXIgc2l6ZSBpcyBhIGZpeGVkIHNpemUgKDE2SyksIHdoeSBkbyB3ZSBuZWVk
IEBidWZfbGVuIGhlcmU/DQo+ID4gPiANCj4gPiA+IEkgaGF2ZSBhZGRlZCBpdCB0byBzdXBwb3J0
IGJ1ZiBsZW5ndGggY2hhbmdlcyBpbiBmdXR1cmUgKGxpa2UgYWRkaW5nIGENCj4gPiA+IGNvbW1h
bmQgbGluZSBvcHRpb24gdG8gYWxsb3cgdXNlciBjaGFuZ2UgdGhlIEdFVF9RVU9URV9NQVhfU0la
RSkuICBBbHNvLA0KPiA+ID4gSU1PLCB1c2luZyBidWZfbGVuIGlzIG1vcmUgcmVhZGFibGUgdGhh
biBqdXN0IHVzaW5nIEdFVF9RVU9URV9NQVhfU0laRQ0KPiA+ID4gbWFjcm8gaW4gYWxsIHBsYWNl
cy4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIHdoeSBkbyB3ZSBuZWVkIEB2YWxpZD8g
IEl0IHNlZW1zIC4uLg0KPiA+ID4gDQo+ID4gPiBBcyBhIHByZWNhdXRpb24gYWdhaW5zdCBzcHVy
aW91cyBldmVudCBub3RpZmljYXRpb24uIEkgYWxzbyBiZWxpZXZlIHRoYXQgaW4NCj4gPiA+IHRo
ZSBmdXR1cmUsIGV2ZW50IG5vdGlmaWNhdGlvbiBJUlFzIG1heSBiZSB1c2VkIGZvciBvdGhlciBw
dXJwb3NlcyBzdWNoIGFzDQo+ID4gPiB2VFBNIG9yIG90aGVyIFREVk1DQUxMIHNlcnZpY2VzLCBh
bmQgdGhhdCB0aGlzIGhhbmRsZXIgbWF5IGJlIHRyaWdnZXJlZA0KPiA+ID4gd2l0aG91dCBhIHZh
bGlkIEdldFF1b3RlIHJlcXVlc3QuIFNvLCBiZWZvcmUgd2UgcHJvY2VzcyB0aGUgSVJRLCBJIHdh
bnQgdG8NCj4gPiA+IG1ha2Ugc3VyZSB3ZSBoYXZlIGEgdmFsaWQgYnVmZmVyLg0KPiA+IA0KPiA+
IE9LLiAgVGhpcyBpcyBhbiBzaGFyZWQgSVJRIGJhc2ljYWxseSwgc28gd2UgbmVlZCB0byB0cmFj
ayB3aGV0aGVyIHdlIGhhdmUgYW55DQo+ID4gR2V0UXVvdGUgcmVxdWVzdCBwZW5kaW5nLg0KPiA+
IA0KPiA+IEhvd2V2ZXIgSSBhbSB3b25kZXJpbmcgd2hldGhlciB3ZSBuZWVkIGEgZGVkaWNhdGVk
IEB2YWxpZCBmb3IgdGhpcyBwdXJwb3NlLiAgSWYNCj4gPiBJIHJlYWQgY29ycmVjdGx5LCB3ZSB3
aWxsIG1ha2Ugc3VyZSB0aGUgYnVmZmVyIGlzIHplcm8tZWQgd2hlbiB0aGVyZSdzIG5vDQo+ID4g
cmVxdWVzdCBwZW5kaW5nLCB0aHVzIGNhbiB3ZSBqdXN0IHVzZSBzb21lIG1lbWJlciBpbiAndGR4
X3F1b3RlX2hkcicgdG8gdHJhY2s/DQo+ID4gDQo+ID4gRm9yIGluc3RhbmNlLCBwZXItR0hDSSB0
aGUgJ3ZlcnNpb24nIG11c3QgYmUgc2V0IHRvIDEgZm9yIGEgdmFsaWQgcmVxdWVzdC4gIEFuZA0K
PiA+IEkgdGhpbmsgaW4gYSBmb3Jlc2VlYWJsZSBmdXR1cmUgd2UgY2FuIGFsc28gYXNzdW1lIEBp
bl9sZW4gYmVpbmcgdGhlIHNpemUgb2YNCj4gPiBURFJFUE9SVF9TVFJVQ1QuICBDYW4gd2UgdXNl
IG9uZSBvZiB0aGVtIChpLmUuIHZlcnNpb24pIGZvciB0aGlzIHB1cnBvc2U/DQo+IA0KPiBJTU8s
IGl0IGlzIGJldHRlciB0byB0cmFjayBpdCBmcm9tIHRoZSBndWVzdCBlbmQgKHdpdGggYSBkZWRp
Y2F0ZWQgQHZhbGlkKS4gU2luY2UNCj4gcXVvdGUgcmVxdWVzdCBidWZmZXIgaXMgc2hhcmVkIHdp
dGggdGhlIFZNTSwgd2Ugc2hvdWxkIG5vdCBqdXN0IHJlbHkgb24gaXRzIHZhbHVlDQo+IHRvIGRl
Y2lkZSB3aGV0aGVyIHdlIGhhdmUgYW4gYWN0aXZlIHJlcXVlc3QuwqBJZiBuZWVkZWQsIGluIGFk
ZGl0aW9uIHRvIHRoZSAiQHZhbGlkIg0KPiBjaGVjayB3ZSBjYW4gYWxzbyBpbmNsdWRlIGNoZWNr
IGZvciBAdmVyc2lvbi4gQWxzbywgSSB0aGluayB3ZSB3aWxsIG5vdCBsb3NlIG11Y2gNCj4gdXNp
bmcgYSAiYm9vbCIgdmFsdWUgdG8gdHJhY2sgdGhlIHF1b3RlIGJ1ZmZlciB2YWxpZCBzdGF0dXMu
DQoNCkJ1dCB0aGUgaGVhZGVyIGlzIG5ldmVyIHdyaXR0ZW4gYnkgdGhlIFZNTSwgcmlnaHQ/DQoN
CklmIHRoZSBWTU0gaXMgYnVnZ3kgdGhlbiB0aGUgZ3Vlc3QgaXMgbm90IGd1YXJhbnRlZWQgdG8g
d29yayBwcm9wZXJseSBhbnl3YXkuDQoNClNvIHRvIG1lIHRoZXJlJ3Mgbm8gbmVlZCB0byBoYXZl
IGFkZGl0aW9uYWwgQHZhbGlkLg0KDQpbLi4uXQ0KPiA+ID4gPiANCg0KPiA+ID4gPiA+ICsvKiBz
dHJ1Y3QgdGR4X3F1b3RlX2hkcjogRm9ybWF0IG9mIFF1b3RlIHJlcXVlc3QgYnVmZmVyIGhlYWRl
ci4NCj4gPiA+ID4gPiArICogQHZlcnNpb246IFF1b3RlIGZvcm1hdCB2ZXJzaW9uLCBmaWxsZWQg
YnkgVEQuDQo+ID4gPiA+ID4gKyAqIEBzdGF0dXM6IFN0YXR1cyBjb2RlIG9mIFF1b3RlIHJlcXVl
c3QsIGZpbGxlZCBieSBWTU0uDQo+ID4gPiA+ID4gKyAqIEBpbl9sZW46IExlbmd0aCBvZiBURFJF
UE9SVCwgZmlsbGVkIGJ5IFRELg0KPiA+ID4gPiA+ICsgKiBAb3V0X2xlbjogTGVuZ3RoIG9mIFF1
b3RlIGRhdGEsIGZpbGxlZCBieSBWTU0uDQo+ID4gPiA+ID4gKyAqIEBkYXRhOiBRdW90ZSBkYXRh
IG9uIG91dHB1dCBvciBURFJFUE9SVCBvbiBpbnB1dC4NCj4gPiA+ID4gPiArICoNCj4gPiA+ID4g
PiArICogTW9yZSBkZXRhaWxzIG9mIFF1b3RlIGRhdGEgaGVhZGVyIGNhbiBiZSBmb3VuZCBpbiBU
RFgNCj4gPiA+ID4gPiArICogR3Vlc3QtSG9zdCBDb21tdW5pY2F0aW9uIEludGVyZmFjZSAoR0hD
SSkgZm9yIEludGVsIFREWCAxLjAsDQo+ID4gPiA+ID4gKyAqIHNlY3Rpb24gdGl0bGVkICJUREcu
VlAuVk1DQUxMPEdldFF1b3RlPiINCj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gK3N0cnVjdCB0
ZHhfcXVvdGVfaGRyIHsNCj4gPiA+ID4gPiArCV9fdTY0IHZlcnNpb247DQo+ID4gPiA+ID4gKwlf
X3U2NCBzdGF0dXM7DQo+ID4gPiA+ID4gKwlfX3UzMiBpbl9sZW47DQo+ID4gPiA+ID4gKwlfX3Uz
MiBvdXRfbGVuOw0KPiA+ID4gPiA+ICsJX191NjQgZGF0YVtdOw0KPiA+ID4gPiA+ICt9Ow0KPiA+
ID4gPiANCj4gPiA+ID4gVGhpcyBzdHJ1Y3R1cmUgaXMgd2VpcmQuICBJdCdzIGEgaGVhZGVyLCBi
dXQgaXQgY29udGFpbnMgdGhlIGR5bmFtaWMtc2l6ZQ0KPiA+ID4gPiBidWZmZXIuICBJZiB5b3Ug
aGF2ZSBfX2RhdGFbXSBpbiB0aGlzIHN0cnVjdHVyZSwgdGhlbiBpdCBpcyBhbHJlYWR5IGEgYnVm
ZmVyIGZvcg0KPiA+ID4gPiB0aGUgZW50aXJlIFF1b3RlLCBubz8gIFRoZW4gc2hvdWxkIHdlIGp1
c3QgY2FsbCBpdCAnc3RydWN0IHRkeF9xdW90ZSc/DQo+ID4gPiA+IA0KPiA+ID4gPiBPciBkbyB5
b3Ugd2FudCB0byByZW1vdmUgX19kYXRhW10/DQo+ID4gPiANCj4gPiA+IEkgY2FuIG5hbWUgaXQg
YXMgc3RydWN0IHRkeF9xdW90ZV9kYXRhDQo+ID4gDQo+ID4gSWYgZ28gd2l0aCByb3V0ZSwgd2h5
IG5vdCBqdXN0ICd0ZHhfcXVvdGUnLCBvciAndGR4X3RkcXVvdGUnPw0KPiA+IA0KPiA+IE9yLCBh
Y3R1YWxseSBJIHRoaW5rICd0ZHhfcXVvdGUnIChvciAndGR4X3RkcXVvdGUnKSBzZWVtcyB0byBi
ZSB0aGUgZm9ybWF0IG9mDQo+ID4gdGhlIF90cnVlXyBRdW90ZSwgc28gcGVyaGFwcyB3ZSB3YW50
ICdzdHJ1Y3QgdGR4X3F1b3RlX3JlcV9idWYnPw0KPiA+IA0KPiANCj4gU2luY2UgdGhpcyBidWZm
ZXIgaXMgdXNlZCBmb3IgYm90aCByZXF1ZXN0L3Jlc3BvbnNlLCB3ZSBjYW4ganVzdCB1c2UNCj4g
c3RydWN0IHRkeF9xdW90ZV9idWYuDQoNCk5vdCBteSBwcmVmZXJlbmNlIGJ1dCB3aWxsIGxlYXZl
IHRvIG90aGVycy4NCg0K
