Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D201520ADC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgFZICz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 04:02:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgFZICy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 530B5ABE2;
        Fri, 26 Jun 2020 08:02:52 +0000 (UTC)
Date:   Fri, 26 Jun 2020 10:02:52 +0200
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
Message-ID: <20200626080252.GL8444@alley>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
 <20200624083955.GF8444@alley>
 <20200624201247.GA25319@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624201247.GA25319@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-06-24 16:12:47, Joe Lawrence wrote:
> On Wed, Jun 24, 2020 at 10:39:55AM +0200, Petr Mladek wrote:
> > On Tue 2020-06-23 23:48:36, Joe Lawrence wrote:
> > > On 6/22/20 4:51 AM, Naresh Kamboju wrote:
> > > > On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > > > 
> > > > > It is Very Rude to clear dmesg in test scripts. That's because the
> > > > > script may be part of a larger test run, and clearing dmesg
> > > > > potentially destroys the output of other tests.
> > > > > 
> > > > > We can avoid using dmesg -c by saving the content of dmesg before the
> > > > > test, and then using diff to compare that to the dmesg afterward,
> > > > > producing a log with just the added lines.
> > > > >
> > > > > > > > diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> > > > > index dadf819148a4..0b409e187c7b 100755
> > > > > --- a/tools/testing/selftests/lkdtm/run.sh
> > > > > +++ b/tools/testing/selftests/lkdtm/run.sh
> > > > >   # Record and dump the results
> > > > > -dmesg -c >"$LOG"
> > > > > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> > > > 
> > > > We are facing problems with the diff `=%>` part of the option.
> > > > This report is from the OpenEmbedded environment.
> > > > We have the same problem from livepatch_testcases.
> > > > 
> > > > # selftests lkdtm BUG.sh
> > > > lkdtm: BUG.sh_ #
> > > > # diff unrecognized option '--changed-group-format=%>'
> > > > unrecognized: option_'--changed-group-format=%>' #
> > > > # BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
> > > > v1.27.2: (2020-03-30_164108 #

> I did a bit more hacking to work that awk script into the livepatching
> tests.  The changes aren't too bad and coding it ourselves lets us drop
> the temporary dmesg file business.  If this looks good, I can send out
> as a real patch, but then that raises a few questions:

The patch worked and I agree that it is not that bad.

Well, what about using "comm" as proposed by Michael in the other
mail? It seems to be part of coreutils and should be everywhere.

I guess that many people, including me, are not fluent in awk.
So, I am slightly in favor of the "comm" approach ;-)


>   1 - f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running
>       tests") has already merged, updating that file doesn't look too
>       difficult, but will need a Fixes tag and should probably go
>       through Shuah's tree.

Yup.

>   2 - We haven't actually merged the livepatch copy yet.  I can roll
>       another version of that patchset, substituting a fix for the
>       problematic patch, or we could just tack this one on at the end.
>       In fine with either approach.

I prefer the followup patch to avoid rebase.

Best Regards,
Petr
