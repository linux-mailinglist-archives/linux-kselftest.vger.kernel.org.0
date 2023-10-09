Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4007BD4D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjJIIFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjJIIFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:05:17 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE8BA;
        Mon,  9 Oct 2023 01:05:15 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b102a6565eso1371980241.0;
        Mon, 09 Oct 2023 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696838715; x=1697443515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ti/HWPE0cWzwTmuERRmavIjosKwcUVbmnHFfLYzgBc=;
        b=GQC7c5zbtVdpihkWjgWQEiKc1SXEzeGO89ZZeIwDCHr7hgKoTK/ziZnAyZ7Iaiw6ts
         txbGQQoyeJ+3GHaQMzN4VAO+21Yl0Z0AAvNI2+PadF3zkqVtTJt/+vY/tlsKLQRRSUOa
         z+3IMJE771O7jMdyzL1sqbtsEgPmTrzfwZrsvgl1NRHvYB4szqJlgD5onGBJHcBij1CW
         x/KFMwjONFIbcPz2ona1LLfSgqeBp5VxQqUARUFCmipJNmYFU32EDFNai0LvPXNUwfMv
         Pvs154Zg4YuIvkKmFlnXD/Al0XhwNu4UFVhUMY/1zSpwvIRSW3iMnQU6ezkgaOtkvq1N
         372Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838715; x=1697443515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ti/HWPE0cWzwTmuERRmavIjosKwcUVbmnHFfLYzgBc=;
        b=sZbMOD/kDT152a2CXGMa7wJfdGiP1MB0MPD0hMW8lJ3UdaJ/nMbO58abhTfEUEOzeU
         wP6GoPoUrx5ZUpmOyBGjR3p7muyaEZfZle56eVNBcVhRpr9YMqoq5Y1/ObDxTxuJAtzF
         faiN68MXl5pkIjr2mkoz+AceqEwnZ92qi+XlCrdq+WPYplcOqGMws5Bow2bpS15I+cJB
         E5mJpLF1mpXFAO78/xj/Cc0ED6FDuXfxrgrMx56G4DzLfZYLWjo72U6zx64V/wKv5TpK
         FFGo9HmAdmwrDeY2YlNY5WSG92mvN4kb9oTa5SWxJ6+WeiojVh0uMlDadUJr/SLNVW7U
         sbaw==
X-Gm-Message-State: AOJu0YyWm9jjLFeajsKXIBiixQ35tBWdSq0N2Pl2hDwofn1oxb7LCfS/
        XK7Evg8t6uUS3TBF9tUCDNHztstAH56IfV3BXUU=
X-Google-Smtp-Source: AGHT+IH9+0duN/DwJjTcz6PvfXQkVycNSPtz3xjugo2P/Xn5/hpapbonbt+oqUiI8Gfbij3OwxzuDU9Lm7C6lPyTWNg=
X-Received: by 2002:a67:bb06:0:b0:44e:9674:7781 with SMTP id
 m6-20020a67bb06000000b0044e96747781mr13044529vsn.15.1696838714812; Mon, 09
 Oct 2023 01:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com> <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
In-Reply-To: <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 03:04:37 -0500
Message-ID: <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2023/10/09 5:08, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF.
> >>>>
> >>>> Introduce the code to compute hashes to the kernel in order to overc=
ome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but it m=
akes
> >>>> little sense to allow to implement different hashing algorithms with
> >>>> eBPF since the hash value reported by virtio-net is strictly defined=
 by
