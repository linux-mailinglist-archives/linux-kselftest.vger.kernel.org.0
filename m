Return-Path: <linux-kselftest+bounces-39248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF6B2B189
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFC17AA6E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAA273D81;
	Mon, 18 Aug 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfDDwrE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73BE555;
	Mon, 18 Aug 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545183; cv=none; b=SjGPiulzhakX/PkdezRF/FIsnn58PSqFRa2SoVrXHvsr0evBxXhOEaM/Gu2TnBAkT0V4SSD0Obz5iZxUrVGXHe8FU1P1180vXbY/GJXm0SdVByD6qLNVmqw3SjTmuiU+aHiYOQUM9iMSxHhO/PbQXQ4qIwY8pohHqhUUymuqUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545183; c=relaxed/simple;
	bh=+y/vOOo8jAZA17Jtz8gRMU0zs0a5jt47Bouz8MVv3Wg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tu9Guv4YxTkS7O2py7ILd9YV1bsg0wTGKFUQaSly+9c25prviC8B0zL9yMl81MyMc6jxUIMaDWFEToTyXhO48A8NytWm47Nluo8xHtosPcxs7vZ7tS6CpgOtrnbWLrQV6r7mu5c+fYWu1yUPwh54rVZRXs+Fx778qhbrEdHvapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfDDwrE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2F9C4CEEB;
	Mon, 18 Aug 2025 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545183;
	bh=+y/vOOo8jAZA17Jtz8gRMU0zs0a5jt47Bouz8MVv3Wg=;
	h=From:Subject:Date:To:Cc:From;
	b=qfDDwrE+BVp5zL1+EDWcdMm7DmF/RDfc139D2y/CQIlaGUYVodu81jkwikSMnQAp9
	 I6RIQpL6z+vUbr3V7f/oao7P8ecH/sO6LvAa8gv51EltIpuqfeFBLOPDwjrF1O/XCq
	 ARoyCzVY3yd1NvKMFVR6KGeaRKuc5mP30SqfNLuf/Psh7+Mxtli77t09TWya4cAkaf
	 7eaPmhtMhH5/niq6dqMUg+SdujDRCt50ZzIhPsb4uyR4K+LfRgdZC+A6QpQroNGfKu
	 3v/o6HbGyBOre8ZFJYdaycQMX+ZajkeTaG4trVyK3qk3A6yClCydTDmX7dlovz2KPi
	 P8EBQe0D/+0Ww==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] arm64: Support FEAT_LSFE (Large System Float
 Extension)
Date: Mon, 18 Aug 2025 20:21:17 +0100
Message-Id: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC59o2gC/1XMQQ6CMBCF4auQrq2ZlgKtK+9hXECZQiOCmZpGQ
 7i7hcQoy/eS/5tZQPIY2CmbGWH0wU9jGvkhY7avxw65b9NmEmQBpSx4TfdS8SE45KAFWGd03Vr
 JUvAgdP61YZdr2r0Pz4nemx3F+n6Z6p+JggMvdV4IqxpXKXG+IY04HCfq2OpE+WsryHetTC1ab
 DUYY2yjdu2yLB+mc/9x4QAAAA==
X-Change-ID: 20250625-arm64-lsfe-0810cf98adc2
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+y/vOOo8jAZA17Jtz8gRMU0zs0a5jt47Bouz8MVv3Wg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo35Z9ywOmVIYyAGuED3un6+Vp7m7E8UOzL3eO
 oaGa9ejrgyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN+WQAKCRAk1otyXVSH
 0Pn0B/9Lgel83JGwfCO6weWZrwLTSxZ2NGgB1wsezpQ0o8+jWonTcI42s6sUDwa5kbmTm29twd3
 au1tIWNztBPPSfYtmfR013a77/8OggTudCW3WkyBYW60gOe+W7oO9VZ7ncmJjl0KdLpga9/CJo2
 QrcJs0AQeSYSfDSX2aUFarsYAeJf0BOpcZQQqFmRcBJeEYfOXJuoPISSlTl2QToQGQbEIsSsuHZ
 czwK5wGZhCDuyu3Rz5InsNXmq1P2Yw0DbkfMp0rYdaX6NClG3rFT6zQD59hMfeqRpSHeCawPxMD
 Tpj8xMNFP4Z9IbXUBYDpqVYc5Y1Csw1L4AH82yeJPogRglaZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
memory operations with floating point values.  We have no immediate use
for it in kernel, provide a hwcap so userspace can discover it and allow
the ID register field to be exposed to KVM guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.17-rc1.
- Link to v2: https://lore.kernel.org/r/20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org

Changes in v2:
- Fix result of vi dropping in hwcap test.
- Link to v1: https://lore.kernel.org/r/20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org

---
Mark Brown (3):
      arm64/hwcap: Add hwcap for FEAT_LSFE
      KVM: arm64: Expose FEAT_LSFE to guests
      kselftest/arm64: Add lsfe to the hwcaps test

 Documentation/arch/arm64/elf_hwcaps.rst   |  4 ++++
 arch/arm64/include/asm/hwcap.h            |  1 +
 arch/arm64/include/uapi/asm/hwcap.h       |  1 +
 arch/arm64/kernel/cpufeature.c            |  2 ++
 arch/arm64/kernel/cpuinfo.c               |  1 +
 arch/arm64/kvm/sys_regs.c                 |  4 +++-
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 7 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250625-arm64-lsfe-0810cf98adc2

Best regards,
--  
Mark Brown <broonie@kernel.org>


