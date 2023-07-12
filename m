Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163C7514AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGLXo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGLXow (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D8211F;
        Wed, 12 Jul 2023 16:44:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3329B320094D;
        Wed, 12 Jul 2023 19:44:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jul 2023 19:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689205481; x=
        1689291881; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=1
        bPDjgHazGZEQ+c+ows2wTY7V33tOSibQdMolPRNEwwHAvcfbYxe+eg/okm8M31/H
        8wI8jflCQdMrgnuCimrXzGfwvjIk16oj/cVrpwsjafyN7Nvp+Le1rDpmV6b2TP6M
        tmHSakCs2R/ibmM9drveZo1B+ppUYQucwPawKgBbgoOHhwAw/KP6NESQFemO8uih
        f2xdZQ27AK701xr5o4gGmdDUx4qwaKbFJLxJ9ksaeM+Xcrqwx4BNPgEk9xEKgot5
        oTZMHPSfgCxZwDmr+7c7Wvy6XVxUkSByN8MsbHFkwxiLdUpTrmZlZPbyc/jlFKMS
        njIEW/sfQUhME8F3DCbuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1689205481; x=
        1689291881; bh=jCzr01pZ2u8uI49LnXSVMw7KSVSfUH7qENNmnpv8K+w=; b=n
        miiAakAvnGENcs76zXufNkCv8xtSSQ92oI2esCbIKZhIQsI9BH9FkdqQ/dn6vbZW
        yZwsTBUe+jom2wMkNXpqfEd5G8506bPyAnOFLlAurpErsOYFu4O5RRAE9YWDZXQX
        +trcrZk2f+nmbX1zb5l25GJ04doQ7iQLRiE84WoU/hh+ZJKaRBljAzKy8M2TbIoP
        OzRiIiWTgJY72Db5v4hGz4Mw1kWwn+bjcbxKPP8vYqySQgufZY0czvrgEED0ozTy
        VKZRBbYAlL2Ify5qMAbWRfQpHTaeGi6qZ3wqsGt+cyXBR8t2ezxIlsiYzUUIjSvy
        DYjf5M03kvj/3zywdKoGw==
X-ME-Sender: <xms:6TqvZKP-zW_mLj_dp0qmfAIpRd5UjULTKT53sgWW6xebuqrX2G1cKg>
    <xme:6TqvZI_5tQ3aaLcivsjup2nJ6VecHbBUdFa_4uOF0f9KPeYy9KttPWBpW6L2Go7ad
    MqQCiWaXWSBIcnkFw>
X-ME-Received: <xmr:6TqvZBQU5l1iqvaHLcOOy0Yd2gPOJEAagCMOZO1WbEl_dLaLlTql4dNJq966IzrFAi7S3C7w85tmkqOK0BkvKfQwfiWNd4pmJuJf5IzJJ_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:6TqvZKvwU9C2s4RIbzAqDEcWRlgDJ7XUCxKAgVMURirgXrGd8LtkaA>
    <xmx:6TqvZCff3oHtXk6f2mgTWJeE92FBJPDqckT7kswIevOVknK4TRG4hQ>
    <xmx:6TqvZO2pPJOn2dyOlpVpaYR0NQF6j7HNfGNdqxMyrOSAWBHjYtp3Rw>
    <xmx:6TqvZFWM_iA6-nEPaaO3RxTbQFzELo5PuJKimZYC9viBdUKs9aUUJw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:40 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        shuah@kernel.org, alexei.starovoitov@gmail.com, fw@strlen.de
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        dsahern@kernel.org
Subject: [PATCH bpf-next v4 5/6] bpf: selftests: Support custom type and proto for client sockets
Date:   Wed, 12 Jul 2023 17:44:00 -0600
Message-ID: <0e39aaed415e84d3a4b096974cd8dac84fbb7b0b.1689203090.git.dxu@dxuuu.xyz>
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

