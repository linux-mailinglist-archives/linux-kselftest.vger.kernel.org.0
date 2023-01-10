Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE252663F50
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 12:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjAJLgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 06:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjAJLgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 06:36:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04473113A;
        Tue, 10 Jan 2023 03:36:03 -0800 (PST)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NrpXg50mcz6J91l;
        Tue, 10 Jan 2023 19:30:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 11:35:59 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.034;
 Tue, 10 Jan 2023 11:35:59 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Topic: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Index: AQHY8wv6WqOaN9m/WUKJgvcZCnpZkK454qzggAFgXgCAXKMbQA==
Date:   Tue, 10 Jan 2023 11:35:59 +0000
Message-ID: <36b0fdac061e4680b5966d2774f0026a@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
 <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
In-Reply-To: <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWkgTGl1IFttYWlsdG86
eWkubC5saXVAaW50ZWwuY29tXQ0KPiBTZW50OiAxMiBOb3ZlbWJlciAyMDIyIDEyOjQ1DQo+IFRv
OiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgYnBmQHZnZXIu
a2VybmVsLm9yZzsgSm9uYXRoYW4gQ29yYmV0DQo+IDxjb3JiZXRAbHduLm5ldD47IERhdmlkIFdv
b2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47DQo+IGlvbW11QGxpc3RzLmxpbnV4LmRldjsg
Sm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBLZXZpbiBUaWFuDQo+IDxrZXZpbi50aWFu
QGludGVsLmNvbT47IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtzZWxmdGVz
dEB2Z2VyLmtlcm5lbC5vcmc7IGxsdm1AbGlzdHMubGludXguZGV2OyBOYXRoYW4gQ2hhbmNlbGxv
cg0KPiA8bmF0aGFuQGtlcm5lbC5vcmc+OyBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNA
Z29vZ2xlLmNvbT47IE1pZ3VlbA0KPiBPamVkYSA8b2plZGFAa2VybmVsLm9yZz47IFJvYmluIE11
cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBTaHVhaA0KPiBLaGFuIDxzaHVhaEBrZXJuZWwu
b3JnPjsgU3VyYXZlZSBTdXRoaWt1bHBhbml0DQo+IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1k
LmNvbT47IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT47IFdpbGwNCj4gRGVhY29uIDx3aWxsQGtl
cm5lbC5vcmc+DQo+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQu
Y29tPjsgTHUgQmFvbHUNCj4gPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47IENoYWl0YW55YSBL
dWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPjsNCj4gQ29ybmVsaWEgSHVjayA8Y29odWNr
QHJlZGhhdC5jb20+OyBEYW5pZWwgSm9yZGFuDQo+IDxkYW5pZWwubS5qb3JkYW5Ab3JhY2xlLmNv
bT47IERhdmlkIEdpYnNvbg0KPiA8ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1PjsgRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgRXJpYw0KPiBGYXJtYW4gPGZhcm1hbkBsaW51
eC5pYm0uY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47DQo+IEplYW4tUGhp
bGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPjsgSm9hbyBNYXJ0aW5zDQo+
IDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsga3ZtQHZnZXIua2VybmVsLm9yZzsgTWF0dGhl
dyBSb3NhdG8NCj4gPG1qcm9zYXRvQGxpbnV4LmlibS5jb20+OyBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPjsgTmljb2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsg
TmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0uY29tPjsNCj4gemh1a2VxaWFuIDx6
aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvMTddIElP
TU1VRkQgR2VuZXJpYyBpbnRlcmZhY2UNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAyMDIy
LzExLzExIDIzOjUxLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFzb24gR3VudGhv
cnBlIFttYWlsdG86amdnQG52aWRpYS5jb21dDQo+ID4+IFNlbnQ6IDA4IE5vdmVtYmVyIDIwMjIg
MDA6NDkNCj4gPj4gVG86IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENvcmJldCA8Y29y
YmV0QGx3bi5uZXQ+OyBEYXZpZA0KPiA+PiBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IEpvZXJnDQo+IFJvZWRlbA0KPiA+PiA8am9yb0A4Ynl0
ZXMub3JnPjsgS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+Ow0KPiA+PiBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOw0KPiA+
PiBsbHZtQGxpc3RzLmxpbnV4LmRldjsgTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwu
b3JnPjsgTmljaw0KPiA+PiBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+OyBN
aWd1ZWwgT2plZGENCj4gPG9qZWRhQGtlcm5lbC5vcmc+Ow0KPiA+PiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPjsgU2h1YWggS2hhbg0KPiA8c2h1YWhAa2VybmVsLm9yZz47DQo+
ID4+IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+
OyBUb20gUml4DQo+ID4+IDx0cml4QHJlZGhhdC5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPg0KPiA+PiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbT47IEx1IEJhb2x1DQo+ID4+IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+OyBDaGFpdGFu
eWEgS3Vsa2FybmkNCj4gPGNoYWl0YW55YWtAbnZpZGlhLmNvbT47DQo+ID4+IENvcm5lbGlhIEh1
Y2sgPGNvaHVja0ByZWRoYXQuY29tPjsgRGFuaWVsIEpvcmRhbg0KPiA+PiA8ZGFuaWVsLm0uam9y
ZGFuQG9yYWNsZS5jb20+OyBEYXZpZCBHaWJzb24NCj4gPj4gPGRhdmlkQGdpYnNvbi5kcm9wYmVh
ci5pZC5hdT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47DQo+IEVyaWMNCj4g
Pj4gRmFybWFuIDxmYXJtYW5AbGludXguaWJtLmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Ow0KPiA+PiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZz47IEpvYW8gTWFydGlucw0KPiA+PiA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT47
IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IE1hdHRoZXcgUm9zYXRvDQo+ID4+IDxtanJvc2F0b0BsaW51
eC5pYm0uY29tPjsgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47DQo+IE5pY29s
aW4NCj4gPj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5pa2xhcyBTY2huZWxsZSA8c2No
bmVsbGVAbGludXguaWJtLmNvbT47DQo+ID4+IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNo
YW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IFlpDQo+ID4+IExpdSA8eWku
bC5saXVAaW50ZWwuY29tPjsgemh1a2VxaWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ID4+
IFN1YmplY3Q6IFtQQVRDSCB2NCAwMC8xN10gSU9NTVVGRCBHZW5lcmljIGludGVyZmFjZQ0KPiA+
IFsuLi5dDQo+ID4+DQo+ID4+IC0gVXNlcnNwYWNlIHBhZ2UgdGFibGVzIGFrYSAnbmVzdGVkIHRy
YW5zbGF0aW9uJyBmb3IgQVJNIGFuZCBJbnRlbCBpb21tdQ0KPiA+PiAgICBkcml2ZXJzOg0KPiA+
PiAgICBodHRwczovL2dpdGh1Yi5jb20vbmljb2xpbmMvaW9tbXVmZC9jb21taXRzL2lvbW11ZmRf
bmVzdGluZw0KPiA+DQo+ID4gSGkgRXJpYy9ZaS9OaWNvbGluLA0KPiA+DQo+ID4gQ291bGQgeW91
IHBsZWFzZSBwcm92aWRlIGEgbGF0ZXN0IEtlcm5lbC9RZW11IGJyYW5jaCBmb3IgdGhlIEFSTSBu
ZXN0aW5nDQo+IHN1cHBvcnQ/DQo+ID4gVGhlIGFib3ZlIGxpbmsgcG9pbnRzIHRvIFlpJ3MgZ2l0
LCBidXQgbm90IHN1cmUgd2hpY2ggb25lIGlzIGxhdGVzdC9zdGFibGUgdG8NCj4gPiBoYXZlIGEg
cGxheS4NCj4gDQo+IE5pY29saW4gYW5kIEkgYXJlIHdvcmtpbmcgb24gdGhlIG5ldyB2ZXJzaW9u
IGZvciBuZXN0aW5nIHN1cHBvcnQuIEJlbG93DQo+IGtlcm5sIGJyYW5jaCBpcyBvdXIgbGF0ZXN0
IHByb2dyZXNzIHNvIGZhci4gQXMgdGhlIG5hbWluZywgaXQncyBzdGlsbA0KPiB3aXAuIFdlIGFs
c28gbmVlZCB0byB3b3Jrb3V0IGEgUWVtdSB2ZXJzaW9uLCBzbyBzdGlsbCBuZWVkIHNvbWUgdGlt
ZQ0KPiBiZWZvcmUgc2hhcmluZyB3aXRoIHlvdS4NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS95
aWxpdTE3NjUvaW9tbXVmZC90cmVlL3dpcC9pb21tdWZkLXY2LjEtcmMzLW5lc3RpbmcNCg0KSGkg
WWksDQoNClRoYW5rcyBmb3IgdGhhdC4gSSBhdHRlbXB0ZWQgQVJNIHZTVkEgc3VwcG9ydCBiYXNl
ZCBvbiB5b3VyIGFib3ZlIGJyYW5jaA0KYW5kIHJlbGF0ZWQgUWVtdSBicmFuY2guIFdpdGggZmV3
IGhhY2tzIGFuZCBhZGRpdGlvbmFsIHBhdGNoZXMgdGhlIHByb3RvdHlwZQ0KY29kZSB3b3JrcyB3
ZWxsIG9uIEhpU2lsaWNvbiBBUk0gcGxhdGZvcm0uIA0KDQpQbGVhc2UgZmluZCB0aGUgY29ycmVz
cG9uZGluZyBicmFuY2hlcyBlcmUsDQpodHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29uL2tlcm5l
bC1kZXYvdHJlZS9pb21tdWZkLXY2LjEtcmMzLW5lc3RpbmctYXJtLXZTVkENCmh0dHBzOi8vZ2l0
aHViLmNvbS9oaXNpbGljb24vcWVtdS90cmVlL3FlbXUtaW9tbXVmZC02LjEtcmMzLWFybS12U1ZB
DQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IHJlY2VudCBicmFuY2hlcyBm
b3IgQVJNIHN1cHBvcnQuDQoNClRoYW5rcywNClNoYW1lZXINCiANCj4gDQo+IC0tDQo+IFJlZ2Fy
ZHMsDQo+IFlpIExpdQ0KDQo=
