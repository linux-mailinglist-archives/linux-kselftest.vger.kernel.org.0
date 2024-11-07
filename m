Return-Path: <linux-kselftest+bounces-21584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A958E9BFBDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF90281FBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80E18787F;
	Thu,  7 Nov 2024 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD80AIlz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD9186E58;
	Thu,  7 Nov 2024 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943840; cv=none; b=Xhxvf7DUntVufpPjIqalG4sxwf6rhSzuG0UEJ/ReX3Kf+YCPQSCySZBcF1+i+OXL1dDPUh9oyqD51pkXvipc6jjnHxQYHZAHu9kJ3KpHr2X6X05NSPzbBwoAfVBpN1qCpQlAqR9DW/sH7+iMk7r90PxIa2NlVRQMO0cqFS3MUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943840; c=relaxed/simple;
	bh=leVU7E1xUyU67WCn5RdQJAXMEOCia4xbUFczyjMgbo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIhwES1hF6+lfNftwaE7Ds5GMwgtCeu1jt7C4xxeT39VuzZ0CVhoAa1m7Oc6ekbzzho2Xa0nukGrKj/JriEIoCwUh8MwNe1ywPHBn0hHCFbkTZElYLCXQj7EGYpC4JVTaSpFDI8dHppmZLz3ochD5jYAI3wKSsPH1kesx9fYkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD80AIlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BB7C4CECC;
	Thu,  7 Nov 2024 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943840;
	bh=leVU7E1xUyU67WCn5RdQJAXMEOCia4xbUFczyjMgbo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jD80AIlzSqU2r/cv9e/ie7Owo+WfjDElCsL6B8UgadlAaRiP+5loHocFvNnVoXa3b
	 oG8RmynJUtK37v71OIhLcZ69krDJBhOFA0AeuVVW27cAGQZionXdR24/7k0cRDqCk7
	 iUgTosPk1f5VAvyd9OHB6ztAXzsPufCXXbu9EQKqM8rMrotlyka3xcBKE/zQe7Dm+9
	 Am0HwME3N8tHhzwS2JxuGME7wRWy4Bdv4SY/M689QhbIdy/rP0KVDWZHhYAwaUSc+O
	 qGu4/mSb5RC+oydJLjZTYmjZ4HhgbkKe72gq7teGXdHUNvHWNniMIDf6rr69kggRVh
	 nNhCsTdzDcVqg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:24 +0000
Subject: [PATCH v2 5/6] kselftest/arm64: Provide a SIGUSR1 handler in the
 kernel mode FP stress test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-5-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=broonie@kernel.org;
 h=from:subject:message-id; bh=leVU7E1xUyU67WCn5RdQJAXMEOCia4xbUFczyjMgbo0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtS2FRnGevJn8KdIwsF19SK/BkdiQ/yz1S77N3e
 u1IvERGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbUgAKCRAk1otyXVSH0DadB/
 41K/s/wFQumB72ze1INxlRbvEQrpNju8Mfu7P81epd5uw2x02Ey2Bg9GCyHSCnA6T+2mHk4N5NK+FS
 vPG6XeN9PkdLjANLz/0gx91TrUw/Sf4Cbun9GSYKk7tmLBqHMJrEEAWoeJtfWXVi0aj/UZ78bTikSw
 nA90uLjIeY8Gnr9Sdo0xss5XTV1RjfGNScF7EPgMreb6nGCHmhfq9i1rqauJwqT2oCTJUsGYMxcLi9
 XDVrtAY14aXzBud0yt2s442KvlKVj/EcHfZdnM5cR8ZtRmPbYH3Aj3qb6JQOiIrczBxYLAGuT2TRs/
 EPkj0uwDq0d7TChyA7GwaXUmott0Rf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The other stress test programs provide a SIGUSR1 handler which modifies the
live register state in order to validate that signal context is being
restored during signal return. While we can't usefully do this when testing
kernel mode FP usage provide a handler for SIGUSR1 which just counts the
number of signals like we do for SIGUSR2, allowing fp-stress to treat all
the test programs uniformly.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/kernel-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
index e8da3b4cbd23202c6504ffd8043f8ef351d739f6..859345379044fc287458644309d66cf5f3d8bdf5 100644
--- a/tools/testing/selftests/arm64/fp/kernel-test.c
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -267,6 +267,10 @@ int main(void)
 		       strerror(errno), errno);
 
 	sa.sa_sigaction = handle_kick_signal;
+	ret = sigaction(SIGUSR1, &sa, NULL);
+	if (ret < 0)
+		printf("Failed to install SIGUSR1 handler: %s (%d)\n",
+		       strerror(errno), errno);
 	ret = sigaction(SIGUSR2, &sa, NULL);
 	if (ret < 0)
 		printf("Failed to install SIGUSR2 handler: %s (%d)\n",

-- 
2.39.2


