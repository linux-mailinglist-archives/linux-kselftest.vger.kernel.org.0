Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735B1592F4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiHONDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiHONDq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0F13E31
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D010B80C82
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C05C433D6;
        Mon, 15 Aug 2022 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568622;
        bh=l3XvK+jlp/9PYO7n/6J/JQ9jLg+oujmM2iZHtjmH5tw=;
        h=From:To:Cc:Subject:Date:From;
        b=Lr3an2+y9HQmvrHboaJSyD4RhjrAK3t/uPaGpxwTQ6GTk8mvwF9/oO6cBpR6YyjFQ
         O0aQodUHBfcXOwecECpK2O15kAWp0219PdVgzHalNo22oLX+yMbsJMaM7kikaFQ0VT
         AGbDyQXD6e6fUPW27QRlVZClBAqUu/seQ/DP9Ceu+GLCKzpklN5mb4OcSf4zDakZXI
         BWuCmMa3HX5+5EqIedT1GBQYhFXm5uYUAeoj/aa9lm4v2MfGcGKiMxYlu8sS9iolG/
         K+bAtBHVQ5QaQjhYmkHLgV0eqNRPV5i8Bn0lLWBvuYH68TulxBACwVYbETArziE+Mh
         dbvHDhBZLfuNg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] kselftest/arm64: Floating point stress test harness
Date:   Mon, 15 Aug 2022 14:01:58 +0100
Message-Id: <20220815130202.204725-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=broonie@kernel.org; h=from:subject; bh=l3XvK+jlp/9PYO7n/6J/JQ9jLg+oujmM2iZHtjmH5tw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kPF2GbIiTHYwL06NenhLj1/WJG/2T4E4b0qbVFu HXwkw3mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpDxQAKCRAk1otyXVSH0PEIB/ 9shQpdmnvLsHKshJ0akL/Y0y3uzabpnv9hO6xoijfDqKwyAeMRE8zVbFBz/QnHq1NppZsHByHzq4Qy E+G3Jq8nm2GKWtJA6ATLk3/iRN1CaV+yt2Y307uDzfF2ceIn9DbRcJFHRCDNl9g99v8kwp7iwJ+4hy zL+QXlGWt8pOovxtwsjBAFZex4cNuUpQeHOkw/qbElzrtQLdIp4qhAZqseo8iC/wJEsknDR1YdUtZl Yys5W2x/QgVABiy3INjXADQ14zXdvLxYF8CiHPFKOHTFTPxOeUKnahDvNcvZDAxWa5tVocK6HrvQLv 0Q3QIyU8C2wiolofZWF8c9IEnRC8oZ
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

This series has a runtime dependency on a fix "arm64/signal: Raise limit
on stack frames" which has previously been posted separately, without
this fix spurious failures will be seen on systems supporting large SME
vector lengths.

Mark Brown (4):
  kselftest/arm64: Always encourage preemption for za-test
  kselftest/arm64: Count SIGUSR2 deliveries in FP stress tests
  kselftest/arm64: Install signal handlers before output in FP stress
    tests
  kselftest/arm64: kselftest harness for FP stress tests

 tools/testing/selftests/arm64/fp/.gitignore   |   1 +
 tools/testing/selftests/arm64/fp/Makefile     |   5 +-
 .../testing/selftests/arm64/fp/asm-offsets.h  |   1 +
 tools/testing/selftests/arm64/fp/fp-stress.c  | 532 ++++++++++++++++++
 .../testing/selftests/arm64/fp/fpsimd-test.S  |  51 +-
 tools/testing/selftests/arm64/fp/sve-test.S   |  51 +-
 tools/testing/selftests/arm64/fp/za-test.S    |  58 +-
 7 files changed, 638 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/fp-stress.c


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

