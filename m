Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF8730408
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbjFNPnA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjFNPnA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 11:43:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFB2101
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 08:42:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977e83d536fso121521966b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686757376; x=1689349376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtT0/eZ+pzVcJ4kjv037r9aHK8XNjhCtUjr9Gr9jvYU=;
        b=ZP/SamkUlMwFjkSD+wrJBR2kE19TzHG8u/731TAnTAmVaSTQXtc0WwSReIL1pIoYyf
         hAj1Fc83SjRkaP/Jd8z+8vJrD7kacBt1WV+EFkP6WCPbUg1TFiUki5IQEAS5cjPTJIfl
         NuAVoDBcAtSqb1N6akK+1QNhFDl0FUCmiUU2J30qDEaelyMgFfmxTcRgPY5ojlK3pt8V
         UILRh0iEMQtUeodX9l9Q6zlGZ8C+tDuwTXnydiJL+4X4PwVEcM3pmQl6eSYDSyZC6CZo
         whkT1upUUDa2NpmYHxgN9lR0xKmCB5JsX4htzUiT/chQYtbB1TGedl3PqHXWnyOmSWGp
         rPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757376; x=1689349376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtT0/eZ+pzVcJ4kjv037r9aHK8XNjhCtUjr9Gr9jvYU=;
        b=F85Z3M4d5Gt3uNqbuxJVr2Y9xz7hMx09vRvk/Cw3Csc9L6RuXn2/emifXUp32cV8xW
         i0N7Er4ecba0gk+ynqS34hgqB+u+VkUBx3rt4JrMK4NzJIpp5ABW9coOz7u3fWTFVdgm
         EtyaGvkw5EFqbXUSrB14ZquYC082E7eSzTKnHLfZpyQqXlLYn9zs/aLW7aJQzZTLUdCo
         pi/3qX95ZkBYRp6S7lPobWyJY6GwUOoMOXv9xSh/CcvIvrQFB3t18kQn0X7Muh5NRSCY
         wPp/xRfH5E8SPGwjTaudQwLk2qQilzylTAwvMY6wXd4d+Kaw7hyNzrHQGxF59/olEGTC
         UOiw==
X-Gm-Message-State: AC+VfDyoaljjPKYhmaQMK8WPShJrttsIhFBG/i6Q+Rq6TvdrZyfuema6
        B712LXHQg1xAu2RduLvMQGdn+jDCHXXAP58pxBbBTA==
X-Google-Smtp-Source: ACHHUZ5MvmIC2GdVwJiGsq0XfnMom2QZJ/Olx8aWbiV58zzX/ROjObQVmYDJgQ/CvJ/oOynYK5NegYFewhrN1Ut0aiU=
X-Received: by 2002:a17:907:6d08:b0:978:992e:efc4 with SMTP id
 sa8-20020a1709076d0800b00978992eefc4mr14322051ejc.8.1686757376686; Wed, 14
 Jun 2023 08:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com>
 <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com> <ZIiMKgt6iQwJ6vCx@corigine.com>
In-Reply-To: <ZIiMKgt6iQwJ6vCx@corigine.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 14 Jun 2023 16:42:45 +0100
Message-ID: <CAN+4W8jTTQqz2Fgzz4AndzpEo=Xteqisv88HqQu=j_VPcu3OVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To:     Simon Horman <simon.horman@corigine.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 13, 2023 at 4:33=E2=80=AFPM Simon Horman <simon.horman@corigine=
.com> wrote:
> >
> > +INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
> > +                                       const __be32, const __u16,
> > +                                       const __be32, const __be16));
> > +
>
> Hi Lorenz,
>
> Would this be better placed in a header file?
> GCC complains that in udp.c this function is neither static nor
> has a prototype.

Hi Simon,

The problem is that I don't want to pull in udp.h in
inet_hashtables.c, but that is the natural place to define that
function. I was hoping the macro magic would solve the problem, but oh
well. How do you make gcc complain, and what is the full error
message?

Thanks
Lorenz
