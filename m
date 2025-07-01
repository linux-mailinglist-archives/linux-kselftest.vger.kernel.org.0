Return-Path: <linux-kselftest+bounces-36199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE1AF00B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21F917DB59
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7827F736;
	Tue,  1 Jul 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRwsVWd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A727E1D5;
	Tue,  1 Jul 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388591; cv=none; b=RUX1lB6jHHYRGAOi2uaMu1hS0gOo3DB3uSirl4CMDNscaNL6fkdAVzD69VUnkLqUTk1jU+QLINN7Lv1B4fRKCm9OTAtxYqul1keZ2+JQB8VIkb8eqXXHx6oQ9BK1qVI9z6KheIe+qZxSl2NHnGnc9RQAhIoPW6nY4xrwHKBB3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388591; c=relaxed/simple;
	bh=chk1wwizZG1MPIiCNwD46/EZhbEvHPTiZmXZqpThA3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T13PGAVKgVr2g3N3Rt2imChrc2n5PT3vPKg7tlA/38Ds6Y81LynjF0wKglmCeuMu4R+AstlcGgrB60397Hwl9aemdieUZ9w+ecx1Yzg1YJ3CIRkmsEdy/UkOCnHs1c2DxSISotr2ozcxc3CoYM+FRlyDeOlcrVhUGgQDU6dv/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRwsVWd+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d44e4d248dso381917885a.2;
        Tue, 01 Jul 2025 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388588; x=1751993388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPiSjh0N/D3OxLvptKuG8AXPpYOOl5hUxlwQvU9k874=;
        b=aRwsVWd+SXZza4peij7M4o0nk5fyFQzu6Jl4oKLFRjyjgdFIKX0N3pMSTsIVZcfevf
         enrf6A4AkoBSNcL8lzSI+k6rqq2SpwdQrmujPijwDD9aJZh2ftrESD9XHgfGcNhbF/PI
         u3louA4JY80xITwISckB3IXIZZmdBpIrIyJ4BRPb5G8uE0U//e+T2fkc3TX4QjhEvp4r
         RkrYcDC6ZSjnu8MiVv9NycQmVIPnRy0yywbV8E942YN7h/lMZ7qwmuF64Co4IuRt3n5Y
         O5Ww2XjU+d8aow/scey3dO99uwtwxi0xVthO9WZpyIVXtklajwz8Jpjj4IneAREnyYzz
         RU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388588; x=1751993388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPiSjh0N/D3OxLvptKuG8AXPpYOOl5hUxlwQvU9k874=;
        b=dRI9h08Q2btJIZv+nsd/njWU3AbGca3UviqwqmxV3IYRl29eNOKskVL7jBctsU8r5p
         HDylaJ7Uc48yOA0Pu8u6MciVqQMVzIQeKC4ostgAgCaHtfdBp+Rs9XSuJetrQxJ+7INz
         km91PXvCBJAOqFH0c0GIVq3dTj7kZOrses6ceMOSdljHan9MJ0XmolfYEqaAy+G+Y7Aj
         MOBLE1BUUBGCPqbi18v18BlR9RCEoPoCPGp5U/CU5JAfufjkUWSNLpc7KQYvLqxI+DaV
         4k1CbGOOcoiL9DH7ZvWeFy2t95bkRcEpBBz+9jrepr4aj0jFBosKJFke10CR017w+FYW
         xJhw==
X-Forwarded-Encrypted: i=1; AJvYcCUvGnry5ZK+FqyVRXFrd4otP1GVR6WH6XSJisIxWmG+SE2rlGP9Nj8KmNDoTMJ1GOoJNxR/64weRbpwv9x0DbS/@vger.kernel.org, AJvYcCVAlkBPnZdCg7OVnWEfFaxvSj8/Y40JZvcNY1QNHou9KMR5AY6vdEUtiyRlmZhUDWsB8Mcm4zKYZq0HkXU=@vger.kernel.org, AJvYcCW+AbhaH1BfEHsPjtuKCeRIVT3Iwq1abAX7vxdpd8RemAiMQ34OxRaGEbTETMaOut1n6zitIcOdqns=@vger.kernel.org, AJvYcCWJf5HpNS8IOlaTCEuG8O9YnvdcP5ipQDpINCPhZGIORq89CHPpQnmP9NBDll4UTvgeki+hBiZ3CPDOtyhT@vger.kernel.org, AJvYcCWghbsg/JCPgYY5DZ7tpdfU0oDiDLivcu0pF0W+b6xM4WB6mJUKh7aLGAl8pz+R/aF7aayE3OATkvSy@vger.kernel.org, AJvYcCWkAzCQ2yBvRuMf3RoSKxeIfXJvqNxITzuv91JVuAAo4BwZI1WolnsncvgrVa0Q3oGcDtcmh67g@vger.kernel.org, AJvYcCWs/51uWdIqVMIshDdyc7gDrdshexYlzVxjbdv/HoPqnJqnCD11KlcuxgfsNyJ5GN6I6po9FgdO6YG5@vger.kernel.org, AJvYcCWuwBvV7QtgfP+ClaJGeJUb1WlhbuyZQaH/EW5FxSCRIfyxdy6kVNV6PFQDY9FgdOR0g3M26YrT6JcH@vger.kernel.org
X-Gm-Message-State: AOJu0YyXItwc9oDyBBBWAPAPXzgi67Ht+Je1nyRb1wRHWzbYzDdkw/ym
	NReGVLQgkZBPsQCObfsyFqX2w+7MucZr1yLNMQzIvS20OFzsRucGkUiP
