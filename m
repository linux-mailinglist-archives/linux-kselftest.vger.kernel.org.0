Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA2176C7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 03:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgCCC5A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Mar 2020 21:57:00 -0500
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:32772 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbgCCCsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1583203708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvE9T2Bz+JTtEMUGdn6Ryihpl6seEYU5FEn8O251FgY=;
        b=QmUZ2fOO+dnW6XKENjaKQG+wwQ2wR22vzzP/nCCKwtvAVZxUDcWLjhbxhOfzCzMKJ1ofgp
        pJEARf0pA35zzqlgAsxFRaMzoda8gOyLDabBO1+Jj5inhmHxXtCwa0HSwHB9D5PWSIvjqk
        a+9vFXMazst2SF/KGxnZhU9KG5xIaNw=
Received: from smtp02.valvesoftware.com (smtp02.valvesoftware.com
 [208.64.203.182]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-rxXDkuBvOYCkL6LbzZeo5Q-1; Mon, 02 Mar 2020 21:47:22 -0500
X-MC-Unique: rxXDkuBvOYCkL6LbzZeo5Q-1
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp02.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1j8xab-0001dp-KK; Mon, 02 Mar 2020 18:47:21 -0800
Received: from antispam.valve.org (127.0.0.1) id hbn2ji0171sl; Mon, 2 Mar 2020 18:47:21 -0800 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o202003030247210012484-5; Mon, 02 Mar 2020 18:47:21 -0800
Received: from [172.18.21.27] (172.18.21.27) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Mar 2020
 18:47:21 -0800
Subject: Re: [PATCH v3 1/4] futex: Implement mechanism to wait on any of
 several futexes
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@collabora.com>,
        <krisman@collabora.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <rostedt@goodmis.org>,
        <ryao@gentoo.org>, <dvhart@infradead.org>, <mingo@redhat.com>,
        <z.figura12@gmail.com>, <steven@valvesoftware.com>,
        <steven@liquorix.net>, <malteskarupke@web.de>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
 <20200213214525.183689-2-andrealmeid@collabora.com>
 <20200228190717.GM18400@hirez.programming.kicks-ass.net>
 <20200228194958.GO14946@hirez.programming.kicks-ass.net>
 <87tv3aflqm.fsf@nanos.tec.linutronix.de>
 <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
 <87o8thg031.fsf@nanos.tec.linutronix.de>
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
Date:   Mon, 2 Mar 2020 18:47:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o8thg031.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-C2ProcessedOrg: d7674bc1-f4dc-4fad-9e9e-e896f8a3f31b
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o202003030247210012484
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/29/20 2:27 AM, Thomas Gleixner wrote:
> "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com> writes:
>> On 2/28/20 1:25 PM, Thomas Gleixner wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> Thomas mentioned something like that, the problem is, ofcourse, that w=
e
>>>> then want to fix a whole bunch of historical ills, and the probmem
>>>> becomes much bigger.
>>>
>>> We keep piling features on top of an interface and mechanism which is
>>> fragile as hell and horrible to maintain. Adding vectoring, multi size
>>> and whatever is not making it any better.
>>>
>>> There is also the long standing issue with NUMA, which we can't address
>>> with the current pile at all.
>>>
>>> So I'm really advocating that all involved parties sit down ASAP and
>>> hash out a new and less convoluted mechanism where all the magic new
>>> features can be addressed in a sane way so that the 'F' in Futex really
>>> only means Fast and not some other word starting with 'F'.
>>
>> Are you specifically talking about the interface, or the mechanism
>> itself? Would you be OK with a new syscall that calls into the same code
>> as this patch? It does seem like that's what we want, so if we rewrote a
>> mechanism I'm not convinced it would come out any different. But, the
>> interface itself seems fair-game to rewrite, as the current futex
>> syscall is turning into an ioctl of sorts.
>=20
> No, you are misreading what I said. How does a new syscall make any
> difference? It still adds new crap to a maze which is already in a state
> of dubious maintainability.

I was just going by the context added by Peter, which seemed to imply=20
your concerns were mostly around the interface, because I couldn't=20
understand a clear course of action to follow just from your email. And=20
frankly, still can't, but hopefully you can help us get there.

>=20
>> This solves a real problem with a real usecase; so I'd like to stay
>> practical and not go into deeper issues like solving NUMA support for
>> all of futex in the interest of users waiting at the other end. Can you
>> point us to your preferred approach just for the scope of what we're
>> trying to accomplish?
>=20
> If we go by the argument that something solves a real use case and take
> this as justification to proliferate existing crap, then we never get to
> the point where things get redesigned from ground up. Quite the
> contrary, we are going to duct tape it to death.
>=20
> It does not matter at all whether the syscall is multiplexing or split
> up into 5 different ones. That's a pure cosmetic exercise.
>=20
> While all the currently proposed extensions (multiple wait, variable
> size) make sense conceptually, I'm really uncomfortable to just cram
> them into the existing code. They create an ABI which we have to
> maintain forever.
>=20
>  From experience I just know that every time we extended the futex
> interface we opened another can of worms which hunted us for years if
> not for more then a decade. Guess who has to deal with that. Surely not
> the people who drive by and solve their real world usecases. Just go and
> read the changelog history of futexes very carefully and you might
> understand what kind of complex beasts they are.
>=20
> At some point we simply have to say stop, sit down and figure out which
> kind of functionality we really need in order to solve real world user
> space problems and which of the gazillion futex (mis)features are just
> there as historical ballast and do not have to be supported in a new
> implementation, REQUEUE is just the most obvious example.
>=20
> I completely understand that you want to stay practical and just want to
> solve your particular itch, but please understand that the people who
> have to deal with the fallout and have dealt with it for 15+ years have
> very practical reasons to say no.

Note that it would have been nice to get that high-level feedback on the=20
first version; instead we just received back specific feedback on the=20
implementation itself, and questions about usecase/motivation that we=20
tried to address, but that didn't elicit any follow-ups.

Please bear with me for a second in case you thought you were obviously=20
very clear about the path forward, but are you saying that:

  1. Our usecase is valid, but we're not correct about futex being the=20
right fit for it, and we should design an implement a new primitive to=20
handle it?

  2. Our usecase is valid, and our research showing that futex is the=20
optimal right fit for it might be correct, but futex has to be=20
significantly refactored before accepting this new feature. (or any new=20
feature?)

If it was 1., I think our new solution would either end up looking more=20
or less exactly like futex, just with some of the more exotic=20
functionality removed (although even that is arguable, since I wouldn't=20
be surprised if we ended up using eg. requeue for some of the more=20
complex migration scenarios). In which case I assume someone else would=20
ask the question on why we're doing this new thing instead of adding to=20
futex. OR, if intentionally made not futex-like, would end up not being=20
optimal, which would make it not the right solution and a non-started to=20
begin with. There's a reason we moved away from eventfd, even ignoring=20
the fd exhaustion problem that some problematic apps fall victim to.

If it's 2., then we'd be hard-pressed to proceed forward without your=20
guidance.

Conceptually it seems like multiple wait is an important missing feature=20
in futex compared to core threading primitives of other platforms. It=20
isn't the first time that the lack of it has come up for us and other=20
game developers. Due to futex being so central and important, I=20
completely understand it is tricky to get right and might be hard to=20
maintain if not done correctly. It seems worthwhile to undertake, at=20
least from our limited perspective. We'd be glad to help upstream get=20
there, if possible.

Thanks,
  - Pierre-Loup


>=20
> Thanks,
>=20
>          tglx
>=20

