Return-Path: <linux-kselftest+bounces-47692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BFCCAD8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C72C300CD66
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52216332902;
	Thu, 18 Dec 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRirV3Hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563E3328FA;
	Thu, 18 Dec 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045613; cv=none; b=R1lWVBRnGn3VWf75Ulbr5f+1PRwhb86cF31rVcBTev5tKlfR0flwAra30OUcPXx/tI3R6x4BJ6DuyZ1QDrvcJ+8BlkqERQW+P8B7GY7P3yzcUuk4UPPT1Wtt7f4whUFel03VnXWQWJdlSTC1x2evZJnFskyAxh4PzQ5W4313hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045613; c=relaxed/simple;
	bh=p/HV5NAkkDiAEYyZwvxSSeBqc7NHv593vzQCAZgVHbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cy+lw4TZ7RxxG59UWPNz9bEacHGxXgSOd1hWF/EI+v0fzc56OrdID4pnfIvT70ZevAJ27fo2DPlDzuCs+Yp/Rvp/VQEIt/MIWFal2zlfWcSOHIpMUpu7PhQ5l/UDiDh/8L7uYip4Ai42s2ihoO5JZXaZ/agNknuitjernu689Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRirV3Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E31C16AAE;
	Thu, 18 Dec 2025 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045612;
	bh=p/HV5NAkkDiAEYyZwvxSSeBqc7NHv593vzQCAZgVHbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JRirV3Hm29C4eUeVBA8PiCi1dIazJYLZGa4/fMPh715BJJzjRxsEuo806PXIzyKRQ
	 XM7rNmJzdwU2c8vkB1Ik5ol5YKkzVHo+5cMeaFw9QAxBJC1us2D14kOmK2gs6v3GBT
	 bHNE1htSQpBttc8eZNfdOe6WmU5/LQkuax4h4vMuFZ218xnaEdyydiresqnE98HmaB
	 g7TKKdM4lUW2kM8zw4ZT3Likx4a6eWNkb8lLFXT6dLBZ5gLoDGyRj1pbJ1Y1dJxdJV
	 RXAQIx9k7o/vaB2W2mG19V91r3jkTQvBN+vmE6QODrg7pHzPcHut9x0TmOrZiDZyhO
	 blJhIyqx1Qixw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 08:10:10 +0000
Subject: [PATCH v23 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clone3-shadow-stack-v23-5-7cb318fbb385@kernel.org>
References: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
In-Reply-To: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p/HV5NAkkDiAEYyZwvxSSeBqc7NHv593vzQCAZgVHbg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ7d9SDT0u5qV6dyQJiXLZWIbDp1RVQNiCMjDM
 PyMXHcbcguJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUO3fQAKCRAk1otyXVSH
 0Gv2B/wKmkBlyQZoiw7flpJ77bHqHVOEboQlVL+wfZauhfIxd7dZygbbm2lDl4BaqOtUsOkjzOZ
 tSdhtLV6jtdEGE43lDgQj685rsO5wQFGSgTztumUN203g6nX1+VBPjBrNL4kdvOaOfCfqomJYZY
 iDS2C38+pt8PteqNP1zE9DWTY9XBR+kzUkfIB7NpCkxLdJDcsUQNcSG3lOajLLWORyu9DcTvEp+
 CyaNBVcBtpqaf4w+V9ivt0UWjUv6FsUIuoi+qysNkBXbDQdBFKLrUtp2DvWtENilXzGxOh3c9p0
 2UkwBGE8Ah0mrbTyF4XoumW8dgm3ZT9fy9ET/ihp8pBaVdD7
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index a0593e8950f0..a7ab2f1cccda 100644
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
2.47.3


