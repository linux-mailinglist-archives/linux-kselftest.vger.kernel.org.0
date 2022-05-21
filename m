Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40A52FB11
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354902AbiEULMu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354487AbiEULMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD303617B;
        Sat, 21 May 2022 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/GqEVHzCeGmnHEwCJ5d9fnnW3FSeEfNTvrJLua2eLiM=;
  b=dH7s7ZRozr+Wa2TmhlucZ/VjO3wxam0VR19m8ZnfkekvfKMSBlvG9Fdl
   gT1NaLNGnydRPsjxkgbKbsLpPBiU/Si4gTOcD5PLYNNLcMFBRoPJiMCWI
   o7R8dUKY2X4vzlnPSU2uEIx7Y3VhYn69aTK8avMX7umPuH5nUK2uTR+7a
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727942"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:00 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Shuah Khan <shuah@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: sync: fix typo in comment
Date:   Sat, 21 May 2022 13:10:55 +0200
Message-Id: <20220521111145.81697-45-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 tools/testing/selftests/sync/sync_stress_parallelism.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sync/sync_stress_parallelism.c b/tools/testing/selftests/sync/sync_stress_parallelism.c
index e6c9be671dfc..6ce56ca204c4 100644
--- a/tools/testing/selftests/sync/sync_stress_parallelism.c
+++ b/tools/testing/selftests/sync/sync_stress_parallelism.c
@@ -87,7 +87,7 @@ int test_stress_two_threads_shared_timeline(void)
 
 	/*
 	 * Use a single timeline to synchronize two threads
-	 * hammmering on the same counter.
+	 * hammering on the same counter.
 	 */
 
 	pthread_create(&a, NULL, (void *(*)(void *))

