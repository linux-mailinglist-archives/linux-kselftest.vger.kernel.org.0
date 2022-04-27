Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7787D511E53
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiD0SX0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244725AbiD0SXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA3856779
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6D061B1C
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCE4C385AF;
        Wed, 27 Apr 2022 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083613;
        bh=KeHxjI3X0KHJ4YKwVGdoQpHrsUbHr5T16xq2vz+3ddM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBhatwDLQAO4qeAhL9w8aLnLHNSQj456s8Bb5MgdWK+LJ3XYVBYcsDwxFcWcgS/YF
         SX7BsjOpTxa/2V1/ZOgOFAHRMG4udYmicBCgslK5OKQqSOJ1HX6OkoGm97RFMaNuv1
         480dFKj+T11JbcUEXvw1+LGCnXxhrD6zpuu2nFW+vpAx4CFZ6fkxfG8lH+eHuf5YJ0
         rxjrz8pqLvmuBAXSVf+1JiPKvHmopw3I2jm3hciQyx2Dmznj9CO8dEsDqZa3gd7aMU
         bLI1n2cHTfkAyQT56fv5swgSLLdvY8btOUJ8xjlb5GNpUOfzQaOkgBLJX0nbHdmhzv
         gqmvzmsQUZjdg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/4] selftests/arm64: Clean the fp helper libraries
Date:   Wed, 27 Apr 2022 19:19:53 +0100
Message-Id: <20220427181954.357975-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427181954.357975-1-broonie@kernel.org>
References: <20220427181954.357975-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; h=from:subject; bh=KeHxjI3X0KHJ4YKwVGdoQpHrsUbHr5T16xq2vz+3ddM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiaYlHtRa4HrvcFyy6aPu897kqHpF4KvhnoI0/VS4u g8sERlGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmmJRwAKCRAk1otyXVSH0Gd8B/ 93X6kmzuItkJLuNqb7/aS8CQH/7pqYwf1cYa9p/9S1UKoKAoY41OGcIw9H0p1cLhZdQK+R4iDzgN+Z 56qUex/Wt1H6XQVshFlAn6U79LAtMgcX8TsQuKrGO+Jq+mqJmuDHjQ5GiKd037IHGXGUOoewjd/VhE Cvwp9AtdGWG3ERht36dpBo1yZH79VwkZv2dVvGlIDkaaO/upnex+zXJEGob96svB7gSweQY9rtwq1T CKKpeJuLiR7+xAlPabMH2JDVRNGAudL4Sj5UgBBmu7mDERdAGZub/fHyIA8n0VjUaudI6Cni4QFGT7 uHVQR4k4B/U5HbMUMeT9FVLwWUq0Tm
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We provide a couple of object files with helpers linked into several of
the test programs, ensure they are cleaned.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index ba758a6c6b9a..7e5d48c4a59d 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -14,6 +14,8 @@ TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	vlset
 TEST_PROGS_EXTENDED := fpsimd-stress sve-stress ssve-stress za-stress
 
+EXTRA_CLEAN += $(OUTPUT)/asm-utils.o $(OUTPUT)/rdvl.o $(OUTPUT)/za-fork-asm.o
+
 # Build with nolibc to avoid effects due to libc's clone() support
 fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-- 
2.30.2

