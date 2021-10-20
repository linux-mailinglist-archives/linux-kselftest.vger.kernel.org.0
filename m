Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E508434380
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 04:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJTCaN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 22:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTCaN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 22:30:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB5460F0F;
        Wed, 20 Oct 2021 02:27:58 +0000 (UTC)
Date:   Tue, 19 Oct 2021 22:27:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tracing: Add division and multiplication support
 for hist triggers
Message-ID: <20211019222756.1fde436b@gandalf.local.home>
In-Reply-To: <20211020013153.4106001-3-kaleshsingh@google.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-3-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 18:31:39 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> +static u64 hist_field_div(struct hist_field *hist_field,
> +			   struct tracing_map_elt *elt,
> +			   struct trace_buffer *buffer,
> +			   struct ring_buffer_event *rbe,
> +			   void *event)
> +{
> +	struct hist_field *operand1 = hist_field->operands[0];
> +	struct hist_field *operand2 = hist_field->operands[1];
> +
> +	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
> +	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
> +
> +	/* Return -1 for the undefined case */
> +	if (!val2)
> +		return -1;
> +
> +	return div64_u64(val1, val2);
> +}
> +

I wonder if you should add a shift operator as well?

I mean, if for some reason you want to divide by a power of two, then why
us the division. Especially if this is on a 32 bit machine.

Of course, the parsing could detect that. If the divisor is a constant. Or
we could even optimize the above with:

	if (!val2)
		return -1;

	if (!(val2 & (val2 - 1))
		return val1 >> __ffs64(val2);

Which should be faster than a divide, and even if it isn't a power of two,
the subtract and & should be in the noise compared to the divide.

Note, the above can be added to this. I'm not suggesting changing this
patch.

-- Steve
