Return-Path: <linux-kselftest+bounces-21580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B19BFBD7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614C01F228CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA838FAD;
	Thu,  7 Nov 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUkKATgw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAB374CB;
	Thu,  7 Nov 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943832; cv=none; b=XZrhOySYCdePmMrySK6L3jwXVbhAhD1Qw6SMTAUaQbPNs6L6p7B6/H4jq0ZZStOcI4k3OnSPH3UsERXDdaY0neLPUJuPfUWV3Z7INOjJQ41F3TqzFU6hhcaJmFB0y8KcmFgBF3pkpZOTHcBCfHE2nPLtDhYdOFMKVyuqOtCscqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943832; c=relaxed/simple;
	bh=0bSqJfCBOTI4Jmz4xl8iWhEjG/ZUwMwS5LAsSpOElfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtbuMoUe/TbNk2ZCi2/NWdLL4aGpGUAexpUbSGY19w5QCsbYT7cFsnQ4mJOzKrfyrLc3Zd81a1XaWQxaE/alQMjBmANATbK65qcFBw6bDfmZXOjYx3f+PCQkv/d1Huy9Pn0fcqyETulTWGd/n95E+ckJG3W2qAegVt1sZbpmIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUkKATgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8410C4CED6;
	Thu,  7 Nov 2024 01:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943832;
	bh=0bSqJfCBOTI4Jmz4xl8iWhEjG/ZUwMwS5LAsSpOElfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hUkKATgwOUiynyRaCLwhg28ZBXndF/nkmS5+NsBGFJ77E7tKRWc/xWWmBq9AWEU20
	 eg2Hp3nUIYojB8nOZ8XR4cc2XfMip+g6ql6M7kqgmNUcqFN+5fyI3qkR2GL9BeZL9h
	 lh5kXV3HvpngOLIxX8qHzWzCRT7Mtk8un0l5AbzHkvdzN4JxyFQP2CpvWDJMtXjU8i
	 Qx32HnMp3RRo1gRJHT2yEy4/KSqHRSFSYgr+YqFT+xyGbI3TlAzQPguEw1XcXiq4Kt
	 xsCzOIC7X1QZ+N9hhv926A1Q87jHK+ye6aJHB/tDVPJp9TZtBtCzuPcSxLmPmvh8g6
	 FD3EtRnT8uUAg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:20 +0000
Subject: [PATCH v2 1/6] kselftest/arm64: Correct misleading comments on
 fp-stress irritators
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-1-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0bSqJfCBOTI4Jmz4xl8iWhEjG/ZUwMwS5LAsSpOElfs=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnQdaf+pybN0Nz+Uf9z3XOk/V30ft+Kz1H8Tmw408aVGujZr
 OizuZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmoqTB/j/zXSXPHp5Q9wuqnNlTJ/
 dy394V1xd7XDPEomniW1H/wPiQuLtZr5umd9tWtG73vXfvHdfeLa+jnz5Q5QtfM0+6Z4r7T73gxzGS
 du+vftWfu7jsqljFFaWZ69/VPCzc02Dpy2nnEv7UrfmK14N7ETPjZBuvTvqgExTcX7BrAqObn2ntzb
 /8wso5LZ65i3NXv3R5zKhkrC+16v1Xx1umR2eItCXvuz1rVx3HrLwGO6/921vbCoWOF19u23xCVtTw
 6yq/lmAD5bdzZ8unqJ/gSFfu3Xh4tsU35/46hZxQQ7uM5ZtOZEb+/XXNPiw5oP5PjQSjCFPothdGgT
 9VT/CcDzwfr31v3vN4bp8Yb+aPAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The comments in the handlers for the irritator signal in the test threads
for fp-stress suggest that the irritator will corrupt the register state
observed by the main thread but this is not the case, instead the FPSIMD
and SVE irritators (which are the only ones that are implemented) modify
the current register state which is expected to be overwritten on return
from the handler by the saved register state. Update the comment to reflect
what the handler is actually doing.

Acked-by: Mark Rutland <mark.rutland@arm.com>
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


