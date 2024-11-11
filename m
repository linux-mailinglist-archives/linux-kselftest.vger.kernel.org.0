Return-Path: <linux-kselftest+bounces-21801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2CD9C47DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FDBB30862
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46481BB6BE;
	Mon, 11 Nov 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YEP6j6o5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC131BD515
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358445; cv=none; b=rmWLcdOkUf7XM7vsZBd/OfvU8qG77aAj05/T6KlYEGGzNRfEWjj4p4roKowdd7I1KQorIcFYpMMp7nXK8htHSra9Eu3IF6AvIJ0fDv/3ycp9+UHvvPMNtqLQmpe7xpZqDCwBa8YjnGJm4mgLDoOgFpIDwFURNrLqtS/LeCJsW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358445; c=relaxed/simple;
	bh=KwC5Wix9XMtDJh6G0GdPiXT0cb5t5hjSLaOj79us1MY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hk3OvgJHzC2N2zqN5vjZjlKTpkzJl+PxNTuHjdpVYLXNF1Pm+SXpaSxqPz6mK4Ar1CPYoVKV+itz5Jv1HiAr5OziS34MH/AnghHR05hVjH9GnODFzL70zxcBQ4Cg6SrYXqp5PlRXZg0CGyybmsX+fkxRvXd5hPegO7wxHWQhvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YEP6j6o5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so3942404a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358442; x=1731963242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIZVW5kCW5Dqg3JTts8BKHfPCkqfunLzJ4lU/RN+S5A=;
        b=YEP6j6o5C88nVNHj1DamEVXallcN4QkUg0BJ4n/MXibco9fkaT6B9WbDaTVrvmsc5a
         kDG1xG508yKQMXDUmVIp/JRh8nswd6bBfPo59BLBXSaJgkh+jinGa7YALBXo9qHswalC
         pCaMPP+NgC5/PiEcWs2D6awbUOHNbB1FFGkcy6F2BOsOQvF5r6W5AZUJGLD8SP70HQSQ
         mEwOwY+T87A+7EY+CqjesCuuFBH+Zkcmgwfo8cj21xfNhRbLqD68l6zqaGitwL2fy4Ke
         1mXLOqoIOq0L4LGdJPhnXyWRS2mdAiOY6ab1HgwlakOvwpeqb5DBYPZB2gY6VpFpe2ZW
         Kt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358442; x=1731963242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIZVW5kCW5Dqg3JTts8BKHfPCkqfunLzJ4lU/RN+S5A=;
        b=DbexKy8avml2jL6mDmAfOsPw0Hc9TnumIq0wNjyucJFo4Dd0Onj+LGhkr219iTdq2J
         84LQnpC5CneBA0i5vQjw5vFtlYIDoB+szTYjpPzpMOOSmPDg9VwgwdpuEOIUgnpHzv/0
         o6zS0sePlCeg5I87Z8+hCs5bnklGrSYyyrWYANZ/1Lk2rSkFwlDTd5GX4kpkYEhRk4vG
         6d2PxkZJMofU0Z7y7ci/vtCcEdzxUmjfqKGZTy6Cn7fT7YK71/Z/mR2epx1Y71x4DEHA
         dd9dO5VEKO2oq0xG2HdRRqrFofCh1oTRC8VYgaS0LS/ISg08KKz2oqMogVq+e9NVyXMt
         04mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9nzAk6pc2iGprLEOuD6Vu9CLfYO6EUj3XYiETRoI2qfKZH7YWhssbrcL4fr5y0JSnvVA5DprkW8MNO6rdQO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLBaq34ddf2f5dk9+mD4CRTRIsLwle0ZQmfwh9xtMWLQiGl0o
	XydWRCzrmHiZzG0Wz5EGvJBY4IbJ625p2FhYggi0e2tcmqLYmf9jSDWZrYqPhuY=
X-Google-Smtp-Source: AGHT+IGa2fbiAJuGCBnF9rSK98Eqsv5rxxJ/njsQk9gbKD4n0fa6MYIbIMWZY1h1CaKZlLTFD7l4AA==
X-Received: by 2002:a17:90b:3941:b0:2e2:d239:84be with SMTP id 98e67ed59e1d1-2e9b166bc4dmr18469289a91.5.1731358442231;
        Mon, 11 Nov 2024 12:54:02 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:01 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:48 -0800
Subject: [PATCH v8 03/29] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-3-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index af7e5237b2c0..5fb40665fbaf 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -398,6 +398,20 @@ properties:
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


