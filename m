Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DED75B911
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGTU6o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGTU6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 16:58:36 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054BD2D6B;
        Thu, 20 Jul 2023 13:58:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C734F3202AC7;
        Thu, 20 Jul 2023 16:58:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 16:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1689886704; x=
        1689973104; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=P
        XUPe3DJnTw8/vHue3otEdZkV0JB4X3VvVcqfqByGatn2bkUMqbloqOYcrrPmFh2L
        Vs2x+MX72N98SQgEKS0n0GCVXGjKXo6c182e1dvJW6XalsnQqdJaYdMpJcwQ3Zs4
        yQiZ4SRxCLdRCN+r6Zyevv13DwoP7vF44O1RJ3R9niprF6qae4lhj9ZhaUrHU/ya
        ks/1ECwLYOCaPiPfr/H+YA44S3n3ZtA438MhokaKZJQxlGgySVTiiMBOpBFl7nxI
        UtVjTbknJSAd7QvziMxdr+RXEzzRom725Uxz0gYKUUgb14W1YVDnGxSmyWAtfHkk
        vnOW6OCqpWG+rVu0xPm6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689886704; x=
        1689973104; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=D
        1xhs+Ok8PBbEOzXfhe3dEP2vApkFiv0X8zWGgNSFWubJExCa4E1TcmquQSjaznsv
        bAQAJYYt3A/KFiRtyx8Zziqx0wLU2JgGEVJ7ek74pmiW9K+rHu3in/Yf6+VnU/Dq
        1iu03vrpMmhUmdzhXenBbS+tKBFqEBHtJSmKkXfnGM5W6mhGn9bkNaO4Q6PagBfg
        QCWT7zO3hhzlcu7wlFzRjJLbJX3zNIBWXe+hosp1NjK3X5Ep1mkUYFnGpYMDC0Oi
        QsbqZKcPx4FRnYvFEnJUQx8xAkBkLouVoeC1P2ucrc3l6c6vlJy2cRQHXbG2IMeb
        56TpKnHrG3biPL2eh5kMQ==
X-ME-Sender: <xms:75-5ZIrcakbwQNyiivLq_hyDEfPmw_r6d0FX4xauP__p1dSnb8ENSg>
    <xme:75-5ZOr-0UBwnzKmqwoxdlcm8vT-AF5n-L2HK9ASIViJJDYydMDuUINs3Y1ZouqiN
    jEgvDs6TWLw78aMxw>
X-ME-Received: <xmr:75-5ZNMdiCfnNUUkxxFgPw2jfDzk2CKkXGha3tt-M9Eeb1JYemI8hGeg1FetB3AnXFihpM-xf084cqmG3jbVEV5BKnL0hEy7dXL0ndzDs5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:8J-5ZP6wJ90QXP0nU9CKyW7VEpfboR_W9WPD5-bUJ5XqD9yCrE3T_g>
    <xmx:8J-5ZH5UVn3yq6h1o9Qxg_md_b9KUoM6N-WpYquQ5XLApscm9AaJ-g>
    <xmx:8J-5ZPjJuZbsa-cUJTG1S3ZaLc4hOsMnJy-b9XUhXHAy30AkkDoXNw>
    <xmx:8J-5ZExxoXM7Ry9u3McUrQzpV4MMb86a5WWcAgP9StXTs7za_qEW2A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 16:58:22 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, alexei.starovoitov@gmail.com, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v5 4/5] bpf: selftests: Support custom type and proto for client sockets
Date:   Thu, 20 Jul 2023 14:57:38 -0600
Message-ID: <0d73e2d2ca71f407fbb3dc1011481e2d6fc89d19.1689884827.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689884827.git.dxu@dxuuu.xyz>
References: <cover.1689884827.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend connect_to_fd_opts() to take optional type and protocol
parameters for the client socket. These parameters are useful when
opening a raw socket to send IP fragments.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++------
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index d5c78c08903b..910d5d0470e6 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -270,14 +270,23 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 		opts = &default_opts;
 
 	optlen = sizeof(type);
-	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
-		log_err("getsockopt(SOL_TYPE)");
-		return -1;
+
+	if (opts->type) {
+		type = opts->type;
+	} else {
+		if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
+			log_err("getsockopt(SOL_TYPE)");
+			return -1;
+		}
 	}
 
-	if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
-		log_err("getsockopt(SOL_PROTOCOL)");
-		return -1;
+	if (opts->proto) {
+		protocol = opts->proto;
+	} else {
+		if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
+			log_err("getsockopt(SOL_PROTOCOL)");
+			return -1;
+		}
 	}
 
 	addrlen = sizeof(addr);
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 87894dc984dd..5eccc67d1a99 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -22,6 +22,8 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
+	int type;
+	int proto;
 };
 
 /* ipv4 test vector */
-- 
2.41.0

