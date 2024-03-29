Return-Path: <linux-kselftest+bounces-6857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB298915CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59477284165
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891A5026C;
	Fri, 29 Mar 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jfZsineP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142A4D107
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704467; cv=none; b=ASVYPRxlr+0V2NC9YvKVx+b9ZUhghnPCR1TLiu125NIxqheCWZPcprkaJfLBfWgUxJ6OCPx+WdV7W8g+vro9dQlrBH53s9cnGEDD9ioKUNynDsQh06EhIuLqJQZWs6Kq6bE0AQOs6QQ67dwMpfzdgaNP3vjZ/daz1G0xhFfxSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704467; c=relaxed/simple;
	bh=LSg/rLuOsrxnsspgQ4r75KW0fisxGsUYFmGBfMYsNR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lE/3e9aU/GKg6AAShyQrb0mV/SOWwUL/rIOnI0cxdWB+5Y88ZRvPhVyQZ3e2FMeOi58yFW2pe/GaCg+bRomP4jtP+l2TflLRHYsuJtpgmY8nb1u1F59aCAlZLmVTH9k9qSYCy0D/N5y2VrxfyiRNhT6mYuR3Mm9L/LtLwsj0RaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jfZsineP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a215582617so206439a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704464; x=1712309264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=jfZsinePGh8GvughMdULBUqVVMU1/IJRkTvq/SnnFQDY0Q+6enwRM+p1Y4Db8388LN
         Ld0i1RVKMNpoau3cAcSqb5TrIJqhYrW7P+fQz3J9IQJwOkKcKowBRgEsvr2lUU4DYjbA
         /0snbQzpo2MYpphrbq8vQGY5i4KqzuiwtPry/z1RnbZD0+6Z7gFRBshffAJ23D5v+uzW
         cxFsXRI/7R2j1NvNuFIxlcuapbcsxuuPFr3lv8UNbBysKwDbWFlx9IMC+SQBuCFDf3vA
         mAtSjLmfnj5tnMuaHSHq+O4ceHaGTfHdGvxbTVd48Jv+s4Ly7qh3TAv1BDpU6+Sp9wHq
         4anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704464; x=1712309264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=UVTImEomWg0XcF5bvtYCRz2PIeKFlAjKQvQy4XJZbwmVRC5V80UEVjb0I9tpPYUk3E
         HksTO/wIYqd+1Wrpjwiub3b85vRyg6nCaBRt94YN9E3HdjQEdxUuwmippjYGYdMzuX6a
         pxfXm7y9/vXfR2SEBeqE/oWQ1T8f9F/HFcsxROo9kf9kxiC/GUBPk0lWB0/S11FUX3g8
         q6Q5Oelv75ii4i1+YIT0N+PrG3UQRXaa4V5RKDUg1pV4cq0myiJqc1Q+A4FytXoTdBNG
         HD85M0IcRzXYvwteYz1xEOp1QmhHdnvHzr2u4YSAxCzaWtVAMKg0AUaqHf12LhXwN35K
         jOwA==
X-Forwarded-Encrypted: i=1; AJvYcCUUttcKR/yVeYK90RoW/9Og+iij+ycXIv/21YFwJtPxy6SEziHkmHvOGhaya18G7nGNnHK/qhUAkX2mNfYYXujk9/3P2jsmk7L9yhWawHCj
X-Gm-Message-State: AOJu0Yy6WIMcDbXNMUdaZWlU391Ir6oxdqfzZMRV8F1m0Nv0a+/n3Zmu
	YobUhNzVcNKZrymccBwPjQchrFdiy71KGAfiFDpZduK3eFFf7nIuDE+FG4qnC2M=
X-Google-Smtp-Source: AGHT+IFlwBZNBeq8Vspi+hcWxSywtk3eGAD9nkXigHO0/VIsXQXySmGGcQSPVllJIcGqIgMzGVu2Kw==
X-Received: by 2002:a17:90a:6986:b0:2a2:1012:fbbf with SMTP id s6-20020a17090a698600b002a21012fbbfmr1808164pjj.14.1711704464008;
        Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:43 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:17 +0800
Subject: [PATCH RFC 01/11] dt-bindings: riscv: Add Sdtrig ISA extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-1-1534f93b94a7@sifive.com>
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

As riscv-debug-spec [1] Chapter 5 introduce Sdtrig extension.

Add an entry for the Sdtrig extension to the riscv,isa-extensions property.

Link: https://github.com/riscv/riscv-debug-spec/releases/download/ar20231208/riscv-debug-stable.pdf [1]
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..47d82cd35ca7 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -121,6 +121,13 @@ properties:
             version of the privileged ISA specification.
 
         # multi-letter extensions, sorted alphanumerically
+        - const: sdtrig
+          description: |
+            The standard Sdtrig extension for introduce trigger CSRs for
+            cause a breakpoint exception, entry into Debug Mode,
+            or trace action as frozen at commit 359bedc ("Freeze Candidate")
+            of riscv-debug-spec
+
         - const: smaia
           description: |
             The standard Smaia supervisor-level extension for the advanced

-- 
2.43.2


