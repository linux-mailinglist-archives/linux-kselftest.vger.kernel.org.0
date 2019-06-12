Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC342EB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFLS36 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 14:29:58 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38035 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFLS36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 14:29:58 -0400
Received: by mail-io1-f52.google.com with SMTP id k13so13787287iop.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQkZCQxFoQUkZfxWv9OEhzoncFxWotQHK1Gs9MUv1eA=;
        b=DscpfkVHpoVJrPEj936BY0NpwocME1pU2zrFpusFS6THPzJHoZsSUdD+M93I3wUeAM
         mA8uLUwYm88ZYwXyLGIOs8wDumR3OU2EQJQuZCC27V8GlmS7x6w0F30NAzu620wqB5vM
         kG5vw2JoMf4spR/srC5xH0mP5xbODbmJnHtcFe7H3uCz7Xzj4CyHbChqj/xAVuYmylE0
         DfaxMiopWqOX5DNZSh9kfwBIhLvygtGB2RuDTnSZtj9TO9LuavXD5T+qIyAizALeubRK
         1Dfep3nsj9pY/iDyc+LvV2ItJ1C62KQRpWkerW7VDqDWQg4oboVWoQxNdASLQf42yCOs
         zXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQkZCQxFoQUkZfxWv9OEhzoncFxWotQHK1Gs9MUv1eA=;
        b=fNtVbDVpVIxNxD0LCMNSLghCpoFr81qIJSaW9KoHJ5mbEI4k8zG/jVD1nIIGe5d5bg
         VEe0YEYKavRQiUk/QYpKWO1pIM4BZJf/gPQBM9yCy4Xjt5p5/qOeJyv3GOxI1ZGTXN1u
         UWuFWY2mevR3bzUZQxv10CvvEg5ulOYqj+iVsSagWwPU9JqLAscSizkO1eFaF4Vp4kCP
         wyi+E9aNQW9EIXuUnTIk6FtXbEliuigPNYTsl3DUF1Lf9P65RO0NsjL2YNJ6OhQcWnzK
         7ZqPrg3x4lxorZ4otXhXrCQ9OzKL3fiFouXs+PckAg25efoH+onHFa46lK+L1hGl0pkC
         cv6g==
X-Gm-Message-State: APjAAAV956dc3d+4KPV4zfsVBlj9ZThdyDYhL4cYtRjSdFle/qeDhqTZ
        jhym19qvpqfmKlBNiZqQx/MsStaYgB4rUdmBofIxSII95+3ssw==
X-Google-Smtp-Source: APXvYqzH+rbVpVXfkTTvElMEIRrDYXIOIfM8dHuSOu2lfLrQAWrgPoK1L/lFuDGFWQoi+CKD/24+w02CM4CMHbHJ4kw=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr2981744ior.231.1560364197232;
 Wed, 12 Jun 2019 11:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com> <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org>
In-Reply-To: <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 20:29:44 +0200
Message-ID: <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 6:45 PM shuah <shuah@kernel.org> wrote:
> Hi Dmitry,
>
> This is the 6th email from you in a span of 3 hours! I am just going to
> respond this last one. Please try to summarize your questions instead of
> sending email storm, so it will be easier to parse and more productive
> for both of us.

Hi Shuah,

Sorry for that. Let me combine all current questions in a more structured w=
ay.

My motivation: I am trying to understand what does it take to run/add
kernel tests in particular for the purpose of providing working
instructions to run kernel test to a new team member or a new external
kernel developer, and if it's feasible to ask a kernel developer
fixing a bug to add a regression test and ensure that it works. Note
in these cases a user may not have lots of specific expertise (e.g.
any unsaid/implicit thing may be a showstopper) and/or don't have
infinite motivation/time (may give up given a single excuse to do so)
and/or don't have specific interest/expertise in the tested subsystem
(e.g. a drive-by
fix). So now I am trying to follow this route myself, documenting steps.

1. You suggested to install a bunch of packages. That helped to some
degree. Is there a way to figure out what packages one needs to
install to build the tests other than asking you?

