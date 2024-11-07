Return-Path: <linux-kselftest+bounces-21585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A059BFBE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E15281FBA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1E18C939;
	Thu,  7 Nov 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNyWj4hX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37D18C34B;
	Thu,  7 Nov 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943842; cv=none; b=bYefv7WWQsDLVJ4P4+0nsS+MTujAKIO3BLk5JCzH3qR8xk3b9loacU1h972159uDIgoeB8MpUp99iRIf5y3DE3WfongRDNz2Y4DoxJv9ap/88iEFVPWD/VYANFICsvW1gfAdjrH/gGIU/xqURm7s1oMv0cgxQ4I02f6iyDF4Aok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943842; c=relaxed/simple;
	bh=vmq9jrn8vuSD3VpJFg9vZzUggmSUeit7J7xVMGFrJhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uemY8r3dcXKBzHs704MGnOK5UMJ+8JjwDuWJGFCTUXi78K4/X/j3DV1JB7Pqpc83VtEuECjmg2yKC+xh0csfw24m4P5wzjS0EZ/6LCr4o1mRxlZ2E1gt7gXdyX+RgFOxSQG7Ria7NhfO4/O+DVRL8UwetCkQztZBxLk5jLBYkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNyWj4hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC4BC4CEC6;
	Thu,  7 Nov 2024 01:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943842;
	bh=vmq9jrn8vuSD3VpJFg9vZzUggmSUeit7J7xVMGFrJhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SNyWj4hXoSwtKFE4Q23qDjAbNQV2HYafmT6nfUhsCGj9bJC1XOa/8scYdkfYM6zdj
	 4PtEtBF0uPRREIwL7lgIH8w9Rss3EgVdkR/dT+GNsrpHOdr7q9lIX5JS5qKH6oBzLP
	 g3XgNT2cdhbFuf2e4JcEv7KlSMnuxUPwN5D/E8X9PlX0yjjbweoTHyTjW1nlskRBBd
	 rIvle74315XTZEpG7Q7owSb+06aLjmK5wVYhfct1/A+rsJ4x5SOg8HXa+HAcv6V/KL
	 AZx46JsJ2IDBxapUvJgrlXfLsxqNc4syQGUNE8BrDKf1xnOFZ/ZPwadSVTMrmjfX+3
	 ytP5fOQ0Kn7JA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:25 +0000
Subject: [PATCH v2 6/6] kselftest/arm64: Test signal handler state
 modification in fp-stress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-6-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vmq9jrn8vuSD3VpJFg9vZzUggmSUeit7J7xVMGFrJhg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtTWoXA4eHd6zfw971HD8lilDRJqnyTNW/1R2WW
 DSk3ur+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbUwAKCRAk1otyXVSH0NxLB/
 0QhT6wTv8THELHvP8ObPV5Wls/EzSymSLag6pDrd4ya2LZ50x0Q6/+4Yni77XBfDvIMGDzADqk9d1y
 pPC6kx+WhBONPXVYzCcG+oeucfATYVRlJem/srypiq84viWGUdETPLB3tyJun/CcptYd37d2PNrhcP
 cOakCK+6UKQjnTZYU2ERhh1zRPHoavzLs/5eBz54TqQBgsLVd37WPGHVh/gKjlkLLucyFfpNCATfqT
 /vKAnFfvgVjPegyVyYXKfFpee2BIk+e92YdZTYJHREdL19GhFfMhDfWbMgDI2U0lpW/swoLG0QXSMn
 aKXv8WLvIqS08/7aj4Zn88rMvcrV7N
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently in fp-stress we test signal delivery to the test threads by
sending SIGUSR2 which simply counts how many signals are delivered. The
test programs now also all have a SIGUSR1 handler which for the threads
doing userspace testing additionally modifies the floating point register
state in the signal handler, verifying that when we return the saved
register state is restored from the signal context as expected. Switch over
to triggering that to validate that we are restoring as expected.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..3d477249dee0632b662b48582433d39323d18e18 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -221,7 +221,7 @@ static void child_output(struct child_data *child, uint32_t events,
 static void child_tickle(struct child_data *child)
 {
 	if (child->output_seen && !child->exited)
-		kill(child->pid, SIGUSR2);
+		kill(child->pid, SIGUSR1);
 }
 
 static void child_stop(struct child_data *child)

-- 
2.39.2


