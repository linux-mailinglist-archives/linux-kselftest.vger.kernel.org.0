Return-Path: <linux-kselftest+bounces-33739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC469AC3134
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DCB3BE585
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA91EF395;
	Sat, 24 May 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG8jlmJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACC131E49;
	Sat, 24 May 2025 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118805; cv=none; b=t1OXEwWHZMMgFn09F6Mx3JnV9d9xs07FldWlO2iwPZYhQblPzdE9uPYpVkVpGWrcvIX5IeoGUs0DHxB3r6QzCZoEYAn7dtsOnh9ZP1cN7LWSIWmUBfjm9qGWqb4inm8llRa1Y/ZTEAehKEs+joAnuR5hxWV7OCBD5oR1DgZUlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118805; c=relaxed/simple;
	bh=hrug913Vp1NiKCmHn+m4wiqCG8z8FSEDUX4Thc02O9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlbc1s+jnQyUxOGYaOwpf4MeK8G9du3s4fA2oYbcQoc26fqPtG0Mwr/duRYBu3IveWI6/LjDJeqMby6YKNHUQ8emJzQVczVDqvuYOMTgAJpK32MUKOMsrD8K1C2/md0VTQ905rbKApWSXH99kUFbqE2YcPsBF4OFkkhcAGqtA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG8jlmJl; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c58974ed57so88916785a.2;
        Sat, 24 May 2025 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118802; x=1748723602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvfJkqxXdrTl2ACAyEytt+D5VYLPEzTHxEFeE81vrvE=;
        b=dG8jlmJla3zc2ddUvzo1xIkXVdrOk6ql1swxZFLTgGQKqfpK472JQrYDZGjVhguXk+
         rTeO3qyZ1ie8UqNiD1KUPe/2b9U9NadbnkWfunusRgiL2yukrFBhTpLrfuIL9fLFjX99
         uiljK+yqr3gVkYsDhe5llOVjTBZr8mZjHTr+7UMxP4yRrXfgL32XXAmKv2allvYZdMt3
         AACrWSDcfckGpOsXu7/DbVVBQX3w9tPqDhHL/7uE2W+ivYwKJi5HVa+S5FVmK2+f7jQM
         7mfwEqXCRwofL4jH6uSIptCpJgqJC9TkAofPlGHy/AJ4xMyBSav5klkGxte38xXybw/m
         oDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118802; x=1748723602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvfJkqxXdrTl2ACAyEytt+D5VYLPEzTHxEFeE81vrvE=;
        b=VGqG7A/CU04bxsQV41KB4jYzk1ckRNpI+Jye6ymFbdBt3mzhJVf1WiA6sMkRvdFWz/
         8Eeba1qFUgnuBjEnPFf2erGRAwMLIPltB85GFULnSqIg7prssC+gO/Cw5ioR/I+RO94e
         hc8rsubE9ciQLpYh87cZ+T0t8r9kl9p1o2+idHN/KwYigiE+1bBIeiShYuiOf0zAc6oy
         UlWghP5rcvDATyNlw4yjaT5xHNhQR2lbGir+oAaS1i2DIgo1O0LkY1g1pAXT75TAYGy3
         gC+6XBvUsLP4z/i20MBBD+m6lM1bsMzk0a089SG1sNvVi6k15n7RcS/lONB0UxNa88hT
         K0HA==
X-Forwarded-Encrypted: i=1; AJvYcCUHUMxgGJ7e7EkY/5Hlu9IbzB0Mf/yUbLFIWQICABtHEPHcvwIs1nFC23VSRIHHIxeIww2wgh1W7Eu8X/g6@vger.kernel.org, AJvYcCVOzYqJTXzPhb3lrGJf6BB7DGktwDYZgBtWwsOmwMIYnI8h3f/7b7UOPz7407LHsMxrGkREiFkn@vger.kernel.org, AJvYcCW+oPQgfCROSnLjszMzV6c8Zqxqmf7ZKm28hpZTd0EW5DhkSwUCKLSUM2lIbV4EL3ll0JzlTlkvLJ25@vger.kernel.org, AJvYcCX8kOhncy/uAohzarCRCm6yHA2vGJPIldbKhhxY7N9mzwiIkN1DNnBpNtAgD/CUQdbs0xV60N04hGi+@vger.kernel.org, AJvYcCXJ0H6hbcySEaDjxV6BXWFObSLBxcGUgypONyBtlV7NCjs9eALZFOXl8LYyeXSBFqcmXVzw68RHn/a64jI=@vger.kernel.org, AJvYcCXvgOTbjU/NurvdBn5AjOz57FeSdzltWEoGsPfxjWU3kDJjCcn/OUuSxd0LMvGcoMtcwJhCK8SRg7+3awhz5I8e@vger.kernel.org
X-Gm-Message-State: AOJu0YysgelZss5dG9yiIMxbUYP3GEitZL2Dtjrixr0rCtrzsuu3dzFl
	g35rThbAXrPXmGk2Czr2nqfW9Pf7MoHSzjz271aV8hKqkaTLtuIGREts
X-Gm-Gg: ASbGncvghfBJqknLZ3v06DoaabbmIXgCiP9QdX1vf04BgmVVcuhYvsoTchZZildl1kX
	dQlmNEhU05Fc52tzqHvdzn3dDrgaRt/3fkhXC2Mj4fuD8CTHDjMGA3uTC4dGOlkQ+a7v215ewPo
	AYydxb8SzOz5EpW7O1YWMSAJLkBjeAngP2mAb8RZyT9oDRYcWCKoHZo/c3mkBPiei2fRHnFj4VY
	fLlxkUgR1OYdJUKi9eFWwB205Y6Cm4vi4q47Zbk0IQ8PK7WDxGE5YlYsWQg15tRt0WtBPRZ/9iK
	YYlDsolnc0MmIF1Va9Dwntk+jwe93YCvmEvhCMZEWSxab05LpD4xOknIAvhg4wGg1k+30Hc0vhG
	yBnHLvxgCbCzKN9XqkIm17LoTGYBKNdXXBRBZ4W7cBu9K/UsWp6jh9BGuSmifO1BGuHIQ7o0vLv
	Xjf1Y=
X-Google-Smtp-Source: AGHT+IFboxRLluplUf3LaplIw8SJcbgWkLbYbE/qq4hS3to1whGiWg64X2sqtasOImnMch7vEUC1oA==
X-Received: by 2002:a05:620a:608e:b0:7ca:eb5b:6b99 with SMTP id af79cd13be357-7ceecba77cdmr512632385a.15.1748118802225;
        Sat, 24 May 2025 13:33:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:8563:e370:791f:7436])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7fd1sm1379590085a.29.2025.05.24.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 13:33:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 24 May 2025 16:33:01 -0400
Subject: [PATCH v10 1/5] rust: retitle "Example" section as "Examples"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com>
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This title is consistent with all other macros' documentation,
regardless of the number of examples contained in their "Examples"
sections.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 9acaa68c974e..d31e50c446b0 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -263,7 +263,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// literals (lifetimes and documentation strings are not supported). There is a difference in
 /// supported modifiers as well.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```
 /// # const binder_driver_return_protocol_BR_OK: u32 = 0;

-- 
2.49.0


