Return-Path: <linux-kselftest+bounces-7550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4989EE4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DB1F2220D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81815B108;
	Wed, 10 Apr 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h6HGpF5x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B0156962
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740276; cv=none; b=HvEf8ASmxfwWWj/ZJOU7BxNPMeT4+fP4Lo2HMLS7YmWwDUqWfi2/HXdFar8lEhTBvkVnprKym50xfAgKi1dJvbFNcHWbV7scZWH80V7skjYgiUwvz+GNaMeoA1CtJ6JQeiTw6HUYZlPwL/1HdEV//Gy5YRDnXxp78SM+xVpVneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740276; c=relaxed/simple;
	bh=Sq/YgFLF0vizQ6xS0hnRpwO6s5EiAcRiT8BZGOJrZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q16ydaIoHwR8zbz2/TZRcEPb9fnjPPH+bV8XXdpFvqgOfL5xQ+up8c4tcDTOSRKJ2RJMsXTlhTdFsPCeIjFyWENIe3ZpjFsyq+BVfbCHM0bnr2cw0wUmaEXbC+L7YV2DW4hGTW/oWwXsEEI/lLLXIOWsDwByvlsATsv7cEis9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h6HGpF5x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346407b8c9aso516537f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740272; x=1713345072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7nj0hrAb/ZTca31LKYsuyiwQEp4tEr8mY0ChFA9P/c=;
        b=h6HGpF5x46FdmW6HkWhwfDdwdLSRF7Edv6bcO3AsJlVSGwOx/YlPFrNyMOVPkVjBA+
         +ZkEje3raXv2oEWEkHr2qcsLCxZmi0FsZULZsMiMNwMXFA/Q7Eku/zQ82B+re4DWMGpz
         VFlxRtyYDHYd5/ZK1Vt6n5H9AnIgjjtsuoyleO60gSj82b7d5K4940LIFiNUPFFzuycW
         n/bdXvpRfS+GNfmt0im+Bmi4jUAKM6gT5qlhFna7UO3mug7HNcAAqmjx3O5qi6NIC23H
         hxpfQaBrtb3PpjjyIKY7ENj3YzIDlrHx1i/A8mf89CK4sKXIRCf9gZ+AgZHXdvdtbKpi
         AU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740272; x=1713345072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7nj0hrAb/ZTca31LKYsuyiwQEp4tEr8mY0ChFA9P/c=;
        b=rIc9yZHSyN2xCIxFzo0IliLZGXJR8JPE6FOVsXV2nSHSOU5gVKlf/RI/pI6O6TK3cT
         ke+zICTozVdoXOGCdOC3JQSF7/9U/+r8e/BiLTHBKgIOG99//vbaIEJ6frxXgtfdtCm3
         byAe32z+uvxNHa6IXVX9jVGmStZtWVVk2PdVcVqzWVRYXJdX5G/u3dedW1cRRUxNC8g9
         cAKeXtkvctJsyuRCl6RyHIC1mpc46k8MYE7wdhj7IE5mFBWu8aOB0/Piz3j78eNGIKAm
         IzGnwAiLjLAt8IzJqqI2JtFVj2zEtP9UmbUMAeWh/rJUum7zwQ6VcAl4S+rDS5l5xnLn
         PeIA==
X-Forwarded-Encrypted: i=1; AJvYcCWmlJC31kWbbrpZ1O3s+67fVAF9YX1QgCqM0XxGrK/eTzyR/N6aFISMyhWxxY3IQNuwO3ZRn4mRsNCZa5MPGWVh4l8q+PjSktFTj8R97M4A
X-Gm-Message-State: AOJu0YyX+bz07LE2Z7nBTtgqTL/LAGOydpNIXf/dJGi3vUh4r/wxyMBi
	YgJ/mbGWH7HXHQ3FWVOEPt9jrhPcr7iQDIK4iCUh3OJu0NC2XjIsidePRbXGQ28=
X-Google-Smtp-Source: AGHT+IEC8u4594PjRvl4MC3WnGzfb1LV/AIXMlfgTp70rfcnNUzoxfb7eYEGhKXPjIrc4Pbt7pSXrA==
X-Received: by 2002:a5d:4a4e:0:b0:343:c3b0:ee39 with SMTP id v14-20020a5d4a4e000000b00343c3b0ee39mr1259238wrs.5.1712740272056;
        Wed, 10 Apr 2024 02:11:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension description
Date: Wed, 10 Apr 2024 11:10:54 +0200
Message-ID: <20240410091106.749233-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for Zca, Zcf, Zcd and Zcb extensions which are part the
Zc* standard extensions for code size reduction.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 616370318a66..516f57bdfeeb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -220,6 +220,38 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zca
+          description: |
+            The Zca extension part of Zc* standard extensions for code size
+            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
+            RV64 as it contains no instructions") of riscv-code-size-reduction,
+            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
+            of zc.adoc to src tree.").
+
+        - const: zcb
+          description: |
+            The Zcb extension part of Zc* standard extensions for code size
+            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
+            RV64 as it contains no instructions") of riscv-code-size-reduction,
+            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
+            of zc.adoc to src tree.").
+
+        - const: zcd
+          description: |
+            The Zcd extension part of Zc* standard extensions for code size
+            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
+            RV64 as it contains no instructions") of riscv-code-size-reduction,
+            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
+            of zc.adoc to src tree.").
+
+        - const: zcf
+          description: |
+            The Zcf extension part of Zc* standard extensions for code size
+            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
+            RV64 as it contains no instructions") of riscv-code-size-reduction,
+            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
+            of zc.adoc to src tree.").
+
         - const: zfa
           description:
             The standard Zfa extension for additional floating point
-- 
2.43.0


