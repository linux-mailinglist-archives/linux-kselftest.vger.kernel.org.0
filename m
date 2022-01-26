Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4FF49D11B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiAZRqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 12:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiAZRqF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 12:46:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A3C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 09:46:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BB261A90
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 17:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6503C340E3;
        Wed, 26 Jan 2022 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643219164;
        bh=RzYZzAPS850FeOS1uK0OYrU3jl7In9b5K4YKxnBG+2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=et1LRTrSbrgx4a3AZPzVVvjxh32G0kFXHsuqL/OD5AGd0+gHnFBYuEMw1R3tNdV7O
         99b7qJuYOaje66CfPXv3gj4/ho4qoaUO2n5QMdmJH/AwXUSvYOe5y0S0WDgwP+XAOj
         BIpZT1rYtvMo7VusNb2H53ExWkq7Gd+BVYzAdlIbrwLEwZkb1gBjWwaVaOc4y61TPK
         GQBzCFVTkGtL61vtAofIOV60+tTRvZ061hChsCWMUVywPdMa5OgxIV7aBMX0hC0IGF
         KQXPCwsj66bkg7VT/OMLKdzyJ5sWHV+YT279QX8q1SgDfBX3tp3Kkee1LlhbSxILbC
         YacUwJHKGCeCw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Remove local definitions of MTE prctls
Date:   Wed, 26 Jan 2022 17:44:21 +0000
Message-Id: <20220126174421.1712795-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; h=from:subject; bh=RzYZzAPS850FeOS1uK0OYrU3jl7In9b5K4YKxnBG+2Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8YgQstwPXDTpRJhALuchU1J0rihamTUObSRSa77x oEpnKoyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfGIEAAKCRAk1otyXVSH0Go8B/ 9MSw/KqebjwmIRuUm6Jfr7BQNJnUxFJM6AUSLklVq3Asw50F24b3yeSBOCMPxGkM8Re/g8NV8Fvasv TshoTvNJ+BQ6dNdQYIdeDeVUOCoWzW9T3QhU08M4wCzdN0+yzBRti2kd6HDAeWmhUy+M9wFNyyDB5P cx6+3OAJL8jgHASyup4SUqCxpi5I0viPY8lhuSQAscj6f34U0INhZ7dRjcqjr/eh1jFRyLPrM7aRw9 ZZhkWdv2ZYZMOek9/fVAzvb/N0MY3n02HqsCzQ99oZNj4wFSl6MAN4fC5PHHL+vpKi3zips7i55Whq r2F87ARYH9NcJqRuz+jBjX1YHknr68
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The GCR EL1 test unconditionally includes local definitions of the prctls
it tests. Since not only will the kselftest build infrastructure ensure
that the in tree uapi headers are available but the toolchain being used to
build kselftest may ensure that system uapi headers with MTE support are
available this causes the compiler to warn about duplicate definitions.
Remove these duplicate definitions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/mte/check_gcr_el1_cswitch.c       | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
index a876db1f096a..325bca0de0f6 100644
--- a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
+++ b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
@@ -19,17 +19,6 @@
 #include "kselftest.h"
 #include "mte_common_util.h"
 
-#define PR_SET_TAGGED_ADDR_CTRL 55
-#define PR_GET_TAGGED_ADDR_CTRL 56
-# define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
-# define PR_MTE_TCF_SHIFT	1
-# define PR_MTE_TCF_NONE	(0UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_SYNC	(1UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_ASYNC	(2UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_MASK	(3UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TAG_SHIFT	3
-# define PR_MTE_TAG_MASK	(0xffffUL << PR_MTE_TAG_SHIFT)
-
 #include "mte_def.h"
 
 #define NUM_ITERATIONS		1024
-- 
2.30.2

