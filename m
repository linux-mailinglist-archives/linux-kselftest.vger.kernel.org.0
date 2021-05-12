Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B37337BF60
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhELOIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhELOIO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 10:08:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F9C061574;
        Wed, 12 May 2021 07:07:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gx5so35140381ejb.11;
        Wed, 12 May 2021 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5LF26CKutDtZq53l+W30hpY63jIDvW7jhu+eoEl2ew=;
        b=ZnhUVQ9JVwJAKPCJ5gOrkoLqfQ5MdoigO+F6uo0DG1I9ymh1HS+pCVo1dSSSGX8JWB
         HLl0O2B7u3WlbEaa6gzPEwsdFCXnxkzmmk3lQWz2zwOpoLtZAUmYTxlikPejW9WF/3T1
         sv1JWJQrEq7y2g/DgStmhN0YE4IIlIOS7Q9jD+3H8l42GXiwqRKi+hh/6iQ4SG+3RUDX
         unHt0FwgOo+gw9KducW7162dUZjoMWrxdJbxQSv7OAA9c6iAVNVoBUtbLPEwBsajfdFM
         tt4Nt2OdewldT99E9o3c6neqIYwfRzmlU9T3Pu8FdrWsMTpnIo0csYxwJ/JIF2lee1WX
         elrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5LF26CKutDtZq53l+W30hpY63jIDvW7jhu+eoEl2ew=;
        b=S28Ocsxw3cG6936eimng867f1aSULyBcbzWkyvgS9VIsKm7ASkKsGAuA+lBJCCqNi+
         +96y3AIs7wYacdv5/F77Q20zJy4ve2zKb3mIab1pcmF7EWUQoIoK6Rzk6svRXjHFGD2O
         H+15bsS77VyUGWnfCPrl3Y5ZOp67KCd/RVusVpBVZ2Ngo1nfWYjoRg5s0frfM2hDVQ8L
         rXbtT3Hm5soHqBz9rKiJpaIk8Lo5wP+/sxWKWWlgYyJmQURN/IkK7HyliiLclXW3P/JT
         iLlRawQOTecp8SoNX3psxfPx7kG/jo6TNKrZBm78sNkok+BoIN5SSuyLhKdHWqWMHU0U
         ohXQ==
X-Gm-Message-State: AOAM532+TNOP4ty4u0WtzWJeLIsxNY2muo8sdBXAgjL3WKpl1tu5S4pE
        tK+ZThHuezbysEhCQ+mG4Cg=
X-Google-Smtp-Source: ABdhPJwH/iByVw+CnvRUG344WyGXRKSmDNAzfjpygkxFPPv9BlK0j9qfLnEWcMifHUCH8SNO/5GqbQ==
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr30608107ejc.132.1620828420320;
        Wed, 12 May 2021 07:07:00 -0700 (PDT)
Received: from localhost.localdomain (ispc-static-34.84-47-111.telekom.sk. [84.47.111.34])
        by smtp.gmail.com with ESMTPSA id k5sm20022874edk.46.2021.05.12.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:06:58 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH] mm/slub, kunit: add a KUnit test for SLUB debugging functionality-fix
Date:   Wed, 12 May 2021 16:06:56 +0200
Message-Id: <20210512140656.12083-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210511150734.3492-2-glittao@gmail.com>
References: <20210511150734.3492-2-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Remove unused function test_exit(), from SLUB KUnit test.

Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 lib/slub_kunit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index f28965f64ef6..8662dc6cb509 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -129,8 +129,6 @@ static int test_init(struct kunit *test)
 	return 0;
 }
 
-static void test_exit(struct kunit *test) {}
-
 static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_clobber_zone),
 
@@ -147,7 +145,6 @@ static struct kunit_case test_cases[] = {
 static struct kunit_suite test_suite = {
 	.name = "slub_test",
 	.init = test_init,
-	.exit = test_exit,
 	.test_cases = test_cases,
 };
 kunit_test_suite(test_suite);
-- 
2.31.1.272.g89b43f80a5

