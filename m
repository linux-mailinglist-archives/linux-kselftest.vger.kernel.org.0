Return-Path: <linux-kselftest+bounces-39377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F89B2DF08
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DEA06082
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837252DECBC;
	Wed, 20 Aug 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiI37vqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548B2DEA9E;
	Wed, 20 Aug 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699331; cv=none; b=HWlYK89A+nCHD9fMHrQrQ0XK4Pm7g8DYWL9wT/yzAEkA3MFZntyUKzEHcPVnUVVxxPEZUDjiFyUIIg0bnlasXlOKThm0pLEnc5KE5faWOhdRB3G/jpRO0v9DrtQFgUkssuWnu2MW1L5eGRe/zXJZ/o4Jh6USXAXZsQv099zG940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699331; c=relaxed/simple;
	bh=/H6Cuxewkf3ZOoM+h+m1Hnboxh9fXQ17PaC0xmbP9d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGApKk9kclkd4I1PSfSrhk0tPQiJ8+S+YYRomuio4zBYDF4gvAyP86Tk4XA0wNqwiVUw0hS2noLTZE+JVpk3QaBvtAkXbDfqp2aMNxvl7fDkWsMuE6inb4eZU8Ub280qdtsFoyrhFdINu86ancCirnaahdpO7qRgGTnenv2eNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiI37vqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B26C4CEE7;
	Wed, 20 Aug 2025 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699331;
	bh=/H6Cuxewkf3ZOoM+h+m1Hnboxh9fXQ17PaC0xmbP9d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GiI37vqHndScZIBREQpAxkImAI56bfK+WeLENIxvhYv5359DFAtQtmJYBGk19UGYR
	 tmNbFEZxzCQHTfyMGnX6oP7FDC2CbCP2wJvzuhGyfpnoGYOY3DKWYnpckF5XgJERiM
	 5/88QrLKY3OZhbv36zIf7gQlAx56Mlfvvwy7jdFDgyYooGUJZ0bZ4pTqHcb4ghNYJX
	 IYeXx0+QdgvkE1PeTJuTKqyr923obJRXwi8U/lE4set3YWBpqQhAtE7kNdy50uyTsN
	 z7tlN+drlTw/YYQsITAxXk0pf7sxf1/+DJnoCjM0umRNcX5lmHIuSe/LHgzof96Vj9
	 N35iVNX01cvKA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 15:14:43 +0100
Subject: [PATCH v15 3/6] KVM: arm64: Forward GCS exceptions to nested
 guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-gcs-v15-3-5e334da18b84@kernel.org>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
In-Reply-To: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/H6Cuxewkf3ZOoM+h+m1Hnboxh9fXQ17PaC0xmbP9d8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhw9a8PwftR7e7KTrbNQNhA2EWwxbNtGK3+O
 uDaajVqAxqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYcAAKCRAk1otyXVSH
 0JS+B/wNzWs53o4ozEZ+UVZObC3L+hU7WGSpojmSDhHzVYkpqAFOywHJUwUe+8/kJmKC2Ct/VzX
 ZIxMGWpO7E5OHGJDMbT3yRXqGkMs0kHvt3kkoXjn6Y6dddqtFqWYXaqwkY2ZOLxbSGPJRDn3eb3
 kvQdUSWxwaRwrTeuLEGsGm2pLoaTRVVCJaUTAWwV5DpUPjuwuIYuM9nBPWZHzB5sWuKU02iw0jE
 gqhqavT9QJPnLdf9K3EMhPfixEkK+XraEgf9MtzpLcGJfzTmL+CjakifA4gK3Nsvmf84TGNFDCE
 eGwHOfQggzSd0F6ijq6Edd84QEfFJtMQICcL60sMNnDY78SE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS can generate exceptions with an EC of 0x2D (GCS Data Check
Exception) when data validation checks fail.  When running a nested
guest which has access to GCS such exceptions can be directed from EL0
to EL2 and therefore need to be forwarded to the guest hypervisor, add
handling for this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/handle_exit.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a598072f36d2..2f5aef84b294 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -301,10 +301,18 @@ static int handle_svc(struct kvm_vcpu *vcpu)
 
 static int kvm_handle_gcs(struct kvm_vcpu *vcpu)
 {
-	/* We don't expect GCS, so treat it with contempt */
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, GCS, IMP))
-		WARN_ON_ONCE(1);
+	if (!kvm_has_gcs(vcpu->kvm)) {
+		kvm_inject_undefined(vcpu);
+		return 1;
+	}
 
+	if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)) {
+		kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
+		return 1;
+	}
+
+	/* We shouldn't have generated a trap in this case */
+	WARN_ON_ONCE(1);
 	kvm_inject_undefined(vcpu);
 	return 1;
 }

-- 
2.39.5


