Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AA10A71D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 00:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZXb2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 18:31:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKZXb2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 18:31:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED712068E;
        Tue, 26 Nov 2019 23:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574811087;
        bh=symYYUtFNhnfIh9driE62idqblDpdzSXfmuR7iSwBLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwrs7OPExaCNkQ1tpJUroPHz2gstOk+e4GqTJLemh3nnCovQ/7mBObM+IUgmPS3PH
         XT1YrzzMSWX0UnQ1fujdeU1ywtnwD5xRkPD5ljCuxWn8kdMUo4RO25zGqNh8PzYebZ
         5RiAJB6NiW9Lpld/375GATVwvzpVdR46w0gkkUIM=
Date:   Wed, 27 Nov 2019 08:31:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v4 2/4] selftests/ftrace: Fix ftrace test cases
 to check unsupported
Message-Id: <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
In-Reply-To: <20191126124901.22ae2f9f@gandalf.local.home>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
        <157475726452.3389.3778488615487716476.stgit@devnote2>
        <20191126124901.22ae2f9f@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Nov 2019 12:49:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Nov 2019 17:34:24 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> > @@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
> >    exit_unresolved
> >  fi
> >  
> > +if ! grep -q function available_tracers ; then
> > +  echo "Function trace is not enabled"
> > +  exit_unsupported
> > +fi
> > +
> >  ORIG_CPUMASK=`cat tracing_cpumask`
> 
> Strange, but the bashism test failed:
> 
> ++ checkbashisms /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> possible bashism in /work/git-local/linux.git/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc line 18 ('function' is useless):
> if ! grep -q function available_tracers ; then
> 
> Not sure why it did not like that line. Maybe my bashism check got
> confused by the key word "function"?
> 
> Yep!
> 
> By adding quotes around "function" it doesn't complain:
> 
> 	if ! grep -q "function" available_tracers ; then
> 
> May need to add that.

Thanks! Shuah, can I update this patch?
I'll send it asap.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
