Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97A57BD8A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjJIKdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345759AbjJIKdQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:33:16 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60C9C;
        Mon,  9 Oct 2023 03:33:12 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49e15724283so901733e0c.1;
        Mon, 09 Oct 2023 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696847592; x=1697452392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT1rH97yMTf0notAyuO1uE+7xlHDEM8gJWBeBFRun/4=;
        b=fVJBx33lvVIec7BPRSSeE1O1koYZKiO+/Cr6z5bLUzgCreyYXGO+x8B2SShUHfyJ4j
         k5GC9oY+TcT2fOCQI3pupWdXhW6EP4hkM4UgbPJjBd28xc3lhSeaEhOHFUXWZUiwdT+L
         vOxDoiIBYvQ2IdGoGqSD6ie0+dr/OGfYtKzkipAWvDXM0koqeftnk9iLFBJwiNAjhL2v
         SeTfVGGmiV7UZoVwlqi7XmRqfip0GLVdUXOgdZ650E6EDzkjjwIlAMemJKH+XFvbXUgI
         LCr6AvrmfYv9AeeqQKhI8VXfw61s3oCDaNJ8OfNlHM7NkvXViyoEzLKHPcSeewvCFV4Q
         fJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847592; x=1697452392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT1rH97yMTf0notAyuO1uE+7xlHDEM8gJWBeBFRun/4=;
        b=gwaCu5w5srJag2kxxKlhJqhVSfLN7u00nqBgx2BsKFAVzerrbGBdFLyWbDJMct3xy3
         bJqnNgtqXTwn0506AGjdX5nFmtM14urzYbiAgVkeQfoedY8s3WYt10qCRU3ThB2EhCFr
         s8fdmBUVUOyO3iDiq8HotjsECOC0mRhWLWIO4bvPQp3/A9S/ZV0YzRfBkxV3IyLZon0e
         gNTVy5fEB/btbklRPR2fgjDfsj6PDaQcA8M7j3SGYMIwcdcaEHHTAKE59wwkAnkkVSsS
         dOrHCv7M31FoW29pCZ31pugOSqQBmBT3qjUE+ji4s3JCcXSyZrbMwD/Mtte/Pi9EQOVE
         iyHQ==
X-Gm-Message-State: AOJu0YwbB5bZljxngf8xczZca1ExEhMa5UgI9C9oQ5jJ+S5MIWFG4Pfe
        EOAhEAc9PaY837qUFR2mYYGYX/bHcmKJQNTmc4c=
X-Google-Smtp-Source: AGHT+IHE+bLXnKSnxxU/KTXcPWxDAmkZwBaU9nQyxeRMxaOL1S5mD7d5OmMEdKfRaLaQMD1aS0xEm5VGTb84Y71ZDqI=
X-Received: by 2002:a05:6122:7c9:b0:49d:c216:873d with SMTP id
 l9-20020a05612207c900b0049dc216873dmr13801907vkr.8.1696847591769; Mon, 09 Oct
 2023 03:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com> <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
 <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com> <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
 <eab359ec-3bb9-4245-8ac3-097d66ef30a9@daynix.com>
In-Reply-To: <eab359ec-3bb9-4245-8ac3-097d66ef30a9@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 03:32:33 -0700
Message-ID: <CAF=yD-LPMK4eOTABU5EPOOnSCBo=jQNPuNXLLa6qZy_jHSxyMg@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 3:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2023/10/09 19:07, Willem de Bruijn wrote:
> > On Mon, Oct 9, 2023 at 3:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >>
> >>
> >> On 2023/10/09 18:54, Willem de Bruijn wrote:
> >>> On Mon, Oct 9, 2023 at 3:44=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 17:13, Willem de Bruijn wrote:
> >>>>> On Sun, Oct 8, 2023 at 12:22=E2=80=AFAM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
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
> >>>>>
> >>>>>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_str=
uct *tun,
> >>>>>>            }
> >>>>>>
> >>>>>>            if (vnet_hdr_sz) {
> >>>>>> -               struct virtio_net_hdr gso;
> >>>>>> +               union {
> >>>>>> +                       struct virtio_net_hdr hdr;
> >>>>>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> >>>>>> +               } hdr;
> >>>>>> +               int ret;
> >>>>>>
> >>>>>>                    if (iov_iter_count(iter) < vnet_hdr_sz)
> >>>>>>                            return -EINVAL;
> >>>>>>
> >>>>>> -               if (virtio_net_hdr_from_skb(skb, &gso,
> >>>>>> -                                           tun_is_little_endian(t=
un), true,
> >>>>>> -                                           vlan_hlen)) {
> >>>>>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HA=
SH_REPORT) &&
> >>>>>> +                   vnet_hdr_sz >=3D sizeof(hdr.v1_hash_hdr) &&
> >>>>>> +                   skb->tun_vnet_hash) {
> >>>>>
> >>>>> Isn't vnet_hdr_sz guaranteed to be >=3D hdr.v1_hash_hdr, by virtue =
of
> >>>>> the set hash ioctl failing otherwise?
> >>>>>
> >>>>> Such checks should be limited to control path where possible
> >>>>
> >>>> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz=
 are
> >>>> not read at once.
> >>>
> >>> It should not be possible to downgrade the hdr_sz once v1 is selected=
.
> >>
> >> I see nothing that prevents shrinking the header size.
> >>
> >> tun->vnet_hash.flags is read after vnet_hdr_sz so the race can happen
> >> even for the case the header size grows though this can be fixed by
> >> reordering the two reads.
> >
> > One option is to fail any control path that tries to re-negotiate
> > header size once this hash option is enabled?
> >
> > There is no practical reason to allow feature re-negotiation at any
> > arbitrary time.
>
> I think it's a bit awkward interface design since tun allows to
> reconfigure any of its parameters, but it's certainly possible.

If this would be the only exception to that rule, and this is the only
place that needs a datapath check, then it's fine to leave as is.

In general, this runtime configurability serves little purpose but to
help syzbot exercise code paths no real application would attempt. But
I won't ask to diverge from whatever tun already does. We just have to
be more careful about the possible races it brings.
