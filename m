Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31642440409
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJ2U2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 16:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhJ2U2V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 16:28:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F6E6101E;
        Fri, 29 Oct 2021 20:25:51 +0000 (UTC)
Date:   Fri, 29 Oct 2021 16:25:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, mhiramat@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tracing/histogram: Optimize division by
 constants
Message-ID: <20211029162549.2c22f2dd@gandalf.local.home>
In-Reply-To: <CAC_TJve9OsL5taBN0ckgjG4=HxvmWfP6ULwwqnVsDyRxuQuRkg@mail.gmail.com>
References: <20211029183339.3216491-1-kaleshsingh@google.com>
        <20211029183339.3216491-2-kaleshsingh@google.com>
        <20211029144524.367d6789@gandalf.local.home>
        <CAC_TJve9OsL5taBN0ckgjG4=HxvmWfP6ULwwqnVsDyRxuQuRkg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 29 Oct 2021 11:53:16 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> > If these functions are only called when val2 is constant, can't we make it
> > such that we get val2 from the hist_field directly? That is:
> >
> >         u64 val2 = operand2->constant;  
> 
> operand2 might be a var ref to a constant, so we would need to resolve
> that with hist_field_var_ref().

So can a var_ref change? If not, then we should convert that to a constant
for this operation.

-- Steve
