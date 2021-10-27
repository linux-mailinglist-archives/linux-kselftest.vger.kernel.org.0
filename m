Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17C43BE6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 02:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJ0AVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 20:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhJ0AVO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 20:21:14 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437C86103B;
        Wed, 27 Oct 2021 00:18:49 +0000 (UTC)
Date:   Tue, 26 Oct 2021 20:18:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 6/8] tracing/histogram: Optimize division by a power
 of 2
Message-ID: <20211026201846.08990d1d@rorschach.local.home>
In-Reply-To: <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-7-kaleshsingh@google.com>
        <20211026151451.7f3e09a4@gandalf.local.home>
        <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 16:39:13 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> >         // This works best for small divisors
> >         if (div > max_div) {
> >                 // only do a real division
> >                 return;
> >         }
> >         shift = 20;
> >         mult = ((1 << shift) + div - 1) / div;
> >         delta = mult * div - (1 << shift);
> >         if (!delta) {
> >                 /* div is a power of 2 */
> >                 max = -1;
> >                 return;
> >         }
> >         max = (1 << shift) / delta;  
> 
> I'm still trying to digest the above algorithm. 

mult = (2^20 + div - 1) / div;

The "div - 1" is to round up.

Basically, it's doing:  X / div  = X * (2^20 / div) / 2^20

If div is constant, the 2^20 / div is constant, and the "2^20" is the
same as a shift.

So multiplier is 2^20 / div, and the shift is 20.

But because there's rounding errors it is only accurate up to the
difference of:

  delta = mult * div / 2^20

That is if mult is a power of two, then there would be no rounding
errors, and the delta is zero, making the max infinite:

  max = 2^20 / delta as delta goes to zero.

> But doesn't this add 2 extra divisions? What am I missing here?

The above is only done at parsing not during the trace, where we care
about.

> > 
> >
> > We would of course need to use 64 bit operations (maybe only do this for 64
> > bit machines). And perhaps even use bigger shift values to get a bigger max.
> >
> > Then we could do:
> >
> >         if (val1 < max)
> >                 return (val1 * mult) >> shift;

This is done at the time of recording.

Actually, it would be:

	if (val1 < max)
		return (val1 * mult) >> shift;
	else
		return val1 / div;

-- Steve
