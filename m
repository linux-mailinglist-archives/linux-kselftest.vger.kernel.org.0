Return-Path: <linux-kselftest+bounces-19096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71E991614
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549DD283F28
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9B14B94B;
	Sat,  5 Oct 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyH7ieI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479013BC11;
	Sat,  5 Oct 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124392; cv=none; b=oz/ygrcLn+e9nv702W7YB9M8FIb14Mn5pnsq7eLZq4jlWnOdLTymtatxz2UEUY54F2zfIkVTy/6S/eIVKXu6mrIDltm58PkXM+Qml0cejD8VRg54DNNt8I6VEZ+KC94FwfX1Cjq5wKNmVtHHJt1W8f0MbqMWqv5zJ3Gy3YV5k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124392; c=relaxed/simple;
	bh=429Rfem38BUZ9Ha+P7tmsQvwi4MZGvihbGBHtztpEwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5yeELjkTWyyibP+onJ0CFioHkuxbOaozEHXWzL3v/bJ9qumFIvi6FfM7jiyOH1cf8bJd9xmTE5oaXCtqqwF5+QkGVaQE0AU5yMG3QcziQiFK8wC6afM1oAXtJCctV9/a+tX/X4vb1Rxl0FjWNMGgwfm/6QXjhwzQhhy691qCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyH7ieI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D67AC4CECC;
	Sat,  5 Oct 2024 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124392;
	bh=429Rfem38BUZ9Ha+P7tmsQvwi4MZGvihbGBHtztpEwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GyH7ieI9Jb8nOzKWNnRdtxc9ypNYVPYtPGOR4L0pGp+1DbjymDxzqO9CceAxdhKOS
	 YAI2AgK1cdXkUi3f9YQzsEDg8txMPhFLBTanTYpf6bXDbP+GyLDPFuMy2Q3oDv48f5
	 8mRn5sJuPc05/QKCgaI1uEcu30OWcmJsxOWuI+MbXSuAMMU4k6JAmimhJhO2cQhujb
	 evVfUio08stPuqTfGxnBXhHOPixCJJK0aKe1I9NPZ3seDlMik1n3fSG/zFO6sVI/sl
	 xRbTXwwJadJLUha+piV8kGKXwkqXbVAKVzopGjDBBfxt1qoVTxvJHhTye53Ya1V6i7
	 dtNn4dSYbW/qw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:32 +0100
Subject: [PATCH RFT v11 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-5-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=429Rfem38BUZ9Ha+P7tmsQvwi4MZGvihbGBHtztpEwE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARW+9td3kWcf+jMf9S+ta1Rptcq4kXdmGzx9uzgd
 DSbMsJWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVvgAKCRAk1otyXVSH0E7SB/
 9TYgkUROHh5SzmPnIP6PJ0VCqOATolw6jRR+E4HG5NjNtUg4gXy+hNWTEhQ24FqEm2DLHpyFDLK/rT
 ffryWZyS1iVfSniHMhKanbuPRmGdO+z1xoISwEKQUvJWcB68aHD9z1sLX5N12pisGr2KZqE/7pHF+F
 0g5/q8IrB6gVBBQfaHh+Tg0sAnhBM4LbMP9a8RIYCGkxgiYBL6hHcNpB2wXs3S4kmTHjDOH8j0o6rg
 YJMUlRCfsdj69anI/ckbB7SFEXQ/It3PG3Cw/hQ0b3Q/3O1Ni0QbRFMCyIxtYRnbsymm/kBGDpYsJi
 Z8lMHPd2SeMIjG8KO4glBFOFnPhYjl
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


