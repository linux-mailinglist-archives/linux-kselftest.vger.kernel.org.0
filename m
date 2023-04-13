Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594C6E0E1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjDMNJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 09:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDMNJh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 09:09:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFA1701;
        Thu, 13 Apr 2023 06:09:35 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:09:27 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681391373;
        bh=Yhv7mCx4Al1gJu1rdYzadILqil9/sKtPjX1Iwoi4Rqo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RXFVlroSG3X8lXZs43qURnHkuGCtzOpBDuOcd/vrucBxNqr00ZumcvMOvStWAp4md
         fxzzWo+Jnj5wIPtcXexd8+BbIl6xG6R1sgkqjJb/eHFdTz95dnj2BR14xBNWp/PVOu
         gR5Ar0/6hiG2lcQaMd5QfkuySGu6zZKE1G49aTNI=
From:   linux@weissschuh.net
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
Message-ID: <a91f0fe9-fcca-4009-b34d-0c58542d9765@weissschuh.net>
In-Reply-To: <f28e3c85-84a4-4b30-a3f5-c2efad311fe7@sirena.org.uk>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net> <20230328-nolibc-printf-test-v3-3-ddc79f92efd5@weissschuh.net> <f28e3c85-84a4-4b30-a3f5-c2efad311fe7@sirena.org.uk>
Subject: Re: [PATCH v3 3/4] tools/nolibc: implement fd-based FILE streams
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a91f0fe9-fcca-4009-b34d-0c58542d9765@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,


Apr 12, 2023 17:58:45 Mark Brown <broonie@kernel.org>:

> On Sun, Apr 02, 2023 at 06:04:36PM +0000, Thomas Wei=C3=9Fschuh wrote:
>
>> This enables the usage of the stream APIs with arbitrary filedescriptors=
.
>>
>> It will be used by a future testcase.
>
> This breaks the explicit use of standard streams:
>
>> -static __attribute__((unused)) FILE* const stdin=C2=A0 =3D (FILE*)-3;
>> -static __attribute__((unused)) FILE* const stdout =3D (FILE*)-2;
>> -static __attribute__((unused)) FILE* const stderr =3D (FILE*)-1;
>> +static __attribute__((unused)) FILE* const stdin=C2=A0 =3D (FILE*)(intp=
tr_t)~STDIN_FILENO;
>> +static __attribute__((unused)) FILE* const stdout =3D (FILE*)(intptr_t)=
~STDOUT_FILENO;
>> +static __attribute__((unused)) FILE* const stderr =3D (FILE*)(intptr_t)=
~STDERR_FILENO;
>
> Nothing in this change (or anything else in the series AFAICT) causes
> STDx_FILENO to be declared so we get errors like below in -next when a
> kselftest is built with this version of nolibc:

These definitions come from
"tools/nolibc: add definitions for standard fds".
This patch was part of the nolibc stack protector series which is older tha=
n this series and went through the same channels.
So I'm not sure how one series made it into next and the other didn't.

This would also have been noticed by Willy and Paul running their tests.

>
> clang --target=3Daarch64-linux-gnu -fintegrated-as -Werror=3Dunknown-warn=
ing-option -Werror=3Dignored-optimization-argument -Werror=3Doption-ignored=
 -Werror=3Dunused-command-line-argument --target=3Daarch64-linux-gnu -finte=
grated-as -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
> =C2=A0=C2=A0=C2=A0 -include ../../../../include/nolibc/nolibc.h -I../..\
> =C2=A0=C2=A0=C2=A0 -static -ffreestanding -Wall za-fork.c /tmp/kci/linux/=
build/kselftest/arm64/fp/za-fork-asm.o -o /tmp/kci/linux/build/kselftest/ar=
m64/fp/za-fork
> In file included from <built-in>:1:
> In file included from ./../../../../include/nolibc/nolibc.h:97:
> In file included from ./../../../../include/nolibc/arch.h:25:
> ./../../../../include/nolibc/arch-aarch64.h:176:35: warning: unknown attr=
ibute 'optimize' ignored [-Wunknown-attributes]
> void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start=
(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> In file included from <built-in>:1:
> In file included from ./../../../../include/nolibc/nolibc.h:102:
> ./../../../../include/nolibc/stdio.h:33:71: error: use of undeclared iden=
tifier 'STDIN_FILENO'
> static __attribute__((unused)) FILE* const stdin=C2=A0 =3D (FILE*)(intptr=
_t)~STDIN_FILENO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ./../../../../include/nolibc/stdio.h:34:71: error: use of undeclared iden=
tifier 'STDOUT_FILENO'
> static __attribute__((unused)) FILE* const stdout =3D (FILE*)(intptr_t)~S=
TDOUT_FILENO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ./../../../../include/nolibc/stdio.h:35:71: error: use of undeclared iden=
tifier 'STDERR_FILENO'
> static __attribute__((unused)) FILE* const stderr =3D (FILE*)(intptr_t)~S=
TDERR_FILENO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> 1 warning and 3 errors generated.
>
> The kselftest branch itself is fine, the issues manifest when it is
> merged with the nolibc branch.=C2=A0 I'm not quite sure what the implicit=
> include that's been missed here is?

These defines should be available to all users of nolibc.
It seems more of an issue with the patchsets going through different trees.

I can investigate this more tomorrow with my proper development setup.

Thomas
