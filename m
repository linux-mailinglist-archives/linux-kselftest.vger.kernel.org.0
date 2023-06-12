Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52E72C4DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjFLMtZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjFLMtY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:49:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF4E69;
        Mon, 12 Jun 2023 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686574162; x=1718110162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WyaMZ95mKStGhDk3V4snEG/Bvw6l1dOxldXvkGV5r0w=;
  b=JkoUujsYFX0CLuUl32PaGBxjiqjUVn4w5C3vjZb6cwHSnB0wnyXWduCo
   K13k0jt1OJ6ZKJOnBDBbjhUF8+2nfb1tTTOXTbb3+iyE22hWPq2EWfyfi
   /TYB/YXxAOinEeXkR3k/R1Jcs4cg28moozMvFMpT8cC6DFsr1dLfFOL+e
   +z0ytBHQazfBhwef99p89Y9dZXfGbz15WoXHKe6W0uCgwA3rPwMhcWvd4
   8wzOAP9wfsm4jzWSsldOlmqB26S6P7J/8Vt8EuJ1ixfignG9mWO2bSZIb
   Zd8CgJusJx+xMZx6uRztX1fwqmpqNySiUM3aB74xIVwQdoYEe4wU20ejK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358022002"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358022002"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 05:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="711187240"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="711187240"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2023 05:49:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 05:49:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 05:49:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 05:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzlG7ZWvnpi5LJQaiwEGrHSKfzagsX8HfcVudsk/yiPRSNb7QBFjCxRxTIjNNgYEz5r7vPt3FRgMYJXV+m0SSko/ii0ejAGrZd7HFi7RyR0iuYjl4YGPMq96MR2zuWM5Pp4RDjjYBSahHgYwG2ClsNaw/adzF4Niai902/JqBoie9i00DUVaAaEqhVYLz/xb8AuuMRq4bg48HI9V/tTgPohXS0ujbOzCMK7X6FPUGdbXTIPYClJqOR1D38VucrHxownQDsvdcPdNiDyGXi91DPBhMRBBnHZ2iLmmoJF1A+qM36h2bAJkeUhrqj2US+PSBUeKk9B8ngRs6zhkWy6wJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyaMZ95mKStGhDk3V4snEG/Bvw6l1dOxldXvkGV5r0w=;
 b=j29PjdW6j2Gq92CChcFDaecJCbsuFpByJWOQBzOHQVl9fzLPtxkvi5nq0jIooPDjotib6KVWsYTgg1Jb6tJMTiy9ehJ15e0ds1rffhg35Mxu6F60OjRZrdghPIKy2eAIG1dHQauQiXWglZNwCKkac4qrvlw23fVcbjJhr7Tm53/Qwj2bUEWi1tBr6uMeNW/P5NdH6sXeqGMBsb8XDuWHmn9UxgsPF++XCVyu5h/XI9iTEhZj2yHqQHeJvFOQZ0AWZt4cE9C6h5VBEth2bgnFAKua8kUiuReI3U1aG9WLlLHh/lYI+t3jHbugsnhZJNembkpIthUsuIXmXAHnNYVETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 12:49:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 12:49:19 +0000
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
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: Re: [PATCH v3 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v3 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZhjUeN1r3OXi4mUiNWNBRLpdS2a+HTC0A
Date:   Mon, 12 Jun 2023 12:49:19 +0000
Message-ID: <60bf8ff53a226ad386cde930e6d117be7b565002.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <83a832b156f6e3bf906fee657b0147f042481a36.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <83a832b156f6e3bf906fee657b0147f042481a36.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: caec5af4-b471-42dc-3b46-08db6b437040
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZF00NbCW1GkNKP0azIVbc1RKKzFFFCKymWdJex4fyijv19vBeWcCuYgoA8FZLkB+xdPnUmVp/KG/UBjK9/KCXjcMYDVKDKTrGZ0TzzaNqeOvuFA5EXJ+385t3Nh5oZjIpmWExFd9Xjm39esW//W0Yp4id0j57fbNkUnEMLzLO0B6/XK64xVjkmuxSWR1H61211P1KqAWDvMzauWbgXw3/uKF4YWD7W70AL/nL6xpmsP7A+dzgvVL5rECkx33UESveL0fmu+KNAflSAUkCEIClnsFeWn3iZh58rVbNf7JOdivlk85RclbfBroQ4pPeoAaha2dRWJngptMoygs61zquzedek3GXCNLDjcKeANGMPkCIchKAVrVrbbsqc/oMDwT1MWpERU+iWTqHa9njTBe+JpCfQu/VjMzuJpLofYzwGXNr0lVZosvKnMu1CR75l/KyZ0qZvEJpKhrXdH2h59WFjYtp5eK4BHRI2d2zUgPRPMy9OlpSIfrZApYDKiKuRR7kaSOgHH/rdTuRlt74sh6J6bH0FtQ7bWq8AcGDjzr5kxUAtdccuGJ29Q1rJoJr/TSjNUl7hEVOGQ9fE+c34mH2jIzV919Zui2If+Cl8MZe35S315oIN0Q+5RpoGkyVgjH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(4326008)(91956017)(64756008)(66476007)(66556008)(316002)(7416002)(66446008)(41300700001)(76116006)(186003)(110136005)(2906002)(54906003)(478600001)(66946007)(8676002)(8936002)(5660300002)(71200400001)(6486002)(6512007)(6506007)(122000001)(26005)(83380400001)(36756003)(38070700005)(86362001)(82960400001)(2616005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTRKK291UXZySnpiUmpkUmJzOU92SlRVNzVwSVR2Zmt0NUY2bXUyakVlMWpl?=
 =?utf-8?B?YjU3MnMzMkFzRWZBQ2pzNDFkWm5BY1FPSWprUWRqMExoY2hTc2kvZFNzREY2?=
 =?utf-8?B?cUhuNUZnamw0ek9VQWZLVTlQR0ZMVGJZZG92c1ZuQmhpS2F2NUxlSE5TVGlv?=
 =?utf-8?B?Tys1Q3B3UHJxUCtzMVlsV3BEMnRlS3Q2UUhQT3dvenhTdnNpSVhZNG45MEpC?=
 =?utf-8?B?UGdaTXZqSEdwU2dWbmhMWS96RDM2QzRUaGtKZlVIM1pndDcweWR1MUxiTW5y?=
 =?utf-8?B?eFk5Uitrc0Zwek5RSUZQS1dDdWZDZjdSWjlXUTRSTllrLzVEY0JIbGhaaGll?=
 =?utf-8?B?Qk0xamczSWJvOE1mQ1JwNzRsYzF5Wnl4bW0wdFhWS3NOdnVCVElLbTNJdG1a?=
 =?utf-8?B?RUtBYWVoLzdaVmxBK3piVlJRZWdOY2pQVzVPemJ0SHJuQ3hYNTUxWmo4WjJ6?=
 =?utf-8?B?UUlMWnd0Q2xoYlZKR1hSK3lSU3IzSVBoZm0zVDhDa0FxMjl4UUJkUVh6eVdL?=
 =?utf-8?B?UUpFaWVicExFRndMSHBEOWZwaVA3enNZS1hPeTBYYXdkYnNueUJTTHcxbkN3?=
 =?utf-8?B?dmpDbFZLMXdoblFlczJyZHFGWVBUZ2hRTmU3b2dVZkFrR3NXSkI5a2t5cmhu?=
 =?utf-8?B?TkxmR1dVbjlUbDBKVTA1NmZ3TjhDWkR0MEhLc0JVZUxoUENTY00xYzdKUFMx?=
 =?utf-8?B?YVRDdERqYmIvclVwb1I5UUdJRktQY25NcmJxTnpIaU9lbnc4bkh3czJaNDlt?=
 =?utf-8?B?clUyVDhEVm9zcEtuS2JsUGdHZ2lEa1ZSbTNaaFpXNFNMOEJUQjdEM3Q0N2tP?=
 =?utf-8?B?c1FMSXhYT1gxMThSUHNSaDVjUzJiS3pGdmZJMlpZVFgrUkRRanVTczBDN0tx?=
 =?utf-8?B?VDVVUm9BN29iOU5xK1hIL0JrTTVJTGFWQU1EMUg5QUNuRmd5UDlPSVlNR1dY?=
 =?utf-8?B?cHpPZ3FaRFE1Qk45ZlI2RzJzaTNHOWFIeVVIeVhVL0NQRzNTWkw0c2JKY1M3?=
 =?utf-8?B?TFVnZFBqa0lyejExUTg3WnptTldlSnJQWFJ3dkZWcjNtOXg2ZUtQaEl2Z0hI?=
 =?utf-8?B?MVFoNHBqS2dwZVNUck1NOHFiRHI0Z21CUWJrVngwNFhkenZ0YnRsUmlEK2Y2?=
 =?utf-8?B?ZDdwVVlCU0E0OEZQaXlRUHpmamV2Nnh3bmV2K0FUWERabUM1UUNqWGhsdHhQ?=
 =?utf-8?B?RkN2SUNPdjBHTGZrd2RLS21kNnp2U2theXpLSEY2OCtlOVRlalpLZUM5dGJJ?=
 =?utf-8?B?SUhUR1BsTUxsbjAyS0x2eGJVcEVvOWI0ZUpIRXdza2g0TlJCRXhmeCttUlds?=
 =?utf-8?B?dzEvTFd0c3grekRRUUlOK0tDRS9sdjVraHJFM1FXZk0yVWVCYkg1YVFrYlha?=
 =?utf-8?B?cUl2K1gyNGNUWHB2L1JKMU9YN1pKSTlTNU5lUzJlYStzd08zdmdWMEVtSE9P?=
 =?utf-8?B?VGUwa2daUisyRTVTT21vcWc0cU9sR0x3RXQ3Y1hpeHZSRnlBSjZpTG83T2JL?=
 =?utf-8?B?NjZrQURkam0rdkFzWTNHWHpFanM1Uzg2KzlYRm94K0dpakpTSFNscFBzZUx0?=
 =?utf-8?B?M1U2UGdwOVFJZTRhL2dGTlkwdGUrNXVNNElKODFvb0ZPMDB1K2J0YjhLM1pI?=
 =?utf-8?B?MmJEaWZiUkZtUnNSdHZVdGZRVWF2U1ZQcHBkWXltVFZsb0E4MFQrZzBMS000?=
 =?utf-8?B?dmgreENFQlpzbXAwOXpkV1RWYStabkc4ZW1tSnJIU1MxWlJsNWRXaWpVdURB?=
 =?utf-8?B?VGszWmc5MTRaZWJld3pkUWZVcUpleWN3SnhJQno4TXphTGVxOGI0aWIrMm1r?=
 =?utf-8?B?VkdoLzNPa1RRVXB1SE5MaEJoTStMUitvRU54RmlpM3dsN2E2SFpJRE80RkNB?=
 =?utf-8?B?RU5CbjFPYU4zZG81NWFWS1dHTExMdEdYZGVRdHFMZkRUR3J3bGRCYVc3MGNk?=
 =?utf-8?B?clVVeFVxUEFwLzJxTVBxekloZEN1NTNMUGowOFVBQUI4YmlvK1hXY1QwM1Ey?=
 =?utf-8?B?RVJUWmF6SURUckpNQ2hjS3N1Z1JNUXEwNkxLa2FaUUQvWThrYUgxcXdsY1Fl?=
 =?utf-8?B?MmgvcGNLcERKV1h1cHlqMGZVVjB0L2VZMVQxQlpNVlkrNGYyVDU4SW96R1I3?=
 =?utf-8?B?a0trRDlFTko1aWd2eTJkMDJzN3p1ak56MEg3NGlQeFM5WGtGcVR2VTBLckdD?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C0AA444952564798BA94C3CB18ED95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caec5af4-b471-42dc-3b46-08db6b437040
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 12:49:19.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENu0D22Wa7Hl2xF0wQsLwqyjtNrgw/1Cuho7eXdNNjmKaRnbjvQmeFnMrtoGiGVDs3ASxzSqyzg5UOi6ZoUv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gU3VuLCAyMDIzLTA1LTE0IGF0IDAwOjIzIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gSG9zdC1ndWVzdCBldmVudCBub3RpZmljYXRpb24gdmlhIGNvbmZpZ3Vy
ZWQgaW50ZXJydXB0IHZlY3RvciBpcyB1c2VmdWwNCj4gaW4gY2FzZXMgd2hlcmUgYSBndWVzdCBt
YWtlcyBhbiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQgbmVlZHMgYQ0KPiBjYWxsYmFjayBmcm9t
IHRoZSBob3N0IHRvIGluZGljYXRlIHRoZSBjb21wbGV0aW9uIG9yIHRvIGxldCB0aGUgaG9zdA0K
PiBub3RpZnkgdGhlIGd1ZXN0IGFib3V0IGV2ZW50cyBsaWtlIGRldmljZSByZW1vdmFsLiBPbmUg
dXNhZ2UgZXhhbXBsZSBpcywNCj4gY2FsbGJhY2sgcmVxdWlyZW1lbnQgb2YgR2V0UXVvdGUgYXN5
bmNocm9ub3VzIGh5cGVyY2FsbC4NCj4gDQo+IEluIFREWCBndWVzdCwgU2V0dXBFdmVudE5vdGlm
eUludGVycnVwdCBoeXBlcmNhbGwgY2FuIGJlIHVzZWQgYnkgdGhlDQo+IGd1ZXN0IHRvIHNwZWNp
Znkgd2hpY2ggaW50ZXJydXB0IHZlY3RvciB0byB1c2UgYXMgYW4gZXZlbnQtbm90aWZ5DQo+IHZl
Y3RvciBmcm9tIHRoZSBWTU0uIERldGFpbHMgYWJvdXQgdGhlIFNldHVwRXZlbnROb3RpZnlJbnRl
cnJ1cHQNCj4gaHlwZXJjYWxsIGNhbiBiZSBmb3VuZCBpbiBURFggR3Vlc3QtSG9zdCBDb21tdW5p
Y2F0aW9uIEludGVyZmFjZQ0KPiAoR0hDSSkgU3BlY2lmaWNhdGlvbiwgc2VjdGlvbiAiVlAuVk1D
QUxMPFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQ+Ii4NCj4gDQo+IEFzIHBlciBkZXNpZ24sIFZN
TSB3aWxsIHBvc3QgdGhlIGV2ZW50IGNvbXBsZXRpb24gSVJRIHVzaW5nIHRoZSBzYW1lDQo+IENQ
VSBvbiB3aGljaCBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IGh5cGVyY2FsbCByZXF1ZXN0IGlz
IHJlY2VpdmVkLg0KPiBTbyBhbGxvY2F0ZSBhbiBJUlEgdmVjdG9yIGZyb20gIng4Nl92ZWN0b3Jf
ZG9tYWluIiwgYW5kIHNldCB0aGUgQ1BVDQo+IGFmZmluaXR5IG9mIHRoZSBJUlEgdmVjdG9yIHRv
IHRoZSBDUFUgb24gd2hpY2gNCj4gU2V0dXBFdmVudE5vdGlmeUludGVycnVwdCBoeXBlcmNhbGwg
aXMgbWFkZS4NCj4gDQo+IEFkZCB0ZHhfcmVnaXN0ZXJfZXZlbnRfaXJxX2NiKCkvdGR4X3VucmVn
aXN0ZXJfZXZlbnRfaXJxX2NiKCkNCj4gaW50ZXJmYWNlcyB0byBhbGxvdyBkcml2ZXJzIHRvIHJl
Z2lzdGVyL3VucmVnaXN0ZXIgZXZlbnQgbm90aWZpY2F0aW9uDQo+IGhhbmRsZXJzLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1pa2Eg
V2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEVyZGVtIEFrdGFzIDxlcmRlbWFrdGFzQGdvb2dsZS5jb20+DQo+IEFja2VkLWJ5OiBLaXJp
bGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IEFja2Vk
LWJ5OiBXYW5kZXIgTGFpcnNvbiBDb3N0YSA8d2FuZGVyQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVz
d2FteUBsaW51eC5pbnRlbC5jb20+DQo+IA0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVh
bmdAaW50ZWwuY29tPg0K
