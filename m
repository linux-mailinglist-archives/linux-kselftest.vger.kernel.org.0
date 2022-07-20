Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CBE57BF5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGTUx1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUx0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC4501AC
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 13:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633C661CCF
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 20:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3498C341C7;
        Wed, 20 Jul 2022 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658350404;
        bh=YSKR+0WQX7Mq/SCbbuEVAq76XcSFDwV4GjHw5zpQ0kU=;
        h=From:To:Cc:Subject:Date:From;
        b=UVjY/dbkeGDpbWCo4StI4S8gb8boPhiEAMQucMLlbTLOjiuX3m5xOEtgVC/9Ks7Nm
         1vYQx+9VNRYhRrohzUcJwOJ25xXBGwBZKkiPZOOEae2treKY0NxFSznyTgRAbjFlL2
         4sYFXoBy5+S7YS+oAA9pbHpuFC6JbFH+gCzo229HrE8q0YJFCZjYfuKJUg02x/EFtu
         42jxivZpVnK1t9StYnJoNPDF0WK+5g2vTQgtf2ZjNNF9xcceN6mX3Sn74jfG/n+4mW
         dhUR9UiXs5rpMtvGdoSysg628Und+piAyPEezDG972DyvI1ihxB40FUPKEsk1lqBKN
         biHQ+0lS7pSsA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] arm64/sve: Document our actual SVE syscall ABI
Date:   Wed, 20 Jul 2022 21:50:10 +0100
Message-Id: <20220720205013.890942-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; h=from:subject; bh=YSKR+0WQX7Mq/SCbbuEVAq76XcSFDwV4GjHw5zpQ0kU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi2GqCaUN7YliFgf8CYHR6UgHSNz4XqUEJESFAKm3x YKohRe6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYthqggAKCRAk1otyXVSH0O/5B/ 9QtVh9u4Ax+Oh8zWGvAGCwcK+isBH0Feons5uKX09WOTv6uDn0poHP/A6BzeTjvEPt8mjw/FfjOn6v olTmiki/uZZHi50dbiS1W2HaB3QRbpP+ry3IF7hY4+UlU981P4MPKZfw0nFeN3/FD9VMLBKBHYjOg9 N/JsvccNc3WDGED0aX0PAmYS0/kg1GmxlyC1f8F82oSYosNBuF9RDZVAQAN/KuIeJf6qlWUWlFNh/X 5Z7MqjxRckK9kUeWYQ+6HZdrgyPjc/HK7Tl/oRyDL72HOVpz25PqB241u3fVB7qcpDKC8jzJp2d5bS +nZRTaicRIfhG5oImWH4CuFolwRnGT
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently our SVE syscall ABI documentation does not reflect the actual
implemented ABI, it says that register state not shared with FPSIMD
becomes undefined on syscall when in reality we always clear it. Since
changing this would cause a change in the observed kernel behaviour
there is a substantial desire to avoid taking advantage of the
documented ABI so instead let's document what we actually do so it's
clear that it is in reality an ABI.

There has been some pushback on tightening the documentation in the past
but it is hard to see who that helps, it makes the implementation
decisions less clear and makes it harder for people to discover and make
use of the actual ABI. The main practical concern is that qemu's user
mode does not currently flush the registers.

Mark Brown (3):
  kselftest/arm64: Correct buffer allocation for SVE Z registers
  arm64/sve: Document our actual ABI for clearing registers on syscall
  kselftest/arm64: Enforce actual ABI for SVE syscalls

 Documentation/arm64/sve.rst                   |  2 +-
 .../testing/selftests/arm64/abi/syscall-abi.c | 61 ++++++++++++-------
 2 files changed, 41 insertions(+), 22 deletions(-)


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.30.2

