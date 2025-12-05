Return-Path: <linux-kselftest+bounces-47146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA26CA8D04
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28F6330250B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735203491FB;
	Fri,  5 Dec 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="GV//io1f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C07346FBC
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959818; cv=none; b=da/u6iJzClk8I4YoAVIq+pNwm59mLKd/SMK3xiKUwzSAEvpW1ziZcpiwLY11broGHpj0q5jotHXLWL6x4YjOLhwCcaCbv+ML6I9okM4lF2XkbiMDE6l1mdVlpAIayXQh8/StBLfKt3lw8EnVfa73r7CSBcsUPc0fvKNkQMxP/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959818; c=relaxed/simple;
	bh=vDVmmVGnkAFlfQ8sB5tmt1wB1lda3XmsatvedsLasmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMBtECBYU70EqSgrgCDfXAd5QXWY+R4Ciy4Fgt2whosz7nfIo9n3ZHftnxYb/peMBv56A7iiBH20qSSYADnRECKomONYOLWGB6SSXQgGMMviaQN/qveRtjk1mFFl++6wAcXHey7gH04Bp6Gp8pYt7cm9OCpIGVB+ZMmeIFlImyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=GV//io1f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2981f9ce15cso32737445ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959815; x=1765564615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64xLkyzyDt+G7LhAFS7W5T4PZ7pgqwloJjIatj/cxJQ=;
        b=GV//io1fXl5h9w5aMxur+jMOG1H8NhcyyY/48WT/K9zQCfj3x7lNPAFRQZTB0QcWt1
         G1lV15JmYtH1PzgD+vlkeJaseWJuh2HRBUfPsAZufmxQw6Dp7kdXDvcGdl+lP1/gUhtb
         PxUA10p9u9xBUPJ0AXP9hRJqXv1/ReT+DgSBjU7r+/X49elW5i5BLQF5roSow4Sh0sy4
         GNEKhR2Kk+PXKaL+yOIjbO857zFRYm5szbyQbBRNjOJeOM35NjplRROki1pKAn6uOwBc
         to18TpYX5COg8A+wlbgTd2d93RfaoNSOr+y6YdZYrkA1yHWCrxRKUdn7mMevH5zBXO4Z
         8STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959815; x=1765564615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64xLkyzyDt+G7LhAFS7W5T4PZ7pgqwloJjIatj/cxJQ=;
        b=CDMm+VsCspF6KLMT+/mkqcsrDnN9Y0sP+1lua/96b3YzcljjB8is3eubIf6L8RfTqX
         hV3pTo3a6cQVsL/TaSGO5HxYYUTnu/8RIqYjY/VWqMKvDkNqu3bydeYRxYIg4S/iW26r
         3QULSyoj2KqeOd559+qQVksOIwH4fjdr/6l3k0dQnllrmvcmGiqhMHceLD6YsoMHBZOc
         jj8SEcDbta0lCxyB9bZQLxuJvts3bD+8KkP/zKn1jDCOEOXUbevu4ux58Tgx62YefaDc
         AuQwOBCWMriUqlQJL8GZb2OVq6LWPOmtPEYxng0goxKeBNsHlyFyxRHG53/R8hXTBGZ+
         cqYg==
X-Forwarded-Encrypted: i=1; AJvYcCXaBy8MWq7RgwepkLV4zkyClcjpJFrqjQfovg65Ll7PyTcozGfGCXYffVIeHbtbFcd0yQmGlY+UI+EdTVS1fiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5MYbOOICSzfn9GbPi7Dw1tE5PIhQ/k7tHPCiRErbcA8LuGV3
	Nb8YgvbtgDeCkumpHbqhqFRVYfKjs9yn3jZNqBaJrQfcptXd7ibMsEz7rtCO1CtVEsc=
X-Gm-Gg: ASbGncsKz7XX2Faafj0DxccSzBSqE/yb2jhGHCVKFebU3l4Sp2Z8OobtNHoxROlwFvH
	vjkGfaQJKgRxCSN+PRkfBZ/yeGuI4O9KgSVYdO4IY0mRjgpLiy06RDGfNjxpcuN2d6ArXyKjLlQ
	v9t2NyS5MgB80y31xl89MZWYPXDVPdYU0yYUKeiDZHgwSXUG/POpWSE2pcXbMgp9FGuBT8GMyHS
	sA1zOFksrpc6g99i1tY8htkadeYA5M0nLO3zE2IkYP0u1cWlj55VL5kVN3RxYP403mcq1KRvkHa
	vbteZAcM+80dJPJOHU1dglpxTaj6ixGDSyvmHbkF8OUP0mLBAnlVzmVnQXaXQjZAr58XHxGe80G
	g3jJPVEzxIlpIq42E5Ed/xQEzNu4Rn9M4hCh+ET9LTDuw/BH2tXfBZ476U7gXngbeISFlh2QamW
	+J5OTFkv8k+fwxd0Ku2J9a
X-Google-Smtp-Source: AGHT+IGU2sLP85/lJ1hQVHbc76Oe28ZFP7QFL3n7WXxEEBaxhaqoxKiUM68PA0g4YWByoTPd/kSlLw==
X-Received: by 2002:a05:7300:cc8f:b0:2a4:3593:9699 with SMTP id 5a478bee46e88-2abc71f7ee3mr78452eec.22.1764959814725;
        Fri, 05 Dec 2025 10:36:54 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:36:54 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:48 -0800
Subject: [PATCH v25 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-2-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1566;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=vDVmmVGnkAFlfQ8sB5tmt1wB1lda3XmsatvedsLasmU=;
 b=FTcBrsY29zH4CGwlbVTm1o8uVBkzLWVuJZRVdzWSvyaLQ+YCd1ACncy30R/KVfqxKm8RGhxIK
 fyUsZ0gvoQPAEuPbkBJtPN+hiBZ+Driu1BfYy5W9om0F5sqYa2IMOjY
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Make an entry for cfi extensions in extensions.yaml.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 543ac94718e8..3222326e32eb 100644
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
2.45.0


