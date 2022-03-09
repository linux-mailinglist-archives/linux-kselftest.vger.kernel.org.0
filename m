Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9FA4D2E89
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiCIMBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 07:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiCIMBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 07:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E310075C
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 04:00:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C3D06190D
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 12:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAB1C340F5;
        Wed,  9 Mar 2022 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646827204;
        bh=ShIBATOODCLF6f7ab34iknbp1vswlDy8eIw8Vvx7nl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ulu0LLrD8e2xNBkaXDnfqt/aAPW2SyMLJM4FB7CkpNTRl7qh3wqo5cNqidWAfYJ+q
         TZJXhHAjK1YIgTFa8w2NBaM2acvue70Xmo7NvqSEBiDb7XYgDSA23zXQ7gz97AeG4v
         wReeG2ahEo1eoFtGpH55B244HzMexVh9IedaWfzFdP7ur//jkXoVZwFiOrkeUzobR6
         89q8r22r69OFdPIStf1xlfcEB20qI6YrR46uPUw6iiltZfCPLIvV+KQUuEg7BpaLRj
         NV+FmKvOEXiF3aW1QozFzWhsz3NUZsRwNw6vkC1tMUoJXG8ZPt58n1VUXW84DQ8adR
         FWmueHPdPWJJg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
Date:   Wed,  9 Mar 2022 11:59:16 +0000
Message-Id: <20220309115918.22469-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309115918.22469-1-broonie@kernel.org>
References: <20220309115918.22469-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; h=from:subject; bh=ShIBATOODCLF6f7ab34iknbp1vswlDy8eIw8Vvx7nl0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKJaTxnXbzoI6bSlH27xH6SBI5RY/EfC3j2GtSasI myU2UI6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYiiWkwAKCRAk1otyXVSH0F3aB/ 9Y4laTrOBcGmGGx7/JSK5sZlfLqdJyzyLcn9C6T2UUTiah2Mzd90iqwoEHV1c+C7QCPvbBoXkifKD9 kEYZFZhRsI02V1DxJzAAEZDAPfVIL+Rt3kaKUCQ72XQpWR92y6iPM45CZKxE2RVdjMRzHPfSyvXl3u RVF2CE8WN0UCbVAumWDbhgIG8By8QvQSBpP0eLkPsgcIX5hsT5fB74BHBqLUYa+Q4Pc3cKv7zp+pfu pskro6G4TBmNepdfOjsqjbHkznUwtmJGw5LZ/jpOctybHp1FOX2PXK/cXawuU32wnVdwdXxkHt/MBq DldHnVvPNWVclcZ/a1gByiP8wM4zfO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The comment for ptrace_sve_get_fpsimd_data() doesn't describe what the test
does at all, fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index a3c1e67441f9..6b139d5f67f1 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -397,7 +397,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
 	free(write_buf);
 }
 
-/* Validate attempting to set SVE data and read SVE data */
+/* Validate attempting to set SVE data and read it via the FPSIMD regset */
 static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 					   const struct vec_type *type,
 					   unsigned int vl)
-- 
2.30.2

