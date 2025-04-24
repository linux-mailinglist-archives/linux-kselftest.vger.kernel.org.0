Return-Path: <linux-kselftest+bounces-31578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C18A9B548
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984545A7EDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BC28EA44;
	Thu, 24 Apr 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nOO22wwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B828E5E1
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516046; cv=none; b=ewi7w6jF7OO1CwTSGNt9UPfXJWBx9qOo900HkdHAlaSMvoiAnaF/vNKcZLzWvFgYZF6tkbra1LFKMdndjRWN8YptZUURUJcqzIHCWxFwt/GE90/3yrFdVh+pqowhlb+7h4Yw4NhO7Y0Os3bDGxCytQrADkMnLMMKZFdYgkxfem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516046; c=relaxed/simple;
	bh=I8q3a/r8sIPwl9ULO4heNHCAxh6RA5hJvMvMHg5vqgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeN+nmRl5T/B0+/7x0bKyTyafeukXDM5pES5p6jft1d4kSpHiJQprThqsadt0arkP9YWdSpYGUwxz5dM7LTDK1CNsJTDkq1Lll1MvUEhP1cf/cmXsZ1EfX6mNiVQC2FoEUeJPWdBr82Q1Ed08lm6mKhM4rOEZZwS9sLuX4JOC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nOO22wwC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c33e5013aso17664585ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516043; x=1746120843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ5IZYf4f1NhGHvFycXXpF/34tAS76qwhFgvuPH97UQ=;
        b=nOO22wwCEeeCLRdveDX1XJoulJIftSH2Nt3zOLaUXbwhKvcj7lcqH87YEsPTBbZZVa
         DAZ92Bd8Qn0w/IXvr6KM2BLUODk+EeRU+BzFKu3J8g29wrEmXLW4zt8L/U+KtaqYVI1E
         1uVZ4y1fDi5d5ZdC40Rbt7iLF5i1i5LlbLDyP/24BqAHGGZ5l9ZyGFNaST9DcpVhflpv
         AfqL3xSYZe6wrmKxpIZImjsLgR6rYg5TWruM+xJmm7bN64PuspNEKe1mWR2TlFafaKnd
         xN1Xqs7d8jv6TDen0V0LTc3ynMr0xWKDV2TFI0PWiQKG/mraDPeHnKEyRGyF9fkw/HTA
         jPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516043; x=1746120843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ5IZYf4f1NhGHvFycXXpF/34tAS76qwhFgvuPH97UQ=;
        b=kethng5Kjyzw1q9farYsfWWYiDnk9/ew20lmwV3oPlo6/G9t5GlWpRGtNSP6gqUOIn
         F51443EKDqe/0SDfJGI67LV96oYVmob0g1Lopk5hr10W5SaGU34MYu9/1hCfy7Lj7EmK
         D15urSgjcrpVvZj7ZlWlAPtE1u7w1gf+CXR8S29YnjVCpErFT9fVO0J/h7h2iUj3VvBI
         JtrbMhy+QlKqhxWYIihUx6glZWXs0V6IbscxPvUfq3sEaNrFTCLVE0z4dhsYwCPn0FyI
         HxH9iFz6298kv0MQadDQP9abyslWSlZXjkJINPGV5/kQKaVWlXR7YCCTUgfjDYEgjmZU
         O3RA==
X-Forwarded-Encrypted: i=1; AJvYcCUPAbXmvOZTIJ5SjBH/j47hIjcxI3BEYHOy6NImyGOQq0Tiw1JbZ4yeY1Onk+ycFl3gI9W7cCvEWEiLf9gYP8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDlC49ATCA8MXp7Bktcj4FyadRuCwTKne4ZNS8PbmNtGkfXBY
	b82Kg/ifVWRaWPnw8Ik10wusdTUa0ieviU2k0LfYwHLRPaU42HnCnoqO9v8Qw9k=
X-Gm-Gg: ASbGncsqK34GnlW4xuapOb5J67w7asbJ5JmzI8dA/TMaRRLyjBh1WvN0XKmy0YkOWAd
	h2GCZX+DBbrw+41b1bABmEc3LG86IxQxuxMX1Y/ReImbjOjSdutm6GH8ufYKJyDK7touD/5dCdx
	xOb11zP9BaXsxYcuZksjdYJ5ZQDhUAxFMSBtTPnpjWEW2XvjTPaT2u1YA4gIt5MY6NwvxAyAzF5
	p56qS3e2qSthVhRBDEOoYwDVaWULBWAW8VdKIZq9ErZu2fbJ1Uhlxw8DFuC9TGfLzpEI9pRSab3
	mTQlkbQHHUJDfTmk8FPq3XfKmVpVlyXm8Vji+apDeQ==
X-Google-Smtp-Source: AGHT+IHzS5PXDP+Qy5Xmwwn0uCCNIK9/92EEG8lEAWpb5PTGOgGH/HAmRDTuUMHUdz3Q/hblJk8Z1w==
X-Received: by 2002:a17:903:234e:b0:223:67ac:8929 with SMTP id d9443c01a7336-22dbd35407bmr5533655ad.0.1745516043323;
        Thu, 24 Apr 2025 10:34:03 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:34:02 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 03/14] riscv: sbi: add new SBI error mappings
Date: Thu, 24 Apr 2025 19:31:50 +0200
Message-ID: <20250424173204.1948385-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424173204.1948385-1-cleger@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few new errors have been added with SBI V3.0, maps them as close as
possible to errno values.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bb077d0c912f..7ec249fea880 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -536,11 +536,21 @@ static inline int sbi_err_map_linux_errno(int err)
 	case SBI_SUCCESS:
 		return 0;
 	case SBI_ERR_DENIED:
+	case SBI_ERR_DENIED_LOCKED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_INVALID_STATE:
 		return -EINVAL;
+	case SBI_ERR_BAD_RANGE:
+		return -ERANGE;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_NO_SHMEM:
+		return -ENOMEM;
+	case SBI_ERR_TIMEOUT:
+		return -ETIME;
+	case SBI_ERR_IO:
+		return -EIO;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.49.0


