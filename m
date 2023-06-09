Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF27294C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbjFIJVl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjFIJVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 05:21:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096085FC7
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 02:15:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-q9nRy84GPH-DWMN5iDJwaQ-1; Fri, 09 Jun 2023 10:15:08 +0100
X-MC-Unique: q9nRy84GPH-DWMN5iDJwaQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 9 Jun
 2023 10:15:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 9 Jun 2023 10:15:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "w@1wt.eu" <w@1wt.eu>
Subject: RE: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and
 __sysret() helpers
Thread-Topic: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and
 __sysret() helpers
Thread-Index: AQHZmozMSUsfyUxi2UiZnouHjWtcta+CLgRA
Date:   Fri, 9 Jun 2023 09:15:05 +0000
Message-ID: <13d8756927914b578b076babc8b7f7fb@AcuMS.aculab.com>
References: <9edb16b4-0d3f-4355-a7b1-684a28f9b4cb@t-8ch.de>
 <20230609044230.165494-1-falcon@tinylab.org>
In-Reply-To: <20230609044230.165494-1-falcon@tinylab.org>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhangjin Wu
> Sent: 09 June 2023 05:43
> 
> Hi, Thomas, David, Willy
> 
> > Hi David,
> >
> > On 2023-06-08 14:35:49+0000, David Laight wrote:
> > > From: Zhangjin Wu
> > > > Sent: 06 June 2023 09:10
> > > >
> > > > most of the library routines share the same code model, let's add two
> > > > helpers to simplify the coding and shrink the code lines too.
> > > >
> > > ...
> > > > +/* Syscall return helper, set errno as -ret when ret < 0 */
> > > > +static inline __attribute__((always_inline)) long __sysret(long ret)
> > > > +{
> > > > +	if (ret < 0) {
> > > > +		SET_ERRNO(-ret);
> > > > +		ret = -1;
> > > > +	}
> > > > +	return ret;
> > > > +}
> > >
> > > If that right?
> > > I thought that that only the first few (1024?) negative values
> > > got used as errno values.
> > >
> 
> Thanks David, this question did inspire me to think about the syscalls
> who returns pointers, we didn't touch them yet:

I'm also not sure whether lseek() is expected to return values
that would be negative.

(I do remember having to patch out some checks (not Linux) in order to use:
    echo -n xxxx | dd of=/dev/kmem oseek=nnn
in order to patch a live kernel!)

Technically read() and write() can do longer transfers, but
Linux limits them to MAXINT.
IIRC both BSD and SYSV allow drivers return all values (except -1)
form ioctl().

The check for -4095UL is probably reasonable.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

