Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694A1408CB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhIMNVQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240357AbhIMNU2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4020660FA0;
        Mon, 13 Sep 2021 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539124;
        bh=mA+0CsuIfJkgDiC6lErrWJ/d7egZo8invcZOmdXVmcw=;
        h=From:To:Cc:Subject:Date:From;
        b=X1Itwk8uzhl9R5+P/dW4Ty3ZUvVN9iRMP04zXoWvWN8vn7xIeIF6Xfw89tIN6vNKY
         sM+7eh/L6vG2qLUV+ikepRGUVJBTYlaB9oDL+TGR/6WCd/zasJHoGo6YLRUnKZyhms
         cgk1dwI++stNjPFycgb1Eghoh/Jw7qQoz9btfOLHOhDbJfAKGC2W2fFCcaSHU/sKNc
         3/jB/L/Tiwihj/4BoYYlp1ITnn/Scg0HdM7uvSNORimx7wUzaX9fqKg28zzbWutzOA
         +w0hYVjBdeJYliJWNFcttd+LPYzvXqQ6qLsyTP/uVgPl8T+RiXvshFpCBK2VQUw1cT
         ravae1dlJJFwA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/8] selftests: arm64: SVE ptrace test rework
Date:   Mon, 13 Sep 2021 13:54:57 +0100
Message-Id: <20210913125505.52619-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; h=from:subject; bh=mA+0CsuIfJkgDiC6lErrWJ/d7egZo8invcZOmdXVmcw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0oiwiuP5irtY9k38zY4yBBsYwbYq2TmgQuPNY+O pjmsYKiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KIgAKCRAk1otyXVSH0O0iB/ 9V3eyvh7j1+KeRJpClTv14LVGGsLF9j7CERN9Cob41AL5+pfO60khtw6Q3epB7JU7kBZmOkaFJetDw SydpnAQPOclqmvfqWRp0DyGkUHAn1iEjHfMBeaG/jLbP/97crl6P2GsmPkMKlai9Twd90v0PljXOSJ rZIP32EfCZBorqv0GSp3JxrqoEz6NLoFQKC1uybVXo7IM1cGFwd1P16MEsBLLhFZFBiRxlhTitHJRN MGa4r9ukpXhXKmVnqR2n4EO2/IuplRqt5AzLIVafteHvg7I29Gsx1k9IApbwg7uwlZc4zXLcyHQboR WgouZIfFVHoVtSpvFbcGBB8ClzNxOg
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series overhauls the selftests we have for the SVE ptrace interface
to make them much more comprehensive than they are currently, making the
coverage of the data read and written more complete.  The new coverage
for setting data on all vector lengths showed the issue with using the
wrong buffer size with ptrace reported and fixed by:

  https://lore.kernel.org/linux-arm-kernel/20210909165356.10675-1-broonie@kernel.org/

(arm64/sve: Use correct size when reinitialising SVE state).

Mark Brown (8):
  selftests: arm64: Use a define for the number of SVE ptrace tests to
    be run
  selftests: arm64: Don't log child creation as a test in SVE ptrace
    test
  selftests: arm64: Remove extraneous register setting code
  selftests: arm64: Document what the SVE ptrace test is doing
  selftests: arm64: Clarify output when verifying SVE register set
  selftests: arm64: Verify interoperation of SVE and FPSIMD register
    sets
  selftests: arm64: More comprehensively test the SVE ptrace interface
  selftests: arm64: Move FPSIMD in SVE ptrace test into a function

 tools/testing/selftests/arm64/fp/Makefile     |   2 +-
 tools/testing/selftests/arm64/fp/TODO         |   9 +-
 .../selftests/arm64/fp/sve-ptrace-asm.S       |  33 --
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 460 ++++++++++++------
 4 files changed, 321 insertions(+), 183 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.20.1

