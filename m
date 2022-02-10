Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892774B0292
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 02:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiBJB4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 20:56:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiBJB4D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C062BB02
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 17:48:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d15-20020a17090a564f00b001b937f4ae2fso1702458pji.4
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 17:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6mmBz6t35yik3VhkFP6A7kQ3O5P30JK27hLe7Q0ulY=;
        b=ZccprKSK//ZALRudlRMNgZptyRngyNB9lJ/sm2zd4oP9RBebLTVMW9vHvyX1eW3BC5
         mM/qJCf1fl+7+9w46dPuJEaWVmE3saS54TjVbn79uFU4zWRFsHgJhXdLjU3XmyeeDu4b
         3ygVwvCUSBQySyY7WDYSATaazDuCkKfMy+GM6mKW954RlioSqY6vcGaBMOD96wI5kikb
         SwiExWokQgdlsTC9TE5ANM0oVTgl1hqnOZ7TE8iF9gFs6Ao9TohKkASi4G2TLkfGOsjW
         ABLtYC6Yg02rd/APMgVxMf9zyePNjJkriPOc2f5V7iToAsf1ImNV/F4m8rpQPWKGxame
         bdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6mmBz6t35yik3VhkFP6A7kQ3O5P30JK27hLe7Q0ulY=;
        b=nrxGruhcjnGde0UcsD8vhDjHaMWpmfYocYSQjh84nVKOw9icxKpGApfktxPQwoYUuR
         vrDnH2UV0IDVSKLhxzaSEWu29YiHKOeU1ZlOVHo1qlz0qxgeesy0IsxZGKAaUJsiry9g
         g1FPhM3bkjM6q5bOQDMaIthSoZB11NBj2s23El3dWK2TtoNMiaJBJ8RpPC0sboqvLkhB
         ckKJz3Wc58SGdS5butWXUi42MBPb6CsAjjZPVGwLoJgeocWEYbsKjC4cDk0aVaeTBNNZ
         eUgGYtX9foDYP3WxrUP/iQiyooXjqQPDHDw5y68Kn0csYR8/33/a9QSdouF7WFrdwHF4
         LIKg==
X-Gm-Message-State: AOAM533yr6cwSM8tv5qZTSx/O8MrB4s52FPTtUOmDSO+YJ3JwjpzoDiN
        II7GsPieseIDOG5amKJ9UGnLOOBX7GeY8jyBCgg7ZW3uQZc=
X-Google-Smtp-Source: ABdhPJyOTmPbdqCyIBqYP1ntx6P9eXy1egrm7sfhmc+Kj5LYoGa53VQDBGCTYPrbiC/MJFttNJATWAnQFUw0PV3Fw9w=
X-Received: by 2002:a05:6122:c83:: with SMTP id ba3mr1748326vkb.27.1644453870493;
 Wed, 09 Feb 2022 16:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20220210003649.3120861-1-kuba@kernel.org> <20220210003649.3120861-3-kuba@kernel.org>
In-Reply-To: <20220210003649.3120861-3-kuba@kernel.org>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Wed, 9 Feb 2022 16:44:18 -0800
Message-ID: <CANP3RGfqsFNOvtGk6e_3sia0esEknNr2gT-PmcbhRV+S2MEaUA@mail.gmail.com>
Subject: Re: [PATCH net-next 02/11] net: ping6: support packet timestamping
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux NetDev <netdev@vger.kernel.org>,
        Willem Bruijn <willemb@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        David Ahern <dsahern@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 9, 2022 at 4:36 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Nothing prevents the user from requesting timestamping
> on ping6 sockets, yet timestamps are not going to be reported.
> Plumb the flags through.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ipv6/ping.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index 86a72f7a61cf..3228ccd8abf1 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -113,6 +113,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>
>         ipcm6_init_sk(&ipc6, np);
>         ipc6.sockc.mark = sk->sk_mark;
> +       ipc6.sockc.tsflags = sk->sk_tsflags;
>         fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
>
>         dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
> --
> 2.34.1
>

probably deserves a fixes tag?
otherwise looks fine to me
