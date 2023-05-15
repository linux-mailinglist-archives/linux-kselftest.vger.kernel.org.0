Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA7702E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbjEON1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbjEON1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:27:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84F1BF0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:27:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9203:ad00:2382:dff5:d060:ac62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86F6666031D7;
        Mon, 15 May 2023 14:27:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684157233;
        bh=vOlks2OLKky5ea5WAgGEUwwRzBCm2PEAFIwJlQc8jIU=;
        h=From:To:Cc:Subject:Date:From;
        b=TOPi2pan0U9U2ttB6HXYHEERhXGkTfoQwlNhW7nHH4CUJsBu0mQKf7P+RA9XXKYSG
         1As4WZhw0PzhpNIEg/RNIhl6G+iRfFuWqkitQhsDVKJeScNYsVb+qw9PQ8d8ixdL/0
         42Wpf6HJ/U4XByOigCmhOEggXyqkLY/ffzE1U2KDvf6jdBdcw/h5RMgsv4h45E0dKu
         4rkmCrbJ5nYnDqXeS7/UA+iTmk0tV2WCIrXCq41HBIaDBilhgcMj2vk1+VYcMjNTbq
         TJrKrGEVCfXptrgQl1VusQj3w09s5VWwBaQXYGbpedq955uoMQ5yZaDnOkHVQ2GcTE
         Rq1swdIw6THiQ==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kernel@collabora.com,
        naresh.kamboju@linaro.org, dan.carpenter@linaro.org
Subject: [PATCH] selftests/mincore: fix skip condition for check_huge_pages test
Date:   Mon, 15 May 2023 15:26:43 +0200
Message-Id: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The check_huge_pages test was failing instead of skipping on qemu-armv7
because the skip condition wasn't handled properly. Add an additional
check to fix it.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com
---
 tools/testing/selftests/mincore/mincore_selftest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 4c88238fc8f0..6fb3eea5b6ee 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -150,8 +149,8 @@ TEST(check_huge_pages)
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 		-1, 0);
 	if (addr == MAP_FAILED) {
-		if (errno == ENOMEM)
-			SKIP(return, "No huge pages available.");
+		if (errno == ENOMEM || errno == EINVAL)
+			SKIP(return, "No huge pages available or CONFIG_HUGETLB_PAGE disabled.");
 		else
 			TH_LOG("mmap error: %s", strerror(errno));
 	}
-- 
2.25.1

