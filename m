Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D37263AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgIJB7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIJBhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB88C061372;
        Wed,  9 Sep 2020 18:21:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so3605363qtw.5;
        Wed, 09 Sep 2020 18:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCjRFBD7NU49turQlnVW81Mg28iHO5E7HqPSd/MOeR4=;
        b=DKUWKouS+Lpfjuq6qitHH5Aki/47pGmwkydGG/Zg3J/0WS0im0P0fGNAyojixo6br2
         XKn45CZCKbkBpBLAPcs2N5+MR0W4PZH70ZUI07WRA9OaYlSREwJwElUSe2gatjoMR8ol
         roxlhIIUaVZGYLVbKXvDqN309H88Xt6SXRuxD//WwGqgPFDdGe0kn6ni3bj/dZyi8Byv
         h5sCEgDIkCaWakY/90spLLWZYvmnpBjWVowljpr+tlTIJ8FktiZjWnDotbfJZL7NXLMl
         pjASqkDnoSsq1hSrI2PtTSSpilaEwAu698R51bLQPma3dKcbpbqnl2cB6LWsOgzji2C4
         rWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCjRFBD7NU49turQlnVW81Mg28iHO5E7HqPSd/MOeR4=;
        b=m7G8jweQ14tztcXly0nvpkaIWFS/s2LevSthwpQhMwqF7d65IWCsazWbeZXtdqO1hV
         5W+tTjCDqMh1ZVvxmbNg7izZgl2cxQ2fQFAruoreBWQWWmOdxYBh4u++U0vowcPPJ39v
         dbHEw/plMZub+dx7XCwzchWE7d1fz49e1SqbWAm7DhejmtmXer8qXiA1pugVEnS9B3wq
         aOUSg1+OBDwz+L+6JdYNsXo4ixh++G0AfBr86/Ikdf0S3GN9SrcZEF62eXEPUo5QEDYF
         7pZqiRbKLqsvsemHKUQ10esRjunBocJHYiNr8V1zoJxpRpj+NwD12lKyn9CKlsfD7o6+
         zaCQ==
X-Gm-Message-State: AOAM530aKcRAMC7sUF0jUh89g+jAOvmsuN2YxBgJQoP8jUpuxtGnBVom
        /15Af4ryU7BfuTyFKSmiPTEjI6DXYch7IzQnU7SktqnXo8E=
X-Google-Smtp-Source: ABdhPJw5ALkYeIGw8hE6RyBHu894F7qwoDbjGlLPy8ECKmz83tbtyWSX/ohdJVbqOduC+kplj+d96pJVZEhg0O5TdgY=
X-Received: by 2002:ac8:743:: with SMTP id k3mr6124648qth.182.1599700865339;
 Wed, 09 Sep 2020 18:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200309101256.868-1-liuhangbin@gmail.com> <20200316072626.24037-1-liuhangbin@gmail.com>
In-Reply-To: <20200316072626.24037-1-liuhangbin@gmail.com>
From:   Hangbin Liu <liuhangbin@gmail.com>
Date:   Thu, 10 Sep 2020 09:20:54 +0800
Message-ID: <CAPwn2JR=WzpuMjA=x+39GFAbXpTFLt16bcD37LyfH5NtU=Mqvw@mail.gmail.com>
Subject: Re: [RFC PATCHv2] selftests/run_kselftest.sh: make each test
 individually selectable
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

What do you think of this change? Any comments?
If you are OK, I can rebase the patch and repost it.

Thanks
Hangbin

