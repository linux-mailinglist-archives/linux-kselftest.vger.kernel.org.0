Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066443C0AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 05:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhJ0DSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 23:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJ0DSZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 23:18:25 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474776058D;
        Wed, 27 Oct 2021 03:15:59 +0000 (UTC)
Date:   Tue, 26 Oct 2021 23:15:57 -0400
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
Message-ID: <20211026231557.1eedad9b@rorschach.local.home>
In-Reply-To: <20211026222123.5e206fcf@rorschach.local.home>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-7-kaleshsingh@google.com>
        <20211026151451.7f3e09a4@gandalf.local.home>
        <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
        <20211026201846.08990d1d@rorschach.local.home>
        <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
        <20211026211511.403d76ca@rorschach.local.home>
        <CAC_TJvdwqQAKrVs3w6NcQNBT+bAgdyqR+8Zt_An7R9AQSSthGA@mail.gmail.com>
        <20211026222123.5e206fcf@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 22:21:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm sure there's an algorithm somewhere that can give as the real max.

You got me playing with this more ;-)

OK, I added the rounding in the wrong place. I found that we can make
the max_div to be the same as the shift! The bigger the shift, the
bigger the max!

	mult = (1 << shift) / div;
	max_div = (1 << shift)

But the rounding needs to be with the mult / shift:

	return (val * mult + ((1 << shift) - 1)) >> shift;


When val goes pass 1 << shift, then the error will be off by more than
one.

-- Steve
