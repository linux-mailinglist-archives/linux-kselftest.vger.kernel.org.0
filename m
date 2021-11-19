Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183294574DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhKSRBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbhKSRBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 12:01:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C98C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 08:58:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so45308436edb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErEg5lH429+YsanJojZrUh0d3Z7cACpSQZvZBHsD9aM=;
        b=gHr/2RgEtdOpErOyPDZJcCcSeofSSueWvK1Gfx8uT/hKpyS19T+uOdZRQndugSs/JL
         KUgewbkMC1HIXARDMGn/NhLLyYOcArTvlm0XSfpZnx468ig2jb1/IwKczWH2d+MDGlvv
         SbV4gwUgLZ4ZflXxnrD5a5v8CRg1Maib65SwwknmkSoOMLMGzQtaGyrqSbxacY7ZZGLY
         LhSL2UK6eqbSa/NpDeESxZNHOxkKHgCWECMr7xpyIJ1+RnNTHOScEG36IeoaaiYFT28w
         zyuiDH/3ReGX3xplGxCk/+zuQEwa9nIf46f6Kw5v/QhIjqHrJ1oWcm97n9ux2SYWpGQz
         dA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErEg5lH429+YsanJojZrUh0d3Z7cACpSQZvZBHsD9aM=;
        b=xYwPZcESTtw+ulVaU4pedr31RXBBu1r+odict0ge2v5ETwVBLIBg9h4P3Wem/TM5us
         tseffSlfHpkZS3CDxGCWJaC+uFyug5zeLgSMT/L4q2UOiPgEUvHAmCExl7KaIQJ3/JMV
         XrSL5nALkguQSkvrRv0xsytkxAr159qCe/lbUGUPV3TsHBU1tCpoyPNhcTtqA21cA1mG
         8qBY8icy4sNiZ+3ZTx7pefPfuzzglsS1RZlsGuo3be34GnPT8mwbtB+j3ugHdkS007ya
         E4a0SMFpqhY+fkJhKGJ9U1T622H5P2epquJvWm/c+lSLwd8amqH7WeW2olpyIb4UTOZP
         UxBw==
X-Gm-Message-State: AOAM533/EIF7ph+vqQTPMVAKmZi3XISSYBu1NjT4SyOsHYyQ4G6rV9/m
        IzX5n+6U9Q60yQblYhqHuKgwUSpBLwdjXYkYU1bo5Q==
X-Google-Smtp-Source: ABdhPJwjwYFQF5TH1tiK/c/KeHtkYUZ2Q17dm1zRuaodp9PMZ8lS3WsNKveiq1lhKT/gzcOUbADx50wPsTEZO1po6ic=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr9656058ejc.493.1637341119226;
 Fri, 19 Nov 2021 08:58:39 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook> <875ysp1m39.fsf@email.froward.int.ebiederm.org>
 <CAP045Aq06LV_jbXVc85bYU62h5EoVQ=rD9pDn+nGaUJ+iWe62w@mail.gmail.com> <202111190829.C0B365D4@keescook>
In-Reply-To: <202111190829.C0B365D4@keescook>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 19 Nov 2021 08:58:24 -0800
Message-ID: <CAP045Aq6SvnBpOsTKkwprYSdae1eppJhbhkYrxn_-vcFvzoPgQ@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 8:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 19, 2021 at 08:07:36AM -0800, Kyle Huey wrote:
> > On Thu, Nov 18, 2021 at 8:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Kyle thank you for your explanation of what breaks.  For future kernels
> > > I do need to do some work in this area and I will copy on the patches
> > > going forward.  In particular I strongly suspect that changing the
> > > sigaction and blocked state of the signal for these synchronous signals
> > > is the wrong thing to do, especially if the process is not killed.  I
> > > want to find another solution that does not break things but that also
> > > does not change the program state behind the programs back so things
> > > work differently under the debugger.
> >
> > The heads up in the future is appreciated, thanks.
>
> Yeah, I wonder if we could add you as a Reviewer in the MAINTAINERS file
> for ptrace/signal stuff? Then anyone using scripts/get_maintainers.pl
> would have a CC to you added.

I don't object to that. I guess we'll see how manageable the email load is.

> Also, are there more instructions about running the rr tests? When the
> execve refactoring was happening, I tried it[1], but the results were
> unclear (there seemed to be a lot of warnings and it made me think I'd
> done something wrong on my end).

It's a standard cmake test suite. The easiest way to run it is just to
run `make check`, wait a while, and see what gets printed out at the
end as failing.  There's a couple thousand tests that run and they
print all sorts of output ... some of them even crash intentionally to
make sure we can record specific types of crashes, so the ctest
pass/fail output at the very end is the only reliable indicator.

If you have specific issues you're seeing I'm happy to follow up here
or off list.

- Kyle

> -Kees
>
> [1] https://github.com/rr-debugger/rr/wiki/Building-And-Installing#tests
>
> --
> Kees Cook
