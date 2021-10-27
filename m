Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0143CCC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhJ0OzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 10:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbhJ0OzA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 10:55:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAFB260724;
        Wed, 27 Oct 2021 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635346354;
        bh=8M3nKt+glST/1vlSEYvPRleNwgXQb7gbwuxaCwI1Whg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fR/xE8m7qavd66EZEMHa2Um94damyxYlntoxUkZEmBPfI2A5kkRyyXpUs4MNS8p+V
         qhu62Mbkwk4U4yP0MMLVlawZaGSSAecsLiQAH5r0AEyFUMxTgp1mm1vCumIArq44br
         mUYif0qDQPVBy8eXTNkulbPq2tpOQdFhIgzMVn1pdwAg6/NLifaT6CO8K0FfiMqZc8
         kU5+JCbzYWlfyqjFFJS1TE3VioDSh2ketCRCxlauE/fXZWI88loRIpoRC34+R5vwYc
         +50aJ/ONRLLWROXaLmxvEkhQ5oVHeudRRH4BmzGS+eFb4PAB1lcRa0DhEc3YD2LvBJ
         cTNWJ8poH/yvg==
Date:   Wed, 27 Oct 2021 23:52:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-Id: <20211027235229.06f268a62133882a547c3c01@kernel.org>
In-Reply-To: <20211027103119.2365bc90@gandalf.local.home>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211026214311.583c728d90d41778c38201dd@kernel.org>
        <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
        <20211026174420.0056bde2@gandalf.local.home>
        <CAC_TJveMumb=BkGL53d_rS08uQ35fz1B7cM9jp8eKoCz0MUG_Q@mail.gmail.com>
        <20211026202020.026e7907@rorschach.local.home>
        <CAC_TJvf8areGd1rQMbJV4r+J6JP2-DWXBLQwKRZEOzNWL_rqrQ@mail.gmail.com>
        <20211027121420.03a09fca1efc414189bb40bb@kernel.org>
        <CAC_TJvdMXd+wnvvs7XrTmT2-iyepr==hH9Kkd_T9_f3jd3Edrg@mail.gmail.com>
        <20211027103119.2365bc90@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 10:31:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Oct 2021 21:27:00 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> > > Interesting. There should be test logs under logs/ directory in the
> > > ftracetest. Can you share the logs/*/ftracetest.log and your kernel kconfig?
> > >
> > > Thank you,
> > >  
> > Hi Masami,
> > 
> > I have attached the config and ftracetest.log here.

Thanks! but it seems that the tests were randomely failed...

> 
> 
> Actually, could you attach the other files in that log?
> 
> tar cvjf log.tar.bz2 logs/<date>/
> 
> Where <date> is the value for the log that failed.
> 
> That will give me more information to why the tests failed.
> 
> I'm currently going to test the config you sent.

I'm also trying to reproduce it, but it seems to need full qemu mode.
If you share the above logs, it is easier to check why the tests have
been failed.

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
