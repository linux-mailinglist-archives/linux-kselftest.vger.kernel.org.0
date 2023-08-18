Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226B0780FF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378416AbjHRQLF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 12:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378490AbjHRQK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 12:10:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170A3AB6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 09:10:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso1325876a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692375056; x=1692979856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41qfF2rDjgnUSHUgG2/XWiGlbnndu7FcBrWK0wJOx5U=;
        b=sgLdpzWSEW85aFWZ9IqWqrtx8unXK7p+EIt+qUbpbcwLTvDO1gRQoTnYViNN4Kbujm
         tIQZBoQyvovRHDImY2vPhDXpYLXrlelJ1NlOQFOyL1z0M/ZgcTHLqt5T2cxhGPWE6HQ6
         V/Or1Lnr6/8xGkXFqbKyXP+Vn8YwRPBHCXeNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375056; x=1692979856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41qfF2rDjgnUSHUgG2/XWiGlbnndu7FcBrWK0wJOx5U=;
        b=iiWsi9JJswYG9HHyqw9xmges8iWkAm7fV45Lb+864Jye8NCEAUJ8vJPDD76VDST+KI
         gyi6l6fig8QcfTelev04CyBvWQ4/zlGCwbzPBA03xZrRSXrRuNLMr8hCPCZDyhbeJ6FY
         9/+SrbfYHmIqj4yR9aEBzH7ZYN8dod8ksdJkcqgQYuxP0X7QNOvVwI9wjzcbTOQavxfK
         Xst0TOoTOYLMgawAwO9g7ZiV/Uswhy1GV+jzTAOaOtiE7E6DseHRH/NoLaAZRv+UMQTl
         KQm2BCyzHZtpswBnNBVREAFFont7RvunLfwcrX4EOqGvZV2YU4ToQ16wVNbZ1S1HqDQ3
         +R8A==
X-Gm-Message-State: AOJu0YyjREBCH+/pm2iyC4rHtanlOqkkg4za2fzroFcvM0t0PklRntxo
        kIBwjKprhvz7z/lMbRRGeycgxA3yn0hqcg/cvZhwTQ==
X-Google-Smtp-Source: AGHT+IEw2PzKZbmQLG51l1VNKzmJafq1ZnLchM0x2UwO8LQRZoqpGzbStf5i0pqWiTK3I22RJEhUrZ2ko3iSngM0WI8=
X-Received: by 2002:a05:6402:7c1:b0:523:22f6:e8a5 with SMTP id
 u1-20020a05640207c100b0052322f6e8a5mr2087451edy.39.1692375055993; Fri, 18 Aug
 2023 09:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692326837.git.yan@cloudflare.com> <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
 <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com> <61e79414-9290-736f-6a50-dfe1585dc2a7@iogearbox.net>
In-Reply-To: <61e79414-9290-736f-6a50-dfe1585dc2a7@iogearbox.net>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 18 Aug 2023 11:10:45 -0500
Message-ID: <CAO3-PbovC6Dd6B_OO6zSX8gd3NrtpfF0t1pYH1Obi3VoikY0KQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 11:08=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/18/23 6:01 PM, Yan Zhai wrote:
> > On Fri, Aug 18, 2023 at 9:55=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> On 8/18/23 4:58 AM, Yan Zhai wrote:
> >>> lwt xmit hook does not expect positive return values in function
> >>> ip_finish_output2 and ip6_finish_output. However, BPF programs can
> >>> directly return positive statuses such like NET_XMIT_DROP, NET_RX_DRO=
P,
> >>> and etc to the caller. Such return values would make the kernel conti=
nue
> >>> processing already freed skbs and eventually panic.
> >>>
> >>> This set fixes the return values from BPF ops to unexpected continue
> >>> processing, checks strictly on the correct continue condition for
> >>> future proof. In addition, add missing selftests for BPF redirect
> >>> and reroute cases for BPF-CI.
> >>>
> >>> v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.c=
om/
> >>> v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> >>> v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.c=
om/
> >>> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> >>> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> >>>
> >>> changes since v5:
> >>>    * fix BPF-CI failures due to missing config and busybox ping issue
> >>
> >> Series looks good, thanks! Given we're fairly close to merge window an=
d
> >> this has been broken for quite some time, I took this into bpf-next.
> >>
> > Thanks Daniel! Can you also queue this up for stable (or guide how I ca=
n do it)?
>
> Given the Fixes tags, it will be picked up automatically once it lands in
> Linus' tree.
>
Wonderful. Thank you!

> Thanks,
> Daniel
