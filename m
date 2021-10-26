Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34543B518
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhJZPJe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 11:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhJZPJ1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 11:09:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FB0604AC;
        Tue, 26 Oct 2021 15:07:02 +0000 (UTC)
Date:   Tue, 26 Oct 2021 11:07:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-ID: <20211026110700.3be13865@gandalf.local.home>
In-Reply-To: <20211026214311.583c728d90d41778c38201dd@kernel.org>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211026214311.583c728d90d41778c38201dd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 21:43:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > new file mode 100644
> > index 000000000000..e715641c54d3
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > @@ -0,0 +1,72 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test histogram expression parsing
> > +# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log  
> 
> Hmm, are there any way to check the running kernel supports this feature?
> Because the latest version of the kselftest is expected to run on the old stable
> kernel for testing, the testcase should check whether the kernel supports this
> testing feature or not. (That's why the requires tag supports README pattern check)
> 
> So, at first if you didn't update the <tracefs>/README, please update it first
> to show the new syntax is supported, and add "SOME-PATTERN":README to the
> requires tag.

Yes, please update the README in kernel/trace/trace.c readme_msg[].

I'll look at the other patches, and if they are fine, I may just apply them.

-- Steve
