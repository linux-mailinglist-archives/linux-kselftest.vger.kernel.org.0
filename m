Return-Path: <linux-kselftest+bounces-33580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAEAC1BE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8344A6A56
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A823278D;
	Fri, 23 May 2025 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Oxej2Idn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344B22ACE3
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978281; cv=none; b=O/wLHD+E2wKIwtBD+wnpGEi8q6e6XH4VXHrJD22TC4jOiP618OkrwwOIAmKTGH7a6opqb2dcG7+gjothk0xbTGtNYAMPfCAOVNZl8hzh4nh11tSVcdsQ9FUKqSk7rSQewPebAt6+SZhit1O5pm16c+pvZZGXqW53N37Fr3/ZZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978281; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoFNJNkwgUvEuljocxkFzPD78DjUsWJRMxGWB/WO5q/wSfPmSj1TyTGbkc2OXQ3DwcMqdxdgfJWmogSCylWPNurnvc86A4lfXuRP9e9cf/ceMZ4UPrvDVcmpYPFMVudMPu4QpusauLukmdY5AP7muikN0jQEteJciHTE2+4Cfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Oxej2Idn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso9952370b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978279; x=1748583079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=Oxej2IdnMsGHRaO9c+zkgGtL+0F/YDHYigFGlWSwlQVejY0C1Jo3OaLChJ3dSpNwvt
         qYOX1H4c3UnjzZ4bmRRu3tRJiRMhJZPrOVgsWq8+6ClyQSh5sSxOAqgrJtdnw/ZNzpiz
         2OqaAisr6yTAQsO9ICKkjwoEAg41v/kssp0iBkysdHOpsur7GHnrUAdwIU49/oGA4pGi
         7xUWE/0oUQ952dviC6zqg08TQX3r5cDVOsmx8iysIN6Jve5NvyHvEWNYPuGbFIAiHvXv
         eoBw5cfIA7l/AQYnUlUpHgki7K0o/bT8/+JwRfeYOObYxV3M8UuvHDGsGh7A4Wsnw99X
         S/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978279; x=1748583079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=ErKTQmUMpnQxgSOTvcoksYrysv/QCSTjExR8QADWOINcqAMG9VYMzAnB+vf3+GcYRI
         Wd72wxW4Zm8lVR+PnnnZ5WW1IwmMVq7YycuZzmBtFkSruUv3stLTeCYTNuxZjRQo3+fk
         kygRB1Nd/diGrZlnopd2HA32de9/FsvUS+aJ0gC+yKlFuCo46oq7f5QvoM6s6Oiqmtyq
         1qa7m7QivznMwUAiy5X0nBfRlMNuj8ePryHiduo3EGe7lUuAecJi+bps3BPf39ygRCTV
         m6w4mTmjFrSYyEBP3V+R9ZujGv2dSz59Jo+h6uBIinU+vFyokGocpZHuwX4BJoU2cPz6
         H8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUUZ/ViUahEErrIa7pIDhfXTFfBU0lNcRoE040HeUbr4BmpmEBXi9s14AzNjQlslyJXhMaomq0IhBZkgSh9Biw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVPU9ESCXuit1hWFo1CAPWWFTSX/FQZ6ebr+w6OP0h1tNzAt3
	IM8q6Yq3zbN25HMU5BQTn9/GIMmUkgye9Qz4BL+P3RyeyMkCsqhXPcROXVCvqaIds/U=
X-Gm-Gg: ASbGncsfA2meyZ5rYO5dCnTAfcm/EYti7jlg+hub5Os4YiRz43Pld9BMpu3wriJeEba
	PdwsnAKnH1jv6XW79Mgao0REsfOeU3yKzivRyHMYfGlXijggtNAisuDSODjwcnTHf5+3ilG1I5s
	1ogL/UO5CX0s5WGoLfY/498mKIQY4QVX7PAb3vG8TCghU0Edq/WBZREiwKhLQKtexvI63MWLrPA
	3uQpLJ/maWQIBlvHjshVmlpCrw/CKaPvaoY32D5p6BS8J9txO64EyJBld02Xpj9Trhu+AW82TkJ
	8MiKIvM89oueYHke1al42k3q4gJLUeyQOxrDt+0ekLUTX6ChaWSrb2gOojVLeA==
X-Google-Smtp-Source: AGHT+IHlKP4UZxn2X0unpKyk2s34DfMIrhFXaYoYHN8A+/APpLh1k93lfGM8cFGfaP7h7sD51xUlFw==
X-Received: by 2002:a05:6a21:a341:b0:1f5:6f95:2544 with SMTP id adf61e73a8af0-216219b25a5mr40768503637.33.1747978279402;
        Thu, 22 May 2025 22:31:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:05 -0700
Subject: [PATCH v16 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-2-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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


