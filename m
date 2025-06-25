Return-Path: <linux-kselftest+bounces-35749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2AAE80FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA53AEF4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C552D8DA4;
	Wed, 25 Jun 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKAHdKb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575962D879C;
	Wed, 25 Jun 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850709; cv=none; b=Ew6jTyw6V/jsWS3VoQ3VXjYnoJvwnLjmLTtU/V1hTHHJ12FXlBTxazDIvQmZEdznbDPZcd6W/E1Ee4OUIVUkUuLmuQxUvoQSVq90QYK/I+jHPgB6xUHTouUjXfFUazGTezoWjQacJvkZCnM3lirx9dxHIplMkipCcNEbashHW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850709; c=relaxed/simple;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9mV9WGrs1WX6dLTs6+mQfbYwh9d/wqLsKeCYEj3kjZZ+FubQTg+utEICvvE6lKFzpg5hiKPuQpcRHYhCOfIpzOQjBGsYgfaQGBj1ktsgqYWH9UwuiRTQrXRRuBNcXK0uh6jX/6hvG5KFCcWmMuNQ2KBYE39XBfnCnT/h3weVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKAHdKb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED19CC4CEEA;
	Wed, 25 Jun 2025 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850709;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QKAHdKb4lwsD0O70a4egcSiV4BSR70bAZ1fMAnStK5BsAbHKKBcGls+5GRFKHiSRs
	 33dZQqORAWAwNRDIDf5sa4m2zzvZQxLPXZBS9x0r04PjOXWOVyZjtF6WzAYn8oFlDr
	 9kJnhOz+qXYScqI071Zobwl1Y+Ima4y6ljJMhaM91j9mybJv5tXU2VRvCkDyVqDTco
	 uQQ+8KULaryX0DXElY4fbQ18B5+QRA+QcwvPn9wVwNAi5+Nn3HjOMzWRQpwdxuZU2O
	 Vn5/o+l4QA6SuALYFLa7+2+vXYCDBgk7HeueIAWxZyITvQ4C5GMLkw9yn7Yqg19mS6
	 TbndP0QNu38Kg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:57 +0100
Subject: [PATCH v6 06/28] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-6-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xpVM7A4Y5s7BNvaF1svD8tgLscwneMGhduz
 ayXN4iIJ26JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcaQAKCRAk1otyXVSH
 0L56B/4lzdpMHqj4p9rkFkdVzwpE8vA4ZOrgAnR75BmaWi1o48gAT1nUy5z5W4uHFEWOlbhNIlV
 JoW/ULkTBRwXLTkWbdDsFWMxoR4ClBkkVAWnP9HXkjtY2QnAuL7SoQy6apSPhUf3dAesZswe5Fj
 d/CqU0yV9+OscSaXgIbIiV2unlFKM1KsziwzeghFoFzsVCkXB1d52EOaUjLkNkKnQcZbVVZKBUv
 LEvMJj5KjF69ItunSj4Ba5sa9+TmdOiMIDhwgPwwycUHp17nh7gx359qwJFL0sWwWSvvDtLF4Hb
 /+JSxij7xp2XibayPmVXSWwUS5bFaVwthv45NXkCAZ564aQ5
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
index e950875e31ce..6e16cbfc5df2 100644
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


