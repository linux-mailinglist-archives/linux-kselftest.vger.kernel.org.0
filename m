Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E91CA4D9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 09:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgEHHL6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 03:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgEHHL5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 03:11:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141F7208CA;
        Fri,  8 May 2020 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588921917;
        bh=9u7QMul5gOL/AJOhTxAS3eOVQSRsWi7aj+x7KYa+78E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCoMlMdFTC+hksEq/bKLRlv4rxfq6R9oxeIqx/9Ksb+5YEOK603n9N0isFEIQmp4t
         g0X8oY2nTyMPnG/BOlJaIkmMjqhFhpC7HinXjSWBCf1UkeAhC+ti/KP1lZ02QIEEMc
         CzGbj6Ir5zGKOeKx5eo4hkViqpY2lrPcaLr5sHIM=
Date:   Fri, 8 May 2020 16:11:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-Id: <20200508161152.5815fd2fac26c300d836f0f1@kernel.org>
In-Reply-To: <f575eead-c021-c830-b9d5-41437964db32@linux.intel.com>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <20200501101942.5c0da986@gandalf.local.home>
        <20200502120842.9d93352083fb854295150235@kernel.org>
        <20200507091207.5c3b1a92@gandalf.local.home>
        <20200508005028.a825d53373721a13d6cc80fc@kernel.org>
        <20200507132539.7e081980@gandalf.local.home>
        <f575eead-c021-c830-b9d5-41437964db32@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 May 2020 15:32:46 -0500
"Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:

> Hi,
> 
> On 5/7/2020 12:25 PM, Steven Rostedt wrote:
> > On Fri, 8 May 2020 00:50:28 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >>>> Yes, I need Tom's review for this change. As far as I can test, this
> >>>> fixes the test failure. If this isn't acceptable, we can use "alias echo=echo"
> >>>> for this test case.
> >>>>    
> >>>
> >>> I still don't see how changing "keys=common_pid" to "keys=ip" has anything
> >>> to do with the echo patch. If that is a problem, it should be a different
> >>> patch with explanation to why "keys=common_pid" is broken.
> >>
> >> This test case uses a trace_marker event to make a histogram with
> >> the common_pid key, and it expects the "echo" command is built-in command
> >> so that the pid is same while writing several events to trace_marker.
> >> I changed it to "ip" which is always same if trace_marker interface is
> >> used.
> > 
> > Can you explicitly state that in your change log? It wasn't obvious from
> > what you meant with:
> > 
> > "This also fixes some test cases which expects built-in echo command."

OK, will add the description.

> > 
> 
> With that change,
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks Tom!

> 
> Thanks,
> 
> Tom
> 
> > Thanks!
> > 
> > -- Steve
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
