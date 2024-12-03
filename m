Return-Path: <linux-kselftest+bounces-22772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58C9E2CE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 21:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BB5B473A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1B205E1C;
	Tue,  3 Dec 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx3vjB/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90720205E14;
	Tue,  3 Dec 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251466; cv=none; b=IkaeB3HYEaZCfN2wkfiARa0Pt/sfwchibeuuXeLXqtdCuyfdONkGQhHSuwoj0HRj1zoYypm62s0VNnsaH70Jb+lZinrVExZa1ocrkuXYuJ31YDq3HgfX/h+R+Hr+iXRbV4BDKWltNVZLY/vZcoK7t85YbBPvaILKkjX27Wh5oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251466; c=relaxed/simple;
	bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nD1vVTUYb9DtFXkcj9QzcIguo/ntKBUqXdjvd/wo6nsWuEFD5NGisCMG2Dd4lrmXjTvpT9bUPxcdKLEJMWXRpQ8F/prXUUaxUamCgWK/Pa9Ydc97yPmRDJzeOPhHvi4dM80X7YQp0lJVJnAs6h+OUmvQn59o9nqxAwWQ5P6eVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx3vjB/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B8AC4CEDD;
	Tue,  3 Dec 2024 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251466;
	bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hx3vjB/rCjDGEMZOJldMcskWOp3syVQh0qpixHcdYbZ7oTt05j7tJWPclX87BvBOi
	 nQ3rjeF32i+yAZwDKCzQVm6ING3UrJLcR1himpKRTuN9lW4LDt7vjrd3tgyteX4qak
	 M+gOxXCj2kl7n867m0j1SHMIOtz4sc+fXqu+xmvI3DwNkafEmSgw7TTWNUYkEj1FSV
	 Ciq4HsW/OLQIWJ4Bv0iSoskAgwPaWqVgzenkaRefps57Efgnq5sUDrbV1zdbMX1qUQ
	 sHObTc+DunIS5TcDRAsCemvTwyp+XFeWD3zM01Hrmv3MmDUc+zoUtOgtidoakcdbW/
	 FjcM6D6bAwK4Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 18:43:39 +0000
Subject: [PATCH RFT v13 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-clone3-shadow-stack-v13-5-93b89a81a5ed@kernel.org>
References: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
In-Reply-To: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
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
 h=from:subject:message-id; bh=PnhVCE63r5J0w6Q+lF8rA/22EDQWPUEiFQtbWxOidH8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnT1FiPGuGG9F8YqvPDKVh5qYqoyw05th4BGvH6a8z
 bsztwliJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ09RYgAKCRAk1otyXVSH0BR9B/
 91Y4vEiFtJDrVZtxCfz/elE4eUMeO8Z3NjLy1acF17Kl7VcZaizZpoWSItRK6EeNambZMLoDkgHuvk
 betvtwkStk6yptW/hHSEbTkCTPh4L3ib0AIYywdgT57xDOLg7MRFWwyNO4BuYtC5Xc7G6bCHSwLlHm
 GSln1PsLcLbR732G2s6XZO02tYjzGRI0JJrwgZiXMK9zQfPtdSSLHaA7R9egPEKUUzfFqJDgZP9Lbs
 HnwInzbTtSwRhg5P8YAxu3QzJ0PyQ6aPTOpanGN6PYdqLJXln5RkGgMRlkvE+cYtIcmKWN5myCgf4z
 afTLrZI/VX77BpCWkXpjXRvYfTgZZh
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


