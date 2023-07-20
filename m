Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0075B29F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGTPbD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGTPa5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 11:30:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71881273A
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992af8b3b1bso163609166b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689867045; x=1690471845;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLrofFXFKrbEUtT1d0pkNm+CngV/kgOBeV8t2d3zZXY=;
        b=Dgehf2MBQmy2b6PIrBeu3Y/Iqew31GTxhkwE/zy2hcb2ruecyEJFzVrnGKhG+yaccQ
         Yaly4VdpImLVw43BjqNy+gt5wU3r48dCnuAPkJVTiei+A/wWa1mwS3J9CDDfplZCBNkU
         Er4dFbWuBUJDs8mLv/w9mCJIvUsAcXkeV63CEsCh/Yaso0IVsi9sDXxiSmy95ZO0Ax45
         tE0dPVZ6fi2l4N+Sk8X1lxu24SXh3Wp1FES+1ykZ4D8Wxu1TN6C8y1vDxRgCIFEhH3xX
         9XMZHz/ZmzgMUvtD1BiGqa9vybT6XU9AJB4FjP7rRmUWdqRSSzax/nL8PfRS+YQpvkL6
         8I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867045; x=1690471845;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLrofFXFKrbEUtT1d0pkNm+CngV/kgOBeV8t2d3zZXY=;
        b=OvoH4H4bK57QDRsM7ADPmiHhDq/N3/Q3HY5Zl1mHrUAB9Dna4jebY6r66gs9wLm6u2
         O1hVDzCYosaTQim1ucggxDO0GiGokHDQ2pyCxAdL0KE9hM0s3Y2ofGqYMbVj/5m5jflV
         wmOiMTDBkSifgOLOTpSzUc2CyD88g0lZ7AkfWicWhwXeCCOqWdAH37DOzt32A9vtRJym
         OowqPkq6TrMgKCGzjUy16z6xzN05AW9s6OdDGmciUbYh8x3qhBLFpbPn5iYWP5vzE1hC
         pn3EwdSs8b3OvC1zHgmI9tADy+uacF7YReZC1LtLUx5ULZ4rOdddqvIIQqz+3wxfWfp0
         askA==
X-Gm-Message-State: ABy/qLaXWTIncdBCjLDRu2oTh9ZEjuNuXJ0ExRg4c2SApPvbaMa6wzvo
        i4YO1L/65TTUrmS3YZcykJz9mg==
X-Google-Smtp-Source: APBJJlHWH1U2EegISmcUbcT+YfPJwsNTtGymAlJvhuVaCOsFoBXwcdT9+t+q9lnbaE0jgbeXNaICaQ==
X-Received: by 2002:a17:907:d0a:b0:993:22a2:8158 with SMTP id gn10-20020a1709070d0a00b0099322a28158mr7363662ejc.61.1689867044845;
        Thu, 20 Jul 2023 08:30:44 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7176000b788d2ebe49c4b82.dip0.t-ipconnect.de. [2003:c1:c717:6000:b788:d2eb:e49c:4b82])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm851007ejw.225.2023.07.20.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:30:44 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v6 0/8] Add SO_REUSEPORT support for TC
 bpf_sk_assign
Date:   Thu, 20 Jul 2023 17:30:04 +0200
Message-Id: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxSuWQC/33OQQ7CIBAF0KsY1mIQKIgr72FcMDi1JAoNVFJje
 nexK2OaLid/5v15k4zJYybHzZskLD77GOqgthviOhtuSP21zoQzLpjaC5ojTfjM2Mc0UDTcNVz
 ttUAk9QRsRgrJBtd9j353v3GfsPXj3HYm0Lc04DiQS006n4eYXvMbhc/5cmPhlFHQThkrZG0WJ
 59jsXcMw87Fx4wVsQaIChimQToADcYsAXINkBWQ6FArzQ4Adglo1oCmAq1SB2XZFRyyf2Capg9
 eqJYrmAEAAA==
To:     "David S. Miller" <davem@davemloft.net>,
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
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>,
        Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We want to replace iptables TPROXY with a BPF program at TC ingress.
To make this work in all cases we need to assign a SO_REUSEPORT socket
to an skb, which is currently prohibited. This series adds support for
such sockets to bpf_sk_assing.

I did some refactoring to cut down on the amount of duplicate code. The
key to this is to use INDIRECT_CALL in the reuseport helpers. To show
that this approach is not just beneficial to TC sk_assign I removed
duplicate code for bpf_sk_lookup as well.

Joint work with Daniel Borkmann.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v6:
- Reject unhashed UDP sockets in bpf_sk_assign to avoid ref leak
- Link to v5: https://lore.kernel.org/r/20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com

Changes in v5:
- Drop reuse_sk == sk check in inet[6]_steal_stock (Kuniyuki)
- Link to v4: https://lore.kernel.org/r/20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com

Changes in v4:
- WARN_ON_ONCE if reuseport socket is refcounted (Kuniyuki)
- Use inet[6]_ehashfn_t to shorten function declarations (Kuniyuki)
- Shuffle documentation patch around (Kuniyuki)
- Update commit message to explain why IPv6 needs EXPORT_SYMBOL
- Link to v3: https://lore.kernel.org/r/20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com

Changes in v3:
- Fix warning re udp_ehashfn and udp6_ehashfn (Simon)
- Return higher scoring connected UDP reuseport sockets (Kuniyuki)
- Fix ipv6 module builds
- Link to v2: https://lore.kernel.org/r/20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com

Changes in v2:
- Correct commit abbrev length (Kuniyuki)
- Reduce duplication (Kuniyuki)
- Add checks on sk_state (Martin)
- Split exporting inet[6]_lookup_reuseport into separate patch (Eric)

---
Daniel Borkmann (1):
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper

Lorenz Bauer (7):
      udp: re-score reuseport groups when connected sockets are present
      bpf: reject unhashed sockets in bpf_sk_assign
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

 include/net/inet6_hashtables.h                     |  81 ++++++++-
 include/net/inet_hashtables.h                      |  74 +++++++-
 include/net/sock.h                                 |   7 +-
 include/uapi/linux/bpf.h                           |   3 -
 net/core/filter.c                                  |   4 +-
 net/ipv4/inet_hashtables.c                         |  68 ++++---
 net/ipv4/udp.c                                     |  88 ++++-----
 net/ipv6/inet6_hashtables.c                        |  71 +++++---
 net/ipv6/udp.c                                     |  98 ++++------
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 13 files changed, 660 insertions(+), 179 deletions(-)
---
base-commit: 6f5a630d7c57cd79b1f526a95e757311e32d41e5
change-id: 20230613-so-reuseport-e92c526173ee

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

