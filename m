Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6543BFE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 04:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhJ0Cgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 22:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238214AbhJ0Cgo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 22:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAF0B60F0F;
        Wed, 27 Oct 2021 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635302059;
        bh=tJuz9xU+39xdBxstvNh2Lqyyxlqzg73RtzfkS9+Mx50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DBREyDU5e++mtcWEZgz8YzaxZtExD++2IO7ykow899wUqCr8ulbm1Wjr9wgtaiA83
         COG3pR0aXfKuPDapxFwMeUN2YiA083KMVzSOhkqJPcQNGsO1lNlbGlNl4hK3KaFPNq
         JOI3Y4X/KIrNCXyH8ZUWwpmhvwcHC+ePSAH9L3AQ2RwOWuRVd4+ZGcKvkl0y/Vh0Rf
         yNCJBGp+3UAdQS4KHq9WJ5BQ1+Rz1w3s4OL2dHfFuVABa33nCH+gT4PXedcLQjQ7uU
         2PxBHj85C4m0V6ejXzBbiwYcOGl9ZqBVI/8BXx6jiltLrNVGYyeK1K+jloHXrQXYf2
         qBQAg2vJw5HNw==
Date:   Wed, 27 Oct 2021 11:34:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-Id: <20211027113416.fdad2adf8d162e67405e44ba@kernel.org>
In-Reply-To: <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211026214311.583c728d90d41778c38201dd@kernel.org>
        <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 07:28:39 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> On Tue, Oct 26, 2021 at 5:43 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Kalesh,
> >
> > On Mon, 25 Oct 2021 13:08:39 -0700
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > > Add tests for the parsing of hist trigger expressions; and to
> > > validate expression evaluation.
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >
> > > Changes in v3:
> > >   - Remove .sym-offset error check tests
> > >
> > > Changes in v2:
> > >   - Add Namhyung's Reviewed-by
> > >   - Update comment to clarify err_pos in "Too many subexpressions" test
> > >
> > >
> > >  .../testing/selftests/ftrace/test.d/functions |  4 +-
> > >  .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
> > >  2 files changed, 74 insertions(+), 2 deletions(-)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
> > >
> > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > > index 000fd05e84b1..1855a63559ad 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > @@ -16,13 +16,13 @@ reset_tracer() { # reset the current tracer
> > >
> > >  reset_trigger_file() {
> > >      # remove action triggers first
> > > -    grep -H ':on[^:]*(' $@ |
> > > +    grep -H ':on[^:]*(' $@ | tac |
> > >      while read line; do
> > >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> > >       file=`echo $line | cut -f1 -d:`
> > >       echo "!$cmd" >> $file
> > >      done
> > > -    grep -Hv ^# $@ |
> > > +    grep -Hv ^# $@ | tac |
> > >      while read line; do
> > >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> > >       file=`echo $line | cut -f1 -d:`
> >
> > If this update has any meaning, please make a separate patch for this part.
> 
> Hi Masami,
> 
> Thanks for the feedback. The above change is to ensure we remove
> triggers in the reverse order that we created them - important when
> one trigger depends on another.

Hi Kalesh,
That's a good reason to make this an independent patch :)

> I can split it out into a separate
> patch and will add a README pattern check to the requires tag for
> these tests.

Thank you!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
