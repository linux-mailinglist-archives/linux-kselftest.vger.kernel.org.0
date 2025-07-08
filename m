Return-Path: <linux-kselftest+bounces-36765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61368AFCFA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413E9482846
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41852E3374;
	Tue,  8 Jul 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AaV51Lfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B72E336F
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989696; cv=none; b=DS4zmYqiZsKRV6mwIp5ycCsSOfDom0imCddYFaAIbjUMOUXOdUirK9Su/gIW5ADrrtzLA9IvJ7xeGTR9KChv7ZGKv6xWm0qkeOR8ADLvWX1PKOEu3tWGcSrpwzG/GKgoL1Vx6H+IMNZt/A7K1apmxNl4HsOZ4Yv1OAcJFaPeENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989696; c=relaxed/simple;
	bh=ds5SN/ud6IreyNpgodB7PP6useD2H+9ogieo60SRHek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oasIETqwP6HqHkAeN7B42e1nSC+/l406gjUFZh/J2rqebkpf7kzm2WhZP8tP8x4mfyOL8MlAZ8RPj9gk3I3+VQhtuJWthENQpk1HXYUu0ianx48jtTZX0J4M1zoTuSjzzfSb/8QmYca5OBlQQ81WIa/pzHmfUFP/ibsGRfHiKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AaV51Lfe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d3f192a64eso462456085a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751989693; x=1752594493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH04xoC4HJJjcr3JF880EHmqHS1N+xsYoFSsuwlbdaQ=;
        b=AaV51Lfev6Qp8tdyZv2g7NRGgMs+qZodiXVapmdyH8iFqJ+iIDC+s+LzViHZwizJzx
         k/WNcT5UxTnQKCFgAfTjnYG8pUlYWmm2le122Hy98pXgFkShftt5SuM1F61jvdXFS1GK
         NvT04frwRN4DtwjIffQhsWvb0Vqh2gQ+VmxGFAjx5+kWMSWRotNdQj66IsQsujsxyf3C
         wzxpwbsgiayNBU2f6qm0s9EhS/3ACCJRbp/q4GCkWy275yTVz2PTAmWtN2jHrkdF11xX
         UaXRjpdi8cVcG8yLJ8/Qj8cuKDwKSIxuKotnPi8T1kZw9+agVv2GY2p9duPkjoACNgFn
         XCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989693; x=1752594493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH04xoC4HJJjcr3JF880EHmqHS1N+xsYoFSsuwlbdaQ=;
        b=DrmNPKAb69Q4PaKbhGhxDbO7JKw5Hu8VLrMlYqM3QOmQ5jm2git8YrWjBDRBktmUP/
         mGyjqAo8dA3qj3RyudeYLkx/Bpowj6sbyRK5o4flctz4Wend2JvZHS+xFjLdKzpKWlpW
         3Mx4nSTC6vgaEk7gJFLsdsb8VynY0E11iODp1VePeEblqrFDTyCXCbaqlfoEoIKPLWDZ
         lPLD2SC9JpQY2hrcgZFhYfWZlmOTvBxKG+9Dc34Sel49yr8Bjpsv1ClFY4i4und0qtNr
         vw6i1HHSvzbm85N+etzQnN52pnECB5taFoS2eAv4G2HyNLJ0e+tiJvnDZOzTAucmT1Ss
         1Gxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRcSLPg0U/8weyxAVUwtszsrh7tp0AdBGObjLTcCrRrj1ZqCVOAQmvHIJjSbzLqlQ06Z+2deduHH0+qPcNC9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaEsYuooULLDP9ARpnuP5k6G6PuIO7U3DuY29T+lOo8Grs0If
	xr2TUrmNVri4OyUwX22vaEQoISPHS7NcziuO8jCoU18We0h0hB6R1C5TS3IGGpdC+TI=
