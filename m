Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EE752B6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGMULq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGMULo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347830C5;
        Thu, 13 Jul 2023 13:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FD561B24;
        Thu, 13 Jul 2023 20:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9AC433C8;
        Thu, 13 Jul 2023 20:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279057;
        bh=b+mXPu6hNz1J3rv9s18G7fKwLpeHT94qeHP9x8G2zPo=;
        h=From:Subject:Date:To:Cc:From;
        b=R4Ebcd75+4TN8r4xX5AjQ0htMud9ZRjaNpBbh8127EbiyvvDj95qjKwznaS2XNnFJ
         2I0o0y4B+1tTJs9Cz1AvOmrv6UbZp7u4nQK2xsTUZXkGP9bAE/AxOVm8hnvxlGk7s3
         Fp7+2CUUAJOLtibvDdUXMsdaXbwz+gfj/u6ULp7IV8T3Ui/scdMSfF9D7Y5NjBWXDT
         rbi3czlvzMFWn6VTu+HFCtP3fxDToZLjLdSC2jgAbu2YpflpWL9YT9Z1zrDToBv9hG
         D+qX1QAzaa1uaX7A8tnZXZLOBgpYIXx8VN0o3kKge0Xhvq8BDjPP971GZFbdo7CYiv
         HNwBogtp7gznQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] arm64/fpsimd: Fix use after free in SME when changing
 SVE VL
Date:   Thu, 13 Jul 2023 21:06:03 +0100
Message-Id: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtZsGQC/y3MQQqAIBBA0avErBvQCoWuEi2sphpICwckkO6eR
 MsPj59BKDIJ9FWGSImFz1BC1xXMuwsbIS+loVFNq6xu0UVvOlz5RkmE4gnTgT81iia9OuOsslA
 OV6QCv/swPs8LuM/wkW0AAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b+mXPu6hNz1J3rv9s18G7fKwLpeHT94qeHP9x8G2zPo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBksFpM4XanCkYYveJuZ7ekHPux6xvnYhM82hbe788V
 jXNeyzOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLBaTAAKCRAk1otyXVSH0BlOB/
 wIRvb6SdQQY9DllL88SkYw2v3TxsK5ZM/5AvbPiaHMBIys0TBmboBl7ux54eBHUENQJCDbU5AbT2zV
 Lh0XUlpmKGAff7NqCKKOB0OiBCDlDDay+CWBsgbuW9HlGA6LI22Ir6mCkb/y9ib9DIpCt+UmtrBgFW
 35jYRzqncVW9mxS1w4k3D4nOOKbtNWv+eoYFfFPZ4m45pIRXMw3hHlahz0xJT9leotTKSUMRCCI9Ai
 ypRU7jk1Ir//2PVrqLzUIud9b8l7SrZyE1LpFIbvbNL8NTgXpimJjP84OFH/fZmUDG6xrYl5OFv9Cj
 2K6K/qxJPirdWp6JeGGd6FdWrCBSJO
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
Mark Brown (3):
      arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
      kselftest/arm64: Add a test case for SVE VL changes with SME active
      kselftest/arm64: Validate that changing one VL type does not affect another

 arch/arm64/kernel/fpsimd.c                    |  32 +++++--
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 127 +++++++++++++++++++++++++-
 2 files changed, 148 insertions(+), 11 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230713-arm64-fix-sve-sme-vl-change-60eb1fa6a707

Best regards,
-- 
Mark Brown <broonie@kernel.org>

