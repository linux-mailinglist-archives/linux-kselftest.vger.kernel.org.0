Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0775AC4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGTKsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGTKsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C71726;
        Thu, 20 Jul 2023 03:48:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso4904175e9.2;
        Thu, 20 Jul 2023 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689850097; x=1690454897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz2Sq0S+RXTbDpe9ecyzrk2o3BfrHc1B7uV4sD294ak=;
        b=loptYpAXNpFv0UzT4EsQ7SlIaYQ2/6hrwYsrM1Sv37QjPXVP/8jSQXbo2fVrM65g2A
         xP8NDYXIM2oqX1KqnV92D5kQoQzFUgOdrPMQqkLCBElaCnLgPxkJAMW1t/Z1F3rIWDdj
         /u0oTmwztDWwwhSxIvNdVr+OqiPuiDePJtFtLivNkw1BDh90ixVnbaq9R31M27+HUvdx
         44AapSy4jete34LLVB4qSEMRZGPZtD1vTgdbYTkShl8DPKNI2piSJdlKnoPgqsy/Omfd
         uEd65ZQqOpFvk0cN/oRBs9qUTaakYGpcTgsFMFxWmfczuxNazW34hHtizlTFk6CU7IjG
         1E8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689850097; x=1690454897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz2Sq0S+RXTbDpe9ecyzrk2o3BfrHc1B7uV4sD294ak=;
        b=JsoXCdI75xU0kvM9b5KWsnAopMKbObaSUUAcGbzlbEWqFbAxcHfvMFcXxFmaTCBn8N
         +Wj73moPC3Jkifg6QLoMMtMbnxeYLL8DsIWrDRk4t+dlY5WF+18Yns3ncszAySnpMba1
         yJd4epQtBh5c6xsSmJ7ie2+kGkOjk5+oeGsTC7Nq1Log6Z4VvUC10JpNm31Y2p8H3TOX
         3c5gC7c88STWIUkcFSE/AnBMJfb0Qq25L7AjEKsRdFH6AuWSi71fXtQGBoNHi/JOcj9d
         keUcToSkj6XUeZEx/0X1k5b0YAO+pvCJQJjyj5sr8oQ6KuKELdyeB9jiEEyXmE/12J4Z
         mabQ==
X-Gm-Message-State: ABy/qLa+8UWYF3hU8GH1jarryEGEhbgnodriMJNeHhUt3PZtl8HLOxw6
        8h+XaLjmXXA38B60bXGV3vM=
X-Google-Smtp-Source: APBJJlFa2N27wsuW7LwOxH+2o4ECxN+x3FVslcpd52LhxX4ODZMoN3kZnKpZRv5TSJFEP1CssvKYQA==
X-Received: by 2002:a05:600c:2150:b0:3fb:be07:5343 with SMTP id v16-20020a05600c215000b003fbbe075343mr4322704wml.27.1689850096684;
        Thu, 20 Jul 2023 03:48:16 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003fbc0a49b57sm893454wma.6.2023.07.20.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:48:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/xsk: Fix spelling mistake "querrying" -> "querying"
Date:   Thu, 20 Jul 2023 11:48:15 +0100
Message-Id: <20230720104815.123146-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 3ff436706640..2827f2d7cf30 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2076,7 +2076,7 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
-		ksft_print_msg("Error querrying XDP capabilities\n");
+		ksft_print_msg("Error querying XDP capabilities\n");
 		exit_with_error(-err);
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
-- 
2.39.2

