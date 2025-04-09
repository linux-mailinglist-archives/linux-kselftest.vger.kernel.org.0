Return-Path: <linux-kselftest+bounces-30413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1418FA826C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753B43AA0D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB625E836;
	Wed,  9 Apr 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeSqpKCy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FD172767;
	Wed,  9 Apr 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206833; cv=none; b=tHl1VO1Gtm0+YlhK9uMIFEoqcxX0W4Vf5FXHzD5lGp3qC9Op4hZvT61Tc7g8X5+1S6WbYJ63QtIX1mAzZTzxDtz+i1WRaEU9V0HzNeb8KUnZ5VhUvUDW9w3badLGZq8KWJR9zMofLMAP/1OpuPRWNs+720JSCxTNpX4O2/Vf/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206833; c=relaxed/simple;
	bh=VvSiDUAiwgB4XqDAXPRunK7EgXcqQUjeMPsiC8XGV3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpDyGgSHsd1es5nrkAYJHpKJqRtlHpr/wp+hYnJXFK5abNU2hO3WJzre0H50vsuWgMIdJ1PHhlR9WGDEwNzU5sDLlcURA6iEK+L/oMcOVY+Utxs9dozGDp+2swASexlPF+wDsy9bOmLSvR+7atw2Nh8Unvcgb9rETCZ6aT19SSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeSqpKCy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso70217465ad.3;
        Wed, 09 Apr 2025 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206831; x=1744811631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXYmIewHBQZHKjz0TG7FwEVxtA+dONvTtnb2TiEKr9I=;
        b=jeSqpKCyUXqBa0KEAE64fn9QmTsob/ZEOheFw6ZzRuti9jZhJpoaumooOlplwXq5UY
         HOfzOahKGcI2H7aHBT800NdjZ5Gda8EyYGg6hzvH6Z93FaUN/SjTZqCCH9yASZM3Epow
         v63T+pvrkPFV1ja6mz35ljLeb1Db0EDDTofhvFVW2kln+XFynMKi4dmFyvi7FmwEPXOU
         E98QWFMcnqTTiwMGSv3WR+apI4c1HY5YU0eafUMqdSWStMAI0u+VTNoB++dTj3aua+W1
         1e/+e4iSeA4swQEtTPx6omnFwisodOIpfpSx6dgDUaLI/3crbcGTIKPYjkOHFhYAavcS
         j2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206831; x=1744811631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXYmIewHBQZHKjz0TG7FwEVxtA+dONvTtnb2TiEKr9I=;
        b=bLKlt/WgK6UZmn9qcxwCqsFiGJvJ5bHX0PcQXWFaneDXmhxyfe+rG2T662qSIOOqpq
         QMsTxHvC5ZrROqLecg1bMWBAmCUzwebm+4BjleBy/nh0BQnTnZPoOXW+rHAqmVimkr6o
         06i0yH/dZgZjH6TYHttf/GHkF45PIrfYHf+3K5WyOQ1fN6v1q5Tp2ILKOebTQVixuYC1
         qxK2ZQSx+nQAgRbFMy38M6Bne//d+Ue6tAT84Sl9O8D4w0uM3Egza2z/hFxR9IEJRl1g
         RHnk5Wrj9yKsWKnczmcz95l7T0H+VJKMpZyqlSJV/evzQ2ZxX9xGZFVcQwdWw7DnTx7e
         j2xg==
X-Forwarded-Encrypted: i=1; AJvYcCUNaDs0y9bs2aPwETZkvkDbTZsRCRO0e6s62ZjG7/1Y23RqsJIf8ZodG+twyNWQifVfwyHhiwA3M2jEVeSnAkGc@vger.kernel.org, AJvYcCXnKlSTp4TVE0xKXAsy0OpivyPUnS/tBAMxclUb0C2YGB2S3UReWzEZTNITxtghFKPwPAYFl/7nfvxzG44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtMcR7jSCprezP4Pqjn8v0erMnhElVmYfQIWu7Cff/P9ZcnNk
	Rbtr1ftd2TJ0kKLPDFu4QmaZsWwXnX5qFAVCa8T3CvVvqxzsSXQW
