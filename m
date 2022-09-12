Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223295B54FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiILHEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiILHEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 03:04:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CBAE61;
        Mon, 12 Sep 2022 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662966276; x=1694502276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=48wQcXiMDGoNCm3XtO/Eu6BaGcWxzXMVuZbMZRJcvSs=;
  b=mlUCeQ4pLleHIGlRhHOu/l7aamKinKRgO7k7evf2GVUjfQ3ihUodckkj
   F9VEHSY1XBkto2AVFp7aQzWbG0DZs9ECZ3L34LiYznCoI8IjbjrFUzeP9
   WtJZwZGvIWROL54eTpvUDuCxLT22OTYv1f/SZ86ti6I3blueaZrkfNdVV
   vYIPcIUAOiITPTBJyCNRhJadAHIJCpVogeWinJac3eSBRuqym/Q8Kk9hv
   +U9JH4CIzS6rxha47qorRWAQT586PfQShMcIwmPUvMYosaaEF7L88PWbO
   SIUaoFkn/cBebtwsqtrAwZZZQ0F3X0v6HTOI8IK7bsb87Aqg4zugVpT8A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296535769"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="296535769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 00:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="861058718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 00:04:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 00:04:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 00:04:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 00:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+e5Qt7AVAgblLk9cV6p0+Dv1lC3Xcr7pBzqEbctODKedZnSF1K7Ez3/eVMo1HRuFLdITPEkE+fuztjnYgU6U5rPWxycqwuadkKOP3WzBbqiCZpCr5NvhPyh131XC2KEXbOb+Bd5M/SwbJBWDYq+SwvatI70dz6jIx2kO94Q9oCgqxkyrlwNd6OWF4C9dnYTLd2gP2Fu1UQhfjfr1yyBhGxKCJytNks9+5Ty9H3Bt3u4Yj1rLdV5eDvQb5gGLOy/VPENH1j8YG5m/u4YgOkKhUV90X9V6txausFp3sngiSb6FEvdUaR/U1hFwS2PPx234x6KVTw35zu1ol6hhizoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48wQcXiMDGoNCm3XtO/Eu6BaGcWxzXMVuZbMZRJcvSs=;
 b=msG4Pkj0HWVbHMOsGQycpWQBKlMet0J1C3VsZUvMY2kIzvp3tHH+U3DF1myiGmA10v25armEkmW7rpkYPPAC1586+2/QkqdGYMWZ/IhqSFpdPqUoPLSYNLvLZAKsi8779XF/O0Qxd4yryB2nlra4r8qvEvJrj7TEd+fcqMaeoKGVKh231ORXJYmM9gvyrWd1pPdFmSPzAXrWHw5APLbmpi9XdXtTWaz4eoPpb31rttjt06sy8Q7AJ2EUGhcl5GKAklaKQRVQxXfSeMX96MM6Im5QMgZ52C5D2logQxc2Bv8WWfiUapsx61G3knE8oTGbre4hdPR8YzZqntyfOne1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 07:04:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:04:29 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Topic: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Index: AQHYxII0umFKXJIJT0imMnKpHHEJMa3bYscA
