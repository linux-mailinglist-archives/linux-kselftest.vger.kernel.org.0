Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2D6CB434
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjC1Cig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 22:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1Cie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 22:38:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5519A2;
        Mon, 27 Mar 2023 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679971113; x=1711507113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U39wJe6CbrklBmyQ6TwqjF48Ft00DJJ9gVV04WWICFY=;
  b=mS7l9cdAbh4jYS3QhJ71/6q+YPgqk6Si+DD7w1P5tXzZ0ly+HRkzmy6D
   UdatXvHrTcCl5uojdoUSh2fs0VE1Z0ReRSRnsgPBBDDU+iwXONv+D4mBh
   puKVMP43npVFXn4bSp7cHhgDaoyXj8SxZ8ttsuAr8PY9CVJ7MeGePgcUm
   5+di1HmMMeoQHNA3KUv4CdvMdwP8RFj1Fph/N2Z1tfeKYnz1S2yqOhMSR
   YEcYTEpVa/KWW71o0luQ1CZaPn8m/72jkZSyOhvWzesK8CuoFlakeG0FQ
   CNL9TVuWfcm+H23P+yNne9B7c0iKJp0Fu3Wglkf/s3VqbNQQVKaCqFzTI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337953285"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337953285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794604150"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="794604150"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2023 19:38:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:38:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:38:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:38:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d47Dx4C70bO38VWQW6o2f7jSufTLkVvVgxDQ2SdjfqejVKz0FG4OL33/XPb5bwa6Ia/df7s3U/3VwMIII7ymr1q/HA3za8Faf/f3qHyemJCF7VsD/7cQtCbj9L/5XczC96G5OpEX8ZW5COVXsZBB3otKkESXb/sMQn0JvY7rrUvJZRdUYmdR3sdcmv908QOxuawbOyLAvBg0MSJuSO4esxGpq9VfNzTq2ep8f92LxpmYohSnE2eVmFLz2u+rYeAtIS1pWN759jrQjr3Y54OmZxFgmOyCAEZm69Ik+IiEbYk83fueCNvbI6yCvOLspyzbQDMyeSdHiM/4iz8enxhUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U39wJe6CbrklBmyQ6TwqjF48Ft00DJJ9gVV04WWICFY=;
 b=BGGdDQ66xSnYeLFb7oDwm9G6A4HZlHytqwTuxd/hTAmJu2o0BU5VXDD6yo8lzQWwrgJe8a62Ib64b132d0CE1m7RWGmWmZFGPxyPnHftlRjp3kLQ0Bc9it6bBnwtP1McU5cSO1b01j3VYLRDh8PNSkfYrFTMvTrnQzc+7YLdhDkOWGprgmp5B7+8Foe3cRy1dBBMzJ6Ub8nDRK5j6pjmVT5lraNW93TumnDuB7OLwGEfzPbw9x+T2eLNHR7VO6nBQC9hXZn3KqX8Obtydf9a810o2pcs1Iw97syAPGqnb74MbtlqbqaXda+97CXhEMvQpcR7zDi7uorV8gPwOeeAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 28 Mar
 2023 02:38:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%6]) with mapi id 15.20.6178.038; Tue, 28 Mar 2023
 02:38:19 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Du, Fan" <fan.du@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZX6sop/+L0HR+ikaJZEYejVYN468PfV2A
