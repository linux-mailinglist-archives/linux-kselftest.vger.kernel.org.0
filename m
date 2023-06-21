Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7F738151
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 13:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjFUKpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjFUKou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D882940;
        Wed, 21 Jun 2023 03:42:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4712164f8f.0;
        Wed, 21 Jun 2023 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344144; x=1689936144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHPRs1MqZty/wg+jsAp8zNvbtNVXPPRgzXINsE+kXQE=;
        b=VnQokrgk0Iz9SvTaDc2gkX6Q8kiSeFQ8t1Zj23M/ZpXDEe0wcD7e3XgktdBgYWzQ9S
         aTHwHLFyzbSytAA5biib1VzAujkwrkE1ycYsPdLd+CPGxaWZA/uOSnjpBRA2pKD6BVsy
         G+m21PABWd0HPHQwSRNeRao2Nx+wuhb3nyzsRS48W8oMHe8hN39hHj8a4Esolljzoz6c
         +cGQbdumgkD2+/kqkALU84zRSVwb+vPuhl6llQgwv9y6YfhDCJj0/Rpm8EFyZJfjeDiP
         5YvsHA4cmOdY1shmNu3eAroemfPyqcAcpK24gSh1JTNp+a16vWLSPJHilvnPXqqDoWk4
         dxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344144; x=1689936144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHPRs1MqZty/wg+jsAp8zNvbtNVXPPRgzXINsE+kXQE=;
        b=FPMlP7ESIf6aIVMQ5x5wKRzJnfJp0RdbrBZctrEsEMaiUsUPWkrySoT3vqvwakKNlQ
         IDAm7Tp8YvM+9rdX0tXpC6do/Z8NaiAiD5bU2rXzBhUUJOCfnhfqbSB30At2GLut7+XC
         NllY3mGRc27J4qwkZ1ytIyjgDH8JLELjsZNzKP4HKOH6WF24vgqY7ZV1TCh8OYb9wi+l
         c3NsIWoaU8pDIbPHB0qqRoFXpbHjR2Mb+si+9YNq/bXzx23WxBtHYodlGmNyliaC1q39
         P52qlplS4zjNKv2u4X59ExI7bOOD+4NEWkcFOLheQXgSXCg+ieJYUTqvhzs4s3i7c6Ih
         OaOQ==
X-Gm-Message-State: AC+VfDyltp6mQWYLwnByzU+VjAc4pkVkYum7D69o8Mj2qlN77CnzIkDf
        xHXY5LHq4ztyi5s3KrQP9Cg=
X-Google-Smtp-Source: ACHHUZ41rmI9icvhUGi3V9K0i3xcs8stBKVolWoPHEi8/fCvwoCpSDHnjdhISRHYWN0NSKA6kmdpTA==
X-Received: by 2002:adf:ee51:0:b0:311:1dfb:2907 with SMTP id w17-20020adfee51000000b003111dfb2907mr10024600wro.68.1687344143896;
        Wed, 21 Jun 2023 03:42:23 -0700 (PDT)
Received: from gsever-Latitude-7400.corp.proofpoint.com ([46.120.112.153])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm4121378wrv.40.2023.06.21.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:42:23 -0700 (PDT)
From:   Gilad Sever <gilad9366@gmail.com>
To:     dsahern@kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org, hawk@kernel.org, joe@wand.net.nz
Cc:     eyal.birger@gmail.com, shmulik.ladkani@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Gilad Sever <gilad9366@gmail.com>
Subject: [PATCH bpf,v6 2/4] bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
Date:   Wed, 21 Jun 2023 13:42:09 +0300
Message-Id: <20230621104211.301902-3-gilad9366@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621104211.301902-1-gilad9366@gmail.com>
References: <20230621104211.301902-1-gilad9366@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

skb->dev always exists in the tc flow. There is no need to use
bpf_skc_lookup(), bpf_sk_lookup() from this code path.

This change facilitates fixing the tc flow to be VRF aware.

Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Gilad Sever <gilad9366@gmail.com>
---
 net/core/filter.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 57d853460e12..e06547922edc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6730,8 +6730,12 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	return (unsigned long)bpf_skc_lookup(skb, tuple, len, IPPROTO_TCP,
-					     netns_id, flags);
+	struct net *caller_net = dev_net(skb->dev);
+	int ifindex = skb->dev->ifindex;
+
+	return (unsigned long)__bpf_skc_lookup(skb, tuple, len, caller_net,
+					       ifindex, IPPROTO_TCP, netns_id,
+					       flags);
 }
 
 static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
@@ -6749,8 +6753,12 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP,
-					    netns_id, flags);
+	struct net *caller_net = dev_net(skb->dev);
+	int ifindex = skb->dev->ifindex;
+
+	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
+					      ifindex, IPPROTO_TCP, netns_id,
+					      flags);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
@@ -6768,8 +6776,12 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP,
-					    netns_id, flags);
+	struct net *caller_net = dev_net(skb->dev);
+	int ifindex = skb->dev->ifindex;
+
+	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
+					      ifindex, IPPROTO_UDP, netns_id,
+					      flags);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
-- 
2.34.1

