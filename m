Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABEE6CB542
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 06:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjC1EDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 00:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1EC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 00:02:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D74D1;
        Mon, 27 Mar 2023 21:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679976177; x=1711512177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G2YLm2x6zxr0LPLY0DnYt2U4tgl9azGANShzvyVZn00=;
  b=WTqosWo19C/Cpg3sT0WawS8GD5v42LgOD3W96FwXSEpWCssufdHXhWBh
   gHuImw82B/8mcfkUuKzls7X8ie3KkeCqmqZQc0+lTsi8NcDawMyqfkKiV
   bLyysT7jcjyB/TlcfwwJhi/Pp8KBb/GsIeU1E1et6WZq26kcaUWy2y0qI
   VgG9R7FdBYeIB6Uy7658VmyMHgzARei4SCJdaWOsedhnsC600Dh1UzeAv
   9OyWvSQ4kNi0xoi1hyWo6vhenGONQAhinJYJPGcrUPJ3tS3sA+kpefwMH
   HJzQUXy44gcPKZD1TWi8HHrXcY1Ik5Vz+QBCMPky56YLQsjVjLWP13BgB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342050311"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="342050311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 21:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686232096"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="686232096"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 21:02:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 21:02:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 21:02:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 21:02:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 21:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBTksvnW8Uoao13kQXWC1JnZyBIlj1qc24XiHc/sw7dy+lO/RMRIQ0HK38frD2Be6uC1u5bSi2mLx4WuiH49OoN8aZcr1oOYJhvRRllH7Tf5nsJLcvvhipiRBsvxciHCh9v2aPNDqQvKWWSADSmI3OOBCuXUpOSBxDyz8G2VBuMS9G3YysknZGzKtAf5s3N7H9e4mUI6WS7hQ0sy4/KCr4P+wwyiRIcwFhcZppzKXOTBbPxDijOyozxdB4YulJ1AqFfG3J2xWGD8eRGLE1fklr/KDxE/yZO61cutirOGmrFsEgcWHcttHuUnbroo4RIesisIAOSH7BBR0imKx1U0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2YLm2x6zxr0LPLY0DnYt2U4tgl9azGANShzvyVZn00=;
 b=MP/SqwuPsSXhMDqr0dtQixn6KadyCJlvpeNUMOvIfM6ITEnmTSHQctXb19dLHaPSGZtmUPYop+8+ylMsIQgGxRrFM+tstZJyx8OZPhZy+n9ev2pFWjLYY9c7UXa+8Nl/K78WWR7E5ygiOD3/1ZUlFLGibfSxkmzLAGhHSxkAnR9qTPghyzwfPDCCO7IqhvjFGBrM1zcioaVIjrYS3xtRc3xsihvI9vKCJ2z03WzZaG/5FkH7TOuUC3CrRKq3SxTs+G055IF5AWwbqx6uFhnakrGwPozr8Mf01mYbMEklOeAqMOQk8ybcB08KA/kKngnwXN7C2aBvxggV/XgSTzn1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 04:02:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%6]) with mapi id 15.20.6178.038; Tue, 28 Mar 2023
 04:02:52 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Du, Fan" <fan.du@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZX6sop/+L0HR+ikaJZEYejVYN468PfV2AgAADagCAABQ0gA==
Date:   Tue, 28 Mar 2023 04:02:52 +0000
Message-ID: <7aeac332d8be1e99d78997638354342dc55dfe8e.camel@intel.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230326062039.341479-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <3c88945515eba868056906f4a269e6ffcf49e1ec.camel@intel.com>
         <c49727dc-1fe8-2214-07c7-e3be269030af@linux.intel.com>
