Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D058809C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiHBRAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiHBRAO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 13:00:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8989C46
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 10:00:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a7so14072023ejp.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2w9j9LaZJjOKyMxreP7PDQG5d151R4IhaLjK01Lb1iM=;
        b=Iua2tMz9VCggF2zvbuaciSSrSdIzA6LZwUpp1N894iDucV1kOI7qdYGfmfKDClT2IE
         f2UgcD9N78KSCyczFLpt4gpc3fEw+lpAMY2ctYeN+7a1QLskAiRER1ucVyHk/2/fhtfR
         rfMjdQ5aPIgxJ00Y5WNVwhd47T8BjWPFOzshujn5+knc605IMjbOkmMz3XcoTbXOt/cg
         mpu49YAP3pdjXirKKYgt6noUtvlxJ279lQfM//iGDWqPwxIvR2nXb9mq9Qawf7nKe+24
         s2vcHKHPNhUvqLtEr7OsnpId++WidGeGPmCCinwuiyRHzy+PQXwHJxhQ4g7pW0zfDgD4
         87gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2w9j9LaZJjOKyMxreP7PDQG5d151R4IhaLjK01Lb1iM=;
        b=IFucDKsugah8xCQykGM7Zsh7d/ibRTSsoofpyqISaYvYTZ5hK5vAcYu3L/Qt0x54iy
         MDQlI+lNn2s5wUr22vntO2d5IZOQ1FEYz5Qx5sjyhGJ3frt9CHLy8ZkPYhatXdiVo8Lx
         JvqnM0X2Myw6PYARtqgzBnTSHV/duTtfWndLtVLnIidiCnpmkeyO7/sfaFH1khCalGox
         8ulxoOWNpLGBrNUbM3WHB4/xD4iwj6XLjRwnIgAhLHNXEZ6+0yRHleQRyVuYYg7fusN6
         M68NwJs1jHmgcGNoBzzHQdg8eUX+8JZ/MVmylo8e4ELPeUIjvudx+yVLTphXrMjjXnPX
         QN0g==
X-Gm-Message-State: ACgBeo1MZLf+NLoZaTfYMS+6WL5U/VZoQ40fLgFHMKqwPsJvxS6wCsvT
        5BaI9ORg9iJ4kiQ+5ifYNmZ2hANl+7wZrvdNTWkYIQ==
X-Google-Smtp-Source: AA6agR41HGJZg+YeeikZ2qs2nfRN9hqXpBRMZUvhsoEyZwKr3moN6pyQp+LCxIrEH9wFbiTETV/GLbEakJHhm6pT+LA=
X-Received: by 2002:a17:907:6da8:b0:730:8ed5:2df8 with SMTP id
 sb40-20020a1709076da800b007308ed52df8mr7232187ejc.75.1659459611056; Tue, 02
 Aug 2022 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220802161206.228707-1-mairacanal@riseup.net>
In-Reply-To: <20220802161206.228707-1-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 09:59:59 -0700
Message-ID: <CAGS_qxoAc934AwB7SZ34PpoVxvF3Eua-g+aO77kjJf6d1m0+Qw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 2, 2022 at 9:12 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> Currently, in order to compare arrays in KUnit, the KUNIT_EXPECT_EQ or
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
> Therefore, create a new set of macros KUNIT_EXPECT_ARREQ and
> KUNIT_EXPECT_ARRNEQ that compare memory blocks until a determined size. I=
n
> case of expectation failure, those macros print the hex dump of the memor=
y
> blocks, making it easier to debug test failures for arrays.

I totally agree with this.

The only reason I hadn't sent an RFC out for this so far is
* we didn't have enough use cases quite yet (now resolved)
* I wasn't sure how we'd want to format the failure message.

For the latter, right now this series produces
dst =3D=3D
00000000: 33 0a 60 12 00 a8 00 00 00 00 8e 6b 33 0a 60 12
00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
result->expected =3D=3D
00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00

I was thinking something like what KASAN produces would be nice, e.g.
from https://www.kernel.org/doc/html/v5.19/dev-tools/kasan.html#error-repor=
ts
(I'll paste the bit here, but my email client doesn't support
monospaced fonts, so it won't look nice on my end)

Memory state around the buggy address:
 ffff8801f44ec200: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff8801f44ec280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8801f44ec300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03
                                                                ^
I just wasn't quite sure how to do it for a diff, since this only
really works well when showing one bad byte.
If we blindly followed that approach, we get

dst =3D=3D
>00000000: 33 0a 60 12 00 a8 00 00 00 00 8e 6b 33 0a 60 12
                                          ^
>00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
                        ^
result->expected =3D=3D
>00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
                                          ^
>00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00
                        ^

But perhaps we could instead highlight the bad bytes with something like
dst =3D=3D
00000000: 33 0a 60 12 00 a8 00 00 00 00 <8e> 6b 33 0a 60 12
00000010: 00 00 00 00 <00> a8 8e 6b 33 0a 00 00 00 00
result->expected =3D=3D
00000000: 31 0a 60 12 00 a8 00 00 00 00 <81> 6b 33 0a 60 12
00000010: 00 00 00 00 <01> a8 8e 6b 33 0a 00 00 00 00

Thoughts, suggestions?
