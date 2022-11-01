Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E661469A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKAJ1Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKAJ1N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:27:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1518E3C
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 02:27:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-B-9HsrjzPcmqxY1XE4Mqwg-1; Tue, 01 Nov 2022 09:27:08 +0000
X-MC-Unique: B-9HsrjzPcmqxY1XE4Mqwg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Nov
 2022 09:27:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 1 Nov 2022 09:27:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rong Tao' <rtoax@foxmail.com>
CC:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "haoluo@google.com" <haoluo@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "rongtao@cestc.cn" <rongtao@cestc.cn>,
        "sdf@google.com" <sdf@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>
Subject: RE: RE: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Thread-Topic: RE: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify
 warning
Thread-Index: AQHY60Mk36Wn0FfjTU6Muu9w9hWY+64lSbUwgASHdACAAABlkA==
Date:   Tue, 1 Nov 2022 09:27:06 +0000
Message-ID: <70ddf02157bc418cbc38230c87a7b228@AcuMS.aculab.com>
References: <1611fe67d311461aa5f820836318bacc@AcuMS.aculab.com>
 <tencent_5523542A5E3F46AD119B0C0A8588B27E2E09@qq.com>
In-Reply-To: <tencent_5523542A5E3F46AD119B0C0A8588B27E2E09@qq.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rtoax@foxmail.com>
> Sent: 01 November 2022 09:25
> 
> Can we just use the first patch?
> https://lore.kernel.org/lkml/tencent_EE3E19F80ACD66955D26A878BC768CFA210A@qq.com/

IIRC strlcpy() does the copy you want.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

