Return-Path: <linux-kselftest+bounces-20508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C899AD5AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018CAB21613
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665F1FF7AE;
	Wed, 23 Oct 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEBz9J2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1761FF7A8;
	Wed, 23 Oct 2024 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715983; cv=none; b=Nys2niRpxW46cnJfgsaNUPTTfNTgRlOF4kGK9FYhng8IrCxByDklNIiPb/rCpih234sx2eJHq9sMRHeMHAIQJG+j0zQu/XO/fAa90bLTvZ7sNzUar4VnZKv8QKLNMhLm2pK3Vms1pr0ZA7/nJkyR6PgrHksIzp6fLOPxqYcoYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715983; c=relaxed/simple;
	bh=/bHrhesLCeIwKS6Tm5OOpULv9OOeXujD+y0vb5AVloM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfSW1LjtYYHlvyW+Er8IMQAvA96kBTiq2vwPRaVtGJSoovhv4XMm9ntkrQYQvtM4E7Culm65NTPQR5bYkcFhYslBWTV7lmlp8jb3GkVwRsttp1wUl/b5VNkGT4wj/qCIMxieJea21YH/qu2zkhxrOGou7S6+vo+fJpxZ6eroGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEBz9J2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451BEC4CECD;
	Wed, 23 Oct 2024 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715982;
	bh=/bHrhesLCeIwKS6Tm5OOpULv9OOeXujD+y0vb5AVloM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HEBz9J2SYayNbbRkBwd2iwxoESLTRpgf1SxBFOntvWwBVNUv28S3mZIaSuhRmvayR
	 jQ2lwTFB5OV24DDouzZMEsU9VYK8Mpf+ft/Vcva8GApuEThPqQwXFmrF8APwzG3czW
	 2Chi4MNYNRA3IpODaKSuCt8oW3b4sxHbCVA7M3MdxuwYIozafqU2TxQpRe5NLo2otu
	 xmqM9O2HWAj7ptDz3y6DAPQV+ts2l/oD/fx5RJ37NdPFDBBNMNhgIu9OBumBnYq0P+
	 rH3RqA/nOa4AR0HraXZ5lqUo7qilZEhp8SaHhoa4NmvdEIW6zIky2/CEkuN44alSQR
	 mS33JnbX5cPdQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:29 +0100
Subject: [PATCH 1/6] kselftest/arm64: Correct misleading comments on
 fp-stress irritators
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-1-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/bHrhesLCeIwKS6Tm5OOpULv9OOeXujD+y0vb5AVloM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8Gc55M2w82ehj/LpjjHUBt4adVvVgcz0prD+dS
 XvsOxI2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfBgAKCRAk1otyXVSH0CA5B/
 0c7+WD7+iS6lYyf0bnJuH8r+L60B8ehcqJrpsjYxePuktHethpL14YIdnlm0MeLaomjRQqDl26a7h0
 7QEyHO8j9AwYw6KYE0gIZfQLbawPVnu5cl4Hwo9nODuwfvRo8286EF8lBzbpPPvFRaHO1VYuYhCNeA
 lNfN16OdFKjhP6YpxNxYKuJHChn2L4BZeqy7kMcBiqISG6+MbUlD6YgzxsvpbwRzxKAHodXlNfaMHp
 sJpVOv3LW4gibvdMHqDEEghYc5SkuWcvfjRWYhsObwwrNev33WFLOeIKNlzU3bSLZmbLXYGb2Bgtsr
 3lUfYaJb55y0v/wJGedDx53K8xYUam
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The comments in the handlers for the irritator signal in the test threads
for fp-stress suggest that the irritator will corrupt the register state
observed by the main thread but this is not the case, instead the FPSIMD
and SVE irritators (which are the only ones that are implemented) modify
the current register state which is expected to be overwritten on return
from the handler by the saved register state. Update the comment to reflect
what the handler is actually doing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fpsimd-test.S | 3 +--
 tools/testing/selftests/arm64/fp/sve-test.S    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index 8b960d01ed2e0ef516893b68794078ddf8c01e1f..bdfb7cf2e4ec175fda62c1c2f38c6ebb1a1c48bf 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -134,8 +134,7 @@ function check_vreg
 	b	memcmp
 endfunction
 
-// Any SVE register modified here can cause corruption in the main
-// thread -- but *only* the registers modified here.
+// Modify live register state, the signal return will undo our changes
 function irritator_handler
 	// Increment the irritation signal count (x23):
 	ldr	x0, [x2, #ucontext_regs + 8 * 23]
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index fff60e2a25addfd4850ef71aa3cf6535ac880ffd..e3c0d585684df29723a49265f3df6d23817498c7 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -291,8 +291,7 @@ function check_ffr
 #endif
 endfunction
 
-// Any SVE register modified here can cause corruption in the main
-// thread -- but *only* the registers modified here.
+// Modify live register state, the signal return will undo our changes
 function irritator_handler
 	// Increment the irritation signal count (x23):
 	ldr	x0, [x2, #ucontext_regs + 8 * 23]

-- 
2.39.2


