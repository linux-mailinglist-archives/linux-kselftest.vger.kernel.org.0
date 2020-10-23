Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED782972DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463936AbgJWPtv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 11:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463832AbgJWPtv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 11:49:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E25120878;
        Fri, 23 Oct 2020 15:49:50 +0000 (UTC)
Date:   Fri, 23 Oct 2020 11:49:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201023114948.6900aa68@gandalf.local.home>
In-Reply-To: <20201023151243.GA1537@oc3871087118.ibm.com>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
        <20201023093523.65c495f8@gandalf.local.home>
        <20201023151243.GA1537@oc3871087118.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Oct 2020 17:12:44 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> > Perhaps we should have:
> > 
> > 	# older kernels have do_fork, but newer kernels have kernel_clone
> > 	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter  
> 
> Would you suggest to do the same with all occurences in
> eea11285dab3 ("tracing: switch to kernel_clone()")?
> Otherwise it does not really make sense to just fix couple
> of tests out of dozens.

Yes. I haven't pulled in the updated tests, so I haven't hit the errors yet
(nor have I merged my work with the switch to the new name yet). So those
will most definitely break my tests.

But because it's a more generic issue, we should have a way to find what to
use. Perhaps add to the test.d/functions, something like:

FUNCTION_FORK=`(if grep '\bkernel_clone\b' /proc/kallsyms > /dev/null; then
                echo kernel_clone; else echo '_do_fork'; fi)`

and use $FUNCTION_FORK everywhere that references it.

-- Steve
