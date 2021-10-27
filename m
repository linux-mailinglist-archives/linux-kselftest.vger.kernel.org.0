Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5C43BF8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 04:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhJ0CXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 22:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhJ0CXv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 22:23:51 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E42610CB;
        Wed, 27 Oct 2021 02:21:25 +0000 (UTC)
Date:   Tue, 26 Oct 2021 22:21:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 6/8] tracing/histogram: Optimize division by a power
 of 2
Message-ID: <20211026222123.5e206fcf@rorschach.local.home>
In-Reply-To: <CAC_TJvdwqQAKrVs3w6NcQNBT+bAgdyqR+8Zt_An7R9AQSSthGA@mail.gmail.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-7-kaleshsingh@google.com>
        <20211026151451.7f3e09a4@gandalf.local.home>
        <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
        <20211026201846.08990d1d@rorschach.local.home>
        <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
        <20211026211511.403d76ca@rorschach.local.home>
        <CAC_TJvdwqQAKrVs3w6NcQNBT+bAgdyqR+8Zt_An7R9AQSSthGA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 18:31:21 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> And IIUC max_div is an arbitrary value we decide on that's <= 2^shift?
> Is there a rule of thumb for choosing this?

The way I came up with the max was to figure out at what point is it no
longer guaranteed to be accurate. That is, what number can make the
mult/shift no longer match the division.

If we have some number div that is not a power of two. At some point:

	(X * mult) >> shift != X / div

Now I simply picked

  max = 1 << shift / (mult * div - (1 << shift))

Because that will always be within the precision of the actual number.

But I believe we can make max bigger, but because that deals with
truncation, it's not simple math.

That is, the above X / div is truncated and not the real number.

I'm sure there's an algorithm somewhere that can give as the real max.

-- Steve
