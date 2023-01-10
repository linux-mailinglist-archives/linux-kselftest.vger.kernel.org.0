Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E266644DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjAJPbg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjAJPay (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 10:30:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15DD2EC;
        Tue, 10 Jan 2023 07:30:52 -0800 (PST)
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NrvsN0FpRz67N2W;
        Tue, 10 Jan 2023 23:30:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 15:30:49 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.034;
 Tue, 10 Jan 2023 15:30:49 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Joao Martins <joao.m.martins@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Chaitanya Kulkarni" <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        "Eric Farman" <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
Subject: RE: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Topic: [PATCH v4 00/17] IOMMUFD Generic interface
Thread-Index: AQHY8wv6WqOaN9m/WUKJgvcZCnpZkK454qzggAFgXgCAXKMbQIAAKFmAgAAYaYCAAAM8UA==
Date:   Tue, 10 Jan 2023 15:30:49 +0000
Message-ID: <dc7ffdc5f38248caaaabac5a66de85bb@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
        <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
        <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
        <36b0fdac061e4680b5966d2774f0026a@huawei.com> <Y71szSt7jRFKTMcl@nvidia.com>
 <5481b0e8-84dc-52a9-c99f-1df3417328d6@oracle.com>
In-Reply-To: <5481b0e8-84dc-52a9-c99f-1df3417328d6@oracle.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9hbyBNYXJ0aW5zIFtt
YWlsdG86am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbV0NCj4gU2VudDogMTAgSmFudWFyeSAyMDIz
IDE1OjE2DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgU2hhbWVlcmFs
aSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
Pg0KPiBDYzogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+OyBicGZAdmdlci5rZXJuZWwub3Jn
OyBKb25hdGhhbiBDb3JiZXQNCj4gPGNvcmJldEBsd24ubmV0PjsgRGF2aWQgV29vZGhvdXNlIDxk
d213MkBpbmZyYWRlYWQub3JnPjsNCj4gaW9tbXVAbGlzdHMubGludXguZGV2OyBKb2VyZyBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz47IEtldmluIFRpYW4NCj4gPGtldmluLnRpYW5AaW50ZWwuY29t
PjsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta3NlbGZ0ZXN0QHZnZXIua2Vy
bmVsLm9yZzsgbGx2bUBsaXN0cy5saW51eC5kZXY7IE5hdGhhbiBDaGFuY2VsbG9yDQo+IDxuYXRo
YW5Aa2VybmVsLm9yZz47IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29t
PjsgTWlndWVsDQo+IE9qZWRhIDxvamVkYUBrZXJuZWwub3JnPjsgUm9iaW4gTXVycGh5IDxyb2Jp
bi5tdXJwaHlAYXJtLmNvbT47IFNodWFoDQo+IEtoYW4gPHNodWFoQGtlcm5lbC5vcmc+OyBTdXJh
dmVlIFN1dGhpa3VscGFuaXQNCj4gPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPjsgVG9t
IFJpeCA8dHJpeEByZWRoYXQuY29tPjsgV2lsbA0KPiBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47
IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+Ow0KPiBMdSBCYW9s
dSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgQ2hhaXRhbnlhIEt1bGthcm5pDQo+IDxjaGFp
dGFueWFrQG52aWRpYS5jb20+OyBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT47IERh
bmllbA0KPiBKb3JkYW4gPGRhbmllbC5tLmpvcmRhbkBvcmFjbGUuY29tPjsgRGF2aWQgR2lic29u
DQo+IDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+OyBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+OyBFcmljDQo+IEZhcm1hbiA8ZmFybWFuQGxpbnV4LmlibS5jb20+OyBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxq
ZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+OyBrdm1Admdlci5rZXJuZWwub3JnOw0KPiBNYXR0aGV3
IFJvc2F0byA8bWpyb3NhdG9AbGludXguaWJtLmNvbT47IE1pY2hhZWwgUy4gVHNpcmtpbg0KPiA8
bXN0QHJlZGhhdC5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOaWts
YXMgU2NobmVsbGUNCj4gPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+OyB6aHVrZXFpYW4gPHpodWtl
cWlhbjFAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMC8xN10gSU9NTVVG
RCBHZW5lcmljIGludGVyZmFjZQ0KPiANCj4gT24gMTAvMDEvMjAyMyAxMzo0OSwgSmFzb24gR3Vu
dGhvcnBlIHdyb3RlOg0KPiA+IENhbiB5b3UgYWxzbyBsb29rIGF0IHRoZSBkaXJ0eSB0cmFja2lu
ZyBzdHVmZj8gSSdkIHJlYWxseSBsaWtlIHRvIHNlZQ0KPiA+IHRoYXQgZG9uZSBmb3IgdGhlIGh1
YXdlaSB2ZmlvIGxpdmUgbWlncmF0aW9uIGRyaXZlcg0KPiA+DQo+IA0KPiBIZSBkaWQgbG9vayBh
bmQgcHJvdmlkZXMgY29tbWVudHMgYmFzZWQgb24gaGlzIHRlc3Rpbmcgb2YgdGhlIGluaXRpYWwg
c2VyaWVzDQo+IChJSVVDIGZyb20gd2hhdCB3ZSBzcG9rZSBhdCBMUEMpLiB2MiBzaG91bGQgYmUg
c2ltcGxlciwgdGhvdWdoIEkgYW0gc3RpbGwNCj4gd29ya2luZyBpdCBvdXQgdGhlIG1lcmdpbmcg
b2YgdW5pdCB0ZXN0cyBpbnRvIGlvbW11ZmQuDQo+IA0KPiBNeSBwbGFuIG9uY2UgSSBwb3N0IHRo
ZSB2MiB3YXMgdG8gaGFuZG92ZXIgdGhlIFNNTVV2MyBwYXJ0IGJhY2sgdG8NCj4gU2hhbWVlcmFs
aQ0KPiBnaXZlbiB0aGUgZmFjdCBoZSBoYXMgaGFyZHdhcmUgdGhhdCBoYXMgdGhlIGZlYXR1cmUg
YW5kIGNhbiBpdGVyYXRlIG1vcmUNCj4gbWVhbmluZ2Z1bGx5IHRoYW4gbWUuDQoNCk5vIHByb2Js
ZW0uIEhhcHB5IHRvIGhlbHAuDQoNClRoYW5rcywNClNoYW1lZXINCg==
