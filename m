Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0E7619B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGYNVH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGYNVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:21:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4791FFA
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9939fbb7191so1165926466b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=avOtOUW+Cj7SR0Q9peI/1FD6B3M1N5Hr+fpAclHpm7L8hzrxsUoV1RTF4m5DA/Dq6a
         YJrqZXEXN7nHdcOkn45MQip/pZDwfl59O6sLsgxXu550emMbxOb105bU8WmyRsMyqKeR
         DiZpVUvn/srF5U00xeHXv3iBuwmiPGmWrnWb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=NomMz0eZoV16/r2ZxpGx0hGeYGM+uzz40Coaq8xzgt2+SYKNBFoaiigkga+VAuA06G
         fvYID/uwSqS4sDUGo6XteM4bNmtKuxxyNx2MHT1MBFLiUN3xc6XK+C2GsOT/B+BZbtqQ
         S62eG7BRJFkgtzrp8MW6CREAOJiV6HojC3Weri60+WAPBzLtAb78CFDGa28yFgDDeLSk
         UhZgOoCR6osCJJ0MesN2b3HRSCMHbqNsxXMBDc5XHhB4LQgz8j/+Bp6qDwCFWaTdaNhs
         Oe3k9rSMT3SHASpXfey1capS/it6tWOSq7DiDvJK5R5l8jCKueG8UPnJ4Rd5K8KKYfmt
         pN4Q==
X-Gm-Message-State: ABy/qLaEW8MRPTC7MSYUr054EHA9gRZzOVWGFo2ktSXwbkIxqZXkIHUS
        eKtcDdznsD0z34pIJyJpxwjS8w==
X-Google-Smtp-Source: APBJJlH+qEf1EkwtzcMEpjPEgMFdKkhYpww/2/CnlXcjZ72gg/UoQUeciPbGIm5RrLkuaIIGMvU/lQ==
X-Received: by 2002:a17:907:2c4f:b0:993:d632:2c3 with SMTP id hf15-20020a1709072c4f00b00993d63202c3mr2315057ejc.21.1690291256910;
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906254100b00992076f4a01sm8117208ejb.190.2023.07.25.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yan Zhai <yan@cloudflare.com>
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
        linux-kselftest@vger.kernel.org,
        Jordan Griege <jgriege@cloudflare.com>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH v3 bpf 0/2] bpf: return proper error codes for lwt redirect
Date:   Tue, 25 Jul 2023 15:20:06 +0200
In-reply-to: <cover.1690255889.git.yan@cloudflare.com>
Message-ID: <87mszkxh3c.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 09:12 PM -07, Yan Zhai wrote:
> lwt xmit hook does not expect positive return values in function
> ip_finish_output2 and ip6_finish_output2. However, BPF redirect programs
> can return positive values such like NET_XMIT_DROP, NET_RX_DROP, and etc
> as errors. Such return values can panic the kernel unexpectedly:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> This patch fixes the return values from BPF redirect, so the error
> handling would be consistent at xmit hook. It also adds a few test cases
> to prevent future regressions.
>
> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
>
> changes since v2:
>   * subject name changed
>   * also covered redirect to ingress case
>   * added selftests
>
> changes since v1:
>   * minor code style changes
>
> Yan Zhai (2):
>   bpf: fix skb_do_redirect return values
>   bpf: selftests: add lwt redirect regression test cases
>
>  net/core/filter.c                             |  12 +-
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
>  .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
>  4 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
>  create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

For the series:

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
