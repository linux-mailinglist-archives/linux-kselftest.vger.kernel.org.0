Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3474B554
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjGGQv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjGGQvU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 12:51:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF37210C;
        Fri,  7 Jul 2023 09:51:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 917CA32001C6;
        Fri,  7 Jul 2023 12:51:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jul 2023 12:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688748675; x=
        1688835075; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=5
        ylpP1mihx5lXocGkIaxYB+bGqJJHwKqe7lrUm0DM3dz0325bRPnGOlrMbrjunV+j
        kRxmY6oIcKVm7XJxLfpkMDJ4cw3TgLPkRzHA7K7/E+jUUqKVle/1azUQCm/JsW7n
        ngTwgXCnjMZfBjc/Io1G0s3v7f5fcd4MPB3vfAmc35vTDUGwK4twBynQ7+aanMSn
        xVG7UfE9hdJjuaTGw0Sqn8WVeslJm+YDJUyORKnh7isop8wMnR0goCL6AZGXZN6n
        IrAaA9eL5mGgbOeAc7dcjRH3HXrYe+e6kzysFPXz5EJJKreNwjM+d3FGu9Yk1a5h
        Zg0RmhbsRiouBSozbxt+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688748675; x=
        1688835075; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=H
        nXsQ06F1OlTkwF5knu1BATNQ2EvkjoaKmw7+FWGTZaUl1DqI2ZgN7+pDrAdYYR+u
        OL1FNP+KwKrFY/s2/s8e+2sfUsWV8HsVllYWRLlTf9BUNyL4jDpOXgG/9uJMZQ/2
        ZGzbcVhe2CB8Tm0sbkoLQslU5BsdPMiXSxFoU/xXPkcm0rEMYlGiWRnVohFmVBeZ
        jXiaRkO3B4PJFf0WqmQDZimKae4HSvTKRkqPUVKCo86A+XhR3p4R+QpjNhJ0Hj7g
        d357PowSsyokFHbgk9gEQDIEz3PetLyQaNcmCdF9gwIQ0B68K4vfYfSeWEmbCdxj
        kkLZWpsa9yY4HChSAM6Zw==
X-ME-Sender: <xms:gkKoZEYneUahfLF2Hv90tCSaIEi6ZJCQfvISDpMEd_9WTvoZXhHqCQ>
    <xme:gkKoZPa4XAt-kxvpdFL4MPi137F_Ct0bnsJYDGfelNU9igRWe7VFJXNmGO2oq-SUd
    OaJE4NxxUaQIZYJNw>
X-ME-Received: <xmr:gkKoZO8c0PL85TAB02eBsGG1z7_WeNfdeWxn7B4m4tSQERTT_1pacH_DKofNLS6PhBOPiKKA_KsY-qGs0yifIGSVXWV7zIVknZRdIhV85QI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:gkKoZOp30o_3vwohI2ipXWFD9AJbLE16uq8j1IcE0Qc4Er96JeImyA>
    <xmx:gkKoZPoOVQgS5p0LTf4kVmnFRyROMveLNMQtRTFlyTHZyQnj2y4WBg>
    <xmx:gkKoZMSYChOZN5IrTM-ZypasrPRcIPQel3IdQ66tqw2AiCrUb725JQ>
    <xmx:g0KoZG-b0scEH3ZkqhSzgB1MvRqX11YOWK4Z0bXeL4R8TMfhp7HlFw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:51:13 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, shuah@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v3 4/6] bpf: selftests: Support not connecting client socket
Date:   Fri,  7 Jul 2023 10:50:19 -0600
Message-ID: <6d4095f283a6aace70ec325ad62e1dd3fc4a5287.1688748455.git.dxu@dxuuu.xyz>
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

