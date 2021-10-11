Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32442895D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhJKJJP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 05:09:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22667 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235308AbhJKJJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 05:09:15 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-ej5tqsneN3Wj5_e8EA6vRA-1; Mon, 11 Oct 2021 10:07:13 +0100
X-MC-Unique: ej5tqsneN3Wj5_e8EA6vRA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 11 Oct 2021 10:07:10 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 11 Oct 2021 10:07:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: RE: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Thread-Topic: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Thread-Index: AQHXu5hFfxTcZGJlCEqsZaCSpNxtnavNhYtQ
Date:   Mon, 11 Oct 2021 09:07:10 +0000
Message-ID: <33e1be3f6e3b40eeb6f3cd5524e649fe@AcuMS.aculab.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
         <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
 <86b05929e5aa8fa6e975c59cf523ad84498351b6.camel@perches.com>
In-Reply-To: <86b05929e5aa8fa6e975c59cf523ad84498351b6.camel@perches.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joe Perches
> Sent: 07 October 2021 17:28
...
> IMO: this new file is missing 2 #include directives.
...
> This is not a self-contained header as it requires
> #include <linux/build_bug.h>
> which should be at the top of this file.
...
> And this requires
> 
> #include <linux/err.h>

And I bet the biggest problem is the time spent by the compiler
searching down the -I path for headers.

If you count system calls during a build I suspect that
failed opens of .h files dominate.

To see how much this really costs try running a build with
a (traditional) NFS mounted source tree - where every directory
name in a filename requires an NFS file handle lookup.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

