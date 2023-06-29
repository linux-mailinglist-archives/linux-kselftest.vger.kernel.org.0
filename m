Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B574225E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjF2Ilw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF2Iky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 04:40:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210CA3C04;
        Thu, 29 Jun 2023 01:36:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9106:d00:e867:262b:7a75:ba57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A716B660712C;
        Thu, 29 Jun 2023 09:36:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688027774;
        bh=FSB3vdthTDE8QsPbEoftdqOjP9tW5sPqQjMaqelHFQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=MUrmPvAgIuG6PPwwOcNoSthD0vmMKW4iQZeANxzg5ongiPmat12mOfD08OUxgD2px
         MoTWfucH3nD7ZjOrjVDiRdzjpR7lVlabsLTQBf74+Sy5eV31bW3ml3gk7x/0PiiXTP
         ikBCEHC4BQiinXa1XjUBn75ZoCSABOSkHm0E9BhdtcKKY2aWW4DFRyR45czA9uLajT
         AAy2pg1jTIf3pr6/FgWJ05HqPxTspbExgm9hIYwW0TlGyW4mTFGaxIJPahFl1UT0+b
         2sgvv5PVqNVIfrKo8XyyI01lyBgJ5nc0Vx9c0bMvG/3gm4W85kX+igs6npSG43v062
         PIl9ouL72DD9A==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, naresh.kamboju@linaro.org,
        dan.carpenter@linaro.org, skhan@linuxfoundation.org
Subject: [RESEND PATCH] selftests/mincore: fix skip condition for check_huge_pages test
Date:   Thu, 29 Jun 2023 10:35:46 +0200
Message-Id: <20230629083546.3031488-1-ricardo.canuelo@collabora.com>
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
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

