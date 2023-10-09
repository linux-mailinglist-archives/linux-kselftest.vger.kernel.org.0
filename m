Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD67BD7C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjJIJ6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 05:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjJIJ6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 05:58:14 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0D097;
        Mon,  9 Oct 2023 02:58:12 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b07719089aso2849965241.0;
        Mon, 09 Oct 2023 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696845491; x=1697450291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UQu7ZxKt3SgEsSumjeMXtr6/TTeWg3eL1+yCIl9X3g=;
        b=kCPhpMP546DuOO8YY52E/DDZbgebipc9KWWKoY16n7RdAYPaCIlaSAO0+vsoXPbAOr
         /NTeB+CjfjM6BBkJFqIl9XhTRQJBhh6YBTRlD+MSvfopxXM4KuUM4n6INsn2gXSvsOjD
         dbBjC1ZLwgcRXNAJ1Z344C5A/RG/FfuhslH42XSVXq8SwwYlUZyV/B3yGKfl0ybolzR+
         N6zG3N0eVA1M2Do4ZiSD6FwKLsccTqsrGPNB+g/YeccHs94OClJnLU1+kw7urE2++Y+L
         ytoueeMFELX7rUANin59GDbwyp7U6NI5p1sN3uBy4dFCXN/ELCHq2q18phvJO4Mpj6lV
         hdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845491; x=1697450291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UQu7ZxKt3SgEsSumjeMXtr6/TTeWg3eL1+yCIl9X3g=;
        b=FqKhdcsS9sdbTpGEoCy/2ncXIWxqKLjS7fqY6ydSDf2GcelVUY93Omh7SJiiEufURy
         Un1wcU39Nxo5Io632PlK6Sw0a5uEOPBXULULg16Am8zrQVUiTbXu7AeXcInE5BzyRxtG
         LO51lkSNJbUmM9K1tTaX/OBUWGuSiscu4EQo6i0RPEcLVclb0tfrC305AT+So3L3C9aO
         CftaBZc4s3cpXoBtieIg/jrVKfpVVt0v5ZXnkneORPcfm5DjEJ6Ninmx+LC6zzGjkBUY
         BJUCUkM8TU0Nx6/dU5q+8kVxGXs7kxTmgw1xkGGHrjqRlximnpc4hQpNaecYLMBdPrYU
         4aKg==
X-Gm-Message-State: AOJu0Yz7G/4xmzf/eZi5nxHS2YsAQGLXz/naQ/1hAEV0TdvegNq8rOdC
        ScW26W6fgfyEWjtbJE+FZCeZkenaruXrryJ+u0w=
X-Google-Smtp-Source: AGHT+IGDgdO9gO0/H9fjMssaFno+x01yJKkkf0DGlYvrctvF9jKh/A7zhIK+wq90Ni+Jk375I6OAzOI8eAurWQgYimE=
X-Received: by 2002:a05:6122:2026:b0:496:2d54:e6f0 with SMTP id
 l38-20020a056122202600b004962d54e6f0mr7503884vkd.6.1696845491642; Mon, 09 Oct
 2023 02:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com> <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com> <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
In-Reply-To: <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 02:57:35 -0700
Message-ID: <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 3:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2023/10/09 17:04, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2023/10/09 5:08, Willem de Bruijn wrote:
> >>> On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>>>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> virtio-net have two usage of hashes: one is RSS and another is has=
h
> >>>>>> reporting. Conventionally the hash calculation was done by the VMM=
.
> >>>>>> However, computing the hash after the queue was chosen defeats the
> >>>>>> purpose of RSS.
> >>>>>>
> >>>>>> Another approach is to use eBPF steering program. This approach ha=
s
> >>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>> restrictive nature of eBPF.
> >>>>>>
> >>>>>> Introduce the code to compute hashes to the kernel in order to ove=
rcome
> >>>>>> thse challenges. An alternative solution is to extend the eBPF ste=
ering
> >>>>>> program so that it will be able to report to the userspace, but it=
 makes
> >>>>>> little sense to allow to implement different hashing algorithms wi=
th
> >>>>>> eBPF since the hash value reported by virtio-net is strictly defin=
ed by
> >>>>>> the specification.
> >>>>>>
> >>>>>> The hash value already stored in sk_buff is not used and computed
> >>>>>> independently since it may have been computed in a way not conform=
ant
> >>>>>> with the specification.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> ---
> >>>>>
> >>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D {
> >>>>>> +       .max_indirection_table_length =3D
> >>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> >>>>>> +
> >>>>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>>>> +};
> >>>>>
> >>>>> No need to have explicit capabilities exchange like this? Tun eithe=
r
> >>>>> supports all or none.
> >>>>
> >>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=
.
> >>>>
> >>>> It is because the flow dissector does not support IPv6 extensions. T=
he
> >>>> specification is also vague, and does not tell how many TLVs should =
be
> >>>> consumed at most when interpreting destination option header so I ch=
ose
> >>>> to avoid adding code for these hash types to the flow dissector. I d=
oubt
> >>>> anyone will complain about it since nobody complains for Linux.
> >>>>
> >>>> I'm also adding this so that we can extend it later.
> >>>> max_indirection_table_length may grow for systems with 128+ CPUs, or
> >>>> types may have other bits for new protocols in the future.
> >>>>
> >>>>>
> >>>>>>            case TUNSETSTEERINGEBPF:
> >>>>>> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, arg=
p);
> >>>>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering_prog,=
 argp);
