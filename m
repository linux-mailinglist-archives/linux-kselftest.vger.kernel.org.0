Return-Path: <linux-kselftest+bounces-4448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822284F7A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F31C21B34
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0411127B59;
	Fri,  9 Feb 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKE8eD3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B974E36;
	Fri,  9 Feb 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489150; cv=none; b=YdMbO748tFRnjNw/B24OHj4mZVuVIaSwpOldteXyYIUgyfbAeq78otewa5ZRe3DR2A9MonssaN1yKjhWk5gUn6jYbSO07vIUOY14nArgSAwHVleePDvIVG6Do3xZeHUXfV3hpaZ2vu7APXv5KwmLpMdSYz9UrNfnns7wOpCSd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489150; c=relaxed/simple;
	bh=SNdpuBCpO0JSkOWXvK3leOkPlkJ8pkETSJ0EjQBtI1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivul2Iq+nuXgmCDC7LcQVCicC+f2hDT8mSfAjxYHoILu7bhIbKgDHgE/g4m1VambjG/56wucAm5T+G9dXShZk1etDHs1lq1l86v84VKCMryClKip53NQT+qoMm9KFMIyfSgqPGoaU2KvQe3IjijlbGdWgqBJIBx4RZHFFOjj1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKE8eD3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD0BC43390;
	Fri,  9 Feb 2024 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707489150;
	bh=SNdpuBCpO0JSkOWXvK3leOkPlkJ8pkETSJ0EjQBtI1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VKE8eD3sZWW5fEQtWPkCRBNkQo3ehVIXsOA9fELaVSi3m9F+Vd0l32uyrCJX7/rkP
	 Mod0j110Xyn45qDVbqHYvHZZ+2Q13WAbCjHuubA1INaigCrg+lNEzxm59Q174XvRqn
	 Ot1IkZcWh1jHJaH2i2jaWhn3wi3Lrt6+C313F11LHm6Bz+O0jST3KdcV05uivd6LZ1
	 vGg0REiPgMH/tigU2ahFd/9XG8Ib4pMGtMVPIrPr++s09K4zvF7dh5wpayHnFPXLn5
	 AurgQWPdsp73phvU2MRxKY4oZ5a2eZvmV4T3/QkYw/LVwCyeb/O/eH/Id+gfxOmL3Y
	 3mubJ3UyNBKUg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 14:30:03 +0000
Subject: [PATCH 1/2] selftests/mm: Log skipped compaction test as a skip
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-kselftest-mm-cleanup-v1-1-a3c0386496b5@kernel.org>
References: <20240209-kselftest-mm-cleanup-v1-0-a3c0386496b5@kernel.org>
In-Reply-To: <20240209-kselftest-mm-cleanup-v1-0-a3c0386496b5@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Ryan Roberts <Ryan.Roberts@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SNdpuBCpO0JSkOWXvK3leOkPlkJ8pkETSJ0EjQBtI1E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxjd2aWt1MZeqGP+Sjwd45kcKirLj+wtx0YjNP
 /5BRSewS8+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcY3dgAKCRAk1otyXVSH
 0Lr4B/4mqYsi2Lo6QA241MmfSg0cwBXmgg2LOHFVMA62X1zAB/NMIQYNAhSVIFZTrGaZg1+/KX5
 u7pVXzG8Y5C2XmrXHeMCoeuUAkWeaVV+tojvjmG4WUTO+cWJuqPJi7K4V5HP+p7i8YcPyqp1sUB
 rWkO4mJC6DQ9QVk6Oho2B1IGG9BBEYNwxEJqsUzB4/6VAenIJj/unbUI/thLu8zUFCTFQqRMjjB
 zXDCW0PlErz9/y7xG/p3G3CNYRekFr+mMLtYNfIposkiQ8NtFiUeE2HCaOXMYwyrhDM0AcAwjGo
 w2LwNXEUk4eEeARHxe3VeOud4S6J5gVREjwhJdtSPy93sbMl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When the compaction test is run it checks to make sure that prerequistives
the test requires are available and skips the tests if not. When this
happens we log the test as a pass rather than a skip, log as a skip so that
the distinction is clear and automation can see unexpected skips.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/compaction_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 656afba02dbc..30150929c8c5 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -174,7 +174,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 
 	if (prereq() || geteuid())
-		return ksft_exit_pass();
+		return ksft_exit_skip("Prerequisites unsatisfied\n");
 
 	ksft_set_plan(1);
 

-- 
2.39.2


