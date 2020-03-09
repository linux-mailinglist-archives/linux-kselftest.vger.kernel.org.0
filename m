Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69917EC4D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgCIWvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 18:51:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:2373 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgCIWvQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 18:51:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 15:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="235856561"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2020 15:51:15 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.192]) with mapi id 14.03.0439.000;
 Mon, 9 Mar 2020 15:51:14 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
Thread-Topic: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
Thread-Index: AQHV9DL72y2lBowYF0OswuZ3RsHuuahBROGA//+RIaCAAHyVgP//jqDA
Date:   Mon, 9 Mar 2020 22:51:14 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573084EC@ORSMSX114.amr.corp.intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
 <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
 <FFF73D592F13FD46B8700F0A279B802F57307F89@ORSMSX114.amr.corp.intel.com>
 <d0409729-b546-f0b9-4944-cbe5c9a74f76@intel.com>
In-Reply-To: <d0409729-b546-f0b9-4944-cbe5c9a74f76@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmVp
bmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXks
IE1hcmNoIDksIDIwMjAgMzozNCBQTQ0KDQpbU05JUF0NCg0KPiA+IFRoYXQncyBhIGdvb2QgcG9p
bnQgYW5kIG1ha2VzIHNlbnNlIHRvIG1lLiBJIHRoaW5rIHdlIGNvdWxkIGZpeCBpdCBpbg0KPiA+
IHR3byB3YXlzIDEuIGdyZXAgZm9yIHN0cmluZ3MgaW4gZG1lc2cgYnV0IHRoYXQgd2lsbCBzdGls
bCBsZWF2ZQ0KPiA+IGFtYmlndWl0eSBpbiBkZWNpZGluZyBiL3cgbWJtIGFuZCBjcW0gYmVjYXVz
ZSBrZXJuZWwgcHJpbnRzICJyZXNjdHJsOiBMMw0KPiBtb25pdG9yaW5nIGRldGVjdGVkIiBmb3Ig
Ym90aCB0aGUgZmVhdHVyZXMgMi4gQ2hlY2sgaW4gImluZm8iIGRpcmVjdG9yeQ0KPiA+IAlhLiBG
b3IgY2F0X2wzLCB3ZSBjb3VsZCBzZWFyY2ggZm9yIGluZm8vTDMNCj4gPiAJYi4gRm9yIG1iYSwg
d2UgY291bGQgc2VhcmNoIGZvciBpbmZvL01CDQo+ID4gCWMuIEZvciBjcW0gYW5kIG1ibSwgd2Ug
Y291bGQgc2VhcmNoIGZvciBzcGVjaWZpZWQgc3RyaW5nIGluDQo+ID4gaW5mby9MM19NT04vbW9u
X2ZlYXR1cmVzDQo+ID4NCj4gPiBJIHRoaW5rIG9wdGlvbiAyIG1pZ2h0IGJlIGJldHRlciBiZWNh
dXNlIGl0IGNhbiBoYW5kbGUgYWxsIGNhc2VzLCBwbGVhc2UgbGV0IG1lDQo+IGtub3cgd2hhdCB5
b3UgdGhpbmsuDQo+IA0KPiBJIGFncmVlLiBGb3IgdGhlIHJlYXNvbnMgeW91IG1lbnRpb24gYW5k
IGFsc28gdGhhdCAoMSkgbWF5IG5vdCBiZSBwb3NzaWJsZSBpZiB0aGUNCj4gbG9nbGV2ZWwgcHJl
dmVudHMgdGhvc2UgbGluZXMgZnJvbSBiZWluZyBwcmludGVkLg0KDQpNYWtlcyBzZW5zZS4gSSB3
aWxsIHdvcmsgb24gdGhlIGZpeC4NCg0KUmVnYXJkcywNClNhaQ0K
