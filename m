Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC711DD45C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgEUR2p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 13:28:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:18404 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgEUR2o (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 13:28:44 -0400
IronPort-SDR: q+PO2hQjJ9shZKcOyR7Xw0HZH7SENT0t35fBeGZIi2t7sajODKyzSL0WeGOUtfSF+0jG1Grvd1
 jL8O62s9/DVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:28:43 -0700
IronPort-SDR: FI77GAeRD8ByxCVBVRxrV1H99C3wMb8ZUpAuhDL5KErsTNXfIEwgwLGanxrP7A6iqurr+E0QXF
 dd1hYEbtExsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="289824685"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 21 May 2020 10:28:43 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 10:28:42 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.231]) with mapi id 14.03.0439.000;
 Thu, 21 May 2020 10:28:42 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "dcb314@hotmail.com" <dcb314@hotmail.com>
Subject: RE: [PATCH V2 00/19] Miscellaneous fixes for resctrl selftests
Thread-Topic: [PATCH V2 00/19] Miscellaneous fixes for resctrl selftests
Thread-Index: AQHWLWGetu1h4045MEyyPJ1k78YbtqizL9CA//+fKUA=
Date:   Thu, 21 May 2020 17:28:41 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573B66D6@ORSMSX114.amr.corp.intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <3669988f-2a76-c698-dd95-7972056353cb@intel.com>
In-Reply-To: <3669988f-2a76-c698-dd95-7972056353cb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmVp
bmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWF5IDIxLCAyMDIwIDk6MTIgQU0NCj4gVG86IFByYWtoeWEsIFNhaSBQcmFuZWV0aCA8c2Fp
LnByYW5lZXRoLnByYWtoeWFAaW50ZWwuY29tPjsNCj4gc2h1YWhAa2VybmVsLm9yZzsgc2toYW5A
bGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZw0KPiBD
YzogdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IEx1
Y2ssIFRvbnkNCj4gPHRvbnkubHVja0BpbnRlbC5jb20+OyBiYWJ1Lm1vZ2VyQGFtZC5jb207IGph
bWVzLm1vcnNlQGFybS5jb207DQo+IFNoYW5rYXIsIFJhdmkgViA8cmF2aS52LnNoYW5rYXJAaW50
ZWwuY29tPjsgWXUsIEZlbmdodWENCj4gPGZlbmdodWEueXVAaW50ZWwuY29tPjsgeDg2QGtlcm5l
bC5vcmc7IExLTUwgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tOyBkY2IzMTRAaG90bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWMiAwMC8xOV0gTWlzY2VsbGFuZW91cyBmaXhlcyBmb3IgcmVzY3RybCBzZWxmdGVzdHMNCj4g
DQo+IEhpIFNhaSwNCj4gDQo+IE9uIDUvMTgvMjAyMCAzOjA4IFBNLCBTYWkgUHJhbmVldGggUHJh
a2h5YSB3cm90ZToNCj4gPiBGZW5naHVhIFl1ICgxKToNCj4gPiAgIHNlbGZ0ZXN0cy9yZXNjdHJs
OiBGaXggbWlzc2luZyBvcHRpb25zICItbiIgYW5kICItcCINCg0KW1NOSVBdDQoNCj4gVGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgY3JlYXRpbmcgdGhlc2UgZml4ZXMuIFRoZXJlIGFyZSBhIGZldyB0
byB3aGljaCBJDQo+IHJlc3BvbmRlZCBkaXJlY3RseSwgdGhlIHJlc3QgbG9vayBnb29kIHRvIG1l
Lg0KDQpUaGFua3MgYSBsb3QhIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoZXMuIEkgd2lsbCBwb3N0
IGEgVjMgYWRkcmVzc2luZyB5b3VyIGNvbW1lbnRzLg0KDQpSZWdhcmRzLA0KU2FpDQo=
