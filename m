Return-Path: <linux-kselftest+bounces-28000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E526A4B774
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497A216C394
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BB1E9B1B;
	Mon,  3 Mar 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lowmE10z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468051E9B18
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978584; cv=none; b=MNvOq15Yp04vHyCrbhttTrPISl6Tv65BdLX1VBAOKv/0l8xFO7rJ3+OM8M3OdACxkOQkjIJKBhIbglGMbNojXiceoQ5f3btjij5BbtzaoyB4aaU9DUsSaMarNSrROQUEKONS1SWEWGTOWyKGiPt6ebwjJusE8Iqyh/7K1YbF6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978584; c=relaxed/simple;
	bh=6u+r0ovtm0jW5YjCvNxc1YcxBTXJYiyjcM76RIX7sIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpsJB8Y71Ny/vuNUQtkiDjdLoSdLetIo+27obmtR2F/d+5l+lc9Ns6uiZZFZcQbEFTAV8Bw58KMre31+r4XNZup/8Z8Cj36lqLy5MTUwoqYUlU8zFMb+IcHrsfzeTVg2ssxXt7e8vbi3GRMSjxB0YyjzhQCdKIXKC5SGgQQaxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lowmE10z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so393744a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978581; x=1741583381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnEHm8Q2R+qf55+zK9cHcOTX+1u/tw9AcohnyzHuWzM=;
        b=lowmE10zZjRfpjgY3yGz7s+cYg8TFDsROAvSHdr4FSL0TMnxo+7fLlN7LfOg3KTeHp
         uDaqA7GYdtJ7Dru+DB+S44hOsYpD3uDzur1TrWH55Jw+bJgOYuUAIFFz2nksHr9vqSZC
         w6obBXbSKu0yqELGxxSV3UCz6MU6ndk3/EO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978581; x=1741583381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnEHm8Q2R+qf55+zK9cHcOTX+1u/tw9AcohnyzHuWzM=;
        b=iWbp9+7mjLRNVHWDE0yeT6MkpcG+oSWtwCupynC09305wiYk4eYDqHvEOBLwDsPOgs
         lpdLbK6AqP1dXIZJxmL/X15qEPYTFYZ6U/fG5bpCpjbiTLNh5Y1Zyt4uIw0/uO8HsoxU
         uZGIA+O+vnrZT+Zsi8wPOCiVtSmQ5pMzEaa0TStEQqHvpdR6Kxf4Wr4fenr1Ocb6njfE
         71Nj+DAlFQexy0VyBimjOWRPxXlbG5/v2WW+VVWhwQT3bNCVqkyB8ssO6RqqBpRLQY8D
         Om+6ZDR/c8rxoH4ZsyIxtLaZElHtNXjpnwLvESKzA+NK8BnfCKy6m2g9pSqpP09HtVTQ
         +jpA==
X-Forwarded-Encrypted: i=1; AJvYcCVv40xYF3OgWkRqZFSFXrkih9XPZv6+QJKdMWUBkcjLAWRWzDE8EwdirfEkWbmmrGiXkiu9su8Z21cbAWjNxco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAwYl7FM9IBESlmFyMPW0m48nOX7LofPRSqVTB1m6vuikoGXH
	kuEuKiFjFYWlXJJ3kO7SfTlN5BgKIw/IjPjCjsVZAqoh7E3WBVLvS4ZY1oCtUQ==
X-Gm-Gg: ASbGncsBWIJWgluVph6hByUFZZkyX6ZFa5o8DVxqxkO1766BJEUKyG3Hp2n7c0OxeTG
	tq/rd5ep/NwiPjl1vh/pfkH75oz5LzvdmOcfztZ4Vw50Hmm48T60KXNLFHMyAslWZCLKid18gW5
	JmaWkPvd7zHls1uxXtEUzoCuoLHAbeMuboLXhdNyCX7Q8scxkj/LBXmOpE6aJ35ebWAllPbVAyA
	gWQffxy6yMhBDr+MWQzBMeYCo4K9CqFOSzlPrkzpD0azwWqxMOoRV4KMKOoiZ3DxaV6e8BQa6Vo
	0QW+i+c0HL1PsLlz8/aC1PUtOhVfb7f1haHXtYEmIQidaV4pfhC4EIqc4zPSdqQrkUOwcesCA+9
	/
X-Google-Smtp-Source: AGHT+IGr7aLO58G4GmFia0KH79zY4iYQWcKqxIsMg7qlBQCpzajCy2mPKds0czrD1eMZhOSnlodKgg==
X-Received: by 2002:a05:6402:2550:b0:5e0:82a0:50b6 with SMTP id 4fb4d7f45d1cf-5e4d6b57020mr4945161a12.6.1740978580628;
        Sun, 02 Mar 2025 21:09:40 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:39 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v8 6/7] mseal sysmap: update mseal.rst
Date: Mon,  3 Mar 2025 05:09:20 +0000
Message-ID: <20250303050921.3033083-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Documentation/userspace-api/mseal.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..76e10938302a 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,26 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  The system mappings are created by the kernel and includes vdso, vvar,
+  vvar_vclock, vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
+
+  Those system mappings are readonly only or execute only, memory sealing can
+  protect them from ever changing to writable or unmmap/remapped as different
+  attributes. This is useful to mitigate memory corruption issues where a
+  corrupted pointer is passed to a memory management system.
+
+  If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
+  architecture.
+
+  The following architectures currently support this feature: x86-64 and arm64.
+
+  WARNING: This feature breaks programs which rely on relocating
+  or unmapping system mappings. Known broken software at the time
+  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+  this config can't be enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.711.g2feabab25a-goog


