Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B97627F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGZBHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 21:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGZBHK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 21:07:10 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66D2137
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 18:07:09 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-447576e24e1so43775137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690333628; x=1690938428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdwBWxmoC8jWTGG50vXsFsrbHYhobVYe8zMui4535MQ=;
        b=XA63LcB9VKrUs3pNggkpMfJamzRch4vGpdmmh6PwlAH3APOY7XGBx0fy8etlhxP1lz
         Q52+dLUQNIc/9qZ06aIc2H1T3NnY9UtzyAXLAl/zzzu6XeiBtdBEhggxvBYqcUs3hDPe
         0oaywFZ21cnoBDtVPm9np78YHPOHUZk+HDBO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333628; x=1690938428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdwBWxmoC8jWTGG50vXsFsrbHYhobVYe8zMui4535MQ=;
        b=aCXE6SgAzlCHtfqcUYGAMX2pq2h1iFwrMLjA2so/v2bxlQqgnpO2T374wpE/Q/yHL3
         GCzDn7v2kF1rSW/19FP6g8AtnC+JDjmgQbxwtlUaBXFdHvA8enXAk3ciMLmYAAb49Jbk
         kPB1toLQdFXGMfhxsS1u2uFLLy5YzXEzJlA7LFyl0n/t4/KQb19Gz7xPRWQ3NbwDVc67
         oOR4voD9i48kSglVvh4SN5L9dCcPLSY5uFd+Bm1aH4AT5FSovnRQqPtjdUhg5UMr2E/i
         mmvgwus9et77II6/HxX/Xg9sbY1kuWdsL6NEt26i0OP/7Rk5jIFFDvLPNPOWSzaCMrHt
         Raqw==
X-Gm-Message-State: ABy/qLZqD7dRPXAUA/e9E7QlKd8jY5Qs8u4M/QmZPKIKIrMj1aj+kbTF
        IFdkIfzsdQgW79JirgP8jcBFgA==
X-Google-Smtp-Source: APBJJlHg6hZeDGvlQaspCRybUMZ7BXtzCybEQyrhLiY03Jvht5I5Hk0u379XAnTpp5OJ3bfjj12Jsg==
X-Received: by 2002:a05:6102:282e:b0:443:7572:598b with SMTP id ba14-20020a056102282e00b004437572598bmr275284vsb.13.1690333627937;
        Tue, 25 Jul 2023 18:07:07 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e7-20020a0ce3c7000000b0063757aea986sm4710610qvl.28.2023.07.25.18.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:07:07 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:07:04 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH v4 bpf 0/2] bpf: return proper error codes for lwt redirect
Message-ID: <cover.1690332693.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

lwt xmit hook does not expect positive return values in function
ip_finish_output2 and ip6_finish_output2. However, BPF redirect programs
can return positive values such like NET_XMIT_DROP, NET_RX_DROP, and etc
as errors. Such return values can panic the kernel unexpectedly:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

This patch fixes the return values from BPF redirect, so the error
handling would be consistent at xmit hook. It also adds a few test cases
to prevent future regressions.

v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/ 
v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/

changes since v3:
  * minor change in commit message and changelogs
  * tested by Jakub Sitnicki

changes since v2:
  * subject name changed
  * also covered redirect to ingress case
  * added selftests

changes since v1:
  * minor code style changes

Yan Zhai (2):
  bpf: fix skb_do_redirect return values
  bpf: selftests: add lwt redirect regression test cases

 include/linux/netdevice.h                     |   2 +
 net/core/filter.c                             |   9 +-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_lwt_redirect.c   |  66 +++++++
 .../selftests/bpf/test_lwt_redirect.sh        | 174 ++++++++++++++++++
 5 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

-- 
2.30.2

