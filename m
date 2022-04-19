Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE15068B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbiDSKa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiDSKa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7926562
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D859611FC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61719C385A7;
        Tue, 19 Apr 2022 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364094;
        bh=jrRh+8wStvVN/Hd3Nb9FI4sSmTpR9aUxzMnC0aqDmSA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ci0WZXIdVlEvtwv7DWK3ErtjxTw8du7Jt1HKMQA59mM4qxjgflSdRhCg9Ombz5oLF
         sRslIHLCrHKPENF78iK9ttr4TsvqhivXeMEokbrPyLe0hPOVJr6W0WX+9MEuGGm1sg
         MAlsftTy8FnttzItkf740ovWeG1lTy5EQoT7riMznf7om8tv01BWn94fSbsZe5vzIp
         Qh9QEgk1hUVRy+s0A0wBDTIG8MgzAJ4LXfMdev3sQ6BjTs4pKBR157cNw4XFLFdwcx
         QioyxCNH25ugl7H+vdTehcYpOxfNSaSgf8PbvPjwLGBZAa0jDJhPoxS+d88U/LcIhU
         aXs5McUx4Ic2w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        inux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Miscelaneous MTE test updates
Date:   Tue, 19 Apr 2022 11:28:04 +0100
Message-Id: <20220419102808.24522-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; h=from:subject; bh=jrRh+8wStvVN/Hd3Nb9FI4sSmTpR9aUxzMnC0aqDmSA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo6xhgr6cFblAnK9/EUiZlU+z0dC4fFztExS0t+2 LfeGPNeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6OsQAKCRAk1otyXVSH0MWbB/ wNhHRQ42BP4FudciC73Ri6FiX0kyL1ekwWHp+QKVOjF30/ImMi1hBF1HlRUcdn2fnoFxG6yCLBvG51 SFi8gsDL5nttdfSWuDVapax6YtFxw6Cur/EhqDoQlVP4UeTvTbBHFgex2/6W20Wa11tGxC7EK1ozcR wfaQF3OuC5EyiAzDDX29w16LGgzG9y3lWTPtYCaQiN8sLXweX5411w95j87ug01tGBsRGlheruN1fL w6G7JnDnXEluvf8uC46Lzqfty93z2I+Bxu8FQwJ+Ln0tK80V0Dx9ThjBe1qa2NhpCHyK6IVEFDDWFF V3z/x0wxqFJ/wvTDdRFtYt2wVVrttb
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 - Rebase onto v5.18-rc3

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


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.30.2

