Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE053A4B16
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jun 2021 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFKXRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 19:17:32 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:44949 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFKXRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 19:17:32 -0400
Received: by mail-wm1-f52.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so6382518wms.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x77VeL0664QNf/49UZ4vs2zjAoFI8RzH88arzAm1WBg=;
        b=C+cg6tjcLIGs07jTA8L3RATTcy9xTkno6wuXHN/tEV5WHsbRj1s9WQvvXQUjUk9EsL
         xzpaoZiiOIOAe5X5ZeBytD45YPzPMYh8m3UyfOBXKQKO//jH8AtE0rrS1kV2Wyx9LMTt
         YBKwsuuzJnkq4KLb3E/KFTJhS5Ehfec3CAUaBwJoFl+ph5oW0QMif2qrL+B69E0WUUpg
         Wd6E4nXa6PBpsaD8vezPRZqOLtcBoCZWUiK/v9N2/Au3atPcm8Im25qvuv653Eo6aYGF
         gwQ2hw55AKiLkkr0Is3c58QZGvzuduCb8V0hOrVkkfp52E2O7dqfgmSGQwAqdA0WBKXw
         NWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x77VeL0664QNf/49UZ4vs2zjAoFI8RzH88arzAm1WBg=;
        b=U/YOW1171242wsmraSM6XIgqvjaWy25Cn4nNX4Sv8JwD63zx350q3rDbxF45AvLw0t
         ZI8RMR6qm7KBcb8jbs+TsXqx7gSQaCIexnITAWyL1kmL2BbexCshOtu/jIU7s0urEuOh
         1+t8HUO+6uuikjnjPZwFaD4ylurdpuIHAryVcIkbZKx9SKJDE5wc4iV+dUSETzB5Hbrd
         UsBCwG6nrZ7tcAe6+3E3ABhY/ysMoJRlom3piAHrNxyT0pv+lBsg9VpE4BOxiYSWcqp5
         +Cr9k9R48E4E51BOQdi479YPlOaJzT0ml6x0uakQRgMCDBJbE67koN2giPRrmTsKzGKv
         iUew==
X-Gm-Message-State: AOAM530ZfKwMqRfiOi7JYtlzFjUkpGiaE3g81tB1yejPkd8c2A9SKT/D
        9K/D7nMEaOVmNvb6QiattO24pWx4CyMQe3mIMG8ffA==
X-Google-Smtp-Source: ABdhPJxTpSvCcBLIeAN3y050nO91jX9/Kp1Hx26Jp+Q+MTBTtVldNR5uQc11vPgC4guGCwDoDwTGVSfShBdjLW6wynY=
X-Received: by 2002:a05:600c:17d7:: with SMTP id y23mr5279112wmo.123.1623453273156;
 Fri, 11 Jun 2021 16:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210611035725.1248874-1-davidgow@google.com> <CAFd5g44hC9XM2EcphwTNF5Vcz6v3kZg-ZFJwyj610ty6688OSQ@mail.gmail.com>
In-Reply-To: <CAFd5g44hC9XM2EcphwTNF5Vcz6v3kZg-ZFJwyj610ty6688OSQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 12 Jun 2021 07:14:21 +0800
Message-ID: <CABVgOSnaUsJaTO+6AvRL5fx_xhv=mbDB9CStxVYwr45HZVkGAg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix result propagation for parameterised tests
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 12, 2021 at 4:26 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Jun 10, 2021 at 8:57 PM David Gow <davidgow@google.com> wrote:
> >
> > When one parameter of a parameterised test failed, its failure would be
> > propagated to the overall test, but not to the suite result (unless it
> > was the last parameter).
> >
> > This is because test_case->success was being reset to the test->success
> > result after each parameter was used, so a failing test's result would
> > be overwritten by a non-failing result. The overall test result was
> > handled in a third variable, test_result, but this was disacarded after
> > the status line was printed.
>
> nit: s/disacarded/discarded/g
>
> > Instead, just propagate the result after each parameter run.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")
>
> I tried to reproduce the problem described and was unable to. Anyway,
> from the code it definitely looks like there is a bug like you
> describe. And it definitely looks like your change should fix it.

I was able to reproduce this again myself. Note that the kunit_tool
wrapper does its own result propagation which doesn't have a similar
bug, so you won't see the issue in its parsed results. (Using the
--raw_output flag does show it, though).

Here's the output from a patched UUID suite, which deliberately fails
the first parameter of the first two tests and passes the other
parameters and tests, which exhibits the issue:

TAP version 14
1..1
   # Subtest: uuid
   1..4
   # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
   Expected uuid_parse(data->uuid, &be) == 0, but
       uuid_parse(data->uuid, &be) == -22

failed to parse 'c33fx4995-3701-450e-9fbf-206a2e98e576'
   # uuid_correct_be: not ok 1 - c33fx4995-3701-450e-9fbf-206a2e98e576
   # uuid_correct_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
   # uuid_correct_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
   not ok 1 - uuid_correct_be
   # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
   Expected guid_parse(data->uuid, &le) == 0, but
       guid_parse(data->uuid, &le) == -22

failed to parse 'c33fx4995-3701-450e-9fbf-206a2e98e576'
   # uuid_correct_le: not ok 1 - c33fx4995-3701-450e-9fbf-206a2e98e576
   # uuid_correct_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
   # uuid_correct_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
   not ok 2 - uuid_correct_le
   # uuid_wrong_be: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
   # uuid_wrong_be: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
   # uuid_wrong_be: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
   ok 3 - uuid_wrong_be
   # uuid_wrong_le: ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
   # uuid_wrong_le: ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
   # uuid_wrong_le: ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
   ok 4 - uuid_wrong_le
ok 1 - uuid


Note the "not ok 1 - uuid_correct_be" line, yet it ending in "ok 1 - uuid".

>
> Anyway, I tried testing your fix, but given I was unable to reproduce
> the failure, I am not super confident in my testing. Still,
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
