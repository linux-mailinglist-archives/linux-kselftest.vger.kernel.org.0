Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E46C8628
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 20:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCXTtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCXTtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 15:49:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784D59D5;
        Fri, 24 Mar 2023 12:49:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so12040282edb.10;
        Fri, 24 Mar 2023 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679687344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dGXja0zvpydJsZsuWVMkoEKw4WPEINUjm2uBsr6JaU=;
        b=hs+ldOsjN8SnevYkzSOcp4cUBEN4Xz3SacCSZd9EtvwORoBt+sjEovcWxwL5NRPud/
         5xtC+0z/mihjmMb9UwUJHVANr65g4XGxlUbowxfEyRQNVL2fbf3D5UnoHBKwlTNdqeca
         DellOa12KN2h9XCNNadej7ttPf9Gq9ezLz03YnxpIXt59Fs36Ey5JUYBA8ovvNhEviUz
         TMXBWFTpwMXnuTPYUzvqp5WSAIybWC7VCvuMCTc33hipAa9Cb1fYT1PSGeyqZH1VSsRZ
         s7RuGtEbereB47YaGeVgLLSSFeeOZFk6r68ZoYAYvf54FwKsYH/54Xofkpik0jJRGogR
         SPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dGXja0zvpydJsZsuWVMkoEKw4WPEINUjm2uBsr6JaU=;
        b=4oNYKaVCrwr4JYztL+Cl5b+qUkOeaKqtdiPlUc/pKZUX6NUTr6DbdYjmz/ZDsKdhuW
         514SiHA1AjmfkYfhsL7PsbwetXQpicEckjmGvuCr2SmjwDmhXcYIUc9LCUlvP5iUzctg
         TeGMp+Dna7sc9Ign2id2fAwteYL8WrALTgvZaQYFZNNO7DCs0mV4YXEc87T4cwXp/HrE
         QZ2HIw9Knp0tTIpUCynPStsGsMdBx2lRaZNTrh9ZMlYzodeZ8PfkxX/vnzyIyOkVsdI7
         pgRSSGOD/Ux2jhXMaEfaaGyo33P65lVkiWSL41PFrS/vNKnn+vmiyhfBUhBve78bDKWc
         Vjgw==
X-Gm-Message-State: AAQBX9dzy/XsYjSyO8BNTaDFYYaeK80+qVI6gJd5QwgCkAxPEYArasK+
        f5ODvs//Y9NGiO9UYeKkunMmE8qoBVy3+0GEEQ6M+2Kurg0tTidF
X-Google-Smtp-Source: AKy350ZSA0zMugpWag/aWNzDe6DH4VbciU7FRSO8/Ns0h3xwxK448eN6P/ZPeRUIQsY0L0n+v2e7VRgBj5PuJtuhA4U=
X-Received: by 2002:a50:cc94:0:b0:4fb:c8e3:1ae2 with SMTP id
 q20-20020a50cc94000000b004fbc8e31ae2mr2144838edi.3.1679687344430; Fri, 24 Mar
 2023 12:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230324123626.2177476-1-sashal@kernel.org> <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
In-Reply-To: <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Mar 2023 12:48:53 -0700
Message-ID: <CAADnVQLJNtCmSXy1DP-ihbZAgkEySVPPH9u4TGZMOOfKiCvtUw@mail.gmail.com>
Subject: Re: [PATCH] capability: test_deny_namespace breakage due to
 capability conversion to u64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 9:49=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 24, 2023 at 5:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > Commit f122a08b197d ("capability: just use a 'u64' instead of a 'u32[2]=
'
> > array") attempts to use BIT_LL() but actually wanted to use BIT_ULL(),
> > fix it up to make the test compile and run again.

It would only fix the compilation error, but the test would still fail.

> This got fixed differently by e8c8361cfdbf ("selftests/bpf: Fix
> progs/test_deny_namespace.c issues").

exactly. It's not just the macro that had to be adjusted.

> I wonder what drugs made me think BIT_LL() was ok. Maybe my wife puts
> something in the coffee?

$ make C=3D2 kernel/bpf/core.o
kernel/bpf/core.c:1822:43: error: arithmetics on pointers to functions
kernel/bpf/core.c:1827:48: error: arithmetics on pointers to functions
kernel/bpf/core.c:2073:77: error: subtraction of functions? Share your drug=
s

:)
