Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12F14AD81B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 13:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiBHMEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 07:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiBHMEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 07:04:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901A3C03FEC0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 04:04:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m4so51704579ejb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 04:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1Ynaws2GY/+Lh+Uv+SX/Dhjyk5BDPTdOy3iEgoGago0=;
        b=dV/6aqwBTE1nE53JnnfqdItmumlNz59N2ADTV2WNdnk9cTuwNXZikQfWb28NoCGmGy
         GuQk8fJopAmBpiNQyN6dtxD7jwfxbejZqJdWqc1ZHsT0GKvzSXEJP1e2uvDP5n6IrKqN
         oLCzJHzBnAgBZu8l5fkzaPnDf2EX0JOxJuWvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1Ynaws2GY/+Lh+Uv+SX/Dhjyk5BDPTdOy3iEgoGago0=;
        b=Z+GlXUJysQ7+TYKAIMC9AaKYM1y71daXWXzeCek1n+0/6I0P4U812mnpbg5zyelEer
         ZyhFCceXONSYgJED1DYQ8/s62zOdvrVA8gH4lz/GjLoJou18LgB6XY4VYvCJcsrJRWxx
         Vk6vfrri+P4amS2Pc6eRnJBkBDwmP1F2a3tu2cy06KJ+CkPMysNde+n3WHD8XaTTWey3
         X7gaqbWjzDvAVYSs2chRmhsGKq43thY7JewblUoRjzT+GnJffHmGsoZiCYOi/y1lPO4W
         gLwQlpN6oPzaA7WZI2O5iWNaZEKwoGklw41l3WMLQ1xHeZJ5dSGS/MXVjfHYtjITi7ZC
         KQLQ==
X-Gm-Message-State: AOAM532bx+9KuRohN0cltFnufWpEGtpwtH3xcExMbquFnM64NGPifXBN
        cQSQiNiMjUjNAMsfgBbrPIYRMjYJVgPExHu1
X-Google-Smtp-Source: ABdhPJzVX4h7CFbWz8c5Kiv7nyRCh01jyfNqcX6+samMHNQ6h7gmHZwRAh8xsZaV5w8WJapl0yw/Zw==
X-Received: by 2002:a17:906:d551:: with SMTP id cr17mr3446219ejc.392.1644321876616;
        Tue, 08 Feb 2022 04:04:36 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id jg24sm835858ejc.90.2022.02.08.04.04.35
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:04:36 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id ka4so51467366ejc.11
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 04:04:35 -0800 (PST)
X-Received: by 2002:a17:906:6a20:: with SMTP id qw32mr3393699ejc.40.1644321874965;
 Tue, 08 Feb 2022 04:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208114541.2046909-1-ribalda@chromium.org> <20220208114541.2046909-3-ribalda@chromium.org>
In-Reply-To: <20220208114541.2046909-3-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 8 Feb 2022 13:04:23 +0100
X-Gmail-Original-Message-ID: <CANiDSCsz_QBXfvXJ7o3KKeUoHckCcdx18tkM4vD4Y3x-2NDXrA@mail.gmail.com>
Message-ID: <CANiDSCsz_QBXfvXJ7o3KKeUoHckCcdx18tkM4vD4Y3x-2NDXrA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] thunderbolt: test: use NULL macros
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel

