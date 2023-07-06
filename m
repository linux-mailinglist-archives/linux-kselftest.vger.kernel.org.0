Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2074A798
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 01:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGFX0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 19:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGFX00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 19:26:26 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BC1BC9;
        Thu,  6 Jul 2023 16:26:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 043725C00C1;
        Thu,  6 Jul 2023 19:26:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jul 2023 19:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688685985; x=
        1688772385; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=q
        DE8nerLk1zdCRgbLbcNyLzu/2fSH9WE1z0b0GxZ8SHIjiixreXCpkwPakHgKFlCF
        0E6t+Js8uIkuFnolE2Pji7yr4hedGHf6vjMDTZzrtAJgyiLCpTGEdP5a4GVz77He
        qsjrtPu3Z6JbkBx2FZzl6xny2TPfxfmzKs+GkUQjTquvCqecSPKr0pbmpONPoTQS
        frbqeZ58i1XmA72AdnfK1xQb+iUBPMSWgsGTqxeoim102ujAbcCO7Kk4c+WMAbT3
        7VGcHgSOI+45OcW765VqwHpOCXWEBUgO0sy4GwiT9bwvMRA+BGJE2tzudAqMwQup
        e6VMRyyEEwtiYB/uy05Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688685985; x=
        1688772385; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=O
        x7aiC6MDx0+rDHB+9xIAgqkTslsqDkbevuH2G8qZFU0RIwzPztjFJtMwIHxl0RcN
        iO1QB00iWG/CJkYxCm4IXn4rnENa+mwsY7wEXabcob5EH5Oib/x+UJv442vIv4PJ
        WKmgQ5162tcmT6D7fdiYXwiXkqYKu5pzQ+nnMh/dCMIQUCOVTwaT8h3qmCfhTEhJ
        jU+ePAtMAPaI21a41WEXOO/oTCZUx8R6kVQgK8Auphui8KxzI0yLTSHN/zxoCM+N
        v5S4WdacrWKpDw1P50lL2/HavxiL7cD6wXGYmSsEsAa5c/B3poSRxm33HKrsZCRM
        g4+j0ZWlEFHhP20XaT3sA==
X-ME-Sender: <xms:oE2nZBgd72kmkngWt3XuPlTU0f4JUh3wP3k1_tp8pqwFoKm_AZ6gog>
    <xme:oE2nZGAPCdmTcItHJk3AdiH19juj2rKO0elCfqD6EaQG43Wb76Nb0bKSbf3zH_kNK
    KYmL1EvzPNlZg3XTg>
X-ME-Received: <xmr:oE2nZBEkjPAUDUddlY6i3HMFFyuyVZoH6TmMWzy500Jub5Bew64Iwki-WrMETJKvRwGCSIUi4qomvPa37WfYCgvBnykUvJILbkUHUotVgyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:oE2nZGQNopZP2ReTPhQQ9diLyDumUNLcoauZVyhOvXvneGFvMFrjmw>
    <xmx:oE2nZOxPewdicVeTXGbItqSzzVbxh0aPu-1fZq4BhV6ykTM5G27GPA>
    <xmx:oE2nZM6rxc_uwO_Ku7T0_nZyIagZUgzWfuvh_dKWeZAQyFxTvxO76w>
    <xmx:oU2nZKnILdgQpR3MCq9ku5E9c9edXveBEvEn6zs2us1p648jpQ_W9g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 19:26:23 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v2 5/6] bpf: selftests: Support custom type and proto for client sockets
Date:   Thu,  6 Jul 2023 17:25:52 -0600
Message-ID: <7729886a0e1ae0e07850840a7cd54530b26318d8.1688685338.git.dxu@dxuuu.xyz>
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

