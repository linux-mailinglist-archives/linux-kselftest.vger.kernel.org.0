Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B735A5067
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2PpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2PpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8262205F5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4280C611B3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2859AC433D6;
        Mon, 29 Aug 2022 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787912;
        bh=3gHAMufKGhBfbqyt4qNJAHJiKw/Eem+SlhUrWXhGRFs=;
        h=From:To:Cc:Subject:Date:From;
        b=ICYTHJ8sKCBUCk1kjEFa3L/OGWginCz6IW4AXnG8oZdqXyf5dwUCNZLPvuzZxBpDS
         AhbK5LPRAi9xI5pJ/I0+VGhyYTlKFyD2HrUig7ZsQbA5e6w8PUDpxqJbkbUhF+5Qxn
         HFtbq4hS+fq1s09JAnU+2HavtcGJFPC2VurEciuGp60202FlkZ1mnVlvQOsTVFkRtJ
         cZdjsdylLAcgb4SrGPQ4AbrTUIZYkW7vS9UCQVK7MVdqEaAV33G37gu4NbWkGPRXIV
         Hhn4QT8svxMwQWLbS+H4OedcZOZNUcsTgJ6H70WbopH/75xz7TQa+iRwjtPbMBxrFo
         V97C2xwYxkf1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] kselftest/arm64: Floating point stress test harness
Date:   Mon, 29 Aug 2022 16:44:48 +0100
Message-Id: <20220829154452.824870-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=broonie@kernel.org; h=from:subject; bh=3gHAMufKGhBfbqyt4qNJAHJiKw/Eem+SlhUrWXhGRFs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN7wa59b1VLrVzFzjimvUuplqXqS8J2yy7Yf4qwh 42khnn6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwze8AAKCRAk1otyXVSH0GK7B/ 0Q1WfvWlQB3THhDQsMoaDrLbk4kfAAN+X/mOlYMibmUIR96Tc7zxvTvA0Jzd4lWLbvpcfml0tUIa+a IBjX86OnH1c5oCq02IryBsN3FJqhIlv4Jc0/6ILKiCwGexgt1sb2xCK1Sau/mm+7Dw6oPDBs6WZXDC gZH0nSUfe8RKb3UweCwkN8Z4vUbmIcV9ixrwP9BhZz1WjY+1oS/J1gj1qomZ6kg4L/D5BdG5ALt4Xd bYbdrkbd45RThzMZgjUGc/ntkA+iH9liN+3Yj47w1x+vShMzreOkEyd/zs5AihEtoUk/J1EkB8E4ti wOk7UfOnJItVZdD5FhgFVL1iOWsbRh
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

This series has a few small enhancements for the existing standalone
floating point stress tests and then builds on those with a kselftest
integrated program which gives those a very quick spin from within
kselftest, as well as having an option to set a custom timeout to allow
for use with longer soak testing. This makes it much easier to get
thorough testing of the floating point state management logic, rather
than requiring custom setup for coverage of the various vector lengths
in the system as is needed at present.

It might be nice in future to extend this to attach to some or all of
the test programs with ptrace and read/write their registers as another
means of potentially triggering race conditions or corruption but that's
definitely another step.

v2:
 - Rebase onto v6.0-rc3.
 - Announce the results of enumeration before we start everything.

Mark Brown (4):
  kselftest/arm64: Always encourage preemption for za-test
  kselftest/arm64: Count SIGUSR2 deliveries in FP stress tests
  kselftest/arm64: Install signal handlers before output in FP stress
    tests
  kselftest/arm64: kselftest harness for FP stress tests

 tools/testing/selftests/arm64/fp/.gitignore   |   1 +
 tools/testing/selftests/arm64/fp/Makefile     |   5 +-
 .../testing/selftests/arm64/fp/asm-offsets.h  |   1 +
 tools/testing/selftests/arm64/fp/fp-stress.c  | 535 ++++++++++++++++++
 .../testing/selftests/arm64/fp/fpsimd-test.S  |  51 +-
 tools/testing/selftests/arm64/fp/sve-test.S   |  51 +-
 tools/testing/selftests/arm64/fp/za-test.S    |  58 +-
 7 files changed, 641 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/fp-stress.c


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

