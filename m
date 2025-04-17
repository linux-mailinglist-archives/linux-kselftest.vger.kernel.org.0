Return-Path: <linux-kselftest+bounces-31051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCCA91BEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E373BF2D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B124A048;
	Thu, 17 Apr 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gvcv5E0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F42245006
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892678; cv=none; b=dUYAVB+52tozSIvg9O9AZ90xHcaP7kqC3kGfybQXjgP4aZznqhpgPJmMRehOLXDchQ0sq1w3FG8Uk2zTemzihxTIHnd6wLCZ8+W/foGSQ5URqa/IxTJZ6FqmsxVyr6V4HeFiQExLJCYIAYPVDxuc6B08xBBhVsg+ztoUL3d/Ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892678; c=relaxed/simple;
	bh=qJu1m4hx4nbu+oDFlDHA2hR7AvuynQAz0skV827DhvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3r+wug5hjhM6WRyWTkVdaP8lnDRH44DE1Cx91KyYF4ZCWIVkk8szwhMX0vDJX9hFL26JggsVoAjnN16GBFAOyR5d/zx/fVkBQy2pl1GlU/JOCZkj+RSWKyEEs+Saf4TmqVMvBWx1MuF+XB1dm1yVTRN/+Ye1EeTlOALZj6FP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gvcv5E0q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b433so7451045ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892675; x=1745497475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkvRtqiwpGFu2F2LneoosRxgLPIUe40LOw9HI4KIxXc=;
        b=Gvcv5E0q7WqcEvNo6Eg5joSeG01Iyyd0lKPavaMmhHr3u+PWN0xV4mFwfqRmSAB30o
         qUA/7LCPqp9+QlScp8y/95J/eJVwK0D9OOeSI+nioht74bY6oFljLxmg5DfM30v+BIgc
         HMtT4jD8vCrKvRau9K9pGlwr4rM0LIkBcAnnTeei9YX/fLZVzAFVztfaej6wQrqlhMLr
         sNlD+LX94iVvxutP4h3nLBAFrgSwiCLj3JTa7dOt2qVfnjEjR+aIuwugOicZriRCSGac
         plf9mnYgKJMqhWn5eQHTdulbIo8C/gL8d9/wX8ZCjUPcHzDFbq/GCc2rGkQL+YL0hhEC
         iTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892675; x=1745497475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkvRtqiwpGFu2F2LneoosRxgLPIUe40LOw9HI4KIxXc=;
        b=mtzpBB3hPVcSdlU8fGibSx2DIMzHN6+ZHZdq19SyY7tYn/ahHYJmsDYZYpF64ReekT
         7ANlOCvx99eGZj8+OjSp4GEcQBKMKGMMPPYlEK9gRMajjuhQBCC9x5FrvT97xuJbTfSI
         pYhJsds7z9Psu0R+KZVn0LB+efg9Vv4+61uHwkC0qhoA4J/D/NCOOjR1wHqFb/ru103L
         S68tmQ6+dILBGlC/fEkj/s2c/yMciGYF5mW7Xl3cu4YAAsddTm5+ofLqzN0K0t7kyrBu
         +YWWdCUFWWcbG9FSVDdVop/s+Lu81oN9hnz8lIZHBET5C6l4ptHrISlOetw4+VFrIoeD
         cq3g==
X-Forwarded-Encrypted: i=1; AJvYcCXz5sp0nasnbEuhjMkUoWqtThyG5/OtqA/q502k5+EwthTIjb8yc5ewfx6UWhZaXCtXQ4aH6wDqz5hry7Pnuzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79GW+VKZMSmryw3oPve++k3cwIngJVlFrVRnFmJej52iqqnf0
	1FPxilUzEUea6I4dzC/1sALcxm601t+6rI/vRB7csa5G4bGV/bBya2hh3f70PXI=
X-Gm-Gg: ASbGncuF40Da55FGs3mQVcU+i28Qw93hrquY0sF4S7A9ipI6zTdXPCWrS+s3/SmCQQ6
	OFeTy5HsDNs/uMmaD2t2+Mbrf/dQDpN0r+f7y1ZQvIg9w9mnz18Je4Tkv5jQHhrE9SQfwDcQW0U
	ddZYvCn6xqVpSC93X7BHLPLZQIjTsJliN1cgN3TD82EbtTFGMOKkYpSaGG6ibe8Mg9JlnHzxATq
	xjogZ4KeSeYvQvzMZ4MNc4OEHhbmBgSwCCzl1kXTi4eNgz/rXtk59yg+jNKovU21NgnX8ltw3Mf
	3QsSwszCaCNAhzwzjThHivpLZVUGQdzfVZP04aTAqw==
X-Google-Smtp-Source: AGHT+IFwoPNkZRHRLCRUuOqGDF2uiHAGyCvd3q8quDmBUyk1f/F/4WvIpLrbGYXfNhaC6uEF0f4feg==
X-Received: by 2002:a17:903:2447:b0:227:eb61:34b8 with SMTP id d9443c01a7336-22c35916f13mr99932925ad.25.1744892675059;
        Thu, 17 Apr 2025 05:24:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:24:34 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 04/13] riscv: sbi: add SBI FWFT extension calls
Date: Thu, 17 Apr 2025 14:19:51 +0200
Message-ID: <20250417122337.547969-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
provided as a separate commit that can be left out if needed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 379981c2bb21..7b062189b184 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+static bool sbi_fwft_supported;
+
 /**
  * sbi_fwft_set() - Set a feature on the local hart
  * @feature: The feature ID to be set
@@ -309,7 +311,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
  */
 int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
 {
-	return -EOPNOTSUPP;
+	struct sbiret ret;
+
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
+			feature, value, flags, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
 }
 
 struct fwft_set_req {
@@ -348,6 +358,9 @@ int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
 		.error = ATOMIC_INIT(0),
 	};
 
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
 	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
 		return -EINVAL;
 
@@ -679,6 +692,11 @@ void __init sbi_init(void)
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
+		if ((sbi_spec_version >= sbi_mk_version(3, 0)) &&
+		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
+			pr_info("SBI FWFT extension detected\n");
+			sbi_fwft_supported = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.49.0


