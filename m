Return-Path: <linux-kselftest+bounces-47664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B04CC80DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1766130674DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF0B387B20;
	Wed, 17 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpvShJaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9B387B13
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979979; cv=none; b=j8e5lLFn3cof9GTKQea4xiQP7/8sOf01KhXhmivl7a7j+QToDqm5gyxGDkxSdDNM/FU+lEpAsO9XY8rDGXNk0yWMtWKgdZ8ONiZREMkYftuY2enuQXl18m9HvJFEBJEDNq/aB9xQ07d9yR7WFTGWCzJpBzA2BG8NF/zpoZOysRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979979; c=relaxed/simple;
	bh=Xj9l/yM0SPbMt3SAV36FAlRh5ZJtA05cSb4NwKf4QhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u3O1hUvdyGj95SDIi3W0GsVXHrzN6ogT8Suwn6im7hZJid83eRRIVyb9opXzFqxTKosOTd2UGz10eLOfGvbyVQ5e+QxChY8t9wzluHmuGVGKB3usEENeosNmnRv7q/gcS0aNxJ+lAhfO5oALwFQH0zBiDzyIzGqs9NFirq0R1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpvShJaR; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b801784f406so49879966b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765979976; x=1766584776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2o53ko9UhCUjsjdchPJi5HhbLy/7+eH3xO+hHSEUhFk=;
        b=WpvShJaR7ZiqkJsZy/v3pQPmEVrys18TBvNFXfhltIHQt9J3MQIFr7fRqEyxHq6cjJ
         XHjJsr77T3w//x2yzWprwHwvt3ulBTvhGH4sSVy0j450pP2Ck9uvYAaqohfpnlfAOH5e
         fXKjsGk0X9VxNn5yX3E5VsUqawvrgoLv32LTma2FA2gqMffi1cxTWlz+V3F2WJiqXJuc
         wjjfak5o2/xPCe4wtukt7+wJoqA4+gLFZqaRrPG6mNZhXzaa/BqG7EdDp2WjVQHqirpf
         jk9T5+jH1SXWQaPaq2W98SSb4kvNTaE/f0fMkvHAmPUYSag56quru207XYEEeuPo9Zis
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979976; x=1766584776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2o53ko9UhCUjsjdchPJi5HhbLy/7+eH3xO+hHSEUhFk=;
        b=ArXZ6LKqqySMfKMGM5d5l4o0sJqvzqappVFjj+UIhm0LoOWmkvOdz7w4Vo/8J2mh7h
         fWgcGtWLaT8Nqpw8bbUz0eKUsHkPpZOO0G6WyQ/UnA9plEo2S6R+NH5+ApYWak4Q7cQL
         RBfdtwhgvwi/vFAXBmos41XE6oAi8AdpF7ZPOjfe020g3w7V5ofIL1abqvYCAhx2OI4S
         iC1HN2wopkUwNL/BYD2w7AixH1t3B5xo10+7TAXSUx0/i3lTp2aHj3Ydx2MHtC7HTp6b
         hf8Ty1pQOF+WEx3BHB517Hcet0QnPbdL5dSN104k6Seyde/ZP1wJBb/NOWfitjUo4P41
         Xq5A==
X-Forwarded-Encrypted: i=1; AJvYcCWxKehmHsWjSnsZ95i76rmWIDoaHnTD18x7+DbOHF1eLUcnTalu5AGFltTp0a83t9lUPOo5nBHUST1x2ZuRMJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSeZ8DaV0ljLrLEkRmhBKiuoynABzT8slBm6Niu+/EWmaPEX/
	x0xzPvuhPwbw48f9vLP9x0ximkzhJElvSIIIMlymHlBlPmQdq0b2lwgUDfVHmynooS/CL1gmsno
	U/Xkwqg==
X-Google-Smtp-Source: AGHT+IF1D3f84URlN255U5s63r+lnRQRT/GFNWLV/C+KzdLYEv+siEvCdtxjHeFTUkCC4hxFx+hjgFSuB38=
X-Received: from ejcsk11.prod.google.com ([2002:a17:906:630b:b0:b7d:3810:9533])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2d11:b0:b73:70db:49ab
 with SMTP id a640c23a62f3a-b7d237743f2mr1742928466b.35.1765979976616; Wed, 17
 Dec 2025 05:59:36 -0800 (PST)
Date: Wed, 17 Dec 2025 13:59:32 +0000
In-Reply-To: <20251217135932.3153847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217135932.3153847-1-srosek@google.com>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217135932.3153847-3-srosek@google.com>
Subject: [PATCH v1 2/2] selftests/x86/ptrace_syscall: Skip int80 if not supported
From: Slawomir Rosek <srosek@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: Betty Zhou <bettyzhou@google.com>, Wake Liu <wakel@google.com>, 
	Kazuhiro Inaba <kinaba@google.com>, Jeff Xu <jeffxu@google.com>, 
	Alistair Delva <adelva@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The IA32 Emulation support can be either removed from the kernel,
disabled by default or disabled at runtime. The x86/ptrace_syscall
selftest crashes for all of above thus is_32bit_syscall_supported()
helper is added to skip int80 syscalls if they are not supported.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 360ec88d5432..6c19bea485c6 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -51,6 +51,18 @@ extern void sys32_helper(struct syscall_args32 *, void *);
 extern void int80_and_ret(void);
 #endif
 
+static bool is_32bit_syscall_supported(void)
+{
+#ifdef __x86_64__
+	return system("((zcat /proc/config.gz | grep CONFIG_IA32_EMULATION=y) &&"
+		"((test -z $(zcat /proc/config.gz | grep CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y)) || (grep ia32_emulation=true /proc/cmdline)) &&"
+		"(test -z $(grep ia32_emulation=false /proc/cmdline))) >/dev/null 2>&1"
+	) == 0;
+#else
+	return true;
+#endif
+}
+
 /*
  * Helper to invoke int80 with controlled regs and capture the final regs.
  */
@@ -389,8 +401,12 @@ static void test_restart_under_ptrace(void)
 
 int main()
 {
-	printf("[RUN]\tCheck int80 return regs\n");
-	test_sys32_regs(do_full_int80);
+	if (is_32bit_syscall_supported()) {
+		printf("[RUN]\tCheck int80 return regs\n");
+		test_sys32_regs(do_full_int80);
+	} else {
+		printf("[SKIP]\t32bit syscall support is not available\n");
+	}
 
 #if defined(__i386__) && (!defined(__GLIBC__) || __GLIBC__ > 2 || __GLIBC_MINOR__ >= 16)
 	vsyscall32 = (void *)getauxval(AT_SYSINFO);
-- 
2.52.0.305.g3fc767764a-goog


