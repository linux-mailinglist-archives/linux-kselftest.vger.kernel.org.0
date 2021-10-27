Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35C743CF86
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhJ0RTd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 13:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhJ0RTd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 13:19:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6404560238;
        Wed, 27 Oct 2021 17:17:06 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:17:04 -0400
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
Message-ID: <20211027131704.2050ee4b@gandalf.local.home>
In-Reply-To: <CAC_TJvehyzE4yvnn9ZvG7qnU6H9u-6mTauvqhPJjAUHvi4ebfg@mail.gmail.com>
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
        <20211027110149.4bf5eb88@gandalf.local.home>
        <20211027115030.50edec1b@gandalf.local.home>
        <CAC_TJvehyzE4yvnn9ZvG7qnU6H9u-6mTauvqhPJjAUHvi4ebfg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 08:55:39 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Thanks for looking into this. I've attached the full logs here.

Just looking at:

  11-add_remove_kprobe.tc-log.vQWAmF

I see the failure of:

+ echo
+ PLACE=_do_fork
+ >>dynamic_events
+ echo 'p:myevent1 _do_fork'


Where "_do_fork" no longer exists and the tests have been updated.

I'm guessing you are running outdated tests. Please make sure that the
tests you run are the latest from the kernel tree.

Thanks!

-- Steve
