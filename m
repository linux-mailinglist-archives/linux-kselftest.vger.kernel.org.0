Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3A87A2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406815AbfHIMci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 08:32:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406657AbfHIMch (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 08:32:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE991596;
        Fri,  9 Aug 2019 05:32:36 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24BDD3F706;
        Fri,  9 Aug 2019 05:32:36 -0700 (PDT)
Date:   Fri, 9 Aug 2019 13:32:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] kselftest: arm64: adds first test and common
 utils
Message-ID: <20190809123233.GM10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-3-cristian.marussi@arm.com>
 <20278fdd-95d0-060f-088d-aba8ac2b0b01@arm.com>
 <20190809111635.GL10425@arm.com>
 <4a73fcdf-911e-b44a-ce6b-f9bcde34eec8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a73fcdf-911e-b44a-ce6b-f9bcde34eec8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 09, 2019 at 01:20:45PM +0100, Cristian Marussi wrote:
> 
> Hi
> 
> On 8/9/19 12:16 PM, Dave Martin wrote:
> >On Fri, Aug 09, 2019 at 11:54:06AM +0100, Cristian Marussi wrote:
> >>Hi
> >>
> >>On 8/2/19 6:02 PM, Cristian Marussi wrote:
> >>>Added some arm64/signal specific boilerplate and utility code to help
> >>>further testcase development.
> >>>
> >>>A simple testcase and related helpers are also introduced in this commit:
> >>>mangle_pstate_invalid_compat_toggle is a simple mangle testcase which
> >>>messes with the ucontext_t from within the sig_handler, trying to toggle
> >>>PSTATE state bits to switch the system between 32bit/64bit execution state.
> >>>Expects SIGSEGV on test PASS.
> >>>
> >>>Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >>>---

[...]

> >>diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> >>index 31788a1d33a4..c0f3cd1b560a 100644
> >>--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
> >>+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> >>@@ -23,21 +23,25 @@ extern struct tdescr *current;
> >>  static int sig_copyctx = SIGTRAP;
> >>  static char *feats_store[FMAX_END] = {
> >>-       "SSBS",
> >>-       "PAN",
> >>-       "UAO",
> >>+       " SSBS ",
> >>+       " PAN ",
> >>+       " UAO ",
> >>  };
> >>  #define MAX_FEATS_SZ   128
> >>+static char feats_string[MAX_FEATS_SZ];
> >>+
> >>  static inline char *feats_to_string(unsigned long feats)
> >>  {
> >>-       static char feats_string[MAX_FEATS_SZ];
> >>+       for (int i = 0; i < FMAX_END; i++) {
> >>+               size_t tlen = 0;
> >>-       for (int i = 0; i < FMAX_END && feats_store[i][0]; i++) {
> >>-               if (feats & 1UL << i)
> >>-                       snprintf(feats_string, MAX_FEATS_SZ - 1, "%s %s ",
> >>-                                feats_string, feats_store[i]);
> >>+               if (feats & 1UL << i) {
> >>+                       strncat(feats_string, feats_store[i],
> >
> >Should this be feats_string + tlen?
> >
> 
> strncat appends to the end of a NULL terminated string overwriting the NULL itself and
> appending its own NULL (as long as dest and src do not overlap and fits the max size param),
> so it must be fed the start of the dest string to which we are appending
>
> >>+                               MAX_FEATS_SZ - 1 - tlen);

I see.  Yes, you're right -- I was confusing strncat() with strncpy().

> >An assert(tlen <= MAX_FEATS_SZ - 1) is probably a good idea here,
> >in case more features are added to feats_store[] someday.
> >
> 
> Yes in fact...if not it would be simply truncated silently

I think MAX_FEATS - 1 - tlen would overflow.  tlen is a size_t, so the
result would might be a giant unsigned number in this case, leading to a
potential buffer overrun in strncat().

> 
> >>+                       tlen += strlen(feats_store[i]);
> >>+               }
> >
> >Don't we need to initialise tlen outside the loop?  Otherwise we just
> >zero it again after the +=.
> 
> ..and that's a bug :<

OK

> >
> >>         }
> >>         return feats_string;
> >>@@ -190,7 +194,7 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
> >>                 /* it's a bug in the test code when this assert fail */
> >>                 assert(!current->sig_trig || current->triggered);
> >>                 fprintf(stderr,
> >>-                       "SIG_OK -- SP:%p  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",
> >>+                       "SIG_OK -- SP:%llX  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",
> >
> >For consistency, can we have a "0x" prefix?
> >
> >I think %p usually generates a "0x" prefix by itself, so 0x%p might give
> >a double prefix.
> >
> 
> Yes you are right.
> 
> Moreover I'm in doubt what to do generally with all these stderr
> output, because I optionally discard to null testing standalone, but
> this is not what the KSFT framework runner script does, so
> arm64/signal tests end up being overly verbose when run from the
> framework (even if tests use anyway the KSFT exit codes conventions
> so all the results are correctly reported); but I suppose I'll
> receive a clear indication on this matter from the maintainers at the
> end...

Sure, keep the prints for now.  If they're potentially useful we can
always find a way to make them optional.

Cheers
---Dave
