Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D84ACA86
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiBGUaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiBGU1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36CC0401DA
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s7so6058449edd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOdNmlyNPW+E8PGbp+vyT82pH5RDo7o+AEX7jRKD5jw=;
        b=jd22+PXasAQBeEVZ1It+lxlZQPw/JWKSI973ehOH4wUKCWP763mBUk6Q3eCQLeVgbk
         X/jYyRhXIQ+X3CsBoIV+JY70LF4vbSN2+1Kk1SvY5yBYb+Ec+yREgpj3ah7sCaNCSQuH
         +0Rhg4XmXOwtdWrHBmTKAjUF75LQbN8p59czA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOdNmlyNPW+E8PGbp+vyT82pH5RDo7o+AEX7jRKD5jw=;
        b=oXuCAIRnD3WrRFX1m40xlpY64q8o2BF4AI/SluDgiG83yEfwjTZXgZt0gbxNsTS7Lu
         NGDskfFPUfAjw2nC508Igt3ccSkC33M0BLZuXjGCQZ9LzDTVDSbDL/XNgja4ISdA5KoD
         t0Z4DSRWZs2rCY5A9PhGv9zxz1rqCF1U3rfnTiqEhAv+/q4mZd0GgSjO1JC0srdSplHa
         xvah8DUbMVfgUzll5/4YT84CmB7K8VHvgIVqGs3IOaFeQOleW+Y9gGOzAW7AIthhDLZR
         oM4f/in1n9ure2lTiR7sJ3YWyMKZVOxvp9dufRHSDp1WhHMO3PVmVe6T9nPeorDMM78L
         4Psg==
X-Gm-Message-State: AOAM533TXsQenGfH+pY8XlfnMzFZqnr+ND+DO0sINzOvuzsWaLriS1SP
        MAyUXNpg17aMphXZKXOtlXKrvLfr73vKiA==
X-Google-Smtp-Source: ABdhPJwXM42h357HMBrXg0hRVKtB+o6sISPdsi4QruQKe1X4+mT2WJBjJOxk/32ho5krXBDuyDs2rg==
X-Received: by 2002:a05:6402:5110:: with SMTP id m16mr1184680edd.325.1644265637825;
        Mon, 07 Feb 2022 12:27:17 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:17 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 3/6] thunderbolt: test: use NULL macros
Date:   Mon,  7 Feb 2022 21:27:11 +0100
Message-Id: <20220207202714.1890024-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207202714.1890024-1-ribalda@chromium.org>
References: <20220207202714.1890024-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the NULL checks with the more specific and idiomatic NULL macros.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/thunderbolt/test.c | 130 ++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f69bab236ee..b8c9dc7cc02f 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -796,9 +796,9 @@ static void tb_test_path_not_connected(struct kunit *test)
 	up = &dev2->ports[9];
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path == NULL);
+	KUNIT_ASSERT_NULL(test, path);
 	path = tb_path_alloc(NULL, down, 8, up, 8, 1, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path == NULL);
+	KUNIT_ASSERT_NULL(test, path);
 }
 
 struct hop_expectation {
@@ -847,7 +847,7 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 	up = &dev->ports[9];
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -909,7 +909,7 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 	out = &dev->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -989,7 +989,7 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 	out = &dev3->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1069,7 +1069,7 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 	out = &host->ports[5];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1161,7 +1161,7 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 	out = &dev4->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1253,7 +1253,7 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 	out = &host->ports[5];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1297,7 +1297,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev1->ports[9];
 	tunnel1 = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
@@ -1312,7 +1312,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	down = &dev1->ports[10];
 	up = &dev2->ports[9];
 	tunnel2 = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
@@ -1349,7 +1349,7 @@ static void tb_test_tunnel_dp(struct kunit *test)
 	out = &dev->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1395,7 +1395,7 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 	out = &dev4->ports[14];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1445,7 +1445,7 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 	out = &dev5->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1510,7 +1510,7 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 	out = &dev12->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1566,7 +1566,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	down = &host->ports[12];
 	up = &dev1->ports[16];
 	tunnel1 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
@@ -1581,7 +1581,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	down = &dev1->ports[17];
 	up = &dev2->ports[16];
 	tunnel2 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
@@ -1628,7 +1628,7 @@ static void tb_test_tunnel_port_on_path(struct kunit *test)
 	out = &dev5->ports[13];
 
 	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
 
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, out));
@@ -1685,7 +1685,7 @@ static void tb_test_tunnel_dma(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1728,7 +1728,7 @@ static void tb_test_tunnel_dma_rx(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 2);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1765,7 +1765,7 @@ static void tb_test_tunnel_dma_tx(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 2, -1, -1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1811,7 +1811,7 @@ static void tb_test_tunnel_dma_chain(struct kunit *test)
 	nhi = &host->ports[7];
 	port = &dev2->ports[3];
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1857,7 +1857,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, 15, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, 15, 1));
 	KUNIT_ASSERT_FALSE(test, tb_tunnel_match_dma(tunnel, 8, 1, 15, 1));
