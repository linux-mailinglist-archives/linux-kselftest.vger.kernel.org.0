Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90D595B94
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiHPMSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiHPMSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 08:18:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081E60E4;
        Tue, 16 Aug 2022 05:15:32 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6VTd3t89z67W0D;
        Tue, 16 Aug 2022 20:15:17 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 14:15:29 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 16 Aug 2022 14:15:29 +0200
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
Thread-Index: AQHYrjUQ7TU+Vo0VRkmtop3PBwuR+62wBRIAgAEczrCAAA+CAIAAREcg
Date:   Tue, 16 Aug 2022 12:15:29 +0000
Message-ID: <f54e27659dce49ee93d5feafa46f5477@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
 <14032690-e7a9-9d14-1ec1-14dd3503037c@iogearbox.net>
 <b61eb3b95843409eb6ab03aea4a0ca30@huawei.com>
 <be1fdbba-73ba-3106-622e-57ef5f471a26@iogearbox.net>
In-Reply-To: <be1fdbba-73ba-3106-622e-57ef5f471a26@iogearbox.net>
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
U2VudDogVHVlc2RheSwgQXVndXN0IDE2LCAyMDIyIDEyOjA1IFBNDQo+IE9uIDgvMTYvMjIgOTox
MiBBTSwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPj4gRnJvbTogRGFuaWVsIEJvcmttYW5uIFtt
YWlsdG86ZGFuaWVsQGlvZ2VhcmJveC5uZXRdDQo+ID4+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDE1
LCAyMDIyIDY6MTAgUE0NCj4gPj4gT24gOC8xMi8yMiAxMjoxOCBQTSwgUm9iZXJ0byBTYXNzdSB3
cm90ZToNCj4gPj4+IE9uZSBvZiB0aGUgZGVzaXJhYmxlIGZlYXR1cmVzIGluIHNlY3VyaXR5IGlz
IHRoZSBhYmlsaXR5IHRvIHJlc3RyaWN0IGltcG9ydA0KPiA+Pj4gb2YgZGF0YSB0byBhIGdpdmVu
IHN5c3RlbSBiYXNlZCBvbiBkYXRhIGF1dGhlbnRpY2l0eS4gSWYgZGF0YSBpbXBvcnQgY2FuIGJl
DQo+ID4+PiByZXN0cmljdGVkLCBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBlbmZvcmNlIGEgc3lz
dGVtLXdpZGUgcG9saWN5IGJhc2VkIG9uDQo+ID4+PiB0aGUgc2lnbmluZyBrZXlzIHRoZSBzeXN0
ZW0gb3duZXIgdHJ1c3RzLg0KPiA+Pj4NCj4gPj4gWy4uLl0NCj4gPj4+IENoYW5nZWxvZw0KPiA+
Pj4NCj4gPj4+IHYxMDoNCj4gPj4+ICAgIC0gSW50cm9kdWNlIGtleV9sb29rdXBfZmxhZ3NfY2hl
Y2soKSBhbmQgc3lzdGVtX2tleXJpbmdfaWRfY2hlY2soKQ0KPiBpbmxpbmUNCj4gPj4+ICAgICAg
ZnVuY3Rpb25zIHRvIGNoZWNrIHBhcmFtZXRlcnMgKHN1Z2dlc3RlZCBieSBLUCkNCj4gPj4+ICAg
IC0gRml4IGRlc2NyaXB0aW9ucyBhbmQgY29tbWVudCBvZiBrZXktcmVsYXRlZCBrZnVuY3MgKHN1
Z2dlc3RlZCBieSBLUCkNCj4gPj4+ICAgIC0gUmVnaXN0ZXIga2Z1bmMgc2V0IG9ubHkgb25jZSAo
c3VnZ2VzdGVkIGJ5IEFsZXhlaSkNCj4gPj4+ICAgIC0gTW92ZSBuZWVkZWQga2VybmVsIG9wdGlv
bnMgdG8gdGhlIGFyY2hpdGVjdHVyZS1pbmRlcGVuZGVudA0KPiBjb25maWd1cmF0aW9uDQo+ID4+
PiAgICAgIGZvciB0ZXN0aW5nDQo+ID4+DQo+ID4+IExvb2tzIGxpa2UgZnJvbSBCUEYgQ0kgc2lk
ZSwgdGhlIHNlbGZ0ZXN0IHRocm93cyBhIFdBUk4gaW4gdGVzdF9wcm9ncyAvDQo+ID4+IHRlc3Rf
cHJvZ3Mtbm9fYWx1MzINCj4gPj4gYW5kIHN1YnNlcXVlbnRseSBmYWlscyB3aXRoIGVycm9yLCBw
dGFsOg0KPiA+Pg0KPiA+PiAgICAgaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC0NCj4gPj4gcGF0
Y2hlcy9icGYvcnVucy83ODA0NDIyMDM4P2NoZWNrX3N1aXRlX2ZvY3VzPXRydWUNCj4gPg0KPiA+
IGl0IGlzIGR1ZSB0byB0aGUgbWlzc2luZyBTSEEyNTYga2VybmVsIG1vZHVsZSAobm90IGNvcGll
ZCB0bw0KPiA+IHRoZSB2aXJ0dWFsIG1hY2hpbmUpLg0KPiA+DQo+ID4gSSBtYWRlIGEgc21hbGwg
cGF0Y2ggaW4gbGliYnBmL2NpIHRvIGNoYW5nZSBrZXJuZWwgb3B0aW9ucyA9bQ0KPiA+IGludG8g
PXkuIFdpdGggdGhhdCBwYXRjaCwgbXkgaW5zdGFuY2Ugb2Ygdm10ZXN0IGdpdmVzIHN1Y2Nlc3MN
Cj4gPiAoZXhjZXB0IGZvciB6MTUsIHdoaWNoIHJlcXVpcmVzIGFkZGluZyBvcGVuc3NsIGFuZCBr
ZXljdGwNCj4gPiB0byB0aGUgdmlydHVhbCBtYWNoaW5lIGltYWdlKS4NCj4gDQo+IFRoZSBjb2Rl
IGluIHBrY3MxcGFkX3ZlcmlmeSgpIHRyaWdnZXJpbmcgdGhlIHdhcm5pbmcgaXM6DQo+IA0KPiAg
ICAgIFsuLi5dDQo+ICAgICAgICAgIGlmIChXQVJOX09OKHJlcS0+ZHN0KSB8fCBXQVJOX09OKCFk
aWdlc3Rfc2l6ZSkgfHwNCj4gICAgICAgICAgICAgICFjdHgtPmtleV9zaXplIHx8IHNpZ19zaXpl
ICE9IGN0eC0+a2V5X3NpemUpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ICAgICAgWy4uLl0NCj4gDQo+IEl0IGlzIG5vdCBvYnZpb3VzIGF0IGFsbCB0byB1c2VycyB0aGF0
IHNoYTI1NiBtb2R1bGUgaXMgbWlzc2luZyBpbiB0aGVpciBrZXJuZWwsDQo+IGhvdyB3aWxsIHRo
ZXkgYmUgYWJsZSB0byBmaWd1cmUgaXQgb3V0Pw0KDQpZZXMsIGl0IHdhcyBub3QgdHJpdmlhbCB0
byBmaW5kLg0KDQo+IFNob3VsZCB0aGUgaGVscGVyIGJlIGdhdGVkIGlmIGRlcGVuZGVuY3kgaXMg
bm90IGF2YWlsYWJsZSwgb3IgcmV0dXJuIGEgLQ0KPiBFT1BOT1RTVVBQDQo+IGlmIHRoZSBzcGVj
aWZpYyByZXF1ZXN0IGNhbm5vdCBiZSBzYXRpc2ZpZWQgKGJ1dCBvdGhlcnMgY2FuLi4pPw0KDQpV
aG0sIHRoZSBmYWlsdXJlIGlzIG5vdCByZWxhdGVkIHRvIHRoZSBrZnVuY3MgSSBpbnRyb2R1Y2Vk
LiBUaGUgYWRkX2tleSgpDQpzeXN0ZW0gY2FsbCBmYWlsZWQuDQoNCkFsc28sIGl0IHNlZW1zIG5v
dCBlYXN5IHRvIGRldGVybWluZSBpZiBkZXBlbmRlbmNpZXMgYXJlIHNhdGlzZmllZC4NCklmIFNI
QTUxMiBpcyBzdXBwb3J0ZWQsIHRoYXQgbWlnaHQgYmUgc3VmZmljaWVudC4gSXQgZGVwZW5kcyBv
biBob3cNCnRoZSBjZXJ0aWZpY2F0ZSBpcyBnZW5lcmF0ZWQuDQoNCldoYXQgaXMgeW91ciBvcGlu
aW9uIG9uIHRoZSBzb2x1dGlvbiwgY2hhbmdlIGFsbCBjb25maWcgb3B0aW9ucw0KdG8gPXksIG9y
IHVzZSBzZWQgbGlrZSBJIGRpZD8NCg0KVGhhbmtzDQoNClJvYmVydG8NCg0KPiA+PiAgICAgWy4u
Ll0NCj4gPj4gICAgICMyMzUgICAgIHZlcmlmX3NjYWxlX3hkcF9sb29wOk9LDQo+ID4+ICAgICAj
MjM2ICAgICB2ZXJpZl9zdGF0czpPSw0KPiA+PiAgICAgIzIzNyAgICAgdmVyaWZfdHdmdzpPSw0K
PiA+PiAgICAgWyAgNzYwLjQ0ODY1Ml0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0t
LS0tDQo+ID4+ICAgICBbICA3NjAuNDQ5NTA2XSBXQVJOSU5HOiBDUFU6IDMgUElEOiA5MzAgYXQg
Y3J5cHRvL3JzYS1wa2NzMXBhZC5jOjU0NA0KPiA+PiBwa2NzMXBhZF92ZXJpZnkrMHgxODQvMHgx
OTANCj4gPj4gICAgIFsgIDc2MC40NTA4MDZdIE1vZHVsZXMgbGlua2VkIGluOiBicGZfdGVzdG1v
ZChPRSkgW2xhc3QgdW5sb2FkZWQ6DQo+ID4+IGJwZl90ZXN0bW9kXQ0KPiA+PiAgICAgWyAgNzYw
LjQ1MjM0MF0gQ1BVOiAzIFBJRDogOTMwIENvbW06IGtleWN0bCBUYWludGVkOiBHICAgICAgICAg
ICBPRSAgICAgIDUuMTkuMC0NCj4gPj4gZzlmMDI2MDMzOGUzMS1kaXJ0eSAjMQ0KPiA+PiAgICAg
WyAgNzYwLjQ1MzYyNl0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsg
UElJWCwgMTk5NiksDQo+IEJJT1MNCj4gPj4gMS4xMy4wLTF1YnVudHUxLjEgMDQvMDEvMjAxNA0K
PiA+PiAgICAgWyAgNzYwLjQ1NDgwMV0gUklQOiAwMDEwOnBrY3MxcGFkX3ZlcmlmeSsweDE4NC8w
eDE5MA0KPiA+PiAgICAgWyAgNzYwLjQ1NTM4MF0gQ29kZTogNWMgNDEgNWQgNDEgNWUgNDEgNWYg
NWQgYzMgY2MgY2MgY2MgY2MgNDggODkgZGYgODkgYzYNCj4gNWIgNDENCj4gPj4gNWMgNDEgNWQg
NDEgNWUgNDEgNWYgNWQgZTkgYTUgMDQgMDAgMDAgMGYgMGIgYjggZWEgZmYgZmYgZmYgZWIgZDQg
PDBmPiAwYiBiOCBlYQ0KPiBmZg0KPiA+PiBmZiBmZiBlYiBjYiAwZiAwYiA5MCAwZiAxZiA0NCAw
MCAwMCA1MyA0OCA4OSBmYiBjNw0KPiA+PiAgICAgWyAgNzYwLjQ1Njg2Nl0gUlNQOiAwMDE4OmZm
ZmZhZDU1NDc4ZGJiNTggRUZMQUdTOiAwMDAwMDI0Ng0KPiA+PiAgICAgWyAgNzYwLjQ1NzY4NF0g
UkFYOiBmZmZmOWIzYzQzYzQyNDU4IFJCWDogZmZmZjliM2M0ODk3NWIwMCBSQ1g6DQo+ID4+IDAw
MDAwMDAwMDAwMDAwMDANCj4gPj4gICAgIFsgIDc2MC40NTg2NzJdIFJEWDogZmZmZmZmZmZhNzI3
NzQzOCBSU0k6IGZmZmZmZmZmYTUyNzU1MTAgUkRJOg0KPiA+PiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4+ICAgICBbICA3NjAuNDU5NjcwXSBSQlA6IGZmZmZhZDU1NDc4ZGJjZjggUjA4OiAwMDAwMDAw
MDAwMDAwMDAyIFIwOToNCj4gPj4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+PiAgICAgWyAgNzYwLjQ2
MDY4OF0gUjEwOiBmZmZmYWQ1NTQ3OGRiYzIwIFIxMTogZmZmZmZmZmZhNDRkZGUxMCBSMTI6DQo+
ID4+IGZmZmY5YjNjNDNkZTJlODANCj4gPj4gICAgIFsgIDc2MC40NjE2OTVdIFIxMzogZmZmZjli
M2M1ODQ1OWVhMCBSMTQ6IGZmZmY5YjNjNDRkNTk2MDAgUjE1Og0KPiA+PiBmZmZmYWQ1NTQ3OGRi
YzIwDQo+ID4+ICAgICBbICA3NjAuNDYyMjcwXSBGUzogIDAwMDA3ZmYxZWUwZWI3NDAoMDAwMCkg
R1M6ZmZmZjliM2NmOWNjMDAwMCgwMDAwKQ0KPiA+PiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+
ID4+ICAgICBbICA3NjAuNDYyNzIyXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQo+ID4+ICAgICBbICA3NjAuNDYzMDI2XSBDUjI6IDAwMDA1NWI5YTRj
MTc1ODggQ1IzOiAwMDAwMDAwMTA3YmIyMDAwIENSNDoNCj4gPj4gMDAwMDAwMDAwMDAwMDZlMA0K
PiA+PiAgICAgWyAgNzYwLjQ2NDAzOV0gQ2FsbCBUcmFjZToNCj4gPj4gICAgIFsgIDc2MC40NjQ0
NjVdICA8VEFTSz4NCj4gPj4gICAgIFsgIDc2MC40NjQ3NDldICBwdWJsaWNfa2V5X3ZlcmlmeV9z
aWduYXR1cmUrMHg0YTIvMHg1NzANCj4gPj4gICAgIFsgIDc2MC40NjU2MjNdICB4NTA5X2NoZWNr
X2Zvcl9zZWxmX3NpZ25lZCsweDRlLzB4ZDANCj4gPj4gICAgIFsgIDc2MC40NjU5MzddICB4NTA5
X2NlcnRfcGFyc2UrMHgxOTMvMHgyMjANCj4gPj4gICAgIFsgIDc2MC40NjY2NTZdICB4NTA5X2tl
eV9wcmVwYXJzZSsweDIwLzB4MWYwDQo+ID4+ICAgICBbICA3NjAuNDY2OTc1XSAgYXN5bW1ldHJp
Y19rZXlfcHJlcGFyc2UrMHg0My8weDgwDQo+ID4+ICAgICBbICA3NjAuNDY3NTUyXSAga2V5X2Ny
ZWF0ZV9vcl91cGRhdGUrMHgyNGUvMHg1MTANCj4gPj4gICAgIFsgIDc2MC40NjgzNjZdICBfX3g2
NF9zeXNfYWRkX2tleSsweDE5Yi8weDIyMA0KPiA+PiAgICAgWyAgNzYwLjQ2ODcwNF0gID8gc3lz
Y2FsbF9lbnRlcl9mcm9tX3VzZXJfbW9kZSsweDI0LzB4MWYwDQo+ID4+ICAgICBbICA3NjAuNDY5
MDU2XSAgZG9fc3lzY2FsbF82NCsweDQzLzB4OTANCj4gPj4gICAgIFsgIDc2MC40Njk2NTddICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkDQo+ID4+ICAgICBbICA3NjAu
NDcwNDEzXSBSSVA6IDAwMzM6MHg3ZmYxZWRmMGJhOWQNCj4gPj4gICAgIFsgIDc2MC40NzA4MzJd
IENvZGU6IDViIDQxIDVjIGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIGYzIDBmIDFlIGZh
IDQ4DQo+IDg5IGY4DQo+ID4+IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRk
IDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDENCj4gZjAgZmYNCj4gPj4gZmYg
NzMgMDEgYzMgNDggOGIgMGQgY2IgZTIgMGUgMDAgZjcgZDggNjQgODkgMDEgNDgNCj4gPj4gICAg
IFsgIDc2MC40NzI3NDJdIFJTUDogMDAyYjowMDAwN2ZmZTYzNWU3YTE4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6DQo+ID4+IDAwMDAwMDAwMDAwMDAwZjgNCj4gPj4gICAgIFsgIDc2MC40NzMz
NTVdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZmZlNjM1ZTdiZTAgUkNYOg0KPiA+
PiAwMDAwN2ZmMWVkZjBiYTlkDQo+ID4+ICAgICBbICA3NjAuNDc0NTIzXSBSRFg6IDAwMDA1NTk4
MmZlZDgwYzAgUlNJOiAwMDAwN2ZmZTYzNWU3ZjE3IFJESToNCj4gPj4gMDAwMDdmZmU2MzVlN2Yw
Yw0KPiA+PiAgICAgWyAgNzYwLjQ3NTUwMF0gUkJQOiAwMDAwN2ZmZTYzNWU3YTM4IFIwODogMDAw
MDAwMDBmZmZmZmZmZCBSMDk6DQo+ID4+IDAwMDAwMDAwMDAwMDAwMDANCj4gPj4gICAgIFsgIDc2
MC40NzU5MTNdIFIxMDogMDAwMDAwMDAwMDAwMDM1NSBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEy
Og0KPiA+PiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4+ICAgICBbICA3NjAuNDc2NTk0XSBSMTM6IDAw
MDA3ZmZlNjM1ZTdiZDggUjE0OiAwMDAwNTU5ODJmZWQ0OGFlIFIxNToNCj4gPj4gMDAwMDU1OTgy
ZmVkNzZlOA0KPiA+PiAgICAgWyAgNzYwLjQ3NzU3OV0gIDwvVEFTSz4NCj4gPj4gICAgIFsgIDc2
MC40Nzc3NjldIGlycSBldmVudCBzdGFtcDogNDcyNw0KPiA+PiAgICAgWyAgNzYwLjQ3Nzk2M10g
aGFyZGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoNDczNSk6IFs8ZmZmZmZmZmZhNDEwMWRmNT5dDQo+
ID4+IF9fdXBfY29uc29sZV9zZW0rMHg3NS8weGEwDQo+ID4+ICAgICBbICA3NjAuNDc5MDM2XSBo
YXJkaXJxcyBsYXN0IGRpc2FibGVkIGF0ICg0NzQ0KTogWzxmZmZmZmZmZmE0YTMxY2NhPl0NCj4g
Pj4gc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4YS8weGIwDQo+ID4+ICAgICBbICA3NjAu
NDgwNDAzXSBzb2Z0aXJxcyBsYXN0ICBlbmFibGVkIGF0ICg0NzYyKTogWzxmZmZmZmZmZmE0MDg1
MTcyPl0NCj4gPj4gX19pcnFfZXhpdF9yY3UrMHhiMi8weDE0MA0KPiA+PiAgICAgWyAgNzYwLjQ4
MDg2OV0gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNDc1NSk6IFs8ZmZmZmZmZmZhNDA4NTE3
Mj5dDQo+ID4+IF9faXJxX2V4aXRfcmN1KzB4YjIvMHgxNDANCj4gPj4gICAgIFsgIDc2MC40ODE3
MDZdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+PiAgICAgR2VuZXJh
dGluZyBhIFJTQSBwcml2YXRlIGtleQ0KPiA+PiAgICAgLisrKysrDQo+ID4+ICAgICAuLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLisrKysrDQo+ID4+ICAg
ICB3cml0aW5nIG5ldyBwcml2YXRlIGtleSB0byAnL3RtcC92ZXJpZnlfc2lnWGRPTDVWL3NpZ25p
bmdfa2V5LnBlbScNCj4gPj4gICAgIC0tLS0tDQo+ID4+ICAgICBhZGRfa2V5OiBJbnZhbGlkIGFy
Z3VtZW50DQo+ID4+ICAgICB0ZXN0X3ZlcmlmeV9wa2NzN19zaWc6UEFTUzpta2R0ZW1wIDAgbnNl
Yw0KPiA+PiAgICAgdGVzdF92ZXJpZnlfcGtjczdfc2lnOkZBSUw6X3J1bl9zZXR1cF9wcm9jZXNz
IHVuZXhwZWN0ZWQgZXJyb3I6IDEgKGVycm5vDQo+ID4+IDEyNikNCj4gPj4gICAgICMyMzggICAg
IHZlcmlmeV9wa2NzN19zaWc6RkFJTA0KPiA+PiAgICAgIzIzOSAgICAgdm1saW51eDpPSw0KPiA+
PiAgICAgIzI0MCAgICAgeGRwOk9LDQo+ID4+ICAgICAjMjQxLzEgICB4ZHBfYWRqdXN0X2ZyYWdz
L3hkcF9hZGp1c3RfZnJhZ3M6T0sNCj4gPj4gICAgICMyNDEgICAgIHhkcF9hZGp1c3RfZnJhZ3M6
T0sNCj4gPj4gICAgICMyNDIvMSAgIHhkcF9hZGp1c3RfdGFpbC94ZHBfYWRqdXN0X3RhaWxfc2hy
aW5rOk9LDQo+ID4+ICAgICAjMjQyLzIgICB4ZHBfYWRqdXN0X3RhaWwveGRwX2FkanVzdF90YWls
X2dyb3c6T0sNCj4gPj4gICAgIFsuLi5dDQoNCg==
