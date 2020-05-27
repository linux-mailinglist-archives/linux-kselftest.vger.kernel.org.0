Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F191E5122
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE0WX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 18:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgE0WX2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 18:23:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E54C05BD1E;
        Wed, 27 May 2020 15:23:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c11so28776114ljn.2;
        Wed, 27 May 2020 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDUCdw/ayIiyqDGiRwy24Togh8qSAsEHJq3kdKNjy6E=;
        b=ikxz+wtqcz/ix6joyxaUeYfQteyOLp04oMU8aJNHvQnZFbC9bWtbG1YytzuVFhW7H5
         v+O7FfJ+cIfAxN0yjNGeg6pplAK8DwxGrqi/BjwaVQKPVGxUSi8mfwZvRtspfetStYV9
         ox5CabBJjOpPZzRG6SA6pvEveJ4NU7jx9XKLQ6Drk6tJBDUDDyVZgy2Ra9hrOCp+zYTw
         k2m/P6ArpEIVCxXj7j8he3Qt6YgUyJeTv02WQYhPScomjaJsUrIV2pQlKSjgcqWDPWAc
         zTGXUWpDvHrMlX/0OvjuTlyX2Al1yHuQe1paZm/bLenHB7dISjOXZ1T1o58tu866OC76
         qZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDUCdw/ayIiyqDGiRwy24Togh8qSAsEHJq3kdKNjy6E=;
        b=QMMcE8aHeFhzhiyWMSnpfTW9wbYbhtF5GaUr4XsKX2KGlMj8aNhGKIfFRfc0xhDrn4
         0qn063BMMqjYg2snWUdkq2HC42xr/U9Wva9u90Yf0vytS/3hsNmqCKv4x9sbRJSJFSgD
         gYQ1T9ccOPwDoGktJPZV+wkwz4HEPoifSasX73bK+JH44OmFCXlODRMIXAcNaY8LfevB
         5hSIcuIT3YrPIYIalGtMAZSiNVqStoZTtR4gqThxhljNOY6AhvX8YIZyiIx6WWnto+pI
         XaBCKk+/OlYK3a9Rc+G8Fia5s7jvFgUX9y/Ou+GGSjbIH+NB3oX5LyfrJv1ackYPb5tX
         IRtA==
X-Gm-Message-State: AOAM5328mebKTww9zNi/K9pTcAk0dLo5pycTDTWNPpJgso6IE/lx+3kI
        R7zgeNyw21jHaxCTAn9h5fYZXQfSeSSwad3dfM0=
X-Google-Smtp-Source: ABdhPJz2YfTgfRMaHeZNPMoqZ6BxheRpJKYAN/tJKTVlw8s7jqed1pa8mFXkVP0vF4UtBXfQUQeu8+/snV7j/b2NWj0=
X-Received: by 2002:a2e:150e:: with SMTP id s14mr3716381ljd.290.1590618204753;
 Wed, 27 May 2020 15:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367so4k3.fsf@redhat.com> <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
 <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
 <xunya71uosvv.fsf@redhat.com> <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
In-Reply-To: <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 May 2020 15:23:13 -0700
Message-ID: <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     shuah <shuah@kernel.org>
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 27, 2020 at 3:01 PM shuah <shuah@kernel.org> wrote:
>
> On 5/27/20 11:05 AM, Alexei Starovoitov wrote:
> > On Wed, May 27, 2020 at 10:02 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> >>
> >> Hi, Alexei!
> >>
> >>>>>>> On Wed, 27 May 2020 09:48:04 -0700, Alexei Starovoitov  wrote:
> >>
> >>   > On Wed, May 27, 2020 at 12:19 AM Yauheni Kaliuta
> >>   > <yauheni.kaliuta@redhat.com> wrote:
> >>   >>
> >>   >> Hi, Alexei!
> >>   >>
> >>   >> >>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:
> >>   >>
> >>   >> > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
> >>   >> > <yauheni.kaliuta@redhat.com> wrote:
> >>   >> >>
> >>   >> >> Hi, Andrii!
> >>   >> >>
> >>   >> >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
> >>   >> >>
> >>   >> >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
> >>   >> >> > <yauheni.kaliuta@redhat.com> wrote:
> >>   >> >> >>
> >>   >> >> >> There is difference in depoying static and generated extra resource
> >>   >> >> >> files between in/out of tree build and flavors:
> >>   >> >> >>
> >>   >> >> >> - in case of unflavored out-of-tree build static files are not
> >>   >> >> >> available and must be copied as well as both static and generated
> >>   >> >> >> files for flavored build.
> >>   >> >> >>
> >>   >> >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
> >>   >> >> >> is chosen in analogy to TEST_GEN_* variants.
> >>   >> >> >>
> >>   >> >>
> >>   >> >> > Can we keep them together but be smarter about what needs to
> >>   >> >> > be copied based on source/target directories? I would really
> >>   >> >> > like to not blow up all these rules.
> >>   >> >>
> >>   >> >> I can try, ok, I just find it a bit more clear. But it's good to
> >>   >> >> get some input from kselftest about OOT build in general.
> >>   >>
> >>   >> > I see no value in 'make install' of selftests/bpf
> >>   >> > and since it's broken just remove that makefile target.
> >>   >>
> >>   >> Some CI systems perform testing next stage after building were
> >>   >> build tree is not available anymore. So it's in use at the
> >>   >> moment.
> >>
> >>   > such CI systems can do 'cp -r' then
> >> >> It's a discussion for linux-kselftest@ (added).
> >>
> >> At the moment `make install` is generic kselftest functionality
> >> and since bpf is part of that infra it looks a bit strange to
> >> break it intentionally.
> >
> > selftests/bpf is only historically part of selftests.
> > It probably should stop using kselftest build infra all together.
> > We had breakages in selftests/bpf in the past only because
> > of changes in kselftests bits.
> >
>
> The question is whether or not the breakages addresses quickly.
> Also, bpf keels breaking ksleftest builds and installs because
> it has dependencies on bleeding edge tools and causes problems
> for kselftest users.
>
> You are pulling me into the discussion midway and I am missing the
> context for the discussion. There is another thread on this topic
> where Yauheni and I have been talking about bpf install.
>
> I would say bpf install has never really worked from kselftest
> install mechanism.
>
> Ideally all tests use kselftest common install rule to leverage
> the install and not have users do individual test installs.
> It isn't productive and cooperative to say let's have bpf test
> do its thing. It is part of selftests and we have to figure out
> how to have it consistently build and run.
>
> It isn't building for me on Linux 5.7-rc7 at the moment, leave
> alone install.
>
> The test Makefile has to handle OUTPUT directory. Please add me
> to the entire patch series especially if it changes selftests
> Makefile and lib.mk. I will review and try to see if we can make
> bpf install work under kselftest common infrastructure.

I prefer to keep selftests/bpf install broken.
This forced marriage between kselftests and selftests/bpf
never worked well. I think it's a time to free them up from each other.