> >>>>>> +               if (IS_ERR(bpf_ret))
> >>>>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>>>> +               else if (bpf_ret)
> >>>>>> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_HASH_R=
SS;
> >>>>>
> >>>>> Don't make one feature disable another.
> >>>>>
> >>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> >>>>> functions. If one is enabled the other call should fail, with EBUSY
> >>>>> for instance.
> >>>>>
> >>>>>> +       case TUNSETVNETHASH:
> >>>>>> +               len =3D sizeof(vnet_hash);
> >>>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
> >>>>>> +                       ret =3D -EFAULT;
> >>>>>> +                       break;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
> >>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_=
hdr_v1_hash) ||
> >>>>>> +                     !tun_is_little_endian(tun))) ||
> >>>>>> +                    vnet_hash.indirection_table_mask >=3D
> >>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
> >>>>>> +                       ret =3D -EINVAL;
> >>>>>> +                       break;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>> +               len =3D (vnet_hash.indirection_table_mask + 1) * 2=
;
> >>>>>> +               if (copy_from_user(vnet_hash_indirection_table, ar=
gp, len)) {
> >>>>>> +                       ret =3D -EFAULT;
> >>>>>> +                       break;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>> +               len =3D virtio_net_hash_key_length(vnet_hash.types=
);
> >>>>>> +
> >>>>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
> >>>>>> +                       ret =3D -EFAULT;
> >>>>>> +                       break;
> >>>>>> +               }
> >>>>>
> >>>>> Probably easier and less error-prone to define a fixed size control
> >>>>> struct with the max indirection table size.
> >>>>
> >>>> I made its size variable because the indirection table and key may g=
row
> >>>> in the future as I wrote above.
> >>>>
> >>>>>
> >>>>> Btw: please trim the CC: list considerably on future patches.
> >>>>
> >>>> I'll do so in the next version with the TUNSETSTEERINGEBPF change yo=
u
> >>>> proposed.
> >>>
> >>> To be clear: please don't just resubmit with that one change.
> >>>
> >>> The skb and cb issues are quite fundamental issues that need to be re=
solved.
> >>>
> >>> I'd like to understand why adjusting the existing BPF feature for thi=
s
> >>> exact purpose cannot be amended to return the key it produced.
> >>
> >> eBPF steering program is not designed for this particular problem in m=
y
> >> understanding. It was introduced to derive hash values with an
> >> understanding of application-specific semantics of packets instead of
> >> generic IP/TCP/UDP semantics.
> >>
> >> This problem is rather different in terms that the hash derivation is
> >> strictly defined by virtio-net. I don't think it makes sense to
> >> introduce the complexity of BPF when you always run the same code.
> >>
> >> It can utilize the existing flow dissector and also make it easier to
> >> use for the userspace by implementing this in the kernel.
> >
> > Ok. There does appear to be overlap in functionality. But it might be
> > easier to deploy to just have standard Toeplitz available without
> > having to compile and load an eBPF program.
> >
> > As for the sk_buff and cb[] changes. The first is really not needed.
> > sk_buff simply would not scale if every edge case needs a few bits.
>
> An alternative is to move the bit to cb[] and clear it for every code
> paths that lead to ndo_start_xmit(), but I'm worried that it is error-pro=
ne.
>
> I think we can put the bit in sk_buff for now. We can implement the
> alternative when we are short of bits.

I disagree. sk_buff fields add a cost to every code path. They cannot
be added for every edge case.
>
> >
> > For the control block, generally it is not safe to use that across
> > layers. In this case, between qdisc enqueue of a given device and
> > ndo_start_xmit of that device, I suppose it is. Though uncommon. I
> > wonder if there is any precedent.
>
> That's one of the reasons modifying qdisc_skb_cb instead of creating
> another struct embedding it as bpf_skb_data_end and tc_skb_cb do. This
> clarifies that it is qdisc's responsibility to keep these data intact.
>
> >
> > The data will have to be stored in the skb somewhere. A simpler option
> > is just skb->hash? This code would use skb_get_hash, if it would
> > always produce a Toeplitz hash, anyway.
>
> We still need tun_vnet_hash_report to identify hash type.
>
> skb_get_hash() uses Siphash instead of Toeplitz, and the configuration
> of Toeplitz relies on tun's internal state. It is still possible to
> store a hash calculated with tun's own logic to skb->hash, but someone
> may later overwrite it with __skb_get_hash() though it's unlikely.

That won't happen in this data path.

Fair point on the hash type.
