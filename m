Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9812C43BA74
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhJZTRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 15:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhJZTRS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 15:17:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897D16108D;
        Tue, 26 Oct 2021 19:14:53 +0000 (UTC)
Date:   Tue, 26 Oct 2021 15:14:51 -0400
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
Message-ID: <20211026151451.7f3e09a4@gandalf.local.home>
In-Reply-To: <20211025200852.3002369-7-kaleshsingh@google.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-7-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Oct 2021 13:08:38 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> == Results ==
> 
> Divisor is a power of 2 (divisor == 32):
> 
>    test_hist_field_div_not_optimized  | 8,717,091 cpu-cycles
>    test_hist_field_div_optimized      | 1,643,137 cpu-cycles
> 
> If the divisor is a power of 2, the optimized version is ~5.3x faster.
> 
> Divisor is not a power of 2 (divisor == 33):
> 
>    test_hist_field_div_not_optimized  | 4,444,324 cpu-cycles
>    test_hist_field_div_optimized      | 5,497,958 cpu-cycles

To optimize this even more, if the divisor is constant, we could make a
separate function to not do the branch, and just shift or divide.

And even if it is not a power of 2, for constants, we could implement a
multiplication and shift, and guarantee an accuracy up to a defined max.


If div is a constant, then we can calculate the mult and shift, and max
dividend. Let's use 20 for shift.

	// This works best for small divisors
	if (div > max_div) {
		// only do a real division
		return;
	}
	shift = 20;
	mult = ((1 << shift) + div - 1) / div;
	delta = mult * div - (1 << shift);
	if (!delta) {
		/* div is a power of 2 */
		max = -1;
		return;
	}
	max = (1 << shift) / delta;

We would of course need to use 64 bit operations (maybe only do this for 64
bit machines). And perhaps even use bigger shift values to get a bigger max.

Then we could do:

	if (val1 < max)
		return (val1 * mult) >> shift;

-- Steve
