Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3643CCEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhJ0PES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 11:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhJ0PER (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 11:04:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5DD60F38;
        Wed, 27 Oct 2021 15:01:51 +0000 (UTC)
Date:   Wed, 27 Oct 2021 11:01:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
Message-ID: <20211027110149.4bf5eb88@gandalf.local.home>
In-Reply-To: <20211027235229.06f268a62133882a547c3c01@kernel.org>
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
        <20211027235229.06f268a62133882a547c3c01@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 23:52:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > I'm currently going to test the config you sent.  
> 
> I'm also trying to reproduce it, but it seems to need full qemu mode.
> If you share the above logs, it is easier to check why the tests have
> been failed.

And my build failed with:

make[2]: *** No rule to make target 'kernel/drivers/char/hw_random/tpm-rng.o', needed by 'modules-only.symvers'.  Stop.
make[1]: *** [/work/git/linux-test.git/Makefile:1783: modules] Error 2

I'll tweak the config to go further.

-- Steve
