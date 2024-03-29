Return-Path: <linux-kselftest+bounces-6859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01B8915D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D61D1C22CF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABB53E28;
	Fri, 29 Mar 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y+kogVx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7A535D2
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704473; cv=none; b=MXvrC6Xhq2I7Nbo/4PvZFnAmDKzzNeOhXZN7YjsXQAvQtHdDa8+HNtG99P/VhtmH7nSyhRvRltPcRuz+3CWVvqrmzILGxMbPWOxy5BpGSL/wSkoSvi7xaFrxvD5oph0c+EBmzmo39xzWNQfK66vPHsYAG2fPYUKqFMspxQhfokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704473; c=relaxed/simple;
	bh=JA7UBPKQETRrngwLOp+J6IF6ItB1gKtf7ZWFX11pOa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4h3OgM6dqDp8T+FX0/oZwcsZfKDKO0lTC3plvU1Kh/Zi6om2zHzj8Ykj7xziBlYb0k0Igc+yVTJ7lFLBKOOXGFbYcwpRHIQE3HixJM+kB1LfbAnnJ3qsU5Wi5W2xxuZdRJEyGy84EKCRM6bkwdZzYGURek0yDsf4fP3oUQqJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y+kogVx+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1247865a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704471; x=1712309271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zZjndsCXBnAhUzEP7RXDQ1mWPnsHyYv9gf2B2OXJhU=;
        b=Y+kogVx+aPSJb+/4M886ExbMfFekUnh15FdP7WFiHUXrpSqYmngEX+cR6VQgj3EN4+
         08NFjwmxuWSUZxNAKi78pmDG7fk/HXZVaS05csCUkREqDpXDqgkMH5ueWQoUXeOq0sLt
         1LKEexOzlFo15dcbz3nWq6Ei2cn8M4pcVWLD+fZbJcgGiuDoIIfQS9Td3Jf+Z3ZWvTZ0
         Z/idaBOYgq8fQDev0TmMJ6+pFwcPmycqdXoBLtXxUrTafFTFkZQQUvrFtbsctsNIWJXX
         RddcdrLfx2uz5svmgDU+KLFkE6mrDwnvmjiWFsbDNm9d9jAC7W/4p4Ha8WxG9LXdE/GQ
         79Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704471; x=1712309271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zZjndsCXBnAhUzEP7RXDQ1mWPnsHyYv9gf2B2OXJhU=;
        b=dUPv9g44J6UZZf4U2lC7/BKdq6MYucutEgQW6iY2dnkBrAbZSFIM6HibCQQ1kRzsb5
         b+kl9YE/WLjZkymKd3JE+HBSoTJWJPTuIJxEup7qjxGeU53pXapc0CBlrnPasCWQvdSk
         jXJNY/+kJFEOCh0Cz9a+PBqRcQjkKed6kwXrm6kYdmJSUMlNPWA9e+eA4CqyL8VkQBH9
         8fbEUAdG6pla1M/P9seoEFsbufTzsEdyMWVSXFlXYL78Gh/cKejZHqTpbv6IzCzvwi46
         UZ6rMPvVSB243cfmIDt0/yNwEFliokcX8ql6mR5Pe5yT0jcpTZNU5SzLE980tUdVXfWL
         bglg==
X-Forwarded-Encrypted: i=1; AJvYcCX51XtmSMObFxqMZsRmvxA5Snf4lIz7t0mjwply6uMg7SqMKJvm6wF/lVCQFSAEWsihFvZsaSrAFt+PY+8OnKbW0dO818tjLMIgC+lOcht6
X-Gm-Message-State: AOJu0YxkLlZoe2u8rrUI0nrV5omQ/o2SAzCPIaAi74WuOcfd/+8wg5mW
	vmHij0mFxsoFnAqylP8fndp4P95DJCgXdjJan9CyFo2P+q7nLd9/c29jcyiMejc=
X-Google-Smtp-Source: AGHT+IFa9F+COKZa8ISch08bbNdcv43TGvP8EG5xj5dJ6X521KU5ZdxA9e79JCDBwefI9u7FZNld2Q==
X-Received: by 2002:a17:90a:ba88:b0:2a1:f3a0:181a with SMTP id t8-20020a17090aba8800b002a1f3a0181amr1796435pjr.31.1711704471054;
        Fri, 29 Mar 2024 02:27:51 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:50 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:19 +0800
Subject: [PATCH RFC 03/11] riscv: Add ISA extension parsing for Sdtrig
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-3-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

Add ISA extension parsing for Sdtrig as introduced
in riscv-debug-spec [1] Chapter 5

Link: https://github.com/riscv/riscv-debug-spec/releases/download/ar20231208/riscv-debug-stable.pdf [1]
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..9f8d780fce35 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_SDTRIG		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..080c06b76f53 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -296,6 +296,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
+	__RISCV_ISA_EXT_DATA(sdtrig, RISCV_ISA_EXT_SDTRIG),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),

-- 
2.43.2


