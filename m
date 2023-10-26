Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520A7D8A63
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjJZVdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJZVdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 17:33:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53BB1AC;
        Thu, 26 Oct 2023 14:33:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c3c8adb27so205081766b.1;
        Thu, 26 Oct 2023 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698356012; x=1698960812; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASkx/seKw1YtjFjKsIGUgBV6CKjEmc7iU1IIiSP7eYk=;
        b=nYndZGk768C+pcpPfY+PNAM0e8jacZEaQzw+lBQGeQaq/C7fmPRe9zAO/NxJ7jm1Ho
         1ol36e2mSezoYFd89bqvhg8F/15fYRxsa3h2C9oSAU6AsHfEZNxFXrnaEmucNWSh9FrP
         ZpiriqICGfBzIiQq0wj7JL7tehg+TCBHCYU0iFo1j5WD9wvxru8e8hOkRHE5gAkHZqqo
         zLKtHuJ5uBj7rbwLvMQLXMapzZqV/ys7tT/xKd2LRIWSWJ2VUDpRZbUbRKuNkFjmqu2B
         2iMgrx1HtrWdqn0AYarb57ynZTe96o88MfSa7ybBW1IMMDSN6h7yvj2+zChtZ/XLmJOM
         kxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698356012; x=1698960812;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASkx/seKw1YtjFjKsIGUgBV6CKjEmc7iU1IIiSP7eYk=;
        b=lpPs1VCBp1O22KzSXl2H6CqTA5lwqBzwj0DcONDSJxRI+xBs3pzoImTF3RplY7Itj1
         X7St28Q/m91GS0X1yszR6v36hMy4rPrd6MgzqklhxQtJx1SC1Kmr/gV7K3VBLPluvNf5
         J4Y6ewJMzte27yFMxEJzyiG5l/Qxamu/sF4YIxc8sPPtNWoRuAt/DmK6Xd1Cx/A+hiBf
         QDAxRuwMRWBuqiVuthFw+X66cz6i8944venhB2kTGQe9EHsYhisZDbqaszQ66xEbdqoE
         dFzdKuDKtqvUFokUyk6fHJqMNuK1Tlf154b7mYxySLUvmU6VB1cH62cteNVu0RzovmFB
         cpPA==
X-Gm-Message-State: AOJu0YyQ2M0Ac0aG1wzJtS4Nd+YJuqv5TlDd33ggfnFUEUzcGrYhrmUT
        1qL4J7UfFFycL2kXYN6if90=
X-Google-Smtp-Source: AGHT+IH0n/0FDbflc8SokhFm2icvHNmomLnkCanqkoI6rky+zSHGaw9GIjdNCoO7Oo4uWx2FBohIBg==
X-Received: by 2002:a17:907:3202:b0:9c6:3c94:69de with SMTP id xg2-20020a170907320200b009c63c9469demr803220ejb.53.1698356012084;
        Thu, 26 Oct 2023 14:33:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906680f00b0099b8234a9fesm186613ejr.1.2023.10.26.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:33:31 -0700 (PDT)
Message-ID: <707a9c4c001ca5efe8bf7db36e7341f308651451.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix incorrect immediate spill
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Fri, 27 Oct 2023 00:33:30 +0300
In-Reply-To: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-10-26 at 17:13 +0200, Hao Sun wrote:
> Immediate is incorrectly cast to u32 before being spilled, losing sign
> information. The range information is incorrect after load again. Fix
> immediate spill by remove the cast. The second patch add a test case
> for this.
>=20
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Thank you for finding and fixing this issue.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
> Hao Sun (2):
>       bpf: Fix check_stack_write_fixed_off() to correctly spill imm
>       selftests/bpf: Add test for immediate spilled to stack
>=20
>  kernel/bpf/verifier.c                             |  2 +-
>  tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++=
++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> ---
> base-commit: 399f6185a1c02f39bcadb8749bc2d9d48685816f
> change-id: 20231026-fix-check-stack-write-c40996694dfa
>=20
> Best regards,

