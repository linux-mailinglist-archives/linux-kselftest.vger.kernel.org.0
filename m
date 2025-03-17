Return-Path: <linux-kselftest+bounces-29228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC5A6535C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E717B114
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D8248884;
	Mon, 17 Mar 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmrGf//d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C222459FC;
	Mon, 17 Mar 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221443; cv=none; b=NN/2jWX+etER5VoyXMD2ao4ZCmUq63C1rqLy82EaCKMLAxM9xzA+DOX6cPLRw+hb6kSFOAKFcsmVNcvDthWDbh25vbY6Ftr2mEzOwxcWeDEm/O2nVR0OcJPH98FXB4newWeF5ngpFpxTLZqm08qGWgzqfi8yx98GmTxESE2SMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221443; c=relaxed/simple;
	bh=eOC8GNYrVfiMmJjIlMnjsi5R6euOkfd+217Ym/0TGMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoVyGyyyqVoBS3295NxdXNzTZdO1CISN3Fbaw+S1DA1kW/EtOxODYPLmgsoW0V6aup69FUMxEjU7b8PtIfzxpNbZTavmCH1Lr535vBCx051kZXmqYxlXHxTMO2UINILm/HsKyMJf8G2O1lOYspvqVwYzWtlZR1qeq0yszjVqp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmrGf//d; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4766631a6a4so45528291cf.2;
        Mon, 17 Mar 2025 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221441; x=1742826241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=SmrGf//dlRODNS3EFkIRINdwG8DOrAw57F9551SDb4NCdCXzNEGGxdnW+GL6q2OueE
         7nX4W1mI1DU+RwOPUiL4nTGiEPuHItFdjwP8jE9I3xjvjj6aAmbDU3lpLGlrTIHvttWw
         j65OOz9ZtA0gopYXdNWc+gqy6qHny+IxXk9avScdkFsFZfv+8v2w1KsvXB7MZO+MuAcI
         ze/ckKEtZcNU/RrlT42eZILcNLqOoORhyXYZagifgwjUu5cMBLota0Ry4zI9/0370hsK
         QDR4K9tvGH3ZWQO/XjDUphC9VFtAklaA3NHpitcVW3jpGkaVb8NwgPkVJ0OESgYUDe3e
         +8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221441; x=1742826241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=FkPSBoZTPv6o46+UWLLqDKhJ1IRTRJpcGmoIYd8yBqYkJHrD3t86vUf5elac/o2PVG
         MMDoiLCjPTQVqWPuQjRtujmellzU+sCHmeqksvfymaj2ofRYD5HHrnP45p6OKyB0q4fn
         EeGoUnTt/KqXiMdK9JGdBiFty3YoCssvz5Uy1xTmRObQfezyZ7Uvr5iYTY0TetgpSKB0
         Z9th8oE8ut+6rAZPUjJQNUOM2QEMiLLM5rdoRq3OYVZk6XjfnGKbHixbMwbfaIK9us/8
         vS9CxF+2D4dxgQJubu9z5AK7FWgztKwFZiVqfCNpa86tiYMlFZB9YBIY1md3dCxtfrKr
         dzhA==
X-Forwarded-Encrypted: i=1; AJvYcCWSp049ViGwcxu2vKZc4Hy4FtnHpwY60luFV8i3PN0ze0li0xCtQhexNp1dQDRg98/qlDQMvN9EmrfK@vger.kernel.org, AJvYcCWo0OF/VZmbQ8neKKexdGZuqOKiLkOgev1Kq2/Wnqk3uFZJrWQOrltnTjrUZbMxgGe/YrcPMw5wCOYNDNI=@vger.kernel.org, AJvYcCWsYJx7gJZfiK2CEdPWGFcgtd44QRi/2mhtjYOwTUN9A61IU4pES6lPA6yD3UTZwxD7ZlTnzDQ0U7mvTCBtsyQ=@vger.kernel.org, AJvYcCXTsvL1lqEzkd1H9wPyZPFRVu8tjhIl8BkgM5AzvyBUM3ltzdc8AYhyp1t0sI/TlcO77wUwSno15lY4m6np@vger.kernel.org, AJvYcCXc7fgww3diUp0HeraP3Nr7JYPfLbxLaH4J7CvHhjtz4iFbU8EZDECu9+QDTOvPByfdhgX63ED666PT@vger.kernel.org, AJvYcCXguZg9RS9PYj4zQrAhcPU94mDEXTVFIzk8OjB7mnT1DeTAC73yztOWK5gAiPvrwYccezVNOu91hRBC/VYisiZG@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDsrFiBHAyeWWmUNv1rjf6mipM/f2INWRcaefJspkR1y/B+DF
	XAjQSRio5Q0U8yL1IldwRnGQbTqo3J8wv37TXAB5a7+cGU448OxK70rxlO6DSog=
X-Gm-Gg: ASbGncvmQ8Pat1Rw4MKL8HY6D2wsdv8MrufeX6j4+IJBDToIoJYsY+suW7fefkGIzr1
	7LHXOzgf1z782BB6wYlU79MO3xBKAQWu3bk/XNLlGR7wkBEnOUZjVrB1FmkQuDsM+Sd12biddId
	sNBKF2bnpiGeC+mrLceOTBpJVnKDpYwvE/nDRa7Yb+HbLclWdA/z8P5Sr/4tLAu6vznuQAzkN6D
	enOgDzY3d4TqCUXtzyeVIy3HHiPzexfVYa+HlGqdZ0N9RQGmvu8jcoZvw7DseAkpJzGXW8YKQvE
	uGX1fBIC5agQfyjLqH0pj3gcWRP8S7fm0IubuNoBONnWOutuamFi0lzxn2aFmGk2efw5PSvRPA=
	=
X-Google-Smtp-Source: AGHT+IGW4rw89ZFFbVEcn+X1uJyv5hQbpNSEeeMe8/EJAtes1dgkOySMbKI6jcF0Eq27FoJF6gAMEg==
X-Received: by 2002:a05:622a:4c8:b0:476:838c:b0ce with SMTP id d75a77b69052e-476c812caa7mr238396871cf.13.1742221440614;
        Mon, 17 Mar 2025 07:24:00 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:24:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:23:54 -0400
Subject: [PATCH v5 4/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250317-ptr-as-ptr-v5-4-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
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


