Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD16435002
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJTQV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 12:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhJTQVZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 12:21:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC15960C51;
        Wed, 20 Oct 2021 16:19:09 +0000 (UTC)
Date:   Wed, 20 Oct 2021 12:19:08 -0400
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
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist
 triggers expression
Message-ID: <20211020121908.28fed7af@gandalf.local.home>
In-Reply-To: <CAC_TJvfsF9BF2wfGck1icX_Ya7dLWO+hOBA5cR56PPr0Dn9D9Q@mail.gmail.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-4-kaleshsingh@google.com>
        <20211020114805.3fbb7d94@gandalf.local.home>
        <CAC_TJvfsF9BF2wfGck1icX_Ya7dLWO+hOBA5cR56PPr0Dn9D9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 20 Oct 2021 09:11:27 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> The main reason for this is that it's predictable behavior form the
> user's perspective. Before this patch the recursion always walked down
> a single branch so limiting by level worked out the same as limiting
> by sub expressions and is in line with the error the user would see
> ("Too many sub-expressions (3 max)"). Now that we take multiple paths
> in the recursion, using the level to reflect the number of
> sub-expressions would lead to only seeing the error in some of the
> cases (Sometimes we allow 4, 5, 6 sub-expressions depending on how
> balanced the tree is, and sometimes we error out on 4 - when the tree
> is list-like). Limiting by sub-expression keeps this consistent
> (always error out if we have more than 3 sub-expressions) and is in
> line with the previous behavior.

I'm fine with that. If we want to improve this in the future then fine. We
can always extend, as that doesn't break user API.

So we can keep it as is.

-- Steve