On Mon, 16 Mar 2020 at 15:26, Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Currently, after generating run_kselftest.sh, there is no way to choose
> which test we could run. All the tests are listed together and we have
> to run all every time. This patch enhanced the run_kselftest.sh to make
> the tests individually selectable. e.g.
>
>   $ ./run_kselftest.sh -t "bpf size timers"
>
> Note: I use `tr -s "/-" "_"` to cover the path name to function name in
> tests. e.g. networking/timestamping -> networking_timestamping.
>
> Before the patch:
>
> $ cat run_kselftest.sh
> \#!/bin/sh
> BASE_DIR=$(realpath $(dirname $0))
> cd $BASE_DIR
> . ./kselftest/runner.sh
> ROOT=$PWD
> if [ "$1" = "--summary" ]; then
>   logfile=$BASE_DIR/output.log
>   cat /dev/null > $logfile
> fi
> [ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
> cd android
> run_many        \
>         "run.sh"
> cd $ROOT
> ...<snip>...
> [ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
> cd zram
> run_many        \
>         "zram.sh"
> cd $ROOT
>
> After the patch:
> $ cat run_kselftest.sh
> \#!/bin/sh
> BASE_DIR=$(realpath $(dirname $0))
> . ./kselftest/runner.sh
> TESTS="android ...<snip>... zram"
>
> run_android()
> {
>         [ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
>         cd android
>         run_many        \
>                 "run.sh"
>         cd $ROOT
> }
>
> ...<snip>...
>
> run_zram()
> {
>         [ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
>         cd zram
>         run_many        \
>                 "zram.sh"
>         cd $ROOT
> }
>
> usage()
> {
>         cat <<EOF
> usage: ${0##*/} OPTS
>         -s | --summary          Only print summary info and put detailed log in output.log
>         -t | --tests            Test name you want to run specifically
>         -h | --help             Show this usage info
> EOF
> }
>
> while true; do
>         case "$1" in
>         -s | --summary ) logfile=$BASE_DIR/output.log; cat /dev/null > $logfile; shift ;;
>         -t | --tests ) TESTS=$2; shift 2 ;;
>         -h | --help ) usage; exit 0;;
>         "" ) break;;
>         * ) usage; exit 1;;
>         esac
> done
>
> cd $BASE_DIR
> ROOT=$PWD
> for test in $TESTS; do
>         run_$test
> done
>
> v2: update document and commit description.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/dev-tools/kselftest.rst |  4 +++
>  tools/testing/selftests/Makefile      | 48 +++++++++++++++++++++------
>  tools/testing/selftests/lib.mk        |  2 +-
>  3 files changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 61ae13c44f91..e856713a1deb 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -151,6 +151,10 @@ note some tests will require root privileges::
>     $ cd kselftest
>     $ ./run_kselftest.sh
>
> +Or you can run some specific test cases in the installed Kselftests by::
> +
> +   $ ./run_kselftest.sh -t "bpf size timers"
> +
>  Contributing new tests
>  ======================
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index be22dbe94a4c..5481ea0634cf 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -212,13 +212,9 @@ ifdef INSTALL_PATH
>         @# Ask all targets to emit their test scripts
>         echo "#!/bin/sh" > $(ALL_SCRIPT)
>         echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
> -       echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
>         echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
> -       echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
> -       echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
> -       echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
> -       echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
> -       echo "fi" >> $(ALL_SCRIPT)
> +       echo "TESTS=\"$(TARGETS)\"" | tr -s "/-" "_" >> $(ALL_SCRIPT)
> +       echo "" >> $(ALL_SCRIPT);
>
>         @# While building run_kselftest.sh skip also non-existent TARGET dirs:
>         @# they could be the result of a build failure and should NOT be
> @@ -226,15 +222,47 @@ ifdef INSTALL_PATH
>         for TARGET in $(TARGETS); do \
>                 BUILD_TARGET=$$BUILD/$$TARGET;  \
>                 [ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> -               echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
> -               echo "cd $$TARGET" >> $(ALL_SCRIPT); \
> -               echo -n "run_many" >> $(ALL_SCRIPT); \
> +               echo "run_$$TARGET()" | tr -s "/-" "_" >> $(ALL_SCRIPT); \
> +               echo "{" >> $(ALL_SCRIPT); \
> +               echo -e "\t[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
> +               echo -e "\tcd $$TARGET" >> $(ALL_SCRIPT); \
> +               echo -en "\trun_many" >> $(ALL_SCRIPT); \
>                 echo -n "Emit Tests for $$TARGET\n"; \
>                 $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
>                 echo "" >> $(ALL_SCRIPT);           \
> -               echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
> +               echo -e "\tcd \$$ROOT" >> $(ALL_SCRIPT); \
> +               echo "}" >> $(ALL_SCRIPT); \
> +               echo "" >> $(ALL_SCRIPT); \
>         done;
>
> +       echo "usage()" >> $(ALL_SCRIPT);
> +       echo "{" >> $(ALL_SCRIPT);
> +       echo -e "\tcat <<EOF" >> $(ALL_SCRIPT);
> +       echo "usage: \$${0##*/} OPTS" >> $(ALL_SCRIPT);
> +       echo -e "\t-s | --summary\t\tOnly print summary info and put detailed log in output.log" >> $(ALL_SCRIPT);
> +       echo -e "\t-t | --tests\t\tTest name you want to run specifically" >> $(ALL_SCRIPT);
> +       echo -e "\t-h | --help\t\tShow this usage info" >> $(ALL_SCRIPT);
> +       echo "EOF" >> $(ALL_SCRIPT);
> +       echo "}" >> $(ALL_SCRIPT);
> +       echo "" >> $(ALL_SCRIPT);
> +
> +       echo "while true; do" >> $(ALL_SCRIPT);
> +       echo -e "\tcase \"\$$1\" in" >> $(ALL_SCRIPT);
> +       echo -e "\t-s | --summary ) logfile=\$$BASE_DIR/output.log; cat /dev/null > \$$logfile; shift ;;" >> $(ALL_SCRIPT);
> +       echo -e "\t-t | --tests ) TESTS=\$$2; shift 2 ;;" >> $(ALL_SCRIPT);
> +       echo -e "\t-h | --help ) usage; exit 0;;" >> $(ALL_SCRIPT);
> +       echo -e "\t\"\" ) break;;" >> $(ALL_SCRIPT);
> +       echo -e "\t* ) usage; exit 1;;" >> $(ALL_SCRIPT);
> +       echo -e "\tesac" >> $(ALL_SCRIPT);
> +       echo "done" >> $(ALL_SCRIPT);
> +       echo "" >> $(ALL_SCRIPT);
> +
> +       echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
> +       echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
> +
> +       echo "for test in \$$TESTS; do" >> $(ALL_SCRIPT); \
> +       echo -e "\trun_\$$test" >> $(ALL_SCRIPT); \
> +       echo "done" >> $(ALL_SCRIPT); \
>         chmod u+x $(ALL_SCRIPT)
>  else
>         $(error Error: set INSTALL_PATH to use install)
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..2dc5a0cca6f3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -107,7 +107,7 @@ emit_tests:
>         for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
>                 BASENAME_TEST=`basename $$TEST`;        \
>                 echo "  \\";                            \
> -               echo -n "       \"$$BASENAME_TEST\"";   \
> +               echo -ne "\t\t\"$$BASENAME_TEST\"";     \
>         done;                                           \
>
>  # define if isn't already. It is undefined in make O= case.
> --
> 2.19.2
>
