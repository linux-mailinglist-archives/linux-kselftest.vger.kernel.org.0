Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B04357D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhJUAdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 20:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhJUAdt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 20:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 345A960FF2;
        Thu, 21 Oct 2021 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634776294;
        bh=2N7TWg46Hjrz6h+njX57e9C+a3Xllj8D+pXkB0nOhz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqOuJlmNVVV5HSW89rPxf/94/+KqNr9ByEXkQV83sc6t7CrXMj4o7uszHHYySJpXy
         Ooijt/dU7t4KtIRpuPYLiYukU1gcwf+2n96a9w40rDAosI6+j73wwzUGzvKR2yTlm4
         w/nA55g/9IhFHEFyvCN1C6TGY+gdqCrEoyzlOe1nX39IjFQc4Cy+zE+RN13jA+MqaK
         OT1JlG1GeHhlxI2ILL2sZQdSv/RnR2acf2STy4DqlsrLIP//8jJivyLn67OBFa3duS
         gdy9bZMg2X7wX66487Ag6LvK1Ki4eLxnf5LdQZL4Nm4um8JPrUlp1X6CLJnh+DA2s7
         sTp4giaVYnwJA==
Date:   Thu, 21 Oct 2021 09:31:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211021093131.affc348280aba040f76f769e@kernel.org>
In-Reply-To: <20211020101659.42360147@gandalf.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 20 Oct 2021 10:16:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Oct 2021 11:55:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -124,6 +124,12 @@ initialize_ftrace() { # Reset ftrace to initial-state
> >      [ -f uprobe_events ] && echo > uprobe_events
> >      [ -f synthetic_events ] && echo > synthetic_events
> >      [ -f snapshot ] && echo 0 > snapshot
> > +
> > +# Stop tracing while reading the trace file by default, to prevent
> > +# the test results while checking it and to avoid taking a long time
> > +# to check the result.
> > +    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
> > +
> 
> Is there a way we can save the previous setting and put it back on reset?

No, since each testcase must be run under the clean state. Would we need to
recover the settings?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
