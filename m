Return-Path: <linux-kselftest+bounces-29336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51301A66DEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278193B51FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D41F872B;
	Tue, 18 Mar 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTSZQsWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32E1EF39D;
	Tue, 18 Mar 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285825; cv=none; b=O15XUAFjuBEWtzqwrvZT1kTXFaBsYFYZupg3vJZS8uR1v38zFF3lX60uRtq0ca/IF/p72xW215WFgLZLr5oxddmenRYyn15UpRXbbaEp6NcOKDB+GNrpQS9HCQngXfLHjE8/JF+2e6OAQhAa310+42+ZiF2P6xIEIqUw/HcxdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285825; c=relaxed/simple;
	bh=SyPRS1VQKcQGW7s/oBLq1ciCntHpRx8mww8jsVEAmhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9j41eLYc/MbYRUv8c2eeQKc1Yffixa4YRi05E6r1mFDkNiwKeUIpQTaeO7wkDeN9keVOw3BInO4Pdrkwla/8HXcGkFI9GON3KnFKbpM0kv7BAjTjG+zqD98iKZD5Ga8E/mFOjLA1ZJL13y7L1xJGuL5MbqfKcvlobd5Q8RbSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTSZQsWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40285C4CEDD;
	Tue, 18 Mar 2025 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285824;
	bh=SyPRS1VQKcQGW7s/oBLq1ciCntHpRx8mww8jsVEAmhA=;
	h=From:To:Cc:Subject:Date:From;
	b=CTSZQsWJ+c3bx2DH4kww7FY3HWFKyDFBv1hZIhX+a+Hf2BPz/OnVT2fW5fPhbxMUJ
	 RLucUrR98l3QJyT5Mlqbl6UyRnvAKpm2DcA59sC+oKEHQDsI29XXDd3MXn3O9cWiZK
	 pLpd2nc7bnqvlOCmSPQCkVfm6+/5JUBLUgmmd74jzXdJ8Svg7P1zJZ73OywUu4aOqy
	 ywUWBkk0tlIRpnLFEuxXiZhtTcjDnrHQ8UYasWg+zdGf0pnHCQ0JhtGz/xGvC+zKjK
	 5hKxZ4eT1uClQjY4lfxU5MpQZ5U3WotU6h3OqQDHcR8I3kUTdRRedwPpqlrrLZRIss
	 f5wgrV2YIe+0g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Sanitize pointer prior fclose()
Date: Tue, 18 Mar 2025 09:16:47 +0100
Message-ID: <20250318081648.122523-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

There are scenarios where env.{sub,}test_state->stdout_saved, can be
NULL, e.g. sometimes when the watchdog timeout kicks in, or if the
open_memstream syscall is not available.

Avoid crashing test_progs by adding an explicit NULL check prior the
fclose() call.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/test_progs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index d4ec9586b98c..309d9d4a8ace 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -103,12 +103,14 @@ static void stdio_restore(void)
 	pthread_mutex_lock(&stdout_lock);
 
 	if (env.subtest_state) {
-		fclose(env.subtest_state->stdout_saved);
+		if (env.subtest_state->stdout_saved)
+			fclose(env.subtest_state->stdout_saved);
 		env.subtest_state->stdout_saved = NULL;
 		stdout = env.test_state->stdout_saved;
 		stderr = env.test_state->stdout_saved;
 	} else {
-		fclose(env.test_state->stdout_saved);
+		if (env.test_state->stdout_saved)
+			fclose(env.test_state->stdout_saved);
 		env.test_state->stdout_saved = NULL;
 		stdout = env.stdout_saved;
 		stderr = env.stderr_saved;

base-commit: f3f8649585a445414521a6d5b76f41b51205086d
-- 
2.45.2


