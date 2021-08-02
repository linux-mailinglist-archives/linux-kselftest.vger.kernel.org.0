Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F13DDC98
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhHBPht (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 11:37:49 -0400
Received: from foss.arm.com ([217.140.110.172]:37718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233939AbhHBPhs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 11:37:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C144911D4;
        Mon,  2 Aug 2021 08:37:38 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA19F3F66F;
        Mon,  2 Aug 2021 08:37:37 -0700 (PDT)
Date:   Mon, 2 Aug 2021 16:36:15 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210802153614.GC25258@arm.com>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
 <20210729160642.GP1724@arm.com>
 <20210729173411.GT4670@sirena.org.uk>
 <20210802102517.GA25258@arm.com>
 <20210802113330.GD4668@sirena.org.uk>
 <20210802123749.GB25258@arm.com>
 <20210802141939.GF4668@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802141939.GF4668@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 02, 2021 at 03:19:39PM +0100, Mark Brown wrote:
> On Mon, Aug 02, 2021 at 01:37:50PM +0100, Dave Martin wrote:
> > On Mon, Aug 02, 2021 at 12:33:30PM +0100, Mark Brown wrote:
> 
> > > That really doesn't seem like a good idea - it's just asking for
> > > fragility if a signal gets delivered to the parent process or something.
> > > Even if almost all the time there will only be one trip through the loop
> > > we should still have the loop there for those few cases where it
> > > triggers.
> 
> > This concern only applies when the program actually registers signal
> > handlers.
> 
> > wait() can't return for any other reason, and it mustn't, precisely
> > because historically software would have made this assumption.  This is
> > one reason why wait3() etc. are separate functions.
> 
> That's great for the reader with a detailed knowledge of exactly what
> error handling can be skipped and how standards conforming Linux is but
> less good for the reader who is merely aware of best practices.  I am
> not clear what the problem that is solved by removing the loop here is
> TBH - to me it just makes it less obvious that we've handled everything.

Ok, leave it as is then.

(It would be good to collect some best-practice guidance on how to
actually use syscalls, but that's clearly way out of scope here...)

> > That aside though, can't we use popen(3)?
> 
> > I tend to forget about popen because it is "boring" to use it, but it
> > looks like it fits this case quite well.  Then it would be libc's
> > problem how to fork and wait safely.
> 
> popen() appears to be break the _SET_VL_ONEXEC test.  Between a lack of
> strace in my test filesystem and not spotting anything obvious in the
> glibc sources I can't tell exactly where it's doing something different,
> though it does feel like it should be a separate testcase if it's
> anything interesting.  I do think there is value in having exactly
> what's done to start the child process be clear in the test program, and
> that coverage of anything interesting from popen() could be done
> incrementally.

Ah, dang, popen() will run the target program via a shell, so there will
actually be two fork-exec()s, with the VL being reset to default by the
second exec.

Using PR_SET_SET_VL with popen() still makes sense, but if you want the
target program to get the new VL (not just the shell) then you'd need
PR_SVE_VL_INHERIT.  Then we would get confused later when trying to
test the !PR_SVE_VL_INHERIT case.  The way to "fix" this would be to
have the shell invoke something like vlset, but that will blur the test
in a different way, adding even more confusion.

So Ack, we can't test all the variations using the popen() method, so we
probably shouldn't use it here at all.  

This is the kind of reason why I tend not to go for it, I guess --
it looks convenient, but it's just that little bit overcooked as an API.
*sigh*


I'll review your final version of the series, but I guess we're all good.

Cheers
---Dave
