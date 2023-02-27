Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1C6A4BB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjB0TxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjB0TxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:53:10 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3B298E2;
        Mon, 27 Feb 2023 11:52:46 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4F9D23200955;
        Mon, 27 Feb 2023 14:52:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Feb 2023 14:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1677527541; x=1677613941; bh=pJ
        73DrAYXIIgt6NXNbsY1qViBhntRO01+UwF0Z/mWJw=; b=MDIPO55uf1Rb/b4t3e
        jiFTioMtMkDuBgR4BulVyFNVLTKTzPBqjzkyOB42QBpmAb0736fxW8suE7MzxVQE
        m166WOWMxdx2ye6ajv33y5v6YOtJUKl4FjT6CDzdYpaxd87+4HZZXY3sgJfNgzKr
        My7z5vPM1cBZI0GM8V7gQ4RE1K0rzgmBY0arz7EVXp5CetjY1VczIrQIt1tKFWzO
        Y9T5ElwC4Z9hC4l5T7GMyDlcW6t2JAEncSBIQCMIW390p8BStzUS0kBzryd3dDvZ
        SAcY/wVzNhEG18P2mfERIn+8ZMuCHhll4PROWinAi0egMClEBSkHM4uqT8FL19eH
        Mxog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677527541; x=1677613941; bh=pJ73DrAYXIIgt
        6NXNbsY1qViBhntRO01+UwF0Z/mWJw=; b=kz+0nHbGjE2FFDAJ001z+0EeK/zzD
        DwucsUCmtlowxtidYhNqKQfYSSyBzDvZcDmav5+abm4zUGke1tewTtUoLs7IwGNW
        PO7DFlNKI2I3DODBUIjW9FRPdwmSkI1WtUGGRD73xUkjrA1n5Aw9KaEhC5WrUTZ+
        aAXR2GA6T4qPzWcxdaZjV53lJKBuKJlEtVWlXlSDM4EogrTbk3Nn1f5/QMP4CQEY
        JcU+DFWKhCAjfQDGLrhcpEhKNuudtSWxvuvkH2e4SD1cVM/KpEvipIWZzq0Pqi/S
        cM0CnNZjqdnqMsJoHhRAI8tY2PD+Y7zOtJRmHVTQm8SKgQgVanD+dQgog==
X-ME-Sender: <xms:9Qn9Y5mFZZSt8zREJZjpq3nVmMSEgTDAdBjzoALcyD4yhcTiAMjq0g>
    <xme:9Qn9Y010Q4QTk4e36U1s6qmlrUeWjxC4-ynGcMmAcuBcVmeQtYz5qqGx5n9u7gxh-
    aP1HIlexKiCm9oW-Q>
X-ME-Received: <xmr:9Qn9Y_oKkt8NdpScQsINLK7zbU7oAJ7bgO_U5fI8-zL7W3FSKi1Lc9pJH7rt7S_f6UgxUJeChsMXnGxLl8pCupF7g1GvjxB9qWg7xi1Gh8W_rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:9Qn9Y5m0ZpaH-pm7Kiujshn8OACWGS0wBph_60I_nEpRkjHCTMWBkw>
    <xmx:9Qn9Y30fTLfB_KH37VO4IEFbesZa4SqsmQhctYkaIe9KEBCFXcDBqg>
    <xmx:9Qn9Y4tS1l0SCnpQEEpzx58hAq47Z84hs0meGouALu1BRWHQTV0rFw>
    <xmx:9Qn9YxP0JaUDz7jMEW6nFSKl2D7KdKPf8Yf1HQCZy8HspdqfZc_jtQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 14:52:20 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        ast@kernel.org
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 7/8] bpf: selftests: Support custom type and proto for client sockets
Date:   Mon, 27 Feb 2023 12:51:09 -0700
Message-Id: <4c74acce194c9896da3c84cbaf6191f3c706845c.1677526810.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677526810.git.dxu@dxuuu.xyz>
References: <cover.1677526810.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
2.39.1

