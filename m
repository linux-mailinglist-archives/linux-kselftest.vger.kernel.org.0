Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF2512052
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiD0SXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiD0SXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4C5675E
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66B161ECE
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80589C385A7;
        Wed, 27 Apr 2022 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083604;
        bh=Y/sj/XPhiO/NGppKYOiD8TvsJyBvGw8/yYSEpGXDcvY=;
        h=From:To:Cc:Subject:Date:From;
        b=Dviq3WbCwYHetH5+fdZCui1h+QdbSH9/vhm0RRCCGlF7yvq5wiSSmjs+wKrru0L1v
         DNO8UYxmUifPMIGBCdNvcioatI6xOamAvInduB0QnRTkue/RoBYF8ktzTcF1xU6tth
         dfoXKyqqmYlNLiLdaRi/CcV5Y5xiMbPeYvrNa40yUoT46oHPiayIxNMEB0/iU3e2tj
         5hgt0Nada7Ww37cLyueuf7Ih84bDe7ov45/fou5/6me2BMkagu50roEnGixkIts2i7
         AzYRpQTu8d6hjoflP8M+e4NTz5WQGdW721YNtjsnBJcH8GjLDx0S22BhRwOLsqlN6h
         esjPOB8qHB02g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] selftests/arm64: Fix O= builds for the FP selftests
Date:   Wed, 27 Apr 2022 19:19:50 +0100
Message-Id: <20220427181954.357975-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=694; h=from:subject; bh=Y/sj/XPhiO/NGppKYOiD8TvsJyBvGw8/yYSEpGXDcvY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiaYlFTlRL8zFlfPTr95xFT4wDjFo54VaG6ZXEQVlo ivih4gWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmmJRQAKCRAk1otyXVSH0L0KB/ 9WqNPI49RX0WyGzQTzX5ZZhQzFBEyli6R8ZC7V7IStJIQTGrpdU/NAabSCWFbnIewRbotWGIo9oUXD ScC0zt792EWYz+qOptK7PmR4Y4q25FgF+25nS7zyod2//ZNR3iWt3c3jDtqXrlsZg4t4N+1Jxjrqwo vmix6EGOXhfH8H8mga6sdiHg88DPgcMOnUfwFQ7dggLWyIXwR9ShN96uNVkzenQOk4FT/eAOGhx3Zd IxD4Ef0OKb+QjcVcvGnHICaWeWFj3F4RGPYqoLRJDttqnyGkjEVTH9QofPmCD6o6mdbEeHLr7j9kJM JwIHGkrZV2b9cikNBTndkwdKqtKrGG
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

Currently the arm64 selftests don't support building with O=, this
series fixes that, bringing them more into line with how the kselftest
Makefiles want to work.

v3:
 - Rebase onto arm64/for-next/core.
v2:
 - Rebase onto v5.18-rc3.

Mark Brown (4):
  selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
  selftests/arm64: Define top_srcdir for the fp tests
  selftests/arm64: Clean the fp helper libraries
  selftests/arm64: Fix O= builds for the floating point tests

 tools/testing/selftests/arm64/fp/Makefile | 49 ++++++++++++-----------
 1 file changed, 26 insertions(+), 23 deletions(-)


base-commit: 5c346f94d2933ba320af8325cfe77fc58c6e537a
-- 
2.30.2

