Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80BC1C956C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEGPuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 11:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEGPuc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 11:50:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74EFB20659;
        Thu,  7 May 2020 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588866632;
        bh=a4g1pYWcIDP9Pbd1virnw3Z83hS76WeKV3KwymGm09U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSaTPs3Enu9YAiDYWqenhOiKwvLbcEun5F5evfg3kwO4xVSEy99B924mrWjVqKxHZ
         vRue5I3xj+CxdNPpJT/BUCn/ZVSkyNKd/21TphpJTu+Zw0XPrA4WYEaGjH/8NVZa3D
         DytGmdOxNJi9199T6xqy0BJSX8HPKwmpFs60MTtg=
Date:   Fri, 8 May 2020 00:50:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-Id: <20200508005028.a825d53373721a13d6cc80fc@kernel.org>
In-Reply-To: <20200507091207.5c3b1a92@gandalf.local.home>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <20200501101942.5c0da986@gandalf.local.home>
        <20200502120842.9d93352083fb854295150235@kernel.org>
        <20200507091207.5c3b1a92@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 May 2020 09:12:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2 May 2020 12:08:42 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > > > index ab6bedb25736..b3f70f53ee69 100644
> > > > --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > > > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> > > > @@ -30,7 +30,7 @@ fi
> > > >  
> > > >  echo "Test histogram trace_marker tigger"
> > > >  
> > > > -echo 'hist:keys=common_pid' > events/ftrace/print/trigger
> > > > +echo 'hist:keys=ip' > events/ftrace/print/trigger  
> > > 
> > > This is doing more than just changing the echo being used. It's changing
> > > the test being done.  
> > 
> > Yes, I need Tom's review for this change. As far as I can test, this
> > fixes the test failure. If this isn't acceptable, we can use "alias echo=echo"
> > for this test case.
> > 
> 
> I still don't see how changing "keys=common_pid" to "keys=ip" has anything
> to do with the echo patch. If that is a problem, it should be a different
> patch with explanation to why "keys=common_pid" is broken.

This test case uses a trace_marker event to make a histogram with
the common_pid key, and it expects the "echo" command is built-in command
so that the pid is same while writing several events to trace_marker.
I changed it to "ip" which is always same if trace_marker interface is
used.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
