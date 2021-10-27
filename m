Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924F743BE71
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJ0AWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 20:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJ0AWs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 20:22:48 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9F860F90;
        Wed, 27 Oct 2021 00:20:22 +0000 (UTC)
Date:   Tue, 26 Oct 2021 20:20:20 -0400
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
Message-ID: <20211026202020.026e7907@rorschach.local.home>
In-Reply-To: <CAC_TJveMumb=BkGL53d_rS08uQ35fz1B7cM9jp8eKoCz0MUG_Q@mail.gmail.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-8-kaleshsingh@google.com>
        <20211026214311.583c728d90d41778c38201dd@kernel.org>
        <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
        <20211026174420.0056bde2@gandalf.local.home>
        <CAC_TJveMumb=BkGL53d_rS08uQ35fz1B7cM9jp8eKoCz0MUG_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 16:36:03 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> On my setup I without any of the changes applied (config hist triggers enabled):
> 
> ./ftracetests
> 
> # of passed:  41
> # of failed:  40
> # of unresolved:  0
> # of untested:  0
> # of unsupported:  32
> # of xfailed:  0
> # of undefined(test bug):  0
> 
> Do all the tests pass for you, before any of the changes in this
> series? Maybe some of the tests need updating?

All my tests past, and I don't push any code if they fail.

I'd like to understand why you have these failures. Are the test from
the kernel you are testing?

-- Steve
