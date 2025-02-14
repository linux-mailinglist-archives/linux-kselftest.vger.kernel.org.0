Return-Path: <linux-kselftest+bounces-26610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D170A35411
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D2416C633
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C61632C8;
	Fri, 14 Feb 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7UIjh0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFA13C67E;
	Fri, 14 Feb 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498483; cv=none; b=d51M4cDT8Os9OWmsZzT7QkW5KmAqEgO9HsvKObVxb0PfEWOUdWK0ovu8ZiJAiqZPgKIRAi3oNDI0PvR4GtWuR5pqyRng0X8seLvC553vhZU3I3NV/QhLAIz0hQY2K6oqSJa7d0oWRKwJcoxQE7E2O2lctucLHjOuTdT5etVhrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498483; c=relaxed/simple;
	bh=JnEqIyH78l9xsw6E0vWUYiTwf0S6e7Oe4YtvEVb5AnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdGo6QqcH6G8NSUqFzC5VyhTGlci25TeESKRrg2YWiSGplcnVwB/XwjiHRNz0s3p1Ucr54j9AvJzAqIP7MERSU4zUWn20zTD4zue0sWnVVCY7kaaq2h88439JCUM54Uo96ZrTWC/avnXI/W+nGy/EHzkad+phZJvUR0ubvwH07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7UIjh0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B8AC4CEE2;
	Fri, 14 Feb 2025 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498482;
	bh=JnEqIyH78l9xsw6E0vWUYiTwf0S6e7Oe4YtvEVb5AnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d7UIjh0q+lcU0AxLdlaSXJLGrhIZWxBc+DQOAwQSY/QjBnAOWKlSJboYy6RpfYHjv
	 h5dCR3LHAieYy1H39UzMHoanhdUTdg52orb4Ko4oPiZlfWzmj4nufeT46HEKd9D7mU
	 CoeLjavVayJc1kdRwRAT0UQX+cegEboPALT4yJhLJysxLKveOImDweQyD1pcPdcOlf
	 HjPzAFslOi6e2x0grvwjfFLh96qVQxFL4X6EPhgfzr0xnzKjoKJNO9K1uC0t7Gedna
	 6WvekUWWXOA9nHEBKWOYLh0BqXdMQxWHat5cn5haNUjwTWTR1yLF7sDvRl9H3BX6BU
	 Gs420OjoUWyJA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:49 +0000
Subject: [PATCH v4 06/27] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-6-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JnEqIyH78l9xsw6E0vWUYiTwf0S6e7Oe4YtvEVb5AnM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPF+pAtXQPXSTsQZGuqvhemh9NN4G4H2ci9DUiY
 AClsV1KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jxQAKCRAk1otyXVSH0COFB/
 9U9N3HtxehL/e0EI+cW9a8BBCSt/vjX16EH5FMpRsx4zCyw3E7fWPLLgsoDgdZnMgNnc11B+WnvK6K
 Aoidkh0Q48OAkja1ZMtrKJlTYcXXuxOL6GVKyxSAr8oHydJ79ke2S9gb/XXFpvBGFDDqUzc5gQBp1f
 wxdw2M+BEEor2AOo6HpaWEMv8anIrmeG4w05y0SmrWPEnjNUCR2/SJaIeRQGBn3k0xp0gtfD/mb3mi
 EI8oKaanbuwZ4bg/zEW71/6bFvdkfrbGE3QsH0roySCGAwRGrudhRElr0IJSDnduaHpt3muWwGoawe
 vD6+erTFWPuV/u9/aD8b/aoaAmPlPk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The hypervisor copies of the SVE save and load functions are prototyped
with third arguments specifying FFR should be accessed but the assembly
functions overwrite whatever is supplied to unconditionally access FFR.
Remove this and use the supplied parameter.

This has no effect currently since FFR is always present for SVE but will
be important for SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/fpsimd.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e950875e31cee4df58d041519b7584356463c91b..6e16cbfc5df27e63732655dffea60d7039c37332 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,13 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	mov	x2, #1
 	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	mov	x2, #1
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)

-- 
2.39.5


