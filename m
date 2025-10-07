Return-Path: <linux-kselftest+bounces-42804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C130FBC016E
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E533C2CC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5420C023;
	Tue,  7 Oct 2025 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fK9CsyzM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF891BC41
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807870; cv=none; b=q+8t61+X0cGfuasunHN18X3qRmJwcKUvleUbnI9JAD2yT4QNy8Hbp3lPIjV4CG8pv5ZIcwAQlAKFvYQkATX33KJTlZ+G8aTJR4xYMiJKzn3ufKyy5CZZWFRA7uEzVtk4SSP0sL7xW/v25fO1ODZdFKv8T8a7SZxkKL74fDsFWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807870; c=relaxed/simple;
	bh=/fll/of95rQWwNDdp7em7nO/Y9F6lxz5T9wJPKWVKi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDIOHRrOTOKx81dFpB87kyBqh7rT7oVtu7zhueFbPZc+RotubCC6meJPN6O78odG0QNC5lmQEcnAMy/swerTesR4osRVN4ipjdDKkCBiN0CskInvaWILJjUCUMi/BRw0oPEKFaFTDfaiXNT7f/4py967HnW0vkwneSTMC6L2r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fK9CsyzM; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54b21395093so3880208e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807867; x=1760412667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb2j8N8Az+uWt45nNFfEUmcYJA7/O93dKo/dsaUrS7Y=;
        b=fK9CsyzM/WiXFRmOL9nd20G0NhzsxKur5anC5bQTbNxTeWydxWXaRIBajBezvKsPmm
         PFQm5Nz97r/BTXWpLt+1S8OQ4NH7112W30C4pqVXBJxG+59/HAkHkgy8fDBby6go7HrE
         NclW6CKwV7N27GB+o44uh1TUF87Ut2yaynL9TC1LC59rJWeQ2pM1pg4MVCkYHXhziEcn
         klwR3Udv8t/A3wglxYZaTQuFyDhMubPZqjX0U/LOnuZpdvpSBvIagJP8qFR/w5yibZNi
         9f8zwtKstG5CUj9j3B2Kgw6m2nwETkY6mHlnpaTOQBKgJ9PU1hrN6qUIC6bJUdPyVW9r
         G22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807867; x=1760412667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb2j8N8Az+uWt45nNFfEUmcYJA7/O93dKo/dsaUrS7Y=;
        b=lvJifJWhSCnxlafBY+DAicVqBvCv5YblQLAFuQjNgRe78KdFQfMqeu/wCpc4SryPDF
         HgcWLLNpQMILEolS/WSSE8yUtbpd9EJKdhqWyJE5IoM2ShQKpzruWI/zvO27r5W6WaYt
         fsZsZNtwDwkLq0d/JJWFpumCNHSHoAMn1YWcV1QY4bAyKF3hj3VZeZU2A+j6UI4XVdMg
         +igoCTWoZAC1PYsQr0HUgWZjp0JkWi2kWue6c5+tHhq3NTklpPROO8Md7xdAILrqsTKw
         MUfB4Zo/ygOI8h69eNAdsx+5Ys+jI8YHKgTAnHMypNAJKgFpCJbZCMSp9Lr/7/2mg9ye
         waBw==
X-Forwarded-Encrypted: i=1; AJvYcCX+RhTtMqsTYgNxQWNZmvwg9nRVF+Q4A0aBGBp95XvoIHSeqKfqCYD/PAs2rMU313r2M70Vn0uOqeAH1TusWpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzqfe1Du836v4MF5cB+eaTwRUwpSDdC3nLDAZKnQhGMww52FWa
	1JFqF0cjy+RSojnm1V9ze6aLm9L9TGFvMRRkqECG65Efl1tRdl7IvOOR1jh3D1nYA78=
X-Gm-Gg: ASbGncvs9JHTTM2xOt+u4C4Dt0NemOe8QZPXskCV4ZfBFFg2GQeUj5xnask1+q09VH2
	3ew46Wo3W2a8kNqymV198g6Jm7E3wwOdGpfaixk4RKirOA5/QGJX6OwaokWONmCUq4DlA7M3KlE
	VNdF9A3j04TVVOqCxhLWaaqQkvW0dgG4vE+wgmWtNkvmGB7QH60M3o0e9Kg1Hxp2KQZZ8UneQGX
	fY4ThLBMaF8GvlzPmrenjOD7n5jMsq1gHw4mmBpNQm4FVb+yhmQXJTUhhNmO/3/OMLLpSw8Ctzl
	8IZmPXMSxbsKannnnfyFvlgQ6uhoHY2AaKs6CjIH2AN1NvTYAYxFkwoZwSncnCbuYmldXskzf9D
	1ED7wR87D3E0+u1LAvuUcTbd31puBCBJEUHhqMbXUMudxcZXS/+Wv15ouhxNxVh+smTrs/e0ZTq
	Ko5vsIFJ0M5Hn2nbsVXx58eQr/yExIb5o=
X-Google-Smtp-Source: AGHT+IHKWYvZiwypYwTwT1zKSJgyEU7e/SRkQV11sdxCZs7Hd6H9BMFs3IwoGAGyQxuhUHEh8cuY/A==
X-Received: by 2002:a05:6122:8cd:b0:552:3366:e822 with SMTP id 71dfb90a1353d-554a8d1b310mr1055414e0c.1.1759807867441;
        Mon, 06 Oct 2025 20:31:07 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v5 1/7] kho: allow to drive kho from within kernel
Date: Tue,  7 Oct 2025 03:30:54 +0000
Message-ID: <20251007033100.836886-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to do finalize and abort from kernel modules, so LUO could
drive the KHO sequence via its own state machine.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 15 +++++++
 kernel/kexec_handover.c        | 74 ++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 25042c1d8d54..04d0108db98e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -67,6 +67,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline int kho_finalize(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_abort(void)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..76c34ea923f0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1100,7 +1100,27 @@ static int kho_abort(void)
 	return err;
 }
 
-static int kho_finalize(void)
+int kho_abort(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (!kho_out.finalized)
+		return -ENOENT;
+
+	ret = __kho_abort();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = false;
+
+	return kho_out_update_debugfs_fdt();
+}
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -1143,12 +1163,32 @@ static int kho_finalize(void)
 abort:
 	if (err) {
 		pr_err("Failed to convert KHO state tree: %d\n", err);
-		kho_abort();
+		__kho_abort();
 	}
 
 	return err;
 }
 
+int kho_finalize(void)
+{
+	int ret;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (kho_out.finalized)
+		return -EEXIST;
+
+	ret = __kho_finalize();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = true;
+
+	return kho_out_update_debugfs_fdt();
+}
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
@@ -1160,33 +1200,7 @@ static int kho_out_finalize_get(void *data, u64 *val)
 
 static int kho_out_finalize_set(void *data, u64 _val)
 {
-	int ret = 0;
-	bool val = !!_val;
-
-	mutex_lock(&kho_out.lock);
-
-	if (val == kho_out.finalized) {
-		if (kho_out.finalized)
-			ret = -EEXIST;
-		else
-			ret = -ENOENT;
-		goto unlock;
-	}
-
-	if (val)
-		ret = kho_finalize();
-	else
-		ret = kho_abort();
-
-	if (ret)
-		goto unlock;
-
-	kho_out.finalized = val;
-	ret = kho_out_update_debugfs_fdt();
-
-unlock:
-	mutex_unlock(&kho_out.lock);
-	return ret;
+	return (!!_val) ? kho_finalize() : kho_abort();
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-- 
2.51.0.618.g983fd99d29-goog


