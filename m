Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AADE78A219
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjH0Vvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjH0Vvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 17:51:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97711A
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Aug 2023 14:51:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-21-i_qKFWZgNka4tYyQRpP4Gw-1; Sun, 27 Aug 2023 22:51:33 +0100
X-MC-Unique: i_qKFWZgNka4tYyQRpP4Gw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 27 Aug
 2023 22:51:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 27 Aug 2023 22:51:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>,
        "tanyuan@tinylab.org" <tanyuan@tinylab.org>
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single
 -ENOSYS return
Thread-Topic: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Thread-Index: AQHZ2MEQNQnWfqnECUm1iJ9YHQny8K/+quMQ
Date:   Sun, 27 Aug 2023 21:51:35 +0000
Message-ID: <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
References: <20230827083225.7534-1-falcon@tinylab.org>
In-Reply-To: <20230827083225.7534-1-falcon@tinylab.org>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

...
> Of course, we can also use the __stringify() trick to do so, but it is
> expensive (bigger size, worse performance) to unstringify and get the number
> again, the expensive atoi() 'works' for the numeric __NR_*, but not work for
> (__NR_*_base + offset) like __NR_* definitions (used by ARM and MIPS), a simple
> interpreter is required for such cases and it is more expensive than atoi().
> 
>     /* not for ARM and MIPS */
> 
>     static int atoi(const char *s);
>     #define __get_nr(name)          __nr_atoi(__stringify(__NR_##name))
>     #define __nr_atoi(str)          (str[0] == '_' ? -1L : ___nr_atoi(str))
>     #define ___nr_atoi(str)         (str[0] == '(' ? -1L : atoi(str))
> 
> Welcome more discussion or let's simply throw away this direction ;-)

While it will look horrid the it ought to be possible to
get the compiler to evaluate the string.

Since "abc"[2] (etc) is converted to a constant (by gcc and clang
except at -O0) and you only need to process "n" "nn" "nnn"
"(n + m)" (with variable length n and m) then append some spaces
and convert the characters back to digits.

So something that starts:
#define dig(c) (c < '0' || c > '9' ? 999999 : c - '0')
	str[0] == '_' ? -1 :
	str[0] != '(' ? str[1] == ' ' ? dig(str[0]) :
		str[2] == '1' ? (dig(str[0]) * 10 + dig(str[1]) :
Any unexpected character will expand the 99999 and generate
an over-large result.
I'm not sure how constant the array index need to be.
They may well have to be 'integer constant expressions'
so cant depend on a previous str[const] value.

I just found a(nother) clang bug:
	int f(void) { return "a"[2]; }
compiles to just a 'return'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

