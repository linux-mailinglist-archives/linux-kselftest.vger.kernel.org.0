Return-Path: <linux-kselftest+bounces-21253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091AA9B8368
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26ED1F238F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487D1CCECC;
	Thu, 31 Oct 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCrrqOvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E1CBEA2;
	Thu, 31 Oct 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402765; cv=none; b=KvSb0YolFCm1M6CkiQ3oGaC8ft3RO5TISHo1XGE8psm23JQ2bGQ6A+6lHR5sF36V5CKaHzvtWGdRHHllAGQi08IbiyUChRakvGGjrF9yvp8nWi+HvNEMNtJ6kasHr/9ECONHnKqTKrUINBjW6+nbLtr7BsqkqMZj5yJDbr8X6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402765; c=relaxed/simple;
	bh=0Dl3uDEeH7NWGuu8VVS8yQdc9lIyxTmUs6kDxTA2NxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfG//nziD4z8fTmszN39NeEfdfpNuAVD6nqKIVpuQkWmPjmOcoSeHn744APvOU9t07132sWOTFnpf/SuwqXwPxuuM4DEBwlXilyMeyrafe6hye7jvzyreFbWsl7rk2oigwK+hf3Nw3NeSThuR1o+28hRU+czIkIWRXlEVGoHLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCrrqOvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F95C4CED4;
	Thu, 31 Oct 2024 19:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402765;
	bh=0Dl3uDEeH7NWGuu8VVS8yQdc9lIyxTmUs6kDxTA2NxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XCrrqOvqgE560dtfOdgga3A0c+E2SMDMB0FFCvOTOudH1VVoSKXP4necPp+qYm8oZ
	 6MCFnX/aGaV1Ws65qWEFUYfew3f83aL4mspyqt1yjsFnFQ9qde5wygZF09gsKNpng7
	 dfKqu9vSNGzitgjGYfNztIig4XjkNwELY0TKkdRb02QOe//Wrb0hVDOUHSZG05bjqz
	 ETIymC/4xCb++tjdSudPTBLVoLnfKeqkAojEwMMzb6C7azFOQZ9KoeQsLS2axOp6og
	 YtmPfqWyn8jEVhkwOAYXYWckLUU7MWOs96LH3AR/mwfCLK1Td4t2ezYsdjqFRy6tLx
	 zV42vpq3FD4eQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2024 19:25:06 +0000
Subject: [PATCH RFT v12 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-clone3-shadow-stack-v12-5-7183eb8bee17@kernel.org>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
In-Reply-To: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0Dl3uDEeH7NWGuu8VVS8yQdc9lIyxTmUs6kDxTA2NxQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnI9ml0/MH8CawbYcgZ/+27QQybx5PVsbZXmn+QAEp
 r/IkHoCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyPZpQAKCRAk1otyXVSH0KhdB/
 9DnxfO+8pieUd7gqoLYjq6rUGtBX/UU1zJfwhhHynM1ZfDqh/xUZ+2v8t/1JBZ5rkkSDNVVr7GWFyW
 1Qy4uNToAeMeNrTuW6ofgj9qCCcsZZKHIhhxM2u6ROpQ6fSP8qU2cR3fWcqybLq0BYR7uPLVIfs4Dc
 JrclgFMDDJisYzSSd8AFHNxfNdASRS+gtroVSM32+kZrbBl2BKOn+RMFvdxGcSD/faR+IkXWUSwtMw
 A+Zr2Gtw+t6JmivdserqsIMM5GbqMotXmMPPTnouXhHMs5hoDE5Fr0bHwWTfd9TYSX0bmsHmhOuRUN
 n/y5P79I9HUcCf3GdbRlwQsXlBirgR
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba56f011629e4f2eb68a72bcceb087..39b5dcba663c30b9fc2542d9a0d2686105ce5761 100644
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


