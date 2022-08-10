Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13F458E599
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiHJDp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 23:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiHJDp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 23:45:57 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BDC491DB
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 20:45:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o123so13933836vsc.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Aug 2022 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=KW8ybOJFichyl+rL+B899j3HSHwvcdsvy2PdBohQB9I=;
        b=E/y0/jft2wIPxHH4A5nTLopi7mdsnl2/bFJHZt05CvjZAr1BHT3KkAeldBbd6CzAY4
         57QNhsaCDQk8J0tTcHt4rtYNdaFLc91e1nGyw4gBsyEiY/SmfmTorGSiztQKVWEYkn02
         yBLt3iPhz48bUN6W56AymPGxJmbLXWHVKjmjlzqLDeCEPrvdHw4KjG8gHZOUGOy2fFQ9
         FPD1WKw2tjidpZ4jaOQ0kbNOJjpdxOoCVGPfJ3NJGbavhb3Bh0nZogAPkVP8I15nlUvk
         b7UcruiRkPkAehmZc0CO9kTwNiycoejpg0BTgIOEwGXtqDQy5EPVx5Q+l1axQCYuQd2g
         qy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=KW8ybOJFichyl+rL+B899j3HSHwvcdsvy2PdBohQB9I=;
        b=siNdVcvWCWdw9s9OX3nucr3JTXQ6aIRKelXuYQtBR08IUK+RvopLfiOhRBOpWnjZn2
         yoOXN4MpbXfCwmk1C0Kgp44FWVh2xfUYkxRg1/Mg8d+D6ZC7/Pxh5EeaOycJFd+K3rv0
         Z+99nvigZ9yS+elrcdybFL2Df/iAWg+cGIdaPr+H7mvmEazYw7Yz2Ezz+uH/8ZJh0ME8
         +2bpVbH6ia4ypibZTmxdiB9zIsUCTYQW+1oby84p/3/S833nR1w7SAI4qcS6hZ7Q71Pd
         NuOIoxkKnQtgnz4eOKweETbr3TZtGVVjxrd72Dgcx4W1OT/Jo7jWwdTboCLEXenpq8/i
         JKCA==
X-Gm-Message-State: ACgBeo018k8lZdkmcANYJDpWCEy6RVKnNt7rBX7ulOAfjmG2WtR2WxjL
        fRjD+0Bozc26ZHP4EEoJQu9Qjy3tAn5+zAkLtKXklw==
X-Google-Smtp-Source: AA6agR4Fs4XJ4C8ExqkOl2T320CK+M9XWX8GvmKn+P9Th7az4ltDyGarR+0gM+fMtLZiqvvDSckJDQb8eqfj/DDwnJ8=
X-Received: by 2002:a67:c885:0:b0:38a:7a34:cbca with SMTP id
 v5-20020a67c885000000b0038a7a34cbcamr1535612vsk.22.1660103154624; Tue, 09 Aug
 2022 20:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220808125237.277126-1-mairacanal@riseup.net>
In-Reply-To: <20220808125237.277126-1-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 11:45:43 +0800
Message-ID: <CABVgOS=ziJi0+_6GVt0RCr9YzW+VUBWBwrMAnMAb1W35JnjnJw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 8, 2022 at 8:53 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_E=
Q or
> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp functio=
n,
> such as:
>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>
> Although this usage produces correct results for the test cases, if the
> expectation fails the error message is not very helpful, indicating only =
the
> return of the memcmp function.
>
> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size. I=
n
> case of expectation failure, those macros print the hex dump of the memor=
y
> blocks, making it easier to debug test failures for memory blocks.
>
> The v4 doesn't bring many changes. The output is aligned just like the pr=
evious
> version but it fixes some mail client problems (sorry about that) and men=
tions
> that this macros are not recommended for structured data.
>
> The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
> expectations on the kunit-example-test.c. And the last patch replaces the
> KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.
>
> Best Regards,
> - Ma=C3=ADra Canal
>
> v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2749=
-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2
>
> - Change "determinated" to "specified" (Daniel Latypov).
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to =
make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Mark the different bytes on the failure message with a <> (Daniel Latyp=
ov).
> - Replace a constant number of array elements for ARRAY_SIZE() (Andr=C3=
=A9 Almeida).
> - Rename "array" and "expected" variables to "array1" and "array2" (Danie=
l Latypov).
>
> v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.420840-1=
-mairacanal@riseup.net/T/#t
>
> - Make the bytes aligned at output.
> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel L=
atypov).
> - Line up the trailing \ at macros using tabs (Daniel Latypov).
> - Line up the params to the functions (Daniel Latypov).
> - Change "Increament" to "Augment" (Daniel Latypov).
> - Use sizeof() for array sizes (Daniel Latypov).
> - Add Daniel Latypov's tags.
>
> v3 -> v4: https://lore.kernel.org/linux-kselftest/CABVgOSm_59Yr82deQm2C=
=3D18jjSv_akmn66zs4jxx3hfziXPeHg@mail.gmail.com/T/#t
>
> - Fix wrapped lines by the mail client (David Gow).
> - Mention on documentation that KUNIT_EXPECT_MEMEQ is not recommended for
> structured data (David Gow).
> - Add Muhammad Usama Anjum's tag.
>

Thanks very much! I've looked through and tested this, and it looks great t=
o me.

This entire series is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Ma=C3=ADra Canal (3):
>   kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
>   kunit: Add KUnit memory block assertions to the example_all_expect_macr=
os_test
>   kunit: Use KUNIT_EXPECT_MEMEQ macro
>
>  .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
>  include/kunit/assert.h                        | 34 ++++++++
>  include/kunit/test.h                          | 84 +++++++++++++++++++
>  lib/kunit/assert.c                            | 56 +++++++++++++
>  lib/kunit/kunit-example-test.c                |  7 ++
>  net/core/dev_addr_lists_test.c                |  4 +-
>  6 files changed, 186 insertions(+), 5 deletions(-)
>
> --
> 2.37.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20220808125237.277126-1-mairacanal%40riseup.net.
