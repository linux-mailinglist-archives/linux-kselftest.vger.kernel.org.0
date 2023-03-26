Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FC6C9508
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjCZOLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjCZOLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 10:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF833C3E;
        Sun, 26 Mar 2023 07:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72942B80C97;
        Sun, 26 Mar 2023 14:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC73C433D2;
        Sun, 26 Mar 2023 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679839880;
        bh=hvcZuk55/yILwRwMKFGSNKC3aA0PxgoQCcIFNTXSAtE=;
        h=From:Subject:Date:To:Cc:From;
        b=frVF+5ZAyAOpA6uMgO4YTbEpBPs+/JVKyZ11CzTcdQs22hSVcMF3acN883iPPdloJ
         6z+ftWqx3m+Yr1Dvtc1/33WWv7wOLRQfkc0Ee8pxYXjKf3rkjXC1wo5UBxc6KrL3is
         tGtKkRRVch57BFeAfbeD1R9sLZhSgLVdGaoUdEQBNuEhxVP9jqZ24sgbo2nUmpJccV
         v4wMRDxza6SBukayC/n+O/lOKka2KsUkkVfqMl44EUkhUVW0jOPRg+dDKplje1JRLn
         bZvmrfqe1KCgjwi//k3wR3FETh+v5qE6YOMY4UGQg8xsUWpIw71HA3KEfL8f16VWrV
         DC/egRQplzP8g==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] regmap: Initial KUnit coverage
Date:   Sun, 26 Mar 2023 15:11:11 +0100
Message-Id: <20230324-regmap-kunit-v2-0-b208801dc2c8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9SIGQC/3WNQQ6CMBBFr0Jm7Rho1YAr7mFYtHWACdqSKaKGc
 HcLe5fvJf+/BSIJU4RrtoDQzJGDT6AOGbje+I6Q74lB5UrnWp1QqHuaEYeX5wmt1U5TWZA+O0g
 TayKhFeNdv43eQYZNj0Itf/bKrUncc5yCfPfoXGz2z/9cYI4XRW3lWlPZsqoHEk+PY5AOmnVdf
 zq4NB7AAAAA
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hvcZuk55/yILwRwMKFGSNKC3aA0PxgoQCcIFNTXSAtE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkIFKD5VS9CefhELvjTrdGXdZdsiwefwZCo65ancTd
 70+oWx+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCBSgwAKCRAk1otyXVSH0P6AB/
 9h2vKbHNGsGYOkRR+CSeraQafE2NdnfxyAZnDaayH2CqPre28ksmv3DrV7pEiXhbyhWZhTBurhrCi5
 TVPSMPoU/t44QlIuQCFKEnwUUVAT6WAICEvPRTAymxoLuQSID/PT4FXDzLbcGQ1UrkwrYoiS9dJ3+d
 IUhyEIVUz3066cajeCNb1gZ4QrpXxc/ne7y+N3NOHswCZ00FfEZOFBRHnsEyE4PTFXaew842oWjfKG
 f5Va+RkKtt0psGzoLw6TBL9gP5H+NvAdLm9+biSkMTj7Sbt44LZFqHiQL5aKo+AinyDiqYgtpOU9j0
 GNFaLg2KyuaebP6OWKC9oH9waMkO2b
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series provides some initial KUnit coverage for regmap,
covering most of the interfaces that operate at the register
level using an instrumented RAM backed bus type.

Without the current regmap tree the paging tests will fail as the
RAM backed regmap doesn't support the required operations.

Changes in v2:
- Add a test for regcache_drop_region().
- Add a stress test for inserting registers into a sparse cache.
- Link to v1: https://lore.kernel.org/r/20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: Add RAM backed register map
      regmap: Add some basic kunit tests

 drivers/base/regmap/Kconfig        |  10 +
 drivers/base/regmap/Makefile       |   2 +
 drivers/base/regmap/internal.h     |  19 +
 drivers/base/regmap/regmap-kunit.c | 736 +++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-ram.c   |  85 +++++
 5 files changed, 852 insertions(+)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230324-regmap-kunit-bb3c3e81e35c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

