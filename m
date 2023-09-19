Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3C7A5D1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjISI5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISI5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 04:57:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEA11A;
        Tue, 19 Sep 2023 01:57:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so5336250f8f.2;
        Tue, 19 Sep 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113853; x=1695718653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M0oH3rEpj2jIH57zHE90N6wAzwLmk1hC60jq7/TfHg=;
        b=UnvUmYW9t+62tSO9cDZLDbwBNl0sLb/ElHQhYNWBNFnkmSHpH53HhSMbHKM3wmxnm9
         nQfAJfz1JE3yqc0ZC+DfxsHNi11Id0LWKjoyDpfJK8BT/4Ov/NUe9w3hQMGvyy6PUNkh
         0TyNsm8KFzQHF6S0mZm5eVUzIaBVCKlc6DKscas3MhaIU+BKfxkMzgpbH0HD8fxYPztc
         iBViLpo0W5lPQPI+6IARjdadXo5g0ISfHHXz6r2SoLIyTDLNDb1OP4gZetL2FqIsBEUV
         Kxi5hRNJ6VzKgc6f2Huf9gGYpirxqhetqjV0L8hFsLblSSV5mWYMkC2+q5hJxQerkt6g
         gk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113853; x=1695718653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M0oH3rEpj2jIH57zHE90N6wAzwLmk1hC60jq7/TfHg=;
        b=ROdYee6uVmJmbTBv2Gmu8xwDG22BVw5e8BOAqONeD0/IivdiVyTXPeqk9G+UyK8WbS
         kvPxjw1Y03mvwlvEKVchaz5hLyI/9PAJPwKnG9e8XexJVGHINkeLkqpYqU31YEzW1su6
         wlV0B5c2Bjp4/DXhCwXW6EP0d/Exu3ziywoCV9AGdtVjyMO0Y0dW/iBGp53lMpRkujQ6
         x3NnxOqePh+cDNw4aYl+JntOQVeinV/Hgy1DNYWMnLtEYZdQ5mER8qg4Ure/ZeRZ7zeA
         EEQMbw+p64Z4BhcUvCOVXFxHDt0y/yzVs1yvvjFPG7dI7UW2G5uke+DMcuZEmGrFFK0j
         WN0A==
X-Gm-Message-State: AOJu0YwAb4Hk7Cd7HxTaJfKxHCakwrCtzebV4b6g9GbNgAhU5BTJZLKO
        hSwnRxhHX3ZjgrFBC9naTbvhn+cmmX06fRzCHDI=
X-Google-Smtp-Source: AGHT+IFEm6ihX07RHkQmJfPR6TpX2UomyvS3tyYQCrIhoP2uqDAyqq7eUstv+fQIDZ8XqcVULym8YSHeZoX2xIpK0Ws=
X-Received: by 2002:adf:ce87:0:b0:317:57f0:fae with SMTP id
 r7-20020adfce87000000b0031757f00faemr9012499wrn.63.1695113853086; Tue, 19 Sep
 2023 01:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJ4Fg-VQ-tVCEqsKLuozT7y_o8pZ1oM3eBW7u-Z0jOk4A@mail.gmail.com>
 <20230918112549.105846-1-gerhorst@amazon.de>
In-Reply-To: <20230918112549.105846-1-gerhorst@amazon.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Sep 2023 01:57:21 -0700
Message-ID: <CAADnVQJZRqNZ_rKw2tUrmDpwhW7JGUge1+9x1_qtROf=OyMpHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Luis Gerhorst <gerhorst@amazon.de>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Luis Gerhorst <gerhorst@cs.fau.de>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Hao Luo <haoluo@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>
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

On Mon, Sep 18, 2023 at 4:26=E2=80=AFAM Luis Gerhorst <gerhorst@amazon.de> =
wrote:
>
> It is true that this is not easily possible using the method most exploit=
s use,
> at least to my knowledge (i.e., accessing the same address from another c=
ore).
> However, it is still possible to evict the cacheline with skb->data/data_=
end
> from the cache in between the loads by iterating over a large map using
> bpf_loop(). Then the load of skb->data_end would be slow while skb->data =
is
> readily available in a callee-saved register.

...

> call %[bpf_loop]; \
> gadget_%=3D: \
> r2 =3D *(u32 *)(r7 + 80);   \
> if r2 <=3D r9 goto exit_%=3D; \

r9 is supposed to be available in the callee-saved register? :)
I think you're missing that it is _callee_ saved.
If that bpf_loop indeed managed to flush L1 cache the
refill of r9 in the epilogue would be a cache miss.
And r7 will be a cache miss as well.
So there is no chance cpu will execute 'if r2 <=3D r9' speculatively.

I have to agree that the above approach sounds plausible in theory
and I've never seen anyone propose to mispredict a branch
this way. Which also means that no known speculation attack
was crafted. I suspect that's a strong sign that
the above approach is indeed a theory and it doesn't work in practice.
Likely because the whole cache is flushed the subsequent misses
will spoil all speculation. For spec v1 to work you need
only one slow load in one side of that branch.
The other load and the speculative code after should not miss.
When it does the spec code won't be able to leave the breadcrumbs
of the leaked bit in the cache.
'Leak full byte' is also 'wishful thinking' imo.
I haven't seen any attack that leaks byte at-a-time.

So I will insist on seeing a full working exploit before doing
anything else here. It's good to discuss this cpu speculation
concerns, but we have to stay practical.
Even removing bpf from the picture there is so much code
in the network core that checks packet boundaries.
One can find plenty of cases of 'read past skb->end'
under speculation and I'm arguing none of them are exploitable.
