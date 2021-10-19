Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F458433FEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhJSUr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 16:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhJSUr6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 16:47:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940CE60EFF;
        Tue, 19 Oct 2021 20:45:44 +0000 (UTC)
Date:   Tue, 19 Oct 2021 16:45:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: Add division and multiplication support
 for hist triggers
Message-ID: <20211019164543.2ca20830@gandalf.local.home>
In-Reply-To: <20210915195306.612966-3-kaleshsingh@google.com>
References: <20210915195306.612966-1-kaleshsingh@google.com>
        <20210915195306.612966-3-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Sep 2021 19:52:46 +0000
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
> +	return val1 / val2;

This wont work on x86 32 bit machines, as u64 division will trigger
floating point arithmetic by the compiler, and cause a fault.

You'll need to use one of the div64() helpers.

-- Steve


> +}
> +
