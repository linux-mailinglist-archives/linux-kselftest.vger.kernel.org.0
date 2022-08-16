Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6095955BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHPJCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiHPJBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 05:01:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D617052;
        Tue, 16 Aug 2022 00:12:35 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6Mfk4mGxz67QMh;
        Tue, 16 Aug 2022 15:07:42 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 09:12:32 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 16 Aug 2022 09:12:32 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 0/9] bpf: Add kfuncs for PKCS#7 signature verification
Thread-Topic: [PATCH v11 0/9] bpf: Add kfuncs for PKCS#7 signature
 verification
Thread-Index: AQHYrjUQ7TU+Vo0VRkmtop3PBwuR+62wBRIAgAEczrA=
Date:   Tue, 16 Aug 2022 07:12:32 +0000
Message-ID: <b61eb3b95843409eb6ab03aea4a0ca30@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
 <14032690-e7a9-9d14-1ec1-14dd3503037c@iogearbox.net>
In-Reply-To: <14032690-e7a9-9d14-1ec1-14dd3503037c@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQm9ya21hbm4gW21haWx0bzpkYW5pZWxAaW9nZWFyYm94Lm5ldF0NCj4g
U2VudDogTW9uZGF5LCBBdWd1c3QgMTUsIDIwMjIgNjoxMCBQTQ0KPiBPbiA4LzEyLzIyIDEyOjE4
IFBNLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+IE9uZSBvZiB0aGUgZGVzaXJhYmxlIGZlYXR1
cmVzIGluIHNlY3VyaXR5IGlzIHRoZSBhYmlsaXR5IHRvIHJlc3RyaWN0IGltcG9ydA0KPiA+IG9m
IGRhdGEgdG8gYSBnaXZlbiBzeXN0ZW0gYmFzZWQgb24gZGF0YSBhdXRoZW50aWNpdHkuIElmIGRh
dGEgaW1wb3J0IGNhbiBiZQ0KPiA+IHJlc3RyaWN0ZWQsIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRv
IGVuZm9yY2UgYSBzeXN0ZW0td2lkZSBwb2xpY3kgYmFzZWQgb24NCj4gPiB0aGUgc2lnbmluZyBr
ZXlzIHRoZSBzeXN0ZW0gb3duZXIgdHJ1c3RzLg0KPiA+DQo+IFsuLi5dDQo+ID4gQ2hhbmdlbG9n
DQo+ID4NCj4gPiB2MTA6DQo+ID4gICAtIEludHJvZHVjZSBrZXlfbG9va3VwX2ZsYWdzX2NoZWNr
KCkgYW5kIHN5c3RlbV9rZXlyaW5nX2lkX2NoZWNrKCkgaW5saW5lDQo+ID4gICAgIGZ1bmN0aW9u
cyB0byBjaGVjayBwYXJhbWV0ZXJzIChzdWdnZXN0ZWQgYnkgS1ApDQo+ID4gICAtIEZpeCBkZXNj
cmlwdGlvbnMgYW5kIGNvbW1lbnQgb2Yga2V5LXJlbGF0ZWQga2Z1bmNzIChzdWdnZXN0ZWQgYnkg
S1ApDQo+ID4gICAtIFJlZ2lzdGVyIGtmdW5jIHNldCBvbmx5IG9uY2UgKHN1Z2dlc3RlZCBieSBB
bGV4ZWkpDQo+ID4gICAtIE1vdmUgbmVlZGVkIGtlcm5lbCBvcHRpb25zIHRvIHRoZSBhcmNoaXRl
Y3R1cmUtaW5kZXBlbmRlbnQgY29uZmlndXJhdGlvbg0KPiA+ICAgICBmb3IgdGVzdGluZw0KPiAN
Cj4gTG9va3MgbGlrZSBmcm9tIEJQRiBDSSBzaWRlLCB0aGUgc2VsZnRlc3QgdGhyb3dzIGEgV0FS
TiBpbiB0ZXN0X3Byb2dzIC8NCj4gdGVzdF9wcm9ncy1ub19hbHUzMg0KPiBhbmQgc3Vic2VxdWVu
dGx5IGZhaWxzIHdpdGggZXJyb3IsIHB0YWw6DQo+IA0KPiAgICBodHRwczovL2dpdGh1Yi5jb20v
a2VybmVsLQ0KPiBwYXRjaGVzL2JwZi9ydW5zLzc4MDQ0MjIwMzg/Y2hlY2tfc3VpdGVfZm9jdXM9
dHJ1ZQ0KDQpIaSBEYW5pZWwNCg0KaXQgaXMgZHVlIHRvIHRoZSBtaXNzaW5nIFNIQTI1NiBrZXJu
ZWwgbW9kdWxlIChub3QgY29waWVkIHRvDQp0aGUgdmlydHVhbCBtYWNoaW5lKS4NCg0KSSBtYWRl
IGEgc21hbGwgcGF0Y2ggaW4gbGliYnBmL2NpIHRvIGNoYW5nZSBrZXJuZWwgb3B0aW9ucyA9bQ0K
aW50byA9eS4gV2l0aCB0aGF0IHBhdGNoLCBteSBpbnN0YW5jZSBvZiB2bXRlc3QgZ2l2ZXMgc3Vj
Y2Vzcw0KKGV4Y2VwdCBmb3IgejE1LCB3aGljaCByZXF1aXJlcyBhZGRpbmcgb3BlbnNzbCBhbmQg
a2V5Y3RsDQp0byB0aGUgdmlydHVhbCBtYWNoaW5lIGltYWdlKS4NCg0KUm9iZXJ0bw0KDQo+ICAg
IFsuLi5dDQo+ICAgICMyMzUgICAgIHZlcmlmX3NjYWxlX3hkcF9sb29wOk9LDQo+ICAgICMyMzYg
ICAgIHZlcmlmX3N0YXRzOk9LDQo+ICAgICMyMzcgICAgIHZlcmlmX3R3Znc6T0sNCj4gICAgWyAg
NzYwLjQ0ODY1Ml0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ICAgIFsg
IDc2MC40NDk1MDZdIFdBUk5JTkc6IENQVTogMyBQSUQ6IDkzMCBhdCBjcnlwdG8vcnNhLXBrY3Mx
cGFkLmM6NTQ0DQo+IHBrY3MxcGFkX3ZlcmlmeSsweDE4NC8weDE5MA0KPiAgICBbICA3NjAuNDUw
ODA2XSBNb2R1bGVzIGxpbmtlZCBpbjogYnBmX3Rlc3Rtb2QoT0UpIFtsYXN0IHVubG9hZGVkOg0K
PiBicGZfdGVzdG1vZF0NCj4gICAgWyAgNzYwLjQ1MjM0MF0gQ1BVOiAzIFBJRDogOTMwIENvbW06
IGtleWN0bCBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgIDUuMTkuMC0NCj4gZzlmMDI2MDMz
OGUzMS1kaXJ0eSAjMQ0KPiAgICBbICA3NjAuNDUzNjI2XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUw0KPiAxLjEzLjAtMXVidW50dTEu
MSAwNC8wMS8yMDE0DQo+ICAgIFsgIDc2MC40NTQ4MDFdIFJJUDogMDAxMDpwa2NzMXBhZF92ZXJp
ZnkrMHgxODQvMHgxOTANCj4gICAgWyAgNzYwLjQ1NTM4MF0gQ29kZTogNWMgNDEgNWQgNDEgNWUg
NDEgNWYgNWQgYzMgY2MgY2MgY2MgY2MgNDggODkgZGYgODkgYzYgNWIgNDENCj4gNWMgNDEgNWQg
NDEgNWUgNDEgNWYgNWQgZTkgYTUgMDQgMDAgMDAgMGYgMGIgYjggZWEgZmYgZmYgZmYgZWIgZDQg
PDBmPiAwYiBiOCBlYSBmZg0KPiBmZiBmZiBlYiBjYiAwZiAwYiA5MCAwZiAxZiA0NCAwMCAwMCA1
MyA0OCA4OSBmYiBjNw0KPiAgICBbICA3NjAuNDU2ODY2XSBSU1A6IDAwMTg6ZmZmZmFkNTU0Nzhk
YmI1OCBFRkxBR1M6IDAwMDAwMjQ2DQo+ICAgIFsgIDc2MC40NTc2ODRdIFJBWDogZmZmZjliM2M0
M2M0MjQ1OCBSQlg6IGZmZmY5YjNjNDg5NzViMDAgUkNYOg0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+
ICAgIFsgIDc2MC40NTg2NzJdIFJEWDogZmZmZmZmZmZhNzI3NzQzOCBSU0k6IGZmZmZmZmZmYTUy
NzU1MTAgUkRJOg0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAgIFsgIDc2MC40NTk2NzBdIFJCUDog
ZmZmZmFkNTU0NzhkYmNmOCBSMDg6IDAwMDAwMDAwMDAwMDAwMDIgUjA5Og0KPiAwMDAwMDAwMDAw
MDAwMDAwDQo+ICAgIFsgIDc2MC40NjA2ODhdIFIxMDogZmZmZmFkNTU0NzhkYmMyMCBSMTE6IGZm
ZmZmZmZmYTQ0ZGRlMTAgUjEyOg0KPiBmZmZmOWIzYzQzZGUyZTgwDQo+ICAgIFsgIDc2MC40NjE2
OTVdIFIxMzogZmZmZjliM2M1ODQ1OWVhMCBSMTQ6IGZmZmY5YjNjNDRkNTk2MDAgUjE1Og0KPiBm
ZmZmYWQ1NTQ3OGRiYzIwDQo+ICAgIFsgIDc2MC40NjIyNzBdIEZTOiAgMDAwMDdmZjFlZTBlYjc0
MCgwMDAwKSBHUzpmZmZmOWIzY2Y5Y2MwMDAwKDAwMDApDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAw
MDANCj4gICAgWyAgNzYwLjQ2MjcyMl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMw0KPiAgICBbICA3NjAuNDYzMDI2XSBDUjI6IDAwMDA1NWI5YTRjMTc1
ODggQ1IzOiAwMDAwMDAwMTA3YmIyMDAwIENSNDoNCj4gMDAwMDAwMDAwMDAwMDZlMA0KPiAgICBb
ICA3NjAuNDY0MDM5XSBDYWxsIFRyYWNlOg0KPiAgICBbICA3NjAuNDY0NDY1XSAgPFRBU0s+DQo+
ICAgIFsgIDc2MC40NjQ3NDldICBwdWJsaWNfa2V5X3ZlcmlmeV9zaWduYXR1cmUrMHg0YTIvMHg1
NzANCj4gICAgWyAgNzYwLjQ2NTYyM10gIHg1MDlfY2hlY2tfZm9yX3NlbGZfc2lnbmVkKzB4NGUv
MHhkMA0KPiAgICBbICA3NjAuNDY1OTM3XSAgeDUwOV9jZXJ0X3BhcnNlKzB4MTkzLzB4MjIwDQo+
ICAgIFsgIDc2MC40NjY2NTZdICB4NTA5X2tleV9wcmVwYXJzZSsweDIwLzB4MWYwDQo+ICAgIFsg
IDc2MC40NjY5NzVdICBhc3ltbWV0cmljX2tleV9wcmVwYXJzZSsweDQzLzB4ODANCj4gICAgWyAg
NzYwLjQ2NzU1Ml0gIGtleV9jcmVhdGVfb3JfdXBkYXRlKzB4MjRlLzB4NTEwDQo+ICAgIFsgIDc2
MC40NjgzNjZdICBfX3g2NF9zeXNfYWRkX2tleSsweDE5Yi8weDIyMA0KPiAgICBbICA3NjAuNDY4
NzA0XSAgPyBzeXNjYWxsX2VudGVyX2Zyb21fdXNlcl9tb2RlKzB4MjQvMHgxZjANCj4gICAgWyAg
NzYwLjQ2OTA1Nl0gIGRvX3N5c2NhbGxfNjQrMHg0My8weDkwDQo+ICAgIFsgIDc2MC40Njk2NTdd
ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkDQo+ICAgIFsgIDc2MC40
NzA0MTNdIFJJUDogMDAzMzoweDdmZjFlZGYwYmE5ZA0KPiAgICBbICA3NjAuNDcwODMyXSBDb2Rl
OiA1YiA0MSA1YyBjMyA2NiAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBmMyAwZiAxZSBmYSA0OCA4
OSBmOA0KPiA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4
YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmDQo+IGZmIDczIDAxIGMzIDQ4IDhiIDBk
IGNiIGUyIDBlIDAwIGY3IGQ4IDY0IDg5IDAxIDQ4DQo+ICAgIFsgIDc2MC40NzI3NDJdIFJTUDog
MDAyYjowMDAwN2ZmZTYzNWU3YTE4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6DQo+IDAwMDAw
MDAwMDAwMDAwZjgNCj4gICAgWyAgNzYwLjQ3MzM1NV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJC
WDogMDAwMDdmZmU2MzVlN2JlMCBSQ1g6DQo+IDAwMDA3ZmYxZWRmMGJhOWQNCj4gICAgWyAgNzYw
LjQ3NDUyM10gUkRYOiAwMDAwNTU5ODJmZWQ4MGMwIFJTSTogMDAwMDdmZmU2MzVlN2YxNyBSREk6
DQo+IDAwMDA3ZmZlNjM1ZTdmMGMNCj4gICAgWyAgNzYwLjQ3NTUwMF0gUkJQOiAwMDAwN2ZmZTYz
NWU3YTM4IFIwODogMDAwMDAwMDBmZmZmZmZmZCBSMDk6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4g
ICAgWyAgNzYwLjQ3NTkxM10gUjEwOiAwMDAwMDAwMDAwMDAwMzU1IFIxMTogMDAwMDAwMDAwMDAw
MDI0NiBSMTI6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gICAgWyAgNzYwLjQ3NjU5NF0gUjEzOiAw
MDAwN2ZmZTYzNWU3YmQ4IFIxNDogMDAwMDU1OTgyZmVkNDhhZSBSMTU6DQo+IDAwMDA1NTk4MmZl
ZDc2ZTgNCj4gICAgWyAgNzYwLjQ3NzU3OV0gIDwvVEFTSz4NCj4gICAgWyAgNzYwLjQ3Nzc2OV0g
aXJxIGV2ZW50IHN0YW1wOiA0NzI3DQo+ICAgIFsgIDc2MC40Nzc5NjNdIGhhcmRpcnFzIGxhc3Qg
IGVuYWJsZWQgYXQgKDQ3MzUpOiBbPGZmZmZmZmZmYTQxMDFkZjU+XQ0KPiBfX3VwX2NvbnNvbGVf
c2VtKzB4NzUvMHhhMA0KPiAgICBbICA3NjAuNDc5MDM2XSBoYXJkaXJxcyBsYXN0IGRpc2FibGVk
IGF0ICg0NzQ0KTogWzxmZmZmZmZmZmE0YTMxY2NhPl0NCj4gc3lzdmVjX2FwaWNfdGltZXJfaW50
ZXJydXB0KzB4YS8weGIwDQo+ICAgIFsgIDc2MC40ODA0MDNdIHNvZnRpcnFzIGxhc3QgIGVuYWJs
ZWQgYXQgKDQ3NjIpOiBbPGZmZmZmZmZmYTQwODUxNzI+XQ0KPiBfX2lycV9leGl0X3JjdSsweGIy
LzB4MTQwDQo+ICAgIFsgIDc2MC40ODA4NjldIHNvZnRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDQ3
NTUpOiBbPGZmZmZmZmZmYTQwODUxNzI+XQ0KPiBfX2lycV9leGl0X3JjdSsweGIyLzB4MTQwDQo+
ICAgIFsgIDc2MC40ODE3MDZdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0K
PiAgICBHZW5lcmF0aW5nIGEgUlNBIHByaXZhdGUga2V5DQo+ICAgIC4rKysrKw0KPiAgICAuLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLisrKysrDQo+ICAg
IHdyaXRpbmcgbmV3IHByaXZhdGUga2V5IHRvICcvdG1wL3ZlcmlmeV9zaWdYZE9MNVYvc2lnbmlu
Z19rZXkucGVtJw0KPiAgICAtLS0tLQ0KPiAgICBhZGRfa2V5OiBJbnZhbGlkIGFyZ3VtZW50DQo+
ICAgIHRlc3RfdmVyaWZ5X3BrY3M3X3NpZzpQQVNTOm1rZHRlbXAgMCBuc2VjDQo+ICAgIHRlc3Rf
dmVyaWZ5X3BrY3M3X3NpZzpGQUlMOl9ydW5fc2V0dXBfcHJvY2VzcyB1bmV4cGVjdGVkIGVycm9y
OiAxIChlcnJubw0KPiAxMjYpDQo+ICAgICMyMzggICAgIHZlcmlmeV9wa2NzN19zaWc6RkFJTA0K
PiAgICAjMjM5ICAgICB2bWxpbnV4Ok9LDQo+ICAgICMyNDAgICAgIHhkcDpPSw0KPiAgICAjMjQx
LzEgICB4ZHBfYWRqdXN0X2ZyYWdzL3hkcF9hZGp1c3RfZnJhZ3M6T0sNCj4gICAgIzI0MSAgICAg
eGRwX2FkanVzdF9mcmFnczpPSw0KPiAgICAjMjQyLzEgICB4ZHBfYWRqdXN0X3RhaWwveGRwX2Fk
anVzdF90YWlsX3NocmluazpPSw0KPiAgICAjMjQyLzIgICB4ZHBfYWRqdXN0X3RhaWwveGRwX2Fk
anVzdF90YWlsX2dyb3c6T0sNCj4gICAgWy4uLl0NCg==
