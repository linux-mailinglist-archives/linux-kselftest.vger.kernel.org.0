Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68696434F88
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJTQB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 12:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhJTQBZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 12:01:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42E261373;
        Wed, 20 Oct 2021 15:59:09 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:59:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] tracing: Add support for creating hist trigger
 variables from literal
Message-ID: <20211020115908.63022a05@gandalf.local.home>
In-Reply-To: <CAC_TJvdOx_=CY8u02hWzxkEpipPQTk2bvb1oOtN7uoURPffsDg@mail.gmail.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-2-kaleshsingh@google.com>
        <20211020113234.45657902@gandalf.local.home>
        <CAC_TJvdOx_=CY8u02hWzxkEpipPQTk2bvb1oOtN7uoURPffsDg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 20 Oct 2021 08:55:23 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> > BTW, why is there a limit to the number of constants?  
> 
> The motivation was to limit the number of hist_fields that can be
> created for constants. These are also indirectly limited by the max
> number of subexpressions (3) and the max number of vars/keys that can
> be defined, so I don't feel strongly about keeping it.

Yeah. I see the limiting factor is the number of expressions and such. And
as described in my other email, if you have two constants for a single
operand, you can easily combine them into one.

-- Steve
