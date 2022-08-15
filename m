Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C14592F4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiHONDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiHONDq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51313E9D
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940CC611E2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D67C433D7;
        Mon, 15 Aug 2022 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568625;
        bh=fBxL1nzlY8qeFhnm7QsFfEvtJ4Mb/hUggbozRGaqApM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tzk31dkPHQHIqOiaMwF+Od9jyIr7rGURSi8XTaukDkYKMkQsDU4Fty4YY4Rv2O7md
         7vYiBZP2eUg8ZyHNm29h/dwu4Sq8itXi/CaYdTcI2U9dNvKkvBa/BsekOrwLOHPxxj
         cVNYeyRZpvi89ixQ7WCkZYtDmrAKxWH1iaDaBlH4e+vIpPoYJr/v9FyByYGHoR6bdh
         g6+6zUJp2Fp++R4wlaSAqPOXMcvUrgK25Ktojg4ibEs1d2A5QijGbonPUJsXCDM7/u
         SaLDGIlwsEwhdhkXEEYyI5zYU8hDDoWAclrZf7z87z7koxb/ifUP9+X3yBYFc7/rG/
         BD71dWzEFyiTw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/4] kselftest/arm64: Always encourage preemption for za-test
Date:   Mon, 15 Aug 2022 14:01:59 +0100
Message-Id: <20220815130202.204725-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815130202.204725-1-broonie@kernel.org>
References: <20220815130202.204725-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=broonie@kernel.org; h=from:subject; bh=fBxL1nzlY8qeFhnm7QsFfEvtJ4Mb/hUggbozRGaqApM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kPG88WNfyOa5FHhYX6WLftaPWxS0aXpEVmXAFKj 1ozMyeaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpDxgAKCRAk1otyXVSH0CpJB/ wIchtUHNu4PC/w/hx4mTcEBymSlZJlJvk5BS8zdhAHk8NknM3bDf1Hcy+FoHGfuxcU0zlIh3oCJzpt FNGmqB95PsAz+o4PTZaFFIBg62pAxpDkqhmnlr+/7eWKNUfYi9BD9nEUjtfsOYmzDsG+WX34nq3Syu EYSigvVkMBc52ONHEQGrwIICmCjykDQjWx466UUl5DU28bPUxWD5FPsml6R0AuzBKpH1f2S7DVJANt DcKIiqSNsJ74kRMKLHq2D4CClPM8ubZdiPEf2SkLPeaXFvqjkOSXhBB7Wj1w177We2lsxR3kY2QRR+ jfNgrL9FILO1L3u/H1XDtaW53Ob0Cx
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

Since we now have an explicit test for the syscall ABI there is no need for
za-test to cover getpid() so just unconditionally do sched_yield() like we
do in fpsimd-test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-test.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 9ab6f9cd9623..2dd358f9edf2 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -287,12 +287,7 @@ _start:
 	subs	x21, x21, #1
 	b.ne	0b
 
-	and	x8, x22, #127		// Every 128 interations...
-	cbz	x8, 0f
-	mov	x8, #__NR_getpid	// (otherwise minimal syscall)
-	b	1f
-0:
-	mov	x8, #__NR_sched_yield	// ...encourage preemption
+	mov	x8, #__NR_sched_yield	// encourage preemption
 1:
 	svc	#0
 
-- 
2.30.2