@@ -1873,7 +1873,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	tb_tunnel_free(tunnel);
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, -1, -1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, -1, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, -1, -1, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, 1, -1, -1));
@@ -1885,7 +1885,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	tb_tunnel_free(tunnel);
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 11);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, 11));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, -1, 11));
@@ -1910,7 +1910,7 @@ static void tb_test_credit_alloc_legacy_not_bonded(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -1943,7 +1943,7 @@ static void tb_test_credit_alloc_legacy_bonded(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -1976,7 +1976,7 @@ static void tb_test_credit_alloc_pcie(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -2010,7 +2010,7 @@ static void tb_test_credit_alloc_dp(struct kunit *test)
 	out = &dev->ports[14];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
 
 	/* Video (main) path */
@@ -2053,7 +2053,7 @@ static void tb_test_credit_alloc_usb3(struct kunit *test)
 	down = &host->ports[12];
 	up = &dev->ports[16];
 	tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -2087,7 +2087,7 @@ static void tb_test_credit_alloc_dma(struct kunit *test)
 	port = &dev->ports[3];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	/* DMA RX */
@@ -2141,7 +2141,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	 * remaining 1 and then we run out of buffers.
 	 */
 	tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
 
 	path = tunnel1->paths[0];
@@ -2159,7 +2159,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
 
 	tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
 
 	path = tunnel2->paths[0];
@@ -2177,7 +2177,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
 
 	tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
-	KUNIT_ASSERT_TRUE(test, tunnel3 == NULL);
+	KUNIT_ASSERT_NULL(test, tunnel3);
 
 	/*
 	 * Release the first DMA tunnel. That should make 14 buffers
@@ -2186,7 +2186,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	tb_tunnel_free(tunnel1);
 
 	tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
-	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel3);
 
 	path = tunnel3->paths[0];
 	KUNIT_ASSERT_EQ(test, path->path_length, 2);
@@ -2216,7 +2216,7 @@ static struct tb_tunnel *TB_TEST_PCIE_TUNNEL(struct kunit *test,
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	pcie_tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, pcie_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, pcie_tunnel);
 	KUNIT_ASSERT_EQ(test, pcie_tunnel->npaths, (size_t)2);
 
 	path = pcie_tunnel->paths[0];
@@ -2246,7 +2246,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL1(struct kunit *test,
 	in = &host->ports[5];
 	out = &dev->ports[13];
 	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
 	KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
 
 	path = dp_tunnel1->paths[0];
@@ -2283,7 +2283,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL2(struct kunit *test,
 	in = &host->ports[6];
 	out = &dev->ports[14];
 	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
 	KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
 
 	path = dp_tunnel2->paths[0];
@@ -2320,7 +2320,7 @@ static struct tb_tunnel *TB_TEST_USB3_TUNNEL(struct kunit *test,
 	down = &host->ports[12];
 	up = &dev->ports[16];
 	usb3_tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, usb3_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, usb3_tunnel);
 	KUNIT_ASSERT_EQ(test, usb3_tunnel->npaths, (size_t)2);
 
 	path = usb3_tunnel->paths[0];
@@ -2350,7 +2350,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL1(struct kunit *test,
 	nhi = &host->ports[7];
 	port = &dev->ports[3];
 	dma_tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, dma_tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dma_tunnel1);
 	KUNIT_ASSERT_EQ(test, dma_tunnel1->npaths, (size_t)2);
 
 	path = dma_tunnel1->paths[0];
@@ -2380,7 +2380,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL2(struct kunit *test,
 	nhi = &host->ports[7];
 	port = &dev->ports[3];
 	dma_tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
-	KUNIT_ASSERT_TRUE(test, dma_tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dma_tunnel2);
 	KUNIT_ASSERT_EQ(test, dma_tunnel2->npaths, (size_t)2);
 
 	path = dma_tunnel2->paths[0];
@@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
 	struct tb_property *p;
 
 	dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, dir != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dir);
 
 	p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
 	KUNIT_ASSERT_TRUE(test, !p);
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
 
 	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
 	KUNIT_ASSERT_TRUE(test, !p);
 
 	p = tb_property_find(dir, "network", TB_PROPERTY_TYPE_DIRECTORY);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 
 	network_dir = p->value.dir;
 	KUNIT_EXPECT_TRUE(test, uuid_equal(network_dir->uuid, &network_dir_uuid));
 
 	p = tb_property_find(network_dir, "prtcid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcvers", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcrevs", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcstns", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x0);
 
 	p = tb_property_find(network_dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
@@ -2558,7 +2558,7 @@ static void tb_test_property_format(struct kunit *test)
 	int ret, i;
 
 	dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, dir != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dir);
 
 	ret = tb_property_format_dir(dir, NULL, 0);
 	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
@@ -2566,7 +2566,7 @@ static void tb_test_property_format(struct kunit *test)
 	block_len = ret;
 
 	block = kunit_kzalloc(test, block_len * sizeof(u32), GFP_KERNEL);
-	KUNIT_ASSERT_TRUE(test, block != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, block);
 
 	ret = tb_property_format_dir(dir, block, block_len);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -2584,10 +2584,10 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 	int n1, n2, i;
 
 	if (d1->uuid) {
-		KUNIT_ASSERT_TRUE(test, d2->uuid != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, d2->uuid);
 		KUNIT_ASSERT_TRUE(test, uuid_equal(d1->uuid, d2->uuid));
 	} else {
-		KUNIT_ASSERT_TRUE(test, d2->uuid == NULL);
+		KUNIT_ASSERT_NOT_NULL(test, d2->uuid);
 	}
 
 	n1 = 0;
@@ -2606,9 +2606,9 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 	p2 = NULL;
 	for (i = 0; i < n1; i++) {
 		p1 = tb_property_get_next(d1, p1);
-		KUNIT_ASSERT_TRUE(test, p1 != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, p1);
 		p2 = tb_property_get_next(d2, p2);
-		KUNIT_ASSERT_TRUE(test, p2 != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, p2);
 
 		KUNIT_ASSERT_STREQ(test, &p1->key[0], &p2->key[0]);
 		KUNIT_ASSERT_EQ(test, p1->type, p2->type);
@@ -2616,14 +2616,14 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 
 		switch (p1->type) {
 		case TB_PROPERTY_TYPE_DIRECTORY:
-			KUNIT_ASSERT_TRUE(test, p1->value.dir != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.dir != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.dir);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.dir);
 			compare_dirs(test, p1->value.dir, p2->value.dir);
 			break;
 
 		case TB_PROPERTY_TYPE_DATA:
-			KUNIT_ASSERT_TRUE(test, p1->value.data != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.data != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.data);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.data);
 			KUNIT_ASSERT_TRUE(test,
 				!memcmp(p1->value.data, p2->value.data,
 					p1->length * 4)
@@ -2631,8 +2631,8 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 			break;
 
 		case TB_PROPERTY_TYPE_TEXT:
-			KUNIT_ASSERT_TRUE(test, p1->value.text != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.text != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.text);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.text);
 			KUNIT_ASSERT_STREQ(test, p1->value.text, p2->value.text);
 			break;
 
@@ -2654,10 +2654,10 @@ static void tb_test_property_copy(struct kunit *test)
 	int ret, i;
 
 	src = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, src != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, src);
 
 	dst = tb_property_copy_dir(src);
-	KUNIT_ASSERT_TRUE(test, dst != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dst);
 
 	/* Compare the structures */
 	compare_dirs(test, src, dst);
@@ -2667,7 +2667,7 @@ static void tb_test_property_copy(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block = kunit_kzalloc(test, sizeof(root_directory), GFP_KERNEL);
-	KUNIT_ASSERT_TRUE(test, block != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, block);
 
 	ret = tb_property_format_dir(dst, block, ARRAY_SIZE(root_directory));
 	KUNIT_EXPECT_TRUE(test, !ret);
-- 
2.35.0.263.gb82422642f-goog

