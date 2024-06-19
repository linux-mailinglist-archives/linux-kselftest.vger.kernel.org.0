Return-Path: <linux-kselftest+bounces-12225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36D90E991
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668FD1F2358E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC503140364;
	Wed, 19 Jun 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u2PEiiON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C413DB90
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796940; cv=none; b=X2QiGTMKXp2vDgOTyvsuvu1jaWOfD+C6Gp6dURxmkHK+P38ynicw1QVB+sxsKXF9LogU0DJ3r2gLLoN0GWPU/ThK2miRDEFiSFxDqxBXBHo+i0odJ8PJSpZIsuKnzx6wHYP5HOC7D7S8tQSGxFmfwuVSK+EJbecga6MwsQV+S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796940; c=relaxed/simple;
	bh=/pPeKAKHhM5dioXaKdW0+1A0gvhpNEvKq5S12HlRxII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7kbfxmMPn8jchEqdfQ+puAbMbatETbeqWIkLztraC8SbUA4OEMhc6bxL5P49NDFoyZXi2eYyhEy+65qX0isBUFlWEdg2QzomgIJQCq0Rlv0U1GFx2wonX39x/7xXdjYFEfG65FklZyJnCCNA/TnkHA+4NBtCXZssaWb5Us/Ls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u2PEiiON; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebc724e1fdso7522641fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796936; x=1719401736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0PmMBKub5I32kw3OQ7yKpgs2VnUnUQFxbp3Wubvvb8=;
        b=u2PEiiON1zgiurpdfxaf4OswkXZ+PMZfbMryGz94S+ZhT3B5Bf3ftzJugcD3uSZ+bt
         wnGzaf6ekL34WXAaOHeFdnSrbH8cBOVf2dpccTrsPc8iDpi/J8BupYdmRXoQ1OCbqjgZ
         XxlqS5jM6f6/DbphT8ttubV5zv1/QEgQQ2R46lJhEDf8t95X91wErUNVXy6hrN75dPyL
         CNRhEmgLJgShqMa+jPRvv9yaKKXldQf+HKzG2Xz9NCWlPsIX8x8ZmhzrNWznNuceKuCL
         w2bznsArys1UhwUtT/TpPz8M/uFQTteVDg9yA3MrqBDHZg3VRUAlsBsmyHWrys5XpFKL
         EFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796936; x=1719401736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0PmMBKub5I32kw3OQ7yKpgs2VnUnUQFxbp3Wubvvb8=;
        b=D9oepLayZiUxjXY3xk9UQboqjPwP9oI5fBCzmgtnsR2AlEyjMvasXI1hfso8qzGzvh
         We1j1OU52lcnqnQk+gI4BT5iFPyp2C7JQr5Ed8pMYBe3oPr4fH4u4fEd83aOuqIkpjFz
         vcgaYr7fHo0vAJbTghGjYtX96sbuuGZHlqKXpDSm39zyAqU6VowJsml6Qx4bJfuBASuk
         9C282+YUG+zbzs7Pcy/RJNUpqPjZSy1oBXpCcpYj9+58r3Oct3dyXQdSXYo0jNPKacdr
         zWa0peXf3tcO7ZgE3z3sH4vLraBClfLwM+4lhi84XOiV19QM6nvqGbou5obdK3e8TpL+
         aPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDtnq90xByZZMq99N2dnv6D3IBAiv58f9UcBzwtSHczwi1RxtEZWm+37IWWif3DjveqqAbbxnczc/XBef7BSVYuVe3GTiMHWQlEEHiRnyI
X-Gm-Message-State: AOJu0YyLTdiPIkRA+t7dr+AOrQDIdL0B9BrCGg6BoAA6Lb3rLltJFFUi
	AEj3Vow1Zwq9Fy+xm44iNRzJEFlD721WJyUs/XckqWsPZYeaJDj1nG1YPrraFTs=
X-Google-Smtp-Source: AGHT+IFuiQe12ySMx1uVFaLMWupgr3h/vsw4XsgpQWD0r4gVFKJnVvYpOMaUKCr84w7Jsgw+DR3BMw==
X-Received: by 2002:a2e:a553:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ec3cfe8333mr18233921fa.4.1718796936025;
        Wed, 19 Jun 2024 04:35:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:35 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 01/16] dt-bindings: riscv: add Zimop ISA extension description
Date: Wed, 19 Jun 2024 13:35:11 +0200
Message-ID: <20240619113529.676940-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619113529.676940-1-cleger@rivosinc.com>
References: <20240619113529.676940-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the Zimop (May-Be-Operations) ISA extension which
was ratified in commit 58220614a5f of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cfed80ad5540..e214679ab6da 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -363,6 +363,11 @@ properties:
             ratified in the 20191213 version of the unprivileged ISA
             specification.
 
+        - const: zimop
+          description:
+            The standard Zimop extension version 1.0, as ratified in commit
+            58220614a5f ("Zimop is ratified/1.0") of the riscv-isa-manual.
+
         - const: ztso
           description:
             The standard Ztso extension for total store ordering, as ratified
-- 
2.45.2


