Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB043BDBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 01:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhJZXWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 19:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235196AbhJZXWK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 19:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC8560F9B;
        Tue, 26 Oct 2021 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635290386;
        bh=4nDnndQ0TnTd7hTrxigTe3N1neZeTNXgL8YmAYDY8AE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLTf6TxHl2WC9Jk+sQbGRtv1ntlr71rxFwmAC4gAWhKKOSNwRl92blH/uzZ01maBt
         oN6VX0mBYL0Ueh8WYeVQkD09fcZfA+ua5TY4t1UIZleo+B3fI2gmW70zqBzOBTE4NH
         MNfP0YG57EPKNvcPJM6f8Dl8GKZi4+8tF7jxgiBiWUOc7QZYQHCSc5o+MHEt3QfeBt
         NfB9lAOJZ/ryL/BfNS6/Lyq3UWOoV9weEJtqW8hOentRS3wZWgaJLBg/mvpRrGWP0r
         Wm4XapBV7qYy+52DI1Y9LQu/YdWfku0psrOBQ3dsaGDtF+qdkvL5KiabvSnsDKOCkZ
         Q5avEEWjXpBLg==
Date:   Wed, 27 Oct 2021 08:19:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-Id: <20211027081943.86f7d279b4a32e94bf434c41@kernel.org>
In-Reply-To: <20211026111626.73e9eb9c@gandalf.local.home>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
        <20211025221717.56daf4e8@rorschach.local.home>
        <20211026211331.8496340b0011127e6505b5ff@kernel.org>
        <20211026091534.4ef376e0@gandalf.local.home>
        <20211026231314.1b5c1f378f9c5410b01a2d85@kernel.org>
        <20211026111626.73e9eb9c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 11:16:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Oct 2021 23:13:14 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >From e6ab7217c8f50dabee0f565764489fdd32e1ff07 Mon Sep 17 00:00:00 2001  
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Wed, 20 Oct 2021 11:55:22 +0900
> > Subject: [PATCH v2] selftests/ftrace: Stop tracing while reading the trace file
> >  by default
> > 
> > Stop tracing while reading the trace file by default, to prevent
> > the test results while checking it and to avoid taking a long time
> > to check the result.
> > If there is any testcase which wants to test the tracing while reading
> > the trace file, please override this setting inside the test case.
> > 
> > This also recovers the pause-on-trace when clean it up.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Looks good. Can you resend this as a standalone patch, so that it triggers
> my patchwork?

Sure, let me send it :-)

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
