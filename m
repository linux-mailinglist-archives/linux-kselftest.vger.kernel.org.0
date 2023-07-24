Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E675ED01
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGXIB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXIB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:01:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F5E0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso717405866b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=L8ohUoQwhRgvUZKLkgt2VAsrzphG3+p7mgJ/gQ+hDxT+HVl0t3pJLoFEdQrx/EQwy8
         xN1jUdg4iR/MYSLHSdB0o3Yg4cMoEfFfJyuO4WEkhPBIWYOyMlTGIrl4OG209ohSxtQD
         DQ/4D3OMZFqg3Mf/skvNwVLRIbKNFakNb+F8IzAU2JEIS0I+8iyUqV3ouJTt/iLoqnbv
         TkD15YOuPNF7Z6yAakkJUlScTQgfZQXvscA83nD8qR63JT1c/g6Q1+T4UwOETkE86fMg
         1NAHj9FRSpcvm/jIUFC37I2Hwi1EHaTDTYdpKW4AXtemRlwTju6DmY0fzVkMBXE4QIIT
         SiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=JoUPGzEfrwb7wuHaY4kB5vpoqwT42/nTkJPyZqdB8BLCJjqPF4NP1nbH46tYy/j0ON
         Hugqkvz9pPkkkbfrYWHyBCDyppK9h78bNT9aajeJjeh4zrqjuYbZPA0xNz1aNjXWR1vc
         jgZxnx3BJyhRs5WnhtY6FXwAZAxEXCPU6g6wkOs2Ju/0MuYpVVZMCDOO30AFbYAY79Ew
         pMBSgy1FgDLBZcx67xHs7tLCmLebQSAhaz+XXvhnxF1sDRWlJnGVwazwkTt3uo37BNp4
         KNvw8iA0RbZkujbZxIuj/9okSvMtyynUWy9KCIQYRgItMFlCJ1gMMfi7Uo+iLnMisfNy
         mVGQ==
X-Gm-Message-State: ABy/qLajow2E24N79GohqXDX9xcycjzbGvYikf483YFxWHyUWxZOiwlV
        Wz0YjiNhIrkJe99Y4k1+nuk6iEcvL27WTSDFYRmngQ==
X-Google-Smtp-Source: APBJJlHC5rMQrIx5ImZ99gmyXHNXpIqWWNKYgsVWHrLadDUIN+FGDrHLMI+w2SLqw3PTowpbtiuavEOWH40HooYc2NA=
X-Received: by 2002:a17:907:7846:b0:994:8e9:67fe with SMTP id
 lb6-20020a170907784600b0099408e967femr8119394ejc.35.1690185715296; Mon, 24
 Jul 2023 01:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com> <20230720211646.34782-1-kuniyu@amazon.com>
In-Reply-To: <20230720211646.34782-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 24 Jul 2023 10:01:44 +0200
Message-ID: <CAN+4W8h=dSqF-TV1pRueP1mGSpUpkkZGgMScL_=GR7PphTZRkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: reject unhashed sockets in bpf_sk_assign
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@cilium.io, joe@wand.net.nz, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 11:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:

> > Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> > This matches the behaviour of __inet_lookup_skb which is ultimately
> > the goal of bpf_sk_assign().
> >
> > Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
>
> Should this be 0c48eefae712 then ?

I think it makes sense to target it at the original helper add, since
we really should've done the unhashed check back then. Relying on
unhashed not being available is too subtle.
