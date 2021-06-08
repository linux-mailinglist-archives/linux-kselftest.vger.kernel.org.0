Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB99739FD8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFHR0a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 13:26:30 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:51886 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFHR03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 13:26:29 -0400
X-Greylist: delayed 1045 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 13:26:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o1rKVWS8yk/+TD71rwtUO/tlxJR2buWgJpKkF2iMIHE=; b=OxNn6SQM+f2RUa07cyRtggHlRX
        SRjXsyCYik4TZ12vt2EzfmpVt7pYdTn0bdwyIqV8jJaks9GDLGho9rZ/8Y/n/hl+ELczNvNDAbim9
        BYmjn0brfShV68C3j5sE9pU0qduGOsHD+c3xUeHmQM6vOxnW3K3fQf46SMn+eowv9FPo=;
Received: from [75.162.249.176] (helo=[192.168.0.62])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zfigura@codeweavers.com>)
        id 1lqfBv-0005Hl-Cl; Tue, 08 Jun 2021 12:07:04 -0500
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Andrey Semashev <andrey.semashev@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com> <YL9Q2tKLZP6GKbHW@kroah.com>
 <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com> <YL9kApyE6FbG/hru@kroah.com>
 <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com>
From:   Zebediah Figura <zfigura@codeweavers.com>
Message-ID: <4c16b622-d2a8-c9f7-4c0b-80c9dbd8ef2c@codeweavers.com>
Date:   Tue, 8 Jun 2021 12:06:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/21 8:18 AM, Andrey Semashev wrote:
> On 6/8/21 3:35 PM, Greg KH wrote:
>> On Tue, Jun 08, 2021 at 03:06:48PM +0300, Andrey Semashev wrote:
>>> On 6/8/21 2:13 PM, Greg KH wrote:
>>
>>>> So what's keeping the futex2 code from doing all that futex1 does so
>>>> that the futex1 code can be deleted internally?
>>>
>>> I think, André will answer this, but my guess is, as stated above, 
>>> this is a
>>> lot of work and time while the intermediate version is already useful.
>>
>> useful to who?  I still do not understand what users will be needing
>> this.  All I can tell is a single userspace program wants to use it, and
>> that is a fork from the real project it was based on and that the
>> maintainers have no plan to merge it back.
>>
>> So who does need/want this?
> 
> I mentioned C++ std::atomic and Boost.Atomic before. Those need variable 
> sized futexes.
> 
> The project you mention is probably Wine and its derivatives. Those need 
> variable sized futexes and "wait for multiple" operation. I'm not sure 
> about the "no plan to merge it back" part, I probably missed it in an 
> earlier discussion. There are multiple different patches and versions 
> out there, and I don't know which one it refers to. But WaitOnAddress 
> and WaitForMultipleObjects APIs are very important and I would assume 
> Wine wants to emulate those with best efficiency.

See [0]. The short version is that we can't use futexes the way that 
out-of-tree patch set does, due to compatibility and robustness 
problems. I wrote said patch set and I'm currently working on a 
different solution for upstreaming.

We also can't exactly use futexes to back WaitOnAddress() directly. We 
actually do currently, but for various complex reasons that needs to 
change, and none of the proposals for futex2 help the new implementation.

ἔρρωσο,
Zebediah

[0] 
https://lore.kernel.org/lkml/dab34fd2-b494-8686-bcd7-68beeba4f386@gmail.com/
