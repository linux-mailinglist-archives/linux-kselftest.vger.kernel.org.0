Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9265068D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiDSKfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDSKfb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D729CBE
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D2361236
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D7C385A7;
        Tue, 19 Apr 2022 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364368;
        bh=jrRh+8wStvVN/Hd3Nb9FI4sSmTpR9aUxzMnC0aqDmSA=;
        h=From:To:Cc:Subject:Date:From;
        b=mYGFakqveSm6zpPCXpvLb2cZM9slX3UsiH1YS46BsSnZ8T28ujvCiOEQhaoEoCizF
         ElqvYLQI+ArjEXM68Kip/D3RDynXi3lwEqmkgdKJ5cLhL2gVMkHptQsk/b7Sw/y7Dv
         R0ZyD+OIi5C5MWXml+CI2UnxTY55Ns+kYZRjXX+wpN0yxHj4E04Gfkdz7Tqw/gnU7D
         /LWKLRPIMIXduQmBgKo04CyV78/lb7E9+6zg4MSKJLb57PYJAz+8kcELuBwXF6C9V0
         b1Ua8V+DftPUwUs85LAmy9QGvTWQvB/mqn5OOucd69RCEpZFPDh4AgPKVj8STio9av
         LQvObFy7Y9C+w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Miscelaneous MTE test updates
Date:   Tue, 19 Apr 2022 11:32:39 +0100
Message-Id: <20220419103243.24774-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; h=from:subject; bh=jrRh+8wStvVN/Hd3Nb9FI4sSmTpR9aUxzMnC0aqDmSA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo/Ghgr6cFblAnK9/EUiZlU+z0dC4fFztExS0t+2 LfeGPNeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6PxgAKCRAk1otyXVSH0FMrB/ 9bqW2u7B1dYSn5wZ+oDxPXjkJrZyVGNXvM6wmruJq6zP1zTU8IgaKwibFz8S/tQTNcqKIdgwHW7g28 T7mIGmEqRAa2A6jEV+ofRnCgjsCogJQSjqnuUM/dwi0JT+fq1dov5dPebVY8ezg3E3xUJ4KUnBPxMQ kRkYMF6dlZ4Pz9UrQ0lJiY4AbjoLyIqVRPYY/huKZ9UmYxfI3H6KITLSkhonG6FmSjuk0cPx/PxQvq OFQniQ9wf+qKGxsbh6xOtr9Ltycn/HWrJy6fyYY8/vfSX8VmFlHwK/lhoPT4CPnlPbyNk2euQjJxgg TqqDn047pX7zbTIn5uZtu5d9o0GIj4
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2:
 - Rebase onto v5.18-rc3

Mark Brown (4):
  kselftest/arm64: Handle more kselftest result codes in MTE helpers
  kselftest/arm64: Log unexpected asynchronous MTE faults
  kselftest/arm64: Refactor parameter checking in mte_switch_mode()
  kselftest/arm64: Add simple test for MTE prctl

 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../testing/selftests/arm64/mte/check_prctl.c | 119 ++++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.c     |  19 ++-
 .../selftests/arm64/mte/mte_common_util.h     |  15 ++-
 4 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.30.2

