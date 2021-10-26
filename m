Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758C243B30D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhJZNSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 09:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235298AbhJZNSA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 09:18:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F1460E96;
        Tue, 26 Oct 2021 13:15:36 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:15:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-ID: <20211026091534.4ef376e0@gandalf.local.home>
In-Reply-To: <20211026211331.8496340b0011127e6505b5ff@kernel.org>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
        <20211025221717.56daf4e8@rorschach.local.home>
        <20211026211331.8496340b0011127e6505b5ff@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 21:13:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > No, since each testcase must be run under the clean state. Would we need to
> > > recover the settings?  
> > 
> > I would at least put it back to the default. If someone runs the tests,
> > it should at least put it back to what it was at boot. Otherwise,
> > someone might run the tests, and then wonder why events are being
> > dropped when they are reading the trace.  
> 
> Umm, we may need to have a knob to reset the ftrace options...
> Can we warn such user that if the ftracetest finds that the current
> value is not the same what it sets?

You mean before we set pause-on-trace, make sure that it was cleared?

That could work too, and then just set everything back to what we expected
it to be at the start.

-- Steve
