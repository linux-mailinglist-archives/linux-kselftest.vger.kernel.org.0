Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B27BD7B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjJIJzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjJIJzf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 05:55:35 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA297;
        Mon,  9 Oct 2023 02:55:34 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4a06fb5331bso609678e0c.0;
        Mon, 09 Oct 2023 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696845333; x=1697450133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJUF31J0PbZtxav7G88aAg0axEBg2ZH8ruSnLMC/BFU=;
        b=IAmcXbBygL+PxCxXp4KzQD86973j00dsrHlNxupCd2IOMxPSuAc1E2AET9A7JlAqEH
         tRlE+6BTYXzg7mXZsHv78dbiY4EpasjFQjzT8du9oc2KRg2vtVvBWYgiDrw2D6Nq2xub
         M7n+I2hgUaVszuErZWWECuyr49UPs0oJg/rPe8fcZAIDsk/ro7brfl3uBpZShX1xznvx
         R5FJlfEw6orJ9trF8LPPyfXYYsFyJ9Wefk0WrhyKpoeDmcRrWAh0M8T1glePPVCIabsT
         Pka+mKOJX1dUuBdDANDtlrT15aufPtFZ0DvdVmkJ2CsLzdLXiF+SRFV4YQN2AmdK6epv
         nVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845333; x=1697450133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJUF31J0PbZtxav7G88aAg0axEBg2ZH8ruSnLMC/BFU=;
        b=tQedT06intOKGnRD/HPXz+Xw1Bdr2Hh0aZ+YVImhSXSerAfDRQtXSMtJtDVZTr/7Hn
         SCGJoE/gWjBwiDleN9Yd6lAD+vN+5r6NHElyUlo5R5a5qMaEGxwRhjgDrR40dJIWRvr+
         hiXomPgx1FbiyFkqN8P2KfK5Z0WY5W85AQwrIL11UDqDl3y2oGRv6pbehpQTF++COZx5
         6EmNlG267MTPcXJD/N8UyaPA11Cc0QzWEsrfvGyi3LsV9KE7LTfZga1TGFtYHsFIrFE0
         g4vBaCUQrqPz9KMhcvGaUaNz4OQlPx7KAp67gBYWZF4NwQVNJd6q02jczaCwhndUp3hK
         aFxA==
X-Gm-Message-State: AOJu0Yzl2CZC4bWGRKeFQEagGbGd2og3l7k4b2Qvck/Cxq5Pg3Bh9Fgc
        NbjhrDVaHK6XBUcksJ8Z2gYhWdzdkmtweeUEfME=
X-Google-Smtp-Source: AGHT+IEreKMizCCNFcpEhH5iXSdei2Vqfm7cxxdu5FLzU7oTPyhiYyKY1JIs9eh8s4CbyXRR0j34a2PGChoyRSIntTA=
X-Received: by 2002:a1f:4f86:0:b0:495:c10c:ec39 with SMTP id
 d128-20020a1f4f86000000b00495c10cec39mr10736648vkb.2.1696845333308; Mon, 09
 Oct 2023 02:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
In-Reply-To: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Oct 2023 04:54:56 -0500
Message-ID: <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 9, 2023 at 3:44=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2023/10/09 17:13, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 12:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
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
> >
> >> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct =
*tun,
> >>          }
> >>
> >>          if (vnet_hdr_sz) {
> >> -               struct virtio_net_hdr gso;
> >> +               union {
> >> +                       struct virtio_net_hdr hdr;
> >> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> >> +               } hdr;
> >> +               int ret;
> >>
> >>                  if (iov_iter_count(iter) < vnet_hdr_sz)
> >>                          return -EINVAL;
> >>
> >> -               if (virtio_net_hdr_from_skb(skb, &gso,
> >> -                                           tun_is_little_endian(tun),=
 true,
> >> -                                           vlan_hlen)) {
> >> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_R=
EPORT) &&
> >> +                   vnet_hdr_sz >=3D sizeof(hdr.v1_hash_hdr) &&
> >> +                   skb->tun_vnet_hash) {
> >
> > Isn't vnet_hdr_sz guaranteed to be >=3D hdr.v1_hash_hdr, by virtue of
> > the set hash ioctl failing otherwise?
> >
> > Such checks should be limited to control path where possible
>
> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are
> not read at once.

It should not be possible to downgrade the hdr_sz once v1 is selected.
