Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA33D73E2CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFZPJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZPJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 11:09:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A18130
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-312863a983fso3939129f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687792153; x=1690384153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFcQRDCnPx+ynCpnF2uFrs+TLwer8UbpK1ON+IZqGjg=;
        b=Bdh0fSQLic8GK24HDf3N/rYsDXp0g5q1AXTN6FF2vyHtYHXt1iEdesUewz6eGR40Ed
         9QFHTXPmVxvxWjLFJO4riKrSrGvBsSy2Rw4MrLgYCTc4GuDKvtSZ6Jr2jYH44BwP0ewD
         uuQ3mh+NJQGkk5OyGdPSCiECAmJMPo8d7YoAn5GsINQN0VYx0iU7dxh2Qwtb8vP6LCQh
         VZ195sjvz5hSuhSGswffFJdVCftH2DnZi/geebX3tQSNCyZvJKPwaaqfGWBjf3TZ2HUt
         JLbVUSEEJSj0wLm3Ww9IwuENK+ch0qGYbRN3NC7ULa2rmv8kfwWEIdnxDcYrkXzx416g
         AmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792153; x=1690384153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFcQRDCnPx+ynCpnF2uFrs+TLwer8UbpK1ON+IZqGjg=;
        b=LD+ipUyUI29VbSieE2gucw3yba9fz8lacRE5sT7C3TJfuXx9T+DTfdetnv0QA6k+jm
         l2YIzOqR8CVjfDk44I/olnmb6V6vTCPIN6gHNTYQHInHx5eDvvL3ECQlfU8v3GCZntoA
         7yGiCAb8nsVvuod3cIWkQ8r0KYv4+90G+qwkI/0DRnk02bVZZfmYnRYX6w3CEjECccr5
         KSFJVSyHyn9zdvC6/wH06PFWPofXbPIyxFT10Az2V45w3rcsG6soRByXRlZUlpvPqH90
         ICfUkX3OoxoAMfwjyUmaR6KaT5oRbc9cGzmiM4PYMRpIcrWa9H7GR2ASaDT3WJ6yp5XN
         g8KQ==
X-Gm-Message-State: AC+VfDyIahTWzLizzl3/0tDCeNE0C4W2UJvVBuWj4lg3cftAmuZgIoRp
        F/WLxG1X9rI6OuchKPB2w0oiEA==
X-Google-Smtp-Source: ACHHUZ4tGG8fHK6H7JRwd23ypMKZA5H9umKPvcqfyKGjq7sH0yQK3kam6nswRSMg68RE5TI41cFW6A==
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id x3-20020adfec03000000b0030636ef2e3bmr22381550wrn.70.1687792153406;
        Mon, 26 Jun 2023 08:09:13 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b00311299df211sm7668710wri.77.2023.06.26.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:13 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 26 Jun 2023 16:08:58 +0100
Subject: [PATCH bpf-next v3 1/7] udp: re-score reuseport groups when
 connected sockets are present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v3-1-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/udp.c | 20 +++++++++++++++-----
 net/ipv6/udp.c | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fd3dae081f3a..5ef478d2c408 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -450,14 +450,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
index e5a337e6b970..8b3cb1d7da7c 100644
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

