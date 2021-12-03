Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1238467DE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 20:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhLCTQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 14:16:04 -0500
Received: from foss.arm.com ([217.140.110.172]:52600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239754AbhLCTQD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 14:16:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE971396;
        Fri,  3 Dec 2021 11:12:39 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5553F5A1;
        Fri,  3 Dec 2021 11:12:38 -0800 (PST)
Date:   Fri, 3 Dec 2021 19:12:36 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sjpark@amazon.de, shuah@kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add optional command
 parameters in settings
Message-ID: <20211203191236.GG56473@e120937-lin>
References: <20211202142056.17386-1-cristian.marussi@arm.com>
 <202112021310.E1B3208@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112021310.E1B3208@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 02, 2021 at 01:18:35PM -0800, Kees Cook wrote:
> On Thu, Dec 02, 2021 at 02:20:56PM +0000, Cristian Marussi wrote:
> > Some testcases allow for optional commandline parameters but as of now
> > there is now way to provide such arguments to the runner script.
> > 
> > Add support to the per-test-directory "settings" file to provide such
> > optional arguments; two new optional fields can now be defined in
> > "settings":
> > 
> >  - args="<options>": general arguments common to all testcase commands in
> >    the test directory
> > 
> >  - <BASENAME_TEST>_args="<options>": custom arguments specific to only one
> >    specific testcase command
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

Hi Kees,

thanks for the review.

> > Used to configure the use of a specific rtc device on CI systems with:
> >  tools/testing/selftests/rtc/settings:
> >    timeout=90
> >    rtctest_args="/dev/rtc1"
> 
> I like this idea generally, but I have some concern that this is
> muddling the test's settings ("do not expect me to finish before
> timeout=90") vs the local system's settings ("here is where to find the
> rtc to test"). I can't, however, think of a better way to handle this
> currently. :P
> 

The idea stems from the need to workaround some broken setup in CI, but
beside this (which is opinable) then I realized that, indeed, the rtctest
could already accept as first argument the rtc to use but simply there's
no way as of now to pass any argument down to the tests through the
run_kselftest/runner scripts, so, it seemed to me a general nice to have
for any kind of test that needs local configuration, beside the specific
issue I was facing.

So basically enabling a mechanism that allows me to tell the CI automation
guys how to overlay a specific platform tests-config on top of the default
one found in setting, right before the test starts.

At the end, both timeouts and test-specific args are configuration params
with the only difference that the first is general the second address
test specific capabilities.
(there are quite a few: egrep -R "argv\[1\]" tools/testing/selftests/)

> Is this case common enough that a given test shouldn't, instead, just
> take config from environment variables set by the CI?
> 
That would mean patch every single test though, right ? or do you mean
maybe instead using the same variable indirection mechanism as it is now
but let the CI system provide the exported var instead of picking it from
the overlayed settings file like:

export kselftest_rtctest_args=/dev/rtc1; /opt/ksft/run_kselftest.sh -c rtc

...in fact it works fine on my local setup and maybe it's better than the
overlaying thing for the CI perspective

> (Also, will we need to worry in the future about running the same test
> multiple times with different system settings? ("try each of these /dev
> nodes...")
> 

I would let this to be in charge of the CI automation machinery (if they
want to run multiple runs with different setups and so different ENVs)

> Is there a patch for the changes to the RTC test?
> 

The rtctest already interprets argv[1] as the rtc to use, if provided and,
as said, I was thinking to use this as a CI-directed overlaying mechanism,
so that's no need of further patches to the test to be commited upstream
(if this was what you meant)

> > ---
> >  tools/testing/selftests/kselftest/runner.sh | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index a9ba782d8ca0..f877a8571927 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -49,6 +49,15 @@ run_one()
> >  
> >  	# Reset any "settings"-file variables.
> >  	export kselftest_timeout="$kselftest_default_timeout"
> > +
> > +	# Optional arguments for any command, possibly defined in settings
> > +	# as args="<options>"
> > +	kselftest_args=""
> > +
> > +	# Optional arguments for this command, possibly defined in settings
> > +	# as <$BASENAME_TEST>_args="<options>"
> > +	kselftest_cmd_args_ref="kselftest_${BASENAME_TEST}_args"
> > +
> >  	# Load per-test-directory kselftest "settings" file.
> >  	settings="$BASE_DIR/$DIR/settings"
> >  	if [ -r "$settings" ] ; then
> > @@ -69,7 +78,8 @@ run_one()
> >  		echo "# Warning: file $TEST is missing!"
> >  		echo "not ok $test_num $TEST_HDR_MSG"
> >  	else
> > -		cmd="./$BASENAME_TEST"
> > +		eval kselftest_cmd_args="\$$kselftest_cmd_args_ref"
> 
> nitpit: Just to avoid tripping any future work to gracefully handle
> unset variables, maybe this could specify an empty-string default:
> 
> 		eval kselftest_cmd_args="\${$kselftest_cmd_args_ref:-}"
> 

Right, I'll fix.

Thanks again,
Cristian

