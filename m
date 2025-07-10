Return-Path: <linux-kselftest+bounces-36996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FAB0071B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC07B1C292FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AFA2857FF;
	Thu, 10 Jul 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkPCbV/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562827F72C;
	Thu, 10 Jul 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161517; cv=none; b=i5ajuhUw+KIMq9+Dtq6ql8q2gSOMDpvTbVMQNWTR7bZgg2fbEL8vpoIY4GUYpAxKSv7BLTDaVpJ7pEn74jEA1VxXFtTZw48/jZfp5c9cJ6wrP37uqeuqmc6ePAP4IqEVx1CCA3nxCFMmRlWwbMW+iMF0qyMhaftbahH0DdT9Us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161517; c=relaxed/simple;
	bh=B0KEkllv4KLqzgncCGypsjEUbt1Q46eDNieIWc4/B+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7fD4mdj99NKdsV4Sh0/mRWvQeRRGgPDuwD24iJXBYBk543cYEtHDfAcKAbbYVD0hM/5/IxvrAlJ4wzLMCCvdZl2Ivd1H8PzghrhlJMMeQVLxh/3zl1m7L6bc6HkEONd4gOTyl6/CWnqpi8r3c87PY/6LGVEUL252QQl3lpn9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkPCbV/S; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafb6899c2so11251986d6.0;
        Thu, 10 Jul 2025 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161515; x=1752766315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhrV3vZWuhikKaFejaIZB2VhRDh4d1+RSI3qAol7Dtw=;
        b=mkPCbV/SA+mHYzxS36R55YOCJufNlXM4YdNVmVqito3xkBUX9d3tBF11BCzh2WfUjQ
         Q+3jDTMIckty68NR1s3G6siex80X4waLbsM1/UQhsWmRVJNxqGh4JBJNSQexh6GYfqeA
         2h0nVeDGpjutlMBdIeoZ9ej/OX4f9iz32aHQDi6xKlpb/HNIGOOSd/tH7c59FBIgLlNf
         YKWzGZIhDyeo7fvR1zEKulwd3h9ZDhXmQ5ZMSrcgIfEZnkQgDkX42k8C5/xdtNb5ZGJP
         +l7VK3d+XQQoLSmrZiNHERy1bLVqrq0hf76TW+qIGBXmRaPkWW2hZaufNKQNkpFyetKX
         3ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161515; x=1752766315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhrV3vZWuhikKaFejaIZB2VhRDh4d1+RSI3qAol7Dtw=;
        b=wYf03ztolu+yHye+xW4qo7x5wt0urTz3LxTZ3WdkGq73jfFnxRPabOG+RG6kO0M8Dv
         erbgVRRt/cUrS9cUn37pnJsuhaObNLiDWSaG2+QriA+rH8E0Cg1sZH2vJ1VLn36wU64L
         1GrcyN4by4sbMFowFtPNqW6w7S69DmwNrCs8tWv0s6RkEYLOXPUbhUmArM/G7bkujDS5
         GnK2eI2MvtmYN7g+tUIe7bRJKoFLws51xVsKGThx0IQMMAS4zmK9bvRBhxAG1edeXMYc
         Z25q3TcI8/ZoUYrfZj164UM0YTKSzT1upMpDnbyUXUsMVVyP357pOuhzCf/f/PJ7kCHv
         8Zrg==
X-Forwarded-Encrypted: i=1; AJvYcCU5exllngRVySYd9mIM7gvpsB038mbAs4kNXfKFhmluvVDdGO+i8XJG5D2zTy+5vGR6tD92CB6SROBU@vger.kernel.org, AJvYcCUJHL5WPa9Zrprov8fkikFMoDwpWI8a1H1yiYz+XJv6vxlSRcLr8c6Kii/tvMpawPzyJETvwCQZOeVZDw==@vger.kernel.org, AJvYcCUl83rxBKZYb+/QmUWg8G9ZxFr5nu/E3MKwgzpVLL78HbITW0zEpa5huLn2havyWD8K52HDiADkHiJ1kBmn@vger.kernel.org, AJvYcCUwh6neaTl9gxHkg4AM7D7EqUlWU2iEq0rznaAVfVDNwoEODBYSlDSRSSS2OJWqT554Bvaw+OEQ@vger.kernel.org, AJvYcCWG9gfw0g6Q38tuXW22A1/eD3HM8U2BiD9wvwECmIXbfhYBj6/2UcB3iiRXurs0j5PVLUxnYdxmDIXKX+ETU5k=@vger.kernel.org, AJvYcCWgK8Vcyus9qaY2h9/Fil0W+yiY2muC89VrmvzZam7pa7z9HQm+Rc4hlxA8qjMeIxNplB22WiQ6UXSvY7WxJthn@vger.kernel.org, AJvYcCXF0gQUNCjD3OvIkacyKsCaFsqpTDsIuoon++i0TWhK1pjyiC1offXzi/S+jmrV1jDlpvjUGEfZ/xYZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v2ard+AHOToPFc5hHDBNj+HAVXMToxaB81w2F2FhydviqkJw
	OKUYfQY3k4OdZDIGzJjXGNPILcPIz4KCWsPtp53bvChLSx3h7iPZ2NoJBp6Okrry1QKtUg==
X-Gm-Gg: ASbGncsaP4bW73YbRkz2eyggjQh14y268I9ty7rstIYnXQeodwrogIci9boVN1Jxcx+
	2/sVyRIpTN375XDtOyLJDXjrectYhCK565mt6GTsy+MT0NFCsQmLcSDZL6f6zIa+jD9l82kxLMU
	dlt7bITGxTm8e2Vlp5g7aE622mN6QPhwDJLHJ6C9GoX0f5s+3zmWrgjNqsMJVyGJKmily8oXftD
	viBDO21xBA8gUrpFDetkTgXHwbIAdFy9I6Q1sTDS6ItjSpswT3bjf29dvF3r4sC4e+T54JmgoTl
	4rplr87kWDTM8V7sKMgoUCBLHtgWycxMQOdE2dMq7hX1qYdcQxXyzroXRequzjx8IwFT89e5OI/
	UuH0YZ+hqRpohIRPwMRUqDjXnMIwehl/P1Oo5xtY9/kDzAG1L56TTDzNWcg==
X-Google-Smtp-Source: AGHT+IEw13HodLomzFs84mjDGVe/DxIwgY+6Bt92at/u/VVMJbnCgIFImh0JWt602UotdmNBzfqpDg==
X-Received: by 2002:a05:6214:2a8b:b0:702:cf15:686a with SMTP id 6a1803df08f44-70495a2b055mr54603066d6.3.1752161514460;
        Thu, 10 Jul 2025 08:31:54 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:13 -0400
Subject: [PATCH 10/17] rust: macros: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-10-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1002;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=B0KEkllv4KLqzgncCGypsjEUbt1Q46eDNieIWc4/B+E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCK05p8xNa3LGaXJc6O6PPvN7xhvmquzms/X5YPBQsJOGR8HkhPuMGHlIcvfVVrrU8WqBLJgnYV
 mMhn0UT3LHAw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/module.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 5dd276a2e5cb..532342a38b6f 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,7 +228,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = ::kernel::c_str!(\"{name}\");
+                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.

-- 
2.50.0


