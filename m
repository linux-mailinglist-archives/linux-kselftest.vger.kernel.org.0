Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B673A203
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjFVNkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVNkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 09:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB421996;
        Thu, 22 Jun 2023 06:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6B56182A;
        Thu, 22 Jun 2023 13:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A17C433CC;
        Thu, 22 Jun 2023 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687441202;
        bh=w8fxWAGiQaBMUkDFhDb0uejIT4OUWJBakDRMQaptQUc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iICu2phPR5ILZG7JI+68q0+Ns20bNqyrhvhMml5d1wdZUjJIv++BCVrkuNLIDBWdt
         Kd20yWMwj+Dga0597jCavM6zRC4YX2QQBwy7sJsOBxGH4Sn6RLqwHv/b1evHSWIwQr
         Vvzl7D0C9M/k+2WEDmAG4EtSyLHUnnFIr1IQegTJXtK9mZ82SNPw5THJH9/FMAgQXH
         WGXWTaqIbQ8tG4UF5qObRfLwG4RRRxci7Pdvxiii/6Is5GNiD2mEomUesEHkn7QEnI
         I9L4amYoZMYfzQRlZECyjtWYCRe/wp1ZgqrWgAuqrTU/9BbRgBPt6zi9ZzPJT+owK1
         oVn511dFpR3nQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 22 Jun 2023 14:39:45 +0100
Subject: [PATCH v2 1/2] arm64/signal: Restore TPIDR2 register rather than
 memory state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
In-Reply-To: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w8fxWAGiQaBMUkDFhDb0uejIT4OUWJBakDRMQaptQUc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBklE8nsYvELF3WpfKfmByc+fGAeLNPcr9NAY5/8CsN
 LVvdDDuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJRPJwAKCRAk1otyXVSH0KBhB/
 473Gq3ZQ6893sd0piLda7UZJYhhBVNu0fwedBuDBuNgvNMdK0H3wXVUYvCW9jNcR15aSIZS/pq7kU3
 8URMlQX/Z3hg3mls6Rq4kAmBU26Z/ZaX1P9Q1mcVp+MWL/W6xzcN27KBFS+5nIWPX6tgpLMmVAMnep
 Sypvldcx/pJRVAfX5wnHWPfQ35s2NEPO+mfTDSsOh5lvsOq3KJ0KISzk3k1R6X7MCbXB6ZxVoKl7sg
 EzoiSrSssf+NLXLIom2bKAeEnYVN+aO+T9bF0MKAPteCBs9Am8fNNY4VBsqaD40r3LNfdl3yO2byUn
 Ugs8AZ/DZYuXXkxiMZmhsbq+06e+oe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently when restoring the TPIDR2 signal context we set the new value
from the signal frame in the thread data structure but not the register,
following the pattern for the rest of the data we are restoring. This does
not work in the case of TPIDR2, the register always has the value for the
current task. This means that either we return to userspace and ignore the
new value or we context switch and save the register value on top of the
newly restored value.

Load the value from the signal context into the register instead.

Fixes: 39e54499280f ("arm64/signal: Include TPIDR2 in the signal context")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 2cfc810d0a5b..10b407672c42 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -398,7 +398,7 @@ static int restore_tpidr2_context(struct user_ctxs *user)
 
 	__get_user_error(tpidr2_el0, &user->tpidr2->tpidr2, err);
 	if (!err)
-		current->thread.tpidr2_el0 = tpidr2_el0;
+		write_sysreg_s(tpidr2_el0, SYS_TPIDR2_EL0);
 
 	return err;
 }

-- 
2.30.2

