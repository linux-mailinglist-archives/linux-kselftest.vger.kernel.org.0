Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2715A76FC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2019 19:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGZRYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jul 2019 13:24:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33365 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfGZRYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jul 2019 13:24:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so55314669wru.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2019 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiMZfUFI9f1x83nRtSh10tjTtqDmFY2gSeI0ixlEL60=;
        b=SiPCiPGGfcsNv4L7SzwEt2NQhzlhnSUE4cqgWRn01nnTRL6yhggdWq3Bc3wAGe4Z5P
         21Jd7i0S+RBhuramgqr4wk3v4wvo8PNUkcZvMaJ+gARZ5wUFkHb4FtEJFdQaC6lQLYmo
         3aiE18fm2Fq9PJPjQE7WkHnJO4J/l6/l2U+J0v75ydPPZOzqjm8vstimhHosnKq5TGKP
         hfSgmmup2/f9E4TIx5vmsTTWmDvxXKoO9zph6caB1MvVG3yHOnHGyTgoy8tgazi8PWme
         /SQAf/m2mnsSFc7EXiXcrk5Pi+AqZtIiYUgZXw4Mf1t8kvjd9A5Fe5Xb2xCd8Jm4pzEm
         FYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiMZfUFI9f1x83nRtSh10tjTtqDmFY2gSeI0ixlEL60=;
        b=ROacEpIyh5/2RQAaZPWU+6XiPfJ7mNc+owj4XjdRmb0pLr1x9sa5+h42T11UqDLdUy
         iLE0SujkTjv1F+Hdf5Ed+nte69HwZciK/7GrQqrWEEuu2iTGVoSxDTVepS3fPegWR1XI
         j9BMG9Z7oAVEKy0nhk3FBYByNupI/+E1ZLk6N2ldvEzygBDdINRTa7vGUX5kCTCa85r5
         PEdLhkWVyKwLRMWWEuOe6kP94PBte60eu5T7OaWMgOim6xNaHGPf7vU/uhv1zcx7Snqj
         EeMaJtmBRYj9zc7zoub+ehbVKoYvBDmgbGVoUnWtKa9fmSYJYN6ZJMp+1xfIywtjzXsE
         3Q7Q==
X-Gm-Message-State: APjAAAWbe7OS3sY2edHPgv4rdMkGW10eCHZZiGvKmJISJUbvo97DjxIy
        vSqk1sc52Bfow6UbN8WrNfLiU7RUnnCf3mI46tEjJg==
X-Google-Smtp-Source: APXvYqxX7siZeHb+jWToJR43WvqVEL69RSnG9wpa+9TaPngb7kLZK3ho0MCwuUSsib+mZXGRRGGl0uHsZUXyIPZ2aHo=
X-Received: by 2002:adf:df10:: with SMTP id y16mr79737717wrl.302.1564161882081;
 Fri, 26 Jul 2019 10:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190726162226.252750-1-surenb@google.com> <20190726162226.252750-2-surenb@google.com>
 <20190726170728.GA157922@google.com>
In-Reply-To: <20190726170728.GA157922@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 26 Jul 2019 10:24:31 -0700
Message-ID: <CAJuCfpEH_QnrBFwYkhCKgvDK2dzhtTBgRnMYH9hY=j6gVNajPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>, arnd@arndb.de,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Colascione <dancol@google.com>, tglx@linutronix.de,
        Jann Horn <jannh@google.com>, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 26, 2019 at 10:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Jul 26, 2019 at 09:22:26AM -0700, Suren Baghdasaryan wrote:
> > This adds testing for polling on pidfd of a process being killed. Test runs
> > 10000 iterations by default to stress test pidfd polling functionality.
> > It accepts an optional command-line parameter to override the number or
> > iterations to run.
> > Specifically, it tests for:
> > - pidfd_open on a child process succeeds
> > - pidfd_send_signal on a child process succeeds
> > - polling on pidfd succeeds and returns exactly one event
> > - returned event is POLLIN
> > - event is received within 3 secs of the process being killed
> >
> > 10000 iterations was chosen because of the race condition being tested
> > which is not consistently reproducible but usually is revealed after less
> > than 2000 iterations.
> > Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
>
> > +             close(pidfd);
> > +             // Wait for child to prevent zombies
>
> Comment style should be /* */, but I think Christian would be kind enough to
> fix that when he applies the patch so shouldn't need a resend.

Agrh! That's what I get for constantly switching between kernel and
userspace development :\
Christian please let me know if I should respin this or you can fix it
when taking this patch.
Thanks!

>
> Thanks Suren and Christian!
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
