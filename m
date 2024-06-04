Return-Path: <linux-kselftest+bounces-11185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E68FB289
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9457D284643
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D9146598;
	Tue,  4 Jun 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eF/SBaRk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632E1459F5
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505183; cv=none; b=b/nXjPtncVR7e4XbqugpGof2VqhPJoCFXK41FbNsS995GoVQcSkMx6dfNARlYOWODsPsIzz3y1CC7is9b9pGnnLBYEd3lUTNb8SiVV4j5gj5KozBJRuyr4k4mugSIkEuaa/x5eBQXQ+D7cWS+ngtT4Z5M+jSUsqCmsZrGBxqrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505183; c=relaxed/simple;
	bh=krQUkNfTKWTUKxvKlFPKtZuRRj8DoTRNLSytjvedMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Exj82GBYetQLY0X4yk71Xa9NKTUtL5bjXZ7TzmGJgHIWVNOrh9RgXmypGuq/MqaZhsg5eubMHNT7cgRN3CO2kdlF3xc3J4H64+g/bboWTe/QJh0lQsDx3FANeLLXwQBkjoZSJluahEinZ22XeyrbCK8zxIlpXx1Ig5S9FJ4wZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eF/SBaRk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f63b8a28a3so824355ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505182; x=1718109982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkPyoR3KU3XSm/AEH/d1RonWJjnHK9mNu+9RmdnkI1w=;
        b=eF/SBaRk3tAWkysYLAjECFL6buehXgwpMdB3LTW5CSwijWPldsY/yLYOWvPh0Jmo4l
         m9SZhSHEPzrAyXN+ox8yYduPwTdSz4NVi5zSXXNEyfuuU31FMvV4aOGzgCUDYe6E9/DQ
         1ds7aZK+GmI6Zfqc/39o0xe5FBSdGTyuZcv+dEZJKdd7THlZOTQCQiT6xcRzgC5zYNtY
         gXodEN9p5ERHOGevegBfzgybLu7V9NQy32tuPKDXp5JH3f3BjqPFBDLFIP7cqMZqhfxd
         aEd0a+QPpgB/PAw2uKxvOUnavsKPq4pgWMP3G1V1lQPmzQ3lNdZxfvChpxZtnxyAnwYk
         6dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505182; x=1718109982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkPyoR3KU3XSm/AEH/d1RonWJjnHK9mNu+9RmdnkI1w=;
        b=EtPqQQOqlkmTg0u3ch9aIcOAPTwHSWloFJpWwQBuslopuGWxEjTFybRTDSoXlu6cjd
         YmHJkh1OuGoaTx+SPXmHMUxtX/a+oc578QLSwqzsPNM+ZKwlbDPzrvsz0ewtTpHwSz3w
         XzAE4NJsxzVEQp9LKYsqHImhN1DtgGuXziNIpjmdHkiZhYhR59h8PEEpG38bXPvkhkhi
         Kd4wQAp4kVxYZ4j3bqucyHuJPPYMvsMouxb62tuNJoMgQ09Q+BBhCyt4p4jawNmsio4z
         3C/bqXTpXDC75vxL7/ue4UWJa1ylPsK31zuDF45xrCpTk4ZzpAwZfu22rNqhJitPnvfw
         IzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbVZmebgA2C7b1wgkgE6JL5hXCSX+HpGcHB5NCoT9FRi4ZNBMAbGlQv9Gm1SssTPZ763NILGZnCsZR783UKu1U/JsXDO46Blol9B6J/2wT
X-Gm-Message-State: AOJu0YwcrtMXZP+LZk5cZhQ8NoblJHWOYAKfNgafKq8c+YzBwLL9p+vI
	ey+bLYcwcoR+cayd+ldW0pBLqjqnxNgpUWHbgSd6zjq/IJs/VVYLtZr2FUgnii0=
X-Google-Smtp-Source: AGHT+IE7Gfwq22B4CqIBvkHs1xIPksWu/HDt59N3pxzuY9J8Ym84nB3KvA4Wk5h6TCyGNl1IpKdoHw==
X-Received: by 2002:a17:902:ecc6:b0:1f4:8a31:5a43 with SMTP id d9443c01a7336-1f6370b3a51mr135960905ad.4.1717505181811;
        Tue, 04 Jun 2024 05:46:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:46:21 -0700 (PDT)
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
Subject: [PATCH v6 01/16] dt-bindings: riscv: add Zimop ISA extension description
Date: Tue,  4 Jun 2024 14:45:33 +0200
Message-ID: <20240604124550.3214710-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604124550.3214710-1-cleger@rivosinc.com>
References: <20240604124550.3214710-1-cleger@rivosinc.com>
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
index 468c646247aa..616370318a66 100644
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
2.45.1


