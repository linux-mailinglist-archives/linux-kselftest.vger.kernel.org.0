Return-Path: <linux-kselftest+bounces-37258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA558B0411E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6EB1891EF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE273255F26;
	Mon, 14 Jul 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CysqORFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63972571A5;
	Mon, 14 Jul 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502335; cv=none; b=qGc6r2C/G0MH67TkrYv72F9ZvQWhCOsYrI3xHaWDTybtiXzPx6Hy1ojFKJutN4ha7P1l8eHrKnD/aHbP13uRctOsGiz3qhgrFXJcqbbGUZWlYNl9+Enh1VGS43EuVB/eRRTfNv4eyoLaQoO/j2gdu0sN8LMxRhD6+FQ85uf0vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502335; c=relaxed/simple;
	bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+52AoJLq+lDG7rGZnZ12hUoNPU6IseFlUp7TdQ7S+LHOewiGgUnIETE/+jwCvLnvCJn8w9T7V6UqkNmV+VN3DQd89Yzj+3EClnGTWZInz2ZwhHi2aeLdrYVfifn5RSXo+JpqCASG9pehcAEIomAO64qni0XNoJS/JeFop5adIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CysqORFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07797C4CEF0;
	Mon, 14 Jul 2025 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502334;
	bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CysqORFb3xC8ZG6E8HU1d/Sxvgowb2lCUs6fO4R7hhP1ApCHr0+97Ypuy1/ns6zEY
	 CLw45FEWcShhxVrMhpBV9NddleL8HjTJqY34VE1frCH5mPKBSciUcEA++4vT67rI1y
	 JvEzfBP45vAAJdzJK/Y3dnX9Fweq1wwxN3n21HvtBSFCuLK6sxBo9LmyBVuoA8FUzn
	 t0GXG1x7M6hN4FcF5AHG4E7hmPmhFB/j2DkUfCpGOkE2O2B/cZgPCCSZHiv8uPj6mN
	 GaKjZ9cD/bQfTCbkdmXgYc/ew5Ck8NaRs2OsIFyKbW9TIbfR7rWLfqZTRIcfVTJ2oW
	 gkw6uDtosgxbA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Jul 2025 15:03:36 +0100
Subject: [PATCH 2/2] selftests/fchmodat2: Use ksft_finished()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-selftests-fchmodat2-v1-2-b74f3ee0d09c@kernel.org>
References: <20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org>
In-Reply-To: <20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodRA3ok4ladySzTp+/5wpGWVhgh+6kUr2lRCTS
 u8Y2U7CQQyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHUQNwAKCRAk1otyXVSH
 0HSLB/9IpFW9TNpPUNwBMo7mGE0IA+8mQNgdLfWpjIR2sCvuCiA7YYon9KnZ2yDd2IcBE5fCdiw
 n2Rm5fzKtC8nPfFZrU0S9aFsvmdu/bHVGugEuC9bEBmT9z7Il90Q9ybma1eVz8vvZAU/J3FQYjP
 WJ66fRtU1oY4RbJ4lOlNgiGPh/+4/zucdP2P3UwaedW2bGnQmd70SsZ1c4MgugFvs7FOelzWzwo
 ewAlVlYaoMVpfWiVIdoclgqlFGvqZXRSf0NyWnLcIctDQfKXdgW7sjWWG5l5rylXZfkmqJq7A0X
 4eM1sUR5jXEIlslBwMJe0ufeNkt4TbNGvp534Ifl2oMCUpAk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fchmodat2 test program open codes a version of ksft_finished(), use the
standard version.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e977d942c00b..d3682ccd7cb8 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -196,8 +196,5 @@ int main(int argc, char **argv)
 	test_regfile();
 	test_symlink();
 
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
+	ksft_finished();
 }

-- 
2.39.5