> >>>> the specification.
> >>>>
> >>>> The hash value already stored in sk_buff is not used and computed
> >>>> independently since it may have been computed in a way not conforman=
t
> >>>> with the specification.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>
> >>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D {
> >>>> +       .max_indirection_table_length =3D
> >>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> >>>> +
> >>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>> +};
> >>>
> >>> No need to have explicit capabilities exchange like this? Tun either
> >>> supports all or none.
> >>
> >> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.
> >>
> >> It is because the flow dissector does not support IPv6 extensions. The
> >> specification is also vague, and does not tell how many TLVs should be
> >> consumed at most when interpreting destination option header so I chos=
e
> >> to avoid adding code for these hash types to the flow dissector. I dou=
bt
> >> anyone will complain about it since nobody complains for Linux.
> >>
> >> I'm also adding this so that we can extend it later.
> >> max_indirection_table_length may grow for systems with 128+ CPUs, or
> >> types may have other bits for new protocols in the future.
> >>
> >>>
> >>>>           case TUNSETSTEERINGEBPF:
> >>>> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp)=
;
> >>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering_prog, a=
rgp);
> >>>> +               if (IS_ERR(bpf_ret))
> >>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>> +               else if (bpf_ret)
> >>>> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_HASH_RSS=
;
> >>>
> >>> Don't make one feature disable another.
> >>>
> >>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> >>> functions. If one is enabled the other call should fail, with EBUSY
> >>> for instance.
> >>>
> >>>> +       case TUNSETVNETHASH:
> >>>> +               len =3D sizeof(vnet_hash);
> >>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
> >>>> +                       ret =3D -EFAULT;
> >>>> +                       break;
> >>>> +               }
> >>>> +
> >>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
> >>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hd=
r_v1_hash) ||
> >>>> +                     !tun_is_little_endian(tun))) ||
> >>>> +                    vnet_hash.indirection_table_mask >=3D
> >>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
> >>>> +                       ret =3D -EINVAL;
> >>>> +                       break;
> >>>> +               }
> >>>> +
> >>>> +               argp =3D (u8 __user *)argp + len;
> >>>> +               len =3D (vnet_hash.indirection_table_mask + 1) * 2;
> >>>> +               if (copy_from_user(vnet_hash_indirection_table, argp=
, len)) {
> >>>> +                       ret =3D -EFAULT;
> >>>> +                       break;
> >>>> +               }
> >>>> +
> >>>> +               argp =3D (u8 __user *)argp + len;
> >>>> +               len =3D virtio_net_hash_key_length(vnet_hash.types);
> >>>> +
> >>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
> >>>> +                       ret =3D -EFAULT;
> >>>> +                       break;
> >>>> +               }
> >>>
> >>> Probably easier and less error-prone to define a fixed size control
> >>> struct with the max indirection table size.
> >>
> >> I made its size variable because the indirection table and key may gro=
w
> >> in the future as I wrote above.
> >>
> >>>
> >>> Btw: please trim the CC: list considerably on future patches.
> >>
> >> I'll do so in the next version with the TUNSETSTEERINGEBPF change you
> >> proposed.
> >
> > To be clear: please don't just resubmit with that one change.
> >
> > The skb and cb issues are quite fundamental issues that need to be reso=
lved.
> >
> > I'd like to understand why adjusting the existing BPF feature for this
> > exact purpose cannot be amended to return the key it produced.
>
> eBPF steering program is not designed for this particular problem in my
> understanding. It was introduced to derive hash values with an
> understanding of application-specific semantics of packets instead of
> generic IP/TCP/UDP semantics.
>
> This problem is rather different in terms that the hash derivation is
> strictly defined by virtio-net. I don't think it makes sense to
> introduce the complexity of BPF when you always run the same code.
>
> It can utilize the existing flow dissector and also make it easier to
> use for the userspace by implementing this in the kernel.

Ok. There does appear to be overlap in functionality. But it might be
easier to deploy to just have standard Toeplitz available without
having to compile and load an eBPF program.

As for the sk_buff and cb[] changes. The first is really not needed.
sk_buff simply would not scale if every edge case needs a few bits.

For the control block, generally it is not safe to use that across
layers. In this case, between qdisc enqueue of a given device and
ndo_start_xmit of that device, I suppose it is. Though uncommon. I
wonder if there is any precedent.

The data will have to be stored in the skb somewhere. A simpler option
is just skb->hash? This code would use skb_get_hash, if it would
always produce a Toeplitz hash, anyway.

> >
> > As you point out, the C flow dissector is insufficient. The BPF flow
> > dissector does not have this problem. The same argument would go for
> > the pre-existing BPF steering program.
> It is possible to extend the C flow dissector just as it is possible to
> implement a BPF flow dissector. The more serious problem is that
> virtio-net specification (and Microsoft RSS it follows) does not tell
> how to implement IPv6 extension support.
