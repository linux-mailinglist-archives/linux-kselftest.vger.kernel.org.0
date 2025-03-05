Return-Path: <linux-kselftest+bounces-28268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CBA4F48A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40424188FF59
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9636170A13;
	Wed,  5 Mar 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AfJDiRoO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7607151985
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141046; cv=none; b=TL6BTpwu36H4SIDs3KD0cDXpVzLPtycU0aE8Jrtn/WjIKaexpGCyXj3H9QLaBl5ZsM946emDwftwYs2gJuMjchQVY6oDA9+OQ/usV5xsW9s2zOvjKQ243/7olC20nkqIk2aL+FgLWSSHDwOH7qkP7AkRChEOFECsqvN5QTAvu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141046; c=relaxed/simple;
	bh=WkYih5t6WQKzC8SRX+eOO5zI9Mi24DV+jfAcAFV75MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocjlRTbrr8lIToe4927g/ijAEhxN5YmkKjngB2NLbafZkxjICkZnEELPUhMSPE2P7QNHq228IxhivUN9tLajO34gtRpNm+z6w5fofvckv4VzHjSSuuCby8ytnS8PShZyoYsYpyFmTGkmZ001oXxQJzp6uDALbWfWGzsZyQx5uLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AfJDiRoO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7dd005cb0so110546766b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141043; x=1741745843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jha9BeMcP/SA8VECG4X9DDtpBo8dKz3YZuDo79u+NoA=;
        b=AfJDiRoOsd3ep55dVYZoCJpcULd7b4yLl7/lmXiIdGZFezcWwYH+EuMQxMP1OJvloP
         SpzCZYx7DyKiBz2C1qZlTDfC6WWGwPRVQIjkuHJhVy+NaXYj9PxisenjXbpS1VXLCyMZ
         IDReA9pOqG5uYwXtwULDgrhb4hwTm6hMV0C+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141043; x=1741745843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jha9BeMcP/SA8VECG4X9DDtpBo8dKz3YZuDo79u+NoA=;
        b=tp4A11Qy7EP6xuLUeCHhqbRnjPLq7vyYOYiZ5DTvekz1CgxJstX+byf2EZWTrh0h/h
         tl7zliVLgpE3m0+anF27Z+CnefOTOvZ7t/8NKsbz3e16R4oi/4AvChd8ssAnpliVaVTO
         B4EHiYNZ3fbzP0LPOx/HnanTmDKvgqFOB9GaRSG+YweuNTWDzuqIO5dqmeyEU5n/E7xq
         j57kC3pawKIZLL7vTWJFBETGWvpBLPqktYUKOJYZmRQhGXapFkm2QSBeweI8/GgMDzNT
         R4XIVJKTNZFvg/8/n/ygoAEe6pg1AQBzT9Y/XQY7VaIm/4S2zDXts0vMsVxU/dNb0OYb
         R9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCzFo2C0KN7NMy7vi1rW9d3AM+eLFxbDkqie9Fxhy8E5XmyOAPBHLmQOqX62Vgn1JSlcGzXNdDkUyoddxDM5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2drTYqJS+EcwJLcgpcOyulKF/UdK39eHjEa7aZJ3Z4I45Qjv
	Dkwsme3+FKeGkkovMKZ3Gbu9yQAYzaCJ+LKzFKDuZMMkTL+WYJz8liX5qn/1oQ==
X-Gm-Gg: ASbGncs7JguHm3j2iCBb1g/Fifu0+jEXQkSYZ8yTCu/sgx4/EWgyV3EkgbCWfhzIZoV
	0sA07PfSXA18YPsHLqaWQpmy8VwAbFcb2ybQPOBnnN4iho6jUaajOAwoDZBCuvyQOOCDkXIqpu1
	urEnxC1d5weqd9Zx1DwZBx0gkxXGLTLGXB7CqOKuKlj4ZCPAGIyI77ou2mi9agNzYX/k3m3FGqd
	MWNa39+EIjBfHPhVLhv6tVfWlL+EIEVqBjSXHIAh3/+OLI6scfQu+/KrXI4knm/SRHnt1rsyg4N
	SEpjKfn/A9BOCyzkVBnE41kUT7GOabtULQd3q7llLDhpmwaqjdQ4NR6mXCj94REfy70PHWzZH2O
	G
X-Google-Smtp-Source: AGHT+IHAY/NTcScvmVs2xXOeM1Ij1O2NDVu041npSdSjcuYalt0YFoSHHFOL4tb05WaRr9KzRw08ZQ==
X-Received: by 2002:a05:6402:35d2:b0:5e0:36fa:ac1e with SMTP id 4fb4d7f45d1cf-5e59f4717ebmr416274a12.6.1741141043123;
        Tue, 04 Mar 2025 18:17:23 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:21 -0800 (PST)
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
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v9 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Wed,  5 Mar 2025 02:17:06 +0000
Message-ID: <20250305021711.3867874-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add code to detect if the vdso is memory sealed, skip the test
if it is.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..94bee6e0c813 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <sys/mman.h>
 #include <sys/auxv.h>
@@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 
 }
 
+#define VDSO_NAME "[vdso]"
+#define VMFLAGS "VmFlags:"
+#define MSEAL_FLAGS "sl"
+#define MAX_LINE_LEN 512
+
+bool vdso_sealed(FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+	bool has_vdso = false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, VDSO_NAME))
+			has_vdso = true;
+
+		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
+			if (strstr(line, MSEAL_FLAGS))
+				return true;
+
+			return false;
+		}
+	}
+
+	return false;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	pid_t child;
+	FILE *maps;
 
 	ksft_print_header();
 	ksft_set_plan(1);
 
+	maps = fopen("/proc/self/smaps", "r");
+	if (!maps) {
+		ksft_test_result_skip(
+			"Could not open /proc/self/smaps, errno=%d\n",
+			 errno);
+
+		return 0;
+	}
+
+	if (vdso_sealed(maps)) {
+		ksft_test_result_skip("vdso is sealed\n");
+		return 0;
+	}
+
+	fclose(maps);
+
 	child = fork();
 	if (child == -1)
 		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
-- 
2.48.1.711.g2feabab25a-goog


