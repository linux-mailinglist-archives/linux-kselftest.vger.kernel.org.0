Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8383B78838E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHYJcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244264AbjHYJcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:32:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA41FDF
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 02:32:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-CWXtiu9VOBa0HfxzC4PXkQ-1; Fri, 25 Aug 2023 10:32:04 +0100
X-MC-Unique: CWXtiu9VOBa0HfxzC4PXkQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 10:32:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 25 Aug 2023 10:32:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mahmoud Maatuq' <mahmoudmatook.mm@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "wad@chromium.org" <wad@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH v2 2/2] selftests/net: replace ternary operator with
 min()/max()
Thread-Topic: [PATCH v2 2/2] selftests/net: replace ternary operator with
 min()/max()
Thread-Index: AQHZ1slDuEzSfgmyIkyLho9d3Y2q6K/6vr1A
Date:   Fri, 25 Aug 2023 09:32:02 +0000
Message-ID: <dd7b956916e044b181e7ccd1823f14ec@AcuMS.aculab.com>
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
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

From: Mahmoud Maatuq
> Sent: 24 August 2023 21:24
....
>  		tdeliver = glob_tstart + ts->delay_us * 1000;
> -		tdeliver_max = tdeliver_max > tdeliver ?
> -			       tdeliver_max : tdeliver;
> +		tdeliver_max = max(tdeliver_max, tdeliver);

That was spectacularly horrid...
What is wrong with using:
	if (tdeliver > tdeliver_max)
		tdeliver_max = tdeliver;
That is pretty obviously calculating the upper bound.
Even the version with max() needs extra parsing by the human reader.

(The only issue is whether it reads better with the if condition
reversed.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

