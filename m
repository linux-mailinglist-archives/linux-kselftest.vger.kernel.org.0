Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC139F8B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhFHOQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhFHOQr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 10:16:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAC9C061574;
        Tue,  8 Jun 2021 07:14:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4ABA81F42B4F
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, acme@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com> <YL9Q2tKLZP6GKbHW@kroah.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <1983f58b-6bb2-5f47-3cb2-647bb81b6ed2@collabora.com>
Date:   Tue, 8 Jun 2021 11:14:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL9Q2tKLZP6GKbHW@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Às 08:13 de 08/06/21, Greg KH escreveu:
> On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
>> On 6/8/21 4:25 AM, Nicholas Piggin wrote:
>>>
>>> Are shared pthread mutexes using existing pthread APIs that are today
>>> implemented okay with futex1 system call a good reason to constrain
>>> futex2 I wonder? Or do we have an opportunity to make a bigger change
>>> to the API so it suffers less from non deterministic latency (for
>>> example)?
>>
>> If futex2 is not able to cover futex1 use cases then it cannot be viewed as
>> a replacement. In the long term this means futex1 cannot be deprecated and
>> has to be maintained. My impression was that futex1 was basically
>> unmaintainable(*) and futex2 was an evolution of futex1 so that users of
>> futex1 could migrate relatively easily and futex1 eventually removed. Maybe
>> my impression was wrong, but I would like to see futex2 as a replacement and
>> extension of futex1, so the latter can be deprecated at some point.
> 
> You can never delete a kernel system call, so even if you "deprecate"
> it, it still needs to be supported for forever.
> 
> Best of all would be if internally your "futex2" code would replace the
> "futex1" code so that there is no two different code bases.  That would
> be the only sane way forward, having 2 code bases to work with is just
> insane.
> 
>> (*) I use "unmaintainable" in a broad sense here. It exists and works in
>> newer kernel versions and may receive code changes that are necessary to
>> keep it working, but maintainers refuse any extensions or modifications of
>> the code, mostly because of its complexity.
> 
> Adding additional complexity for no good reason is not a good idea,
> especially if you are asking others to maintain and support that
> complexity.  Would you want to have to do that work?
> 
> So what's keeping the futex2 code from doing all that futex1 does so
> that the futex1 code can be deleted internally?
> 

My very first submission of futex2[0] was just an overlay on top of
futex.c, I didn't get much feedback at that time, but I think this is
what you and Peter are thinking of?

After that, last year at Plumbers' RT MC, I presented a talk called
"futex2: A New Interface" and my conclusion after the discussion on this
talk + responses I got from my FUTEX_WAIT_MULTIPLE patchset[1] was that
this work couldn't be done at futex.c, given how fragile things are
there. futex.c would be "feature freeze" and no new major changes would
happen there.

This is the context where this new futex2 code base comes from. So,
which one is it? Happy to go either way but I'm getting conflicting
messages here.

Thanks,
	André

[0]
https://lore.kernel.org/lkml/20200612185122.327860-2-andrealmeid@collabora.com/

[1]
https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@collabora.com/

> thanks,
> 
> greg k-h
> 
