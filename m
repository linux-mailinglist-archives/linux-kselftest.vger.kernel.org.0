Return-Path: <linux-kselftest+bounces-30922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C494A8AC32
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAC7A1D89
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5172D92DE;
	Tue, 15 Apr 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6PldiIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF242957C5;
	Tue, 15 Apr 2025 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759935; cv=none; b=aq3RubK2QKQw76uCTIuQMBccfQ+WJkTdN8tf3XJoWz2wY7zFZamC9CwO7/5B4VnX6PcHFqWXl77d+gr4Nf/NSfc2lLzEAWdmhniSzY1tul8vYDHENuVvEse0gCSOecB+/pbvxn4rs8m7NyLeS7du0oMX1UtRhhwjsfPpojwVJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759935; c=relaxed/simple;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLabeWM1qdG29YiAIQGpaMoJo4idEhbCxw/CTO7mDccZ9kZ/zS9iR8Rtgxpv6ZHndp7CPT2HjscrBkbrvhb9R3bRiVKkhQxFUJVbp+ntrKOORR5GuhN2fisBL2y64sgb3GL5rsWVnBtvdazD4ivhJpdxdbGkooqCW8KRfNwfa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6PldiIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DA6C4CEEB;
	Tue, 15 Apr 2025 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759934;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O6PldiIi0Rdv+U8lBSkuOZoa3Mkx1xbHU2GySWjxuQaWGFCgQ9ohuvG+ceM02d5Z+
	 rIM+QE+SHa8TYw3fvELAXBlFM5O/+JD4QFXfn4doDf3fbA6aDNTTVtI4EnLLGC4x73
	 HhoXfahgItSq6yhYLCC53rrtMqGCJPxkkWgBcuVYYSAHReXwvNtbV946SXKYgqCXIO
	 CWM899mjwq+bfJNgp9b2SF5b9Xlh4tzL3yLOG8Aq4nE+pSSWt861kB9Vco8L0u4PCN
	 +Kjj3E3A8jYBb08s3Xm3jp45m0SQpiKJKr10z6sWOxhzANU5WzZEAbf4jNODYEPN3I
	 P7p/lIdGhbCiA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:12 +0100
Subject: [PATCH RFT v16 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-5-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn/uxXLPA2MHp1WY76h8D0i0egTceyqPIUhaOhpAFN
 TNwQHAGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/7sVwAKCRAk1otyXVSH0BDfB/
 4ouepZj1QcHV/tVhjplIlFFGwkUsDD+qoQkAfBbVjqeRlffWLDy7WallhKm7dQZkJRL1gPGOzdW9+g
 x59MOk8caXI0kFlrxLtqahKTVQ4ALbyxo638jk/3Ytsw5uxla6kMqT8GViW3Lol2Dpfs4DuGrB6xde
 liAPDx1CfzKFldm1+TL+Ci5faRnY/BA4vevbCPE/oH1pitGJkFJmKussTIhs4jkQUQUy5lxWMiBlrA
 f2jutfnGTjizzan0rUiqhNrF7LMrkxZ13ZdLq4q4QSiLY7eoKWKMCt3/B9emoF3v6WAHhP/9izKmUg
 fbVOyqainPutkLDQ7JM6MkYIVLpwsv
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


