Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346F241C833
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbhI2PWm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345050AbhI2PWm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59781613D0;
        Wed, 29 Sep 2021 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928860;
        bh=0laa9Q9iEd73V8q37+sSzQnxV7PEKjUrKEAHxjP+ib4=;
        h=From:To:Cc:Subject:Date:From;
        b=klTJ2tpP8uAqqs4LxOvwwTUyKpPJXgbSeQbLpUziegI2WF7Qh8BsuayYzWbBD/8L2
         XAki/g2lrqvfdWoiuQykC5dT6ZRqQw8f+bgFuKkhws5SbMjz+6DZUAro1kE1j1BIo/
         m5ktIPf+EAFmSF8jIsW5bsiZmXec9R2APSOR/Oi0zlK8gXfVdfehnqCo1CFmXV6b5L
         NVzA0Jo48ExiWFfQmNzEgpjGRKbFpgLJm0jdU+3pZH/g17CnawRhrFsZriWl9gX/t1
         ntRXrLw56Zts42zgQEFAQVeFDi9br19Y4TCBEIA9GXd+ofJ0T95+0X9/ZX0YSunWkl
         VxCERfNqs3jJA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] selftests: arm64: vec-syscfg updates
Date:   Wed, 29 Sep 2021 16:19:21 +0100
Message-Id: <20210929151925.9601-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; h=from:subject; bh=0laa9Q9iEd73V8q37+sSzQnxV7PEKjUrKEAHxjP+ib4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVIP42b1nIW6DP8taU4r9aeRYPBKTeks6COsuV6WW X7rjmgOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVSD+AAKCRAk1otyXVSH0FPVB/ kByW8j8MYoIflFMF7eoE9doo3WKtvoAHu8j3TkwVXRXXd0/qQSxCllPwpRu0EIKpHW0k/rpiKfcD/V W1yw2S0bj0iS09ATILN09vbsnoq4iMSXXNMR8rlniq8QMwXm0bem8M1TutiemTc9rmtE8tPNfPvl6i R+9HbsFRVF+K6diEvIk6ZupUr/4iUPIVS/mq0e+r4CbVrduMxb+zKRXHiDzQNnVgz8PVH/ZPzOTq8K KfQlbO3dhVEAyj/8jvUILWobPKgMtEMREm/msOr2jqlAoYgJ41VMs2zxZIBEA5AC/2qouo6BMpoUlT R2kzETFY8U0AjeqXNPhloqvZuieQOU
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes up a few issues introduced into vec-syscfg during
refactoring in the review process, then adds a new test which ensures
that the behaviour when we attempt to set a vector length which is not
supported by the current system matches what is documented in the SVE
ABI documentation.

v3:
 - Rebased onto v5.14-rc3.
 - Check to see if we discovered the system vector lengths before trying
   to set all possible vector lengths since we need that information to
   validate the results.
v2:
 - Fix handling of missing VLs when checking that vector length setting
   works as expected.

Mark Brown (4):
  selftests: arm64: Fix printf() format mismatch in vec-syscfg
  selftests: arm64: Remove bogus error check on writing to files
  selftests: arm64: Fix and enable test for setting current VL in
    vec-syscfg
  selftests: arm64: Verify that all possible vector lengths are handled

 tools/testing/selftests/arm64/fp/vec-syscfg.c | 95 ++++++++++++++++---
 1 file changed, 82 insertions(+), 13 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.20.1

