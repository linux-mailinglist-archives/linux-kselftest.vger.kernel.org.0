Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CC2A514
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2019 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfEYPU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 May 2019 11:20:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46465 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfEYPU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 May 2019 11:20:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id x144so723943ywd.13
        for <linux-kselftest@vger.kernel.org>; Sat, 25 May 2019 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFixVte+KRZ0eDi2dM904QnB5LrKYVziMe7pK+9vKpA=;
        b=uS7W7fBCo8MN4KH49ynbBJFE22ReYcNJXR65W82MPwze63XpTnI1Jl/vuoRl4hPLTr
         YmDDJj+vlCp92KxAOZuN01blzuOusbBGeYPQ17ubOS6S/2KYA3DDu5dvsSjb1v1lvnbH
         VCvbxa5V4BszgCANSd1SXNWKDbhS7sGlzvrPSoDcqGHgVA4QQT+cdZo0q1e4nk+Elo1P
         dNDYfMsvWWaPskxYOvhoOtnB8WifeIEaQYde27cdX3HIxt0KTnrgVHVGQCdXLnw5w0dR
         YmDG0PjAq3c4aQj0f3vfwdVnQDP7nWIXq/3qBfQ8IKmsaki1eGDldE6d/SOalLcg0J00
         ZXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFixVte+KRZ0eDi2dM904QnB5LrKYVziMe7pK+9vKpA=;
        b=NeR3z8NEvd9GeWPP+CxCbpBbE/7oLm7qhToyA15xwK/xQ6eUqlSaeE4Mn2ybo9Znah
         TkLZh0xe8HN49ArUqkCHrOkFEEEs+ks4SWBgPMwZxFippogxajUOdRgyzABeXk4JiFSf
         JUFQSQ6EWBDE27J6pLmAekQQqS/jV8CikRBdSfDGyrJkErWvwckmod2LOYsiaduwQyys
         K/+RcV9u+S0BTMH/FJJq9PkuYhoSCQSc6TdH3kP9tvIaLTnbkQKO7u+eARuJHJNTBd1Y
         WiK7AI1QHglFusDOn3/FyazJIxnnfMZObFCd+DuWuI96ONct/RXGAXZTMm5ENTZjkzN5
         EH8A==
X-Gm-Message-State: APjAAAUE6+vdJ4izn7nPE6Q0v98NXRLkx1f8l8UL7Cgh1tYppZspS6J8
        GbGADJ1ngnyT8Lin2kMLqBzeZOyG
X-Google-Smtp-Source: APXvYqxW7tA48RLf/gTO2ov16ZV0CoRTnWz93d8h9Kvr5b6iBX5y99p0f0qdSSrOs9f4yGj9jKdTmg==
X-Received: by 2002:a0d:d785:: with SMTP id z127mr5867134ywd.261.1558797657814;
        Sat, 25 May 2019 08:20:57 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id d132sm1500184ywc.89.2019.05.25.08.20.56
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 08:20:56 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id x187so4826136ybc.11
        for <linux-kselftest@vger.kernel.org>; Sat, 25 May 2019 08:20:56 -0700 (PDT)
X-Received: by 2002:a25:f509:: with SMTP id a9mr50352842ybe.391.1558797656141;
 Sat, 25 May 2019 08:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190523210651.80902-1-fklassen@appneta.com> <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
 <AE8E0772-7256-4B9C-A990-96930E834AEE@appneta.com> <CAF=yD-LtAKpND601LQrC1+=iF6spSUXVdUapcsbJdv5FYa=5Jg@mail.gmail.com>
 <AFC1ECC8-BFAC-4718-B0C9-97CC4BD1F397@appneta.com> <CAF=yD-Le-eTadOi7PL8WFEQCG=yLqb5gvKiks+s5Akeq8TenBQ@mail.gmail.com>
 <90E3853F-107D-45BA-93DC-D0BE8AC6FCBB@appneta.com>
In-Reply-To: <90E3853F-107D-45BA-93DC-D0BE8AC6FCBB@appneta.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 25 May 2019 11:20:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTScNr9Srsn9QFBSj=oT4TnMh1QuOZ2h40g=joNjSwccqMg@mail.gmail.com>
Message-ID: <CA+FuTScNr9Srsn9QFBSj=oT4TnMh1QuOZ2h40g=joNjSwccqMg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
To:     Fred Klassen <fklassen@appneta.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 24, 2019 at 6:01 PM Fred Klassen <fklassen@appneta.com> wrote:
>
>
>
> > On May 24, 2019, at 12:29 PM, Willem de Bruijn <willemdebruijn.kernel@g=
mail.com> wrote:
> >
> > It is the last moment that a timestamp can be generated for the last
> > byte, I don't see how that is "neither the start nor the end of a GSO
> > packet=E2=80=9D.
>
> My misunderstanding. I thought TCP did last segment timestamping, not
> last byte. In that case, your statements make sense.
>
> >> It would be interesting if a practical case can be made for timestampi=
ng
> >> the last segment. In my mind, I don=E2=80=99t see how that would be va=
luable.
> >
> > It depends whether you are interested in measuring network latency or
> > host transmit path latency.
> >
> > For the latter, knowing the time from the start of the sendmsg call to
> > the moment the last byte hits the wire is most relevant. Or in absence
> > of (well defined) hardware support, the last byte being queued to the
> > device is the next best thing.

Sounds to me like both cases have a legitimate use case, and we want
to support both.

Implementation constraints are that storage for this timestamp
information is scarce and we cannot add new cold cacheline accesses in
the datapath.

The simplest approach would be to unconditionally timestamp both the
first and last segment. With the same ID. Not terribly elegant. But it
works.

If conditional, tx_flags has only one bit left. I think we can harvest
some, as not all defined bits are in use at the same stages in the
datapath, but that is not a trivial change. Some might also better be
set in the skb, instead of skb_shinfo. Which would also avoids
touching that cacheline. We could possibly repurpose bits from u32
tskey.

All that can come later. Initially, unless we can come up with
something more elegant, I would suggest that UDP follows the rule
established by TCP and timestamps the last byte. And we add an
explicit SOF_TIMESTAMPING_OPT_FIRSTBYTE that is initially only
supported for UDP, sets a new SKBTX_TX_FB_TSTAMP bit in
__sock_tx_timestamp and is interpreted in __udp_gso_segment.

> >
> > It would make sense for this software implementation to follow
> > established hardware behavior. But as far as I know, the exact time a
> > hardware timestamp is taken is not consistent across devices, either.
> >
> > For fine grained timestamped data, perhaps GSO is simply not a good
> > mechanism. That said, it still has to queue a timestamp if requested.
>
> I see your point. Makes sense to me.
>
> >> When using hardware timestamping, I think you will find that nearly al=
l
> >> adapters only allow one timestamp at a time. Therefore only one
> >> packet in a burst would get timestamped.
> >
> > Can you elaborate? When the host queues N packets all with hardware
> > timestamps requested, all N completions will have a timestamp? Or is
> > that not guaranteed?
> >
>
> It is not guaranteed. The best example is in ixgbe_main.c and search for
> =E2=80=98SKBTX_HW_TSTAMP=E2=80=99.  If there is a PTP TX timestamp in pro=
gress,
> =E2=80=98__IXGBE_PTP_TX_IN_PROGRESS=E2=80=99 is set and no other timestam=
ps
> are possible. The flag is cleared after transmit softirq, and only then
> can another TX timestamp be taken.

Interesting, thanks. I had no idea.