X-Gm-Gg: ASbGncs/lyHPUCm0H6YVCSRPL2U5xcDdXztefZxJ6+WGjKhuRiUO8RpXL8sEanmaLlI
	lqUnlygZqPysQXolIB8bytPggUq75lak7O8piv6F2zoW4HvYfedAviVdMiAkLI782q/5ZcQg3Ol
	uIdmdDSiDDdnH3BvFFLbpERp7J8KPwl8ZcJrjXPIZlpvMG4078lzt3JDQbaPoFz0yYvnjXB7Buy
	TJ6iUArO2RPDzHufVwyTGLiUFR8NieobtmzHpoI5p6bev9GbjY2AC7agwQt0y3yZZR0/o/d2+Xx
	Lc5zQ7of3HL3mPM+KCarqTW+u2wetW3iM2x9Vdf3C/NbnCT48oB9nSBYjEVuVEWJ4LQRNlgPmKm
	c0weWXw75gmogB9tEGjkZKd0=
X-Google-Smtp-Source: AGHT+IFPIJX376JBLYKWCutXbXeV2+24Pg77r5/57Ico+fCcKK5FSAt/gRjZUndiM8xAT6rQSA2uKA==
X-Received: by 2002:a17:903:124c:b0:224:1781:a950 with SMTP id d9443c01a7336-22ac29916demr44398175ad.14.1744206830738;
        Wed, 09 Apr 2025 06:53:50 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb531csm11798545ad.185.2025.04.09.06.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:53:50 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: mingo@kernel.org
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4] selftests/x86/lam: fix resource leak in do_uring() and allocate_dsa_pasid()
Date: Wed,  9 Apr 2025 19:23:37 +0530
Message-ID: <20250409135341.28987-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_WDEJdIFLLCpZ-2@gmail.com>
References: <Z_WDEJdIFLLCpZ-2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves resource leaks reported by cppcheck in lam.c.
Specifically, the 'file_fd' and 'fd' were not closed in do_uring()
and allocate_dsa_pasid() functions, respectively.

cppcheck output before this patch:
tools/testing/selftests/x86/lam.c:685:3: error: Resource leak: file_fd [resourceLeak]
tools/testing/selftests/x86/lam.c:693:3: error: Resource leak: file_fd [resourceLeak]
tools/testing/selftests/x86/lam.c:1195:2: error: Resource leak: fd [resourceLeak]

cppcheck output after this patch:
No resource leaks found

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 18d736640ece..0873b0e5f48b 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -682,7 +682,7 @@ int do_uring(unsigned long lam)
 		return 1;
 
 	if (fstat(file_fd, &st) < 0)
-		return 1;
+		goto cleanup;
 
 	off_t file_sz = st.st_size;
 
@@ -690,7 +690,7 @@ int do_uring(unsigned long lam)
 
 	fi = malloc(sizeof(*fi) + sizeof(struct iovec) * blocks);
 	if (!fi)
-		return 1;
+		goto cleanup;
 
 	fi->file_sz = file_sz;
 	fi->file_fd = file_fd;
@@ -698,7 +698,7 @@ int do_uring(unsigned long lam)
 	ring = malloc(sizeof(*ring));
 	if (!ring) {
 		free(fi);
-		return 1;
+		goto cleanup;
 	}
 
 	memset(ring, 0, sizeof(struct io_ring));
@@ -729,6 +729,8 @@ int do_uring(unsigned long lam)
 	}
 
 	free(fi);
+cleanup:
+	close(file_fd);
 
 	return ret;
 }
@@ -1189,6 +1191,7 @@ void *allocate_dsa_pasid(void)
 
 	wq = mmap(NULL, 0x1000, PROT_WRITE,
 			   MAP_SHARED | MAP_POPULATE, fd, 0);
+	close(fd);
 	if (wq == MAP_FAILED)
 		perror("mmap");
 
-- 
2.43.0


