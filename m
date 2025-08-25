Return-Path: <linux-kselftest+bounces-39858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFBB34651
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351D13A4DF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7222F2916;
	Mon, 25 Aug 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNzgMPNn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD129E0F4
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137136; cv=none; b=Hl9uqbiZyQhpCjqmXnLlLgo/XUXVB1kYSjocCRE2V8igh3l5NksO1d0EFbqjSynaPW10pr0q6avXZK4+KgpgNAMfNBH7flmNfA0w7bLOcW1z37GwTxwTYQNHr9BHPb8d+HU1aOcupkYJTNjK3rphbms9BJApQdMFlbJON6sR95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137136; c=relaxed/simple;
	bh=KZkhA/kQOmp5Oy93QMxfpEXKqa6Fo2q74cwH7XYOoXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn11giTfTAt0dzK6uHhrMdW7LEJetNVLSnuHJ/wlTLVnQGL26oxGpLVl763FiEO6hE2JtDiEGtVdCJCRYImitmbyteUQNaY0a4Qvpa2DKU3vRX4R99kmvZj1d3Wr3JyeuqL76JVC36ssMAGYSXI0C9wCreGdZbPAHjm0QDHTmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNzgMPNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756137134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ed6qfTFHMUqyUn8kqjL4nj7yM5M0u0oh4hNGYHbww5c=;
	b=LNzgMPNnwqeaRmUfES2bLyObn/B2iVStO4niAFqGnhI4aZznWpHH8kgL3Ih3YsNn987s3p
	S1Tf87kT82c7+2YVbPykqzq+cCtNcc6SLUgtCmCJOb7ejSKiqGGd9j9twfS4tzjv/DlXot
	JL55/6VbcMXgRVBvGonYJBpSnDsYVps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-jxGlNkb2OnakM0Fx0XPiHg-1; Mon, 25 Aug 2025 11:52:10 -0400
X-MC-Unique: jxGlNkb2OnakM0Fx0XPiHg-1
X-Mimecast-MFC-AGG-ID: jxGlNkb2OnakM0Fx0XPiHg_1756137129
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c79f0a57ddso1103457f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 08:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137129; x=1756741929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed6qfTFHMUqyUn8kqjL4nj7yM5M0u0oh4hNGYHbww5c=;
        b=LdR+TORYdNyFiakoYwQwr4d8UM89You3jHZTYRSJTECKyHFq27AO4oyUNQ1BJkAEVl
         ERFtq2hMdWeUwjUaXufCyhehw1CWoeFKrauAUfrJqIA69dPL2ZU084rd3/uiegl/Yiao
         kdxasKwNCg+7k2R39+qQx0LahFg8PDMdlar78AvKvTeXrxKPQhnYED2naBKvqdXRSemj
         dlsYHAxz8SfDfqNoafFq+GWI/Iae1IXDiWN71N9HAnPI8Nn4usumziakbHW12iC4iPk/
         KiA7l2PK++d+J/xruN1CUi6SAym96Wq+1+Sc6u1YigRnhj8fJaCH7Xc8tE/DJV8jTl2c
         cNfg==
X-Forwarded-Encrypted: i=1; AJvYcCXP9wGVcpBsFEa1AE4tJrplIVTlNBfEk2wYQsCwTOFnxG2bOzKZ6F/H1pvaYxooImD1GKDevcFHb/D4hoKtvTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPS2nI/Pq0B/ib8+mtTDi8efuBbw7jJYEjEC/gCepcEypq4/R
	pCLdmwT0KKA3uPkLcH4Kq5V2wWSE8+12mG2+rZuAIgHSA1tW6wP/7hsZ45BGSVhOVBHXCHQCYbX
	vgE5DNPFU8Xlmjkpj3zdP+kQ4SV7v36Yc5lmVxQD9JPzSNfwIzJgatCcy33+px6bLsgX3uw==
