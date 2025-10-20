Return-Path: <linux-kselftest+bounces-43578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EDBF362B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D8487E70
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482EC2E62D0;
	Mon, 20 Oct 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VTwOS41c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA22E264C
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991764; cv=none; b=BrAMjXH6cnGWa12GUKJ2x/54UrI8JBHCDcR5sq8fduybftplh3fu+Qxy+yNbDi4zA3SgDZFzcUciZC/Yp03pbm7K4Xz69qaLoJ7ea9BTwAHp2d+wDitWzjuA2WtaRckJxrT5vmzRiWJyRm3KzGKfHPffnZwV2cG6hj3E3FPXII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991764; c=relaxed/simple;
	bh=omr+A/BOicIje23HsXl7grjzobxFuycKUasQlCN+FZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1UH6l33RuvCGoq6hVDrdbzz8uGtI11W3Sn/LnvMekIOqeaNhgWS8I823NoKAJZEl8xew6GQBRyIoCtG0ysTsG6rTKr6KRJMCElB5seHlo3rPYCh5jepJjrMPXbMw/6WOwNNzNTODeShShs3FWY1AxEmDM5LjNc97h2ZzrWMRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VTwOS41c; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2685943b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991762; x=1761596562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5X0eU5n70apxl8FByquMpjWi58YW7xT98Nr31GIt0Y=;
        b=VTwOS41cjA34rbcUzCdp+E7VsikTGqQwFoTyThoWsUSnSLxLslokzdzc0p6bCBFz/0
         6eL5AuS59Sq1VT7qpi21AsSZtcKSEv6hrhknsJt1W+DbmlGiCoUCCspUr8nWaWPJYOYB
         NBb6mS8LDseSb2nhFCCoHMDZVMnJRa/vbLF/EBwMmg01iqCspxmVhUJFc3+Zq69j+jwN
         bB0esMhISyQfxpjZDa80O9DN9KdM4A8qoumoJeDfXJ84ssbl/ntUT0X0ZQYyjoBtMZfS
         Lw8h3JWWCr7nGEreYs2SHCoq4DRvxmGSMYMAxMUQAZjL4MPq63aE/fS0SnPVNR7p69iD
         ZV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991762; x=1761596562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5X0eU5n70apxl8FByquMpjWi58YW7xT98Nr31GIt0Y=;
        b=BfmySmGeleQgzXvq0FYu1971dqPvOTTNZ0sEtwG1CXkQOmudPyGYX4HHqCgKwdCzwn
         Dhtyz3TEDkn/ZMBlmgyPAN9zDzV1sAtWMfHSwQigcGYu7BlQ+JyT+NmO/vqlRtkBD4to
         D59uwJf89rFWjqKwCfrFltt1NspNZDt6TitiTHsPRJJtSbql6piYSxAkI6ms83DWSHXs
         +PpmrbL0YijxQsKfHjoyhab3JbhivK2K5HPWfWne4/8NgA/2Ch5bFySbF4hQKh2xBaGH
         xLJILbPgn4VM3NL2xw5IratbllbpvyZz+HK0oAvk93kovYGkw1S1E2OiJV4hqMjFkrAN
         /hXA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyAjZ3WH0g81PrZ4tLL6xWFoCP34cg+Cq4kTLKutbUNCGQ5HPGTBYl+VKL/cgEKOELpgoRkrFEwgIL4dqNDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUbLQB2WBybW+CIE6G52qx96NgekKRIjc3ST+Tj9PXvZ0XqEy
	NBNNP6GSgQ185BgMvbyVtLaGgnislyX7olnUnX6+jbyNpbLvWYqHfDbG+1rjrvranqA=
X-Gm-Gg: ASbGncsow4c8WB+6k5ypRl6V+EczeNAa6IILsY/1W6gqiWDxjEiHELQf4r0zCHFkaJ3
	B+es+vhT6nehTMg6b++HfrYHmXG07XapUk9sd27oAPAMQlwu3DZZ0lWDjc1kbAfv1P9ky/h6MAF
	VWzXUaW8vKtGrZKoIW9AAJ4XgddmVT73jFZgyGkYCLbzaEvzknVDzzy7JvEqVXhGIJq3t8OCVNY
	nvP+ZApiqIfO5B79MNy5Ee3UEoQLP8f2KU8fVdN27FOHj4f4lazCbQlrjwJ4sz8dZp7ncLnqorc
	uCBhh1ldjxdb2oIIy7ppELNOl3NXQkqtgmXcCAaL63oRjlN/HzxYMd2HHCKjgKmr4xvp3bvf5bv
	yZbvwzQyAW0HdZfti5Vy14YAJf89RUP8EIwahUE3VDpwklwEoHE1rU2qPgVKQWf5vUXPwfemu4s
	bEalDZMPhtDw==
X-Google-Smtp-Source: AGHT+IHEvyI4J6sPrBxVlVCaHky5xMHxaAzs+PZxvL80WqSoNdemSVWitLZhoB4ljrrK9RkRoQOjQg==
X-Received: by 2002:a05:6a20:4309:b0:2f8:4558:ad9e with SMTP id adf61e73a8af0-334a860747emr20871921637.33.1760991761685;
        Mon, 20 Oct 2025 13:22:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:41 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:31 -0700
Subject: [PATCH v22 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-2-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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


