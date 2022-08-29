Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF585A51E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiH2QfX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH2QfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC817E37
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E086123C
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00542C433C1;
        Mon, 29 Aug 2022 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790918;
        bh=rgZeVaAQOuL3m/C8WBnuLmQQu27R/Lxp0H+/EePZFac=;
        h=From:To:Cc:Subject:Date:From;
        b=E5+jYf04qJcXPfA2tkxByj+17e6U/57aNeXjpJUJcp0pchU4Rh5JLcsNUaUMuhOlW
         ylRMPp8MUVGthQZgsik53JNFnexDbAzCq/3A9ucOPS6Mm3hlaWjca2UHcVoGD6VLQ3
         iTWDA04d8pvoWKBdq7U6vP/aQwQsU1K2Ahzu6SxADSVYSZuEg3bmaedWjRiJur/fgR
         vWt2w/TdCKNsgXyryoTqnI6DwnKrPQHQ1fbJ4i0XLZZV6JR4phvFc5YfvNWyEbaw0V
         BaJ9ETQGS0HbT790JcYyOX3F2j8VWrMp346cPItHK5tLNujIV4UyoFvpUfHTgQc4vE
         8BNAJ5k425laA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] arm64/sve: Document our actual SVE syscall ABI
Date:   Mon, 29 Aug 2022 17:24:59 +0100
Message-Id: <20220829162502.886816-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=broonie@kernel.org; h=from:subject; bh=rgZeVaAQOuL3m/C8WBnuLmQQu27R/Lxp0H+/EePZFac=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOhaUBHrLwn7X+8iW3LFtWFbkJOiDpUyblLMjAOp eVzlUOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzoWgAKCRAk1otyXVSH0DHxCA CCQGPqZh5FaRnfiB8QRQG8EXja65zvc196j5hq8qshAYjYvxDhFezIwv3ABfO4sE2aIEP0e5Axme4O vH/q5uAEZiATTpxlvgB/ydCwHmD4C15JFxcng3iiNpR3mFpSZcDB9S+bH8UcXeqGCeb/P0W34oeLri x9iNRnHvWJWhLBlNTlsaj/DkT0ZdQwJz2vhrhtZki5ZeKZXVMkALvK/ggzEDLsf59kmSl7cmc7PEON 7UNjXFKGkIziMz2R4Dmpga0U5UDtfREtWd44hN3YeiKnQkZ3gmfKRDopEe3RLQUsT3SxngKdOkfmQP iAkkjEiGMK476BxxfeAAAf2DKGNqYy
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

v3:
 - Rebase onto v6.0-rc3.
v2:
 - Rebase onto v6.0-rc1.

Mark Brown (3):
  kselftest/arm64: Correct buffer allocation for SVE Z registers
  arm64/sve: Document our actual ABI for clearing registers on syscall
  kselftest/arm64: Enforce actual ABI for SVE syscalls

 Documentation/arm64/sve.rst                   |  2 +-
 .../testing/selftests/arm64/abi/syscall-abi.c | 61 ++++++++++++-------
 2 files changed, 41 insertions(+), 22 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

