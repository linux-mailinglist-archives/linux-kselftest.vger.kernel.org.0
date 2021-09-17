Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB59640F745
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhIQMLU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhIQMLT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:11:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE2F60187;
        Fri, 17 Sep 2021 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880597;
        bh=eqg/nDhFJayhUYdR3eTgL9JXj5aAu9NgVnQhmHor+MM=;
        h=From:To:Cc:Subject:Date:From;
        b=NvSjDT0TZatazYAOK421dNGJza2GvUpVfqtqnBsHUGy/0llYhEMaHi+lIIIPiEHmV
         eD2zUr9qzNaNtbMKzSbzyXaSxkQ/i9JxbSUVjO5w6zdIFWOXR9JGsnKjQ/3tAD9XDe
         s3ae29F2gc5N7z0hYAvpycuYXRM075Dcj3opyexIvv7mC2HMf5hv2ORccAJPZgVWfT
         f8GBiGmhLBBCTbWnVzQPXvC2c+fzO1Gph/xAqvIVx1PHd0VSzJYjWdW10Wi0M3neJp
         urEa1b3CtxSLir5diJ7U0y9m0ElpPFJ3x5b/quEUajRW8hZPseQ6nel94qwcerfZiD
         vr0yAXfDzSbjA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Date:   Fri, 17 Sep 2021 13:08:51 +0100
Message-Id: <20210917120855.13858-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; h=from:subject; bh=eqg/nDhFJayhUYdR3eTgL9JXj5aAu9NgVnQhmHor+MM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhRIVRICuTTOTtT5mOuYFGcjIkmsm4ibuRsYG9ZoO6 6sSThDyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUSFUQAKCRAk1otyXVSH0D7JB/ 95WoFMZVB393/u8DprskS8KjRsaBJsVgufi4niZEuSU/b+sah766hvmHpkVjsApRhR0YZ3QekMlah/ WLhMXuLQuHtYysky4uhWt3DjOYl8Jvfnzkdfr0YnGnXHOKDDTG7hOGorRTGFZEUbcN2ZBGRmxSuBDh 8nDJPI7oCXHmAtX8vYDHMcdVIpFLYsWqelEe9ApfMHf8lz5X08jWxgjhHgiWrdvu7srI/umryLP7nN feIdWXhuYA1ZOhI3/uHA5v1VMZKLDk7PLlmue0JZkjG+LpqVtcOSOnXyFKD4G1RVene8shjIT1QTeJ fCYMBYPtZ7or+/Ea1yJ8g8s8L1ygbB
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

v2:
 - Fix handling of missing VLs when checking that vector length setting
   works as expected.

Mark Brown (4):
  selftests: arm64: Fix printf() format mismatch in vec-syscfg
  selftests: arm64: Remove bogus error check on writing to files
  selftests: arm64: Fix and enable test for setting current VL in
    vec-syscfg
  selftests: arm64: Verify that all possible vector lengths are handled

 tools/testing/selftests/arm64/fp/vec-syscfg.c | 89 ++++++++++++++++---
 1 file changed, 76 insertions(+), 13 deletions(-)


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.20.1

