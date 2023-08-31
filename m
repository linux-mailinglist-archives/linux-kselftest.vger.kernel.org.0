Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90A78E897
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjHaInd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjHaInd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:43:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75BCF2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 01:43:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-LRFvNPzzO7iMs2R3ZDsrzw-1; Thu, 31 Aug 2023 09:37:14 +0100
X-MC-Unique: LRFvNPzzO7iMs2R3ZDsrzw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 31 Aug
 2023 09:37:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 31 Aug 2023 09:37:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>
CC:     "ammarfaizi2@gnuweeb.org" <ammarfaizi2@gnuweeb.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tanyuan@tinylab.org" <tanyuan@tinylab.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>, "w@1wt.eu" <w@1wt.eu>
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single
 -ENOSYS return
Thread-Topic: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Thread-Index: AdnbXfVru8RTG9gTQ+SsAG5ax7hYowAeEOWAAANtgiA=
Date:   Thu, 31 Aug 2023 08:37:11 +0000
Message-ID: <f7f06eb4a5b44ce29718341e28c823f8@AcuMS.aculab.com>
References: <2d52dbd55e6240d5a91ebdce67fe0b7b@AcuMS.aculab.com>
 <20230831074151.7900-1-falcon@tinylab.org>
In-Reply-To: <20230831074151.7900-1-falcon@tinylab.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

...
> We also need this style of checking for the delta logic in __atoi_add(). have
> randomly tried different clang and gcc versions, seems all of them work
> correctly, but the compiling speed is not that good if we want to support the
> worst cases like "((0x900000 + 0x0f0000) + 5)", the shorter one
> "((0x900000+0x0f0000)+5)" is used by ARM+OABI (not supported by nolibc
> currently), therefore, we can strip some tailing branches but it is either not
> that fast, of course, the other architectures/variants can use faster
> __atoi_add() versions with less branches and without hex detection, comparison
> and calculating.

If there are only a few prefix offsets then the code can be optimised
to explicitly detect them - rather than decoding arbitrary hex values.
After all it only needs to decode the values that actually appear.

The code also needs a compile-time assert that the result
is constant (__buitin_constant_p() will do the check.
But you can't use _Static_assert() to report the error
because that requires an 'integer constant expression'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