X-Gm-Gg: ASbGncv8apbT/eX9gmilzojrIxfDeW2DLqCmml6psiKqmQoa3UqNvQ+3Ul6p2PK1GoC
	T5a2Nix7MRfbvfKUKVZZCy4qch/YsSDWnKNG9e3MzhZbGW2W5V86kAmYuNR4mhtM4n0l93055wN
	IGH6LfdK6/1YY3DK3Ge4ITDnocPZS/pcjM70afDuFaW5e53pZa/6GSaQDJUpnMKOmzdro6LCdgM
	+jzZMPgrQqEVI5rgsCFhQoyFcmIds72m1BSXDQhqAuoD/TGNjB+2RyJUbql0gJAA6iZcGTTLB0f
	oCyXZFYIDvwfUFYxzhtpWhAQnb7MiPn91MjctEXRHczGg9FXXKSzPhd9nXMyL/GYdxNYVh5rS2S
	fvzQGeX4koqK/It/MNBRk5RZCjbbNLI1ZSsgS79CgtSckhQHpXQruzJNzDvyEgafcr7yHw53LYw
	==
X-Google-Smtp-Source: AGHT+IGGs/fA6BbM/mtl8WZrhsacYrqQT0Q7w79xZLNS42IorGM0Z4Es17kL4nrws8MX53BCDx11XA==
X-Received: by 2002:a05:620a:1713:b0:7d2:284f:e471 with SMTP id af79cd13be357-7d44394fd4dmr2546821385a.33.1751388588025;
        Tue, 01 Jul 2025 09:49:48 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317e285sm793098885a.45.2025.07.01.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:49:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:49:33 -0400
Subject: [PATCH v13 1/5] rust: macros: reduce collections in `quote!` macro
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-cstr-core-v13-1-29f7d3eb97a6@gmail.com>
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751388583; l=8684;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=chk1wwizZG1MPIiCNwD46/EZhbEvHPTiZmXZqpThA3c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHncOK9jmTcSRpxenCz1qsF8Hfzh6VWwhvz5AFOmB20gAplsko5e7ie0TE/e9Kxqo9sKSUIwLiU
 Iq3d0s+9OwQ4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Remove a handful of unncessary intermediate vectors and token streams;
mainly the top-level stream can be directly extended with the notable
exception of groups.

Remove an unnecessary `#[allow(dead_code)]` added in commit dbd5058ba60c
("rust: make pin-init its own crate").

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/quote.rs | 104 ++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 55 deletions(-)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 92cacc4067c9..acc140c18653 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -2,7 +2,6 @@
 
 use proc_macro::{TokenStream, TokenTree};
 
-#[allow(dead_code)]
 pub(crate) trait ToTokens {
     fn to_tokens(&self, tokens: &mut TokenStream);
 }
@@ -47,121 +46,116 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
 /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
 macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
-        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
-        #[allow(clippy::vec_init_then_push)]
+        let mut tokens = ::proc_macro::TokenStream::new();
         {
-            tokens = ::std::vec::Vec::new();
             let span = $span;
             quote_spanned!(@proc tokens span $($tt)*);
         }
-        ::proc_macro::TokenStream::from_iter(tokens)
+        tokens
     }};
     (@proc $v:ident $span:ident) => {};
     (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) => {
-        let mut ts = ::proc_macro::TokenStream::new();
-        $crate::quote::ToTokens::to_tokens(&$id, &mut ts);
-        $v.extend(ts);
+        $crate::quote::ToTokens::to_tokens(&$id, &mut $v);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) => {
         for token in $id {
-            let mut ts = ::proc_macro::TokenStream::new();
-            $crate::quote::ToTokens::to_tokens(&token, &mut ts);
-            $v.extend(ts);
+            $crate::quote::ToTokens::to_tokens(&token, &mut $v);
         }
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
         #[allow(unused_mut)]
-        let mut tokens = ::std::vec::Vec::<::proc_macro::TokenTree>::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Parenthesis,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) => {
-        let mut tokens = ::std::vec::Vec::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Bracket,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) => {
-        let mut tokens = ::std::vec::Vec::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Brace,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident :: $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Joint)
-        ));
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::Spacing::Joint, ::proc_macro::Spacing::Alone].map(|spacing| {
+            ::proc_macro::TokenTree::Punct(::proc_macro::Punct::new(':', spacing))
+        }));
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident : $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident , $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident @ $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ! $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ; $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident + $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident = $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident # $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident _ $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new("_", $span)));
+        $v.extend([::proc_macro::TokenTree::Ident(
+            ::proc_macro::Ident::new("_", $span),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
+        $v.extend([::proc_macro::TokenTree::Ident(
+            ::proc_macro::Ident::new(stringify!($id), $span),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
 }

-- 
2.50.0


