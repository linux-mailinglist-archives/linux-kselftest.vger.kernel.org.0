Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16B539EC22
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 04:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFHCfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Jun 2021 22:35:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHCfH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Jun 2021 22:35:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2BDC219BE;
        Tue,  8 Jun 2021 02:33:13 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 194DA118DD;
        Tue,  8 Jun 2021 02:33:07 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jKjUNOPWvmA2HgAALh3uQQ
        (envelope-from <dave@stgolabs.net>); Tue, 08 Jun 2021 02:33:07 +0000
Date:   Mon, 7 Jun 2021 19:33:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@collabora.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, acme@kernel.org,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Darren Hart <dvhart@infradead.org>,
        fweimer@redhat.com, joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <20210608023302.34yzrm5ktf3qvxhq@offworld>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 07 Jun 2021, Andrï¿½ Almeida wrote:

>Às 22:09 de 04/06/21, Nicholas Piggin escreveu:
>> Actually one other scalability thing while I remember it:
>>
>> futex_wait currently requires that the lock word is tested under the
>> queue spin lock (to avoid consuming a wakeup). The problem with this is
>> that the lock word can be a very hot cache line if you have a lot of
>> concurrency, so accessing it under the queue lock can increase queue
>> lock hold time.
>>
>> I would prefer if the new API was relaxed to avoid this restriction
>> (e.g., any wait call may consume a wakeup so it's up to userspace to
>> avoid that if it is a problem).
>
>Maybe I'm wrong, but AFAIK the goal of checking the lock word inside the
>spin lock is to avoid sleeping forever (in other words, wrongly assuming
>that the lock is taken and missing a wakeup call), not to avoid
>consuming wakeups. Or at least this is my interpretation of this long
>comment in futex.c:
>
>https://elixir.bootlin.com/linux/v5.12.9/source/kernel/futex.c#L51

I think what Nick is referring to is that futex_wait() could return 0
instead of EAGAIN upon a uval != val condition if the check is done
without the hb lock. The value could have changed between when userspace
did the condition check and called into futex(2) to block in the slowpath.

But such spurious scenarios should be pretty rare, and while I agree that
the cacheline can be hot, I'm not sure how much of a performance issue this
really is(?), compared to other issues, certainly not to govern futex2
design. Changing such semantics would be a _huge_ difference between futex1
and futex2.

At least compared, for example, to the hb collisions serializing independent
futexes, affecting both performance and determinism. And I agree that a new
interface should address this problem - albeit most of the workloads I have
seen in production use but a handful of futexes and larger thread counts.
One thing that crossed my mind (but have not actually sat down to look at)
would be to use rlhastables for the dynamic resizing, but of course that would
probably add a decent amount of overhead to the simple hashing we currently have.

Thanks,
Davidlohr
