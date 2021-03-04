Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160E32D5D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhCDPDQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 10:03:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51200 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232988AbhCDPDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 10:03:05 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 124F1E6c002357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Mar 2021 10:01:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A243015C3A88; Thu,  4 Mar 2021 10:01:14 -0500 (EST)
Date:   Thu, 4 Mar 2021 10:01:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
Message-ID: <YED2OrBdsiYWMqpp@mit.edu>
References: <20210304004219.134051-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304004219.134051-1-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 03, 2021 at 09:42:06PM -0300, André Almeida wrote:
>  ** Performance
> 
>  - For comparing futex() and futex2() performance, I used the artificial
>    benchmarks implemented at perf (wake, wake-parallel, hash and
>    requeue). The setup was 200 runs for each test and using 8, 80, 800,
>    8000 for the number of threads, Note that for this test, I'm not using
>    patch 14 ("kernel: Enable waitpid() for futex2") , for reasons explained
>    at "The patchset" section.

How heavily contended where the benchmarks?  One of the benefits of
the original futex was that no system call was necessary in the happy
path when the lock is uncontended.  Especially on a non-NUMA system
(which are the far more common case), since that's where relying on a
single memory access was a huge win for the original futex.  I would
expect that futex2 will fare worse in this particular case, since it
requires a system call entry for all operations --- the question is
how large is the delta in this worst case (for futex2) and best case
(for futex) scenario.

Cheers,

						- Ted
