Return-Path: <linux-kselftest+bounces-37302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B2B04B48
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A271A6835A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9628D82F;
	Mon, 14 Jul 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmixXwc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35962882B7
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533985; cv=none; b=sMwhpP/XP5Wb0Cpx3uA+fKn3okQ9Vl8QjaEmFJRlkZ5+WEcfwVTezzW+5inST9TTvry/ow4oUKxjM9WHN/F4cDOvgUqEe+zqiz61vS++ICt+f5GeW4jCaJMvlzJCZHFaDj7INNB9obgOERQeShqe6NPh6yg9rw5zf7Fu9zJQ8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533985; c=relaxed/simple;
	bh=v8A7OTNElLp9NjEON3srySP/azHIcZU0IjsZoZmUJ/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IaLq2IxwP0S2DmHwzLgJtpNHPX64lAik0pmj8lRFLXlgbWN398fVX3fsDx79yEzTcwcjDr06BUiZE8LvZDuo7xoDQg1pe6D8sQefMxWEOD2Nd6BAoSHORnAfi7fF9x7c4J2alvwbeCoSLoqDeyD9kT3ayUkyCjjoMkhCcdoUrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmixXwc1; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86cf753423cso443509039f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533980; x=1753138780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ8dG4IcFoEafWjbI5Tl7HqmjBNXuoxF6820bVcH07Q=;
        b=XmixXwc1HY47T3FLyI7+GX30antrbAGHh8W7QOBlxl1Vi7niRJpeTLprb1R5PzRjtr
         1zQkeFVfKHPRYXJ/LdkmjGvCY89071Ib4CzKO7i5/sxYWwYTFYviKmDriSC80r/OMWeP
         roYnnvJx3XdZgfpvQEgprf3vTCA3PRnBJVWSm55Gg+MZWKZGQ7cgX+/PL3OjxJ5NsYNo
         iwmr05ujlIgJS2p2FXitDBT8MqJPxx87oXTwKeormk2V+v0xKD5PfsAf18NPL+Xxi/xP
         fBk7b7rN8G93O7/rP/PLG7JAZZx8wAWS+0nje0LRfs0FnE10tx4ZgrHvir87imq9bnRc
         GHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533980; x=1753138780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ8dG4IcFoEafWjbI5Tl7HqmjBNXuoxF6820bVcH07Q=;
        b=SKjFkbRMJaNhhyo+8Zh54BmTfbDeqxLk6fN9ykHomQ2NVwwsO1aGBrSfnjrP5g806u
         hYZcltHz9AbVORTbTKeQp6W/JBUMXl0G1RModaPWuhpNroTWJXIHQQD+bwfubKtK7Qig
         JKprLzkXR109KVvgXz/xHzaZ9r+IXDP9c+MnqJPK7IEsiyFbfO+DMH7QpjRVUxZpfN6f
         hH0kFDWc+POAiNc72ajtX9YuINCcEcxJDHwCkz9IDnpRWph4vKP+MXtkZFLipXHbgriC
         ShtXdcgBDYgZovph87NxxeBecM9O6AwhfEx1TZydQtrpkTBqaO3bg44rcPdPysJ4gvgj
         u52g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2nyg/3aJc0b41oT82B4aAaxxkSC9YhKZU3QnoPyoE9xciNqvBVl7VdHgMzjzSgqmCvAreJlikK+NFFLW5eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3f/HF6GVWyBfWHAgnCrL8SyZ1peWj92FpvO3JsIgbPms/Zr+2
	QlO9J83lkNEkxyqfcZ5sF4zVUtOsIclTglywazBz9jGhshVF0wAxg6rNS3ZvZW61I3i06hwiSBz
	VuVk6drzJYhAxckpXZ1oOSJYA0A==
X-Google-Smtp-Source: AGHT+IGJW+F7N+Qps6LoDsgu+dPhKH89vA9SG/aNNYSKUKGt/XO72mo40SLlz3/qQJipXch8VyxKlGUxhSMvINEeyA==
X-Received: from iove26.prod.google.com ([2002:a05:6602:45a:b0:861:c7b1:d848])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:6d03:b0:86c:cf7e:d85d with SMTP id ca18e2360f4ac-8797888c692mr1676383639f.12.1752533980153;
 Mon, 14 Jul 2025 15:59:40 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:04 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-11-coltonlewis@google.com>
Subject: [PATCH v4 10/23] KVM: arm64: Writethrough trapped PMEVTYPER register
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

With FGT in place, the remaining trapped registers need to be written
through to the underlying physical registers as well as the virtual
ones. Failing to do this means delaying when guest writes take effect.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b3f97980b11f..704e5d45ce52 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1036,6 +1036,30 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				   u64 reg, u64 idx)
+{
+	u64 eventsel;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+	else
+		eventsel = p->regval & kvm_pmu_evtyper_mask(vcpu->kvm);
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
+		return false;
+
+	__vcpu_assign_sys_reg(vcpu, reg, eventsel);
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(eventsel);
+	else
+		write_pmevtypern(idx, eventsel);
+
+	return true;
+}
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1062,7 +1086,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!pmu_counter_idx_valid(vcpu, idx))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmevtyper(vcpu, p, reg, idx);
+	} else if (p->is_write) {
 		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
 		kvm_vcpu_pmu_restore_guest(vcpu);
 	} else {
-- 
2.50.0.727.gbf7dc18ff4-goog


