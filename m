Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4C64D365
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 00:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiLNX2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 18:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLNX2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 18:28:07 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453D4A07E;
        Wed, 14 Dec 2022 15:26:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C0C2932008FD;
        Wed, 14 Dec 2022 18:26:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Dec 2022 18:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1671060379; x=1671146779; bh=BD
        uLvltuZiCfQIpl/cg6UT6rVLB+E4UVzC26FRWH+yc=; b=v0duqfnizi6TXQq0pv
        tV0Mtr9tJguGjJjr9lhJDVIsWIjj0l2hEI6imQgrX/wGZDbyGsgRV3LXJqvJ71YG
        hhNzVPpyVwB3yDcqBWvMPRdfo5EMF/GrGer7yXJGjPaJkOUSlzlCpqRKWbWpKQmJ
        pOiNkef22a5HuMT072LceBUyShZqIrg4m/yCID8tojqGYpEIqWOKLOkN7QNhqrbQ
        8KD8vuqOoBup/9lPXEnj5c/8DsFCf6rkUe3u10a6Xpryg5jMlvEr+7cpF/btxyBb
        rG+jDWXq87fCgSUCG9afQvVT4KJs8yIBcoQ9pcnLM+S5laneM8MKP1MgwPCg2qbd
        8kOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671060379; x=1671146779; bh=BDuLvltuZiCfQ
        Ipl/cg6UT6rVLB+E4UVzC26FRWH+yc=; b=cC7kZ9LHhbZsYpHUpfWe/Q7WhbFu3
        p/metdPtPy7+iJt71YvXtkl1JIpJLqjBpAseCDlEUUh5dR4KhWcQU9B43rzxFM9h
        uizLbcpKEh56jf1OBg3ZfQEauFf9YN28c9C89eJux+App++SWYqCh9RM0+OIXXrB
        2jjDGGWg2+MBeh8wWo2W4eumqEybjVyC2AC7+szWmIf+N5tsx/XNixMHx1pxhU+k
        KSVAvIVj9yWdG8ApUE7V9NZcZo7m+ezcdp5qrkc1z2W0KNbH8EgKwZ0F9BaPjKP0
        P7mvs+EJegrBg+xADPEi4bw7sF6b60ZDG70ot5rsZjCx/iVBvyKD10kJQ==
X-ME-Sender: <xms:m1uaY70yCozY8cRSpId6u5Ju6Td3MdBbdFR_JvaL9i07ZetQle6bWw>
    <xme:m1uaY6GEH752t99XzEfcYSPJsKLOIQ_Rboznf4Xbzsei7NjSVUe3h_IiFgWqF40pd
    2diFZUdafBd-DhIFQ>
X-ME-Received: <xmr:m1uaY752YB5PZXKy7ot3UN47DoyqjVGnKvkMaC2VChSKsq29yACVmdINRoarTknoOLOxNnWTOirqqHxZui-31YQ9m3eRLVMo4FqaROxMhVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeek
    gfffgefhtddtteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:m1uaYw2vzBmioGekQfecarzaobTwrmqBKTWv2Msi3VL2qlggYWObMg>
    <xmx:m1uaY-H6q8NzL1_0kEkO7g8iJIIHDJ7eQAMgzA1NaJDifkMegeb6nQ>
    <xmx:m1uaYx-U8rmdaGGuJRzi5su59hLFz7NAVvxHGSxOdB-Lj24z5ycp2w>
    <xmx:m1uaY8VH-THEeALOOTLy1qAUMcY1ay876hOsTg6nmFhGwAcO4aheig>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:26:17 -0500 (EST)
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
Subject: [PATCH bpf-next 5/6] bpf: selftests: Support custom type and proto for client sockets
Date:   Wed, 14 Dec 2022 16:25:32 -0700
Message-Id: <892b579588b4985fdae013fc752fa1b2c2315e34.1671049840.git.dxu@dxuuu.xyz>
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

Extend connect_to_fd_opts() to take optional type and protocol
parameters for the client socket. These parameters are useful when
opening a raw socket to send IP fragments.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++------
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 24f5efebc7dd..4f9ba90b1b7e 100644
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
index 8be04cd76d8b..7119804ea79b 100644
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
2.39.0

