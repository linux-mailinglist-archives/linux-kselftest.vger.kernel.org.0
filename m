Return-Path: <linux-kselftest+bounces-42005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D304B8D009
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A687AA5F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C232652A6;
	Sat, 20 Sep 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHp1VIKf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7D264A76;
	Sat, 20 Sep 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398302; cv=none; b=d1lv7JD6PLGWhbJelVAg7H7c7IM80VR2mdxHiDXOY4nN/OVsG0JesF44FVtlrIEJESuvZuOaur6u4JbGMmtHqYH45pF4nL89hGUMqvz3atNgopLkJSAFGkFrjwwNc+B35yOSBZWJE19S0OZ/9sinIAkQYoJJxWu5BfTgCFFECQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398302; c=relaxed/simple;
	bh=N/5+0U8xq7Zk0a8gL9aaRKTgfFfm/74fnNbziAndS6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t29IK8rXq/orzEbxmCc6sUTKIEJYSjMmvLu8Fg0NXKm50C1INhfkGobwN+6nDsPH0RE30MwkdZCQkzeMZ6KMDrPY6l729kiY2ps2c45MXOLAqb/jeOBWKOz4apvB/ama6QQ4OZfQh/a3ebojNrJaW49Qf/UYdiRWzrJOGmFb8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHp1VIKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32CFC4CEEB;
	Sat, 20 Sep 2025 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398302;
	bh=N/5+0U8xq7Zk0a8gL9aaRKTgfFfm/74fnNbziAndS6o=;
	h=From:Subject:Date:To:Cc:From;
	b=LHp1VIKfKI+eepDbB7yikTc5ETwfy6Nq9fSlWZIeztY9wsL6No7L1c05IgVWoEXGi
	 MRzD8R3+CfV7g7sSgQo6po6X9KrmPmsiUYrEHSTHZ93Ffp1iMs5WgbFhF1FE450Nlz
	 n+xy7lEx8CQ4Kny5VjJA09R8etiD7AI5O6Iea9YaD792eTrtaf1H4cIVM3xJXI35ov
	 1mf1I1h42JVEDlE56sgWsGYe51yROme8x55JrBiM4bsT2eIPRp0100MK2kB+1lSzUQ
	 YdGXT1lusTN4Z+7RD2XS8IsQ771gLjmb38lJUNyS7MOzYhw0rw2aqScBLfk/lH9yPM
	 8kU5mKEmsWXZQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in
 set_id_regs
Date: Sat, 20 Sep 2025 20:51:58 +0100
Message-Id: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4Fz2gC/x3MTQqEMAxA4atI1gZa6xT1KuIinUYN/pKCCOLdp
 8zy48F7ILEKJ+iKB5QvSXLsGbYs4DvTPjFKzIbKVB/T2haXa0PSzdc5IJGvJZE65NXiaEJsKLj
 ofIA8OJVHuf/zfnjfHyhGpbVsAAAA
X-Change-ID: 20250919-kvm-arm64-id-aa64isar3-el1-f0bd8ab3d36b
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=broonie@kernel.org;
 h=from:subject:message-id; bh=N/5+0U8xq7Zk0a8gL9aaRKTgfFfm/74fnNbziAndS6o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBozwdZ263G51AbBxPCoC9tq9dlYHu5oWbxX0dPZ
 TjHX2QkL3aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM8HWQAKCRAk1otyXVSH
 0HveB/98b1Ix+bm1YAuE6OCxpqygoEcAVSg/qamEdFKMVwqnqIS0gcuTq0pefZ1J148lRUIAYTY
 fMMIRqjcCUmxqFE9JZ9bFX2LFL3tkueH92DSQTP4RrN+BQQ2nUwvJYNKAXVn8dvxPwYbKoCxZs/
 +yYpfR8JYP914CavjErEowg3ozNptxtr24JASzk4KcTgXy8Vpr8U8eUrMhazn+A4umkBOASVRhd
 xLTGQ8s7PzIlHvv7Pm5w05R57lCkqGZIKkoaU2Vg6HM2kQcv2QanNWBEdBHlLFAcpVmmuAU4diP
 VN6pe4IrGLjYojk7DaI8GuVGJkC82LXZ7mUpviGpBwKxmB4P
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The set_id_regs selftest lacks coverag for ID_AA64ISR3_EL1 which has
several features exposed to KVM guests in it.  Add coverage, and while
we're here adjust the test to improve maintainability a bit.  

The test will fail without the recently applied change adding FEAT_LSFE:

   https://lore.kernel.org/r/175829303126.1764550.939188785634158487.b4-ty@kernel.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      KVM: arm64: selftests: Remove a duplicate register listing in set_id_regs
      KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in set_id_regs

 tools/testing/selftests/kvm/arm64/set_id_regs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)
---
base-commit: 5db15c998c390efbe5c82f6cda77cb896a3a6a3e
change-id: 20250919-kvm-arm64-id-aa64isar3-el1-f0bd8ab3d36b

Best regards,
--  
Mark Brown <broonie@kernel.org>