In-Reply-To: <c49727dc-1fe8-2214-07c7-e3be269030af@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7985:EE_
x-ms-office365-filtering-correlation-id: 51048116-4f33-4b4d-f705-08db2f414db2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PSxxz+tGRlB7C8+3c0VN7fJHdjFs3G1jYN6MrQioD6K4IbyXALT63wyNKdMp8ElNpz4ArQUVvpxQ0cKay1DOd/VHIy3cs+X9sJ48AzcKuWZkaY5Jzo/zC68zICqoW9QMpRnOuV2vROajEvSJaMBP0KXhxaYzoC8dd4LW/7xI+6I5srhwJfBVNcxFvXO/Ug/LuhOkNcQXBzFIU62InQxKtBnRiR0++s7q3UMaOphR9Vqpxqo9+hLp+x+mhz1IZYmSOLB1e5XtYLDbuGqVn6ZtJW27tRcM0kLjK052JOmHdUqkn/hBMtP0Si8pzUuhPYfpaBNIjqt77MunHRh0FI4cwvlxpDtve2OSa9yIfecoJOGWx4DZmV/z3uprVc5FcZI09zIKVMqZD/FZtTdgInp+aW6VKgW+D/cRjzq/iC0+pWKHUOT0l1VtYLhlhLn3/d+mR1xH/IHVBV7ix/6VNYmBubB6NECv64N+yfJ78ER0HFNWklBYkfOPyUrXkRx4MKQD1musjF/vC4cMJAfsB3DHjc3GloIUm1AewjA/5qG96VrUdxOXQE4/DRdjaNg5/T2v1o1VEzpUQwV7vByEz2pSLwBE9ofWAxcDq93IJHwnfytaBOompN8TPIMpSpIBwEJ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(76116006)(66476007)(66946007)(4326008)(8676002)(64756008)(66446008)(66556008)(41300700001)(91956017)(186003)(5660300002)(2906002)(83380400001)(7416002)(36756003)(38100700002)(38070700005)(86362001)(122000001)(2616005)(82960400001)(478600001)(54906003)(110136005)(71200400001)(8936002)(6512007)(6506007)(26005)(53546011)(6486002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlVEL3J4UFVWeGYyaTBpMjZjVXI4ajBJYmtKOHU3dFRSeDFFUGFkUDRpaEVT?=
 =?utf-8?B?T2M2UmovQ0RvaS81cEZKTmlDcUNKamNtcEJQUzNTT2UxaEEwejBRVTFPOGRx?=
 =?utf-8?B?T2RLYkluelRpNlRxS2RQNlhJMkxxalFNYXk2ajRVVTRGYnc1RkZkSTBEYzBk?=
 =?utf-8?B?U1JEZ05iTUhibUI3dnRtTFE3bUd2NjBLaTBTQXh1Y2h1OEZpdDJmeVBVR0dY?=
 =?utf-8?B?NDF5bFI0WlhJOHgySE42SFdhR01SOThhY0VOQkx6MDdFYjVYb2EydXd1elNz?=
 =?utf-8?B?dzh0WE5mS2I2QjlBaG9CMUlZMHFjTG9CTUFlbkgrNjMyOE8zcXVpaUdGT3Vl?=
 =?utf-8?B?bFhNVTBjcElPaG5ZZWsraTc3V3lEVnZPNzlNczZESEJyQlU1aFpDNTY0YVI2?=
 =?utf-8?B?QjkwbzVkZmRxN09Bdi84VDdwNXRDbW5rcWw5RW9UcWFhL1ZLSzh3aDAwcTNM?=
 =?utf-8?B?d3Jsb1cvbkNqd3VkLzZGYmlmcHk0d3FMM1JBcVhoOGJpM3ZvRlRIdDF6Z1ZI?=
 =?utf-8?B?bGI2Qm0zZlBNcU1XU00yTEJwclZVd3pFeFZySStvQkVabDhzbHNnSUJwMVhW?=
 =?utf-8?B?KzRzd3o0NlVCY1ZvYi9veWRydGRXcDVZYUlsZllmTk4zaGJ5K3lzMVpxTXpW?=
 =?utf-8?B?MVFMaitpNTVZYkxBRHluSzYvTmJpQTI0anBBamN3cy9HTEVScFl6N0JndGxJ?=
 =?utf-8?B?cW5EWHhaZmxwMHFjUGVOVjR5THpzejZVYUlsaHM4QTVaMVMwNGN0RENZbmdN?=
 =?utf-8?B?djl6VTdkSC9TTDhJc015Ny9jcTlCUHo5d1pQZzFLVERpTnAwUkNpNGtJY2Iz?=
 =?utf-8?B?ODlBejdSczg2ZUp1cHJKeFFDSEZzVWRKM2F2a2RiK1poSEVURGVPWEp2TFd5?=
 =?utf-8?B?TWdTY0lJYXRjN0kxd21mR2lEN2h5MzFFZGNzcnUvNllwTTRNcHBjK0FKQUh6?=
 =?utf-8?B?bm5WUXlBOTVLQTAyUGZoWTRZU2JnNTdFZGdpdGFwNVZXMDcyN1A4RG1aRzhW?=
 =?utf-8?B?VzhGUmRhVFk5WFBGdVFvM3JEczhjT2NiL0pDL0RZUmVueXZsN0FQQTJPU2RG?=
 =?utf-8?B?bHVDcGhIdnZNZDhrVW1LWFBVNjRGaGRpUThXQUR0L0NUWGtEaXpqSDVzN0Zn?=
 =?utf-8?B?U0RhcTloeGhRYkdSU3pZNEk1b0pDNkxhVjZZcDQ1ZTNJUnp4MmEvaCtuQVpP?=
 =?utf-8?B?bWZLUUo3Wll0VDZWQTBPZTNtMFNySjI5cW0vUG1UTmF3azhsbXRGNkdrTm4v?=
 =?utf-8?B?cUY1dVg1RGxBMk9QTEtlekRIdmdOeEpNN1lGZEQ0TlFjZGY2cW11Z3Fna2FZ?=
 =?utf-8?B?a0t0ZXljVnZZbHJxazM2Z3VTZ3NGRnRnUzV5VmpaaE9leUNzT3Jpd0pnZGNq?=
 =?utf-8?B?OXA5RlJ6M0QwY1VRdnBmenU5OEhIaTN6bHlmNzBFdFpvR1Yyc3hJNDFSNXRR?=
 =?utf-8?B?M25TeTJLRm42RUdOdHdQSGdVMXN6MXFXemt5a0M4VzErSzJ1Vm1tbDdZV0JX?=
 =?utf-8?B?Z0JEMWZBajlSZGpBZTU2eEpraHhWemFKNzNKYTVnd0c2aCtpbERIemdna3Z4?=
 =?utf-8?B?KzZuYXRQR1pla3Y3bGhCOHNkcW8ySEhwL0Y3TUNLR2JReW5MOG1uWU9FT0dt?=
 =?utf-8?B?Y0dKTU56ZGVmT0NmUFgvYkxaMEppNmJYdmp6aXU3SWpxL3J1NlhHdm5NWmFw?=
 =?utf-8?B?ZFpDOFNZdThFSkVsQUFlT1NBamVocG8ranEzMG1PQ0wvMzE1Vk42T2kyUTcz?=
 =?utf-8?B?Z0FwS1I5VFBXaHV5RFZPT1pzMXY0cUtmbmhiaCtZMWkxamJ1SGl1U3FFelly?=
 =?utf-8?B?RmVoYzk5dGJlYXk1UkxKd0pGSyt4Q2k5WDZnVDF0UFU0UTlLSXhISGJ0anRX?=
 =?utf-8?B?K0pGNGJOREZldlpmZ1hPR1QzRVg0YnAxNDVGQ0o4U3gzREFVRGlZMEYvZ3R1?=
 =?utf-8?B?dGQzaGJnVmVQMTFFb2hWb1drOHh5YkxMQVFmMXpmYnNSVHZLZWNHT1VCS0tm?=
 =?utf-8?B?NHNRaVlqb0duQVRnS1lWL2pHdWMzVlRIYlcrNzg4Q2tLSjRpUG5TdXF0ZFpk?=
 =?utf-8?B?OFZIRlkwR3U1WUlvVmlZVlpzYXdJSEpacDFjY2FmUmxyaklibkRHOTRFS0Zr?=
 =?utf-8?Q?2n6UwJPCm5oHtqL0KVyBMwKXP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A2396D3FB596447A840118384F73340@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51048116-4f33-4b4d-f705-08db2f414db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 04:02:52.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnZ/S3dGkllFwFtgxomOdn/Sn3k5l1z+xG6ZTVI/fZ9+lJGhxFzVawZnZ26Dsrcc+Jo/K+LIG0cLuTVQ1Auf5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTI3IGF0IDE5OjUwIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gSGkgS2FpLA0KPiANCj4gT24gMy8yNy8yMyA3OjM4IFBNLCBIdWFuZywg
S2FpIHdyb3RlOg0KPiA+ID4gKy8qIFJlc2VydmUgYW4gSVJRIGZyb20geDg2X3ZlY3Rvcl9kb21h
aW4gZm9yIFREIGV2ZW50IG5vdGlmaWNhdGlvbiAqLw0KPiA+ID4gK3N0YXRpYyBpbnQgX19pbml0
IHRkeF9ldmVudF9pcnFfaW5pdCh2b2lkKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGlycV9h
bGxvY19pbmZvIGluZm87DQo+ID4gPiArCWNwdW1hc2tfdCBzYXZlZF9jcHVtYXNrOw0KPiA+ID4g
KwlzdHJ1Y3QgaXJxX2NmZyAqY2ZnOw0KPiA+ID4gKwlpbnQgY3B1LCBpcnE7DQo+ID4gPiArDQo+
ID4gPiArCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0K
PiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCWluaXRfaXJxX2FsbG9jX2luZm8o
JmluZm8sIE5VTEwpOw0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBFdmVudCBub3Rp
ZmljYXRpb24gdmVjdG9yIHdpbGwgYmUgZGVsaXZlcmVkIHRvIHRoZSBDUFUNCj4gPiA+ICsJICog
aW4gd2hpY2ggVERWTUNBTExfU0VUVVBfTk9USUZZX0lOVFIgaHlwZXJjYWxsIGlzIHJlcXVlc3Rl
ZC4NCj4gPiA+ICsJICogU28gc2V0IHRoZSBJUlEgYWZmaW5pdHkgdG8gdGhlIGN1cnJlbnQgQ1BV
Lg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJY3B1ID0gZ2V0X2NwdSgpOw0KPiA+ID4gKwljcHVtYXNr
X2NvcHkoJnNhdmVkX2NwdW1hc2ssIGN1cnJlbnQtPmNwdXNfcHRyKTsNCj4gPiA+ICsJaW5mby5t
YXNrID0gY3B1bWFza19vZihjcHUpOw0KPiA+ID4gKwlwdXRfY3B1KCk7DQo+ID4gVGhlICdzYXZl
ZF9jcHVtYXNrJyByZWxhdGVkIGNvZGUgaXMgdWdseS4gIElmIHlvdSBtb3ZlIHB1dF9jcHUoKSB0
byB0aGUgZW5kIG9mDQo+ID4gdGhpcyBmdW5jdGlvbiwgSSB0aGluayB5b3UgY2FuIHJlbW92ZSBh
bGwgcmVsYXRlZCBjb2RlOg0KPiA+IA0KPiA+IAljcHUgPSBnZXRfY3B1KCk7DQo+ID4gDQo+ID4g
CS8qDQo+ID4gCSAqIFNldCBAaW5mby0+bWFzayB0byBsb2NhbCBjcHUgdG8gbWFrZSBzdXJlIGEg
dmFsaWQgdmVjdG9yIGlzDQo+ID4gCSAqIHByZS1hbGxvY2F0ZWQgd2hlbiBURFggZXZlbnQgbm90
aWZpY2F0aW9uIElSUSBpcyBhbGxvY2F0ZWQNCj4gPiAJICogZnJvbSB4ODZfdmVjdG9yX2RvbWFp
bi4NCj4gPiAJICovDQo+ID4gCWluaXRfaXJxX2FsbG9jX2luZm8oJmluZm8sIGNwdW1hc2tfb2Yo
Y3B1KSk7DQo+ID4gDQo+ID4gCS8vIHJlc3Qgc3RhZmY6IHJlcXVlc3RfaXJxKCksIGh5cGVyY2Fs
bCAuLi4NCj4gPiANCj4gPiAJcHV0X2NwdSgpOw0KPiA+IAkNCj4gDQo+IGluaXRfaXJxX2FsbG9j
X2luZm8oKSBpcyBhIHNsZWVwaW5nIGZ1bmN0aW9uLiBTaW5jZSBnZXRfY3B1KCkgZGlzYWJsZXMN
Cj4gcHJlZW1wdGlvbiwgd2UgY2Fubm90IGNhbGwgc2xlZXBpbmcgZnVuY3Rpb24gYWZ0ZXIgaXQu
IEluaXRpYWxseSwgSQ0KPiBoYXZlIGltcGxlbWVudGVkIGl0IGxpa2UgeW91IGhhdmUgbWVudGlv
bmVkLiBIb3dldmVyLCBJIGRpc2NvdmVyZWQgdGhlDQo+IGZvbGxvd2luZyBlcnJvci4NCg0KT2gg
c29ycnkgSSBmb3Jnb3QgdGhpcy4gIFNvIEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBtaWdyYXRlX2Rp
c2FibGUoKSBpbnN0ZWFkOg0KDQoJbWlncmF0ZV9kaXNhYmxlKCk7DQoNCglpbml0X2lycV9hbGxv
Y19pbmZvKCZpbmZvLCBjcHVtYXNrX29mKHNtcF9wcm9jZXNzb3JfaWQoKSkpOw0KDQoJLi4uDQoN
CgltaWdyYXRlX2VuYWJsZSgpOw0KDQpPciwgc2hvdWxkIHdlIGp1c3QgdXNlIGVhcmx5X2luaXRj
YWxsKCkgc28gdGhhdCBvbmx5IEJTUCBpcyBydW5uaW5nPyAgSU1ITyBpdCdzDQpPSyB0byBhbHdh
eXMgYWxsb2NhdGUgdGhlIHZlY3RvciBmcm9tIEJTUC4NCg0KQW55d2F5LCBlaXRoZXIgd2F5IGlz
IGZpbmUgdG8gbWUuDQoNCj4gDQo+IFsgwqAgwqAyLjQwMDc1NV0gQlVHOiBzbGVlcGluZyBmdW5j
dGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQga2VybmVsL2xvY2tpbmcvbXV0ZXgu
Yzo1ODANCj4gWyDCoCDCoDIuNDA0NjY0XSBpbl9hdG9taWMoKTogMSwgaXJxc19kaXNhYmxlZCgp
OiAwLCBub25fYmxvY2s6IDAsIHBpZDogMSwgbmFtZTogc3dhcHBlci8wDQo+IFsgwqAgwqAyLjQw
ODY3MV0gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDANCj4gWyDCoCDCoDIuNDEyNjUwXSBS
Q1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCj4gWyDCoCDCoDIuNDEyNjY2XSBubyBsb2Nr
cyBoZWxkIGJ5IHN3YXBwZXIvMC8xLg0KPiBbIMKgIMKgMi40MTY2NTBdIFByZWVtcHRpb24gZGlz
YWJsZWQgYXQ6DQo+IFsgwqAgwqAyLjQxNjY1MF0gWzxmZmZmZmZmZjgzYjgwODlmPl0gdGR4X2Fy
Y2hfaW5pdCsweDM4LzB4MTE3DQo+IFsgwqAgwqAyLjQyMDY3MF0gQ1BVOiAwIFBJRDogMSBDb21t
OiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNi4xLjAtcmM0LTAwMTE3LWc2NzJjYTA3M2Q5ZjktZGly
dHkgIzI1MjcNCj4gWyDCoCDCoDIuNDI0NjUwXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJk
IFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyAwLjAuMCAwMi8wNi8yMDE1DQo+IFsgwqAgwqAy
LjQyNDY1MF0gQ2FsbCBUcmFjZToNCj4gWyDCoCDCoDIuNDI0NjUwXSDCoDxUQVNLPg0KPiBbIMKg
IMKgMi40MjQ2NTBdIMKgZHVtcF9zdGFja19sdmwrMHg2YS8weDg2DQo+IFsgwqAgwqAyLjQyNDY1
MF0gwqBfX21pZ2h0X3Jlc2NoZWQuY29sZCsweGY0LzB4MTJmDQo+IFsgwqAgwqAyLjQyNDY1MF0g
wqBfX211dGV4X2xvY2srMHg1MC8weDgxMA0KPiBbIMKgIMKgMi40MjQ2NTBdIMKgPyBsb2NrX2lz
X2hlbGRfdHlwZSsweGQ4LzB4MTMwDQo+IFsgwqAgwqAyLjQyNDY1MF0gwqA/IF9faXJxX2FsbG9j
X2Rlc2NzKzB4Y2YvMHgzMTANCj4gWyDCoCDCoDIuNDI0NjUwXSDCoD8gZmluZF9oZWxkX2xvY2sr
MHgyYi8weDgwDQo+IFsgwqAgwqAyLjQyNDY1MF0gwqA/IF9faXJxX2FsbG9jX2Rlc2NzKzB4Y2Yv
MHgzMTANCj4gWyDCoCDCoDIuNDI0NjUwXSDCoF9faXJxX2FsbG9jX2Rlc2NzKzB4Y2YvMHgzMTAN
Cj4gWyDCoCDCoDIuNDI0NjUwXSDCoGlycV9kb21haW5fYWxsb2NfZGVzY3MucGFydC4wKzB4NDkv
MHhhMA0KPiBbIMKgIMKgMi40MjQ2NTBdIMKgX19pcnFfZG9tYWluX2FsbG9jX2lycXMrMHgyYTAv
MHg0ZjANCj4gWyDCoCDCoDIuNDI0NjUwXSDCoD8gbmV4dF9hcmcrMHgxMjkvMHgxZjANCj4gWyDC
oCDCoDIuNDI0NjUwXSDCoD8gdGR4X2d1ZXN0X2luaXQrMHg1Yi8weDViDQo+IFsgwqAgwqAyLjQy
NDY1MF0gwqB0ZHhfYXJjaF9pbml0KzB4OGUvMHgxMTcNCj4gWyDCoCDCoDIuNDI0NjUwXSDCoGRv
X29uZV9pbml0Y2FsbCsweDEzNy8weDJlYw0KPiBbIMKgIMKgMi40MjQ2NTBdIMKgPyByY3VfcmVh
ZF9sb2NrX3NjaGVkX2hlbGQrMHgzNi8weDYwDQo+IFsgwqAgwqAyLjQyNDY1MF0gwqBrZXJuZWxf
aW5pdF9mcmVlYWJsZSsweDFlMy8weDI0MQ0KPiBbIMKgIMKgMi40MjQ2NTBdIMKgPyByZXN0X2lu
aXQrMHgxYTAvMHgxYTANCj4gWyDCoCDCoDIuNDI0NjUwXSDCoGtlcm5lbF9pbml0KzB4MTcvMHgx
NzANCj4gWyDCoCDCoDIuNDI0NjUwXSDCoD8gcmVzdF9pbml0KzB4MWEwLzB4MWEwDQo+IFsgwqAg
wqAyLjQyNDY1MF0gwqByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiBbIMKgIMKgMi40MjQ2NTBd
IMKgPC9UQVNLPg0KDQo=
