Return-Path: <linux-kselftest+bounces-32239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E7AA7CC0
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001713B6A18
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8522F766;
	Fri,  2 May 2025 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RrCBEhO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82322A7EC
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228649; cv=none; b=Aa2ULBxPf+k8DqH+IkdY1HO5HMcEdNw1lWmzYj7bFGVJ3zQs/zV4tN6zKBsTxhQy04hv8pnhyOZDd5YUhbfnT7bITJGW2aeCBGntnMeRi+VGswHzaWVYo8cE4EQ+2fpIhd60PPwGGNJsKPkhEkkMO4VkrsS1RMvccqO8KWxEx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228649; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnBPvwzO1Z8faYNQEgE2mFsbU2ItjZR/JAbR3LM3kE0rqe6GoYsIntpTrY2CeaNJq5lLiyB3dx4xm5xdcDUcj312daTzPxqJrGwFzmkR1/ckwa+pPJPPp85IJ+3DGT1+ZxVqQzndoABZWf1G9JuDgvGOSFOUFQStL/G5CStYZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RrCBEhO/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so26582525ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228647; x=1746833447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=RrCBEhO/bym/PUAppKE9EUs1vGGxECFx4JYqM9GhgT2G/62v1fo9rYEELKBViD4EfZ
         bsTZPgAV+rw6wyLwMSpeQksFsxVwBo3ASb1nVM2ifAlvgsZrlyxNl4rnrLOhMiLluDtC
         DNUhAbf0K5TpPGRF4pDyO2y97dr2OuoSO6ZNvqNKq7oRX1AJR9JLa/njZLPx9RsYQmN3
         xRm7gq7nUcMq9hjAyl+X0/vyjAptO+g66dN2Cy8NGri2zfExyO9O5jfCsLVxVHBN1tAc
         L5rmdIXraZw5SO54o/dccdlBzAIoKxqlYgVlg9ZQqcF3uBrvYDq5fgdpiRE8nkkRwReU
         f6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228647; x=1746833447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=ZWdbfuYBxfRP1EwV/Rqputxup0ZfBY56kNqSgX22eUse6PrmH383hMPhls5t2lsWDv
         K63y5NseiI2dhAtbK+dAkUF7vbRUkrHn9u/dyqYJ63dbrMYh0qGaPjXbTPhE8QyZFlVw
         I85k6bok2btPizIiZDzecG8rfRSYV2nzaXREuUP1+OpR0th6zy9+q+Xee+L3jXemOez+
         okBy2zanGvO0av/6waSpLDKbIkYAc0ebMq3HHEPxrHWatpfIdkpQpBoMFOJ4QL9eEk/C
         9ZLzkw8ynMbTkrVJZhM5iMJq5OoVevyH7x8Io6cIAqqpta1BWomcmVdYKvCjc+iPp/uO
         Q2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3z7vbNNqgZ2dWR9elI3WSBsZmcKkg+wBskQNzVFSE7LqKTT9YeMxC9pOPzrNcEizbvoHFuFBubmiWR2bR+8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRuzu9dUjuFS42cvkXgQjyAF/9j2kjLbKhJe76vTe87o3AvcW
	wuZTK4OW02TWR8HaoBiX4DwQolvouxZ3fc+jKEmjBKuz8nh9+HlZqt4hNvuF+z8=
X-Gm-Gg: ASbGnctez5y6kdpt+coD005aFqmRVfNAwm91SBnAwcUpxe1UOpnxJbgRSdsKacEZf+m
	EgawOcDWBeUlFul42aS5K5Ffrf7mB8M+4pKODt0mxrb4+deyBbCxOcgeqIH4c1bzkk8oyLulaYV
	I5YOoMRNazaawSW+euMNjONuORi09pCLXIg7lY5ykFniepISSPLWZ66H4oXa7cdRxCqeA5GJbwv
	Anm2NUhTjYLqorVgHYTeL2tYlgRNxolVPxlx+AsqirUx+44svWXX1BEVk5IWWX4ahylbLAMXK7u
	ag3exldPiDCAOLw1AmGcsg4tp4dVzj+LZHVVBImbynCw6LhQeWeqVfOEMo+usA==
X-Google-Smtp-Source: AGHT+IE7dZgo/vpzWfqm3CX3dsTr88XWeuxnKV7R1SeEHd0BNwvl70GJFY+aLiGFC3AULLyuCpB9mw==
X-Received: by 2002:a17:902:e88c:b0:224:3c6:7865 with SMTP id d9443c01a7336-22e1030c76amr65218425ad.3.1746228646876;
        Fri, 02 May 2025 16:30:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:30:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:33 -0700
Subject: [PATCH v15 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-2-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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


