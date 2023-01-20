Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBA675413
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjATMEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 07:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATMEl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 07:04:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB897CCDB;
        Fri, 20 Jan 2023 04:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1948461DEA;
        Fri, 20 Jan 2023 12:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94DCC433D2;
        Fri, 20 Jan 2023 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674216279;
        bh=4qvBxhVf64pE7B1ZoMsbFgfAbXLEfzqFSMLWRfDt03c=;
        h=From:Subject:Date:To:Cc:From;
        b=N9+QYeQTUUo404XvLUH+olhKdbZ5MAwUQx/W7avWT2EwfzhngoiJbJnGkrem5ElFl
         IAks0NogyJLDiOEBBJ5Sds8l5gSC/KJMaMkPeX+sz2ktMBh/6F5DewQRsAXUtKY7WA
         g+5WgOWBpjjI25sJZS1vxVH9RfqRXX+V4Z3IXHMbNFyudgSMfReuMaDm72Z5mWt3M+
         xQLfEjaUyLCxyAeSrSHYY5HoX+Bvp5rXkENDiwM4soGy51afMitWmPw8eX/iICU/LM
         FEtlFmG1lHOShsWfR/9/cXjlefzZJ+98GMBl0t9HoMS730oaqNa1BBKkAbl0U5dW8X
         65RwW/oZ7Exgg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: Minor SME signals test additions
Date:   Fri, 20 Jan 2023 12:04:08 +0000
Message-Id: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiDymMC/x2NQQrCQAwAv1JyNrC7FVv9inhI02iDuJWk1GLp3
 916nIFhVnAxFYdLtYLJrK5jLhAPFfBA+SGofWFIIdUhxgbJXqcjTuITus+CX8ImppYDS9vzGUr
 YkQt2RpmHPf2M9tz12+Suy/91vW3bD2oewOZ7AAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4qvBxhVf64pE7B1ZoMsbFgfAbXLEfzqFSMLWRfDt03c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjyoNU7i2EbiyqD1tsJ+lWgQpu8mA77w5mXKl7/5id
 Y5NTZ32JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8qDVAAKCRAk1otyXVSH0DjHB/
 4onlib5eKNCL+eq+YFJZHWuhPL4gdSMriAtud6AEnNeA9/kMDLKdU7YwPaa7gTDhz2r4QqJjTZynFI
 0r3oklMfoZ3WVbWnyDTVqg3Z30+CRM5n2fAQ7j/acSEoaY/bTqh78KbuJpjXbN7soLGUAKcOavZ36a
 Me+Z0ynyxGjZeF8o1dd6uq1iQ0nScpcqgDU7y263EwIWqRgixk7uDm0sXk6vBOl1Iy6pOisOromBW/
 VYEGK50yYyc3ew54iKRDYfM5GE2DoAYlEtXALtfqDQumRLsWzeLeLfmofvjyIX5yTr6X0FjBbjHDDI
 NN7fcmWMG/KPmTFRJL4mOGLHcPEv33
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While discussing the SME signal handling support I realised that
we were not verifying that SVE_SIG_FLAG_SM is set for streaming
SVE, and not explicitly covering the case where we are both in
streaming mode and have ZA enabled.  Add coverage of these cases,
I didn't find any problems running these new tests.

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (2):
      kselftest/arm64: Verify that SSVE signal context has SVE_SIG_FLAG_SM set
      kselftest/arm64: Verify simultaneous SSVE and ZA context generation

 .../selftests/arm64/signal/testcases/ssve_regs.c   |   5 +
 .../arm64/signal/testcases/ssve_za_regs.c          | 162 +++++++++++++++++++++
 2 files changed, 167 insertions(+)
---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230117-arm64-test-ssve-za-7128c0ce8dc9

Best regards,
-- 
Mark Brown <broonie@kernel.org>

