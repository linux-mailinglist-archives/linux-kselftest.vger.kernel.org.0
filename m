Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0DA20328E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFVIv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgFVIvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 04:51:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF65C061794
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 01:51:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so18351941ljc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iSOzHwBaotY/UIRNioAEBuXDPVG7zu4qxXMNrK9fyc=;
        b=g1brCWmwJtbkSmFV9tqet1ryr9ApeCcCobA98O+cU+FVDj94qF4u9u0ipyjv7QP2qo
         21prTrr4rLVKagZO1Ra+ay+gNxNr917nLzNVLjeCbu4H8rSqpfyjR3kLirlWPjVNhK+T
         6QeOABhjPryupAkfoIxNCmCs1oKwrRJYxQQUcWvqw0So+1UGczY8TbVrX0AdRZxSHDUO
         UIR2+jQozywcAJJqc3Mlk6cLafjWJ1imBHjeftPy7Mr7Ml7HMaV+jqn/W2D4waHIkcom
         J1L6fq9amVsuNkhjxaOkV2BUbByvpCXBuzl8LU/7fNF4G3bmFcAly/3OtqShrxr7ehiG
         TyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iSOzHwBaotY/UIRNioAEBuXDPVG7zu4qxXMNrK9fyc=;
        b=mP9srPPTOlrt4rqpJ+sh8Blkg3tO8Iwm8Am16FMIJZtnkejSn6kjvpKsjMHx4BkB0C
         FsBAgOrV2sZ+NeNK+QiytbaboqAAsddCB+sJZD3xqlcgTnq7FE/FtDFT6un8loCIcqH1
         GGJVq/cOZz7rOO165zbhlYNwBrfZ4u9OlnHTJx+2nQVbwSpRxmNXHeUZ4e0NyMN6yuqg
         /WoB2QjddWk60GyV0/q47QDcKQikoMgBgn4c9k/cY/lI+Td8WxVykzwhzAZ1Dk3FN2eP
         4VacGLexltbO6/7scM7/6NAZEGNLmS1i1wfDWisgKwqLigf6CC/vkfQ01GaFFUqLzK6K
         SKow==
X-Gm-Message-State: AOAM530DsD728PZZKbrI7oZTq5fdNmEqpzZffZwQCOHcMVyzWDkU0hT6
        ha3e3Divp5m65oXSR1bK1uHgbdv8xdqWaGTEAsF+Rw==
X-Google-Smtp-Source: ABdhPJzPcxI7lreAQVQmWGeoQhl8ktN6/1zLDkgbhAhAe090FX+hV8+nsH6dFhqYb8sndBXmAohGrA73QF7C0Ox0Zno=
X-Received: by 2002:a05:651c:318:: with SMTP id a24mr7713808ljp.55.1592815910815;
 Mon, 22 Jun 2020 01:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
In-Reply-To: <20200508065356.2493343-1-mpe@ellerman.id.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Jun 2020 14:21:38 +0530
Message-ID: <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It is Very Rude to clear dmesg in test scripts. That's because the
> script may be part of a larger test run, and clearing dmesg
> potentially destroys the output of other tests.
>
> We can avoid using dmesg -c by saving the content of dmesg before the
> test, and then using diff to compare that to the dmesg afterward,
> producing a log with just the added lines.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/lkdtm/run.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index dadf819148a4..0b409e187c7b 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -59,23 +59,25 @@ if [ -z "$expect" ]; then
>         expect="call trace:"
>  fi
>
> -# Clear out dmesg for output reporting
> -dmesg -c >/dev/null
> -
>  # Prepare log for report checking
> -LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
> +LOG=$(mktemp --tmpdir -t lkdtm-log-XXXXXX)
> +DMESG=$(mktemp --tmpdir -t lkdtm-dmesg-XXXXXX)
>  cleanup() {
> -       rm -f "$LOG"
> +       rm -f "$LOG" "$DMESG"
>  }
>  trap cleanup EXIT
>
> +# Save existing dmesg so we can detect new content below
> +dmesg > "$DMESG"
> +
>  # Most shells yell about signals and we're expecting the "cat" process
>  # to usually be killed by the kernel. So we have to run it in a sub-shell
>  # and silence errors.
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>
>  # Record and dump the results
> -dmesg -c >"$LOG"
> +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true

We are facing problems with the diff `=%>` part of the option.
This report is from the OpenEmbedded environment.
We have the same problem from livepatch_testcases.

# selftests lkdtm BUG.sh
lkdtm: BUG.sh_ #
# diff unrecognized option '--changed-group-format=%>'
unrecognized: option_'--changed-group-format=%>' #
# BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
v1.27.2: (2020-03-30_164108 #
#
: _ #
# Usage diff [-abBdiNqrTstw] [-L LABEL] [-S FILE] [-U LINES] FILE1 FILE2
diff: [-abBdiNqrTstw]_[-L #
# BUG missing 'kernel BUG at' [FAIL]

Full test output log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200621/testrun/2850083/suite/kselftest/test/lkdtm_BUG.sh/log

-- 
Linaro LKFT
https://lkft.linaro.org
