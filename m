Return-Path: <linux-kselftest+bounces-14897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C8949CCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8231C2198D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D762A1DC;
	Wed,  7 Aug 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ypIPFMcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5A801
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990709; cv=none; b=V5avBT5BB/lBbC8K3Pi3wQ6GbxEhLBt+V1HDrNitxSbGzvlCiIW8CDe+cyKoCDJOi6ICFdh85Y4Geo9OLaJxmuN+ry9OYpGEs0uwkL3tcvzghDcttIV/dGHSL1iRRCdnzL6osCkedptTxlio90UTpqw5E2mbX5IW3ET9Dxe/Pqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990709; c=relaxed/simple;
	bh=n+1uXcpPSzDKbEZ3gf2yswWeiNf7ojNdJOC78EyvEvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xky6kdmbEXx0yWRVE+Kus8t+D5bvng3rPjK4VBpna2vWlISp++t1+ydNmFRxieX3em31hBGEFAoz6jZO+TszdRdIqkyMYpoqYZMatPndGUeJ31r1CZCb0PxrobOUaDenMdiVHqUoLKrDipcHmw+Pyt2ULRYr+soAb07tYd16c+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ypIPFMcU; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-396675b83afso5294275ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990706; x=1723595506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ+D4p75bjfTb0EItLpHxQIjWmqIJlAlnUMhz5TxedE=;
        b=ypIPFMcU3OHL0qJDZ3y0caYBKvHI962PrVAt1GWoc81kSuKXCMFs1PWDlLVnXmx5Pe
         eNn0fyJkfcKP509IIFoSfLpH7HA67E0GZbDwH9p2gp0x/v2kQMU0EDr8IRIE/NJWjdsZ
         mm+S9R8HfQBdMybkGqoSa8IkRukgnA3p7A5zJqNzOENxiUKqszgdtmV3XhjGsdPCCKEW
         pi0bszNcW2fgqaCnNNh/VbCji+q6H3BiwKNyi6+QwHIT6AF9Ecpzwn2qlT52dg8CYQwi
         PI+L+riMeIogJP7SZw7p0GSBwsgBWg/OrRsGCbjv2I5OGpBJMojBXiNWVGphyTx0cJkj
         Yscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990706; x=1723595506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ+D4p75bjfTb0EItLpHxQIjWmqIJlAlnUMhz5TxedE=;
        b=NQve3d71xEHG8daTl3mnQvox4RXcC2mL4u5UF09u0F+NYa0GWNYTUwX4gZsyPhifnS
         0MVrE0NVk722VWwmxjQnfMeCUSLtli+hw0Y2uUI1oqK5sXsd79JZFelHxef622xQom11
         8+ybJNv/GCby927wobWSfYhOGb4pp1/Hx/zfqSJtQLPihPpRkfd8pltsI5w4ZO/XOLcb
         diJQnwiCoAg3f91Xb8B0Op4EKOrjqrwhBW8HQc8G78j+cs1ze/6Hx6BMoxruSCX22NJC
         ml0wD3odTb4Tcg0x/VaCo3YX/Owy6mUnnqFtw6LnTCBchUgQXhPeripOXEfJPuPGMa1m
         B78g==
X-Forwarded-Encrypted: i=1; AJvYcCVfPWXGP3jN9JP9Zn7AqucWGviiKdbvHJZqpUe9oKK/7LMzQjCr0Plh+B1SQaPATmR/hoVqBsKGyohmxxzVuj0VdJO+R5vUOVX+qsbSAiZr
X-Gm-Message-State: AOJu0YyFXQ63GePaY0INePcnsRrEKtQxCWxbE/IJ3qGIgPOF8tYsA/S/
	bgrjMABOrbGvQXTes5FvpN1aM40ByKlBb5OMkF/wpvTyIC19sEJxLAvmZH9DtGg=
X-Google-Smtp-Source: AGHT+IGt3XlJs5WA24THRxvIb9/ANnk9itE8gX2KWFij4dZh7cIbInKOO2OSONSuPSefGVoo/Wv5/A==
X-Received: by 2002:a92:c003:0:b0:39a:eb26:45f8 with SMTP id e9e14a558f8ab-39b1fc1caf9mr159350705ab.20.1722990705710;
        Tue, 06 Aug 2024 17:31:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:31:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 17:31:37 -0700
Subject: [PATCH v9 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xtheadvector-v9-1-62a56d2da5d0@rivosinc.com>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=1788;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=n+1uXcpPSzDKbEZ3gf2yswWeiNf7ojNdJOC78EyvEvs=;
 b=6O6Y/O7ilQvMwXHjXH5ncVCTt0keW9yY1oW1bUdxC8xpCAYGnrYGKuz4ml0Ca6Y2H6csZpNHV
 TvVxuODA9RcAT4JN9cvY6+06cznH6+IJFj8SS27BN5w4qhDRIrivNt7
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The xtheadvector ISA extension is described on the T-Head extension spec
Github page [1] at commit 95358cb2cca9.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..1a3d01aedde6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -556,6 +556,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -563,6 +567,12 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
     allOf:
       # Zcb depends on Zca
       - if:

-- 
2.45.0


