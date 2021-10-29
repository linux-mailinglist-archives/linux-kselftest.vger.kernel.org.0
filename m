Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A907043FD26
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJ2NNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 09:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhJ2NNY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 09:13:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B9D60FC4;
        Fri, 29 Oct 2021 13:10:54 +0000 (UTC)
Date:   Fri, 29 Oct 2021 09:10:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>, lkp@lists.01.org,
        lkp@intel.com, surenb@google.com, hridya@google.com,
        namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [tracing/selftests]  cfece71411:
 kernel-selftests.ftrace.event_trigger_-_test_inter-event_histogram_trigger_onchange_action.fail
Message-ID: <20211029091053.18cc2c25@gandalf.local.home>
In-Reply-To: <20211029210056.6cd7796aea59cec3e9c1d7da@kernel.org>
References: <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211029064818.GG737@xsang-OptiPlex-9020>
        <20211029210056.6cd7796aea59cec3e9c1d7da@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 29 Oct 2021 21:00:56 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > # # of passed:  85
> > # # of failed:  26
> > # # of unresolved:  1
> > # # of untested:  0
> > # # of unsupported:  0
> > # # of xfailed:  1
> > # # of undefined(test bug):  0
> > not ok 1 selftests: ftrace: ftracetest # exit=1  
> 
> Also, please configure your running environment correctly so that all
> ftracetest passes. If you unsure how to do, please ask me.

Although I think it's good to test with different configurations, where not
all tests pass. Because then there's times when a test will fail when it
should have been ignored, and that will let us know that there's a bug in
the test.

Or, different configurations might make a test fail that should have
passed, where a missing dependency was made.

I had someone report a bug that I never caught because it only happened
when something was configured off, and because I tested with everything on,
I never hit that bug.

-- Steve
