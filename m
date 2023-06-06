Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE75724563
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjFFOMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjFFOMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E1D3;
        Tue,  6 Jun 2023 07:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4999561DB8;
        Tue,  6 Jun 2023 14:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CD5C433D2;
        Tue,  6 Jun 2023 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060734;
        bh=nYj9AbUU59HCaqannbEYbVUupazB1udPANPd7R8v5fQ=;
        h=From:Date:Subject:To:Cc:From;
        b=U513mg2pt/PkVILvX0n/tTQXpeUHYZtOFnWFoFW0UwGt6DSqq+qp7w0DZytaZL7X3
         7IIvxbwVDW/vIBcFzkyRO0EA+l+xCTer77JfX8KA289KyQm7D+ZXH7u8w3cFES7MTo
         UBerx5hAMQtTvyZk9QTFFlJoujvTd4oK7D/ECPsLRci25/Fq8gSxibITHNizCqcpnT
         bTc8cLvdXs05pbBlds+Jg8w540qG8R4J6yynxoWLL7HecSO2Jcgc07bUvu14u9KKtd
         ZQuOGdUvcSylgdhKaclPeiC73awgc/EBvPcoBjM9HiedsWaHaRhBKYo7zow6Nauxns
         Tav0rZFR1wVnw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 06 Jun 2023 15:11:49 +0100
Subject: [PATCH] selftests/cpufreq: Don't enable generic lock debugging
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-kselftest-cpufreq-options-v1-1-d4621e0c7cbe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKQ+f2QC/x2NywrDIBBFfyXMugNW0xT6K6ULo2MjKWpn7ANC/
 j0my3PhnLuAEEcSuHULMH2jxJwanE8duMmmJ2H0jUErbdSgLjgLvUIlqejKJzC9MZfaJEEd/OD
 7a6+NMdD80QrhyDa5aS/8Ms/7XJhC/B+X98e6bj8VZnOCAAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nYj9AbUU59HCaqannbEYbVUupazB1udPANPd7R8v5fQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkfz670xVO01Ifmckeit23E9d7DWAFVjrMqaG6WWQv
 8TuP8bCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZH8+uwAKCRAk1otyXVSH0LdwB/
 9IqeAx8yIONur8WnWgUToSGK2QrJMUBBj6P+M47oCrhbFaOvAis3W6FvK6RoXLxtCy96o+eycqABqr
 lBlwSy9EAS7ePr+qZdI5kJVIwamhwvc5sfuFSHEvGfhLlwDZx5ztUYZ9mpL3TshKL0/Vgqq9Dh/1ty
 WleOs4db9hWDhQcIqTLFOFsPgf5AZNYEgfyizWATaDsyi3P3Jt+dwm95c7+quAYL7GW4WS2OA2oWY9
 iKRsRYZcbWLL+2L9333+3tP6gQqb92bfaEenhRRWdYj1eZqke7t/lihOtj1hdi8/ty2YzF5k4wXENX
 wN5uw1FcMUmDEHzXqr6GkflmaPct+J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the the config fragment for cpufreq enables a lot of generic
lock debugging.  While these options are useful when testing cpufreq
they aren't actually required to run the tests and are therefore out of
scope for the cpufreq fragement, they are more of a thing that it's good
to enable while doing testing than an actual requirement for cpufreq
testing specifically.  Having these debugging options enabled,
especially the mutex and spinlock instrumentation, mean that any build
that includes the cpufreq fragment is both very much larger than a
standard defconfig (eg, I'm seeing 35% on x86_64) and also slower at
runtime.

This is causing real problems for CI systems.  In order to avoid
building large numbers of kernels they try to group kselftest fragments
together, frequently just grouping all the kselftest fragments into a
single block.  The increased size is an issue for memory constrained
systems and is also problematic for systems with fixed storage
allocations for kernel images (eg, typical u-boot systems) where it
frequently causes the kernel to overflow the storage space allocated for
kernels.  The reduced performance isn't too bad with real hardware but
can be disruptive on emulated platforms.

In order to avoid these issues remove these generic instrumentation
options from the cpufreq fragment, bringing the cpufreq fragment into
line with other fragments which generally set requirements for testing
rather than nice to haves.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/cpufreq/config | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
index 75e900793e8a..ce5068f5a6a2 100644
--- a/tools/testing/selftests/cpufreq/config
+++ b/tools/testing/selftests/cpufreq/config
@@ -5,11 +5,3 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_PLIST=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_LOCKDEP=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230605-kselftest-cpufreq-options-2fd6d4742333

Best regards,
-- 
Mark Brown <broonie@kernel.org>

