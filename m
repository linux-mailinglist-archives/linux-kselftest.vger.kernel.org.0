Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BCF0B21
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfKFAhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 19:37:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfKFAha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 19:37:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so5723565pff.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2019 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xOEbfGEe8GuKsDuMH9MLXg4toOcxPN6sItuj2bk3/c=;
        b=H9CHqqLsNjXKwjTR8C18iAyH8mYJcqKTJzTxrYbrX9XeucuHFy1MhMkr1qLwUynZoI
         /J/8lr1Tt6Tc60wRlH3f0rCQ+RCSquDh718fEM32Pnwo3rLKeuHLnu9yJmM44VRCWzAL
         fq9Bt+WdnoeV5CUpdKzZdWbZmt41FnpeY8GYZ5DJ2H/cxEiSxhW2f46kx44APEOsPs2N
         4F351UJo2YxVOgozWPeqoavVc5HMRYeB51yXeKoXhAF9CtkVszv/lcexWJwkh/wJIpcR
         4dIAA7zDub0oVR8BKH2l7GEwSt6EPBaBMMM13ETRjrqv2629QX/kFGMEOst2UaazKjlf
         E0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xOEbfGEe8GuKsDuMH9MLXg4toOcxPN6sItuj2bk3/c=;
        b=llEz/wKy7cH9MM/X8NWoQZet7pUzwcxlIh753YT5E8On36qqKmka8smM1fYrL+XXIU
         xkcmhJbDqVZrGUiocOrZ1TneifzfYm3qRaPHbgpZcR9BdDaQb1WaR//dSMFFS4R4tv3x
         MGkxxZ5kkGDFMefOGzgNvUAFkX8prUfQi4toPCXh6sbo28NiZJ0jdk0oed1tbayoof3T
         5BtmrH3I0nBJSWctSudvasfje6+bbBUSFYwTKBCQkt3NnTxvdq6D62B1nuh3J7opsFTX
         29gUGDla5Bhf+L6pTROUtrnvhY4+aVdkicCl4qP6psSEnQEnm/VxyLmstalyyWirwiaD
         XUgQ==
X-Gm-Message-State: APjAAAXtOKOc0wRdj2tn9kJbNidwLyj0Nz++spsDMdNkbDA5qCiJzZ1U
        XOm1ql22hSSFirHJ1lBftbEbAHrTKwiygoAP5VpL+w==
X-Google-Smtp-Source: APXvYqxcqWQVNbu/TYt0V5Wacgq4WEbsEc01rhn+cjVcvFFuB1FXuC8UVbgZanjPIa7uEEjhDRGZx0tXaQhiyBI1m6k=
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr18353pje.131.1573000647922;
 Tue, 05 Nov 2019 16:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
 <201910301157.58D0CE4D3@keescook> <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
In-Reply-To: <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 16:37:16 -0800
Message-ID: <CAFd5g47Qn7ESPLvm9t_ifGPhjJ9dXgV9KVObg64bN3UNnoQPdA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 5, 2019 at 4:35 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Oct 30, 2019 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> > > On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > >
> > > > +config SECURITY_APPARMOR_TEST
> > > > +       bool "Build KUnit tests for policy_unpack.c"
> > > > +       default n
> >
> > New options already already default n, this can be left off.
> >
> > > > +       depends on KUNIT && SECURITY_APPARMOR
> > > > +       help
> > > >
> > > select SECURITY_APPARMOR ?
> >
> > "select" doesn't enforce dependencies, so just a "depends ..." is
> > correct.
> >
> > > > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > > > +       KUNIT_EXPECT_TRUE(test,
> > > > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > > I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> > > otherwise there could be a buffer overflow in memcmp. All tests that
> > > follow such pattern
> >
> > Agreed.
> >
> > > are suspect. Also, not sure about your stylistic preference for
> > > KUNIT_EXPECT_TRUE(test,
> > >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > > vs
> > > KUNIT_EXPECT_EQ(test,
> > >                0,
> > >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
> >
> > I like == 0.
>
> Oh, I almost missed this. I think the *_EQ(...) is better than the
> *_TRUE(...) because the EQ is able to provide more debug information
> if the test fails (otherwise there would really be no point in
> providing all these variants).
>
> Any objections?
>
> Thanks for the catch Iurii!

Wait, nevermind.

Either way is fine because memcmp probably won't show terribly
interesting information in the non-zero case. I'll just leave it the
way Mike wrote it.

Sorry!
