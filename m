Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AF7BCF9D
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjJHSjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 14:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHSjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 14:39:46 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71154AC;
        Sun,  8 Oct 2023 11:39:45 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso1380323e0c.3;
        Sun, 08 Oct 2023 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696790384; x=1697395184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr653O7IJNfsfgKHhAi3CZ9n/CYymbSf0E9j3Afy54M=;
        b=QMkthJNkQJqSz9ok8mre+vq74zCMjcyPODrgL3t2TaqXL7XQ568rkXZVo1QYRopMk9
         bnAt+iehHcLg72capiHvfKWGSVetqNJyUsUW301Nxf4p+JfkyZmXVGobrCapxcFZKKkM
         sFN527VUnWKyDrxEpRUgkdLFdbhhbX6VsuNao6thuv083EBvPCWb86+Lq7fzff0y/i+S
         hNUPpakJJiX+ZY+4qkWFnQRDKQoFWbuyNbdv5csT1WgcO9Zztbjg/vcMh7DluUVFp3vY
         JVKSJbRflBFluw/acPUdrqFOD8uSvO0hhjtEQtYy2AOIG6NBFQBUy95zxhjPDuE93z/4
         Qhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696790384; x=1697395184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr653O7IJNfsfgKHhAi3CZ9n/CYymbSf0E9j3Afy54M=;
        b=irmrFeToPsaKjP9Fpn8eV2IPZui3Z6m8ESn8YGUqAVSTnKhewApC2SNa0a2mpvZPAI
         IZyZ0M8EVACcEKzJ8QmLM+XuvMM1OIU5fN2gB21GAsiNg9JnhZef/R53bBQIPKGMAt8R
         1W7EpZm8EuLZwbCDaUflmk8pUGoVIueeCzxTvL0f1A3TGzjXKBZgHti27dZM1QWyN5yc
         Uc9ipPUhaygXg9keflarX/jScIDowi6hk3kJDxOrW1KLOXNmC4QPYOUZ1ekLsX1pwwLE
         IKFFwbVp6Y4lP9GrQTlLyYCskeGxQ3E/Xi3iMhQj/bStbwt+xKa1Nb1P9U0igqLNTZQb
         mn3g==
X-Gm-Message-State: AOJu0YyNuyGIQo6dEFgo9Qcgruza5g+4L+EJyme+9sfaRo9TKf/CGZZW
        SQzNLZFk4x6A5EH5eTn0ToIyUNWbPtwQeG35ukg=
X-Google-Smtp-Source: AGHT+IE/jeE8xp/dnu7wWNl+8oGAAPikxJaZzEQXCj6pPJv5za+sk1HRBAcSLpYAaMWWEgSrYl8NAuH0m57scqWgSgE=
X-Received: by 2002:a1f:ec83:0:b0:49a:a3ee:d280 with SMTP id
 k125-20020a1fec83000000b0049aa3eed280mr10123409vkh.16.1696790384365; Sun, 08
 Oct 2023 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com> <20231008052101.144422-2-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-2-akihiko.odaki@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Oct 2023 20:39:07 +0200
Message-ID: <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] net: skbuff: Add tun_vnet_hash flag
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
        gustavoars@kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, nogikh@google.com,
        pablo@netfilter.org, decui@microsoft.com, cai@lca.pw,
        jakub@cloudflare.com, elver@google.com, pabeni@redhat.com,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> tun_vnet_hash can use this flag to indicate it stored virtio-net hash
> cache to cb.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/skbuff.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4174c4b82d13..e638f157c13c 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -837,6 +837,7 @@ typedef unsigned char *sk_buff_data_t;
>   *     @truesize: Buffer size
>   *     @users: User count - see {datagram,tcp}.c
>   *     @extensions: allocated extensions, valid if active_extensions is =
nonzero
> + *     @tun_vnet_hash: tun stored virtio-net hash cache to cb
>   */
>
>  struct sk_buff {
> @@ -989,6 +990,7 @@ struct sk_buff {
>  #if IS_ENABLED(CONFIG_IP_SCTP)
>         __u8                    csum_not_inet:1;
>  #endif
> +       __u8                    tun_vnet_hash:1;

sk_buff space is very limited.

No need to extend it, especially for code that stays within a single
subsystem (tun).

To a lesser extent the same point applies to the qdisc_skb_cb.
