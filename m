Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8B4D4C61
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiCJOzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346813AbiCJOuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306118A7B3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 06:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89506B825B3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1A6C340F3;
        Thu, 10 Mar 2022 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646923496;
        bh=u0383KI764BHLRXMzp29Htp7OroDqqQqAwLxf3DtRqA=;
        h=From:To:Cc:Subject:Date:From;
        b=HSiNm6BsOgk0QdlplnKc64UDYeIQFhJXA78jtNOogd0jb95qPrrGp4bLGy8Q6xMoB
         XVgbF5wZWtPSgcX3zRNQEkztghSnKCid4Y03BaaO2OXDQeasNJvnqIQH9OUwDu57om
         BGhktR/aXWk+3p8DsXKuPmLqIO5JrucHrKPUI4Zhh5gZGRhaqW4knbieA5yUF6x6xh
         rgrAFZdah1rx6irV0KHrW++OnqK0sQKDco/c+Z4rwCgURhKSA25+CA01/M3GPBZkR4
         +l+N0paTT+YXe7/kWScxP0YEfj+DQ3O2nc8eINz5cZXbBg3SRCGHoyY6y6YSVzNEIp
         puwY7FTFy6SIA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] kselftest/arm64: Miscelaneous MTE test updates
Date:   Thu, 10 Mar 2022 14:43:31 +0000
Message-Id: <20220310144335.2097457-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; h=from:subject; bh=u0383KI764BHLRXMzp29Htp7OroDqqQqAwLxf3DtRqA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKg6RvhrPHtwxlk6T2WbezMguC8qHeCUDGLMZFNWm UNKLipaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYioOkQAKCRAk1otyXVSH0NVpB/ wNHizTql7qFY7Kq3ynP+ibNdyDK8/oXm+rgKZDEDjBzBsXDLenPY+Qby5XdAmXBf8jdjlYXTfGprsF 9qLCpRU6ZTkBY3dPR79yMJOybjernITwS7ERNW1rcrAHchmMa2pIMuXGMQ7TJv0ddoGbYT/mfxVnyt l5gsGUFJJ+QF8IhyfXYFKfU4DfSUWN2blmP/XDqL4vtbJTeSjqJezhDNWWE3JHkil+RKUxmWuzvRtk Cd80PfgpdKyQsJ15KMLUsc1iwik4YGPliDSolSJXrBM144W16J4uKbImCkHDeJaSB+LwAV+n/u51/p 4u+tDtQSJzs4qEdlCAaudNYqxaLcK2
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is just a set of minor tweaks and improvements for the MTE
tests that I did while working on the asymmetric mode support for
userspace which seemed like they might be worth keeping even though the
prctl() for asymmetric mode got removed.

Mark Brown (4):
  kselftest/arm64: Handle more kselftest result codes in MTE helpers
  kselftest/arm64: Log unexpected asynchronous MTE faults
  kselftest/arm64: Refactor parameter checking in mte_switch_mode()
  kselftest/arm64: Add simple test for MTE prctl

 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../testing/selftests/arm64/mte/check_prctl.c | 123 ++++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.c     |  17 ++-
 .../selftests/arm64/mte/mte_common_util.h     |  15 ++-
 4 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

