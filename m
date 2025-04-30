Return-Path: <linux-kselftest+bounces-31975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AEAA3EF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D32C9A6CE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B621B19F;
	Wed, 30 Apr 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sMC4GSVP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9446219E8C
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972195; cv=none; b=cdSmkDJnGXZhd4rQOzLYBL2YmyZeIav4KLmDBI2RAEjxfrTB3NJIQnj1/3I3CqRBPMW5a6xB8+kcGBpGkuPaBjwBWBtvMywab/UC88hEVg2QKlJcK9Hp6eeqnAYgVbyntZRbcIg2i7OCM++qG5rBZ2G2z+UIpdtMw4yD1rd0VXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972195; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkv6zi2FCItHOFE9nIdhnti+DvaOouFaZKZblMoh9EEl8kCUxDzZ3ZyRcFfIvKPueZSKdWCrpRQ1qq3v94XSDO5Pzoo3bNS+kyiYEv0MzONnFZ2G/hHlFMgehfiiV0wuiorPFFHencwwDhmICUedA6Qf19rgrY6ddE2OpNGoJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sMC4GSVP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736bfa487c3so5492262b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972192; x=1746576992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=sMC4GSVPZdq+3xo/i9GAPn9J7xS8K31wIwYHW6wZbRo6kUZQcVMEzq94A+VRNVp1fr
         vT3x9Z4Y14DR8U6Rj3Q1Uqkk14sdYT4yNBEElyVqkXrGNBX6UO0QOSOCMxlBAsGkDBdx
         yYwVhhSZhrOkWGYUDCWvMKUGp/VhGpY6pT9/iV5Obe89LtQ8W1iSpNrT6nn5Hivgblcm
         h5biWDfm0s7+2UtNXJ2qOBt+9TYt++RFJXXKCUVmo1OBCP5nDJWZSW5JQ4XBrkJbLkGz
         LRePUqYsvhRFm+9MQct1fHW2c12vJg9A7CZzaeuI839YAA+gDwA3g3ROeEgEdw7GjGsT
         fx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972192; x=1746576992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=e8LY/UxHut4iSPHZUS6OAnSeeyKU4F0qin70K6V8dQitvUgdz8rei8jrj/sC6pruJa
         wSGGioF/pumJr0DRcbHxjIIRGp7QOX5rUN3Po1JCcy+KAekFcFpFDj4tvBbjYMLWD4uO
         9jY8g0HtzcEQSwd/Za5Lh0hXiiAPopxA5IrmuXRFJa3uaVnATe/ODlsPvpC24plROlUS
         e+mJbcX8ORtYiV4Jj/lwgHXUmN9RD8CpIjgbsyT++6mTjU+H/sEmRbKxAzuHbAyHuVxJ
         +2HplRNDP5sWdtgx5eWHzi3gVHV7i7Kx+tFkfJLJorzbHsY4W4ZRKYknE3Axw8Vc/ZCw
         BhuA==
X-Forwarded-Encrypted: i=1; AJvYcCVBShvjjrcgStLRFSyC0kV2/ybcaSBWp3uVk0wSuyG0e+FKNNaqdqwidfrWc3y1+il3FkmKR8RIkzpfpGYgy9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0prTDRj44ayMgSEnDeoC4fA/6vfMJDEuycAymeaAYoZXPjIhM
	XPn7JBSatx5Ib26Jk5LwyNhd8b1duosqQs8+axqSHzvH1HmFg0gmBUgDZr47OwM=
X-Gm-Gg: ASbGncsf9MuJPaeBupBUEHWY7CB/Lbdam6bxJaC8+Xl4DPl0+KnaUZeT9KfZgNr05Mn
	iMaMVfkkzDgEyEBYFw/IsaaeVye3WT+aGc0dlqJm913adp1uR7kWcbngWGB+miq3PzoMAIGbPmA
	fdP8xWks2bLnWj+HRIXkAdufJOLM+kDk1L9gwj0z+aRWWWlTrxY9TuP1/vpbnhgKGYeshXq9cYm
	DJZisyd534+mN1s2+wVqS/QqdWgLydHhStU1jcHmjlCSR+ET6EY8qdQvahFHU0cowQyny10XfWv
	Vn4l6ukENVK3FvNg67aWn31xZoTwIxJgeOrr49V+BSJnKhVFV2k=
X-Google-Smtp-Source: AGHT+IFZqq9MjhSqj6zWUKle5rqAOmKZksHCBhGRQygZlDXBwlT0hJq0zTG/U4jkXRf2orxlgxORVA==
X-Received: by 2002:a17:90b:3d84:b0:309:f5c6:4c5c with SMTP id 98e67ed59e1d1-30a34450c14mr888187a91.25.1745972192207;
        Tue, 29 Apr 2025 17:16:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:31 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:19 -0700
Subject: [PATCH v14 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-2-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index bcab59e0cc2e..c9e68bdbf099 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -444,6 +444,20 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as

-- 
2.43.0


