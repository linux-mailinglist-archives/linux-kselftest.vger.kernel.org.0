Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949494343A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJTC5j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 22:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTC5i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 22:57:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2CF26052B;
        Wed, 20 Oct 2021 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634698525;
        bh=lrE9AqvkgTJNc+6kPuxY92F7aQFAi4cPD8wMvZJl43w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grldJGgsLlVYS7aLGpfyR7Ygw6HSU6aFXv6CyEXzFWNHWBT6YSTVZEfKEXhKT3Tgc
         x5ghsTIWdMuSrF8sJ8yejQ9rXEn2RRbZ/+xd926GD039dhmDNWYydvuZRwoTWZ9RNh
         wktP6SgK3VbxqetNOmK8Ghxep0ZZVATy9ZN6twpvMlcPenxJ77hRVIqQcRXtTdjdNn
         w/Pg3k+nCuw0zSFstVFOYvcEewOdtoTdUqyMpPhiZF6Vol8dn4HhSZ3Mjkky1Jz9Hq
         7fFFAc0pgfrrYJT5YtT+gYRIGhyj2WQlIbQSWP3oZdDKJAIjQAscd0so36f0cXvCFj
         tsXHEtQxfpS4w==
Date:   Wed, 20 Oct 2021 11:55:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
In-Reply-To: <20211019223454.5da09d74@gandalf.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 22:34:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Oct 2021 11:20:27 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hmm, by the way, shouldn't we set this feature by default?
> > There are many "cat trace | grep ..." style test code in ftracetest just for
> > checking whether the event is recorded. At least for the ftracetest, it should
> > be set unless the testcase is explicitly disable it.
> 
> For testing, sure.
> 
> I was criticized by the BPF folks about tracing stopping when the trace
> file was being read. So for normal operations, it doesn't pause, because
> that "confuses" people (so I am told).

OK, I got it.

Here is the patch to enable it by default for ftracetest :)

Thanks!

From 61e641f494307d9942a8415bc6743e85dd95438e Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 20 Oct 2021 11:50:35 +0900
Subject: [PATCH] selftests/ftrace: Stop tracing while reading the trace file
 by default

Stop tracing while reading the trace file by default, to prevent
the test results while checking it and to avoid taking a long time
to check the result.
If there is any testcase which wants to test the tracing while reading
the trace file, please override this setting inside the test case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..8adc0140d03f 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -124,6 +124,12 @@ initialize_ftrace() { # Reset ftrace to initial-state
     [ -f uprobe_events ] && echo > uprobe_events
     [ -f synthetic_events ] && echo > synthetic_events
     [ -f snapshot ] && echo 0 > snapshot
+
+# Stop tracing while reading the trace file by default, to prevent
+# the test results while checking it and to avoid taking a long time
+# to check the result.
+    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
+
     clear_trace
     enable_tracing
 }
-- 
2.25.1

 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
