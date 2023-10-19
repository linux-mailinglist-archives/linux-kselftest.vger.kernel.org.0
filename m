Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098DF7CF3E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjJSJTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSJTh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 05:19:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3486B8
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 02:19:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-249-cGV1VhXOMa6ASajv7ojwdQ-1; Thu, 19 Oct 2023 10:19:32 +0100
X-MC-Unique: cGV1VhXOMa6ASajv7ojwdQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 19 Oct
 2023 10:19:29 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 19 Oct 2023 10:19:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'jeffxu@chromium.org'" <jeffxu@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "sroettger@google.com" <sroettger@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "jeffxu@google.com" <jeffxu@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "surenb@google.com" <surenb@google.com>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "mawupeng1@huawei.com" <mawupeng1@huawei.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shr@devkernel.io" <shr@devkernel.io>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        "yu.ma@intel.com" <yu.ma@intel.com>,
        "zhangpeng362@huawei.com" <zhangpeng362@huawei.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/8] Introduce mseal() syscall
Thread-Topic: [RFC PATCH v2 0/8] Introduce mseal() syscall
Thread-Index: AQHaANl9uNyZCjtaekqZ4TrOWO2ruLBQ2GGA
Date:   Thu, 19 Oct 2023 09:19:29 +0000
Message-ID: <b3508782e1304074b4b43040be2d1f1b@AcuMS.aculab.com>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogamVmZnh1QGNocm9taXVtLm9yZw0KPiBTZW50OiAxNyBPY3RvYmVyIDIwMjMgMTA6MDgN
Cj4gDQo+IFRoaXMgcGF0Y2hzZXQgcHJvcG9zZXMgYSBuZXcgbXNlYWwoKSBzeXNjYWxsIGZvciB0
aGUgTGludXgga2VybmVsLg0KDQpJJ20gc3VyZSB5b3UgY2FuIGdpdmUgaXQgYSBiZXR0ZXIgbmFt
ZSwgdGhlcmUgaXNuJ3QgYSA2IGNoYXJhY3Rlcg0KbGltaXQgb24gaWRlbnRpZmllcnMhDQoNCkZX
SVcgeW91IGNvdWxkIGFsc28gdXNlIG1wcm90ZWN0KGFkZHIsIGxlbiwgSU1NVVRBQkxFKTsNCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

