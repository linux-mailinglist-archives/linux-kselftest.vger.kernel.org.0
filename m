Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDD73801E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFUKpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjFUKot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364EF198B;
        Wed, 21 Jun 2023 03:42:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so3700625f8f.0;
        Wed, 21 Jun 2023 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344141; x=1689936141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nniAcfc0pGJ2zeNQrhfgwRlH/v4XnVj4PMgap0ZSAzk=;
        b=c0Z6AfIsG54HC2i1LoSJitGgCkhcKqPsuCL/Pmav4WvhJ1D2FtRPw6/VYODGF/Zrwm
         /eDbSnSrSaeCveqALY4s7mUGpYSIkKolZSI7UPo7ojov8CjRLr7ERJTzjBtlxJgslItd
         C580UUgFbp/nuDaV7zG3K0x19x+mOiuOyzWgD3/e4oRlcIyglXnMXcbKC6v2KZ9iCGXs
         6V3T3M85HH7WiTKFirxkdRfnmxfnSPrOZYIholz5ThWJ85ortUwEESSf1YXwQn33OxOS
         gmyJ9nTwLKYGOCxkWGHMh3MhtEJnBZ+R2kTJYXZDJM2j1KBEmjfDlptpRUKkWbgj1cgL
         hjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344141; x=1689936141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nniAcfc0pGJ2zeNQrhfgwRlH/v4XnVj4PMgap0ZSAzk=;
        b=Y3HW+/kioctWWl+fdAadtFve1vy6/4cBP2FhmqGg6dQl852+TaXRwCov9GXCfw0A6h
         +jW95hNSR0Zcq2EnrYhWbNBcwHtkE6JxYBGcuVEv3jVwg2byqYHB3tlh+imZ5Z5NeChn
         NnMG+JiBnkBlRiHxzSOBWlx/RDn3tSeRNem4wAEMz1ZqQuFMHDVyb4Fa3XZNLyC3WENl
         kDDhZsfzBA104X7TCt1dPmIf+RaloDrIDvuw6/nUnh3LWJD3w+f13SzdLUcn2nqyMnl0
         8B1DPZxSDC855aAgptvn0jfNK7/sNv1ONnv7NLKLHGoCzKaPlmFY2BE4UMxbcphyq3Mb
         BOUQ==
X-Gm-Message-State: AC+VfDw3YDlaXvrZ2NV1pbx/qhRIQvMFZUoarRgZXn3Dq5PnDdhU4fsr
        YPuG+HTpXCsjQbLcrR/+P80=
X-Google-Smtp-Source: ACHHUZ4ghA8UMpNGQmIOFrpmkvIWTIyQJWiQXfqQX5VUyPyeI5DjTRzraohCanhbjuzVqYblyFr7gw==
X-Received: by 2002:a5d:6406:0:b0:307:9f8:4f30 with SMTP id z6-20020a5d6406000000b0030709f84f30mr10151301wru.70.1687344141527;
        Wed, 21 Jun 2023 03:42:21 -0700 (PDT)
Received: from gsever-Latitude-7400.corp.proofpoint.com ([46.120.112.153])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm4121378wrv.40.2023.06.21.03.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:42:21 -0700 (PDT)
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
Subject: [PATCH bpf,v6 1/4] bpf: factor out socket lookup functions for the TC hookpoint.
Date:   Wed, 21 Jun 2023 13:42:08 +0300
Message-Id: <20230621104211.301902-2-gilad9366@gmail.com>
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

Change BPF helper socket lookup functions to use TC specific variants:
bpf_tc_sk_lookup_tcp() / bpf_tc_sk_lookup_udp() / bpf_tc_skc_lookup_tcp()
instead of sharing implementation with the cg / sk_skb hooking points.
This allows introducing a separate logic for the TC flow.

The tc functions are identical to the original code.

Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Gilad Sever <gilad9366@gmail.com>
---
 net/core/filter.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d9ce04ca22ce..57d853460e12 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6727,6 +6727,63 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_skc_lookup(skb, tuple, len, IPPROTO_TCP,
+					     netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
+	.func		= bpf_tc_skc_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP,
+					    netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
+	.func		= bpf_tc_sk_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP,
+					    netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
+	.func		= bpf_tc_sk_lookup_udp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
 	if (sk && sk_is_refcounted(sk))
@@ -7980,9 +8037,9 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
-		return &bpf_sk_lookup_tcp_proto;
+		return &bpf_tc_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_lookup_udp:
-		return &bpf_sk_lookup_udp_proto;
+		return &bpf_tc_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_tcp_sock:
@@ -7990,7 +8047,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skc_lookup_tcp:
-		return &bpf_skc_lookup_tcp_proto;
+		return &bpf_tc_skc_lookup_tcp_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
-- 
2.34.1

