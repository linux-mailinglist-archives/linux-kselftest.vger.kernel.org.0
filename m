Return-Path: <linux-kselftest+bounces-7772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86C8A270A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796E62896EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D424F898;
	Fri, 12 Apr 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZJTX6YID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D874F5FA
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904562; cv=none; b=R8QtWtncqJl15scfIgZQLXoCaqGnvCzrclJb+iiiYqD3CaNks6B/c7d5AyZ7cebaOYJ2l9SBzJtCzpANeFT/wScDYs88FvXc7uQ/DQ7DCTbiXu4/4K9pEI9xqOTCV9Ao6q3ozUHrw5IPmRboJKa+TZ3dGC1XqVJgxdkJXgUesSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904562; c=relaxed/simple;
	bh=3S9fzgrhpr37e6u603MyEzK4ZDEnNNexKCWCZt2/GWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSGapascsxejFdNlxLpk3P1oymS6fuxkCC+FtbBmMm4OXG6wFLD1dCx40H1OWM9L+Xnrr7BsUAiQibCDVsbQmvyeMHew/NIk55i/UX58uICgni7BGSAikrgfbdlZtvv64YalAanA4p1jomLxmXr995FBv3MxMeJaFkYZFEl0w7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZJTX6YID; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5715a9ebdso5790085ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904561; x=1713509361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmjJM7prKhSJUQ/iHjZSKFVAIwCvyZorqbvL8NpufQk=;
        b=ZJTX6YIDsUIvoYWIEHgNf3u2ZCqaUCbxV5PuIoUXUlEjRpWoW+tPRYncGOyQyNw4CW
         U55Us/ijMyt9WAi5VBI9dm/9Ap7oQgJsfGsGLeDqH/prbiIXINHMOfZn6gomI24MiFMi
         rZ6qRW4Pxs9MOb+WTEOHi9KUmjYHP9BifRbXOwHcrQtqbmnOUEoiSDx2UL4Bu7EHaomZ
         xBLWWMMaeGE/d/+Rvod+lDSiuV+JlP5QmSc2H9aei8Iqf5s5lzd4NFeRmuIDejbxla/o
         sKKLBd2IEBfmwdTXD5r213SPTtiSXPPAsqWc5YQK95k+aivv/2kTtXZ6LCRwFcIRZwf2
         TycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904561; x=1713509361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmjJM7prKhSJUQ/iHjZSKFVAIwCvyZorqbvL8NpufQk=;
        b=JMIO3jGvTB5vmvDJeyzfSSnlnQPp3MEiPUN61Ph8zsDh0uQG3YEqUnGTK9lCNIPWHW
         T3VwZkdK/d2AcXwd2tWp6MvahSBdSlbZitPIlaYT8jAoBo4dgd4Ippb2vo7JCXBmNtdL
         KHMwFpQxqtdl0LVELgutSTTbLB48HTndmEkct8GwR5W5ITn+DTRgv/7zeEI6arn6DLbk
         liyKjVkAgnTcDSOTtL+Nvfmp9jY5RypUJBy2uHM/Bnm8xq5L8KCEUBMkCANehwUu5Pkx
         UGszh+rNl7Tz/H0dpZWn/8iS9VC+kIiH3cFYu7ArdbbY4OwcLtnOW5YEXbqDeSHD3ZbC
         ld3g==
X-Forwarded-Encrypted: i=1; AJvYcCVu1nXuuuQUWQ1fBgX77ypIuLzOfWqRlzVwVKgMDxcm3IJk/6cMT1K65nPFW0dPwY/2lkY/7nAnw5/lee2+5OcIsIP40hMsKZoBYaqGoU19
X-Gm-Message-State: AOJu0Ywlca9ATIM+u/I1AmUtKZIgEEjb/9WcPhv7ZubgEIoic3qdkb8e
	IJBUoRe0wUR+Bi+qE1HL3XeSBVkDpiMwaZ/BOxgfkwgJPoPqqIQPk5Gif4BzRX3skVo5yGmFyx/
	G
X-Google-Smtp-Source: AGHT+IGm9y8I11+R6SyRv/t5G6RHmcLUsT36+9WxupmJkWY3E0gV+Me9Ik9kATEAv67/WzjE2CXInQ==
X-Received: by 2002:a17:902:f711:b0:1e0:157a:846c with SMTP id h17-20020a170902f71100b001e0157a846cmr1494556plo.55.1712904561015;
        Thu, 11 Apr 2024 23:49:21 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:20 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:49:01 +0800
Subject: [PATCH v4 5/9] dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-zve-detection-v4-5-e0c45bb6b253@sifive.com>
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

Add description for Zve32x Zve32f Zve64x Zve64f Zve64d ISA extensions.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v3:
 - Correct extension names and their order (Stefan)
Changelog v2:
 - new patch since v2
---
 .../devicetree/bindings/riscv/extensions.yaml      | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..cfed80ad5540 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -381,6 +381,36 @@ properties:
             instructions, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        - const: zve32f
+          description:
+            The standard Zve32f extension for embedded processors, as ratified
+            in commit 6f702a2 ("Vector extensions are now ratified") of
+            riscv-v-spec.
+
+        - const: zve32x
+          description:
+            The standard Zve32x extension for embedded processors, as ratified
+            in commit 6f702a2 ("Vector extensions are now ratified") of
+            riscv-v-spec.
+
+        - const: zve64d
+          description:
+            The standard Zve64d extension for embedded processors, as ratified
+            in commit 6f702a2 ("Vector extensions are now ratified") of
+            riscv-v-spec.
+
+        - const: zve64f
+          description:
+            The standard Zve64f extension for embedded processors, as ratified
+            in commit 6f702a2 ("Vector extensions are now ratified") of
+            riscv-v-spec.
+
+        - const: zve64x
+          description:
+            The standard Zve64x extension for embedded processors, as ratified
+            in commit 6f702a2 ("Vector extensions are now ratified") of
+            riscv-v-spec.
+
         - const: zvfh
           description:
             The standard Zvfh extension for vectored half-precision

-- 
2.44.0.rc2


