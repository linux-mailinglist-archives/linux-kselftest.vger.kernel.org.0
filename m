Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE41CDDF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgEKO7Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 10:59:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52467 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729120AbgEKO7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 10:59:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-157-TNtXyxpxO8qGl8Sa13yMrg-1; Mon, 11 May 2020 15:59:21 +0100
X-MC-Unique: TNtXyxpxO8qGl8Sa13yMrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 May 2020 15:59:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 May 2020 15:59:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masami Hiramatsu' <mhiramat@kernel.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: RE: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Thread-Topic: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Thread-Index: AQHWJ5lrSXqvrVhCTk6tpfgbVx7YuKii+RAg
Date:   Mon, 11 May 2020 14:59:20 +0000
Message-ID: <f61eda03333941958d62f9df93ba534b@AcuMS.aculab.com>
References: <87imh21x6f.fsf@igel.home>
        <158920418730.16156.8299185499520876735.stgit@devnote2>
 <20200511223804.9483cab03c9221818ff4fc5b@kernel.org>
In-Reply-To: <20200511223804.9483cab03c9221818ff4fc5b@kernel.org>
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

> > +    pos=$(printf "%s" "${2%^*}" | wc -c) # error position
> > +    command=$(printf "%s" "$2" | tr -d ^)

You may want to put all the $(...) inside "" to avoid field splitting
(not relevant to a shell assignment with modern shells) and
filename globbing.

> >      echo "Test command: $command"
> >      echo > error_log
> > -    (! echo "$command" >> "$3" ) 2> /dev/null
> > +    (! printf "%s" "$command" >> "$3" ) 2> /dev/null

WTF is the (! for ??
The (...) is a subshell.
And ! inverts the exit status.
Neither is needed at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

