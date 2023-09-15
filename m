Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8767A1E8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjIOMXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 08:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjIOMXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 08:23:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983D8271F;
        Fri, 15 Sep 2023 05:23:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCC8C433C8;
        Fri, 15 Sep 2023 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694780581;
        bh=ErW/YFbwxN2J3CUnXkc0WWVMAtkcRHHwxqYmA0qC0ao=;
        h=From:Subject:Date:To:Cc:From;
        b=dlQuQ9rT05Y8NXQI7Mc5lvH1kS6/wcf7PhTOCelm27zrCyBd9Yn7G/pnZo4Dn+O9X
         9EcSnpUXZ1OwiLiA0Hivou7tFix8Uyd8Zt7PBOGu/0IDr05+sgTMrNpKzXW/0ImFoi
         +7r7Nkq/bFMgNGuh2w4v2kE0phlGnV0Xn3tZQ4r8SrItNSHVbw1BSlYpaN49cw0AW1
         JPYDC4NyikN/6qMkm8Are8wpwTpwJWXnh4i89Rrh4un09eIpbIcOl5lqfETo1lmQp8
         gE55tPlN5E5WO/UCHPUB5+Ip59qSjsWBwqu8xJSGsjC9Phz7dIDNMcMzV+tF44HBG4
         HElO+HIfK4oag==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] Report FEAT_SVE_B16B16 to userspace
Date:   Fri, 15 Sep 2023 13:18:05 +0100
Message-Id: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1LBGUC/x2MSQqAQAzAviI9W2hV3L4iHlw6WnCjAyKKf3cQc
 skhecCLqXioowdMTvW6b0E4jmCYu20S1DE4JJSkVHGKna15hrcz7DkPoCyEVDK7oSDHWQEhPUy
 cXv+2ad/3A3KZY5JmAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ErW/YFbwxN2J3CUnXkc0WWVMAtkcRHHwxqYmA0qC0ao=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlBEyfr1fhPm8VZAq8TG7GL4gyOzJd0HP5ZOzOgsUg
 Ws7Vl76JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQRMnwAKCRAk1otyXVSH0PlyB/
 99UB9CQmWgDVtt8gHOulMKEyEKnkcOEhxaeNCqrfxrCtov+yx3F5SW1QlbAdDOJq+A5dHFZIeXq/y5
 v//IJRXRX32eb5IEILJ3tAPObNVxWHZStTs7VGstM7qpmAUou8QbZIyI6662M95i+3nfIA3nrQGM1K
 k+5Hd9cGcXaaUICLXL1z/zkCG1Op5PpzLXdS9nBgiN7OQXREQ/3KQQIK4JEiZPqoG/JlOGTGm1QuLR
 /b6kBCht6Ym4wY6JwZaipAIThsPEoJ68p5BVUvjNueFrnjuIxrA2kOI1QfCskY0a85d/xmQynj0Hqq
 1qsJgy/7fdX0RAtoN5b5BCe1ICu5Ia
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SVE 2.1 introduced a new feature FEAT_SVE_B16B16 which adds instructions
supporting the BFloat16 floating point format. Report this to userspace
through the ID registers and hwcap.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/sve: Report FEAT_SVE_B16B16 to userspace
      kselftest/arm64: Verify HWCAP2_SVE_B16B16

 Documentation/arch/arm64/cpu-feature-registers.rst |  2 ++
 Documentation/arch/arm64/elf_hwcaps.rst            |  3 +++
 arch/arm64/include/asm/hwcap.h                     |  1 +
 arch/arm64/include/uapi/asm/hwcap.h                |  1 +
 arch/arm64/kernel/cpufeature.c                     |  3 +++
 arch/arm64/kernel/cpuinfo.c                        |  1 +
 arch/arm64/tools/sysreg                            |  6 +++++-
 tools/testing/selftests/arm64/abi/hwcap.c          | 13 +++++++++++++
 8 files changed, 29 insertions(+), 1 deletion(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230913-arm64-zfr-b16b16-el0-0811fc70f147

Best regards,
-- 
Mark Brown <broonie@kernel.org>

