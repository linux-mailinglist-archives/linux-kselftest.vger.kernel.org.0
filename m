Return-Path: <linux-kselftest+bounces-45652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B3C5E2D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13E6B3C1B38
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A75328B66;
	Fri, 14 Nov 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYzPddv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEC328260;
	Fri, 14 Nov 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134730; cv=none; b=soqeDawXNBPWByFsaretgstcjQacHYo/1liT3zasAkOaVEqaUPXeAu0RHuBby/07cqAxhHtNnFgy/wPXZWBabfLtKhAkUaMTDgpNGu6BD2+1n3etaPK469IOlJmohSiGhhzx7UMjP94i7NTyraKqBZVA3z5nh5f6YjWSHm26Pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134730; c=relaxed/simple;
	bh=J45c/s19KG5BRrKbkkO8elgq2nUpoF6T9W4M2wJwxIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d3eJd3wUQSunKxw2g9wFM2kcVNSUrDjYpVuEfF0qDc7tIb/+QqHSbPRcdBCgScr4NEZVtoZqiwpFnaj4zI2UfJvBUjOzvXoB887OPQgs5WEiG1cfQWSetjKcH5AyW5uHQSH7H9TYwsUo4G+kZEFThiE6x48qxtaMtQFE4AxXqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYzPddv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D78C113D0;
	Fri, 14 Nov 2025 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134729;
	bh=J45c/s19KG5BRrKbkkO8elgq2nUpoF6T9W4M2wJwxIg=;
	h=From:Subject:Date:To:Cc:From;
	b=sYzPddv/oyC4fyRjzIbV4LUbG7tuVcGoEtaqEdOSgNCYfiIB7NXyfAh3oUOmGuJSK
	 Wbth6vCLlEyQRBghE7FCZ6JyIfmPLguDbCVlrrIjOY3vu3h0FB5joa/9NSQi0pa+V0
	 vd9WLyxem65B+bq14jTosrdWkjFD9YepT/PjMmUEj8fGl8Iai4ZgMzd0me+p85cpdW
	 Kc5Mx5u2d+2CxWAj6jQDn8+1iSmFrnFkUr6q19+p9xubqlLiWYTIt1gGFU6y+jdFZZ
	 GN9roLcEP9rVCYqa08oPnTSrLHJL8sJsF7gtq2EgrS52C5VtTOjkP8KWn5xgUNAxHV
	 D5WYf4EVTm10w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] KVM: selftests: arm64: Improve diagnostics from
 set_id_regs
Date: Fri, 14 Nov 2025 15:35:33 +0000
Message-Id: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVMF2kC/4WNyw6CMBBFf4XM2jFtxfJY+R+GRSkDNAg1U9JoC
 P9uJe5dnnOTczcIxI4C1NkGTNEF55cE6pSBHc0yELouMSihrlKoEqc4o+FZ5xhoTSMyDQGNYTs
 mR21bFJWuciEtpMaTqXevo39vEo8urJ7fx12UX/srX8SfcpQosNI9iU61sijpNhEv9Dh7HqDZ9
 /0Dwl+2WMsAAAA=
X-Change-ID: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=broonie@kernel.org;
 h=from:subject:message-id; bh=J45c/s19KG5BRrKbkkO8elgq2nUpoF6T9W4M2wJwxIg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpF00CvVNN1ixu1R00fyRsa8mf54xwdC9j31NOL
 DOsaLUnhwSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaRdNAgAKCRAk1otyXVSH
 0A0KB/sGtgmfnFGBZsCQ8KRHczYKmHn8xbMTbhdwyps3Tux2tF9yJ4rubWo0HO1JMd3yY0qqqvp
 JJMahVCsnI45Sp2Iw9ix9Ya5INP0R8lQ4qMSbLb1YN29PX2cieTkr3ZZkvRY5+wNk8/tjueNWri
 H/Vsx3ma6ZXdaJ6ZaXt3sRwrIZ1SdVapRo4Ngj97XuLyF/MaOPMB9qyky34K244ynsCVog4qBWP
 0CcwUKa8YGdbCQWq4GOPPlJ0n7TM2P7aXZ+OPrVHspSalZcEGZRNNFlz/b7Uyh6XjLaeHovK63B
 NNPoC69lV0c6S1Hrq83EDSxwDncgDu083/9aeXaZLXcMlAfW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While debugging issues related to aarch64 only systems I ran into
speedbumps due to the lack of detail in the results reported when the
guest register read and reset value preservation tests were run, they
generated an immediately fatal assert without indicating which register
was being tested. Update these tests to report a result per register,
making it much easier to see what the problem being reported is.

A similar, though less severe, issue exists with the validation of the
individual bitfields in registers due to the use of immediately fatal
asserts. Update those asserts to be standard kselftest reports.

Finally we have a fix for spurious errors on some NV systems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add a fix for spurious failures with 64 bit only guests.
- Link to v1: https://patch.msgid.link/20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org

---
Mark Brown (4):
      KVM: selftests: arm64: Report set_id_reg reads of test registers as tests
      KVM: selftests: arm64: Report register reset tests individually
      KVM: selftests: arm64: Make set_id_regs bitfield validatity checks non-fatal
      KVM: selftests: arm64: Skip all 32 bit IDs when set_id_regs is aarch64 only

 tools/testing/selftests/kvm/arm64/set_id_regs.c | 150 ++++++++++++++++++------
 1 file changed, 111 insertions(+), 39 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251028-kvm-arm64-set-id-regs-aarch64-ebb77969401c

Best regards,
--  
Mark Brown <broonie@kernel.org>