X-Gm-Gg: ASbGncuSggrHVb19E0kwNu49Ufz5l65RHrWy0pruRRK2ICxG9uZIUoz92frHcEsEhAJ
	s34tyOKzN71qFMMXanXYvfiZJ3AvkYgaNeqVDgefktynTMc1+Q1NVoPNJ22Sbjf+dPV2pDpFHI3
	P33jw1rQ7vVGDAc73kzIJzv4cB0geHA/ErY6U1fBEueYYn8EO6i0HvIu5WMlum1Li1sgrKvZYIK
	CH2s+uIcwu6BHih43y1VNLew27rBre5snBmrpARwsrfcoOPFYfRq5jJebxrIkFe8st26Zkxc9Ik
	SBsPIDnXKfrjIuur9RmTORGuw3YAMsd6VhmtYgtITFMCw5JduWW9rkZ0zE5JjlQVneZIRfUDpq/
	VW2QZpKEXWbijgc+8qw5qXceynhc=
X-Received: by 2002:a05:6000:2404:b0:3b8:d30c:885f with SMTP id ffacd0b85a97d-3c5dcefe32fmr10599042f8f.53.1756137128985;
        Mon, 25 Aug 2025 08:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXEz5g23IvWuo/ydVi6QeOhq8AK8ymIKqhjfE0JE8EYTvGus+zqYsHwn1w6Z++sXaw7/PNcA==
X-Received: by 2002:a05:6000:2404:b0:3b8:d30c:885f with SMTP id ffacd0b85a97d-3c5dcefe32fmr10599010f8f.53.1756137128539;
        Mon, 25 Aug 2025 08:52:08 -0700 (PDT)
Received: from rh.redhat.com (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm12155436f8f.30.2025.08.25.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:52:08 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH] KVM: selftests: fix irqfd_test on arm64
Date: Mon, 25 Aug 2025 17:52:03 +0200
Message-ID: <20250825155203.71989-1-sebott@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irqfd_test on arm triggers the following assertion:
==== Test Assertion Failure ====
  include/kvm_util.h:527: !ret
  pid=3643 tid=3643 errno=11 - Resource temporarily unavailable
     1  0x00000000004026d7: kvm_irqfd at kvm_util.h:527
     2  0x0000000000402083: main at irqfd_test.c:100
     3  0x0000ffffa5aab587: ?? ??:0
     4  0x0000ffffa5aab65f: ?? ??:0
     5  0x000000000040236f: _start at ??:?
  KVM_IRQFD failed, rc: -1 errno: 11 (Resource temporarily unavailable)

Fix this by setting up a vgic for the vm.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/irqfd_test.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irqfd_test.c b/tools/testing/selftests/kvm/irqfd_test.c
index 7c301b4c7005..f7b8766e9d42 100644
--- a/tools/testing/selftests/kvm/irqfd_test.c
+++ b/tools/testing/selftests/kvm/irqfd_test.c
@@ -8,7 +8,11 @@
 #include <stdint.h>
 #include <sys/sysinfo.h>
 
+#include "processor.h"
 #include "kvm_util.h"
+#ifdef __aarch64__
+#include "vgic.h"
+#endif
 
 static struct kvm_vm *vm1;
 static struct kvm_vm *vm2;
@@ -86,14 +90,30 @@ static void juggle_eventfd_primary(struct kvm_vm *vm, int eventfd)
 	kvm_irqfd(vm, GSI_BASE_PRIMARY + 1, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
 }
 
+static struct kvm_vm *test_vm_create(void)
+{
+#ifdef __aarch64__
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int gic_fd;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	gic_fd = vgic_v3_setup(vm, 1, 64);
+	__TEST_REQUIRE(gic_fd >= 0, "Failed to create vgic-v3");
+
+	return vm;
+#endif
+	return vm_create(1);
+}
+
 int main(int argc, char *argv[])
 {
 	pthread_t racing_thread;
 	int r, i;
 
 	/* Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. */
-	vm1 = vm_create(1);
-	vm2 = vm_create(1);
+	vm1 = test_vm_create();
+	vm2 = test_vm_create();
 
 	WRITE_ONCE(__eventfd, kvm_new_eventfd());
 
-- 
2.51.0


