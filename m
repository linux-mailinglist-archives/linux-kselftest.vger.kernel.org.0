Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD181743D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 01:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB2AfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 19:35:09 -0500
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:48769 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgB2AfI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 19:35:08 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 19:35:08 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1582936507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufSd4liXEtenLWhEiDRwdDyH9pGFym23PUH1iGN1T4E=;
        b=cQI5iljcNDqyC/rfM7AUnqOqLGxP4NpKtHI6brXcIJNb/xegFr/heFrY9f2+dDTEg09ZoQ
        UovkbFP2EXMecXWm3DkR2X0r1PsjbdQwF7ypdVIfSxVmupVvwV2Be8giQAJ+J6myUH9TAu
        efD0VQer93L00647Dh2wAgNKNg20JLQ=
Received: from smtp02.valvesoftware.com (smtp02.valvesoftware.com
 [208.64.203.182]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-hPciQZ--OhuhdebqPrhmXQ-1; Fri, 28 Feb 2020 19:28:59 -0500
X-MC-Unique: hPciQZ--OhuhdebqPrhmXQ-1
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp02.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1j7q02-0001t0-5N; Fri, 28 Feb 2020 16:28:58 -0800
Received: from antispam.valve.org (127.0.0.1) id hb6o4k0171sf; Fri, 28 Feb 2020 16:28:58 -0800 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o202002290028580002852-5; Fri, 28 Feb 2020 16:28:58 -0800
Received: from [172.18.21.27] (172.18.21.27) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Feb
 2020 16:28:57 -0800
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
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
Date:   Fri, 28 Feb 2020 16:29:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3aflqm.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-C2ProcessedOrg: d7674bc1-f4dc-4fad-9e9e-e896f8a3f31b
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o202002290028580002852
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/28/20 1:25 PM, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Fri, Feb 28, 2020 at 08:07:17PM +0100, Peter Zijlstra wrote:
>>> So I have a problem with this vector layout, it doesn't allow for
>>> per-futex flags, and esp. with that multi-size futex support that
>>> becomes important, but also with the already extand private/shared and
>>> wait_bitset flags this means you cannot have a vector with mixed wait
>>> types.
>>
>> Alternatively, we throw the entire single-syscall futex interface under
>> the bus and design a bunch of new syscalls that are natively vectored or
>> something.
>>
>> Thomas mentioned something like that, the problem is, ofcourse, that we
>> then want to fix a whole bunch of historical ills, and the probmem
>> becomes much bigger.
>=20
> We keep piling features on top of an interface and mechanism which is
> fragile as hell and horrible to maintain. Adding vectoring, multi size
> and whatever is not making it any better.
>=20
> There is also the long standing issue with NUMA, which we can't address
> with the current pile at all.
>=20
> So I'm really advocating that all involved parties sit down ASAP and
> hash out a new and less convoluted mechanism where all the magic new
> features can be addressed in a sane way so that the 'F' in Futex really
> only means Fast and not some other word starting with 'F'.

Are you specifically talking about the interface, or the mechanism=20
itself? Would you be OK with a new syscall that calls into the same code=20
as this patch? It does seem like that's what we want, so if we rewrote a=20
mechanism I'm not convinced it would come out any different. But, the=20
interface itself seems fair-game to rewrite, as the current futex=20
syscall is turning into an ioctl of sorts.

This solves a real problem with a real usecase; so I'd like to stay=20
practical and not go into deeper issues like solving NUMA support for=20
all of futex in the interest of users waiting at the other end. Can you=20
point us to your preferred approach just for the scope of what we're=20
trying to accomplish?

>=20
> Thanks,
>=20
>          tglx
>=20

