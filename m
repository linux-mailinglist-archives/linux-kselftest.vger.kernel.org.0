Return-Path: <linux-kselftest+bounces-40895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CFB47642
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 20:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3831C2223E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07F27CB31;
	Sat,  6 Sep 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqNb8pV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF96315D2B;
	Sat,  6 Sep 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184231; cv=none; b=QnQhxRt1oMH59cPMShMfl9KTLkb7/58Mqi3d7H4byggrtfrJVJCvUH01RDb5KBQlFmQ1Ep1PHEm7vztold+xU5teiF4KOWEtPkvfJ52nOKLybH4w71NFycd8DaGC826JCOV2lyCB9OX1NHed4zSOid1TvMXJT3jFzoKOKAsaRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184231; c=relaxed/simple;
	bh=A2SfHCO2en4ZibxLIFm+2RXjb315oSn5JIZ9vIAmY8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vg6fNb1kSgBO3Id6SghTbGls3OijS4sQKDhC912DKokvc6qI7wQIKeKb4Hfuq5F+0ocwlwFb6u7J1OTfsImNmd1/xvQV99hjkv8i0uTMrtNq6dtUigpY01ZQ35huTS5wyJYzoVN0lpp5oh3+V5pGvyzkxFRWjhWf5qn8ejE5j/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqNb8pV9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b02c719a117so572925466b.1;
        Sat, 06 Sep 2025 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757184227; x=1757789027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPAi90Hux0mu62Ys4IXO2Pj4eDbqG6EQAkVC5R4v2uU=;
        b=WqNb8pV91L9rJE3R0wpitjxd/17CVV1XLyhnrL4u7DR98CXLuj2avNnmGtgL2YM1r5
         ZkKpC45jw6JpxjEwaGjd9XljXFb1EK//W92bjMT/eIEgaRBc4K+N6vslXxYAPtHMXTUu
         BZlyomsbVCktzOoAqKXfXPmipmcLyABXiF8Z6UuIWtrAxWBvI7GPDMx9zk8fnOJV5XVv
         SjO6HxqmCO+BqbQj2C5J/VisTZkR+0OcRhDHg8W9w4CVReA2ZDq9DFCJv9tcKXLb5B9X
         954FGapAKOC0tzdseYvPaB0xTnUfHixtBtTHyPnAQR5/fQmp2ydj+za4AZaQhMkJpwFC
         Zg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184227; x=1757789027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPAi90Hux0mu62Ys4IXO2Pj4eDbqG6EQAkVC5R4v2uU=;
        b=KRULYuz/90Ywev2lATMxwv2N9BToghvikdw7gxTWRk5QrTFo1vn4r2U17MXa/0tJVV
         IRMR+6vGxNc+ZYELr2tGCseg0hf8FM6yP0KI6gg40gIrtCWjBkjK27ZR0vxkEOW9i+Vw
         UqvH66QWZfZz/9g7/zEhNlBpl6ZFFFbvhb9y2IF7su8wz0jyKJAfG7rDJAeGpt3B19Tb
         KZc/+QR84QcrMag2ncOGyMg0o45MROVZtv4YBw8S4rvtEfL2Yk4+aYFFXVMaPgSprWY3
         5I3BbgYkfJkVI0ptzox73YRkb0kAQ79UO9ZSixyAdQU8/xG1YkNtb+isZ4DGpElZwx+v
         nF2A==
X-Forwarded-Encrypted: i=1; AJvYcCVAW0HlVRRSFpEwhUnUCgMNb/MkrpvaF0xpWi9blLB9RcZB6ERXpIim6azcOk1ywyfzYt8Fd5wtZ1flKJKv@vger.kernel.org, AJvYcCVgFrYMeWC9T7oDke4aejmJB3a+EjnxvGthCo3DEzCDaCKwv2tW+4iUvjPS8kXi3+X0uuY=@vger.kernel.org, AJvYcCWHfmX8I4rxz3RU+SMIqjFRvjm/ISU8F+qRZ7jJ3iH+vGDAvSSYjF8/6BeLJ+ti87+4M7ke9WiNx1Twkl7sP3gC@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjJPWb47SAiKVjDiknKG3rij3knHMAu7jmGEqoOHnYsEUJuko
	VEUcwBBrUuOhBB5x5EFY41ebXoibB7bgf1seD8X4g7FMZgMzoeOCRan6
X-Gm-Gg: ASbGncsPRkKLHFPuXS32oYZnNVYchxi4LpcwU82OgXcyD6HO0sFC8zfwkknvsEVopPE
	POt3wrfsXvWm/G5kSXIgF5RuwGY2xobZowhFvw5UgqrGQLUJCtElEGdCO3p8MTCIdNm1KDXP7Oz
	3Bbk3bQaEzfiNnftrbdiOG3LTpN43GZO3wTProluxLlQdDe/N/Q3aCF7ImtspBbXOuxxMluXf1n
	NTBTjfKsCcfl79rn1NS4BvHauwbzz5KOIdnOuiIMUWXWnqrpxyGX6VARHPqTysezfWcH+HmCI3I
	yt0KaxvrafD+6J0P0+p1qR6Z/oo6bieyX/9Uc7TWF/bN3NWUzyLRX1wCJ7oquUVmRt+rV28zEHf
	MSwU8IN9pq6SJC80=
X-Google-Smtp-Source: AGHT+IHE2NZIt0wrvI86xs9hDbwS5+mTK6rKNdU1UL89vVA8Qvv/fkz3LiQ4We8x5UFPjNvHXXIAog==
X-Received: by 2002:a17:907:6d05:b0:b04:3c66:ee5a with SMTP id a640c23a62f3a-b04b147d878mr264654366b.23.1757184226681;
        Sat, 06 Sep 2025 11:43:46 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047b61cf00sm700359666b.15.2025.09.06.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 11:43:46 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: 
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/kvm: Use vcpus count instead of hardcoded 0xff in test_icr
Date: Sat,  6 Sep 2025 20:43:20 +0200
Message-ID: <20250906184324.89974-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded 0xff in test_icr() with the actual number of vcpus
created for the vm. This address the existing TODO and keeps the test
correct if it is ever run with multiple vcpus.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/kvm/x86/xapic_state_test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index fdebff1165c7..4af36682503e 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -56,6 +56,17 @@ static void x2apic_guest_code(void)
 	} while (1);
 }
 
+static unsigned int vm_nr_vcpus(struct kvm_vm *vm)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned int count = 0;
+
+	list_for_each_entry(vcpu, &vm->vcpus, list)
+		count++;
+
+	return count;
+}
+
 static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 {
 	struct kvm_vcpu *vcpu = x->vcpu;
@@ -124,7 +135,7 @@ static void test_icr(struct xapic_vcpu *x)
 	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
 	 */
 	icr = APIC_INT_ASSERT | 0xff;
-	for (i = 0; i < 0xff; i++) {
+	for (i = 0; i < vm_nr_vcpus(vcpu->vm); i++) {
 		if (i == vcpu->id)
 			continue;
 		for (j = 0; j < 8; j++)
-- 
2.43.0


