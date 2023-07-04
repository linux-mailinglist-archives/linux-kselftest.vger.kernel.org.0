Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D774731F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDNqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGDNqr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 09:46:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A3E7E
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 06:46:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so54521135e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688478403; x=1691070403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+vl3t8RodtYbx2eQenih8tBnL7SBRBNpLzdp8LByFg=;
        b=ZdTIfeIEGLzfxSzuPxM3gievbQxmAD7AOJh+4V0KmaEVlKTsTINx4tA9s/WiHt75oH
         Ysk2Jxn4aS6F1qNcsceP6OlPbIWqWq1cYGfeTYT3FVi+PzU+urOyT34r+mFSoDIsFSwq
         CaMEnop/92p4QIhVmSKmvPPTkNNPQD+15TkgV2sd4v4xDbd4wNCt43cxsIplloS4dRt+
         J19nbZ/ogUBLILqL5qxJ3mTIMKwsCqrQywMB/ereToHiFigCTmgdgSrEAGkw8Rb51RMD
         VzHUJOtIyDC8Bt4i4+HiF93ZDS/GWleXSin0tjVwLXB+L8zVmnc4i3Lo1gFXFaNLLNpd
         sh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478403; x=1691070403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+vl3t8RodtYbx2eQenih8tBnL7SBRBNpLzdp8LByFg=;
        b=TauOfkr/i75tNMH6nGjdprElg6hNbU310oKTIwLeIT1XXIMxmHLstG1EBz23lojDPU
         Zg67IpJNlFLPGcJTzB+e9Ce9hU4VkLbwHqlJJuGgzbqdA6qtUGgIjRAtrB45nd1Q926c
         nqXyd8DBSEhzEJ/BBe8EBFMa42thrUCPkXUk/BmtV0f4qFqw4orujbPMGgtR1JgTzyT+
         aDAt9au0XhshtkjepWUHMaraAndDxTqtCx2vFCeU2D6Q7gH5X/hrzpDesDzLhwYwBuA9
         9yQAi7ANmbdRdUeaGHT5uLxgep8wGPEQE3jkjC4gtIurAABXLOTy/ElcH0cMjeFIfr5K
         M/YQ==
X-Gm-Message-State: AC+VfDzcSuh60SAJDgN6pajCvS8t5FpoDlJ0enOUyUn2noDs1EjLcGNY
        3VKhK3d1nDXp6Po79ms9TlWw6TvJoab9JoxZlNisUg==
X-Google-Smtp-Source: ACHHUZ7PgGMmvr4itGjLn3YE1UNMhepT0HQpN31fTTcglq7hAEcViziaB9Q0tBrjfhtSbZLbeSbirQ==
X-Received: by 2002:a7b:c7d9:0:b0:3fb:c1df:a4fe with SMTP id z25-20020a7bc7d9000000b003fbc1dfa4femr10599757wmk.12.1688478403076;
        Tue, 04 Jul 2023 06:46:43 -0700 (PDT)
Received: from [192.168.133.175] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm9274680wrt.37.2023.07.04.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:46:42 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 04 Jul 2023 14:46:23 +0100
Subject: [PATCH bpf-next v5 1/7] udp: re-score reuseport groups when
 connected sockets are present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v5-1-f6686a0dbce0@isovalent.com>
References: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
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
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
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

Contrary to TCP, UDP reuseport groups can contain TCP_ESTABLISHED
sockets. To support these properly we remember whether a group has
a connected socket and skip the fast reuseport early-return. In
effect we continue scoring all reuseport sockets and then choose the
one with the highest score.

The current code fails to re-calculate the score for the result of
lookup_reuseport. According to Kuniyuki Iwashima:

    1) SO_INCOMING_CPU is set
       -> selected sk might have +1 score

    2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
       -> selected sk will have more than 8

  Using the old score could trigger more lookups depending on the
  order that sockets are created.

    sk -> sk (SO_INCOMING_CPU) -> sk (ESTABLISHED)
    |     |
    `-> select the next SO_INCOMING_CPU sk
          |
          `-> select itself (We should save this lookup)

Fixes: efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/udp.c | 20 +++++++++++++++-----
 net/ipv6/udp.c | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..c62d5e1c6675 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -451,14 +451,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(result, net, saddr, sport,
+						daddr, hnum, dif, sdif);
+
 		}
 	}
 	return result;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 317b01c9bc39..dca8bec2eeb1 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -193,14 +193,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(sk, net, saddr, sport,
+						daddr, hnum, dif, sdif);
 		}
 	}
 	return result;

-- 
2.40.1

