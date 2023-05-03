Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD616F5E03
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjECSfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjECSew (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 14:34:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E155583C5;
        Wed,  3 May 2023 11:34:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1063902666b.0;
        Wed, 03 May 2023 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138870; x=1685730870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyL6ErGxtGK4gbcrXbY7+L3d/vbQkgK7HxYu2bCcYGY=;
        b=Hyfqv2D/Vmdm2qFvoJ0/03cG9FwKp7F/gSIeqr4sgYcvejyBB87r94IUaNBhST7yVE
         npRmmDaVs6LIVUbsUBG9t7M/UqpLPq+eftmvOBtGnYdRyHTXJjwJ6zesj+es8PaF5XHU
         wQyE6sZfQ7VrBdLweKkk5Klq17iffIxZntoTmFywSrNt3Svyed2Eo8eiPNrba4aDEOPV
         fPhImEWYSmvpS/IeAHtnG66QU3GSEUBLm9uq0DfOdC4NwBIDciwxNCEznXKkCIQQXj9X
         vsupHh8Lu1hhe2h13Z4vKrlmL1PwA+QCTlrB+U2QRdVT/mGKSnD03QdOChUCv6figHdh
         QUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138870; x=1685730870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyL6ErGxtGK4gbcrXbY7+L3d/vbQkgK7HxYu2bCcYGY=;
        b=Fx7aXC0okIDAFpEsl9oq03lQgVGRbZFF9iPzu+ARlyXCpBNn0GCsDYe8+cPJ8hl8pZ
         W5bhOymR15V62UWzJTbTDe1204jBG+dOay0u9FfA148Av9l5/DMfFdli63nULRdqxftR
         TiIiTz1uK68WW2TmaPbH+pn5qcO7juBRTaXUED0bd19IWFSiCZlJcwqpRn1vQzRQCuHK
         3MLabC1o4Zoa56W3Yj88mVhMTBXqtNuw3rXKEnycOvjPzzesWPePEX2+7pu0R2D5Xy2q
         ZUkFE60bhIZGDWBaNAqHBcaa3dmIHLVXR0GL4SvtvtynxqGEgEVvkLIDiW/fFvPDUfkj
         btKA==
X-Gm-Message-State: AC+VfDyEkAo5O04FlTkjb4map6LSVND7FCSdHjp+zXmU3YCCqQRC1KuR
        7cQvMZa1IK+1wTzKyum9KF+w+W3w6TisLQWKznZMC9M/
X-Google-Smtp-Source: ACHHUZ7a+hQOAcN6OMpUgSZPHGzi8ZUj4EGszToNKziX2RB/Nt4YhgZDxNyVmWXTjd/63KKAyBsdDGJOjhhvuxX4Dmk=
X-Received: by 2002:a17:907:9705:b0:94e:1764:b0b5 with SMTP id
 jg5-20020a170907970500b0094e1764b0b5mr4372303ejc.69.1683138870113; Wed, 03
 May 2023 11:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
 <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com> <CA+PiJmQJ8m_W_SF3GPe9pqnwJX0gbkWuuOz-WXHWcA7JExgMyg@mail.gmail.com>
In-Reply-To: <CA+PiJmQJ8m_W_SF3GPe9pqnwJX0gbkWuuOz-WXHWcA7JExgMyg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 May 2023 11:34:17 -0700
Message-ID: <CAEf4BzbQthAhS_TzOuMecz45SXMf5zDL1c2XQ6xS6C5jpx-y+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 28, 2023 at 6:58=E2=80=AFPM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > would this work correctly if someone passes a non-null buffer with too
> > small size? Can you please add a test for this use case.
> >
> Working on a test case for this, but the test case I wrote fails
> without my patches.
> I'm just declaring a buffer of size 9 on the stack, and then passing
> in bpf_dynptr_slice that buffer, and size 10. That's passing the
> verifier just fine. In fact, it loads successfully up to size 16. I'm
> guessing that's adjusting for alignment? Still feels very strange. Is
> that expected behavior?

pointer to stack is trickier (verifier will just mark part of stack as
overwritten with random data), it's best to use map value pointer as a
source of buffer. So try using ARRAY map with small value_size, do
lookup_elem, check for NULL, and pass non-NULL pointer as a buffer.
