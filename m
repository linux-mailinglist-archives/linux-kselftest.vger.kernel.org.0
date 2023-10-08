Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864FF7BCFBE
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjJHTHs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHTHr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 15:07:47 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D2AC;
        Sun,  8 Oct 2023 12:07:45 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b396733895so416431241.2;
        Sun, 08 Oct 2023 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696792063; x=1697396863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUIUiIpPTlwOBRO7US0BTmiwF5PXFfWcZRBZPb+tCDY=;
        b=GW5WZ5Kyn9EPEyabHpJu3TagErVWHaRX0sGereZUU5fko+5aG4mx/D/huUBynkMLJE
         /Kl+28SJnyfFjJ1hfjj3/IFmQLU7HwduDbqdwVtE1PzhiyyWIsHgS7YgKJjwafgMCl7O
         Jpifqe5yt9bws+Anud3cyRZ2rhTWOIzoCA8AUbvCr9kt1Z0no/y4yocNY3zhhzIxzWVI
         Yocxvlrpj+i6VQtPcs+96YvQFwKCofcpMTSpg1noNJ6tfEQGJddJX3+o87mkuvkUlIlS
         sdhGCDOHQeFrsFjIMFTB14FVIr94RcljauE+CIgOY8wEkCAlBnTywjhEZKUXrk2yxtoO
         Cucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696792063; x=1697396863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUIUiIpPTlwOBRO7US0BTmiwF5PXFfWcZRBZPb+tCDY=;
        b=nLw3Dx1WqkEoBlCFQ1LU7EGOPJuFDZV7NqwE9F5gr0oKuxbgFprNeUkOZttvHoJ2UX
         kQ4VPgF6qyJ1D8aF9GE9emIgn6agByD6RWas9USIewoO0/V3cqEI1YKyuzWgF9iqEjr7
         lSD9r/xs7yx+9C87i1Dy2sndLD9gJu4nhpswzB3t9V5H6pQWeetOOTcj0DM+8rWvi3lM
         VVYQL0E1Vb2j4XUmL5ZIiimdx0VQNujp6cgL/qJettNOD+Wg6ODWD2aK4jr9Y3l1fXd8
         CPnpRSHvdveqs1GrriRWX8GUffkGrTaw2QnWd+sJKqi7tSqSEitDaneRXFbxgMPv0N/g
         2p0A==
X-Gm-Message-State: AOJu0Yz/HNGBB5Rl4vMcX//dvldIlUcWwejiwMlcc8dVWIcBrQyippQt
        mLU48Xfs1nFg/8C14KtV3BmaK7EKlqe5I4p+lCA=
X-Google-Smtp-Source: AGHT+IFyg6cgU92JMHIokRkaJhJ1e8P2rsbmzc2Pl3JccuZl4PPZUIzePqmqzU+Vbf5KveqqFMmHtwZMF46wJiX+l34=
X-Received: by 2002:a67:e40d:0:b0:452:8953:729e with SMTP id
 d13-20020a67e40d000000b004528953729emr13189757vsf.13.1696792063644; Sun, 08
 Oct 2023 12:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com> <20231008052101.144422-6-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-6-akihiko.odaki@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Oct 2023 21:07:06 +0200
Message-ID: <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
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
        pablo@netfilter.org, decui@microsoft.com, jakub@cloudflare.com,
        elver@google.com, pabeni@redhat.com,
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

On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
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
> ---

> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D {
> +       .max_indirection_table_length =3D
> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> +
> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> +};

No need to have explicit capabilities exchange like this? Tun either
supports all or none.

>         case TUNSETSTEERINGEBPF:
> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp);
> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp);
> +               if (IS_ERR(bpf_ret))
> +                       ret =3D PTR_ERR(bpf_ret);
> +               else if (bpf_ret)
> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_HASH_RSS;

Don't make one feature disable another.

TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
functions. If one is enabled the other call should fail, with EBUSY
for instance.

> +       case TUNSETVNETHASH:
> +               len =3D sizeof(vnet_hash);
> +               if (copy_from_user(&vnet_hash, argp, len)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_=
hash) ||
> +                     !tun_is_little_endian(tun))) ||
> +                    vnet_hash.indirection_table_mask >=3D
> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               argp =3D (u8 __user *)argp + len;
> +               len =3D (vnet_hash.indirection_table_mask + 1) * 2;
> +               if (copy_from_user(vnet_hash_indirection_table, argp, len=
)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               argp =3D (u8 __user *)argp + len;
> +               len =3D virtio_net_hash_key_length(vnet_hash.types);
> +
> +               if (copy_from_user(vnet_hash_key, argp, len)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }

Probably easier and less error-prone to define a fixed size control
struct with the max indirection table size.

Btw: please trim the CC: list considerably on future patches.
