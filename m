Return-Path: <linux-kselftest+bounces-8078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5B8A6220
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881111C22782
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16FE42058;
	Tue, 16 Apr 2024 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KSolLaZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF63C08A
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240732; cv=none; b=Pkdj6mNQPCN6lbW+j2E60nyd3s5ZLg/hyMQhpW4XCaVPnznp1cNzIm3Tc4nH9H2Ure6EEqR0G91XO+OB9sYjVyWR6z95xuiGJqKrUsd26jf3qjofMok98Cm6vF0Y6u1OcxaBE45u+rILK6Txu5Fm7XNA0d34h43pL/78RFunvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240732; c=relaxed/simple;
	bh=m0plhmdNbdmA80gesn/7KnCdXtvm5F7fdW9kC5KptxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJXGjNTKdJncALKxRy0uKkfJFBDpDaPGOrbAS1loT108emGO6i2Cjulb8bXgnP7hwkvfxePbxEORIPmLz5ROYcod5AvjfJ/IeIcizlww/BeMacNk35VfKGVfvcShGPbPx+ko9Eaovew/sG1prod/4OTRJQUwRqmSfsBhsZfciVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KSolLaZD; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23335730db1so2309667fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240729; x=1713845529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVSzHGFLNnrGti654VC11tvpK1bZGKmyJ0hbbIeQ45Q=;
        b=KSolLaZDORvmHMAd9QWBGgfyAEJoKPd8rzVkjMVt3vWlaJyoEMK5eTCfTK81uuyEEE
         OXdj1MyObjVj6eA7rXk+YbDXrVRiWXKFkhH9tFZ7o8vM4tYCuQakflIP9L42xHqOIdF0
         5cC5YWotZyBGWxSHqETdYDYTMbRt7y/MW84l2t0yz5TuOqXajtMXQ3DN40UqZyQNqBEm
         r2zd59hRDoEa5PakAihLudgBm1j0eBgK0B+V7nI5pcNx0qrgV0HJI2nwREWqq3p/0HO6
         QMM3PAacIcXKCj1T1zv2UaaDIpjZv/Lbq5W8DAeCRE58nfuBZmtignBPKpRfvLBSaZqW
         +uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240729; x=1713845529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVSzHGFLNnrGti654VC11tvpK1bZGKmyJ0hbbIeQ45Q=;
        b=bpfdTKUSCmMtyeeS7fFJaNlo4w6B8OpZmuPwoJ0z+MziUk8NWrLNgfkjfIrbCX8fBb
         FCpAm0toUdWde5fYVqEy31290iS+WFSX2Ql20nvT/jYX1+DKCx++ZNvSDbJKCPmwR5kh
         KkY52km2xobt8ear+dwsPF6ZKZ12Qka44oxyYe+gLmozXeoleu0U1TWOZQWwSdZWLPZO
         LQvklnC0AObtdqVQ7xvSabcM3rve3fX5Lt8y1NCY1VaXnXOoO3BIEFj7GM+TWDN+Mt6I
         2XMj1UM5U2oSwwddCCHgRddKRGNPWENyBz0Vd2+XXp3QbpVUuKPs2rFNniJwvvUBw8iS
         dnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgXhIk25fb1I6nZLeprO3iCWi2aRnizO39LaRtzbAhdBDQAmq1htcdpFDhOO59CwBDKKeBOfAb6xOEr9jdj6YkgdgEnjwlkIfHHhnWKtoo
X-Gm-Message-State: AOJu0Yzw4PTWbcS1yFw5bikODLBAQkTDPf7sgUvBW8NetvVG0EJ+l7TG
	FMDJ3y9DYI7kTgqXo1kq0Z/XQvExXDsWz2zCcOm5/5szioa7W76UmDSuiTltyrk=
X-Google-Smtp-Source: AGHT+IFZkd9NDeZNRCG3hOkxXiBzQioQ5hVlHYi/wzn2zrou30bpeRqjwOjjzziMFEa1WsZ5xhufcQ==
X-Received: by 2002:a05:6870:315:b0:22e:8539:60a0 with SMTP id m21-20020a056870031500b0022e853960a0mr12983308oaf.46.1713240729449;
        Mon, 15 Apr 2024 21:12:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:02 -0700
Subject: [PATCH v2 05/17] riscv: Fix extension subset checking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-5-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=1065;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=m0plhmdNbdmA80gesn/7KnCdXtvm5F7fdW9kC5KptxM=;
 b=7DRonXaAgLJzhWvXE1qbRYS0I+BfU0oGsBOBG0My2i8BWoHww2ZulgK6Ne5SIPj9jjmGT1fAh
 WB/f+iRxM2uC9jcfHku9va0/Bg5wWaTVh/Ak3KRIWgDEL+7zSph3JfU
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
than if ext->subset_ext_ids[i] is valid, before setting the extension
id ext->subset_ext_ids[j] in isainfo->isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c6e27b45e192..6dff7bb1db3f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -607,7 +607,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}

-- 
2.44.0


