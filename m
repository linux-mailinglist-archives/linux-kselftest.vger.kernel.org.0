Return-Path: <linux-kselftest+bounces-42852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18ABC279F
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 21:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3C434E60C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA6223DCE;
	Tue,  7 Oct 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd3cM1sU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C42223324
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864359; cv=none; b=KkCvytsqWbG3JRPgIe2T1Z2S810Z5uosci8MnFrGa8af8hraGHGoWvVYr8JS6vqAKMUgBdgCLz6dIMRihhgfksZCR8711DK3OUxZJpwDAaLnvVm6fxuQeZcnJkwGkQ5VqUBAY8MS2vwjzKeB1/f89ceSwwXN1EFv5HfIlN9EP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864359; c=relaxed/simple;
	bh=1zq+wnX1vqfhxHgRG9451gSG2RiJStNjkn4b+44kVWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AH+w0IHJpWricy1HVHRD/ULlC3iy0n/NOucDLgcS4RKEv6Zp8VPRgVHN0WlfrbPacDM5oq6IEjwrZdJx6BkNjs41JbM0tELHdCcQ0l1KoH7obfynkZKqJhmYxIVoFISOfcS32Ggh5ZrQtbPB2qnUBW3N/zMYvBGHHPtDkrmJuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xd3cM1sU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso35206685e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759864356; x=1760469156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvaIFYn8xxn1Zh95yE3a4kb+EhT+TJRLQn+JPUMtZMI=;
        b=Xd3cM1sUDRdMe/hcpWwKJOjdwiam0WZf53hvhu1twpYFP2Es7JPhNB6CJ/gbrymL1O
         X4I+WecHOmNz37dKHwYlyzi52nXJpUviymGuzkhUQ12WPrv6hczXnEbjFeHzaG7jTJbT
         5tPLd41WJC4rYdxgMiPet/lhVXDClNj2fezr8GzuUx1HKyH7z1XjQ0LDOV59z6TpyFW2
         xcQKbGFmAk2yoG4c20eEYORNXxWpZ1E1xGDxNyUbOyANGP/HA98JnN/39lMtR7ZvD7+C
         RkxI8Jl2yAW4RBm3NCO5QiVxwPN/I334RD7nQFlCOEg7ASlbg75ffJRPfLnMPFuzt5G0
         MXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864356; x=1760469156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvaIFYn8xxn1Zh95yE3a4kb+EhT+TJRLQn+JPUMtZMI=;
        b=L1Hs+Ydz0C6tYkCTz51A27DKafN1as/4vPWYLPhfDCub+u0hrAZwL9crgtYt4wj4w+
         xoMSXkIhUfb5FtvdKwENpdoMlqgsaHmgwyRc6qu8URojmjEndJfJGRjcYHu7gKabjnpg
         LdkGcSeicXVwDGBg2HsdXcQ084OIBE69cTCYCllEGQizufP7zNuA913INkxQeJ7wShoU
         f35u2v2op5rmJ3Dp/+oAJLl7N5aKQvF6UevqYvT7K5H4BxhLY4xacDTFX+dCCdYx4Yxo
         meG64376KaffQBMjmw9mQC5XDXCk4QKmCdgIeg+muXR+5S1q+OJjsCH+Holxl/jl+xUR
         PTGw==
X-Forwarded-Encrypted: i=1; AJvYcCVsi2Lu62UmVmOKB6xbDDUAl8AeqC87OzDKEPzlhOitFecyA4y5xb62PBRNrw7tPolbtHGfjY2vGSYKQr609Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGFmYdKhwSjGvEsKwkP/ZbOj299Ga1MHMwhhvuVpJ/emV+b2Y
	2dP5vJRnvBqAgR4hM+UBonsXbjpk99dhG96CBu/vg2AR3unNbwzFUCjHPBfQpyWoV34s3MAtR2N
	A4xWxzVZsKoUFrw==
X-Google-Smtp-Source: AGHT+IF8cPzfTUCADjWMgjnDGXv9bUSJvQjzkSR8TvbNkHcOTb21Htn49hpM3qx+nFkCimdVq0HJmb49CeMBYA==
X-Received: from wmcm4.prod.google.com ([2002:a7b:ce04:0:b0:45d:cfa4:ce19])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8d:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-46fa9aa1d13mr5841565e9.12.1759864356219;
 Tue, 07 Oct 2025 12:12:36 -0700 (PDT)
Date: Tue, 07 Oct 2025 19:12:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB5m5WgC/x3MwQqDMAwA0F+RnA00Ou3Yr8gO2mUapCpJJ4L47
 5Yd3+WdYKzCBq/iBOVdTNYlg8oCwtQvI6N8sqFyVUPOeRweOO8RY/yhJWWzxJaQNl0DckuND1T 7p+8hD5vyV47/3r2v6wbvcihFbQAAAA==
X-Change-Id: 20251007-b4-kvm-mmu-stresstest-1proc-e6157c13787a
X-Mailer: b4 0.14.2
Message-ID: <20251007-b4-kvm-mmu-stresstest-1proc-v1-1-8c95aa0e30b6@google.com>
Subject: [PATCH] KVM: selftests: Don't fall over when only one CPU
From: Brendan Jackman <jackmanb@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Running this test on a system with only one CPU is not a recipe for
success. However, there's no clear-cut reason why it absolutely
shouldn't work, so the test shouldn't completely reject such a platform.

At present, the *3/4 calculation will return zero on these platforms and
the test fails. So, instead just skip that calculation.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 6a437d2be9fa444b34c2a73308a9d1c7ff3cc4f5..b5bd6fbad32a9ad5247a52ecf811b29293763e2e 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -263,8 +263,10 @@ static void calc_default_nr_vcpus(void)
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)",
 		    errno, strerror(errno));
 
-	nr_vcpus = CPU_COUNT(&possible_mask) * 3/4;
+	nr_vcpus = CPU_COUNT(&possible_mask);
 	TEST_ASSERT(nr_vcpus > 0, "Uh, no CPUs?");
+	if (nr_vcpus >= 2)
+		nr_vcpus = nr_vcpus * 3/4;
 }
 
 int main(int argc, char *argv[])

---
base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
change-id: 20251007-b4-kvm-mmu-stresstest-1proc-e6157c13787a

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


