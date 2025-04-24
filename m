Return-Path: <linux-kselftest+bounces-31490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B966A9A333
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060173B23D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AE1F3B85;
	Thu, 24 Apr 2025 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NQvKPa+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AE1EFF93
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479227; cv=none; b=f2S4xfTzt9w4jADeRdrjzOqcL0llumQkQDH9k1QXjh0o+lMyr4B8uMlWf0Jz2AEieNv7W6g+r4IVUUtnxDr9Q9+jo+VMO8/QxRolN+r5XgZErhqLGwlsB2UaQaikmTXQQ87pcBFzx6yNsVlwmDp88k1ftOZcksLkTtgWNkJxuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479227; c=relaxed/simple;
	bh=7kXTpucwJSzW6zZG+M2YQFCdZLNkh09DJtJPRKvlxRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx1G7OOULUAYwLUXeAErqAouphYhmU6r22IMHod727QNAI4YG9MKO12YSDckNx0uN0EBOD/cJ+T2RubzQbfnzXDD4ooDSFcVUnpSWPKboKfzxkje1WP3QuqpinGNVfZ5pZUdppoYUp+/4aUDX9CjlWRgQa0OFtQNdWfv/J+iOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NQvKPa+x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2295d78b433so6989625ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479224; x=1746084024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgj2CDzD4Jo/CEM6nihs8vPoVImKLJIm8Gt1mS5KnTE=;
        b=NQvKPa+xxcoNdzUSaQ+oCgF/DkbeZnGuzjhsl9iZwY5d0fbOUwR5i8/yD1dn+Qj6JR
         kWKi+sqL41v0LBPBuk4Jt0HuyHQots3Y/DWaR7oqMB3XwrfCf66MXVEldQGJp7J39MBA
         6LjUcJrQbcFtC4aJYrZuBzulrF7VdJryk44G7mGR4Mz+1M9aXjLaGpxQAGT57p70qaZ4
         RqB/Ll+LPe1gqO8v02QYtOceBDFgNAnaPyHGqLWAPqwJYtwbGI+Jox+Z0eWKFe34Kk+f
         BGQeiIdVe251QvFxKE30Sf4DaPn69jQOaC37YkH4gL5yjhvVfATFvSj+oXJvHw75Uu+V
         0GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479224; x=1746084024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgj2CDzD4Jo/CEM6nihs8vPoVImKLJIm8Gt1mS5KnTE=;
        b=Mdv/k2/ebIQfogbFjraOdkmjrKhEUtsna3JwBGFiqV+5yJwGTZwQdVRr4Ee89fkhMI
         Nm6SdfaOiuf+CpydZ8+qjrox5tf5xLxlm8ImyeBN5LUpctxYCb8CxjTqn+E8fVTwiTVs
         xckdg3FEn141yDl35sb0GHiH99jxnAFVF1PKzsCY1hxQ6zZLH1m/VkNCUDdyHU8A1gV9
         YRVU5vT87b4I3gyfU70s8mSQqWobOvMdaRipun/0d5+Nwp91oc1JF2eXz5dDQdjQsrYt
         BNetoFBQ/ivnc78L3C2IGvPNjQtKOYIH+g4pI2kE2XawxU0CH4Xi8GTLgARRze8MXe0M
         vV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTDM5JntI40CwaCwX/+3hMoxk6+YLsffGivOVYXu/CDsoYJnWcZ/SqkBAo4KUZirCkZoeXwN3bnimAx4V6cEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tlryb9uIS+KwPm9LrMfMF+M74+L6SpbD+iV3/OrPm4tjERJn
	vM2+PINRvhv2WkCnpPi5vgPCoEmCCpa5sbO+jFK9yjbhEiOHifhUR4uv2gIFzf0=
X-Gm-Gg: ASbGncuOm9favrbuq1g4ls1RdKLNR9nz5vBYPayx6L/dRgSeeDf+nGoA6SeVqXjR8Pa
	21vO5AzADQJLp8HbIGmWU5GDpwZk6SvjVomt0q9hBu+LoaIlUBYEj4JBTyPem91Z4BQoDcGyySV
	SPXRpYz2jkaftEZgtQgKBGbMjCAdU7rz2AWA8Vz0LAodzCsyJ4qyo0UWZoD2gQTS96xAgjznGxF
	gSGOxu6u27dYjNQgOfUngZAkW/0GjDkAHwe7E95WabNPrWQU8Ia3xbVYBuT0ExKxRQBetfEpaWs
	2T1U5+fNOPQLXWpkBE83Tg7cDpvEknc72CEJ55Usb6rQEtsflfk=
X-Google-Smtp-Source: AGHT+IHy7+gUl6JYqkh6DnEiG93YQYFRurMg0kkH08H4hXEqOE1zGfqqlxcBK4Z6Ezoo9LY2AtzRZw==
X-Received: by 2002:a17:903:1b66:b0:216:6901:d588 with SMTP id d9443c01a7336-22db3bde914mr23693625ad.15.1745479224614;
        Thu, 24 Apr 2025 00:20:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:16 -0700
Subject: [PATCH v13 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-1-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


