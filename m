Return-Path: <linux-kselftest+bounces-28632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED46A5995B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407133AAEE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFF22D4F4;
	Mon, 10 Mar 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BdT1BFky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E322D4C5
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619586; cv=none; b=TCndcDih6wTrBJ4kkqK1kjCFZZYdrzipZRLpTeLNYRiJZJBBDt4FRx+UkHgjoabgATQ7ERgBvS23iR7Y53VwxXlHZYmPIqKOJyV1bEyhsPn2DM/pAxhBS+HhDWEyhHSpsLBtoIiQaq56SLtBBxfeYevLpVX2qQyYmYoO8BWmf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619586; c=relaxed/simple;
	bh=VIx0VINPP1Q8PAskPT4Er6jvEXpGjGjvKjx+kWo9Xuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iu7iDJEZ90ZfY0FPgdSV2ClPFd3vxyEPRNyov8sMxbqF61hzOTKaRTxn6+dJrX+biTT5g+J+clS2xh0RQd9akq2Mcos8BYlkJIL4Uq4Sb4v8ZyoguAbtNXUJcVij5rQ7PjjkIVz2yZ5G23BzZqAusoY+eQBJXHlg0gfqZm6OYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BdT1BFky; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso7305257a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619583; x=1742224383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL3KrdqQvlwv1xQYem17t7QUv6GmMan/yx9/ashDvsw=;
        b=BdT1BFkypsIWLrd6nEL+hW90wxUe8FCZP3yyGu9Auq7HRnIgtDSWmeNzdW1+dZIL2t
         diIMNu0mORP7LPU3ivWeh28j1u0R4K4qrGqMGjgaNYHEZxUAS+a6HlFSoRfmxLgFnP8X
         bITKK1C+P+PBhdkiOt81w6C0oJ02R+QGH/R/izu7Dyo70PngprmSK0jS6jgLJdmuaLvR
         Bx5goO2jqF2hobXrpUHUJ81dZpwZvytGQQQrT/0c4IwzAr68dD7eeST1qqYF6tWH4tuA
         PAsd3iN0Pafht7xpZrkYgS5iartP6ZxiA8PAOo11LehK98SB/lc1kdLkUhuNcD11qhS+
         GS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619583; x=1742224383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL3KrdqQvlwv1xQYem17t7QUv6GmMan/yx9/ashDvsw=;
        b=Lc5YyMLT5PEeNabCE/OGBV+K3UKu9VMXPZPhl9L/6mI27XFWUfift0t2fNMJ6eXdjr
         QgqrujHs/2Ym4AiZg7Or9H5YIuF2SQcngNbOaAlkzihFtxSVxizGfMwVUOcKHUr3h8V/
         FGZsFVzGgvn0/OQVUmeCVBEVA/qD3G3ZjJpFoelNplAz1NMppMOwZUQx/1mLeBlKdXH3
         Nr9aYESqu5eCi19e5ArDLxKNHF2rYnwc9KvU8UN8SPavPwdxD9ffoo0rGNjS6H8SjMFD
         u9ka6sK3+TZ/OcQ7IRfw4JEGEM5CmP6QvgcmnsRJBBYXgEi+iaoq73h6eLHnXwOq+1g/
         GmGg==
X-Forwarded-Encrypted: i=1; AJvYcCULsUd/o3GWAI4cEjr1bqG+gB3ldxaAQRGFVak35ENzcqFLQa6ZpvcfR0dPFlGQ43PWGm9uRYkaEnhFm2gQkB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbOv4koduWV/59TLdJva00b3594dcLl+Q8U0WoPTqbkh+jNIn
	vZeewS0Q8ur0g0qirc2URxSamrp/aWrorTBMgRdvzgyZxDW/Q+xuOyR4cSRF5f8=
