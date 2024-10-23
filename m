Return-Path: <linux-kselftest+bounces-20507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95B9AD5A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2771C20ACE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285601FE101;
	Wed, 23 Oct 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMAbHMVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F561E2611;
	Wed, 23 Oct 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715981; cv=none; b=GI1heTz5J//beuoDr+Kidhj/9N4jslxZSNONRFr6XoZHP6MvBtF9L/gnN87kzaTr55l7VBSL7NNUBlVY2Itzk85/w3ko82Om29e3g502Gz9MAStOf8Jt+UoQNW/MT8eFDMlRsykdh+D8mR/T3Shvio1xHGKzFdSZC+r9qpvAMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715981; c=relaxed/simple;
	bh=KVTyCSHO3IKy45k1g82pm2rTQMvLTo5VSsiU946MF+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ebwozCBqnAEAhg+gg+nvmjEzHdbM53CtVXFQQUuodCYeBUb50rXrPHuRoPovwncghdGs4NpcxRY+Zoepie1sLqu9GuYT2/tNCvWjXvlb8wPb5iKsVrdbsk4NyGF3GnD9PwbB/J4y0FqDM0ygSkYqo3cfkmr6ps77hOvAv0ntsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMAbHMVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEA6C4CEE5;
	Wed, 23 Oct 2024 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715980;
	bh=KVTyCSHO3IKy45k1g82pm2rTQMvLTo5VSsiU946MF+Q=;
	h=From:Subject:Date:To:Cc:From;
	b=EMAbHMVYbG9E/UFnp6Gh7YN4EgkfqD4+HH1FzQcZ4tUZdDoge9aKec/xoUEuwPyUB
	 AYWX4UqKtGwdbAdXIdk8Kg9sRDqD3fQ2zDn8FdaXNk1X7SZczzkSzVhY+SHmI1SEXt
	 J1gIfbc5KUJ//YeL9YA6Wa3XvcKt/CZJo1/rY0n74FqJggODv+xmU818/s0O6fTVtC
	 4NZ9zG8NrASnXkPLCGObHArigqg5fPkexmlFH0ewlFS4Rt9RMlkQqvTcFXCKeSHR+p
	 WFOE6aHXN4GTZrdciurL8RZJ50TRoNtwqpkMIL6rd3BPe8pii4EjX4m6WejjamyVx7
	 7IbKzN8+QA90w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] kselftest/arm64: Test floating point signal context
 restore in fp-stress
Date: Wed, 23 Oct 2024 21:38:28 +0100
Message-Id: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMReGWcC/x3MPQqAMAxA4atIZgNtrYJeRRyKpprBH5IiQvHuF
 sdveC+DkjApDFUGoZuVz6PA1hXMWzhWQl6KwRnnrXENBtk7j/FCTUKqyCKcQjoFW2/bSL0LC0U
 o/SUU+fnf4/S+HxgEPM1rAAAA
X-Change-ID: 20241023-arm64-fp-stress-irritator-5415fe92adef
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KVTyCSHO3IKy45k1g82pm2rTQMvLTo5VSsiU946MF+Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8F2INtwxgXIoiUoQrRFDtnMbJkUFgtlgl/WYNn
 rDKLzfeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfBQAKCRAk1otyXVSH0BNIB/
 4ih+CnZpppBhkqbwlSYfQYsYtU61752e15oGC34vX3GFkcyMQngwu4YRNYbl4dfb5IQ5L/mMkzWlg8
 8aB5EuqMca3/yUHOBfLb6+ZodJuu4si2/v3hFz9vF4ixkcZGablC28XwRxF4hE50mOHniDct3Y3gvG
 BByBjJgl3tgydbkA2MY+rAFIFKttLAP88Urj1FgqknhLoyqMu/xCXYzaA3ERE6G66IKowL1gNoFks7
 /NdfQXfchwmZxyqA6ycREy2TUvINBqUhesj7rrrEacTHCQ1UQqBN7CmUMKglNPbkJu+f2VaSU/Q5ta
 CIhImwroMaSg5wI5B9JGVCuRjWpRKG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we test signal delivery to the programs run by fp-stress but
our signal handlers simply count the number of signals seen and don't do
anything with the floating point state.  The original fpsimd-test and
sve-test programs had signal handlers called irritators which modify the
live register state, verifying that we restore the signal context on
return, but a combination of misleading comments and code resulted in
them never being used and the equivalent handlers in the other tests
being stubbed or omitted.

Clarify the code, implement effective irritator handlers for the test
programs that can have them and then switch the signals generated by the
fp-stress program over to use the irritators, ensuring that we validate
that we restore the saved signal context properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (6):
      kselftest/arm64: Correct misleading comments on fp-stress irritators
      kselftest/arm64: Remove unused ADRs from irritator handlers
      kselftest/arm64: Corrupt P15 in the irritator when testing SSVE
      kselftest/arm64: Implement irritators for ZA and ZT
      kselftest/arm64: Provide a SIGUSR1 handler in the kernel mode FP stress test
      kselftest/arm64: Test signal handler state modification in fp-stress

 tools/testing/selftests/arm64/fp/fp-stress.c   |  2 +-
 tools/testing/selftests/arm64/fp/fpsimd-test.S |  4 +---
 tools/testing/selftests/arm64/fp/kernel-test.c |  4 ++++
 tools/testing/selftests/arm64/fp/sve-test.S    |  6 ++----
 tools/testing/selftests/arm64/fp/za-test.S     | 13 ++++---------
 tools/testing/selftests/arm64/fp/zt-test.S     | 13 ++++---------
 6 files changed, 16 insertions(+), 26 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241023-arm64-fp-stress-irritator-5415fe92adef

Best regards,
-- 
Mark Brown <broonie@kernel.org>


