Return-Path: <linux-kselftest+bounces-25917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9EA2A7B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A7A16632B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AA22E410;
	Thu,  6 Feb 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/VAl5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259922E401;
	Thu,  6 Feb 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842042; cv=none; b=AKGnmSy5ord2uStptln8cCOdESXzAKrTj60e4FMEqi+he/ja1kn2aPoLAf9Dk08y54xrAW+6DQ6a1HAnU7gIM87AdRiiwS+CnX3R6CQRzVIV1U8tJoapi9q3L3+2ZNcOymtMHvdpqNxKegDP9Kj7F+aMNfHb5pXD2mSHporfQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842042; c=relaxed/simple;
	bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5m+6mw6jTdFXLfTABAt+IeyS5Hc1uuE4oI3caHonho2KsSZyWwjqPFIj+scdvgBiNdT8SrRR22Ws0P0oG7iSdeSG2NKBSvc9AHPYGrouqYAOQxYjwWmSv8q5rAVuX0rtbkdbRYL/FowuxE+k/JXd+a70bW7IrwVEvj9LbqViVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/VAl5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D77C4CEE4;
	Thu,  6 Feb 2025 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842041;
	bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bU/VAl5Zwm7krQlPIdYlYd3cmkHLOUDNTdJRp8x4RdkxzInIxsKafCazvacl5gFgc
	 vWJZxlOnYd2KTeVh27Z6Zwuwk+1RYc6Bpshl76FM5HUrBsllmxI76ejxBPqjr+Lpee
	 TplJ7K4jvX58fQIL+dBsND9tVyxT1e2xdjtBhxAKhXDmmUsgbx4RIGndn8uuC3I3uo
	 MuD7JGv2GBy3oLRzHCpyJLNbApK8n15O0oF0767yvN2bNgQ/TirSDjt805WVuSVqoz
	 N294Ltl9d+ObtjzFlsPzN4zpl9Xff90gcDBjgdQwBHA/4wMxpWr46BuevYphpJ31L1
	 jrzBvwGzgaqJg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Feb 2025 11:38:07 +0000
Subject: [PATCH RFT v14 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-clone3-shadow-stack-v14-5-805b53af73b9@kernel.org>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
In-Reply-To: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnpJ+SDt5MY/PeYn2i3MjDTGqPfut3rGjAzO4UGMQ5
 rwFJFNiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6SfkgAKCRAk1otyXVSH0JeLB/
 0aRBuFzEuX+vu9XGmqCIolu3o5bGLCbpfX0Q8Gh1mdNKDlIX7gBe84m2oewjRlRdUbE+/m9tlb2VrV
 sQS0xE1j30SQeJ3Aom8EYam9Io0JfMuy0jPLkeJ5O+ctqdcGs8wzdtX7cLr+rRuE9+ouQHcG8nONKZ
 1LueuNhIgNPjJWuxJ1jzYppaZHPLN2l1Sm6bpodDDpfA+XhggTDoIL4s78lW7u0cmsripxWPsRsjyj
 68/lqwnzN+le1OnGM3HOKtAwvknsPrKJCspZdIpV90g4dqWDOLZd5ojphKrlVu2afzeCDLYimuyAn1
 aZPZiSRfXq6XGOqC5PIGYX8VmIp2qh
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
2.39.5


