Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1487F1332C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgAGVNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 16:13:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41124 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgAGVNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 16:13:24 -0500
Received: by mail-vs1-f65.google.com with SMTP id f8so460789vsq.8
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bvDGD+uZFRI6wle2DQe8dNEf7/FawRKtQyhzkKp5kw=;
        b=KQVwsStOsvUFWmEIg1vbufOPH4q4526fnFkHZKuJZrLDUdrYo7b8+m/wOLoLIxlMpQ
         rifgkmP2r1S8nCyPcgVxzg3CxK/rOoqCa6uKsUsyMbk45IZqSPcRxtTjgKyhdO67JVw2
         yZDfkKv5zrHZXehKokQv0Ky2Ry9W0r0NEmWM9Rra4jWzzDJNsvUjjwE0gyPp6en9iHX8
         AB8I2xUL4Ovt8bQoDDJl5+fIYsLQn8fQBttM81wro9kWD1Jcr34on3ie4oTjb184Ifow
         uXvWDd06kKCirdcfRYDKXGHhcP4gu4+aKneQwt/Fz8UleolmSVLsX5BA0JhjUGa/FhGm
         ox2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bvDGD+uZFRI6wle2DQe8dNEf7/FawRKtQyhzkKp5kw=;
        b=l9/jwio6JV6JXKAVbQKq73eZC1DwcWkL8WTtExaL3yzIB8ah2Oy/GOrKc8VqF/ByfK
         HBps45PCtFwnl9WQCCC8qIVayq+U4syMwd0uNieb1S4HSDigYYf1q6H0xUl/ZI/y9M0P
         88Roww+pikRFrWbJ1PBrpnn49XUwiq/JQcL9Cmw8tour3UElIGTrbG9OKgWZSqfRACR2
         xfUp6sgA3z/8Q7zDHpkzSioirkVGGM/gVpfXbJeQgM2x02spDteHGdNws7k/F0u0Svve
         bc4q8yLunPSPY2UjjMY15qSHpf5N0eB4izYwO+BkEFrL8ao8j+W3IRS/vjevVBYpNIuz
         geIA==
X-Gm-Message-State: APjAAAXvxcAvb+pkT8YbNN8pSD03fk5hROte4ri5ULr+6q7t66lgghYo
        V7NT17xhIEZSW9PPUUQL8zZfH8PEuwonySXu4Lr7BQ==
X-Google-Smtp-Source: APXvYqz4dUEEj5q+SNZ0t9tcB9nHne8gPerfQ8ARFF6iQ6Im7uIQEkt0Hpm/+TaVwjf3O0rCQAlQVrwOn4RCK0e1NUM=
X-Received: by 2002:a67:fc46:: with SMTP id p6mr784857vsq.235.1578431603178;
 Tue, 07 Jan 2020 13:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-3-bgardon@google.com>
 <20200107160035.GG219677@xz-x1>
In-Reply-To: <20200107160035.GG219677@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 13:13:12 -0800
Message-ID: <CANgfPd-GLFtqrWsyg6hvrMFYxWCzxAQEGZ9Ahk4ZATYWs0_VaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] KVM: selftests: Add demand paging content to the
 demand paging test
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Done. I'll have it in the next version of the patch set I send out.

On Tue, Jan 7, 2020 at 8:00 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 01:38:55PM -0800, Ben Gardon wrote:
>
> [...]
>
> > +static void *uffd_handler_thread_fn(void *arg)
> > +{
> > +     struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> > +     int uffd = uffd_args->uffd;
> > +     int64_t pages = 0;
> > +
> > +     while (!quit_uffd_thread) {
> > +             struct uffd_msg msg;
> > +             struct pollfd pollfd[1];
> > +             int r;
> > +             uint64_t addr;
> > +
> > +             pollfd[0].fd = uffd;
> > +             pollfd[0].events = POLLIN;
> > +
> > +             /*
> > +              * TODO this introduces a 0.5sec delay at the end of the test.
> > +              * Reduce the timeout or eliminate it following the example in
> > +              * tools/testing/selftests/vm/userfaultfd.c
> > +              */
> > +             r = poll(pollfd, 1, 500);
>
> Would you mind implement it instead of adding a todo?  IIUC it's as
> simple as a few more lines than the comment itself.  Thanks,
>
> --
> Peter Xu
>
