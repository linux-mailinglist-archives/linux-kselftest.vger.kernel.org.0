Return-Path: <linux-kselftest+bounces-38141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF17B17969
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FB581D97
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1127FD6E;
	Thu, 31 Jul 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3WW+1+89"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF527FB1C
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003966; cv=none; b=UmzcG7/LXbxVt61fKlqA0naq3q11BuSszBt4xVNI/Vvzi6ztlwiS1fXakzwNzcTxWTdk2PJaxt3xNWzPcZn5oC6gyXrWl85nNRvZIeYzXx5uTe0xVZzdMB65PvVP9MUFVKzVWZbD++gh3P9/Ebug6wXfnc5hqKIEkPdZ18gtXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003966; c=relaxed/simple;
	bh=3rWM+6ai+GAHLkW+NDrA2ZDlcBd4pzb4hc2PSkPwx/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kazr8V284K+lwod2D08mAtjVivfc3Rh59Ct2dswQNrsv1lel/urI2WaxBkygxUjjQoUhrn6Ck+N4MKXHCluaeRycBcPRTJk5SYBjGB4zT9RW86VQgy1k0+d2z2BnK3CdNpsqFdFMZIpYiqxzz3VW4Gm8MUfi/le6WjT8k63B1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3WW+1+89; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-240418cbb8bso10204285ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003964; x=1754608764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AetdkWsxzLbheuZJ3kb+4mhEhv1uz8fN4NCKhkFj5X4=;
        b=3WW+1+89GrGqIRUcnWC8S3IqQs//0CNWXN/TdYWW+0ZxImOPxz2aMvJccR7N2Ae9SG
         SxGdo50LtHzE8GH6kUYxjv/leq1uFrLZZCk/j9CaoRpR71qe5bSvtymSF1rrV2rHF4Cj
         l34pp5J5NTBN/68zJiS7eaNNcks2zUe4nVDrLTxM5aFob/vfCg8+KmDhc9mfnRkXYRq+
         4142K1+onHJ6NwgqJ0baDHXU4yfoZesve7GkeRJ+GbG0K/C1rbleOpRCbkeLnLV31fbi
         kUh3bIhx0kdC1fuP8yuwwfbNAxuDzy6M5PP2ghFqBgVpNMbKJWe6QnoYXpmIAoDo2bSI
         jTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003964; x=1754608764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AetdkWsxzLbheuZJ3kb+4mhEhv1uz8fN4NCKhkFj5X4=;
        b=k/QHuVnHDz3r7KKa4QqHlwtqPmezLbixRL214SSPwaBBnLxB/1uA7DpJE6msatVpQO
         YCPsFAiUCvBbIpOrHsySdEtVTcvdLv9Kogti7pLNI7r1hPXi/PZ4m1gprszCTx33pKP3
         9rXcIaw9yc3zaTkOJELwAe7sqp5ImrfEFJEA78SBs2H9MLvApeJn+/wsQ6GSam4og0pE
         ktFJkQTv5o+LiStsP6KCpqFzGMuRWILpf0Q0vLoaeWQ7sCHsbSl4XhkdSjy8XPM6D7yr
         ExhUc//P1u1vnJov/fHzdcd5xOZC0bNJv/jIW0t5y5/Wd3hUuwOUD2dbN1wLwF901n8K
         0uWg==
X-Forwarded-Encrypted: i=1; AJvYcCUtrTQ1O30TV/VsvrhwKyYQ9USO2q+rjBJ+WpLdWs/5oNC+Y4x/7qma7FTID4b1OJ64AbjkoJmbSJZHn7PEjvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedzMvtkQxNT00CrrmrWTY1CWSYJS9Wr5GQWmYmbL3VpVh0HN8
	bCcmSHq3psvBDuuGMCAqufqwBrppxoIf2RwatBxZa2DnbKEenlf992rrgdzk5YZukAs=
X-Gm-Gg: ASbGnctjGM6wW17WVMTPzq2+1v3osqQdPAtlwmK2SmW7eiTSnaRFTSCXB+0xUkSXNbR
	QHoRMjrdq+vrbDlTCHu7bxSreMLlkl1J5zlr06eDRWMicjwoxhD2PH5pmBr2aze+oFwSYURmLzR
	wBxiM4P/xNlKtPlPaLwiTzHYLuASBiWp1i5w3qtyQDdIpQzIU3gAdv5aShpDLVl0Uj9asAePPmc
	5DyIZ4KGqEwVcNmQI3TrJ1KeM5uj8JIlkOg6v3PYpFVbqPn62DraTxcu+osaEs8FyUNDEgBMoj5
	rSLanM8rcwA2cJMbaVP/MmFeZR4cPkkII1yjbD1KM3jkziafO9PtuA8g+j5MAjP0UEVh/sfRXFN
	ONPzIEPCqPvx9Gjo/lKlculxCP+IfiG4zxKd4/2KOqaM=
X-Google-Smtp-Source: AGHT+IHQbINJSIJX3DRCY7VWQRNn4wGJVllkshwYu6z4COruD7/LM4Lj3NJ+5unK+IoBRvria/ND6w==
X-Received: by 2002:a17:903:1aee:b0:235:eb8d:7fff with SMTP id d9443c01a7336-24096b0404cmr123206725ad.28.1754003964051;
        Thu, 31 Jul 2025 16:19:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:12 -0700
Subject: [PATCH v19 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-2-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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
index ede6a58ccf53..9cfe4381f3cf 100644
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


