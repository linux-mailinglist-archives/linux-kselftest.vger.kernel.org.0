Return-Path: <linux-kselftest+bounces-31335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72528A972A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B3116C2AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AB296179;
	Tue, 22 Apr 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="clDG/FZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD7296166
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339065; cv=none; b=pU3DJw7mSFNm1PCVIULExGrSnVd6Fole+PnogZ6uKFdkSlF7piMmUzw1Yi8Oz2gb3VRH28aGz+7mmbRePz1KEw1QVG3qTZEoM+rndIZWpwTFEayL+jHaeZStsS6nRPcvUStnxqbQ/tBQCPG+yjNBulay8JyVzaPSghyPT2fN/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339065; c=relaxed/simple;
	bh=cnNngG1SEA++0p1pjRKLRhcZbXg8zfVDDmR8Yj1S+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftHmunY02nn4kzU6Voin8wgLMAwEzDG4HUg8cmxxKRhRAzh1smVtqDTMXtII+l85qLU+CSMaDYw1m1igsZJOeZWIL42/WbC14AncIMJCs11w0LPcgyO8z/ODKqmi40CAkUO7EwY7aZH/vaCwQ99UBO4iqCpogzXw7aYaMhMNsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=clDG/FZG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736a72220edso5378992b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745339063; x=1745943863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbKVfcaTHYuJWKRcGFqU1yco7PJvUrfVpm2zvqDMXhg=;
        b=clDG/FZGPs5IxQovqixh7N43uaBkd0ltXi8+M7KTm2m+qWMjwU3NLva/oArFvnXvbH
         TZwaGpM6QchTWK5BAqFxkZ9eCYq8WXTkmhxAGgtnLiYZuzF3GXuL+cbGAoG726iv3eFQ
         MS/vFD5E7kTISyXPZ9gUq2bXNwa7W8i88m6M/af60OGgPhG5Zs9Xca4n35DXbfNeTXEv
         TmlGzvoMFlubCQTY+CDlGAwFJP762na3VB/msexZ/XSfVhPfS7jP5171l77ntT/UtPhN
         Nn2bnMN0SBnTiyXID28m5oowZ32iEgcDUq974uGvUfWPbKVRKYjlhepP+yeOi1QDAYts
         O7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339063; x=1745943863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbKVfcaTHYuJWKRcGFqU1yco7PJvUrfVpm2zvqDMXhg=;
        b=XNA7lwfo9NokJYmUBBIbJamUvNtH5xwh3tMm7yKgtlclJLGIbSq3k3ceTDarQoc08T
         gsGC+6HHLZT5D/T2eA+dfjlj6sxIRt99tjWsRII9oa05Zr1FMBeJnL1SOU/q4LMfDCZF
         a5OKmO038nXlkp1IffJ7/om5jsL0FJKrPwC3y2XSZI1bZyHdACm8fK2FgpqTy7MEzuDs
         HuJUi3YRMvnKuXvqmZ01GsYWwpBaSi2rK/lR1rZWfTAqg4ipeB6XUP0bPC4s7avgxNZC
         Owna+ATVJWTf8j4/NWEblh+B8QAJRoY2ck1gcadeeNOtGvLBMyccHHNZO1IXlMEgHgon
         lEmA==
X-Forwarded-Encrypted: i=1; AJvYcCU57yBq3h3HVrkBRHI5iYUEd5aZDJWsjThSlJfri+Ul+kEHJNBG0zZgfbHBOODhWS9pWl55xBCXmE3FtpTbMuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxycrwt1B1G540sHeWmeNl9dvxEdYWw/0kkuOLnjtJBial4X7P+
	xeVwANAkRbxt0ppHENHsJdk3C2nUxm8YUJBuQRfxtAnp0UoIZsBXAap6H6yqv+o=
X-Gm-Gg: ASbGncvDY5ky2KMekA2YwPmwzzGdzVNhypvgOOcvs7xBL4CHq2GsPgCQoWDI0Q8Fzed
	jZ3bGNGsgHtn6li0wNnS88Rwh4xKfH9iIcViHUXgKLfhB46+csfUQzchfo1Et+dr1Fa88osWP6g
	g++SLAE5YuRfAiu5oCEw6Dk/UNa0MZU9rvKSnjcohW37YxC7PELwesL0Uhywx2c5DoZO+RxWf3I
	03CpSQNLSv06tOL28ROHZU/mfYXb+dH/6PTyhn8k62CplUTEsDOc7WwdR2PQsFWxK3+yO+GCKpU
	hyW3X7mtQw0t+imKM7yMCLrBBrPimdqb/uptklzdRg==
X-Google-Smtp-Source: AGHT+IEFf0tssnpfmlIbhqMb84KZUlhUCNzB5IiKyJZf9ulfPIE7IN7Goopu3beJAt1h94MrpDZmZg==
X-Received: by 2002:a05:6a00:27a9:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-73dc159de28mr23833026b3a.18.1745339063142;
        Tue, 22 Apr 2025 09:24:23 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm8850825b3a.46.2025.04.22.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:24:22 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/5] Documentation/sysctl: add riscv to unaligned-trap supported archs
Date: Tue, 22 Apr 2025 18:23:11 +0200
Message-ID: <20250422162324.956065-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422162324.956065-1-cleger@rivosinc.com>
References: <20250422162324.956065-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

riscv supports the "unaligned-trap" sysctl variable, add it to the list
of supported architectures.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..a38e91c4d92c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1595,8 +1595,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
-are caught and emulated (instead of failing).
+``arc``, ``parisc``, ``loongarch`` and ``riscv``), controls whether unaligned
+traps are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
-- 
2.49.0