X-Gm-Gg: ASbGncsVz+rE9KNrJ+s1AoTkfjnKJd7Uw4heR9Q2KNmpvFC7A7QQf4aW9FouFycsuLQ
	NXlgjJBoD59W26fhptSUdiUpX5F4+NJ4v2SPbjsuuYKsmU1VVFh/KVChnttg2gRB78GbIq24rG8
	kauULki+/VQumZ4bEjtVYJ+e3lhATFCKAuUTby0LgN8AIrpmOc/V/m4oD6z9zJ/dRrUMFba4/m+
	73r0ljA0Xi0ZfEsoTXXje2C6w4V2PGm15XCsQ31fZADDOE6lECd3bMBZn/cfty2Y5/RjHIf7ZVv
	OkP4xEM9Z6oW/3N1m5f3mPgzKhgw0LvMH6jPePp1dLh8kON/JhD8mCbGqXoAu7l7NsEJD/sWKVC
	jbfxpE13L/YUdTfWjMiMoIp14b8M5FATCyFfch0q2zumVOhN2sl+FNvOpc/ro5w==
X-Google-Smtp-Source: AGHT+IGUQo5EBx/tNY5n3ZATmL3uaoM4iK61VNEuctuQHFnVd7lY/jZGvovGvruOSz6T58HuyGkltw==
X-Received: by 2002:a05:6214:5b81:b0:6fb:3d7:71bb with SMTP id 6a1803df08f44-7047d931790mr46736666d6.1.1751989693532;
        Tue, 08 Jul 2025 08:48:13 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ab9csm78453346d6.87.2025.07.08.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:48:13 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	James Raphael Tiovalen <jamestiotio@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Cade Richard <cade.richard@gmail.com>
Subject: [kvm-unit-tests PATCH v2 2/2] riscv: lib: Add sbi-exit-code to configure and environment
Date: Tue,  8 Jul 2025 08:48:11 -0700
Message-ID: <20250708154811.1888319-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708154811.1888319-1-jesse@rivosinc.com>
References: <20250708154811.1888319-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --[enable|disable]-sbi-exit-code to configure script.
With the default value as disabled.
Add a check for SBI_EXIT_CODE in the environment, so that passing
of the test status is configurable from both the
environment and the configure script

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 configure      | 11 +++++++++++
 lib/riscv/io.c |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 20bf5042..7c949bdc 100755
--- a/configure
+++ b/configure
@@ -67,6 +67,7 @@ earlycon=
 console=
 efi=
 efi_direct=
+sbi_exit_code=0
 target_cpu=
 
 # Enable -Werror by default for git repositories only (i.e. developer builds)
@@ -141,6 +142,9 @@ usage() {
 	                           system and run from the UEFI shell. Ignored when efi isn't enabled
 	                           and defaults to enabled when efi is enabled for riscv64.
 	                           (arm64 and riscv64 only)
+	    --[enable|disable]-sbi-exit-code
+	                           Enable or disable sending pass/fail exit code to SBI SRST.
+	                           (disabled by default, riscv only)
 EOF
     exit 1
 }
@@ -236,6 +240,12 @@ while [[ $optno -le $argc ]]; do
 	--disable-efi-direct)
 	    efi_direct=n
 	    ;;
+	--enable-sbi-exit-code)
+	    sbi_exit_code=1
+	    ;;
+	--disable-sbi-exit-code)
+	    sbi_exit_code=0
+	    ;;
 	--enable-werror)
 	    werror=-Werror
 	    ;;
@@ -551,6 +561,7 @@ EOF
 elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
     echo "#define CONFIG_UART_EARLY_BASE ${uart_early_addr}" >> lib/config.h
     [ "$console" = "sbi" ] && echo "#define CONFIG_SBI_CONSOLE" >> lib/config.h
+    echo "#define CONFIG_SBI_EXIT_CODE ${sbi_exit_code}" >> lib/config.h
     echo >> lib/config.h
 fi
 echo "#endif" >> lib/config.h
diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index b1163404..c46845de 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2023, Ventana Micro Systems Inc., Andrew Jones <ajones@ventanamicro.com>
  */
 #include <libcflat.h>
+#include <argv.h>
 #include <bitops.h>
 #include <config.h>
 #include <devicetree.h>
@@ -163,7 +164,8 @@ void halt(int code);
 void exit(int code)
 {
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
-	sbi_shutdown(code == 0);
+
+	sbi_shutdown(GET_CONFIG_OR_ENV(SBI_EXIT_CODE) ? code == 0 : true);
 	halt(code);
 	__builtin_unreachable();
 }
-- 
2.43.0


