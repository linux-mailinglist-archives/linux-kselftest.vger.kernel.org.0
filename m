Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C874B558
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGGQvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjGGQv3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 12:51:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220B26A2;
        Fri,  7 Jul 2023 09:51:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 79831320077A;
        Fri,  7 Jul 2023 12:51:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jul 2023 12:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688748678; x=
        1688835078; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=N
        M9a/fHU+sAtF01f0VlLA1ct1vLKtuK1DtAXRcznpcMttlNBGHix89tgucxwMEMZl
        EwkiUDo32GzO8cTr9M216skbVJzIu5v7U1UsYFIl256sf+ZnAd18IXArSivKosCa
        bvCRvByOFSty205mbTCTiwFXYblJH2slsu63diVLvMLaxniEWs1lXtJedz32OKXa
        PZnivKemQdzBgEqZLde5n1a9ykuTDE946kRpupm68SguuxSEIWXxmeZf3mibXaTT
        /Fy/yYPRDYC0PvX6gORsiSo+At/vZYH4Bo1TRKXXbzZZqw0J/2EQ2dk+8LkV+GCi
        3sQx8C1mF2jmA+EYOS7uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688748678; x=
        1688835078; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=f
        63JbEt1Z/WFGq5pHpihxYFUxsgZ7hYJac912GHOms1yYCPPneN73Jg+BurgeCgJ4
        lduOjYvznUehElM6s3LKphW0QicrXDNhlT+4vd8O6EzxW0TAJliMpLYqJ8LlDW5K
        ANiaR5fI+9oirJCiQHA1v8nCiptbVzwJRVW1WNnQ37COxSbvoRHv1KldZiozFWTf
        XPmQRPRBQtA3lmoQCsY5E12RMtnICWNo5pG/MYwJNSiizWVyPqqPgqvdCLRl7jtv
        pE/Vm8M+HoyWqUF+duc3NmqG2t/Hk3IDXFXi0rLRfHL8O5qQ7Tej1+mI18ca65c9
        q57K3SueHvYT7aA+5tonA==
X-ME-Sender: <xms:hkKoZBb45r_OniO477W0LCfmr-8FLMfYEWhBBYmzN18-2IsyN6kBsQ>
    <xme:hkKoZIaBeUjLOErAM_LRkxOJ-Kg7oStWlafvjijDTGG4U8ss4ZWWad6bh3isKoCYv
    WII11cIWX5Qhf35Xg>
X-ME-Received: <xmr:hkKoZD_iApl63ob_GmRQ_2U16FRcbdXqhy03QaKMb3iCKVPdw-wSaqJUC-LezHyEntOb0B128DW2p_Kddr-xICYMWD0dER1SwMIV97Zi8EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:hkKoZPpadjYTn4c_Kqpa0P0QwXxM6ac6ORKotJzVGQ0N0zSBa79csA>
    <xmx:hkKoZMoc3Wxz_xmdn88E0FLZ1piJaY9h1efrn2ivhchYRB9TPxlJ2w>
    <xmx:hkKoZFRaITkhoj2_E69LL9l7-F-jBVG4YK_z1rA9re2b0LWBRD3gag>
    <xmx:hkKoZH80wWUMMsfPC6PzvOw1IQuntLk3yIsj1plV6OQvBEGcLO79cw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:51:17 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, shuah@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v3 5/6] bpf: selftests: Support custom type and proto for client sockets
Date:   Fri,  7 Jul 2023 10:50:20 -0600
Message-ID: <ed9ac0bf0f6fc246609133d47f946091e2366fef.1688748455.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688748455.git.dxu@dxuuu.xyz>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

