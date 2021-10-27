Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADAB43BEDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhJ0BRj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234339AbhJ0BRj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:17:39 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FF460F9B;
        Wed, 27 Oct 2021 01:15:13 +0000 (UTC)
Date:   Tue, 26 Oct 2021 21:15:11 -0400
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
Message-ID: <20211026211511.403d76ca@rorschach.local.home>
In-Reply-To: <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
References: <20211025200852.3002369-1-kaleshsingh@google.com>
        <20211025200852.3002369-7-kaleshsingh@google.com>
        <20211026151451.7f3e09a4@gandalf.local.home>
        <CAC_TJveHgsPZw7p7BWOgQw6h8GNU_Pv_WUjNmw3AUq+wnSzk6Q@mail.gmail.com>
        <20211026201846.08990d1d@rorschach.local.home>
        <CAC_TJve-mKSojaXtukdFeQKvPz-8TQtS=pgGD0Z18Wt6yJi7dg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 18:09:22 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> >   delta = mult * div / 2^20
> >
> > That is if mult is a power of two, then there would be no rounding
> > errors, and the delta is zero, making the max infinite:

That should have been (as shown in the algorithm)

  delta = mult * div - 2 ^ 20

As mult is 2^20 / div; and the above should end up zero if there's no
rounding issues, as it would be:

 delta = (2^20 / div) * div - 2^20

-- Steve
