Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A23771C1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHGIQP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGIQO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 04:16:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9FE1BB
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 01:16:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-6FPU6Xj6Ow-DPKP--BfwjA-1; Mon, 07 Aug 2023 09:16:06 +0100
X-MC-Unique: 6FPU6Xj6Ow-DPKP--BfwjA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 09:16:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Aug 2023 09:16:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v6 06/15] tools/nolibc: __sysret: support syscalls who
 return a pointer
Thread-Topic: [PATCH v6 06/15] tools/nolibc: __sysret: support syscalls who
 return a pointer
Thread-Index: AQHZyGJM8MfmHZ1C3ES1BFx0kL6bna/eeWXw
Date:   Mon, 7 Aug 2023 08:16:02 +0000
Message-ID: <a1732bbffd1542d3b9dd34c92f45076c@AcuMS.aculab.com>
References: <20230806095846.GB10627@1wt.eu>
 <20230806123351.35202-1-falcon@tinylab.org>
In-Reply-To: <20230806123351.35202-1-falcon@tinylab.org>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhangjin Wu
> Sent: 06 August 2023 13:34
...
> Based on your macro version, I tried to use the is_signed_type() from kernel,
> it seems works.

You'll find that (void *)0 isn't 'constant enough' for
is_constexpr() - so is_constexpr((type)0) can be used
to detect pointer types.
Probably requires an 'is_pointer_type()' define.
This also rather means that is_signed_type() needs to be
wrapped in is_constexpr() - probably generating header
file inclusion hell.

I'm going to add a comment on v3 of the patch...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

