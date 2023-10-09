Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C0C7BDA47
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjJILvJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJILvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 07:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1FE94
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696852224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
        b=X6fQRVGUekm0B4f/MlPxIcOwEe8uqFroQiM/Z1UkeLIR8IXlz/8l5bIhfCp+i6N+FUnCGn
        GLdI0pim32A+DjQj0IO4h5JICUwM/xdJrGjUeZEWyKBUm70R14m3j1Q2Td9KHTVVOtKeOu
        702W5UzDIIfMUxlJCnQDCgkqBsxgPAA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-anPwHi28PlKOg7L6uut0Sg-1; Mon, 09 Oct 2023 07:50:22 -0400
X-MC-Unique: anPwHi28PlKOg7L6uut0Sg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so361982266b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852222; x=1697457022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
        b=pirTohBQKDFJEaKlj7tk1j9ARgHhaorjYumr3e1cFFxOojcESehwCVQ1llXaVlmEw+
         9ahpXXao9dDNOoRAoN3ySBANp03yfEO3icjPwmPAkGvYmkSHp/+n9BsagTpcnm2U4cWI
         1tNuaXvugophVFpQAwS31vB9wjZmVNIc9LEhzTRNL8fqQjcSVvCcnWH73guJSv/UEWiO
         OiXyBD7NMsJepvEa98VqoKttuoaCEzwCfmh7d64zIw0mszs+tNh/oZ9qX0pBNQF7qXUH
         D1O4IOF1D/6YXkRBJ1KBEsBO9g520w+flDMlKzYDx+0Sj4GAywcDkRI8cIvISx81N3mW
         Sv4A==
X-Gm-Message-State: AOJu0YyGgk/UYacuhEGs3pMqwDc5M6MAO2/AtSnGZtp0AZZKX7bzMfyS
        vqgyocT2l6WymuWD5bbBpEnuJWBY6hL09mTBLo7xNiCpUEQMPFJYcwKm94SFJq5DW48e5P4ioK7
        c8Vp28xDnqc5Em6M31cDzSY17pXGj
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id gx16-20020a1709068a5000b009aa2c5b6591mr14399885ejc.9.1696852221872;
        Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOfzC8yt9O1EKKC6ulfMdWzK/Wyw5t8obuDTFM7EgyZXQHnZ2zQtwYH9FVSA5nqeIbOBRa3w==
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id gx16-20020a1709068a5000b009aa2c5b6591mr14399871ejc.9.1696852221495;
        Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d393000000b005330b2d1904sm6058419edq.71.2023.10.09.04.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:50:20 -0700 (PDT)
Date:   Mon, 9 Oct 2023 07:50:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Message-ID: <20231009074840-mutt-send-email-mst@kernel.org>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 05:44:20PM +0900, Akihiko Odaki wrote:
> On 2023/10/09 17:13, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > 
> > > virtio-net have two usage of hashes: one is RSS and another is hash
> > > reporting. Conventionally the hash calculation was done by the VMM.
> > > However, computing the hash after the queue was chosen defeats the
> > > purpose of RSS.
> > > 
> > > Another approach is to use eBPF steering program. This approach has
> > > another downside: it cannot report the calculated hash due to the
> > > restrictive nature of eBPF.
> > > 
> > > Introduce the code to compute hashes to the kernel in order to overcome
> > > thse challenges. An alternative solution is to extend the eBPF steering
> > > program so that it will be able to report to the userspace, but it makes
> > > little sense to allow to implement different hashing algorithms with
> > > eBPF since the hash value reported by virtio-net is strictly defined by
> > > the specification.
> > > 
> > > The hash value already stored in sk_buff is not used and computed
> > > independently since it may have been computed in a way not conformant
> > > with the specification.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > > @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> > >          }
> > > 
> > >          if (vnet_hdr_sz) {
> > > -               struct virtio_net_hdr gso;
> > > +               union {
> > > +                       struct virtio_net_hdr hdr;
> > > +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> > > +               } hdr;
> > > +               int ret;
> > > 
> > >                  if (iov_iter_count(iter) < vnet_hdr_sz)
> > >                          return -EINVAL;
> > > 
> > > -               if (virtio_net_hdr_from_skb(skb, &gso,
> > > -                                           tun_is_little_endian(tun), true,
> > > -                                           vlan_hlen)) {
> > > +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
> > > +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
> > > +                   skb->tun_vnet_hash) {
> > 
> > Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
> > the set hash ioctl failing otherwise?
> > 
> > Such checks should be limited to control path where possible
> 
> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are not
> read at once.

And then it's a complete mess and you get inconsistent
behaviour with packets getting sent all over the place, right?
So maybe keep a pointer to this struct so it can be
changed atomically then. Maybe even something with rcu I donnu.

-- 
MST

