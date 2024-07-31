Return-Path: <linux-kselftest+bounces-14546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02982942E15
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80DF284E30
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE591B1424;
	Wed, 31 Jul 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht8q6aAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211D1B010D;
	Wed, 31 Jul 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428386; cv=none; b=K3YLwJSLy4pRBKvMHtoj8SMkt8mZzAsoHXZjdn+3xDLfhS/VJpLsbAmyR7ExfR183tvOtQ/8Gvki/uxNT4f1y7VjZpGqkMd6Jgm6lcuVyNYmgemIwYL7q1ns78/cFv8W9QvCD2o6sTLmnW9hwBtEUbjPT3Ou8JNHfzL+uc3TupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428386; c=relaxed/simple;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtlhCjiYFdA+KPdtZniOL/TTd/9gc1DHyUG9ESElGjxecFmkH/BJ+AP0rah3hCUKdm8p27MVTvTzybA2Lsnw2BsE8sXzZejI+5+NrG0KxKT87bXm8m8grxFGIB/bCCk1PAMmvW47+lF031EXDQoih6bRgqlzuv+bD9QcCCpBNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht8q6aAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCE0C4AF0C;
	Wed, 31 Jul 2024 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428386;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ht8q6aAYkmsoxJWrvp9DVOsvJNMUeaUQYvmi1zNQm9HZf+iO9FL8mW3fWpfmkqtLj
	 gSX58F7+JZ1teV5C5A4X1FhoJ08iwztwP+UkEc6iFS/0QNIEWw8xJguQrZFKY96oDT
	 0ln0u+o1diDHV31vAkwd00JUStGjZ4cRC5ALZTqIy46ilRjP79Bffpz0LCSrpCE1vQ
	 bu8lq814gDACrI7wvvwG14vw9wMCzh83CT4WvqPGsUqBWQ71RJO8WGDj6r4wF4Fy6G
	 KFzZRWm00lk3t1JVnllNraQqPiFh7ivqZuSx+V88aP7JVfn92nMWAfLCFho2lpTp+o
	 63x0Wi7qds+TA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:13 +0100
Subject: [PATCH RFT v7 7/9] selftests/clone3: Explicitly handle child exits
 due to signals
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-7-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqiuwbcO9UTdUesirwLQsw94zrJDokDcQEQcmEH9b
 Qqiy90KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqorsAAKCRAk1otyXVSH0PcdB/
 0f+JoYeSHm2g+j+gFYmG6VcSGazpUHB49Dyho4aDTQtJyufbHcP9xIKuK/Lj2BNApVkHbpDpZ6NSUo
 fWjsOzSTmJYXo4tpllISxzZDvIb0LsHVu+IcZ2jrk350lhimnJ0stdumPhBHUaEb5LXUV0ZoN+viia
 YVcWnZfGDq24L1sUguNdo04C2FKqW5V16qkIuLKSt7ZP0tLB2grNxPE3UUjZTVJF/84y4RYvtzWp44
 MoUOZvWbE0dxn0Ug2qbpSLYjkn5DQxcgkVfOFaASX/qHqnc4lzO9/AwBK3m+FjBW97jqTkH1k3heuH
 e0Rlk9HWFAouPIVDwI0s8lRJb3zU6U
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to improve diagnostics and allow tests to explicitly look for
signals check to see if the child exited due to a signal and if it did
print the code and return it as a positive value, distinct from the
negative errnos currently returned.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e066b201fa64..3b3a08e6a34d 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -111,6 +111,13 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
 		return -errno;
 	}
+
+	if (WIFSIGNALED(status)) {
+		ksft_print_msg("Child exited with signal %d\n",
+			       WTERMSIG(status));
+		return WTERMSIG(status);
+	}
+
 	if (!WIFEXITED(status)) {
 		ksft_print_msg("Child did not exit normally, status 0x%x\n",
 			       status);

-- 
2.39.2


