Return-Path: <linux-kselftest+bounces-213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540297EE0E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DB1C2048D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15710951;
	Thu, 16 Nov 2023 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFWyR79M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0A10940
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 12:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4CC433C9;
	Thu, 16 Nov 2023 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700139158;
	bh=z/GTSUVgAaIxP2s2u7Y93d6tpqT1f5YeehxRbaLZg2c=;
	h=From:Date:Subject:To:Cc:From;
	b=FFWyR79McdYnQ/zWZpLU0bpBFDvKYQZj7QVHyEBTWrLTCTV5TuYoIL3eEHeFtzv/H
	 rHDQKWxucUUble4HOh09umUcOFcVwbuBqFiaz3xVW+HjhQ0yLz7/XHYuyTpilXTW7Y
	 uN+HmsVVx5vhFT0Q8B9LCiXohJ6lw0fJJNS1U7s0dIxrEvi5aXwNVKSJB3vlT0sNuh
	 BLx+ep2Zo6WUNJlBO+736GRJKbpSBRDWuUEekm/+WwKlMv1JtDNQcFfCwgc4wdjVKk
	 VT98l5ZT6M1hYba8ZnEkdMQFZe3Xsnbch4BzfyoN8G6fLku+DDrWBkFZUfrTePdBOH
	 5fcZ5xb9yRAwQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 16 Nov 2023 12:52:29 +0000
Subject: [PATCH] kselftest/arm64: Fix output formatting for za-fork
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-arm64-fix-za-fork-output-v1-1-42c03d4f5759@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIwQVmUC/x2MywqEMAwAf0VyNmDqi91fkT2UNmoQraS6iOK/W
 zwOzMwFkVU4wje7QPkvUcKSgPIM3GiXgVF8YjCFKYmoRqtzU2EvB54W+6AThn1b9w0NOe9b29K
 ndpDyVTlZ77r73fcDk4urImoAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z/GTSUVgAaIxP2s2u7Y93d6tpqT1f5YeehxRbaLZg2c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlVhCQKIl3nvwpx955b3AQ0M511w63OM2oM7kzO
 W5k2qAY2t6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVYQkAAKCRAk1otyXVSH
 0H5vB/91Jpk6PxJcrw2BnwzUUGipORtm/pqOhxlTCwAc30s9vw6ZZsEmPMBVa+CoqjMBryBPRAH
 DzNfUYacgvCnUDq1zHWzlrBIBHC1jrltoTlbFO6VNy/sJ/KAh43DhQ2K101Q3XlH2xYe/lepvp3
 6vsFLCAXFvMZDEs1YMS/qjLSrXlbm+ZkkA/zNBOGXuBsfIb+7AGITEnCxFYs2ghxXZq+XUHD3Mw
 +MsCiCJl4c2Qo7/dQUmj8Y6T1qaX37EfJaaeuoewjxqSROIF/UkucjQXOb3WrujDe7VXGVVipgk
 nDSuUkso4zn8kZiqYBHnNWi5KxHm/pkuqDa1ttTPx3B+Qmls
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The za-fork test does not output a newline when reporting the result of
the one test it runs, causing the counts printed by kselftest to be
included in the test name.  Add the newline.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
index b86cb1049497..587b94648222 100644
--- a/tools/testing/selftests/arm64/fp/za-fork.c
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
 	 */
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
-		ksft_test_result(fork_test(), "fork_test");
+		ksft_test_result(fork_test(), "fork_test\n");
 
 	} else {
 		ksft_print_msg("SME not supported\n");

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231115-arm64-fix-za-fork-output-21cdd7a7195c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