Date:   Tue, 28 Mar 2023 02:38:19 +0000
Message-ID: <3c88945515eba868056906f4a269e6ffcf49e1ec.camel@intel.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230326062039.341479-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230326062039.341479-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB6706:EE_
x-ms-office365-filtering-correlation-id: ad67afd1-f8bc-48ae-eeb0-08db2f357e20
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPpMU3DowK8ODM1JWCxPM9lQVdnR6j/PUWcVfTPBZB9oMsKwwpNXnyoAJ7cGc66h8NnuQmn3pL6MQlKiRiMD8P4EU99zeZ96t91XHB8SmogJj+6ilN3veLn/XFGqoMvhxLLsWre2sHaAV9kTa7KMPAFYKZi7OoBdgUT0tNJyYGKr5niHXdvcDOGGIiu5VZ8aHaY8NPl1KitmMkyaAgJPIxi/CcV07I/aNbu6opdBnAEynRgULk5nYPT/5pXrDScYDcpa4SPwj6MjPfOoxHkvjejbG+FgjlhGwpkARv+k1QUMKAXLioV8MBoFz6brlOCHomZo9ZtqUOOy3NTQ8NpEgTo2GPDWEdsCr9ex94CltST1jFYP1JJIEheQ85aztfteTbj9UUWsths6g9x2X104Aw1Hhk9qUEtbVFFrxo237+8d6OIPyhW+HsRrIQrHBvlcZgd1KArPZiSMvYz90AvGEap749I4eV3TfTLPdxfdiHaAbsZQKRF7M6j93x3wK8xG4AgRZrGmSdtWYB/Z4ImxIZt+b9i0+r5oVqyn+z5sMEKBy8apuEGcL2E75SUTA1kRs+6ISyqoJC8Xw+a+5aTBRhoXdwFamDoorNgFzXsjOmqz1zIrMIWKk2i7ImUZddp3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(83380400001)(6486002)(36756003)(8676002)(4326008)(6512007)(6506007)(2616005)(186003)(478600001)(66556008)(86362001)(110136005)(26005)(71200400001)(64756008)(66476007)(54906003)(66946007)(8936002)(66446008)(38070700005)(316002)(7416002)(122000001)(41300700001)(38100700002)(76116006)(82960400001)(2906002)(5660300002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUhHYmhTbmdjMTZ1U1NHSzJtTFNacU1DUWJyMCtzL3FZNXFZWllmYjRLZkQ4?=
 =?utf-8?B?TkZzc2ZqRzRvR2FEc290WitrZFl2SmYzOTVlTXhaRUNvRXZXT1BINkhPZ3E4?=
 =?utf-8?B?SzRDRFJYUm9zeU02WVF6N3BMUEV2ckJ6RGk4RGtBSDc4WXNKenlYWXY3SmJB?=
 =?utf-8?B?NDZuVXRYQU93dXhicGdjY0JRa1JQUnFxcVlIcE5xNFFVci9VV0FIbTZLTCtQ?=
 =?utf-8?B?bXUzWng2bzRvalN6ZWZ4OW9odmU4czRMdTcwZm1nSWx2d3o4MFllWVkxMXNp?=
 =?utf-8?B?SDhKYXBneVpNV1duZFRTN2JZNy9ZT2Z0SjZiNHZrSGFCdFY4Nmt2UmtvUjZk?=
 =?utf-8?B?QkxUTzhnRDNGS2xkTjYvRFFaSnI2eWQzRThJZGNsdFF3Ymo5Uy9rT09Eb2Ri?=
 =?utf-8?B?eGM4aDZpTDZmTUcwazIwd0N1V0kzK0pPak1pWmdLcDRLazB1NCsxS3o1Zk9P?=
 =?utf-8?B?OFM1bklOUitBaWNobHpobW53b3A0Z2trSVNBNExWT3Z3MlR3cWJ4M09MNG9R?=
 =?utf-8?B?dVJXeFQ3S0RJd2t0Tk4wYm9RUXY2QjJkcDl6dGJXTVRXbm96QzVFNk9HbWV4?=
 =?utf-8?B?dmtTMnoxc20rNnhqMjVFblZYZHVBZVFPb2ZMeEg4UG83R29LdWlXRWpqanlX?=
 =?utf-8?B?MFcxTWJLV0xpcmJCTUM3b3M3QWwzM1NzTm9YUzlET09Nb3dMWnpLcTNyUHRS?=
 =?utf-8?B?Yzh3WDNiR0szTE9BaS8ra1cxdjQ0aGd4b0o4eGg2ZGpDbjU3Ym9DaDVVSGRM?=
 =?utf-8?B?amVaQ0RaMXRyWjRzNVNzbUJQRS9vUTh3SHAxNHJLNlBOMHlkSjVMVi9mMjY2?=
 =?utf-8?B?TkRSaHRDV1FidmMwMlEvVGJtZ0lCaFI1TFJCT1FMYy9GdlUzcXlPNXE4WDdL?=
 =?utf-8?B?U1ZMNERvZFQ3ZG9DOTZEdGQzNWYwdkRZSHBqTHdBcXFaaUlRWSt3MFJqUmlJ?=
 =?utf-8?B?dzBrZm9weC8zZjBseGVYcEovTUdHdnRmVVFKTFlKMHNqc1NQenpaREpRcldP?=
 =?utf-8?B?Z3NUWEFiR290a091N08zaWdiTzNQMElVZ3pTVGowNkp2dzZVMWxWNXJhRG5R?=
 =?utf-8?B?OW1seXQ0TTZUL2FVamlNWXloMHJuNjZpeUZZUzRCWSttcFRsb0xkL2g5QXZF?=
 =?utf-8?B?QXhMZ2c0TEg1TFB6VlRJczJINU41V1FJaHozcFFqdU9oTXFoU2VGQk9OMXMy?=
 =?utf-8?B?SVpqZ1ZHZ3pwelByd3k0OEJtLyt6U1lCRFJZcHNIUWxaYzA1dG9sWGlBVFhw?=
 =?utf-8?B?c2xHdVROTko1ZmthbXpMMVB0dVVyOVo1Q3VtekVGS3pzcHhmVGxFY25kVU1a?=
 =?utf-8?B?WDgrbFlDY3lDcm5QZG44TGo3MVpoU2xtb29pN0JMeU1uU2ZNZ1FHcENVZ2RU?=
 =?utf-8?B?Y3VzYld2RXpVa3JvWWxFU1J3ajA0Yi9TTkYxdTFZZjM2eENRSTVIMm5JM2tN?=
 =?utf-8?B?cVpqTFp4eU9HdnE1VG1vN29vaE44Y0lPaCtKeHZVRTFnT05UQUhydzR3NlVH?=
 =?utf-8?B?U0FWSVFuWHY4UU9MTi9ZVzZhY2krM3RHYnVZTlArNkNCaDllL3QvQVdGSFRk?=
 =?utf-8?B?VGdDNkpjV0JtbnV3bDVCeW0xQ09MTm9HR1lVMTMweXR2bkhNS3dWS3dIMnZK?=
 =?utf-8?B?a0lRT3d5MzhMdDVkMzlkb3lSVjRRKzR3b3BjRDhkMlJiZHlxQU1ZVjZRRWx2?=
 =?utf-8?B?K2lvOFR6WEttWXdNNmt1UmtMRmtjakRzVU9PNVJGSUNnQW8rRU12RnFiZ1Rj?=
 =?utf-8?B?YVlKRzE1MUZHWkVkZ1JtWTlPcEVPSm5BTUFUakZxRW9DaHc3YmMyV09Ud092?=
 =?utf-8?B?ZmEvVzZCWnEyNUpMOElJK2RyME5XZ2VCbGtiMnJMOTNFbU4vOStkWjk1VnZL?=
 =?utf-8?B?d2dpVHBjUDZmRHkzNkdndFovYXRGYjF5bFhseVQwQkYrQmFFaU9UZW55NkJp?=
 =?utf-8?B?c0RZL1FpcUU0V2ZTN3ZpTzBWNEJaYjRLSmZjR2ZvUCt2VjJDOFVGL3hLRW00?=
 =?utf-8?B?VzVQRTFtU0ljbUZwQWNzNGZOTGdOSGZsT2U3NlhIdkZFOUpQTHJLSzRPSUtE?=
 =?utf-8?B?TzMyM3RscXdYVlNYVENUKy9VN1RTY2V2cDRDamN4ZU5LSTM1M1RWTzZydElT?=
 =?utf-8?Q?7csB1IlUvqyvDebql5I/vqvFI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31C817990550E44A18FBD27271248CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad67afd1-f8bc-48ae-eeb0-08db2f357e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:38:19.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmisCqjF1zA+B2V7ttvbpZNp0d9/NDIB1oD1X9/aL0dtW1K02fbsW5EAr+jzhILv/rle8DzJY3sa48wfc/A2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gU2F0LCAyMDIzLTAzLTI1IGF0IDIzOjIwIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gSG9zdC1ndWVzdCBldmVudCBub3RpZmljYXRpb24gdmlhIGNvbmZpZ3Vy
ZWQgaW50ZXJydXB0IHZlY3RvciBpcyB1c2VmdWwNCj4gaW4gY2FzZXMgd2hlcmUgYSBndWVzdCBt
YWtlcyBhbiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQgbmVlZHMgYQ0KPiBjYWxsYmFjayBmcm9t
IHRoZSBob3N0IHRvIGluZGljYXRlIHRoZSBjb21wbGV0aW9uIG9yIHRvIGxldCB0aGUgaG9zdA0K
PiBub3RpZnkgdGhlIGd1ZXN0IGFib3V0IGV2ZW50cyBsaWtlIGRldmljZSByZW1vdmFsLiBPbmUg
dXNhZ2UgZXhhbXBsZSBpcywNCj4gY2FsbGJhY2sgcmVxdWlyZW1lbnQgb2YgR2V0UXVvdGUgYXN5
bmNocm9ub3VzIGh5cGVyY2FsbC4NCj4gDQo+IEluIFREWCBndWVzdCwgU2V0dXBFdmVudE5vdGlm
eUludGVycnVwdCBoeXBlcmNhbGwgY2FuIGJlIHVzZWQgYnkgdGhlDQo+IGd1ZXN0IHRvIHNwZWNp
Znkgd2hpY2ggaW50ZXJydXB0IHZlY3RvciB0byB1c2UgYXMgYW4gZXZlbnQtbm90aWZ5DQo+IHZl
Y3RvciB0byB0aGUgVk1NLsKgDQo+IA0KDQoidG8gdGhlIFZNTSIgLT4gImZyb20gdGhlIFZNTSI/
DQoNCj4gRGV0YWlscyBhYm91dCB0aGUgU2V0dXBFdmVudE5vdGlmeUludGVycnVwdA0KPiBoeXBl
cmNhbGwgY2FuIGJlIGZvdW5kIGluIFREWCBHdWVzdC1Ib3N0IENvbW11bmljYXRpb24gSW50ZXJm
YWNlDQo+IChHSENJKSBTcGVjaWZpY2F0aW9uLCBzZWMgMy41ICJWUC5WTUNBTEw8U2V0dXBFdmVu
dE5vdGlmeUludGVycnVwdD4iLg0KDQpJdCBzZWVtcyB3ZSBzaG91bGRuJ3QgbWVudGlvbiB0aGUg
ZXhhY3Qgc2VjdGlvbiBudW1iZXIuDQoNCj4gDQo+IEFzIHBlciBkZXNpZ24sIFZNTSB3aWxsIHBv
c3QgdGhlIGV2ZW50IGNvbXBsZXRpb24gSVJRIHVzaW5nIHRoZSBzYW1lDQo+IENQVSBpbiB3aGlj
aCBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IGh5cGVyY2FsbCByZXF1ZXN0IGlzIHJlY2VpdmVk
Lg0KDQoiaW4gd2hpY2giIC0+ICJvbiB3aGljaCINCg0KPiBTbyBhbGxvY2F0ZSBhbiBJUlEgdmVj
dG9yIGZyb20gIng4Nl92ZWN0b3JfZG9tYWluIiwgYW5kIHNldCB0aGUgQ1BVDQo+IGFmZmluaXR5
IG9mIHRoZSBJUlEgdmVjdG9yIHRvIHRoZSBjdXJyZW50IENQVS4NCg0KSU1ITyAiY3VycmVudCBD
UFUiIGlzIGEgbGl0dGxlIGJpdCB2YWd1ZS4gIFBlcmhhcHMganVzdCAidG8gdGhlIENQVSBvbiB3
aGljaA0KU2V0dXBFdmVudE5vdGlmeUludGVycnVwdCBoeXBlcmNhbGwgaXMgbWFkZSIuDQoNCkFs
c28sIHBlcmhhcHMgaXQncyBiZXR0ZXIgdG8gbWVudGlvbiB0byB1c2UgSVJRRl9OT0JBTEFOQ0lO
RyB0byBwcmV2ZW50IHRoZSBJUlENCmZyb20gYmVpbmcgbWlncmF0ZWQgdG8gYW5vdGhlciBjcHUu
DQoNCj4gDQo+IEFkZCB0ZHhfcmVnaXN0ZXJfZXZlbnRfaXJxX2NiKCkvdGR4X3VucmVnaXN0ZXJf
ZXZlbnRfaXJxX2NiKCkNCj4gaW50ZXJmYWNlcyB0byBhbGxvdyBkcml2ZXJzIHJlZ2lzdGVyL3Vu
cmVnaXN0ZXIgZXZlbnQgbm9maWNpYXRpb24NCj4gaGFuZGxlcnMuDQo+IA0KPiBSZXZpZXdlZC1i
eTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5kaSBL
bGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogTWlrYSBXZXN0ZXJiZXJn
IDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiBBY2tlZC1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBBY2tlZC1ieTog
V2FuZGVyIExhaXJzb24gQ29zdGEgPHdhbmRlckByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlA
bGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2NvY28vdGR4L3RkeC5jICAgIHwg
MTYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3RkeC5oIHwgICA2ICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE2OSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMgYi9hcmNo
L3g4Ni9jb2NvL3RkeC90ZHguYw0KPiBpbmRleCAwNTUzMDBlMDhmYjMuLmQwMzk4NTk1MmQ0NSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYv
Y29jby90ZHgvdGR4LmMNCj4gQEAgLTcsMTIgKzcsMTggQEANCj4gICNpbmNsdWRlIDxsaW51eC9j
cHVmZWF0dXJlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvaW8uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC91YWNjZXNzLmg+DQoNCkRvIHlvdSBuZWVkIGFib3ZlIHR3byBoZWFkZXJzPw0KDQpBbHNv
LCBwZXJoYXBzIHlvdSBzaG91bGQgZXhwbGljaXRseSBpbmNsdWRlIDwuLi4vbGlzdC5oPiBhbmQg
PC4uLi9zcGlubG9jay5oPi4NCg0KDQo+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbnVtYS5oPg0KPiAg
I2luY2x1ZGUgPGFzbS9jb2NvLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3RkeC5oPg0KPiAgI2luY2x1
ZGUgPGFzbS92bXguaD4NCj4gICNpbmNsdWRlIDxhc20vaW5zbi5oPg0KPiAgI2luY2x1ZGUgPGFz
bS9pbnNuLWV2YWwuaD4NCj4gICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPg0KPiArI2luY2x1ZGUg
PGFzbS9pcnFkb21haW4uaD4NCj4gIA0KPiAgLyogVERYIG1vZHVsZSBDYWxsIExlYWYgSURzICov
DQo+ICAjZGVmaW5lIFREWF9HRVRfSU5GTwkJCTENCj4gQEAgLTI3LDYgKzMzLDcgQEANCj4gIC8q
IFREWCBoeXBlcmNhbGwgTGVhZiBJRHMgKi8NCj4gICNkZWZpbmUgVERWTUNBTExfTUFQX0dQQQkJ
MHgxMDAwMQ0KPiAgI2RlZmluZSBURFZNQ0FMTF9SRVBPUlRfRkFUQUxfRVJST1IJMHgxMDAwMw0K
PiArI2RlZmluZSBURFZNQ0FMTF9TRVRVUF9OT1RJRllfSU5UUgkweDEwMDA0DQo+ICANCj4gIC8q
IE1NSU8gZGlyZWN0aW9uICovDQo+ICAjZGVmaW5lIEVQVF9SRUFECTANCj4gQEAgLTUxLDYgKzU4
LDE2IEBADQo+ICANCj4gICNkZWZpbmUgVERSRVBPUlRfU1VCVFlQRV8wCTANCj4gIA0KPiArc3Ry
dWN0IGV2ZW50X2lycV9lbnRyeSB7DQo+ICsJdGR4X2V2ZW50X2lycV9jYl90IGhhbmRsZXI7DQo+
ICsJdm9pZCAqZGF0YTsNCj4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGhlYWQ7DQo+ICt9Ow0KPiArDQo+
ICtzdGF0aWMgaW50IHRkeF9ldmVudF9pcnE7DQoNCg0KX19yb19hZnRlcl9pbml0Pw0KDQo+ICtz
dGF0aWMgTElTVF9IRUFEKGV2ZW50X2lycV9jYl9saXN0KTsNCj4gK3N0YXRpYyBERUZJTkVfU1BJ
TkxPQ0soZXZlbnRfaXJxX2NiX2xvY2spOw0KPiArDQo+ICAvKg0KPiAgICogV3JhcHBlciBmb3Ig
c3RhbmRhcmQgdXNlIG9mIF9fdGR4X2h5cGVyY2FsbCB3aXRoIG5vIG91dHB1dCBhc2lkZSBmcm9t
DQo+ICAgKiByZXR1cm4gY29kZS4NCj4gQEAgLTg3MywzICs4OTAsMTQ5IEBAIHZvaWQgX19pbml0
IHRkeF9lYXJseV9pbml0KHZvaWQpDQo+ICANCj4gIAlwcl9pbmZvKCJHdWVzdCBkZXRlY3RlZFxu
Iik7DQo+ICB9DQo+ICsNCj4gK3N0YXRpYyBpcnFyZXR1cm5fdCB0ZHhfZXZlbnRfaXJxX2hhbmRs
ZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiArew0KPiArCXN0cnVjdCBldmVudF9pcnFfZW50
cnkgKmVudHJ5Ow0KPiArDQo+ICsJc3Bpbl9sb2NrKCZldmVudF9pcnFfY2JfbG9jayk7DQo+ICsJ
bGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJmV2ZW50X2lycV9jYl9saXN0LCBoZWFkKSB7DQo+
ICsJCWlmIChlbnRyeS0+aGFuZGxlcikNCj4gKwkJCWVudHJ5LT5oYW5kbGVyKGVudHJ5LT5kYXRh
KTsNCj4gKwl9DQo+ICsJc3Bpbl91bmxvY2soJmV2ZW50X2lycV9jYl9sb2NrKTsNCj4gKw0KPiAr
CXJldHVybiBJUlFfSEFORExFRDsNCj4gK30NCj4gKw0KPiArLyogUmVzZXJ2ZSBhbiBJUlEgZnJv
bSB4ODZfdmVjdG9yX2RvbWFpbiBmb3IgVEQgZXZlbnQgbm90aWZpY2F0aW9uICovDQo+ICtzdGF0
aWMgaW50IF9faW5pdCB0ZHhfZXZlbnRfaXJxX2luaXQodm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3Qg
aXJxX2FsbG9jX2luZm8gaW5mbzsNCj4gKwljcHVtYXNrX3Qgc2F2ZWRfY3B1bWFzazsNCj4gKwlz
dHJ1Y3QgaXJxX2NmZyAqY2ZnOw0KPiArCWludCBjcHUsIGlycTsNCj4gKw0KPiArCWlmICghY3B1
X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KPiArCQlyZXR1cm4gMDsN
Cj4gKw0KPiArCWluaXRfaXJxX2FsbG9jX2luZm8oJmluZm8sIE5VTEwpOw0KPiArDQo+ICsJLyoN
Cj4gKwkgKiBFdmVudCBub3RpZmljYXRpb24gdmVjdG9yIHdpbGwgYmUgZGVsaXZlcmVkIHRvIHRo
ZSBDUFUNCj4gKwkgKiBpbiB3aGljaCBURFZNQ0FMTF9TRVRVUF9OT1RJRllfSU5UUiBoeXBlcmNh
bGwgaXMgcmVxdWVzdGVkLg0KPiArCSAqIFNvIHNldCB0aGUgSVJRIGFmZmluaXR5IHRvIHRoZSBj
dXJyZW50IENQVS4NCj4gKwkgKi8NCj4gKwljcHUgPSBnZXRfY3B1KCk7DQo+ICsJY3B1bWFza19j
b3B5KCZzYXZlZF9jcHVtYXNrLCBjdXJyZW50LT5jcHVzX3B0cik7DQo+ICsJaW5mby5tYXNrID0g
Y3B1bWFza19vZihjcHUpOw0KPiArCXB1dF9jcHUoKTsNCg0KVGhlICdzYXZlZF9jcHVtYXNrJyBy
ZWxhdGVkIGNvZGUgaXMgdWdseS4gIElmIHlvdSBtb3ZlIHB1dF9jcHUoKSB0byB0aGUgZW5kIG9m
DQp0aGlzIGZ1bmN0aW9uLCBJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlIGFsbCByZWxhdGVkIGNvZGU6
DQoNCgljcHUgPSBnZXRfY3B1KCk7DQoNCgkvKg0KCSAqIFNldCBAaW5mby0+bWFzayB0byBsb2Nh
bCBjcHUgdG8gbWFrZSBzdXJlIGEgdmFsaWQgdmVjdG9yIGlzDQoJICogcHJlLWFsbG9jYXRlZCB3
aGVuIFREWCBldmVudCBub3RpZmljYXRpb24gSVJRIGlzIGFsbG9jYXRlZA0KCSAqIGZyb20geDg2
X3ZlY3Rvcl9kb21haW4uDQoJICovDQoJaW5pdF9pcnFfYWxsb2NfaW5mbygmaW5mbywgY3B1bWFz
a19vZihjcHUpKTsNCg0KCS8vIHJlc3Qgc3RhZmY6IHJlcXVlc3RfaXJxKCksIGh5cGVyY2FsbCAu
Li4NCg0KCXB1dF9jcHUoKTsNCgkNCj4gKw0KPiArCWlycSA9IGlycV9kb21haW5fYWxsb2NfaXJx
cyh4ODZfdmVjdG9yX2RvbWFpbiwgMSwgTlVNQV9OT19OT0RFLCAmaW5mbyk7DQoNClNob3VsZCB5
b3UgdXNlIGNwdV90b19ub2RlKGNwdSkgaW5zdGVhZCBvZiBOVU1BX05PX05PREU/DQoNCj4gKwlp
ZiAoaXJxIDw9IDApIHsNCj4gKwkJcHJfZXJyKCJFdmVudCBub3RpZmljYXRpb24gSVJRIGFsbG9j
YXRpb24gZmFpbGVkICVkXG4iLCBpcnEpOw0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKwl9DQo+ICsN
Cj4gKwlpcnFfc2V0X2hhbmRsZXIoaXJxLCBoYW5kbGVfZWRnZV9pcnEpOw0KPiArDQo+ICsJY2Zn
ID0gaXJxX2NmZyhpcnEpOw0KPiArCWlmICghY2ZnKSB7DQo+ICsJCXByX2VycigiRXZlbnQgbm90
aWZpY2F0aW9uIElSUSBjb25maWcgbm90IGZvdW5kXG4iKTsNCj4gKwkJZ290byBlcnJfZnJlZV9p
cnFzOw0KPiArCX0NCg0KWW91IGFyZSBkZXBlbmRpbmcgb24gaXJxX2RvbWFpbl9hbGxvY19pcnFz
KCkgdG8gaGF2ZSBhbHJlYWR5IGFsbG9jYXRlZCBhIHZlY3Rvcg0Kb24gdGhlIGxvY2FsIGNwdS4g
IFRoZW4gaWYgIWNmZywgeW91ciBjb2RlIG9mIGNhbGxpbmcgaXJxX2RvbWFpbl9hbGxvY19pcnFz
KCkgdG8NCmFsbG9jYXRlIHZlY3RvciBpcyBicm9rZW4uDQoNClNvLCBwZXJoYXBzIHlvdSBzaG91
bGQganVzdCBXQVJOKCkgaWYgdmVjdG9yIGhhc24ndCBiZWVuIGFsbG9jYXRlZCB0byBjYXRjaCBi
dWcuDQoNCglXQVJOKCEoaXJxX2NmZyhpcnEpLT52ZWN0b3IpKTsNCg0KDQo+ICsNCj4gKwlpZiAo
cmVxdWVzdF9pcnEoaXJxLCB0ZHhfZXZlbnRfaXJxX2hhbmRsZXIsIElSUUZfTk9CQUxBTkNJTkcs
DQoNCkl0J3MgYmV0dGVyIHRvIGFkZCBhIGNvbW1lbnQgdG8gZXhwbGFpbiB3aHkgdXNpbmcgSVJR
Rl9OT0JBTEFOQ0lORy4NCg0KPiArCQkJInRkeF9ldmVudF9pcnEiLCBOVUxMKSkgew0KPiArCQlw
cl9lcnIoIkV2ZW50IG5vdGlmaWNhdGlvbiBJUlEgcmVxdWVzdCBmYWlsZWRcbiIpOw0KPiArCQln
b3RvIGVycl9mcmVlX2lycXM7DQo+ICsJfQ0KPiArDQo+ICsJc2V0X2NwdXNfYWxsb3dlZF9wdHIo
Y3VycmVudCwgY3B1bWFza19vZihjcHUpKTsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVnaXN0ZXIg
Y2FsbGJhY2sgdmVjdG9yIGFkZHJlc3Mgd2l0aCBWTU0uIE1vcmUgZGV0YWlscw0KPiArCSAqIGFi
b3V0IHRoZSBBQkkgY2FuIGJlIGZvdW5kIGluIFREWCBHdWVzdC1Ib3N0LUNvbW11bmljYXRpb24N
Cj4gKwkgKiBJbnRlcmZhY2UgKEdIQ0kpLCBzZWMgdGl0bGVkDQo+ICsJICogIlRERy5WUC5WTUNB
TEw8U2V0dXBFdmVudE5vdGlmeUludGVycnVwdD4iLg0KPiArCSAqLw0KPiArCWlmIChfdGR4X2h5
cGVyY2FsbChURFZNQ0FMTF9TRVRVUF9OT1RJRllfSU5UUiwgY2ZnLT52ZWN0b3IsIDAsIDAsIDAp
KSB7DQo+ICsJCXByX2VycigiRXZlbnQgbm90aWZpY2F0aW9uIGh5cGVyY2FsbCBmYWlsZWRcbiIp
Ow0KPiArCQlnb3RvIGVycl9yZXN0b3JlX2NwdXM7DQo+ICsJfQ0KPiArDQo+ICsJc2V0X2NwdXNf
YWxsb3dlZF9wdHIoY3VycmVudCwgJnNhdmVkX2NwdW1hc2spOw0KPiArDQo+ICsJdGR4X2V2ZW50
X2lycSA9IGlycTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArDQo+ICtlcnJfcmVzdG9yZV9jcHVz
Og0KPiArCXNldF9jcHVzX2FsbG93ZWRfcHRyKGN1cnJlbnQsICZzYXZlZF9jcHVtYXNrKTsNCj4g
KwlmcmVlX2lycShpcnEsIE5VTEwpOw0KPiArZXJyX2ZyZWVfaXJxczoNCj4gKwlpcnFfZG9tYWlu
X2ZyZWVfaXJxcyhpcnEsIDEpOw0KPiArDQo+ICsJcmV0dXJuIC1FSU87DQo+ICt9DQo+ICthcmNo
X2luaXRjYWxsKHRkeF9ldmVudF9pcnFfaW5pdCkNCj4gKw0KDQo=