Date:   Mon, 12 Sep 2022 07:04:29 +0000
Message-ID: <8cb035b4e2cb1e5a49bab23ca7d06920e1585ec8.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: 4aba2862-d62a-404e-ad27-08da948d095d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XDIPeGxT3Uxy0t3FLYY+B/WzpsVboWCzHZD1XctEh+4Jd1FSWuEUu1klkp7937EydZ2P8IEeLvEJAAEgrOu875+9FTll1QPMvuCXHe2o0IZXh6SX47Q+8rCCZGG8Ay61a9Y4pKrdpCcJN0FN+Q1+sbxGSz64xk2V79CKlxTzL9r0WwudcNa9o8N+f/zyzCyV6dlZL9WasyJgS9ZRcQCeIlfUFTSmwwrGxdzQpCuREf+hONo6SGPEyoRZGeewbmBIF+LO9uHnN7bfzFnb8jzoKoHt773Xh1sN277SR8edgCoHJwED85AFePFeT9MTAUbJuJwDRuxg7qYEoXuFpe4fC4+mbpqNjCvy1pvb9bWcZOL2ba0nxvPv7tpflWUMPAdcQc5J3tbNeOjVcR7lbLC5GpQplfS4okbfofxlxrZs2uwlJhe1ucryDW9tWUYXhX2qlXljPfhVBCPU0/XtA7R3YVqGdlGygCdjS4IinNtALvxGdZZM9LwPJuNCNhqjdatc/Qfr9wyKGdl3tkG2zWw6VTYpznxBnO83tmiGD4/cNA83eJGrZtUT9k+gQAHS8YjO91Hrq+5uunRiEaTuSclcynOp5VuwMQA5NvQYg9a1sUaWD1HkBXn39Z9gZJwF+4CSBO/zjYLVCUI5zcxWH24oOsqIcBjUSb5/41xWFth0OH88mpXmzJf3ckWwb8CvZtF4BTZeOrvz92J/RTiwW/pjhmpofYM0rTGkHV+SNTewFqHp5e/K85VG/HZT77qcghIL0u2phWrjpDh++7JX+9dMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(376002)(346002)(136003)(86362001)(2616005)(6506007)(122000001)(83380400001)(38100700002)(186003)(36756003)(76116006)(8936002)(91956017)(5660300002)(316002)(54906003)(110136005)(7416002)(64756008)(66446008)(8676002)(66476007)(66946007)(66556008)(2906002)(4326008)(26005)(71200400001)(6486002)(38070700005)(41300700001)(6512007)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRrZVkwdTl6d1c2T1hzeHI0b0lLVVlKVGtESXlSSDRRQ0djTFJTSFNGQTFx?=
 =?utf-8?B?cXVWL3dScjNKNmJZdHpqQTdEMk1zR2hwYmRNRXo2aXR4bXM3TjJzRXpKWWxx?=
 =?utf-8?B?M1ZPcVZIcVlVZUl1VDBmT283Z0FNcGt1TlJqZThxQ3p5dStTRW1yWWF0Q1Nt?=
 =?utf-8?B?R3pVN0VlMS9ONDQ4WVV2dkJnemFUZCtndElmS3Y1cVp3QURNZUpSRGRxS3pr?=
 =?utf-8?B?aFRMaVhjVDRQSUJ6VnFyK1lOUGZaTlhUK0ZZQzJIbUptajNwRjhqcTI5d3Ry?=
 =?utf-8?B?WEE0MUgyR1lySmZyL3Z6cFBvYk9ta1h2TENUdkJTdnl2NVptT3oxU3IxY3B2?=
 =?utf-8?B?SmdobWlkdUQ4Z2d1SE5wa2FRSVoxa3ZXS0dsK3c0VDZkWkpteGNrc09STWF1?=
 =?utf-8?B?Sjg0amxURmk4clgxRktlaCtRVVRwMWxWeld4cjFFbzE5YU5xWnZZekl2dDVr?=
 =?utf-8?B?NGpYd2o0OEt2U2s4MENUaUo4bExUdkROMW91aGpkN0xzSTM2dnIzcU1qSjBM?=
 =?utf-8?B?eHk1bUh1Q3ZOOEhudkpEVTByVWtoZmdNOFM4T1hxakxNWkJFajZCNnVrYnkz?=
 =?utf-8?B?L3FyU01EVXRzck95S0pPVWU4c1ZvRSttaGpLdHB1dTcvS2NhaDA3MTN3ZFN3?=
 =?utf-8?B?dUtCWjZRdlg3clgwVUYrenJOMGJRTnkxd2FGdnZDUEN4bnRhUE04TFZUQWRY?=
 =?utf-8?B?R2tTTGc3akhMYi95TndRWDd5b3RNSVdWb3R4aFlSd243WlBlZnpuRVJGVU9z?=
 =?utf-8?B?U0grVHNaWXRiYXRaZ0wxVEdja0htQ1ZOSE16M3JrZi9jbGlFRUVCeHhSdW5s?=
 =?utf-8?B?UldMU3dRbVEva29SRXEvM3NNLzFyNG9DZWpHbjBlalhrakVMS0pjN0hDU0V5?=
 =?utf-8?B?QXZCZmtJRmFIZG91Ung1OCtyTlpXazBFL3NLc0VPWUJWV1pkUlFMZlNWVHBm?=
 =?utf-8?B?dm9JeUVHR1BReHVaMDFadHdpZkVuQkRKd2VTQTQ0N0pGaUQ0Tm1RdXgveDJM?=
 =?utf-8?B?YUFydU5MMFBqV2QrT3BSZW56eXVnSGcwRGFRWjQyRmlxRWZjbXEyank1YTN5?=
 =?utf-8?B?bmJmYzdOeXRLSXI1RzdtRkhNUFJsL0ZmWGZUd1RpMVR1TTgwSlY3MDBxck1E?=
 =?utf-8?B?MWJBeWo1UUdYYkJmQ0FkRy82d0gwWDE0eGZ3VDFCSWtuTFZmcDduSk5pRTB6?=
 =?utf-8?B?SWF2b2t4M1FRemJIQzNSOGI0NyttMGo1eW53ZXBWMzZTbnBaMDRzb0I3bWdH?=
 =?utf-8?B?eDJnQnFSY0dCQU5Fa1F1Sk5mNW9NV2lTeVRjZ0VhenAwMGdzeHB1MU0rQk9t?=
 =?utf-8?B?QTV4eUM5d29yTTlQa3JnN2txN3VXdHZZTEJ5OWlKSUpZc2owUVdSTzhrVUY2?=
 =?utf-8?B?dDhjSnFuYmVrbVFRZ3E2NXlOV1JISHJ4VzJGemt0K0JIWVo4SVgvV3dYZ3hC?=
 =?utf-8?B?aXAxMWRGYXNhVFo1cUZsT0tHazhBNEtudWFwWEJMSDZ0cTZmOFQ0cGdGam5O?=
 =?utf-8?B?bFkybTdnRGFEb0dkcHdQdFF4K3BLN3V2dExwZkR5cXAwMDhaV0p6OEVwZ2tl?=
 =?utf-8?B?cDE3M1cxMFFtYS9SSDZNZzZRZHVBRi8wSkhTRkZUK1RNY0J0NnZWKzRaWnNE?=
 =?utf-8?B?ZHBtZDAvRFBqWkxhSEhvYU1MT2F6SEphR1lBNytuT0VNL0tZOE43WnhHSUk5?=
 =?utf-8?B?VjZLNXptaXBLeEU2cjdCclZzUjZpYUhEd3dDQ09hQnhYaWsvemxYOC9XZjk5?=
 =?utf-8?B?ZnNjRjNHdmY4S016ZUNwVXcyV1lwZ0trQzNab1NyK3BCUFpvTUQyTjJ0NlJm?=
 =?utf-8?B?RVFWYzlsT29RWElrZ2RqTlBCa1dCTjZQUklSUW5zajZUY2R4WnVJRTJMWWg4?=
 =?utf-8?B?d1ZLeVAvb1RlaGJiaW9MdGx6bkM0d1AyY29QdWFSZlVTL2htNmRzeXVOUUdo?=
 =?utf-8?B?dHNZQXlEMVY5cHp2QjN2RWErUXlvZVNnRzBCRExXU21FODYwQ3ZBRXVjNVBW?=
 =?utf-8?B?TTU2SHhXdC9kd3BxcHVQRDRtQXpWRnU0Wk1mS1hnUTRuVHUvbjA2SHBwY2pn?=
 =?utf-8?B?bnZnVTdaQXkvK1pxeitZK3l6alkvT1lDLzMrQWI5TzRiUk5CNVhnMFRwL1RD?=
 =?utf-8?B?THhDR1loYkVuZ1hpdG1DTDgwZ2M1aFFWTGVZZUhTL3hlUklLdXBTOVhycDZG?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5B36F68D03CC642B3A6EB35BD15AB1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aba2862-d62a-404e-ad27-08da948d095d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:04:29.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPhWSJ+qFvGz5Z7uFQObDsJZ+uSzZrGhGZQLo/nkZWBTWLedNxh4rph4tEADFL7r1/pvnU4bA02Tpe96Zgym3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
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