2. Build of bpf tests was broken after installing all required
packages. It helped to delete some random files
(tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}). Is it
something to fix in kselftests? Deleting random files was a chaotic
action which I can't explain to anybody.

3. I am still getting 1 build error:

  CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/selftests=
/bpf/str_error.o
timestamping.c:249:19: error: =E2=80=98SIOCGSTAMP=E2=80=99 undeclared (firs=
t use in
this function); did you mean =E2=80=98SIOCGSTAMPNS=E2=80=99?

What should I do to fix this?

4. Are individual test errors are supposed to be fatal? Or I can just
ignore a single error and proceed?
I've tried to proceed, but I am not sure if I will get some
unexplainable errors later because of that. By default I would assume
that any errors during make are fatal.

5. The instructions on running tests:

  $ make -C tools/testing/selftests run_tests
  $ make kselftest

Do they assume that the tests will run right on my host machine? It's
not stated/explained anywhere, but I don't see how "make kselftest"
can use my usual setup because it don't know about it.
I cannot run tests on the host. Policy rules aside, this is yet
untested kernel, so by installing it I am risking losing my whole
machine.
Reading further, "Install selftests" and "Running installed selftests"
sections seem to be a way to run tests on another machine. Is it
correct? Are there any other options? There seems to be a bunch of
implicit unsaid things, so I am asking in case I am missing some even
simpler way to run tests.
Or otherwise, what is the purpose of "installing" tests?

6. The "Running installed selftests" section says:
"Kselftest install as well as the Kselftest tarball provide a script
named "run_kselftest.sh" to run the tests".

What is the "Kselftest tarball"? Where does one get one? I don't see
any mentions of "tarball" anywhere else in the doc.

7. What image am I supposed to use to run kselftests? Say, my goal is
either running as many tests as possible (CI scenario), or tests for a
specific subsystem (a drive-by fix scenario).
All images that I have do not seem to be suitable. One is failing with:
./run_kselftest.sh: 2: ./run_kselftest.sh: realpath: not found
And there is no clear path to fix this. After I guessed the right
package to install, it turned out to be broken in the distro.
In another image all C programs fail to run with:
./test_maps: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.26'

How is one supposed to get an image suitable for running kselftests?

8. Lots of tests fail/skipped with some cryptic for me errors like:

# Cannot find device "ip6gre11"

# selftests: [SKIP] Could not run test without the ip xdpgeneric support

# modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could
not open moddep file '/lib/modules/5.1.0+/modules.dep.bin'

# selftests: bpf: test_tc_edt.sh
# nc is not available
not ok 40 selftests: bpf: test_tc_edt.sh

Say, I either want to run tests for a specific subsystem because I am
doing a drive-by fix (a typical newcomer/good Samaritan scenario), or
I want to run as many tests as possible (a typical CI scenario). Is
there a way to bulk satisfy all these prerequisite (configs, binaries
and whatever they are asking for)?

9. There is a test somewhere in the middle that consistently reboots my mac=
hine:

# selftests: breakpoints: step_after_suspend_test
[  514.024889] PM: suspend entry (deep)
[  514.025959] PM: Syncing filesystems ... done.
[  514.051573] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[  514.054140] OOM killer disabled.
[  514.054764] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  514.057695] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
early console in extract_kernel
...

Is it a bug in the test? in the kernel? Or how is this supposed to
work/what am I supposed to do with this?

10. Do you know if anybody is running kselftests? Running as in
running continuously, noticing new failures, reporting these failures,
keeping them green, etc.
I am asking because one of the tests triggers a use-after-free and I
checked it was the same 3+ months ago. And I have some vague memories
of trying to run kselftests 3 or so years ago, and there was a bunch
of use-after-free's as well.

11. Do we know what's the current code coverage achieved by kselftests?
What's covered? What's not? Overall percent/per-subsystem/etc?

12. I am asking about the aggregate result, because that's usually the
first thing anybody needs (both devs testing a change and a CI). You
said that kselftest does not keep track of the aggregate result. So
the intended usage is always storing all output to a file and then
grepping it for "[SKIP]" and "[FAIL]". Is it correct?

Thanks in advance for bearing with me.
