Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8F528CCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiEPSW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiEPSWU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678362BB0D
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04233612FD
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D543FC34100;
        Mon, 16 May 2022 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652725338;
        bh=h1UKXVDVZHoKYKAEdvbohaOWVujO4anm+OwgwbTJU/M=;
        h=From:To:Cc:Subject:Date:From;
        b=S7lWXq/kBitZMD8C5SQcwRC2wJLtv27tdKKE27iyuFUFsjAcDS4hstFk/5+ERwsbQ
         /urf1DK26BQbH0OQ4apBaIvYafA2kXf17JDhxJb2U8RUYVS2rfVO0/x2nxvFYMUsni
         EDz0/mayqWNQco55HSHm2RUYaURVBdxrLoUZ61MiE8PtqgGnvkldDbEeC7UDXwOHub
         i42LAGcxuLZ66MY8UcGCiSKpQMauuPoxku4lO2gqW4lRNe44WsTpJPa5YW7HW2XFay
         ZDtcrS18q6xXhtxmXGITuXpNg0PyavB0EHZ4CObsJipgCkc6kPoozYbvkKWPLB2Xlk
         o1/87bfIMBeIA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] kselftest/arm64: Explicitly build no BTI tests with BTI disabled
Date:   Mon, 16 May 2022 19:22:13 +0100
Message-Id: <20220516182213.727589-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; h=from:subject; bh=h1UKXVDVZHoKYKAEdvbohaOWVujO4anm+OwgwbTJU/M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBigpXoGhDxPoLVEnKcG99ISoCPOyr7aY5fUoDGyoMe z/4z5n+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYoKV6AAKCRAk1otyXVSH0PRYCA CDXprQEokLbp4i1AlReFTvA60xF9/Ci1pnWGdMwFwXr1BTRiGPyhbvwTrpT3d4OrR5with0F3nGC0Q Inj8ClgijyXg1Vhr5ZB/u3idUP7xRoPEeMiTg/mEDZH1fNwY7PE1XKBbF/HCLSV+irZQNa0yCYTnIE yk8Ie4WBTrjUf6Bhewgj5G78l12d43UVPQxEmYjF5YUuNjfqmg/GALZA/KOby2eSdR6B+0kOc9Vvkj OHJMkqWBtgldIo7FRnWYqoKmG59BoB/HPzB0hBbiU+yHyCZtvOqNmj6Vor1WzF0pCmdXklG8X7fo8r O0QWGdAjfVKJKw3hNoOmfjCUIbl1rx
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In case a distribution enables branch protection by default do as we do for
the main kernel and explicitly disable branch protection when building the
test case for having BTI disabled to ensure it doesn't get turned on by the
toolchain defaults.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

v2:
 - Rebase on -next

 tools/testing/selftests/arm64/bti/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/bti/Makefile b/tools/testing/selftests/arm64/bti/Makefile
index 73e013c082a6..25c66e622b86 100644
--- a/tools/testing/selftests/arm64/bti/Makefile
+++ b/tools/testing/selftests/arm64/bti/Makefile
@@ -10,7 +10,7 @@ PROGS := $(patsubst %,gen/%,$(TEST_GEN_PROGS))
 # cases for statically linked and dynamically lined binaries are
 # slightly different.
 
-CFLAGS_NOBTI = -DBTI=0
+CFLAGS_NOBTI = -mbranch-protection=none -DBTI=0
 CFLAGS_BTI = -mbranch-protection=standard -DBTI=1
 
 CFLAGS_COMMON = -ffreestanding -Wall -Wextra $(CFLAGS)
-- 
2.30.2

