Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5585989F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiHRRGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345424AbiHRRE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 13:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DEACCD78
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 10:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36DEA616CB
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 17:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98354C433D6;
        Thu, 18 Aug 2022 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842112;
        bh=LbiGsvCrcjxKaot3ZWZbctBJ4WOVBeDJbpRTvOjY/3s=;
        h=From:To:Cc:Subject:Date:From;
        b=BoSpNlOSsO/BTkwPd1ZHlzg8od0G3UegVHhFtA5G+WP1/IM630Fat7dse5bwmG15b
         ZIpaCdWHvJG4KM6f2uEkFKlaysH3s6WfD6rcjRyIjdhA9yiqtzxdKWoPCNDcCk+JwH
         5v1eirCKu6ZnuHBe76ppYR02yVK7wU0bAFDcOASJJ66HJHu9ld7okuRvZAWDI6RgPH
         NrGzPa92L1GM9iUI7meFf5WNURSIvnzhtlrZalRxsodm8gVEfZg4DwT65nrJBzVn+o
         WJLJ9r6QtYEWL5f+jrqSo4u5/HPyKQkD1v2aOZxuAagpeJRr3sF2DhWCLivPn/vXFV
         e/KtxNamm4daw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] arm64/sme: ptrace support for TPIDR2_EL0
Date:   Thu, 18 Aug 2022 18:01:07 +0100
Message-Id: <20220818170111.351889-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=broonie@kernel.org; h=from:subject; bh=LbiGsvCrcjxKaot3ZWZbctBJ4WOVBeDJbpRTvOjY/3s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi/nBSSY+IZEhiVzX1rpQh7oRfCQMkCNM52E+Ho936 /z8OXgGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYv5wUgAKCRAk1otyXVSH0IZBB/ 9Q4fUGGxtlxOHHoCiyujsB7a4I4XH1dgGY0VGE/xRLJ/ZQCbr4e4UKiWu+YDBhInht5xtyrps0W/zQ xMozWgKy5ZyPYsTI70cC0dBhVgVu1MV6ZK9q4uH84mrgGWsVak/zdFcpohvaHkluxnowK/122+6vjb qjya0UPk57Eah7rl0XujcqazKaE6Y1SXVdKQIfSBxfLaloKhaimtcDjL6rIM6BO3/8+UiW2p3d/0Z7 lqOQCtVgS5xZmyKAwkTmI3cSRYD+Go3Fb4pExVuIQqsuThkviv3/5EObwFww7SiX5+3WpMHb4KCmpH FmoZ0EiVsyTr/iuEVeOllJgIWT62/2
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When SME was initially merged we did not add support for TPIDR2_EL0 to
the ptrace interface, creating difficulties for debuggers in accessing
lazy save state for ZA. This series implements that support, extending
the existing NT_ARM_TLS regset to support the register when available,
and adds kselftest coverage for the existing and new NT_ARM_TLS
functionality.

Existing programs that query the size of the register set will be able
to observe the increased size of the register set. Programs that assume
the register set is single register will see no change. On systems that
do not support SME TPIDR2_EL0 will read as 0 and writes will be ignored,
support for SME should be queried via hwcaps as normal.

v3:
 - Fix copyright date on test program.
v2:
 - Rebase onto v6.0-rc1.

Mark Brown (4):
  kselftest/arm64: Add test coverage for NT_ARM_TLS
  arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
  arm64/ptrace: Support access to TPIDR2_EL0
  kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface

 Documentation/arm64/sme.rst                  |   3 +
 arch/arm64/kernel/ptrace.c                   |  25 +-
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |   2 +-
 tools/testing/selftests/arm64/abi/ptrace.c   | 241 +++++++++++++++++++
 5 files changed, 266 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.c


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

