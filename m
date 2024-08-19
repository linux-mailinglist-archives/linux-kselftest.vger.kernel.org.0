Return-Path: <linux-kselftest+bounces-15694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D5957466
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABBD1C208F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73A1DD3AB;
	Mon, 19 Aug 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct2gCKg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133D1DC48E;
	Mon, 19 Aug 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095599; cv=none; b=SfV+q0uKh+MSZkiyCab2LQrpormgP/sIeLYOFoOF/qcpAmhg8HGfG6GcWCIXW9Eyz0vO1wGBJHHM3SB/ZHqSwDohvR9KvkOZX4GVMJGAYL2nUJ10uaVt10fQEoDAMSrVDAsBghsro9gGkrimy2NYuSk9IsJn/OsgbDqbWaBJomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095599; c=relaxed/simple;
	bh=j9ob7ZYoLp4hP0MnrgcOUFxUwkxx358xO3rY/g4W29c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qglM7Q1ftRB0FsClRoUgFWWixPMRWQYhl4UAVDX3om6d/3myJSm6B8GNx4BoCOU7xTAHXuggdhmzSF6DmqjXwxXpql0W9UoJj6DPFut3OIXwvilZUbrTfHJpXHh0DLQg/P63jLvMuDs37Yxeljx4hTgXqEKmzzM3WklUcs1fnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct2gCKg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECC8C4AF14;
	Mon, 19 Aug 2024 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095598;
	bh=j9ob7ZYoLp4hP0MnrgcOUFxUwkxx358xO3rY/g4W29c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ct2gCKg69IGce57qBJiGSp+85i7msM6BmHmvMaTzQ09NrIxuigsS0FrV5QSl8Ne6r
	 YdU+n7mGrkTDcEBEfNr7e3fLqtTX9JPxILoMjGnvfjaPJ2LI0ByhcotqZuCVDfLh+D
	 8Rjo0N+s7mFIHDpV+PFtD+NZKzwH7ZH3p0Sdj1lP4uAnkzJLcCQb0lbndoeLYEIM1k
	 fnJv8GlQraEZkBobUOBaXI5z8W7yL9sZtUoeew6KwaVUPnB2BJLfPvtfckisuVnsCE
	 /HK1w/H5QL8+ANiBj8CmAF+0toYfhZq/6qe5VWblRnlPXCQfA9z6JQTneHkyfKC/Qg
	 V5e5wltDaBHJw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 19 Aug 2024 20:24:26 +0100
Subject: [PATCH RFT v9 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-clone3-shadow-stack-v9-5-962d74f99464@kernel.org>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xGTQsGFnnsXkzj9iyPYSkbO7zgaru1OyjNN0ln
 fdOTBH+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcRgAKCRAk1otyXVSH0KSVB/
 91+3bGW9gkcum5wjok8hv+EPZDZx0MgWGLJcZEcI1Y85ek4duInhVz+alA4WqQPQPKwdd7c5gwGrKi
 eBnOOppXivd5IHS5G7vxTpHUQrCeUXJBNbpycQ/oop6yHb6nshnKjbgcBCVfbxSQmCKKH/o3Ql3zaW
 WmEeNuYbV1DuocsU8yDxcYniiC6CIMIySJXfP4ERdo46s1S2l1Kmw4eMYUi7dH8dIwtjbi0vbSaag6
 ryN/kuS3Ncg/pAMclIjITW5XqA524+zzCWqmkjivdvy1TTF/4RKvPDgw7IvI3HGhqw4oq7uFEw7a5o
 Jiu928fQSbnzYx6lT653nnHCpHhgh8
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


