Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0344C28EE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfEXBis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 21:38:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43858 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfEXBis (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 21:38:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so4076274pgv.10
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 18:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fIG1/oNez6GVfieaNVvRGqClWbB80a7VpaI4ZVWlUTY=;
        b=kGOO7QJjYShPVPBvs/ZZX4VQ4eRHKxuNroC1T1gSIH+LURunL1GYc8S5KkMJ4304nt
         D0vjJP1zY0itozAzVofvfnp6vwc37FxbJCWVEjzCPHkvqiNeBjdFsXbkJdDIa+f/G+o7
         l2A9DZTeNt5XJA8Qxui7ybi7g1aIi80biu8DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fIG1/oNez6GVfieaNVvRGqClWbB80a7VpaI4ZVWlUTY=;
        b=K8VHfl9BJ2KlKqNYPxvoxHa7LhBqfzHHatGwETnuPAdeCCzFGOQOwVLzsPOvqHZxqq
         C3CHzwPKXMC7xc3juAWUHDI173lo0gN+Ac+g4qb160Fr0R4yoCVEDFdyCRw5dpqgAG/k
         Wtj6qL3SEMtleglEQhRmHoi5/ZXIOAeLK+FRxb+t/1tGtZ4I5Ag63poHxj3Z8akHUGDk
         BEP8ejfBB2DPNBP7ZinEdlISQvZ7x/6Emb1+O5/WSYLSLnfuaf+IF+PxcEMiBnxGD9fr
         M5laI/KQZ2/imgOBdQ+x0sGpXXpY7pNtXk9ZN2zLuL1cxvgGRePszimKRCyTfqUUHvLR
         tr/Q==
X-Gm-Message-State: APjAAAW3CzyDNs0n30ZwN16Btlk5LAFO3zCOhIS5fk4+Cj7zT/+IimdT
        Csb5UE02E6GWSTrX9y9bKrYJDw==
X-Google-Smtp-Source: APXvYqxbCF0d1RN2Gw85wpBkrv/MWoagSl5+oFwhvvoDBMmfB9ADuQlYwD4bfak3BfVpG5B/MM3VLA==
X-Received: by 2002:a63:d016:: with SMTP id z22mr102922046pgf.116.1558661926884;
        Thu, 23 May 2019 18:38:46 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id f36sm524732pgb.76.2019.05.23.18.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 18:38:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
Date:   Thu, 23 May 2019 18:38:44 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE8E0772-7256-4B9C-A990-96930E834AEE@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Thanks for the report.
>=20
> Zerocopy notification reference count is managed in skb_segment. That
> should work.
>=20
> Support for timestamping with the new GSO feature is indeed an
> oversight. The solution is similar to how TCP associates the timestamp
> with the right segment in tcp_gso_tstamp.
>=20
> Only, I think we want to transfer the timestamp request to the last
> datagram, not the first. For send timestamp, the final byte leaving
> the host is usually more interesting.

TX Timestamping the last packet of a datagram is something that would
work poorly for our application. We need to measure the time it takes
for the first bit that is sent until the first bit of the last packet is =
received.
Timestaming the last packet of a burst seems somewhat random to me
and would not be useful. Essentially we would be timestamping a=20
random byte in a UDP GSO buffer.

I believe there is a precedence for timestamping the first packet. With
IPv4 packets, the first packet is timestamped and the remaining =
fragments
are not.=
