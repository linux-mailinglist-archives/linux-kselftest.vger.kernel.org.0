Return-Path: <linux-kselftest+bounces-8960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A48B4164
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E579286359
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A63BBF7;
	Fri, 26 Apr 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gew71aKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60F3BBD2
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167450; cv=none; b=hALWguVJsyIjsJo9B5HLyJ7QgL/aLlJNcKR+mfs3GUNKnlUcm9qv76GGbnOlYUgZxusepGc1lq09JvHBcnP4Dyblkkq7SFtlxX7Xj3jFSyGbciUlkWAOP3FVMYEDL8/uS52fpwxNrxosdYXcBvZBAe05UvwgS5kaIrW+qNMFlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167450; c=relaxed/simple;
	bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6Ob/BDD8P3+bImdwdQ9QLMdGU+BDtZxc4nbDr7O2RlZLwUHMCnQrSgE9pVG/LTkQ2LjmcEkg6sos875mlJB/ULyBOlsPY8yPSgN5Ew/4GEdoShS6kvAMCZEyuHzjiY/58xlZI54kE3OjPe4gNX2tUc9TF0oEP99EOiE1RENu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gew71aKb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso2432172b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714167448; x=1714772248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=Gew71aKbtnX7tkzWcsPrYnexoF5+m8Mk5r7y9Az3JIz/PgKmxXoue3Lvc7VIUZLTQj
         w0pzexSy6Lt66pPmBD4XEx9f09a5jsWJeh9GBzSNYldiZc178JzeX6PqD2zgEX7zMmy2
         meecQvguPPnNrVWJTgNnOJLvjOa7fOP9ZipR4pqsQUOzCG+9qWEn4kzkcEYOMEFwVH8y
         DaDjSQeu0ikvg+s9CQJMsq1+ccApDjvITOqokBOSRQ6Yc3wa41Ty65qPxY/0xP9papZJ
         sDEpFEMC/YWIY5Fa5m9A0sKxeOWY0UpneYdCxc1cDLgIGbI4+H3BqpMeqbkc9UOvsV0R
         hRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167448; x=1714772248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=gNBQ4cmNQFz3R/zwxIbwmb9ehNfm0OVoigmRDUhP1o2Kgem32wjrw8VUiISCYR4Vsv
         orcSDt4VJxy9dZKXLfwBAxMvq7mX2UbmbpPu1f7gS12jsdIrW02nXSnDUjuPviUETocz
         JwEKRLmHwtJU6QfwaXaJVx6cW3tGsuk9eNOZp/hqOnJTqnes5VMgimyGywvxgH/5Hbi+
         oRPXuC7g200TqgMaH2DbGQhmGgQktsxA3gWSadrAtrptO6fNPEjy7/prIipbOCGJnkHx
         x61xgb+fR9j0/wG8dFr/yfo39QpTAupYOcGvnjJXia3aAmMgSDbJCdCFNMLF1Ms60ULo
         X4SA==
X-Forwarded-Encrypted: i=1; AJvYcCXQfTa5z6T5TMp1GED0TrxY+I1Kt7Pj08+4SHDTiE7xFdbDPIc5WrEkaAQj95cHH0EYbD53GkZg0DLhVtQbHTwCLkpW51DfNi/Ih2Wyql5p
X-Gm-Message-State: AOJu0Yw2n/7CKwZOZfz2Hhz0pXJrXkfZSH/lryu9N7d3+iFveseM0z5i
	SRTkG05QyjbsrxIK2fHQBo0hVgVaisPn05aeoO7kGEo+QinYlSfEZLYaiw/R9PQ=
X-Google-Smtp-Source: AGHT+IHm5zjW+ioSlduj4IUVa22zr9qzjWQiXQZ2Y/v/laULdkXJTWt9qYlN0WXsPxl/15hsWAapOw==
X-Received: by 2002:a05:6a20:b112:b0:1ad:6e6:b494 with SMTP id ed18-20020a056a20b11200b001ad06e6b494mr3747995pzb.54.1714167448210;
        Fri, 26 Apr 2024 14:37:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902760400b001e2936705b4sm15935701pll.243.2024.04.26.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:37:26 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:37:09 -0700
Subject: [PATCH v4 14/16] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-14-5cf53b5bc492@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714167425; l=1205;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
 b=e/cAGXYDWmxX50AQyo8xsB3J/G31Eq8eUDUhpDifz2FCc5Ho3O6JsuFEwtpQxetc2K8CMG6gP
 M9udTAsKA4wAkZkxbNvpvvFbbz4MRw/af9XgaK3F9Xx1+v4uG+N2dmN
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..b2bb305140aa 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


