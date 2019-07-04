Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464D45F7C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2019 14:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfGDMPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jul 2019 08:15:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41744 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfGDMPT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jul 2019 08:15:19 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hj0dc-0001hq-3T
        for linux-kselftest@vger.kernel.org; Thu, 04 Jul 2019 12:14:56 +0000
Received: by mail-wr1-f69.google.com with SMTP id p13so2357082wru.17
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Jul 2019 05:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZ17bZ+LXx4n8vNZTmDIWxMdFlyXwsk5RUf0bS977CM=;
        b=SyVUd6D4EM2DX4vjDMA9tcaUj8WcQ5jaFD9RFrx3QtVGFCeafolpSOMwrO+tRn1Mkw
         KSWQ7sGf6rSJqe7eUg9t6+xgoe0+bHFAwum4PzQYQNL1cKsLA2PEzJw7KiqSaW4d2ZbR
         JltNpz+ie3Ic6hLCdE2cGH2woaVqKQJ+MNboDpyCDFmE3Db/KNrKJaalDl2fq0eWWRjJ
         gosY8ZAKnXzFsdykmhgSnzQiQNfsHCn4tANnBayaElWOtWRitDU5B+pKWRoDWOvuq7EM
         zgq54YkfzcvcrSVsVoFDtpra5W4rQLxkm0qx0NZJC1O+qBTmoabh4GKgJF2u2qzH1n0p
         j+xw==
X-Gm-Message-State: APjAAAX7LpPNxWRSIG26LURCeCUkK0k07m3EesSyl/Ols/tKD4rMGFXF
        OCfnsISvdNbvgJgt7n1qO2maXqvLgsAMP2bPx1hI7e4F1o5HdQITOcUnTicXIudi94K/ckVNQi7
        xtBJVYkUtd/UpmRzRvOe7sknLTWleYihL4Sz/BnTfwejkTZV9nB6niwDqlL0O
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr12784521wmh.141.1562242495769;
        Thu, 04 Jul 2019 05:14:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzr9KvQewn+s3Th0jDrKNYrXcqI2Rjwqqcxd1Q4ngnxYl05qDeiBNbrM6WbfZXW4O9eKeA6LARlvTTIuUHJRdI=
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr12784503wmh.141.1562242495442;
 Thu, 04 Jul 2019 05:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190702062358.7330-1-po-hsu.lin@canonical.com>
 <4a44dd22-be88-ce5b-5c9b-6a3759b6c2eb@kernel.org> <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
In-Reply-To: <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 4 Jul 2019 20:14:44 +0800
Message-ID: <CAMy_GT9nyu-NZJ0SUr19GZZ7Jap_8KHAQ_nSd7kTSw2vovyomg@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not enabled
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     shuah <shuah@kernel.org>, rostedt@goodmis.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,
Thanks all for your feedback!

On Wed, Jul 3, 2019 at 8:11 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Po-Hsu Lin,
>
> On Tue, 2 Jul 2019 13:22:26 -0600
> shuah <shuah@kernel.org> wrote:
>
> > Hi Po-Hsu Lin,
> >
> > On 7/2/19 12:23 AM, Po-Hsu Lin wrote:
> > > The ftrace test will need to have CONFIG_FTRACE enabled to make the
> > > ftrace directory available.
> > >
> > > Add an additional check to skip this test if the CONFIG_FTRACE was not
> > > enabled.
>
> Sorry, NAK for config check.
>
> > >
> > > This will be helpful to avoid a false-positive test result when testing
> > > it directly with the following commad against a kernel that does not
> > > have CONFIG_FTRACE enabled:
>
> Would you know tools/testing/selftests/ftrace/config (and other config files
> in each tests) ?
>
> Since each selftest depends specific configurations, those configs are
> written in config file, and tester must enable it using
> "scripts/kconfig/merge_config.sh".
>
> We can not check the kernel config in some cases, e.g. distro kernel,
> cross-build kernel, remote build kernel etc. Also, the .config file
> can be a config file for another kernel build.
>
> So please take care of your kernel configuration. If you find any test
> failed even if you enable configs in config file under that test, please
> report it, since that is a bug.
>
Yes I'm aware the config file.

People can still run a test directly without enabling corresponding
configs, so I think it's better to skip it if possible, directory
checking proposed by Steven looks better for this.

And thank you the explanation about the possible issue for a config check.

>
> Thank you,
>
> > >      make -C tools/testing/selftests TARGETS=ftrace run_tests
> > >
> > > The test result on an Ubuntu KVM kernel will be changed from:
> > >      selftests: ftrace: ftracetest
> > >      ========================================
> > >      Error: No ftrace directory found
> > >      not ok 1..1 selftests: ftrace: ftracetest [FAIL]
> > > To:
> >
> > Thanks for the patch.
> >
> > Check patch fails with the above To:
> >
> > WARNING: Use a single space after To:
> > #107:
> > To:
> >
> > ERROR: Unrecognized email address: ''
> > #107:
> > To:
> >
> > total: 1 errors, 1 warnings, 23 lines checked
> >

This is an interesting error here,
it looks like this checkpatch.pl script cannot identify the "To:" is
actually located inside the commit message.
I have to change this into something else to avoid this error.


> >
> > Please fix and send v2.
> >
> > >      selftests: ftrace: ftracetest
> > >      ========================================
> > >      CONFIG_FTRACE was not enabled, test skipped.
> > >      not ok 1..1 selftests: ftrace: ftracetest [SKIP]
> > >
> > > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > > ---
> > >   tools/testing/selftests/ftrace/ftracetest | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > > index 6d5e9e8..6c8322e 100755
> > > --- a/tools/testing/selftests/ftrace/ftracetest
> > > +++ b/tools/testing/selftests/ftrace/ftracetest
> > > @@ -7,6 +7,9 @@
> > >   #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> > >   #
> >
> > Hmm. You havem't cc'ed Masami on this. Adding Masami.
> >
> > I would think Masami should be on the Signed-off-by as well,
> > since he is the author.
> >
> > >
> > > +# Kselftest framework requirement - SKIP code is 4.
> > > +ksft_skip=4
> > > +
> > >   usage() { # errno [message]
> > >   [ ! -z "$2" ] && echo $2
> > >   echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
> > > @@ -139,7 +142,13 @@ parse_opts $*
> > >
> > >   # Verify parameters
> > >   if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
> > > -  errexit "No ftrace directory found"
> > > +  ftrace_enabled=`grep "^CONFIG_FTRACE=y" /lib/modules/$(uname -r)/build/.config`
> > > +  if [ -z "$ftrace_enabled" ]; then
> > > +    echo "CONFIG_FTRACE was not enabled, test skipped."
> > > +    exit $ksft_skip
> > > +  else
> > > +    errexit "No ftrace directory found"
> > > +  fi
> > >   fi
> > >
> > >   # Preparing logs
> > >
> >
> > thanks,
> > -- Shuah
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
