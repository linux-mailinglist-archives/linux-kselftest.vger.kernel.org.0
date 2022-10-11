Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE45FB045
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJKKSL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 06:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKKSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 06:18:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87824094
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Oct 2022 03:18:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-09IWco5YP-G3TOKGjGh0fQ-1; Tue, 11 Oct 2022 11:18:04 +0100
X-MC-Unique: 09IWco5YP-G3TOKGjGh0fQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 11 Oct
 2022 11:18:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 11 Oct 2022 11:18:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: RE: tools/nolibc: fix missing strlen() definition and infinite loop
 with gcc-12
Thread-Topic: tools/nolibc: fix missing strlen() definition and infinite loop
 with gcc-12
Thread-Index: AQHY3A4FfEAIYReKOkCQTHoqkpVhA64HYvoggAFHY4CAACsgsA==
Date:   Tue, 11 Oct 2022 10:18:03 +0000
Message-ID: <b5de4f7b61f1467baea10267c96d6db4@AcuMS.aculab.com>
References: <Y0LsreRGq3nbe2xC@localhost.localdomain>
 <20221009175920.GA28685@1wt.eu> <20221009183604.GA29069@1wt.eu>
 <9e16965f1d494084981eaa90d73ca80e@AcuMS.aculab.com>
 <20221011062055.GC5107@1wt.eu>
In-Reply-To: <20221011062055.GC5107@1wt.eu>
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

From: Willy Tarreau
> Sent: 11 October 2022 07:21
> 
> On Mon, Oct 10, 2022 at 10:03:53AM +0000, David Laight wrote:
> > From: Willy Tarreau <w@1wt.eu>
> > > Sent: 09 October 2022 19:36
> > ...
> > > By the way, just for the sake of completeness, the one that consistently
> > > gives me a better output is this one:
> > >
> > >   size_t strlen(const char *str)
> > >   {
> > >           const char *s0 = str--;
> > >
> > >           while (*++str)
> > >   		;
> > >           return str - s0;
> > >   }
> > >
> > > Which gives me this:
> > >
> > >
> > >   0000000000000000 <strlen>:
> > >      0:   48 8d 47 ff             lea    -0x1(%rdi),%rax
> > >      4:   48 ff c0                inc    %rax
> > >      7:   80 38 00                cmpb   $0x0,(%rax)
> > >      a:   75 f8                   jne    4 <len+0x4>
> > >      c:   48 29 f8                sub    %rdi,%rax
> > >      f:   c3                      ret
> > >
> > > But this is totally ruined by the addition of asm() in the loop. However
> > > I suspect that the construct is difficult to match against a real strlen()
> > > since it starts on an extra character, thus placing the asm() statement
> > > before the loop could durably preserve it. It does work here (the code
> > > remains the exact same one), but for how long, that's the question. Maybe
> > > we can revisit the various loop-based functions in the future with this in
> > > mind.
> >
> > clang wilfully and persistently generates:
> >
> > strlen:                                 # @strlen
> >         movq    $-1, %rax
> > .LBB0_1:                                # =>This Inner Loop Header: Depth=1
> >         cmpb    $0, 1(%rdi,%rax)
> >         leaq    1(%rax), %rax
> >         jne     .LBB0_1
> >         retq
> >
> > But feed the C for that into gcc and it generates a 'jmp strlen'
> > at everything above -O1.
> 
> Interesting, that's not the case for me here with 12.2 from kernel.org
> on x86_64, which gives this at -O1, -O2, -O3 and -Ofast:
> 
>   0000000000000000 <strlen>:
>      0:   48 8d 47 ff             lea    -0x1(%rdi),%rax
>      4:   0f 1f 40 00             nopl   0x0(%rax)
>      8:   48 83 c0 01             add    $0x1,%rax
>      c:   80 38 00                cmpb   $0x0,(%rax)
>      f:   75 f7                   jne    8 <strlen+0x8>
>     11:   48 29 f8                sub    %rdi,%rax
>     14:   c3                      ret
> 
> Out of curiosity what version were you using ?

Clang 12.0.0 onwards, see https://godbolt.org/z/67Gnzs8js

> > I suspect that might run with less clocks/byte than the code above.
> 
> Certainly for large strings, but not for short ones.

For short strings not needing the final sub and not having
the read depend on the increment should make the leal one faster.
(The nop to align the loop label is monumentally pointless.)

For long strings what matters is how many clocks it takes
to schedule the 4 uops in the loop.
It might be possible to get down to 2 clocks - but I think
both the loops are 3 clocks (assuming the adjacent cmp/jne fuse).

I'm not going to try to instrument the loops though!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

