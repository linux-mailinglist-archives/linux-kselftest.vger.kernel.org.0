Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DC595741
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiHPJ4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiHPJz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 05:55:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640C86FC5;
        Tue, 16 Aug 2022 01:40:17 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6Pf11nsMz688pK;
        Tue, 16 Aug 2022 16:37:13 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 10:40:14 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 16 Aug 2022 10:40:14 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Topic: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Index: AQHYrNrI3xbltKneMkianwQkzvowha2qT5IAgADB09A=
Date:   Tue, 16 Aug 2022 08:40:14 +0000
Message-ID: <7278db1e90de4c7bb669449e897d1946@huawei.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
 <20220810165932.2143413-6-roberto.sassu@huawei.com>
 <CACYkzJ718fr2TsvX0JPhTRiMQH8=HwaxLShrETLvrhPUy2p8OQ@mail.gmail.com>
In-Reply-To: <CACYkzJ718fr2TsvX0JPhTRiMQH8=HwaxLShrETLvrhPUy2p8OQ@mail.gmail.com>
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

PiBGcm9tOiBLUCBTaW5naCBbbWFpbHRvOmtwc2luZ2hAa2VybmVsLm9yZ10NCj4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMTIsIDIwMjIgMjo1MCBBTQ0KDQpbLi4uXQ0KDQo+ID4gKy8qKg0KPiA+ICsg
KiBicGZfa2V5X3B1dCAtIGRlY3JlbWVudCBrZXkgcmVmZXJlbmNlIGNvdW50IGlmIGtleSBpcyB2
YWxpZCBhbmQgZnJlZQ0KPiBicGZfa2V5DQo+ID4gKyAqIEBia2V5OiBicGZfa2V5IHN0cnVjdHVy
ZQ0KPiA+ICsgKg0KPiA+ICsgKiBEZWNyZW1lbnQgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiB0aGUg
a2V5IGluc2lkZSAqYmtleSosIGlmIHRoZSBwb2ludGVyDQo+ID4gKyAqIGlzIHZhbGlkLCBhbmQg
ZnJlZSAqYmtleSouDQo+ID4gKyAqLw0KPiANCj4gVGhpcyBpcyBtb3JlIG9mIGEgc3R5bGUgdGhp
bmcgYnV0IHlvdXIgY29tbWVudCBsaXRlcmFsbHkgZGVzY3JpYmVzIHRoZQ0KPiBzbWFsbCBmdW5j
dGlvbg0KPiBiZWxvdy4gRG8gd2UgcmVhbGx5IG5lZWQgdGhpcz8NCg0KVGhhbmtzIGZvciB0aGUg
cmV2aWV3LCBLUC4gSnVzdCBrZXB0IHRoaXMsIHRvIGZvbGxvdyB0aGUgc3R5bGUgb2Yga2VybmVs
DQpkb2N1bWVudGF0aW9uIGZvciBmdW5jdGlvbnMuDQoNClJvYmVydG8NCg==
