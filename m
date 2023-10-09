Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD07BD802
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjJIKHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346110AbjJIKGy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:06:54 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8CC97;
        Mon,  9 Oct 2023 03:06:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4526b9404b0so3687960137.0;
        Mon, 09 Oct 2023 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696846010; x=1697450810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUulTN1h38HfKtLoczTxDqQh9DCfOrCmaxardUNW3tA=;
        b=H8+1A5NUj1Ns4BMSQGYNeq07qjAqcHTNxBt2ckfSYv131nmJwQU0lX71MSvTdB2eJF
         MQDV5gC5JGyHzIOKin3dulQko8S6JI9q/LGtEd4m6lcYJUY02aWh5xQx9MJXbNMkPztp
         wYQZW8exDLzUj75XJJQSdZtxuXEPAS0LCP9w3arENQ84PScxD3pshlvPhZcijt5XW2P/
         iefTErOow0/loEF2fB84xzrkC4jzG+KXxFvwhP/zWJNNCX2zFkh8GhtBix1+PVpK38NG
         GXqsOMNMdFMI+iz1uW6picVTsSovnlVvAhR46XGJghIrRJHkfosOMdmqa3mq87nRVDSo
         4sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846010; x=1697450810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUulTN1h38HfKtLoczTxDqQh9DCfOrCmaxardUNW3tA=;
        b=Wz0WzgPoo3WTK9BuHbFqrpk2uuDE5Y0hcoddFmFMYM0QvIUBUNE0azjeI4o53AKuZE
         s6NpVOhd7zEYaZ9pQRUEqKXBQkOj6ZZHzZLsdtBgxliOj823sH+tUPSwS1KnXGg/bAup
         /KES58ypSzzVO/98Qsl5/O+PFK+xNPO0/f3UvAcIY2zIGmulOR03fgs8RZ/H8kfzVoK4
         b9WqaSefTrICfIIzuaybj62mN2Kj6jwUWPNVZy9slG2gS8qlwMN0W+9PJru67Jz/4P75
         Lhjz5h4hUHFk/i7HaNdZnak8V5ir52vq8o+kwbBVqG3LtnkG+mHEaKX9/irOzKALn4o+
         bLJw==
X-Gm-Message-State: AOJu0YxxnL+gAzbG6vEQbhSDRKwljPLoMNphnydw66bz7n7ZLWI6LWQQ
        fIaxLWpOBk1JGCTfW2fV0N1AnbltBmJUkSld6ks=
X-Google-Smtp-Source: AGHT+IGeiHftpvohpaihVWI8j4pdDM3FdFbyTLW7xo376tPGFfTL1jLnkf6qSqJR0XyB8zSyHHRzZVF0eAddRpMqimY=
X-Received: by 2002:a67:ee49:0:b0:452:d5cb:a211 with SMTP id
 g9-20020a67ee49000000b00452d5cba211mr6160893vsp.15.1696846010494; Mon, 09 Oct
 2023 03:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com> <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com> <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com> <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
In-Reply-To: <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 03:06:13 -0700
Message-ID: <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 3:02=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2023/10/09 18:57, Willem de Bruijn wrote:
> > On Mon, Oct 9, 2023 at 3:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2023/10/09 17:04, Willem de Bruijn wrote:
> >>> On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
> >>>>> On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>>>>>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> virtio-net have two usage of hashes: one is RSS and another is h=
ash
> >>>>>>>> reporting. Conventionally the hash calculation was done by the V=
MM.
> >>>>>>>> However, computing the hash after the queue was chosen defeats t=
he
> >>>>>>>> purpose of RSS.
> >>>>>>>>
> >>>>>>>> Another approach is to use eBPF steering program. This approach =
has
> >>>>>>>> another downside: it cannot report the calculated hash due to th=
e
> >>>>>>>> restrictive nature of eBPF.
> >>>>>>>>
> >>>>>>>> Introduce the code to compute hashes to the kernel in order to o=
vercome
> >>>>>>>> thse challenges. An alternative solution is to extend the eBPF s=
teering
> >>>>>>>> program so that it will be able to report to the userspace, but =
it makes
> >>>>>>>> little sense to allow to implement different hashing algorithms =
with
> >>>>>>>> eBPF since the hash value reported by virtio-net is strictly def=
ined by
> >>>>>>>> the specification.
> >>>>>>>>
> >>>>>>>> The hash value already stored in sk_buff is not used and compute=
d
> >>>>>>>> independently since it may have been computed in a way not confo=
rmant
> >>>>>>>> with the specification.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>> ---
> >>>>>>>
> >>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D {
> >>>>>>>> +       .max_indirection_table_length =3D
> >>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> >>>>>>>> +
> >>>>>>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>>>>>> +};
> >>>>>>>
> >>>>>>> No need to have explicit capabilities exchange like this? Tun eit=
her
> >>>>>>> supports all or none.
> >>>>>>
> >>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_=
EX.
> >>>>>>
> >>>>>> It is because the flow dissector does not support IPv6 extensions.=
 The
