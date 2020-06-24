Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B38206F14
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbgFXIj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 04:39:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388836AbgFXIj6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 04:39:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBB7BAC2E;
        Wed, 24 Jun 2020 08:39:55 +0000 (UTC)
Date:   Wed, 24 Jun 2020 10:39:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <20200624083955.GF8444@alley>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2020-06-23 23:48:36, Joe Lawrence wrote:
> On 6/22/20 4:51 AM, Naresh Kamboju wrote:
> > On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > 
> > > It is Very Rude to clear dmesg in test scripts. That's because the
> > > script may be part of a larger test run, and clearing dmesg
> > > potentially destroys the output of other tests.
> > > 
> > > We can avoid using dmesg -c by saving the content of dmesg before the
> > > test, and then using diff to compare that to the dmesg afterward,
> > > producing a log with just the added lines.
> > >
> > > > > > diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> > > index dadf819148a4..0b409e187c7b 100755
> > > --- a/tools/testing/selftests/lkdtm/run.sh
> > > +++ b/tools/testing/selftests/lkdtm/run.sh
> > >   # Record and dump the results
> > > -dmesg -c >"$LOG"
> > > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> > 
> > We are facing problems with the diff `=%>` part of the option.
> > This report is from the OpenEmbedded environment.
> > We have the same problem from livepatch_testcases.
> > 
> > # selftests lkdtm BUG.sh
> > lkdtm: BUG.sh_ #
> > # diff unrecognized option '--changed-group-format=%>'
> > unrecognized: option_'--changed-group-format=%>' #
> > # BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
> > v1.27.2: (2020-03-30_164108 #
> > #
> > : _ #
> > # Usage diff [-abBdiNqrTstw] [-L LABEL] [-S FILE] [-U LINES] FILE1 FILE2
> > diff: [-abBdiNqrTstw]_[-L #
> > # BUG missing 'kernel BUG at' [FAIL]
> > 
> > Full test output log,
> > https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200621/testrun/2850083/suite/kselftest/test/lkdtm_BUG.sh/log
> > 
> 
> D'oh!  Using diff's changed/unchanged group format was a nice trick to
> easily fetch the new kernel log messages.
> 
> I can't think of any simple alternative off the top of my head, so here's a
> kludgy tested-once awk script:
> 
>  SAVED_DMESG="$(dmesg | tail -n1)"
>  ... tests ...
>  NEW_DMESG=$(dmesg | awk -v last="$SAVED_DMESG" 'p; $0 == last{p=1}')
> 
> I think timestamps should make each log line unique, but this probably won't
> handle kernel log buffer overflow.

The test would fail anyway if there was log buffer overflow.

We could check if the last line was still there and
suggest to increase the log buffer size in the error message.

> Maybe it would be easier to log a known unique test delimiter msg and then
> fetch all new messages after that?

The timestamp should be enough to distinguish any message.

But some visual separator between each test is useful anyway. And
it might include some random string...

Best Regards,
Petr