On Tue, 8 Feb 2022 at 12:45, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the NULL checks with the more specific and idiomatic NULL macros.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Just realised that you ACKed by, not Reviewed-by. Will fix if I need
to send a v5.
Sorry about that

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/thunderbolt/test.c | 130 ++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> index 1f69bab236ee..f5bf8d659db4 100644
> --- a/drivers/thunderbolt/test.c
> +++ b/drivers/thunderbolt/test.c
> @@ -796,9 +796,9 @@ static void tb_test_path_not_connected(struct kunit *test)
>         up = &dev2->ports[9];
>
>         path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
> -       KUNIT_ASSERT_TRUE(test, path == NULL);
> +       KUNIT_ASSERT_NULL(test, path);
>         path = tb_path_alloc(NULL, down, 8, up, 8, 1, "PCIe Down");
> -       KUNIT_ASSERT_TRUE(test, path == NULL);
> +       KUNIT_ASSERT_NULL(test, path);
>  }
>
>  struct hop_expectation {
> @@ -847,7 +847,7 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
>         up = &dev->ports[9];
>
>         path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -909,7 +909,7 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
>         out = &dev->ports[13];
>
>         path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -989,7 +989,7 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
>         out = &dev3->ports[13];
>
>         path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -1069,7 +1069,7 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
>         out = &host->ports[5];
>
>         path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -1161,7 +1161,7 @@ static void tb_test_path_mixed_chain(struct kunit *test)
>         out = &dev4->ports[13];
>
>         path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -1253,7 +1253,7 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
>         out = &host->ports[5];
>
>         path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
> -       KUNIT_ASSERT_TRUE(test, path != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, path);
>         KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
>         for (i = 0; i < ARRAY_SIZE(test_data); i++) {
>                 const struct tb_port *in_port, *out_port;
> @@ -1297,7 +1297,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
>         down = &host->ports[8];
>         up = &dev1->ports[9];
>         tunnel1 = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel1);
>         KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_PCI);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
> @@ -1312,7 +1312,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
>         down = &dev1->ports[10];
>         up = &dev2->ports[9];
>         tunnel2 = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel2);
>         KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_PCI);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
> @@ -1349,7 +1349,7 @@ static void tb_test_tunnel_dp(struct kunit *test)
>         out = &dev->ports[13];
>
>         tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
> @@ -1395,7 +1395,7 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
>         out = &dev4->ports[14];
>
>         tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
> @@ -1445,7 +1445,7 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
>         out = &dev5->ports[13];
>
>         tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
> @@ -1510,7 +1510,7 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
>         out = &dev12->ports[13];
>
>         tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
> @@ -1566,7 +1566,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
>         down = &host->ports[12];
>         up = &dev1->ports[16];
>         tunnel1 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel1);
>         KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_USB3);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
> @@ -1581,7 +1581,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
>         down = &dev1->ports[17];
>         up = &dev2->ports[16];
>         tunnel2 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel2);
>         KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_USB3);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
> @@ -1628,7 +1628,7 @@ static void tb_test_tunnel_port_on_path(struct kunit *test)
>         out = &dev5->ports[13];
>
>         dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, dp_tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
>
>         KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
>         KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, out));
> @@ -1685,7 +1685,7 @@ static void tb_test_tunnel_dma(struct kunit *test)
>         port = &host->ports[1];
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
> @@ -1728,7 +1728,7 @@ static void tb_test_tunnel_dma_rx(struct kunit *test)
>         port = &host->ports[1];
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 2);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
> @@ -1765,7 +1765,7 @@ static void tb_test_tunnel_dma_tx(struct kunit *test)
>         port = &host->ports[1];
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 2, -1, -1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
> @@ -1811,7 +1811,7 @@ static void tb_test_tunnel_dma_chain(struct kunit *test)
>         nhi = &host->ports[7];
>         port = &dev2->ports[3];
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
>         KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
> @@ -1857,7 +1857,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
>         port = &host->ports[1];
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, 15, 1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, 15, 1));
>         KUNIT_ASSERT_FALSE(test, tb_tunnel_match_dma(tunnel, 8, 1, 15, 1));
> @@ -1873,7 +1873,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
>         tb_tunnel_free(tunnel);
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, -1, -1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, -1, -1));
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, -1, -1, -1));
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, 1, -1, -1));
> @@ -1885,7 +1885,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
>         tb_tunnel_free(tunnel);
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 11);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, 11));
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, -1));
>         KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, -1, 11));
> @@ -1910,7 +1910,7 @@ static void tb_test_credit_alloc_legacy_not_bonded(struct kunit *test)
>         down = &host->ports[8];
>         up = &dev->ports[9];
>         tunnel = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
>
>         path = tunnel->paths[0];
> @@ -1943,7 +1943,7 @@ static void tb_test_credit_alloc_legacy_bonded(struct kunit *test)
>         down = &host->ports[8];
>         up = &dev->ports[9];
>         tunnel = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
>
>         path = tunnel->paths[0];
> @@ -1976,7 +1976,7 @@ static void tb_test_credit_alloc_pcie(struct kunit *test)
>         down = &host->ports[8];
>         up = &dev->ports[9];
>         tunnel = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
>
>         path = tunnel->paths[0];
> @@ -2010,7 +2010,7 @@ static void tb_test_credit_alloc_dp(struct kunit *test)
>         out = &dev->ports[14];
>
>         tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
>
>         /* Video (main) path */
> @@ -2053,7 +2053,7 @@ static void tb_test_credit_alloc_usb3(struct kunit *test)
>         down = &host->ports[12];
>         up = &dev->ports[16];
>         tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
>
>         path = tunnel->paths[0];
> @@ -2087,7 +2087,7 @@ static void tb_test_credit_alloc_dma(struct kunit *test)
>         port = &dev->ports[3];
>
>         tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
> -       KUNIT_ASSERT_TRUE(test, tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel);
>         KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
>
>         /* DMA RX */
> @@ -2141,7 +2141,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
>          * remaining 1 and then we run out of buffers.
>          */
>         tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
> -       KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel1);
>         KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
>
>         path = tunnel1->paths[0];
> @@ -2159,7 +2159,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
>
>         tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
> -       KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel2);
>         KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
>
>         path = tunnel2->paths[0];
> @@ -2177,7 +2177,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
>
>         tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
> -       KUNIT_ASSERT_TRUE(test, tunnel3 == NULL);
> +       KUNIT_ASSERT_NULL(test, tunnel3);
>
>         /*
>          * Release the first DMA tunnel. That should make 14 buffers
> @@ -2186,7 +2186,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
>         tb_tunnel_free(tunnel1);
>
>         tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
> -       KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, tunnel3);
>
>         path = tunnel3->paths[0];
>         KUNIT_ASSERT_EQ(test, path->path_length, 2);
> @@ -2216,7 +2216,7 @@ static struct tb_tunnel *TB_TEST_PCIE_TUNNEL(struct kunit *test,
>         down = &host->ports[8];
>         up = &dev->ports[9];
>         pcie_tunnel = tb_tunnel_alloc_pci(NULL, up, down);
> -       KUNIT_ASSERT_TRUE(test, pcie_tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, pcie_tunnel);
>         KUNIT_ASSERT_EQ(test, pcie_tunnel->npaths, (size_t)2);
>
>         path = pcie_tunnel->paths[0];
> @@ -2246,7 +2246,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL1(struct kunit *test,
>         in = &host->ports[5];
>         out = &dev->ports[13];
>         dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, dp_tunnel1 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
>         KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
>
>         path = dp_tunnel1->paths[0];
> @@ -2283,7 +2283,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL2(struct kunit *test,
>         in = &host->ports[6];
>         out = &dev->ports[14];
>         dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, dp_tunnel2 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
>         KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
>
>         path = dp_tunnel2->paths[0];
> @@ -2320,7 +2320,7 @@ static struct tb_tunnel *TB_TEST_USB3_TUNNEL(struct kunit *test,
>         down = &host->ports[12];
>         up = &dev->ports[16];
>         usb3_tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
> -       KUNIT_ASSERT_TRUE(test, usb3_tunnel != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, usb3_tunnel);
>         KUNIT_ASSERT_EQ(test, usb3_tunnel->npaths, (size_t)2);
>
>         path = usb3_tunnel->paths[0];
> @@ -2350,7 +2350,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL1(struct kunit *test,
>         nhi = &host->ports[7];
>         port = &dev->ports[3];
>         dma_tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
> -       KUNIT_ASSERT_TRUE(test, dma_tunnel1 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dma_tunnel1);
>         KUNIT_ASSERT_EQ(test, dma_tunnel1->npaths, (size_t)2);
>
>         path = dma_tunnel1->paths[0];
> @@ -2380,7 +2380,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL2(struct kunit *test,
>         nhi = &host->ports[7];
>         port = &dev->ports[3];
>         dma_tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
> -       KUNIT_ASSERT_TRUE(test, dma_tunnel2 != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dma_tunnel2);
>         KUNIT_ASSERT_EQ(test, dma_tunnel2->npaths, (size_t)2);
>
>         path = dma_tunnel2->paths[0];
> @@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
>         struct tb_property *p;
>
>         dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> -       KUNIT_ASSERT_TRUE(test, dir != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dir);
>
>         p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
>         KUNIT_ASSERT_TRUE(test, !p);
>
>         p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
>
>         p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
>
>         p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
>
>         p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
>
>         p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
>         KUNIT_ASSERT_TRUE(test, !p);
>
>         p = tb_property_find(dir, "network", TB_PROPERTY_TYPE_DIRECTORY);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>
>         network_dir = p->value.dir;
>         KUNIT_EXPECT_TRUE(test, uuid_equal(network_dir->uuid, &network_dir_uuid));
>
>         p = tb_property_find(network_dir, "prtcid", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
>
>         p = tb_property_find(network_dir, "prtcvers", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
>
>         p = tb_property_find(network_dir, "prtcrevs", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
>
>         p = tb_property_find(network_dir, "prtcstns", TB_PROPERTY_TYPE_VALUE);
> -       KUNIT_ASSERT_TRUE(test, p != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, p);
>         KUNIT_EXPECT_EQ(test, p->value.immediate, 0x0);
>
>         p = tb_property_find(network_dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
> @@ -2558,7 +2558,7 @@ static void tb_test_property_format(struct kunit *test)
>         int ret, i;
>
>         dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> -       KUNIT_ASSERT_TRUE(test, dir != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dir);
>
>         ret = tb_property_format_dir(dir, NULL, 0);
>         KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
> @@ -2566,7 +2566,7 @@ static void tb_test_property_format(struct kunit *test)
>         block_len = ret;
>
>         block = kunit_kzalloc(test, block_len * sizeof(u32), GFP_KERNEL);
> -       KUNIT_ASSERT_TRUE(test, block != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, block);
>
>         ret = tb_property_format_dir(dir, block, block_len);
>         KUNIT_EXPECT_EQ(test, ret, 0);
> @@ -2584,10 +2584,10 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
>         int n1, n2, i;
>
>         if (d1->uuid) {
> -               KUNIT_ASSERT_TRUE(test, d2->uuid != NULL);
> +               KUNIT_ASSERT_NOT_NULL(test, d2->uuid);
>                 KUNIT_ASSERT_TRUE(test, uuid_equal(d1->uuid, d2->uuid));
>         } else {
> -               KUNIT_ASSERT_TRUE(test, d2->uuid == NULL);
> +               KUNIT_ASSERT_NULL(test, d2->uuid);
>         }
>
>         n1 = 0;
> @@ -2606,9 +2606,9 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
>         p2 = NULL;
>         for (i = 0; i < n1; i++) {
>                 p1 = tb_property_get_next(d1, p1);
> -               KUNIT_ASSERT_TRUE(test, p1 != NULL);
> +               KUNIT_ASSERT_NOT_NULL(test, p1);
>                 p2 = tb_property_get_next(d2, p2);
> -               KUNIT_ASSERT_TRUE(test, p2 != NULL);
> +               KUNIT_ASSERT_NOT_NULL(test, p2);
>
>                 KUNIT_ASSERT_STREQ(test, &p1->key[0], &p2->key[0]);
>                 KUNIT_ASSERT_EQ(test, p1->type, p2->type);
> @@ -2616,14 +2616,14 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
>
>                 switch (p1->type) {
>                 case TB_PROPERTY_TYPE_DIRECTORY:
> -                       KUNIT_ASSERT_TRUE(test, p1->value.dir != NULL);
> -                       KUNIT_ASSERT_TRUE(test, p2->value.dir != NULL);
> +                       KUNIT_ASSERT_NOT_NULL(test, p1->value.dir);
> +                       KUNIT_ASSERT_NOT_NULL(test, p2->value.dir);
>                         compare_dirs(test, p1->value.dir, p2->value.dir);
>                         break;
>
>                 case TB_PROPERTY_TYPE_DATA:
> -                       KUNIT_ASSERT_TRUE(test, p1->value.data != NULL);
> -                       KUNIT_ASSERT_TRUE(test, p2->value.data != NULL);
> +                       KUNIT_ASSERT_NOT_NULL(test, p1->value.data);
> +                       KUNIT_ASSERT_NOT_NULL(test, p2->value.data);
>                         KUNIT_ASSERT_TRUE(test,
>                                 !memcmp(p1->value.data, p2->value.data,
>                                         p1->length * 4)
> @@ -2631,8 +2631,8 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
>                         break;
>
>                 case TB_PROPERTY_TYPE_TEXT:
> -                       KUNIT_ASSERT_TRUE(test, p1->value.text != NULL);
> -                       KUNIT_ASSERT_TRUE(test, p2->value.text != NULL);
> +                       KUNIT_ASSERT_NOT_NULL(test, p1->value.text);
> +                       KUNIT_ASSERT_NOT_NULL(test, p2->value.text);
>                         KUNIT_ASSERT_STREQ(test, p1->value.text, p2->value.text);
>                         break;
>
> @@ -2654,10 +2654,10 @@ static void tb_test_property_copy(struct kunit *test)
>         int ret, i;
>
>         src = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> -       KUNIT_ASSERT_TRUE(test, src != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, src);
>
>         dst = tb_property_copy_dir(src);
> -       KUNIT_ASSERT_TRUE(test, dst != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, dst);
>
>         /* Compare the structures */
>         compare_dirs(test, src, dst);
> @@ -2667,7 +2667,7 @@ static void tb_test_property_copy(struct kunit *test)
>         KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
>
>         block = kunit_kzalloc(test, sizeof(root_directory), GFP_KERNEL);
> -       KUNIT_ASSERT_TRUE(test, block != NULL);
> +       KUNIT_ASSERT_NOT_NULL(test, block);
>
>         ret = tb_property_format_dir(dst, block, ARRAY_SIZE(root_directory));
>         KUNIT_EXPECT_TRUE(test, !ret);
> --
> 2.35.0.263.gb82422642f-goog
>


-- 
Ricardo Ribalda
