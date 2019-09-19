Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3EB8323
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbfISVLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 17:11:06 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:41683 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732924AbfISVLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 17:11:05 -0400
Received: by mail-pg1-f174.google.com with SMTP id s1so1456728pgv.8
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6chP0Jk8rLCzBcCjbBKcXglY2CnF5xku1bIcPvrJsbc=;
        b=jJ8Z1Bl9H1HgKSPzujWtNiq7i2pPe6C4eggOZI92o3+wyC3PPSNAISgV6gbelsBH08
         Or/lhiLaLN0eaqGyPBNy+Ii6lNHLJHrjBpkrTaGCiF+6/oqHv9lyAzQkurUDj7pD+VL8
         Rszo+VR3XoSxgjmzeLBRi+3N73rCUTVdwVa38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6chP0Jk8rLCzBcCjbBKcXglY2CnF5xku1bIcPvrJsbc=;
        b=GYPe5ftpHB3AVsCVIHq+dS86IPkssrvY4TMrg9ycuaMycdKlmN8pD3AuQKJtYRKVws
         geeNEN8bmF2pKHkBxjH0jGc+OVGB3RH+BU5Sxz3ztnF2qv6yKiMropunXC/FmITkCbDS
         ncLOeTDwxCCSSWYiiSlj6Zdl+GiPc/bbZMf7BWTgV55d5k9rQj3Z9/RCmGifjnRBoWD8
         3WACOTwN+tXN3/crnx39/EJckcNu94LuSeVeHqXvZPQJ+IrtwLJavR4e1hrhDhUdOHl0
         4n+hGfLYr+Exn5mRHp1sICsYpkNG32GaXFN63huDqQ2rzK5UW7LF9zBPsXhSmKs7zhPT
         fBUw==
X-Gm-Message-State: APjAAAXJw2vOF5/UR/hY+yvDHPfas926P3CNK4YXaEoak7ni+JQGAIIk
        JSph4osILIwARe/6CyPITE0SMA==
X-Google-Smtp-Source: APXvYqxm6La4+LFVHtAEPcA6FPlj/HQFIZbg6xz7EZzCBQIR9Bmoodg06gPea30OEy5hF6Z0iMXelA==
X-Received: by 2002:a65:6550:: with SMTP id a16mr9064325pgw.115.1568927462921;
        Thu, 19 Sep 2019 14:11:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x125sm11492420pfb.93.2019.09.19.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:11:02 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:11:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tim.Bird@sony.com
Cc:     shuah@kernel.org, anders.roxell@linaro.org,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
Message-ID: <201909191359.1BFD926842@keescook>
References: <201909191102.97FA56072@keescook>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 19, 2019 at 08:41:42PM +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Kees Cook
> > 
> > Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> > test") solves the problem of kselftest_harness.h-using binary tests
> > possibly hanging forever. However, scripts and other binaries can still
> > hang forever. This adds a global timeout to each test script run.
> > 
> > To make this configurable (e.g. as needed in the "rtc" test case),
> > include a new per-test-directory "settings" file (similar to "config")
> > that can contain kselftest-specific settings. The first recognized field
> > is "timeout".
> 
> OK - this is quite interesting.  I have had on my to-do list an action
> item to propose the creation of a file (or a standard kerneldoc string)
> to hold CI-related meta-data (of which timeout is one example).

FWIW, I opt for a "per directory settings" file here because per-test
seemed like overkill.

> What other meta-data did you have in mind?

I figured in the future it could hold details about expected environmental
states (user, namespace, rlimits, etc). For example, I'd like to
indicate that the seccomp tests should be run twice both as root and as
a regular user.

> I would like (that Fuego, and probably other CI systems would like) to have
>  access to data like test dependencies, descriptions, and results interpretation
> that would be beneficial for both CI systems (using them to control test invocations and scheduling), as
> well as users who are trying to interpret and handle the test results.
> So this concept is a very welcome addition to kselftest.

I think this stuff may still be very per-test specific, but regardless,
having it in a single place makes it easy to scrape. :)

> LTP is in the process of adopting a new system for expressing and handling their test meta-data.
> See the discussion at: 
> https://lists.yoctoproject.org/pipermail/automated-testing/2019-August/000471.html
> and the prototype implementation at:
> https://github.com/metan-ucw/ltp/tree/master/docparse

This looks like similar framework details: _how_ to run a test in a
given environment.

> One example of a specific field that would be handy is 'need_root'.

I think describing (possibly multiple) expected environments would be
more useful, but perhaps just user alone would be a nice start.

> It would be nice to avoid proliferation of such meta-data schemas (that is
> field names), so maybe we can have a discussion about this before adopting
> something?
> 
> Just FYI, I'm OK with the name 'timeout'.  I think that's pretty much universally
> used by all CI runners I'm aware of to indicate the test timeout value.  But
> before adopting other fields it would be good to start comparing notes
> and not invent a bunch of new field names for concepts that are already in
> other systems.

Yeah, I figure "timeout" could stand and other things would need more
infrastructure.

> > +		if [ $rc -eq $skip_rc ]; then	\
> >  			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
> > +		elif [ $rc -eq $timeout_rc ]; then \
> > +			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
> This is an extension to the TAP protocol (well, not strictly, since it is in a comment),
> but it should be documented.

Right -- this is a "weird" corner of TAP-14. It says there can be "#"
with everything after it semantically ignored, but that "# SKIP" is
special. I think clarification of the spec here would be to have the
format be:

not ok name name name # DETAIL ignored ignored ignored

Where the meaningful DETAIL words could be SKIP, TIMEOUT, FAIL.

> I took an action item at the CKI hackfest to rigorously document the
> details of how kselftest has extended (or augmented) TAP.  For example
> our indentation mechanism for sub-tests.  You and I talked about this
> a bit at Plumbers, but I'd like to follow up and add something
> to Documentation/dev-tools/kselftest.rst so users and CI systems
> can know how to appropriately parse and manage kselftest TAP output.
> 
> I'll start a separate thread on that when I get to documenting it,
> but this would definitely be an addition to that documentation.
> 
> >  		else
> > -			echo "not ok $test_num $TEST_HDR_MSG"
> > +			echo "not ok $test_num $TEST_HDR_MSG #
> > exit=$rc"
> Is this also something new to kselftest's TAP output that should be documented?

Right, if we made more the "SKIP" meaningful and required a specific
detail here, this could just be "... # FAIL exit=$rc" unless we _wanted_
to make the exit code be parsed. Then maybe "... # EXIT=$rc" ?

> 
> >  		fi)
> >  		cd - >/dev/null
> >  	fi
> > diff --git a/tools/testing/selftests/rtc/settings
> > b/tools/testing/selftests/rtc/settings
> > new file mode 100644
> > index 000000000000..ba4d85f74cd6
> > --- /dev/null
> > +++ b/tools/testing/selftests/rtc/settings
> > @@ -0,0 +1 @@
> > +timeout=90
> 
> This is introducing a schema for meta-data naming, and a first field name.
> I have no problem with this one, but it might be worth comparing it with
> names expected by various kselftest-calling  CI systems.  I'll try to work
> on this shortly and report back any issues.
> 
> Thanks for this.  I think this points us in an interesting new direction.

Cool; I'm glad you like it! I really do want to get timeouts nailed down
since Shuah mentioned that was a pain point. While I solved it for
seccomp via the kselftest_harness.h timeout, there have been other
cases of stalls that aren't handled by that change.

-- 
Kees Cook
