Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7381745974
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGCJ7Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjGCJ6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 05:58:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1974EFE
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 02:54:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98e109525d6so767918666b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jul 2023 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688377994; x=1690969994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iGJp3Y6rXle8uuZs1n28iqn7SIORXWqojx1agj3edY=;
        b=bphMktEdQ7kRVbqtpfQc9RhJUAIleyS9jzfQeitBsbWpVglcgIukNLf9QojsnXBl7Y
         7eSdQy3YQHS1OPoADbZmcuSsaRZk5STkaHKVeeDw93oo9EAUhXR/se9R2HA9zB8B1VDE
         Le4q6+XaE3HFMyVECQlhecyHDUQuiUUPLRD7mp5u6Bxo+6wHggU+aOaulkVVtGAp76P0
         8JohFw9mCyGO+KeT4U2cyNE33w6VinERfsudUV3K+H2VQIHfmayxDP6tk371iFBFPODB
         21ChH2nQM3TqMuFdKHgponFeeppDmhBjYU6CKFWh8OrHzAE35TxFrdfoPBcyBpQ5hdzP
         +S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377994; x=1690969994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iGJp3Y6rXle8uuZs1n28iqn7SIORXWqojx1agj3edY=;
        b=btOg23pe5qM2Hl7ZuW+hY7S1AY/brSz7zmtnMjl+ibN02Ahj6lPOEGrYtECKQILDTS
         eNzFuwX75rQDdz8e31qpPT0PSs4UHapVE13okheu8dYKjQaI1X2NEelOBtGvhUHRY2wU
         VGfaPOKvPtS6IpCjd51fmIk+A2ypBDTPf/TvbPCH0Ve84DNKFXQt3JZMC18+CP2r2ZD+
         WNKrS5C1gh9F8MslW65fpaExJ1FOtsJX5wH0zqU9+bhV2QYr/ze90pxv/7sRtMoy+sPG
         xhiQmcS8GqbGkurQMegPTjTiEsgmVioZBxt/QZP7HEO+6+dpm4PsVH+LOKadgqWjXEL6
         M4OA==
X-Gm-Message-State: AC+VfDy/LRbS3HY2/DxmhTuhH+yYBdJSoy2Reu+9ffaxxd9IMOU4YV+A
        he2mDoYlr4U0HCofexovuYpsdEu8nKrXTfIIRlxaxg==
X-Google-Smtp-Source: ACHHUZ7bIeou5Mbf5sQ4AuXdSmgs0EUefiJOjBpKJhnQ5LCHfzQaSsQLVcAmXDOIi1h+QBWptSoHuOL31iaBYoluKuQ=
X-Received: by 2002:a17:907:720c:b0:988:565f:bf46 with SMTP id
 dr12-20020a170907720c00b00988565fbf46mr10110365ejc.32.1688377994535; Mon, 03
 Jul 2023 02:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com> <20230628185006.76632-1-kuniyu@amazon.com>
In-Reply-To: <20230628185006.76632-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 3 Jul 2023 10:53:03 +0100
Message-ID: <CAN+4W8iktigV4j3t11HiVoo1BLW4r0UsDv+adaE_OZp_bemkOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@cilium.io, joe@wand.net.nz, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 7:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +     } else {
> > +             return sk;
> > +     }
> > +
> > +     reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> > +                                       saddr, sport, daddr, ntohs(dpor=
t),
> > +                                       ehashfn);
> > +     if (!reuse_sk || reuse_sk =3D=3D sk)
>
> nit: compiler might have optimised though, given here is the fast path,
> we can save reuse_sk =3D=3D sk check.

Ack.
