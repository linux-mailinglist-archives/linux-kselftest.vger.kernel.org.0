Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1783D1A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfFKQDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 12:03:44 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:35247 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390180AbfFKQDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 12:03:44 -0400
Received: by mail-it1-f178.google.com with SMTP id n189so5646711itd.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2019 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bbC2HlAaeGaI6XYG23mMzi2D9r/xdtJIjJqHaWFIUu8=;
        b=N11BuGeZlLCH66f7ijCwCtpiVoWNe1zMubIVK23Yd7lpH+fwK3KR5c/9bMQnMioaLB
         Y1zhUntQNyK07pxmIzjMqZsTxuHz+gcsBv3uESJXseJQwuCHWKhRa34ztLCXLGS6ZdN6
         n/96sACZYUYG6HBFe0a+HfOuTkF6w1ZhgkRuxJlFefZ0BmEWGihlIjG2XlIP5ZP2RBFn
         2sNEMHTRMCgV4AFfWDDftmdPQJG+fM5qiTrqnUZYPZHAwWPaKUvWOTM1riqRaGfWD4N+
         0D/TjiIFZrc9qVb0STZ7dmUueZw4GnoNiTiyr04ZT3oy+xBbgjbLc1vvwgQAl6fj6t63
         9ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bbC2HlAaeGaI6XYG23mMzi2D9r/xdtJIjJqHaWFIUu8=;
        b=SbBo1sSatU99SSNYCVmTjf1oiAKOOaX9PQ9hjIYO73f3FJQ2+YsDkbxwVY1axjN0iA
         o4ZKiS2Pa9fZVT6eskfSLrauFObgAkZ4N17adl/0rjwlfqcweAUf8kUcShvfVWrozcAS
         ZleGkyABut+keB0LcWE9HibbtFOFMqzqUA++XoNXFAxinOCU4u6vh8hQmCx5ggLLDVdW
         9iyA/rb2U8fodpXZs+1eHg/+/2zGAz9oZPei9M7mRJ5kYv7/MXAb0Lv5RwJPX37fZZjx
         8koLpul+gx7Gb/exPB6CqrjnCVslTs2osVw1fOT4UYVSfSDaEwR3Wq23QdFjBSAJH3fQ
         GcTQ==
X-Gm-Message-State: APjAAAUcz5M5sKA6trHeCrpAvBTa0nw29e6kQ6/aEKioTrfcJreZ1F82
        QbCI8HLRqQvfVUryr+h4hFw84wUfHN52c8OddHwAXxv5gH+xAQ==
X-Google-Smtp-Source: APXvYqwubymTq/IgQCzOOK/NB4fEGb6z9y5g8+UUD10G2E34i4AHQTy7QfoTpmRNEUPGVHVFw8uK2RNO455tTbLUqnU=
X-Received: by 2002:a24:4417:: with SMTP id o23mr19643967ita.88.1560269022833;
 Tue, 11 Jun 2019 09:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
In-Reply-To: <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jun 2019 18:03:29 +0200
Message-ID: <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
>
> Hi Dmitry,
>
> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
> > Hi,
> >
> > I've tried to build kselftests for several years now, but I always
> > find the build broken. Which makes me wonder if the instructions are
> > broken or something. I follow the instructions in
> > Documentation/dev-tools/kselftest.rst and start with "make -C
> > tools/testing/selftests". Here is the errors I get on the upstream
> > commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
> > > error: unable to create target: 'No available targets are compatible
> > with triple "bpf"'
> > 1 error generated.
> > Makefile:259: recipe for target 'elfdep' failed
> > Makefile:156: recipe for target 'all' failed
> > Makefile:106: recipe for target
> > '/linux/tools/testing/selftests/bpf/libbpf.a' failed
> > test_execve.c:4:10: fatal error: cap-ng.h: No such file or directory
>
> These errors are due to missing dependencies. You will need
>
> libmount-dev
> libcap-ng-dev
> libelf-dev
>
> for bpf to build and also clang
>
> > ../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/capabilities/test_execve' failed
> > gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such file or d=
irectory > <builtin>: recipe for target 'gpio-mockup-chardev' failed
> > fuse_mnt.c:17:10: fatal error: fuse.h: No such file or directory
>
> libfuse-dev is missing.
>
> > ../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
> > collect2: error: ld returned 1 exit status
> > ../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
>
> Needs libpopt-dev
>
> > reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file or direct=
ory
>
> Needs libnuma-dev
>
> > ../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
> > mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
> > or directory > ../lib.mk:138: recipe for target
> > '/linux/tools/testing/selftests/vm/mlock-random-test' failed
> >
> > Here is full log:
> >
> > https://gist.githubusercontent.com/dvyukov/47430636e160f297b657df5ba2ef=
a82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
> >
> > I have libelf-dev installed. Do I need to install something else? Or
> > run some other command?
>
> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 development
> libraries and
> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read and write
> ELF fil
>
>
> All of the above built for me on Linux 5.2-rc4. Try installing all of
> these and let me know if you still see problems.


Hi Shuah,

Thanks for quick reply!

I've installed these: libmount-dev libcap-ng-dev libfuse-dev
libpopt-dev libnuma-dev.
libelf-dev I already had. And for clang I switched to distro-provided one.

This reduced number of errors, but I still see some:

clang: error: unable to execute command: Broken pipe
clang: error: clang frontend command failed due to signal (use -v to
see invocation)
Makefile:259: recipe for target 'elfdep' failed
Makefile:156: recipe for target 'all' failed
Makefile:106: recipe for target
'/linux/tools/testing/selftests/bpf/libbpf.a' failed
timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared (firs=
t use in
this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?
../../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/networking/timestamping/timestamping'
failed
mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
or directory
../lib.mk:138: recipe for target
'/linux/tools/testing/selftests/vm/mlock-random-test' failed

Full log:
https://gist.githubusercontent.com/dvyukov/5c334e7e7e136909cb66b23b9fb7d439=
/raw/965f84bd99deb361dcb567ce2e2654db5d270138/gistfile1.txt
