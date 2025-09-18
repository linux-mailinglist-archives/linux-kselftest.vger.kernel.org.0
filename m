Return-Path: <linux-kselftest+bounces-41894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57AB86BC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADACF3BCF9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCF2E3391;
	Thu, 18 Sep 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW3c6aFV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD412E2EF3;
	Thu, 18 Sep 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224669; cv=none; b=NxJcGjMG45mAwWGJv1HeTOxAB9JgNcYkPGFsm5FdmQu6lIOcFXhjyJUMDh+69oZvK9vnul6TA4lmwLItq0E69HMXfGg/AH7MonmaBHaV3mHRaCGZoMmV5bc76ttbbP5bdRmTclZOLRdZE3ldC3xvviBVtQf4Ii+ssimCrVdX6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224669; c=relaxed/simple;
	bh=/fyRtjX7Acq7Ib/RG2oDrAdMcjvCIkWa8I5Em83Gg64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l22oLb+luEjUYKHLD0PHPkW1sT3Q97wOfvuz0QFvWbdZwWh3uCpTka34IxV8ye2ild64uTuqkvBJgo9zbM/xTiIS2EMB2lwtXF1ZNMzmiqxJO8J6UtCHHvgqfau4ws3x3gzjMInaua3OSDODOYmTkdSOZ2+CRBM1n9qKnxAesJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW3c6aFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD07C4CEE7;
	Thu, 18 Sep 2025 19:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224668;
	bh=/fyRtjX7Acq7Ib/RG2oDrAdMcjvCIkWa8I5Em83Gg64=;
	h=From:Subject:Date:To:Cc:From;
	b=PW3c6aFVxiQWITh6uQ/YoOHRKxxI3L9bEFBR6TwvzK3VAt9z2AzpTVgc/j+W6yO6W
	 nkn16qJAv7CO+ycRjZIgiq+cT46fXqA5py/CN5FasGMgCtDWP9Ps4sN+6SGurZtyJN
	 xNF3Y85SGQUlejYbaLp40z1mSwsmA+knuaFXPUdyrEWgfkJ5LhhC88g3FDGPObVPvr
	 8E3GsSL1dOri2YE0qVPyK4iP+0LE/h7Au+Jx09CpfN2jouhrIOqyt+YanXECchgfrZ
	 +p1NDzYH5oNYrJV48B1umx3nLZudUkiSvgwiP/atuE79dnBYbRmpjgH1tPaEwk1p44
	 6uK4LkE1X7s7Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/2] arm64: Support FEAT_LSFE (Large System Float
 Extension)
Date: Thu, 18 Sep 2025 20:42:05 +0100
Message-Id: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5gzGgC/2XM3wqCMByG4VuRHbfYP+fWUfcRHej2m45MY4tRi
 PfeFMKkw++D551QhOAholMxoQDJRz8OeYhDgUxXDy1gb/NGjLCSSFbiOtylwH10gImixDitams
 YyuARwPnXGrtc8+58fI7hvbYTXd5vpvrNJIoJloqX1IjGVYKebxAG6I9jaNHSSWyzFeE7y7IFA
 1YRrbVpxJ/lm1VU7SzPtnbSCSslNFzv7DzPH9T48Y0dAQAA
X-Change-ID: 20250625-arm64-lsfe-0810cf98adc2
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/fyRtjX7Acq7Ib/RG2oDrAdMcjvCIkWa8I5Em83Gg64=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBozGEW5FyWseaqc8/F+wIiqySykyyfiEMwETJHD
 3x47bVLit6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMxhFgAKCRAk1otyXVSH
 0MnLB/sEOZMOHVacNMWbkkwuSaxy58fOnDcDG3q5SSd4PYa/uO6lM9ZG4SYsH1bv7w0L350Oml5
 /05e0opT3uGxlCmhQL2AcdMQF8bEw45kMI6pe7XDKC0oNu5sL0D1PSUP9psLPM82dsK5FszB87U
 gkisjR3K77ju9UxZbtP2bQJbRBg0FW1PeIv6K1gD9dwfEkEoVyqnKblRP6eQ4jyDHFwdqmHSbJF
 vMQ5uXgp+3m0gAibiPJuhNUt4umwF2ktg6gC/4y0SXM/0jEMC/rSycbv4smm0hAXYqvWGc6l2TR
 8/IsnwQrH8X7xO1FsCqOpRQlONJtdgwaTwvbqLTp63iIfltT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
memory operations with floating point values.  We have no immediate use
for it in kernel, provide a hwcap so userspace can discover it and allow
the ID register field to be exposed to KVM guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Rebase onto arm64/for-next/cpufeature, note that both patches have
  build dependencies on this.
- Drop unneeded cc clobber in hwcap.
- Use STRFADD as the instruction probed in hwcap.
- Link to v3: https://lore.kernel.org/r/20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org

Changes in v3:
- Rebase onto v6.17-rc1.
- Link to v2: https://lore.kernel.org/r/20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org

Changes in v2:
- Fix result of vi dropping in hwcap test.
- Link to v1: https://lore.kernel.org/r/20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org

---
Mark Brown (2):
      KVM: arm64: Expose FEAT_LSFE to guests
      kselftest/arm64: Add lsfe to the hwcaps test

 arch/arm64/kvm/sys_regs.c                 |  4 +++-
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 220928e52cb03d223b3acad3888baf0687486d21
change-id: 20250625-arm64-lsfe-0810cf98adc2

Best regards,
--  
Mark Brown <broonie@kernel.org>


