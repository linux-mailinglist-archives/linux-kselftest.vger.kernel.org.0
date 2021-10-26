Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C143AA29
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhJZCTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 22:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJZCTm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 22:19:42 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB8360C51;
        Tue, 26 Oct 2021 02:17:18 +0000 (UTC)
Date:   Mon, 25 Oct 2021 22:17:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-ID: <20211025221717.56daf4e8@rorschach.local.home>
In-Reply-To: <20211021093131.affc348280aba040f76f769e@kernel.org>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 21 Oct 2021 09:31:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > +# Stop tracing while reading the trace file by default, to prevent
> > > +# the test results while checking it and to avoid taking a long time
> > > +# to check the result.
> > > +    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
> > > +  
> > 
> > Is there a way we can save the previous setting and put it back on reset?  
> 
> No, since each testcase must be run under the clean state. Would we need to
> recover the settings?

I would at least put it back to the default. If someone runs the tests,
it should at least put it back to what it was at boot. Otherwise,
someone might run the tests, and then wonder why events are being
dropped when they are reading the trace.

-- Steve
