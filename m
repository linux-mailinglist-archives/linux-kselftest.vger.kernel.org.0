Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF14D7BD4F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjJIIN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJIIN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:13:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33C94;
        Mon,  9 Oct 2023 01:13:53 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4527d65354bso1803136137.0;
        Mon, 09 Oct 2023 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839232; x=1697444032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g97708SLPpUQGaeNPBhyGUaVogHGb5gBagyPdjwmXiM=;
        b=CPBbaLWwNkHDb8dQP4ygjl4E59xeMq0QU27H1CtXMYwmNFHX2qdkzZG1dTjHU8vNqY
         vXCjNzBRi5Nq9cfz3M9c9gd2kZIqIufYQBPC6oM9azBCJ8HVkB+5zcrKOIO2FBwrahAA
         ivr6mG5XrQZeiN8awN7iUkRG0mUOZdkqqVNNYr+Z7bDa2jzWK94jiY2tm5FlFWvP4910
         my2FLZUuqlzHoZmidaJFNsuYFB3NfMtTGD8VonOuCP231RSN0sLItxNGtSFwQ0kK42W4
         Xo5vd2ptmgJhDBIoYN8plWGUTOQ8bPzT8Wc93K/HSLVY5TbxbD9OrDdQtY9l7F3aXK+i
         995w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839233; x=1697444033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g97708SLPpUQGaeNPBhyGUaVogHGb5gBagyPdjwmXiM=;
        b=kqlti5EC4f//7Lpu7oLsEWtDMaGHkRZIj7Mrm+cUl5pPqdziE+O5DgJf5/m4gUJRDT
         yYvc0wYh9Q5tA1Nm+wKWdVysqzOtb3auvwhcpYiB/LSAMrBFchs/pAXg/9WHDwdXjLi1
         9fmR9t3ajVwEL0hnhYnbqMc4Q65p5C/uDJyGC21BITu3Dk9x4eqU2XrZOo5SKGxsyGWU
         P7tK9sLNTiZS4nEbC0x44EphAr0yoaNIhfWoWYHdSpeVhsXBUyER37Hqgj6QBbbzLzAl
         2FoW0+Y2TSyCI3Ykl0PavuPqZUQgbxdhOj6fbzJ8gdaaoaPFn2u/wa9BrjHal0fxgHd6
         RqUA==
X-Gm-Message-State: AOJu0Yz7AceqltKfbvzM5z+Vbk6OkV6eW+xx4gqKUVlKCgJ20gWh13r1
        Ra/nutxPkUl2NCp8YRu2zCNxhkeQjz3NVhAySDk=
X-Google-Smtp-Source: AGHT+IFADylaHVxGSdb1Oqn5UxNB9rtGxlVAuFq0a1ZtipvFhWLBvdaHsXsXzXMCgag4xO0u48yu7pmMnXOLi+XLyn8=
X-Received: by 2002:a67:f7c1:0:b0:44e:d6c3:51d4 with SMTP id
 a1-20020a67f7c1000000b0044ed6c351d4mr12138747vsp.18.1696839232644; Mon, 09
 Oct 2023 01:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com> <20231008052101.144422-6-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-6-akihiko.odaki@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 03:13:15 -0500
Message-ID: <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 8, 2023 at 12:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but it makes
> little sense to allow to implement different hashing algorithms with
> eBPF since the hash value reported by virtio-net is strictly defined by
> the specification.
>
> The hash value already stored in sk_buff is not used and computed
> independently since it may have been computed in a way not conformant
> with the specification.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>         }
>
>         if (vnet_hdr_sz) {
> -               struct virtio_net_hdr gso;
> +               union {
> +                       struct virtio_net_hdr hdr;
> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> +               } hdr;
> +               int ret;
>
>                 if (iov_iter_count(iter) < vnet_hdr_sz)
>                         return -EINVAL;
>
> -               if (virtio_net_hdr_from_skb(skb, &gso,
> -                                           tun_is_little_endian(tun), tr=
ue,
> -                                           vlan_hlen)) {
> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPO=
RT) &&
> +                   vnet_hdr_sz >=3D sizeof(hdr.v1_hash_hdr) &&
> +                   skb->tun_vnet_hash) {

Isn't vnet_hdr_sz guaranteed to be >=3D hdr.v1_hash_hdr, by virtue of
the set hash ioctl failing otherwise?

Such checks should be limited to control path where possible

> +                       vnet_hdr_content_sz =3D sizeof(hdr.v1_hash_hdr);
> +                       ret =3D virtio_net_hdr_v1_hash_from_skb(skb,
> +                                                             &hdr.v1_has=
h_hdr,
> +                                                             true,
> +                                                             vlan_hlen,
> +                                                             &vnet_hash)=
;
> +               } else {
> +                       vnet_hdr_content_sz =3D sizeof(hdr.hdr);
> +                       ret =3D virtio_net_hdr_from_skb(skb, &hdr.hdr,
> +                                                     tun_is_little_endia=
n(tun),
> +                                                     true, vlan_hlen);
> +               }
> +
