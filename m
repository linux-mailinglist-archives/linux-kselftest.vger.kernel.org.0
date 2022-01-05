Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23555484CFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 05:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiAEEDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 23:03:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:3525 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbiAEEDi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 23:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641355418; x=1672891418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hD5D/qy0JFkYiSUyx0SgL1ulgXIS3svvrm1f7vT72+8=;
  b=VYF/eckFqJA/fgAou/jR0AQ4NlHup3NtydLhPnQysVFhu0EYPj8323QA
   G61oRR2PncXqjzh3ym5x1kIrbbJO+eCLV22Ol/rQYOJviIcGOOBfABJq0
   5jHNS6Jb4JfbZ6JCsMd+cIoh9pgnO2dcmh4jHL8KYdCBWbsItVq33zZ5F
   4QQsD98RdMgQ5zDrhC8jgnjRzWjTgMuXFVBA5Kf+2ZTczBZQ6XJOX8kkh
   xCPlQfe+jZvriyGlLEHRMHN6rRtMhQW/87nSCUGrCd//P2kQnB1gfLuLW
   S67viwc57J9Jb5sk8TD9s0KYMluNDPxN0MPXcR6kuubwat5Judm1ARwFD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242319952"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242319952"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 20:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="763033728"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2022 20:03:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 20:03:36 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 20:03:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 20:03:36 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 20:03:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGJtUglKCR0yTNMDfW8ZlQQ48hwkX6Lmu1JBHdzwHqQIDrnJ5sudFFWJmbfb1nY9qBmkF6mGDB+xSvFoT/goPVCOJg3zsJ/5hsny5pkrGElwPaEb9a0g8QiX2LzAOYDrRtkZXhhCnA931eGtIGhvnus1GE4TGjqxbXVEoPD4euH4Lx/CutmyFP517+FNi1Ntp3mCY4j3R8UbrnnVYdqzSkmcWoRVQw4TbPiB+SBiT/0WcxQ3RboI9V7Z01suphJ+rZLsxSugqfhtqJ7ZXRSQ8h5BA1pRSHXs2npMyvt+6w7n33nobRGCBD0IDs4PgreNq7kio8pS4IP/5yaEbHIAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD5D/qy0JFkYiSUyx0SgL1ulgXIS3svvrm1f7vT72+8=;
 b=Uq6M5MbZ19WIabbQRKfbNXWDnLU4qJvh8jvI+O73frFNWFpILulZNiMoW6LXFkzvVd3EnPvG2242WlT1NDFCEyk3IRgkjxkwO85184YimlGwin58P3wNT8FQfZbT278D0mTP33bhKgx3hZ1lDrmQWIdsZm0h0USLYdm2DKqo4/Q3x8jTwX0fAKgSsz8FpUhQ2t9YTdonvkiN6TJ7r5GOjt9xkVq+yGgD8QW2ssi+FXRXAyI+0XNPJdrACBJmeLRr1Y+0L84W8kpTkvYMr7/6a37pVK2OeuvsTngcrjrNfpYRVl+qehnI61znji5Vzo76slnnuOatmHis3lHrGAntvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1569.namprd11.prod.outlook.com (2603:10b6:405:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 04:03:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 04:03:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v4 18/21] kvm: x86: Add support for getting/setting
 expanded xstate buffer
Thread-Topic: [PATCH v4 18/21] kvm: x86: Add support for getting/setting
 expanded xstate buffer
Thread-Index: AQHX/LXv8YYbtY1bDUCh211gRytBzqxTThEAgAAQlYCAAHe94A==
Date:   Wed, 5 Jan 2022 04:03:33 +0000
Message-ID: <BN9PR11MB5276A5116B76143CB694D1738C4B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-19-yang.zhong@intel.com> <YdSkDAruycpXhNUT@google.com>
 <c41a0458-1bfa-9dc6-71ce-f0433cd400e7@redhat.com>
