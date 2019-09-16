Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D758B398F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIPLjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 07:39:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39025 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbfIPLje (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 07:39:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id s19so2736274lji.6
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2019 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f5a1BChAu3dyalw+cUTX4tLGbm1QRrKJw1j9muYZIGY=;
        b=TrzOfFUYFDWcU0Mm7IHUprpprBHhyiuhR38gvj9ZpcefblJY/uh/SlOYG7cY0/nw+M
         ySXaxrk4fmlzmj4F8Yym3H2AdB53Ep4gnRJywFN1E6b44xVK/7Hz2JoGruyXKeJUz3Hm
         qflyd1hMBUkNctqsc03vQiNeu7BIRFUlwhDts2gUV2acheK/t9JrpGuDGGBiSPU1DuUc
         Fe462Hzo9eWyTXsmC/XtNQZJwkGXAFfa0UALKMZR7MrZeqMzEqjfoPeXEhGVRWgtIr6l
         FeOF3ZPimXy8vkV4VyHgPV1gMPcTrG8sgExqCI2l9rRzBVk7Ves8n0L/s+7rA4GMtQH9
         d3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f5a1BChAu3dyalw+cUTX4tLGbm1QRrKJw1j9muYZIGY=;
        b=QUarqLEv2mz7RkDkyyQrcW9WPcg5Si1xfL75Hjg+Kgr1fPy4RTSFbEhTq7qii6EyCg
         AqyOWDoDEDbY5uSrhBV540+OFN7jh0tSgulmE8JMW9q3rvwC7O5Fs66q7KmOTUV0vBh5
         k62jeSWj3TwUZnUE3YbJjnP9gFV5ak6TMTm19yHxufhtqAuJX9Z+dfCq33V0BG0mUNiW
         dfTlV2UPxTe7NWm6FQPulBRMQAQHnZXA1KFDmcTDg80E/j0q2vaJZewZuuQxXEmL9F+l
         fQ/CTI3JVmfITF2nK2ceG6n2OX0s8QAPYkCKPXmSkmWc3uihjNldzDvClT6lSElocFc2
         PlBg==
X-Gm-Message-State: APjAAAXVMUNqT+yNugwHo0rFgN1+dFMD/tA3xdVATGyM8ji6XwCffCZ9
        CTdCCvizASWnJXV+TaOSF+O3jjwHeKA/Pm/3HSvSSw==
X-Google-Smtp-Source: APXvYqyF/vTMBQLIzMMmA4MjGs9N3Z29+Zd/qyQLXrhaXqKygcunzLEXfGCFRRSdXb2lj+2ry3V6W4CO/6S/R61sOck=
X-Received: by 2002:a2e:9218:: with SMTP id k24mr37512846ljg.35.1568633971209;
 Mon, 16 Sep 2019 04:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568224280.git.esyr@redhat.com>
In-Reply-To: <cover.1568224280.git.esyr@redhat.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 16 Sep 2019 13:39:20 +0200
Message-ID: <CADYN=9KM5YWat7Fbh52hB4=pjpwPRO5o62=Jg+D3SnEATy3CeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Update clone3 self-tests
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Adrian Reber <areber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 11 Sep 2019 at 20:02, Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> Hello.
>
> This patch set updates clone3 selftest in several aspects:
>  - adding checks for exit_signal invalid values handling;
>  - adding clone3 to selftests targets;
>  - enabling clone3 tests on all architectures;
>  - minor cleanups of the clone3 test.
>
> This respin alignes additional clone3 self-tests with v3 of the
> exit_signal checking patch[1].
>
> Applied on top of brauer/linux.git/for-next.
>
> Changes since v2[2]:
>  - CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG check is now expected to fail.
>
> Changes since v1[3]:
>  - exit_signal check extended to cover more cases of invalid
>    exit_signal value.
>
> [1] https://lkml.org/lkml/2019/9/11/677
> [2] https://lkml.org/lkml/2019/9/10/768
> [3] https://lkml.org/lkml/2019/9/10/416
>
> Eugene Syromiatnikov (6):
>   selftests/clone3: convert test modes into an enum
>   selftests/clone3: add a check for invalid exit_signal
>   selftests/clone3: use uint64_t for flags parameter
>   selftests/clone3: fix up format strings
>   selftests/clone3: enable clone3 self-tests on all architectures
>   selftests: add clone3 to TARGETS

I wasn't able to build this patchset for arm64, I applied it on tag
next-20190904:

$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -skj$(getconf
_NPROCESSORS_ONLN) headers_install
$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -skj$(getconf
_NPROCESSORS_ONLN) -C tools/testing/selftests/clone3

clone3_set_tid.c: In function =E2=80=98raw_clone=E2=80=99:
clone3_set_tid.c:22:17: error: =E2=80=98__NR_clone3=E2=80=99 undeclared (fi=
rst use in
this function); did you mean =E2=80=98raw_clone=E2=80=99?
  return syscall(__NR_clone3, args, sizeof(struct clone_args));
                 ^~~~~~~~~~~
                 raw_clone
clone3_set_tid.c:22:17: note: each undeclared identifier is reported
only once for each function it appears in
make: *** [../lib.mk:138:
/srv/src/kernel/kselftest-testing/tools/testing/selftests/clone3/clone3_set=
_tid]
Error 1
clone3.c: In function =E2=80=98raw_clone=E2=80=99:
clone3.c:41:17: error: =E2=80=98__NR_clone3=E2=80=99 undeclared (first use =
in this
function); did you mean =E2=80=98raw_clone=E2=80=99?
  return syscall(__NR_clone3, args, size);
                 ^~~~~~~~~~~
                 raw_clone
clone3.c:41:17: note: each undeclared identifier is reported only once
for each function it appears in
make: *** [../lib.mk:138:
/srv/src/kernel/kselftest-testing/tools/testing/selftests/clone3/clone3]
Error 1
make: Target 'all' not remade because of errors.


Any idea what I'm doing wrong?

Cheers,
Anders

>
>  tools/testing/selftests/Makefile        |  1 +
>  tools/testing/selftests/clone3/Makefile |  4 +--
>  tools/testing/selftests/clone3/clone3.c | 64 +++++++++++++++++++++++++++=
+-----
>  3 files changed, 57 insertions(+), 12 deletions(-)
>
> --
> 2.1.4
>
