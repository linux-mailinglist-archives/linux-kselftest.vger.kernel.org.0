Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2A771C6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHGIkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjHGIki (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 04:40:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB21721
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 01:40:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-vUjLTDvzN4WT0QZiNbwsZw-1; Mon, 07 Aug 2023 09:40:30 +0100
X-MC-Unique: vUjLTDvzN4WT0QZiNbwsZw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 09:40:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Aug 2023 09:40:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v3] tools/nolibc: fix up size inflate regression
Thread-Topic: [PATCH v3] tools/nolibc: fix up size inflate regression
Thread-Index: AQHZyPQZCzWEgy7xdkqtRS3MdkRe3q/efQWQ
Date:   Mon, 7 Aug 2023 08:40:27 +0000
Message-ID: <f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com>
References: <8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org>
In-Reply-To: <8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org>
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
> Sent: 07 August 2023 06:58
...
> +/* __auto_type is used instead of __typeof__ to workaround the build error
> + * 'error: assignment of read-only variable' when the argument has 'const' in
> + * the type, but __auto_type is a new feature from newer gcc version and it
> + * only works with 'const' from gcc 11.0 (__GXX_ABI_VERSION = 1016)
> + * https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
> + */

You can use typeof((x) + 0) to lose the 'const' flag.
The only downside is that char/short become int.

> +
> +#if __GXX_ABI_VERSION >= 1016
> +#define __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
> +#endif
> +
> +#ifdef __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
> +#define __sysret(arg)                                                    \
> +({                                                                       \
> +	__auto_type __ret = (arg);                                       \
> +	if (__is_signed_type(__typeof__(arg))) {                         \
> +		if (__ret < 0) {                                         \
> +			SET_ERRNO(-(long)__ret);                         \
> +			__ret = (__typeof__(arg))(-1L);                  \
> +		}                                                        \
> +	} else {                                                         \
> +		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
> +			SET_ERRNO(-(long)__ret);                         \
> +			__ret = (__typeof__(arg))(-1L);                  \
> +		}                                                        \
> +	}                                                                \
> +	__ret;                                                           \
> +})
> +
> +#else  /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */
> +#define __sysret(arg)                                                    \
> +({                                                                       \
> +	long __ret = (long)(arg);                                        \
> +	if (__is_signed_type(__typeof__(arg))) {                         \
> +		if (__ret < 0) {                                         \
> +			SET_ERRNO(-__ret);                               \
> +			__ret = -1L;                                     \
> +		}                                                        \
> +	} else {                                                         \
> +		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
> +			SET_ERRNO(-__ret);                               \
> +			__ret = -1L;                                     \
> +		}                                                        \
> +	}                                                                \
> +	(__typeof__(arg))__ret;                                          \
> +})
> +#endif /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */

with (retyped so it may be wrong):
#define is_constexpr(x) sizeof(*(0 ? (void *)((long)(x) * 0) : (int *)0)) == 1)
and (because even (void *)0 isn't completely constant):
#define is_pointer(x) (!is_constexpr((typeof(x))0))

You can probably do:
#define __sysret(arg) \
({ \
	typeof((arg) + 0) __ret = arg; \
	if (__built_choose_expr(is_pointer(arg), (unsigned long)-(MAX_ERRNO+1), __ret) \
			< (__built_choose_expr(is_pointer(arg), (unsigned long)__ret, 0)) { \
		SET_ERRNO(-__ret); \
		__reg = typeof(ret)-1L; \
	} \
	__ret; \
})

Apart from the annoyance of having to reverse the conditional
that only has one copy of the check.

Using two __builtin_choose_expr() saves you having to write two
comparisons that are valid for both pointer and integer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

