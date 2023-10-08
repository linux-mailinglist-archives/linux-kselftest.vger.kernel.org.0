Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F507BCFFE
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbjJHUJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJHUJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 16:09:21 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428599;
        Sun,  8 Oct 2023 13:09:19 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7abcef80a82so1465043241.3;
        Sun, 08 Oct 2023 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795758; x=1697400558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKzbBuqUCPwy23ymUT8eWLppkGLME/yOaopQNwUxG30=;
        b=mB2r707agsWpTrOg+hzMsJGDlaVjWyJHbZ8bjbEjj/17rUwaQRUykX5WounqYOiEec
         GIQAdGCFZFEWhH1FjLlpAEyKVHjOaOAUyCcBpqVxxWMVLV5Qb0wAKY5DOQLA/vngFXga
         li++ORimIYvsfVdij7VVk4RIJYQRpzLc6ee8TpFY1cNckzyxJN8pIPT9+Rord9zKC6ec
         lgOpQntLP/frzk8qvDbGNPuhcpraEG4KPdTj6kwghUIizdduJoXW32ericAg0uT90wJy
         DEbL7tQHFYBl9N4fHup4IrcsK8DCL9WwDnkXL86JL6/mnMRQ0I85QvhepDNgLr5Uryba
         kEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795758; x=1697400558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKzbBuqUCPwy23ymUT8eWLppkGLME/yOaopQNwUxG30=;
        b=cjfnZtjysG5KitGnHSv56gl5IV0SbZGVm+Q0aeaEz9lyDRaHV7S1a642cs92gKGF4q
         iY4SppQoYN4cqVPW+kb5rAT3Z/oaRUn0XCJdu/AjjLp5m+tzFmnzHvDqJWYWg9XQgQ9P
         f9zNfCA4TP89AJeIsL3b4oCqUt3DsehhpAGO/aysbjclfIYEBFBP1cQEkO+ZrCHQpa1Z
         aby9Bk01S3feERu7brfXNVH7mqBQ6NfSTIEE8gFWCI2JDpE7pH4prNB+ixBPfNIVTlak
         xZDE7My5qBpNEe56tNRCkQMZeMv8JKU6bAPNQk080zmVz55DOTiKoRK9eAg9w9AGPXhw
         4srA==
X-Gm-Message-State: AOJu0YzSeExkryXUE+o1xzmfy7iyI5oimFfaGmyhCVndJGiJBnUlGTtv
        8B+zBukitrt0yI7aIAzrse55DoTwaIbjC2BoDXM=
X-Google-Smtp-Source: AGHT+IGrYlgQ6F5EY0bVUrDd7waD3CZx2805a119uOAlNTL7Tqx04UAkUDYuRhHdWSoQ7JP98oJjlRy68sXaAxl/L7Y=
X-Received: by 2002:a1f:ed41:0:b0:495:dcd0:471 with SMTP id
 l62-20020a1fed41000000b00495dcd00471mr10732498vkh.5.1696795758506; Sun, 08
 Oct 2023 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
In-Reply-To: <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Oct 2023 22:08:41 +0200
Message-ID: <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
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

On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/09 4:07, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> virtio-net have two usage of hashes: one is RSS and another is hash
> >> reporting. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF.
> >>
> >> Introduce the code to compute hashes to the kernel in order to overcom=
e
> >> thse challenges. An alternative solution is to extend the eBPF steerin=
g
> >> program so that it will be able to report to the userspace, but it mak=
es
> >> little sense to allow to implement different hashing algorithms with
> >> eBPF since the hash value reported by virtio-net is strictly defined b=
y
> >> the specification.
> >>
> >> The hash value already stored in sk_buff is not used and computed
> >> independently since it may have been computed in a way not conformant
> >> with the specification.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >
> >> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D {
> >> +       .max_indirection_table_length =3D
> >> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> >> +
> >> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >> +};
> >
> > No need to have explicit capabilities exchange like this? Tun either
> > supports all or none.
>
> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.
>
> It is because the flow dissector does not support IPv6 extensions. The
> specification is also vague, and does not tell how many TLVs should be
> consumed at most when interpreting destination option header so I chose
> to avoid adding code for these hash types to the flow dissector. I doubt
> anyone will complain about it since nobody complains for Linux.
>
> I'm also adding this so that we can extend it later.
> max_indirection_table_length may grow for systems with 128+ CPUs, or
> types may have other bits for new protocols in the future.
>
> >
> >>          case TUNSETSTEERINGEBPF:
> >> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp);
> >> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering_prog, arg=
p);
> >> +               if (IS_ERR(bpf_ret))
> >> +                       ret =3D PTR_ERR(bpf_ret);
> >> +               else if (bpf_ret)
> >> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_HASH_RSS;
> >
> > Don't make one feature disable another.
> >
> > TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> > functions. If one is enabled the other call should fail, with EBUSY
> > for instance.
> >
> >> +       case TUNSETVNETHASH:
> >> +               len =3D sizeof(vnet_hash);
> >> +               if (copy_from_user(&vnet_hash, argp, len)) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
> >> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_=
v1_hash) ||
> >> +                     !tun_is_little_endian(tun))) ||
> >> +                    vnet_hash.indirection_table_mask >=3D
> >> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
> >> +                       ret =3D -EINVAL;
> >> +                       break;
> >> +               }
> >> +
> >> +               argp =3D (u8 __user *)argp + len;
> >> +               len =3D (vnet_hash.indirection_table_mask + 1) * 2;
> >> +               if (copy_from_user(vnet_hash_indirection_table, argp, =
len)) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >> +
> >> +               argp =3D (u8 __user *)argp + len;
> >> +               len =3D virtio_net_hash_key_length(vnet_hash.types);
> >> +
> >> +               if (copy_from_user(vnet_hash_key, argp, len)) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >
> > Probably easier and less error-prone to define a fixed size control
> > struct with the max indirection table size.
>
> I made its size variable because the indirection table and key may grow
> in the future as I wrote above.
>
> >
> > Btw: please trim the CC: list considerably on future patches.
>
> I'll do so in the next version with the TUNSETSTEERINGEBPF change you
> proposed.

To be clear: please don't just resubmit with that one change.

The skb and cb issues are quite fundamental issues that need to be resolved=
.

I'd like to understand why adjusting the existing BPF feature for this
exact purpose cannot be amended to return the key it produced.

As you point out, the C flow dissector is insufficient. The BPF flow
dissector does not have this problem. The same argument would go for
the pre-existing BPF steering program.
