Return-Path: <linux-kselftest+bounces-8491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75158AB7A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1563C1C20CE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC0143C5F;
	Fri, 19 Apr 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OMD8wsZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07630143894
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570479; cv=none; b=dyvWhWPoNdAHFJYeDgg6pUMtINe+PLTpWH1jF7HpT5DqJ0xGBe9vB2qNZxzc4vI3Igg8aZ8MJcZMcOMO25JSUtlTYQKJ6dPJiyDh3UV+4mMmN5SajDTIX4/nPXB14wt+XAhLv2YmPpxrzbmqWxy2R7V+gR7C6AOSzJUQgZdegSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570479; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdxJ4dZ7sGR/5Fc4yfll1s6qx+ekrFYJsiU3dw88Jn13gTKtvMbQYV8oVhAP5He4088J3QMuA5HDd+KY2Kc6EXSkKFUURcffHlhONFrLx51PZxH6BVbB4Ud6HhRP5PkN3g+OQWTxAgz3tmua3bX7NzB85ZSXeumGNF1k3GuoIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OMD8wsZK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1969893a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570477; x=1714175277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=OMD8wsZKCRdjJvZGYl+Ya9IqIPLUZN8Us5XJWfHNYzlhwyLm4likvuiWW6LVNW3IYE
         QU/Srx4vAkmXgdvUwKtwJaZWCykHAgaudHZKtq4SKk7HN63XIwXGxRpzofIGz3gbcCqO
         357XHJEuOzF/l+GTioGQAaLZuoS/lfAShwkiGc2PMHLF+EBfLUu2ac9wQwzCm7CfFEmG
         gNKJnSoRazQ7Yox/coXpMl++jZ0OW+T2J0q6yFtlaRwncB7uq/9qBwDk8c3ce8LZ10td
         C8qi/t2EQnGp7OFdkE5qUlQM3Xg3EsweW/ZuGLTY8NgW4A2nrc1gHBbJUl4DPUEmEP9Z
         zkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570477; x=1714175277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=v4g54GKF5t0LtNtwMQgFzUqRkdBTzq4fKud1vkk56pQRN2/Vinw+U4eUUpvti8jQbk
         OUBJDnddMcWbYSvv7/39baYooFWtbx6o25m5wCu52MWi69QRSNAh8jMU2y1YviFlpmTg
         gwR/UELCHpGqEWyI7zk0lKIq9qRrcoOkzhmsNRhCTRbBIwH9KUKLu7fNfdv5sPJr9s6I
         zNfiek+R2TOLHFf4GHyEzsKT9a0UPJTM6iWAIP2KGtXCVN4utM4wEQVfQhs7+xsL3x+A
         TzmQm6pU7oCYOKKybhr998OjxEUbjkZtgLi4jS1PCMI9s5tC7DlviXZfW+xc3DBcvMsh
         dIkw==
X-Forwarded-Encrypted: i=1; AJvYcCVP4asjY5io3OjtLgWhSv5CD5d0tRDPYnYebiOooOtDZhJ8FGIzEFI76R1rAbaij7q7bq1N6lQAKdzKwOnEpFJl3n+jgc7KsSAaGb97S7tl
X-Gm-Message-State: AOJu0YwsvGW1sUOOgLtiWIEYTD78ACV6MoqD9LFoeva/D5CB7YCstVdW
	oURicECYxqgre+XiDaBzJNLZYhQHAtSK6ai18XpZk8/o9lDbqgM8mjJCblHDO6s=
X-Google-Smtp-Source: AGHT+IEp4LLA0ETVFj3v2NTREBIL9JwLMfd8wP55jjHsvOjY9dRaboqfqB73D1IRQCndgtBmMeDbdg==
X-Received: by 2002:a05:6a20:8422:b0:1a7:336c:555c with SMTP id c34-20020a056a20842200b001a7336c555cmr4805991pzd.60.1713570477483;
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Sat, 20 Apr 2024 08:17:23 -0700
Message-Id: <20240420151741.962500-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..112a0a0d9f46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


