Return-Path: <linux-kselftest+bounces-39233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41387B2AF07
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA451BA674C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247732C313;
	Mon, 18 Aug 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Zht8J9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039032C304;
	Mon, 18 Aug 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536852; cv=none; b=hGSMMhe/gqxlAyimgvf+08QcE1QOLz3LJSHfMm0LLk3mS/sjyEa0PW9ElbGqs8edAfrI5akTaISmu+Vu41baiplZMroT2KhoSI3sPZCHwO7kOr95QBgTv415hx22ROr23zXgpDU+gEFDCG6zzWHXET3sOSDDKcOw7KxYHHcYsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536852; c=relaxed/simple;
	bh=KhHns3MO0aHvf+3Asuji1SH4gKY6cGswxL3bjgtAUSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O++Ynm7RK2bWNIbpbJMmiNpErPUwxZM3iL18IurF6YTb28484vjqOwiwCZ1V/c6DmTwHQCozQfVsWcVnxkX+CiX6nQabYenNThAP3BBCw+my3YAo/HvbU4xv8dp85hr6WY1R/kKr0nqrFOHTGxSynzk85Rrj8NmDDBjGuHvSBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Zht8J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB006C4CEEB;
	Mon, 18 Aug 2025 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536852;
	bh=KhHns3MO0aHvf+3Asuji1SH4gKY6cGswxL3bjgtAUSI=;
	h=From:Date:Subject:To:Cc:From;
	b=J4Zht8J9cq28qvrFdNfKEhj6+9ZF3/cDfE7ThTl02xFlct9SSpXoQdeE+ZpCY+KM0
	 EYTnSOOkZ/JwKjy5XlRnbhw+Y/6XpZcrlzAm1+IIOp1fzbb1LAdT7qBr1h+ViURf1d
	 KdZgz3aD2/S5BBlkUT//+2y307Hk5JjZFIJbzRaxWAV4eBFHuZsllpGzIzuQLXZQRT
	 FAYbTz6kW81T5dWMQZyfCYCVrS10hZDko46lU1fHnWNouAKx4Im9wJNTtRxbfGeJmZ
	 lJJlSM8Sa30BxbDZuKP+A7L7D6AaGCqCyiIs9lPGIAoed8mGkZhY0mmF3J+p+A4uc0
	 q0vt3kfqcYVBg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 17:41:00 +0100
Subject: [PATCH] KVM: arm64: selftests: Sync ID_AA64MMFR3_EL1 in
 set_id_regs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-kvm-arm64-selftests-mmfr3-idreg-v1-1-2f85114d0163@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJtXo2gC/x2NywqDMBAAf0X27IKJ8UF/RTykZmOXNrbsihQk/
 27wODDMnKAkTAqP6gShg5W/WwFTV7C8/LYScigMtrFdM5oO30dCL6l3qPSJO+mumFKUtohCKw5
 PH8cwWOdaA6XyE4r8vw/TnPMFI+NEvXEAAAA=
X-Change-ID: 20250815-kvm-arm64-selftests-mmfr3-idreg-7baf8d724431
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KhHns3MO0aHvf+3Asuji1SH4gKY6cGswxL3bjgtAUSI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo13QE86Q+y16bpfWE+6x/9uKmyweiprMs5xFd
 i2iompCKpmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKNd0AAKCRAk1otyXVSH
 0BLnB/47gyQvwyahO0s7MsRSP2NgxKt/teBkTEhY6fNSSnTUGClsLhO1v7AwheWNVNuF7pMb9N3
 sSFAFAcJwQaJmtRlJQca/uTn5FLMGV5Fp3EznJ1nOatvjL17YpmJixZyGZOppo5cNL6+TBLCiUp
 CTVDIgAWbUAkzhA8NVdmyRQgcoQA/cW7vq2y5/2tLPCkcr9vZqkjeiDA45szgLRWm0KtfEXRcRe
 FU63m2c+k07H7iPqyDtf0m9qDWgrgvNHD1yaqpyze2ryyrVywr7tMsxSJSryueQ3TMxHXU0ymMk
 MVb302LVklf1wglLZJWS4Q8yT52k9g+yv/ZiLqqVnk2lf6+H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we added coverage for ID_AA64MMFR3_EL1 we didn't add it to the list
of registers we read in the guest, do so.

Fixes: 0b593ef12afc ("KVM: arm64: selftests: Catch up set_id_regs with the kernel")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index d3bf9204409c..97d5ab9ef0fe 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -243,6 +243,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64MMFR3_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_CTR_EL0);
 	GUEST_REG_SYNC(SYS_MIDR_EL1);

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250815-kvm-arm64-selftests-mmfr3-idreg-7baf8d724431

Best regards,
--  
Mark Brown <broonie@kernel.org>


