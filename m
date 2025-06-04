Return-Path: <linux-kselftest+bounces-34304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C6ACE2E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B898116FA66
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE391FBC8C;
	Wed,  4 Jun 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YYZImV4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8971F8690
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057381; cv=none; b=u5Ll12gPmChG4Qj6v8BGBTnt1ztGNXqB8RFNSIE4yNMU2wIcAdrTUB9bu2QW40AeKriOBIfcLeTh+N+fSdJnr3SecyXy7aj29+SXCSG9GUSFeKJlD9sX1diBr8AiYVbG8Y/OwVpyKYbsY6mDxgNCCz9XWtlOVw7AE4RHWeDiMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057381; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRmoU3UZAnKW7W+/1vW0Qqio13nLHsbkddzK1iGIm2ayjbVJwIZhJwyQJ7rDFYFfAb7j7qXlIi52YEAESytSD4scUFgKlUP9f0xKC5sPxbiXYHf1fceCwH3XLkU7bOjiJ5FrK5jntrEPAsoDbdyyEeP/ClCRlltpxxrZrDp9VJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YYZImV4X; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3114560d74aso106820a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057379; x=1749662179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=YYZImV4XAxaoX3dv1PEm4++u4SUVmagxZ5gO6578St8oHtI9Yq+C54jWNio035aFQf
         drwQ3kAA3DWXVEF6TtBub4CmoS9epqX1qBGuI2QO1+5lZXtOBTGVE0SX03C6xSAu9fEu
         Tr4zKwupKeBjLdh6ErJEYkCd1xy4g4jnxDH1Ym8H+SxRYMkeBUIx1FYBMlN9119NH5dL
         H1fBBhuK4mjP7hF1PqMyRbvfRpMV3oocFkNTwwctZ/K1t9RfRXO65DhgeYUwBGmf93Vi
         gIKTKg08X7Ew2fjPwnTqqoPyW+YKVNXypYnZ1w5elSzyRmmN+/u3Q90Vq4S8Si7w+AHt
         Q6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057379; x=1749662179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=kPLxMYYw3biyOU7tnxjlr1UKR48gfXM691xxPLATyPMrWFKBoDwNyE94D9XQRaK0kp
         PBueRFa9qfgO1CWXsWymMycywsm9sXsMeUWVGdOPiydVO9szBLhCQ2MIptMNT5bm6Xqk
         fwZV33cuAPi0BMuHKJTx9W1okUIkuBt9ROyPcsH3NAI3C4bvuPwXE97EqaObhpEMhVFY
         yZ7P72DnjLzAJyqKAKgc+HZlK8VsC52zfHwlpMGsDTHw185PviS34LUc4h1kKxKQfe6p
         8mquCBBx8gNCFym3w2Q7HYwIvzRn7jtRl1NhE85kiQol9GVoYfVQAsG30q8NBT8UOWQw
         aOCA==
X-Forwarded-Encrypted: i=1; AJvYcCWAMWVMcLIBcDa6ct6fJ/O/jW1lrT5FzdR4q4tshGwjWSTV/maWkz1OB+8ctI7nAMPMNAPFa8M5jcfvy1zprZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQL7hyv6l8z2hdC/LJaC2GdBkpM6dxP/6Deh2a47ij1No2JfMA
	rxJNH6v1xM2RK77S3H7JS4SX0t2QHA2J3143X8VPZ5a5kEW+DYdFadVyB8G2s8kkK/g=
X-Gm-Gg: ASbGnctDMVAmaCnR9qkAEmsnEI5iJqIG8WMudm++0UoSDpU55W+K9CgTOT7LFigA/T9
	v2n+Xt3qJhgZfylnZ7CdjvrNd1A7EQe5VsSmW2adCcGjx/8B27IId6cLCOZUSWS60khyDDgbw7P
	7T3wCi151aV7zmnNXWArFvTBKZvdoqIe9JfbsMRw1p8OpbACFNRGdpCddCJK2CPAMmK+vlNb1EN
	Z67U/qhDJs/bNG6bqFdoVXCG0+U2H0TzfSNXfN4XmkYJiDp0k1d0nIp8EEu6rXWkq2bPX6pOmhZ
	Ho75BD9LuYYwfMjoMGCHfHVmgB0LQ5g+WYS8ER8sR6l3tP9TNnBjdIjRb2MBVDDyXfH7SmL2
X-Google-Smtp-Source: AGHT+IGkexVwRd4MBugt686K9ooA6BwNW7BY3mlzIvdhU2r4+d354fip8huOwZDJ0pdHlmWrSOoHpw==
X-Received: by 2002:a17:90b:2692:b0:313:279d:665c with SMTP id 98e67ed59e1d1-313279d6ba1mr1336750a91.7.1749057379093;
        Wed, 04 Jun 2025 10:16:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:26 -0700
Subject: [PATCH v17 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-2-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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


