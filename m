Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43C7514A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGLXoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjGLXoo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C01FFC;
        Wed, 12 Jul 2023 16:44:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 47BD1320095D;
        Wed, 12 Jul 2023 19:44:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jul 2023 19:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689205477; x=
        1689291877; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=g
        XaRKk0A+eeMTC2URiJ7IxVHqSJSH0rLOLy5HtR5SQ/2VO2WbIFpUMqXyQsigB7uB
        v8v8QKIhVVOEgB1KtAAql1ZHPihJDyNy16cCDUuyL/SFaEosGHeODKV7NkWCTTo+
        91LMo6tDog/t6DkxJdmreAkB4tc2WeYseucWlitB5DJTyx8ztOElmoKB3bwNQlc7
        YiqV3vpaJp0u2fePviahqQQrAdBoi+zn5VDETkQ/OdatJqXNW26TbQZQyrJwyxw1
        2kiGHEYiQh6CMtsUS1NnawK+8UySnU53aN0BdEm3dXZmCYyoB2HCCDhk+d9Hyk5v
        QSjDSSpaN/ZgtPGaAhvaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1689205477; x=
        1689291877; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=B
        7Bc5SnhFDNljANSsBGZAxm0ywz91IK5k6qgkkDSLQMMv7NW3TO2B/eUyAOb0bsOC
        AX7o4OfLOOMoQUzdfnoa1oi6bZ4hwOpv4MWam6nEJjofl3z+VDX8Cts0nYn1QSMw
        RQbo2qMTCHhA+dvD5hSy7/LRGmW5S9j/3i6nlbf73u2XwR8LN1R1WnzUNA7+9X/l
        Dk6z96IL8lIAcvSfQQMwhG4mf8vAsYo3vO++r/+L5ghG9OmjhzCU2bVRP8LAZPUz
        9H12tTV2vWGF+kG/T3DSkAcv1Csy6pg32vE3RKfGE5/WDrqc68SdL40hjxAPVkRQ
        wHK70vnH+uW+gPsoMUlZQ==
X-ME-Sender: <xms:5TqvZDaxskD29vdjKGZ6dmwbZvmrVlthlAGvHp08jvf52lRq8DfIxA>
    <xme:5TqvZCYUCpFCR4loe8zoLhcPhBaD4fHjLeqpB9iJKeb1A0afeF7RtpIIrVZ7zkHXG
    1vRjqeLVxbNgmICuA>
X-ME-Received: <xmr:5TqvZF8QzU12LZiPaSPB6hr8Ipzv_nQviZJDJmRS-EQIN_md1INQ9NFf2RdbYvwbxrPRYlVK_CrE-qPUouDvhXp0w50puhgwNqJKv4V3Jag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:5TqvZJq-fBsXWOL_zKhE6EeATpaI424UH_V85ov7XqM-ziqbCVJiSw>
    <xmx:5TqvZOpHl0XFd-8UJH_SJRsJX2tPsPKmNrXxklIebM8fi-rCxHhFSQ>
    <xmx:5TqvZPR2pEQoONjGnUqvuQj8hJP9vrRwHDn0I1yZrA3BlTdpS5RCFQ>
    <xmx:5TqvZDj5gzotHVZZuiWqk775-dIagZCPmWS2aLX2o-EjDuBPbphZDw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:36 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        shuah@kernel.org, alexei.starovoitov@gmail.com, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v4 4/6] bpf: selftests: Support not connecting client socket
Date:   Wed, 12 Jul 2023 17:43:59 -0600
Message-ID: <0b1b6665846b7e88f49db8fe4d929955a3aa69e7.1689203090.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689203090.git.dxu@dxuuu.xyz>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

