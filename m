Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BE214F655
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2020 04:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBADzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 22:55:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42034 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBADzw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 22:55:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so9386983oih.9
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2020 19:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpR02gdbkQHjEdxG9SGzf7pEIWQTwMtXqw53xDeIps0=;
        b=VQjFL00X7xtyXkCCDgN3B68jvRIqMEmqrDPxRd5YE3DRN80cjuRwJc+vxnog0d9I5v
         oefItgDUERaDVY/Gd5fT07KrQSGyCfMFvmsVeDqKTlRMu4QC5hyubUOprxRi3O2iZk9S
         v53qnNnUyOyS8RL4KLV+hKJDShcM7+QvFo2HLP4uXwSiTMCgRy8D2WH6g4GTnvEFjn5i
         by/CkmTLDYrhvYjZ9s8vSWSUayYwFsYMnktoKLw6TUHPxil+24ZVVOm8A4US4MkV6VHQ
         XfULhdcSaKINaYs0Qt9Xq7gu1CkXzn/q0rbEaqmknolSfd9wEwSLp6tTknjiPAawKRvF
         g/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpR02gdbkQHjEdxG9SGzf7pEIWQTwMtXqw53xDeIps0=;
        b=KL3VIsNxeVcezPexBkFP3JPe/4Ba1g4wH+zDC69eqcDMAXcYtOsOEaqGQQnTXcOPUt
         UycRkn1oBhfo40Reech5j13LYtkncGb81qyObgzMmuSdv69P7+6T3/PdsfO2I2vn+BAp
         6WF7Ro5axdNBQCt6BdkRUYdlT/oPBhkNTp0+wNCxQsxYKtJeAnvofPKLuLpx9oiExkC2
         dLwoKY7i3Iq6GdxXgST/0FX+NHmpYFJduUFqgn+02CDMR5I6xVe5ceQ+yGQvCrFGUKQ2
         Yyx9frQZWnRQFOqpd5ugcbNU1yumIOcUx9BIZavEsDoGCuPuSaVJAxKA86WlRn46kqsB
         aVtQ==
X-Gm-Message-State: APjAAAXVCEHSi80NckWvn3rsbFfShI4hX92sYIxIlApYcukyYXedwzWm
        DrL/s/CosfVc2k2WhVIPHc6JL9k0nx/7/XqZK3f9AGeQUck=
X-Google-Smtp-Source: APXvYqxjgAjU3MBV4JGRRnsokOeDc9RuSZPhvl788mDb/V6Q+vKxvqq99N+lRsnjuxpaGJX4PklmpwXXNaKnby1DZuc=
X-Received: by 2002:aca:1b17:: with SMTP id b23mr6844579oib.95.1580529351343;
 Fri, 31 Jan 2020 19:55:51 -0800 (PST)
MIME-Version: 1.0
References: <CADVnQy=Z0YRPY_0bxBpsZvECgamigESNKx6_-meNW5-6_N4kww@mail.gmail.com>
 <20200131221755.3874-1-sj38.park@gmail.com>
In-Reply-To: <20200131221755.3874-1-sj38.park@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 31 Jan 2020 22:55:34 -0500
Message-ID: <CADVnQy=oFmmG-Z9QMafWLcALOBgohADgwScn2r+7CGFNAw5jvw@mail.gmail.com>
Subject: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK
 is received
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, sjpark@amazon.com,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, shuah@kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, aams@amazon.com,
        SeongJae Park <sjpark@amazon.de>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 5:18 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Fri, 31 Jan 2020 17:11:35 -0500 Neal Cardwell <ncardwell@google.com> wrote:
>
> > On Fri, Jan 31, 2020 at 1:12 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > >
> > >
> > >
> > > On 1/31/20 7:10 AM, Neal Cardwell wrote:
> > > > On Fri, Jan 31, 2020 at 7:25 AM <sjpark@amazon.com> wrote:
> > > >>
> > > >> From: SeongJae Park <sjpark@amazon.de>
> > > >>
> > > >> When closing a connection, the two acks that required to change closing
> > > >> socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
> > > >> reverse order.  This is possible in RSS disabled environments such as a
> > > >> connection inside a host.
> [...]
> >
> > I looked into fixing this, but my quick reading of the Linux
> > tcp_rcv_state_process() code is that it should behave correctly and
> > that a connection in FIN_WAIT_1 that receives a FIN/ACK should move to
> > TIME_WAIT.
> >
> > SeongJae, do you happen to have a tcpdump trace of the problematic
> > sequence where the "process A" ends up in FIN_WAIT_2 when it should be
> > in TIME_WAIT?
>
> Hi Neal,
>
>
> Yes, I have.  You can get it from the previous discussion for this patchset
> (https://lore.kernel.org/bpf/20200129171403.3926-1-sjpark@amazon.com/).  As it
> also has a reproducer program and how I got the tcpdump trace, I believe you
> could get your own trace, too.  If you have any question or need help, feel
> free to let me know. :)

Great. Thank you for the pointer.

I had one quick question: in the message:
  https://lore.kernel.org/bpf/20200129171403.3926-1-sjpark@amazon.com/
... it showed a trace with the client sending a RST/ACK, but this
email thread shows a FIN/ACK. I am curious about the motivation for
the difference?

Anyway, thanks for the report, and thanks to Eric for further clarifying!

neal
