Return-Path: <linux-kselftest+bounces-40552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801BCB3FC6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611B57AD1F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCD2F5491;
	Tue,  2 Sep 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCGaZZyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1428466A;
	Tue,  2 Sep 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808573; cv=none; b=WrmRQupwkjatC6p+ZwjrpYgG6C09UIE5i6/SQjV88kffQpBWW9z6alcxCbbS6eu0vS9V6j4uImxwrnw/ExxNXvqGVVIk2GTnAKihkUhzaLWvO0+3n6Xyjo77i5CkIfWm6w8rCqik6PtP0FVzap3HgJe+M7GwaJYQ3jtLQM726zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808573; c=relaxed/simple;
	bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRQaKuDxpc8AC1Sv797UUOIBT8VqajeNwfXZ84yr8Zpk6hNRBkAwq+EuESVtJ5eEF0gjYI6jQE2MCffNRVX0r+uj98LF+Wc9fdLSWH1w0whU3g7nBubBnwF3K6e264kdE4W+5Qy/3JKMaOD9134e1ezDioiOpDuHkY6mNP1lpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCGaZZyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54EAC4CEF9;
	Tue,  2 Sep 2025 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808572;
	bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oCGaZZyPLqQXCDVtkGHccs4sMYQytwbOeuBabRhu/cAhlP9JDw8Eof6/6VzYuimeC
	 dSelB5Ih0O5lHbFktR87vshlfptsSei6iMLCH5UqHQ9JaAzn/toF3TnVy3dgGZqkwH
	 KLdZxT9lmNYo+1Jo14ybykyx4d1qkixpzu7xII/E6FJCallqabs3WKO6FmccxrAUmr
	 gMwRxcKZVTLyH+FWwrmPu53ecTLCNW28+tZtuATXrzFRDBBnqDsuep4hQ7OzXscR0x
	 M4b1EC6LbLEYpT0eO7ZR5cUgNhJDVDN7L/6E+QW4MU60cVINnFvHFSaOO4Nj+4rhas
	 1qpq+4YOrphAA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:49 +0100
Subject: [PATCH v20 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-5-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVWRP3iBqfaGDsEwUZV7WCoebNlAg+31iLJ2
 i/73Lv8TMuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFVgAKCRAk1otyXVSH
 0C+/B/0ee2BGEMfoL62ZEkbha4zuCtctfokJ9gIIqKGXk3MYnYkFaXzcr43bF6hUFv1U3sv6SGQ
 91xkxsjK8iLhYPPjsELjVEMXxoeszQI4hvkFITI5C6s93zfiFqk8mJJtTLevHg9DutODKD9s10R
 Tbhrt5Hjyv/Q36FtveHV+i8I2hegC/SfY+M1e6tdGtShfswinF1TN4g69kCRyAxky+OrHM9M0rA
 iKa7Q5tS0GBosV3JuoC22mV5w2AqpuShJvYuEsuwy7ShB0kubl2KSmBEajOEOcVYW41DTcByEpr
 htWu/QzkLiPEHBsX3El1L2SZLXglBD0LbjFpBANbzI8YcYDZ
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
index eeca8005723f..939b26c86d42 100644
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


