Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC264D368
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLNX2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 18:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLNX2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 18:28:07 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53CB4B98A;
        Wed, 14 Dec 2022 15:26:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 18413320046E;
        Wed, 14 Dec 2022 18:26:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Dec 2022 18:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1671060375; x=1671146775; bh=pd
        7hPqCj1rehq8dhbnt6R5oY2ttXZHs4/Flb91zMciw=; b=L1GSh0Y2wzAAZIidc3
        ymLqrA6lW80edFw11+ahwc+Qmtd8xkDNi0OS5rUjwEKP3zuEZ4C8+m1Id92jq4zE
        0dLVz4+CDU3oZW8qozAIxJefisJ2nSnjDjLWLqm5VtLdf+1b4+OXIT8Iz1YzJyGe
        xNjChP35Gq9rEmfyL6lR0qFIobM22nrpmV78sCa9LpXH5bpuPv2bvBoO6rZhwqvL
        prRFGS8n6/6nhc94zskG+7kR55Q4fiBuFQyPGoPpm9L1sm7oeMnGcxMFOs5OAaES
        9BSLVaCIKk8DnxNGMOZwDRob7LxwpePNH5WerLNsAPvQMh+0eu7edGP9du1kJYka
        jWZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671060375; x=1671146775; bh=pd7hPqCj1rehq
        8dhbnt6R5oY2ttXZHs4/Flb91zMciw=; b=DsPoClf0RQVxj54YXJw/qv0CQrrrn
        LmN3WpfoJIgkwv81pLN+QHifyZLE+QdVOpI4t2PrKYEnxJfqp4bEqyQ8QHaBILyc
        HJ+oRsMeYO/GkxEKNsFf4eT9dICKQIPOew+YG6Bw5AoXZaSczquzhGqCYnLyAU/C
        w3nMIIae3zjNnxBp82GQEc0p/jD6+cSWTYSn4Go4KIgZu+RkP61SU4xt01PSp8fW
        1HGQbqMjeL5Hpmoebjwwkmn2w9j2Y43JzUTpoPg9Ltc12AlABCZGxQQn/iR408jo
        25E9V3MX5ah/AX03iQ+kWPfX54f/dGrSlxZtNl5IDENVip5uITuzOQumg==
X-ME-Sender: <xms:l1uaYzOuuxHr5L3DTAuW2n7BHUkyR6V_LuelF0EQAYnthdrxflf_kw>
    <xme:l1uaY98ZZUSOXoc_cxJaZJRvtSf71NNd-OQ2sbzv52oSEVmfHQvMFvsnePZVeljq5
    rXGGLhFkIs-WSpjTw>
X-ME-Received: <xmr:l1uaYyS2PifTTu_BhsQ_pGNtZHMYMdi_ZEexW1EfBPrgY2zSJD1jX8ANGgwO-QOtkwsXH4fGZfuBK2ZZeRa2d8IiuYVabnYCfs9AYmjIPS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeek
    gfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:l1uaY3tRa3P-O_zJfAxl7kqFGOp7udvfCNZXRJe86GvNRhxj3BXSBA>
    <xmx:l1uaY7f3jZO-v6X1pTKQmqbI9RTkEWWYKzgsBnvqtFNSwQtqQAqMaQ>
    <xmx:l1uaYz1_m-9vd_6UNk0vZRjNrDpUA122y2sDbBXfoO_ZFW7bn_Lh9A>
    <xmx:l1uaY2ujI-drrgDgpQVnnOuDVd_VrjKADwUndj7ddCX6ok-YkcUKig>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:26:14 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     ppenkov@aviatrix.com, dbird@aviatrix.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/6] bpf: selftests: Support not connecting client socket
Date:   Wed, 14 Dec 2022 16:25:31 -0700
Message-Id: <3623f9fbdfe7e1be46ca6745312eb020329d23c9.1671049840.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671049840.git.dxu@dxuuu.xyz>
References: <cover.1671049840.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For connectionless protocols or raw sockets we do not want to actually
connect() to the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/network_helpers.c | 5 +++--
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 01de33191226..24f5efebc7dd 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -301,8 +301,9 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 		       strlen(opts->cc) + 1))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-		goto error_close;
+	if (!opts->noconnect)
+		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
+			goto error_close;
 
 	return fd;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index f882c691b790..8be04cd76d8b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,6 +21,7 @@ struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
 	bool must_fail;
+	bool noconnect;
 };
 
 /* ipv4 test vector */
-- 
2.39.0

