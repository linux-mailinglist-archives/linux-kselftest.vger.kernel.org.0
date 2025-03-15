Return-Path: <linux-kselftest+bounces-29131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F06A62C7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16E03B339D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F21FCCFD;
	Sat, 15 Mar 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw5RwqVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBA1FCCE2;
	Sat, 15 Mar 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041063; cv=none; b=u34cEPNZdC6++i9Kpm6k2on7rPAk7NmAdcaobzMzkVjLlHBwbRwxsdEMlyGHfajJMxel2EYx8TXa82CQ4H4Jsac9rkdaqNLCp9gP0uXjpQlAwXQa775zZUdTsAtfRRSe9aFJ7u92oxMLPqExrHaxNi8eLwiSwVkSWUfU3IAhjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041063; c=relaxed/simple;
	bh=eOC8GNYrVfiMmJjIlMnjsi5R6euOkfd+217Ym/0TGMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgPT3hPLI3NtojkTDq30kKH7BjnKM5858aePnXS7RdVJTO7SwKj78nEUgxE85n59Ii2tZ00fgoWizDffyq+rMSGi/fzFp2e5rke9naVtWg54c8VKazxzPV1iKfbJFMCOkYbIDTHtpsJCxzL8BPPvQXpozdXvCEmm+mGWlAo3Ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw5RwqVB; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c58974ed57so6734885a.2;
        Sat, 15 Mar 2025 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041061; x=1742645861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=lw5RwqVB8GUADajLqsBoR76EKxCewxQ2Su2Zr6Se/yOIrj66wfwUiRkMYkKiyFDOL6
         h8nKK3w8ySa2p4rPUBvWQxa8cJCmplBd43495Wo16bueYYRSy3l2WHLmGmkjr6w23Z1V
         TbWaJCTxw2vYTv9Mrg+s+Y29Ao2Dh6HW4fC4dkdUsK+mIZHAADAvxBanrcym+n9jURFc
         3scUqlvy7V92PH1TzcH0bci/zNQFJZIf5g6tgqwW/4BzEkiU6hSvUTE0ww6CcMVJJjNt
         JDfKWS2UTuB4mUIbyr/mjLmlOL4V/qMnhXg0cr5GqICy69QFa4mFHKvCyJgRQvWcEHnJ
         xtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041061; x=1742645861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=XO27b3QWrLgW5lVIM3XBROsImPxp0YfgPTvPw+Ea+sRxuJ9yMuUZv8iPFRh2OWOrWI
         RASUXUfMFX2fsUemuGiQHaJOdI6auVGl3LBZmUBMuyyOxtEHuuw+42P9aa4r87ttbdy7
         NC4OPSz5E82WN6oJ4J/nkYGKBke0mGPE18Glyd76ufJRGFj8sCTDftiyYVnx6uW0jjsP
         TNp5XXOFsV6jlXpvWhJWuw6EGv50uABcnaZoePWlQZ0ZlEXqRahAf0MzSTZB4K7pRD8l
         rKzMnTTa+uWhUXV0xNI54oDjQDWUSAGTGTHNA81kuqy/vMIHO0qdnbnvW0G3wu/Pyvgf
         yj7w==
X-Forwarded-Encrypted: i=1; AJvYcCUFYhHGdXEdmjB+mBC3Em6lHpveGGI/U3ONANZoDU6LQw65h/9oblF8jMleZxGOpstJjeKTp1nK0aMKtra1@vger.kernel.org, AJvYcCUjw+FPWi0LEk08z/TktCK4VKpkcKFMAWgpasnAOruQLc/+Bf944QGHCsXgROdURTO/SGn3nA/5eOs1@vger.kernel.org, AJvYcCV/yneLmvvlZqpu/6MqZ6lg43mkzyqMV9M5Jay9FfUnozqLL4Woq9HU5zpIW9rBgp59sSlo+crcyqTz+S+JJQE=@vger.kernel.org, AJvYcCWwz5R/zAVsHnQ29u4KPOYkDutoDMkf08gptpjR5mnMhUsagOagZtpOFJANFyNQvAFr+4O1nFOTlXqlcp22/Z5h@vger.kernel.org, AJvYcCXXgG0fNKcrBsiAxwdjyoyFd6T58XR7igqmO07k0OWSQEsuPEEjDv5qGrzv9CFiOvpPB17tUJAMBWw3@vger.kernel.org, AJvYcCXrLFACW8kU2LlYmo/2xmrt6uP1kfGQ44VzmHI6ZhnLvMQcoSC6jUAEFf+5NN65zkMny+pUFGZ1RXE5K1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5N8EZSPd4T0LhvUNI0GS6u2ZeGPL+T1qh9zeIONv+F6WugHN
	7OM3y50K+tV1BRcYS8TWyNGxWeJRR+ovh1a8WiW62wZpGGWh/Gdv
X-Gm-Gg: ASbGnct6Yy05FCBluBBmdxG4BhdUvfjf6F6HnDCDe+LRGzcZdhWXNVTfehR+kklLZQd
	iauuXk7M1X8AZ52Wiob1vENWvApqyNwLUtntILr942vmjv/eWCeFMCwIu/PV/fNS77txtvr8K1/
	wN8NiMsDZ0dbRUunIsNTdjNqzBZa3Lj7DKxBI5KJOtFGEkXCdmm8TpEiZ03Qn8WjSvdWtocatKm
	NBhSe1f60zRl2F66/5zWCXXvg0iOcAEokGi45wrpzp6B89ZWH6VD2jeygtmUD3g0KGQiLmIBd/p
	+HWF5MoRKLeLR37wGkvkbeyxmcgVJZWemGv+Qw7fKcAG5s9Tz2Aqungf80acO5clk9LH
X-Google-Smtp-Source: AGHT+IFyXw5wRW9zVMT6PEc03Fq+30rTHftgs+ooHPQ0kqyQOsP2npeNaRrfM9vlMPYzF1SwXif3IA==
X-Received: by 2002:a05:620a:1929:b0:7c5:5343:8c2c with SMTP id af79cd13be357-7c57c80efb4mr849773285a.27.1742041060753;
        Sat, 15 Mar 2025 05:17:40 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm371885185a.60.2025.03.15.05.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:17:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:17:28 -0400
Subject: [PATCH v4 4/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250315-ptr-as-ptr-v4-4-b2d72c14dc26@gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
In-Reply-To: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:

> Since `as_ptr` takes a `&self`, the pointer won’t have write
> permissions unless interior mutability is used, making it unlikely
> that having it as a mutable pointer is correct.

There is only one affected callsite, and the change amounts to replacing
`as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
is more descriptive of what's going on.

Apply this change and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_cast_mut [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c62bae2b107b..bb15b86182a3 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3a9d998ec371..598001157293 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.48.1


