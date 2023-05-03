Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB66F5E82
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjECSuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjECSts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 14:49:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE619A8;
        Wed,  3 May 2023 11:49:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so7792753a12.1;
        Wed, 03 May 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139766; x=1685731766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD37naz1y4adnKBHCi37A5366cr37Qr3DhQA4M+9vdQ=;
        b=jkHZIic4zMoD2D2yKKLHoDBj8KjdV3nyMVlwyyr0FnYbpXXvQv6KGvKRQHhFePhJwN
         y4a4OrmvGg+JAf2TIM1ezAvyCU50MiMjI4z1u0bIQdNDaDaf7haDBipYJRCznMo2i34D
         qEPDeWxhj8DyfuAPO50Ocg8KfSuYD+iBekQZ9cT3B/fjBzeADPWq95Zcwkw+Ha72wlpL
         s2iH79GfwdYK15llrl7MI1tQ1dwdetsOMBH8A5cbzI5ndGgMNxhdu11RyoyfdVoB/Sbc
         sSYeyMMt0h63uIaDqFvaAv0/yhBWU8dgHdoeJyMi+mUFXxuyG/3dMAOvY470EPraBy+j
         XUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139766; x=1685731766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD37naz1y4adnKBHCi37A5366cr37Qr3DhQA4M+9vdQ=;
        b=fZCq2oQqADWNkSvCpwh5JtAMddvcfNJAXdbvXUxoh+YGFt3FLqpmkmZyQgKPKzvrch
         chLErvNpMmUzZUMnUpphgKubhioV/ZgpbRAc3JWhPxTxhTA/TBw0oxu6P8sOX/VHH6LZ
         0cAjljzrJfc6dhW0oDIVrhDJLHavSnq18XvwdKLQOsbCqunTVMCYzoOgPgvqaeONNow1
         OmSI4qck/x0dXpT/uQ40aCPIW+hjwndafAcuUJeEKKVJJdFNEf/rq7VrqoVU4tcVJ+o2
         XC/j4WYqPaGN3ixGJSq2qGH9r9FUyOIIRl0/IVCPnjU0ttZiidCC1g1++Rq1eow03SMg
         uGHQ==
X-Gm-Message-State: AC+VfDyrJWQuqF1KEmwpyWx3Lc7l4BtXAVKQEQkbSp4k02GhyAWyiGaS
        EXnwQu4OtPnZsWV3ZgLonw3bwcZrtDZcOb3NX4o=
X-Google-Smtp-Source: ACHHUZ76xKnCcn1JyjJd+WU9V7ueR/fbedFqrncRZ2+mlvIPAVgSCt1aXT/zUpv+l+hsFpnaE1nmwvttE9XpEsKP6N0=
X-Received: by 2002:a17:907:844:b0:961:69a2:c8d6 with SMTP id
 ww4-20020a170907084400b0096169a2c8d6mr4206788ejb.69.1683139766485; Wed, 03
 May 2023 11:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com>
In-Reply-To: <20230502005218.3627530-1-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 May 2023 11:49:14 -0700
Message-ID: <CAEf4BzYtAhch7TrkO6QH6fnQ--9e-U1gRSNw_s_pMG-Jv9PxJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
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

On Mon, May 1, 2023 at 5:52=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
> a pointer to a block of contiguous memory. This buffer is unused in the
> case of local dynptrs, and may be unused in other cases as well. There
> is no need to require the buffer, as the kfunc can just return NULL if
> it was needed and not provided.
>
> This adds another kfunc annotation, __opt, which combines with __sz and
> __szk to allow the buffer associated with the size to be NULL. If the
> buffer is NULL, the verifier does not check that the buffer is of
> sufficient size.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
>  include/linux/skbuff.h       |  2 +-
>  kernel/bpf/helpers.c         | 30 ++++++++++++++++++------------
>  kernel/bpf/verifier.c        | 17 +++++++++++++----
>  4 files changed, 54 insertions(+), 18 deletions(-)
>

[...]
