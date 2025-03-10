Return-Path: <linux-kselftest+bounces-28603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD7A59846
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6100C188B59A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038922DF9A;
	Mon, 10 Mar 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fpB+ZLEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00322D790
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618361; cv=none; b=Npm6YZFoKG7CNFpa4eeae9iVkHwY4paern8L7z+MRHpUPXzOIv3LtDFe8NRWlI2CEFUIlpAORdeO0BAQ5CFB1EvaevnETkfiANAhKZpG9XSJhXRjjosPGQPNzQlX0Nzyy8bWrOwzGNet42B3n4xj86ug3Z+pJhAq/WL5yTF38kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618361; c=relaxed/simple;
	bh=DjlSjyKZg5L1RJtFrw9Awsbe+InTSaQHdJt80sHp1pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sb/PnSysuBAYGza7NrTskLSPNthQ1oJf6tNZBZQSuOcw4De87y1Tw8dODc7mfA2fe7HGu5tmEjG2162JYBKzSmvKL2owV4dNSiUh2Du4Ex5o7l8oSdIn5irGxh8RQeCe0ve23aoVvTln8epv8NbD5ix+ecpk3z8KhsGNwu6RlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fpB+ZLEG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224019ad9edso99084365ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618358; x=1742223158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=fpB+ZLEGGOr4HB1489JPrDqL88yR4qlhADmJ5wM0+L0MyptC5pY5oC6/0Wxm5lFI20
         F1wpaZLQpsV5dGmdI0JwDL8/6rhwvenzHT+/6E+ntF/4Hy7/AkPqjjYwxQ80BGfp8Bhx
         fYWDPd+QRQwPq/LVuWC0p4Os/OVHNnHVk7k1cOHtsDsdIm8OIVUdi0orf+oWwYi48xJS
         0mWMd2QFO98Yk6JHt/hmWniv92TPVN51o4KC+0uorSmlU3UB6YJuKH6QBif9RRA/A1cx
         8RAAkElNPNwwOG5AhaYIRyNPqC6lh38HLwqu9npFfAHL0cMJnp6gOuZ+NjyzntEe4nTF
         4J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618358; x=1742223158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=jZ1jsVxl43L1udPRWIaseN/9c+mJhirfklDoKvxc7xLIGg1OPlGk1P5yZHKSfLoAbJ
         xOcXk+r2hLYDRDpFTUSG83oqAvJ15q8ALubJPbdUJVxKl+k70hNW4tmieWcUhMWZEHcF
         OjRgYHWzFO2mghhzfyKP3QHJ7K/5i72t6kPWSCr8+MsKMZKaNlg/Mom0Ldtu1HvS+R26
         LFZGqn51ZhTDmXbI2dKt+XNueyRg087uf6/I2gGWoBk4gHajwqb0QcJvk5lommM+Rz9n
         nxdS3pJIm+SVXhFhwKBg6Cvh53va0TPKmrElOxzELMTWddUxABo+Xc+zQcXSIOxNLc9I
         IonQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9r+4MqS8kpgUK3/1A29dV+Gat5N8eHAKtuu/vaYKng+fkUas/FrJ8oKWsV78pzlXAl8dKv9cBf2tGhfuV5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVH0LMnzO3uPPJONw8h46fP8iql+UxoKrmour9FqjtI81x1i0
	da3b/vLsO0qcJqp33PG3mT7dqOH67Vly76vyjkqpMpGGWYsmpCJbQmcrc792oLY=
X-Gm-Gg: ASbGnctPh1N16XLsKWk3TtoQDe3wBS6IaWzi9OMR+Jlu8nuCKgtL0TKNO4PfChGDiis
	BtWZOFJFVZTZIDrEE12S4j4kW3s9XUdghGUIAsKSy4j0/Tp8AVkbYnAd1pzJFeN8nSf1fbE2pC3
	w96985jAAYs8vkwFO/c46jU5jXxQTm/irESkq9dm3g2vOURu6ZG7qPOFvWr062lc/HckaJ60inY
	fGTgd9xRIdXhzhA3wYbtbaiq+bD7Rk+yLZkhtkPFutWgr6hN6Gveu5Vh1ylrCCjWpPGqQds0+Mm
	eidj07FksqXwdAz6Z+jlE6LE19mUEqRYa62FmClHF97ldAwujaDxu88=
X-Google-Smtp-Source: AGHT+IHtkwbPi3YsMJ6A8ZQyEy1VJS3fRxtZo4fUkREMtAJmz9IifioPXZ2s22L3uz4hyDnWUTIX/g==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:d687:c39b with SMTP id adf61e73a8af0-1f544c37a63mr24132640637.7.1741618357489;
        Mon, 10 Mar 2025 07:52:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:24 -0700
Subject: [PATCH v11 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-2-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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
index a63b994e0763..9b9024dbc8d2 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -426,6 +426,20 @@ properties:
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
2.34.1