DQo+ICsNCj4gK0F0IFREWCBndWVzdCBydW50aW1lLCB0aGUgSW50ZWwgVERYIG1vZHVsZSByZXVz
ZXMgdGhlIEludGVsIFNHWCBhdHRlc3RhdGlvbg0KPiAraW5mcmFzdHJ1Y3R1cmUgdG8gcHJvdmlk
ZSBzdXBwb3J0IGZvciBhdHRlc3RpbmcgdG8gdGhlc2UgbWVhc3VyZW1lbnRzIGFzDQo+ICtkZXNj
cmliZWQgYmVsb3cuDQoNClRoZSBhYm92ZSBwYXJhZ3JhcGggaXNuJ3QgcmlnaHQuICBUaGUgSW50
ZWwgVERYIG1vZHVsZSBpdHNlbGYgZG9lc24ndCB1c2UNCmFueXRoaW5nIGFib3V0IFNHWCAocGVy
aGFwcyBleGNlcHQgdXNpbmcgdGhlIGtleSB0byBnZW5lcmF0ZSB0aGUgTUFDIGZvciB0aGUNClRE
UkVQT1JULCBidXQgaXQgY2VydGFpbmx5IGRvZXNuJ3QgdXNlICJTR1ggaW5mcmFzdHJ1Y3R1cmUi
IGZvciBzdXJlKS4gIEV2ZW4gdGhlDQpuZXcgRU5DTFUgbGVhZiB1c2VkIHRvIHZlcmlmeSB0aGUg
VERSRVBPUlQgaXMgbm90IHBhcnQgb2YgdGhlIFREWCBtb2R1bGUgLS0gaXQncw0KYW4gZXh0ZW5z
aW9uIHRvIFNHWCB0byBzdXBwb3J0IFREWCBhdHRlc3RhdGlvbi4gIA0KDQpBbHNvLCBjb25jZXB0
dWFsbHksIG9ubHkgdGhlIHZlcmlmaWNhdGlvbiBzZXJ2aWNlIGNhbiB0cnVseSBfYXR0ZXN0XyBz
b21ldGhpbmcuDQpUaGUgU0dYIHNvZnR3YXJlIHN0YWNrIHJ1bm5pbmcgb24gdGhlIG1hY2hpbmUg
dGhhdCBob3N0cyBURFggZ3Vlc3RzIGRvZXNuJ3QNCmFjdHVhbGx5IF9hdHRlc3RfIGFueXRoaW5n
LiAgSXQgb25seSBjYW4gX2dlbmVyYXRlXyBzb21ldGhpbmcgKFF1b3RlKSB0aGF0IGNhbg0KYmUg
YXR0ZXN0ZWQuDQoNCkluIGJlbG93IHlvdSBhbHJlYWR5IG1lbnRpb25lZCAiVERYIGxldmVyYWdl
cyBJbnRlbCBTR1ggUXVvdGUgKHNob3VsZCBiZSBRdW90aW5nDQpJIHRoaW5rKSBFbmNsYXZlIHRv
IC4uLiIuICBJIGRvbid0IHRoaW5rIHRoaXMgcGFyYWdyYXBoIGlzIGV2ZW4gbmVjZXNzYXJ5IGFu
ZA0KeW91IGNhbiBqdXN0IGRlbGV0ZSBpdC4NCg0KSWYgeW91IHJlYWxseSB3YW50IHRvIHNheSwg
SSB0aGluayBvbmUgc2ltcGxlIHNlbnRlbmNlIGxpa2UgIlREWCBsZXZlcmFnZXMgU0dYDQp0byBz
dXBwb3J0IGF0dGVzdGF0aW9uIiBpcyBlbm91Z2guDQoNCj4gKw0KPiArVGhlIGF0dGVzdGF0aW9u
IHByb2Nlc3MgY29uc2lzdHMgb2YgdHdvIHN0ZXBzOiBURFJFUE9SVCBnZW5lcmF0aW9uIGFuZA0K
PiArUXVvdGUgZ2VuZXJhdGlvbi4NCj4gKw0KPiArVERYIGd1ZXN0IHVzZXMgVERDQUxMW1RERy5N
Ui5SRVBPUlRdIHRvIGdldCB0aGUgVERSRVBPUlQgKFREUkVQT1JUX1NUUlVDVCkNCj4gK2Zyb20g
dGhlIFREWCBtb2R1bGUuIFREUkVQT1JUIGlzIGEgZml4ZWQtc2l6ZSBkYXRhIHN0cnVjdHVyZSBn
ZW5lcmF0ZWQgYnkNCj4gK3RoZSBURFggbW9kdWxlIHdoaWNoIGNvbnRhaW5zIGd1ZXN0LXNwZWNp
ZmljIGluZm9ybWF0aW9uIChzdWNoIGFzIGJ1aWxkDQo+ICthbmQgYm9vdCBtZWFzdXJlbWVudHMp
LCBwbGF0Zm9ybSBzZWN1cml0eSB2ZXJzaW9uLCBhbmQgdGhlIE1BQyB0byBwcm90ZWN0DQo+ICt0
aGUgaW50ZWdyaXR5IG9mIHRoZSBURFJFUE9SVC4NCj4gKw0KPiArQWZ0ZXIgZ2V0dGluZyB0aGUg
VERSRVBPUlQsIHRoZSBzZWNvbmQgc3RlcCBvZiB0aGUgYXR0ZXN0YXRpb24gcHJvY2Vzcw0KPiAr
aXMgdG8gc2VuZCBpdCB0byB0aGUgUUUgdG8gZ2VuZXJhdGUgdGhlIFF1b3RlLiBURFJFUE9SVCBi
eSBkZXNpZ24gY2FuIG9ubHkNCj4gK2JlIHZlcmlmaWVkIG9uIGxvY2FsIHBsYXRmb3JtIGFzIHRo
ZSBNQUMga2V5IGlzIGJvdW5kIHRvIHRoZSBwbGF0Zm9ybS4gVG8NCj4gK3N1cHBvcnQgcmVtb3Rl
IHZlcmlmaWNhdGlvbiBvZiB0aGUgVERSRVBPUlQsIFREWCBsZXZlcmFnZXMgSW50ZWwgU0dYIFF1
b3RlDQo+ICtFbmNsYXZlIChRRSkgdG8gdmVyaWZ5IHRoZSBURFJFUE9SVCBsb2NhbGx5IGFuZCBj
b252ZXJ0IGl0IHRvIGEgcmVtb3RlDQo+ICt2ZXJpZmlhYmxlIFF1b3RlLiBNZXRob2Qgb2Ygc2Vu
ZGluZyBURFJFUE9SVCB0byBRRSBpcyBpbXBsZW1lbmVudGF0aW9uDQo+ICtzcGVjaWZpYy4gQXR0
ZXN0YXRpb24gc29mdHdhcmUgY2FuIGNob29zZSB3aGF0ZXZlciBjb21tdW5pY2F0aW9uIGNoYW5u
ZWwNCj4gK2F2YWlsYWJsZSAoaS5lLiB2c29jayBvciBoeXBlcmNhbGwpIHRvIHNlbmQgdGhlIFRE
UkVQT1JUIHRvIFFFIGFuZCByZWNlaXZlDQo+ICt0aGUgUXVvdGUuDQo+ICsNCj4gK1RvIGFsbG93
IHVzZXJzcGFjZSBhdHRlc3RhdGlvbiBhZ2VudCBnZXQgdGhlIFREUkVQT1JULCBURFggZ3Vlc3Qg
ZHJpdmVyDQoNCgkJCQkJXg0KCQkJCQl0byBnZXQNCg0KPiArZXhwb3NlcyBhbiBJT0NUTCAoVERY
X0NNRF9HRVRfUkVQT1JUKSBpbnRlcmZhY2UgdmlhIC9kZXYvdGR4LWd1ZXN0IG1pc2MNCj4gK2Rl
dmljZS4NCj4gKw0KPiArVERYIEd1ZXN0IGRyaXZlcg0KPiArPT09PT09PT09PT09PT09PQ0KPiAr
DQo+ICtUaGUgVERYIGd1ZXN0IGRyaXZlciBleHBvc2VzIElPQ1RMIGludGVyZmFjZXMgdmlhIC9k
ZXYvdGR4LWd1ZXN0IG1pc2MNCj4gK2RldmljZSB0byBhbGxvdyB1c2VyIHNwYWNlIHRvIGdldCBj
ZXJ0YWluIFREWCBndWVzdCBzcGVjaWZpYyBkZXRhaWxzDQo+ICsobGlrZSBhdHRlc3RhdGlvbiBy
ZXBvcnQsIGF0dGVzdGF0aW9uIHF1b3RlIG9yIHN0b3JhZ2Uga2V5cywgZXRjKS4NCg0KT25seSBU
RFhfQ01EX0dFVF9SRVBPUlQgaXMgc3VwcG9ydGVkIG5vdy4gIFdoZXRoZXIgR2V0UXVvdGUgVERW
TUNBTEwgc2hvdWxkIGJlDQpzdXBwb3J0ZWQsIG9yIGhvdyBzaG91bGQgaXQgYmUgc3VwcG9ydGVk
IGlzIHVua25vd24gbm93LiAgTm90IHRvIG1lbnRpb24gImdldA0KdGhlIHN0b3JhZ2Uga2V5cyIu
DQoNCkkgZG9uJ3QgdGhpbmsgeW91IHNob3VsZCBwdXQgYW55dGhpbmcgaGVyZSBub3cgZXhjZXB0
ICJhbGxvdyB1c2Vyc3BhY2UgdG8gZ2V0DQpURFJFUE9SVCIuDQoNCj4gKw0KPiArSW4gdGhpcyBz
ZWN0aW9uLCBmb3IgZWFjaCBzdXBwb3J0ZWQgSU9DVEwsIGZvbGxvd2luZyBpbmZvcm1hdGlvbiBp
cw0KPiArcHJvdmlkZWQgYWxvbmcgd2l0aCBnZW5lcmljIGRlc2NyaXB0aW9uLg0KPiArDQo+ICs6
SW5wdXQgcGFyYW1ldGVyczogUGFyYW1ldGVycyBwYXNzZWQgdG8gdGhlIElPQ1RMIGFuZCByZWxh
dGVkIGRldGFpbHMuDQo+ICs6T3V0cHV0OiBEZXRhaWxzIGFib3V0IG91dHB1dCBkYXRhIGFuZCBy
ZXR1cm4gdmFsdWUgKHdpdGggZGV0YWlscw0KPiArICAgICAgICAgYWJvdXQgdGhlIG5vbiBjb21t
b24gZXJyb3IgdmFsdWVzKS4NCj4gKw0KPiArVERYX0NNRF9HRVRfUkVQT1JUDQo+ICstLS0tLS0t
LS0tLS0tLS0tLS0NCj4gKw0KPiArOklucHV0IHBhcmFtZXRlcnM6IHN0cnVjdCB0ZHhfcmVwb3J0
X3JlcQ0KPiArOk91dHB1dDogVXBvbiBzdWNjZXNzZnVsIGV4ZWN1dGlvbiwgVERSRVBPUlQgZGF0
YSBpcyBjb3BpZWQgdG8NCj4gKyAgICAgICAgIHRkeF9yZXBvcnRfcmVxLnRkcmVwb3J0IGFuZCBy
ZXR1cm5zIDAgb3IgcmV0dXJucw0KPiArICAgICAgICAgLUVJTyBvbiBURENBTEwgZmFpbHVyZSBh
bmQgc3RhbmRhcmQgZXJyb3IgbnVtYmVyIG9uDQo+ICsgICAgICAgICBvdGhlciBjb21tb24gZmFp
bHVyZXMuDQo+ICsNCj4gK1RoZSBURFhfQ01EX0dFVF9SRVBPUlQgSU9DVEwgY2FuIGJlIHVzZWQg
YnkgdGhlIGF0dGVzdGF0aW9uIHNvZnR3YXJlIHRvDQo+ICtnZXQgdGhlIFREWCBndWVzdCBtZWFz
dXJlbWVudHMgZGF0YSAod2l0aCBmZXcgb3RoZXIgaW5mbykgaW4gdGhlIGZvcm1hdA0KPiArb2Yg
VERSRVBPUlRfU1RSVUNULsKgDQo+IA0KDQpJTUhPICJ0byBnZXQgdGhlIFREUkVQT1JUIiBpcyBl
bm91Z2guICBZb3UgYWxyZWFkeSB1c2VkIFREUkVQT1JUIGluIG1hbnkgcGxhY2VzDQppbiB0aGlz
IGRvY3VtZW50YXRpb24gKGFuZCBpbiB0aGlzIHNlcmllcyksIGFuZCB5b3UgaGF2ZSBhbHJlYWR5
IGV4cGxhaW5lZCBpdC4NCg0KV2l0aCBhYm92ZSAoYXQgbGVhc3QgZXJyb3JzKSBmaXhlZDoNCg0K
QWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KDQotLSANClRoYW5r
cywNCi1LYWkNCg0KDQo=
