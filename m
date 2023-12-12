Return-Path: <linux-kselftest+bounces-1730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFA80F827
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7391F217F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373864CD1;
	Tue, 12 Dec 2023 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ul1VeDvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD232107
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:09 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2866c800dd5so7176786a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414029; x=1703018829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=63FW+3XX5/e8zea7VCMPF1eNiMssQ00z9r2TQiyi8pA=;
        b=Ul1VeDvOG29+3NaboalKn8wNCYf/SOUXpqzZMGFnU0u+2yxU+sLOEyeWB7DBUUa0BS
         yKca9l7GWJK9r063xZuCjVhTuWGg9cin4PH18VIGlwk4uLX5+qmDc/4TuGsFJRyij74+
         ymtR9n9p5abNttRhZJzaK1BBGErV19VYDfpjR49ECM97b3uTuGedgjzlY/T0+/OoR17k
         cSoxWjvGen9Zky/FnIZw14ty5OQETCWq16UqgOpDdRtMIl+4uDOk6BOWcMD6e8zmLeSM
         BA67mBHRfiJaSZg5Shef9zW8ghIC4ab+N5ZBjJ2m5S8FQMuslSMLfLri6+lznSxGbC+S
         3sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414029; x=1703018829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63FW+3XX5/e8zea7VCMPF1eNiMssQ00z9r2TQiyi8pA=;
        b=q6CmSW11b71sqZ9pYwkKAS7mr3twmzFdXlKb29xjo2pa47etYHRg7J5mkFHN0Jl7tf
         h61/At8wlQlcQaEnQdYqcXIxMzLuDjZOsCiM9qu7v1d+IdqNZfpiUE/HiwTeDKfqBQpH
         SEPa4o/jZhPJv70Cdi/q6WsXUc0fPcCslLwjWRkpZlz9DJspRyeZJ5wYWAOfozkqBDh3
         YiByhYsqrBKP40hCGtgi9Y7dXEo++0dKhHxxbomOjYnnP5w8Ooqfflpz2zDsKCLDTvSu
         3elwSoJgZ+8lwpN/yXYWAcYLCW7KdgfMTyrqANXZzTVYf/7gGjgX4iNCkFN1rfCbb7mx
         5eIQ==
X-Gm-Message-State: AOJu0YytW19uUzS5JuKSqy4FhkLeFVLbvyu7Tf4ohwbsv1ikVdY3ZPZe
	TaakP2ToyKMpEZb8LXm8RRtsaesSUV5YPiOxY/IdigfALFGnd3ZT9rqz4Kf1BvTP5yNzZHSpcUW
	mxk9Kx/6JV2416v9DB2p1vvjJNtvAKMIGqHgwxsYzVf6ONyb6oANSKL7oTP4kW2DJQSZHsgM=
X-Google-Smtp-Source: AGHT+IH6ncVDoAW1Mu0I8+yN+N2a6MAdsdDn6tV65AJTStVCqp2NOxk5JgLw7Qu1wnmKPp61ATAwmDH9Kg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:e74e:b0:1d0:820a:cf0d with SMTP id
 p14-20020a170902e74e00b001d0820acf0dmr51718plf.6.1702414028261; Tue, 12 Dec
 2023 12:47:08 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:21 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-7-sagis@google.com>
Subject: [RFC PATCH v5 06/29] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 69 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index 9b69c733ce01..6b995c3f6153 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -27,10 +27,9 @@ static char *tdx_cmd_str[] = {
 };
 #define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
 
-static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+static int _tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 {
 	struct kvm_tdx_cmd tdx_cmd;
-	int r;
 
 	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
 		    ioctl_no);
@@ -40,11 +39,58 @@ static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 	tdx_cmd.flags = flags;
 	tdx_cmd.data = (uint64_t)data;
 
-	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+}
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	int r;
+
+	r = _tdx_ioctl(fd, ioctl_no, flags, data);
 	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
 		    errno);
 }
 
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	int i;
+	int rc = -1;
+	int nr_cpuid_configs = 4;
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(
+			tdx_cap, sizeof(*tdx_cap) +
+			nr_cpuid_configs * sizeof(*tdx_cap->cpuid_configs));
+		TEST_ASSERT(tdx_cap != NULL,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->nr_cpuid_configs = nr_cpuid_configs;
+		rc = _tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: attrs: fixed0 0x%016llx fixed1 0x%016llx\n"
+		 "tdx_cap: xfam fixed0 0x%016llx fixed1 0x%016llx\n",
+		 tdx_cap->attrs_fixed0, tdx_cap->attrs_fixed1,
+		 tdx_cap->xfam_fixed0, tdx_cap->xfam_fixed1);
+
+	for (i = 0; i < tdx_cap->nr_cpuid_configs; i++) {
+		const struct kvm_tdx_cpuid_config *config =
+			&tdx_cap->cpuid_configs[i];
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->leaf, config->sub_leaf,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
 #define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
 
 static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
@@ -78,6 +124,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
 	}
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* TDX spec: any bits 0 in attrs_fixed0 must be 0 in attributes */
+	TEST_ASSERT_EQ(attributes & ~tdx_cap->attrs_fixed0, 0);
+
+	/* TDX spec: any bits 1 in attrs_fixed1 must be 1 in attributes */
+	TEST_ASSERT_EQ(attributes & tdx_cap->attrs_fixed1, tdx_cap->attrs_fixed1);
+
+	free(tdx_cap);
+}
+
 static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 {
 	const struct kvm_cpuid2 *cpuid;
@@ -91,6 +152,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 	memset(init_vm, 0, sizeof(*init_vm));
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
-- 
2.43.0.472.g3155946c3a-goog


