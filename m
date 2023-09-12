Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7779CA2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 10:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjILIil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjILIil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 04:38:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A945E7A;
        Tue, 12 Sep 2023 01:38:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991c786369cso709125266b.1;
        Tue, 12 Sep 2023 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694507915; x=1695112715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5WzW7udVB3HdwrirrUGrjvkqjfIkPOdv3DY3SpLmXk=;
        b=kprj7FtczO5+01Xw1n/tLGqFrn4h+aI1W4RCgmCVk+sgHNEZc0gI6y5r8U/p2JwwW5
         ijqy/USEumr+x1/XvTAv1GXBTosc4MM0GtlQafqXNg8c74CNffK7KHZatwRgFQhTDHwW
         ScZv7b/m1d2fmkZWNakXFByd5l9XhcMF4uey2lA/6ojOa2AkvQ8zeMOiaSVfI4KDesLN
         Hnh7K1zD1SrDjHh7CX5mk1LYnzRQrbTwRqB4PowqDm4CAhigzyH9SiC793x3A5UD2ODu
         HPXUiBGU7VLYLtGEMtKlVYdJZdvHx/3YF9NPODYyrspCwmX0Ck8LuIxnK0IjItnegm+D
         6JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507915; x=1695112715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5WzW7udVB3HdwrirrUGrjvkqjfIkPOdv3DY3SpLmXk=;
        b=qZVBYYtIWwEVInH8hGiAszcRGWrrxYKTMKvIh9AfBZzwvUx2pqAXoi2vZekPPrKULZ
         1rJmLgkn6Lv5O6PO9JMahv7ewml6u4zQ04w4F2rmB1XCnNYT+SWIqmRXxilKygvUfdKK
         cru2aCXDZ6wYWVAAKrqmX3OLesRJZ9zsg8fmkn/hKNGYzuYIpR9hFVwws4FZbV9Ee0Of
         3DpfXu/2f9KGASMg23A0dAAH0UPFjGXtmoNXL1JB6+1Ef/uMLwy1cSD6sfsB3NBQ7eXU
         q259zZXsZ+D4Yx2hhrqJf/415NOcTNuwoVpNNKyODPZIvQuJ1KHoDWDEPOVwVZV5TsRd
         JcsA==
X-Gm-Message-State: AOJu0YyIX7ggiTBoYhauachN8gbtAAnpMFPW0CtSK20Rd1nexbuHD+rj
        +K3BHh3g/imOtuxROr+GhL4=
X-Google-Smtp-Source: AGHT+IEwPItuktnWOR0gh0mbE4XlHJQpgYLFMu1sfdxplQaopwaTpT2qalC3/qPX5N1G4uxUV65OHA==
X-Received: by 2002:a17:906:5350:b0:9aa:1020:8c39 with SMTP id j16-20020a170906535000b009aa10208c39mr8166508ejo.18.1694507915324;
        Tue, 12 Sep 2023 01:38:35 -0700 (PDT)
Received: from lelloman-5950.. (host-87-10-35-251.retail.telecomitalia.it. [87.10.35.251])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b0099b76c3041csm6511726eja.7.2023.09.12.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:38:34 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     dan.carpenter@linaro.org, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH] selftests: cgroup: fix test_zswap error path and meaningless check
Date:   Tue, 12 Sep 2023 10:38:00 +0200
Message-Id: <20230912083800.57435-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace destruction paths with simple returns before the test cgroup is
created, there is nothing to free or destroy at that point.

Remove pointless check, stored_pages is a size_t and cannot be < 0.

Fixes: a549f9f31561 ("selftests: cgroup: add test_zswap with no kmem bypass test")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 49def87a909b..5257106776d5 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -178,10 +178,10 @@ static int test_no_kmem_bypass(const char *root)
 
 	/* Set up test memcg */
 	if (cg_write(root, "cgroup.subtree_control", "+memory"))
-		goto out;
+		return KSFT_FAIL;
 	test_group = cg_name(root, "kmem_bypass_test");
 	if (!test_group)
-		goto out;
+		return KSFT_FAIL;
 
 	/* Spawn memcg child and wait for it to allocate */
 	set_min_free_kb(min_free_kb_low);
@@ -208,8 +208,6 @@ static int test_no_kmem_bypass(const char *root)
 		free(trigger_allocation);
 		if (get_zswap_stored_pages(&stored_pages))
 			break;
-		if (stored_pages < 0)
-			break;
 		/* If memory was pushed to zswap, verify it belongs to memcg */
 		if (stored_pages > stored_pages_threshold) {
 			int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
-- 
2.34.1

