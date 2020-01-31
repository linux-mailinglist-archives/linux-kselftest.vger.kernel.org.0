Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F3F14F0EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgAaQzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 11:55:21 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36345 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgAaQzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 11:55:21 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so5358211ywc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2020 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KhtHImXtz0JOAa4RO8x+lv3CDdZ2tWniHcetxHbNDM=;
        b=cm0aso3/Xjvi4skad8txSnRwV2bnnpVCWs5H/1KesxyDUCchgXrPHUKtGgfkVrIzsr
         RhA/i4SUp2BpBBIijrJ1hq5NlmlUfmutY/imQFb6qcUBrPKcnO6RjnUtUzIRzk0k5eBV
         EOf/lVdhObbZ7QaFGuZlVmXc1qmLclUXsVXXD+de7m3c3nmLpdS7elL4LXGhgOPjHysz
         WrFDwnOHRJh8lms8SkByj18vTFjadZmwwNj4/a+RJTgB1qQJfypSpcUKJoOuT6qChWaI
         H1RwaSeIOjio8RJmhOq88wFsHisugJaCDK/IZaWJQeAc3XB8xxOCCxVrZLlUnZF36wgv
         70Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KhtHImXtz0JOAa4RO8x+lv3CDdZ2tWniHcetxHbNDM=;
        b=CgxjfR1LCgC8U1AoNBvJ5PcRrbjSTMT8wqb3TnGB8LL0sfmdjmCKn42ILUY/UiNZSr
         PSViGMEGOEEXsSVyLLu1Orhac72S6ibfqMRA+cqlPer6bCMdqfYkoSu+ShTi3vblWlRQ
         BSKgycdmP3L3RUCansxBZTP+ZRUKUcqmjBYm6ZrP+2Vkv6Xoeig9Ta/83GJ1F4eBqCvZ
         UDkst6Z/qr+tKqj+mRLHe6UkL5TJvbmP/G8xjJPKcFwXEyppcf/7KJZ2HvrGc0L2g54K
         ++C+f3l48F+mv4qjEsfufOAtLHR2Cd5NwVSErIDDVf2D0VU+EM2jngEYqxPWQ6UisnqN
         JOpQ==
X-Gm-Message-State: APjAAAUwMpfzTmRbEACLu8izNARVl2UZ+wkK0iZFz9/8OXS9lRMzhPZY
        QcY6xGb9xsgJzk8QbhysI3UypuCDV/skRYeQI4KeBw==
X-Google-Smtp-Source: APXvYqy1pS828g+jsBdHmsd0kpbGo7NWEEkG1HfX+h0fyxOklzg1bd4R3xdI/sm4OG5ERTTWBOOwY9txYilItD+ZW7k=
X-Received: by 2002:a81:3845:: with SMTP id f66mr9055421ywa.220.1580489719518;
 Fri, 31 Jan 2020 08:55:19 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+rKfAhUjYLoEhyYj8OsRBtHC+ukPcE6CuTAJjb183GRQ@mail.gmail.com>
 <20200131161200.8852-1-sjpark@amazon.com>
In-Reply-To: <20200131161200.8852-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 08:55:08 -0800
Message-ID: <CANn89iJjZdoTKnnHNAByp7euDWo0aW9bL8ngw78vx4z7pwBJiw@mail.gmail.com>
Subject: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK
 is received
To:     sjpark@amazon.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 8:12 AM <sjpark@amazon.com> wrote:
>
> On Fri, 31 Jan 2020 07:01:21 -0800 Eric Dumazet <edumazet@google.com> wrote:
>
> > On Fri, Jan 31, 2020 at 4:25 AM <sjpark@amazon.com> wrote:
> >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  net/ipv4/tcp_input.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 2a976f57f7e7..b168e29e1ad1 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -5893,8 +5893,12 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
> > >                  *        the segment and return)"
> > >                  */
> > >                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> > > -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> > > +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> > > +                       /* Previous FIN/ACK or RST/ACK might be ignore. */
> > > +                       inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> > > +                                                 TCP_ATO_MIN, TCP_RTO_MAX);
> >
> > This is not what I suggested.
> >
> > I suggested implementing a strategy where only the _first_ retransmit
> > would be done earlier.
> >
> > So you need to look at the current counter of retransmit attempts,
> > then reset the timer if this SYN_SENT
> > socket never resent a SYN.
> >
> > We do not want to trigger packet storms, if for some reason the remote
> > peer constantly sends
> > us the same packet.
>
> You're right, I missed the important point, thank you for pointing it.  Among
> retransmission related fields of 'tcp_sock', I think '->total_retrans' would
> fit for this check.  How about below change?
>
> ```
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2a976f57f7e7..29fc0e4da931 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5893,8 +5893,14 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>                  *        the segment and return)"
>                  */
>                 if (!after(TCP_SKB_CB(skb)->ack_seq, tp->snd_una) ||
> -                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt))
> +                   after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> +                       /* Previous FIN/ACK or RST/ACK might be ignored. */
> +                       if (tp->total_retrans == 0)

canonical fied would be icsk->icsk_retransmits (look in net/ipv4/tcp_timer.c )

AFAIK, it seems we forget to clear tp->total_retrans in tcp_disconnect()
I will send a patch for this tp->total_retrans thing.

> +                               inet_csk_reset_xmit_timer(sk,
> +                                               ICSK_TIME_RETRANS, TCP_ATO_MIN,
> +                                               TCP_RTO_MAX);
>                         goto reset_and_undo;
> +               }
>
>                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
>                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> ```
>
> Thanks,
> SeongJae Park
>
> >
> > Thanks.
> >
> > >                         goto reset_and_undo;
> > > +               }
> > >
> > >                 if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
> > >                     !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
> > > --
> > > 2.17.1
> > >
> >
