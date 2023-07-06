Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44E574A79D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 01:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGFX0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 19:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGFX0Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 19:26:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D881BC3;
        Thu,  6 Jul 2023 16:26:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 813BD5C00BC;
        Thu,  6 Jul 2023 19:26:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jul 2023 19:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688685983; x=
        1688772383; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=B
        c+H2ztTaE7ptsCMni+nenlvV7jKQHsFh4Ji0Eu/Adb/s/zyiRtqz+eHz5wt1vCvZ
        KCtuZq6qeNMoTnAGs5RI2nN2ikp4bhqMKLaEZ/pOyoY/mKyn8AdtGBvsRl8N+Wav
        rbuSlSkaEBPkC5UMEHPAAH+smg+MUwoHVk5yiM8D4pjtxMWpJcDaDt9QzXbtHs8k
        kX00fiuJS4iRtnwVMhZPRuu2cosWbI7MAsK46No9TWMksauqkeUbu2VCjFFMfzYh
        pwHxwc2hvD/zc6h869YwBAt6KYKa9UKDMjmO0Ui+/N3Sw4LnfxDL1pWEql1LmM1O
        4ws3BFiFughd3puZ29PJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685983; x=
        1688772383; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=B
        J7nPJopT2ail/G1jh6hTswuDk5YFCdeJDozGn+LRbe3OBXAsLCmcpZDv0c3U4WMm
        UPNtgADIbvQVviYFK3YgbZxg+gOF+zRL3lw6QNYDKQvahvL5zQZNvRoMneYcdteE
        wHkhBn4dFNcV0KhaKbDX26PcxG8MrIv2N5exnqStS+5bTzwdGil88FL54WRWjvQO
        hoNYslh3Pch1tpf8VoJt8AjT976VcKgusK3ThJbinvyw2rXsKV3IatT6MiYpYS7J
        c0KzN/Bgv9PuPdYkoa3bO4tbOHE1UpCZZuWgzuIO1M2vmFMQQ/cOHppvgsxCP/qC
        R2UeqaZfVNd+4xiPAbcPg==
X-ME-Sender: <xms:n02nZO57jvvESjcn3n2-WUfYp0eZOSOyZ0BBlngMsSG_IjI5Nr9BbQ>
    <xme:n02nZH60YApi31HVRzVZ_lQTBmivRa8Pv-x_vqRhe9tMPnvuqaU93bc71hv-zpoyT
    XLl3hNX-Oy-HE1Srg>
X-ME-Received: <xmr:n02nZNdl3uwthZ405TrdmTopr7rO5lETQ6euCs_HEsp5X6GLeyYosWx2Z1xO-4P5KYQJxzSQ4QPWTXOBQnbbAtl6UPRAy-VXGoKo4LOlT9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:n02nZLLyR0MT2FcgiNBW3LK2UpHdGHZbbk8_hTnNJGUG6KyBgxxnlA>
    <xmx:n02nZCIGCp7xtPX7EuG4QNL9CJHWfvtQ5vUY2y393IzWxcqWfZXcFQ>
    <xmx:n02nZMzEBfCBrgGaOiZX-TI_2hcNcPPB0AyrrtYmZMPOmryLpfNTMg>
    <xmx:n02nZDcpnOBYHZRjePFHQrdVzWf9RVzir176s8_cd0pwf10VCQc15A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:22 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, fw@strlen.de
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, dsahern@kernel.org
Subject: [PATCH bpf-next v2 4/6] bpf: selftests: Support not connecting client socket
Date:   Thu,  6 Jul 2023 17:25:51 -0600
Message-ID: <2ca086a7122d7a5a65090b4b90da6037c6ad3ff2.1688685338.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688685338.git.dxu@dxuuu.xyz>
References: <cover.1688685338.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index a105c0cd008a..d5c78c08903b 100644
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
index 694185644da6..87894dc984dd 100644
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
2.41.0

