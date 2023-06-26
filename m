Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421373EEF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 01:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFZXCo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFZXCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 19:02:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE411702;
        Mon, 26 Jun 2023 16:02:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 97D9E5C011D;
        Mon, 26 Jun 2023 19:02:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 26 Jun 2023 19:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1687820552; x=
        1687906952; bh=n503uRHlm7PSoiNPrcOUsA2hVWcbKqQi9TGbsXoSZ2w=; b=A
        M2xFjMFCHi0+cn+Ont6P5Xx/0zfrXSozDZPxpFSbgE9pLHZ1A9+MOMVcSmhPBF6m
        bvfKfPFxaeIVgdiuELhpmNr0DIjw0mTo85fWKE21eBf2QQbFqVVMbQ58D5FIS+jn
        2H43dLcRNScKASbQpyp6Zxwyao24miuLA/xtnfvL+MnXuUjiOTQyI9TGgGv73qSd
        /ubXwfyXW+QzDxjXKcBBTFonUqxgkCDSj+/ZE5m7ZZU1QlBQi9Vi0owIX068LLZd
        6ofWNdHD5PGYMyAWCZru6e/t/JSU4cXJVTpGXC3Z2l86YMzV3rcXE7UpEM6o0KF3
        0rXTJQyd0Uaeqhn6oVJ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820552; x=
        1687906952; bh=n503uRHlm7PSoiNPrcOUsA2hVWcbKqQi9TGbsXoSZ2w=; b=a
        Igs5mBnvWzzmmvZ2NAc8WDkZJN2kP4/Ud0pu+UrjvkPt/bl/5NpZjM/pe8pAnEp3
        5lF0pw06YMCzuWOCYLTTJNHb/h3z9Wj8qyoLnJ7UcoMYPLnranQ28WJZ9WtZclEi
        7FYm6yE41TJkJPae0Cyzgwi7Kst5T6QPxQ3nyHHZJUN7LYC7/JX4PqEbhoNaqjX5
        SqY9Yl4Jq8LDaxHbu72ZDIYEDy/gmLyc38ERU+XZVYFd5QRCmbkn/HvVx1+IbDTp
        6MVn9toKEMfelcebY1x1UlNPafLqVJKRWLS+wDUVdGU5YFxcJbigzatjdpTbEQlY
        Xs85/BnO7wARFiuUoF1DA==
X-ME-Sender: <xms:CBmaZGJ_fYzs5btD0doW2O-tfF5nt3gN4HenNshiJpsC2f70YRN6AQ>
    <xme:CBmaZOJkL0QxgQfxdR3jXWQoljmA4perVYeI3OgUeoPiojb5Q-N3G-99ayO5IivPo
    mjaPiWf2aum_IVbHQ>
X-ME-Received: <xmr:CBmaZGtYiZCu1GT-ce7hI56pfVpV84F0dGbZqddVPwxhJfDvRDF61h2c0TKu_n3NbqXT_aetzRWFVJT_aBQulrzDjG2sRtZekWeiYhDlbEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:CBmaZLYzcoFFBBKfzPCrJsDGxMhPPYaMWtwtPPYMVbHpDeuRIPDSZg>
    <xmx:CBmaZNZMIXSepnislt8EscR9PyEkOHF5ZLTEZHAhTF24DBk1rwWmjw>
    <xmx:CBmaZHCXZEeYI3EE2s5XAkSAg9REwQZRwbQrh5nxnAWgb74WaJqp0g>
    <xmx:CBmaZLtvho0npfWk6oAwtTcrSR1qlyvIop6NoKS8yP9PipyKcBSTIw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:30 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, ast@kernel.org, shuah@kernel.org,
        andrii@kernel.org, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next 6/7] bpf: selftests: Support custom type and proto for client sockets
Date:   Mon, 26 Jun 2023 17:02:13 -0600
Message-Id: <548b1c471bf0993a68ffc0fe29fd283825a361b6.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

