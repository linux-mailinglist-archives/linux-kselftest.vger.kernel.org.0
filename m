Return-Path: <linux-kselftest+bounces-12516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47884913A0A
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C01C20CC1
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202251304B1;
	Sun, 23 Jun 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGjsBkwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F2135A6C;
	Sun, 23 Jun 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141994; cv=none; b=GnJGlkErEC/BiNrJxGh3bxn/cTN7ZMOFMcfVo5VxAI76xuOD2dn4004X+lbDNWwYUgyeArgInJ7L/1mswRtfM2QZOUVaIWW32nuc1ltn9RqodokMgjyqE+E1tsHawc8cW6BhDmfpX2IO+UuliXkftVVAQtHpCfcKZongjosWYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141994; c=relaxed/simple;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtfbsfsYMMs/w9ssXq2+7hR0BxDVgaYr9Yj1/KwUXNipp95gBnvk/dbECwx2sA2uKWAW5gqIymTAl2tRSX2B8hqehD3z9tKi/G8bQkHmmT8YV8xQyBdjbAZXD/5plkqyz/6k79AAgJhLcW3qp5fADSn2HLoEk8dP+juSbaLvRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGjsBkwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111FFC4AF0F;
	Sun, 23 Jun 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141993;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGjsBkwIcvBhTSmRb8zXzzpwfmks29t54lBO5zwqYR1uD1dmFeWtH7zjyDEOrh9YH
	 j7MXeL0EDzzImO9A5giZ7ir7bgBhYz/REwLGTQZnUErCZVDy4/OOXFfEzpZAiEcW5s
	 bNWRjw1QnmsxHJoCuiJoi9Z+bG4w1ofUPfdHjGutNcYbFy6MOiMHbLK9bZi9bqJo8j
	 vf8Ii4mM7cz3TDWQUchS1vAgw/o7ogMqAqVxRiIUPxHhmhthOZowMftFEgO+5TK2WS
	 83tlqrfZec2Y91oSzLlEkUdqG6C6DxPiGhFUvNeqkZoeDdU5F/b0ce5ybNI3SK8Ga6
	 IPwuX+c/J2ZPA==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:47 +0100
Subject: [PATCH RFT v6 5/9] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-5-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAZBbxtMxkm5nJrZt3r3WGuB46BeS32RoItol67u
 OvGTisWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGQQAKCRAk1otyXVSH0CD1B/
 49gxwS5b9BoCUU9Ib5yucTVOuhEDooM9ckUWmw898AfP1G2Nk2J6S0JfBhDmGDxWtDoRrmsKL+BW+7
 xxkqLzgDdXb1xmM9yLrI10e0bOQ2SSy531HlsT8D0d2CFKaqoLZqtqyadFcfJAl4qi3nkg5UNNv70H
 J+Zy822syXvd3awup2/HiXlTcvL6YI6d2yxq40QiT9Q8TvnubKZryi4TDE0SYF5rK/5/xFAw1XKoQG
 NGclsCd2NQ1mgoadOYmgbUlm+u0v2Te0u6kNDrEEmvIykb/wBaNmf65CVVEy7KZoVXrYmijkwOZxVs
 R5jWH64jz9VtFMxcyycLzV4pICbFiT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

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


