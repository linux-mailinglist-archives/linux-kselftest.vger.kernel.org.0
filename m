Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD882A0D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2019 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbfEXWB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 18:01:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38505 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404311AbfEXWB0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 18:01:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so6072105pfb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nt1Bto+RuKAe8F0XKPOQ+MhI4MGCp3IBcqE1bNWm624=;
        b=CP3pG9ifqRjFBc0YzSgRZhosVC3X/Gn1RGmFGqOzuMcKIczmIs/OCyyjYxWltNsfFk
         4mycd8lZIITJoEB+fcpjf8FT1kv+xkBDmO6lK+fhB4wuUjsW2BKF02fS2SVSabb57vwh
         ANBUCNIjYnb5tPURfcu15IQNfhbH/7OJVk0es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nt1Bto+RuKAe8F0XKPOQ+MhI4MGCp3IBcqE1bNWm624=;
        b=MzQyYkXvVs4jsXqhsJeKaIg1cScM3SS2eWhxKyWxXdJzCTJG6fm/d82U5PvumMZWQ4
         DSW2Nku2zjToNSV4LFaA2Mul0QYkWcDmADQRFPK3RvwOBdr07P1irQHj3gCK0soAqspN
         /Ml7h9BwuPbT8xRVoA9AFmnmNxd+4ifJpaSxaqXPyW+EC6j5myeDHkNgvmeeCzvADPxx
         jXe7C1zbFNxb7g8ReuCvGoCgW2St9pJlWgy0sj6XeNlLNc4E39YX7NuOWLwkTMaU9yA9
         7hdqz2eMd8zVmiUz4TFisM1u7qTjNRZ/0KpssY2dCilYchoz8hzZx36iSyC7qRdFuN9M
         EasA==
X-Gm-Message-State: APjAAAVppUy/pyP2GxtyOpdCH1VN01MbR6mNnRCjoRAO2qZb+TMKVJtf
        rPQI1qcnPg23dQ9188fbVHF5YA==
X-Google-Smtp-Source: APXvYqx1AU7WlE+4JCn2Y/DvThwLZLnoOhh2EBVLKjNWpqmzprHergerEz/Wt2MlbcL6sAcU78Bqng==
X-Received: by 2002:a17:90a:216d:: with SMTP id a100mr12026144pje.6.1558735285565;
        Fri, 24 May 2019 15:01:25 -0700 (PDT)
Received: from jltm109.jaalam.net (vancouver-a.appneta.com. [209.139.228.33])
        by smtp.gmail.com with ESMTPSA id e123sm3645702pgc.29.2019.05.24.15.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 15:01:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-Le-eTadOi7PL8WFEQCG=yLqb5gvKiks+s5Akeq8TenBQ@mail.gmail.com>
Date:   Fri, 24 May 2019 15:01:24 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90E3853F-107D-45BA-93DC-D0BE8AC6FCBB@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
 <AE8E0772-7256-4B9C-A990-96930E834AEE@appneta.com>
 <CAF=yD-LtAKpND601LQrC1+=iF6spSUXVdUapcsbJdv5FYa=5Jg@mail.gmail.com>
 <AFC1ECC8-BFAC-4718-B0C9-97CC4BD1F397@appneta.com>
 <CAF=yD-Le-eTadOi7PL8WFEQCG=yLqb5gvKiks+s5Akeq8TenBQ@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On May 24, 2019, at 12:29 PM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> It is the last moment that a timestamp can be generated for the last
> byte, I don't see how that is "neither the start nor the end of a GSO
> packet=E2=80=9D.

My misunderstanding. I thought TCP did last segment timestamping, not
last byte. In that case, your statements make sense.

>> It would be interesting if a practical case can be made for =
timestamping
>> the last segment. In my mind, I don=E2=80=99t see how that would be =
valuable.
>=20
> It depends whether you are interested in measuring network latency or
> host transmit path latency.
>=20
> For the latter, knowing the time from the start of the sendmsg call to
> the moment the last byte hits the wire is most relevant. Or in absence
> of (well defined) hardware support, the last byte being queued to the
> device is the next best thing.
>=20
> It would make sense for this software implementation to follow
> established hardware behavior. But as far as I know, the exact time a
> hardware timestamp is taken is not consistent across devices, either.
>=20
> For fine grained timestamped data, perhaps GSO is simply not a good
> mechanism. That said, it still has to queue a timestamp if requested.

I see your point. Makes sense to me.

>> When using hardware timestamping, I think you will find that nearly =
all
>> adapters only allow one timestamp at a time. Therefore only one
>> packet in a burst would get timestamped.
>=20
> Can you elaborate? When the host queues N packets all with hardware
> timestamps requested, all N completions will have a timestamp? Or is
> that not guaranteed?
>=20

It is not guaranteed. The best example is in ixgbe_main.c and search for
=E2=80=98SKBTX_HW_TSTAMP=E2=80=99.  If there is a PTP TX timestamp in =
progress,
=E2=80=98__IXGBE_PTP_TX_IN_PROGRESS=E2=80=99 is set and no other =
timestamps
are possible. The flag is cleared after transmit softirq, and only then
can another TX timestamp be taken. =20

>> There are exceptions, for
>> example I am playing with a 100G Mellanox adapter that has
>> per-packet TX timestamping. However, I suspect that when I am
>> done testing, all I will see is timestamps that are representing wire
>> rate (e.g. 123nsec per 1500 byte packet).
>>=20
>> Beyond testing the accuracy of a NIC=E2=80=99s timestamping =
capabilities, I
>> see very little value in doing per-segment timestamping.
>=20
> Ack. Great detailed argument, thanks.

Thanks. I=E2=80=99m a timestamping nerd and have learned lots with this=20=

discussion.

