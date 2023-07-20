Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D175B6F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjGTSjP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGTSjN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 14:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28CE47;
        Thu, 20 Jul 2023 11:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0150661BDC;
        Thu, 20 Jul 2023 18:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABCDC433C8;
        Thu, 20 Jul 2023 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878348;
        bh=8e4Akz9WsSzK3omseih/f3BlHrS7YZVf/pCD/Nyk1eQ=;
        h=From:Subject:Date:To:Cc:From;
        b=Ewmy2d4CrOmRkGnbIlFIwR646fvj+Mc70TquhXJF7AezIplBXG+Cds6X39iY69S3x
         k6+LNcLz1Pth3g8qDfKqAY92whF5WvvPT0pP+EjW2L/0vQ1ISHugJcGMypVfCwkd7G
         A9fykN3xwBbWkcNyqLl6/fNZ1oY2VnoT+WVsvuPk4CAGBi9V2TR2+GmLFOIr8FAzBs
         BRz291uQbbj2Ep4ooVtwr/plEdTmrh5Vl0mUr+HPYuP9rAP+IKQ1A4mRfh3YAw/uQi
         jraTu5Y3xct0CZdLt5Jhqp7KA9bQ7sNahsY8bZx2tHHiLRdoG1yvQNTjQFVOZBjqNa
         KS3oEQbsx7D5A==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64/fpsimd: Fix use after free in SME when
 changing SVE VL
Date:   Thu, 20 Jul 2023 19:38:57 +0100
Message-Id: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEF/uWQC/42NQQ6CMBBFr0Jm7ZhOS4q68h6GRbUDNAI1U9NoC
 He3Eg/g8v28vL9AYgmc4FQtIJxDCnEuoHcV3AY394zBFwattFENGXQy2Rq78MKUGdPEmEf8qVb
 xlTpnXaMaKIWHcBG3+qUtPIT0jPLezjJ91/+6mVAh6aP3B0tUkznfWWYe91F6aNd1/QDz9Rv8x
 wAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8e4Akz9WsSzK3omseih/f3BlHrS7YZVf/pCD/Nyk1eQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkuX9GAwk8cEP4Cn+OXwPxHcGTGJ7cz3SxsouNWVRq
 N3lFxD6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLl/RgAKCRAk1otyXVSH0GV2B/
 wJ+AgIoXIuJXZ/qt5peMxjTojQ6I7eEnXd+mopSLM46ZK2Mfhh04sfNMkwFFgMGWja4sN4Zl98st9Y
 1yt6eY2A+ScPHWnnKatZd/1k3s+mooNA9ic34Em0+KyLx62ZJA1Gwg25CyQN7Yh8zwfyNJwZV2FPTV
 TT0ply8+G4pehCpqMGuSnQZ+YZgml1j5hsbxCRoagBEp5jwY4jnHTJBLTIkfmf4IkcpDESDRLwIF03
 s0pBC5vfiUz7D1af1qPKgqoPki3UPZe3Vxw8gByxqU4Z4tNK0EvesulJlbHUuECM/ua95UJbFFv35W
 LWznzerBRZXmcIGf6CKkwix/pFHAp1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes an issue which David Spickett found where if we change
the SVE VL while SME is in use we can end up attempting to save state to
an unallocated buffer and adds testing coverage for that plus a bit more
coverage of VL changes, just for paranioa.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Always reallocate the SVE state.
- Rebase onto v6.5-rc2.
- Link to v1: https://lore.kernel.org/r/20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org

---
Mark Brown (3):
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
      kselftest/arm64: Add a test case for SVE VL changes with SME active
      kselftest/arm64: Validate that changing one VL type does not affect another

 arch/arm64/kernel/fpsimd.c                    |  33 +++++--
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 127 +++++++++++++++++++++++++-
 2 files changed, 148 insertions(+), 12 deletions(-)
---
base-commit: 06785562d1b99ff6dc1cd0af54be5e3ff999dc02
change-id: 20230713-arm64-fix-sve-sme-vl-change-60eb1fa6a707

Best regards,
-- 
Mark Brown <broonie@kernel.org>