In-Reply-To: <c41a0458-1bfa-9dc6-71ce-f0433cd400e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fe7c76-4b08-4aa2-b571-08d9d000576a
x-ms-traffictypediagnostic: BN6PR11MB1569:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB15692550ECCF93EF9F3355F28C4B9@BN6PR11MB1569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2K80INLczpbeMYSBXcYgLNMTKmeTD+/xQFIKIE04VGr5Tj70zFvfUR4J+D9Fn/xkG3y3OdVt9/+yTJw3WFppSAwG8izq4NKdCfwZkOhm5MAXiCK+tYEFlBAJeHYdh+8j1NA4/zkyHKUcv9+76r80ntoa8KJB4+fAUSU7ns6M0hi9o66B5TMhzZBF7C9nn+RgL9L2wcC12HSegYhZMDa+Xrnzkh0TK00UdqSrl2h0POwzKHEeOaaW/mEtqrKTamz5HNA2pZvlHCf/PLaVbuofXF//QVBm4gHUrfRARgx2phUF97A17CcnHWu4kZhh3tcQzJWX5dUUrNKrGkq2UwypxpQWwbnxgtC9CSkYsGVDafZuC/l/WFljcJ8tIoHHLCPAdRGGnmDn+qtPgRuWTe/6EgYnQdhZutQzGDP5mnORaoIWauM/MpqRF+S1QFiMvJac2ptZFIDRBUg/nQ2MQNwT89TG+lJ1nPrspOg04c6wNEnQIA2XnjO9zBpMcbt+0T2n8K1zv33d7gn8+O5W3Mvmd/KtOae5pgwITQM0C3LF8H/PlUV2U7xoXByG74k+wXJHZuDPKSqieL+mrHmR+EWhm2Hc+1ePlEQbxLp8g6gtogjWHXlMWLWQI7ui6rSdkCC7IUVQ84CTxWxcqNWkpzbN97Q4lwpE7OxqbdFs6L6L52CA4JeXZNy5ZgDgxerXLM/dYSHJt/GodC4vRo/ui1LNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(38070700005)(7696005)(86362001)(8676002)(66946007)(53546011)(82960400001)(66556008)(71200400001)(52536014)(66476007)(6506007)(6636002)(66446008)(64756008)(4326008)(5660300002)(55016003)(76116006)(8936002)(110136005)(9686003)(186003)(7416002)(122000001)(26005)(2906002)(38100700002)(316002)(54906003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWpVU1NQUkVQaUU5Ry9QMUMrUlJ5SXBKbm5Xdlg1ZGxzc0M2M04xNkF2UUV4?=
 =?utf-8?B?d2w3ZFM3L3VreFZNT1pxaFF5cjlIZ0szeXBMMllTWTh2cTdGZS9UcExPRXUr?=
 =?utf-8?B?ZWhCRUZJRGU0WllROXc4VzBuVS9KcWdQRC9CS3dqcmIvTTZ2Rkg2SkZBRjBV?=
 =?utf-8?B?MmEyUVZXM3dPaVgwTHRucEJza3B6Vi9vNDdJNnhOcmxBUUtWY2VOQTIwM2xj?=
 =?utf-8?B?UkF3Nmp4ano4Um1VSklGbCs2c3ZLSnAxOW9LbWxBbGhJQzZSKzhWNHpPM2pk?=
 =?utf-8?B?WFpmUGl0TTlkVU1Ub05tOWVsU2hGTnVhRE1uQ1RnSWtwZ1VHV1czNUJ1U3U4?=
 =?utf-8?B?WjNnckZRcFNKTXU5MEFuV2p4MDI3Qko0VXAvMVVHOUtCNlM2TTBjMDR5a09j?=
 =?utf-8?B?YlM4SW11QzBNRWZYa29qblFrbVRtMGdoMGUrM1AxeFJxcVo5WEFYWlYwRTFP?=
 =?utf-8?B?dHNNVlBhMDJEeWRVbnNuQjM3enh1OHNaYnJWTHhzVFVXTng0TThYVTdTUHdD?=
 =?utf-8?B?WTZjWW1JaC9BOW1WWWhTVlB3L3BFVVh5TjNGRllhSVdGODZudWp4d050Znhs?=
 =?utf-8?B?Y2FqMXcyeDk5L3lQdnduSlVmTGhSanFIcktLS3A3Z01QbkRKQW82eEsxWmRV?=
 =?utf-8?B?ZWhJdk9xZlgza0QvMXRDdHJTTko0WnFyYjdUekJ5VzRWVkptQk5SWjZQV2lN?=
 =?utf-8?B?MWVpa0ExRFBoMVRESjJ4T2xUMk10NVBpV1pwdnhvVE90TjdqYUcyZkdlTjNH?=
 =?utf-8?B?R1dPMU1CQ2lSdXZkTkdRSjdhVDNmQ1V5dXIxQTBUQXJUajFiT01TUmJpNlh5?=
 =?utf-8?B?eVpwODRiRC9UTEZLa2RpcnJ5YmNIN2N2ZUdRYVcyK2JHWVNqRW0rRnFWcVVD?=
 =?utf-8?B?dFpjNVhzRUlWckpxSzU2ZktDVlRIdkhmSXhObTRCbVlNYUFBdDlzUGJ5c20y?=
 =?utf-8?B?bWlkOVNJMTFzanJNbWNwVlQ5VUNOK0x5MDBDb25jYkhQZFRVYm1LUVc3TmRL?=
 =?utf-8?B?U2dEaGNCZnJubFZpOFk5cGNhVWcvSURmVHNxeTJBRTV0cm5iZStidGlTenJp?=
 =?utf-8?B?Z0wvYWZTZXVkT2xNd09QWmV4b2lxTnVJajRjOTkrc2p5ek43eGd1cFhNUmsv?=
 =?utf-8?B?bWE5S0x3TDIrMWlxUmQ2ZUsrTzNVdElHZjJJd2lhcFpMODZRRHZPRTRjalQ4?=
 =?utf-8?B?dzdtNHVMZkVXaGJBVFdUTEljQkphWG1iSUdqYzdRSWhTS3d6Z0FvTkVUQ0Jw?=
 =?utf-8?B?MUJZNzVZSU1xYXZPQTkrbXFXODFlTEN0UDlWa3RmRElUMUtpWkM4TkJBTjBC?=
 =?utf-8?B?Q0JLdVlNZWZLdHV3dVZBcCtyOXFEVmdZaFQ1QlA3Ky9LUlVxdFVWNnRaeis4?=
 =?utf-8?B?RUFqREdPV2JxZ3h0VXpEM3FDU3E3a2tEb1g0d1RrRjBMQ0ZrWFBkNjNCMEpr?=
 =?utf-8?B?SDBaWlZiQkZ3VjMxUVU2a1loY25ZUFBSbnRCZUZtalZrLzhSVldmMHdYUis5?=
 =?utf-8?B?NkZXa01OWVl4Y01PU0kydlZSWTdRY2JXOFc1R3QyMmZsUGhOQmlDQ0ZORVd6?=
 =?utf-8?B?YUJIb1puY0lEc3JIZHJ2bk5nOHRPamhwSG54THdHVlRrNjc0Znk1bnA3UDM0?=
 =?utf-8?B?N1JYZk9zOEgzQ3lYbVVpT2Vud2s3ZFQ0aGMxdHlvcVd5R0xMZWZMN0NXZUVh?=
 =?utf-8?B?amg1R1pueC9CQUJPYkt3YmR0dk9rdkVhdE85VHJCQXFNY1hJSzd2djRKa05w?=
 =?utf-8?B?U2VybXBVOGdCQXBDVFhDeVhHUmhBdTVrT2NySE5yN3Y0Q3NWWk90dHpBbXkz?=
 =?utf-8?B?ekxkOXRFKyttK1Z2VFlLWWdDYkNPbmNSTldhU01SMGFyaUp6R1NiQndvbTJR?=
 =?utf-8?B?KzVXRHFDbEcvVi8xN2E1TUtTTnNmQnVzWFdmNFVKa3lmNjV6NEY1T0tXeEhJ?=
 =?utf-8?B?VkFKREJnWGNuazE4M2Q4OWovZmczUzFsMzV5Sm16QXRQTW5IWkx3NFF4V25S?=
 =?utf-8?B?bW5zR0tMYUt0ZmhJL0JVZTQ5d0pqTjkyYWEzZGtKWmphMFl5UEY0djFlYnpI?=
 =?utf-8?B?Wm9FaWZKa1pheGNDRXhqRDl6WlZuZEkxUDh4V1UzRngyMnRlRTFFd3RoMy9i?=
 =?utf-8?B?cVcvV3BrTTlkWndwU1lXVGx5Y2xrbGx3NFQxZlBVNmFDOWZ5dmFINWtUMkJm?=
 =?utf-8?Q?G1VfUoRL+FseJKjlF+fp1IE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fe7c76-4b08-4aa2-b571-08d9d000576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 04:03:33.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvceVpM5ZKeyrWs5A0t/rtfNqUFvNnvoFQXFzoomXEc1itwqP5BwZKTqD+XRjervMH3yZ38dmeXlweAup6quHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1569
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgNSwgMjAyMiA0OjQ2IEFNDQo+IA0KPiBPbiAxLzQvMjIgMjA6NDYsIFNl
YW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+ID4gT24gV2VkLCBEZWMgMjksIDIwMjEsIFlhbmcg
Wmhvbmcgd3JvdGU6DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNo
L3g4Ni9rdm0veDg2LmMNCj4gPj4gaW5kZXggYmRmODljMjhkMmNlLi43NmUxOTQxZGIyMjMgMTAw
NjQ0DQo+ID4+IC0tLSBhL2FyY2gveDg2L2t2bS94ODYuYw0KPiA+PiArKysgYi9hcmNoL3g4Ni9r
dm0veDg2LmMNCj4gPj4gQEAgLTQyOTYsNiArNDI5NiwxMSBAQCBpbnQga3ZtX3ZtX2lvY3RsX2No
ZWNrX2V4dGVuc2lvbihzdHJ1Y3Qga3ZtDQo+ICprdm0sIGxvbmcgZXh0KQ0KPiA+PiAgIAkJZWxz
ZQ0KPiA+PiAgIAkJCXIgPSAwOw0KPiA+PiAgIAkJYnJlYWs7DQo+ID4+ICsJY2FzZSBLVk1fQ0FQ
X1hTQVZFMjoNCj4gPj4gKwkJciA9IGt2bS0+dmNwdXNbMF0tPmFyY2guZ3Vlc3RfZnB1LnVhYmlf
c2l6ZTsNCj4gPg0KPiA+IGEpIFRoaXMgZG9lcyBub3QgY29tcGlsZSBhZ2FpbnN0IGt2bS9xdWV1
ZS4NCj4gPg0KPiA+ICAgICBhcmNoL3g4Ni9rdm0veDg2LmM6IEluIGZ1bmN0aW9uIOKAmGt2bV92
bV9pb2N0bF9jaGVja19leHRlbnNpb27igJk6DQo+ID4gICAgIGFyY2gveDg2L2t2bS94ODYuYzo0
MzE3OjI0OiBlcnJvcjog4oCYc3RydWN0IGt2beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkDQo+IOKA
mHZjcHVz4oCZDQo+ID4gICAgICA0MzE3IHwgICAgICAgICAgICAgICAgIHIgPSBrdm0tPnZjcHVz
WzBdLT5hcmNoLmd1ZXN0X2ZwdS51YWJpX3NpemU7DQo+ID4NCj4gPiBiKSB2Y3B1MCBpcyBub3Qg
Z3VhcmFudGVlZCB0byBiZSBub24tTlVMTCBhdCB0aGlzIHBvaW50Lg0KPiANCj4gWWFuZywgeW91
IGNhbiBwb3N0IGFuIGluY3JlbWVudGFsIHBhdGNoIGZvciB0aGlzLiAgWW91IGNhbiB1c2UgdGhl
DQo+IGhpZ2hlc3QgYml0IG9mIHRoZSBndWVzdC1wZXJtaXR0ZWQgeGNyMCAoaS5lLiB0aGUgT1Ig
b2YgS1ZNJ3Mgc3VwcG9ydGVkDQo+IFhDUjAgYW4gdGhlIGd1ZXN0LXBlcm1pdHRlZCBkeW5hbWlj
IGZlYXR1cmVzKSBhbmQgcGFzcyBpdCB0byBjcHVpZCgweEQpLg0KPiANCg0KV2lsbCBkbywgZXhj
ZXB0IG9uZSBjb3JyZWN0aW9uIHRoYXQgJ09SJyBzaG91bGQgYmUgJ0FORCcgaGVyZS4g8J+Yig0K
DQpUaGFua3MNCktldmluDQo=
