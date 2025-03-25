Return-Path: <linux-kselftest+bounces-29781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16683A70B3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3628C7A975E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E52690D4;
	Tue, 25 Mar 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqz51FUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB888268C70;
	Tue, 25 Mar 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933278; cv=none; b=IoDbHjsyY+afPDJvwwgkkubqe4jNkxT66gDPrg8J2ZibbisJmowzTVC1/2X2hXu6ddFv4iwyvujONSDZi9vwKGnJ+Sy+fIG7S+L2/w7TRj+HT+zo6mGSXlcpy7lN76VYJX5iARdh2Kgv6fd7x9bNCDYO4cKzBwSDREjEbOFpEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933278; c=relaxed/simple;
	bh=ARhxNI1wWiplxkPdk6FMVE4T9Y4lrgoeC4uNkwKSjKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRqywYSi5DEe71rgNUHV6TneKZMssiV3TjHDMVzYpSc/lEDf7D32jjwm5gdu9+2Q25oa8RZIlVKnBEXqJxv6EtpS0v3VMOC1fMiAM4GpHZ3lzVDAPjWNtM5IzgTIZeUmgV/Ej9gB+oDYyjTkUihBy5UOFJ81GGwUnxA6BhQGT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqz51FUO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e89a2501a0so57057906d6.1;
        Tue, 25 Mar 2025 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933276; x=1743538076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8afu+918+Q54xyruc7w9BxMECWF2zkytyg4bSZWLnw=;
        b=Nqz51FUOroXH0Nux+3ah/lqVKdgIddkzLj1ioT054tBjwEaAYyvnDRPOsPphsDwcpR
         tmwg5+hMeFjoTs+2HWnlHdZXX75qzz84Z8O+MTEiWjaeAjr6G+/EwZKOFJjNN580oKLo
         0poX3vqlAkvdxKD8T5KNfLBV8C7DSPOoLA6G4Swzd3rz8rUgEE0K4JuMtvwsVad/SVC0
         cGnmXEeiLuIYG4wdNgIUmEiddaJ8mOBPolE8pI8NNdBQGsX0aMuX6gOnojlsUqhtlctb
         +av+wwSDSYA1C/v16LhhK56XWuj7LFnnFvqyx+snG0a1I3PJ9kge8HaZq2zDjSPv5XcP
         /lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933276; x=1743538076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8afu+918+Q54xyruc7w9BxMECWF2zkytyg4bSZWLnw=;
        b=UW0R0xePP7nI/k+gL/U7e8VDLJUESnjREPq//bLDxsnwXy4ZFyBzRJ5MRRWi7hxL/4
         n9UM2C1H0EIHWXaBskNdzowR7xznRW9WLzdQlL7bQSrm62QKgNl/qcSDVR9wc8axTSRg
         +sO4DX9ac1+y4VLFD21v/VPtJOkGDbQaLm+K3Y6Ihrsxv26SkQ5q3ElRj9G5mVhkNi4X
         jA3Kaf8eJltBY3m8SeCeu+Q2WSSdOHTNdr28enuEVIBcIgsWdK94XTb2Z1d3HhmhaDuE
         r7MmCfgdj/5+0JynrpP4Ymg+HUuO5JHkYTzDzgiEyZPDAO9UCfek1Wgb3DfAN/LmeHGP
         WFNw==
X-Forwarded-Encrypted: i=1; AJvYcCU9uauPegzxxAgxlysIelSb+L+AK5OyYMPf+cj7lArXLduSB8yaiRIXxT65AgRFWqucS0DQ3CSNzrSgMJW8@vger.kernel.org, AJvYcCULruIjVTk4U5n1PionM8R3GlGQsNd5UnlVgTW/382rhQwsYZu7qUi1oeW4rmcIn83jiKC/yn4lcp1KA/o=@vger.kernel.org, AJvYcCUl+uZz3/qCl91f3cjIZUoNxV1wyctlVN6xiZ0No2DHqd4sMhIqxkz068wl18QCWg6hu5NkJgwmkcAbhbY1tziF@vger.kernel.org, AJvYcCUq8hPBsZN9uPdueEI3OevYNv9/kjhAZgi+UcEJtrR0DdT9bNUm0eLTV4I0DngWvcVTKfLvcCHnMaCk@vger.kernel.org, AJvYcCVGnFM4fIYhDMHiQapiBk33cL4qD8dX5YVaif8WPpP7yjsqG2MgIuyxMvuqG+JLt5g46hRGAxDi@vger.kernel.org, AJvYcCWCUmnDPhjEIG6iT0V7Y6oJ6JcDS9giNLy3axKQK9R/gh9npmvPxTi9XeZKgE3DcjZWf0eMZ03PosPtVXCg3QY=@vger.kernel.org, AJvYcCXJOXAa4VGWRNYm44S4Pyt6LixKJz6cKQabIsgOG+77yXAnP7ljUV61grgwE1LFInUpjAwIJ6Aula86@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0z1yNUZ2huSpDhkuKR49ERdj/VP78Axfn6AhZoV/JHymKBuK
	YNZJidezj1K9O+M78YHj4/vPX1/vawtX2IMC9ZKO4SxuaSCUOqHl
X-Gm-Gg: ASbGncvgTbMipqSWT7TH1GnvRfGq6moon4hLKh6VweTkNKcxtMgvchraI28NSKWmuSL
	7+vEgrQdYwBLePul6eS4lMCvYnPaftjlWRqY7xGl+RoVuN3eZaQFoDU7wCDqqWBDfJls5xd2gI6
	5/9Bvv17fRa+Qm1CZNQkUJD6WGdUY4QhsSd4aD1kMiU/U7hcMZWLTAnF09WiRdcT8rxPN952ILC
	I03VO6V+6ejHw+sL1WADp1qmQ9WgbpJfeY29pyncMl5KQE7Vni7bpkl6zFx2jl/sB/zVUdcybPZ
	CDJsMWRiTHOqS7b3Bc/JdBvuk9x37/JXCK7KxH/E4lpd02/PeepaWMg6wtVzW8n3ITnfTuu0nyv
	xcAda5TuW6vW3fq45qsxGFh8y0n40P6lliuWny4/NMPMp0PnRibXzukw5aCjUNR8k
X-Google-Smtp-Source: AGHT+IH5ctNWjC54Y7j3zCNpairalLYRZF34BaBc3KtOMVr913E6IQjPSqy4tjWyjdEoDRDpScx/lQ==
X-Received: by 2002:a05:6214:1d04:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6eb3f33c8b6mr233174246d6.29.1742933275610;
        Tue, 25 Mar 2025 13:07:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm59790316d6.64.2025.03.25.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:07:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:07:44 -0400
Subject: [PATCH v7 4/7] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-ptr-as-ptr-v7-4-87ab452147b9@gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
In-Reply-To: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
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
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
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
2.49.0


