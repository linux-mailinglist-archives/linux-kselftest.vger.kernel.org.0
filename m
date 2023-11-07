Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA17E4967
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKGTxk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 14:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGTxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 14:53:39 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF25D79
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 11:53:37 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so2707949241.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699386816; x=1699991616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnuTqDfsVwYZum4mgCN3P8a9mRjXV0bf7p3FmGowjyI=;
        b=a5TJirnGDnG5vS2j1RCuf6MxnsaEHGicNgGIKWYcB3F8RYwOQsSocoB+ks/0cTDSgx
         pzh+qIOA+n9uAw0FHi0H/NmSmzeMQCvKVLRYWsIZbQv/9dYbQAsgvPjTh+x1qV1hIqhg
         +XCxxBCpHvwI0n5/oqKnyuGSxaSVuj2eEBUtciWoxYx5cQZnrkNnhDKtP/Iwp6ZcNj5w
         gKdzr3iabJumXACkbamfbA2nTi7SUE+v7LyRVHt4DStEYWy0Wi5nnXTQaZn/Y6oC4A5/
         pQT5IiM3eB7wAEwEpJXGHGmB2JUJ75AwhN+Gu1JTwHpCWQoUQIkIrR+hvAKye3Or8lxj
         BeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386816; x=1699991616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnuTqDfsVwYZum4mgCN3P8a9mRjXV0bf7p3FmGowjyI=;
        b=cDsmkQx4htIpa9w2NlUO+Esb8Fz+1tUjdAeRhFNBoqb4kn8bstRPRHbV7g4lVom8cL
         2g0m0ELbziIrxwHsJxyhJAUmwOejrhFv1HOHQDb9uMDrlIMfquHFy0nj9Ode18FhznHE
         o8Jy3WrgrAdOtvVrqZwNE5qf7iCMugZxTLCvfps8cr2J2cJshcEmD4C2Xlm71x8qVlGF
         KSZA5ByJN7vPF956z4tDCTN6s5wyte+mQs6gkun9HwmHa3bYnwd7L/2FevJZL1QPFL+F
         6WhFpD2a+dkGFyhU2Wb49HOs4b/gk4A7pxwcL/8WwlIyYK9GUqA00M5Tyjd1E/HFzxCY
         +yvw==
X-Gm-Message-State: AOJu0YxWhAQhgcc77MY+T9F6fjj9hiaPJCEb1QSDqvUuwpEZFQevB9Q2
        g4x7Azn1z6zSSUz+CbuYG5BXCRnCDwkqX6VpQbazxg==
X-Google-Smtp-Source: AGHT+IFRfpykRqgBWNCOXyp4/VIT9n7OcqngEslUuXORQ+jDqZ50qQ8GNzo4lC3gCBtUGRfNYYENwfnNi6aElAPXvi8=
X-Received: by 2002:a05:6102:475a:b0:45d:86d0:27 with SMTP id
 ej26-20020a056102475a00b0045d86d00027mr11736495vsb.33.1699386816008; Tue, 07
 Nov 2023 11:53:36 -0800 (PST)
MIME-Version: 1.0
References: <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com> <ZUmNk98LyO_Ntcy7@google.com>
In-Reply-To: <ZUmNk98LyO_Ntcy7@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 7 Nov 2023 11:53:22 -0800
Message-ID: <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 6, 2023 at 5:06=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
[..]
> > > > And the socket has to know this association; otherwise those tokens
> > > > are useless since they don't carry anything to identify the dmabuf.
> > > >
> > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is tha=
t
> > > > it somehow implies that I have an option of passing or not passing =
it
> > > > for an individual system call.
> >
> > You do have the option of passing it or not passing it per system
> > call. The MSG_SOCK_DEVMEM says the application is willing to receive
> > devmem cmsgs - that's all. The application doesn't get to decide
> > whether it's actually going to receive a devmem cmsg or not, because
> > that's dictated by the type of skb that is present in the receive
> > queue, and not up to the application. I should explain this in the
> > commit message...
>
> What would be the case of passing it or not passing it? Some fallback to
> the host memory after flow steering update? Yeah, would be useful to
> document those constrains. I'd lean on starting stricter and relaxing
> those conditions if we find the use-cases.
>

MSG_SOCK_DEVMEM (or its replacement SOCK_DEVMEM or SO_SOCK_DEVMEM),
just says that the application is able to receive devmem cmsgs and
will parse them. The use case for not setting that flag is existing
applications that are not aware of devmem cmsgs. I don't want those
applications to think they're receiving data in the linear buffer only
to find out that the data is in devmem and they ignored the devmem
cmsg.

So, what happens:

- MSG_SOCK_DEVMEM provided and next skb in the queue is devmem:
application receives cmsgs.
- MSG_SOCK_DEVMEM provided and next skb in the queue is non-devmem:
application receives in the linear buffer.
- MSG_SOCK_DEVMEM not provided and net skb is devmem: application
receives EFAULT.
- MSG_SOCK_DEVMEM not provided and next skb is non-devmem: application
receives in the linear buffer.

My bad on not including some docs about this. The next version should
have the commit message beefed up to explain all this, or a docs
patch.


--=20
Thanks,
Mina
