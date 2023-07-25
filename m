Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388A76070E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 06:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGYEM1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 00:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGYEMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 00:12:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE501BD8
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 21:12:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40553466a08so23019851cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690258336; x=1690863136;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wj8PYguS3xX7U+0FfQZVAUdYXZWQu9LmjzUUJQ4wOaI=;
        b=Z+JlgAUmlufgtTYuk+mYrzEGas5EJaJzImxCjVFBr0dYFePL976yPBjEzGmVMzbUM9
         Dav85MBDgUkBe1I/XQTAiJ3spftEGcM0Zwyn6y2qqzq8aXoLHE/qwot4MSCmNGMD0Avk
         mn+2qt1+snQsKuRjtQDe1vXqIW+YKBFKoSH2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258336; x=1690863136;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj8PYguS3xX7U+0FfQZVAUdYXZWQu9LmjzUUJQ4wOaI=;
        b=Piub7qpkEaTuywoDHuFuANJVwBgoP/oI6m7sr6nh56FStnOoZMEeN+si4TOczSUNe2
         Cpp3CSyLugMCipyHsKf5Uj/udy2qxd39A1EhHLDuPMNBXhUrJ084DsU6ofWXlNyCRiX7
         2k+fN7IwO9aQVqAcxFw/J9N5e6PKxfoZXLmfJwdtkH6enZnRVzGxRLJVvqWvSjSzplLi
         hIdDI12kY+Byh8dfcDMZRkkznGv2kRx1kSmjjzglAwKkmxmGgF2cQDIC5RQGbrOwRcEV
         V4/SZRoE3eP+y5NZ6Mp5I7XhQPS8lKQuFU9TZxcirdfB4EvKYB0macQ/Qx4+8vvE6f2R
         MiBg==
X-Gm-Message-State: ABy/qLZ/CXXO64yGwMBpIBAMmxlnWiNoUeVkjtMI+gH3jHpQNLQBEZLL
        4mzjAwc1MkToWnCN8o0GrzS23w==
X-Google-Smtp-Source: APBJJlEVOq7ulnNKppzYNyvaq6SerEQ1z7zrZ+6KuSpVoj/yWFAkJz0SGawCVDfDIJnNqpi4LictQQ==
X-Received: by 2002:ac8:5914:0:b0:3fb:42cb:aa9 with SMTP id 20-20020ac85914000000b003fb42cb0aa9mr1930367qty.45.1690258336067;
        Mon, 24 Jul 2023 21:12:16 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id v18-20020ac87292000000b00400aa8592d1sm3779869qto.36.2023.07.24.21.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:12:15 -0700 (PDT)
Date:   Mon, 24 Jul 2023 21:12:12 -0700
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
        kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH v3 bpf 0/2] bpf: return proper error codes for lwt redirect
Message-ID: <cover.1690255889.git.yan@cloudflare.com>
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

v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/

changes since v2:
  * subject name changed
  * also covered redirect to ingress case
  * added selftests

changes since v1:
  * minor code style changes

Yan Zhai (2):
  bpf: fix skb_do_redirect return values
  bpf: selftests: add lwt redirect regression test cases

 net/core/filter.c                             |  12 +-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
 .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
 4 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

-- 
2.30.2

