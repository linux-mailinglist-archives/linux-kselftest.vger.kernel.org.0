Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F322740DFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjF1Jw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjF1JuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:50:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2912119
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso31213465e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945716; x=1690537716;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FP6EIORZPJxzFsIqvOxDq19SJKXWVqMsImue+SKUFg8=;
        b=XsjxTyPkJ3bOYJQSpzHK71Ql/BG/qCVbF4SB/59ookNrppeeken42JlBoGr5NHXNIh
         z5IbxM+mlAVvX+9Zundma7f7rcvVCCcbEuFkhhOuF371COKodPCbgnyvza8yDvStMuIs
         cY2wVRlR0PGT0lTJF+lBmQbSBJDngLEdidJa888k6igCPGkx3KhX+byDoZneoELdMQTS
         EF8B74wwJTrdqRVRX+v5KmlY0xBEfeYc72B1CHnJLEES+EmAIPTcnpm9I0R9hg94sBWZ
         2i/kux9PGuhd/MDx93JduKCKm+pQIutwlEXMrmSwoALEysgTm/Zma6x57ASw6zwUbx6B
         6Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945716; x=1690537716;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP6EIORZPJxzFsIqvOxDq19SJKXWVqMsImue+SKUFg8=;
        b=ThK4YDqUVWVhqxt2fQe+9SF2RY+V19wESf5xjrzcSQushC1J/Zce+HDMGAqypqu7Lb
         wtlGc3D5npbsXjvsMUCEh6swZ9djQQTazchXtJkuusD2gD5cmSGnWy+saF47+r4kKC8r
         DEEni+XAzeRIWpfVoYgkrN7caOR3ZnvtCh4xrJUvVnu6+n2LVk46ijoeKbeOMVsXJf6E
         LQYy+sxYnYhZlxv/l2tIHCII0eFuqv5EID5NOp27fqzLYiSQk7aPt1HfJoaiXZMOPrjO
         D0rGLHuwAIPMRPTipuTFlNLk+RIWMNG710Sf2u7zPKZRo4akF+qGdvbT1U80e8vxqobh
         T7fw==
X-Gm-Message-State: AC+VfDyhUZweCq7ZFoasST1BNZYXWIbOGXZNTdWCIWM4ZHKgGWAg3o2G
        BPFCXM9xPhDsAqvefgfWBzKj+g==
X-Google-Smtp-Source: ACHHUZ7wPIusenCR7v9NN3XspUt/PsXwcRvhGF4plXfCXn9cqoUqOXtN00e6OOtxQAfdg+FxvGhXgQ==
X-Received: by 2002:a7b:c017:0:b0:3f5:ffe3:46a7 with SMTP id c23-20020a7bc017000000b003f5ffe346a7mr24250845wmb.9.1687945716240;
        Wed, 28 Jun 2023 02:48:36 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:36 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v4 0/7] Add SO_REUSEPORT support for TC
 bpf_sk_assign
Date:   Wed, 28 Jun 2023 10:48:15 +0100
Message-Id: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8BnGQC/32OQQ7CIBBFr9KwFkOhluDKexgXDE4tiUIDSGqa3
 l3Kyhjj8ufNf38WEjFYjOTYLCRgttF6V0K3a4gZtbshtdeSCWdcsL4VNHoa8Blx8iFRVNwceN9
 KgUhKBXRECkE7M26lz9sNTwEHO9e1M4FpoA7nRC6FjDYmH171jcwr/72YOWUUpOmVFl1ZFicbf
 dZ3dGlv/KPKsvgnEEWgmITOAEhQ6luwrusbyAOISBYBAAA=
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
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Lorenz Bauer (6):
      udp: re-score reuseport groups when connected sockets are present
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

 include/net/inet6_hashtables.h                     |  81 ++++++++-
 include/net/inet_hashtables.h                      |  74 +++++++-
 include/net/sock.h                                 |   7 +-
 include/uapi/linux/bpf.h                           |   3 -
 net/core/filter.c                                  |   2 -
 net/ipv4/inet_hashtables.c                         |  67 ++++---
 net/ipv4/udp.c                                     |  88 ++++-----
 net/ipv6/inet6_hashtables.c                        |  70 +++++---
 net/ipv6/udp.c                                     |  98 ++++------
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 13 files changed, 656 insertions(+), 179 deletions(-)
---
base-commit: 970308a7b544fa1c7ee98a2721faba3765be8dd8
change-id: 20230613-so-reuseport-e92c526173ee

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

