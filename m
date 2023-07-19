Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317F6759CED
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGSR5S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSR5R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 13:57:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C11FE8
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 10:57:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e3b15370so5396972b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689789434; x=1690394234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FVEMGAeC4A4acfilWsGklHz88eR5z5EWRCCV9Kst0I=;
        b=0Q1tzUOb9vYJXHmPeDryrYB5A4pEESrmEqXYj9Hg+90Z5+QCPv2ecrkofZgQVHrh2Q
         2SmV6ESktQAtsjCYVJZhJojTRHsrQLvYLqNH0EoTgXcN4+EyUGH6ZSXKFYb02Y0hiirh
         icie1/r4QjaO+Xr/8VrDJJ+t8iIcRUo2snH46DM7aXAbB12rMZS46rJ2h5Z2q3coLAKN
         GMT7GgUwcUUW4SpZr+6zG8X6fnKROWImTBv7u2v/1CdFXwNuMSzJvhzr6uNXEVsoU8p0
         jr3ynj+/29rinW5TGGhTFa+uF7yLH222PS2w2a9Iu7qAlX2Am1gjapUEui6PcMe/HT1i
         pwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789434; x=1690394234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FVEMGAeC4A4acfilWsGklHz88eR5z5EWRCCV9Kst0I=;
        b=jTDARx9Xi/sQlzGTfBlNsgU59vrwB0gXql2AQ2iebOEpfxkgYhSAiLkQhXEgNrYcgB
         It5Kg0YE8mChHkzqKlgsvF93Oga4P37L6Qy2Ty3sBJW/wHLorQnL/sUAIEnihMH3NQFs
         4HSbfN/65w4LVBWzxrlqVbP7id8DiegGNZoDeaVM93jrN0Dj3Q3NTJBJoUy6Dy68GcuY
         7mhAoKEjC/bGz823oAh4dhZnnRfAOL4MV3yZTBFZ9oC3dFRCeA+OZrCBrE3tW8IJQTt3
         WxHulzkZDrDZ7H/fuEMY0naEflsbLCnqfCqTuBy4ZULdzxWy65xK8DBwOBkuUA8hEW8L
         4bLQ==
X-Gm-Message-State: ABy/qLbV0iTdZpHpNXlouT+Iqm/4vBkQAKF6QRQkfPwcZ3PiPC5xGrwO
        8jlBYjbKm4hA+RzxtKXLNQo1wA==
X-Google-Smtp-Source: APBJJlEsVXT/riHHb217/IRnC4FkTdrL+WEIRgGEaqW1QkKPQqx7J9SZ2+4YPKCL/Z0Wz9JzjQeyoQ==
X-Received: by 2002:a17:90a:d598:b0:264:97a:2ba6 with SMTP id v24-20020a17090ad59800b00264097a2ba6mr4560333pju.7.1689789434001;
        Wed, 19 Jul 2023 10:57:14 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id nw17-20020a17090b255100b00263f41a655esm1415304pjb.43.2023.07.19.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:57:13 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:57:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <20230719105711.448f8cad@hermes.local>
In-Reply-To: <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
References: <20230710223304.1174642-1-almasrymina@google.com>
        <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
        <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
        <ZLbUpdNYvyvkD27P@ziepe.ca>
        <20230718111508.6f0b9a83@kernel.org>
        <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
        <20230718112940.2c126677@kernel.org>
        <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
        <20230718154503.0421b4cd@kernel.org>
        <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 19 Jul 2023 08:10:58 -0700
Mina Almasry <almasrymina@google.com> wrote:

> On Tue, Jul 18, 2023 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 18 Jul 2023 16:35:17 -0600 David Ahern wrote: =20
> > > I do not see how 1 RSS context (or more specifically a h/w Rx queue) =
can
> > > be used properly with memory from different processes (or dma-buf
> > > references). =20
>=20
> Right, my experience with dma-bufs from GPUs are that they're
> allocated from the userspace and owned by the process that allocated
> the backing GPU memory and generated the dma-buf from it. I.e., we're
> limited to 1 dma-buf per RX queue. If we enable binding multiple
> dma-bufs to the same RX queue, we have a problem, because AFAIU the
> NIC can't decide which dma-buf to put the packet into (it hasn't
> parsed the packet's destination yet).
>=20
> > > When the process dies, that memory needs to be flushed from
> > > the H/W queues. Queues with interlaced submissions make that more
> > > complicated. =20
> > =20
>=20
> When the process dies, do we really want to flush the memory from the
> hardware queues? The drivers I looked at don't seem to have a function
> to flush the rx queues alone, they usually do an entire driver reset
> to achieve that. Not sure if that's just convenience or there is some
> technical limitation there. Do we really want  to trigger a driver
> reset at the event a userspace process crashes?

Naive idea.
Would it be possible for process to use mmap() on the GPU memory and then
do zero copy TCP receive some how? Or is this what is being proposed.
