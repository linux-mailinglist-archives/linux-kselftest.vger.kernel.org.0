Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05BF3D9349
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhG1QeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhG1QeT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7416D60F23;
        Wed, 28 Jul 2021 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627490058;
        bh=V33Ijhd+xG+OltrEOSfLIQyuHzAL4taRF9kOtS+AXUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNllgp2x6keKy5lkCWPCMBkFuGPNLW45u4DrEojxj5dJULeWZlBudYyxbqNieDhQN
         D8aIC4ilZHprkhDmdns3F5Lfvc75YTzKokTBZEZYijum6DZB6srZIl6oN/S6+OzH3Q
         CbSN9LjydMfL5xbme5wj44mG2ZolAf+hhfAheOwiXdAtg+X8ZyIN3XNWLhErb/5ef8
         NOP19tYmdaCcZf5ibRp+ZlboAoJxpdtPGUOCFaE6tCCC5a5x+WvDV97itWgnc9wOjW
         fqDvYIwnLYyglzEWvaA8O2HYAFOEHyAX1X3dJi5X+FsjPDT42elz6b/9FBCdwZduF8
         YgmYHzxxqXrUA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/4] kselftest/arm64: Add a TODO list for floating point tests
Date:   Wed, 28 Jul 2021 17:33:18 +0100
Message-Id: <20210728163318.51492-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728163318.51492-1-broonie@kernel.org>
References: <20210728163318.51492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; h=from:subject; bh=V33Ijhd+xG+OltrEOSfLIQyuHzAL4taRF9kOtS+AXUU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAYbLsZx68yAmc02VZ8d6xESMUx5a4KdjiVxwqGGD VtKCJjCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQGGywAKCRAk1otyXVSH0EfaB/ 9esyb3f9tcHVvoUjq4YtJcgY8QEfdIjiV+3cT94W3eRmkp7JCYKvASDQBXzGj3pGWVshEYzzqHPBAq JBN2RSGq0x7jf6bnK2qDtq73e8ZfaQhjYRhPMqo8UBcBu/v1oZGbyWWAT2YH6q8sOCYw8ys82PeWM8 c+8wOM1iqswInsNSSN6fPP8ktjjxUWbwSmdIvOyoOo3ZQxZiki3i/z7y0BvOAj6EnTuLTdkkkG912Y fvb1jbbp0Q9EfQUGvYBsxjhrWtdhkH5YDcg19keEcmfjp3OjyblfHfxrDMh0G/ebY6YLYzBowHxgdq +NwWDcjuCWtecCWNaG25dR7eWQHP8J
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write down some ideas for additional coverage for floating point in case
someone feels inspired to look into them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/TODO | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO

diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
new file mode 100644
index 000000000000..eada915227cf
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/TODO
@@ -0,0 +1,3 @@
+- Test unsupported values in the ABIs
+- More coverage for ptrace (eg, vector length conversions).
+- Coverage for signals.
-- 
2.20.1

