Return-Path: <linux-kselftest+bounces-29689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9AA6E165
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333AF171D5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461426FA60;
	Mon, 24 Mar 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szaoe19h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F226F465
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837634; cv=none; b=D1LVVGhGiP5iftKgz8HDo4iP/KCKVmkCbReytxbz79bnsOI3tDjfFq4P0czE6Q5esh8EiijQYPmWx9ZTewxG2bLVw58YuAGgSpx8cERnAAX6oMiWj87NTl0mJgXhGJ1QkIn3JBSAS1it01W2Y3jI4hK3rZDPeBAaSLYb1wlmUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837634; c=relaxed/simple;
	bh=t+FBsewtahFrhEqpdQUoxO68mKcKYqQ7X3zySWw12Ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FJjMAZfwx4mRrPHOU/PqhWZ6g0xtpoptdAl/cUGj8AMMJN0u1kH+wZQchFxUBphRXcYlD39XEoAtFA7qwtlys/NZT0ZpS+NtFWB/SnG+7tXZiuNm1aigiLDL3bjg4jpIpJ1neibjnJVO7FmmhyupITi3ZyCt8jKKzd/rA2yZa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szaoe19h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22410b910b0so59013805ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837632; x=1743442432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gKxt/ZFpIcQCUjKHtBsLuH60QpmMdsVsx2I4SxrQ2+c=;
        b=szaoe19hWVLWRI8vGWFz8HFExFqDfUIPNRe37bPvP9hxX1GijvGhTDE/LFE4e4Sn2V
         kP0ovxg/QWPIdHuwNP1sschCLWuDq6lzhu6IcXYqYkIzkW4Up204TFhnfuV4jfFq08t+
         xwjnEpab53w2jwbjkditiV6nC0kgu7Ou8mRmJEQv8lq09GGo5Mkp9cUlfPsHd7hi7Sak
         paRjIZfUwoGExau19pZhm42izPcPRicUzkS2eb3+EFfKf/PCFrfJuVet21nI9ezIiJOv
         ydn7hM6WDCWJdC8CLb7H4jG5vnlxBbfbOEbszn3UJMiNDlegM5QXLJy9IEFNMpdf7JcN
         xBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837632; x=1743442432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKxt/ZFpIcQCUjKHtBsLuH60QpmMdsVsx2I4SxrQ2+c=;
        b=GYCKe+ByPKUnjEZ5hJVGLncnEetJbEx1Ig/lNf/8rlJmmy5eXpnmzos7DCRaMCtDN6
         SMloKp2NB1Y7yUwDjZqPE0AgJ++F7IQP+uxJVbmvV1NbssUNmAzV1KOLDLgd0/eLxw+M
         X1KTk44cbWDC4afpOSlivBsvHAwo3jF5wZf9nCGBd12wPMcbXqaOybNseb9yDaLOswJc
         Imvyc6l87ywxz/qs8y+ZOM6AbRI42wlHFJD2ZRK4m2dl5Y6p8OrZ7g4bN6y9G1vCkns8
         jWTxaBcqpU4r9wV0zhjACv/rOFgx+qRGZ5g3eik3Ou8Wh3bjVGmE3xLBVw191kVyGS+n
         a8AA==
X-Forwarded-Encrypted: i=1; AJvYcCUAIvUPy85BMqF5OTCzbva2d/r/zpWuXdqYCGpVxSfXPgEtP04RfpKZAyPvfuuVeEcpGC0Mi0wbsNbMjOHpvAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThl5ryDd1OIxWX+avY6hwHYYYac5xEk9ds39F4iUrRP7YFiHL
	yCaP7uslTWImySP+o4eY7lwLoJYMaxjoEV02V1jgEu2CUgc+DOojiA1tVFNGNkuOxX3RS6mHLJy
	VC8LdJA==
X-Google-Smtp-Source: AGHT+IHEUGZ9HMGmtkVavziiAMz85RPnL2GSNbJ89iUYw8JW6AOa/3RZtMuAZcKQV1zb8hNT1J6wnY1/R504
X-Received: from plbjg17.prod.google.com ([2002:a17:903:26d1:b0:221:8568:bfe3])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e846:b0:21f:6546:9af0
 with SMTP id d9443c01a7336-22780e5fee3mr212707755ad.44.1742837631950; Mon, 24
 Mar 2025 10:33:51 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:17 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-38-mizhang@google.com>
Subject: [PATCH v4 37/38] KVM: Selftests: Support mediated vPMU for vmx_pmu_caps_test
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Define KVM_ONE_VCPU_PMU_TEST_SUITE macro which calls
vm_create_with_one_vcpu_with_pmu() to create mediated vPMU enabled VM.

Then vmx_pmu_caps_test can supported mediated vPMU's validation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 .../selftests/kvm/include/kvm_test_harness.h        | 13 +++++++++++++
 tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
index 8f7c6858e8e2..4efde79708ce 100644
--- a/tools/testing/selftests/kvm/include/kvm_test_harness.h
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -23,6 +23,19 @@
 		kvm_vm_free(self->vcpu->vm);				\
 	}
 
+#define KVM_ONE_VCPU_PMU_TEST_SUITE(name)					\
+	FIXTURE(name) {								\
+		struct kvm_vcpu *vcpu;						\
+	};									\
+										\
+	FIXTURE_SETUP(name) {							\
+		(void)vm_create_with_one_vcpu_with_pmu(&self->vcpu, NULL);	\
+	}									\
+										\
+	FIXTURE_TEARDOWN(name) {						\
+		kvm_vm_free(self->vcpu->vm);					\
+	}
+
 #define KVM_ONE_VCPU_TEST(suite, test, guestcode)			\
 static void __suite##_##test(struct kvm_vcpu *vcpu);			\
 									\
diff --git a/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
index a1f5ff45d518..d23610131acb 100644
--- a/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
@@ -73,7 +73,7 @@ static void guest_code(uint64_t current_val)
 	GUEST_DONE();
 }
 
-KVM_ONE_VCPU_TEST_SUITE(vmx_pmu_caps);
+KVM_ONE_VCPU_PMU_TEST_SUITE(vmx_pmu_caps);
 
 /*
  * Verify that guest WRMSRs to PERF_CAPABILITIES #GP regardless of the value
-- 
2.49.0.395.g12beb8f557-goog


