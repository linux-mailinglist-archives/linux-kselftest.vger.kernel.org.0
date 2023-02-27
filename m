Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512A6A4BA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjB0TxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjB0Tw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:52:59 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92328867;
        Mon, 27 Feb 2023 11:52:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F39423200947;
        Mon, 27 Feb 2023 14:52:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Feb 2023 14:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1677527535; x=1677613935; bh=c8
        o35w1Jj7teVzLK9zP1vbcoSLG5zTY/3S1Db25AnFg=; b=lrht50y/jtiCKp0+xK
        Vb21ok4ouCL6GyyPauJ75Jbh8VM78wKMZMZlyMQKyHXfNAi0G1G5AaUrIRoh1X1g
        SbICxrSc2immkkXH9rGoG3IIyKOwg3aSuk8XmKGn7+lbsn66vYeW1f6DKjoOaXzq
        muxGK97c0tclwKKxb8zj2EQPMuBk1SWGOeAXrE85Qiv8med3Uv2gMVeIQLlsOffm
        PRcOii8SFj9tdbNOPVaKEKBa+jJ9vrGVheXMUT/MtG7jz5yAHvi9iEEpvWl7KT8N
        ipWZJxY+0r/jMoCGMAWYDJtcAcfUAUrumvComhRqFsmA4dRFAwtnRueVJBG7OdaE
        Nthg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677527535; x=1677613935; bh=c8o35w1Jj7teV
        zLK9zP1vbcoSLG5zTY/3S1Db25AnFg=; b=IFx0kw7RqjmJKAWOJydKaR+gZDsLb
        0NfnUjqo48NAN9QEpVUGhHGzRUSoD43OWslLJurKT+8WXU6NkesgG68X3hUJDTLy
        0t8b2YGmk/aLTCJ53u8URdM9Ou66oIXaxueeAcnAs73gGtrnN0VSi+vAVPE5ZSfy
        jqwQy71hae7WkmcNFGCDgu86z7E0RIgQfuuj43JWpDXFP46wjKVE7iTjCTOnCr6R
        m/ykOJ+AZq0tdNmVGcnwErbFzeJ0eJptQPAUzYXLrKD1jtSHn9Jd5sGwciyKEkm/
        VaGkjfEqMjuNt83SaLu72F2kQTGyfvUxpDCFNo8/qbQK4zasS4lvdrUgw==
X-ME-Sender: <xms:7wn9YzbUUFbPDpDvRMyTBDUI4KM3pGmJUyKope8XliTaKI11FJn3hQ>
    <xme:7wn9Yyb70BzbwETI1F60CUAjc42bcR7pMUDakaNlLBoDSxfqVfBLd6uQEWC1DWzZO
    EtiWiFJW9MqhZRSag>
X-ME-Received: <xmr:7wn9Y19rB3mHvMOpba59IrsagzQGMX_OlQBfeot7KlViB7U4b_pCwFFp5VW_vuVJZylnFfv3F2VDhEVNao08bYczsaXnCng8yJv1loigHFC7Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:7wn9Y5p9F9VX72Yrmu9rVNbbXyadL0TKUsRYKDxM-tuK26EoWT-q5g>
    <xmx:7wn9Y-qaFGgjYTddFi3tn3N7skHIGiLhd_vVykJ8Im-iODrwPl_55g>
    <xmx:7wn9Y_TNkhCVJtGOk-fMfe4Kuc86k-T2rSrPyQtMvH4osFiyvHmLSQ>
    <xmx:7wn9Y5BiV1N1GiW9YL0GvNaNyoX-RdBj5ihDcdsRKFi0i6qWiaeL1g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 14:52:14 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        ast@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 6/8] bpf: selftests: Support not connecting client socket
Date:   Mon, 27 Feb 2023 12:51:08 -0700
Message-Id: <1e98c66945fdba2b4665e9b9bdf084757ca8a112.1677526810.git.dxu@dxuuu.xyz>
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

For connectionless protocols or raw sockets we do not want to actually
connect() to the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/network_helpers.c | 5 +++--
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 01de33191226..24f5efebc7dd 100644
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
index f882c691b790..8be04cd76d8b 100644
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
2.39.1

