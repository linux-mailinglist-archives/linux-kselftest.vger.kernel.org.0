Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39181CD6A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgEKKfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 06:35:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27495 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbgEKKe7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 06:34:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-Y6aTlilXPbm7gmL1oEH7BQ-1; Mon, 11 May 2020 11:34:55 +0100
X-MC-Unique: Y6aTlilXPbm7gmL1oEH7BQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 May 2020 11:34:55 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 May 2020 11:34:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masami Hiramatsu' <mhiramat@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: RE: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Thread-Topic: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Thread-Index: AQHWJ3Z3OA5bC6hjSEW0AS/lPBzMtKiisGaQ
Date:   Mon, 11 May 2020 10:34:55 +0000
Message-ID: <a53a35607015496986678713cd1899e8@AcuMS.aculab.com>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <5EB3AE7C.5@cn.fujitsu.com>
        <20200507181505.3e8369ee39f14d9c74ec986b@kernel.org>
        <5EB8FD31.9020906@cn.fujitsu.com>
 <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
In-Reply-To: <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu
> Sent: 11 May 2020 10:28
...
> > We may not avoid fixing related failures after your change:
> > 1) We have to reuse built-in echo (do alias echo=echo) if we want to
> > test common_pid for histogram.
> > 2) We have to reuse built-in echo if some new tests want to interpret
> > backslash escapes in future.
> 
> 1) yes, that's what I need to do for avoiding "pid" key histogram
>   (but I think we should have better way to test it)
> 2) No, in that case you should use "/bin/echo -e" explicitly.
>    dash's built-in echo doesn't support it.
> 
> > Is it simple to provide two implementations of echo?(built-in echo and
> > echo command?) and then just apply echo command for kprobe_syntax_errors.tc?
> 
> Hmm, OK, there might be another reason we reconsider this patch.
> 
> - Alisasing echo (this patch) can avoid dash related issues but
>   this also makes "echo" running in another process implicitly.
> 
> - Using /bin/echo for backslash explicitly will be missed unless
>   user runs it on dash, but it will keep "echo" in same process.

Why not change to use printf - probably a builtin in both shells?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

