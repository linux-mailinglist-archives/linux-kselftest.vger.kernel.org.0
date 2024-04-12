Return-Path: <linux-kselftest+bounces-7768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964B8A26FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C74288915
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90EC481AA;
	Fri, 12 Apr 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mJjHeDEN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7B46558
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904548; cv=none; b=D3s8GsDvbQUSK0fNdsChPw/r1jrcLY3n1iMODxuHqbF5ISIrxOyXpA3jt24N65tCL4YneLVkIQHVsJgp1ISa39zzbFNOb01teAlRycA4hxcaUddO8Mj3sgCg8acSoL582MzW9cSkUcU8aGiafhL5XjHukpuyofuhY4Q1V7NVaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904548; c=relaxed/simple;
	bh=v5lsx72T+bwwkalmCViShoyQqewfBPUAjK8ziKGVSKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwfxTFBRxOObCmDNsYeKHslRwBCjP28YPWzxzg1prfPCs/Te5Z/y5s2KUGtNIKs4sh7TjjJdZodOxiakuh1XhIv8ZMIKRNhGYEigoOdD7CATcXw0Zpbw4N5FGuFLXzjnIHr6623AlPRAPoSGHeVaEJYTmKq049mYvDftGxzr8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mJjHeDEN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so595374b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904547; x=1713509347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srXw+GM0AbxLDkn2sukHjOTHYGaz4TEKS2v/bKB+HwE=;
        b=mJjHeDENzgG4gDckyAKh9nUWEQvpsykJTysvaHQg+0FZVclPPl7jziP1Sd8XitEerd
         uF4oYbbNXMxkb3o9ZPPnRd+pB+eklLTV1n2pou/6m3mtzThBA7B97hurWEL3FpQQkcbt
         B4z9vOtuYdADtpz3QQhStgbOYBrJsaJEMWVwnYCuL697Z+up/YlFPrMZDBvlt6k17klD
         etmxmqDxrkPEwmWHMm88r0Nzjk7c0VIgYHAwMyp0eF5hsqIyicqWJRk6+aU86MPlEfAk
         9DNCvqvzoiKUKjLKpyF7VycrlEmu42jbj2X9FSLsJ7oHawx3gsAT8jNMDpIB4UKEL+fT
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904547; x=1713509347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srXw+GM0AbxLDkn2sukHjOTHYGaz4TEKS2v/bKB+HwE=;
        b=cwHetfi5clRWJOWT/t1MdsbGziiEQmjEkwSHYcorhSo0pqttjqF+VxKbp3dWfE1qj2
         Gohc+0R58R9mEAK6SaQKcM8WCPSX6gPxFVWNbsXL6o1siiQZLX6WZoPEePfnmqgtENBf
         /SSwbOTY0F5EXPxfoqdHFqKD5UcZcOmGLdih2382DZ7yLS/JRhe21OZnrwDB7K9PoFo9
         56Z+76tCYxJOG0YCWsa2Mvb2OmZ0a72UAtvlkJd9gHsubislhEvS5UCeaHblqhjzFJKz
         qk02DRZ40wCkIfXnQ6XA6Ye6eJkHmHwD9/RxCfjrBAGAzvXtAWeBjQzxT4+dOUTGZp00
         h/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7AfbuGtb1M6qiV2tusykWApktMw+Jh0oLDXYVaBEzI2vwpWnW7MPVhw0USnY0rd+xP0IGJYckB5eaiCtpAuLh7qNPvHfI3d8o1QByGO6k
X-Gm-Message-State: AOJu0YxcJNg23zYlOkn/oue8q4RdZGK1kz/ksxII0zWzknL5BpdRGG9N
	pBOfornbswKN52nyjfl55Ua/NAhotUvEshChGL9ifgMZKOugE+Yx9hXtOJjXhmw=
X-Google-Smtp-Source: AGHT+IF5X1v/E+xWlHK5pNpmDBocfNqmMv4DyaPfDHN3Yc/L8+Q+p/aEL01S9Eh4YMSg/dpHO62FGw==
X-Received: by 2002:a05:6a20:bf2a:b0:1a3:afdc:fe5 with SMTP id gc42-20020a056a20bf2a00b001a3afdc0fe5mr1702435pzb.42.1712904546736;
        Thu, 11 Apr 2024 23:49:06 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:06 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:48:57 +0800
Subject: [PATCH v4 1/9] riscv: vector: add a comment when calling
 riscv_setup_vsize()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-zve-detection-v4-1-e0c45bb6b253@sifive.com>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

The function would fail when it detects the calling hart's vlen doesn't
match the first one's. The boot hart is the first hart calling this
function during riscv_fill_hwcap, so it is impossible to fail here. Add
a comment about this behavior.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v2:
 - update the comment (Conor)
---
 arch/riscv/kernel/cpufeature.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..d22b12072579 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -683,6 +683,10 @@ void __init riscv_fill_hwcap(void)
 	}
 
 	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		/*
+		 * This callsite can't fail here. It cannot fail when called on
+		 * the boot hart.
+		 */
 		riscv_v_setup_vsize();
 		/*
 		 * ISA string in device tree might have 'v' flag, but

-- 
2.44.0.rc2


