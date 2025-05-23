Return-Path: <linux-kselftest+bounces-33626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E8AC20D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D31450524B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95649228CA5;
	Fri, 23 May 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LrY0UPrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5E227E9B
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995668; cv=none; b=Ujfu8S3FL7koPdai59D4sYy6uxW3dBe2kzD3wtbHAvKyTpXCv20JeH/dWTnNrZJry53JkSqanQIwQiC2nFXGrm7d2E8z7LjVcN5RXmUUuicvJeb2DzU2G5sjQslQO2y523HfFOoHNTxiiTGE445AINej7o461uOw9dkzH8Vs+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995668; c=relaxed/simple;
	bh=oe9YzhrIkRFjcEpmOMMHuXd74hPefU7Jr+/Rq21d1Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZnmMGkLaU53NcHYHzFAVYk0IPMsOrv4+AJ2MZTqaX21U2xOJ1gnTCjKSVUpVsl8YgCST2ZsmYIUy4P9GbcEXElqKlbmfCTzY5RdL9VH6SkPTXG3aXUK+kJVJ+sxC1uuwvPMyNGwrXlUAXXlYmM5myylymF4agocoonTX+klm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LrY0UPrw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso8606206b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995666; x=1748600466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=LrY0UPrwtPLDvA/J0bNSHVUhjnjXI87L9g+VicF/2ooa8r4qxkG2rS0RtcGx3XtAjX
         arVUs5Hn34FfLre91Dzm2glIlhUF10YBfzMAWNy3/tcTHyOmtwekfZScEW6z44IxLoEP
         Y2MnpHkNaP/cZw3qfGYVkIPiRprKZV+zLBZeedx6edDOgZPSr78Paqql6Ti/KOlu5IhZ
         zebUoIkPjnDUWitowJOADZMC+3XZPDi5cR+hELnkn7x1iKV48Gwv9uiNDEipbpckx2Zm
         tZEXNRu/tys0DoWEj77XfLqUfpauQyEia14K/53F8TtSZBbjRCVENg4FmbF+0m+GbnaK
         8IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995666; x=1748600466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=HjPc4Ns0HgHXKJk88iZTnOuBXjjzwoN7pN3Zb+x0XqpOiikVQU5utzdGTCI4/C9IzA
         756dtAPOCYmWuxeTjrqPbwkpQEDpBRZK9TB+4At3l/OPE894ACXbITlLSQ2lagWEXCYv
         brNWJs4pb7gPwnnK1N01DTtuNqK5sLvOPJmZECE102AWivV6iCNKg78qDyHgZVYG9Hpc
         P8OC7qegUk1FNzTIyp6GH1mLXZ4cZJQb6guMs8B1OP3pNn7xN3HeolGz7ShEQLJzqp/j
         P94W5FcGOlTvNHZBXLpWnevLPXJjWTOK+8KZMetRVXHBZxgQV+RWx8mzQC50oZWxIQ0Y
         ubJw==
X-Forwarded-Encrypted: i=1; AJvYcCXFgbRvImc6/msf7ohVQDcDbWV4dwUcGc/Zivbq1+l7DGV352OKxqb+v1pYr2fgmbp/WQwRkWMIBLK5bmhzV9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMpkpFJPBX9RC6n4a3rLX/dwEEyXE2gGum8ogZEQwY/wmc2PQ
	7HrORbbbOrJtTE8xgg9obL6Sd0dhFccr2HYYA4nfEFA/3u/tpgQE1gRsL/Mevf6G4wI=
X-Gm-Gg: ASbGncvuMK7uRjk6y2qAlP2y2mAscxFYHssuRpjqxU/U1lDLQQlQnmVSX52TUNdt9cp
	3Uv7AFSxYfUXExwb+FNjOIsbUYZgpjG+5losv9aTPAkiokkJHUObrg6YN/ieyedGf0sKzz+YC9O
	YeHuxpNgtbxF7ALnwBkEVAD/zX8ZJM6yle+4z7XoKGKMdp3zUHBh4KCwAl5wVX19jjVL6h4zVUz
	d670+e0b+R70hDdLAWN+AZxEv1s9zkpskFdgpVRBd9wfg+Q50RThSu21wmxtR0ByRmlz0IKEWvP
	AMkrxlyaNsMqmk8o2/gk9LtjgL3sEHGznEwHYAwLnFZ+hoLj/y9KKmlMQJziNHY=
X-Google-Smtp-Source: AGHT+IFXhCgkcbKavnE2xTp9i4da6iauW69FEMu71goEiqhGLYMQSQQ3w6lKP9OCGbZDB/3Z0XQGgA==
X-Received: by 2002:a05:6a00:130e:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-745ed847e76mr3749012b3a.3.1747995666204;
        Fri, 23 May 2025 03:21:06 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:21:05 -0700 (PDT)
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
	Charlie Jenkins <charlie@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 02/14] riscv: sbi: remove useless parenthesis
Date: Fri, 23 May 2025 12:19:19 +0200
Message-ID: <20250523101932.1594077-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
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


