Return-Path: <linux-kselftest+bounces-33049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4515AB806C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C867AAB37
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D528C001;
	Thu, 15 May 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L4DzZy5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9C28A708
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297429; cv=none; b=I8RCbNjBi+pqMAKQnnkZ/CuCLSsELo0qd5iKwdqfJsOoRBRs3sp3/i3mdLcDIc2PEercTwyPVer1FjjWk9xQ5er/O84aG9geMp1K9YPWVEXZww5+zE1zrz+jbq0BAZZ08ivGiO4pmMILztTtdEH+JIdj5rR3O0my12VlzF/AT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297429; c=relaxed/simple;
	bh=oe9YzhrIkRFjcEpmOMMHuXd74hPefU7Jr+/Rq21d1Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsYkNps/5AfFSmFZP33al2O5YC1XdEpx8Tc3Tr/noHNFJQo075LkZPys8c6r9C5YozSaRzI1beKNEdh8A/dMnwevMa50lLJ7FvFlcQ3kH0L7U/p4qlP6VCVe4cZqNxiBXaAJD1MjBNjmtiAswic6e+Wf24o97/msI4tot1X6/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L4DzZy5P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so4148345e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297426; x=1747902226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=L4DzZy5P3aJ/GC7hRBJ1TP4uF6OYa3kLCeBAw/zW9Fud20wIND5tl9CKvsQUPgffMG
         Y3Rihi//bqlyR+VS5poYmvhcOyJkrq0giKQWhoXRHkfPPEmGwQcW+H4Dfk9WdvOKgFeC
         mN2wk9r2oZVJTd+zUk2KESl3DiBimxZX4mFC6esD+p5I1OTtv+hYCn1Nmj3ndamfo8mT
         uAYMjn9oD/YxOcBvf3gsCy2NCpFGrLfbP1T9lznaEjiDGtwysiGJ+KBa5nrKRygLv50m
         3YehJhYnkW4oU/O6yO/FMtLZwMGRHR0+Lvc+IOb9dXBKXybBeEpnwYMHEDWzcspJhCbd
         Mh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297426; x=1747902226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=ubmp7alNpaaLq+WElbiavDFwuA0gVlhC3QBeYgIFf8Q9tOduFj92JkZpaKVhaSp80Z
         QNCWtMzXdWW0q12DDlMg9D0WXH4xJpo3T1mc0qH/UUyjvIw+MX5n511XaRHNO2iaAV/1
         2dNAkrSqWuAA+MXNegcb/D7jb68VAvSGUELqTOOeSWQyuS08Ex64eV/d2P/pQbvHLeyq
         fc9JbgXLoYJ0p5dmvnfftzchSv7OrkbtC2iAnbWfkNGUkk6yt9yE50fU+XGULECCAHpY
         27wrivCAXPLGo0tgQTjs1BQjFhConpbfxF/cQ6AAj+h8NfWZNC25xTGl/2TJJzTcyjwV
         mFsA==
X-Forwarded-Encrypted: i=1; AJvYcCV0cHn/BHrMb90P+QyqdJ3aVF0EMsmfFCZCfuQxq1XuQd60kwqBSLdYUfy1j0sTs9z4WD/IApAe4cgORKUE81M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6IlaXMeYvsGLP5EIDIcUHFxvDfxRU5RsGdEyCX80ty0TKrLz
	VH7KNS8ii2TDlbFrW5C6VXe3hcU5oN/T6H+ceSYfqRQszWhmJS7ve21+WG2cjezCXko=
X-Gm-Gg: ASbGncuylAB+7b4YDXLvOFbVLSqR+r9JQxDfQycS4UYQ50cQzuYThmwbDAaQ45cMhnP
	yBR01zaFEE7lo9DmGtnOHJcktAlNH/aW0C2JZp0MBVBVfUjGjLnIkzKO6bilXgM/RqF0R3CiK4X
	uj50b+DOhXH7Jpdp9+Bcb7Zl5mSDCKUHE1LeCZ0zF/Yg+FLcZLSHl0WunKUqwQJ2o7wObaw1NaI
	lLGz5K96cFL7zUtB+G4hMa0qPEv9fK1AKPwrFRWR81n+K89wnJeFjicCRzVC9ZZgurNoxB7JckF
	rO1GMp3sWNmDiG0RgkCHte+3Lt0Vo338MCwTcZrtCpftHJXJgspGuH8EynNIbA==
X-Google-Smtp-Source: AGHT+IEf/m3FG8FRM27DD2c+gtkesEWRNvfkiivPTHatSmLHF+9dpAc024hgwxzmnfOdGRF2n1iTFw==
X-Received: by 2002:a05:600c:46c9:b0:442:f8f6:48e5 with SMTP id 5b1f17b1804b1-442f8f6494fmr16827155e9.8.1747297425789;
        Thu, 15 May 2025 01:23:45 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:45 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v7 02/14] riscv: sbi: remove useless parenthesis
Date: Thu, 15 May 2025 10:22:03 +0200
Message-ID: <20250515082217.433227-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few parenthesis in check for SBI version/extension were useless,
remove them.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1989b8cade1b..1d44c35305a9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -609,7 +609,7 @@ void __init sbi_init(void)
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
-		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
+		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
 			pm_power_off = sbi_srst_power_off;
@@ -617,8 +617,8 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
-		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
-		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
+		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
-- 
2.49.0


