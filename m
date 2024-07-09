Return-Path: <linux-kselftest+bounces-13400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96692C344
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1C51C22B5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ACE180040;
	Tue,  9 Jul 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNo3ZXym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CD17B04F
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549791; cv=none; b=YoxARNH+8LnenaXBr/Z1ZH7s05UoXm1jUpcia2VWGzDCNufJZRkM4M65CKzStbpEfoM8MEYtVegOs+Hi45u95pDiiPJfTgnh8i457y0IZUU/6oYPF0pG4+Y+YwkdTVStnw7KT12XV2ltx7hIwFXtKmV0TPeAf7NWpq39W8Pb7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549791; c=relaxed/simple;
	bh=g7uGEN+YddoxxZ0oSW8KlTk+Tg8ldl5shSEbz8kvz1Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pNGby66a6LYxOtomsLsgTJIN+V1CWL2RujBhUVoslAnN87/K5LLJTUdeVr3/EbIvgS7frPL+oLWFA8zi+Hn3qah7GR7J+iA2Aj8ETLbhZoLTOQtlO7Ox6de0o7ej7rMbDV83v+rZ/G0z8/UuwWkMoNw1wb9XcD0xvqdb4q+iw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNo3ZXym; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70afd833ba9so3163175b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720549789; x=1721154589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZqTDIUJuejWJVRRv7rSZlF+QjRVhuEo942Ds62pbMYg=;
        b=wNo3ZXym2YhcyFEAGuZWHuSUQIH0zAEHmdnoghfFwnONbNwqJpCUjQEod2TDwvknYx
         3AguYJfOSq2oD9utbnFEft3RoBeePCJF+Kf2bkyqooiLOIOvrdAmX8647zqyUWHnSWyt
         nTf8LDPv++HGbyYq2faHM9lMgIv7XhJ409shH7fdSHIDqlvUfHuT+sEcikMgiyOdlUY9
         xcc99Lr4le1sy1UmJZk7k2j3rwUt1hw01yX8wiKjXb+nPQ4Y4Jgh1UQEu4kHhkPxb9YQ
         JEONsMPoXc48OTNcLZliQdzZZ+JIGzSr0FuZoJYwqA8XkI2sDh5PAEtgNs/TG+a1s5BU
         eNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549789; x=1721154589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTDIUJuejWJVRRv7rSZlF+QjRVhuEo942Ds62pbMYg=;
        b=qVnke+Hs4pHoQY/OiKES4qacGcAG2gr3H4oK5fc/LwF+ySNzqq4UnQRDD0nYD3Rzyv
         J8d8qI8F3gg3Z+jJdTGQyAx4ZV6hEzVeqBqJwmuG1EdgslF0L5z40pPi0TyaM/RKencm
         KnYv6Mx4tzTSZRINkrMyFZsFn8/1Ye83sqrKdnOG0eVGFt7AGd6K7gJ9mBUi6TGRSeAr
         Cm56QjY4j3AIFQjyQbco93JWgAV5fSrUlWl0bbhERwzMejLj3Jpfj/toUz1e5KOs59r2
         F8YCOXAfA1i/jtsfGCvwbaoYTY0kua9zvEENU1FTn4JCN6y2WTJ/TgFLyJ+EqI/S7O9D
         tdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpdc3obSeLw6SzfxWSU/hDx05d0BnSW/OJHuLhtJTMqBs8UTjkxU/N6/aIJ9dDgo09c4s3zFJcehjYBHtl1YczCw3du/mIsOnJrZblgl0j
X-Gm-Message-State: AOJu0Yz4H7YSzQrq5HNqAoy3JfhOsNGPlinn2FfadnLa5/BL8hawea9M
	sAqD5O6WDrw2xuQTI+ZEc0f7O91QR5Lk9lww4Ga/Yg3ZCmM9XlgVqe51cffbRQEc2lavYQ2QkSh
	rgw==
X-Google-Smtp-Source: AGHT+IHpJFxP41Dhe/Y2rfoBfzikDk7c/bwo4bZq+HFvVhN55O8dbsQtilruMtC5PfdsbeyNGFXuQte4hhI=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:f7d0:8e04:1846:cd97])
 (user=pgonda job=sendgmr) by 2002:aa7:98de:0:b0:70a:f547:382 with SMTP id
 d2e1a72fcca58-70b4369d510mr75072b3a.5.1720549788460; Tue, 09 Jul 2024
 11:29:48 -0700 (PDT)
Date: Tue,  9 Jul 2024 11:29:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709182936.146487-1-pgonda@google.com>
Subject: [PATCH] KVM: selftests: Add SEV-ES shutdown test
From: Peter Gonda <pgonda@google.com>
To: kvm@vger.kernel.org
Cc: Peter Gonda <pgonda@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Alper Gun <alpergun@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Regression test for ae20eef5 ("KVM: SVM: Update SEV-ES shutdown intercepts
with more metadata"). Test confirms userspace is correctly indicated of
a guest shutdown not previous behavior of an EINVAL from KVM_RUN.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Alper Gun <alpergun@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>

---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 7c70c0da4fb74..04f24d5f09877 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -160,6 +160,30 @@ static void test_sev(void *guest_code, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
+static void guest_shutdown_code(void)
+{
+	__asm__ __volatile__("ud2");
+}
+
+static void test_sev_es_shutdown(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	uint32_t type = KVM_X86_SEV_ES_VM;
+
+	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
+
+	vm_sev_launch(vm, SEV_POLICY_ES, NULL);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
+		    "Wanted SHUTDOWN, got %s",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
@@ -171,6 +195,8 @@ int main(int argc, char *argv[])
 		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
 		test_sev(guest_sev_es_code, SEV_POLICY_ES);
 
+		test_sev_es_shutdown();
+
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
 			test_sync_vmsa(0);
-- 
2.45.2.803.g4e1b14247a-goog


