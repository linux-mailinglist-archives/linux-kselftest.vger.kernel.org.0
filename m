Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE194178795
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 02:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgCDB0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 20:26:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50204 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgCDB0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 20:26:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so117115wmb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 17:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQY8RMiDBALTBZD5pO37W3Q+lyu+FQ6v+Yh5nlQGZ5o=;
        b=LVALL7WayJJj9fVXFeWZhiLO1k562kNn8PPwUQ62FCeQ/h660Mp5uxJYRWP5Yp5jGN
         bH6s3ps5s/3l+hYqMteRYL5QBUDc4se6YnM4kvGAJwCp8ua3Bm9X1F8vEElfpf/SSlf+
         tdXuDuuPbOkLQxHSMalWwKm1TlapPsLupawQxdH0WZdiGv8kqmic+eVe6J5za/09pIg+
         4Kq8YWcrOFUguGtsD4Pn5XobpUsB72g60Nvz5gMUYShixkCfRDpZHZ1NGt3Tt8wRMmEZ
         Ts/bHKl6PD17qhyK/S6VwNfHPrnxGJeWNkHbX1tnzNMiBUPSw3fZE9ovauApTrfiq0s+
         Uxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQY8RMiDBALTBZD5pO37W3Q+lyu+FQ6v+Yh5nlQGZ5o=;
        b=VEJcKCo4KUUH6PMgcaK8k71IBB//4skc8RTCugdpwfCp5FvdCFyplZ4d5WLUl8ad5b
         s4mCTjAQyOFn06J9SPqd3dYJ3FtPyIVORoNkM0EGzMhTeBwBeRdwCVqPPJ40N5wpuv/S
         MGttkJIqLrTRVUv21UNYRtT3ut+wcERSAMEja76ESID2nWM9qVl1RU/d6uRkKKOC3tLv
         gJXF3SObXl7+vxKp4D7gxvydTVKJp7kMHPdWgb7KoV8YVJRfTE1mCzS91Y5HJYOFG7zb
         m2o+S2IjdvYEN87btjpZjIZSrJVbnmOlsGdr1JFGsBtmv4ADzA3CXhI4t83xhvMe6Gvg
         DXcA==
X-Gm-Message-State: ANhLgQ3txs5QBMxwL2uiDBtf1BiOSPhOO3OPQy5Q4DsIN2AFmst8sTYW
        mMr6vXA91n8NSLRulH27utSKLh6/dqILbl43MHYbxg==
X-Google-Smtp-Source: ADFU+vvnH+1bL4NV0ljd5KhdHNpkJzxZzpxkaLTusd/ifrF4jImBz8rBRub4jyXjhEu8R/LjgjUvJAP5IIf8IZ5vPOs=
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr445823wmd.107.1583285208997;
 Tue, 03 Mar 2020 17:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com> <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 3 Mar 2020 17:26:37 -0800
Message-ID: <CAKFsvU+ruKWt-BdVz+OX-T9wNEBetqVFACsG1B9ucMS4zHrMBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 29, 2020 at 10:29 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > > <kasan-dev@googlegroups.com> wrote:
> > > >
> > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > > >                 return True
> > > >
> > > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > > -               args.extend(['mem=256M'])
> > > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> > >
> > > This is better done somewhere else (different default value if
> > > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > > to be a mandatory part now. This means people will always hit this, be
> > > confused, figure out they need to flip the value, and only then be
> > > able to run kunit+kasan.
> > >
> > I agree. Is the best way to do this with "bool multishot =
> > kasan_save_enable_multi_shot();"  and
> > "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> > was done in the tests before?
>
> This will fix KASAN tests, but not non-KASAN tests running under KUNIT
> and triggering KASAN reports.
> You set kasan_multi_shot for all KUNIT tests. I am reading this as
> that we don't want to abort on the first test that triggered a KASAN
> report. Or not?

I don't think I understand the question, but let me try to explain my
thinking and see if that resonates with you. We know that the KASAN
tests will require more than one report, and we want that. For most
users, since a KASAN error can cause unexpected kernel behavior for
anything after a KASAN error, it is best for just one unexpected KASAN
error to be the only error printed to the user, unless they specify
kasan-multi-shot. The way I understand it, the way to implement this
is to use  "bool multishot = kasan_save_enable_multi_shot();"  and
"kasan_restore_multi_shot(multishot);" around the KASAN tests so that
kasan-multi-shot is temporarily enabled for the tests we expect
multiple reports. I assume "kasan_restore_multi_shot(multishot);"
restores the value to what the user input was so after the KASAN tests
are finished, if the user did not specify kasan-multi-shot and an
unexpected kasan error is reported, it will print the full report and
only that first one. Is this understanding correct? If you have a
better way of implementing this or a better expected behavior, I
appreciate your thoughts.

-- 
Thanks,
Patricia Alfonso
