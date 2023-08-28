Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7081D78A92D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjH1Jqc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjH1JqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:46:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FC10E
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 02:46:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-xG4-vW29Mi-XX8dfW8eG2w-1; Mon, 28 Aug 2023 10:46:12 +0100
X-MC-Unique: xG4-vW29Mi-XX8dfW8eG2w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 10:46:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 10:46:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>, "'w@1wt.eu'" <w@1wt.eu>
CC:     "'arnd@arndb.de'" <arnd@arndb.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-kselftest@vger.kernel.org'" <linux-kselftest@vger.kernel.org>,
        "'thomas@t-8ch.de'" <thomas@t-8ch.de>,
        "'tanyuan@tinylab.org'" <tanyuan@tinylab.org>
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single
 -ENOSYS return
Thread-Topic: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Thread-Index: AQHZ2MEQNQnWfqnECUm1iJ9YHQny8K/+quMQgADLxVA=
Date:   Mon, 28 Aug 2023 09:46:14 +0000
Message-ID: <6819b8e273dc44e18f14be148549b828@AcuMS.aculab.com>
References: <20230827083225.7534-1-falcon@tinylab.org>
 <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
In-Reply-To: <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Laight
> Sent: 27 August 2023 22:52
> 
> ...
> > Of course, we can also use the __stringify() trick to do so, but it is
> > expensive (bigger size, worse performance) to unstringify and get the number
> > again, the expensive atoi() 'works' for the numeric __NR_*, but not work for
> > (__NR_*_base + offset) like __NR_* definitions (used by ARM and MIPS), a simple
> > interpreter is required for such cases and it is more expensive than atoi().
> >
> >     /* not for ARM and MIPS */
> >
> >     static int atoi(const char *s);
> >     #define __get_nr(name)          __nr_atoi(__stringify(__NR_##name))
> >     #define __nr_atoi(str)          (str[0] == '_' ? -1L : ___nr_atoi(str))
> >     #define ___nr_atoi(str)         (str[0] == '(' ? -1L : atoi(str))
> >
> > Welcome more discussion or let's simply throw away this direction ;-)
> 
> While it will look horrid the it ought to be possible to
> get the compiler to evaluate the string.
...
> So something that starts:
> #define dig(c) (c < '0' || c > '9' ? 999999 : c - '0')
> 	str[0] == '_' ? -1 :
> 	str[0] != '(' ? str[1] == ' ' ? dig(str[0]) :
> 		str[2] == '1' ? (dig(str[0]) * 10 + dig(str[1]) :
> Any unexpected character will expand the 99999 and generate
> an over-large result.

See https://godbolt.org/z/rear4c1hj

That will convert "1234" or "(1234 + 5678)" (or shorter numbers)
as a compile-time constant.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

