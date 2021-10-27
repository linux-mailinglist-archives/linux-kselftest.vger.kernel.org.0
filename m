Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97B43CFD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbhJ0RjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 13:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236251AbhJ0RjM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 13:39:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF6D160EFF;
        Wed, 27 Oct 2021 17:36:45 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:36:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-ID: <20211027133644.2a8ab22c@gandalf.local.home>
In-Reply-To: <20211027113416.fdad2adf8d162e67405e44ba@kernel.org>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211026214311.583c728d90d41778c38201dd@kernel.org>
        <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
        <20211027113416.fdad2adf8d162e67405e44ba@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 11:34:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Hi Masami,
> > 
> > Thanks for the feedback. The above change is to ensure we remove
> > triggers in the reverse order that we created them - important when
> > one trigger depends on another.  
> 
> Hi Kalesh,
> That's a good reason to make this an independent patch :)
> 
> > I can split it out into a separate
> > patch and will add a README pattern check to the requires tag for
> > these tests.  

Kalesh,

As you may have noticed, I pulled in all the patches in this series but
this selftests patch. Please rebase your updates as requested by Masami on
top of my for-next branch, which can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

Thanks!

-- Steve
