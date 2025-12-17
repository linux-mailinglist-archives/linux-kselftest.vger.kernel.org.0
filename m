Return-Path: <linux-kselftest+bounces-47662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C1CC80D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD06A305122B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34463387B18;
	Wed, 17 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vbekPk2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C6385CD4
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979979; cv=none; b=KYEInlhdVi02EvYvicRDX2Xu5F65dgb6qCaRe5dBHAmJNSZT7TBytk49JPCdQRutU+G1PLYEO9lcf5K+GWM/jRJBLZKHIHMTYZZBG1NHMrz48LumqUxITrkitL4MzZ6Iy/ZuMRYp44i3W1sm2KBVPGnjZBGxmAoW6BTOiykFhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979979; c=relaxed/simple;
	bh=b283TkR/J42estS6ho7KZ9ZW+aNvaWfv0egTJl8++tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zi4EirBHx+qYRNXlOndKBSZLhKXrMq//CXoz2SGSep87H0yYSQfF3m0q07rlr2NPZ5diRLBFn244YeEBVqAJIXUX/jqELTFd+/iv3viilfFUatSSS/9YlpC9e6e7hLw7Gb7u9/Og67PhKKCWE3ywIRpAj8DNL4FHHTu6UuBzIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vbekPk2; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b79f6dcde96so1214651466b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765979976; x=1766584776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+LsWBBeNUqmreZyuEYPO1kEYcqrZnApoVy0IOBA0P0=;
        b=2vbekPk2BosWtOJNIqjLS37QKcsjuFXqUJwKeRxYzvSmqRf0NwYExgBIUMFWxHxhpS
         MuCCU0xvoKRDD+y097kX9tf+COG5kX40MKiPe79EU8SQhoCjS1dzjDi5lSrr5pOLMoKI
         gD8n5ifvkrs/hULSnXGHfkWSBXgfwngf7kTZzXAWSva9ygnoSKGk2xgEaiw9xr/cQuBa
         zLm8401DJQ5Bj6uqFSyZRVveFMLUMCTZJIUYZfKM5q1I5D+C8CWu7Mr+p2PpHSMMb0OT
         mUYtEPBPeeJ0rj70fBydVYXnWZVGNMuMreYDHi5lRaQV3YRUjkb9o1wc1jLhHG/tmCNf
         z+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979976; x=1766584776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+LsWBBeNUqmreZyuEYPO1kEYcqrZnApoVy0IOBA0P0=;
        b=qwR1KPHvgOE9gRQX+9dE4rTJ+jvxj2Hy2Y23K4WkHUO1FioY93618AiY0fYC21JwoN
         iJBhPc+mHG90p0eixHmbMg1unL+7xo3txsos5anvSPtzRpscC0dHLJR57FQK3pZlzC43
         pv2H9aQuVkjp9zH58OfxFNXNo4YteUN2y8HDxxXUYgWtSvXELYg4j4NlAhPFzdtafBmz
         IsWkFa0jBVYqAuX3JfAlY04ltttjLMFQeRKVo/UPkmZuZbdKaVpdp9jGMfxtxQHX+Gx7
         HwVvQPLm2WqkzjUYyzc5RRFyeL3qMbmZSn6ZBjvmpf+5UsV6nrRdQ3yQXfPBZMX5VA2W
         xkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjGAu0x+liUesWVe4g4vP0AJ0cRYE0JBXllyf/ZxUPg1tF/H9PElPVAbYv2q2+JmTVTq7Lmb7lxph4OsQZOeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXBycTjkOy4X9RxempaNBpao1tRGS6M8GvvyMuTGBdF/pLrjB
	W2FWpDxq5ZyKApoZHeo2TL2xcYtPep0dSp2Q6j1QtT48n+IStHX6jD2tJbxp2NjeMZqtxvKG4Jt
	xK6/6Hw==
X-Google-Smtp-Source: AGHT+IGKBO6JKE4toaVcqBpAVaGVwBpONJILCsccvce/1Uqiqm/5D3qAdkQRLYMqmO/mif3P7qmCQWnTcZ4=
X-Received: from ejbdx22.prod.google.com ([2002:a17:906:a856:b0:b7a:6f04:dfab])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fc8:b0:b79:f8f7:38ea
 with SMTP id a640c23a62f3a-b7d23c5bccfmr1848250466b.45.1765979975773; Wed, 17
 Dec 2025 05:59:35 -0800 (PST)
Date: Wed, 17 Dec 2025 13:59:31 +0000
In-Reply-To: <20251217135932.3153847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217135932.3153847-1-srosek@google.com>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217135932.3153847-2-srosek@google.com>
Subject: [PATCH v1 1/2] selftests/x86/ldt_gdt: Skip int80 if not supported
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
disabled by default or disabled at runtime. The x86/ldt_gdt selftest
crashes for all of above thus is_32bit_syscall_supported() helper
is added to skip int80 syscalls if they are not supported.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 tools/testing/selftests/x86/ldt_gdt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index bb99a71380a5..b178392e50c0 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -62,6 +62,18 @@ static struct user_desc *low_user_desc;
 static struct user_desc *low_user_desc_clear;  /* Use to delete GDT entry */
 static int gdt_entry_num;
 
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
 static void check_invalid_segment(uint16_t index, int ldt)
 {
 	uint32_t has_limit = 0, has_ar = 0, limit, ar;
@@ -147,6 +159,7 @@ static bool install_valid_mode(const struct user_desc *d, uint32_t ar,
 	if (!ldt) {
 #ifndef __i386__
 		/* No point testing set_thread_area in a 64-bit build */
+		printf("[SKIP]\tNo point testing set_thread_area in a 64-bit build\n");
 		return false;
 #endif
 		if (!gdt_entry_num)
@@ -676,6 +689,10 @@ static void setup_counter_page(void)
 static int invoke_set_thread_area(void)
 {
 	int ret;
+	if (!is_32bit_syscall_supported()) {
+		printf("[SKIP]\tNo 32bit syscall support in a 64-bit build\n");
+		return -1;
+	}
 	asm volatile ("int $0x80"
 		      : "=a" (ret), "+m" (low_user_desc) :
 			"a" (243), "b" (low_user_desc)
@@ -716,8 +733,10 @@ static void setup_low_user_desc(void)
 
 static void test_gdt_invalidation(void)
 {
-	if (!gdt_entry_num)
+	if (!gdt_entry_num) {
+		printf("[SKIP]\tNo set_thread_area support in a 64-bit only system\n");
 		return;	/* 64-bit only system -- we can't use set_thread_area */
+	}
 
 	unsigned short prev_sel;
 	unsigned short sel;
-- 
2.52.0.305.g3fc767764a-goog


