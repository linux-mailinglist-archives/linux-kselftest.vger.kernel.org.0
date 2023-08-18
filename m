Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4753780402
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 04:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbjHRC61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357340AbjHRC6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 22:58:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127D2698
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407ff54164dso3431211cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692327491; x=1692932291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USI75m3o9913jLduDnux9TyqJuP1aOQC3kWrDolYXiI=;
        b=hGonSGAnNEu4PNUFh9oLEr6YIiZQRdqQBcMq5Gneqf9avC86i+dWuZR3/EmNPbUlSr
         rOpBTRPpzBEgdjOsHlSjUP5+3ruR98DL42+BPmum0xa1Xv/vTiUHCvEyeZinlHlIlFxx
         ZBjt87cnX9lGXtj1dk47cG3y2yM25guJIFSTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327491; x=1692932291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USI75m3o9913jLduDnux9TyqJuP1aOQC3kWrDolYXiI=;
        b=kyzW6wAFZ+kxEHY6FfCilhjVRQxEc8+xnXsL0xVHlL/mUr7Dqwv7lu0RyvZ8ffwDaw
         Z7PftXKHdFqflCIloPvhXJADSuMGUMMHvE2hD6zb7BRvcP/sj69rXC25AhpfjG8SsYf8
         A5vNfXsjLsovYi1fqlun2HAs7lZ1kZJqZECH4ULhyEn4CjAX6AYXAb892EqOv37vLwmm
         IGVRbcZhiWJAX8tdo+MBACyK9Fb/8d0Cb01cHd08tsoD+sOicWHn7wfcA7q2EtgwTHQq
         B+ba7aAinC8mZnaiX3Ygj426+J4Eel+xwx8HpAXclPdvYq2IWNzVw+ItnSvLgp2M1ILk
         KNFQ==
X-Gm-Message-State: AOJu0Yy45XKfHiACn9evtDPzF1vFuOxQAjcS6zLmUV1qkqNX/ew7+xxk
        5e6lNUDWYr1Syff5vVHyGhcUhw==
X-Google-Smtp-Source: AGHT+IFl/FzdHp0SEjIbm5LtZ1Y7zEZh+XmJH76j4McfsP6Qu5b5bJuZ5unpVnZrN8vPsm8hfynOdg==
X-Received: by 2002:ac8:5b43:0:b0:40f:4cfd:7158 with SMTP id n3-20020ac85b43000000b0040f4cfd7158mr1921453qtw.27.1692327491415;
        Thu, 17 Aug 2023 19:58:11 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id z4-20020a05622a124400b00403c82c609asm268339qtx.14.2023.08.17.19.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:58:10 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:58:09 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
Message-ID: <cover.1692326837.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

lwt xmit hook does not expect positive return values in function
ip_finish_output2 and ip6_finish_output. However, BPF programs can
directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
and etc to the caller. Such return values would make the kernel continue
processing already freed skbs and eventually panic.

This set fixes the return values from BPF ops to unexpected continue
processing, checks strictly on the correct continue condition for
future proof. In addition, add missing selftests for BPF redirect
and reroute cases for BPF-CI.

v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.com/ 
v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/ 
v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/ 
v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/ 

changes since v5:
 * fix BPF-CI failures due to missing config and busybox ping issue

changes since v4:
 * fixed same error on BPF_REROUTE path
 * re-implemented selftests under BPF-CI requirement

changes since v3:
 * minor change in commit message and changelogs
 * tested by Jakub Sitnicki

changes since v2:
 * subject name changed
 * also covered redirect to ingress case
 * added selftests

changes since v1:
 * minor code style changes

Yan Zhai (4):
  lwt: fix return values of BPF xmit ops
  lwt: check LWTUNNEL_XMIT_CONTINUE strictly
  selftests/bpf: add lwt_xmit tests for BPF_REDIRECT
  selftests/bpf: add lwt_xmit tests for BPF_REROUTE

 include/net/lwtunnel.h                        |   5 +-
 net/core/lwt_bpf.c                            |   7 +-
 net/ipv4/ip_output.c                          |   2 +-
 net/ipv6/ip6_output.c                         |   2 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 139 ++++++++
 .../selftests/bpf/prog_tests/lwt_redirect.c   | 330 ++++++++++++++++++
 .../selftests/bpf/prog_tests/lwt_reroute.c    | 262 ++++++++++++++
 .../selftests/bpf/progs/test_lwt_redirect.c   |  90 +++++
 .../selftests/bpf/progs/test_lwt_reroute.c    |  36 ++
 10 files changed, 868 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c

-- 
2.30.2


