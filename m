Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B45A50A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2Puj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2Pui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FD886718
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2EF561045
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62AAC433C1;
        Mon, 29 Aug 2022 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788235;
        bh=8u7wzWCBYbPHjL/T7zjkuOofXMJVGIZuJLQLYujweWY=;
        h=From:To:Cc:Subject:Date:From;
        b=sCF6mUZ18Eo4AVw+q7c1kiZXY9G24WOM3v3fHwPYff0hzLVKwDR+2gTARwdaWVnXn
         B2kjN9pdz/qh/tZi4DQ1YEGPvAf4VpCVwIuUfNiNlXq9kGuQ558NzMqUpGbR6sZAq+
         o+aJ718y0TEVzbfO4NnToisxCY4Yeu2Ki2BeEH3nn0RNXvgzeR7t72OJ5YU52kbpVp
         XK+q30waSaYbps/VizPItd8p+lWGwdcwyMupjrSuZ5FypCSVr9BEa4kKnxTwKDA6mj
         txLabvM5PVfDmbcZb3885TMhZJfjLWc87UPgJ0qCfA5852HCuNHoeV9cLxL4ksI0Th
         ivX472rms+i7g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/4] arm64/sme: ptrace support for TPIDR2_EL0
Date:   Mon, 29 Aug 2022 16:49:17 +0100
Message-Id: <20220829154921.837871-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=broonie@kernel.org; h=from:subject; bh=8u7wzWCBYbPHjL/T7zjkuOofXMJVGIZuJLQLYujweWY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN/9Vw0Uuw9uxB+mkYETRApTXVmSRJzLcx1ANY9j sjf1TdmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzf/QAKCRAk1otyXVSH0Ja2B/ wMqdtCon0gnIY9YnAy+XJ6oFYFXrpGIWt484TLFvjFmcP4zf9q0tBfre5UgkzLD5SVZ44tZz1HDIsC pLUvHOgMzds/mh5yXC1NuI6HgGGT3vzdDtoJwdjWJPyh69wJs1Nf5J/Pz+7ijVJ/Lw9vtXo3Gs7Ry1 kuwERb079a+CJAAxDORODhbdWADIvlDDs+bPBG3MnJIq6XHzDwS4/OWlT9AUYwnLr4Rw5L5fnh4zS8 w+yh9hKwHL0p4kDw0UOKJ9H3ywT+g3CA+jNUoBxgJwd9avJmlfl9OVkRUUDHKdFI0tsygnNFPiuYVe WuwWFbRUsPolpOd2z4uBqgfEaG3EPw
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

v4:
 - Rebase onto v6.0-rc3.
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


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

