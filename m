Return-Path: <linux-kselftest+bounces-26628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40DA3545B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA22169FFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01E1FCFE7;
	Fri, 14 Feb 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fukQWye/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF915886C;
	Fri, 14 Feb 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498551; cv=none; b=JUiY1yWOq0+EzKQzScs2nSN4WYKZ/6MQXY+BEcQytHD01cGVz63Hj2gJTskEU+Dyhp300FQ74UTPFsZlrTSxNRvTqP4O7dx0vwaJW91nwCnHfVHQMVpN53b9ovsS4Csxw1i+dUdr2F4rIaW+UklAyAeHH2yHsBOT+UynV3Vq0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498551; c=relaxed/simple;
	bh=O9fUykpOFCE6cffP6rch/hK0pXpC+JZZQ2fo1WCQyng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRA/HKwZp9VN+AYimCmsV+tKHdwjRsuQoj+HHin69619cm9EmfvnaEf9kl7n6ozeWMZrtsr0gm58+JWbvTr6xq03uC1waED7x9gr+bbWj5XIh0cTlHJc3iS2iYmuuklhvWz82jo8OS6qolMn8PNL+OFVTCmKrEEYHSj7R1pp9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fukQWye/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79305C4CEE5;
	Fri, 14 Feb 2025 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498550;
	bh=O9fUykpOFCE6cffP6rch/hK0pXpC+JZZQ2fo1WCQyng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fukQWye/fA/0QbZiSWxfKT8vKRA4t6gbBeNEGE33xtt4MIgWZWzgDALsSPFkuKHwF
	 A5+Qmqee8dVdaMkV8QSFjHhbteVwOuJd7U5FRAXLvKC44eNdhCnfs5exvkYF1j4L01
	 OGlYUsLTEVdYExaYlrlozji9TWxaSq+woWiQz2s5SDBzLl5/8unLfOr/9YyCE8YU3F
	 QVD+HeCRMgKd5USbT1nH3p29bXr7M61pp8iya+N7PAfMlCWkRxQnb6nzHoD12w9pzQ
	 nzZLgg1UzU6rPVSa9m3IwDpXlSzGREk6NxX/XSBuC672b5KOAkjmJtoTOOc2kusG3L
	 hYIfpwRfi3w/Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:07 +0000
Subject: [PATCH v4 24/27] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-24-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=broonie@kernel.org;
 h=from:subject:message-id; bh=O9fUykpOFCE6cffP6rch/hK0pXpC+JZZQ2fo1WCQyng=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPTY/O9PimbZOlJQsTehPrB4TODTPWvtUWQWIQY
 8sv6NXuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66j0wAKCRAk1otyXVSH0LFZB/
 9ior0jJCdNBf81HfqHzJn/jvJY8NN7KoBMDvFl7WH3vVlBcf0AsoMkLVB3kNYoIY13gVuPEddEP8cw
 MVvuosaYdK2Udy5A2uuIwaCGPLpArix2bLDawT6/Of0P9t3BA5teHZGUVwxVAxAEdWdXI3rU78qn1u
 kW3qQq3p42aOMNPr36emzR9ydYiIWgu1fmEXkS4NLEL4cEzgR2NlZntI2VL3qziR1qXHhWw+2HSN8R
 g1xyg9FITMKxVxhmAiRrwC52g9To3eLt0eNyXxzDr0eD32f/o3jjyY6IVByhhVxNp7kqjiZiA19kVJ
 ImrRmgnMLFJ6+EG7PQMshN3D9MOwtC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

With support for context switching SME state in place allow access to SME
in nested guests.

The SME floating point state is handled along with all the other floating
point state, SME specific floating point exceptions are directed into the
same handlers as other floating point exceptions with NV specific handling
for the vector lengths already in place.

TPIDR2_EL0 is context switched along with the other TPIDRs as part of the
main guest register context switch.

SME priority support is currently masked from all guests including nested
ones.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 0c9387d2f50708565b5aac1fc0f86fefffd94ea1..58324806c8d588b0a77c835bafc89236a1ad52d1 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -840,10 +840,11 @@ static void limit_nv_id_regs(struct kvm *kvm)
 	val |= FIELD_PREP(NV_FTR(PFR0, EL3), 0b0001);
 	kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1, val);
 
-	/* Only support BTI, SSBS, CSV2_frac */
+	/* Only support BTI, SSBS, CSV2_frac and SME */
 	val = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR1_EL1);
 	val &= (NV_FTR(PFR1, BT)	|
 		NV_FTR(PFR1, SSBS)	|
+		NV_FTR(PFR1, SME)	|
 		NV_FTR(PFR1, CSV2_frac));
 	kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR1_EL1, val);
 

-- 
2.39.5


