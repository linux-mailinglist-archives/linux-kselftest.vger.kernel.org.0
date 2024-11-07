Return-Path: <linux-kselftest+bounces-21574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11C9BFBBB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EE6B22319
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945B748F;
	Thu,  7 Nov 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exZfFAGQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF71854;
	Thu,  7 Nov 2024 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943538; cv=none; b=KcwpY7qYBb5U352UDy0YljsCbVz8PMofPuqWsUdSp0ReuoSgFwCC/lScGlO7CLwV6dPArykRRBuHnaAtQL6d2BZ7ygTl1aHRmXICTl+5oJGK5/vRcM26v7xujBnjCv68m8uZ6Zhb+yxYcvmQDSsxApGvxEJcwAVFVrBi1pn4+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943538; c=relaxed/simple;
	bh=Ifv5eEqDTr2IOlKTWcHRHgBuh8QWxP57/E+ccYr3L0Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VwE4nNEIq4dGO6z4Sy3LVX9ti9NYiP6AacTM74nzmZN7+sx/a251UIA9HS+sad6yaQvncTySkzkdV3V34r/NPk19m3OAzPq/XszRC/QjUDyGRolR6vHLcSLGYhCucpQWT9cFga0G3enBuNDGkt6h41+gZfzz8DXXvPvP8Eoscwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exZfFAGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55FC4CEC6;
	Thu,  7 Nov 2024 01:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943537;
	bh=Ifv5eEqDTr2IOlKTWcHRHgBuh8QWxP57/E+ccYr3L0Y=;
	h=From:Subject:Date:To:Cc:From;
	b=exZfFAGQhJuBxMeDca1D2ULoSH6/Cau6DPJjdnNWyJodAoP/de3xGH+SBIsRZKFJ9
	 NRw6el1FxQJXcuJB1syFgQLqp6vyla5URvy2l3hB+gtz6YIFxep6i3e5o5O1wDNipp
	 ZbrxbEh8cmkSPKoKhCIG2kCY6qqMV7vMHdkGB0mK9jZ97bwCIDGSBGhhGQftYZ54zp
	 gJ8T6K3gMGdSo8xNSq1k83TEPf2E43SpvMpbeoPiK9q5LjuBC1t/BqM+UTZVmlHuo3
	 y3DMXwv1E1ORjlJTnEe+HlzSfBy3zyUoB06qNRJjRx5IAW7HqNgLY2hF1XmbtobS8F
	 jTQ1rLzZLWOBg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] kselftest/arm64: fp-ptrace enhancements
Date: Thu, 07 Nov 2024 01:38:03 +0000
Message-Id: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwZLGcC/x2MuwqAMAwAf0UyG2h9Df6KOIQ20QxqSUUE8d8tb
 nfD3QOZTTnDWD1gfGnWYy/i6wrCSvvCqLE4NK7pvHc9km1Dh5IwnUaBC22GIm7wQiG2kaCkyVj
 0/rfT/L4fqOoOW2YAAAA=
X-Change-ID: 20241105-arm64-fp-ptrace-fpmr-ff061facd3da
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ifv5eEqDTr2IOlKTWcHRHgBuh8QWxP57/E+ccYr3L0Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBorcyPXQv9O6VGBSffTN5lbz52kyZ7iddgyCHsm
 ZmsNreGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywaKwAKCRAk1otyXVSH0LNmB/
 9r1nEAa2KYrg61SyLhV+PEyYdh9oZixDxbqjxaong7sj7tZorvInnQjIe8IW27S33Goi6twBiNaA2D
 uu+u7l8tUy3fkQRx0xSe7VC4GR10DmHj/hZ6LXjOGaimnKN58rvxPy4gy0lVomc1/cpydriPU89UoF
 DHkRisqnCR0hb0Sn1BG4+shxc3KO1o9zyjo0aCGTHzpqat1gMkG+6fw+GTOEkZUBQIwCxo2kFekqtg
 Zda+FiPOkRQstaJu/bmFxJJSroi/qK7QUKxjlOaxdSZfySO0OP5nJxdspxWdRjKEHBJIqNcH+ijIee
 v8C4FeFdNoFuAPPfuWxAJLe9jVJu3m
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series contains a bit of a grab bag of improvements to the floating
point tests, mainly fp-ptrace.  Globally over all the tests we start
using defines from the generated sysregs (following the example of the
KVM selftests) for SVCR, stop being quite so wasteful with registers
when calling into the assembler code then expand the coverage of both ZA
writes and FPMR (which was not there since fp-ptrace and the 2023 dpISA
extensions were on the list at the same time).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      kselftets/arm64: Use flag bits for features in fp-ptrace assembler code
      kselftest/arm64: Use a define for SVCR
      kselftest/arm64: Expand the set of ZA writes fp-ptrace does
      kselftest/arm64: Add FPMR coverage to fp-ptrace

 tools/testing/selftests/arm64/fp/Makefile        |  20 ++-
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S |  52 +++++---
 tools/testing/selftests/arm64/fp/fp-ptrace.c     | 155 +++++++++++++++++++++--
 tools/testing/selftests/arm64/fp/fp-ptrace.h     |  16 ++-
 tools/testing/selftests/arm64/fp/sve-test.S      |   5 +-
 tools/testing/selftests/arm64/fp/za-fork-asm.S   |   3 +-
 tools/testing/selftests/arm64/fp/za-test.S       |   6 +-
 tools/testing/selftests/arm64/fp/zt-test.S       |   5 +-
 8 files changed, 213 insertions(+), 49 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241105-arm64-fp-ptrace-fpmr-ff061facd3da

Best regards,
-- 
Mark Brown <broonie@kernel.org>


