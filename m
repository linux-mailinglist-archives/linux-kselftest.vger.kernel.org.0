Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBC73A201
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjFVNj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFVNj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 09:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831A1996;
        Thu, 22 Jun 2023 06:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57F16182F;
        Thu, 22 Jun 2023 13:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29DC433C8;
        Thu, 22 Jun 2023 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687441195;
        bh=NTMTlo3MOrDhWRxtZY/AwiKASNnml0gvHavM/MI6Gtg=;
        h=From:Subject:Date:To:Cc:From;
        b=gTfu5hHDs0sX1LrUVWOKsOgISBUMtYVXFEjMfcW5kBJ9nyzDasJzUmuwFqp/h21pt
         59qnnXd2+SvThrHXgM6laCc4DsaTcu2StNtxvJ8hnw30XL0AmGiGjGj9Y1tNNrSpyL
         EBi806O81MIfUrJHlqubWB74v740ANkfo9vK25vB3cg1ncVeo5dc2SIrfkAlyaQKgh
         ftgawF3fhQdodE9pTdlHRu+3k3ugtFuMkH8TTj1trtZpJ+DVuMZKRSfTpQGJ9r5JC7
         FnOD3o6i8TYv9HJUf/FF5P5iMcyZ3rhOgO2RuSyvxzqruoVkKN1cqfMPYVJlJ4+bcb
         SFHQzqTD+NdlQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] arm64/signal: Fix handling of TPIDR2
Date:   Thu, 22 Jun 2023 14:39:44 +0100
Message-Id: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBPlGQC/42OQQ6CMBBFr0K6dgwUBOrKexgWhQ4wAVsyJagh3
 N2WE7h8P/nv/114ZEIv7skuGDfy5GwAeUlEN2o7IJAJLGQq87SUGWh+lQX09IF1IcMSPA1Wz8D
 oV8cIVZYblVeq7pUSwdJqj9Cytt0YPW/HU4wXxuA4h59N4JFi/Xv+2LKY/j+5ZZBCWxqFt7owE
 vExIVucr44H0RzH8QPqp5xu5gAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NTMTlo3MOrDhWRxtZY/AwiKASNnml0gvHavM/MI6Gtg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBklE8m9zIAmV2ipSkkPjReuNZtoff7N3ru3B4J+xCK
 RyvYQFKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJRPJgAKCRAk1otyXVSH0AgVB/
 0Zn7LV/jry2iAEbh4LRlzN/OfSNA+OsY6A+YgSWvrYlA6Pw/Fw/cphg0nwoLfNPzFTSG0BQErObxlH
 vCOlsgQ3UGQdV2rSjOR/Yj3KPykzcWixRhaMqJXFLTPnYpmFNq3IyG99BTWT5xeL61pBuKwNBXVekB
 Xq1KuXcCCqX3wus71SITXH9Hb2iX/jG5pOedoDWl5ncr9BXpKhrPdqfSSmDaCls11YlDBtbjPeQXV4
 t+ifE2G6M1zHsyajvSmCuJbhKnlB0wWrW+4U95Afb86uvpIsUnAsgGGAbVhNHBf3Ch8BQAS4hQegGR
 bb1b7PbLHQild8iBCHeZ1ZqLIQ6rQs
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

The restoring of TPIDR2 signal context has been broken since it was
merged, fix this and add a test case covering it.  This is a result of
TPIDR2 context management following a different flow to any of the other
state that we provide and the fact that we don't expose TPIDR (which
follows the same pattern) to signals.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Added a feature check for SME to the new test.
- Link to v1: https://lore.kernel.org/r/20230621-arm64-fix-tpidr2-signal-restore-v1-0-b6d9e584d2ee@kernel.org

---
Mark Brown (2):
      arm64/signal: Restore TPIDR2 register rather than memory state
      kselftest/arm64: Add a test case for TPIDR2 restore

 arch/arm64/kernel/signal.c                         |  2 +-
 tools/testing/selftests/arm64/signal/.gitignore    |  2 +-
 .../arm64/signal/testcases/tpidr2_restore.c        | 86 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)
---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230621-arm64-fix-tpidr2-signal-restore-713d93798f99

Best regards,
-- 
Mark Brown <broonie@kernel.org>

