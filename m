Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3D3DEFBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhHCOHX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 10:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236514AbhHCOHX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C5096109F;
        Tue,  3 Aug 2021 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999632;
        bh=ckFb0XkUcQ+z5yIZsL4be9ZuCeRo+R3uqsj85+boQZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l34lfKH9fpS7PxH+XsgEEiZSM69TnHlXHEmQels620+55P7crJSJSBmKJt0fxPvv6
         x5HNHdP4z0EU90kyml0QC19ta+Qjr96z/52kjE6O4dMD4WEvj+mEmwst+fMVoYmvSS
         gn2RcqC2H09NoW2HnGWrCf751sfB3clyXkwMaYMVfGZ0954WFFIg4fZMex4qId9Rxj
         L7By35MKljKwrMdJBqbauQm8BEsJAPRh+SZtgxz7fLbXbYp71BmjDJ47pci3NqLgzc
         kIKCbAFYthSDoTzJp/gZVseF/1jzt1c/bXMyOOCFVRSNR25otZ7LyN8dvm7+MHxQlk
         mc6XclNU/7J3Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 4/4] kselftest/arm64: Add a TODO list for floating point tests
Date:   Tue,  3 Aug 2021 15:04:50 +0100
Message-Id: <20210803140450.46624-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803140450.46624-1-broonie@kernel.org>
References: <20210803140450.46624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; h=from:subject; bh=ckFb0XkUcQ+z5yIZsL4be9ZuCeRo+R3uqsj85+boQZI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhCU0A/AIZFwsJX5MFEL+yg9uGqFdyidL53LVC2BC0 pdprvxSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQlNAAAKCRAk1otyXVSH0EUyB/ 9pxh8auFgRWSXooaQdP2MvpGhj+bj8THiDhmHxjEqAgMzegtJ9OoWQH3hgpH7IkXD15/uuRP8lutLn jICOYLzODPsC6HEyJMzOqCrsefLd/tsvKTLkukiJVfRWVin4fJVtfwvb/q5hb8UVl1o176rzSk3v9B tC9EIS3dFKXggIA6R1tM+CTzICjqWYq/uUKIsmHtqn0d7y4Ap0+O0BxHZCo2R4oNDAxQuCvk2CS7J+ C+muLcov3zYsjItV1sIV6EG7rxMrD+U7q3Kqzisn4O2SbV1fdosOUAN23C34xoqUzzpNPSTNPgmtCj ZVZoxNlQtLwap0fJ1IyJA5iAyNpuMl
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write down some ideas for additional coverage for floating point in case
someone feels inspired to look into them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/TODO | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO

diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
new file mode 100644
index 000000000000..b6b7ebfcf362
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/TODO
@@ -0,0 +1,4 @@
+- Test unsupported values in the ABIs.
+- More coverage for ptrace (eg, vector length conversions).
+- Coverage for signals.
+- Test PR_SVE_VL_INHERITY after a double fork.
-- 
2.20.1

