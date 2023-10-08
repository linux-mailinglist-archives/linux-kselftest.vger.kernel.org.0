Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8B7BCF96
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjJHShf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHShf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 14:37:35 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6230AC;
        Sun,  8 Oct 2023 11:37:33 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49618e09f16so1256513e0c.2;
        Sun, 08 Oct 2023 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696790253; x=1697395053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeJ1AX0Emm0B1MNXW9ufDQ+zSWl6WDvAagaRLQUTatk=;
        b=bw2CaHJV30W1P8hD9Sxix6Raciuwqe4hW0Uk0mlEYlzd4OnuO5uc7GuIHkz0hbHfTK
         RQNJ7ycAjlpUYPmJ7Zp4Vo6l/OEQfi1YZkMhxrDvsNUL6B5C6GdunbC/oAcekOHT/AIO
         RT+yUssx6Vta3fHXs+lPFlhJ5PIZtHmw7Fj7/hicQDhLH7xSJyLZXBX7Twj2ZIzm08Xp
         XvnSmZZG5yoXH+BiOry4Pzc/k1Dq3tdrCIm21aw4kTB7pR1B91fzk/s9sUZGhDtoUVre
         i3g8QculUQYsY7ufD/DfMtzkzPBGw3IMo9OKizsufXdIasJuD8Z0y1K0EzMp/PQrhNuH
         ziGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696790253; x=1697395053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeJ1AX0Emm0B1MNXW9ufDQ+zSWl6WDvAagaRLQUTatk=;
        b=wD3nZzd6qpSJKuO+gHs5SSVQPdeZLT8WTQRqz57JgzF3OkHlXF2tJZS4DPDBbAAn6N
         lshIHjgGFM6mU9ol6e0j7S0wO27xQQ7xPAx3iwkb3+Zj0nWfbmV6jLXk0FI6aWfaAQZ4
         WhtnG4+IIQpxe0tMlv4V/E1vE+QJ/0ryp+XOctTn2vxf2AOcnpzK4F5AJMuXG24DQga/
         /hQRx3P8LyaE0+qQ/rIDGAYaWXDpmfSnzpyAoIgORaVUY57LKpOulF46onLPniZvoDYj
         vy1XKWwMxBQM3zbY2eGOHMlkJjfJ4e5SEQ0eCyh8Az3QIfnmFD38YLExsmie7SDWaX8E
         cHIA==
X-Gm-Message-State: AOJu0Yy6D2HJI+U6iNnEEBUaFx6vEJV446fVJ30B9k5ikROq8oJBMw8r
        240EpahogR6axyPvsHI7f/2yo91KyMbGyc0kg/U=
X-Google-Smtp-Source: AGHT+IHSB43dF0pLQwl5fSHzzvgSOaQuNELTv/vnarvg9JxIB3dWUKmxutdHnh4vUjKSphH5Pexh5TnlfPVFyCr7FY4=
X-Received: by 2002:a1f:e641:0:b0:48f:8891:29d9 with SMTP id
 d62-20020a1fe641000000b0048f889129d9mr10186430vkh.13.1696790252736; Sun, 08
 Oct 2023 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Oct 2023 20:36:56 +0200
Message-ID: <CAF=yD-LnqYQ2qdiV+oygfHq5ZQb7QaSZ81XikzKjY8unfCTGRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] tun: Introduce virtio-net hashing feature
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

On Sun, Oct 8, 2023 at 7:21=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
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
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it makes little sense to
> allow to implement different hashing algorithms with eBPF since the hash
> value reported by virtio-net is strictly defined by the specification.

But using the existing BPF steering may have the benefit of requiring
a lot less new code.

There is ample precedence for BPF programs that work this way. The
flow dissector comes to mind.
