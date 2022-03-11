Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91E4D6299
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbiCKNxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 08:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiCKNxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 08:53:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B391C4B37
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 05:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E5DC61E89
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 13:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27249C340E9;
        Fri, 11 Mar 2022 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006718;
        bh=PQY5ZXiEJdvHeBsg8ubhkQxNbXzPgafcIzIDFyGsxY4=;
        h=From:To:Cc:Subject:Date:From;
        b=QA1SRZ8LH1cVrIdW2zka/M8Lc+gO7xEg91G9hO62tV3ST/SbY3d6+hvXPmV2WFtbf
         kNAUMlmTIIeJRrJsWKOTJkDVkFvlIk3pPwVXyA4YQ0Int/UBXyyzb3vuRPQoG+aDTJ
         wEtih4AxxM+36EIphTEykwIlumzvHZb2v+KLQFq3HwVT5h4RfQ2TFASyptulO+mPae
         hZRcTtDFM6DnBwsjfHNX0CplfWdYBWQOGfdoIq3jDShfaHIbVHe2csFZvTFQlzB5zu
         D7KCG7EaDZEXi3HKGd5P+nEmil/OjII1AyxXR/rWJAQJr4eQrEPc3tHXWFDVBFTC7y
         9CrnLWZ5OTBTg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Miscelaneous MTE test updates
Date:   Fri, 11 Mar 2022 13:51:44 +0000
Message-Id: <20220311135148.410366-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; h=from:subject; bh=PQY5ZXiEJdvHeBsg8ubhkQxNbXzPgafcIzIDFyGsxY4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiK1PuD+dVLIrG+XqQ75nBG++h3wPxg54eo5ZiRpMQ lRqJy1CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYitT7gAKCRAk1otyXVSH0J7NB/ 0V8cmMxQlDlSrjV38Lvvx+g+G5I1Ihtt9hernZtFltzAjR3GDrCCjuN5TdyW/A01KRAA+nDVHtokwu cxuuQziVjmonccVDPollCz6ejmqof1HaxUdlVXizidkxx0wNKU4BiUSIcQuwj0IQcyk7BklRVp1dtC iSVcWCiOjO5RgXBWKLq+x6gTRXU+x+ruUiY8nvk42YRDsl9X3vdqfeSePlbGJlCd7Lg6nYEHucgQSk sFylooizOqq/9S7oWiPgx4EogPADoycI7kiTUupziJFqROdQN4itzsuw+XorNK38r73srl4gaGSt9z 8y0hvD+BkV0YIh7k+MgPJtTlzDJWo5
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

This series is just a set of minor tweaks and improvements for the MTE
tests that I did while working on the asymmetric mode support for
userspace which seemed like they might be worth keeping even though the
prctl() for asymmetric mode got removed.

v2:
 - Also log PC and fault address on unexpected async faults.
 - Remove redundant system_has_mte variable.

Mark Brown (4):
  kselftest/arm64: Handle more kselftest result codes in MTE helpers
  kselftest/arm64: Log unexpected asynchronous MTE faults
  kselftest/arm64: Refactor parameter checking in mte_switch_mode()
  kselftest/arm64: Add simple test for MTE prctl

 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../testing/selftests/arm64/mte/check_prctl.c | 119 ++++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.c     |  19 ++-
 .../selftests/arm64/mte/mte_common_util.h     |  15 ++-
 4 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

