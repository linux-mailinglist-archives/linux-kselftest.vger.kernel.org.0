Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2941C97A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGRZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 13:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgEGRZm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 13:25:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CDE20A8B;
        Thu,  7 May 2020 17:25:40 +0000 (UTC)
Date:   Thu, 7 May 2020 13:25:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-ID: <20200507132539.7e081980@gandalf.local.home>
In-Reply-To: <20200508005028.a825d53373721a13d6cc80fc@kernel.org>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <20200501101942.5c0da986@gandalf.local.home>
        <20200502120842.9d93352083fb854295150235@kernel.org>
        <20200507091207.5c3b1a92@gandalf.local.home>
        <20200508005028.a825d53373721a13d6cc80fc@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 8 May 2020 00:50:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Yes, I need Tom's review for this change. As far as I can test, this
> > > fixes the test failure. If this isn't acceptable, we can use "alias echo=echo"
> > > for this test case.
> > >   
> > 
> > I still don't see how changing "keys=common_pid" to "keys=ip" has anything
> > to do with the echo patch. If that is a problem, it should be a different
> > patch with explanation to why "keys=common_pid" is broken.  
> 
> This test case uses a trace_marker event to make a histogram with
> the common_pid key, and it expects the "echo" command is built-in command
> so that the pid is same while writing several events to trace_marker.
> I changed it to "ip" which is always same if trace_marker interface is
> used.

Can you explicitly state that in your change log? It wasn't obvious from
what you meant with:

"This also fixes some test cases which expects built-in echo command."

Thanks!

-- Steve
