Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BD77B89D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHNM23 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHNM2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 08:28:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906DD1BD
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 05:28:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-t5D3hpR5Ou-FBcPeB1FmCg-1; Mon, 14 Aug 2023 13:28:00 +0100
X-MC-Unique: t5D3hpR5Ou-FBcPeB1FmCg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 13:27:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 13:27:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>
CC:     'Zhangjin Wu' <falcon@tinylab.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v5] tools/nolibc: fix up size inflate regression
Thread-Topic: [PATCH v5] tools/nolibc: fix up size inflate regression
Thread-Index: AQHZzpwIMKbqPe7hTkqs7/1zyBEHW6/pnUhggAAFJICAABLgYA==
Date:   Mon, 14 Aug 2023 12:27:48 +0000
Message-ID: <e3a6bd5b7a4d4ac2bccbaac21e0fc1a0@AcuMS.aculab.com>
References: <20230814082224.GA16761@1wt.eu>
 <20230814104226.7094-1-falcon@tinylab.org>
 <6fef903020954515abdcee7261918903@AcuMS.aculab.com>
 <20230814120941.GA18837@1wt.eu>
In-Reply-To: <20230814120941.GA18837@1wt.eu>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Willy Tarreau
> Sent: 14 August 2023 13:10
> 
> Hi David,
> 
> On Mon, Aug 14, 2023 at 11:15:51AM +0000, David Laight wrote:
> > From: Zhangjin Wu
> > > Sent: 14 August 2023 11:42
> > ...
> > > [...]
> > > > > > Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> > > > > > honest, because we're there just because of the temptation to remove
> > > > > > lines that were not causing any difficulties :-/
> > > > > >
> > > > > > I think we can do something in-between and deal only with signed returns,
> > > > > > and explicitly place the test for MAX_ERRNO on the two unsigned ones
> > > > > > (brk and mmap). It should look approximately like this:
> > > > > >
> > > > > >  #define __sysret(arg)                                                \
> > > > > >  ({                                                                   \
> > > > > >  	__typeof__(arg) __sysret_arg = (arg);                           \
> > > > > >  	(__sysret_arg < 0) ? ({           /* error ? */                 \
> > > > > >  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
> > > > > >  		((__typeof__(arg)) -1);   /*      return -1 */          \
> >
> > I'm pretty sure you don't need the explicit cast.
> > (It would be needed for a pointer type.)
> > Can you use __arg < ? SET_ERRNO(-__arg), -1 : __arg
> >
> > Thinking, maybe it should be:
> >
> > #define __sysret(syscall_fn_args)
> > ({
> > 	__typeof__(syscall_fn_args) __rval = syscall_fn_args;
> > 	__rval >= 0 ? __rval : SET_ERRNO(-__rval), -1;
> > })
> 
> Yeah almost, since arg is necessarily signed in this version, it's
> just that I manually edited the previous macro in the mail and limited
> the amount of changes to what was necessary. It's just that SET_ERRNO
> only is an instruction, not an expression:
> 
>    #define SET_ERRNO(v) do { errno = (v); } while (0)
> 
> Thus the return value doesn't even pass through it. That's why it was
> so much simpler before. The rationale behind this was to bring the
> ability to completely drop errno for programs where you didn't care
> about it. It's particularly interesting when you don't need any other
> data either as the program gets strunk from a complete section.

Actually something like:

#define SET_ERRNO(v) (errno = -(long)(v), __typeof__(v)-1)

seems to work and allows the errno assignment be removed.
Also works for pointer types (after a different compare).

A quick check with godbolt doesn't show any sign extensions happening.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

