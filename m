Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9394D2E8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiCIMBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 07:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiCIMBC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 07:01:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3980BFFFAF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 04:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C9C61900
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 12:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECAC340E8;
        Wed,  9 Mar 2022 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646827202;
        bh=ud566pASr2sJXwRTIqTVnKNvfMO9DsPj/ol6hmquK+4=;
        h=From:To:Cc:Subject:Date:From;
        b=qQQx4u17oJKjjcGoFdQUtohKtNosFNJ9R+KsGSenbzc7+xTq3A4TUknth8p2sZ4c0
         bx/tFRIbsqcZ2fNBkPnSFONVfhDpuiPs1uKib5g4D7Z9RxZHv8EnzcyOkbPEOmEBvA
         sNTT7TJIOXLLkc0dF4BAD4XBak1EvhW8bDEhZkfgj57Q2Re3YKZX2m05pH3eH1uHhc
         UDb5ESjHMA/PiZFl5z9N5XAJHr7qxm9WslIHpvyjnOqfqYQ1ZMChhAWlok+/qRRciJ
         4Xnfzm0GJGVTRRt50uiTOEOURCdBn7Vp6ZQgpcR7pHUSVSGO8RMG2Qto2hVaEPUB9c
         HtEHOtBvxDnZg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] kselftest/arm64: Test ptrace writing via FPSIMD and reading via SVE
Date:   Wed,  9 Mar 2022 11:59:15 +0000
Message-Id: <20220309115918.22469-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; h=from:subject; bh=ud566pASr2sJXwRTIqTVnKNvfMO9DsPj/ol6hmquK+4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKJaSRvIkdM2zBvvaUb+sjB6rB9rtY8KPhKrtbpqj yuELSa+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYiiWkgAKCRAk1otyXVSH0JMVB/ 9T4wIKUXmqm1giQGB2vTneo+3Sxve8j7U7EzKPwGk58lODXIlBUvT5tla1oMpeNT5WBlEvycJFZEF2 YPVeKRCjPHIwzAq0L75Cp2hnyrhsc5qTronA1KVp7IkmLySYn56+AWjKnypbENF58RQ4oC1ltFkfjT BJvb71S4ca6dzvPmqeBzlXcH+6A/DgZQVIifbNbtA+Pwk//nM5YBABvwPYjRcwKq3vT90D1SDnfuPH pwaI1T5Yxby1X93lIoCMmWZVJNxDJUZvY5+xl5hJccKsG0oH3lnlpwBRBiqyQKHu1Vn/w2XjUx/aMb 89bGk8r2cYSowNOwZtak7AN0SsNsgx
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

This series has a couple of minor fixes and cleanups for sve-ptrace plus
the addition of a new test which validates that we can write using the
FPSIMD regset and then read matching data back using the SVE regset -
previously we only validated writing SVE and reading FPSIMD data.

Mark Brown (3):
  kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
  kselftest/arm64: Remove assumption that tasks start FPSIMD only
  kselftest/arm64: Validate setting via FPSIMD and read via SVE regsets

 tools/testing/selftests/arm64/fp/sve-ptrace.c | 164 +++++++++++++++---
 1 file changed, 139 insertions(+), 25 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

