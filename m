Return-Path: <linux-kselftest+bounces-36953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1EB0003D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F4561886
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AAE2E0934;
	Thu, 10 Jul 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i67cN5Zb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D4219E8D;
	Thu, 10 Jul 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145997; cv=none; b=ujsGQshCQpj2R0jOJdgo7cbVcLjB5ssXaFI3LOFoo2ryj/ipB4qp9gXXjU5ne7D4wVQcW38cMdjBFeTvP2kJNaHnN3kBh+hHe7s1bxunmQVJ9lI/QNZexg51tzk3vgyFARFgY47IZH7swAtJRqL866tOXFIIS/B9Q6yjlDwNaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145997; c=relaxed/simple;
	bh=fCMFwl6Oa7Wwc2XvpmzD1mwe0tkqTEL6NM+Z25HU34w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fXcOXMoADYd9nDO4z3E/cEkvBRFw1GRh0dxyJwuU8SjTDorRzhgwxyqERtxLSgRl7j/m0d9TUZjNVnD++jtKCypBKPSjgEKgQq7DXgslTDKyvJNpiiJxF4HbLIm0YUpTTlh6z1KrJYa7wEomZKwEqZctOE/r3b5pyz4m8uNmCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i67cN5Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C53C4CEF5;
	Thu, 10 Jul 2025 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145997;
	bh=fCMFwl6Oa7Wwc2XvpmzD1mwe0tkqTEL6NM+Z25HU34w=;
	h=From:Date:Subject:To:Cc:From;
	b=i67cN5ZbNoDe/jqjQnZYTWyFqQH50gksbF036qEU3JKLHZ2KAD2ErKmJgIjqev+VV
	 29cbgSrYABAOXv42x+s+0GNKXLVw5lKu2kpTGSAohZZl7i4G3EtRjiEfMZHR/ofjH5
	 vHO9g7cQ0pyryGPqD61AfRUNmoHTbbq8zoqjvmyf+oZxL/CSJaV6K51yic92/Qeh0m
	 HS/VcYGMEeJYNXBE4GixHapnsaC/U3eFsMIpdwmcnBZ1yQLpGD/WHusFtpOh+Q8AgS
	 5Fd2P9UGpRtHB5HOSOlfPyWTAFcZEdfHYOO9ygdArQ5lCBAbfGFn2jtRasxpHN1GIS
	 DM68A1yvraTOA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 10 Jul 2025 12:12:20 +0100
Subject: [PATCH] KVM: selftests: Add CONFIG_EVENTFD for irqfd selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-kvm-selftests-eventfd-config-v1-1-78c276e4b80f@kernel.org>
X-B4-Tracking: v=1; b=H4sIABOgb2gC/x3MSwqDQAwA0KtI1g3EVJH2KqULP4kG27FMhkEQ7
 97B5du8A1yiicOzOiBKNrctFNS3CsalD7OgTcXAxC119MA1f9Hlo0k8OUqWkHTCcQtqM9Z8HwZ
 i1p4aKMUvitp+9a/3ef4Bpycq6G4AAAA=
X-Change-ID: 20250709-kvm-selftests-eventfd-config-123bb022fa04
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-07fe9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fCMFwl6Oa7Wwc2XvpmzD1mwe0tkqTEL6NM+Z25HU34w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBob6BLebvS2hzgRttjOHmgmDaPDjFiJuGaolRni
 SApdh0D+0uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaG+gSwAKCRAk1otyXVSH
 0JJEB/9/0Zr9vUk2isLoTJ42gYIKHIod1FJ9lnc334JElWb5/rhVM65dOb58xb1Tpf5UUdXh13I
 I1uWo5raNoM5QB5KMfYLgrHqbLih1w8B5T66ZDoncwUNFNRnYsdgyRhnQQeJzIU4J6Ce/LUKpZ+
 yjjosFgrjatnNNCRnAoq2Zlg5XbM2sCs+9bSAVn8xIArJfIEKa1g5ZHhYwSXQUOrsA0GH50WT/F
 468nnOizUpRjwM1K+rq84Cgc2sPO+WdLLKsBPsWiWwULRzgYwoZQhNHfSx4bmxJMAkIWwc7ffeW
 PeV8+f51XaF6RdUfJbF2L9VyHtKu8T1qNJdx6pcsah+DpuSw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify
uniqueness requirements") we added a test for the newly added irqfd
support but since this feature works with eventfds it won't work unless
the kernel has been built wth eventfd support.  Add CONFIG_EVENTFD to
the list of required options for the KVM selftests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
index 8835fed09e9f..96d874b239eb 100644
--- a/tools/testing/selftests/kvm/config
+++ b/tools/testing/selftests/kvm/config
@@ -1,5 +1,6 @@
 CONFIG_KVM=y
 CONFIG_KVM_INTEL=y
 CONFIG_KVM_AMD=y
+CONFIG_EVENTFD=y
 CONFIG_USERFAULTFD=y
 CONFIG_IDLE_PAGE_TRACKING=y

---
base-commit: 7e9b231c402a297251b3e6e0f5cc16cef7dd3ce5
change-id: 20250709-kvm-selftests-eventfd-config-123bb022fa04

Best regards,
--  
Mark Brown <broonie@kernel.org>


