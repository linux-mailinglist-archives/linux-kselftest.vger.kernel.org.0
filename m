Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877029F02B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgJ2Pf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 11:35:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33675 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgJ2Pdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 11:33:55 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kY9w1-0001OG-25; Thu, 29 Oct 2020 15:33:53 +0000
Date:   Thu, 29 Oct 2020 16:33:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Use $FUNCTION_FORK to reference kernel
 fork function
Message-ID: <20201029153351.m6jvaymzlu34plyk@wittgenstein>
References: <20201026162032.124c728d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026162032.124c728d@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 26, 2020 at 04:20:32PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Commit cad6967ac108 ("fork: introduce kernel_clone()") replaced "_do_fork()"
> with "kernel_clone()". The ftrace selftests reference the fork function in
> several of the tests. The rename will make the tests break, but if those
> names are changed in the tests, they would then break on older kernels. The
> same set of tests should pass older kernels if they have previously passed.
> Obviously, a new test may not work on older kernels if the test was added
> due to a bug or a new feature.
> 
> The setup of ftracetest will now create a $FUNCTION_FORK bash variable
> that will contain "_do_fork" for older kernels and "kernel_clone" for newer
> ones. It figures out the proper name by examining /proc/kallsyms.
> 
> Note, available_filter_functions could also be used, but because some tests
> should be able to pass without function tracing enabled, it could not be
> used.
> 
> Fixes: eea11285dab3 ("tracing: switch to kernel_clone()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thank you!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