X-Gm-Gg: ASbGncvm/VyR0mwa28HtXDENkvB6TpQOct5g2xYa8eY2b70e4PsOE9R4SbzF3ZE7Oja
	E5xhPVlMgV5cSHV9odiQoXKvWM66Bh7ozaJKH3vxIecZCGsS6QFMgdy45KZgmvh3ngD/a2OLk9n
	OAB561f9v2HqKuLIuVHkm5SrVRUdf+CHinUmgaNa3VuvVoIsNc5U9SturFu9NfkoErliY0ASfo4
	qHHesmPvkKRk2MENQSQ4B5oguWR832anLyFmQtgkeZctovRnl/YUeyTRUuvshMAS8Hd3xURCA+l
	W3ywP/RixXYF2hnqhWEDJqPrR5yROGeQCH8HUMSUyXXqxjHPSQDKUsaV
X-Google-Smtp-Source: AGHT+IFqOyaVREaO+MohFgN6MHhlVeTDEW+52HPkp4Dqon7PwKBjXGmUdU6fJQIinAVq3owNZZQiOQ==
X-Received: by 2002:a17:90b:3810:b0:2fa:3b6b:3370 with SMTP id 98e67ed59e1d1-2ffbc1f57cemr15412229a91.16.1741619583563;
        Mon, 10 Mar 2025 08:13:03 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:03 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 02/17] riscv: sbi: add FWFT extension interface
Date: Mon, 10 Mar 2025 16:12:09 +0100
Message-ID: <20250310151229.2365992-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This SBI extensions enables supervisor mode to control feature that are
under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
DTE, etc).

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  5 ++
 arch/riscv/kernel/sbi.c      | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bb077d0c912f..fc87c609c11a 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -503,6 +503,11 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
 				unsigned long asid);
 long sbi_probe_extension(int ext);
 
+int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
+			  bool revert_on_failure);
+int sbi_fwft_get(u32 feature, unsigned long *value);
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
+
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
 {
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1989b8cade1b..256910db1307 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,103 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+int sbi_fwft_get(u32 feature, unsigned long *value)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * sbi_fwft_set() - Set a feature on all online cpus
+ * @feature: The feature to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
+
+struct fwft_set_req {
+	u32 feature;
+	unsigned long value;
+	unsigned long flags;
+	cpumask_t mask;
+};
+
+static void cpu_sbi_fwft_set(void *arg)
+{
+	struct fwft_set_req *req = arg;
+
+	if (sbi_fwft_set(req->feature, req->value, req->flags))
+		cpumask_clear_cpu(smp_processor_id(), &req->mask);
+}
+
+static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
+				      unsigned long flags,
+				      bool revert_on_fail)
+{
+	int ret;
+	unsigned long prev_value;
+	cpumask_t tmp;
+	struct fwft_set_req req = {
+		.feature = feature,
+		.value = value,
+		.flags = flags,
+	};
+
+	cpumask_copy(&req.mask, cpu_online_mask);
+
+	/* We can not revert if features are locked */
+	if (revert_on_fail && flags & SBI_FWFT_SET_FLAG_LOCK)
+		return -EINVAL;
+
+	/* Reset value is the same for all cpus, read it once. */
+	ret = sbi_fwft_get(feature, &prev_value);
+	if (ret)
+		return ret;
+
+	/* Feature might already be set to the value we want */
+	if (prev_value == value)
+		return 0;
+
+	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
+	if (cpumask_equal(&req.mask, cpu_online_mask))
+		return 0;
+
+	pr_err("Failed to set feature %x for all online cpus, reverting\n",
+	       feature);
+
+	req.value = prev_value;
+	cpumask_copy(&tmp, &req.mask);
+	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
+	if (cpumask_equal(&req.mask, &tmp))
+		return 0;
+
+	return -EINVAL;
+}
+
+/**
+ * sbi_fwft_all_cpus_set() - Set a feature on all online cpus
+ * @feature: The feature to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ * @revert_on_fail: true if feature value should be restored to it's orignal
+ * 		    value on failure.
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
+			  bool revert_on_fail)
+{
+	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
+		return sbi_fwft_set(feature, value, flags);
+
+	return sbi_fwft_feature_local_set(feature, value, flags,
+					  revert_on_fail);
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
-- 
2.47.2


