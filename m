Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C915B8972
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiINNsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiINNsG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 09:48:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB7760CB
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 06:47:56 -0700 (PDT)
Received: from localhost (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4017B6601F88;
        Wed, 14 Sep 2022 14:47:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663163275;
        bh=ag0pFWwUGGozBZ3vrQUcDBvQ0iBTtskA1NAwADcmVuc=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=VxBjJdVJeyynfnkwK9XDWCaKYa9Z9FL5fPlo4D96r8aAgwQYqnk9OzsA3MXXj1+cb
         F0lzcpwEJmydOGWagzS1uOoIwcvNYTcnPL6vw6Z7L++9ZrBihZtUanScr6LfFZvCvs
         kpTSANTm+zziO1kTfHMa1YS7BNL47SzGtTv5u4yTKnHbYmpWE33o+gyZk2btR2wY8D
         HVw0OQBOHkvMg47W4jDaO2P81R7qV8D/0/RLc3h/Bj6255OSYN0xKf71DfkXfnrelE
         OY8iahoqBhqN6kh6xDSH1fxnaXdA8PzepW28wVLtkbp8/RuzEh16CPQCkp2E2RQjlC
         11YoEXj7KO9fw==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc:     linux-kselftest@vger.kernel.org, dvhart@infradead.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests/futex: fix build for clang
References: <20220909110709.1827374-1-ricardo.canuelo@collabora.com> <a5f6b1da7df0784536c7d7b70a0bc44e@igalia.com>
In-reply-to: <a5f6b1da7df0784536c7d7b70a0bc44e@igalia.com>
Date:   Wed, 14 Sep 2022 15:47:51 +0200
Message-ID: <87leqmt6d4.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On mi=C3=A9, sep 14 2022 at 11:53:34, Andr=C3=A9 Almeida <andrealmeid@igali=
a.com> wrote:

> Hi Ricardo :)

Hey Tony! Long time, haha. I hope you're doing fine.

> Could you share how I can test this patch?

Simply running `make CC=3Dclang' in tools/testing/selftest/futex with and
without the patch on should highlight the differences:

Without the patch:

    $ make CC=3Dclang
    make[1]: Entering directory '/root/linux-kselftest/tools/testing/selfte=
sts/futex/functional'
    make --no-builtin-rules ARCH=3Dx86 -C ../../../../.. headers_install
    make[2]: Entering directory '/root/linux-kselftest'
      INSTALL ./usr/include
    make[2]: Leaving directory '/root/linux-kselftest'
    clang  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../.=
./../../../usr/include/     futex_wait_timeout.c ../include/futextest.h ../=
include/atomic.h ../include/logging.h -lpthread -lrt -o /root/linux-kselfte=
st/tools/testing/selftests/futex/functional/futex_wait_timeout
    clang: error: cannot specify -o when generating multiple output files
    make[1]: *** [../../lib.mk:152: /root/linux-kselftest/tools/testing/sel=
ftests/futex/functional/futex_wait_timeout] Error 1
    make[1]: Leaving directory '/root/linux-kselftest/tools/testing/selftes=
ts/futex/functional'


With the patch:

    $ make CC=3Dclang
    make[1]: Entering directory '/root/linux-kselftest/tools/testing/selfte=
sts/futex/functional'
    make --no-builtin-rules ARCH=3Dx86 -C ../../../../.. headers_install
    make[2]: Entering directory '/root/linux-kselftest'
      INSTALL ./usr/include
    make[2]: Leaving directory '/root/linux-kselftest'
    clang  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../.=
./../../../usr/include/     futex_wait_timeout.c -lpthread -lrt -o /root/li=
nux-kselftest/tools/testing/selftests/futex/functional/futex_wait_timeout
    clang  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../ -I../.=
./../../../usr/include/     futex_wait_wouldblock.c -lpthread -lrt -o /root=
/linux-kselftest/tools/testing/selftests/futex/functional/futex_wait_wouldb=
lock
    ...

I'm testing this with Clang v11, by the way.

Cheers,
Ricardo
