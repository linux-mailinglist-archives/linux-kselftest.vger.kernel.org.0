Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8F7E31EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 01:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKGAD7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 19:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjKGAD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 19:03:58 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231411A
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 16:03:54 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so1967477e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Nov 2023 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699315433; x=1699920233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k7O7fPsM7i2kvbi4Eehiz4lx1hbxjBD0ACtWEdTidQ=;
        b=OZBThTfYmWxjCXnpuw2f2eRdmCYyE/P+WRlpe1p4GtgPA5fNDqSqa1H7L1OTB1PPaQ
         7+Cy7JEETq/OMLB9KpyCUobSuBGZEx5aOa/tyaPJp3gOyNo0Y1kZhoEb/2sV1LITQfwB
         467bQmWbHLHfklXvl7Sso4iArASp3nRBHKryyLSYe/KU5et1kEy/KWEoTGUBS8gy5Nu6
         hYBDA+n/7J7tFHj9W3oBO6FSievmSXBYLa7w6I2r29MK2mbwOo6aaoIxgtoPpoH3dUH3
         2lAOJF9nuWzIb0kh9o0kKP+GZgbx+JZ1aJSk7iRFWvOowcpFzzJN9ghzRcYPvmz3Lu0Q
         dlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315433; x=1699920233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k7O7fPsM7i2kvbi4Eehiz4lx1hbxjBD0ACtWEdTidQ=;
        b=nPI3hE++QTG4iawbo9X/rjlyye8KTKpdiBcf+aEzvj7dYBRNQpryT8AWy186QyPF2h
         JaXiJjI1cAVWzyvdH7f43yslX9IxvjtHWZ0dkfZ+fEEWmupAqDGlVWlvwFzm0hLXTLlF
         vFq0umV/X0WNLg6sxpxJj6Q2l0LcH86WDut1wvNVQ7XrF5WvDUpbpQhAn2W2iISOGHYg
         ZGhML6FDJ2zwJehNQaoLdLwyxE2cvKOHunxUMPDGxdeCLGNMCN1n+R4rpudzdm9nxraS
         FX79hH2cTHwIYZKIYB+pO1zde1jjBBv9xrRguO+mgoth4TXKM2Jo2CuKGnf9GWI8SHQ+
         OzDw==
X-Gm-Message-State: AOJu0Yx72BdgZIfxDVY8yznjb2dkoxGYtw8x59MJ5QW17MEmQWg1986p
        g8VuqYl4xMvkDpiaTwU9Ub6Zfdy3F+x+kY52c6Ue5w==
X-Google-Smtp-Source: AGHT+IEtcpOYvpwzR5ghgo79gr1DGe6ofXaayePQzxg8gI82zeZvTQdm2jCfdPUEIBnZJalKkVVzL1oy5qF5cdYsa+A=
X-Received: by 2002:a1f:aa15:0:b0:4a8:4218:7b90 with SMTP id
 t21-20020a1faa15000000b004a842187b90mr19912346vke.9.1699315433224; Mon, 06
 Nov 2023 16:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <00883386-0c4b-4ba7-84c6-553f468304e6@kernel.org>
In-Reply-To: <00883386-0c4b-4ba7-84c6-553f468304e6@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 6 Nov 2023 16:03:39 -0800
Message-ID: <CAHS8izN3k+x4W19cRv=DyEuJewGKUxVwobQgSZOLEDh3wDcyVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To:     David Ahern <dsahern@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 6, 2023 at 3:37=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/6/23 3:18 PM, Mina Almasry wrote:
> >>>>>> @@ -991,7 +993,7 @@ struct sk_buff {
> >>>>>>  #if IS_ENABLED(CONFIG_IP_SCTP)
> >>>>>>      __u8                    csum_not_inet:1;
> >>>>>>  #endif
> >>>>>> -
> >>>>>> +    __u8                    devmem:1;
> >>>>>>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> >>>>>>      __u16                   tc_index;       /* traffic control in=
dex */
> >>>>>>  #endif
> >>>>>> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_mana=
ged(struct sk_buff *skb)
> >>>>>>              __skb_zcopy_downgrade_managed(skb);
> >>>>>>  }
> >>>>>>
> >>>>>> +/* Return true if frags in this skb are not readable by the host.=
 */
> >>>>>> +static inline bool skb_frags_not_readable(const struct sk_buff *s=
kb)
> >>>>>> +{
> >>>>>> +    return skb->devmem;
> >>>>>
> >>>>> bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_r=
eadable'?
> >>>>> It better communicates the fact that the stack shouldn't dereferenc=
e the
> >>>>> frags (because it has 'devmem' fragments or for some other potentia=
l
> >>>>> future reason).
> >>>>
> >>>> +1.
> >>>>
> >>>> Also, the flag on the skb is an optimization - a high level signal t=
hat
> >>>> one or more frags is in unreadable memory. There is no requirement t=
hat
> >>>> all of the frags are in the same memory type.
> >>
> >> David: maybe there should be such a requirement (that they all are
> >> unreadable)? Might be easier to support initially; we can relax later
> >> on.
> >>
> >
> > Currently devmem =3D=3D not_readable, and the restriction is that all t=
he
> > frags in the same skb must be either all readable or all unreadable
> > (all devmem or all non-devmem).
>
> What requires that restriction? In all of the uses of skb->devmem and
> skb_frags_not_readable() what matters is if any frag is not readable,
> then frag list walk or collapse is avoided.
>
>

Currently only tcp_recvmsg_devmem(), I think. tcp_recvmsg_locked()
delegates to tcp_recvmsg_devmem() if skb->devmem, and
tcp_recvmsg_devmem() net_err's if it finds a non-iov frag in the skb.
This is done for some simplicity, because iov's are given to the user
via cmsg, but pages are copied into the linear buffer. I think it
would be confusing for the user if we simultaneously copied some data
to the linear buffer and gave them a devmem cmsgs in the same
recvmsg() call.

So, my simplicity is:

1. in a single skb, all frags must be devmem or non-devmem, no mixing.
2. In a single recvmsg() call, we only process devmem or non-devmem
skbs, no mixing.

--=20
Thanks,
Mina
