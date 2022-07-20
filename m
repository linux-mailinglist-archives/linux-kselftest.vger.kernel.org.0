Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640E57BF5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGTUxc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGTUxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0CA509E3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 13:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C47561CD6
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 20:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B9CC341D0;
        Wed, 20 Jul 2022 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658350409;
        bh=v1nBfypExpear5ix8uSNG5xgtD+EqsEMaRjYhEBegiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVn//bBAYdiZ2pegsvZLW4zdYe7J72VrOtgeet308+NJZROEm/LD1uJMFhd4pkjeO
         35iTzmWnR48awQ8qNfXP3VF5sGGPl1Ez6BSCXPgXH7TOA5miG9rnTD2UKsLgfhthrV
         UbSgQ3sBT/rkF3Qw3Ft8hb99WWB36IJc68xXZ3IAETwCALJcEs3MfbI9HrqXnciRWd
         vlROW58A4k2FjRWiMEUgH9lgIZlwutr1PzhVBzgvjWjyEtFNTUPHhJqMMjaR5DIOTp
         dxyBObvhhagHKo+EbPg3VagWykTMUxJr4f6g7XX+x74IEd8itUffrPcPMbfYqHgdvL
         BH+VPse9uon1A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
Date:   Wed, 20 Jul 2022 21:50:12 +0100
Message-Id: <20220720205013.890942-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720205013.890942-1-broonie@kernel.org>
References: <20220720205013.890942-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; h=from:subject; bh=v1nBfypExpear5ix8uSNG5xgtD+EqsEMaRjYhEBegiQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi2GqDsQ+vD7tilJtRkbOpvpdpEQ0RWqtUd2af422n gFAa0WKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYthqgwAKCRAk1otyXVSH0IbEB/ wPjuwKXPmdGQePmD83FyRrE990GJ/UOao0m+Z4a8qm9HlY+9sBvYN9SevbSessXQ6/gkxja+y6DfQ6 X5J/aphn/tfdkA9oMc1n7MxqFmBkpsq8TRdqjLV3+3ai6M1cErEEuGcAy4pY778+6sy2ajy9PE4ZF8 bUNkQBHsYMrtFF0gc3C/iCDK08jgOAj7NXM2cTA2NwLrxv6gHT+PLj76ufLfDXfyKoawGvQJx06DCc +1t8eNB12NVpINFHsS3i0DwgHzgLfJ6Dn1ELRVkdtxgJ83z3s08BJf9OIC/r7aLt7q3lektwdrR84u DyKaldX6sMa4eKh8f/FxG3q2z10+ah
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

Currently our ABI documentation says that the state of the bits in the Z
registers not shared with the V registers becomes undefined on syscall but
our actual implementation unconditionally clears these bits. Taking
advantage of the flexibility of our documented ABI would be a change in the
observable ABI so there is concern around doing so, instead document the
actual behaviour so that it is more discoverable for userspace programmers
who might be able to take advantage of it and to record our decision about
not changing the kernel ABI.

This makes qemu's user mode implementation buggy since it does not clear
these bits.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sve.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index 93c2c2990584..e39acf95d157 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -111,7 +111,7 @@ the SVE instruction set architecture.
 
 * On syscall, V0..V31 are preserved (as without SVE).  Thus, bits [127:0] of
   Z0..Z31 are preserved.  All other bits of Z0..Z31, and all of P0..P15 and FFR
-  become unspecified on return from a syscall.
+  become zero on return from a syscall.
 
 * The SVE registers are not used to pass arguments to or receive results from
   any syscall.
-- 
2.30.2

