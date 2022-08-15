Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8D592FEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiHONbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiHONav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EE2BE0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A493560EC2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A868C433C1;
        Mon, 15 Aug 2022 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570250;
        bh=qfExTraPKJESEWy/672kpfKy63KwCmJsuokM8Ka6tq4=;
        h=From:To:Cc:Subject:Date:From;
        b=NY5g+ITSqJOtI0GD9IvlswvTs1cmTdwF3+BfeSqucNSzQorkc+mQqmU9labWnoYFw
         0uMYbPdr1wwO75L05Bcm5U4D1J2MSH6jN3nrqz5ksRL4rEBo6RAfl404aKay1ap2ua
         8y9rhgbvmdvnoxxsYeWOpMAzHHt7bDFkgjTVBebT2VuXrxLRSBMsK8qxtVowxmxkO2
         DGqaKPI7GjQ8FlqmdWyfXRo+dHYVJdnsSiCjXOJlm+Qyf54exnXUxQg3/04oq0PeID
         6lbs6d/pJVDKl205xQLi7pjVV3hiD7BgXdAR77AwN9A8XTEWnb2u4QFiCZo1W7XKCD
         dX6LYlzwKS+Dg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] arm64/sme: ptrace support for TPIDR2_EL0
Date:   Mon, 15 Aug 2022 14:30:30 +0100
Message-Id: <20220815133034.231718-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=broonie@kernel.org; h=from:subject; bh=qfExTraPKJESEWy/672kpfKy63KwCmJsuokM8Ka6tq4=; b=owGbwMvMwMWocq27KDak/QLjabUkhqRfXmXtrTWLHcT2tGcLVJ0X+qSu3HxWKF/g28MnNdntkoab Jyd1MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATcVVn/2e5w2n98dIv/ty+kT6W/c vXeWp+Nz1Wmr9C+NP8bZqOFcwiodHqeUXzxboVn7uyhpqkHTZwzgxY2F/joT3V/dR0jjNVNa2bea7Z 7kg/uGiZ7Crp7z5bZm/IfHCLKYTXeYvJ+cMeWh2sc7c2JYbtM9MoElzHsiU/43VhSZDxNgvlqUW5Xz YeuBilYuGs5suaMjmEK8GvMPR4+7TiC36P34ScC1zic/aQ38Y51pwXQmObHgb4lE51ZmmpzVgr8r65 WZOfv9/+yOYPzyW+HBe97plT/J2/OOH1Lr8lsjftszl41XheRAQFPLigwyXdE2KotvVsS2pTr7zWqe qtrbp9/reU1UutylI2Ft6ZyA0A
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