> >>>>>> specification is also vague, and does not tell how many TLVs shoul=
d be
> >>>>>> consumed at most when interpreting destination option header so I =
chose
> >>>>>> to avoid adding code for these hash types to the flow dissector. I=
 doubt
> >>>>>> anyone will complain about it since nobody complains for Linux.
> >>>>>>
> >>>>>> I'm also adding this so that we can extend it later.
> >>>>>> max_indirection_table_length may grow for systems with 128+ CPUs, =
or
> >>>>>> types may have other bits for new protocols in the future.
> >>>>>>
> >>>>>>>
> >>>>>>>>             case TUNSETSTEERINGEBPF:
> >>>>>>>> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, a=
rgp);
> >>>>>>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering_pro=
g, argp);
> >>>>>>>> +               if (IS_ERR(bpf_ret))
> >>>>>>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>>>>>> +               else if (bpf_ret)
> >>>>>>>> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_HASH=
_RSS;
> >>>>>>>
> >>>>>>> Don't make one feature disable another.
> >>>>>>>
> >>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> >>>>>>> functions. If one is enabled the other call should fail, with EBU=
SY
> >>>>>>> for instance.
> >>>>>>>
> >>>>>>>> +       case TUNSETVNETHASH:
> >>>>>>>> +               len =3D sizeof(vnet_hash);
> >>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
> >>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
> >>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_ne=
t_hdr_v1_hash) ||
> >>>>>>>> +                     !tun_is_little_endian(tun))) ||
> >>>>>>>> +                    vnet_hash.indirection_table_mask >=3D
> >>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH)=
 {
> >>>>>>>> +                       ret =3D -EINVAL;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>> +               len =3D (vnet_hash.indirection_table_mask + 1) *=
 2;
> >>>>>>>> +               if (copy_from_user(vnet_hash_indirection_table, =
argp, len)) {
> >>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>> +               len =3D virtio_net_hash_key_length(vnet_hash.typ=
es);
> >>>>>>>> +
> >>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
> >>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>
> >>>>>>> Probably easier and less error-prone to define a fixed size contr=
ol
> >>>>>>> struct with the max indirection table size.
> >>>>>>
> >>>>>> I made its size variable because the indirection table and key may=
 grow
> >>>>>> in the future as I wrote above.
> >>>>>>
> >>>>>>>
> >>>>>>> Btw: please trim the CC: list considerably on future patches.
> >>>>>>
> >>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF change =
you
> >>>>>> proposed.
> >>>>>
> >>>>> To be clear: please don't just resubmit with that one change.
> >>>>>
> >>>>> The skb and cb issues are quite fundamental issues that need to be =
resolved.
> >>>>>
> >>>>> I'd like to understand why adjusting the existing BPF feature for t=
his
> >>>>> exact purpose cannot be amended to return the key it produced.
> >>>>
> >>>> eBPF steering program is not designed for this particular problem in=
 my
> >>>> understanding. It was introduced to derive hash values with an
> >>>> understanding of application-specific semantics of packets instead o=
f
> >>>> generic IP/TCP/UDP semantics.
> >>>>
> >>>> This problem is rather different in terms that the hash derivation i=
s
> >>>> strictly defined by virtio-net. I don't think it makes sense to
> >>>> introduce the complexity of BPF when you always run the same code.
> >>>>
> >>>> It can utilize the existing flow dissector and also make it easier t=
o
> >>>> use for the userspace by implementing this in the kernel.
> >>>
> >>> Ok. There does appear to be overlap in functionality. But it might be
> >>> easier to deploy to just have standard Toeplitz available without
> >>> having to compile and load an eBPF program.
> >>>
> >>> As for the sk_buff and cb[] changes. The first is really not needed.
> >>> sk_buff simply would not scale if every edge case needs a few bits.
> >>
> >> An alternative is to move the bit to cb[] and clear it for every code
> >> paths that lead to ndo_start_xmit(), but I'm worried that it is error-=
prone.
> >>
> >> I think we can put the bit in sk_buff for now. We can implement the
> >> alternative when we are short of bits.
> >
> > I disagree. sk_buff fields add a cost to every code path. They cannot
> > be added for every edge case.
>
> It only takes an unused bit and does not grow the sk_buff size so I
> think it has practically no cost for now.

The problem is that that thinking leads to death by a thousand cuts.

"for now" forces the cost of having to think hard how to avoid growing
sk_buff onto the next person. Let's do it right from the start.
