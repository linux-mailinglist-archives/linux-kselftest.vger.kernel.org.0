Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3177572AD52
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjFJQe0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjFJQeZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:34:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82473588
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:34:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-vjr2SVtyMI2O7ZtR7E3aMA-1; Sat, 10 Jun 2023 17:34:20 +0100
X-MC-Unique: vjr2SVtyMI2O7ZtR7E3aMA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 17:34:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 17:34:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Thread-Topic: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Thread-Index: AQHZmQJ1YTdtMnXhOkqSBnIhvL9uWq+EPW+g
Date:   Sat, 10 Jun 2023 16:34:16 +0000
Message-ID: <0295105fe0744200bf2ef99e5bf7bc09@AcuMS.aculab.com>
References: <ZIAB7bFYegCuXT9g@1wt.eu>
 <20230607053920.667272-1-falcon@tinylab.org>
In-Reply-To: <20230607053920.667272-1-falcon@tinylab.org>
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
> Sent: 07 June 2023 06:39
...
> As a summary, will use 'sysret()' and something like:
> 
>    static __attribute__((unused))
>    int chdir(const char *path)
>    {
>    	return sysret(chdir(path));
>    }
> 
> to renew the syscall helper patchset, Thanks you very much.

While I'm all for using 'cpp-magic' to abstract and (hopefully)
simplify things. Token-pasting the sys_ here doesn't seem to gain
anything.
Anyone grepping the code for 'sys_chdir' is also going to
wonder where it is used.

There might be scope for something like:
#define syscall_wrapper(func, type) \
	static __attribute__((unused)) \
	int func(type *arg) \
	{ \
		return sysret(sys_#func(arg)); \
	}
and then:
syscall_wrapper(chdir, const char *)
would expand to the code above.

I think you'd need separate defines for each number of arguments.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

