Return-Path: <linux-kselftest+bounces-15915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE895A57B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D2FB219E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA91741C6;
	Wed, 21 Aug 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoKw2yZ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE5172BD5;
	Wed, 21 Aug 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269858; cv=none; b=Ay5a+slU+2mSBpteJVRkX2kHttBDhW6BxMhp7mslEy4SRB+BOQsNS2fSmFrngUByTOWKMG8fUSXjto9FU3lqMgU3NLafR7B6z0jwBjf09dnMhwIsHkRH8pzlSGgZBKaqP/Xw80wZlaOpwN8y8MhRm7LnF3wlgwohJB8FNEhIp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269858; c=relaxed/simple;
	bh=j9ob7ZYoLp4hP0MnrgcOUFxUwkxx358xO3rY/g4W29c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAR62htgGZvI0thLZglrjkrc3Dp3GVYSWXf6I4b8q8u4Qg8CReWeqmS1BMUtmaQeuURxHcA/B8NfqQ5/qIwl1qKqbu5vtdIumUrct1JGHH7R/8yxKdYWM3O5aH6MUAcihaoF+OPV62lvzXHQzD3LIwY+24OUk9iBftcMgyOt0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoKw2yZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB3FC4AF14;
	Wed, 21 Aug 2024 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269858;
	bh=j9ob7ZYoLp4hP0MnrgcOUFxUwkxx358xO3rY/g4W29c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MoKw2yZ9KV1p5r3J7S1CSQ9O3+nVD91Sy68k+/7/QcHB37D9IhNcXSVRWbKtcDHsX
	 OxoFtjah3jsvRu8UjbDY03FMKrKNOCwm9X6w/DmGmP+VHI/hVvTTPm0MvfexxVet+T
	 rUOui2+ERQe7j/kM5ZVXmKy10VCkL/N/7HTPU8DCy1a657SANGkKOCXfvbF+/pWUth
	 1zOiDf8+U55NXq64FVxMzXK0djXbWiKYJGR6MuAlIKBp65e5C8cKiaLcPm27eIS3M+
	 Jf4HdIdGVb5QoMyw9ABba4s9znFTwTw1jDFNcUw42h9CEs7Zq6utF9unmw8tfmze6T
	 S3BLHjKvpF8lQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Aug 2024 20:49:51 +0100
Subject: [PATCH RFT v10 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-clone3-shadow-stack-v10-5-06e8797b9445@kernel.org>
References: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
In-Reply-To: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j9ob7ZYoLp4hP0MnrgcOUFxUwkxx358xO3rY/g4W29c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkT3+D5LXm84pnj9roznmK7UUj20NrCOZrrJXoNZ
 VIHaj3OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE9wAKCRAk1otyXVSH0BdzB/
 47DHhwUw0m/H9CKUCRzIjZF+ciL+wgACMoWQW/F7u4q5VayUMv7J3qXcrdjTFWQCK6TOpAFAJRWlpr
 QPkvP1ZaBxDuKB5iPNoTEcAoHrZvpLk8PcjOCbVPuDniEV8JWth6RbgAKZYJ15X2RCyS4gaT+sWuRu
 2m5z2kXUmn0t+FcA/oGvaanhYjNVMDaJRlhYyCMh2XesRSYzlCuqv9Qs1Zmelgo1Qf7SUahZpGYhdw
 j5l4QWFq9LTK7h8tpPJU/8isW1jM/ovcDTLENLg8Wi0xJ8YuemUOofObkJ7zmwB75Viw3QJK9UxfyI
 V4ZP8h3498/md4jcU363yxLjDmVuLM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..39b5dcba663c 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -35,8 +35,6 @@ struct __clone_args {
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
-	fflush(stdout);
-	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
 

-- 
2.39.2


