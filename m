Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4773F7581A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGRQGg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGRQGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 12:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF36F1AC;
        Tue, 18 Jul 2023 09:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3EA6165D;
        Tue, 18 Jul 2023 16:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B576C433C7;
        Tue, 18 Jul 2023 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689696393;
        bh=EOkdjFMWH7brfMl6FFZE0qz5Gq2zAqO7jP+yRL3OVlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qIb3AHg2MbxQcaCcnDObe7IyWQP9EULqWkf332wERinXUyRdCHH/qCNeIigrp5Ycw
         ydaIfRizs/INJy0ZXVU/+UZxqXbZ1IndtS1QbbNupQjXFCMOZ7s9GtI5Lx1NiLYhed
         N/TXvdwYWv4fstA72glvLH0cz5taXu9s65LrpLU7ltohhuRGO22kZCO1NSDiaci9Yc
         TJl7yenY0O0Vr33FHbShSyg4HHSBhu5lDXZoQp2aT3kvY61gJajckRsCIyRPO8GqYb
         736uydTpvyC9e+RNDJoH0F4C0bAE+h387TX3d2LR2rVDoFVrDCpdJmKatD4hvVsZ17
         nWLnw8l6c1maQ==
Date:   Tue, 18 Jul 2023 09:06:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718090632.4590bae3@kernel.org>
In-Reply-To: <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
        <20230718082615.08448806@kernel.org>
        <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 18 Jul 2023 08:52:55 -0700 Alexei Starovoitov wrote:
> On Tue, Jul 18, 2023 at 8:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote: =20
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb,=
 int offset, int len,
> > >       if (likely(hlen - offset >=3D len))
> > >               return (void *)data + offset;
> > >
> > > -     if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < =
0))
> > > +     if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buff=
er, len) < 0))
> > >               return NULL; =20
> >
> > First off - please make sure you CC netdev on changes to networking!
> >
> > Please do not add stupid error checks to core code for BPF safety.
> > Wrap the call if you can't guarantee that value is sane, this is
> > a very bad precedent. =20
>=20
> This is NOT for safety. You misread the code.

Doesn't matter, safety or optionality. skb_header_pointer() is used=20
on the fast paths of the networking stack, adding heavy handed input
validation to it is not okay. No sane code should be passing NULL
buffer to skb_header_pointer(). Please move the NULL check to the BPF
code so the rest of the networking stack does not have to pay the cost.

This should be common sense. If one caller is doing something..
"special" the extra code should live in the caller, not the callee.
That's basic code hygiene.
