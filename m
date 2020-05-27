Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59861E4D3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgE0Sqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 14:46:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbgE0Sqr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 14:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590605205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRZs2wTiBxkHiiy94lGn4R8kksbGjLYQcTj8D95VNpo=;
        b=KSODuw0FjyS8oJpGf+HZql8hm/m8zwXRM2o07N4dfv2JeNsSutQ/ASsVJHq6THvyrTEnHe
        rq+8Pj/9EivElXVfhH9x15CR4EJol6z8u99GhT/bLtZXpbNAH6NRDqEVU2SvSzQUKAcWWo
        vkqCpcaZfoD9xPnF8V/HU/rOpsEyGrE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-LfI7qHeKNEew0eI9yzrySw-1; Wed, 27 May 2020 14:40:39 -0400
X-MC-Unique: LfI7qHeKNEew0eI9yzrySw-1
Received: by mail-oi1-f199.google.com with SMTP id 3so13551303oip.4
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 11:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRZs2wTiBxkHiiy94lGn4R8kksbGjLYQcTj8D95VNpo=;
        b=BPx3fS+jIe+aedVT3pxbRaIiXuUxtOxgG6XkkrzWBBp8Hpb0KDCPOyv3E8Dc6vYHzw
         LbXYgXPVgVnLdsu+gVI3mohAj/SOxxLtztC8CXxu5SPqlLbSGls7/5OiNWxmEb/tjyzr
         MP3se/tg67kOC9NEYDViBtjElfjdBjzTmnhljxkjevlRKih+li1Ov7Ld3it1nQnZMIei
         +WRjLtGSdIXWWAuYZYZa5XaDOKW1yMLoBg24ylBqcIr+O8cEltDmzCsthFtAfp1q0z1z
         12oLRWvlO2sX4hf2/QrwFLxhjgQue6foAq1RTeNXDgCEpaXl/JOXIqtFOPeS07Zitzi8
         c6ow==
X-Gm-Message-State: AOAM532tNtLqHZ5u9VM1soYrYV9H3uLePlZz42mU3ZpsesJxGdgqQkEk
        K6sfclSirM2QZeQ/7voaU2UoBb67/GdNkHoH+Up7rnCIx5foTYW4DLPxdx8CCD7uK2nw6cGZ3en
        YuqZsPmxr6wKka3gfD8ATexFxQM0SQEnE7VtQiPYaKE+i
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr5687510oth.37.1590604838874;
        Wed, 27 May 2020 11:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3VpSjLAXZCBaXqBvA3zxhCB9C9K1bvDsD9zDZtYShM/wqZfQbuRrBdCBq68owOkvbbsLI3qGNMMUDkVsXqhs=
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr5687491oth.37.1590604838584;
 Wed, 27 May 2020 11:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <xunyblmcqfuu.fsf@redhat.com> <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
 <xunytv01omwj.fsf@redhat.com> <07bb723f-8174-5373-6715-65b61942080c@kernel.org>
In-Reply-To: <07bb723f-8174-5373-6715-65b61942080c@kernel.org>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 27 May 2020 21:40:22 +0300
Message-ID: <CANoWswn-onWmBG4KVzqNj3mtmRcUw1Fp5HD9Od05wYqTYYcPcg@mail.gmail.com>
Subject: Re: kselftest OOT run_tests
To:     shuah <shuah@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 27, 2020 at 9:22 PM shuah <shuah@kernel.org> wrote:
>
> On 5/27/20 1:30 AM, Yauheni Kaliuta wrote:
> > Hi, shuah!
> >
> >>>>>> On Tue, 26 May 2020 11:13:29 -0600, shuah   wrote:
> >
> >   > On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
> >   >> Hi!
> >   >>
> >   >> I'm wondering how out of tree check is supposed to work for make
> >   >> O=dir run_tests from selftests (or make -C ...) directory?
> >   >>
> >   >> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
> >   >> boolean building_out_of_srctree") and without)
> >   >>
> >   >> make M= ... does not work with run_tests.
> >   >>
> >
> >   > Kselftests run_tests target isn't intended for building and
> >   > running tests OOT.
> >
> > But there is code there trying to handle it. All that OUTPUT
> > related things must be removed if it's broken, right? Can I post
> > a patch?
> >
> >   > Also make M= doesn't make sense for them.
> >
> > Well, M=... at least includes all the makefiles.
> >
> >   > There is no support to build OOT at the moment. I would like
> >   > to get a better understanding of your use-case. Can you
> >   > elaborate?
> >
> > I care about make install actually. But fixing it I had to deal
> > with OUTPUT. Looking a proper for that I found that it's a bit
> > broken.
> >
> >
>
> kselftest supports install of all all tests and a sub-set of tests
> both native and cross-builds.
>
> Simple case:
> If you want to build all tests and install to $HOME/install/
> This has a dependency on kernel being built in the source repo
> you are running the following install command from:
>
> In Kernel source root dir run:
> make kselftest-install O=$HOME/install
>
> You will find installed tests with run script to run them all
> under $HOME/install/kselftest/kselftest_install/
>
> If you run run_kselftest.sh under kselftest_install, it will run
> all the tests.
>
> You can use TARGETS var to build a sub-set of tests.
>
> In Kernel source root dir run:
> make kselftest-install TARGETS=bpf O=$HOME/install
>

Have you tried it with the recent bpf tree? ;)

(BTW, it is a bit misleading, it's building there, not installing).

>
> Native or cross-build case when you are doing relocatable
> builds.
>
> arm64 cross-build:
> # first do a relocatable kernel build in $HOME/arm64_build
> make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
>              CROSS_COMPILE=aarch64-linux-gnu- defconfig
>
> make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
>              CROSS_COMPILE=aarch64-linux-gnu- all
>
> # install selftests (all)
> make kselftest-install O=$HOME/arm64_build ARCH=arm64 \
>              HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu-
>
> # install selftests (just bpf)
> make kselftest-install TARGETS=bpf O=$HOME/arm64_build ARCH=arm64 \
>              HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu-
>
>
> You will find kselftest installed under
>
> $HOME/arm64_build/kselftest/kselftest_install
>
> You can use the same procedure for native builds as well
> assuming your native env. is x86_64
>
> # first do a relocatable kernel build in $HOME/x86_64_build
>
> make kselftest-install TARGETS=bpf O=$HOME/x86_64_build
>
> You will find kselftest installed under
>
> $HOME/x86_64_build/kselftest/kselftest_install
>
> It is on todo to update the documentation. :(
>
> thanks,
> -- Shuah
>


-- 
WBR, Yauheni

