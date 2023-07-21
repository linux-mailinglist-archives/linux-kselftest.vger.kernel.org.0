Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2375D5AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGUUZA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGUUYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 16:24:43 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9D35AB;
        Fri, 21 Jul 2023 13:24:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ABBED32009F4;
        Fri, 21 Jul 2023 16:23:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 21 Jul 2023 16:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1689970998; x=
        1690057398; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=c
        b7zG3oFExMrI+w/UD1VGWjgW5chkIuAAXY/y2j/H/l63N/stHHvn/6vIuu9LJBY0
        9sHl42fhagWhf+uXgpjN9EEAc8mxPcnh5rwUzkz8uhsAOMUFGLsdsG8VGldSf5k8
        tQ95cy8/TMCgsqcrfWOyHuars8Cl59z95aRpEmusTYLnLBCX+SG2WwyZrPTmEwTd
        9wOWEnLVPST7HciRZgAVwyYXmGYCzHqdmWXX8ye4qZ4BHQD0npj43aia/Tx1/awj
        dq4GTs1l7cMBovSJvHhrIMEtdfK5DE3oVBwyt6lTF/kyBi0WHSEyv4qMExKL5I/3
        MnLdgPWANxgqqt0e1Xc+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689970998; x=
        1690057398; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=w
        2JHpA304gdG9nI944Wg40kvf95XMXjx1IzUVd8LAz3hMeukCqOxSqQOO06aJvCb1
        Gh9z42jOpFb9vOtCfGiJLtQEKZybTYAnXUb2ZlgwYugZX1cFCW3eLUnNwUCUA6BT
        P9zYAiCeY8jrukjCtt1eJEID04rFQf8m++AnmnI5kYHw4TfmtIskQgi+x77qC5+n
        jEBvXTIHm5mSscCfU5g5/d0xGkeGeRYoUty60R83j/WqqZi4qINsIxN6rkzAYmeD
        fAwXii8dilm2wYWy+yfZrRtXB8+v843uhfb7Gw25jSTX/WsdyoDOaw2TSXQh3jqA
        XpH2wNzKqYlbFP8etHjVA==
X-ME-Sender: <xms:Nem6ZDLX98tIi4--8msmR-n-TfwqgEYmTLUeRoZIPVFQt_SPASH0gw>
    <xme:Nem6ZHKo64nIqQHy44WpuqCzntoD0FCc4Il5z85ag7njZSUhe15-4oIjHoIIX4Vs5
    j_ob9fp5Nb9sUcnvw>
X-ME-Received: <xmr:Nem6ZLt8JY8_JKDPYP4HsL_ZER11d4WO6xur_OpDQ-1YEdU7AEInGNYOsOtZCoc1kQlQNSI8GEk12ibFMsOMfjOUZJa9P5aE0v6P6B9gFbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Nem6ZMaJTQw3t99j3Tb6Gg1hNAh7dTk0XIsr0KmrscduImKNZs7nVw>
    <xmx:Nem6ZKZRl9kRDbvzUwbu6qt5zTIXGZ5BrHiJUKPEzYYB8QkxizfYDg>
    <xmx:Nem6ZACEt1IAgAXkLBqELlZNuGK1kMK_qsDNmwv0uOTplhEK46eslQ>
    <xmx:Num6ZHTFOGCZt1PGt3POXa2Tn-8_VPMwmRnun7I_Im9QHalZdmhlGg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:23:16 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        ast@kernel.org, alexei.starovoitov@gmail.com, fw@strlen.de
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, dsahern@kernel.org
Subject: [PATCH bpf-next v6 4/5] bpf: selftests: Support custom type and proto for client sockets
Date:   Fri, 21 Jul 2023 14:22:48 -0600
Message-ID: <9067db539efdfd608aa86a2b143c521337c111fc.1689970773.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689970773.git.dxu@dxuuu.xyz>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

