Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1140A76C048
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjHAWSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjHAWSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 18:18:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEDE57
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 15:18:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso8028101a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Aug 2023 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690928327; x=1691533127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPseTy7IzinUQZpPzP36aZrRMGJ435Us12Gys3Nc6zk=;
        b=oWRJ4PZkbCJ2ey++KZdiAfsp6lEM0ajwDZWvbZ2+wZ4pZdXAocuW8kuVFjO3dnKtnf
         8lzUDjsfEiq9ZGq+SNVu1I1PVaPvDvJ+ZeGXNk6rd9FVxoAV+2Y1PfIgtto1waRbirIz
         66lQccpXqqqoVxMDXlAsWc7hkQOt7OkpsWcx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928327; x=1691533127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPseTy7IzinUQZpPzP36aZrRMGJ435Us12Gys3Nc6zk=;
        b=SohzTq5KmNTdyQpX3EgNdcThwrjq2rZoyx2j0REoe9MLnjOIAuZR3WfTLgO1ijWrsz
         eZ0TKDCvEvjeQjBEle534j3QNVopW3gtACuIU3Vd/qChbV0G8PQAl28EOLteCMvze20h
         KAfJaTkGT4lRGkebHZBOyiRA+XlUhFXZwQZdEBJwmbVF+uXvloYp8J3CtZ5B8rVX+o3y
         7v5P8MFUJGHiy1vHbVFCQL5IachkYhD5qm56ZRI7qUqYrfyjxr2xshwWQnfDvUlOGqJz
         wOjSQHrcb4YxxLMYFznQvhKUF5Ui1NwadTBfZRgdoamTCksmIRPbuRMAnQlaERKP4JIS
         Mf+A==
X-Gm-Message-State: ABy/qLZ/kdV4qxEZ/OFgzfx/IQALIdB1Osg4p5RMdGVUM6bCvvcJhvyD
        5a6YZd7L4253Ra+GmO5DkAnQHa9KY+DSBSBY+bUcww==
X-Google-Smtp-Source: APBJJlF6hKrUdco2WhtqBq/dd/fptQdjNbrXp5Xp8ffyLBxvo4Hhe4gPknw50y7nZFOKqOmpsbN//GRQckBdVERYlwc=
X-Received: by 2002:a05:6402:125a:b0:51d:e30b:f33a with SMTP id
 l26-20020a056402125a00b0051de30bf33amr3473017edw.34.1690928327002; Tue, 01
 Aug 2023 15:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690332693.git.yan@cloudflare.com> <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain> <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain> <ZMFFbChK/66/8XZd@debian.debian>
 <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain> <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
In-Reply-To: <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Tue, 1 Aug 2023 17:18:36 -0500
Message-ID: <CAO3-Pbpx8vmC_-o59s61mU=TzYLb+VpZ2qk+QhTMjVM6jf=71g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 9:26=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> I'm not a networking person, but I was looking at some use after free
> static checker warnings.

Did you refer to the gist I posted or something new?

>
> Apparently the rule with xmit functions is that if they return a value
> > 15 then that means the skb was not freed.  Otherwise it's supposed to
> be freed.  So like NETDEV_TX_BUSY is 0x10 so it's not freed.
>
> This is checked with using the dev_xmit_complete() function.  So I feel
> like it would make sense for LWTUNNEL_XMIT_CONTINUE to return higher
> than 15.

Yes I am adopting your suggestion in v5. Dealing with NETDEV_TX_BUSY
would be left as another item (potentially more suited for netdev
rather than bpf). Would be great to find a reproduction of memleak.

>
> Because that's the bug right?  The original code was assuming that
> everything besides LWTUNNEL_XMIT_DONE was freed.
>
> regards,
> dan carpenter
>


--=20

Yan
