Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8243437A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 04:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJTCWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 22:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTCWo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 22:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2640611EF;
        Wed, 20 Oct 2021 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634696430;
        bh=JxsIowpKGVDra9B8vW+kfpr7Ls3YqwRYfU0D7J97Q7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e9CTLuAykGzMv8YTLt2sQ1pW0/Og9sxYk/SPbIvXSlizzu3kJcyh+OuPmCrYUZv2V
         6tsLB0wnEreN4Gg8HbHiP2OtrChZr3g0v281Uk/4IMHk2envvy0zBfjGTyfW0X9SXa
         5X1KqCpg9ftE79IIE0NB/QIOK8QVythuzhocjY6g6V9qraRRuiisWWx0/XbC86whgp
         vOziy913xOfnVKi5vhlwb/xFt8n1Stam8GvOhMzhISBTaXGPWaa70t4EtO8RgyaGNa
         aEmu9etm7RLeU9xAXvdhFkvCxuG6V0fVUPNrKNjw9ze+FEUp0JKwHw7DmM1fnteGk1
         PVfMOfEWnN89Q==
Date:   Wed, 20 Oct 2021 11:20:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
In-Reply-To: <20211018221636.47157e52@gandalf.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 18 Oct 2021 22:16:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 18 Oct 2021 21:26:16 +0800
> Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> 
> > LKP/0day observed that kselftests/ftrace cannot finish within 1 hour on
> > a 96 cpus platform where it hangs in the line like:
> > 'cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l'
> > subsystem-enable.tc
> > 
> > It seems that trace will keep growing during it's read by 'cat' command.
> > Consequently, trace becomes too large to finish reading.
> > 
> > replace 'cat trace' by:
> > $ sed -i 's/cat trace |/read_cached_trace |/g' $(find test.d -name "*.tc")
> > 
> 
> Instead, what happens if you add this command to each test?
> 
> if [ -t options/pause-on-trace ]; then
>    echo 1 > options/pause-on-trace
> fi
> 
> We also need to add to the "initialize_ftrace" function in test.d/functions.
> 
> if [ -t options/pause-on-trace ]; then
>    echo 0 > options/pause-on-trace
> fi

Hmm, by the way, shouldn't we set this feature by default?
There are many "cat trace | grep ..." style test code in ftracetest just for
checking whether the event is recorded. At least for the ftracetest, it should
be set unless the testcase is explicitly disable it.

Thank you.

> 
> -- Steve
> 
> > CC: Philip Li <philip.li@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > ---


-- 
Masami Hiramatsu <mhiramat@kernel.org>
