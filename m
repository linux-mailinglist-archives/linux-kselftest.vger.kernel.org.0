Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5546C164EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBST0a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 14:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBST0a (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 14:26:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E60208E4;
        Wed, 19 Feb 2020 19:26:28 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:26:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     shuah@kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>, mhiramat@kernel.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ftrace/selftest: clean up failure cases
Message-ID: <20200219142627.716090a0@gandalf.local.home>
In-Reply-To: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Shuah,

Can you take these two patches through your tree?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Wed, 19 Feb 2020 09:33:28 +0000
Alan Maguire <alan.maguire@oracle.com> wrote:

> When running the ftrace selftests, 2 failures and 6 unresolved
> cases were observed.  The failures can be avoided by setting
> a sysctl prior to test execution (fixed in patch 1) and by
> having unresolved cases not return 0 from ftracetest by default
> since they indicate an absence of testing modules/programs
> rather than ftrace issues (patch 2).
> 
> The latter are classified as "unresolved" tests, which operate
> differently from "unsupported" tests.  For unsupported tests,
> we note the unsupported count but do not consider the tests
> as having failed, whereas with unresolved the test run is
> considered to have failed so returns "not ok" when run via
> kselftest ("make -C tools/testing/selftest/ftrace run_tests").
> 
> Patch 2 aligns the unresolved behaviour with the unsupported;
> by default, unresolved outcomes do not trigger overall failure,
> but they can if --fail-unresolved is specified.
> 
> Changes since v1:
> 
> - updated patch 1 to use /proc path instead of sysctl (Masami)
> - updated patch 2 to modify unresolved handling in ftracetest
>   rather than change individual unresolved -> unsupported (Masami)
> 
> Alan Maguire (2):
>   ftrace/selftests: workaround cgroup RT scheduling issues
>   ftrace/selftest: make unresolved cases cause failure if
>     --fail-unresolved set
> 
>  tools/testing/selftests/ftrace/ftracetest | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 

