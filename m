Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6024FE73B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Apr 2022 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiDLRin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358639AbiDLRiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 13:38:13 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF55BD13;
        Tue, 12 Apr 2022 10:35:55 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d4so13398544iln.6;
        Tue, 12 Apr 2022 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLVJDr6jcH/Hhpk5ljJEeWK/iV9uol+R9xxj2F+8Y4A=;
        b=IiKMX57C5YzcokCDFZdUE8zJQg/C0NyIHC5HWRAvzjaLUUxIxy4ABzQaRjHbEWwACc
         Kg8zVLikJEHR44DHdL7wUaGnMO+0NWiUcb/Gje/dAfucsma0qPwytTqgv8bPfQdwh1FO
         yFDLs486T781Go/Wf08yHKK8UegRCQeaEfuxzC+BKzJ2wcsg+js8ADYm5aI4J4BehwmI
         Dt0TRW0YPQWg2mgrAlfC13jb7/N75LrvuQCrqW4H0g3aBRUsx9Dl36bXb3REoCx2gpkz
         ka20mF4NxvyVsT02NQ7wD2Y9O+DbrwrD8xQ1/G/2Fa66NMVlOQLkxmwcwrZwwVNwTjdh
         CCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLVJDr6jcH/Hhpk5ljJEeWK/iV9uol+R9xxj2F+8Y4A=;
        b=KQoOYVkybrO/RLLdUBqgafImWU6nMchw99PPV6KN8kMQpw8qlin5ctOAXK0oVVcW3m
         JAa06mDazBqJXVh1Ix7zA9B7eujT9Z30KmbhG0sR3Tq2mqA29uY7fAiH5jRWKkMHuUUc
         fxMUfkmUPlnYns/LAdZe6nAFG6BtLAfLfcL4rAel7jMG14wm/KEQ1b/MlTEW2t/EMRFc
         UHLW/RehLz6FqR9y8Y+cSKJxYYMKGNQY4bin4k6nLobuO4SKq+yD0te0Jbps6iAUzoz1
         YggcvuVjZdogYjvytHeDiKbvFPK17Ndm6ep4ePxWIq0TGbHBSrVNGwWPtQZG45zluc/M
         JRgg==
X-Gm-Message-State: AOAM530Rs2AFHfGf6K+ONHycTeFMTDcv4ya4bL/BeU6y9s7zGPRXXXGY
        KML1LTFxecEt1qJXqa4KSmmcrRifdu6aO2IliZY=
X-Google-Smtp-Source: ABdhPJwR8VvgmSj2khd/OCj8r9by523CzaGYCcVzGx7LxRVB5weURh6GvoH9k/ltUnrPmBQdrleFaQfXN7BhInaRYKA=
X-Received: by 2002:a05:6e02:1a64:b0:2ca:c168:a190 with SMTP id
 w4-20020a056e021a6400b002cac168a190mr3814301ilv.72.1649784954752; Tue, 12 Apr
 2022 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220412153906.428179-1-mic@digikod.net> <CANiq72=ogSxwz8iJLZaYD4nSkE71sBhT4dZyDv1HYyo5R43=pw@mail.gmail.com>
 <acdf5af3-f256-8d53-ec44-fcef4022ec62@digikod.net>
In-Reply-To: <acdf5af3-f256-8d53-ec44-fcef4022ec62@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 12 Apr 2022 19:35:43 +0200
Message-ID: <CANiq72mpdYY6Un6UZ49r05AJir_F4xRur9Ecmjw8v8CCWhLJ2w@mail.gmail.com>
Subject: Re: [PATCH v1] clang-format: Update and extend the for_each list with tools/
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 12, 2022 at 7:05 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> I'm wondering about the ASSERT_* and EXPECT_* macros from
> tools/testing/selftests/kselftest_harness.h
> Do you think we should treat them as "for macros" as well? They can
> either be used with or without a following code block.

I would keep the style that we have in the kernel -- as far as I can
see, that means without a space.

Also, from a quick grep, it seems most callers do not use the optional
handler, which also makes sense w.r.t. not using a space.

Cheers,
Miguel
